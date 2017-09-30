local E, L, V, P, G = unpack(ElvUI);
local WF = E:NewModule("Enhanced_WatchFrame", "AceEvent-3.0");

local IsInInstance = IsInInstance
local IsResting = IsResting
local UnitAffectingCombat = UnitAffectingCombat

local watchFrame;

local statedriver = {
	["NONE"] = function()
		WatchFrame.userCollapsed = false;
		WatchFrame_Expand(watchFrame);
		WatchFrame:Show();
	end,
	["COLLAPSED"] = function()
		WatchFrame.userCollapsed = true;
		WatchFrame_Collapse(watchFrame);
		WatchFrame:Show();
	end,
	["HIDDEN"] = function()
		WatchFrame:Hide();
	end
};

function WF:ChangeState()
	if(UnitAffectingCombat("player")) then self:RegisterEvent("PLAYER_REGEN_ENABLED", "ChangeState"); return; end

	if(IsResting()) then
		statedriver[E.db.enhanced.watchframe.city](watchFrame);
	else
		local _, instanceType = IsInInstance();
		if(instanceType == "pvp") then
			statedriver[E.db.enhanced.watchframe.pvp](watchFrame);
		elseif(instanceType == "arena") then
			statedriver[E.db.enhanced.watchframe.arena](watchFrame);
		elseif(instanceType == "party") then
			statedriver[E.db.enhanced.watchframe.party](watchFrame);
		elseif(instanceType == "raid") then
			statedriver[E.db.enhanced.watchframe.raid](watchFrame);
		else
			statedriver["NONE"](watchFrame);
		end
	end

	self:UnregisterEvent("PLAYER_REGEN_ENABLED");
end

function WF:UpdateSettings()
	if(E.db.enhanced.watchframe.enable) then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ChangeState");
		self:RegisterEvent("PLAYER_UPDATE_RESTING", "ChangeState");
	else
		self:UnregisterEvent("PLAYER_ENTERING_WORLD");
		self:UnregisterEvent("PLAYER_UPDATE_RESTING");
	end
end

function WF:Initialize()
	watchFrame = _G["WatchFrame"];
	self:UpdateSettings();
end

local function InitializeCallback()
	WF:Initialize()
end

E:RegisterModule(WF:GetName(), InitializeCallback)