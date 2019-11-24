local E, L, V, P, G, _ = unpack(ElvUI)
local addon = E:NewModule("MinimapButtons", "AceHook-3.0", "AceTimer-3.0")

local ceil = math.ceil
local find, len, sub = string.find, string.len, string.sub
local tinsert = table.insert
local select, ipairs, unpack = select, ipairs, unpack

local SkinnedButtons = {}

local IgnoreButtons = {
	"ElvConfigToggle",

	"BattlefieldMinimap",
	"ButtonCollectFrame",
	"GameTimeFrame",
	"MiniMapBattlefieldFrame",
	"MiniMapLFGFrame",
	"MiniMapMailFrame",
	"MiniMapPing",
	"MiniMapRecordingButton",
	"MiniMapTracking",
	"MiniMapTrackingButton",
	"MiniMapVoiceChatFrame",
	"MiniMapWorldMapButton",
	"Minimap",
	"MinimapBackdrop",
	"MinimapToggleButton",
	"MinimapZoneTextButton",
	"MinimapZoomIn",
	"MinimapZoomOut",
	"TimeManagerClockButton",
}

local GenericIgnores = {
	"GuildInstance",

	-- GatherMate
	"GatherMatePin",
	-- Gatherer
	"GatherNote",
	-- GuildMap3
	"GuildMap3Mini",
	-- HandyNotes
	"HandyNotesPin",
	-- LibRockConfig
	"LibRockConfig-1.0_MinimapButton",
	-- Nauticus
	"NauticusMiniIcon",
	"WestPointer",
	-- QuestPointer
	"poiMinimap",
	-- Spy
	"Spy_MapNoteList_mini",
}

local PartialIgnores = {
	"Node",
	"Note",
	"Pin",
}

local WhiteList = {
	"LibDBIcon",
}

function addon:CheckVisibility()
	local updateLayout = false

	for _, button in ipairs(SkinnedButtons) do
		if button:IsVisible() and button.hidden then
			button.hidden = false
			updateLayout = true
		elseif not button:IsVisible() and not button.hidden then
			button.hidden = true
			updateLayout = true
		end
	end

	return updateLayout
end

function addon:GrabMinimapButtons()
	for i = 1, Minimap:GetNumChildren() do
		local object = select(i, Minimap:GetChildren())

		if object and object:IsObjectType("Button") and object:GetName() then
			self:SkinMinimapButton(object)
		end
	end

	for i = 1, MinimapBackdrop:GetNumChildren() do
		local object = select(i, MinimapBackdrop:GetChildren())

		if object and object:IsObjectType("Button") and object:GetName() then
			self:SkinMinimapButton(object)
		end
	end

	if AtlasButtonFrame then self:SkinMinimapButton(AtlasButton) end
	if FishingBuddyMinimapFrame then self:SkinMinimapButton(FishingBuddyMinimapButton) end
	if HealBot_MMButton then self:SkinMinimapButton(HealBot_MMButton) end

	if self:CheckVisibility() or self.needUpdate then
		self:UpdateLayout()
	end
end

function addon:SkinMinimapButton(button)
	if not button or button.isSkinned then return end

	local name = button:GetName()
	if not name then return end

	if button:IsObjectType("Button") then
		local validIcon = false

		for i = 1, #WhiteList do
			if sub(name, 1, len(WhiteList[i])) == WhiteList[i] then validIcon = true break end
		end

		if not validIcon then
			for i = 1, #IgnoreButtons do
				if name == IgnoreButtons[i] then return end
			end

			for i = 1, #GenericIgnores do
				if sub(name, 1, len(GenericIgnores[i])) == GenericIgnores[i] then return end
			end

			for i = 1, #PartialIgnores do
				if find(name, PartialIgnores[i]) then return end
			end
		end

		button:SetPushedTexture(nil)
		button:SetHighlightTexture(nil)
		button:SetDisabledTexture(nil)
	end

	for i = 1, button:GetNumRegions() do
		local region = select(i, button:GetRegions())

		if region:GetObjectType() == "Texture" then
			local texture = region:GetTexture()

			if texture and (find(texture, "Border") or find(texture, "Background") or find(texture, "AlphaMask")) then
				region:SetTexture(nil)
			else
				if name == "BagSync_MinimapButton" then
					region:SetTexture("Interface\\AddOns\\BagSync\\media\\icon")
				elseif name == "DBMMinimapButton" then
					region:SetTexture("Interface\\Icons\\INV_Helmet_87")
				elseif name == "OutfitterMinimapButton" then
					if region:GetTexture() == "Interface\\Addons\\Outfitter\\Textures\\MinimapButton" then
						region:SetTexture(nil)
					end
				elseif name == "SmartBuff_MiniMapButton" then
					region:SetTexture("Interface\\Icons\\Spell_Nature_Purge")
				elseif name == "VendomaticButtonFrame" then
					region:SetTexture("Interface\\Icons\\INV_Misc_Rabbit_2")
				end

				region:ClearAllPoints()
				region:SetInside()
				region:SetTexCoord(unpack(E.TexCoords))
				button:HookScript("OnLeave", function(self) region:SetTexCoord(unpack(E.TexCoords)) end)

				region:SetDrawLayer("ARTWORK")
				region.SetPoint = function() return end
			end
		end
	end

	button:SetParent(self.frame)
	button:SetFrameLevel(self.frame:GetFrameLevel() + 2)

	button:SetTemplate("Default")
	button:SetScript("OnDragStart", nil)
	button:SetScript("OnDragStop", nil)
	button:HookScript("OnEnter", self.OnEnter)
	button:HookScript("OnLeave", self.OnLeave)

	button.isSkinned = true
	tinsert(SkinnedButtons, button)

	self.needUpdate = true
end

function addon:GetVisibleList()
	local tab = {}
	for _, button in ipairs(SkinnedButtons) do
		if button:IsVisible() then
			tinsert(tab, button)
		end
	end

	return tab
end

function addon:UpdateLayout()
	if #SkinnedButtons < 1 then return end

	local db = E.db.enhanced.minimap.buttonGrabber
	local VisibleButtons = self:GetVisibleList()

	if #VisibleButtons < 1 then
		self.frame:Size(db.buttonsize + (db.buttonspacing * 2))
		self.frame.backdrop:Hide()
		return
	end

	if not self.frame.backdrop:IsShown() then
		self.frame.backdrop:Show()
	end

	local backdropSpacing = db.backdropSpacing or db.buttonspacing
	local numButtons = #VisibleButtons
	local buttonsPerRow = db.buttonsPerRow
	local numColumns = ceil(numButtons / buttonsPerRow)

	if numButtons < buttonsPerRow then
		buttonsPerRow = numButtons
	end

	local barWidth = (db.buttonsize * buttonsPerRow) + (db.buttonspacing * (buttonsPerRow - 1)) + ((db.backdrop and (E.Border + backdropSpacing) or E.Spacing)*2)
	local barHeight = (db.buttonsize * numColumns) + (db.buttonspacing * (numColumns - 1)) + ((db.backdrop and (E.Border + backdropSpacing) or E.Spacing)*2)
	self.frame:Size(barWidth, barHeight)
	self.frame.mover:Size(barWidth, barHeight)

	if db.backdrop then
		self.frame.backdrop:Show()
	else
		self.frame.backdrop:Hide()
	end

	local horizontalGrowth, verticalGrowth
	if db.point == "TOPLEFT" or db.point == "TOPRIGHT" then
		verticalGrowth = "DOWN"
	else
		verticalGrowth = "UP"
	end

	if db.point == "BOTTOMLEFT" or db.point == "TOPLEFT" then
		horizontalGrowth = "RIGHT"
	else
		horizontalGrowth = "LEFT"
	end

	local firstButtonSpacing = (db.backdrop and (E.Border + backdropSpacing) or E.Spacing)
	for i, button in ipairs(VisibleButtons) do
		local lastButton = VisibleButtons[i - 1]
		local lastColumnButton = VisibleButtons[i - buttonsPerRow]
		button:Size(db.buttonsize)
		button:ClearAllPoints()

		if i == 1 then
			local x, y
			if db.point == "BOTTOMLEFT" then
				x, y = firstButtonSpacing, firstButtonSpacing
			elseif db.point == "TOPRIGHT" then
				x, y = -firstButtonSpacing, -firstButtonSpacing
			elseif db.point == "TOPLEFT" then
				x, y = firstButtonSpacing, -firstButtonSpacing
			else
				x, y = -firstButtonSpacing, firstButtonSpacing
			end

			button:Point(db.point, self.frame, db.point, x, y)
		elseif (i - 1) % buttonsPerRow == 0 then
			local x = 0
			local y = -db.buttonspacing
			local buttonPoint, anchorPoint = "TOP", "BOTTOM"
			if verticalGrowth == "UP" then
				y = db.buttonspacing
				buttonPoint = "BOTTOM"
				anchorPoint = "TOP"
			end
			button:Point(buttonPoint, lastColumnButton, anchorPoint, x, y)
		else
			local x = db.buttonspacing
			local y = 0
			local buttonPoint, anchorPoint = "LEFT", "RIGHT"
			if horizontalGrowth == "LEFT" then
				x = -db.buttonspacing
				buttonPoint = "RIGHT"
				anchorPoint = "LEFT"
			end

			button:Point(buttonPoint, lastButton, anchorPoint, x, y)
		end
	end

	self.needUpdate = false
end

function addon:UpdatePosition()
	local db = E.db.enhanced.minimap.buttonGrabber.insideMinimap

	if db.enable then
		self.frame:ClearAllPoints()
		self.frame:Point(db.position, Minimap, db.position, db.xOffset, db.yOffset)

		E:DisableMover(self.frame.mover:GetName())
	else
		self.frame:ClearAllPoints()
		self.frame:SetAllPoints(self.frame.mover)

		E:EnableMover(self.frame.mover:GetName())
	end
end

function addon:UpdateAlpha()
	if E.db.enhanced.minimap.buttonGrabber.mouseover then
		self.frame:SetAlpha(0)
	else
		self.frame:SetAlpha(E.db.enhanced.minimap.buttonGrabber.alpha)
	end
end

function addon:OnEnter()
	if E.db.enhanced.minimap.buttonGrabber.mouseover then
		UIFrameFadeIn(ElvUI_MinimapButtonGrabber, 0.1, ElvUI_MinimapButtonGrabber:GetAlpha(), E.db.enhanced.minimap.buttonGrabber.alpha)
	end
end

function addon:OnLeave()
	if E.db.enhanced.minimap.buttonGrabber.mouseover then
		UIFrameFadeOut(ElvUI_MinimapButtonGrabber, 0.1, ElvUI_MinimapButtonGrabber:GetAlpha(), 0)
	end
end

local function EnchantrixIconFix()
	if not Enchantrix or EnxMiniMapIcon then return end

	local settings = Enchantrix.Settings
	local oldButton = Enchantrix.MiniIcon

	local newButton = CreateFrame("Button", "EnxMiniMapIcon", Minimap)
	newButton:Size(20)
	newButton:SetToplevel(true)
	newButton:SetFrameStrata("LOW")
	newButton:Point("RIGHT", Minimap, "LEFT", 0,0)
	newButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	newButton.icon = oldButton.icon
	newButton.icon:SetTexCoord(0.2, 0.84, 0.13, 0.87)
	newButton.icon:SetParent(newButton)
	newButton.icon:SetPoint("TOPLEFT", newButton, "TOPLEFT", 0, 0)

	newButton.mask = oldButton.mask
	newButton.mask:SetParent(newButton)
	newButton.mask:SetPoint("TOPLEFT", newButton, "TOPLEFT", -8, 8)

	newButton:SetScript("OnClick", oldButton:GetScript("OnClick"))

	oldButton:SetMovable(false)
	oldButton:SetParent(UIParent)
	oldButton:Point("TOPRIGHT", UIParent)
	oldButton:Hide()

	oldButton:SetScript("OnMouseDown", nil)
	oldButton:SetScript("OnMouseUp", nil)
	oldButton:SetScript("OnDragStart", nil)
	oldButton:SetScript("OnDragStop", nil)
	oldButton:SetScript("OnClick", nil)
	oldButton:SetScript("OnUpdate", nil)

	Enchantrix.MiniIcon = newButton

	function Enchantrix.MiniIcon.Reposition()
		if settings.GetSetting("miniicon.enable") then
			newButton:Show()
		else
			newButton:Hide()
		end
	end
end

function addon:FixButtons()
	if IsAddOnLoaded("Atlas") then
		function AtlasButton_Toggle()
			if AtlasButton:IsVisible() then
				AtlasButton:Hide()
				AtlasOptions.AtlasButtonShown = false
			else
				AtlasButton:Show()
				AtlasOptions.AtlasButtonShown = true
			end
			AtlasOptions_Init()
		end
	end

	if IsAddOnLoaded("DBM-Core") then
		local button = DBMMinimapButton
		if not button then return end

		if button:GetScript("OnMouseDown") then
			button:SetScript("OnMouseDown", nil)
			button:SetScript("OnMouseUp", nil)
		end
	end

	if IsAddOnLoaded("Enchantrix") then
		EnchantrixIconFix()
	end
end

function addon:Initialize()
	local db = E.db.enhanced.minimap.buttonGrabber
	local backdropSpacing = db.backdropSpacing or db.buttonspacing

	self.frame = CreateFrame("Button", "ElvUI_MinimapButtonGrabber", UIParent)
	self.frame:Size(db.buttonsize + (backdropSpacing * 2))
	self.frame:Point("TOPRIGHT", MMHolder, "BOTTOMRIGHT", 0, 0)
	self.frame:SetFrameStrata("LOW")
	self.frame:SetClampedToScreen(true)
	self.frame:CreateBackdrop("Default")

	self.frame.backdrop:SetPoint("TOPLEFT", self.frame, "TOPLEFT", E.Spacing, -E.Spacing)
	self.frame.backdrop:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -E.Spacing, E.Spacing)
	self.frame.backdrop:Hide()

	E:CreateMover(self.frame, "MinimapButtonGrabberMover", L["Minimap Button Grabber"], nil, nil, nil, "ALL,GENERAL")

	if self.frame.mover:GetScript("OnSizeChanged") then
		self.frame.mover:SetScript("OnSizeChanged", nil)
	end

	self:UpdateAlpha()
	self:UpdatePosition()

	self.frame:SetScript("OnEnter", self.OnEnter)
	self.frame:SetScript("OnLeave", self.OnLeave)

	self:ScheduleRepeatingTimer("GrabMinimapButtons", 5)

	self:FixButtons()
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)