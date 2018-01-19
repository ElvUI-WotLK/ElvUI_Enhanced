local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

local select, pairs = select, pairs
local format, join = string.format, string.join

local GetItemInfo = GetItemInfo
local GetItemCount = GetItemCount
local GetAuctionItemSubClasses = GetAuctionItemSubClasses
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemCount = GetInventoryItemCount
local GetInventorySlotInfo = GetInventorySlotInfo
local ContainerIDToInventoryID = ContainerIDToInventoryID
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetItemQualityColor = GetItemQualityColor
local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local INVTYPE_AMMO = INVTYPE_AMMO

local quiver = select(1, GetAuctionItemSubClasses(8))
local pouch = select(2, GetAuctionItemSubClasses(8))
local soulBag = select(2, GetAuctionItemSubClasses(3))

local iconString = "|T%s:16:16:0:0:64:64:4:55:4:55|t"
local displayString = ""

local lastPanel

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

local Ammo = {
	-- Arrow
	"2512",		-- Rough Arrow
	"2515",		-- Sharp Arrow
	"3030",		-- Razor Arrow
	"3464",		-- Feathered Arrow
	"9399",		-- Precision Arrow
	"11285",	-- Jagged Arrow
	"12654",	-- Doomshot
	"18042",	-- Thorium Headed Arrow
	"19316",	-- Ice Threaded Arrow
	"24417",	-- Scout's Arrow
	"28053",	-- Wicked Arrow
	"28056",	-- Blackflight Arrow
	"30319",	-- Nether Spike
	"30611",	-- Halaani Razorshaft
	"31737",	-- Timeless Arrow
	"33803",	-- Adamantite Stinger
	"34581",	-- Mysterious Arrow
	"41165",	-- Saronite Razorheads
	"41586",	-- Terrorshaft Arrow
	"52021",	-- Iceblade Arrow
	"56176",	-- Warden's Arrow
	-- Bullet
	"2516",		-- Light Shot
	"2519",		-- Heavy Shot
	"3033",		-- Solid Shot
	"3465",		-- Exploding Shot
	"4960",		-- Flash Pellet
	"5568",		-- Smooth Pebble
	"8067",		-- Crafted Light Shot
	"8068",		-- Crafted Heavy Shot
	"8069",		-- Crafted Solid Shot
	"10512",	-- Hi-Impact Mithril Slugs
	"10513",	-- Mithril Gyro-Shot
	"11284",	-- Accurate Slugs
	"11630",	-- Rockshard Pellets
	"13377",	-- Miniature Cannon Balls
	"15997",	-- Thorium Shells
	"19317",	-- Ice Threaded Bullet
	"23772",	-- Fel Iron Shells
	"23773",	-- Adamantite Shells
	"28060",	-- Impact Shot
	"28061",	-- Ironbite Shell
	"30612",	-- Halaani Grimshot
	"32882",	-- Hellfire Shot
	"32883",	-- Felbane Slugs
	"31735",	-- Timeless Shell
	"34582",	-- Mysterious Shell
	"41584",	-- Frostbite Bullets
	"41164",	-- Mammoth Cutters
	"52020",	-- Shatter Rounds
	-- Soul Shard
	"6265",		-- Soul Shard
}

local function OnEvent(self)
	local name, count, link
	if E.myclass == "WARLOCK" then
		name = GetItemInfo(6265)
		count = GetItemCount(6265)
		if count > 0 then
			self.text:SetFormattedText(displayString, name, count)
		else
			self.text:SetFormattedText(displayString, name, 0)
		end
	else
		link = GetInventoryItemLink("player", GetInventorySlotInfo("AmmoSlot"))
		count = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"))
		if link and (count > 0) then
			name = GetItemInfo(link)
			self.text:SetFormattedText(displayString, name, count)
		else
			self.text:SetFormattedText(displayString, INVTYPE_AMMO, 0)
		end
	end

	lastPanel = self
end

local function OnEnter(self)
	DT:SetupTooltip(self)
	if E.myclass == "WARLOCK" then
		DT.tooltip:AddLine(GetItemInfo(6265))
	else
		DT.tooltip:AddLine(INVTYPE_AMMO)
	end

	local r, g, b
	local count
	local _, name, quality, subclass, texture
	for _, info in pairs(Ammo) do
		name, _, quality, _, _, _, subclass, _, _, texture = GetItemInfo(info)
		count = GetItemCount(info)
		if quality then
			r, g, b = GetItemQualityColor(quality)
		else
			r, g, b = 1, 1, 1
		end

		if name and (count > 0) then
			DT.tooltip:AddDoubleLine(join("", format(iconString, texture), " ", name), count, r, g, b)
		end
	end

	local free, total, used = 0, 0, 0
	for i = 1, NUM_BAG_SLOTS do
		local bagLink = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
		if bagLink then
			name, _, quality, _, _, _, subclass, _, _, texture = GetItemInfo(bagLink)
			if quality then
				r, g, b = GetItemQualityColor(quality)
			else
				r, g, b = 1, 1, 1
			end
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
			used = total - free

			if subclass == quiver or subclass == pouch or subclass == soulBag then
				DT.tooltip:AddLine(" ")
				DT.tooltip:AddLine(subclass)
				DT.tooltip:AddDoubleLine(join("", format(iconString, texture), "  ", name), format("%d / %d", used, total), r, g, b)
			end
		end
	end

	DT.tooltip:Show()
end

local function OnClick(_, btn)
	if btn == "LeftButton" then
		if not E.bags then
			for i = 1, NUM_BAG_SLOTS do
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link then
					local subclass = select(7, GetItemInfo(link))
					if subclass == quiver or subclass == pouch or subclass == soulBag then
						ToggleBag(i)
					end
				end
			end
		else
			OpenAllBags()
		end
	end
end

local function ValueColorUpdate(hex)
	displayString = join("", "%s: ", hex, "%d|r")

	if lastPanel ~= nil then
		OnEvent(lastPanel)
	end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

DT:RegisterDatatext(INVTYPE_AMMO, {"PLAYER_ENTERING_WORLD", "BAG_UPDATE", "UNIT_INVENTORY_CHANGED"}, OnEvent, nil, OnClick, OnEnter, nil, ColorizeSettingName(INVTYPE_AMMO))