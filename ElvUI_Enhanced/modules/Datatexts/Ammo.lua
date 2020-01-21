local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")
local EE = E:GetModule("ElvUI_Enhanced")

local select = select
local format, join = string.format, string.join

local ContainerIDToInventoryID = ContainerIDToInventoryID
local GetAuctionItemSubClasses = GetAuctionItemSubClasses
local GetContainerItemID = GetContainerItemID
local GetContainerItemLink = GetContainerItemLink
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetContainerNumSlots = GetContainerNumSlots
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemLink = GetInventoryItemLink
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemCount = GetItemCount
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local INVTYPE_AMMO = INVTYPE_AMMO

local quiver = select(1, GetAuctionItemSubClasses(8))
local pouch = select(2, GetAuctionItemSubClasses(8))
local soulBag = select(2, GetAuctionItemSubClasses(3))

local iconString = "|T%s:16:16:0:0:64:64:4:55:4:55|t"
local displayString = ""

local lastPanel

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
	DT.tooltip:AddLine(INVTYPE_AMMO)

	local r, g, b
	local item, link, count
	local _, name, quality, subclass, equipLoc, texture
	local free, total, used

	for i = 0, NUM_BAG_FRAMES do
		for j = 1, GetContainerNumSlots(i) do
			item = GetContainerItemID(i, j)
			if item then
				link = GetContainerItemLink(i, j)
				name, _, quality, _, _, _, _, _, equipLoc, texture = GetItemInfo(link)
				count = GetItemCount(link)

				if equipLoc == "INVTYPE_AMMO" then
					r, g, b = GetItemQualityColor(quality)
					DT.tooltip:AddDoubleLine(join("", format(iconString, texture), " ", name), count, r, g, b)
				end
			end
		end
	end

	DT.tooltip:AddLine(" ")

	for i = 1, NUM_BAG_SLOTS do
		link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
		if link then
			name, _, quality, _, _, _, subclass, _, _, texture = GetItemInfo(link)

			if subclass == quiver or subclass == pouch or subclass == soulBag then
				r, g, b = GetItemQualityColor(quality)

				free, total = GetContainerNumFreeSlots(i), GetContainerNumSlots(i)
				used = total - free

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
E.valueColorUpdateFuncs[ValueColorUpdate] = true

DT:RegisterDatatext(INVTYPE_AMMO, {"PLAYER_ENTERING_WORLD", "BAG_UPDATE", "UNIT_INVENTORY_CHANGED"}, OnEvent, nil, OnClick, OnEnter, nil, EE:ColorizeSettingName(L["Ammo/Shard Counter"]))