local E, L, V, P, G = unpack(ElvUI)
local addon = E:NewModule("ElvUI_Enhanced")

local addonName = ...

local LEP = LibStub("LibElvUIPlugin-1.0")

E.PopupDialogs["GS_VERSION_INVALID"] = {
	text = L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"],
	hasEditBox = 1,
	OnShow = function(self)
		self.editBox:SetAutoFocus(false)
		self.editBox.width = self.editBox:GetWidth()
		self.editBox:SetWidth(220)
		self.editBox:SetText("http://www.wowinterface.com/downloads/getfile.php?id=12245&aid=47105")
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
		if self:GetText() ~= "http://www.wowinterface.com/downloads/getfile.php?id=12245&aid=47105" then
			self:SetText("http://www.wowinterface.com/downloads/getfile.php?id=12245&aid=47105")
		end
		self:HighlightText()
		self:ClearFocus()
		ChatEdit_FocusActiveWindow()
	end,
	OnEditFocusGained = function(self)
		self:HighlightText()
	end,
	showAlert = 1
};

function addon:Initialize()
	self.version = GetAddOnMetadata("ElvUI_Enhanced", "Version")

	if E.db.general.loginmessage then
		print(format(L["ENH_LOGIN_MSG"], E["media"].hexvaluecolor, addon.version))
	end

	-- DBConversions
	if E.db.enhanced.tooltip.progressInfo.tiers.TotC then
		E.db.enhanced.tooltip.progressInfo.tiers.ToC = true
	end
	if E.db.enhanced.tooltip.progressInfo.tiers.TotC ~= nil then
		E.db.enhanced.tooltip.progressInfo.tiers.TotC = nil
	end

	LEP:RegisterPlugin(addonName, self.GetOptions)

	if E.db.general.showQuestLevel then
		E.db.enhanced.general.showQuestLevel = true
	end
	E.db.general.showQuestLevel = nil

	if IsAddOnLoaded("GearScore") and IsAddOnLoaded("BonusScanner") then
		if GetAddOnMetadata("GearScore", "Version") == "3.1.20b - Release" then
			E:StaticPopup_Show("GS_VERSION_INVALID")
		end
	end
end

local function InitializeCallback()
	addon:Initialize()
end

E:RegisterModule(addon:GetName(), InitializeCallback)