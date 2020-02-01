local E, L, V, P, G = unpack(ElvUI)
local mod = E:GetModule("Enhanced_Blizzard")

local _G = _G
local select = select
local floor = math.floor
local tconcat = table.concat

local CreateFrame = CreateFrame
local DisableAddOn = DisableAddOn
local EnableAddOn = EnableAddOn
local GetAddOnDependencies = GetAddOnDependencies
local GetAddOnInfo = GetAddOnInfo
local GetNumAddOns = GetNumAddOns
local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand
local IsAddOnLoaded = IsAddOnLoaded
local IsShiftKeyDown = IsShiftKeyDown
local LoadAddOn = LoadAddOn
local PlaySound = PlaySound

local function AddonList_HasAnyChanged()
	local status = ElvUI_AddonList.startStatus

	for i = 1, GetNumAddOns() do
		local _, _, _, enabled, _, reason = GetAddOnInfo(i)

		if not ((enabled == status[i].enabled and not status[i].lod)
		or reason == "DEP_DISABLED"
		or status[i].reason == "DEP_DISABLED"
		or (enabled and status[i].lod and not IsAddOnLoaded(i))
		or (not enabled and status[i].lod and not IsAddOnLoaded(i)))
		then
			return true
		end
	end
end

local function AddonList_IsAddOnLoadOnDemand(index)
	if IsAddOnLoadOnDemand(index) and not IsAddOnLoaded(index) then
		return true
	end
end

local function AddonList_IsDepsLoaded(...)
	local depsCount = select("#", ...)
	if depsCount == 0 then return end

	for i = 1, depsCount do
		if not IsAddOnLoaded(select(i, ...)) then
			return
		end
	end

	return true
end

local function AddonList_SetStatus(entry, load, status, reload)
	if load then
		entry.LoadButton:Show()
	else
		entry.LoadButton:Hide()
	end

	if status then
		entry.Status:Show()
	else
		entry.Status:Hide()
	end

	if reload then
		entry.Reload:Show()
	else
		entry.Reload:Hide()
	end
end

local function AddonList_Update()
	local numEntries = GetNumAddOns()
	local addonIndex, entry, checkbox, status

	for i = 1, 20 do
		addonIndex = ElvUI_AddonList.offset + i
		entry = _G["ElvUI_AddonListEntry"..i]

		if addonIndex > numEntries then
			entry:Hide()
		else
			local name, title, _, enabled, loadable, reason = GetAddOnInfo(addonIndex)

			checkbox = _G["ElvUI_AddonListEntry"..i.."Enabled"]
			checkbox:SetChecked(enabled)

			status = _G["ElvUI_AddonListEntry"..i.."Title"]

			if loadable or (enabled and (reason == "DEP_DEMAND_LOADED" or reason == "DEMAND_LOADED")) then
				status:SetTextColor(1.0, 0.78, 0.0)
			elseif enabled and reason ~= "DEP_DISABLED" then
				status:SetTextColor(1.0, 0.1, 0.1)
			else
				status:SetTextColor(0.5, 0.5, 0.5)
			end

			if title then
				status:SetText(title)
			else
				status:SetText(name)
			end

			status = _G["ElvUI_AddonListEntry"..i.."Status"]
			if not loadable and reason then
				status:SetText(_G["ADDON_"..reason])
			else
				status:SetText("")
			end

			if enabled ~= ElvUI_AddonList.startStatus[addonIndex].enabled and reason ~= "DEP_DISABLED" and ElvUI_AddonList.startStatus[addonIndex].reason ~= "DEP_DISABLED" then
				if enabled then
					if AddonList_IsAddOnLoadOnDemand(addonIndex) then
						if AddonList_IsDepsLoaded(GetAddOnDependencies(addonIndex)) then
							AddonList_SetStatus(entry, true)
						else
							AddonList_SetStatus(entry)
						end
					else
						AddonList_SetStatus(entry, nil, nil, true)
					end
				elseif AddonList_IsAddOnLoadOnDemand(addonIndex) then
					AddonList_SetStatus(entry, nil, true)
				else
					AddonList_SetStatus(entry, nil, nil, true)
				end
			else
				AddonList_SetStatus(entry, nil, true)
			end

			entry.id = addonIndex
			entry:Show()
		end
	end

	FauxScrollFrame_Update(ElvUI_AddonListScrollFrame, numEntries, 20, 16, nil, nil, nil, nil, nil, nil, true)

	if AddonList_HasAnyChanged() then
		ElvUI_AddonListOkayButton:SetText(L["Reload UI"])
		ElvUI_AddonList.shouldReload = true
	else
		ElvUI_AddonListOkayButton:SetText(OKAY)
		ElvUI_AddonList.shouldReload = false
	end
end

local function AddonList_Enable(index, enabled)
	if enabled then
		EnableAddOn(index)
	else
		DisableAddOn(index)
	end

	AddonList_Update()
end

local function AddonList_LoadAddOn(index)
	if not AddonList_IsAddOnLoadOnDemand(index) then return end

	LoadAddOn(index)

	if IsAddOnLoaded(index) then
		ElvUI_AddonList.startStatus[index].enabled = 1
		ElvUI_AddonList.startStatus[index].lod = nil
	end

	AddonList_Update()
end

local function AddonTooltip_BuildDeps(...)
	local depsCount = select("#", ...)
	if depsCount == 0 then return end

	local deps

	if depsCount == 1 then
		deps = ...
	elseif depsCount > 1 then
		deps = tconcat({...}, ", ")
	end

	return L["Dependencies: "] .. deps
end

local function AddonTooltip_Update(self)
	local name, title, notes, _, _, security = GetAddOnInfo(self.id)
	if not name then return end

	GameTooltip:SetOwner(self)

	if security == "BANNED" then
		GameTooltip:SetText(L["This addon has been disabled. You should install an updated version."])
	else
		if title then
			GameTooltip:AddLine(title)
		else
			GameTooltip:AddLine(name)
		end

		GameTooltip:AddLine(notes, 1.0, 1.0, 1.0)

		local dependsStr = AddonTooltip_BuildDeps(GetAddOnDependencies(self.id))
		if dependsStr then
			GameTooltip:AddLine(AddonTooltip_BuildDeps(GetAddOnDependencies(self.id)))
		end
	end

	GameTooltip:Show()
end

function mod:AddonList()
	if IsAddOnLoaded("ACP") then return end

	local S = E:GetModule("Skins")

	local addonList = CreateFrame("Frame", "ElvUI_AddonList", UIParent)
	addonList:SetFrameStrata("HIGH")
	addonList:Size(520, 466)
	addonList:Point("CENTER", 0, 0)
	addonList:SetTemplate("Transparent")
	addonList:SetClampedToScreen(true)
	addonList:SetMovable(true)
	addonList:EnableMouse(true)
	addonList:RegisterForDrag("LeftButton")
	addonList:Hide()
	tinsert(UISpecialFrames, addonList:GetName())

	addonList.offset = 0
	addonList.startStatus = {}

	for i = 1, GetNumAddOns() do
		local _, _, _, enabled, _, reason = GetAddOnInfo(i)
		addonList.startStatus[i] = {
			enabled = enabled,
			reason = reason,
			lod = IsAddOnLoadOnDemand(i)
		}
	end

	addonList:SetScript("OnDragStart", function(self)
		if IsShiftKeyDown() then
			self:StartMoving()
		end
	end)
	addonList:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)

	local addonTitle = addonList:CreateFontString("$parentTitle", "BACKGROUND", "GameFontNormal")
	addonTitle:Point("TOP", 0, -7)
	addonTitle:SetText(ADDONS)

	local cancelButton = CreateFrame("Button", "$parentCancelButton", addonList, "UIPanelButtonTemplate")
	cancelButton:Size(80, 22)
	cancelButton:Point("BOTTOMRIGHT", -8, 8)
	cancelButton:SetText(CANCEL)
	S:HandleButton(cancelButton)
	cancelButton:SetScript("OnClick", function()
		ElvUI_AddonList:Hide()
	end)

	local okayButton = CreateFrame("Button", "$parentOkayButton", addonList, "UIPanelButtonTemplate")
	okayButton:Size(80, 22)
	okayButton:Point("RIGHT", cancelButton, "LEFT", -7, 0)
	okayButton:SetText(OKAY)
	S:HandleButton(okayButton)
	okayButton:SetScript("OnClick", function()
		if ElvUI_AddonList.shouldReload then
			ReloadUI()
		else
			ElvUI_AddonList:Hide()
		end
	end)

	local enableAllButton = CreateFrame("Button", "$parentEnableAllButton", addonList, "UIPanelButtonTemplate")
	enableAllButton:Size(120, 22)
	enableAllButton:Point("BOTTOMLEFT", 8, 8)
	enableAllButton:SetText(L["Enable All"])
	S:HandleButton(enableAllButton)
	enableAllButton:SetScript("OnClick", function()
		EnableAllAddOns()
		AddonList_Update()
	end)

	local disableAllButton = CreateFrame("Button", "$parentDisableAllButton", addonList, "UIPanelButtonTemplate")
	disableAllButton:Size(120, 22)
	disableAllButton:Point("LEFT", enableAllButton, "RIGHT", 7, 0)
	disableAllButton:SetText(L["Disable All"])
	S:HandleButton(disableAllButton)
	disableAllButton:SetScript("OnClick", function()
		DisableAllAddOns()
		AddonList_Update()
	end)

	addonList:SetScript("OnShow", function()
		AddonList_Update()
		PlaySound("igMainMenuOption")
	end)
	addonList:SetScript("OnHide", function()
		PlaySound("igMainMenuOptionCheckBoxOn")
	end)

	local scrollFrame = CreateFrame("ScrollFrame", "$parentScrollFrame", addonList, "FauxScrollFrameTemplate")
	scrollFrame:SetTemplate("Transparent")
	scrollFrame:Point("TOPLEFT", 8, -25)
	scrollFrame:Point("BOTTOMRIGHT", -29, 37)
	scrollFrame.scrollBar = _G[scrollFrame:GetName().."ScrollBar"]
	S:HandleScrollBar(scrollFrame.scrollBar, 5)

	scrollFrame.scrollBar:Point("TOPLEFT", scrollFrame, "TOPRIGHT", 4, -18)
	scrollFrame.scrollBar:Point("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 4, 18)

	scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		self.scrollBar:SetValue(offset)
		addonList.offset = floor((offset / 16) + 0.5)
		AddonList_Update()

		if GameTooltip:IsShown() then
			AddonTooltip_Update(GameTooltip:GetOwner())
		end
	end)

	local function Enable_OnClick(self)
		AddonList_Enable(self:GetParent().id, self:GetChecked())
		PlaySound("igMainMenuOptionCheckBoxOn")
	end

	local function Load_OnClick(self)
		AddonList_LoadAddOn(self:GetParent().id)
	end

	local addonListEntry = {}
	for i = 1, 20 do
		addonListEntry[i] = CreateFrame("Button", "ElvUI_AddonListEntry"..i, scrollFrame)
		addonListEntry[i]:Size(scrollFrame:GetWidth() - 8, 16)
		addonListEntry[i].id = i

		if i == 1 then
			addonListEntry[i]:Point("TOPLEFT", 4, -4)
		else
			addonListEntry[i]:Point("TOP", addonListEntry[i - 1], "BOTTOM", 0, -4)
		end

		local enabled = CreateFrame("CheckButton", "$parentEnabled", addonListEntry[i])
		enabled:Size(24, 24)
		enabled:Point("LEFT", -4, 0)
		S:HandleCheckBox(enabled)

		local title = addonListEntry[i]:CreateFontString("$parentTitle", "BACKGROUND", "GameFontNormal")
		title:Size(220, 12)
		title:Point("LEFT", 22, 0)
		title:SetJustifyH("LEFT")

		local status = addonListEntry[i]:CreateFontString("$parentStatus", "BACKGROUND", "GameFontNormalSmall")
		status:Size(220, 12)
		status:Point("RIGHT", -22, 0)
		status:SetJustifyH("RIGHT")
		addonListEntry[i].Status = status

		local reload = addonListEntry[i]:CreateFontString("$parentReload", "BACKGROUND", "GameFontRed")
		reload:Size(220, 12)
		reload:Point("RIGHT", -22, 0)
		reload:SetJustifyH("RIGHT")
		reload:SetText(L["Requires Reload"])
		addonListEntry[i].Reload = reload

		local load = CreateFrame("Button", "$parentLoad", addonListEntry[i], "UIPanelButtonTemplate")
		load:Size(100, 22)
		load:Point("RIGHT", -21, 0)
		load:SetText(L["Load AddOn"])
		S:HandleButton(load)
		addonListEntry[i].LoadButton = load

		addonListEntry[i]:SetScript("OnEnter", AddonTooltip_Update)
		addonListEntry[i]:SetScript("OnLeave", GameTooltip_Hide)

		enabled:SetScript("OnClick", Enable_OnClick)
		load:SetScript("OnClick", Load_OnClick)
	end

	local buttonAddons = CreateFrame("Button", "ElvUI_AddonListButton", GameMenuFrame, "GameMenuButtonTemplate")
	buttonAddons:Point("TOP", GameMenuButtonMacros, "BOTTOM", 0, -1)
	buttonAddons:SetText(ADDONS)
	S:HandleButton(buttonAddons)
	buttonAddons:SetScript("OnClick", function()
		HideUIPanel(GameMenuFrame)
		ElvUI_AddonList:Show()
	end)

	self:HookScript(GameMenuButtonRatings, "OnShow", function(self)
		buttonAddons:Point("TOP", self, "BOTTOM", 0, -1)
	end)

	self:HookScript(GameMenuButtonRatings, "OnHide", function(self)
		buttonAddons:Point("TOP", GameMenuButtonMacros, "BOTTOM", 0, -1)
	end)

	GameMenuButtonLogout:SetScript("OnShow", function(self)
		self:Point("TOP", buttonAddons, "BOTTOM", 0, -16)

		if not StaticPopup_Visible("CAMP") and not StaticPopup_Visible("QUIT") then
			self:Enable()
		else
			self:Disable()
		end
	end)

	if GetLocale() == "koKR" then
		if IsMacClient() then
			GameMenuFrame:Height(308)
		else
			GameMenuFrame:Height(282)
		end
	else
		if IsMacClient() then
			GameMenuFrame:Height(292)
		else
			GameMenuFrame:Height(266)
		end
	end
end