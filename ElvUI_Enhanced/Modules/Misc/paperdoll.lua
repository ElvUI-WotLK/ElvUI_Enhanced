local E, L, V, P, G = unpack(ElvUI)
local PD = E:NewModule("Enhanced_PaperDoll", "AceHook-3.0", "AceEvent-3.0")

local format = string.format
local pairs, select = pairs, select

local CanInspect = CanInspect
local GetInventoryItemDurability = GetInventoryItemDurability
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemQuality = GetInventoryItemQuality
local GetInventoryItemTexture = GetInventoryItemTexture
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemQualityColor = GetItemQualityColor
local GetItemInfo = GetItemInfo
local InCombatLockdown = InCombatLockdown

local slots = {
	["HeadSlot"] = true,
	["NeckSlot"] = false,
	["ShoulderSlot"] = true,
	["BackSlot"] = false,
	["ChestSlot"] = true,
	-- ["ShirtSlot"] = false,
	-- ["TabardSlot"] = false,
	["WristSlot"] = true,
	["HandsSlot"] = true,
	["WaistSlot"] = true,
	["LegsSlot"] = true,
	["FeetSlot"] = true,
	["Finger0Slot"] = false,
	["Finger1Slot"] = false,
	["Trinket0Slot"] = false,
	["Trinket1Slot"] = false,
	["MainHandSlot"] = true,
	["SecondaryHandSlot"] = true,
	["RangedSlot"] = true,
	-- ["AmmoSlot"] = false,
}

function PD:UpdatePaperDoll(unit)
	if not self.initialized then return end

	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", function(event) self:OnEvent(event, unit) end)
		return
	end

	unit = (unit ~= "player" and InspectFrame) and InspectFrame.unit or unit
	if not unit then return end
	if unit and not CanInspect(unit, false) then return end

	local baseName = unit == "player" and "Character" or "Inspect"
	local frame, slotID, hasItem
	local itemLink
	local _, rarity, itemLevel
	local current, maximum, r, g, b

	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", baseName, slotName)]
		slotID = GetInventorySlotInfo(slotName)
		hasItem = GetInventoryItemTexture(unit, slotID)

		if frame.ItemLevel then
			frame.ItemLevel:SetText()
			if E.db.enhanced.equipment.itemlevel.enable and (unit == "player" or (unit ~= "player" and hasItem)) then
				itemLink = GetInventoryItemLink(unit, slotID)

				if itemLink then
					_, _, rarity, itemLevel = GetItemInfo(itemLink)
					if itemLevel then
						frame.ItemLevel:SetText(itemLevel)

						if E.db.enhanced.equipment.itemlevel.qualityColor then
							frame.ItemLevel:SetTextColor()
							if rarity and rarity > 1 then
								frame.ItemLevel:SetTextColor(GetItemQualityColor(rarity))
							else
								frame.ItemLevel:SetTextColor(1, 1, 1)
							end
						else
							frame.ItemLevel:SetTextColor(1, 1, 1)
						end
					end
				end
			end
		end

		if unit == "player" and durability then
			frame.DurabilityInfo:SetText()
			if E.db.enhanced.equipment.durability.enable then
				current, maximum = GetInventoryItemDurability(slotID)
				if current and maximum and (not E.db.enhanced.equipment.durability.onlydamaged or current < maximum) then
					r, g, b = E:ColorGradient((current / maximum), 1, 0, 0, 1, 1, 0, 0, 1, 0)
					frame.DurabilityInfo:SetFormattedText("%s%.0f%%|r", E:RGBToHex(r, g, b), (current / maximum) * 100)
				end
			end
		end
	end
end

function PD:UpdateInfoText(name)
	local db = E.db.enhanced.equipment
	local frame
	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", name, slotName)]

		if frame.ItemLevel then
			frame.ItemLevel:ClearAllPoints()
			frame.ItemLevel:Point(db.itemlevel.position, frame, db.itemlevel.xOffset, db.itemlevel.yOffset)
			frame.ItemLevel:FontTemplate(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)
		end

		if name == "Character" and durability then
			frame.DurabilityInfo:ClearAllPoints()
			frame.DurabilityInfo:Point(db.durability.position, frame, db.durability.xOffset, db.durability.yOffset)
			frame.DurabilityInfo:FontTemplate(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)
		end
	end
end

function PD:BuildInfoText(name)
	local frame
	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", name, slotName)]

		frame.ItemLevel = frame:CreateFontString(nil, "OVERLAY")

		if name == "Character" and durability then
			frame.DurabilityInfo = frame:CreateFontString(nil, "OVERLAY")
		end
	end
	self:UpdateInfoText(name)
end

local function UpdateTalentTab()
	PD:UpdatePaperDoll(InspectFrame.unit)
end

function PD:OnEvent(event, unit)
	if event == "ADDON_LOADED" and unit == "Blizzard_InspectUI" then
		self:BuildInfoText("Inspect")

		self:SecureHook("InspectFrame_UpdateTalentTab", UpdateTalentTab)

		self:UnregisterEvent("ADDON_LOADED")
	elseif event == "UPDATE_INVENTORY_DURABILITY" then
		self:UpdatePaperDoll("player")
	elseif event == "UNIT_INVENTORY_CHANGED" then
		self:UpdatePaperDoll(unit)
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UpdatePaperDoll(unit)
	end
end

function PD:InitialUpdatePaperDoll()
	if self.initialized then return end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	self:BuildInfoText("Character")

	self.initialized = true
end

function PD:ToggleState(init)
	if E.db.enhanced.equipment.enable then
		if not self.initialized then
			if init then
				self:RegisterEvent("PLAYER_ENTERING_WORLD", "InitialUpdatePaperDoll")
			else
				self:InitialUpdatePaperDoll()
			end
		end

		self:UpdatePaperDoll("player")

		if self.initialized and InspectFrame_UpdateTalentTab then
			self:UpdateInfoText("Inspect")

			if not self:IsHooked("InspectFrame_UpdateTalentTab", UpdateTalentTab) then
				self:SecureHook("InspectFrame_UpdateTalentTab", UpdateTalentTab)
			end
		end

		self:RegisterEvent("UPDATE_INVENTORY_DURABILITY", "OnEvent")
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")
		self:RegisterEvent("ADDON_LOADED", "OnEvent")
	elseif self.initialized then
		self:UnhookAll()
		self:UnregisterAllEvents()

		for slotName, durability in pairs(slots) do
			if _G["Character"..slotName].ItemLevel then
				_G["Character"..slotName].ItemLevel:SetText()
			end
			if _G["Inspect"..slotName].ItemLevel then
				_G["Inspect"..slotName].ItemLevel:SetText()
			end

			if durability then
				_G["Character"..slotName].DurabilityInfo:SetText()
			end
		end
	end
end

function PD:Initialize()
	if not E.db.enhanced.equipment.enable then return end

	self:ToggleState(true)
end

local function InitializeCallback()
	PD:Initialize()
end

E:RegisterModule(PD:GetName(), InitializeCallback)