local E, L, V, P, G = unpack(ElvUI)
local addon = E:NewModule("ElvUI_Enhanced")
local EP = E.Libs.EP

local addonName = ...

local format = string.format

local function gsPopupShow()
	local url = "https://www.wowinterface.com/downloads/getfile.php?id=12245&aid=47105"

	E.PopupDialogs["GS_VERSION_INVALID"] = {
		text = L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"],
		button1 = DISABLE,
		hideOnEscape = 1,
		showAlert = 1,
		OnShow = function(self)
			self.editBox:SetAutoFocus(false)
			self.editBox.width = self.editBox:GetWidth()
			self.editBox:SetWidth(220)
			self.editBox:SetText(url)
			self.editBox:HighlightText()
			ChatEdit_FocusActiveWindow()
		end,
		OnAccept = function()
			DisableAddOn("GearScore")
			DisableAddOn("BonusScanner")
			ReloadUI()
		end,
		OnHide = function(self)
			self.editBox:SetWidth(self.editBox.width or 50)
			self.editBox.width = nil
		end,
		EditBoxOnEnterPressed = function(self)
			ChatEdit_FocusActiveWindow()
			self:GetParent():Hide()
		end,
		EditBoxOnEscapePressed = function(self)
			ChatEdit_FocusActiveWindow()
			self:GetParent():Hide()
		end,
		EditBoxOnTextChanged = function(self)
			if self:GetText() ~= url then
				self:SetText(url)
			end
			self:HighlightText()
			self:ClearFocus()
			ChatEdit_FocusActiveWindow()
		end,
		OnEditFocusGained = function(self)
			self:HighlightText()
		end
	}

	E:StaticPopup_Show("GS_VERSION_INVALID")
end

function addon:ColorizeSettingName(name)
	return format("|cffff8000%s|r", name)
end

function addon:DBConversions()
	if E.db.enhanced.general.trainAllButton ~= nil then
		E.db.enhanced.general.trainAllSkills = E.db.enhanced.general.trainAllButton
		E.db.enhanced.general.trainAllButton = nil
	end

	if E.private.skins.animations ~= nil then
		E.private.enhanced.animatedAchievementBars = E.private.skins.animations
		E.private.skins.animations = nil
	end

	if E.private.enhanced.blizzard and E.private.enhanced.blizzard.deathRecap ~= nil then
		E.private.enhanced.deathRecap = E.private.enhanced.blizzard.deathRecap
		E.private.enhanced.blizzard.deathRecap = nil
	end

	if E.private.enhanced.character.model and E.private.enhanced.character.model.enable ~= nil then
		E.private.enhanced.character.modelFrames = E.private.enhanced.character.model.enable
		E.private.enhanced.character.model.enable = nil
	end

	if P.unitframe.units.player.portrait.detachFromFrame ~= nil then
		E.db.enhanced.unitframe.detachPortrait.player.enable = P.unitframe.units.player.portrait.detachFromFrame
		E.db.enhanced.unitframe.detachPortrait.player.width = P.unitframe.units.player.portrait.detachedWidth
		E.db.enhanced.unitframe.detachPortrait.player.height = P.unitframe.units.player.portrait.detachedHeight
		E.db.enhanced.unitframe.detachPortrait.target.enable = P.unitframe.units.target.portrait.detachFromFrame
		E.db.enhanced.unitframe.detachPortrait.target.width = P.unitframe.units.target.portrait.detachedWidth
		E.db.enhanced.unitframe.detachPortrait.target.height = P.unitframe.units.target.portrait.detachedHeight

		P.unitframe.units.player.portrait.detachFromFrame = nil
		P.unitframe.units.player.portrait.detachedWidth = nil
		P.unitframe.units.player.portrait.detachedHeight = nil
		P.unitframe.units.target.portrait.detachFromFrame = nil
		P.unitframe.units.target.portrait.detachedWidth = nil
		P.unitframe.units.target.portrait.detachedHeight = nil
	end

	if E.db.enhanced.nameplates.cacheUnitClass ~= nil then
		E.db.enhanced.nameplates.classCache = true
	end
	if EnhancedDB and EnhancedDB.UnitClass and next(EnhancedDB.UnitClass) then
		local classMap = {}
		for i, class in ipairs(CLASS_SORT_ORDER) do
			classMap[class] = i
		end
		for name, class in pairs(EnhancedDB.UnitClass) do
			if type(class) == "string" then
				EnhancedDB.UnitClass[name] = classMap[class]
			end
		end

		EnhancedDB.UnitClass[UNKNOWN] = nil
	end

	if E.db.general.minimap.buttons then
		E.private.enhanced.minimapButtonGrabber = true

		E.db.enhanced.minimap.buttonGrabber.buttonSize = E.db.general.minimap.buttons.buttonsize
		E.db.enhanced.minimap.buttonGrabber.buttonSpacing = E.db.general.minimap.buttons.buttonspacing
		E.db.enhanced.minimap.buttonGrabber.backdrop = E.db.general.minimap.buttons.backdrop
		E.db.enhanced.minimap.buttonGrabber.backdropSpacing = E.db.general.minimap.buttons.backdropSpacing
		E.db.enhanced.minimap.buttonGrabber.buttonsPerRow = E.db.general.minimap.buttons.buttonsPerRow
		E.db.enhanced.minimap.buttonGrabber.alpha = E.db.general.minimap.buttons.alpha
		E.db.enhanced.minimap.buttonGrabber.mouseover = E.db.general.minimap.buttons.mouseover
		E.db.enhanced.minimap.buttonGrabber.growFrom = E.db.general.minimap.buttons.point

		if E.db.general.minimap.buttons.insideMinimap then
			E.db.enhanced.minimap.buttonGrabber.insideMinimap.enable = E.db.general.minimap.buttons.insideMinimap.enable
			E.db.enhanced.minimap.buttonGrabber.insideMinimap.position = E.db.general.minimap.buttons.insideMinimap.position
			E.db.enhanced.minimap.buttonGrabber.insideMinimap.xOffset = E.db.general.minimap.buttons.insideMinimap.xOffset
			E.db.enhanced.minimap.buttonGrabber.insideMinimap.yOffset = E.db.general.minimap.buttons.insideMinimap.yOffset
		end

		E.db.general.minimap.buttons = nil
	end

	if E.db.fogofwar then
		E.db.enhanced.map.fogClear.enable = E.db.fogofwar.enable

		if E.db.fogofwar.color then
			E.db.enhanced.map.fogClear.color.r = E.db.fogofwar.color.r
			E.db.enhanced.map.fogClear.color.g = E.db.fogofwar.color.g
			E.db.enhanced.map.fogClear.color.b = E.db.fogofwar.color.b
			E.db.enhanced.map.fogClear.color.a = E.db.fogofwar.color.a
		end

		E.db.fogofwar = nil
	end
end

function addon:PrintAddonMerged(mergedAddonName)
	local _, _, _, enabled, _, reason = GetAddOnInfo(mergedAddonName)
	if reason == "MISSING" then return end

	local text = format(L["Addon |cffFFD100%s|r was merged into |cffFFD100ElvUI_Enhanced|r.\nPlease remove it to avoid conflicts."], mergedAddonName)
	E:Print(text)

	if enabled then
		if not E.PopupDialogs.ENHANCED_MERGED_ADDON then
			E.PopupDialogs.ENHANCED_MERGED_ADDON = {
				button2 = CANCEL,
				OnAccept = function()
					DisableAddOn(E.PopupDialogs.ENHANCED_MERGED_ADDON.mergedAddonName)
					ReloadUI()
				end,
				whileDead = 1,
				hideOnEscape = false
			}
		end

		local popup = E.PopupDialogs.ENHANCED_MERGED_ADDON
		popup.text = text
		popup.button1 = format("Disable %s", string.gsub(mergedAddonName, "^ElvUI_", ""))

		E:StaticPopup_Show("ENHANCED_MERGED_ADDON")
	end
end

function addon:Initialize()
	EnhancedDB = EnhancedDB or {}

	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	self:DBConversions()

	EP:RegisterPlugin(addonName, self.GetOptions)

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E.media.hexvaluecolor, addon.version))
	end

	if IsAddOnLoaded("GearScore") and IsAddOnLoaded("BonusScanner") then
		if GetAddOnMetadata("GearScore", "Version") == "3.1.20b - Release" then
			gsPopupShow()
		end
	end

	self:PrintAddonMerged("ElvUI_MinimapButtons")
	self:PrintAddonMerged("ElvUI_FogofWar")
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)