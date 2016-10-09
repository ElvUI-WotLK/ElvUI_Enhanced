local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local ENH = E:NewModule('ENH', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

ENH.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

E.PopupDialogs["VERSION_MISMATCH"] = {
	text = L["Your version of ElvUI is to old (required v5.25 or higher). Please, download the latest version from tukui.org."],
	button1 = CLOSE,
	timeout = 0,
	whileDead = 1,	
	preferredIndex = 3,
}

--Showing warning message about too old versions of ElvUI
if tonumber(E.version) < 5.25 then
	E:StaticPopup_Show("VERSION_MISMATCH")
end

function ENH:Initialize()
	if E.db.general.loginmessage then
		print(format(L['ENH_LOGIN_MSG'], E["media"].hexvaluecolor, ENH.version))
	end	
end

E:RegisterModule(ENH:GetName())