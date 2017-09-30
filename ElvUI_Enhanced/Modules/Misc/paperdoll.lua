local E, L, V, P, G = unpack(ElvUI);
local PD = E:NewModule("Enhanced_PaperDoll", "AceEvent-3.0", "AceTimer-3.0");

local _G = _G
local pairs, select = pairs, select
local find, format = string.find, string.format

local CanInspect = CanInspect
local GetInventoryItemDurability = GetInventoryItemDurability
local GetInventoryItemLink = GetInventoryItemLink
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemQualityColor = GetItemQualityColor
local GetItemInfo = GetItemInfo
local InCombatLockdown = InCombatLockdown

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
}

local levelColors = {
	[0] = "|cffff0000",
	[1] = "|cff00ff00",
	[2] = "|cffffff88"
}

local heirlooms = {
	[80] = {
		44102,
		42944,
		44096,
		42943,
		42950,
		48677,
		42946,
		42948,
		42947,
		42992,
		50255,
		44103,
		44107,
		44095,
		44098,
		44097,
		44105,
		42951,
		48683,
		48685,
		42949,
		48687,
		42984,
		44100,
		44101,
		44092,
		48718,
		44091,
		42952,
		48689,
		44099,
		42991,
		42985,
		48691,
		44094,
		44093,
		42945,
		48716
	}
}

local function GetItemLvL()
	local total, item = 0, 0;
	local itemLink, itemLevel;

	for i = 1, #slots do
		itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(slots[i][1]));
		if(itemLink) then
			itemLevel = select(4, GetItemInfo(itemLink));
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

function PD:UpdatePaperDoll(inspect)
	if not self.initialized then return end

	if InCombatLockdown() then
		PD:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdatePaperDoll", inspect)
		return
	else
		PD:UnregisterEvent("PLAYER_REGEN_ENABLED")
 	end

	local unit = (inspect and InspectFrame) and InspectFrame.unit or "player"
	if not unit then return end
	if unit and not CanInspect(unit, false) then return end

	local frame, slot, current, maximum, r, g, b
	local baseName = inspect and "Inspect" or "Character"
	local itemLink, itemLevel, rarity
	local avgEquipItemLevel = GetItemLvL()

	for k, info in pairs(slots) do
		frame = _G[("%s%s"):format(baseName, k)]
		slot = GetInventorySlotInfo(k)

		if info[1] then
			frame.ItemLevel:SetText()
			if E.db.enhanced.equipment.itemlevel.enable and info[1] then
				itemLink = GetInventoryItemLink(unit, slot)

				if itemLink then
					itemLevel = self:GetItemLevel(unit, itemLink)
					rarity = select(3, GetItemInfo(itemLink))
					if itemLevel and avgEquipItemLevel then
						if E.db.enhanced.equipment.itemlevel.qualityColor then
							if rarity and rarity > 1 then
								frame.ItemLevel:SetText(itemLevel)
								frame.ItemLevel:SetTextColor(GetItemQualityColor(rarity))
							else
								frame.ItemLevel:SetText(itemLevel)
								frame.ItemLevel:SetTextColor(1, 1, 1)
							end
						else
							frame.ItemLevel:SetFormattedText("%s%d|r", levelColors[(itemLevel < avgEquipItemLevel-10 and 0 or (itemLevel > avgEquipItemLevel + 10 and 1 or (2)))], itemLevel)
						end
					end
				end
			end
		end

		if not inspect and info[2] then
			frame.DurabilityInfo:SetText()

			if E.db.enhanced.equipment.durability.enable then
				current, maximum = GetInventoryItemDurability(slot)
				if current and maximum and (not E.db.enhanced.equipment.durability.onlydamaged or current < maximum) then
					r, g, b = E:ColorGradient((current / maximum), 1, 0, 0, 1, 1, 0, 0, 1, 0)
					frame.DurabilityInfo:SetFormattedText("%s%.0f%%|r", E:RGBToHex(r, g, b), (current / maximum) * 100)
				end
			end
		end
	end
end

function PD:DelayUpdateInfo(inspect)
	if (updateTimer == 0 or PD:TimeLeft(updateTimer) == 0) then
		updateTimer = PD:ScheduleTimer("UpdatePaperDoll", 0.3, inspect)
	end
end

function PD:GetItemLevel(unit, itemLink)
	local rarity, itemLevel = select(3, GetItemInfo(itemLink))
	if rarity == 7 then
		itemLevel = self:HeirLoomLevel(unit, itemLink)
	end

	return itemLevel
end

function PD:HeirLoomLevel(unit, itemLink)
	local level = UnitLevel(unit)

	if level > 85 then level = 85 end
	if level > 80 then
		local _, _, _, _, itemId = find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
		itemId = tonumber(itemId);
		for _, id in pairs(heirlooms[80]) do
			if id == itemId then
				level = 80
				break
			end
		end
	end

	if level > 80 then
		return ((level - 81) * 12.2) + 272
	elseif level > 67 then
		return ((level - 68) * 6) + 130
	elseif level > 59 then
		return ((level - 60) * 3) + 85
	else
		return level
	end
end

function PD:InspectFrame_UpdateTabsComplete()
	originalInspectFrameUpdateTabs()
	PD:DelayUpdateInfo(true)
end

function PD:InitialUpdatePaperDoll()
	if self.initialized then return end

	PD:UnregisterEvent("PLAYER_ENTERING_WORLD")

	LoadAddOn("Blizzard_InspectUI")

	self:BuildInfoText("Character")
	self:BuildInfoText("Inspect")

	originalInspectFrameUpdateTabs = _G.InspectFrame_UpdateTabs
	_G.InspectFrame_UpdateTabs = PD.InspectFrame_UpdateTabsComplete

	self:ScheduleTimer("UpdatePaperDoll", 5, false)

	self.initialized = true
end

function PD:UpdateInfoText(name)
	local db = E.db.enhanced.equipment
	local frame
	for k, info in pairs(slots) do
		frame = _G[("%s%s"):format(name, k)]

		if info[1] then
			frame.ItemLevel:ClearAllPoints()
			frame.ItemLevel:Point(db.itemlevel.position, frame, db.itemlevel.xOffset, db.itemlevel.yOffset)
			frame.ItemLevel:FontTemplate(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)
		end

		if name == "Character" and info[2] then
			frame.DurabilityInfo:ClearAllPoints()
			frame.DurabilityInfo:Point(db.durability.position, frame, db.durability.xOffset, db.durability.yOffset)
			frame.DurabilityInfo:FontTemplate(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)
		end
	end
end

function PD:BuildInfoText(name)
	local frame
	for k, info in pairs(slots) do
		frame = _G[("%s%s"):format(name, k)]

		if info[1] then
			frame.ItemLevel = frame:CreateFontString(nil, "OVERLAY")
		end

		if name == "Character" and info[2] then
			frame.DurabilityInfo = frame:CreateFontString(nil, "OVERLAY")
		end
	end
	self:UpdateInfoText(name)
end

function PD:Initialize()
	PD:RegisterEvent("UPDATE_INVENTORY_DURABILITY", "UpdatePaperDoll", false)
	PD:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdatePaperDoll", false)
	PD:RegisterEvent("SOCKET_INFO_UPDATE", "UpdatePaperDoll", false)
	PD:RegisterEvent("COMBAT_RATING_UPDATE", "UpdatePaperDoll", false)
	PD:RegisterEvent("MASTERY_UPDATE", "UpdatePaperDoll", false)

	PD:RegisterEvent("PLAYER_ENTERING_WORLD", "InitialUpdatePaperDoll")
end

local function InitializeCallback()
	PD:Initialize()
end

E:RegisterModule(PD:GetName(), InitializeCallback)