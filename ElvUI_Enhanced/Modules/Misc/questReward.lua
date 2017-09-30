local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local _G = _G
local format = string.format

local function SelectQuestReward(index)
	local btn = _G[("QuestInfoItem%d"):format(index)]
	if(btn.type == "choice") then
		QuestInfoItemHighlight:ClearAllPoints()
		QuestInfoItemHighlight:SetAllPoints(btn)
		QuestInfoItemHighlight:Show()

		QuestInfoFrame.itemChoice = btn:GetID()
	end
end

function M:QUEST_COMPLETE()
	if not E.private.general.selectQuestReward then return end

	local choice, price = 1, 0
	local num = GetNumQuestChoices()

	if num <= 0 then
		return
	end

	for index = 1, num do
		local link = GetQuestItemLink("choice", index)
		if (link) then
			local vsp = select(11, GetItemInfo(link))
			if vsp and vsp > price then
				price = vsp
				choice = index
			end
		end
	end

	SelectQuestReward(choice)
end

function M:LoadQuestReward()
	self:RegisterEvent("QUEST_COMPLETE")
end