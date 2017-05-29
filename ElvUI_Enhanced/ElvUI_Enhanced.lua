local E, L, V, P, G = unpack(ElvUI);
local addon = E:NewModule("ElvUI_Enhanced");

local addonName = ...;

local LEP = LibStub("LibElvUIPlugin-1.0");

function addon:Initialize()
	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E["media"].hexvaluecolor, addon.version));
	end

	LEP:RegisterPlugin(addonName, self.GetOptions);
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)