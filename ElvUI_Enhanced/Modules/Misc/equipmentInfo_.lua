local E, L, V, P, G = unpack(ElvUI)
local EI = E:NewModule("Enhanced_EquipmentInfo", "AceHook-3.0", "AceEvent-3.0")

local _G = _G
local format = string.format
local pairs = pairs

local GetInventoryItemDurability = GetInventoryItemDurability
local GetInventoryItemID = GetInventoryItemID
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local InCombatLockdown = InCombatLockdown
local IsAddOnLoaded = IsAddOnLoaded

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

function EI:UpdatePaperDoll(unit)
	if not self.initialized then return end

	if unit == "player" and InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
		return
	elseif unit ~= "player" then
		if InspectFrame then
			unit = InspectFrame.unit

			if not unit then return end
		else
			return
		end
	end

	local baseName = unit == "player" and "Character" or "Inspect"
	local frame, slotID, itemID
	local _, rarity, itemLevel
	local current, maximum, r, g, b

	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", baseName, slotName)]

		if frame then
			slotID = GetInventorySlotInfo(slotName)

			frame.ItemLevel:SetText()

			if E.db.enhanced.equipment.itemlevel.enable then
				itemID = GetInventoryItemID(unit, slotID)

				if itemID then
					_, _, rarity, itemLevel = GetItemInfo(itemID)

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
end

function EI:BuildInfoText(name)
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

function EI:UpdateInfoText(name)
	local db = E.db.enhanced.equipment
	local frame

	for slotName, durability in pairs(slots) do
		frame = _G[format("%s%s", name, slotName)]

		if frame then
			frame.ItemLevel:ClearAllPoints()
			frame.ItemLevel:Point(db.itemlevel.position, frame, db.itemlevel.xOffset, db.itemlevel.yOffset)
			frame.ItemLevel:FontTemplate(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)

			if name == "Character" and durability then
				frame.DurabilityInfo:ClearAllPoints()
				frame.DurabilityInfo:Point(db.durability.position, frame, db.durability.xOffset, db.durability.yOffset)
				frame.DurabilityInfo:FontTemplate(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)
			end
		end
	end
end

local function InspectFrameUpdate()
	EI:UpdatePaperDoll()
end

function EI:OnEvent(event, unit)
	if event == "UPDATE_INVENTORY_DURABILITY" then
		self:UpdatePaperDoll("player")
	elseif event == "UNIT_INVENTORY_CHANGED" then
		if unit ~= "player" and InspectFrame and unit == InspectFrame.unit then
			self:UpdatePaperDoll(unit)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UpdatePaperDoll("player")
	elseif event == "ADDON_LOADED" and unit == "Blizzard_InspectUI" then
		self.initializedInspect = true
		self:UnregisterEvent("ADDON_LOADED")
		self:BuildInfoText("Inspect")
		self:HookScript(InspectFrame, "OnShow", InspectFrameUpdate)
		self:SecureHook("InspectFrame_UnitChanged", InspectFrameUpdate)
	end
end

function EI:InitialUpdatePaperDoll()
	if self.initialized then return end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:BuildInfoText("Character")

	self.initialized = true
end

function EI:UpdateText()
	self:UpdatePaperDoll("player")

	if self.initializedInspect and InspectFrame.unit then
		self:UpdatePaperDoll()
	end
end

function EI:UpdateTextSettings()
	self:UpdateInfoText("Character")

	if self.initializedInspect then
		self:UpdateInfoText("Inspect")
	end
end

function EI:ToggleState(init)
	if E.db.enhanced.equipment.enable then
		if not self.initialized then
			if init then
				self:RegisterEvent("PLAYER_ENTERING_WORLD", "InitialUpdatePaperDoll")
			else
				self:InitialUpdatePaperDoll()
			end

			if IsAddOnLoaded("Blizzard_InspectUI") or InspectFrame then
				self:OnEvent("ADDON_LOADED", "Blizzard_InspectUI")
			else
				self:RegisterEvent("ADDON_LOADED", "OnEvent")
			end
		end

		self:UpdateText()

		self:RegisterEvent("UPDATE_INVENTORY_DURABILITY", "OnEvent")
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", "OnEvent")

		if not self.initializedInspect then
			self:RegisterEvent("ADDON_LOADED", "OnEvent")
		end
	elseif self.initialized then
		self:UnhookAll()
		self:UnregisterAllEvents()

		for slotName, durability in pairs(slots) do
			_G["Character"..slotName].ItemLevel:SetText()

			if durability then
				_G["Character"..slotName].DurabilityInfo:SetText()
			end

			if self.initializedInspect then
				if _G["Inspect"..slotName].ItemLevel then
					_G["Inspect"..slotName].ItemLevel:SetText()
				end
			end
		end
	end
end

function EI:Initialize()
	if not E.db.enhanced.equipment.enable then return end

	self:ToggleState(true)
end

local function InitializeCallback()
	EI:Initialize()
end

E:RegisterModule(EI:GetName(), InitializeCallback)