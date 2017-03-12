local E, L, V, P, G = unpack(ElvUI)
local NP = E:NewModule("Enhanced_NamePlates", "AceHook-3.0", "AceEvent-3.0")
local mod = E:GetModule("NamePlates")

if not EnhancedDB then EnhancedDB = {} end
EnhancedDB.UnitClass = EnhancedDB.UnitClass or {}

local function UpdateUnitClass(frame, class)
	frame.UnitClass = class
	mod.UpdateElement_HealthOnValueChanged(frame.oldHealthBar, frame.oldHealthBar:GetValue())
	mod:UpdateElement_Name(frame)
end

function NP:UPDATE_MOUSEOVER_UNIT()
	if not UnitExists("mouseover") then return end

	if UnitIsPlayer("mouseover") then
		local name = UnitName("mouseover")
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

local function OnShowHook(frame)
	if frame.UnitFrame.UnitType ~= "FRIENDLY_PLAYER" then return end

	local class = EnhancedDB.UnitClass[frame.UnitFrame.Name:GetText()]
	if class then
		UpdateUnitClass(frame.UnitFrame, class)
	end
end

function NP:CacheUnitClass()
	if(E.db.enhanced.nameplates.cacheUnitClass) then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		
		if not self:IsHooked(mod, "OnShow") then
			self:SecureHook(mod, "OnShow", OnShowHook)
		end
	else
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		if self:IsHooked(mod, "OnShow") then
			self:Unhook(mod, "OnShow")
		end
	end
end

function NP:Initialize()
	self:CacheUnitClass()
end

E:RegisterModule(NP:GetName())