local E, L, V, P, G, _ = unpack(ElvUI)
local IT = E:NewModule("Enhanced_InterruptTracker", "AceEvent-3.0", "AceTimer-3.0")

local column = 5 -- max number of interrupt icons show per column

local iconTotal = 0
local active = {}

function IT:CountActiveIcons()
	local total = 0
	wipe(active)

	for i = 1, iconTotal do
		local b = self.icons[i]
		if b:IsShown() then
			total = total + 1
			active[total] = b
		end
	end
	return total
end

function IT:RepositionIcons()
	local total = self:CountActiveIcons()
	for i, b in pairs(active) do
		local button = self.icons[i]
		button.texture:SetTexture(b.iconTexture)
		button.expirationTime = b.expirationTime
		button:SetScript("OnUpdate", self.UpdateIconTimer)
		button:Show()
	end

	for i = total + 1, iconTotal do
		local button = self.icons[i]
		button:Hide()
		button:SetScript("OnUpdate", nil)
	end
end

function IT:StopIconTimer(self)
	self:Hide()
	self.expirationTime = nil
	self:SetScript("OnUpdate", nil)
	IT:RepositionIcons()
end

function IT:UpdateIconTimer(elapsed)
	if not self.expirationTime then return end
	self.expirationTime = self.expirationTime - elapsed

	local timer = self.timerText
	local text = floor(self.expirationTime + 1)
	if self.expirationTime > 0 then
		timer:SetText(text)
	else
		timer:SetText("")
		IT:StopIconTimer(self)
	end
end

function IT:StartIconTimer(self, cooldown)
	self:Show()
	self.expirationTime = cooldown
	self:SetScript("OnUpdate", IT.UpdateIconTimer)
end

function IT:UpdateIcon(i, c, t)
	local b = self.icons[i]
	b.texture:SetTexture(t)
	b.iconTexture = t
	self:StartIconTimer(b, c)
end

local numRows = 1
function IT:CreateIcon(i)
	self.icons[i] = CreateFrame("Frame", "ElvUI_InterruptIcon"..i, self.header)
	self.icons[i]:Size(self.db.size)
	self.icons[i]:SetTemplate("Default")

	self.icons[i].texture = self.icons[i]:CreateTexture("$parentIconTexture", "BORDER")
	self.icons[i].texture:SetInside()
	self.icons[i].texture:SetTexCoord(.08, .92, .08, .92)

	self.icons[i].timerText = self.icons[i]:CreateFontString("$parentTimeText", "OVERLAY")
	local x, y = E:GetXYOffset(self.db.text.position)
	self.icons[i].timerText:ClearAllPoints()
	self.icons[i].timerText:Point(self.db.text.position, self.icons[i], self.db.text.position, x + self.db.text.xOffset, y + self.db.text.yOffset)
	self.icons[i].timerText:FontTemplate(E.LSM:Fetch("font", self.db.text.font), self.db.text.fontSize, self.db.text.fontOutline)

	if i == 1 then
		self.icons[i]:SetPoint("CENTER", self.header, "CENTER", -2, -6)
	else
		local row = ceil(i / column)
		if numRows ~= row then
			local b = self.icons[i-column]
			self.icons[i]:SetPoint("RIGHT", b, "LEFT", -6, 0)
			numRows = row
		else
			local b = self.icons[i-1]
			self.icons[i]:SetPoint("TOP", b, "BOTTOM", 0, -6)
		end
	end

	iconTotal = i
end

function IT:Update(cooldown, texture)
	local found = false
	for i = 1, iconTotal do
		local b = self.icons[i]
		if b and not b:IsShown() then
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
	for i = 1, iconTotal do
		local b = self.icons[i]
		if b then
			b:Size(self.db.size)

			local x, y = E:GetXYOffset(self.db.text.position)
			b.timerText:ClearAllPoints()
			b.timerText:Point(self.db.text.position, b, self.db.text.position, x + self.db.text.xOffset, y + self.db.text.yOffset)
			b.timerText:FontTemplate(E.LSM:Fetch("font", self.db.text.font), self.db.text.fontSize, self.db.text.fontOutline)
		end
	end
end

function IT:StopAllIconsTimers()
	for i = 1, iconTotal do
		local b = self.icons[i]
		b:Hide()
		b:SetScript("OnUpdate", nil)
	end
end

function IT:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local _, subEvent, sourceGUID, _, sourceFlags, _, _, _, spellID = ...
	local cooldown = self.spells[spellID]
	if cooldown and subEvent == "SPELL_CAST_SUCCESS" then
		if(sourceGUID and (bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)) then
			local _, _, texture = GetSpellInfo(spellID)
			self:Update(cooldown, texture)
		end
	end
end

function IT:PLAYER_ENTERING_WORLD()
	self:StopAllIconsTimers()
end

function IT:Initialize()
	if not E.db.enhanced.interruptTracker.enable then return end

	self.db = E.db.enhanced.interruptTracker

	self.header = CreateFrame("Frame", "ElvUI_InterruptTrackerHeader", UIParent)
	self.header:Size(50)
	self.header:Point("CENTER", -300, 50)
	E:CreateMover(self.header, self.header:GetName().."Mover", "Interrupt Tracker")

	self.spells = {
		[23920] = 10,
		[6552] = 10,
		[72] = 12,
		[2139] = 24,
		[19647] = 24,
		[16979] = 15,
		[57994] = 6,
		[1766] = 10,
		[47528] = 10,
		[10890] = 23,
		[31224] = 90,
		[48707] = 45,
		[49916] = 120,
		[408] = 20,
		[19503] = 30,
		[44572] = 30
	}

	self.icons = {}
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function InitializeCallback()
	IT:Initialize()
end

E:RegisterModule(IT:GetName(), InitializeCallback)