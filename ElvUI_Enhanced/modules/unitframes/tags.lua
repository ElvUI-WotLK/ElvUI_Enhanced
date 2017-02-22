--[[
local E, L, V, P, G = unpack(ElvUI);

local ElvUF = ElvUI.oUF

local format = string.format
local select = select

local GetThreatStatusColor = GetThreatStatusColor
local UnitCanAttack = UnitCanAttack
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitIsAFK = UnitIsAFK
local UnitIsDND = UnitIsDND

local DEFAULT_AFK_MESSAGE = DEFAULT_AFK_MESSAGE

ElvUF.Tags["xafk"] = function(unit)
	local isAFK, isDND = UnitIsAFK(unit), UnitIsDND(unit)
	if isAFK then
		return format("|cffFFFFFF[|r|cffFF0000%s|r|cFFFFFFFF]|r", DEFAULT_AFK_MESSAGE)
	elseif isDND then
		return format("|cffFFFFFF[|r|cffFF0000%s|r|cFFFFFFFF]|r", L["DND"])
	else
		return ""
	end
end

ElvUF.TagEvents["xthreat:percent"] = "UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE"
ElvUF.Tags["xthreat:percent"] = function(unit)
	if UnitCanAttack("player", unit) then
		local status, percent = select(2, UnitDetailedThreatSituation("player", unit))
		if (status) then
			return format("%.0f%%", percent)
		end
		return L["None"]
	end
	return ""
end

ElvUF.TagEvents["xthreat:current"] = "UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE"
ElvUF.Tags["xthreat:current"] = function(unit)
	if UnitCanAttack("player", unit) then
		local status, _, _, threatvalue = select(2, UnitDetailedThreatSituation("player", unit))
		if (status) then
			return E:ShortValue(threatvalue / 100)
		end
		return L["None"]
	end
	return ""
end

ElvUF.TagEvents["xthreatcolor"] = "UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE"
ElvUF.Tags["xthreatcolor"] = function(unit)
	local status = select(2, UnitDetailedThreatSituation("player", unit))
	if (status) then
		return E:RGBToHex(GetThreatStatusColor(status))
	else
		return "|cff808080"
	end
end
]]