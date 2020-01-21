local E, L, V, P, G = unpack(ElvUI)
local M = E:NewModule("Enhanced_Misc", "AceHook-3.0", "AceEvent-3.0")

local CancelDuel = CancelDuel
local GetSpellInfo = GetSpellInfo
local IsInInstance = IsInInstance
local RepopMe = RepopMe
local UnitBuff = UnitBuff

local soulstone
function M:PLAYER_DEAD()
	local inInstance, instanceType = IsInInstance()

	if inInstance and instanceType == "pvp" then
		if not soulstone then
			soulstone = GetSpellInfo(20707)
		end

		if E.myclass ~= "SHAMAN" and not (soulstone and UnitBuff("player", soulstone)) then
			RepopMe()
		end
	end
end

function M:AutoRelease()
	if E.db.enhanced.general.pvpAutoRelease then
		self:RegisterEvent("PLAYER_DEAD")
	else
		self:UnregisterEvent("PLAYER_DEAD")
	end
end

function M:DUEL_REQUESTED(_, name)
	StaticPopup_Hide("DUEL_REQUESTED")
	CancelDuel()
	E:Print(L["Declined duel request from "]..name)
end

function M:DeclineDuel()
	if E.db.enhanced.general.declineduel then
		self:RegisterEvent("DUEL_REQUESTED")
	else
		self:UnregisterEvent("DUEL_REQUESTED")
	end
end

function M:HideZone()
	if E.db.enhanced.general.hideZoneText then
		ZoneTextFrame:UnregisterAllEvents()
	else
		ZoneTextFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		ZoneTextFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
		ZoneTextFrame:RegisterEvent("ZONE_CHANGED")
	end
end

function M:Initialize()
	self:AutoRelease()
	self:DeclineDuel()
	self:HideZone()
	self:ToggleQuestReward()
	self:WatchedFaction()
	self:LoadMoverTransparancy()
	self:QuestLevelToggle()
	self:BuyStackToggle()
end

local function InitializeCallback()
	M:Initialize()
end

E:RegisterModule(M:GetName(), InitializeCallback)