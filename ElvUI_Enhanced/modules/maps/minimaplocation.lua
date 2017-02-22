local E, L, V, P, G = unpack(ElvUI);
local M = E:GetModule("Minimap");

local GetPlayerMapPosition = GetPlayerMapPosition;
local InCombatLockdown = InCombatLockdown;

local init = false;
local cluster, panel, location, xMap, yMap;

local digits = {
	[0] = {.5, "%.0f"},
	[1] = {.2, "%.1f"},
	[2] = {.1, "%.2f"}
};

local function UpdateLocation(self, elapsed)
	location.elapsed = (location.elapsed or 0) + elapsed;
	if(location.elapsed < digits[E.db.enhanced.minimap.locationdigits][1]) then return; end

	xMap.pos, yMap.pos = GetPlayerMapPosition("player");
	xMap.text:SetFormattedText(digits[E.db.enhanced.minimap.locationdigits][2], xMap.pos * 100);
	yMap.text:SetFormattedText(digits[E.db.enhanced.minimap.locationdigits][2], yMap.pos * 100);

	location.elapsed = 0;
end

local function CreateEnhancedMaplocation()
	cluster = _G["MinimapCluster"];

	panel = CreateFrame("Frame", "EnhancedLocationPanel", _G["MinimapCluster"]);
	panel:SetFrameStrata("BACKGROUND");
	panel:Point("CENTER", E.UIParent, "CENTER", 0, 0);
	panel:Size(206, 22);

	xMap = CreateFrame("Frame", "MapCoordinatesX", panel);
	xMap:SetTemplate("Transparent");
	xMap:Point("LEFT", panel, "LEFT", 0, 0);
	xMap:Size(40, 22);

	xMap.text = xMap:CreateFontString(nil, "OVERLAY");
	xMap.text:FontTemplate();
	xMap.text:SetAllPoints(xMap);

	yMap = CreateFrame("Frame", "MapCoordinatesY", panel);
	yMap:SetTemplate("Transparent");
	yMap:Point("RIGHT", panel, "RIGHT", 0, 0);
	yMap:Size(40, 22);

	yMap.text = yMap:CreateFontString(nil, "OVERLAY");
	yMap.text:FontTemplate();
	yMap.text:SetAllPoints(yMap);

	location = CreateFrame("Frame", "EnhancedLocationText", panel);
	location:SetTemplate("Transparent");
	location:Size(40, 22);
	location:Point("LEFT", xMap, "RIGHT", E.PixelMode and -1 or 1, 0);
	location:Point("RIGHT", yMap, "LEFT", E.PixelMode and 1 or -1, 0);

	location.text = location:CreateFontString(nil, "OVERLAY");
	location.text:FontTemplate();
	location.text:SetAllPoints(location);
end

local function FadeFrame(frame, direction, startAlpha, endAlpha, time, func)
	UIFrameFade(frame, {
		mode = direction,
		finishedFunc = func,
		startAlpha = startAlpha,
		endAlpha = endAlpha,
		timeToFade = time
	});
end

local function FadeInMinimap()
	if(not InCombatLockdown()) then
		FadeFrame(cluster, "IN", 0, 1, .5, function() if(not InCombatLockdown()) then cluster:Show(); end end);
	end
end

local function ShowMinimap()
	if(E.private.general.minimap.fadeindelay == 0) then
		FadeInMinimap();
	else
		E:Delay(E.private.general.minimap.fadeindelay, FadeInMinimap);
	end
end

local function HideMinimap()
	cluster:Hide();
end

hooksecurefunc(M, "Update_ZoneText", function()
	xMap.text:FontTemplate(E.LSM:Fetch("font", E.db.general.minimap.locationFont), E.db.general.minimap.locationFontSize, E.db.general.minimap.locationFontOutline);
	yMap.text:FontTemplate(E.LSM:Fetch("font", E.db.general.minimap.locationFont), E.db.general.minimap.locationFontSize, E.db.general.minimap.locationFontOutline);

	location.text:FontTemplate(E.LSM:Fetch("font", E.db.general.minimap.locationFont), E.db.general.minimap.locationFontSize, E.db.general.minimap.locationFontOutline);
	location.text:SetTextColor(M:GetLocTextColor());
	location.text:SetText(strsub(GetMinimapZoneText(), 1, 25));
end);

hooksecurefunc(M, "UpdateSettings", function()
	if(not E.private.general.minimap.enable) then return; end

	if(not init) then
		init = true;
		CreateEnhancedMaplocation();
	end

	if(E.db.enhanced.minimap.hideincombat) then
		M:RegisterEvent("PLAYER_REGEN_DISABLED", HideMinimap);
		M:RegisterEvent("PLAYER_REGEN_ENABLED", ShowMinimap);
	else
		M:UnregisterEvent("PLAYER_REGEN_DISABLED");
		M:UnregisterEvent("PLAYER_REGEN_ENABLED");
	end

	local holder = _G["MMHolder"];
	panel:SetPoint("BOTTOMLEFT", holder, "TOPLEFT", 0, -(E.PixelMode and 1 or -1));
	panel:Size(holder:GetWidth(), 22);

	local point, relativeTo, relativePoint = holder:GetPoint();
	if(E.db.general.minimap.locationText == "ABOVE") then
		holder:SetPoint(point, relativeTo, relativePoint, 0, -22);
		holder:Height(holder:GetHeight() + 22);
		panel:SetScript("OnUpdate", UpdateLocation);
		panel:Show();
	else
		holder:SetPoint(point, relativeTo, relativePoint, 0, 0);
		panel:SetScript("OnUpdate", nil);
		panel:Hide();
	end
end);