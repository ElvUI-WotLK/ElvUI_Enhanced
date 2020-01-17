local E, L, V, P, G = unpack(ElvUI)
local PI = E:NewModule("Enhanced_ProgressionInfo", "AceHook-3.0", "AceEvent-3.0")
local TT = E:GetModule("Tooltip")

local pairs, ipairs, select, tonumber = pairs, ipairs, select, tonumber
local format = string.format
local twipe = table.wipe

local CanInspect = CanInspect
local ClearAchievementComparisonUnit = ClearAchievementComparisonUnit
local GetAchievementComparisonInfo = GetAchievementComparisonInfo
local GetAchievementInfo = GetAchievementInfo
local GetComparisonStatistic = GetComparisonStatistic
local GetStatistic = GetStatistic
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown
local IsAltKeyDown = IsAltKeyDown
local IsControlKeyDown = IsControlKeyDown
local IsShiftKeyDown = IsShiftKeyDown
local SetAchievementComparisonUnit = SetAchievementComparisonUnit
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitIsPlayer = UnitIsPlayer
local UnitLevel = UnitLevel

local MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL

local difficulties = {"H25", "H10", "N25", "N10"}

local statisticTiers = {
	["RS"] = {
		{4823},	-- Heroic 25
		{4822},	-- Heroic 10
		{4820},	-- Normal 25
		{4821}	-- Normal 10
	},
	["ICC"] = {
		{4642, 4656, 4661, 4664, 4667, 4670, 4673, 4676, 4679, 4682, 4685, 4688},	-- Heroic 25
		{4640, 4654, 4659, 4662, 4665, 4668, 4671, 4674, 4677, 4680, 4684, 4686},	-- Heroic 10
		{4641, 4655, 4660, 4663, 4666, 4669, 4672, 4675, 4678, 4681, 4683, 4687},	-- Normal 25
		{4639, 4643, 4644, 4645, 4646, 4647, 4648, 4649, 4650, 4651, 4652, 4653}	-- Normal 10
	},
	["ToC"] = {
		{4029, 4035, 4039, 4043, 4047},	-- Heroic 25
		{4030, 4033, 4037, 4041, 4045},	-- Heroic 10
		{4031, 4034, 4038, 4042, 4046},	-- Normal 25
		{4028, 4032, 4036, 4040, 4044}	-- Normal 10
	},
	["Ulduar"] = {
		{},
		{},
		{2872, 2873, 2874, 2884, 2885, 2875, 2882, 3256, 3257, 3258, 2879, 2880, 2883, 2881},	-- Normal 25
		{2856, 2857, 2858, 2859, 2860, 2861, 2868, 2862, 2863, 2864, 2865, 2866, 2869, 2867}	-- Normal 10
	}
}

local achievementTiers = {
	["RS"] = {
		{	-- Heroic 25
			4816	-- [1] Heroic: The Twilight Destroyer
		},
		{	-- Heroic 10
			4818	-- [1] Heroic: The Twilight Destroyer
		},
		{	-- Normal 25
			4815	-- [1] The Twilight Destroyer
		},
		{	-- Normal 10
			4817	-- [1] The Twilight Destroyer
		}
	},
	["ICC"] = {
		{	-- Heroic 25
		--	[0] = 4637,	-- [12] Heroic: Fall of the Lich King
			4632,	-- [4] Heroic: Storming the Citadel
			4633,	-- [3] Heroic: The Plagueworks
			4634,	-- [2] Heroic: The Crimson Hall
			4635,	-- [2] Heroic: The Frostwing Halls
			4584	-- [1] The Light of Dawn
		},
		{	-- Heroic 10
		--	[0] = 4636,	-- [12] Heroic: Fall of the Lich King
			4628,	-- [4] Heroic: Storming the Citadel
			4629,	-- [3] Heroic: The Plagueworks
			4630,	-- [2] Heroic: The Crimson Hall
			4631,	-- [2] Heroic: The Frostwing Halls
			4583	-- [1] Bane of the Fallen King
		},
		{	-- Normal 25
		--	[0] = 4608,	-- [12] Fall of the Lich King
			4604,	-- [4] Storming the Citadel
			4605,	-- [3] The Plagueworks
			4606,	-- [2] The Crimson Hall
			4607,	-- [2] The Frostwing Halls
			4597	-- [1] The Frozen Throne
		},
		{	-- Normal 10
		--	[0] = 4532,	-- [12] Fall of the Lich King
			4531,	-- [4] Storming the Citadel
			4528,	-- [3] The Plagueworks
			4529,	-- [2] The Crimson Hall
			4527,	-- [2] The Frostwing Halls
			4530	-- [1] The Frozen Throne
		}
	},
	["ToC"] = {
		{	-- Heroic 25
			3812	-- [5] Call of the Grand Crusade
		},
		{	-- Heroic 10
			3918	-- [5] Call of the Grand Crusade
		},
		{	-- Normal 25
			3916	-- [5] Call of the Crusade
		},
		{	-- Normal 10
			3917	-- [5] Call of the Crusade
		}
	},
	["Ulduar"] = {
		{},
		{},
		{	-- Normal 25
		--	[0] = 2895,	-- [13] The Secrets of Ulduar
			2887,	-- [4] The Siege of Ulduar
			2889,	-- [3] The Antechamber of Ulduar
			2891,	-- [4] The Keepers of Ulduar
			2893,	-- [2] The Descent into Madness
			3037	-- [1] Observed
		},
		{	-- Normal 10
		--	[0] = 2894,		-- [13] The Secrets of Ulduar
			2886,	-- [4] The Siege of Ulduar
			2888,	-- [3] The Antechamber of Ulduar
			2890,	-- [4] The Keepers of Ulduar
			2892,	-- [2] The Descent into Madness
			3036	-- [1] Observed
		}
	}
}

local progressCache = {}

--[[
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria

local function getAchievementProgress(achievementID, criteriaInfo)
	local progress = 0

	for i = 1, GetAchievementNumCriteria(achievementID) do
		local _, _, completed = GetAchievementCriteriaInfo(achievementID, i)

		if completed then
			progress = progress + 1
		end
	end

	return progress
end
]]

local function isAchievementComplete(achievementID)
	return (select(4, GetAchievementInfo(achievementID))) and 1 or 0
end

local function isAchievementComparisonComplete(achievementID)
	return (GetAchievementComparisonInfo(achievementID)) and 1 or 0
end

local function GetProgression(guid)
	local total, kills, killed, tierName
	local statFunc, tiers

	if E.db.enhanced.tooltip.progressInfo.checkAchievements then
		statFunc = guid == E.myguid and isAchievementComplete or isAchievementComparisonComplete
		tiers = achievementTiers
	else
		statFunc = guid == E.myguid and GetStatistic or GetComparisonStatistic
		tiers = statisticTiers
	end

	local header = progressCache[guid].header
	local info = progressCache[guid].info

	for tier in pairs(tiers) do
		header[tier] = header[tier] and twipe(header[tier]) or {}
		info[tier] = info[tier] and twipe(info[tier]) or {}

		for i, difficulty in ipairs(difficulties) do
			if #tiers[tier][i] > 0 then
				total = #tiers[tier][i]
				killed = 0

				for _, statsID in ipairs(tiers[tier][i]) do
					kills = tonumber(statFunc(statsID))

					if kills and kills > 0 then
						killed = killed + 1
					end
				end

				if killed > 0 then
					tierName = tier
					if i <= 2 and tier == "ToC" then
						tierName = "ToGC"
					end

					header[tier][i] = format("%s [%s]:", L[tierName], difficulty)
					info[tier][i] = format("%d/%d", killed, total)

					if killed == total then
						break
					end
				end
			end
		end
	end
end

local function UpdateProgression(guid)
	if not progressCache[guid] then
		progressCache[guid] = {
			header = {},
			info = {},
		}
	end

	progressCache[guid].timer = GetTime()

	GetProgression(guid)
end

local function SetProgressionInfo(guid, tt)
	if not progressCache[guid] then return end

	local tiers = E.db.enhanced.tooltip.progressInfo.checkAchievements and achievementTiers or statisticTiers

	for tier in pairs(tiers) do
		if E.db.enhanced.tooltip.progressInfo.tiers[tier] then
			for i = 1, #difficulties do
				if #tiers[tier][i] > 0 then
					tt:AddDoubleLine(progressCache[guid].header[tier][i], progressCache[guid].info[tier][i], nil, nil, nil, 1, 1, 1)
				end
			end
		end
	end
end

local function ShowInspectInfo(tt)
	if InCombatLockdown() then return end

	local modifier = E.db.enhanced.tooltip.progressInfo.modifier
	if modifier ~= "ALL" and not ((modifier == "SHIFT" and IsShiftKeyDown()) or (modifier == "CTRL" and IsControlKeyDown()) or (modifier == "ALT" and IsAltKeyDown())) then return end

	local unit = select(2, tt:GetUnit())
	if unit == "player" then
		if not E.db.enhanced.tooltip.progressInfo.checkPlayer then return end

		UpdateProgression(E.myguid)
		SetProgressionInfo(E.myguid, tt)
		return
	end

	if not unit or not UnitIsPlayer(unit) then return end

	local level = UnitLevel(unit)
	if not level or level < MAX_PLAYER_LEVEL then return end

	if not CanInspect(unit, false) then return end

	local guid = UnitGUID(unit)
	local frameShowen = AchievementFrame and AchievementFrame:IsShown()

	if progressCache[guid] and (frameShowen or (GetTime() - progressCache[guid].timer) < 600) then
		SetProgressionInfo(guid, tt)
	elseif not frameShowen then
		PI.compareGUID = guid

		PI:RegisterEvent("INSPECT_ACHIEVEMENT_READY")

		if AchievementFrameComparison then
			AchievementFrameComparison:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		end

		ClearAchievementComparisonUnit()
		SetAchievementComparisonUnit(unit)
	end
end

function PI:INSPECT_ACHIEVEMENT_READY()
	UpdateProgression(self.compareGUID)
	ClearAchievementComparisonUnit()

	if UnitExists("mouseover") and UnitGUID("mouseover") == self.compareGUID then
		GameTooltip:SetUnit("mouseover")
	end

	self:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")

	if AchievementFrameComparison then
		AchievementFrameComparison:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
	end

	self.compareGUID = nil
end

function PI:MODIFIER_STATE_CHANGED(_, key)
	if (key == format("L%s", self.modifier) or key == format("R%s", self.modifier)) and UnitExists("mouseover") then
		GameTooltip:SetUnit("mouseover")
	end
end

function PI:UpdateSettings()
	local enabled

	for _, state in pairs(E.db.enhanced.tooltip.progressInfo.tiers) do
		if state then
			enabled = state
			break
		end
	end

	if enabled then
		self:ToggleState()
	else
		self:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
		self:UnhookAll()
	end
end

function PI:UpdateModifier()
	self.modifier = E.db.enhanced.tooltip.progressInfo.modifier

	if self.modifier == "ALL" then
		self:UnregisterEvent("MODIFIER_STATE_CHANGED")
	else
		self:RegisterEvent("MODIFIER_STATE_CHANGED")
	end
end

function PI:ToggleState()
	if E.db.enhanced.tooltip.progressInfo.enable then
		if E.private.tooltip.enabled and TT then
			if not self:IsHooked(TT, "GameTooltip_OnTooltipSetUnit", ShowInspectInfo) then
				self:SecureHook(TT, "GameTooltip_OnTooltipSetUnit", ShowInspectInfo)
			end
		else
			if not self:IsHooked(GameTooltip, "OnTooltipSetUnit", ShowInspectInfo) then
				self:HookScript(GameTooltip, "OnTooltipSetUnit", ShowInspectInfo)
			end
		end

		self:UpdateModifier()
	else
		self:UnregisterAllEvents()
		self:UnhookAll()
	end
end

function PI:Initialize()
	if not E.db.enhanced.tooltip.progressInfo.enable then return end

	self.progressCache = progressCache
	self:ToggleState()
end

local function InitializeCallback()
	PI:Initialize()
end

E:RegisterModule(PI:GetName(), InitializeCallback)