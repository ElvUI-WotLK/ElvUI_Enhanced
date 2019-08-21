local E, L, V, P, G = unpack(ElvUI)
local ENP = E:NewModule("Enhanced_NamePlates", "AceHook-3.0", "AceEvent-3.0")
local NP = E:GetModule("NamePlates")

local pairs = pairs

local UnitClass = UnitClass
local UnitIsPlayer = UnitIsPlayer
local UnitName = UnitName
local UnitReaction = UnitReaction
local GetGuildInfo = GetGuildInfo

local guildMap = {}
local classMap = {}
for i, class in ipairs(CLASS_SORT_ORDER) do
	classMap[class] = i
end

function ENP:UPDATE_MOUSEOVER_UNIT()
	if UnitIsPlayer("mouseover") and UnitReaction("mouseover", "player") ~= 2 then
		local name, realm = UnitName("mouseover")
		if realm or not name then return end

		if E.db.enhanced.nameplates.classCache then
			local _, class = UnitClass("mouseover")
			class = classMap[class]

			if EnhancedDB.UnitClass[name] ~= class then
				EnhancedDB.UnitClass[name] = class
			end
		end

		if E.db.enhanced.nameplates.titleCache then
			local guildName = GetGuildInfo("mouseover")
			if not guildName then return end

			if not guildMap[guildName] then
				table.insert(EnhancedDB.GuildList, guildName)
				guildMap[guildName] = #EnhancedDB.GuildList
			end

			if EnhancedDB.UnitTitle[name] ~= guildMap[guildName] then
				EnhancedDB.UnitTitle[name] = guildMap[guildName]
			end
		end
	end
end

local function UpdateElement_NameHook(self, frame)
	if EnhancedDB.GuildList[EnhancedDB.UnitTitle[frame.UnitName]] and not self.db.units[frame.UnitType].healthbar.enable and not (self.db.alwaysShowTargetHealth and frame.isTarget) then
		if not frame.Title then
			frame.Title = frame:CreateFontString(nil, "OVERLAY")
			frame.Title:SetWordWrap(false)
		end

		frame.Title:SetFont(E.LSM:Fetch("font", self.db.font), self.db.fontSize, self.db.fontOutline)
		frame.Title:SetPoint("TOP", frame.Name, "BOTTOM")

		frame.Title:SetText(EnhancedDB.GuildList[EnhancedDB.UnitTitle[frame.UnitName]])
		frame.Title:Show()
	elseif frame.Title then
		frame.Title:SetText()
		frame.Title:Hide()
	end
end

function ENP:TitleCache()
	if E.db.enhanced.nameplates.titleCache then
		if not self:IsHooked(NP, "UpdateElement_Name") then
			self:Hook(NP, "UpdateElement_Name", UpdateElement_NameHook)
		end
	else
		if self:IsHooked(NP, "UpdateElement_Name") then
			self:Unhook(NP, "UpdateElement_Name")
		end
	end
end

function ENP:Initialize()
	EnhancedDB = EnhancedDB or {}
	EnhancedDB.UnitClass = EnhancedDB.UnitClass or {}
	EnhancedDB.UnitTitle = EnhancedDB.UnitTitle or {}

	if EnhancedDB.GuildList then
		for i, guildName in ipairs(EnhancedDB.GuildList) do
			guildMap[guildName] = i
		end
	else
		EnhancedDB.GuildList = {}
	end

	if E.db.enhanced.nameplates.titleCache or E.db.enhanced.nameplates.classCache then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

	elseif not E.db.enhanced.nameplates.titleCache and not E.db.enhanced.nameplates.classCache then
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	end

	self:ClassCache()
	self:ChatBubbles()
	self:TitleCache()
end

local function InitializeCallback()
	ENP:Initialize()
end

E:RegisterModule(ENP:GetName(), InitializeCallback)