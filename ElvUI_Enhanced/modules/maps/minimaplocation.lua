local E, L, V, P, G = unpack(ElvUI);
local M = E:GetModule("Minimap");

local GetPlayerMapPosition = GetPlayerMapPosition;
local init = false;
local cluster, panel, location, xMap, yMap;

local digits = {
	[0] = {.5, "%.0f"},
	[1] = {.2, "%.1f"},
	[2] = {.1, "%.2f"},
};

local function UpdateLocation(self, elapsed)
	location.elapsed = (location.elapsed or 0) + elapsed;
	if(location.elapsed < digits[E.private.general.minimap.locationdigits][1]) then return; end

	xMap.pos, yMap.pos = GetPlayerMapPosition("player");
	xMap.text:SetFormattedText(digits[E.private.general.minimap.locationdigits][2], xMap.pos * 100);
	yMap.text:SetFormattedText(digits[E.private.general.minimap.locationdigits][2], yMap.pos * 100);

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
	xMap:Point("LEFT", panel, "LEFT", 2, 0);
	xMap:Size(40, 22);

	xMap.text = xMap:CreateFontString(nil, "OVERLAY");
	xMap.text:FontTemplate(E.media.font, 12, "OUTLINE");
	xMap.text:SetAllPoints(xMap);

	location = CreateFrame("Frame", "EnhancedLocationText", panel);
	location:SetTemplate("Transparent");
	location:Point("CENTER", panel, "CENTER", 0, 0);
	location:Size(126, 22);

	location.text = location:CreateFontString(nil, "OVERLAY");
	location.text:FontTemplate(E.media.font, 12, "OUTLINE");
	location.text:SetAllPoints(location);

	yMap = CreateFrame("Frame", "MapCoordinatesY", panel);
	yMap:SetTemplate("Transparent");
	yMap:Point("RIGHT", panel, "RIGHT", -2.5, 0);
	yMap:Size(40, 22);

	yMap.text = yMap:CreateFontString(nil, "OVERLAY");
	yMap.text:FontTemplate(E.media.font, 12, "OUTLINE");
	yMap.text:SetAllPoints(yMap);
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

local function HideMinimap()
	cluster:Hide();
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

hooksecurefunc(M, "Update_ZoneText", function()
	location.text:SetTextColor(M:GetLocTextColor());
	location.text:SetText(strsub(GetMinimapZoneText(), 1, 25));
end);

hooksecurefunc(M, "UpdateSettings", function()
	if(not E.private.general.minimap.enable) then return; end

	if(not init) then
		init = true;
		CreateEnhancedMaplocation();
	end

	if(E.private.general.minimap.hideincombat) then
		M:RegisterEvent("PLAYER_REGEN_DISABLED", HideMinimap);
		M:RegisterEvent("PLAYER_REGEN_ENABLED", ShowMinimap);
	else
		M:UnregisterEvent("PLAYER_REGEN_DISABLED");
		M:UnregisterEvent("PLAYER_REGEN_ENABLED");
	end

	local holder = _G["MMHolder"];
	panel:SetPoint("BOTTOMLEFT", holder, "TOPLEFT", -(E.PixelMode and 3 or 4), -(E.PixelMode and 3 or 2));
	panel:Size(holder:GetWidth() + (E.PixelMode and 5 or 7), 22);
	panel:Show();
	location:Width(holder:GetWidth() - 77);

	local point, relativeTo, relativePoint, xOfs, yOfs = holder:GetPoint();
	if(E.db.general.minimap.locationText == "ABOVE") then
		holder:SetPoint(point, relativeTo, relativePoint, 0, -19);
		holder:Height(holder:GetHeight() + 22);
		panel:SetScript("OnUpdate", UpdateLocation);
		panel:Show();
	else
		holder:SetPoint(point, relativeTo, relativePoint, 0, 0);
		panel:SetScript("OnUpdate", nil);
		panel:Hide();
	end
end);