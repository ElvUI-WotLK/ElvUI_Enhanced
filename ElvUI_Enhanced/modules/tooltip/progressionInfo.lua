local E, L, V, P, G = unpack(ElvUI)
local PI = E:NewModule("Enhanced_ProgressionInfo", "AceHook-3.0", "AceEvent-3.0")
local TT = E:GetModule("Tooltip")

local find, format = string.find, string.format
local pairs, ipairs, select, tonumber = pairs, ipairs, select, tonumber

local CanInspect = CanInspect
local ClearAchievementComparisonUnit = ClearAchievementComparisonUnit
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
	"TotC",
	"Ulduar",
}

local difficulties = {
	"H25",
	"H10",
	"N25",
	"N10",
}

local bosses = {
	{ -- Ruby Sanctum
		{ -- Herioc 25
			4823,
		},
		{ -- Herioc 10
			4822,
		},
		{ -- Normal 25
			4820,
		},
		{ -- Normal 10
			4821,
		},
	},
	{ -- Icecrown Citadel
		{ -- Herioc 25
			4642, 4656, 4661, 4664, 4667, 4670, 4673, 4676, 4679, 4682, 4685, 4688
		},
		{ -- Herioc 10
			4640, 4654, 4659, 4662, 4665, 4668, 4671, 4674, 4677, 4680, 4684, 4686
		},
		{ -- Normal 25
			4641, 4655, 4660, 4663, 4666, 4669, 4672, 4675, 4678, 4681, 4683, 4687
		},
		{ -- Normal 10
			4639, 4643, 4644, 4645, 4646, 4647, 4648, 4649, 4650, 4651, 4652, 4653
		},
	},
	{ -- Trial of the Crusader
		{ -- Herioc 25
			4029, 4035, 4039, 4043, 4047
		},
		{ -- Herioc 10
			4030, 4033, 4037, 4041, 4045
		},
		{ -- Normal 25
			4031, 4034, 4038, 4042, 4046
		},
		{ -- Normal 10
			4028, 4032, 4036, 4040, 4044
		},
	},
	{ -- Ulduar
		{},
		{},
		{ -- Normal 25
			2872, 2873, 2874, 2884, 2885, 2875, 2882, 3256, 3257, 3258, 2879, 2880, 2883, 2881
		},
		{ -- Normal 10
			2856, 2857, 2858, 2859, 2860, 2861, 2868, 2862, 2863, 2864, 2865, 2866, 2869, 2867
		},
	},
}

local playerGUID = UnitGUID("player")
local progressCache = {}
local highest = 0

local function GetEntryCount(tab)
	local i = 0
	for _, _ in pairs(tab) do
		i = i + 1
	end
	return i
end

local function GetProgression(guid)
	local statFunc = guid == playerGUID and GetStatistic or GetComparisonStatistic
	local total, kills, killed

	for i, tier in ipairs(tiers) do
		progressCache[guid].header[i] = {}
		progressCache[guid].info[i] = {}

		for j, difficulty in ipairs(difficulties) do
			if GetEntryCount(bosses[i][j]) > 0 then
				total, killed = 0, 0

				for _, achievmentID in ipairs(bosses[i][j]) do
					kills = tonumber(statFunc(achievmentID))
					total = total + 1

					if kills and kills > 0 then
						killed = killed + 1
					end
				end

				if (killed > 0) then
					progressCache[guid].header[i][j] = format("%s [%s]:", tier, difficulty)
					progressCache[guid].info[i][j] = format("%d/%d", killed, total)

					if killed == total then
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
				if E.db.enhanced.tooltip.progressInfo.tiers[i] then
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
		end

		if updated == 1 then return end

		if highest > 0 then tt:AddLine(" ") end

		for tier = 1, #tiers do
			if E.db.enhanced.tooltip.progressInfo.tiers[tier] then
				for difficulty = 1, #difficulties do
					if GetEntryCount(bosses[tier][difficulty]) > 0 then
						tt:AddDoubleLine(progressCache[guid].header[tier][difficulty], progressCache[guid].info[tier][difficulty], nil, nil, nil, 1, 1, 1)
					end
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
	if not unit then return end

	if unit == "player" and not E.db.enhanced.tooltip.progressInfo.checkPlayer then return end

	local level = UnitLevel(unit)
	if not level or level < MAX_PLAYER_LEVEL then return end

	if not (CanInspect(unit, false)) then return end

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
	if E.db.enhanced.tooltip.progressInfo.enable then
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
	if not E.db.enhanced.tooltip.progressInfo.enable then return end

	self:ToggleState()
end

E:RegisterModule(PI:GetName())