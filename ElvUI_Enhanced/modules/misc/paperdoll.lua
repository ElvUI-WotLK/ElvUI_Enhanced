local E, L, V, P, G = unpack(ElvUI);
local PD = E:NewModule("PaperDoll", "AceEvent-3.0", "AceTimer-3.0");

local find = string.find
local initialized = false
local originalInspectFrameUpdateTabs
local updateTimer

local slots = {
	["HeadSlot"] = {true, true},
	["NeckSlot"] = {true, false},
	["ShoulderSlot"] = {true, true},
	["BackSlot"] = {true, false},
	["ChestSlot"] = {true, true},
	["WristSlot"] = {true, true},
	["MainHandSlot"] = {true, true},
	["SecondaryHandSlot"] = {true, true},
	["HandsSlot"] = {true, true},
	["WaistSlot"] = {true, true},
	["LegsSlot"] = {true, true},
	["FeetSlot"] = {true, true},
	["Finger0Slot"] = {true, false},
	["Finger1Slot"] = {true, false},
	["Trinket0Slot"] = {true, false},
	["Trinket1Slot"] = {true, false},
	["RangedSlot"] = {true, true}
};

local levelColors = {
	[0] = "|cffff0000",
	[1] = "|cff00ff00",
	[2] = "|cffffff88"
};

function PD:UpdatePaperDoll(event)
	if(not initialized) then return; end

	if(InCombatLockdown()) then
		PD:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdatePaperDoll");
		return
	else
		PD:UnregisterEvent("PLAYER_REGEN_ENABLED");
	end

	local unit = InspectFrame and InspectFrame.unit or "player";
	if(not unit) then return; end
	if(unit and not CanInspect(unit, false)) then return; end

	local frame, id, durability, max, r, g, b;
	local baseName = (unit == "player" and "Character") or "Inspect";
	local link, iLevel;

	for k, info in pairs(slots) do
		frame = _G[("%s%s"):format(baseName, k)];
		id = GetInventorySlotInfo(k);

		if(info[1]) then
			frame.ItemLevel:SetText();
			if(E.private.equipment.itemlevel.enable and info[1]) then
				link = GetInventoryItemLink(unit, id);
				if(link) then
					iLevel = self:GetItemLevel(unit, link);
					if(iLevel) then
						frame.ItemLevel:SetFormattedText("%s%d|r", levelColors[1], iLevel);
					end
				end
			end
		end

		if(unit == "player" and info[2]) then
			frame.DurabilityInfo:SetText();
			if(E.private.equipment.durability.enable) then
				durability, max = GetInventoryItemDurability(id);
				if(durability and max and (not E.private.equipment.durability.onlydamaged or durability < max)) then
					r, g, b = E:ColorGradient((durability / max), 1, 0, 0, 1, 1, 0, 0, 1, 0);
					frame.DurabilityInfo:SetFormattedText("%s%.0f%%|r", E:RGBToHex(r, g, b), (durability / max) * 100);
				end
			end
		end
	end
end

function PD:GetItemLevel(unit, itemLink)
	local iLevel = select(4, GetItemInfo(itemLink));
	iLevel = tonumber(iLevel);
	return iLevel;
end

function PD:InspectFrame_UpdateTabsComplete()
	originalInspectFrameUpdateTabs();
	PD:UpdatePaperDoll();
end

function PD:InitialUpdatePaperDoll()
	PD:UnregisterEvent("PLAYER_ENTERING_WORLD");

	LoadAddOn("Blizzard_InspectUI");

	self:BuildInfoText("Character");
	self:BuildInfoText("Inspect");

	originalInspectFrameUpdateTabs = _G.InspectFrame_UpdateTabs;
	_G.InspectFrame_UpdateTabs = PD.InspectFrame_UpdateTabsComplete;

	initialized = true;
end

function PD:BuildInfoText(name)
	for k, info in pairs(slots) do
		frame = _G[("%s%s"):format(name, k)];

		if(info[1]) then
			frame.ItemLevel = frame:CreateFontString(nil, "OVERLAY");
			frame.ItemLevel:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 1, 1);
			frame.ItemLevel:FontTemplate(E.media.font, 12, "THINOUTLINE");
		end

		if(name == "Character" and info[2]) then
			frame.DurabilityInfo = frame:CreateFontString(nil, "OVERLAY");
			frame.DurabilityInfo:SetPoint("TOP", frame, "TOP", 0, -4);
			frame.DurabilityInfo:FontTemplate(E.media.font, 12, "THINOUTLINE");
		end
	end
end

function PD:Initialize()
	local frame;

	PD:RegisterEvent("UPDATE_INVENTORY_DURABILITY", "UpdatePaperDoll");
	PD:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdatePaperDoll");
	PD:RegisterEvent("SOCKET_INFO_UPDATE", "UpdatePaperDoll");
	PD:RegisterEvent("COMBAT_RATING_UPDATE", "UpdatePaperDoll");
	PD:RegisterEvent("INSPECT_TALENT_READY", "UpdatePaperDoll");

	PD:RegisterEvent("PLAYER_ENTERING_WORLD", "InitialUpdatePaperDoll");
end

E:RegisterModule(PD:GetName());