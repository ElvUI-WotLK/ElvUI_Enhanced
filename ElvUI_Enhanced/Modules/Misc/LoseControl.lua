local E, L, V, P, G = unpack(ElvUI)
local LC = E:NewModule("Enhanced_LoseControl", "AceEvent-3.0")

local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local UnitDebuff = UnitDebuff

local spellNameList = {}
local spellIDList = {
	-- Death Knight
	[47481]	= "CC",			-- Gnaw (Ghoul)
	[51209]	= "CC",			-- Hungering Cold
	[47476]	= "Silence",	-- Strangulate
	[45524]	= "Snare",		-- Chains of Ice
	[55666]	= "Snare",		-- Desecration
	[58617]	= "Snare",		-- Glyph of Heart Strike
	[50436]	= "Snare",		-- Icy Clutch
	-- Druid
	[5211]	= "CC",			-- Bash
	[33786]	= "CC",			-- Cyclone
	[2637]	= "CC",			-- Hibernate
	[22570]	= "CC",			-- Maim
	[9005]	= "CC",			-- Pounce
	[339]	= "Root",		-- Entangling Roots
	[19675]	= "Root",		-- Feral Charge Effect
	[58179]	= "Snare",		-- Infected Wounds
	[61391]	= "Snare",		-- Typhoon
	-- Hunter
	[60210]	= "CC",			-- Freezing Arrow Effect
	[3355]	= "CC",			-- Freezing Trap Effect
	[24394]	= "CC",			-- Intimidation
	[1513]	= "CC",			-- Scare Beast
	[19503]	= "CC",			-- Scatter Shot
	[19386]	= "CC",			-- Wyvern Sting
	[34490]	= "Silence",	-- Silencing Shot
	[53359]	= "Disarm",		-- Chimera Shot - Scorpid
	[19306]	= "Root",		-- Counterattack
	[19185]	= "Root",		-- Entrapment
	[35101]	= "Snare",		-- Concussive Barrage
	[5116]	= "Snare",		-- Concussive Shot
	[13810]	= "Snare",		-- Frost Trap Aura
	[61394]	= "Snare",		-- Glyph of Freezing Trap
	[2974]	= "Snare",		-- Wing Clip
	-- Hunter Pets
	[50519]	= "CC",			-- Sonic Blast
	[50541]	= "Disarm",		-- Snatch
	[54644]	= "Snare",		-- Froststorm Breath
	[50245]	= "Root",		-- Pin
	[50271]	= "Snare",		-- Tendon Rip
	[50518]	= "CC",			-- Ravage
	[54706]	= "Root",		-- Venom Web Spray
	[4167]	= "Root",		-- Web
	-- Mage
	[44572]	= "CC",			-- Deep Freeze
	[31661]	= "CC",			-- Dragon's Breath
	[12355]	= "CC",			-- Impact
	[118]	= "CC",			-- Polymorph
	[18469]	= "Silence",	-- Silenced - Improved Counterspell
	[64346]	= "Disarm",		-- Fiery Payback
	[33395]	= "Root",		-- Freeze
	[122]	= "Root",		-- Frost Nova
	[11071]	= "Root",		-- Frostbite
	[55080]	= "Root",		-- Shattered Barrier
	[11113]	= "Snare",		-- Blast Wave
	[6136]	= "Snare",		-- Chilled
	[120]	= "Snare",		-- Cone of Cold
	[116]	= "Snare",		-- Frostbolt
	[47610]	= "Snare",		-- Frostfire Bolt
	[31589]	= "Snare",		-- Slow
	-- Paladin
	[853]	= "CC",			-- Hammer of Justice
	[2812]	= "CC",			-- Holy Wrath
	[20066]	= "CC",			-- Repentance
	[20170]	= "CC",			-- Stun
	[10326]	= "CC",			-- Turn Evil
	[63529]	= "Silence",	-- Silenced - Shield of the Templar
	[20184]	= "Snare",		-- Judgement of Justice
	-- Priest
	[605]	= "CC",			-- Mind Control
	[64044]	= "CC",			-- Psychic Horror
	[8122]	= "CC",			-- Psychic Scream
	[9484]	= "CC",			-- Shackle Undead
	[15487]	= "Silence",	-- Silence
	[64058]	= "Disarm",		-- Psychic Horror
	[15407]	= "Snare",		-- Mind Flay
	-- Rogue
	[2094]	= "CC",			-- Blind
	[1833]	= "CC",			-- Cheap Shot
	[1776]	= "CC",			-- Gouge
	[408]	= "CC",			-- Kidney Shot
	[6770]	= "CC",			-- Sap
	[1330]	= "Silence",	-- Garrote - Silence
	[18425]	= "Silence",	-- Silenced - Improved Kick
	[51722]	= "Disarm",		-- Dismantle
	[31125]	= "Snare",		-- Blade Twisting
	[3409]	= "Snare",		-- Crippling Poison
	[26679]	= "Snare",		-- Deadly Throw
	-- Shaman
	[39796]	= "CC",			-- Stoneclaw Stun
	[51514]	= "CC",			-- Hex
	[64695]	= "Root",		-- Earthgrab
	[63685]	= "Root",		-- Freeze
	[3600]	= "Snare",		-- Earthbind
	[8056]	= "Snare",		-- Frost Shock
	[8034]	= "Snare",		-- Frostbrand Attack
	-- Warlock
	[710]	= "CC",			-- Banish
	[6789]	= "CC",			-- Death Coil
	[5782]	= "CC",			-- Fear
	[5484]	= "CC",			-- Howl of Terror
	[6358]	= "CC",			-- Seduction
	[30283]	= "CC",			-- Shadowfury
	[24259]	= "Silence",	-- Spell Lock
	[18118]	= "Snare",		-- Aftermath
	[18223]	= "Snare",		-- Curse of Exhaustion
	-- Warrior
	[7922]	= "CC",			-- Charge Stun
	[12809]	= "CC",			-- Concussion Blow
	[20253]	= "CC",			-- Intercept
	[5246]	= "CC",			-- Intimidating Shout
	[12798]	= "CC",			-- Revenge Stun
	[46968]	= "CC",			-- Shockwave
	[18498]	= "Silence",	-- Silenced - Gag Order
	[676]	= "Disarm",		-- Disarm
	[58373]	= "Root",		-- Glyph of Hamstring
	[23694]	= "Root",		-- Improved Hamstring
	[1715]	= "Snare",		-- Hamstring
	[12323]	= "Snare",		-- Piercing Howl
	-- Other
	[30217]	= "CC",			-- Adamantite Grenade
	[67769]	= "CC",			-- Cobalt Frag Bomb
	[30216]	= "CC",			-- Fel Iron Bomb
	[20549]	= "CC",			-- War Stomp
	[25046]	= "Silence",	-- Arcane Torrent
	[39965]	= "Root",		-- Frost Grenade
	[55536]	= "Root",		-- Frostweave Net
	[13099]	= "Root",		-- Net-o-Matic
	[29703]	= "Snare",		-- Dazed
	-- PvE
	[28169]	= "PvE",		-- Mutating Injection
	[28059]	= "PvE",		-- Positive Charge
	[28084]	= "PvE",		-- Negative Charge
	[27819]	= "PvE",		-- Detonate Mana
	[63024]	= "PvE",		-- Gravity Bomb
	[63018]	= "PvE",		-- Searing Light
	[62589]	= "PvE",		-- Nature's Fury
	[63276]	= "PvE",		-- Mark of the Faceless
	[66770]	= "PvE",		-- Ferocious Butt
	[71340]	= "PvE",		-- Pact of the Darkfallen
	[70126]	= "PvE",		-- Frost Beacon
	[73785]	= "PvE",		-- Necrotic Plague
}

local priorities = {
	["CC"]		= 60,
	["PvE"]		= 50,
	["Silence"]	= 40,
	["Disarm"]	= 30,
	["Root"]	= 20,
	["Snare"]	= 10,
}

function LC:OnUpdate(elapsed)
	self.timeLeft = self.timeLeft - elapsed

	if self.timeLeft > 10 then
		self.cooldownTime:SetFormattedText("%d", self.timeLeft)
	elseif self.timeLeft > 0 then
		self.cooldownTime:SetFormattedText("%.1f", self.timeLeft)
	else
		self:SetScript("OnUpdate", nil)
		self.timeLeft = nil
		self.cooldownTime:SetText("0")
	end
end

local function CheckPriority(priority, ccPriority, expirationTime, ccExpirationTime)
	if not ccPriority then
		return true
	end

	if priorities[priority] > priorities[ccPriority] then
		return true
	elseif priorities[priority] == priorities[ccPriority] and expirationTime > ccExpirationTime then
		return true
	end
end

function LC:UNIT_AURA(event, unit)
	if unit ~= "player" then return end

	local ccExpirationTime = 0
	local ccName, ccIcon, ccDuration, ccPriority, wyvernSting
	local _, name, icon, duration, expirationTime, priority

	for i = 1, 40 do
		name, _, icon, _, _, duration, expirationTime = UnitDebuff("player", i)
		if not name then break end

		if name == self.wyvernStingName then
			wyvernSting = 1

			if not self.wyvernSting then
				self.wyvernSting = 1
			elseif expirationTime > self.wyvernStingExpirationTime then
				self.wyvernSting = 2
			end

			self.wyvernStingExpirationTime = expirationTime

			if self.wyvernSting == 2 then
				name = nil
			end
		elseif name == self.psychicHorrorName and icon ~= "Interface\\Icons\\Ability_Warrior_Disarm" then
			name = nil
		end

		priority = self.db[spellNameList[name]]

		if priority and CheckPriority(priority, ccPriority, expirationTime, ccExpirationTime) then
			ccName = name
			ccIcon = icon
			ccDuration = duration
			ccExpirationTime = expirationTime
			ccPriority = priorities[priority]
		end
	end

	if self.wyvernSting == 2 and not wyvernSting then
		self.wyvernSting = nil
	end

	if ccExpirationTime == 0 then
		if self.ccExpirationTime ~= 0 then
			self.ccExpirationTime = 0
			self.frame.timeLeft = nil
			self.frame:SetScript("OnUpdate", nil)
			self.frame:Hide()
		end
	elseif ccExpirationTime ~= self.ccExpirationTime then
		self.ccExpirationTime = ccExpirationTime

		self.frame.icon:SetTexture(ccIcon)
		self.frame.spellName:SetText(ccName)

		if ccDuration > 0 then
			self.frame.cooldown:SetCooldown(ccExpirationTime - ccDuration, ccDuration)

			local timeLeft = ccExpirationTime - GetTime()

			if self.frame.timeLeft then
				self.frame.timeLeft = timeLeft
			else
				self.frame.timeLeft = timeLeft
				self.frame:SetScript("OnUpdate", self.OnUpdate)
			end
		end

		self.frame:Show()
	end
end

function LC:UpdateSpellNames()
	local spellName
	for spellID, ccType in pairs(spellIDList) do
		spellName = GetSpellInfo(spellID)

		if spellName then
			spellNameList[spellName] = ccType
		end
	end
end

function LC:ToggleState()
	if E.private.enhanced.loseControl.enable then
		if not self.initialized then
			self:Initialize()
			return
		end

		E:EnableMover(self.frame.mover:GetName())
		self:RegisterEvent("UNIT_AURA")
	else
		self.ccExpirationTime = 0
		self.frame.timeLeft = nil
		self.frame:SetScript("OnUpdate", nil)
		self.frame:Hide()

		E:DisableMover(self.frame.mover:GetName())
		self:UnregisterEvent("UNIT_AURA")
	end
end

function LC:UpdateSettings()
	if not self.db then return end

	self.frame:Size(self.db.iconSize)

	if self.db.compactMode then
		self.frame.cooldownTime:FontTemplate(E.media.normFont, E:Round(self.db.iconSize / 3), "OUTLINE")
		self.frame.cooldownTime:ClearAllPoints()
		self.frame.cooldownTime:SetPoint("CENTER")
		self.frame.spellName:Hide()
		self.frame.secondsText:Hide()
	else
		self.frame.cooldownTime:FontTemplate(E.media.normFont, 20, "OUTLINE")
		self.frame.cooldownTime:SetPoint("BOTTOM", 0, -50)
		self.frame.spellName:Show()
		self.frame.secondsText:Show()
	end
end

function LC:Initialize()
	if not E.private.enhanced.loseControl.enable then return end

	self.db = E.db.enhanced.loseControl

	self.frame = CreateFrame("Frame", "ElvUI_LoseControl", UIParent)
	self.frame:SetPoint("CENTER")
	self.frame:SetTemplate()
	self.frame:Hide()

	self.frame.icon = self.frame:CreateTexture(nil, "ARTWORK")
	self.frame.icon:SetInside()
	self.frame.icon:SetTexCoord(unpack(E.TexCoords))

	self.frame.cooldown = CreateFrame("Cooldown", "$parent_Cooldown", self.frame, "CooldownFrameTemplate")
	self.frame.cooldown:SetInside()

	self.frame.spellName = self.frame:CreateFontString(nil, "OVERLAY")
	self.frame.spellName:FontTemplate(E.media.normFont, 20, "OUTLINE")
	self.frame.spellName:SetPoint("BOTTOM", 0, -25)

	self.frame.cooldownTime = self.frame.cooldown:CreateFontString(nil, "OVERLAY")

	self.frame.secondsText = self.frame.cooldown:CreateFontString(nil, "OVERLAY")
	self.frame.secondsText:FontTemplate(E.media.normFont, 20, "OUTLINE")
	self.frame.secondsText:SetPoint("BOTTOM", 0, -75)
	self.frame.secondsText:SetText(L["seconds"])

	self:UpdateSettings()

	E:CreateMover(self.frame, "LossControlMover", L["Loss Control"], nil, nil, nil, "ALL,ARENA")

	self:UpdateSpellNames()
	self.wyvernStingName = GetSpellInfo(19386)
	self.psychicHorrorName = GetSpellInfo(64058)

	self:RegisterEvent("UNIT_AURA")

	self.initialized = true
end

local function InitializeCallback()
	LC:Initialize()
end

E:RegisterModule(LC:GetName(), InitializeCallback)