local E, L, V, P, G = unpack(ElvUI)
local TA = E:NewModule("Enhanced_TrainAll", "AceHook-3.0", "AceEvent-3.0")

local select = select
local format = string.format

local BuyTrainerService = BuyTrainerService
local GetMoney = GetMoney
local GetNumTrainerServices = GetNumTrainerServices
local GetTrainerServiceCost = GetTrainerServiceCost
local GetTrainerServiceInfo = GetTrainerServiceInfo

local function BetterSafeThanSorry_OnUpdate(self, elapsed)
	self.delay = self.delay - elapsed

	if self.delay <= 0 then
		TA:ResetScript()
	end
end

function TA:TrainAllSkills()
	self.locked = true
	self.button:Disable()

	local j, cost = 0
	local money = GetMoney()

	for i = 1, GetNumTrainerServices() do
		if select(3, GetTrainerServiceInfo(i)) == "available" then
			j = j + 1
			cost = GetTrainerServiceCost(i)
			if money >= cost then
				money = money - cost
				BuyTrainerService(i)
			else
				self:ResetScript()
				return
			end
		end
	end

	if j > 0 then
		self.skillsToLearn = j
		self.skillsLearned = 0

		self:RegisterEvent("TRAINER_UPDATE")

		self.button.delay = 1
		self.button:SetScript("OnUpdate", BetterSafeThanSorry_OnUpdate)
	else
		self:ResetScript()
	end
end

function TA:TRAINER_UPDATE()
	self.skillsLearned = self.skillsLearned + 1

	if self.skillsLearned >= self.skillsToLearn then
		self:ResetScript()
		self:TrainAllSkills()
	else
		self.button.delay = 1
	end
end

function TA:ResetScript()
	self.button:SetScript("OnUpdate", nil)
	self:UnregisterEvent("TRAINER_UPDATE")

	self.skillsLearned = nil
	self.skillsToLearn = nil
	self.button.delay = nil
	self.locked = nil
end

function TA:ButtonCreate()
	self.button = CreateFrame("Button", "ElvUI_TrainAllButton", ClassTrainerFrame, "UIPanelButtonTemplate")
	self.button:Size(80, 22)
	self.button:SetFormattedText("%s %s", TRAIN, ALL)

	if E.private.skins.blizzard.enable and E.private.skins.blizzard.trainer then
		self.button:Point("RIGHT", ClassTrainerTrainButton, "LEFT", -3, 0)
		E:GetModule("Skins"):HandleButton(self.button)
	else
		self.button:Point("RIGHT", ClassTrainerTrainButton, "LEFT")
	end

	self.button:SetScript("OnClick", function() TA:TrainAllSkills() end)

	self.button:HookScript("OnEnter", function()
		local cost = 0
		for i = 1, GetNumTrainerServices() do
			if select(3, GetTrainerServiceInfo(i)) == "available" then
				cost = cost + GetTrainerServiceCost(i)
			end
		end

		GameTooltip:SetOwner(self.button,"ANCHOR_TOPLEFT", 0, 5)
		GameTooltip:SetText(format("|cffffffff%s|r %s", TABARDVENDORCOST, E:FormatMoney(cost, E.db.datatexts.goldFormat or "BLIZZARD", not E.db.datatexts.goldCoins)))
	end)

	self.button:HookScript("OnLeave", function()
		GameTooltip:Hide()
	end)
end

function TA:ButtonUpdate()
	if self.locked then return end

	for i = 1, GetNumTrainerServices() do
		if select(3, GetTrainerServiceInfo(i)) == "available" then
			self.button:Enable()
			return
		end
	end

	self.button:Disable()
end

function TA:ButtonPosition(disable)
	if disable then
		ClassTrainerTrainButton:Point("CENTER", ClassTrainerFrame, "TOPLEFT", 221, -417)

		ClassTrainerCancelButton.Show = nil
		ClassTrainerCancelButton:Show()
	else
		ClassTrainerTrainButton:Point("CENTER", ClassTrainerFrame, "TOPLEFT", 304, -417)

		ClassTrainerCancelButton.Show = E.noop
		ClassTrainerCancelButton:Hide()
	end
end

function TA:ADDON_LOADED(_, addon)
	if self.blockCallback or addon ~= "Blizzard_TrainerUI" then return end

	self:ButtonCreate()
	self:ButtonPosition()

	self:SecureHook("ClassTrainerFrame_Update", "ButtonUpdate")
	self:UnregisterEvent("ADDON_LOADED")
end

function TA:ToggleState()
	if E.db.enhanced.general.trainAllSkills then
		if not self.button then
			if IsAddOnLoaded("Blizzard_TrainerUI") then
				self.blockCallback = nil
				self:ADDON_LOADED(nil, "Blizzard_TrainerUI")
			elseif E.private.skins.blizzard.enable and E.private.skins.blizzard.trainer then
				if not self.skinCallback then
					E:GetModule("Skins"):AddCallbackForAddon("Blizzard_TrainerUI", "Enhanced_Blizzard_TrainerUI_TrainAll", function()
						self:ADDON_LOADED(nil, "Blizzard_TrainerUI")
					end)

					self.skinCallback = true
				else
					self.blockCallback = nil
				end
			else
				self:RegisterEvent("ADDON_LOADED")
			end
		else
			self.button:Show()
			self:ButtonPosition()

			if not self:IsHooked("ClassTrainerFrame_Update") then
				self:SecureHook("ClassTrainerFrame_Update", "ButtonUpdate")
			end
		end
	else
		if not self.button then
			self:UnregisterEvent("ADDON_LOADED")

			if self.skinCallback then
				self.blockCallback = true
			end
		else
			self.button:Hide()
			self:UnhookAll()
			self:ButtonPosition(true)

			if self.locked then
				self:ResetScript()
			end
		end
	end
end

function TA:Initialize()
	if not E.db.enhanced.general.trainAllSkills then return end

	self:ToggleState()
end

local function InitializeCallback()
	TA:Initialize()
end

E:RegisterModule(TA:GetName(), InitializeCallback)