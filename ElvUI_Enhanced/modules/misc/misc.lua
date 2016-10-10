local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:NewModule('MiscEnh', 'AceHook-3.0', 'AceEvent-3.0');

E.MiscEnh = M;

function M:LoadAutoRelease()
	if not E.private.general.pvpautorelease then return end

	local autoreleasepvp = CreateFrame("frame")
	autoreleasepvp:RegisterEvent("PLAYER_DEAD")
	autoreleasepvp:SetScript("OnEvent", function(self, event)
		local inInstance, instanceType = IsInInstance()
		if(inInstance and (instanceType == "pvp")) then
			local soulstone = GetSpellInfo(20707)
			if((E.myclass ~= "SHAMAN") and not (soulstone and UnitBuff("player", soulstone))) then
				RepopMe()
			end
		end
	end);
end

function M:Initialize()
	self:LoadAutoRelease()
	self:LoadWatchedFaction()
	self:LoadMoverTransparancy()
end

E:RegisterModule(M:GetName())