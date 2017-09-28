local E, L, V, P, G = unpack(ElvUI)
local AL = E:NewModule("AddOnList", "AceHook-3.0")

local floor = math.floor

local CreateFrame = CreateFrame
local DisableAddOn = DisableAddOn
local EnableAddOn = EnableAddOn
local GetAddOnDependencies = GetAddOnDependencies
local GetAddOnInfo = GetAddOnInfo
local GetNumAddOns = GetNumAddOns
local IsAddOnLoaded = IsAddOnLoaded
local IsShiftKeyDown = IsShiftKeyDown
local LoadAddOn = LoadAddOn

function AL:HasAnyChanged()
	for i = 1, GetNumAddOns() do
		local _, _, _, enabled, _, reason = GetAddOnInfo(i)
		if enabled ~= ElvUI_AddonList.startStatus[i] and reason ~= "DEP_DISABLED" then
			return true
		end
	end

	return false
end

function AL:SetStatus(entry, load, status, reload)
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

function AL:Update()
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

			if enabled ~= ElvUI_AddonList.startStatus[addonIndex] and reason ~= "DEP_DISABLED" then
				if enabled then
					if self:IsAddOnLoadOnDemand(addonIndex) then
						self:SetStatus(entry, true, false, false)
					else
						self:SetStatus(entry, false, false, true)
					end
				else
					self:SetStatus(entry, false, false, true)
				end
			else
				self:SetStatus(entry, false, true, false)
			end

			entry:SetID(addonIndex)
			entry:Show()
		end
	end

	FauxScrollFrame_Update(ElvUI_AddonListScrollFrame, numEntries, 20, 16)

	if self:HasAnyChanged() then
		ElvUI_AddonListOkayButton:SetText(L["Reload UI"])
		ElvUI_AddonList.shouldReload = true
	else
		ElvUI_AddonListOkayButton:SetText(OKAY)
		ElvUI_AddonList.shouldReload = false
	end
end

function AL:IsAddOnLoadOnDemand(index)
	local lod = false

	if IsAddOnLoadOnDemand(index) then
		if not IsAddOnLoaded(index) then
			lod = true
		end
	end

	return lod
end

function AL:Enable(index, enabled)
	if enabled then
		EnableAddOn(index)
	else
		DisableAddOn(index)
	end

	self:Update()
end

function AL:LoadAddOn(index)
	if not self:IsAddOnLoadOnDemand(index) then return end

	LoadAddOn(index)

	if IsAddOnLoaded(index) then
		ElvUI_AddonList.startStatus[index] = 1
	end

	self:Update()
end

function AL:TooltipBuildDeps(...)
	local deps = ""

	for i = 1, select("#", ...) do
		if i == 1 then
			deps = L["Dependencies: "]..select(i, ...)
		else
			deps = deps..", "..select(i, ...)
		end
	end

	return deps
end

function AL:TooltipUpdate(owner)
	local id = owner:GetID()
	if id == 0 then return end

	local name, title, notes, _, _, security = GetAddOnInfo(id)
	if not name then return end

	GameTooltip:ClearLines()

	if security == "BANNED" then
		GameTooltip:SetText(L["This addon has been disabled. You should install an updated version."])
	else
		if title then
			GameTooltip:AddLine(title)
		else
			GameTooltip:AddLine(name)
		end

		GameTooltip:AddLine(notes, 1.0, 1.0, 1.0)
		GameTooltip:AddLine(self:TooltipBuildDeps(GetAddOnDependencies(id)))
	end

	GameTooltip:Show()
end

function AL:Initialize()
	if IsAddOnLoaded("ACP") then return end

	local S = E:GetModule("Skins")

	local addonList = CreateFrame("Frame", "ElvUI_AddonList", UIParent)
	addonList:SetFrameStrata("HIGH")
	addonList:Size(520, 475)
	addonList:Point("CENTER", 0, 0)
	addonList:SetTemplate("Transparent")
	addonList:Hide()
	tinsert(UISpecialFrames, addonList:GetName())

	addonList.offset = 0
	addonList.shouldReload = false
	addonList.startStatus = {}

	for i = 1, GetNumAddOns() do
		local _, _, _, enabled = GetAddOnInfo(i)
		addonList.startStatus[i] = enabled
	end

	local addonTitle = addonList:CreateFontString("$parentTitle", "BACKGROUND", "GameFontNormal")
	addonTitle:Point("TOP", 0, -12)
	addonTitle:SetText(ADDONS)

	local SPACING = (E.PixelMode and 3 or 5)

	local cancelButton = CreateFrame("Button", "$parentCancelButton", addonList, "UIPanelButtonTemplate")
	cancelButton:Size(80, 22)
	cancelButton:Point("BOTTOMRIGHT", -SPACING, SPACING)
	cancelButton:SetText(CANCEL)
	S:HandleButton(cancelButton)

	local closeButton = CreateFrame("Button", "$parentCloseButton", addonList, "UIPanelCloseButton")
	closeButton:Size(32)
	closeButton:Point("TOPRIGHT", -2, 2)
	S:HandleCloseButton(closeButton)

	local okayButton = CreateFrame("Button", "$parentOkayButton", addonList, "UIPanelButtonTemplate")
	okayButton:Size(80, 22)
	okayButton:Point("TOPRIGHT", cancelButton, "TOPLEFT", -SPACING, 0)
	okayButton:SetText(OKAY)
	S:HandleButton(okayButton)

	local enableAllButton = CreateFrame("Button", "$parentEnableAllButton", addonList, "UIPanelButtonTemplate")
	enableAllButton:Size(120, 22)
	enableAllButton:Point("BOTTOMLEFT", SPACING, SPACING)
	enableAllButton:SetText(L["Enable All"])
	S:HandleButton(enableAllButton)

	local disableAllButton = CreateFrame("Button", "$parentDisableAllButton", addonList, "UIPanelButtonTemplate")
	disableAllButton:Size(120, 22)
	disableAllButton:Point("TOPLEFT", enableAllButton, "TOPRIGHT", SPACING, 0)
	disableAllButton:SetText(L["Disable All"])
	S:HandleButton(disableAllButton)

	addonList:SetScript("OnShow", function()
		self:Update()
		PlaySound("igMainMenuOption")
	end)

	addonList:SetScript("OnHide", function()
		PlaySound("igMainMenuOptionCheckBoxOn")
	end)

	addonList:SetClampedToScreen(true)
	addonList:SetMovable(true)
	addonList:EnableMouse(true)
	addonList:RegisterForDrag("LeftButton")

	addonList:SetScript("OnDragStart", function(self)
		if IsShiftKeyDown() then
			self:StartMoving()
		end
	end)

	addonList:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)

	addonList:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 4)
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(L["Hold Shift + Drag:"], L["Temporary Move"], 1, 1, 1)

		GameTooltip:Show()
	end)
	addonList:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	cancelButton:SetScript("OnClick", function()
		ElvUI_AddonList:Hide()
	end)

	closeButton:SetScript("OnClick", function()
		ElvUI_AddonList:Hide()
	end)

	okayButton:SetScript("OnClick", function()
		ElvUI_AddonList:Hide()
		if ElvUI_AddonList.shouldReload then
			ReloadUI()
		end
	end)

	enableAllButton:SetScript("OnClick", function()
		EnableAllAddOns()
		AL:Update()
	end)

	disableAllButton:SetScript("OnClick", function()
		DisableAllAddOns()
		AL:Update()
	end)

	local scrollFrame = CreateFrame("ScrollFrame", "$parentScrollFrame", addonList, "FauxScrollFrameTemplate")
	scrollFrame:SetTemplate("Transparent")
	scrollFrame:Point("TOPLEFT", addonList, "TOPLEFT", 10, -30)
	scrollFrame:Point("BOTTOMRIGHT", addonList, "BOTTOMRIGHT", -34, 41)
	S:HandleScrollBar(ElvUI_AddonListScrollFrameScrollBar, 5)

	scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		local scrollbar = _G[self:GetName().."ScrollBar"]
		scrollbar:SetValue(offset)
		addonList.offset = floor((offset / 16) + 0.5)
		AL:Update()
		if GameTooltip:IsShown() then
			AL:TooltipUpdate(GameTooltip:GetOwner())
			GameTooltip:Show()
		end
	end)

	local addonListEntry = {}
	for i = 1, 20 do
		addonListEntry[i] = CreateFrame("Button", "ElvUI_AddonListEntry"..i, scrollFrame)
		addonListEntry[i]:Size(scrollFrame:GetWidth() - 8, 16)
		addonListEntry[i]:SetID(i)

		if i == 1 then
			addonListEntry[i]:Point("TOPLEFT", 4, -4)
		else
			addonListEntry[i]:Point("TOP", addonListEntry[i - 1], "BOTTOM", 0, -4)
		end

		local enabled = CreateFrame("CheckButton", "$parentEnabled", addonListEntry[i], "ChatConfigCheckButtonTemplate")
		enabled:Size(24, 24)
		enabled:Point("LEFT", 5, 0)
		S:HandleCheckBox(enabled)

		local title = addonListEntry[i]:CreateFontString("$parentTitle", "BACKGROUND", "GameFontNormal")
		title:Size(220, 12)
		title:Point("LEFT", 32, 0)
		title:SetJustifyH("LEFT")

		local status = addonListEntry[i]:CreateFontString("$parentStatus", "BACKGROUND", "GameFontNormalSmall")
		status:Size(220, 12)
		status:Point("RIGHT", "$parent", -22, 0)
		status:SetJustifyH("RIGHT")
		addonListEntry[i].Status = status

		local reload = addonListEntry[i]:CreateFontString("$parentReload", "BACKGROUND", "GameFontRed")
		reload:Size(220, 12)
		reload:Point("RIGHT", "$parent", -22, 0)
		reload:SetJustifyH("RIGHT")
		reload:SetText(L["Requires Reload"])
		addonListEntry[i].Reload = reload

		local load = CreateFrame("Button", "$parentLoad", addonListEntry[i], "UIPanelButtonTemplate")
		load:Size(100, 22)
		load:Point("RIGHT", "$parent", -21, 0)
		load:SetText(L["Load AddOn"])
		S:HandleButton(load)
		addonListEntry[i].LoadButton = load

		addonListEntry[i]:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -270, 0)
			AL:TooltipUpdate(self)
		end)

		addonListEntry[i]:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		enabled:SetScript("OnClick", function(self)
			AL:Enable(self:GetParent():GetID(), self:GetChecked())
			PlaySound("igMainMenuOptionCheckBoxOn")
		end)

		enabled:SetScript("OnEnter", function(self)
			if self.tooltip then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -270, 0)
				AL:TooltipUpdate(self)
				GameTooltip:Show()
			end
		end)

		enabled:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		load:SetScript("OnClick", function(self)
			AL:LoadAddOn(self:GetParent():GetID())
		end)
	end

	local buttonAddons = CreateFrame("Button", "ElvUI_ButtonAddons", GameMenuFrame, "GameMenuButtonTemplate")
	buttonAddons:Point("TOP", GameMenuButtonMacros, "BOTTOM", 0, -1)
	buttonAddons:SetText(ADDONS)
	S:HandleButton(buttonAddons)

	buttonAddons:SetScript("OnClick", function()
		HideUIPanel(GameMenuFrame)
		ShowUIPanel(ElvUI_AddonList)
	end)

	self:HookScript(GameMenuButtonRatings, "OnShow", function(self)
		ElvUI_ButtonAddons:Point("TOP", GameMenuButtonRatings, "BOTTOM", 0, -1)
	end)

	self:HookScript(GameMenuButtonRatings, "OnHide", function(self)
		ElvUI_ButtonAddons:Point("TOP", GameMenuButtonMacros, "BOTTOM", 0, -1)
	end)

	self:RawHookScript(GameMenuButtonLogout, "OnShow", function(self)
		self:SetPoint("TOP", ElvUI_ButtonAddons, "BOTTOM", 0, -16)

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

local function InitializeCallback()
	AL:Initialize()
end

E:RegisterModule(AL:GetName(), InitializeCallback)