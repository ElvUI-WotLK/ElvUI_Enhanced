local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local HybridScrollFrame_GetOffset = HybridScrollFrame_GetOffset
local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetQuestLogTitle = GetQuestLogTitle

local function ShowLevel()
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries = GetNumQuestLogEntries()
	local buttons = QuestLogScrollFrame.buttons
	local numButtons = #buttons
	local questIndex, questLogTitle, title, level, isHeader, _

	for i = 1, numButtons do
		questIndex = i + scrollOffset
		questLogTitle = buttons[i]

		if questIndex <= numEntries then
			title, level, _, _, isHeader = GetQuestLogTitle(questIndex)

			if not isHeader then
				questLogTitle:SetText("[" .. level .. "] " .. title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end

function M:QuestLevelToggle()
	if E.db.enhanced.general.showQuestLevel then
		self:SecureHook("QuestLog_Update", ShowLevel)
		self:SecureHookScript(QuestLogScrollFrameScrollBar, "OnValueChanged", ShowLevel)
	else
		self:Unhook("QuestLog_Update")
		self:Unhook(QuestLogScrollFrameScrollBar, "OnValueChanged")
	end

	QuestLog_Update()
end