local E, L, V, P, G = unpack(ElvUI)
local ENP = E:GetModule("Enhanced_NamePlates")
local NP = E:GetModule("NamePlates")

local pairs = pairs

local UnitClass = UnitClass

local function UnitClassHook(self, frame, unitType)
	if unitType == "FRIENDLY_PLAYER" then
		local unitName = frame.UnitName
		local unit = self[unitType][unitName]
		if unit then
			local _, class = UnitClass(unit)
			if class then
				return class
			end
		elseif EnhancedDB.UnitClass[unitName] then
			return CLASS_SORT_ORDER[EnhancedDB.UnitClass[unitName]]
		else
			return NP:GetUnitClassByGUID(frame)
		end
	elseif unitType == "ENEMY_PLAYER" then
		local r, g, b = self:RoundColors(frame.oldHealthBar:GetStatusBarColor())
		for class in pairs(RAID_CLASS_COLORS) do -- ENEMY_PLAYER
			if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
				return class
			end
		end
	end
end

function ENP:ClassCache()
	if E.db.enhanced.nameplates.classCache then
		if not self:IsHooked(NP, "UnitClass") then
			self:RawHook(NP, "UnitClass", UnitClassHook)
		end
	else
		if self:IsHooked(NP, "UnitClass") then
			self:Unhook(NP, "UnitClass")
		end
	end
end