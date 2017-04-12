local E, L, V, P, G = unpack(ElvUI)
local ENP = E:GetModule("Enhanced_NamePlates")
local mod = E:GetModule("NamePlates")

local UnitClass = UnitClass
local UnitExists = UnitExists
local UnitName = UnitName

if not EnhancedDB then EnhancedDB = {} end
EnhancedDB.UnitClass = EnhancedDB.UnitClass or {}

local function UpdateUnitClass(frame, class)
	frame.UnitClass = class
	mod.UpdateElement_HealthOnValueChanged(frame.oldHealthBar, frame.oldHealthBar:GetValue())
	mod:UpdateElement_Name(frame)
end

local myrealm = select(2, UnitName("player"))
function ENP:UPDATE_MOUSEOVER_UNIT()
	if not UnitExists("mouseover") then return end

	local name, realm = UnitName("mouseover")
	if realm ~= myrealm then return end

	if UnitIsPlayer("mouseover") then
		local _, class = UnitClass("mouseover")

		if EnhancedDB.UnitClass[name] ~= class then
			EnhancedDB.UnitClass[name] = class

			for frame in pairs(mod.VisiblePlates) do
				if frame and frame:IsShown() and frame.UnitName == name and frame.UnitType == "FRIENDLY_PLAYER" then
					UpdateUnitClass(frame, class)
				end
			end
		end
	end
end

local function UnitClassHook(self, frame, type)
	if type == "FRIENDLY_PLAYER" then
		local _, class = UnitClass(frame.UnitName)
		if class then
			return class
		elseif EnhancedDB.UnitClass[frame.UnitName] then
			return EnhancedDB.UnitClass[frame.UnitName]
		end
	elseif type == "ENEMY_PLAYER" then
		local r, g, b = self:RoundColors(frame.oldHealthBar:GetStatusBarColor())
		for class, _ in pairs(RAID_CLASS_COLORS) do
			if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
				return class
			end
		end
	end
end

function ENP:CacheUnitClass()
	if E.db.enhanced.nameplates.cacheUnitClass then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

		if not self:IsHooked(mod, "UnitClass") then
			self:RawHook(mod, "UnitClass", UnitClassHook)
		end
	else
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		if self:IsHooked(mod, "UnitClass") then
			self:Unhook(mod, "UnitClass")
		end
	end
end