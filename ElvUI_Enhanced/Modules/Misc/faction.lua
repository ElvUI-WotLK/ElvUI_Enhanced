local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local find, gsub = string.find, string.gsub

local GetFactionInfo = GetFactionInfo
local GetNumFactions = GetNumFactions
local GetWatchedFactionInfo = GetWatchedFactionInfo
local IsFactionInactive = IsFactionInactive
local SetWatchedFactionIndex = SetWatchedFactionIndex

local increased	= gsub(gsub(FACTION_STANDING_INCREASED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local decreased	= gsub(gsub(FACTION_STANDING_DECREASED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local changed	= gsub(gsub(FACTION_STANDING_CHANGED, "(%%s)", "(.+)"), "(%%d)", "(.+)")

function M:CHAT_MSG_COMBAT_FACTION_CHANGE(_, msg)
	local startPos, _, faction = find(msg, increased)

	if not startPos then
		startPos, _, faction = find(msg, decreased)
		if not startPos then
			_, _, faction = find(msg, changed)
		end
	end

	if faction and faction ~= GetWatchedFactionInfo() then
		for factionIndex = 1, GetNumFactions() do
			local name = GetFactionInfo(factionIndex)

			if name == faction then
				if not IsFactionInactive(factionIndex) then
					SetWatchedFactionIndex(factionIndex)
				end

				break
			end
		end
	end
end

function M:WatchedFaction()
	if E.db.enhanced.general.autoRepChange then
		self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	else
		self:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	end
end