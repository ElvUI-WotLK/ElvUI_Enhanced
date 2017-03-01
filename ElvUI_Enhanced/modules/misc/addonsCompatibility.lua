local E, L, V, P, G = unpack(ElvUI);
local AC = E:NewModule("Enhanced_AddonsCompat", "AceEvent-3.0");

local tinsert, tremove = table.insert, table.remove
local pairs = pairs

local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn

local addonFixes = {
	-- GroupCalendar 4.6.1
	["GroupCalendar"] = function()
		local DT = E:GetModule("DataTexts")
		if DT.RegisteredDataTexts and DT.RegisteredDataTexts["Time"] then
			DT.RegisteredDataTexts["Time"].onClick = function(_, btn)
				if(btn == "RightButton") then
					if(not IsAddOnLoaded("Blizzard_TimeManager")) then LoadAddOn("Blizzard_TimeManager"); end
					TimeManagerClockButton_OnClick(TimeManagerClockButton);
				elseif(GroupCalendar and GroupCalendar.ToggleCalendarDisplay) then
					GroupCalendar.ToggleCalendarDisplay();
				else
					GameTimeFrame:Click();
				end
			end
		end
	end,
}

local function table_count(t)
	local i = 0
	for _, _ in pairs(t) do
		i = i + 1
	end
	return i
end

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
	local func = addonFixes[addon]
	func()

	if onDemandID then
		tremove(self.addonQueue, onDemandID)
	end
end

function AC:ADDON_LOADED(_, AddonName)
	for i, addon in pairs(self.addonQueue) do
		if addon == AddonName then
			self:ApplyFix(addon, i)

			if table_count(self.addonQueue) == 0 then
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

E:RegisterModule(AC:GetName());