local E, L, V, P, G = unpack(ElvUI)
local addon = E:NewModule("ElvUI_Enhanced")

local LEP = LibStub("LibElvUIPlugin-1.0")

function addon:Initialize()
	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E["media"].hexvaluecolor, addon.version))
	end

	LEP:RegisterPlugin("ElvUI_Enhanced", self.GetOptions)

	if E.db.general.showQuestLevel then
		E.db.enhanced.general.showQuestLevel = true
	end
	E.db.general.showQuestLevel = nil
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)