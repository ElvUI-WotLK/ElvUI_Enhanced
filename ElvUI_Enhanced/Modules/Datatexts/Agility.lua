local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

local select = select
local format, join = string.format, string.join

local AGILITY_COLON = AGILITY_COLON
local ITEM_MOD_AGILITY_SHORT = ITEM_MOD_AGILITY_SHORT

local displayNumberString = ""
local lastPanel

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

local function OnEvent(self, event, ...)
	self.text:SetFormattedText(displayNumberString, AGILITY_COLON, select(2, UnitStat("player", 2)))
	lastPanel = self
end

local function ValueColorUpdate(hex)
	displayNumberString = join("", "%s ", hex, "%.f|r")

	if lastPanel ~= nil then
		OnEvent(lastPanel)
	end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

DT:RegisterDatatext("Agility", {"UNIT_STATS", "UNIT_AURA", "FORGE_MASTER_ITEM_CHANGED", "ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_TALENT_UPDATE"}, OnEvent, nil, nil, nil, nil, ColorizeSettingName(ITEM_MOD_AGILITY_SHORT))