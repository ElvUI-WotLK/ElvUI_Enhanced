local E, L, V, P, G = unpack(ElvUI)
local WF = E:NewModule("Enhanced_WatchFrame", "AceEvent-3.0")

local IsInInstance = IsInInstance
local IsResting = IsResting
local UnitAffectingCombat = UnitAffectingCombat

local watchFrame

local statedriver = {
	["NONE"] = function()
		WatchFrame.userCollapsed = false
		WatchFrame_Expand(watchFrame)
		WatchFrame:Show()
	end,
	["COLLAPSED"] = function()
		WatchFrame.userCollapsed = true
		WatchFrame_Collapse(watchFrame)
		WatchFrame:Show()
	end,
	["HIDDEN"] = function()
		WatchFrame:Hide()
	end
}

function WF:ChangeState()
	if UnitAffectingCombat("player") then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "ChangeState")
		self.inCombat = true
		return
	end

	if IsResting() then
		statedriver[self.db.city](watchFrame)
	else
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			statedriver[self.db.pvp](watchFrame)
		elseif instanceType == "arena" then
			statedriver[self.db.arena](watchFrame)
		elseif instanceType == "party" then
			statedriver[self.db.party](watchFrame)
		elseif instanceType == "raid" then
			statedriver[self.db.raid](watchFrame)
		else
			statedriver["NONE"](watchFrame)
		end
	end

	if self.inCombat then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self.inCombat = nil
	end
end

function WF:UpdateSettings()
	if self.db.enable then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ChangeState")
		self:RegisterEvent("PLAYER_UPDATE_RESTING", "ChangeState")
	else
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("PLAYER_UPDATE_RESTING")
	end
end

local function ShowLevel()
	local questIndex, title, level

	for i = 1, GetNumQuestWatches() do
		questIndex = GetQuestIndexForWatch(i)
		if questIndex then
			title, level = GetQuestLogTitle(questIndex)

			for j = 1, #WATCHFRAME_QUESTLINES do
				if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					if E.db.enhanced.watchframe.level then
						WATCHFRAME_QUESTLINES[j].text:SetText(format("[%d] %s", level, title))
					end
				end
			end
		end
	end
end

function WF:QuestLevelToggle()
	if self.db.level then
		hooksecurefunc("WatchFrame_Update", ShowLevel)
	end

	WatchFrame_Update()
end

function WF:Initialize()
	watchFrame = _G["WatchFrame"]
	self.db = E.db.enhanced.watchframe

	self:UpdateSettings()
	self:QuestLevelToggle()
end

local function InitializeCallback()
	WF:Initialize()
end

E:RegisterModule(WF:GetName(), InitializeCallback)