local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule('UnitFrames');

local sub, find = string.sub, string.find
local abs, atan2, cos, sin, sqrt2, random, floor, ceil, random = math.abs, math.atan2, math.cos, math.sin, math.sqrt(2), math.random, math.floor, math.ceil, math.random
local pairs, type, select, unpack = pairs, type, select, unpack
local GetPlayerMapPosition, GetPlayerFacing = GetPlayerMapPosition, GetPlayerFacing
local unitframeFont

local cos, sin, sqrt2, max, atan2 = math.cos, math.sin, math.sqrt(2), math.max, math.atan2;
local pi2 = 3.141592653589793 / 2;

local function CalculateCorner(r)
	return 0.5 + cos(r) / sqrt2, 0.5 + sin(r) / sqrt2;
end

local function RotateTexture(texture, angle)
	local LRx, LRy = CalculateCorner(angle + 0.785398163);
	local LLx, LLy = CalculateCorner(angle + 2.35619449);
	local ULx, ULy = CalculateCorner(angle + 3.92699082);
	local URx, URy = CalculateCorner(angle - 0.785398163);
	
	texture:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

local GetAngle = function(unit1, unit2)
	local x1, y1 = GetPlayerMapPosition(unit1);
	if(x1 <= 0 and y1 <= 0) then return nil; end
	local x2, y2 = GetPlayerMapPosition(unit2)
	if(x2 <= 0 and y2 <= 0) then return nil; end
	return -pi2 - GetPlayerFacing() - atan2(y2 - y1, x2 - x1);
end

function UF:UpdateGPS(frame)
	local gps = frame.gps
	if not gps then return end
	
	-- GPS Disabled or not GPS parent frame visible or not in Party or Raid, Hide gps
	if not frame:IsVisible() or UnitIsUnit(gps.unit, 'player') or not (UnitInParty(gps.unit) or UnitInRaid(gps.unit)) then
		gps:Hide()
		return
	end

	-- Arbitrary method to determine if we should try to calculate the map position
	local x, y = GetAngle("player", gps.unit)
	local angle
	if not (x == 0 and y == 0) then
		-- Unit is in acceptable range, calculate position fast
		angle = GetAngle("player", gps.unit)
	end
	if not angle then
		-- no bearing show - to indicate we are lost :)
		gps.Text:SetText("-")
		gps.Texture:Hide()
		gps:Show()
		return
	end
	
	RotateTexture(gps.Texture, angle)
	gps.Texture:Show()

	gps.Text:SetFormattedText("%d", angle)
	gps:Show()
end

