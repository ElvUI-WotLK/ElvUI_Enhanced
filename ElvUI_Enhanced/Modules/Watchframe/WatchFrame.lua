local E, L, V, P, G = unpack(ElvUI)
local WF = E:NewModule("Enhanced_WatchFrame", "AceHook-3.0", "AceEvent-3.0")

local ipairs = ipairs

local GetQuestIndexForWatch = GetQuestIndexForWatch
local GetQuestLogTitle = GetQuestLogTitle
local IsInInstance = IsInInstance
local IsResting = IsResting
local UnitAffectingCombat = UnitAffectingCombat

local WATCHFRAME_LINKBUTTONS = WATCHFRAME_LINKBUTTONS
local WATCHFRAME_QUESTLINES = WATCHFRAME_QUESTLINES

local WatchFrame = WatchFrame

local statedriver = {
	["NONE"] = function()
		WatchFrame.userCollapsed = false
		WatchFrame_Expand(WatchFrame)
		WatchFrame:Show()
	end,
	["COLLAPSED"] = function()
		WatchFrame.userCollapsed = true
		WatchFrame_Collapse(WatchFrame)
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
		statedriver[self.db.city](WatchFrame)
	else
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			statedriver[self.db.pvp](WatchFrame)
		elseif instanceType == "arena" then
			statedriver[self.db.arena](WatchFrame)
		elseif instanceType == "party" then
			statedriver[self.db.party](WatchFrame)
		elseif instanceType == "raid" then
			statedriver[self.db.raid](WatchFrame)
		else
			statedriver["NONE"](WatchFrame)
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
	for _, button in ipairs(WATCHFRAME_LINKBUTTONS) do
		if button.type == "QUEST" then
			local questIndex = GetQuestIndexForWatch(button.index)
			local title, level = GetQuestLogTitle(questIndex)
			WATCHFRAME_QUESTLINES[button.startLine].text:SetFormattedText("[%d] %s", level, title)
		end
	end
end

function WF:QuestLevelToggle()
	if self.db.level and not self:IsHooked("WatchFrame_Update") then
		self:SecureHook("WatchFrame_Update", ShowLevel)
	elseif not self.db.level and self:IsHooked("WatchFrame_Update") then
		self:Unhook("WatchFrame_Update")
	end

	WatchFrame_Update()
end

function WF:Initialize()
	self.db = E.db.enhanced.watchframe

	self:UpdateSettings()
	self:QuestLevelToggle()
end

local function InitializeCallback()
	WF:Initialize()
end

E:RegisterModule(WF:GetName(), InitializeCallback)