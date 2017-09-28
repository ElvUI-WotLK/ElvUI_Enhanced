local E, L, V, P, G, _ = unpack(ElvUI)
local module = E:NewModule("HookModelFrames", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")

local models = {
	"CharacterModelFrame",
	"DressUpModel",
	"PetModelFrame",
	"PetStableModel"
}

function module:ModelControlButton(model)
	model:SetSize(18, 18)

	model.bg = model:CreateTexture("$parentBg", "BACKGROUND")
	model.bg:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.bg:SetSize(16, 16)
	model.bg:SetPoint("CENTER")
	model.bg:SetTexCoord(0.29687500, 0.54687500, 0.14843750, 0.27343750)

	model.icon = model:CreateTexture("$parentIcon", "ARTWORK")
	model.icon:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.icon:SetSize(16, 16)
	model.icon:SetPoint("CENTER")
	model.icon:SetTexCoord(0.01562500, 0.26562500, 0.00781250, 0.13281250)

	model.highlight = model:CreateTexture("$parentHighlight", "HIGHLIGHT")
	model.highlight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.highlight:SetSize(16, 16)
	model.highlight:SetPoint("CENTER")
	model.highlight:SetTexCoord(0.57812500, 0.82812500, 0.00781250, 0.13281250)

	model:SetScript("OnMouseDown", function(self) module:ModelControlButton_OnMouseDown(self) end)
	model:SetScript("OnMouseUp", function(self) module:ModelControlButton_OnMouseUp(self) end)
	model:SetScript("OnEnter", function(self)
		UIFrameFadeIn(self:GetParent(), 0.2, self:GetParent():GetAlpha(), 1)
		if GetCVar("UberTooltips") == "1" then
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
			GameTooltip:SetText(self.tooltip, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			if self.tooltipText then
				GameTooltip:AddLine(self.tooltipText, _, _, _, 1, 1)
			end
			GameTooltip:Show()
		end
	end)
	model:SetScript("OnLeave", function(self)
		UIFrameFadeOut(self:GetParent(), 0.2, self:GetParent():GetAlpha(), 0.5)
		GameTooltip:Hide()
	end)

	if E.private.skins.blizzard.enable then
		model.bg:Hide()
	end
end

function module:ModelWithControls(model)
	model.controlFrame = CreateFrame("Frame", "$parentControlFrame", model)
	model.controlFrame:SetPoint("TOP", 0, -2)
	model.controlFrame:SetAlpha(0.5)
	model.controlFrame:Hide()

	model.controlFrame.right = model.controlFrame:CreateTexture("$parentRight", "BACKGROUND")
	model.controlFrame.right:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.controlFrame.right:SetSize(23, 23)
	model.controlFrame.right:SetPoint("RIGHT", 0, 0)
	model.controlFrame.right:SetTexCoord(0.01562500, 0.37500000, 0.42968750, 0.60937500)

	model.controlFrame.left = model.controlFrame:CreateTexture("$parentLeft", "BACKGROUND")
	model.controlFrame.left:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.controlFrame.left:SetSize(23, 23)
	model.controlFrame.left:SetPoint("LEFT", 0, 0)
	model.controlFrame.left:SetTexCoord(0.40625000, 0.76562500, 0.42968750, 0.60937500)

	model.controlFrame.middle = model.controlFrame:CreateTexture("$parentMiddle", "BACKGROUND")
	model.controlFrame.middle:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-ModelControlPanel")
	model.controlFrame.middle:SetSize(32, 23)
	model.controlFrame.middle:SetPoint("LEFT", "$parentLeft", "RIGHT", 0, 0)
	model.controlFrame.middle:SetPoint("RIGHT", "$parentRight", "LEFT", 0, 0)
	model.controlFrame.middle:SetTexCoord(0, 1, 0.62500000, 0.80468750)

	local zoomInButton = CreateFrame("Button", "$parentZoomInButton", model.controlFrame)
	self:ModelControlButton(zoomInButton)
	zoomInButton:SetPoint("LEFT", 2, 0)
	zoomInButton:RegisterForClicks("AnyUp")
	zoomInButton.icon:SetTexCoord(0.57812500, 0.82812500, 0.14843750, 0.27343750)
	zoomInButton.tooltip = L["Zoom In"]
	zoomInButton.tooltipText = L["Mouse Wheel Up"]
	zoomInButton:SetScript("OnMouseDown", function(self)
		module:Model_OnMouseWheel(self:GetParent():GetParent(), 1)
	end)

	local zoomOutButton = CreateFrame("Button", "$parentZoomOutButton", model.controlFrame)
	self:ModelControlButton(zoomOutButton)
	zoomOutButton:SetPoint("LEFT", 2, 0)
	zoomOutButton:RegisterForClicks("AnyUp")
	zoomOutButton.icon:SetTexCoord(0.29687500, 0.54687500, 0.00781250, 0.13281250)
	zoomOutButton.tooltip = L["Zoom Out"]
	zoomOutButton.tooltipText = L["Mouse Wheel Down"]
	zoomOutButton:SetScript("OnMouseDown", function(self)
		module:Model_OnMouseWheel(self:GetParent():GetParent(), -1)
	end)

	local panButton = CreateFrame("Button", "$parentPanButton", model.controlFrame)
	self:ModelControlButton(panButton)
	panButton:SetPoint("LEFT", 2, 0)
	panButton:RegisterForClicks("AnyUp")
	panButton.icon:SetTexCoord(0.29687500, 0.54687500, 0.28906250, 0.41406250)
	panButton.tooltip = L["Drag"]
	panButton.tooltipText = L["Right-click on character and drag to move it within the window."]
	panButton:SetScript("OnMouseDown", function(self)
		module:ModelControlButton_OnMouseDown(self)
		module:Model_StartPanning(self:GetParent():GetParent(), true)
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
		module:Model_Reset(self:GetParent():GetParent())
	end)

	if E.private.skins.blizzard.enable then
		model.controlFrame:StripTextures()
		model.controlFrame:SetSize(123, 23)

		S:HandleButton(zoomInButton)

		S:HandleButton(zoomOutButton)
		zoomOutButton:SetPoint("LEFT", "$parentZoomInButton", "RIGHT", 2, 0)

		S:HandleButton(panButton)
		panButton:SetPoint("LEFT", "$parentZoomOutButton", "RIGHT", 2, 0)

		S:HandleButton(rotateLeftButton)
		rotateLeftButton:SetPoint("LEFT", "$parentPanButton", "RIGHT", 2, 0)

		S:HandleButton(rotateRightButton)
		rotateRightButton:SetPoint("LEFT", "$parentRotateLeftButton", "RIGHT", 2, 0)

		S:HandleButton(rotateResetButton)
		rotateResetButton:SetPoint("LEFT", "$parentRotateRightButton", "RIGHT", 2, 0)
	else
		model.controlFrame:SetSize(114, 23)
		zoomOutButton:SetPoint("LEFT", "$parentZoomInButton", "RIGHT", 0, 0)
		panButton:SetPoint("LEFT", "$parentZoomOutButton", "RIGHT", 0, 0)
		rotateLeftButton:SetPoint("LEFT", "$parentPanButton", "RIGHT", 0, 0)
		rotateRightButton:SetPoint("LEFT", "$parentRotateLeftButton", "RIGHT", 0, 0)
		rotateResetButton:SetPoint("LEFT", "$parentRotateRightButton", "RIGHT", 0, 0)
	end

	model.controlFrame:SetScript("OnHide", function(self)
		if self.buttonDown then
			module:ModelControlButton_OnMouseUp(self.buttonDown)
		end
	end)

	self:HookScript(model, "OnUpdate", "Model_OnUpdate")
	model:SetScript("OnMouseWheel", function(self, delta)
		module:Model_OnMouseWheel(self, delta)
	end)
	model:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and self.panning then
			module:Model_StopPanning(self)
		elseif self.mouseDown then
			module:Model_OnMouseUp(self, button)
		end
	end)
	model:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" and not self.mouseDown then
			module:Model_StartPanning(self)
		else
			module:Model_OnMouseDown(self, button)
		end
	end)
	model:SetScript("OnEnter", function(self)
		self.controlFrame:Show()
	end)
	model:SetScript("OnLeave", function(self)
		if not MouseIsOver(self.controlFrame) and not ModelPanningFrame:IsShown() then
			self.controlFrame:Hide()
		end
	end)
	model:SetScript("OnHide", function(self)
		if self.panning then
			module:Model_StopPanning(self)
		end
		self.mouseDown = false
		self.controlFrame:Hide()
		module:Model_Reset(self)
	end)
end

local ModelSettings = {
	["HumanMale"] = { panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 38 },
	["HumanFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 1.2, panMaxBottom = -0.2, panValue = 45 },
	["OrcMale"] = { panMaxLeft = -0.7, panMaxRight = 0.8, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 30 },
	["OrcFemale"] = { panMaxLeft = -0.4, panMaxRight = 0.3, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 37 },
	["DwarfMale"] = { panMaxLeft = -0.4, panMaxRight = 0.6, panMaxTop = 0.9, panMaxBottom = -0.2, panValue = 44 },
	["DwarfFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.9, panMaxBottom = -0.2, panValue = 47 },
	["NightElfMale"] = { panMaxLeft = -0.5, panMaxRight = 0.5, panMaxTop = 1.5, panMaxBottom = -0.4, panValue = 30 },
	["NightElfFemale"] = { panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.4, panMaxBottom = -0.4, panValue = 33 },
	["ScourgeMale"] = { panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.1, panMaxBottom = -0.3, panValue = 35 },
	["ScourgeFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.4, panMaxTop = 1.1, panMaxBottom = -0.3, panValue = 36 },
	["TaurenMale"] = { panMaxLeft = -0.7, panMaxRight = 0.9, panMaxTop = 1.1, panMaxBottom = -0.5, panValue = 31 },
	["TaurenFemale"] = { panMaxLeft = -0.5, panMaxRight = 0.6, panMaxTop = 1.3, panMaxBottom = -0.4, panValue = 32 },
	["GnomeMale"] = { panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.5, panMaxBottom = -0.2, panValue = 52 },
	["GnomeFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.5, panMaxBottom = -0.2, panValue = 60 },
	["TrollMale"] = { panMaxLeft = -0.5, panMaxRight = 0.6, panMaxTop = 1.3, panMaxBottom = -0.4, panValue = 27 },
	["TrollFemale"] = { panMaxLeft = -0.4, panMaxRight = 0.4, panMaxTop = 1.5, panMaxBottom = -0.4, panValue = 31 },
	["GoblinMale"] = { panMaxLeft = -0.3, panMaxRight = 0.4, panMaxTop = 0.7, panMaxBottom = -0.2, panValue = 43 },
	["GoblinFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 0.7, panMaxBottom = -0.3, panValue = 43 },
	["BloodElfMale"] = { panMaxLeft = -0.5, panMaxRight = 0.4, panMaxTop = 1.3, panMaxBottom = -0.3, panValue = 36 },
	["BloodElfFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.2, panMaxTop = 1.2, panMaxBottom = -0.3, panValue = 38 },
	["DraeneiMale"] = { panMaxLeft = -0.6, panMaxRight = 0.6, panMaxTop = 1.4, panMaxBottom = -0.4, panValue = 28 },
	["DraeneiFemale"] = { panMaxLeft = -0.3, panMaxRight = 0.3, panMaxTop = 1.4, panMaxBottom = -0.3, panValue = 31 },
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

function module:Model_OnMouseWheel(model, delta, maxZoom, minZoom)
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

function module:Model_OnMouseDown(model, button)
	if not button or button == "LeftButton" then
		model.mouseDown = true
		model.rotationCursorStart = GetCursorPosition()
	end
end

function module:Model_OnMouseUp(model, button)
	if not button or button == "LeftButton" then
		model.mouseDown = false
	end
end

function module:Model_OnUpdate(self, elapsedTime, rotationsPerSecond)
	if not rotationsPerSecond then
		rotationsPerSecond = ROTATIONS_PER_SECOND
	end

	if self.mouseDown then
		if self.rotationCursorStart then
			local x = GetCursorPosition()
			local diff = (x - self.rotationCursorStart) * 0.010

			self.rotationCursorStart = GetCursorPosition()
			self.rotation = self.rotation + diff

			if self.rotation < 0 then
				self.rotation = self.rotation + (2 * PI)
			end

			if self.rotation > (2 * PI) then
				self.rotation = self.rotation - (2 * PI)
			end

			self:SetRotation(self.rotation, false)
		end
	elseif self.panning then
		local modelScale = self:GetModelScale()
		local cursorX, cursorY = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		ModelPanningFrame:SetPoint("BOTTOMLEFT", cursorX / scale - 16, cursorY / scale - 16)	-- half the texture size to center it on the cursor
		-- settings
		local settings = ModelSettings[playerRaceSex]

		local zoom = self.zoomLevel or 0
		zoom = 1 + zoom - 0 -- want 1 at minimum zoom

		-- Panning should require roughly the same mouse movement regardless of zoom level so the model moves at the same rate as the cursor
		-- This formula more or less works for all zoom levels, found via trial and error
		local transformationRatio = settings.panValue * 2 ^ (zoom * 1.25) * scale / modelScale

		local dx = (cursorX - self.cursorX) / transformationRatio
		local dy = (cursorY - self.cursorY) / transformationRatio
		local cameraY = self.cameraY + dx
		local cameraZ = self.cameraZ + dy
		-- bounds
		scale = scale * modelScale
		local maxCameraY = (settings.panMaxRight * zoom) * scale
		cameraY = min(cameraY, maxCameraY)
		local minCameraY = (settings.panMaxLeft * zoom) * scale
		cameraY = max(cameraY, minCameraY)
		local maxCameraZ = (settings.panMaxTop * zoom) * scale
		cameraZ = min(cameraZ, maxCameraZ)
		local minCameraZ = (settings.panMaxBottom * zoom) * scale
		cameraZ = max(cameraZ, minCameraZ)

		self:SetPosition(self.cameraX, cameraY, cameraZ)
	end

	local leftButton, rightButton
	if self.controlFrame then
		leftButton = self.controlFrame.rotateLeftButton
		rightButton = self.controlFrame.rotateRightButton
	else
		leftButton = self:GetName() and _G[self:GetName().."RotateLeftButton"]
		rightButton = self:GetName() and _G[self:GetName().."RotateRightButton"]
	end

	if leftButton and leftButton:GetButtonState() == "PUSHED" then
		self.rotation = self.rotation + (elapsedTime * 2 * PI * rotationsPerSecond)
		if self.rotation < 0 then
			self.rotation = self.rotation + (2 * PI)
		end
		self:SetRotation(self.rotation)
	elseif rightButton and rightButton:GetButtonState() == "PUSHED" then
		self.rotation = self.rotation - (elapsedTime * 2 * PI * rotationsPerSecond)
		if self.rotation > (2 * PI) then
			self.rotation = self.rotation - (2 * PI)
		end
		self:SetRotation(self.rotation)
	end
end

function module:Model_Reset(model)
	model.rotation = 0.61
	model:SetRotation(model.rotation)
	model.zoomLevel = 0
	model:SetPosition(0, 0, 0)
end

function module:Model_StartPanning(model, usePanningFrame)
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

function module:Model_StopPanning(model)
	model.panning = false
	ModelPanningFrame:Hide()
end

function module:ModelControlButton_OnMouseDown(model)
	model.bg:SetTexCoord(0.01562500, 0.26562500, 0.14843750, 0.27343750)
	model.icon:SetPoint("CENTER", 1, -1)
	model:GetParent().buttonDown = model
end

function module:ModelControlButton_OnMouseUp(model)
	model.bg:SetTexCoord(0.29687500, 0.54687500, 0.14843750, 0.27343750)
	model.icon:SetPoint("CENTER", 0, 0)
	model:GetParent().buttonDown = nil
end

function module:ADDON_LOADED(event, addon)
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

function module:Initialize()
	if not E.private.enhanced.model.enable then return end

	for i = 1, #models do
		local model = _G[models[i]]

		model:EnableMouse(true)
		model:EnableMouseWheel(true)

		_G[models[i].."RotateLeftButton"]:Kill()
		_G[models[i].."RotateRightButton"]:Kill()

		self:ModelWithControls(model)
	end

	if E.myclass == "HUNTER" then
		PetPaperDollPetInfo:SetPoint("TOPLEFT", PetPaperDollFrame, 23, -76)
	end

	local modelPanning = CreateFrame("Frame", "ModelPanningFrame", UIParent)
	modelPanning:SetFrameStrata("DIALOG")
	modelPanning:Hide()
	modelPanning:SetSize(32, 32)

	modelPanning.texture = modelPanning:CreateTexture(nil, "ARTWORK")
	modelPanning.texture:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\UI-Cursor-Move")
	modelPanning.texture:SetAllPoints()

	modelPanning:SetScript("OnUpdate", function(self)
		local model = self.model
		local controlFrame = model.controlFrame
		if not IsMouseButtonDown(controlFrame.panButton) then
			module:Model_StopPanning(model)
			if controlFrame.buttonDown then
				module:ModelControlButton_OnMouseUp(controlFrame.buttonDown)
			end
			if not MouseIsOver(controlFrame) then
			--	controlFrame:Hide()
			end
		end
	end)

	self:RegisterEvent("ADDON_LOADED")
end

local function InitializeCallback()
	module:Initialize()
end

E:RegisterModule(module:GetName(), InitializeCallback)