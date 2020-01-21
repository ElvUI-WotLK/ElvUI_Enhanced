local E, L, V, P, G = unpack(ElvUI)
local mod = E:GetModule("Enhanced_Blizzard")
local S = E:GetModule("Skins")

function mod:UpdateDressUpFrame()
	local mult = E.db.enhanced.blizzard.dressUpFrame.multiplier

	if ElvCharacterDB.Enhanced_DressUpResize then
		DressUpFrame:Size(384 * mult, 512 * mult)
		S:SetNextPrevButtonDirection(DressUpFrameResizeButton, "up")
	else
		DressUpFrame:Size(384, 512)
		S:SetNextPrevButtonDirection(DressUpFrameResizeButton)
	end

	DressUpFrame:GetLeft() -- update size
	S:SetUIPanelWindowInfo(DressUpFrame, "width")
end

--[[
local function DressUpSources(appearanceSources, mainHandEnchant, offHandEnchant)
	if not appearanceSources then return true end

	local mainHandSlotID = GetInventorySlotInfo("MAINHANDSLOT")
	local secondaryHandSlotID = GetInventorySlotInfo("SECONDARYHANDSLOT")
	for i = 1, #appearanceSources do
		if i ~= mainHandSlotID and i ~= secondaryHandSlotID then
			if appearanceSources[i] and appearanceSources[i] ~= 0 then
				DressUpModel:TryOn(appearanceSources[i])
			end
		end
	end

	DressUpModel:TryOn(appearanceSources[mainHandSlotID], "MAINHANDSLOT", mainHandEnchant)
	DressUpModel:TryOn(appearanceSources[secondaryHandSlotID], "SECONDARYHANDSLOT", offHandEnchant)
end

function mod:SelectOutfit(outfitID, loadOutfit)
	local name
	if outfitID then
		name = C_TransmogCollection.GetOutfitName(outfitID)
	end
	if name then
		UIDropDownMenu_SetText(self, name)
	else
		outfitID = nil
		UIDropDownMenu_SetText(self, GRAY_FONT_COLOR_CODE.."TRANSMOG_OUTFIT_NONE"..FONT_COLOR_CODE_CLOSE)
	end
	self.selectedOutfitID = outfitID
	if loadOutfit then
	--	self:LoadOutfit(outfitID)
	end
	--self:UpdateSaveButton()
	--self:OnSelectOutfit(outfitID)
end
]]

function mod:DressUpFrame()
	if not E.db.enhanced.blizzard.dressUpFrame.enable then return end

	DressUpBackgroundTopLeft:SetAlpha(0)
	DressUpBackgroundTopRight:SetAlpha(0)
	DressUpBackgroundBotLeft:SetAlpha(0)
	DressUpBackgroundBotRight:SetAlpha(0)

	DressUpFrameCancelButton:ClearAllPoints()
	DressUpFrameCancelButton:Point("BOTTOMRIGHT", -40, 84)

	DressUpModel:ClearAllPoints()
	DressUpModel:Point("TOPLEFT", 20, -67)
	DressUpModel:Point("BOTTOMRIGHT", -41, 114)

	local resizeButton = CreateFrame("Button", "DressUpFrameResizeButton", DressUpFrame)
	S:HandleNextPrevButton(resizeButton, nil, nil, true)
	resizeButton:Size(26)
	resizeButton:Point("RIGHT", DressUpFrameCloseButton, "LEFT", 10, 0)
	resizeButton:SetScript("OnClick", function()
		if ElvCharacterDB.Enhanced_DressUpResize then
			ElvCharacterDB.Enhanced_DressUpResize = nil
		else
			ElvCharacterDB.Enhanced_DressUpResize = true
		end

		mod:UpdateDressUpFrame()
	end)

	local _, classFileName = UnitClass("player")
	DressUpFrame.ModelBackground = DressUpFrame:CreateTexture()
	DressUpFrame.ModelBackground:SetAllPoints(DressUpModel)
	DressUpFrame.ModelBackground:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\DressingRoom"..classFileName)
	DressUpFrame.ModelBackground:SetTexCoord(0.00195312, 0.935547, 0.00195312, 0.978516)
	DressUpFrame.ModelBackground:SetDesaturated(true)

--[[
	DressUpFrame.OutfitDropDown = CreateFrame("Frame", "DressUpFrameOutfitDropDown", DressUpFrame, "UIDropDownMenuTemplate")
	DressUpFrame.OutfitDropDown:Point("TOP", -23, -28)
	S:HandleDropDownBox(DressUpFrame.OutfitDropDown)
	DressUpFrame.OutfitDropDown:SetScript("OnShow", function(self)
		mod.SelectOutfit(self, nil, true)
	end)

	DressUpFrame.SaveButton = CreateFrame("Button", nil, DressUpFrame, "UIPanelButtonTemplate")
	DressUpFrame.SaveButton:Size(88, 22)
	DressUpFrame.SaveButton:Point("LEFT", DressUpFrame.OutfitDropDown, "RIGHT", -13, -3)
	DressUpFrame.SaveButton:SetText(SAVE)
	S:HandleButton(DressUpFrame.SaveButton)
]]

	self:UpdateDressUpFrame()
end