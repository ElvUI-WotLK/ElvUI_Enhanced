local E, L, V, P, G = unpack(ElvUI);
local UF = E:GetModule("UnitFrames");

function UF:Construct_Unit_GPS(frame, unit)
	if(not frame) then return; end

	local gps = CreateFrame("Frame", nil, frame);
	gps:SetTemplate("Transparent");
	gps:EnableMouse(false);
	gps:SetFrameLevel(frame:GetFrameLevel() + 10);
	gps:Size(48, 13);
	gps:SetAlpha(.7);

	gps.Texture = gps:CreateTexture(nil, "OVERLAY");
	gps.Texture:SetTexture([[Interface\AddOns\ElvUI_Enhanced\media\textures\arrow.tga]]);
	gps.Texture:Size(12, 12);
	gps.Texture:SetPoint("LEFT", gps, "LEFT", 0, 0);

	gps.Text = gps:CreateFontString(nil, "OVERLAY");
	gps.Text:FontTemplate(E.media.font, 12, "OUTLINE");
	gps.Text:SetPoint("RIGHT", gps, "RIGHT", 0 , 0);

	UF:Configure_FontString(gps.Text);

	gps.unit = unit;
	gps:Hide();

	frame.gps = gps;

	UF:CreateAndUpdateUF(unit);
end

function UF:Construct_HealGlow(frame)
	frame:CreateShadow("Default");
	local x = frame.shadow;
	frame.shadow = nil;
	x:Hide();

	return x;
end

function UF:AddShouldIAttackIcon(frame)
	if not frame then return end

	local tag = CreateFrame("Frame", nil, frame)
	tag:SetFrameLevel(frame:GetFrameLevel() + 8)
	tag:EnableMouse(false)

	local size = frame.Health and frame.Health:GetHeight() - 16 or 24
	tag:Size(size, size)
	tag:SetAlpha(.5)

	tag.tx = tag:CreateTexture(nil, "OVERLAY")
	tag.tx:SetTexture([[Interface\AddOns\ElvUI_Enhanced\media\textures\shield.tga]])
	tag.tx:SetAllPoints()

	tag.db = E.db.unitframe.units.target.attackicon

	tag:RegisterEvent("PLAYER_TARGET_CHANGED")
	tag:RegisterEvent("UNIT_COMBAT")

	tag:SetScript("OnEvent", function()
		if UnitIsTapped("target") and not (UnitIsTappedByPlayer("target") or UnitIsTappedByAllThreatList("target")) then
			tag:Hide()
		end
		if UnitCanAttack("player", "target") and (not UnitIsTapped("target") or UnitIsTappedByAllThreatList("target")) then
			tag:Show()
		else
			tag:Hide()
		end
		--[[if tag.db.enable and not UnitIsDeadOrGhost("target") and UnitCanAttack("player", "target") then
			tag:ClearAllPoints()
			tag:SetPoint("CENTER", frame, "CENTER", tag.db.xOffset, tag.db.yOffset)
			tag:Show()
		else
			tag:Hide()
		end]]
	end)
end

function UF:EnhanceUpdateRoleIcon()
	local frameGroups = {5, 25, 40};
	local frame;

	for _, index in ipairs(frameGroups) do
		for i = 1, (index/5) do
			for j = 1, 5 do
				frame = (index == 5 and _G[("ElvUF_PartyGroup%dUnitButton%i"):format(i, j)] or index == 25 and _G[("ElvUF_RaidGroup%dUnitButton%i"):format(i, j)] or _G[("ElvUF_Raid%dGroup%dUnitButton%i"):format(index, i, j)]);
				if(frame) then
					UF:UpdateRoleIconFrame(frame, ((index == 5 and "party%d" or index == 25 and "raid" or "raid%d")):format(i));
				end
			end
		end
	end

	--UF:UpdateAllHeaders()
end

function UF:UpdateRoleIconFrame(frame)
	if(not frame) then return; end

	if(E.db.unitframe.hideroleincombat) then
		RegisterStateDriver(frame.LFDRole:GetParent(), "visibility", "[combat]hide;show");
	end
end

function UF:ApplyUnitFrameEnhancements()
	--self:AddShouldIAttackIcon(_G["ElvUF_Target"]);
	self:Construct_Unit_GPS(_G["ElvUF_Target"], "target");
	self:Construct_Unit_GPS(_G["ElvUF_Focus"], "focus");
	self:EnhanceUpdateRoleIcon();
end

local CF = CreateFrame("Frame")
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if not E.private["unitframe"].enable then return end

	UF:ApplyUnitFrameEnhancements();
end)
