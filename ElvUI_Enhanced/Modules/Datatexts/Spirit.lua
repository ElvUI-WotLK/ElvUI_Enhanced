local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

local select = select
local format, join = string.format, string.join

local SPIRIT_COLON = SPIRIT_COLON
local SPELL_STAT5_NAME = SPELL_STAT5_NAME

local displayNumberString = ""
local lastPanel

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

local function OnEvent(self)
	self.text:SetFormattedText(displayNumberString, SPIRIT_COLON, select(2, UnitStat("player", 5)))
	lastPanel = self
end

local function ValueColorUpdate(hex)
	displayNumberString = join("", "%s ", hex, "%.f|r")
	
	if lastPanel ~= nil then
		OnEvent(lastPanel)
	end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

DT:RegisterDatatext("Spirit", {"UNIT_STATS", "UNIT_AURA", "ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_TALENT_UPDATE"}, OnEvent, nil, nil, nil, nil, ColorizeSettingName(SPELL_STAT5_NAME))
