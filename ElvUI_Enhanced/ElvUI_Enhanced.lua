local E, L, V, P, G = unpack(ElvUI)
local addon = E:NewModule("ElvUI_Enhanced")

local addonName = ...

local LEP = LibStub("LibElvUIPlugin-1.0")

function E:GearScoreSpam()
	E:Print("GearScore version '3.1.20b - Release' for not WotLK. Download 3.1.7")
end

function addon:Initialize()
	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E["media"].hexvaluecolor, addon.version))
	end

	-- DBConversions
	if E.db.enhanced.tooltip.progressInfo.tiers.TotC then
		E.db.enhanced.tooltip.progressInfo.tiers.ToC = true
	end
	if E.db.enhanced.tooltip.progressInfo.tiers.TotC ~= nil then
		E.db.enhanced.tooltip.progressInfo.tiers.TotC = nil
	end

	LEP:RegisterPlugin(addonName, self.GetOptions)

	if E.db.general.showQuestLevel then
		E.db.enhanced.general.showQuestLevel = true
	end
	E.db.general.showQuestLevel = nil

	if IsAddOnLoaded("GearScore") then
		if GetAddOnMetadata("GearScore", "Version") == "3.1.20b - Release" then
			E:ScheduleRepeatingTimer("GearScoreSpam", 5)
		end
	end
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)