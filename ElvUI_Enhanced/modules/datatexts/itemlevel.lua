local E, L, V, P, G = unpack(ElvUI);
local DT = E:GetModule("DataTexts");
local PD = E:GetModule("PaperDoll");

local displayString = "";
local lastPanel;
local floor = math.floor;

local slots = {
	{"HeadSlot", HEADSLOT},
	{"NeckSlot", NECKSLOT},
	{"ShoulderSlot", SHOULDERSLOT},
	{"BackSlot", BACKSLOT},
	{"ChestSlot", CHESTSLOT},
	{"WristSlot", WRISTSLOT},
	{"HandsSlot", HANDSSLOT},
	{"WaistSlot", WAISTSLOT},
	{"LegsSlot", LEGSSLOT},
	{"FeetSlot", FEETSLOT},
	{"Finger0Slot", FINGER0SLOT_UNIQUE},
	{"Finger1Slot", FINGER1SLOT_UNIQUE},
	{"Trinket0Slot", TRINKET0SLOT_UNIQUE},
	{"Trinket1Slot", TRINKET1SLOT_UNIQUE},
	{"MainHandSlot", MAINHANDSLOT},
	{"SecondaryHandSlot", SECONDARYHANDSLOT},
	{"RangedSlot", RANGEDSLOT}
};

local levelColors = {
	[0] = {1, 0, 0},
	[1] = {0, 1, 0},
	[2] = {1, 1, .5}
};

local function GetItemLvL()
	local total, item = 0, 0;
	for i = 1, 17 do
		local itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(slots[i][1]));
		if(itemLink) then
			local itemLevel = PD:GetItemLevel("player", itemLink);
			if(itemLevel and itemLevel > 0) then
				item = item + 1;
				total = total + itemLevel;
			end
		end
	end

	if(total < 1) then
		return "0";
	end

	return floor(total / item);
end

local function OnEvent(self)
	self.text:SetFormattedText(displayString, L["Item Level"], GetItemLvL());
end

local function OnEnter(self)
	local avgEquipItemLevel = GetItemLvL();
	local color, itemLink, itemLevel;

	DT:SetupTooltip(self);
	DT.tooltip:AddDoubleLine(L["Item Level"], avgEquipItemLevel, 1, 1, 1, 0, 1, 0);
	DT.tooltip:AddLine(" ");

	for i = 1, 17 do
		itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(slots[i][1]));
		if(itemLink) then
			itemLevel = PD:GetItemLevel("player", itemLink);
			if(itemLevel and avgEquipItemLevel) then
				color = levelColors[(itemLevel < avgEquipItemLevel - 5 and 0 or (itemLevel > avgEquipItemLevel + 5 and 1 or 2))];
				DT.tooltip:AddDoubleLine(slots[i][2], itemLevel, 1, 1, 1, color[1], color[2], color[3])
			end
		end
	end

	DT.tooltip:Show();
end

local function ValueColorUpdate(hex)
	displayString = string.join("", "|cffffffff%s:|r", " ", hex, "%d|r");
	if(lastPanel ~= nil) then OnEvent(lastPanel); end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true;

DT:RegisterDatatext("Item Level", {"PLAYER_ENTERING_WORLD", "PLAYER_EQUIPMENT_CHANGED"}, OnEvent, nil, nil, OnEnter);