local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local ENH = E:NewModule('ENH', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

function ENH:Initialize()
	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	if E.db.general.loginmessage then
		print(format(L['ENH_LOGIN_MSG'], E["media"].hexvaluecolor, ENH.version))
	end
end

E:RegisterModule(ENH:GetName())