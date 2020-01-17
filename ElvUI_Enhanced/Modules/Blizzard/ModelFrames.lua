local E, L, V, P, G = unpack(ElvUI)
local MF = E:NewModule("Enhanced_ModelFrames", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")

local _G = _G
local max, min = math.max, math.min
local PI = math.pi

local GetCVar = GetCVar
local GetCursorPosition = GetCursorPosition
local Model_RotateLeft = Model_RotateLeft
local Model_RotateRight = Model_RotateRight

local ROTATIONS_PER_SECOND = ROTATIONS_PER_SECOND

local modelFrames = {
	"CharacterModelFrame",
	"CompanionModelFrame",
	"DressUpModel",
	"PetModelFrame",
	"PetStableModel"
}

local modelSettings = {
	["HumanMale"] = {panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 38},
	["HumanFemale"] = {panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 1.2, panMaxBottom = -0.2, panValue = 45},
	["DwarfMale"] = {panMaxLeft = -0.4, panMaxRight = 0.6, panMaxTop = 0.9, panMaxBottom = -0.2, panValue = 44},
	["DwarfFemale"] = {panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.9, panMaxBottom = -0.2, panValue = 47},
	["NightElfMale"] = {panMaxLeft = -0.5, panMaxRight = 0.5, panMaxTop = 1.5, panMaxBottom = -0.4, panValue = 30},
	["NightElfFemale"] = {panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.4, panMaxBottom = -0.4, panValue = 33},
	["GnomeMale"] = {panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.5, panMaxBottom = -0.2, panValue = 52},
	["GnomeFemale"] = {panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.5, panMaxBottom = -0.2, panValue = 60},
	["DraeneiMale"] = {panMaxLeft = -0.6, panMaxRight = 0.6, panMaxTop = 1.4, panMaxBottom = -0.4, panValue = 28},
	["DraeneiFemale"] = {panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 1.4, panMaxBottom = -0.3, panValue = 31},

	["OrcMale"] = {panMaxLeft = -0.7, panMaxRight = 0.8, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 30},
	["OrcFemale"] = {panMaxLeft = -0.4, panMaxRight = 0.3, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 37},
	["ScourgeMale"] = {panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.1, panMaxBottom = -0.3, panValue = 35},
	["ScourgeFemale"] = {panMaxLeft = -0.3, panMaxRight = 0.4, panMaxTop = 1.1, panMaxBottom = -0.3, panValue = 36},
	["TaurenMale"] = {panMaxLeft = -0.7, panMaxRight = 0.9, panMaxTop = 1.1, panMaxBottom = -0.5, panValue = 31},
	["TaurenFemale"] = {panMaxLeft = -0.5, panMaxRight = 0.6, panMaxTop = 1.3, panMaxBottom = -0.4, panValue = 32},
	["TrollMale"] = {panMaxLeft = -0.5, panMaxRight = 0.6, panMaxTop = 1.3, panMaxBottom = -0.4, panValue = 27},
	["TrollFemale"] = {panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.5, panMaxBottom = -0.4, panValue = 31},
	["BloodElfMale"] = {panMaxLeft = -0.5, panMaxRight = 0.4, panMaxTop = 1.3, panMaxBottom = -0.3, panValue = 36},
	["BloodElfFemale"] = {panMaxLeft = -0.3, panMaxRight = 0.2, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 38},
}

local playerRaceSex
do
	local _
	_, playerRaceSex = UnitRace("player")
	if UnitSex("player") == 2 then
		playerRaceSex = playerRaceSex.."Male"
	else
		playerRaceSex = playerRaceSex.."Female"
	end
end

function MF:ModelControlButton(model)
	model:Size(18, 18)

	model.icon = model:CreateTexture("$parentIcon", "ARTWORK")
	model.icon:SetInside()
	model.icon:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.icon:SetTexCoord(0.01562500, 0.26562500, 0.00781250, 0.13281250)

	model:SetScript("OnMouseDown", function(self) MF:ModelControlButton_OnMouseDown(self) end)
	model:SetScript("OnMouseUp", function(self) MF:ModelControlButton_OnMouseUp(self) end)
	model:SetScript("OnEnter", function(self)
		UIFrameFadeIn(self:GetParent(), 0.2, self:GetParent():GetAlpha(), 1)
		if GetCVar("UberTooltips") == "1" then
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:SetText(self.tooltip, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			if self.tooltipText then
				GameTooltip:AddLine(self.tooltipText, nil, nil, nil, 1, 1)
			end
			GameTooltip:Show()
		end
	end)
	model:SetScript("OnLeave", function(self)
		UIFrameFadeOut(self:GetParent(), 0.2, self:GetParent():GetAlpha(), 0.5)
		GameTooltip:Hide()
	end)
end

function MF:ModelWithControls(model)
	model.controlFrame = CreateFrame("Frame", "$parentControlFrame", model)
	model.controlFrame:Point("TOP", 0, -2)
	model.controlFrame:SetAlpha(0.5)
	model.controlFrame:Hide()

	local zoomInButton = CreateFrame("Button", "$parentZoomInButton", model.controlFrame)
	self:ModelControlButton(zoomInButton)
	zoomInButton:Point("LEFT", 2, 0)
	zoomInButton:RegisterForClicks("AnyUp")
	zoomInButton.icon:SetTexCoord(0.57812500, 0.82812500, 0.14843750, 0.27343750)
	zoomInButton.tooltip = L["Zoom In"]
	zoomInButton.tooltipText = L["Mouse Wheel Up"]
	zoomInButton:SetScript("OnMouseDown", function(self)
		MF:Model_OnMouseWheel(self:GetParent():GetParent(), 1)
	end)

	local zoomOutButton = CreateFrame("Button", "$parentZoomOutButton", model.controlFrame)
	self:ModelControlButton(zoomOutButton)
	zoomOutButton:Point("LEFT", 2, 0)
	zoomOutButton:RegisterForClicks("AnyUp")
	zoomOutButton.icon:SetTexCoord(0.29687500, 0.54687500, 0.00781250, 0.13281250)
	zoomOutButton.tooltip = L["Zoom Out"]
	zoomOutButton.tooltipText = L["Mouse Wheel Down"]
	zoomOutButton:SetScript("OnMouseDown", function(self)
		MF:Model_OnMouseWheel(self:GetParent():GetParent(), -1)
	end)

	local panButton = CreateFrame("Button", "$parentPanButton", model.controlFrame)
	self:ModelControlButton(panButton)
	panButton:Point("LEFT", 2, 0)
	panButton:RegisterForClicks("AnyUp")
	panButton.icon:SetTexCoord(0.29687500, 0.54687500, 0.28906250, 0.41406250)
	panButton.tooltip = L["Drag"]
	panButton.tooltipText = L["Right-click on character and drag to move it within the window."]
	panButton:SetScript("OnMouseDown", function(self)
		MF:ModelControlButton_OnMouseDown(self)
		MF:Model_StartPanning(self:GetParent():GetParent(), true)
	end)
	panButton:SetScript("OnMouseUp", function(self)
		MF:Model_StopPanning(model)
		MF:ModelControlButton_OnMouseUp(self)

		if not model:IsMouseOver() and not model.controlFrame:IsMouseOver() then
			model.controlFrame:Hide()
		end
	end)

	local rotateLeftButton = CreateFrame("Button", "$parentRotateLeftButton", model.controlFrame)
	self:ModelControlButton(rotateLeftButton)
	rotateLeftButton:RegisterForClicks("AnyUp")
	rotateLeftButton.icon:SetTexCoord(0.01562500, 0.26562500, 0.28906250, 0.41406250)
	rotateLeftButton.tooltip = L["Rotate Left"]
	rotateLeftButton.tooltipText = L["Left-click on character and drag to rotate."]
	rotateLeftButton:SetScript("OnClick", function(self)
		Model_RotateLeft(self:GetParent():GetParent())
	end)
	model.controlFrame.rotateLeftButton = rotateLeftButton

	local rotateRightButton = CreateFrame("Button", "$parentRotateRightButton", model.controlFrame)
	self:ModelControlButton(rotateRightButton)
	rotateRightButton:RegisterForClicks("AnyUp")
	rotateRightButton.icon:SetTexCoord(0.57812500, 0.82812500, 0.28906250, 0.41406250)
	rotateRightButton.tooltip = L["Rotate Right"]
	rotateRightButton.tooltipText = L["Left-click on character and drag to rotate."]
	rotateRightButton:SetScript("OnClick", function(self)
		Model_RotateRight(self:GetParent():GetParent())
	end)
	model.controlFrame.rotateRightButton = rotateRightButton

	local rotateResetButton = CreateFrame("Button", "$parentrotateResetButton", model.controlFrame)
	self:ModelControlButton(rotateResetButton)
	rotateResetButton:RegisterForClicks("AnyUp")
	rotateResetButton.tooltip = L["Reset Position"]
	rotateResetButton:SetScript("OnClick", function(self)
		MF:Model_Reset(self:GetParent():GetParent())
	end)

	if E.private.skins.blizzard.enable then
		model.controlFrame:Size(123, 23)

		S:HandleButton(zoomInButton)

		S:HandleButton(zoomOutButton)
		zoomOutButton:Point("LEFT", "$parentZoomInButton", "RIGHT", 2, 0)

		S:HandleButton(panButton)
		panButton:Point("LEFT", "$parentZoomOutButton", "RIGHT", 2, 0)

		S:HandleButton(rotateLeftButton)
		rotateLeftButton:Point("LEFT", "$parentPanButton", "RIGHT", 2, 0)

		S:HandleButton(rotateRightButton)
		rotateRightButton:Point("LEFT", "$parentRotateLeftButton", "RIGHT", 2, 0)

		S:HandleButton(rotateResetButton)
		rotateResetButton:Point("LEFT", "$parentRotateRightButton", "RIGHT", 2, 0)
	else
		model.controlFrame:Size(114, 23)
		zoomOutButton:SetPoint("LEFT", "$parentZoomInButton", "RIGHT")
		panButton:SetPoint("LEFT", "$parentZoomOutButton", "RIGHT")
		rotateLeftButton:SetPoint("LEFT", "$parentPanButton", "RIGHT")
		rotateRightButton:SetPoint("LEFT", "$parentRotateLeftButton", "RIGHT")
		rotateResetButton:SetPoint("LEFT", "$parentRotateRightButton", "RIGHT")
	end

	model.controlFrame:SetScript("OnHide", function(self)
		if self.buttonDown then
			MF:ModelControlButton_OnMouseUp(self.buttonDown)
		end
	end)

	self:HookScript(model, "OnUpdate", "Model_OnUpdate")
	model:SetScript("OnMouseWheel", function(self, delta)
		MF:Model_OnMouseWheel(self, delta)
	end)
	model:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and self.panning then
			MF:Model_StopPanning(self)
		elseif self.mouseDown then
			MF:Model_OnMouseUp(self, button)
		end
	end)
	model:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" and not self.mouseDown then
			MF:Model_StartPanning(self)
		else
			MF:Model_OnMouseDown(self, button)
		end
	end)
	model:SetScript("OnEnter", function(self)
		self.controlFrame:Show()
	end)
	model:SetScript("OnLeave", function(self)
		if not self.controlFrame:IsMouseOver() and not ModelPanningFrame:IsShown() then
			self.controlFrame:Hide()
		end
	end)
	model:SetScript("OnHide", function(self)
		if self.panning then
			MF:Model_StopPanning(self)
		end
		self.mouseDown = false
		self.controlFrame:Hide()
		MF:Model_Reset(self)
	end)
end

function MF:Model_OnMouseWheel(model, delta, maxZoom, minZoom)
	maxZoom = maxZoom or 2.8
	minZoom = minZoom or 0
	local zoomLevel = model.zoomLevel or minZoom
	zoomLevel = zoomLevel + delta * 0.5
	zoomLevel = min(zoomLevel, maxZoom)
	zoomLevel = max(zoomLevel, minZoom)
	local _, y, z = model:GetPosition()
	model:SetPosition(zoomLevel, y, z)
	model.zoomLevel = zoomLevel
end

function MF:Model_OnMouseDown(model, button)
	if not button or button == "LeftButton" then
		model.mouseDown = true
		model.rotationCursorStart = GetCursorPosition()
	end
end

function MF:Model_OnMouseUp(model, button)
	if not button or button == "LeftButton" then
		model.mouseDown = false
	end
end

function MF:Model_OnUpdate(frame, elapsedTime, rotationsPerSecond)
	if not rotationsPerSecond then
		rotationsPerSecond = ROTATIONS_PER_SECOND
	end

	if frame.mouseDown then
		if frame.rotationCursorStart then
			local cursorX = GetCursorPosition()
			local diff = (cursorX - frame.rotationCursorStart) * 0.010

			frame.rotationCursorStart = cursorX
			frame.rotation = frame.rotation + diff

			if frame.rotation < 0 then
				frame.rotation = frame.rotation + (2 * PI)
			end

			if frame.rotation > (2 * PI) then
				frame.rotation = frame.rotation - (2 * PI)
			end

			frame:SetRotation(frame.rotation, false)
		end
	elseif frame.panning then
		local modelScale = frame:GetModelScale()
		local cursorX, cursorY = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		ModelPanningFrame:Point("BOTTOMLEFT", cursorX / scale - 16, cursorY / scale - 16)	-- half the texture size to center it on the cursor
		-- settings
		local settings = modelSettings[playerRaceSex]

		local zoom = 1 + (frame.zoomLevel or 0)

		-- Panning should require roughly the same mouse movement regardless of zoom level so the model moves at the same rate as the cursor
		-- This formula more or less works for all zoom levels, found via trial and error
		local transformationRatio = settings.panValue * 2 ^ (zoom * 1.25) * scale / modelScale

		local dx = (cursorX - frame.cursorX) / transformationRatio
		local dy = (cursorY - frame.cursorY) / transformationRatio
		local cameraY = frame.cameraY + dx
		local cameraZ = frame.cameraZ + dy
		-- bounds
		scale = scale * modelScale

		local maxCameraY = settings.panMaxRight * zoom * scale
		cameraY = min(cameraY, maxCameraY)

		local minCameraY = settings.panMaxLeft * zoom * scale
		cameraY = max(cameraY, minCameraY)

		local maxCameraZ = settings.panMaxTop * zoom * scale
		cameraZ = min(cameraZ, maxCameraZ)

		local minCameraZ = settings.panMaxBottom * zoom * scale
		cameraZ = max(cameraZ, minCameraZ)

		frame:SetPosition(frame.cameraX, cameraY, cameraZ)
	end

	local leftButton, rightButton

	if frame.controlFrame then
		leftButton = frame.controlFrame.rotateLeftButton
		rightButton = frame.controlFrame.rotateRightButton
	else
		leftButton = frame:GetName() and _G[frame:GetName().."RotateLeftButton"]
		rightButton = frame:GetName() and _G[frame:GetName().."RotateRightButton"]
	end

	if leftButton and leftButton:GetButtonState() == "PUSHED" then
		frame.rotation = frame.rotation + (elapsedTime * 2 * PI * rotationsPerSecond)

		if frame.rotation < 0 then
			frame.rotation = frame.rotation + (2 * PI)
		end
	elseif rightButton and rightButton:GetButtonState() == "PUSHED" then
		frame.rotation = frame.rotation - (elapsedTime * 2 * PI * rotationsPerSecond)

		if frame.rotation > (2 * PI) then
			frame.rotation = frame.rotation - (2 * PI)
		end
	end

	frame:SetRotation(frame.rotation)
end

function MF:Model_Reset(model)
	model.rotation = 0.61
	model:SetRotation(model.rotation)
	model.zoomLevel = 0
	model:SetPosition(0, 0, 0)
end

function MF:Model_StartPanning(model, usePanningFrame)
	if usePanningFrame then
		ModelPanningFrame.model = model
		ModelPanningFrame:Show()
	end

	model.panning = true

	local cameraX, cameraY, cameraZ = model:GetPosition()
	model.cameraX = cameraX
	model.cameraY = cameraY
	model.cameraZ = cameraZ

	local cursorX, cursorY = GetCursorPosition()
	model.cursorX = cursorX
	model.cursorY = cursorY
end

function MF:Model_StopPanning(model)
	model.panning = false
	ModelPanningFrame:Hide()
end

function MF:ModelControlButton_OnMouseDown(model)
	model.icon:Point("CENTER", 1, -1)
	model:GetParent().buttonDown = model
end

function MF:ModelControlButton_OnMouseUp(model)
	model.icon:SetPoint("CENTER")
	model:GetParent().buttonDown = nil
end

function MF:ADDON_LOADED(event, addon)
	if addon == "Blizzard_InspectUI" then
		InspectModelFrame:EnableMouse(true)
		InspectModelFrame:EnableMouseWheel(true)

		InspectModelRotateLeftButton:Kill()
		InspectModelRotateRightButton:Kill()

		self:ModelWithControls(InspectModelFrame)
	elseif addon == "Blizzard_AuctionUI" then
		AuctionDressUpModel:EnableMouse(true)
		AuctionDressUpModel:EnableMouseWheel(true)

		AuctionDressUpModelRotateLeftButton:Kill()
		AuctionDressUpModelRotateRightButton:Kill()

		self:ModelWithControls(AuctionDressUpModel)
	end
end

function MF:Initialize()
	if not E.private.enhanced.character.modelFrames then return end

	for i = 1, #modelFrames do
		local model = _G[modelFrames[i]]

		model:EnableMouse(true)
		model:EnableMouseWheel(true)

		_G[modelFrames[i].."RotateLeftButton"]:Kill()
		_G[modelFrames[i].."RotateRightButton"]:Kill()

		self:ModelWithControls(model)
	end

	if E.myclass == "HUNTER" then
		if E.private.enhanced.character.enable then
			PetPaperDollPetInfo:Point("TOPLEFT", PetPaperDollFrame, 24, -81)
		else
			PetPaperDollPetInfo:Point("TOPLEFT", PetPaperDollFrame, 24, -76)
		end
		PetStablePetInfo:Point("TOPLEFT", PetStableModel, 5, -5)
	end

	local modelPanning = CreateFrame("Frame", "ModelPanningFrame", UIParent)
	modelPanning:SetFrameStrata("DIALOG")
	modelPanning:Hide()
	modelPanning:Size(32, 32)

	modelPanning.texture = modelPanning:CreateTexture(nil, "ARTWORK")
	modelPanning.texture:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-Cursor-Move")
	modelPanning.texture:SetAllPoints()

	self:RegisterEvent("ADDON_LOADED")
end

local function InitializeCallback()
	MF:Initialize()
end

E:RegisterModule(MF:GetName(), InitializeCallback)