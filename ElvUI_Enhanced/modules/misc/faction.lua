local E, L, V, P, G = unpack(ElvUI);
local M = E:GetModule("Enhanced_Misc");

local find, gsub, format = string.find, string.gsub, string.format

local GetFactionInfo = GetFactionInfo
local GetNumFactions = GetNumFactions
local GetWatchedFactionInfo = GetWatchedFactionInfo
local IsFactionInactive = IsFactionInactive
local SetWatchedFactionIndex = SetWatchedFactionIndex

local incpat		= gsub(gsub(FACTION_STANDING_INCREASED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local changedpat	= gsub(gsub(FACTION_STANDING_CHANGED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local decpat		= gsub(gsub(FACTION_STANDING_DECREASED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local standing		= format("%s:", STANDING)
local reputation	= format("%s:", REPUTATION)

function M:CHAT_MSG_COMBAT_FACTION_CHANGE(_, msg)
	local _, _, faction = find(msg, incpat);

	if(not faction) then
		_, _, faction = find(msg, changedpat) or find(msg, decpat);
	end

	if(faction) then
		local active = GetWatchedFactionInfo();
		for factionIndex = 1, GetNumFactions() do
			local name = GetFactionInfo(factionIndex);
			if(name == faction and name ~= active) then
				-- check if watch has been disabled by user
				if(not IsFactionInactive(factionIndex)) then
					SetWatchedFactionIndex(factionIndex);
				end
				break;
			end
		end
	end
end

function M:WatchedFaction()
	if(E.db.enhanced.general.autoRepChange) then
		self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
	else
		self:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
	end
end