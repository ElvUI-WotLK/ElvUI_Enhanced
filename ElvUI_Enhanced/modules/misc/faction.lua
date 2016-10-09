local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:GetModule('MiscEnh');

local find, gsub, format = string.find, string.gsub, string.format

local incpat 			= gsub(gsub(FACTION_STANDING_INCREASED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local changedpat	= gsub(gsub(FACTION_STANDING_CHANGED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local decpat			= gsub(gsub(FACTION_STANDING_DECREASED, "(%%s)", "(.+)"), "(%%d)", "(.+)")
local standing    = ('%s:'):format(STANDING)
local reputation  = ('%s:'):format(REPUTATION)

function M:SetWatchedFactionOnReputationBar(event, msg)
	if not E.private.general.autorepchange then return end
	
	local _, _, faction, amount = find(msg, incpat)
	if not faction then _, _, faction, amount = find(msg, changedpat) or find(msg, decpat) end
	if faction then
		if faction == GUILD_REPUTATION then
			faction = GetGuildInfo("player")
		end

		local active = GetWatchedFactionInfo()
		for factionIndex = 1, GetNumFactions() do
			local name = GetFactionInfo(factionIndex)
			if name == faction and name ~= active then
				-- check if watch has been disabled by user
				local inactive = IsFactionInactive(factionIndex) or SetWatchedFactionIndex(factionIndex)
				break
			end
		end
	end
end



function M:LoadWatchedFaction()
	-- no config setting yet
	-- if not E.private.general.questreward then return end
	self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE", 'SetWatchedFactionOnReputationBar')
end