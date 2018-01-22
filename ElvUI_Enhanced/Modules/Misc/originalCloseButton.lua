local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")
local S = E:GetModule("Skins")

local pairs = pairs
local select = select
local tinsert = table.insert

local buttons = {
	"UI-Panel-MinimizeButton-Disabled",
	"UI-Panel-MinimizeButton-Up",
	"UI-Panel-SmallerButton-Up",
	"UI-Panel-BiggerButton-Up"
}

local buttonList = {}

local function UpdateSkinType(f)
	if E.db.enhanced.general.originalCloseButton then
		if f.originalType then return end

		f.SetNormalTexture = nil
		f:SetNormalTexture(f.origNormalTexture)

		f.SetPushedTexture = nil
		f:SetPushedTexture(f.origPushedTexture)

		if not f.desaturated then
			for i = 1, f:GetNumRegions() do
				local region = select(i, f:GetRegions())
				if region:GetObjectType() == "Texture" then
					region:SetDesaturated(1)
				end
			end
		end

		if f.backdrop then
			f.backdrop:Hide()
		end
		if f.text then
			f.text:Hide()
		end

		f.originalType = true
	else
		if not f.originalType then return end

		f:StripTextures()

		if f:GetNormalTexture() then
			f:SetNormalTexture("")
			f.SetNormalTexture = E.noop
		end

		if f:GetPushedTexture() then
			f:SetPushedTexture("")
			f.SetPushedTexture = E.noop
		end

		if not f.backdrop then
			f:CreateBackdrop("Default", true)
			f.backdrop:Point("TOPLEFT", 7, -8)
			f.backdrop:Point("BOTTOMRIGHT", -8, 8)
			f:HookScript("OnEnter", S.SetModifiedBackdrop)
			f:HookScript("OnLeave", S.SetOriginalBackdrop)
		else
			f.backdrop:Show()
		end

		if not f.text then
			f.text = f:CreateFontString(nil, "OVERLAY")
			f.text:SetFont([[Interface\AddOns\ElvUI\media\fonts\PT_Sans_Narrow.ttf]], 16, "OUTLINE")
			f.text:SetText(f.textTemp or "x")
			f.text:SetJustifyH("CENTER")
			f.text:SetPoint("CENTER", f, "CENTER", -1, 1)
		else
			f.text:Show()
		end

		f.originalType = nil
	end
end

function M:UpdateCloseButtons()
	for _, button in pairs(buttonList) do
		UpdateSkinType(button)
	end
end

function S:HandleCloseButton(f, point, text)
	if f:GetNormalTexture() then
		f.origNormalTexture = f:GetNormalTexture():GetTexture()
	end
	if f:GetPushedTexture() then
		f.origPushedTexture = f:GetPushedTexture():GetTexture()
	end

	if E.db.enhanced.general.originalCloseButton then
		for i = 1, f:GetNumRegions() do
			local region = select(i, f:GetRegions())
			if region:GetObjectType() == "Texture" then
				region:SetDesaturated(1)

				for n = 1, #buttons do
					local texture = buttons[n]
					if region:GetTexture() == "Interface\\Buttons\\"..texture then
						f.originalType = true
					end
				end

				if region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Corner"
				or region:GetTexture() == "Interface\\AuctionFrame\\AuctionHouseDressUpFrame-Corner" then
					region:Kill()
				end
			end
		end

		if text then
			f.textTemp = text
		end
	else
		f:StripTextures()

		if f:GetNormalTexture() then
			f:SetNormalTexture("")
			f.SetNormalTexture = E.noop
		end

		if f:GetPushedTexture() then
			f:SetPushedTexture("")
			f.SetPushedTexture = E.noop
		end

		if not f.backdrop then
			f:CreateBackdrop("Default", true)
			f.backdrop:Point("TOPLEFT", 7, -8)
			f.backdrop:Point("BOTTOMRIGHT", -8, 8)
			f:HookScript("OnEnter", S.SetModifiedBackdrop)
			f:HookScript("OnLeave", S.SetOriginalBackdrop)
		end

		if not f.text then
			f.text = f:CreateFontString(nil, "OVERLAY")
			f.text:SetFont([[Interface\AddOns\ElvUI\media\fonts\PT_Sans_Narrow.ttf]], 16, "OUTLINE")
			f.text:SetText(text or "x")
			f.text:SetJustifyH("CENTER")
			f.text:SetPoint("CENTER", f, "CENTER", -1, 1)
		end
	end

	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end

	tinsert(buttonList, f)
end