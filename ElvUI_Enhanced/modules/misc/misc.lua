local E, L, V, P, G = unpack(ElvUI);
local M = E:NewModule("MiscEnh", "AceEvent-3.0");

E.MiscEnh = M;

local IsInInstance = IsInInstance
local RepopMe = RepopMe

function M:LoadAutoRelease()
	if not E.private.general.pvpautorelease then return end

	local frame = CreateFrame("frame")
	frame:RegisterEvent("PLAYER_DEAD")
	frame:SetScript("OnEvent", function()
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