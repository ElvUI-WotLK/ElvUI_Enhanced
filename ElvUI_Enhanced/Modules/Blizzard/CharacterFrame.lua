local E, L, V, P, G = unpack(ElvUI)
local module = E:NewModule("Enhanced_CharacterFrame", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")

local _G = _G
local select, next, ipairs, pairs, tonumber, getmetatable = select, next, ipairs, pairs, tonumber, getmetatable
local abs, floor, max, min = math.abs, math.floor, math.max, math.min
local find, format, gmatch, lower, sub, trim = string.find, string.format, string.gmatch, string.lower, string.sub, string.trim
local tconcat, tinsert, tremove, sort, wipe = table.concat, table.insert, table.remove, table.sort, table.wipe

local CreateFrame = CreateFrame
local GetActiveTalentGroup = GetActiveTalentGroup
local GetAttackPowerForStat = GetAttackPowerForStat
local GetBlockChance = GetBlockChance
local GetCombatRating = GetCombatRating
local GetCombatRatingBonus = GetCombatRatingBonus
local GetCompanionCooldown = GetCompanionCooldown
local GetCompanionInfo = GetCompanionInfo
local GetCritChance = GetCritChance
local GetCritChanceFromAgility = GetCritChanceFromAgility
local GetCurrentTitle = GetCurrentTitle
local GetCursorPosition = GetCursorPosition
local GetDodgeChance = GetDodgeChance
local GetEquipmentSetInfo = GetEquipmentSetInfo
local GetEquipmentSetInfoByName = GetEquipmentSetInfoByName
local GetInventoryItemLink = GetInventoryItemLink
local GetItemInfo = GetItemInfo
local GetMaxCombatRatingBonus = GetMaxCombatRatingBonus
local GetNumCompanions = GetNumCompanions
local GetNumEquipmentSets = GetNumEquipmentSets
local GetNumTitles = GetNumTitles
local GetParryChance = GetParryChance
local GetScreenHeightScale = GetScreenHeightScale
local GetShieldBlock = GetShieldBlock
local GetSpellCritChanceFromIntellect = GetSpellCritChanceFromIntellect
local GetTitleName = GetTitleName
local GetUnitHealthModifier = GetUnitHealthModifier
local GetUnitHealthRegenRateFromSpirit = GetUnitHealthRegenRateFromSpirit
local GetUnitManaRegenRateFromSpirit = GetUnitManaRegenRateFromSpirit
local GetUnitMaxHealthModifier = GetUnitMaxHealthModifier
local GetUnitPowerModifier = GetUnitPowerModifier
local HasPetUI = HasPetUI
local IsTitleKnown = IsTitleKnown
local PlaySound = PlaySound
local SetPortraitTexture = SetPortraitTexture
local UnitAttackSpeed = UnitAttackSpeed
local UnitClass = UnitClass
local UnitDamage = UnitDamage
local UnitHasMana = UnitHasMana
local UnitHasRelicSlot = UnitHasRelicSlot
local UnitLevel = UnitLevel
local UnitRace = UnitRace
local UnitResistance = UnitResistance
local UnitStat = UnitStat

local CharacterRangedDamageFrame_OnEnter = CharacterRangedDamageFrame_OnEnter
local CharacterSpellCritChance_OnEnter = CharacterSpellCritChance_OnEnter
local CooldownFrame_SetTimer = CooldownFrame_SetTimer
local GameTooltip_Hide = GameTooltip_Hide
local GearManagerDialogSaveSet_OnClick = GearManagerDialogSaveSet_OnClick
local PaperDollFrameItemPopoutButton_HideAll = PaperDollFrameItemPopoutButton_HideAll
local PaperDollFrameItemPopoutButton_ShowAll = PaperDollFrameItemPopoutButton_ShowAll
local PaperDollFrame_ClearIgnoredSlots = PaperDollFrame_ClearIgnoredSlots
local PaperDollFrame_SetArmor = PaperDollFrame_SetArmor
local PaperDollFrame_SetAttackPower = PaperDollFrame_SetAttackPower
local PaperDollFrame_SetAttackSpeed = PaperDollFrame_SetAttackSpeed
local PaperDollFrame_SetDamage = PaperDollFrame_SetDamage
local PaperDollFrame_SetDefense = PaperDollFrame_SetDefense
local PaperDollFrame_SetExpertise = PaperDollFrame_SetExpertise
local PaperDollFrame_SetManaRegen = PaperDollFrame_SetManaRegen
local PaperDollFrame_SetRangedAttackPower = PaperDollFrame_SetRangedAttackPower
local PaperDollFrame_SetRangedAttackSpeed = PaperDollFrame_SetRangedAttackSpeed
local PaperDollFrame_SetRangedCritChance = PaperDollFrame_SetRangedCritChance
local PaperDollFrame_SetRangedDamage = PaperDollFrame_SetRangedDamage
local PaperDollFrame_SetRating = PaperDollFrame_SetRating
local PaperDollFrame_SetSpellBonusDamage = PaperDollFrame_SetSpellBonusDamage
local PaperDollFrame_SetSpellBonusHealing = PaperDollFrame_SetSpellBonusHealing
local PaperDollFrame_SetSpellCritChance = PaperDollFrame_SetSpellCritChance
local PaperDollFrame_SetSpellHaste = PaperDollFrame_SetSpellHaste
local PetPaperDollFrameCompanionFrame = PetPaperDollFrameCompanionFrame
local PetPaperDollFrame_FindCompanionIndex = PetPaperDollFrame_FindCompanionIndex

local GearManagerDialog = GearManagerDialog

local ARMOR_PER_AGILITY = ARMOR_PER_AGILITY
local BLOCK_CHANCE = BLOCK_CHANCE
local BLOCK_PER_STRENGTH = BLOCK_PER_STRENGTH
local CR_BLOCK = CR_BLOCK
local CR_BLOCK_TOOLTIP = CR_BLOCK_TOOLTIP
local CR_CRIT_MELEE = CR_CRIT_MELEE
local CR_CRIT_MELEE_TOOLTIP = CR_CRIT_MELEE_TOOLTIP
local CR_CRIT_TAKEN_MELEE = CR_CRIT_TAKEN_MELEE
local CR_CRIT_TAKEN_RANGED = CR_CRIT_TAKEN_RANGED
local CR_CRIT_TAKEN_SPELL = CR_CRIT_TAKEN_SPELL
local CR_DODGE = CR_DODGE
local CR_DODGE_TOOLTIP = CR_DODGE_TOOLTIP
local CR_HIT_MELEE = CR_HIT_MELEE
local CR_HIT_RANGED = CR_HIT_RANGED
local CR_HIT_SPELL = CR_HIT_SPELL
local CR_PARRY = CR_PARRY
local CR_PARRY_TOOLTIP = CR_PARRY_TOOLTIP
local DAMAGE_PER_SECOND = DAMAGE_PER_SECOND
local DEFENSE = DEFENSE
local DODGE_CHANCE = DODGE_CHANCE
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE
local GREEN_FONT_COLOR = GREEN_FONT_COLOR
local GREEN_FONT_COLOR_CODE = GREEN_FONT_COLOR_CODE
local HEALTH_PER_STAMINA = HEALTH_PER_STAMINA
local HIGHLIGHT_FONT_COLOR_CODE = HIGHLIGHT_FONT_COLOR_CODE
local INVSLOT_BODY = INVSLOT_BODY
local INVSLOT_MAINHAND = INVSLOT_MAINHAND
local MANA_PER_INTELLECT = MANA_PER_INTELLECT
local MANA_REGEN_FROM_SPIRIT = MANA_REGEN_FROM_SPIRIT
local MAX_EQUIPMENT_SETS_PER_PLAYER = MAX_EQUIPMENT_SETS_PER_PLAYER
local MELEE_CRIT_CHANCE = MELEE_CRIT_CHANCE
local NONE = NONE
local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
local PAPERDOLLFRAME_TOOLTIP_FORMAT = PAPERDOLLFRAME_TOOLTIP_FORMAT
local PARRY_CHANCE = PARRY_CHANCE
local PET_BONUS_TOOLTIP_INTELLECT = PET_BONUS_TOOLTIP_INTELLECT
local PET_BONUS_TOOLTIP_RESISTANCE = PET_BONUS_TOOLTIP_RESISTANCE
local PET_BONUS_TOOLTIP_STAMINA = PET_BONUS_TOOLTIP_STAMINA
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local RED_FONT_COLOR_CODE = RED_FONT_COLOR_CODE
local RESILIENCE_CRIT_CHANCE_TO_CONSTANT_DAMAGE_REDUCTION_MULTIPLIER = RESILIENCE_CRIT_CHANCE_TO_CONSTANT_DAMAGE_REDUCTION_MULTIPLIER
local RESILIENCE_CRIT_CHANCE_TO_DAMAGE_REDUCTION_MULTIPLIER = RESILIENCE_CRIT_CHANCE_TO_DAMAGE_REDUCTION_MULTIPLIER
local RESILIENCE_TOOLTIP = RESILIENCE_TOOLTIP
local RESISTANCE_EXCELLENT = RESISTANCE_EXCELLENT
local RESISTANCE_FAIR = RESISTANCE_FAIR
local RESISTANCE_GOOD = RESISTANCE_GOOD
local RESISTANCE_NONE = RESISTANCE_NONE
local RESISTANCE_POOR = RESISTANCE_POOR
local RESISTANCE_TOOLTIP_SUBTEXT = RESISTANCE_TOOLTIP_SUBTEXT
local RESISTANCE_VERYGOOD = RESISTANCE_VERYGOOD
local STAT_ATTACK_POWER = STAT_ATTACK_POWER
local STAT_BLOCK = STAT_BLOCK
local STAT_BLOCK_TOOLTIP = STAT_BLOCK_TOOLTIP
local STAT_DODGE = STAT_DODGE
local STAT_FORMAT = STAT_FORMAT
local STAT_PARRY = STAT_PARRY
local STAT_RESILIENCE = STAT_RESILIENCE

-- GLOBALS: CharacterAmmoSlot, CharacterAttributesFrame, CharacterDamageFrame_OnEnter, CharacterFrame, CharacterFrameCloseButton, CharacterFrameExpandButton, CharacterFrameTab2
-- GLOBALS: CharacterLevelText, CharacterMicroButton, CharacterModelFrame, CharacterNameFrame, CharacterNameText, CharacterResistanceFrame, CharacterSpellBonusDamage_OnEnter
-- GLOBALS: CharacterStatsPane, CharacterStatsPaneScrollBar, CharacterStatsPaneScrollBarScrollDownButton, CharacterStatsPaneScrollBarScrollUpButton, CharacterStatsPaneScrollChild
-- GLOBALS: CompanionModelFrame, CompanionModelFrameRotateLeftButton, CompanionNextPageButton, CompanionPageNumber, CompanionPrevPageButton, CompanionSelectedName
-- GLOBALS: CompanionSummonButton, ComputePetBonus, CreateAnimationGroup, EquipmentManager_EquipSet, GS_Data, GameTooltip, GearManagerDialogPopup, GearManagerToggleButton
-- GLOBALS: GearScore2, GearScore_GetQuality, GearScore_GetScore, HybridScrollFrame_CreateButtons, HybridScrollFrame_GetOffset, HybridScrollFrame_OnLoad, HybridScrollFrame_Update
-- GLOBALS: InspectFrame, InspectModelFrame, PaperDollEquipmentManagerPane, PaperDollEquipmentManagerPaneEquipSet, PaperDollEquipmentManagerPaneSaveSet, PaperDollFormatStat
-- GLOBALS: PaperDollFrame, PaperDollSidebarTab1, PaperDollSidebarTabs, PaperDollStatTooltip, PaperDollTitlesPane, PersonalGearScore, PetAttributesFrame, PetExpBar_Update
-- GLOBALS: PetLevelText, PetModelFrame, PetModelFrameRotateLeftButton, PetNameText, PetPaperDollCloseButton, PetPaperDollCompanionPane, PetPaperDollFrame, PetPaperDollFrameExpBar
-- GLOBALS: PetPaperDollFramePetFrame, PetPaperDollFrame_Update, PetPaperDollFrame_UpdateCompanionCooldowns, PetPaperDollFrame_UpdateTabs, PetResistanceFrame, PlayerTitleFrame
-- GLOBALS: PlayerTitlePickerFrame, SetButtonPulse, SetCVar, StaticPopup_Hide, UIFrameFadeIn, UIFrameFadeOut, hooksecurefunc, table
-- GLOBALS: EQUIPSET_EQUIP, SAVE

local CHARACTERFRAME_EXPANDED_WIDTH = 197

local STATCATEGORY_MOVING_INDENT = 4
local MOVING_STAT_CATEGORY

local PAPERDOLL_SIDEBARS = {
	{
		name = L["Character Stats"],
		frame = "CharacterStatsPane",
		icon = nil,
		texCoords = {0.109375, 0.890625, 0.09375, 0.90625}
	},
	{
		name = L["Titles"],
		frame = "PaperDollTitlesPane",
		icon = "Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDollSidebarTabs",
		texCoords = {0.01562500, 0.53125000, 0.32421875, 0.46093750}
	},
	{
		name = L["Equipment Manager"],
		frame = "PaperDollEquipmentManagerPane",
		icon = "Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDollSidebarTabs",
		texCoords = {0.01562500, 0.53125000, 0.46875000, 0.60546875}
	}
}

local PAPERDOLL_STATINFO = {
	["ITEM_LEVEL"] = {
		updateFunc = function(statFrame, unit) module:ItemLevel(statFrame, unit) end
	},

	["STRENGTH"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 1) end
	},
	["AGILITY"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 2) end
	},
	["STAMINA"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 3) end
	},
	["INTELLECT"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 4) end
	},
	["SPIRIT"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 5) end
	},

	["MELEE_DAMAGE"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetDamage(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterDamageFrame_OnEnter(statFrame) end
	},
	["MELEE_DPS"] = {
		updateFunc = function(statFrame, unit) module:SetMeleeDPS(statFrame, unit) end
	},
	["MELEE_AP"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetAttackPower(statFrame, unit) end
	},
	["MELEE_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetAttackSpeed(statFrame, unit) end
	},
	["HITCHANCE"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetRating(statFrame, CR_HIT_MELEE) end
	},
	["CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) module:SetMeleeCritChance(statFrame, unit) end
	},
	["EXPERTISE"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetExpertise(statFrame, unit) end
	},

	["RANGED_COMBAT1"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedDamage(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterRangedDamageFrame_OnEnter(statFrame) end
	},
	["RANGED_COMBAT2"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedAttackSpeed(statFrame, unit) end
	},
	["RANGED_COMBAT3"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedAttackPower(statFrame, unit) end
	},
	["RANGED_COMBAT4"] = {
		updateFunc = function(statFrame) PaperDollFrame_SetRating(statFrame, CR_HIT_RANGED) end
	},
	["RANGED_COMBAT5"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedCritChance(statFrame, unit) end
	},

	["SPELL_COMBAT1"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetSpellBonusDamage(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterSpellBonusDamage_OnEnter(statFrame) end
	},
	["SPELL_COMBAT2"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetSpellBonusHealing(statFrame, unit) end
	},
	["SPELL_COMBAT3"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetRating(statFrame, CR_HIT_SPELL) end
	},
	["SPELL_COMBAT4"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetSpellCritChance(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterSpellCritChance_OnEnter(statFrame) end
	},
	["SPELL_COMBAT5"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetSpellHaste(statFrame, unit) end
	},
	["SPELL_COMBAT6"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetManaRegen(statFrame, unit) end
	},

	["DEFENSES1"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetArmor(statFrame, unit) end
	},
	["DEFENSES2"] = {
		updateFunc = function(statFrame, unit) if unit ~= "player" then statFrame:Hide() return end PaperDollFrame_SetDefense(statFrame, unit) end
	},
	["DEFENSES3"] = {
		updateFunc = function(statFrame, unit) module:SetDodge(statFrame, unit) end
	},
	["DEFENSES4"] = {
		updateFunc = function(statFrame, unit) module:SetParry(statFrame, unit) end
	},
	["DEFENSES5"] = {
		updateFunc = function(statFrame, unit) module:SetBlock(statFrame, unit) end
	},
	["DEFENSES6"] = {
		updateFunc = function(statFrame, unit) module:SetResilience(statFrame, unit) end
	},

	["ARCANE"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 6) end
	},
	["FIRE"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 2) end
	},
	["FROST"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 4) end
	},
	["NATURE"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 3) end
	},
	["SHADOW"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 5) end
	}
}

local PAPERDOLL_STATCATEGORIES = {
	["ITEM_LEVEL"] = {
		id = 1,
		stats = {
			"ITEM_LEVEL"
		}
	},
	["BASE_STATS"] = {
		id = 2,
		stats = {
			"STRENGTH",
			"AGILITY",
			"STAMINA",
			"INTELLECT",
			"SPIRIT"
		}
	},
	["MELEE_COMBAT"] = {
		id = 3,
		stats = {
			"MELEE_DAMAGE",
			"MELEE_DPS",
			"MELEE_AP",
			"MELEE_ATTACKSPEED",
			"HITCHANCE",
			"CRITCHANCE",
			"EXPERTISE"
		}
	},
	["RANGED_COMBAT"] = {
		id = 4,
		stats = {
			"RANGED_COMBAT1",
			"RANGED_COMBAT2",
			"RANGED_COMBAT3",
			"RANGED_COMBAT4",
			"RANGED_COMBAT5"
		}
	},
	["SPELL_COMBAT"] = {
		id = 5,
		stats = {
			"SPELL_COMBAT1",
			"SPELL_COMBAT2",
			"SPELL_COMBAT3",
			"SPELL_COMBAT4",
			"SPELL_COMBAT5",
			"SPELL_COMBAT6"
		}
	},
	["DEFENSES"] = {
		id = 6,
		stats = {
			"DEFENSES1",
			"DEFENSES2",
			"DEFENSES3",
			"DEFENSES4",
			"DEFENSES5",
			"DEFENSES6"
		}
	},
	["RESISTANCE"] = {
		id = 7,
		stats = {
			"ARCANE",
			"FIRE",
			"FROST",
			"NATURE",
			"SHADOW"
		}
	}
}

local PAPERDOLL_STATCATEGORY_DEFAULTORDER = {
	"ITEM_LEVEL",
	"BASE_STATS",
	"MELEE_COMBAT",
	"RANGED_COMBAT",
	"SPELL_COMBAT",
	"DEFENSES",
	"RESISTANCE"
}

local PETPAPERDOLL_STATCATEGORY_DEFAULTORDER = {
	"BASE_STATS",
	"MELEE_COMBAT",
--	"RANGED_COMBAT",
	"SPELL_COMBAT",
	"DEFENSES",
	"RESISTANCE"
}

local _PLAYER_LEVEL, _PLAYER_LEVEL_NO_SPEC

do
	local locale = GetLocale()

	if locale == "deDE" then
		_PLAYER_LEVEL = "Stufe %s, |c%s%s-%s|r"
		_PLAYER_LEVEL_NO_SPEC = "Stufe %s, |c%s%s|r"
	elseif locale == "esES" or locale == "esMX" then
		_PLAYER_LEVEL = "|c%2$s%4$s %3$s|r de nivel %1$s"
		_PLAYER_LEVEL_NO_SPEC = "|c%2$s%3$s|r de nivel %1$s"
	elseif locale == "frFR" then
		_PLAYER_LEVEL = "|c%2$s%4$s %3$s|r de niveau %1$s"
		_PLAYER_LEVEL_NO_SPEC = "|c%2$s%3$s|r de niveau %1$s"
	elseif locale == "koKR" then
		_PLAYER_LEVEL = "%s 레벨 |c%s%s %s|r"
		_PLAYER_LEVEL_NO_SPEC = "%s 레벨 |c%s%s|r"
	elseif locale == "ruRU" then
		_PLAYER_LEVEL = "|c%2$s%4$s (%3$s)|r %1$s-го уровня"
		_PLAYER_LEVEL_NO_SPEC = "|c%2$s%3$s|r %1$s-го уровня"
	elseif locale == "zhCN" then
		_PLAYER_LEVEL = "等级%s |c%s%s %s|r"
		_PLAYER_LEVEL_NO_SPEC = "等级%s |c%s%s|r"
	elseif locale == "zhTW" then
		_PLAYER_LEVEL = "等級%s|c%s%s%s|r"
		_PLAYER_LEVEL_NO_SPEC = "等級%s|c%s%s|r"
	else
		_PLAYER_LEVEL = "Level %s |c%s%s %s|r"
		_PLAYER_LEVEL_NO_SPEC = "Level %s |c%s%s|r"
	end
end

function module:PaperDollFrame_SetLevel()
	local _, specName = E:GetTalentSpecInfo()
	local classColor = RAID_CLASS_COLORS[E.myclass]
	local classColorString = format("FF%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)

	if specName == NONE then
		CharacterLevelText:SetFormattedText(_PLAYER_LEVEL_NO_SPEC, E.mylevel, classColorString, E.myLocalizedClass)
	else
		CharacterLevelText:SetFormattedText(_PLAYER_LEVEL, E.mylevel, classColorString, specName, E.myLocalizedClass)
	end

	if CharacterLevelText:GetWidth() > 205 then
		if PaperDollSidebarTab1:IsVisible() then
			CharacterLevelText:Point("TOP", CharacterNameText, "BOTTOM", -10, -6)
		else
			CharacterLevelText:Point("TOP", CharacterNameText, "BOTTOM", 10, -6)
		end
	else
		CharacterLevelText:Point("TOP", CharacterNameText, "BOTTOM", 0, -6)
	end
end

function module:PaperDollSidebarTab(button)
	button:Size(33, 35)
	button:SetTemplate("Default")

	button.Icon = button:CreateTexture(nil, "ARTWORK")
	button.Icon:SetInside()
	button.Icon:SetTexture(PAPERDOLL_SIDEBARS[button:GetID()].icon)
	local tcoords = PAPERDOLL_SIDEBARS[button:GetID()].texCoords
	button.Icon:SetTexCoord(tcoords[1], tcoords[2], tcoords[3], tcoords[4])

	button.Hider = button:CreateTexture(nil, "OVERLAY")
	button.Hider:SetTexture(0, 0, 0, 0.8)
	button.Hider:SetInside()

	button.Highlight = button:CreateTexture(nil, "HIGHLIGHT")
	button.Highlight:SetTexture(1, 1, 1, 0.3)
	button.Highlight:SetInside()

	button:SetScript("OnClick", function(self)
		module:PaperDollFrame_SetSidebar(self, self:GetID())
		PlaySound("igMainMenuOption")
	end)

	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(PAPERDOLL_SIDEBARS[self:GetID()].name, 1, 1, 1)
	end)

	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
end

function module:CharacterFrame_Collapse(sizeOnly)
	if self.skinEnabled then
		CharacterFrame.backdrop:Width(341)

		S:SetBackdropHitRect(PaperDollFrame, CharacterFrame.backdrop)
		S:SetBackdropHitRect(PetPaperDollFrame, CharacterFrame.backdrop)
	else
		CharacterFrame:Width(384)

		S:SetBackdropHitRect(PaperDollFrame)
		S:SetBackdropHitRect(PetPaperDollFrame)
	end

	S:SetUIPanelWindowInfo(CharacterFrame, "width")

	if sizeOnly then return end

	CharacterFrame.Expanded = false

	S:SetNextPrevButtonDirection(CharacterFrameExpandButton, "right")

	for i = 1, #PAPERDOLL_SIDEBARS do
		_G[PAPERDOLL_SIDEBARS[i].frame]:Hide()
	end

	PaperDollSidebarTabs:Hide()
end

function module:CharacterFrame_Expand(sizeOnly)
	if self.skinEnabled then
		CharacterFrame.backdrop:Width(341 + CHARACTERFRAME_EXPANDED_WIDTH)

		S:SetBackdropHitRect(PaperDollFrame, CharacterFrame.backdrop)
		S:SetBackdropHitRect(PetPaperDollFrame, CharacterFrame.backdrop)
	else
		CharacterFrame:Width(352 + CHARACTERFRAME_EXPANDED_WIDTH)

		S:SetBackdropHitRect(PaperDollFrame)
		S:SetBackdropHitRect(PetPaperDollFrame)
	end

	S:SetUIPanelWindowInfo(CharacterFrame, "width")

	if sizeOnly then return end

	CharacterFrame.Expanded = true

	S:SetNextPrevButtonDirection(CharacterFrameExpandButton, "left")

	if PaperDollFrame:IsShown() and PaperDollFrame.currentSideBar then
		CharacterStatsPane:Hide()
		PaperDollFrame.currentSideBar:Show()
	else
		CharacterStatsPane:Show()
	end

	self:PaperDollFrame_UpdateSidebarTabs()
	PaperDollSidebarTabs:Show()
end

local StatCategoryFrames = {}

local titanGrip
local qualityColors = {}

do
	for i = 0, 7 do
		qualityColors[i] = {GetItemQualityColor(i)}
	end

	if E.myclass == "WARRIOR" then
		local GetTalentInfo = GetTalentInfo

		local titanGripCheck = CreateFrame("Frame")
		titanGripCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
		titanGripCheck:RegisterEvent("SPELL_UPDATE_USABLE")
		titanGripCheck:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		titanGripCheck:RegisterEvent("CHARACTER_POINTS_CHANGED")
		titanGripCheck:SetScript("OnEvent", function(self, event, ...)
			titanGrip = select(5, GetTalentInfo(2, 27)) == 1

			if event == "PLAYER_ENTERING_WORLD" or event == "SPELL_UPDATE_USABLE" then
				self:UnregisterEvent(event)
			end
		end)
	end
end

--[[
local function OnEvent(event, bagID, slotID)
	if event == "ITEM_UNLOCKED" then
		if not slotID then
			-- equiped item removed
		else
			-- bag item removed
		end
	end
end

local slots = {
	["HeadSlot"] = "INVTYPE_HEAD",
	["NeckSlot"] = "INVTYPE_NECK",
	["ShoulderSlot"] = "INVTYPE_SHOULDER",
	["BackSlot"] = "INVTYPE_CLOAK",
	["ChestSlot"] = "INVTYPE_ROBE",
	["WristSlot"] = "INVTYPE_WRIST",
	["HandsSlot"] = "INVTYPE_HAND",
	["WaistSlot"] = "INVTYPE_WAIST",
	["LegsSlot"] = "INVTYPE_LEGS",
	["FeetSlot"] = "INVTYPE_FEET",
	["Finger0Slot"] = "INVTYPE_FINGER",
	["Finger1Slot"] = "INVTYPE_FINGER",
	["Trinket0Slot"] = "INVTYPE_TRINKET",
	["Trinket1Slot"] = "INVTYPE_TRINKET",
	["MainHandSlot"] = {"INVTYPE_WEAPONMAINHAND", "INVTYPE_2HWEAPON", "INVTYPE_WEAPON"},
	["SecondaryHandSlot"] = {"INVTYPE_WEAPONOFFHAND", "INVTYPE_SHIELD", "INVTYPE_HOLDABLE", "INVTYPE_WEAPON"},
	["RangedSlot"] = {"INVTYPE_RANGED", "INVTYPE_RANGEDRIGHT", "INVTYPE_THROWN", "INVTYPE_RELIC"}
}

local bagsTable = {}

local function sortItemLevel(a, b)
	return a > b
end

local function GetAverageItemLevel()
	local _, itemLink, itemLevel, itemEquipLoc, slotID
	local totalItemLevel, totalEquippedItemLevel = 0, 0
	local items = 16

	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			itemLink = GetContainerItemLink(bag, slot)
			if itemLink then
				_, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
				if itemEquipLoc and itemEquipLoc ~= "" then
					if itemEquipLoc == "INVTYPE_WEAPON" or (titanGrip and itemEquipLoc == "INVTYPE_2HWEAPON") then
						if not bagsTable[itemEquipLoc] then
							bagsTable[itemEquipLoc] = {itemLevel}
						elseif #bagsTable[itemEquipLoc] == 1 then
							bagsTable[itemEquipLoc][2] = itemLevel
							sort(bagsTable[itemEquipLoc], sortItemLevel)
						elseif itemLevel > bagsTable[itemEquipLoc][1] then
							bagsTable[itemEquipLoc][2] = bagsTable[itemEquipLoc][1]
							bagsTable[itemEquipLoc][1] = itemLevel
						elseif itemLevel > bagsTable[itemEquipLoc][2] then
							bagsTable[itemEquipLoc][2] = itemLevel
						end
					else
						if not bagsTable[itemEquipLoc] then
							bagsTable[itemEquipLoc] = itemLevel
						elseif itemLevel > bagsTable[itemEquipLoc] then
							bagsTable[itemEquipLoc] = itemLevel
						end
					end
				end
			end
		end
	end

	local hasMainHandBag, maxBagItemLevel, countBagOffhand
	local hasTwoHandBag = bagsTable["INVTYPE_2HWEAPON"]

	for slotName, itemLoc in pairs(slots) do
		slotID = GetInventorySlotInfo(slotName)
		itemLink = GetInventoryItemLink("player", slotID)

		if itemLink then
			_, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)

			if itemLevel and itemLevel > 0 then
				if type(itemLoc) == "table" then
					local maxLocItemLevel = 0
					for _, bagItemLoc in ipairs(itemLoc) do
						maxBagItemLevel = bagsTable[bagItemLoc]

						if maxBagItemLevel and maxBagItemLevel > maxLocItemLevel then
							maxLocItemLevel = maxBagItemLevel
						end
					end

					maxBagItemLevel = maxLocItemLevel ~= 0 and maxLocItemLevel
				else
					maxBagItemLevel = bagsTable[itemEquipLoc]
				end

				if maxBagItemLevel and maxBagItemLevel > itemLevel then
					totalItemLevel = totalItemLevel + maxBagItemLevel
				else
					totalItemLevel = totalItemLevel + itemLevel
				end

				totalEquippedItemLevel = totalEquippedItemLevel + itemLevel

				if slotName == "MainHandSlot" and (itemEquipLoc ~= "INVTYPE_2HWEAPON" or titanGrip) then
					items = 17
					countBagOffhand = true
				end
			end
		else
			if type(itemLoc) == "table" then
				local maxLocItemLevel = 0

				if slotName == "SecondaryHandSlot" then
					if titanGrip then
						maxLocItemLevel = bagsTable["INVTYPE_2HWEAPON"]
					end

					if not titanGrip or maxLocItemLevel < bagsTable["INVTYPE_WEAPON"] then
						maxLocItemLevel = bagsTable["INVTYPE_WEAPON"]
					end
				end

				for _, bagItemLoc in ipairs(itemLoc) do
					maxBagItemLevel = bagsTable[bagItemLoc]

					if maxBagItemLevel and maxBagItemLevel > maxLocItemLevel then
						maxLocItemLevel = maxBagItemLevel
					end
				end

				maxBagItemLevel = maxLocItemLevel ~= 0 and maxLocItemLevel
			else
				maxBagItemLevel = bagsTable[itemLoc]
			end

			if maxBagItemLevel and (slotName ~= "SecondaryHandSlot" or countBagOffhand) then
				totalItemLevel = totalItemLevel + maxBagItemLevel
			end

			if slotName == "MainHandSlot" then
				if hasTwoHandBag then
					if maxBagItemLevel then
						if hasTwoHandBag > maxBagItemLevel then
							hasMainHandBag = hasTwoHandBag
						end
					else
						hasMainHandBag = hasTwoHandBag
					end
				end
			end
		end
	end

	wipe(bagsTable)

	if hasMainHandBag then
		totalItemLevel = totalItemLevel + hasMainHandBag
	end

	return (totalItemLevel / 17), (totalEquippedItemLevel / items)
end

local function GetItemLevelColor(unit)
	if not unit then unit = "player" end

	local i = 0
	local sumR, sumG, sumB = 0, 0, 0
	for slotName in pairs(slots) do
		local slotID = GetInventorySlotInfo(slotName)
		if GetInventoryItemTexture(unit, slotID) then
			local itemLink = GetInventoryItemLink(unit, slotID)
			if itemLink then
				local quality = select(3, GetItemInfo(itemLink))
				if quality then
					i = i + 1
					local r, g, b = GetItemQualityColor(quality)
					sumR = sumR + r
					sumG = sumG + g
					sumB = sumB + b
				end
			end
		end
	end

	if i > 0 then
		return (sumR / i), (sumG / i), (sumB / i)
	else
		return 1, 1, 1
	end
end
]]

local function GetAverageItemLevel()
	local items = 16
	local ilvl = 0
	local colorCount, sumR, sumG, sumB = 0, 0, 0, 0

	for slotID = 1, 18 do
		if slotID ~= INVSLOT_BODY then
			local itemLink = GetInventoryItemLink("player", slotID)

			if itemLink then
				local _, _, quality, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)

				if itemLevel then
					ilvl = ilvl + itemLevel

					colorCount = colorCount + 1
					sumR = sumR + qualityColors[quality][1]
					sumG = sumG + qualityColors[quality][2]
					sumB = sumB + qualityColors[quality][3]

					if slotID == INVSLOT_MAINHAND and (itemEquipLoc ~= "INVTYPE_2HWEAPON" or titanGrip) then
						items = 17
					end
				end
			end
		end
	end

	if colorCount == 0 then
		return ilvl / items, 1, 1, 1
	else
		return ilvl / items, (sumR / colorCount), (sumG / colorCount), (sumB / colorCount)
	end
end

function module:SetLabelAndText(statFrame, label, text, isPercentage)
	statFrame.Label:SetFormattedText(STAT_FORMAT, label)
	if isPercentage then
		statFrame.Value:SetFormattedText("%.2F%%", text)
	else
		statFrame.Value:SetText(text)
	end
end

function module:ItemLevel(statFrame, unit)
	if not self.Initialized then return end

	if GearScore_GetScore then
		if not self.gearScore or not GS_PlayerIsInCombat then
			local gearScore = GearScore_GetScore(E.myname, "player")

			if not gearScore then
				if GS_Data and GS_Data[E.myrealm] then
					gearScore = GS_Data[E.myrealm].Players[E.myname].GearScore
				end
			end

			if gearScore then
				local r, b, g = GearScore_GetQuality(gearScore)

				self.gearScore = gearScore
				self.gearScoreR = r
				self.gearScoreG = g
				self.gearScoreB = b

				statFrame.Label:SetText(gearScore)
				statFrame.Label:SetTextColor(r, g, b)

				return
			end
		else
			statFrame.Label:SetText(self.gearScore)
			statFrame.Label:SetTextColor(self.gearScoreR, self.gearScoreG, self.gearScoreB)
			return
		end
	end

--	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
--	if avgItemLevelEquipped == avgItemLevel then
--		statFrame.Label:SetFormattedText("%.2f", avgItemLevelEquipped)
--	else
--		statFrame.Label:SetFormattedText("%.2f / %.2f", avgItemLevelEquipped, avgItemLevel)
--	end
--	statFrame.Label:SetTextColor(GetItemLevelColor())

	local avgItemLevel, r, g, b = GetAverageItemLevel()
	statFrame.Label:SetFormattedText("%.1f", avgItemLevel)
	statFrame.Label:SetTextColor(r, g, b)
end

function module:SetStat(statFrame, unit, statIndex)
	local stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex)
	local statName = _G["SPELL_STAT"..statIndex.."_NAME"]
	statFrame.Label:SetFormattedText(STAT_FORMAT, statName)

	local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, statName).." "
	if posBuff == 0 and negBuff == 0 then
		statFrame.Value:SetText(effectiveStat)
		statFrame.tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE
	else
		tooltipText = tooltipText..effectiveStat
		if posBuff > 0 or negBuff < 0 then
			tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE
		end
		if posBuff > 0 then
			tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE
		end
		if negBuff < 0 then
			tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE
		end
		if posBuff > 0 or negBuff < 0 then
			tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE
		end
		statFrame.tooltip = tooltipText

		if negBuff < 0 then
			statFrame.Value:SetText(RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE)
		else
			statFrame.Value:SetText(GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE)
		end
	end
	statFrame.tooltip2 = _G["DEFAULT_STAT"..statIndex.."_TOOLTIP"]

	if unit == "player" then
		local _, unitClass = UnitClass("player")
		if statIndex == 1 then
			local attackPower = GetAttackPowerForStat(statIndex, effectiveStat)
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower)

			if unitClass == "WARRIOR" or unitClass == "SHAMAN" or unitClass == "PALADIN" then
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(STAT_BLOCK_TOOLTIP, max(0, effectiveStat * BLOCK_PER_STRENGTH - 10))
			end
		elseif statIndex == 3 then
			local baseStam = min(20, effectiveStat)
			local moreStam = effectiveStat - baseStam
			statFrame.tooltip2 = format(statFrame.tooltip2, (baseStam + (moreStam * HEALTH_PER_STAMINA)) * GetUnitMaxHealthModifier("player"))
			local petStam = ComputePetBonus("PET_BONUS_STAM", effectiveStat)

			if petStam > 0 then
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(PET_BONUS_TOOLTIP_STAMINA, petStam)
			end
		elseif statIndex == 2 then
			local attackPower = GetAttackPowerForStat(statIndex, effectiveStat)

			if attackPower > 0 then
				statFrame.tooltip2 = format(STAT_ATTACK_POWER, attackPower)..format(statFrame.tooltip2, GetCritChanceFromAgility("player"), effectiveStat * ARMOR_PER_AGILITY)
			else
				statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("player"), effectiveStat * ARMOR_PER_AGILITY)
			end
		elseif statIndex == 4 then
			local baseInt = min(20, effectiveStat)
			local moreInt = effectiveStat - baseInt

			if UnitHasMana("player") then
				statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt * MANA_PER_INTELLECT, GetSpellCritChanceFromIntellect("player"))
			else
				statFrame.tooltip2 = nil
			end

			local petInt = ComputePetBonus("PET_BONUS_INT", effectiveStat)
			if petInt > 0 then
				if not statFrame.tooltip2 then
					statFrame.tooltip2 = ""
				end

				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(PET_BONUS_TOOLTIP_INTELLECT, petInt)
			end
		elseif statIndex == 5 then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetUnitHealthRegenRateFromSpirit("player"))

			if UnitHasMana("player") then
				local regen = GetUnitManaRegenRateFromSpirit("player")
				regen = floor(regen * 5.0)
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(MANA_REGEN_FROM_SPIRIT, regen)
			end
		end
	elseif unit == "pet" then
		if statIndex == 1 then
			local attackPower = effectiveStat - 20
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower)
		elseif statIndex == 2 then
			local newLineIndex = find(statFrame.tooltip2, "|n") + 1
			statFrame.tooltip2 = sub(statFrame.tooltip2, 1, newLineIndex)
			statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("pet"))
		elseif statIndex == 3 then
			local expectedHealthGain = (((stat - posBuff - negBuff) - 20) * 10 + 20) * GetUnitHealthModifier("pet")
			local realHealthGain = ((effectiveStat - 20) * 10 + 20) * GetUnitHealthModifier("pet")
			local healthGain = (realHealthGain - expectedHealthGain) * GetUnitMaxHealthModifier("pet")
			statFrame.tooltip2 = format(statFrame.tooltip2, healthGain)
		elseif statIndex == 4 then
			if UnitHasMana("pet") then
				local manaGain = ((effectiveStat - 20) * 15 + 20) * GetUnitPowerModifier("pet")
				statFrame.tooltip2 = format(statFrame.tooltip2, manaGain, GetSpellCritChanceFromIntellect("pet"))
			else
				local newLineIndex = find(statFrame.tooltip2, "|n") + 2
				statFrame.tooltip2 = sub(statFrame.tooltip2, newLineIndex)
				statFrame.tooltip2 = format(statFrame.tooltip2, GetSpellCritChanceFromIntellect("pet"))
			end
		elseif statIndex == 5 then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetUnitHealthRegenRateFromSpirit("pet"))
			if UnitHasMana("pet") then
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(MANA_REGEN_FROM_SPIRIT, GetUnitManaRegenRateFromSpirit("pet"))
			end
		end
	end
	statFrame:Show()
end

function module:SetResistance(statFrame, unit, resistanceIndex)
	local base, resistance, positive, negative = UnitResistance(unit, resistanceIndex)
	local petBonus = ComputePetBonus("PET_BONUS_RES", resistance)
	local resistanceNameShort = _G["SPELL_SCHOOL"..resistanceIndex.."_CAP"]
	local resistanceName = _G["RESISTANCE"..resistanceIndex.."_NAME"]
	local resistanceIconCode = "|TInterface\\PaperDollInfoFrame\\SpellSchoolIcon"..(resistanceIndex + 1)..":14:14:2:2:16:16:2:14:2:14|t"
	statFrame.Label:SetText(resistanceIconCode.." "..format(STAT_FORMAT, resistanceNameShort))
	local text = _G[statFrame:GetName().."StatText"]
	PaperDollFormatStat(resistanceName, base, positive, negative, statFrame, text)
	statFrame.tooltip = resistanceIconCode.." "..HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, resistanceName).." "..resistance..FONT_COLOR_CODE_CLOSE

	if positive ~= 0 or negative ~= 0 then
		statFrame.tooltip = statFrame.tooltip.." ( "..HIGHLIGHT_FONT_COLOR_CODE..base
		if positive > 0 then
			statFrame.tooltip = statFrame.tooltip..GREEN_FONT_COLOR_CODE.." +"..positive
		end
		if negative < 0 then
			statFrame.tooltip = statFrame.tooltip.." "..RED_FONT_COLOR_CODE..negative
		end
		statFrame.tooltip = statFrame.tooltip..FONT_COLOR_CODE_CLOSE.." )"
	end

	local resistanceLevel
	local unitLevel = UnitLevel(unit)
	unitLevel = max(unitLevel, 20)

	local magicResistanceNumber = resistance / unitLevel
	if magicResistanceNumber > 5 then
		resistanceLevel = RESISTANCE_EXCELLENT
	elseif magicResistanceNumber > 3.75 then
		resistanceLevel = RESISTANCE_VERYGOOD
	elseif magicResistanceNumber > 2.5 then
		resistanceLevel = RESISTANCE_GOOD
	elseif magicResistanceNumber > 1.25 then
		resistanceLevel = RESISTANCE_FAIR
	elseif magicResistanceNumber > 0 then
		resistanceLevel = RESISTANCE_POOR
	else
		resistanceLevel = RESISTANCE_NONE
	end
	statFrame.tooltip2 = format(RESISTANCE_TOOLTIP_SUBTEXT, _G["RESISTANCE_TYPE"..resistanceIndex], unitLevel, resistanceLevel)

	if petBonus > 0 then
		statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(PET_BONUS_TOOLTIP_RESISTANCE, petBonus)
	end
end

function module:SetDodge(statFrame, unit)
	if unit ~= "player" then
		statFrame:Hide()
		return
	end

	local chance = GetDodgeChance()
	module:SetLabelAndText(statFrame, STAT_DODGE, chance, 1)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, DODGE_CHANCE).." "..format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE))
	statFrame:Show()
end

function module:SetBlock(statFrame, unit)
	if unit ~= "player" then
		statFrame:Hide()
		return
	end

	local chance = GetBlockChance()
	module:SetLabelAndText(statFrame, STAT_BLOCK, chance, 1)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, BLOCK_CHANCE).." "..format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_BLOCK_TOOLTIP, GetCombatRating(CR_BLOCK), GetCombatRatingBonus(CR_BLOCK), GetShieldBlock())
	statFrame:Show()
end

function module:SetParry(statFrame, unit)
	if unit ~= "player" then
		statFrame:Hide()
		return
	end

	local chance = GetParryChance()
	module:SetLabelAndText(statFrame, STAT_PARRY, chance, 1)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, PARRY_CHANCE).." "..format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY))
	statFrame:Show()
end

function module:SetResilience(statFrame, unit)
	if unit ~= "player" then
		statFrame:Hide()
		return
	end

	local melee = GetCombatRating(CR_CRIT_TAKEN_MELEE)
	local ranged = GetCombatRating(CR_CRIT_TAKEN_RANGED)
	local spell = GetCombatRating(CR_CRIT_TAKEN_SPELL)

	local minResilience = min(melee, ranged)
	minResilience = min(minResilience, spell)

	local lowestRating
	if melee == minResilience then
		lowestRating = CR_CRIT_TAKEN_MELEE
	elseif ranged == minResilience then
		lowestRating = CR_CRIT_TAKEN_RANGED
	else
		lowestRating = CR_CRIT_TAKEN_SPELL
	end

	local maxRatingBonus = GetMaxCombatRatingBonus(lowestRating)
	local lowestRatingBonus = GetCombatRatingBonus(lowestRating)

	module:SetLabelAndText(statFrame, STAT_RESILIENCE, minResilience)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RESILIENCE).." "..minResilience..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(RESILIENCE_TOOLTIP, lowestRatingBonus, min(lowestRatingBonus * RESILIENCE_CRIT_CHANCE_TO_DAMAGE_REDUCTION_MULTIPLIER, maxRatingBonus), lowestRatingBonus * RESILIENCE_CRIT_CHANCE_TO_CONSTANT_DAMAGE_REDUCTION_MULTIPLIER)
	statFrame:Show()
end

function module:SetMeleeDPS(statFrame, unit)
	statFrame.Label:SetFormattedText(STAT_FORMAT, L["Damage Per Second"])
	local speed, offhandSpeed = UnitAttackSpeed(unit)
	local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit)

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg

	local baseDamage = (minDamage + maxDamage) * 0.5
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent
	local totalBonus = (fullDamage - baseDamage)
	local damagePerSecond = (max(fullDamage, 1) / speed)

	local colorPos = "|cff20ff20"
	local colorNeg = "|cffff2020"
	local text

	if totalBonus < 0.1 and totalBonus > -0.1 then
		totalBonus = 0.0
	end

	if totalBonus == 0 then
		text = format("%.1F", damagePerSecond)
	else
		local color
		if totalBonus > 0 then
			color = colorPos
		else
			color = colorNeg
		end
		text = color..format("%.1F", damagePerSecond).."|r"
	end

	if offhandSpeed then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent
		local offhandDamagePerSecond = (max(offhandFullDamage, 1) / offhandSpeed)
		local offhandTotalBonus = (offhandFullDamage - offhandBaseDamage)

		if offhandTotalBonus < 0.1 and offhandTotalBonus > -0.1 then
			offhandTotalBonus = 0.0
		end
		local separator = " / "
		if damagePerSecond > 1000 and offhandDamagePerSecond > 1000 then
			separator = "/"
		end
		if offhandTotalBonus == 0 then
			text = text..separator..format("%.1F", offhandDamagePerSecond)
		else
			local color
			if offhandTotalBonus > 0 then
				color = colorPos
			else
				color = colorNeg
			end
			text = text..separator..color..format("%.1F", offhandDamagePerSecond).."|r"
		end
	end

	statFrame.Value:SetText(text)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE
	statFrame:Show()
end

function module:SetMeleeCritChance(statFrame, unit)
	if unit ~= "player" then
		statFrame:Hide()
		return
	end

	statFrame.Label:SetFormattedText(STAT_FORMAT, MELEE_CRIT_CHANCE)
	local critChance = GetCritChance()
	statFrame.Value:SetFormattedText("%.2F%%", critChance)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MELEE_CRIT_CHANCE).." "..format("%.2F%%", critChance)..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_CRIT_MELEE_TOOLTIP, GetCombatRating(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_MELEE))
end

local function PaperDollFrame_CollapseStatCategory(categoryFrame)
	if not categoryFrame.collapsed then
		categoryFrame.collapsed = true
		--categoryFrame.Toolbar:SetTemplate("NoBackdrop")
		categoryFrame.Toolbar:SetAlpha(0.4)
		local index = 1
		while categoryFrame.Stats[index] do
			categoryFrame.Stats[index]:Hide()
			index = index + 1
		end
		categoryFrame:Height(18)
		module:PaperDollFrame_UpdateStatScrollChildHeight()
	end
end

local function PaperDollFrame_ExpandStatCategory(categoryFrame)
	if categoryFrame.collapsed then
		categoryFrame.collapsed = false
		--categoryFrame.Toolbar:SetTemplate("Default", true)
		categoryFrame.Toolbar:SetAlpha(1)
		module:PaperDollFrame_UpdateStatCategory(categoryFrame)
		module:PaperDollFrame_UpdateStatScrollChildHeight()
	end
end

local function PaperDollFrame_QueuedUpdate(self)
	module:PaperDollFrame_UpdateStats()
	self:SetScript("OnUpdate", nil)
end

local function PetPaperDollFrame_QueuedUpdate(self)
	PetPaperDollFrame_Update()
	self:SetScript("OnUpdate", nil)
end

function module:PaperDollFrame_UpdateStatCategory(categoryFrame)
	if not categoryFrame.Category then categoryFrame:Hide() return end

	local category = categoryFrame.Category
	local categoryInfo = PAPERDOLL_STATCATEGORIES[category]

	if category == "ITEM_LEVEL" then
		if PersonalGearScore then
			categoryFrame.NameText:SetText("Gear Score")
		else
			categoryFrame.NameText:SetText(L["Item Level"])
		end
	elseif category == "RESISTANCE" then
		categoryFrame.NameText:SetText(L["Resistance"])
	elseif category == "DEFENSES" then
		categoryFrame.NameText:SetText(DEFENSE)
	else
		categoryFrame.NameText:SetText(_G["PLAYERSTAT_"..category])
	end

	if categoryFrame.collapsed then return end

	local totalHeight = categoryFrame.NameText:GetHeight() + 10
	local numVisible = 0
	if categoryInfo then
		local prevStatFrame = nil
		for _, stat in next, categoryInfo.stats do
			local statInfo = PAPERDOLL_STATINFO[stat]
			if statInfo then
				local statFrame = categoryFrame.Stats[numVisible + 1]
				if not statFrame then
					statFrame = CreateFrame("Frame", "$parentStat"..numVisible + 1, categoryFrame, "CharacterStatFrameTemplate")
					if prevStatFrame then
						statFrame:SetPoint("TOPLEFT", prevStatFrame, "BOTTOMLEFT")
						statFrame:SetPoint("TOPRIGHT", prevStatFrame, "BOTTOMRIGHT")
					end
					categoryFrame.Stats[numVisible + 1] = statFrame
				end
				statFrame:Show()

				if stat == "ITEM_LEVEL" then
					statFrame:Height(30)
					local label = statFrame.Label
					label:Width(187)
					label:ClearAllPoints()
					label:SetPoint("CENTER")
					label:FontTemplate(nil, 20, "NONE")
					label:SetJustifyH("CENTER")
					statFrame.Value:SetText("")

					if statFrame.leftGrad then
						statFrame.leftGrad:Show()
						statFrame.rightGrad:Show()
					end
				elseif statFrame:GetHeight() > 22 then
					statFrame:Height(15)
					local label = statFrame.Label
					label:Width(122)
					label:ClearAllPoints()
					label:Point("LEFT", 7, 0)
					label:FontTemplate(nil, nil, "NONE")
					label:SetJustifyH("LEFT")
					label:SetTextColor(1, 0.82, 0)

					if statFrame.leftGrad then
						statFrame.leftGrad:Hide()
						statFrame.rightGrad:Hide()
					end
				end

				if statInfo.updateFunc2 then
					statFrame:SetScript("OnEnter", PaperDollStatTooltip)
					statFrame:SetScript("OnEnter", statInfo.updateFunc2)
				else
					statFrame:SetScript("OnEnter", PaperDollStatTooltip)
				end

				statFrame.tooltip = nil
				statFrame.tooltip2 = nil
				statFrame.UpdateTooltip = nil
				statFrame:SetScript("OnUpdate", nil)
				statInfo.updateFunc(statFrame, CharacterStatsPane.unit)

				if statFrame:IsShown() then
					numVisible = numVisible + 1
					totalHeight = totalHeight + statFrame:GetHeight()
					prevStatFrame = statFrame

					if GameTooltip:GetOwner() == statFrame then
						statFrame:GetScript("OnEnter")(statFrame)
					end
				end
			end
		end
	end

	for index = 1, numVisible do
		if index % 2 == 0 or categoryInfo == PAPERDOLL_STATCATEGORIES["ITEM_LEVEL"] then
			local statFrame = categoryFrame.Stats[index]
			if not statFrame.leftGrad then
				statFrame.leftGrad = statFrame:CreateTexture(nil, "BACKGROUND")
				statFrame.leftGrad:Size(80, statFrame:GetHeight())
				statFrame.leftGrad:SetPoint("LEFT", statFrame, "CENTER")
				statFrame.leftGrad:SetTexture(E.media.blankTex)
				statFrame.leftGrad:SetGradientAlpha("Horizontal", 0.8,0.8,0.8,0.35, 0.8,0.8,0.8,0)

				statFrame.rightGrad = statFrame:CreateTexture(nil, "BACKGROUND")
				statFrame.rightGrad:Size(80, statFrame:GetHeight())
				statFrame.rightGrad:SetPoint("RIGHT", statFrame, "CENTER")
				statFrame.rightGrad:SetTexture(E.media.blankTex)
				statFrame.rightGrad:SetGradientAlpha("Horizontal", 0.8,0.8,0.8,0, 0.8,0.8,0.8,0.35)
			end
		end
	end

	local index = numVisible + 1
	while categoryFrame.Stats[index] do
		categoryFrame.Stats[index]:Hide()
		index = index + 1
	end

	categoryFrame:Height(totalHeight)
end

function module:PaperDollFrame_UpdateStats()
	local index = 1
	while CharacterStatsPane.Categories[index] do
		self:PaperDollFrame_UpdateStatCategory(CharacterStatsPane.Categories[index])
		index = index + 1
	end
	self:PaperDollFrame_UpdateStatScrollChildHeight()
end

function module:PaperDollFrame_UpdateStatScrollChildHeight()
	local index = 1
	local totalHeight = 0
	while CharacterStatsPane.Categories[index] do
		if CharacterStatsPane.Categories[index]:IsShown() then
			totalHeight = totalHeight + CharacterStatsPane.Categories[index]:GetHeight() + 4
		end
		index = index + 1
	end
	CharacterStatsPaneScrollChild:Height(totalHeight + 10 -(CharacterStatsPane.initialOffsetY or 0))
end

local function FindCategoryById(id)
	for categoryName, category in pairs(PAPERDOLL_STATCATEGORIES) do
		if category.id == id then
			return categoryName
		end
	end
end

function module:PaperDoll_InitStatCategories(defaultOrder, orderData, collapsedData, unit)
	local order = defaultOrder

	local orderString = orderData
	local savedOrder = {}
	if orderString and orderString ~= "" then
		for i in gmatch(orderString, "(%d+),?") do
			i = tonumber(i)
			if i then
				local categoryName = FindCategoryById(i)
				if categoryName then
					tinsert(savedOrder, categoryName)
				end
			end
		end

		local valid = true
		if #savedOrder == #defaultOrder then
			for _, category1 in ipairs(defaultOrder) do
				local found = false
				for _, category2 in ipairs(savedOrder) do
					if category1 == category2 then
						found = true
						break
					end
				end
				if not found then
					valid = false
					break
				end
			end
		else
			valid = false
		end

		if valid then
			order = savedOrder
		else
			orderData = ""
		end
	end

	wipe(StatCategoryFrames)
	for index = 1, #order do
		local frame = CharacterStatsPane.Categories[index]
		tinsert(StatCategoryFrames, frame)
		frame.Category = order[index]
		frame:Show()

		local categoryInfo = PAPERDOLL_STATCATEGORIES[frame.Category]
		if categoryInfo and collapsedData[frame.Category] then
			PaperDollFrame_CollapseStatCategory(frame)
		else
			PaperDollFrame_ExpandStatCategory(frame)
		end
	end

	local index = #order + 1
	while CharacterStatsPane.Categories[index] do
		CharacterStatsPane.Categories[index]:Hide()
		CharacterStatsPane.Categories[index].Category = nil
		index = index + 1
	end

	CharacterStatsPane.defaultOrder = defaultOrder
	CharacterStatsPane.orderData = orderData
	CharacterStatsPane.collapsedData = collapsedData
	CharacterStatsPane.unit = unit

	self:PaperDoll_UpdateCategoryPositions()
	self:PaperDollFrame_UpdateStats()
end

local function PaperDoll_SaveStatCategoryOrder()
	local activeSpec = GetActiveTalentGroup()

	if CharacterStatsPane.defaultOrder and #CharacterStatsPane.defaultOrder == #StatCategoryFrames then
		local same = true
		for index = 1, #StatCategoryFrames do
			if StatCategoryFrames[index].Category ~= CharacterStatsPane.defaultOrder[index] then
				same = false
				break
			end
		end
		if same then
			if activeSpec == 1 then
				E.private.enhanced.character[CharacterStatsPane.unit].orderName = ""
			else
				E.private.enhanced.character[CharacterStatsPane.unit].orderName2 = ""
			end
			return
		end
	end

	local order = {}

	for index = 1, #StatCategoryFrames do
		order[index] = PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id
	end

	if activeSpec == 1 then
		E.private.enhanced.character[CharacterStatsPane.unit].orderName = tconcat(order, ",")
	else
		E.private.enhanced.character[CharacterStatsPane.unit].orderName2 = tconcat(order, ",")
	end    
end

function module:PaperDoll_UpdateCategoryPositions()
	local prevFrame

	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index]

		local xOffset = 0
		if frame == MOVING_STAT_CATEGORY then
			xOffset = STATCATEGORY_MOVING_INDENT
		elseif prevFrame and prevFrame == MOVING_STAT_CATEGORY then
			xOffset = -STATCATEGORY_MOVING_INDENT
		end

		frame:ClearAllPoints()
		if prevFrame then
			frame:Point("TOPLEFT", prevFrame, "BOTTOMLEFT", 0 + xOffset, -4)
		else
			frame:Point("TOPLEFT", 1 + xOffset, -4 + (CharacterStatsPane.initialOffsetY or 0))
		end
		prevFrame = frame
	end
end

local function StatCategory_OnDragUpdate(self)
	local _, cursorY = GetCursorPosition()
	cursorY = cursorY * GetScreenHeightScale()

	local myIndex, insertIndex, closestPos

	for index = 1, #StatCategoryFrames + 1 do
		if StatCategoryFrames[index] == self then
			myIndex = index
		end

		local frameY
		if index <= #StatCategoryFrames then
			frameY = StatCategoryFrames[index]:GetTop()
		else
			frameY = StatCategoryFrames[#StatCategoryFrames]:GetBottom()
		end
		frameY = frameY - 8
		if myIndex and index > myIndex then
			frameY = frameY + self:GetHeight()
		end
		if not closestPos or abs(cursorY - frameY) < closestPos then
			insertIndex = index
			closestPos = abs(cursorY - frameY)
		end
	end

	if insertIndex > myIndex then
		insertIndex = insertIndex - 1
	end

	if myIndex ~= insertIndex then
		tremove(StatCategoryFrames, myIndex)
		tinsert(StatCategoryFrames, insertIndex, self)
		module:PaperDoll_UpdateCategoryPositions()
	end
end

local function PaperDollStatCategory_OnDragStart(self)
	MOVING_STAT_CATEGORY = self
	module:PaperDoll_UpdateCategoryPositions()
	GameTooltip:Hide()
	self:SetScript("OnUpdate", StatCategory_OnDragUpdate)

	for i, frame in next, StatCategoryFrames do
		if frame ~= self then
			if E.db.enhanced.character.animations then
				UIFrameFadeIn(frame, 0.2, 1, 0.6)
			else
				frame:SetAlpha(0.6)
			end
		end
	end
end

local function PaperDollStatCategory_OnDragStop(self)
	MOVING_STAT_CATEGORY = nil
	module:PaperDoll_UpdateCategoryPositions()
	self:SetScript("OnUpdate", nil)

	for i, frame in next, StatCategoryFrames do
		if frame ~= self then
			if E.db.enhanced.character.animations then
				UIFrameFadeOut(frame, 0.2, 0.6, 1)
			else
				frame:SetAlpha(1)
			end
		end
	end
	PaperDoll_SaveStatCategoryOrder()
end

function module:PaperDollFrame_UpdateSidebarTabs()
	for i = 1, #PAPERDOLL_SIDEBARS do
		local tab = _G["PaperDollSidebarTab"..i]
		if _G[PAPERDOLL_SIDEBARS[i].frame]:IsShown() then
			tab.Hider:Hide()
			tab.Highlight:Hide()
		else
			tab.Hider:Show()
			tab.Highlight:Show()
		end
	end
end

function module:PaperDollFrame_SetSidebar(button, index)
	if not _G[PAPERDOLL_SIDEBARS[index].frame]:IsShown() then
		for i = 1, #PAPERDOLL_SIDEBARS do
			if _G[PAPERDOLL_SIDEBARS[i].frame]:IsShown() then
				if E.db.enhanced.character.animations then
					UIFrameFadeOut(_G[PAPERDOLL_SIDEBARS[i].frame], 0.2, 1, 0)

					_G[PAPERDOLL_SIDEBARS[i].frame].fadeInfo.finishedFunc = function()
						_G[PAPERDOLL_SIDEBARS[i].frame]:Hide()
					end
				else
					_G[PAPERDOLL_SIDEBARS[i].frame]:Hide()
				end

				_G["PaperDollSidebarTab"..i].Hider:Show()
				_G["PaperDollSidebarTab"..i].Highlight:Show()
			end
		end

		_G[PAPERDOLL_SIDEBARS[index].frame]:Show()
		if E.db.enhanced.character.animations then
			UIFrameFadeIn(_G[PAPERDOLL_SIDEBARS[index].frame], 0.2, 0, 1)
		end
		PaperDollFrame.currentSideBar = _G[PAPERDOLL_SIDEBARS[index].frame]
		PaperDollFrame.currentSideBarID = index

		_G["PaperDollSidebarTab"..index].Hider:Hide()
		_G["PaperDollSidebarTab"..index].Highlight:Hide()
	end
end

function module:PaperDollTitlesPane_UpdateScrollFrame()
	local buttons = PaperDollTitlesPane.buttons
	local playerTitles = PaperDollTitlesPane.titles
	local numButtons = #buttons
	local scrollOffset = HybridScrollFrame_GetOffset(PaperDollTitlesPane)
	local button, playerTitle

	for i = 1, numButtons do
		button = buttons[i]
		playerTitle = playerTitles[i + scrollOffset]

		if playerTitle then
			button:Show()
			button.text:SetText(playerTitle.name)
			button.titleId = playerTitle.id

			local highlight = button:GetHighlightTexture()
			highlight:SetTexture(E.Media.Textures.Highlight)
			highlight:SetInside()
			highlight:SetVertexColor(1, 1, 1, 0.35)

			if PaperDollTitlesPane.selected == playerTitle.id then
				button.Check:SetAlpha(1)
				button.SelectedBar:SetTexture(E.Media.Textures.Highlight)
				button.SelectedBar:SetVertexColor(1, 0.80, 0.10, 0.3)
				button.SelectedBar:SetInside()
				button.SelectedBar:Show()
			else
				button.Check:SetAlpha(0)
				button.SelectedBar:Hide()
			end

			if (i + scrollOffset) % 2 == 0 then
				button.Stripe:SetTexture(0.9, 0.9, 1, 0.1)
				button.Stripe:Show()
			else
				button.Stripe:Hide()
			end
		else
			button:Hide()
		end
	end
end

local function PlayerTitleSort(a, b) return a.name < b.name end

function module:PaperDollTitlesPane_Update()
	local playerTitles = {}
	local currentTitle = GetCurrentTitle()
	local titleCount = 1
	local buttons = PaperDollTitlesPane.buttons
	local fontstringText = buttons[1].text

	PaperDollTitlesPane.selected = -1
	playerTitles[1] = {}
	playerTitles[1].name = "       "
	playerTitles[1].id = -1

	for i = 1, GetNumTitles() do
		if IsTitleKnown(i) ~= 0 then
			titleCount = titleCount + 1
			playerTitles[titleCount] = playerTitles[titleCount] or {}
			playerTitles[titleCount].name = trim(GetTitleName(i))
			playerTitles[titleCount].id = i

			if i == currentTitle then
				PaperDollTitlesPane.selected = i
			end

			fontstringText:SetText(playerTitles[titleCount].name)
		end
	end

	sort(playerTitles, PlayerTitleSort)
	playerTitles[1].name = NONE
	PaperDollTitlesPane.titles = playerTitles

	HybridScrollFrame_Update(PaperDollTitlesPane, (titleCount * 22) + 20 , PaperDollTitlesPane:GetHeight())
	if not PaperDollTitlesPane.scrollBar.thumbTexture:IsShown() then
		PaperDollTitlesPane.scrollBar.thumbTexture:Show()
	end

	self:PaperDollTitlesPane_UpdateScrollFrame()
end

function module:PaperDollEquipmentManagerPane_Update()
	local _, setID = GetEquipmentSetInfoByName(PaperDollEquipmentManagerPane.selectedSetName or "")
	if setID then
		PaperDollEquipmentManagerPaneSaveSet:Enable()
		PaperDollEquipmentManagerPaneEquipSet:Enable()
	else
		PaperDollEquipmentManagerPaneSaveSet:Disable()
		PaperDollEquipmentManagerPaneEquipSet:Disable()

		if PaperDollEquipmentManagerPane.selectedSetName then
			PaperDollEquipmentManagerPane.selectedSetName = nil
			PaperDollFrame_ClearIgnoredSlots()
		end
	end

	local numSets = GetNumEquipmentSets()
	local numRows = numSets
	if numSets < MAX_EQUIPMENT_SETS_PER_PLAYER then
		numRows = numRows + 1
	end

	HybridScrollFrame_Update(PaperDollEquipmentManagerPane, numRows * 44 + PaperDollEquipmentManagerPaneEquipSet:GetHeight() + 20 , PaperDollEquipmentManagerPane:GetHeight())
	if not PaperDollEquipmentManagerPane.scrollBar.thumbTexture:IsShown() then
		PaperDollEquipmentManagerPane.scrollBar.thumbTexture:Show()
	end

	local scrollOffset = HybridScrollFrame_GetOffset(PaperDollEquipmentManagerPane)
	local buttons = PaperDollEquipmentManagerPane.buttons
	local selectedName = PaperDollEquipmentManagerPane.selectedSetName
	local name, texture, button

	for i = 1, #buttons do
		button = buttons[i]
		if (i + scrollOffset) <= numRows then
			button:Show()
			button:Enable()

			if (i + scrollOffset) <= numSets then
				name, texture = GetEquipmentSetInfo(i + scrollOffset)
				button.name = name
				button.text:SetText(name)
				button.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)

				if texture then
					button.icon:SetTexture(texture)
				else
					button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
				end

				if selectedName and button.name == selectedName then
					button.SelectedBar:Show()
					GearManagerDialog.selectedSet = button
				else
					button.SelectedBar:Hide()
				end
			else
				button.name = nil
				button.text:SetText(L["New Set"])
				button.text:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
				button.icon:SetTexture("Interface\\Icons\\Spell_ChargePositive")
				button.SelectedBar:Hide()
			end

			if (i + scrollOffset) % 2 == 0 then
				button.Stripe:SetTexture(0.9, 0.9, 1)
				button.Stripe:SetAlpha(0.1)
				button.Stripe:Show()
			else
				button.Stripe:Hide()
			end
		else
			button:Hide()
		end
	end
end

function module:PetPaperDollCompanionPane_Update()
	local scrollFrame = PetPaperDollCompanionPane
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local selected, text
	local button, displayIndex, index
	local creatureID, creatureName, spellID, icon, active

	if PetPaperDollFrameCompanionFrame.mode == "CRITTER" then
		selected = PetPaperDollFrame_FindCompanionIndex(PetPaperDollFrameCompanionFrame.idCritter)
		text = L["Total Companions"]
	elseif PetPaperDollFrameCompanionFrame.mode == "MOUNT" then
		selected = PetPaperDollFrame_FindCompanionIndex(PetPaperDollFrameCompanionFrame.idMount)
		text = L["Total Mounts"]
	end

	local numCompanions = GetNumCompanions(PetPaperDollFrameCompanionFrame.mode)
	scrollFrame.text:SetFormattedText("%s: %d", text, numCompanions)

	for i = 1, #buttons do
		button = buttons[i]
		displayIndex = i + offset

		if displayIndex <= numCompanions then
			index = displayIndex
			creatureID, creatureName, spellID, icon, active = GetCompanionInfo(PetPaperDollFrameCompanionFrame.mode, index)

			button:Show()
			button:SetID(index)
			_G[button:GetName().."Cooldown"]:SetInside()

			button.creatureID = creatureID
			button.spellID = spellID
			button.active = active

			if creatureID then
				button.name:SetText(creatureName)
				button.icon:SetTexture(icon)
				button:Enable()

				local start, duration, enable = GetCompanionCooldown(PetPaperDollFrameCompanionFrame.mode, index)
				if start and duration and enable then
					CooldownFrame_SetTimer(_G[button:GetName().."Cooldown"], start, duration, enable)
				end
			else
				button.name:SetText("")
				_G[button:GetName().."Cooldown"]:Hide()
				button:Disable()
			end

			if (index == selected) and creatureID then
				button.SelectedBar:Show()
				button.SelectedBar:SetTexture(1, 1, 1, 0.2)
			elseif active then
				button.SelectedBar:Show()
				button.SelectedBar:SetTexture(1, 1, 0, 0.2)
			else
				button.SelectedBar:Hide()
			end

			if (i + offset) % 2 == 0 then
				button.Stripe:SetTexture(0.9, 0.9, 1)
				button.Stripe:SetAlpha(0.1)
				button.Stripe:Show()
			else
				button.Stripe:Hide()
			end
		else
			button:Hide()
		end
	end

	local totalHeight = numCompanions * 44
	HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight())
	if not scrollFrame.scrollBar.thumbTexture:IsShown() then
		scrollFrame.scrollBar.thumbTexture:Show()
	end
end

function module:UpdateCharacterModelFrame()
	if not module.Initialized then return end

	if E.db.enhanced.character.characterBackground then
		if not CharacterModelFrame.backdrop then
			CharacterModelFrame:CreateBackdrop()
			CharacterModelFrame.backdrop:SetAllPoints(CharacterModelFrame)

			CharacterModelFrame.textureTopLeft = CharacterModelFrame:CreateTexture("$parentTextureTopLeft", "BACKGROUND")
			CharacterModelFrame.textureTopLeft:Point("TOPLEFT", 1, -1)
			CharacterModelFrame.textureTopLeft:Size(216, 246)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 256, 256, 216, 248, 40, 8
			CharacterModelFrame.textureTopLeft:SetTexCoord(0.15625, 1, 0.03125, 1)

			CharacterModelFrame.textureTopRight = CharacterModelFrame:CreateTexture("$parentTextureTopRight", "BACKGROUND")
			CharacterModelFrame.textureTopRight:Point("TOPLEFT", CharacterModelFrame.textureTopLeft, "TOPRIGHT")
			CharacterModelFrame.textureTopRight:Size(19, 246)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 64, 256, 19, 248, 0, 8
			CharacterModelFrame.textureTopRight:SetTexCoord(0, 0.296875, 0.03125, 1)

			CharacterModelFrame.textureBotLeft = CharacterModelFrame:CreateTexture("$parentTextureBotLeft", "BACKGROUND")
			CharacterModelFrame.textureBotLeft:Point("TOPLEFT", CharacterModelFrame.textureTopLeft, "BOTTOMLEFT")
			CharacterModelFrame.textureBotLeft:Size(216, 76)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 256, 128, 216, 76, 40, 0
			CharacterModelFrame.textureBotLeft:SetTexCoord(0.15625, 1, 0, 0.59375)

			CharacterModelFrame.textureBotRight = CharacterModelFrame:CreateTexture("$parentTextureBotRight", "BACKGROUND")
			CharacterModelFrame.textureBotRight:Point("TOPLEFT", CharacterModelFrame.textureTopLeft, "BOTTOMRIGHT")
			CharacterModelFrame.textureBotRight:Size(19, 76)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 64, 128, 19, 76, 0, 0
			CharacterModelFrame.textureBotRight:SetTexCoord(0, 0.296875, 0, 0.59375)

			CharacterModelFrame.backgroundOverlay = CharacterModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
			CharacterModelFrame.backgroundOverlay:SetInside(CharacterModelFrame.backdrop)
			CharacterModelFrame.backgroundOverlay:SetTexture(0, 0, 0)
		else
			CharacterModelFrame.backdrop:Show()
		end

		local desaturate = E.db.enhanced.character.desaturateCharacter and true or false
		local raceEng = lower(E.myrace)

		CharacterModelFrame.textureTopLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_1.blp")
		CharacterModelFrame.textureTopLeft:SetDesaturated(desaturate)
		CharacterModelFrame.textureTopLeft:Show()

		CharacterModelFrame.textureTopRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_2.blp")
		CharacterModelFrame.textureTopRight:SetDesaturated(desaturate)
		CharacterModelFrame.textureTopRight:Show()

		CharacterModelFrame.textureBotLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_3.blp")
		CharacterModelFrame.textureBotLeft:SetDesaturated(desaturate)
		CharacterModelFrame.textureBotLeft:Show()

		CharacterModelFrame.textureBotRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_4.blp")
		CharacterModelFrame.textureBotRight:SetDesaturated(desaturate)
		CharacterModelFrame.textureBotRight:Show()

		CharacterModelFrame.backgroundOverlay:Show()

		if raceEng == "scourge" then
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.2)
		elseif raceEng == "bloodelf" or raceEng == "nightelf" then
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.7)
		elseif raceEng == "troll" or raceEng == "orc" then
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.5)
		else
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.6)
		end
	elseif CharacterModelFrame.textureTopLeft then
		CharacterModelFrame.backdrop:Hide()
		CharacterModelFrame.textureTopLeft:Hide()
		CharacterModelFrame.textureTopRight:Hide()
		CharacterModelFrame.textureBotLeft:Hide()
		CharacterModelFrame.textureBotRight:Hide()
		CharacterModelFrame.backgroundOverlay:Hide()
	end
end

function module:UpdateInspectModelFrame()
	if not module.Initialized or not InspectModelFrame then return end

	if E.db.enhanced.character.inspectBackground then
		if not InspectModelFrame.backdrop then
			InspectModelFrame:CreateBackdrop("Default")
			InspectModelFrame.backdrop:SetAllPoints(InspectModelFrame)

			InspectModelFrame.textureTopLeft = InspectModelFrame:CreateTexture("$parentTextureTopLeft", "BACKGROUND")
			InspectModelFrame.textureTopLeft:Point("TOPLEFT", 1, -1)
			InspectModelFrame.textureTopLeft:Size(216, 246)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 256, 256, 216, 248, 40, 8
			InspectModelFrame.textureTopLeft:SetTexCoord(0.15625, 1, 0.03125, 1)

			InspectModelFrame.textureTopRight = InspectModelFrame:CreateTexture("$parentTextureTopRight", "BACKGROUND")
			InspectModelFrame.textureTopRight:Point("TOPLEFT", InspectModelFrame.textureTopLeft, "TOPRIGHT")
			InspectModelFrame.textureTopRight:Size(19, 246)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 64, 256, 19, 248, 0, 8
			InspectModelFrame.textureTopRight:SetTexCoord(0, 0.296875, 0.03125, 1)

			InspectModelFrame.textureBotLeft = InspectModelFrame:CreateTexture("$parentTextureBotLeft", "BACKGROUND")
			InspectModelFrame.textureBotLeft:Point("TOPLEFT", InspectModelFrame.textureTopLeft, "BOTTOMLEFT")
			InspectModelFrame.textureBotLeft:Size(216, 76)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 256, 128, 216, 76, 40, 0
			InspectModelFrame.textureBotLeft:SetTexCoord(0.15625, 1, 0, 0.59375)

			InspectModelFrame.textureBotRight = InspectModelFrame:CreateTexture("$parentTextureBotRight", "BACKGROUND")
			InspectModelFrame.textureBotRight:Point("TOPLEFT", InspectModelFrame.textureTopLeft, "BOTTOMRIGHT")
			InspectModelFrame.textureBotRight:Size(19, 76)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 64, 128, 19, 76, 0, 0
			InspectModelFrame.textureBotRight:SetTexCoord(0, 0.296875, 0, 0.59375)

			InspectModelFrame.backgroundOverlay = InspectModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
			InspectModelFrame.backgroundOverlay:SetInside(InspectModelFrame.backdrop)
			InspectModelFrame.backgroundOverlay:SetTexture(0, 0, 0)
		else
			InspectModelFrame.backdrop:Show()
		end

		local _, raceEng = UnitRace(InspectFrame.unit)
		raceEng = lower(raceEng)
		local desaturate = E.db.enhanced.character.desaturateInspect and true or false

		InspectModelFrame.textureTopLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_1.blp")
		InspectModelFrame.textureTopLeft:SetDesaturated(desaturate)
		InspectModelFrame.textureTopLeft:Show()

		InspectModelFrame.textureTopRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_2.blp")
		InspectModelFrame.textureTopRight:SetDesaturated(desaturate)
		InspectModelFrame.textureTopRight:Show()

		InspectModelFrame.textureBotLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_3.blp")
		InspectModelFrame.textureBotLeft:SetDesaturated(desaturate)
		InspectModelFrame.textureBotLeft:Show()

		InspectModelFrame.textureBotRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\"..raceEng.."_4.blp")
		InspectModelFrame.textureBotRight:SetDesaturated(desaturate)
		InspectModelFrame.textureBotRight:Show()

		InspectModelFrame.backgroundOverlay:Show()

		if raceEng == "scourge" then
			InspectModelFrame.backgroundOverlay:SetAlpha(0.2)
		elseif raceEng == "bloodelf" or raceEng == "nightelf" then
			InspectModelFrame.backgroundOverlay:SetAlpha(0.7)
		elseif raceEng == "troll" or raceEng == "orc" then
			InspectModelFrame.backgroundOverlay:SetAlpha(0.5)
		else
			InspectModelFrame.backgroundOverlay:SetAlpha(0.6)
		end
	elseif InspectModelFrame.textureTopLeft then
		InspectModelFrame.backdrop:Hide()
		InspectModelFrame.textureTopLeft:Hide()
		InspectModelFrame.textureTopRight:Hide()
		InspectModelFrame.textureBotLeft:Hide()
		InspectModelFrame.textureBotRight:Hide()
		InspectModelFrame.backgroundOverlay:Hide()
	end
end

function module:UpdatePetModelFrame()
	if not module.Initialized then return end

	if E.db.enhanced.character.petBackground then
		if not PetModelFrame.backdrop then
			PetModelFrame:CreateBackdrop("Default")
			PetModelFrame.backdrop:SetAllPoints(PetModelFrame)

			PetModelFrame.petPaperDollPetModelBg = PetModelFrame:CreateTexture("$parentPetPaperDollPetModelBg", "BACKGROUND")
			PetModelFrame.petPaperDollPetModelBg:SetInside(PetModelFrame.backdrop)
			PetModelFrame.petPaperDollPetModelBg:SetTexCoord(0.00390625, 0.623046875, 0.00390625, 0.689453125)

			PetModelFrame.backgroundOverlay = PetModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
			PetModelFrame.backgroundOverlay:SetInside(PetModelFrame.backdrop)
			PetModelFrame.backgroundOverlay:SetTexture(0, 0, 0)
		else
			PetModelFrame.backdrop:Show()
		end

		if E.myclass == "HUNTER" then
			PetModelFrame.petPaperDollPetModelBg:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\petHunter.blp")
			PetModelFrame.backgroundOverlay:SetAlpha(0.4)
		elseif E.myclass == "WARLOCK" then
			PetModelFrame.petPaperDollPetModelBg:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\petWarlock.blp")
			PetModelFrame.backgroundOverlay:SetAlpha(0.2)
		elseif E.myclass == "DEATHKNIGHT" then
			PetModelFrame.petPaperDollPetModelBg:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\petDeathKnight.blp")
			PetModelFrame.backgroundOverlay:SetAlpha(0.1)
		else
			PetModelFrame.petPaperDollPetModelBg:Hide()
		end

		PetModelFrame.petPaperDollPetModelBg:SetDesaturated(E.db.enhanced.character.desaturatePet and true or false)

		PetModelFrame.petPaperDollPetModelBg:Show()
		PetModelFrame.backgroundOverlay:Show()
	elseif PetModelFrame.petPaperDollPetModelBg then
		PetModelFrame.backdrop:Hide()
		PetModelFrame.petPaperDollPetModelBg:Hide()
		PetModelFrame.backgroundOverlay:Hide()
	end
end

function module:UpdateCompanionModelFrame()
	if not module.Initialized then return end

	if E.db.enhanced.character.companionBackground then
		if not CompanionModelFrame.backdrop then
			CompanionModelFrame:CreateBackdrop("Default")
			CompanionModelFrame.backdrop:SetAllPoints(CompanionModelFrame)

			CompanionModelFrame.backgroundTex = CompanionModelFrame:CreateTexture("$parentBackgroundTex", "BACKGROUND")
			CompanionModelFrame.backgroundTex:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\MountJournal-BG")
			CompanionModelFrame.backgroundTex:SetInside(CompanionModelFrame.backdrop)
			CompanionModelFrame.backgroundTex:SetTexCoord(0.00390625, 0.783203125, 0.0078125, 0.984375)

			CompanionModelFrame.backgroundOverlay = CompanionModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
			CompanionModelFrame.backgroundOverlay:SetInside(CompanionModelFrame.backdrop)
			CompanionModelFrame.backgroundOverlay:SetTexture(0, 0, 0)
			CompanionModelFrame.backgroundOverlay:SetAlpha(0.3)
		else
			CompanionModelFrame.backdrop:Show()
		end

		CompanionModelFrame.backgroundTex:SetDesaturated(E.db.enhanced.character.desaturateCompanion and true or false)

		CompanionModelFrame.backgroundTex:Show()
		CompanionModelFrame.backgroundOverlay:Show()
	elseif CompanionModelFrame.backgroundTex then
		CompanionModelFrame.backdrop:Hide()
		CompanionModelFrame.backgroundTex:Hide()
		CompanionModelFrame.backgroundOverlay:Hide()
	end
end

local function SetScrollValue(self, value)
	if self.scrollBar.anim:IsPlaying() then
		self.scrollBar.anim:Stop()
	end
	self.scrollBar.anim.progress:SetChange(value)
	self.scrollBar.anim:Play()
end

local function Animation_OnMouseWheel(self, delta, stepSize)
	if not self.scrollBar:IsVisible() then return end

	self.times = self.times + 1

	if self.direction ~= delta then
		self.direction = delta
		self.times = 1
	end

	local minVal, maxVal = 0, self.range
	stepSize = stepSize or self.stepSize or self.buttonHeight or self.scrollBar.scrollStep

	if delta == 1 then
		SetScrollValue(self, max(minVal, self.scrollBar:GetValue() - (stepSize * self.times)))
	else
		SetScrollValue(self, min(maxVal, self.scrollBar:GetValue() + (stepSize * self.times)))
	end
end

local function CreateSmoothScrollAnimation(scrollBar, hybridScroll)
	if not E.db.enhanced.character.animations then return end

	local scrollFrame = scrollBar:GetParent()
	scrollFrame.times = 0
	scrollFrame.direction = -1

	scrollBar.anim = CreateAnimationGroup(scrollBar)
	scrollBar.anim.progress = scrollBar.anim:CreateAnimation("Progress")
	scrollBar.anim.progress:SetSmoothing("Out")
	scrollBar.anim.progress:SetDuration(0.5)

	scrollBar.anim.progress:SetScript("OnPlay", function(self)
		if (self:GetChange() >= self.Parent:GetParent().range) or (self:GetChange() <= 0) then
			self.Parent:GetParent().times = self.Parent:GetParent().times - 1
		end
	end)

	scrollBar.anim.progress:SetScript("OnFinished", function(self)
		self.Parent:GetParent().times = 0
	end)

	scrollFrame:SetScript("OnMouseWheel", Animation_OnMouseWheel)

	if not hybridScroll then
		scrollFrame:HookScript("OnScrollRangeChanged", function(self)
			self.range = select(2, self.scrollBar:GetMinMaxValues())
		end)
	end
end

function module:Initialize()
	if not E.private.enhanced.character.enable then return end

	self.skinEnabled = (E.private.skins.blizzard.enable and E.private.skins.blizzard.character) and true or false

	if PersonalGearScore then
		PersonalGearScore:Hide()
	end
	if GearScore2 then
		GearScore2:Hide()
	end

	PlayerTitleFrame:Kill()
	PlayerTitlePickerFrame:Kill()
	CharacterAttributesFrame:Kill()
	CharacterResistanceFrame:Kill()
	GearManagerToggleButton:Kill()

	SetCVar("equipmentManager", 1)

	if self.skinEnabled then
		CharacterNameFrame:ClearAllPoints()
		CharacterNameFrame:Point("CENTER", CharacterFrame.backdrop, 6, 200)
		CharacterFrameCloseButton:Point("CENTER", CharacterFrame.backdrop, "TOPRIGHT", -12, -13)

		CharacterFrame.backdrop:ClearAllPoints()
		CharacterFrame.backdrop:Point("TOPLEFT", 11, -12)
		CharacterFrame.backdrop:Size(341, 424)

		S:SetUIPanelWindowInfo(CharacterFrame, "width")

		S:SetBackdropHitRect(PaperDollFrame, CharacterFrame.backdrop)
		S:SetBackdropHitRect(PetPaperDollFrame, CharacterFrame.backdrop)
		S:SetBackdropHitRect(PetPaperDollFrameCompanionFrame, CharacterFrame.backdrop)
		S:SetBackdropHitRect(PetPaperDollFramePetFrame, CharacterFrame.backdrop)
	end

	local expandButton = CreateFrame("Button", "CharacterFrameExpandButton", CharacterFrame)
	expandButton:Point("BOTTOMLEFT", CharacterFrame, 325, 85)
	expandButton:SetFrameLevel(CharacterFrame:GetFrameLevel() + 5)
	S:HandleNextPrevButton(expandButton)
	expandButton:Size(19)

	expandButton:SetScript("OnClick", function(self)
		if CharacterFrame.Expanded then
			E.private.enhanced.character.collapsed = true
			module:CharacterFrame_Collapse()
			PlaySound("igCharacterInfoClose")
		else
			E.private.enhanced.character.collapsed = false
			module:CharacterFrame_Expand()
			PlaySound("igCharacterInfoOpen")
		end
		if GameTooltip:GetOwner() == self then
			self:GetScript("OnEnter")(self)
		end
	end)

	expandButton:SetScript("OnEnter", function(self)
		S.SetModifiedBackdrop(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if CharacterFrame.Expanded then
			GameTooltip:SetText(self.collapseTooltip)
		else
			GameTooltip:SetText(self.expandTooltip)
		end
	end)
	expandButton:SetScript("OnLeave", function(self)
		S.SetOriginalBackdrop(self)
		GameTooltip_Hide()
	end)

do -- CharacterFrame
	local sidebarTabs = CreateFrame("Frame", "PaperDollSidebarTabs", PaperDollFrame)
	sidebarTabs:Hide()
	sidebarTabs:Size(168, 35)
	sidebarTabs:Point("BOTTOMRIGHT", CharacterFrame.backdrop, "TOPRIGHT", -18, -59)

	local sidebarTabs3 = CreateFrame("Button", "PaperDollSidebarTab3", sidebarTabs)
	sidebarTabs3:SetID(3)
	sidebarTabs3:Point("BOTTOMRIGHT", -30, 0)
	self:PaperDollSidebarTab(sidebarTabs3)

	local sidebarTabs2 = CreateFrame("Button", "PaperDollSidebarTab2", sidebarTabs)
	sidebarTabs2:SetID(2)
	sidebarTabs2:Point("RIGHT", "PaperDollSidebarTab3", "LEFT", -5, 0)
	self:PaperDollSidebarTab(sidebarTabs2)

	local sidebarTabs1 = CreateFrame("Button", "PaperDollSidebarTab1", sidebarTabs)
	sidebarTabs1:SetID(1)
	sidebarTabs1:Point("RIGHT", "PaperDollSidebarTab2", "LEFT", -5, 0)
	self:PaperDollSidebarTab(sidebarTabs1)

	sidebarTabs1:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	sidebarTabs1:RegisterEvent("PLAYER_ENTERING_WORLD")

	local tcoords = PAPERDOLL_SIDEBARS[1].texCoords
	sidebarTabs1.Icon:SetTexCoord(tcoords[1], tcoords[2], tcoords[3], tcoords[4])

	sidebarTabs1:SetScript("OnEvent", function(self, event, unit)
		if event == "UNIT_PORTRAIT_UPDATE" then
			if not unit or unit == "player" then
				SetPortraitTexture(self.Icon, "player")
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			SetPortraitTexture(self.Icon, "player")
		end
	end)

	local titlePane = CreateFrame("ScrollFrame", "PaperDollTitlesPane", PaperDollFrame, "HybridScrollFrameTemplate")
	titlePane:Hide()
	titlePane:Size(169, 350)
	titlePane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)

	titlePane.scrollBar = CreateFrame("Slider", "$parentScrollBar", titlePane, "HybridScrollBarTemplate")
	titlePane.scrollBar:Point("TOPLEFT", titlePane, "TOPRIGHT", 3, -19)
	titlePane.scrollBar:Point("BOTTOMLEFT", titlePane, "BOTTOMRIGHT", 3, 17)
	S:HandleScrollBar(titlePane.scrollBar)

	CreateSmoothScrollAnimation(titlePane.scrollBar, true)

	titlePane:SetScript("OnShow", function(self)
		module:PaperDollTitlesPane_Update()
	end)

	titlePane.scrollBar.Show = function(self)
		titlePane:Width(169)
		titlePane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)
		for _, button in next, titlePane.buttons do
			button:Width(169)
		end
		getmetatable(self).__index.Show(self)
	end

	titlePane.scrollBar.Hide = function(self)
		titlePane:Width(190)
		titlePane:Point("TOPRIGHT", CharacterFrame.backdrop, -8, -64)
		for _, button in next, titlePane.buttons do
			button:Width(190)
		end
		getmetatable(self).__index.Hide(self)
	end

	titlePane:SetFrameLevel(CharacterFrame:GetFrameLevel() + 1)

	HybridScrollFrame_OnLoad(titlePane)
	titlePane.update = self.PaperDollTitlesPane_UpdateScrollFrame
	HybridScrollFrame_CreateButtons(PaperDollTitlesPane, "PlayerTitleButtonTemplate2", 2, -4)

	local statsPane = CreateFrame("ScrollFrame", "CharacterStatsPane", CharacterFrame, "UIPanelScrollFrameTemplate")
	statsPane:Hide()
	statsPane:Size(169, 350)
	statsPane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)
	statsPane.Categories = {}

	statsPane.scrollBar = CharacterStatsPaneScrollBar
	CharacterStatsPaneScrollBar:Point("TOPLEFT", CharacterStatsPane, "TOPRIGHT", 3, -19)
	CharacterStatsPaneScrollBar:Point("BOTTOMLEFT", CharacterStatsPane, "BOTTOMRIGHT", 3, 17)
	S:HandleScrollBar(CharacterStatsPaneScrollBar)

	CharacterStatsPaneScrollBar.scrollStep = 50
	CharacterStatsPane.scrollBarHideable = 1

	statsPane:SetScript("OnMouseWheel", function(self, value, scrollBar)
		scrollBar = scrollBar or self.scrollBar
		local scrollStep = scrollBar.scrollStep or scrollBar:GetHeight() / 2

		if value > 0 then
			scrollBar:SetValue(scrollBar:GetValue() - scrollStep)
		else
			scrollBar:SetValue(scrollBar:GetValue() + scrollStep)
		end
	end)

	CharacterStatsPaneScrollBarScrollUpButton:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		local scrollStep = parent.scrollStep or (parent:GetHeight() / 2)
		parent:SetValue(parent:GetValue() - scrollStep)
		PlaySound("UChatScrollButton")
	end)
	CharacterStatsPaneScrollBarScrollDownButton:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		local scrollStep = parent.scrollStep or (parent:GetHeight() / 2)
		parent:SetValue(parent:GetValue() + scrollStep)
		PlaySound("UChatScrollButton")
	end)

	CreateSmoothScrollAnimation(CharacterStatsPaneScrollBar)

	local statsPaneScrollChild = CreateFrame("Frame", "CharacterStatsPaneScrollChild", statsPane)
	statsPaneScrollChild:Size(169, 0)
	statsPaneScrollChild:Point("TOPLEFT")

	for i = 1, 8 do
		local button = CreateFrame("Frame", "CharacterStatsPaneCategory"..i, statsPaneScrollChild)
		button:Size(169, 0)

		button.Toolbar = CreateFrame("Button", nil, button)
		button.Toolbar:RegisterForDrag("LeftButton")
		button.Toolbar:Size(150, 18)
		button.Toolbar:Point("TOP")
		button.Toolbar:SetTemplate("Default", true)
		button.Toolbar:HookScript("OnEnter", S.SetModifiedBackdrop)
		button.Toolbar:HookScript("OnLeave", S.SetOriginalBackdrop)

		button.Toolbar:SetScript("OnClick", function(self)
			if self:GetParent().collapsed then
				PaperDollFrame_ExpandStatCategory(self:GetParent())
				CharacterStatsPane.collapsedData[self:GetParent().Category] = false
			else
				PaperDollFrame_CollapseStatCategory(self:GetParent())
				CharacterStatsPane.collapsedData[self:GetParent().Category] = true
			end
		end)
		button.Toolbar:SetScript("OnDragStart", function(self)
			PaperDollStatCategory_OnDragStart(self:GetParent())
		end)
		button.Toolbar:SetScript("OnDragStop", function(self)
			PaperDollStatCategory_OnDragStop(self:GetParent())
		end)

		button.NameText = button.Toolbar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		button.NameText:Point("CENTER")

		button.Stats = {}
		button.Stats[1] = CreateFrame("Frame", "$parentStat1", button, "CharacterStatFrameTemplate")
		button.Stats[1]:Point("TOPLEFT", 0, -23)
		button.Stats[1]:Point("RIGHT", -4, 0)

		statsPane.Categories[i] = button
	end

	statsPane:SetScrollChild(statsPaneScrollChild)

	CharacterStatsPaneScrollBar.Show = function(self)
		statsPane:Width(169)
		statsPane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)
		for _, button in next, statsPane.Categories do
			button:Width(169)
			button.Toolbar:Width(132)
		end
		getmetatable(self).__index.Show(self)
	end

	CharacterStatsPaneScrollBar.Hide = function(self)
		statsPane:Width(190)
		statsPane:Point("TOPRIGHT", CharacterFrame.backdrop, -8, -64)
		for _, button in next, statsPane.Categories do
			button:Width(190)
			button.Toolbar:Width(150)
		end
		getmetatable(self).__index.Hide(self)
	end

	local equipmentManagerPane = CreateFrame("ScrollFrame", "PaperDollEquipmentManagerPane", PaperDollFrame, "HybridScrollFrameTemplate")
	equipmentManagerPane:Hide()
	equipmentManagerPane:Size(169, 350)
	equipmentManagerPane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)

	equipmentManagerPane.EquipSet = CreateFrame("Button", "$parentEquipSet", equipmentManagerPane, "UIPanelButtonTemplate")
	equipmentManagerPane.EquipSet:SetText(EQUIPSET_EQUIP)
	equipmentManagerPane.EquipSet:Size(93, 22)
	equipmentManagerPane.EquipSet:Point("TOPLEFT")
	S:HandleButton(equipmentManagerPane.EquipSet)

	equipmentManagerPane.EquipSet:SetScript("OnClick", function()
		local selectedSetName = PaperDollEquipmentManagerPane.selectedSetName
		if selectedSetName and selectedSetName ~= "" then
			PlaySound("igCharacterInfoTab")
			EquipmentManager_EquipSet(selectedSetName)
		end
	end)

	equipmentManagerPane.SaveSet = CreateFrame("Button", "$parentSaveSet", equipmentManagerPane, "UIPanelButtonTemplate")
	equipmentManagerPane.SaveSet:SetText(SAVE)
	equipmentManagerPane.SaveSet:Size(94, 22)
	equipmentManagerPane.SaveSet:Point("LEFT", "$parentEquipSet", "RIGHT", 3, 0)
	S:HandleButton(equipmentManagerPane.SaveSet)

	equipmentManagerPane.SaveSet:SetScript("OnClick", GearManagerDialogSaveSet_OnClick)

	equipmentManagerPane.scrollBar = CreateFrame("Slider", "$parentScrollBar", equipmentManagerPane, "HybridScrollBarTemplate")
	equipmentManagerPane.scrollBar:Point("TOPLEFT", equipmentManagerPane, "TOPRIGHT", 3, -19)
	equipmentManagerPane.scrollBar:Point("BOTTOMLEFT", equipmentManagerPane, "BOTTOMRIGHT", 3, 17)
	S:HandleScrollBar(equipmentManagerPane.scrollBar)

	CreateSmoothScrollAnimation(equipmentManagerPane.scrollBar, true)

	equipmentManagerPane.scrollBar.Show = function(self)
		equipmentManagerPane.EquipSet:Width(83)
		equipmentManagerPane.SaveSet:Width(83)

		equipmentManagerPane:Width(169)
		equipmentManagerPane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)
		for _, button in next, equipmentManagerPane.buttons do
			button:Width(169)
		end
		getmetatable(self).__index.Show(self)
	end

	equipmentManagerPane.scrollBar.Hide = function(self)
		equipmentManagerPane.EquipSet:Width(93)
		equipmentManagerPane.SaveSet:Width(94)

		equipmentManagerPane:Width(190)
		equipmentManagerPane:Point("TOPRIGHT", CharacterFrame.backdrop, -8, -64)
		for _, button in next, equipmentManagerPane.buttons do
			button:Width(190)
		end
		getmetatable(self).__index.Hide(self)
	end

	equipmentManagerPane:SetFrameLevel(CharacterFrame:GetFrameLevel() + 1)
	equipmentManagerPane.EquipSet:SetFrameLevel(equipmentManagerPane:GetFrameLevel() + 3)
	equipmentManagerPane.SaveSet:SetFrameLevel(equipmentManagerPane:GetFrameLevel() + 3)

	HybridScrollFrame_OnLoad(equipmentManagerPane)
	equipmentManagerPane.update = self.PaperDollEquipmentManagerPane_Update
	HybridScrollFrame_CreateButtons(equipmentManagerPane, "GearSetButtonTemplate2", 2, -(equipmentManagerPane.EquipSet:GetHeight() + 4))

	equipmentManagerPane:RegisterEvent("EQUIPMENT_SWAP_FINISHED")
	equipmentManagerPane:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	equipmentManagerPane:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	equipmentManagerPane:RegisterEvent("BAG_UPDATE")

	equipmentManagerPane:SetScript("OnShow", function(self)
		module:PaperDollEquipmentManagerPane_Update()
		PaperDollFrameItemPopoutButton_ShowAll()
	end)

	equipmentManagerPane:SetScript("OnHide", function()
		PaperDollFrame_ClearIgnoredSlots()
		PaperDollFrameItemPopoutButton_HideAll()
		GearManagerDialogPopup:Hide()
		StaticPopup_Hide("CONFIRM_SAVE_EQUIPMENT_SET")
		StaticPopup_Hide("CONFIRM_OVERWRITE_EQUIPMENT_SET")
	end)

	equipmentManagerPane:SetScript("OnEvent", function(self, event, ...)
		if event == "EQUIPMENT_SWAP_FINISHED" then
			local completed, setName = ...
			if completed then
				if self:IsShown() then
					self.selectedSetName = setName
					module:PaperDollEquipmentManagerPane_Update()
				end
			end
		end

		if self:IsShown() then
			if event == "EQUIPMENT_SETS_CHANGED" then
				module:PaperDollEquipmentManagerPane_Update()
			elseif event == "PLAYER_EQUIPMENT_CHANGED" or event == "BAG_UPDATE" then
				self.queuedUpdate = true
			end
		end
	end)

	equipmentManagerPane:SetScript("OnUpdate", function(self)
		for i = 1, #self.buttons do
			local button = self.buttons[i]
			if button:IsMouseOver() then
				if button.name then
					button.DeleteButton:Show()
					button.EditButton:Show()
				else
					button.DeleteButton:Hide()
					button.EditButton:Hide()
				end
				button.HighlightBar:Show()
			else
				button.DeleteButton:Hide()
				button.EditButton:Hide()
				button.HighlightBar:Hide()
			end
		end
		if self.queuedUpdate then
			module:PaperDollEquipmentManagerPane_Update()
			self.queuedUpdate = false
		end
	end)

	GearManagerDialogPopup:SetParent(PaperDollFrame)
	GearManagerDialogPopup:ClearAllPoints()
	GearManagerDialogPopup:Point("BOTTOMLEFT", CharacterFrame.backdrop, "BOTTOMRIGHT", -6, -8)

	CharacterModelFrame:Size(237, 324)

	if not E.private.enhanced.character.player.orderName2 then
		E.private.enhanced.character.player.orderName2 = E.private.enhanced.character.player.orderName
		E.private.enhanced.character.player.collapsedName2 = table.copy(E.private.enhanced.character.player.collapsedName)
	end

	local activeSpec = GetActiveTalentGroup()
	if activeSpec == 1 then
		self:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.player.orderName, E.private.enhanced.character.player.collapsedName, "player")
	else
		self:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.player.orderName2, E.private.enhanced.character.player.collapsedName2, "player")
	end

	PaperDollFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
	PaperDollFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")

	PaperDollFrame:SetScript("OnEvent", function(self, event, unit)
		if event == "PLAYER_ENTERING_WORLD" or (event == "UNIT_MODEL_CHANGED" and unit == "player") then
			CharacterModelFrame:SetUnit("player")
			return
		elseif event == "KNOWN_TITLES_UPDATE" or (event == "UNIT_NAME_UPDATE" and unit == "player") then
			if PaperDollTitlesPane:IsShown() then
				module:PaperDollTitlesPane_Update()
			end
		end

		if not self:IsVisible() then return end

		if unit == "player" then
			if event == "UNIT_LEVEL" then
				module:PaperDollFrame_SetLevel()
			elseif event == "UNIT_DAMAGE" or event == "PLAYER_DAMAGE_DONE_MODS" or event == "UNIT_ATTACK_SPEED" or event == "UNIT_RANGEDDAMAGE" or event == "UNIT_ATTACK" or event == "UNIT_STATS" or event == "UNIT_RANGED_ATTACK_POWER" or event == "UNIT_RESISTANCES" then
				self:SetScript("OnUpdate", PaperDollFrame_QueuedUpdate)
			end
		end

		if event == "COMBAT_RATING_UPDATE" then
			self:SetScript("OnUpdate", PaperDollFrame_QueuedUpdate)
		elseif event == "PLAYER_TALENT_UPDATE" then
			module:PaperDollFrame_SetLevel()
		elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
			if GetActiveTalentGroup() == 1 then
				module:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.player.orderName, E.private.enhanced.character.player.collapsedName, "player")
			else
				module:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.player.orderName2, E.private.enhanced.character.player.collapsedName2, "player")
			end
		end
	end)

	PaperDollFrame:SetScript("OnShow", function()
		module:PaperDollFrame_SetLevel()

		if UnitHasRelicSlot("player") then
			CharacterAmmoSlot:Hide()
		else
			CharacterAmmoSlot:Show()
		end

		if PaperDollFrame.currentSideBarID == 2 then
			module:PaperDollTitlesPane_Update()
		end

		if GetActiveTalentGroup() == 1 then
			module:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.player.orderName, E.private.enhanced.character.player.collapsedName, "player")
		else
			module:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.player.orderName2, E.private.enhanced.character.player.collapsedName2, "player")
		end

		if E.private.enhanced.character.collapsed then
			module:CharacterFrame_Collapse()
		else
			module:CharacterFrame_Expand()
		end

		CharacterFrameExpandButton:Show()
		CharacterFrameExpandButton.collapseTooltip = L["Hide Character Information"]
		CharacterFrameExpandButton.expandTooltip = L["Show Character Information"]
	end)

	PaperDollFrame:SetScript("OnHide", function(self)
		module:CharacterFrame_Collapse()
		CharacterFrameExpandButton:Hide()
		if MOVING_STAT_CATEGORY then
			PaperDollStatCategory_OnDragStop(MOVING_STAT_CATEGORY)
		end
	end)
end

do -- PetFrame
	PetNameText:ClearAllPoints()
	PetNameText:Point("CENTER", CharacterFrame.backdrop, 0, 200)

	PetLevelText:ClearAllPoints()
	PetLevelText:Point("TOP", CharacterFrame.backdrop, 0, -20)

	PetPaperDollCloseButton:Kill()
	PetAttributesFrame:Kill()
	PetResistanceFrame:Kill()

	PetModelFrame:Size(325, 324)
	PetModelFrame:Point("TOPLEFT", 19, -76)

	PetModelFrameRotateLeftButton:Point("TOPLEFT", PetPaperDollFrame, "TOPLEFT", 23, -80)

	PetPaperDollFrameExpBar:Width(297)
	PetPaperDollFrameExpBar:Point("BOTTOMLEFT", 20, 88)

	self:PaperDoll_InitStatCategories(PETPAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.pet.orderName, E.private.enhanced.character.pet.collapsedName, "pet")

	PetPaperDollFrame:SetScript("OnEvent", function(self, event, unit)
		if event == "PET_UI_UPDATE" or event == "PET_UI_CLOSE" or event == "PET_BAR_UPDATE"
		or (event == "UNIT_PET" and unit == "player")
		or (event == "UNIT_NAME_UPDATE" and unit == "pet") then
			PetPaperDollFrame_UpdateTabs()

			if self:IsVisible() then
				self:SetScript("OnUpdate", PetPaperDollFrame_QueuedUpdate)
			end
		elseif event == "UNIT_PET_EXPERIENCE" then
			PetExpBar_Update()
		elseif event == "COMPANION_UPDATE" then
			if not PetPaperDollFrameCompanionFrame.idMount then
				PetPaperDollFrameCompanionFrame.idMount = GetCompanionInfo("MOUNT", 1)
			end
			if not PetPaperDollFrameCompanionFrame.idCritter then
				PetPaperDollFrameCompanionFrame.idCritter = GetCompanionInfo("CRITTER", 1)
			end

			if PetPaperDollFrameCompanionFrame:IsVisible() then
				module:PetPaperDollCompanionPane_Update()
			end
		elseif event == "COMPANION_LEARNED" then
			if not CharacterFrame:IsVisible() then
				SetButtonPulse(CharacterMicroButton, 60, 1)
			end
			if not PetPaperDollFrame:IsVisible() then
				SetButtonPulse(CharacterFrameTab2, 60, 1)
			end

			if self:IsVisible() then
				PetPaperDollFrame_UpdateTabs()
				module:PetPaperDollCompanionPane_Update()
			end
		elseif event == "COMPANION_UNLEARNED" then
			if self:IsVisible() then
				PetPaperDollFrame_UpdateTabs()
				module:PetPaperDollCompanionPane_Update()
			end
		elseif event == "SPELL_UPDATE_COOLDOWN" then
			if PetPaperDollFrameCompanionFrame:IsVisible() then
				PetPaperDollFrame_UpdateCompanionCooldowns()
			end
		elseif ((event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE") and unit == "player") then
			module:PetPaperDollCompanionPane_Update()
		elseif event == "PET_SPELL_POWER_UPDATE" then
			if self:IsVisible() then
				self:SetScript("OnUpdate", PetPaperDollFrame_QueuedUpdate)
			end
		elseif unit == "pet" then
			if self:IsVisible() then
				self:SetScript("OnUpdate", PetPaperDollFrame_QueuedUpdate)
			end
		end
	end)

	PetPaperDollFramePetFrame:HookScript("OnShow", function()
		if E.private.enhanced.character.collapsed then
			module:CharacterFrame_Collapse()
		else
			module:CharacterFrame_Expand()
		end

		CharacterFrameExpandButton:Show()
		CharacterFrameExpandButton.collapseTooltip = L["Hide Pet Information"]
		CharacterFrameExpandButton.expandTooltip = L["Show Pet Information"]

		module:PaperDoll_InitStatCategories(PETPAPERDOLL_STATCATEGORY_DEFAULTORDER, E.private.enhanced.character.pet.orderName, E.private.enhanced.character.pet.collapsedName, "pet")

		module:PaperDollFrame_UpdateStats()
	end)

	PetPaperDollFramePetFrame:HookScript("OnHide", function()
		if PaperDollFrame:IsShown() then return end

		module:CharacterFrame_Collapse()
		CharacterFrameExpandButton:Hide()
	end)
end

do -- CompanionFrame
	CompanionModelFrame:Size(325, 352)
	CompanionModelFrame:Point("TOPLEFT", 19, -76)

	CompanionModelFrameRotateLeftButton:Point("TOPLEFT", PetPaperDollFrame, "TOPLEFT", 23, -80)

	CompanionSelectedName:ClearAllPoints()
	CompanionSelectedName:Point("BOTTOM", CompanionModelFrame, "BOTTOM", 0, 10)
	CompanionSelectedName:SetParent(CompanionModelFrame)
	CompanionSelectedName:SetTextColor(1, 1, 1)

	CompanionPageNumber:Kill()
	CompanionSummonButton:Kill()
	for i = 1, 12 do
		_G["CompanionButton"..i]:Kill()
		_G["CompanionButton"..i].Disable = E.noop
		_G["CompanionButton"..i].Enable = E.noop
	end
	CompanionPrevPageButton:Kill()
	CompanionNextPageButton:Kill()

	local companionPane = CreateFrame("ScrollFrame", "PetPaperDollCompanionPane", PetPaperDollFrameCompanionFrame, "HybridScrollFrameTemplate")
	companionPane:Hide()
	companionPane:Size(169, 350)
	companionPane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)

	companionPane.text = companionPane:CreateFontString(nil, "OVERLAY")
	companionPane.text:Size(169, 20)
	companionPane.text:Point("BOTTOM", PetPaperDollCompanionPane, "TOP", 0, 7)
	companionPane.text:FontTemplate()

	companionPane.scrollBar = CreateFrame("Slider", "$parentScrollBar", companionPane, "HybridScrollBarTemplate")
	companionPane.scrollBar:Point("TOPLEFT", companionPane, "TOPRIGHT", 3, -19)
	companionPane.scrollBar:Point("BOTTOMLEFT", companionPane, "BOTTOMRIGHT", 3, 17)
	S:HandleScrollBar(companionPane.scrollBar)

	CreateSmoothScrollAnimation(companionPane.scrollBar, true)

	companionPane.scrollBar.Show = function(self)
		companionPane:Width(169)
		companionPane:Point("TOPRIGHT", CharacterFrame.backdrop, -29, -64)
		for _, button in next, companionPane.buttons do
			button:Width(169)
		end
		getmetatable(self).__index.Show(self)
	end

	companionPane.scrollBar.Hide = function(self)
		companionPane:Width(190)
		companionPane:Point("TOPRIGHT", CharacterFrame.backdrop, -8, -64)
		for _, button in next, companionPane.buttons do
			button:Width(190)
		end
		getmetatable(self).__index.Hide(self)
	end

	companionPane.update = self.PetPaperDollCompanionPane_Update
	HybridScrollFrame_CreateButtons(companionPane, "CompanionButtonTemplate2", 2)

	PetPaperDollFrameCompanionFrame:HookScript("OnShow", function(self)
		if not CharacterFrame.Expanded then
			module:CharacterFrame_Expand(true)
		end
		module:PetPaperDollCompanionPane_Update()
	end)

	PetPaperDollFrameCompanionFrame:HookScript("OnHide", function(self)
		if PaperDollFrame:IsShown() or PetPaperDollFramePetFrame:IsShown() then return end
		module:CharacterFrame_Collapse(true)
	end)
end

	hooksecurefunc("PetPaperDollFrame_SetTab", function(id)
		if id == 1 and HasPetUI() then
			PetPaperDollCompanionPane:Hide()
		elseif (id == 2 and GetNumCompanions("CRITTER") > 0)
		or (id == 3 and GetNumCompanions("MOUNT") > 0)
		then
			PetPaperDollCompanionPane:Show()
			module:PetPaperDollCompanionPane_Update()
		end
	end)

	self.Initialized = true

	self:UpdateCharacterModelFrame()
	self:UpdatePetModelFrame()
	self:UpdateCompanionModelFrame()

	self:RegisterEvent("ADDON_LOADED", function(event, addon)
		if addon == "Blizzard_InspectUI" then
			module:UnregisterEvent(event)
			module:SecureHook("InspectFrame_UpdateTalentTab", "UpdateInspectModelFrame")
		end
	end)
end

local function InitializeCallback()
	module:Initialize()
end

E:RegisterModule(module:GetName(), InitializeCallback)