local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")
local EE = E:GetModule("ElvUI_Enhanced")

local select = select
local join = string.join

local UnitStat = UnitStat

local AGILITY_COLON = AGILITY_COLON
local SPELL_STAT2_NAME = SPELL_STAT2_NAME

local displayNumberString = ""
local lastPanel

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
E.valueColorUpdateFuncs[ValueColorUpdate] = true

DT:RegisterDatatext("Agility", {"UNIT_STATS", "UNIT_AURA", "ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_TALENT_UPDATE"}, OnEvent, nil, nil, nil, nil, EE:ColorizeSettingName(SPELL_STAT2_NAME))