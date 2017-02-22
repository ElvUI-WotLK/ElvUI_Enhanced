local E, L, V, P, G = unpack(ElvUI);
local ENH = E:NewModule("ENH")

function ENH:Initialize()
	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E["media"].hexvaluecolor, ENH.version))
	end
end

E:RegisterModule(ENH:GetName())