local E, L, V, P, G = unpack(ElvUI)
local addon = E:NewModule("ElvUI_Enhanced")
local EP = E.Libs.EP

local addonName = ...

local format = format

local function gsPopupShow()
	local url = "https://www.wowinterface.com/downloads/getfile.php?id=12245&aid=47105"

	E.PopupDialogs["GS_VERSION_INVALID"] = {
		text = L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"],
		hasEditBox = 1,
		OnShow = function(self)
			self.editBox:SetAutoFocus(false)
			self.editBox.width = self.editBox:GetWidth()
			self.editBox:SetWidth(220)
			self.editBox:SetText(url)
			self.editBox:HighlightText()
			ChatEdit_FocusActiveWindow()
		end,
		OnHide = function(self)
			self.editBox:SetWidth(self.editBox.width or 50)
			self.editBox.width = nil
		end,
		hideOnEscape = 1,
		button1 = DISABLE,
		OnAccept = function()
			DisableAddOn("GearScore")
			DisableAddOn("BonusScanner")
			ReloadUI()
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
		end,
		showAlert = 1
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
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)