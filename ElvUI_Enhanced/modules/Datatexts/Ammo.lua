local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

local pairs = pairs
local format, join = string.format, string.join

local GetItemInfo = GetItemInfo
local GetItemCount = GetItemCount
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

local iconString = "|T%s:%d:%d:0:0:64:64:4:60:4:60|t"
local displayString = ""

local lastPanel

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

local Ammo = {
	-- Arrow
	["2512"] = {ID = 2512},		-- Rough Arrow
	["2515"] = {ID = 2515},		-- Sharp Arrow
	["3030"] = {ID = 3030},		-- Razor Arrow
	["3464"] = {ID = 3464},		-- Feathered Arrow
	["9399"] = {ID = 9399},		-- Precision Arrow
	["11285"] = {ID = 11285},	-- Jagged Arrow
	["19316"] = {ID = 19316},	-- Ice Threaded Arrow
	["18042"] = {ID = 18042},	-- Thorium Headed Arrow
	["12654"] = {ID = 12654},	-- Doomshot
	["28053"] = {ID = 28053},	-- Wicked Arrow
	["24417"] = {ID = 24417},	-- Scout's Arrow
	["28056"] = {ID = 28056},	-- Blackflight Arrow
	["30611"] = {ID = 30611},	-- Halaani Razorshaft
	["56176"] = {ID = 56176},	-- Warden's Arrow
	["33803"] = {ID = 33803},	-- Adamantite Stinger
	["34581"] = {ID = 34581},	-- Mysterious Arrow
	["31737"] = {ID = 31737},	-- Timeless Arrow
	["30319"] = {ID = 30319},	-- Nether Spike
	["41165"] = {ID = 41165},	-- Saronite Razorheads
	["41586"] = {ID = 41586},	-- Terrorshaft Arrow
	["52021"] = {ID = 52021},	-- Iceblade Arrow
	-- Bullet
	["2516"] = {ID = 2516},		-- Light Shot
	["4960"] = {ID = 4960},		-- Flash Pellet
	["8067"] = {ID = 8067},		-- Crafted Light Shot
	["2519"] = {ID = 2519},		-- Heavy Shot
	["5568"] = {ID = 5568},		-- Smooth Pebble
	["8068"] = {ID = 8068},		-- Crafted Heavy Shot
	["3033"] = {ID = 3033},		-- Solid Shot
	["8069"] = {ID = 8069},		-- Crafted Solid Shot
	["3465"] = {ID = 3465},		-- Exploding Shot
	["10512"] = {ID = 10512},	-- Hi-Impact Mithril Slugs
	["11284"] = {ID = 11284},	-- Accurate Slugs
	["10513"] = {ID = 10513},	-- Mithril Gyro-Shot
	["19317"] = {ID = 19317},	-- Ice Threaded Bullet
	["15997"] = {ID = 15997},	-- Thorium Shells
	["11630"] = {ID = 11630},	-- Rockshard Pellets
	["13377"] = {ID = 13377},	-- Miniature Cannon Balls
	["28060"] = {ID = 28060},	-- Impact Shot
	["23772"] = {ID = 23772},	-- Fel Iron Shells
	["28061"] = {ID = 28061},	-- Ironbite Shell
	["30612"] = {ID = 30612},	-- Halaani Grimshot
	["32883"] = {ID = 32883},	-- Felbane Slugs
	["32882"] = {ID = 32882},	-- Hellfire Shot
	["23773"] = {ID = 23773},	-- Adamantite Shells
	["34582"] = {ID = 34582},	-- Mysterious Shell
	["31735"] = {ID = 31735},	-- Timeless Shell
	["41164"] = {ID = 41164},	-- Mammoth Cutters
	["41584"] = {ID = 41584},	-- Frostbite Bullets
	["52020"] = {ID = 52020},	-- Shatter Rounds
	-- Soul Shard
	["6265"] = {ID = 6265},		-- Soul Shard
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
		name, _, quality, _, _, _, subclass, _, _, texture = GetItemInfo(info.ID)
		count = GetItemCount(info.ID)
		if quality then
			r, g, b = GetItemQualityColor(quality)
		else
			r, g, b = 1, 1, 1
		end

		if name and (count > 0) then
			DT.tooltip:AddDoubleLine(join("", format(iconString, texture, 16, 16), " ", name), count, r, g, b)
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
				DT.tooltip:AddDoubleLine(join("", format(iconString, texture, 16, 16), "  ", name), format("%d / %d", used, total), r, g, b)
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