local E, L, V, P, G = unpack(ElvUI);
local TC = E:NewModule("TargetClass", "AceEvent-3.0");

local select = select

local UnitClass = UnitClass
local UnitClassification = UnitClassification
local UnitIsPlayer = UnitIsPlayer

local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS

function TC:TargetChanged()
	self.frame:Hide();

	local class = UnitIsPlayer("target") and select(2, UnitClass("target")) or UnitClassification("target");
	if(class) then
		local coordinates = CLASS_ICON_TCOORDS[class];
		if(coordinates) then
			self.frame.Texture:SetTexCoord(coordinates[1], coordinates[2], coordinates[3], coordinates[4]);
			self.frame:Show();
		end
	end
end

function TC:ToggleSettings()
	local db = E.db.unitframe.units.target.classicon;
	if(db.enable) then
		self.frame:SetSize(db.size, db.size);
		self.frame:ClearAllPoints();
		self.frame:SetPoint("CENTER", ElvUF_Target, "TOP", db.xOffset, db.yOffset);

		self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged");
		self:TargetChanged();
	else
		self:UnregisterEvent("PLAYER_TARGET_CHANGED");
		self.frame:Hide();
	end
end

function TC:Initialize()
	self.frame = CreateFrame("Frame", "TargetClass", E.UIParent);
	self.frame:SetFrameLevel(12);

	self.frame.Texture = self.frame:CreateTexture(nil, "ARTWORK");
	self.frame.Texture:SetAllPoints();
	self.frame.Texture:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");

	self:ToggleSettings();
end

E:RegisterModule(TC:GetName());