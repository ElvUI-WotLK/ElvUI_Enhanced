local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local HG = E:NewModule('HealGlow', 'AceEvent-3.0')
local UF = E:GetModule('UnitFrames')

local GetNumGroupMembers, GetNumSubgroupMembers = GetNumGroupMembers, GetNumSubgroupMembers
local IsInRaid, IsInGroup, GetTime = IsInRaid, IsInGroup, GetTime
local tinsert, twipe = table.insert, table.wipe

local playerId

local spells = {}
local groupUnits = {}
local frameBuffers = {}
local frameGroups = {5, 25, 40}

local healGlowFrame
local healGlowTime

local function ShowHealGlows(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < .1 then return end
	self.elapsed = 0

	local currentTime = GetTime(), expireTime
	for k, unit in pairs(groupUnits) do
		expireTime = unit[2] + healGlowTime
		for _, index in ipairs(frameGroups) do
				for _, frame in pairs(frameBuffers[index]) do			
					if frame.unit == unit[1] then
						frame.HealGlow:SetShown(currentTime < expireTime)
					end
				end	
		end
	end	
end

function HG:SetupVariables()
	HG:UnregisterEvent("PLAYER_ENTERING_WORLD")

	playerId = UnitGUID('player')
	
	for _, spellID in ipairs({
		-- Druid
		81269, -- Wild Mushroom
		-- Monk
		130654, -- Chi Burst
		124040, -- Chi Torpedo
		115106, -- Chi Wave
		115464, -- Healing Sphere
		116670, -- Uplift
		-- Paladin
		114852, -- Holy Prism (enemy target)
		114871, -- Holy Prism (friendly target)
		82327,  -- Holy Radiance
		85222,  -- Light of Dawn
		121129, -- Daybreak
		-- Priest
		121148, -- Cascade
		34861,  -- Circle of Healing
		64844,  -- Divine Hymn
		110745, -- Divine Star (holy version)
		122128, -- Divine Star (shadow version)
		120692, -- Halo (holy version)
		120696, -- Halo (shadow version)
		23455,  -- Holy Nova
		596,    -- Prayer of Healing
		-- Shaman
		1064,   -- Chain Heal	
	}) do
		local name, _, icon = GetSpellInfo(spellID)
		if name then
			spells[name] = { spellID, icon }
		end
	end


	twipe(frameBuffers)
	for _, index in ipairs(frameGroups) do
		frameBuffers[index] = {}
		for i=1, (index/5) do
			for j=1, 5 do
				frame = (index == 5 and _G[("ElvUF_PartyGroup%dUnitButton%i"):format(i, j)] or index == 25 and _G[("ElvUF_RaidGroup%dUnitButton%i"):format(i, j)] or _G[("ElvUF_Raid%dGroup%dUnitButton%i"):format(index, i, j)])
				if frame then
					frame.HealGlow = UF:Construct_HealGlow(frame, ((index == 5 and 'party%d' or index == 25 and 'raid' or 'raid%d')):format(i))
					tinsert(frameBuffers[index], frame)		
				end
			end
		end
	end

	healGlowFrame = CreateFrame("Frame")
	healGlowFrame:SetScript("OnEvent", function(self, event, ...)
		if (event=="COMBAT_LOG_EVENT_UNFILTERED") then
	  	local _, event, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, spellName = select(1, ...)
	  	
			if not (sourceGUID == playerId and event == "SPELL_HEAL" and spells[spellName]) then
				return
			end
			
			if groupUnits[destGUID] then
				groupUnits[destGUID][2] = GetTime()
			end
	  end
	end)

	HG:UpdateSettings()
end

function HG:UpdateSettings()
	local color = E.db.unitframe.glowcolor

	for _, index in ipairs(frameGroups) do
		for _, frame in ipairs(frameBuffers[index]) do
			frame.HealGlow:SetBackdropBorderColor(color.r , color.g, color.b)
		end
	end
	
	healGlowTime = E.db.unitframe.glowtime

	if E.db.unitframe.healglow then
		healGlowFrame:SetScript("OnUpdate", ShowHealGlows)
		healGlowFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		healGlowFrame:SetScript("OnUpdate", nil)
		healGlowFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

function HG:GroupRosterUpdate()
    twipe(groupUnits)

    -- GetNumSubgroupMembers() automatically handles the 1-4 party convention, excluding 'player', GetNumGroupMembers() includes player
    local numMembers = IsInRaid() and GetNumRaidMembers() or IsInGroup() and GetNumGroupMembers() or 0
    local groupName = IsInRaid() and "raid%d" or IsInGroup() and "party%d" or "solo"
    local unit
    for index = 1, numMembers do
        unit = (groupName):format(index)
        if not UnitIsUnit(unit, "player") then
            groupUnits[UnitGUID(unit)] = { unit, 0 }
        end
    end
    if groupName == "solo" then
    	groupUnits[UnitGUID('player')] = { 'player', 0 }
    end
end

function HG:Initialize()
	if not E.private["unitframe"].enable then return end

	HG:RegisterEvent("PLAYER_ENTERING_WORLD", "SetupVariables")
	HG:RegisterEvent("GROUP_ROSTER_UPDATE", "GroupRosterUpdate")
end

E:RegisterModule(HG:GetName())
