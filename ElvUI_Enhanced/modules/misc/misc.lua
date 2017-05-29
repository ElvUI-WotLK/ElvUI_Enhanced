local E, L, V, P, G = unpack(ElvUI);
local M = E:NewModule("Enhanced_Misc", "AceEvent-3.0");

E.Enhanced_Misc = M;

local IsInInstance = IsInInstance
local RepopMe = RepopMe

function M:PLAYER_DEAD()
	local inInstance, instanceType = IsInInstance();
	if(inInstance and (instanceType == "pvp")) then
		local soulstone = GetSpellInfo(20707);
		if((E.myclass ~= "SHAMAN") and not (soulstone and UnitBuff("player", soulstone))) then
			RepopMe();
		end
	end
end

function M:AutoRelease()
	if(E.db.enhanced.general.pvpAutoRelease) then
		self:RegisterEvent("PLAYER_DEAD");
	else
		self:UnregisterEvent("PLAYER_DEAD");
	end
end

function M:Initialize()
	self:AutoRelease();
	self:WatchedFaction();
	self:LoadMoverTransparancy()
end

local function InitializeCallback()
	M:Initialize()
end

E:RegisterModule(M:GetName(), InitializeCallback)