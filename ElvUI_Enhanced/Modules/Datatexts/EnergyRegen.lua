local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

local format, join = string.format, string.join

local STAT_ENERGY_REGEN = STAT_ENERGY_REGEN

local displayNumberString = ""
local lastPanel

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

local function OnEvent(self)
	self.text:SetFormattedText(displayNumberString, STAT_ENERGY_REGEN, GetPowerRegen())
	lastPanel = self
end

local function ValueColorUpdate(hex)
	displayNumberString = join("", "%s: ", hex, "%.f|r")

	if lastPanel ~= nil then
		OnEvent(lastPanel)
	end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

DT:RegisterDatatext("Energy Regen", {"PLAYER_DAMAGE_DONE_MODS"}, OnEvent, nil, nil, nil, nil, ColorizeSettingName(STAT_ENERGY_REGEN))