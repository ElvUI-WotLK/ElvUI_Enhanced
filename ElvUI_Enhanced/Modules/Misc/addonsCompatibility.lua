local E, L, V, P, G = unpack(ElvUI)
local AC = E:NewModule("Enhanced_AddonsCompat", "AceEvent-3.0")

local pairs, ipairs = pairs, ipairs
local tinsert, tremove = table.insert, table.remove

local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn

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
					if not IsAddOnLoaded("Blizzard_TimeManager") then LoadAddOn("Blizzard_TimeManager") end
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
}

function AC:AddAddon(addon)
	if not addon then return end

	if IsAddOnLoaded(addon) then
		self:ApplyFix(addon)
	elseif IsAddOnLoadOnDemand(addon) then
		tinsert(self.addonQueue, addon)
		self:RegisterEvent("ADDON_LOADED")
	end
end

function AC:ApplyFix(addon, onDemandID)
	addonFixes[addon]()

	if onDemandID then
		tremove(self.addonQueue, onDemandID)
	end
end

function AC:ADDON_LOADED(_, addonName)
	if not addonFixes[addonName] then return end

	for i, addon in ipairs(self.addonQueue) do
		if addon == addonName then
			self:ApplyFix(addon, i)

			if #self.addonQueue == 0 then
				self:UnregisterEvent("ADDON_LOADED")
			end

			break
		end
	end
end

function AC:Initialize()
	self.addonQueue = {}

	for addon, func in pairs(addonFixes) do
		self:AddAddon(addon, func)
	end
end

local function InitializeCallback()
	AC:Initialize()
end

E:RegisterModule(AC:GetName(), InitializeCallback)