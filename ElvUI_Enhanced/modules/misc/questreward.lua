local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:GetModule('MiscEnh');

-- local rewardsFrame = QuestInfoFrame.rewardsFrame;
-- questItem = QuestInfo_GetRewardButton(rewardsFrame, index);
-- questItem.type = "choice";
-- questItem.objectType = "item";

local dbg = 0; 

--[[ Old function 
local function SelectQuestReward(index)
	local rewardsFrame = QuestInfoFrame.rewardsFrame;
	
	if dbg==1 then 
		print("index: "..index);
	end
	
	--local btn = _G[QuestInfo_GetRewardButton(rewardsFrame, index)]
	local btn = QuestInfo_GetRewardButton(rewardsFrame, index)
	if (btn.type == "choice") then
		QuestInfoItemHighlight:ClearAllPoints()
		QuestInfoItemHighlight:SetAllPoints(btn)
		QuestInfoItemHighlight:Show()

		-- set choice
		QuestInfoFrame.itemChoice = btn:GetID()
	end
end 
]]--
local function SelectQuestReward(index)
        local rewardsFrame = QuestInfoFrame.rewardsFrame;
       
        if dbg==1 then
                print("index: "..index);
        end
       
        --local btn = _G[QuestInfo_GetRewardButton(rewardsFrame, index)]
        local btn = QuestInfo_GetRewardButton(rewardsFrame, index)
        if (btn.type == "choice") then
                QuestInfoItemHighlight:ClearAllPoints()
                QuestInfoItemHighlight:SetOutside(btn.Icon)
               
                if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.quest ~= true then
                        QuestInfoItemHighlight:SetPoint("TOPLEFT", btn, "TOPLEFT", -8, 7);
                else
                        btn.Name:SetTextColor(1, 1, 0)
                end
                QuestInfoItemHighlight:Show()
 
                -- set choice
                QuestInfoFrame.itemChoice = btn:GetID()
        end
end



function M:QUEST_COMPLETE()
	if not E.private.general.selectquestreward then return end

	-- default first button when no item has a sell value.
	local choice, price = 1, 0
	local num = GetNumQuestChoices()
	
	if dbg== 1 then 
		print("GetNumQuestChoices"..num);
	end

	if num <= 0 then
		return	-- no choices, quick exit
	end

	for index = 1, num do
		local link = GetQuestItemLink("choice", index);
		if (link) then
			local vsp = select(11, GetItemInfo(link))
			if vsp and vsp > price then
				price = vsp
				choice = index
			end
		end
	end
  if dbg==1 then 
  	print("Choice: "..choice) ;
  end
  	SelectQuestReward(choice)
end

function M:LoadQuestReward()
	-- no config setting yet
	-- if not E.private.general.questreward then return end
	self:RegisterEvent("QUEST_COMPLETE");
end