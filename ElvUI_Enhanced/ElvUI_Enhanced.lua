local E, L, V, P, G = unpack(ElvUI)
local addon = E:NewModule("ElvUI_Enhanced")

local addonName = ...

local LEP = LibStub("LibElvUIPlugin-1.0")

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

function addon:DBConversions()
	if E.db.enhanced.general.trainAllButton then
		E.db.enhanced.general.trainAllSkills = E.db.enhanced.general.trainAllButton
		E.db.enhanced.general.trainAllButton = nil
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
	end
end

function addon:Initialize()
	EnhancedDB = EnhancedDB or {}

	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	self:DBConversions()

	LEP:RegisterPlugin(addonName, self.GetOptions)

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E["media"].hexvaluecolor, addon.version))
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