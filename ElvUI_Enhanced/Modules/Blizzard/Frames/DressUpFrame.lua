local E, L, V, P, G = unpack(ElvUI)
local mod = E:GetModule("Enhanced_Blizzard")
local S = E:GetModule("Skins")

function mod:UpdateDressUpFrame()
	local mult = E.db.enhanced.blizzard.dressUpFrame.multiplier
	if ElvCharacterDB.Enhanced.ResizeDressUp then
		DressUpFrame:SetSize(384 * mult, 512 * mult)

		DressUpFrameResizeButton.text:SetText("-")
	else
		DressUpFrame:SetSize(384, 512)

		DressUpFrameResizeButton.text:SetText("+")
	end

	UpdateUIPanelPositions(DressUpFrame)
end

local function DressUpSources(appearanceSources, mainHandEnchant, offHandEnchant)
	if not appearanceSources then return true end

	local mainHandSlotID = GetInventorySlotInfo("MAINHANDSLOT")
	local secondaryHandSlotID = GetInventorySlotInfo("SECONDARYHANDSLOT")
	for i = 1, #appearanceSources do
		if i ~= mainHandSlotID and i ~= secondaryHandSlotID then
			if appearanceSources[i] and appearanceSources[i] ~= 0 then
				DressUpModel:TryOn(appearanceSources[i]);
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

function mod:DressUpFrame()
	if not E.db.enhanced.blizzard.dressUpFrame.enable then return end

	if not ElvCharacterDB.Enhanced then
		ElvCharacterDB.Enhanced = {}
	end

	--[[DressUpFrame.OutfitDropDown = CreateFrame("Frame", "DressUpFrameOutfitDropDown", DressUpFrame, "UIDropDownMenuTemplate")
	DressUpFrame.OutfitDropDown:Point("TOP", -23, -28)
	S:HandleDropDownBox(DressUpFrame.OutfitDropDown)
	DressUpFrame.OutfitDropDown:SetScript("OnShow", function(self) mod.SelectOutfit(self, nil, true) end)
	
	DressUpFrame.SaveButton = CreateFrame("Button", nil, DressUpFrame, "UIPanelButtonTemplate")
	DressUpFrame.SaveButton:Size(88, 22)
	DressUpFrame.SaveButton:Point("LEFT", DressUpFrame.OutfitDropDown, "RIGHT", -13, -3)
	DressUpFrame.SaveButton:SetText(SAVE)
	S:HandleButton(DressUpFrame.SaveButton)]]

	DressUpFrameCancelButton:ClearAllPoints()
	DressUpFrameCancelButton:SetPoint("BOTTOMRIGHT", -39, 79)

	DressUpModel:ClearAllPoints()
	DressUpModel:SetPoint("TOPLEFT", 22, -77)
	DressUpModel:SetPoint("BOTTOMRIGHT", -47, 106)

	DressUpBackgroundTopLeft:SetAlpha(0)
	DressUpBackgroundTopRight:SetAlpha(0)
	DressUpBackgroundBotLeft:SetAlpha(0)
	DressUpBackgroundBotRight:SetAlpha(0)

	DressUpModel:ClearAllPoints()
	DressUpModel:SetPoint("TOPLEFT", 22, -77)
	DressUpModel:SetPoint("BOTTOMRIGHT", -47, 106)
	DressUpModel.backdrop:SetOutside()

	local resizeButton = CreateFrame("Button", "DressUpFrameResizeButton", DressUpFrame)
	resizeButton:SetSize(32, 32)
	resizeButton:SetPoint("RIGHT", DressUpFrameCloseButton, "LEFT", 10, 0)
	S:HandleCloseButton(resizeButton, nil, "+")
	resizeButton:SetScript("OnClick", function()
		if not ElvCharacterDB.Enhanced.ResizeDressUp then
			ElvCharacterDB.Enhanced.ResizeDressUp = true
		else
			ElvCharacterDB.Enhanced.ResizeDressUp = false
		end

		mod.UpdateDressUpFrame()
	end);

	local className, classFileName = UnitClass("player")
	DressUpFrame.ModelBackground = DressUpFrame:CreateTexture()
	DressUpFrame.ModelBackground:SetAllPoints(DressUpModel)
	DressUpFrame.ModelBackground:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\backgrounds\\DressingRoom"..classFileName)
	DressUpFrame.ModelBackground:SetTexCoord(0.00195312, 0.935547, 0.00195312, 0.978516)
	DressUpFrame.ModelBackground:SetDesaturated(true)

	self:UpdateDressUpFrame()
end