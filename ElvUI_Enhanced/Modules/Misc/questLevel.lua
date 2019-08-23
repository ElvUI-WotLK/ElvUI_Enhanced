local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetQuestLogTitle = GetQuestLogTitle
local HybridScrollFrame_GetOffset = HybridScrollFrame_GetOffset
local QuestLogTitleButton_Resize = QuestLogTitleButton_Resize

local function ShowLevel()
	local buttons = QuestLogScrollFrame.buttons
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries = GetNumQuestLogEntries()
	local questIndex, questLogTitle, questCheck, title, level, isHeader, _

	for i = 1, #buttons do
		questIndex = i + scrollOffset
		questLogTitle = buttons[i]
		questCheck = buttons[i].check

		if questIndex <= numEntries then
			title, level, _, _, isHeader = GetQuestLogTitle(questIndex)

			if not isHeader then
				questLogTitle:SetFormattedText("[%d] %s", level, title)
				questCheck:Point("LEFT", 5, 0)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end

function M:QuestLevelToggle()
	if IsAddOnLoaded("QuestGuru") then return end

	if E.db.enhanced.general.showQuestLevel then
		self:SecureHook("QuestLog_Update", ShowLevel)
		self:SecureHookScript(QuestLogScrollFrameScrollBar, "OnValueChanged", ShowLevel)
	else
		self:Unhook("QuestLog_Update")
		self:Unhook(QuestLogScrollFrameScrollBar, "OnValueChanged")
	end

	QuestLog_Update()
end