local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function SearchBoxTemplate(frame)
	frame:SetTextInsets(16, 20, 0, 0)

	frame.Instructions = frame:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
	frame.Instructions:SetText(SEARCH)
	frame.Instructions:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, 0)
	frame.Instructions:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 0)
	frame.Instructions:SetTextColor(0.35, 0.35, 0.35)
	frame.Instructions:SetJustifyH("LEFT")
	frame.Instructions:SetJustifyV("MIDDLE")

	frame.searchIcon = frame:CreateTexture(nil, "OVERLAY")
	frame.searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
	frame.searchIcon:SetVertexColor(0.6, 0.6, 0.6)
	frame.searchIcon:Size(14)
	frame.searchIcon:Point("LEFT", 0, -2)

	frame.clearButton = CreateFrame("Button", nil, frame)
	frame.clearButton:Size(14)
	frame.clearButton:Point("RIGHT", -3, 0)

	frame.clearButton.texture = frame.clearButton:CreateTexture()
	frame.clearButton.texture:SetTexture("Interface\\FriendsFrame\\ClearBroadcastIcon")
	frame.clearButton.texture:SetAlpha(0.5)
	frame.clearButton.texture:Size(17)
	frame.clearButton.texture:Point("CENTER", 0, 0)

	frame.clearButton:SetScript("OnEnter", function(self) self.texture:SetAlpha(1.0) end)
	frame.clearButton:SetScript("OnLeave", function(self) self.texture:SetAlpha(0.5) end)
	frame.clearButton:SetScript("OnMouseDown", function(self) if self:IsEnabled() then self.texture:Point("CENTER", 1, -1) end end)
	frame.clearButton:SetScript("OnMouseUp", function(self) self.texture:Point("CENTER") end)
	frame.clearButton:SetScript("OnClick", function(self)
		local editBox = self:GetParent()
		editBox:SetText("")
		editBox:ClearFocus()
	end)

	frame:SetScript("OnShow", nil)
	frame:SetScript("OnEditFocusLost", function(self)
		if self:GetText() == "" then
			self.searchIcon:SetVertexColor(0.6, 0.6, 0.6)
			self.clearButton:Hide()
		end
	end)
	frame:SetScript("OnEditFocusGained", function(self)
		self.searchIcon:SetVertexColor(1.0, 1.0, 1.0)
		self.clearButton:Show()
	end)
	frame:HookScript("OnTextChanged", function(self)
		if not self:HasFocus() and self:GetText() == "" then
			self.searchIcon:SetVertexColor(0.6, 0.6, 0.6)
			self.clearButton:Hide()
		else
			self.searchIcon:SetVertexColor(1.0, 1.0, 1.0)
			self.clearButton:Show()
		end
		if self:GetText() == "" then
			self.Instructions:Show()
		else
			self.Instructions:Hide()
		end
	end)
end

S:AddCallbackForAddon("Blizzard_AuctionUI", "Enhanced_AuctionUI", function()
	SearchBoxTemplate(BrowseName)
end)

S:AddCallbackForAddon("Blizzard_TradeSkillUI", "Enhanced_TradeSkillUI", function()
	SearchBoxTemplate(TradeSkillFrameEditBox)
end)