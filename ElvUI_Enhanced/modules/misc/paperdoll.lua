local E, L, V, P, G = unpack(ElvUI)
local PD = E:NewModule("Enhanced_PaperDoll", "AceHook-3.0", "AceEvent-3.0")

local format = string.format
local pairs, select = pairs, select

local CanInspect = CanInspect
local GetInventoryItemDurability = GetInventoryItemDurability
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemTexture = GetInventoryItemTexture
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemInfo = GetItemInfo
local InCombatLockdown = InCombatLockdown

local slots = {
	["HeadSlot"] = true,
	["NeckSlot"] = false,
	["ShoulderSlot"] = true,
	["BackSlot"] = false,
	["ChestSlot"] = true,
--	["ShirtSlot"] = false,
--	["TabardSlot"] = false,
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
--	["AmmoSlot"] = false,
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
	local itemLink, itemLevel
	local current, maximum, r, g, b

	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", baseName, slotName)]
		slotID = GetInventorySlotInfo(slotName)
		hasItem = GetInventoryItemTexture(unit, slotID)

		frame.ItemLevel:SetText()
		if E.db.enhanced.equipment.itemlevel.enable and (unit == "player" or (unit ~= "player" and hasItem)) then
			itemLink = GetInventoryItemLink(unit, slotID)

			if itemLink then
				itemLevel = select(4, GetItemInfo(itemLink))
				if itemLevel then
					frame.ItemLevel:SetText(itemLevel)
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

function PD:BuildInfoText(name)
	local frame
	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", name, slotName)]

		frame.ItemLevel = frame:CreateFontString(nil, "OVERLAY")
		frame.ItemLevel:Point("BOTTOMLEFT", frame, "BOTTOMLEFT", 1, 1)
		frame.ItemLevel:FontTemplate(E.media.font, 12, "THINOUTLINE")

		if name == "Character" and durability then
			frame.DurabilityInfo = frame:CreateFontString(nil, "OVERLAY")
			frame.DurabilityInfo:Point("TOP", frame, "TOP", 0, -4)
			frame.DurabilityInfo:FontTemplate(E.media.font, 12, "THINOUTLINE")
		end
	end
end

function PD:OnEvent(event, unit)
	if event == "UPDATE_INVENTORY_DURABILITY" then
		self:UpdatePaperDoll("player")
	elseif event == "UNIT_INVENTORY_CHANGED" then
		self:UpdatePaperDoll(unit)
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UpdatePaperDoll(unit)
	end
end

local function UpdateTalentTab()
	PD:UpdatePaperDoll(InspectFrame.unit)
end

function PD:InitialUpdatePaperDoll()
	if self.initialized then return end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	LoadAddOn("Blizzard_InspectUI")

	self:BuildInfoText("Character")
	self:BuildInfoText("Inspect")

	self:SecureHook("InspectFrame_UpdateTalentTab", UpdateTalentTab)

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

		if self.initialized and not self:IsHooked("InspectFrame_UpdateTalentTab", UpdateTalentTab) then
			self:SecureHook("InspectFrame_UpdateTalentTab", UpdateTalentTab)
		end

		self:RegisterEvent("UPDATE_INVENTORY_DURABILITY", "OnEvent")
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")
	elseif self.initialized then
		self:UnhookAll()
		self:UnregisterAllEvents()

		for slotName, durability in pairs(slots) do
			_G["Character"..slotName].ItemLevel:SetText()
			_G["Inspect"..slotName].ItemLevel:SetText()

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