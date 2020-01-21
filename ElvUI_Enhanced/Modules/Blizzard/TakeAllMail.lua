local E, L, V, P, G = unpack(ElvUI)
local TAM = E:NewModule("Enhanced_TakeAllMail", "AceEvent-3.0")

local select = select
local format = string.format

local AutoLootMailItem = AutoLootMailItem
local CheckInbox = CheckInbox
local DeleteInboxItem = DeleteInboxItem
local GetInboxHeaderInfo = GetInboxHeaderInfo
local GetInboxNumItems = GetInboxNumItems
local InboxItemCanDelete = InboxItemCanDelete
local IsShiftKeyDown = IsShiftKeyDown
local TakeInboxMoney = TakeInboxMoney

local ERR_INV_FULL = ERR_INV_FULL

local MAIL_MIN_DELAY = 0.15

function TAM:GetTotalCash()
	if GetInboxNumItems() == 0 then return 0 end

	local totalCash = 0

	for i = 1, GetInboxNumItems() do
		totalCash = totalCash + select(5, GetInboxHeaderInfo(i))
	end

	return totalCash
end

function TAM:UpdateButtons()
	if self.processing then return end

	if GetInboxNumItems() == 0 then
		self.takeAll:Disable()
		self.takeCash:Disable()
	else
		self.takeAll:Enable()

		if self:GetTotalCash() > 0 then
			self.takeCash:Enable()
		else
			self.takeCash:Disable()
		end
	end
end

function TAM:Reset()
	self.mailIndex = 1
	self.timeUntilNextRetrieval = nil
	self.commandPending = nil

	self.collectCashOnly = nil
	self.collectedCash = 0
	self.collectedTotal = 0
	self.removeEmpty = nil
end

function TAM:StartOpening(mode)
	if GetInboxNumItems() == 0 then return end

	self:Reset()

	self.takeAll:Disable()
	self.takeCash:Disable()

	self:RegisterEvent("MAIL_INBOX_UPDATE", "OnEvent")
	self:RegisterEvent("UI_ERROR_MESSAGE", "OnEvent")

	if mode == 1 then
		self.collectCashOnly = true
	elseif mode == 2 then
		self.removeEmpty = true
	end

	self.processing = true

	self.numToOpen = GetInboxNumItems()
	self.takeAll:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)

	if mode == 2 then
		self:RemoveNextMail()
	else
		self:AdvanceAndProcessNextMail()
	end
end

function TAM:StopOpening(err)
	if self.collectedCash > 0 then
		E:Print(L["Collected "]..E:FormatMoney(self.collectedCash))
	end
	if self.collectedTotal > 0 and not err then
		E:Print(L["Collection completed."])
	end

	self:Reset()

	self.takeAll:Enable()
	self.takeCash:Enable()

	self:UnregisterEvent("MAIL_INBOX_UPDATE")
	self:UnregisterEvent("UI_ERROR_MESSAGE")

	self.processing = nil
	self.takeAll:SetScript("OnUpdate", nil)
	self:UpdateButtons()
end

function TAM:AdvanceToNextMail()
	local _, _, _, _, money, _, _, itemCount = GetInboxHeaderInfo(self.mailIndex)

	if money > 0 or (not self.collectCashOnly and (itemCount and itemCount > 0)) then
		return true
	else
		self.mailIndex = self.mailIndex + 1

		if self.mailIndex > GetInboxNumItems() then
			return false
		end

		return self:AdvanceToNextMail()
	end
end

function TAM:AdvanceAndProcessNextMail()
	if self:AdvanceToNextMail() then
		self:ProcessNextMail()
	else
		self:StopOpening()
	end
end

function TAM:ProcessNextMail()
	local _, _, _, _, money, CODAmount, _, itemCount, _, _, _, _, isGM = GetInboxHeaderInfo(self.mailIndex)
	if isGM or (CODAmount and CODAmount > 0) then
		self.mailIndex = self.mailIndex + 1
		self:AdvanceAndProcessNextMail()
		return
	end

	if money > 0 then
		TakeInboxMoney(self.mailIndex)

		self.collectedCash = self.collectedCash + money
		self.collectedTotal = self.collectedTotal + 1
		self.timeUntilNextRetrieval = MAIL_MIN_DELAY
	elseif not self.collectCashOnly and (itemCount and itemCount > 0) then
		AutoLootMailItem(self.mailIndex)

		self.collectedTotal = self.collectedTotal + 1
		self.timeUntilNextRetrieval = MAIL_MIN_DELAY
	else
		self:AdvanceAndProcessNextMail()
	end
end

function TAM:RemoveNextMail()
	local numItems = GetInboxNumItems()

	if numItems > 0 then
		local money, CODAmount, itemCount, isGM, _

		for i = 1, numItems do
			_, _, _, _, money, CODAmount, _, itemCount, _, _, _, _, isGM = GetInboxHeaderInfo(i)

			if not isGM and (not CODAmount or CODAmount == 0) and money == 0 and (not itemCount or itemCount == 0) then
				if InboxItemCanDelete(i) then
					DeleteInboxItem(i)
					self.timeUntilNextRetrieval = MAIL_MIN_DELAY
					break
				end
			end
		end
	else
		return self:StopOpening()
	end

	if not self.timeUntilNextRetrieval then
		self:StopOpening()
	end
end

function TAM:OnUpdate(dt)
	if not self.timeUntilNextRetrieval then return end

	self.timeUntilNextRetrieval = self.timeUntilNextRetrieval - dt

	if self.timeUntilNextRetrieval <= 0 then
		if not self.commandPending then
			self.timeUntilNextRetrieval = nil
			if not self.removeEmpty then
				self:AdvanceAndProcessNextMail()
			else
				self:RemoveNextMail()
			end
		else
			self.commandPending = nil
			self.timeUntilNextRetrieval = MAIL_MIN_DELAY
		end
	end
end

function TAM:OnEvent(event, errstr)
	if event == "MAIL_SHOW" then
		self:RegisterEvent("MAIL_CLOSED", "OnEvent")
		self:RegisterEvent("MAIL_INBOX_UPDATE", "OnEvent")
		self:RegisterEvent("UPDATE_PENDING_MAIL", "OnEvent")
		self:UnregisterEvent("MAIL_SHOW")

		self:UpdateButtons(true)
	elseif event == "MAIL_CLOSED" then
		self:RegisterEvent("MAIL_SHOW", "OnEvent")
		self:UnregisterEvent("MAIL_CLOSED")
		self:UnregisterEvent("MAIL_INBOX_UPDATE")
		self:UnregisterEvent("UPDATE_PENDING_MAIL")

		self:StopOpening(true)
	elseif event == "MAIL_INBOX_UPDATE" then
		if self.numToOpen ~= GetInboxNumItems() then
			self.mailIndex = 1
		end

		self:UpdateButtons()
	elseif event == "UPDATE_PENDING_MAIL" then
		if self.processing then
			self.commandPending = true
			CheckInbox()
		else
			CheckInbox()
			self:UpdateButtons()
		end
	elseif event == "UI_ERROR_MESSAGE" and errstr == ERR_INV_FULL then
		self:StopOpening(true)
		E:Print(L["Collection stopped, inventory is full."])
	end
end

function TAM:Initialize()
	if not E.db.enhanced.blizzard.takeAllMail then return end

	local S = E:GetModule("Skins")

	self:Reset()

	self.takeAll = CreateFrame("Button", "ElvUI_MailButtonAll", InboxFrame, "UIPanelButtonTemplate")
	self.takeAll:Size(80, 22)
	self.takeAll:Point("BOTTOM", "MailFrame","BOTTOM", -53, 92)
	self.takeAll:SetText(L["Take All"])
	S:HandleButton(self.takeAll)

	self.takeCash = CreateFrame("Button", "ElvUI_MailButtonCash", InboxFrame, "UIPanelButtonTemplate")
	self.takeCash:Size(80, 22)
	self.takeCash:Point("BOTTOM", "MailFrame","BOTTOM", 34, 92)
	self.takeCash:SetText(L["Take Cash"])
	S:HandleButton(self.takeCash)

	self.takeAll:SetScript("OnHide", function() self:StopOpening(true) end)
--	self.takeCash:SetScript("OnHide", function() self:StopOpening(true) end)

	self.takeAll:SetScript("OnClick", function()
		if IsShiftKeyDown() then
			self:StartOpening(2)
		else
			self:StartOpening()
		end
	end)
	self.takeCash:SetScript("OnClick", function() self:StartOpening(1) end)

	self.takeAll:SetScript("OnEnter", function()
		GameTooltip:SetOwner(self.takeAll, "ANCHOR_TOP")
		GameTooltip:AddLine(format(L["%d mails\nShift-Click to remove empty mails."], GetInboxNumItems()), 1, 1, 1)
		GameTooltip:Show()
	end)
	self.takeCash:SetScript("OnEnter", function()
		GameTooltip:SetOwner(self.takeCash, "ANCHOR_TOP")
		GameTooltip:AddLine(E:FormatMoney(self:GetTotalCash()), 1, 1, 1)
		GameTooltip:Show()
	end)

	self.takeAll:SetScript("OnLeave", function() GameTooltip:Hide() end)
	self.takeCash:SetScript("OnLeave", function() GameTooltip:Hide() end)

	self:RegisterEvent("MAIL_SHOW", "OnEvent")

	self.initialized = true
end

local function InitializeCallback()
	TAM:Initialize()
end

E:RegisterModule(TAM:GetName(), InitializeCallback)