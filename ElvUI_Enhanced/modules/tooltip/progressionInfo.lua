local E, L, V, P, G = unpack(ElvUI)
local PI = E:NewModule("Enhanced_ProgressionInfo", "AceHook-3.0", "AceEvent-3.0")
local TT = E:GetModule("Tooltip")

local find, format = string.find, string.format
local pairs, ipairs, select, tonumber = pairs, ipairs, select, tonumber

local CanInspect = CanInspect
local ClearAchievementComparisonUnit = ClearAchievementComparisonUnit
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria
local GetComparisonStatistic = GetComparisonStatistic
local GetStatistic = GetStatistic
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown
local SetAchievementComparisonUnit = SetAchievementComparisonUnit
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel

local MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL

local tiers = {
	"RS",
	"ICC",
	"TOTC",
	"Ulduar",
}

local difficulties = {
	"H25",
	"H10",
	"N25",
	"N10",
--[[
	"Heroic 25",
	"Heroic 10",
	"Normal 25",
	"Normal 10",
]]
}

local bosses = {
	-- http://wotlk.openwow.com/achievement=ID
	{ -- Ruby Sanctum
		{ -- Herioc 25
			[4816] = true,
		},
		{ -- Herioc 10
			[4818] = true,
		},
		{ -- Normal 25
			[4815] = true,
		},
		{ -- Normal 10
			[4817] = true,
		},
	},
	{ -- Icecrown Citadel
		{ -- Herioc 25
			[4632] = false,
			[4633] = false,
			[4634] = false,
			[4635] = false,
			[4584] = true,
		},
		{ -- Herioc 10
			[4628] = false,
			[4629] = false,
			[4630] = false,
			[4631] = false,
			[4583] = true,
		},
		{ -- Normal 25
			[4604] = false,
			[4605] = false,
			[4606] = false,
			[4607] = false,
			[4597] = true,
		},
		{ -- Normal 10
			[4531] = false,
			[4528] = false,
			[4529] = false,
			[4527] = false,
			[4530] = true,
		},
	},
	{ -- Trial of the Crusader
		{ -- Herioc 25
			[3812] = false,
		},
		{ -- Herioc 10
			[3918] = false,
		},
		{ -- Normal 25
			[3916] = false,
		},
		{ -- Normal 10
			[3917] = false,
		},
	},
	{ -- Ulduar
		{},
		{},
		{ -- Normal 25
			[2887] = false,
			[2889] = false,
			[2891] = false,
			[2893] = false,
			[3037] = true,
		},
		{ -- Normal 10
			[2886] = false,
			[2888] = false,
			[2890] = false,
			[2892] = false,
			[3036] = true,
		},
	},
}

local playerGUID = UnitGUID("player")
local progressCache = {}
local highest = 0

local function GetBossCount(achID, isBoss, func)
	local kills = 0
	local total, killed

	if isBoss then
		kills = func(achID)
		total = kills
	else
		total = GetAchievementNumCriteria(achID)

		for i = 1, total do
			killed = select(3, GetAchievementCriteriaInfo(achID, i))

			if killed then
				kills = kills + 1
			end
		end
	end

	return total and tonumber(total) or 0, kills and tonumber(kills) or 0
end

local function GetEntryCount(tab)
	local i = 0
	for _, _ in pairs(tab) do
		i = i + 1
	end
	return i
end

local function GetProgression(guid)
	local statFunc = guid == playerGUID and GetStatistic or GetComparisonStatistic
	local bossNum, total, kills, pos

	for i, tier in ipairs(tiers) do
		progressCache[guid].header[i] = {}
		progressCache[guid].info[i] = {}

		for j, difficulty in ipairs(difficulties) do
			if GetEntryCount(bosses[i][j]) > 0 then
				highest = 0
				bossNum = 0

				for achievmentID, isBoss in pairs(bosses[i][j]) do
					total, kills = GetBossCount(achievmentID, isBoss, statFunc)
					bossNum = bossNum + total

					if kills and kills > 0 then
						highest = highest + kills
					end
				end

				pos = highest

				if (highest > 0) then
					progressCache[guid].header[i][j] = format("%s [%s]:", tier, difficulty)
					progressCache[guid].info[i][j] = format("%d/%d", highest, bossNum)

					if highest == bossNum then
						break
					end
				end
			end
		end
	end
end

local function UpdateProgression(guid)
	progressCache[guid] = progressCache[guid] or {}
	progressCache[guid].header = progressCache[guid].header or {}
	progressCache[guid].info = progressCache[guid].info or {}
	progressCache[guid].timer = GetTime()

	GetProgression(guid)
end

local function SetProgressionInfo(guid, tt)
	if progressCache[guid] then
		local updated = 0

		for i = 1, tt:NumLines() do
			local leftTipText = _G["GameTooltipTextLeft"..i]

			for i, tier in ipairs(tiers) do
				for j, difficulty in ipairs(difficulties) do
					if GetEntryCount(bosses[i][j]) > 0 then
						if (leftTipText:GetText() and find(leftTipText:GetText(), tier) and find(leftTipText:GetText(), difficulty)) then
							local rightTipText = _G["GameTooltipTextRight"..i]
							leftTipText:SetText(progressCache[guid].header[i][j])
							rightTipText:SetText(progressCache[guid].info[i][j])
							updated = 1
						end
					end
				end
			end
		end

		if updated == 1 then return end

		if highest > 0 then tt:AddLine(" ") end

		for tier = 1, #tiers do
			for difficulty = 1, #difficulties do
				if GetEntryCount(bosses[tier][difficulty]) > 0 then
					tt:AddDoubleLine(progressCache[guid].header[tier][difficulty], progressCache[guid].info[tier][difficulty], nil, nil, nil, 1, 1, 1)
				end
			end
		end
	end
end

function PI:INSPECT_ACHIEVEMENT_READY(GUID)
	local unit = "mouseover"
	if UnitExists(unit) then
		UpdateProgression(GUID)
		GameTooltip:SetUnit(unit)
	end

	ClearAchievementComparisonUnit()
	self:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
end

local function ShowInspectInfo(tt)
	if InCombatLockdown() then return end

	local unit = select(2, tt:GetUnit())
	local level = UnitLevel(unit)

	if not level or level < MAX_PLAYER_LEVEL then return end
	if not (unit and CanInspect(unit, false)) then return end

	local guid = UnitGUID(unit)

	if not progressCache[guid] or (GetTime() - progressCache[guid].timer) > 600 then
		if guid == playerGUID then
			UpdateProgression(guid)
		else
			local self = E.private.tooltip.enable and TT or GameTooltip

			ClearAchievementComparisonUnit()

			if not self.loadedComparison and select(2, IsAddOnLoaded("Blizzard_AchievementUI")) then
				AchievementFrame_DisplayComparison(unit)
				HideUIPanel(AchievementFrame)
				ClearAchievementComparisonUnit()
				self.loadedComparison = true
			end

			self.compareGUID = guid

			if SetAchievementComparisonUnit(unit) then
				PI:RegisterEvent("INSPECT_ACHIEVEMENT_READY", "INSPECT_ACHIEVEMENT_READY", self.compareGUID)
			end
			return
		end
	end

	SetProgressionInfo(guid, tt)
end

function PI:ToggleState()
	if E.db.enhanced.tooltip.progressInfo then
		if E.private.tooltip.enabled and TT then
			if not self:IsHooked(TT, "ShowInspectInfo", ShowInspectInfo) then
				self:SecureHook(TT, "ShowInspectInfo", ShowInspectInfo)
			end
		else
			if not self:IsHooked(GameTooltip, "OnTooltipSetUnit", ShowInspectInfo) then
				self:HookScript(GameTooltip, "OnTooltipSetUnit", ShowInspectInfo)
			end
		end
	else
		self:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		self:UnhookAll()
	end
end

function PI:Initialize()
	if not E.db.enhanced.tooltip.progressInfo then return end

	self:ToggleState()
end

E:RegisterModule(PI:GetName())