local E, L, V, P, G = unpack(ElvUI)
local AC = E:NewModule("Enhanced_AddonsCompat", "AceEvent-3.0")

local pairs, ipairs = pairs, ipairs
local type = type
local tinsert, tremove = table.insert, table.remove

local GetAddOnInfo = GetAddOnInfo
local GetNumAddOns = GetNumAddOns
local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand
local IsAddOnLoaded = IsAddOnLoaded

local externalFixes = {}

local addonFixes = {
	-- Cromulent 1.5.2
	["Cromulent"] = function()
		local WORLDMAP_SETTINGS = WORLDMAP_SETTINGS
		local WORLDMAP_WINDOWED_SIZE = WORLDMAP_WINDOWED_SIZE
		local WORLDMAP_QUESTLIST_SIZE = WORLDMAP_QUESTLIST_SIZE

		local _, fontSize = CromulentZoneInfo.text:GetFont()
		local fontSizeWindowed = fontSize / WORLDMAP_WINDOWED_SIZE + 10
		local fontSizeQuestlist = fontSize / WORLDMAP_QUESTLIST_SIZE + 5

		local function UpdateFontSize()
			if CromulentZoneInfo:IsShown() then
				if WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
					CromulentZoneInfo.text:FontTemplate(nil, fontSizeWindowed, "OUTLINE")
				elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
					CromulentZoneInfo.text:FontTemplate(nil, fontSizeQuestlist, "OUTLINE")
				else
					CromulentZoneInfo.text:FontTemplate(nil, fontSize, "OUTLINE")
				end
			end
		end

		UpdateFontSize()
		hooksecurefunc(WorldMapFrameAreaFrame, "SetScale", UpdateFontSize)
	end,

	-- GroupCalendar 4.6.1
	["GroupCalendar"] = function()
		local DT = E:GetModule("DataTexts")
		if DT.RegisteredDataTexts and DT.RegisteredDataTexts["Time"] then
			DT.RegisteredDataTexts["Time"].onClick = function(_, btn)
				if btn == "RightButton" then
					if not IsAddOnLoaded("Blizzard_TimeManager") then
						LoadAddOn("Blizzard_TimeManager")
					end
					TimeManagerClockButton_OnClick(TimeManagerClockButton)
				elseif GroupCalendar and GroupCalendar.ToggleCalendarDisplay then
					GroupCalendar.ToggleCalendarDisplay()
				else
					GameTimeFrame:Click()
				end
			end
		end
	end,

	-- CLCRet 1.3.03.025
	-- https://www.curseforge.com/wow/addons/clcret/files/439502
	["CLCRet"] = function()
		local UnitAffectingCombat = UnitAffectingCombat
		local UnitCanAttack = UnitCanAttack
		local UnitClassification = UnitClassification
		local UnitExists = UnitExists
		local UnitIsDead = UnitIsDead

		local db = clcret.db.profile

		function clcret:Enable()
			self.addonEnabled = true
			self.frame:Show()
		end
		function clcret:Disable()
			self.addonEnabled = false
			self.frame:Hide()
		end

		function clcret:PLAYER_REGEN_ENABLED()
			if not self.addonEnabled then return end
			self.frame:Hide()
		end
		function clcret:PLAYER_REGEN_DISABLED()
			if not self.addonEnabled then return end
			self.frame:Hide()
		end
		function clcret:PLAYER_TARGET_CHANGED()
			if not self.addonEnabled then return end

			if db.show == "boss" then
				if UnitClassification("target") ~= "worldboss" then
					self.frame:Hide()
					return
				end
			end

			if UnitExists("target") and UnitCanAttack("player", "target") and (not UnitIsDead("target")) then
				self.frame:Show()
			else
				self.frame:Hide()
			end
		end

		hooksecurefunc(clcret, "UpdateShowMethod", function(self)
			if db.show == "combat" and self.addonEnabled then
				if UnitAffectingCombat("player") then
					self.frame:Show()
				else
					self.frame:Hide()
				end
			elseif db.show ~= "valid" and db.show ~= "boss" and self.addonEnabled then
				self.frame:Show()
			end
		end)
	end,

	-- DrDamage 1.7.8
	-- https://www.wowace.com/projects/dr-damage/files/426084
	["DrDamage"] = function()
		if not E.private.actionbar.enable then return end

		local HasAction = HasAction
		local SecureButton_GetEffectiveButton = SecureButton_GetEffectiveButton
		local SecureButton_GetModifiedAttribute = SecureButton_GetModifiedAttribute

		local AB = E:GetModule("ActionBars")

		local DrD_ProcessButton = function(button, func, spell, uid, mana, disable)
			if not button then return end
			if not spell and not uid and not mana then
				local frame = button.drd
				if frame then frame:SetText(nil) end
				frame = button.drd2
				if frame then frame:SetText(nil) end
			end
			if not DrDamage.db.profile.ABText or disable then return end
			if button:IsVisible() then
				local id, name, rank = func(button)
				if id and (not HasAction(id) or uid and uid ~= id) then return end
				DrDamage:CheckAction(button, spell, id, name, rank, mana)
			end
		end

		local updateFunc = function(button)
			return SecureButton_GetModifiedAttribute(button, "action", SecureButton_GetEffectiveButton(button))
		end

		hooksecurefunc(DrDamage, "UpdateAB", function(self, spell, uid, disable, mana)
			for _, bar in pairs(AB.handledBars) do
				for _, button in ipairs(bar.buttons) do
					DrD_ProcessButton(button, updateFunc, spell, uid, mana, disable)
				end
			end
		end)
	end,

	-- All Stats 1.1
	-- https://www.curseforge.com/wow/addons/all-stats/files/430951
	["AllStats"] = function()
		if E.private.enhanced.character.modelFrames and not E.private.enhanced.character.enable then
			CharacterModelFrame:Size(237, 324)
		end
	end,

	-- https://github.com/ElvUI-WotLK/ElvUI_Enhanced/issues/100
	["OmniBar"] = function()
		hooksecurefunc("OmniBar_CreateIcon", function(self)
			E:RegisterCooldown(self.icons[#self.icons].cooldown)
		end)

		for _, icon in ipairs(OmniBar.icons) do
			E:RegisterCooldown(icon.cooldown)
		end
	end,

	-- BlizzMove r18
	-- https://www.curseforge.com/wow/addons/blizzmove/files/456128
	-- https://github.com/ElvUI-WotLK/ElvUI_Enhanced/issues/96
	["BlizzMove"] = function()
		if E.private.enhanced.character.enable then
			local MouseIsOver = MouseIsOver

			local origOnMouseWheel

			local function onMouseWheel(self, delta)
				if CharacterStatsPane:IsShown() and MouseIsOver(CharacterStatsPane) then
					CharacterStatsPane:GetScript("OnMouseWheel")(CharacterStatsPane, delta)
				elseif PaperDollTitlesPane:IsShown() and MouseIsOver(PaperDollTitlesPane) then
					PaperDollTitlesPane:GetScript("OnMouseWheel")(PaperDollTitlesPane, delta)
				elseif PaperDollEquipmentManagerPane:IsShown() and MouseIsOver(PaperDollEquipmentManagerPane) then
					PaperDollEquipmentManagerPane:GetScript("OnMouseWheel")(PaperDollEquipmentManagerPane, delta)
				else
					origOnMouseWheel(self, delta)
				end
			end

			local f = CreateFrame("Frame")
			f:RegisterEvent("PLAYER_ENTERING_WORLD")
			f:SetScript("OnEvent", function(self)
				self:UnregisterEvent("PLAYER_ENTERING_WORLD")

				origOnMouseWheel = PaperDollFrame:GetScript("OnMouseWheel")

				if PaperDollFrame.frameToMove and PaperDollFrame.frameToMove.EnableMouse then
					PaperDollFrame:SetScript("OnMouseWheel", onMouseWheel)
				end

				hooksecurefunc(BlizzMove, "Toggle", function(self, handler)
					if handler == PaperDollFrame then
						if not handler:GetScript("OnDragStart") then
							PaperDollFrame:SetScript("OnMouseWheel", nil)
						else
							PaperDollFrame:SetScript("OnMouseWheel", onMouseWheel)
						end
					end
				end)
			end)
		end
	end,

	-- InspectEquip 1.7.7
	["InspectEquip"] = function()
		if E.private.enhanced.character.enable then
			PaperDollFrame:HookScript("OnShow", InspectEquip.PaperDollFrame_OnShow)
			PaperDollFrame:HookScript("OnHide", InspectEquip.PaperDollFrame_OnHide)
		end
	end,
}

function AC:AddAddon(addon, func)
	if type(addon) ~= "string" then
		error(string.format("bad argument #1 to 'AddAddon' (string expected, got %s)", addon ~= nil and type(addon) or "no value"), 2)
	elseif func and type(func) ~= "function" then
		error(string.format("bad argument #2 to 'AddAddon' (function expected, got %s)", func ~= nil and type(func) or "no value"), 2)
	end

	if not self.initialized then
		self.preinitList = self.preinitList or {}
		self.preinitList[addon] = func
		return
	end

	if not self.addonList[addon] then return end

	if IsAddOnLoaded(addon) then
		self:ApplyFix(addon, func)
	elseif IsAddOnLoadOnDemand(addon) then
		if not addonFixes[addon] then
			externalFixes[addon] = externalFixes[addon] or {}
			tinsert(externalFixes[addon], func)
		end

		tinsert(self.addonQueue, addon)
		self:RegisterEvent("ADDON_LOADED")
	end
end

function AC:ApplyFix(addon, func)
	if func then
		func()

		if addonFixes[addon] then
			addonFixes[addon] = nil
		end
	else
		if addonFixes[addon] then
			addonFixes[addon]()
			addonFixes[addon] = nil
		end

		if externalFixes[addon] then
			for i = 1, #externalFixes[addon] do
				externalFixes[addon][i]()
			end

			externalFixes[addon] = nil
		end
	end
end

function AC:ADDON_LOADED(_, addonName)
	if not (addonFixes[addonName] or externalFixes[addonName]) then return end

	for i, addon in ipairs(self.addonQueue) do
		if addon == addonName then
			self:ApplyFix(addon)

			tremove(self.addonQueue, i)

			if #self.addonQueue == 0 then
				self:UnregisterEvent("ADDON_LOADED")
			end

			break
		end
	end
end

function AC:Initialize()
	self.addonQueue = {}
	self.addonList = {}

	for i = 1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(i)

		if enabled or IsAddOnLoadOnDemand(i) then
			self.addonList[name] = true
		end
	end

	self.initialized = true

	for addon, func in pairs(addonFixes) do
		self:AddAddon(addon, func)
	end

	if self.preinitList then
		for addon, func in pairs(self.preinitList) do
			self:AddAddon(addon, func)
		end
	end
end

local function InitializeCallback()
	AC:Initialize()
end

E:RegisterModule(AC:GetName(), InitializeCallback)