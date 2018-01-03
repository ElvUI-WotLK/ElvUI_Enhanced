local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local _G = _G
local band = bit.band

function S:SearchBoxTemplate(frame)
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
	frame.clearButton:SetScript("OnMouseUp", function(self) self.texture:Point("CENTER", 0, 0) end)
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

local function LoadAchievementUISkin()
	local function AnimationStatusBar(bar, noNumber)
		bar.anim = CreateAnimationGroup(bar)
		bar.anim.progress = bar.anim:CreateAnimation("Progress")
		bar.anim.progress:SetSmoothing("Out")
		bar.anim.progress:SetDuration(1.7)

		bar.anim.color = bar.anim:CreateAnimation("Color")
		bar.anim.color:SetSmoothing("Out")
		bar.anim.color:SetColorType("Statusbar")
		bar.anim.color:SetDuration(1.7)
		bar.anim.color.StartR, bar.anim.color.StartG, bar.anim.color.StartB = 1, 0, 0

		if(not noNumber) then
			bar.anim2 = CreateAnimationGroup(_G[bar:GetName() .. "Text"])
			bar.anim2.number = bar.anim2:CreateAnimation("Number")
			bar.anim2.number:SetDuration(1.7)
		end
	end

	local function PlayAnimationStatusBar(bar, max, value, noNumber)
		if(bar.anim:IsPlaying() or (bar.anim2 and bar.anim2:IsPlaying())) then
			bar.anim:Stop()
			if(not noNumber) then
				bar.anim2:Stop()
			end
		end
		bar:SetValue(0)
		bar.anim.progress:SetChange(value)

		local r, g, b = E:ColorGradient(value / max, 1, 0, 0, 1, 1, 0, 0, 1, 0)
		bar.anim.color:Reset()
		bar.anim.color:SetChange(r, g, b)
		bar.anim:Play()

		if(not noNumber) then
			bar.anim2.number:SetPostfix("/" .. max)
			bar.anim2.number:SetChange(value)
			bar.anim2:Play()
		end
	end

	AnimationStatusBar(AchievementFrameSummaryCategoriesStatusBar)
	AnimationStatusBar(AchievementFrameComparisonSummaryPlayerStatusBar)
	AnimationStatusBar(AchievementFrameComparisonSummaryFriendStatusBar)

	for i = 1, 8 do
		local frame = _G["AchievementFrameSummaryCategoriesCategory" .. i]
		AnimationStatusBar(frame)
	end

	hooksecurefunc("AchievementFrameCategory_StatusBarTooltip", function(self)
		if(not E.private.skins.animations) then return end

		local index = GameTooltip.shownStatusBars
		local name = GameTooltip:GetName() .. "StatusBar" .. index
		local statusBar = _G[name]
		if(not statusBar) then return end

		if(not statusBar.anim) then
			AnimationStatusBar(statusBar)
		end

		PlayAnimationStatusBar(statusBar, self.numAchievements, self.numCompleted)
	end)

	hooksecurefunc("AchievementFrameComparison_UpdateStatusBars", function(id)
		if(not E.private.skins.animations) then return end

		local numAchievements, numCompleted = GetCategoryNumAchievements(id)
		local statusBar = AchievementFrameComparisonSummaryPlayerStatusBar
		PlayAnimationStatusBar(statusBar, numAchievements, numCompleted)

		local friendCompleted = GetComparisonCategoryNumAchievements(id)
		statusBar = AchievementFrameComparisonSummaryFriendStatusBar
		PlayAnimationStatusBar(statusBar, numAchievements, friendCompleted)
	end)

	hooksecurefunc("AchievementFrameSummaryCategoriesStatusBar_Update", function()
		if(not E.private.skins.animations) then return end

		local total, completed = GetNumCompletedAchievements()
		PlayAnimationStatusBar(AchievementFrameSummaryCategoriesStatusBar, total, completed)
	end)

	hooksecurefunc("AchievementFrameSummaryCategory_OnShow", function(self)
		if(not E.private.skins.animations) then return end

		local totalAchievements, totalCompleted = AchievementFrame_GetCategoryTotalNumAchievements(self:GetID(), true)
		PlayAnimationStatusBar(self, totalAchievements, totalCompleted)
	end)

	hooksecurefunc("AchievementButton_GetProgressBar", function(index)
		local frame = _G["AchievementFrameProgressBar" .. index]
		if(frame and not frame.anim) then
			AnimationStatusBar(frame, true)
		end
	end)

	hooksecurefunc("AchievementObjectives_DisplayCriteria", function(objectivesFrame, id)
		local numCriteria = GetAchievementNumCriteria(id)
		local textStrings, metas, progressBars = 0, 0, 0
		for i = 1, numCriteria do
			local _, _, _, quantity, reqQuantity, _, flags = GetAchievementCriteriaInfo(id, i)
			if(E.private.skins.animations and band(flags, ACHIEVEMENT_CRITERIA_PROGRESS_BAR) == ACHIEVEMENT_CRITERIA_PROGRESS_BAR) then
				progressBars = progressBars + 1
				local progressBar = AchievementButton_GetProgressBar(progressBars)
				PlayAnimationStatusBar(progressBar, reqQuantity, quantity, true)
			end
		end
	end)
end

S:AddCallbackForAddon("Blizzard_AchievementUI", "Bunny_AchievementUI", LoadAchievementUISkin)

local function LoadAuctionUISkin()
	S:SearchBoxTemplate(BrowseName)
end

S:AddCallbackForAddon("Blizzard_AuctionUI", "Bunny_AuctionUI", LoadAuctionUISkin)

local function LoadTradeSkillUISkin()
	S:SearchBoxTemplate(TradeSkillFrameEditBox)
end

S:AddCallbackForAddon("Blizzard_TradeSkillUI", "Bunny_TradeSkillUI", LoadTradeSkillUISkin)