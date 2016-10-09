local E, L, V, P, G = unpack(ElvUI);
local TC = E:NewModule("TargetClass", "AceEvent-3.0");

local frame;

function TC:TargetChanged()
	frame:Hide();

	local class = UnitIsPlayer("target") and select(2, UnitClass("target")) or UnitClassification("target");
	if(class) then
		local coordinates = CLASS_ICON_TCOORDS[class];
		if(coordinates) then
			frame.Texture:SetTexCoord(coordinates[1], coordinates[2], coordinates[3], coordinates[4]);
			frame:Show();
		end
	end
end

function TC:ToggleSettings()
	local db = E.db.unitframe.units.target.classicon;
	if(db.enable) then
		frame:SetSize(db.size, db.size);
		frame:ClearAllPoints();
		frame:SetPoint("CENTER", ElvUF_Target, "TOP", db.xOffset, db.yOffset);

		self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged");
		self:TargetChanged();
	else
		self:UnregisterEvent("PLAYER_TARGET_CHANGED");
		frame:Hide();
	end
end

function TC:Initialize()
	frame = CreateFrame("Frame", "TargetClass", E.UIParent);
	frame:SetFrameLevel(12);
	frame.Texture = frame:CreateTexture(nil, "ARTWORK");
	frame.Texture:SetAllPoints();
	frame.Texture:SetTexture([[Interface\WorldStateFrame\Icons-Classes]]);

	self:ToggleSettings();
end

E:RegisterModule(TC:GetName());