local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local _G = _G
local select = select

local GetItemInfo = GetItemInfo
local GetNumQuestChoices = GetNumQuestChoices
local GetQuestItemLink = GetQuestItemLink

local function SelectQuestReward(id)
	local button = _G["QuestInfoItem"..id]

	if button.type == "choice" then
		if E.private.skins.blizzard.enable and E.private.skins.blizzard.quest then
			_G[button:GetName()]:SetBackdropBorderColor(1, 0.80, 0.10)
			_G[button:GetName()].backdrop:SetBackdropBorderColor(1, 0.80, 0.10)
			_G[button:GetName().."Name"]:SetTextColor(1, 0.80, 0.10)
		else
			QuestInfoItemHighlight:ClearAllPoints()
			QuestInfoItemHighlight:SetAllPoints(button)
			QuestInfoItemHighlight:Show()
		end

		QuestInfoFrame.itemChoice = button:GetID()
	end
end

function M:QUEST_COMPLETE()
	local numItems = GetNumQuestChoices()
	if numItems <= 0 then return end

	local link, sellPrice
	local choiceID, maxPrice = 1, 0

	for i = 1, numItems do
		link = GetQuestItemLink("choice", i)

		if link then
			sellPrice = select(11, GetItemInfo(link))

			if sellPrice and sellPrice > maxPrice then
				maxPrice = sellPrice
				choiceID = i
			end
		end
	end

	SelectQuestReward(choiceID)
end

function M:ToggleQuestReward()
	if E.private.general.selectQuestReward then
		self:RegisterEvent("QUEST_COMPLETE")
	else
		self:UnregisterEvent("QUEST_COMPLETE")
	end
end