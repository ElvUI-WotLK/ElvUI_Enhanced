local E, L, V, P, G = unpack(ElvUI)
local IT = E:NewModule("Enhanced_InterruptTracker", "AceEvent-3.0")

local ipairs = ipairs
local unpack = unpack
local band = bit.band
local ceil, floor = math.ceil, math.floor
local twipe = table.wipe

local CreateFrame = CreateFrame
local GetInstanceInfo = GetInstanceInfo
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime

local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE

local spellList = {
	[72] = 12,		-- Shield Bash
	[408] = 20,		-- Kidney Shot
	[1766] = 10,	-- Kick
	[2139] = 24,	-- Counterspell
	[6552] = 10,	-- Pummel
	[10890] = 23,	-- Psychic Scream
	[15487] = 45,	-- Silence
	[16979] = 15,	-- Feral Charge
	[19503] = 30,	-- Scatter Shot
	[19647] = 24,	-- Spell Lock
	[23920] = 10,	-- Spell Reflection
	[31224] = 90,	-- Cloak of Shadows
	[34490] = 30,	-- Silencing Shot
	[44572] = 30,	-- Deep Freeze
	[47528] = 10,	-- Mind Freeze
	[48707] = 45,	-- Anti-Magic Shell
	[49916] = 120,	-- Strangulate
	[51514] = 45,	-- Hex
	[57994] = 6,	-- Wind Shear
}

local column = 5 -- max number of interrupt icons show per column
local numRows = 1
local iconTotal = 0
local activeIcons = {}

local function UpdateIconTimer(self, elapsed)
	if not self.expirationTime then return end

	self.expirationTime = self.expirationTime - elapsed

	if self.expirationTime > 0 then
		self.timerText:SetText(floor(self.expirationTime + 1))
	else
		self.timerText:SetText("")
		IT:StopIconTimer(self)
	end
end

function IT:CountActiveIcons()
	local total, icon = 0
	twipe(activeIcons)

	for i = 1, iconTotal do
		icon = self.icons[i]
		if icon:IsShown() then
			total = total + 1
			activeIcons[total] = icon
		end
	end

	return total
end

function IT:RepositionIcons()
	local total = self:CountActiveIcons()
	local icon

	for i, activeIcon in ipairs(activeIcons) do
		icon = self.icons[i]
		icon.texture:SetTexture(activeIcon.iconTexture)
		icon.expirationTime = activeIcon.expirationTime
		icon.cooldown:SetCooldown(GetTime(), activeIcon.expirationTime)
		icon:SetScript("OnUpdate", UpdateIconTimer)
		icon:Show()
	end

	for i = total + 1, iconTotal do
		icon = self.icons[i]
		icon:Hide()
		icon:SetScript("OnUpdate", nil)
	end
end

function IT:StopIconTimer(icon)
	icon:Hide()
	icon.expirationTime = nil
	icon:SetScript("OnUpdate", nil)
	self:RepositionIcons()
end

function IT:StartIconTimer(icon, cooldown)
	icon.expirationTime = cooldown
	icon.cooldown:SetCooldown(GetTime(), cooldown)
	icon:SetScript("OnUpdate", UpdateIconTimer)
	icon:Show()
end

function IT:UpdateIcon(index, cooldown, texture)
	local icon = self.icons[index]
	icon.texture:SetTexture(texture)
	icon.iconTexture = texture
	self:StartIconTimer(icon, cooldown)
end

function IT:CreateIcon(i)
	self.icons[i] = CreateFrame("Frame", "ElvUI_InterruptIcon"..i, self.header)
	self.icons[i]:Size(self.db.size)
	self.icons[i]:SetTemplate()

	self.icons[i].texture = self.icons[i]:CreateTexture("$parentIconTexture", "BORDER")
	self.icons[i].texture:SetInside()
	self.icons[i].texture:SetTexCoord(unpack(E.TexCoords))

	self.icons[i].cooldown = CreateFrame("Cooldown", self.icons[i]:GetName().."Cooldown", self.icons[i], "CooldownFrameTemplate")
	self.icons[i].cooldown:SetInside()

	self.icons[i].timerText = self.icons[i].cooldown:CreateFontString("$parentTimeText", "OVERLAY")
	local x, y = E:GetXYOffset(self.db.text.position)
	self.icons[i].timerText:ClearAllPoints()
	self.icons[i].timerText:Point(self.db.text.position, self.icons[i], self.db.text.position, x + self.db.text.xOffset, y + self.db.text.yOffset)
	self.icons[i].timerText:FontTemplate(E.LSM:Fetch("font", self.db.text.font), self.db.text.fontSize, self.db.text.fontOutline)

	if i == 1 then
		self.icons[i]:Point("CENTER", self.header, "CENTER", -2, -6)
	else
		local row = ceil(i / column)

		if numRows ~= row then
			self.icons[i]:Point("RIGHT", self.icons[i-column], "LEFT", -6, 0)
			numRows = row
		else
			self.icons[i]:Point("TOP", self.icons[i-1], "BOTTOM", 0, -6)
		end
	end

	iconTotal = i
end

function IT:Update(cooldown, texture)
	local found, icon

	for i = 1, iconTotal do
		icon = self.icons[i]

		if icon and not icon:IsShown() then
			found = true
			self:UpdateIcon(i, cooldown, texture)
			break
		end
	end

	if found then return end

	local i = iconTotal + 1
	self:CreateIcon(i)
	self:UpdateIcon(i, cooldown, texture)
end

function IT:UpdateAllIconsTimers()
	local x, y = E:GetXYOffset(self.db.text.position)
	local icon

	for i = 1, iconTotal do
		icon = self.icons[i]

		if icon then
			icon:Size(self.db.size)

			icon.timerText:ClearAllPoints()
			icon.timerText:Point(self.db.text.position, icon, self.db.text.position, x + self.db.text.xOffset, y + self.db.text.yOffset)
			icon.timerText:FontTemplate(E.LSM:Fetch("font", self.db.text.font), self.db.text.fontSize, self.db.text.fontOutline)
		end
	end
end

function IT:StopAllIconsTimers()
	local icon

	for i = 1, iconTotal do
		icon = self.icons[i]
		icon:Hide()
		icon:SetScript("OnUpdate", nil)
	end
end

function IT:COMBAT_LOG_EVENT_UNFILTERED(event, _, subEvent, sourceGUID, _, sourceFlags, _, _, _, spellID)
	if subEvent == "SPELL_CAST_SUCCESS" and spellList[spellID] then
		if sourceGUID and (band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
			local _, _, texture = GetSpellInfo(spellID)
			self:Update(spellList[spellID], texture)
		end
	end
end

function IT:PLAYER_ENTERING_WORLD()
	self:StopAllIconsTimers()
	self:UpdateState()
end

function IT:UpdateState()
	local _, zoneType = GetInstanceInfo()
	if E.private.enhanced.interruptTracker.everywhere or (E.private.enhanced.interruptTracker.arena and zoneType == "arena") or (E.private.enhanced.interruptTracker.battleground and zoneType == "pvp") then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

function IT:Initialize()
	if not E.private.enhanced.interruptTracker.enable then return end

	self.db = E.db.enhanced.interruptTracker
	self.icons = {}

	self.header = CreateFrame("Frame", "ElvUI_InterruptTrackerHeader", UIParent)
	self.header:Size(50)
	self.header:Point("CENTER", -300, 50)

	E:CreateMover(self.header, self.header:GetName().."Mover", L["Interrupt Tracker"])

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local function InitializeCallback()
	IT:Initialize()
end

E:RegisterModule(IT:GetName(), InitializeCallback)