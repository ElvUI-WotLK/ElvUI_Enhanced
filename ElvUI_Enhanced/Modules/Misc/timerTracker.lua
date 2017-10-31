local E, L, V, P, G, _ = unpack(ElvUI)
local module = E:NewModule("Enhanced_TimerTracker", "AceHook-3.0", "AceEvent-3.0")

local tonumber = tonumber
local format, split = string.format, string.split

local locale = GetLocale()
local chatMesage = locale == "ruRU" and {
	-- Ущелье Песни Войны
	["Битва за Ущелье Песни Войны начнется через 30 секунд. Приготовьтесь!"] = "1;30;120",
	["Битва за Ущелье Песни Войны начнется через 1 минуту."] = "1;60;120",
	["Сражение в Ущелье Песни Войны начнется через 2 минуты."] = "1;60;120",
	-- Низина Арати
	["Битва за Низину Арати начнется через 30 секунд. Приготовьтесь!"] = "1;30;120",
	["Битва за Низину Арати начнется через 1 минуту."] = "1;60;120",
	["Сражение в Низине Арати начнется через 2 минуты."] = "1;120;120",
	-- Око Бури
	["Битва за Око Бури начнется через 30 секунд."] = "1;30;120",
	["Битва за Око Бури начнется через 1 минуту."] = "1;60;120",
	["Сражение в Око Бури начнется через 2 минуты."] = "1;120;120",
	-- Альтеракская долина
	["Сражение на Альтеракской долине начнется через 30 секунд. Приготовьтесь!"] = "1;30;120",
	["Сражение на Альтеракской долине начнется через 1 минуту."] = "1;60;120",
	["Сражение на Альтеракской долине начнется через 2 минуты."] = "1;120;120",
	-- Берег Древних
	["Битва за Берег Древних начнется через 30 секунд. Приготовьтесь!"] = "1;30;120",
	["Битва за Берег Древних начнется через 1 минуту."] = "1;60;120",
	["Битва за Берег Древних начнется через 2 минуты."] = "1;120;120",
	-- Берег древних 2-й раунд
	["Второй раунд начнется через 30 секунд. Приготовьтесь!"] = "1;30;60",
	["Второй раунд битвы за Берег Древних начнется через 1 минуту."] = "1;60;60",
	-- Другие
	["Битва начнется через 30 секунд!"] = "1;30;120",
	["Битва начнется через 1 минуту."] = "1;60;120",
	["Битва начнется через 2 минуты."] = "1;120;120",
	-- Арена
	["15 секунд до начала боя на арене!"] = "1;15;60",
	["30 секунд до начала боя на арене!"] = "1;30;60",
	["1 минута до начала боя на арене!"] = "1;60;60",
} or {
	-- WSG
	["The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!"] = "1;30;120",
	["The battle for Warsong Gulch begins in 1 minute."] = "1;60;120",
	["The battle for Warsong Gulch begins in 2 minutes."] = "1;120;120",
	-- AB
	["The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!"] = "1;30;120",
	["The Battle for Arathi Basin begins in 1 minute."] = "1;60;120",
	["The battle for Arathi Basin begins in 2 minutes."] = "1;60;120",
	-- EotS
	["The Battle for Eye of the Storm begins in 30 seconds."] = "1;30;120",
	["The Battle for Eye of the Storm begins in 1 minute."] = "1;60;120",
	["The battle for Eye of the Storm begins in 2 minutes."] = "1;120;120",
	-- AV
	["The Battle for Alterac Valley begins in 30 seconds. Prepare yourselves!"] = "1;30;120",
	["The Battle for Alterac Valley begins in 1 minute."] = "1;60;120",
	["The Battle for Alterac Valley begins in 2 minutes."] = "1;120;120",
	-- SotA
	["The battle for Strand of the Ancients begins in 30 seconds. Prepare yourselves!."] = "1;30;120",
	["The battle for Strand of the Ancients begins in 1 minute."] = "1;60;120",
	["The battle for Strand of the Ancients begins in 2 minutes."] = "1;120;120",
	-- SotA 2 round
	["Round 2 begins in 30 seconds. Prepare yourselves!"] = "1;30;60",
	["Round 2 of the Battle for the Strand of the Ancients begins in 1 minute."] = "1;60;60",
	-- Other
	["The battle will begin in 30 seconds!"] = "1;30;120",
	["The battle will begin in 1 minute."] = "1;60;120",
	["The battle will begin in two minutes."] = "1;120;120",
	-- Arena
	["Fifteen seconds until the Arena battle begins!"] = "1;15;60",
	["Thirty seconds until the Arena battle begins!"] = "1;30;60",
	["One minute until the Arena battle begins!"] = "1;60;60",
}

ChatMesage2 = chatMesage

TIMER_MINUTES_DISPLAY = "%d:%02d"
TIMER_TYPE_PVP = 1
TIMER_TYPE_CHALLENGE_MODE = 2

local TIMER_DATA = {
	[1] = {mediumMarker = 11, largeMarker = 6, updateInterval = 10},
	[2] = {mediumMarker = 100, largeMarker = 100, updateInterval = 100}
}

TIMER_NUMBERS_SETS = {}
TIMER_NUMBERS_SETS["BigGold"] = {
	texture = "Interface\\AddOns\\ElvUI_Enhanced\\media\\textures\\BigTimerNumbers",
	w = 256, h = 170, texW = 1024, texH = 512,
	numberHalfWidths = {
		-- 0,  	 1, 	  2,  	 3, 	  4,  	 5,  	 6, 	  7,  	 8,  	 9,
		35/128, 14/128, 33/128, 32/128, 36/128, 32/128, 33/128, 29/128, 31/128, 31/128,
	}
}

--[[
function GetPlayerFactionGroup()
	local factionGroup = UnitFactionGroup("player")
	-- this might be a rated BG or wargame and if so the player's faction might be altered
	if ( not IsActiveBattlefieldArena() ) then
		factionGroup = PLAYER_FACTION_GROUP[GetBattlefieldArenaFaction()]
	end

	return factionGroup
end
]]

function module:OnShow(timer)
	timer.time = timer.endTime - GetTime()
	if timer.time <= 0 then
		timer:Hide()
		timer.isFree = true
	elseif timer.digit.startNumbers:IsPlaying() then
		timer.digit.startNumbers:Stop()
		timer.digit.startNumbers:Play()
	end
end

function module:StartTimerBar(self)
	self.bar = CreateFrame("StatusBar", "$parentStatusBar", self)
	self.bar:SetSize(195, 13)
	self.bar:SetPoint("TOP", 0, -2)
	self.bar:SetAlpha(0)
	self.bar:SetStatusBarTexture(E.media.glossTex)
	E:RegisterStatusBar(self.bar)
	self.bar:CreateBackdrop("Default")

	self.bar.bg = self.bar:CreateTexture("$parentBackgrund", "BORDER")
	self.bar.bg:SetAllPoints()
	self.bar.bg:SetTexture(E.media.blankTex)

	self.timeText = self.bar:CreateFontString("$parentTimeText", "OVERLAY", "GameFontHighlight")
	self.timeText:SetSize(0, 9)
	self.timeText:SetPoint("CENTER", 0, 0)

	self.fadeBarIn = CreateAnimationGroup(self.bar):CreateAnimation("Fade")
	self.fadeBarIn:SetDuration(1.9)
	self.fadeBarIn:SetChange(1)

	self.fadeBarIn:SetScript("OnPlay", function()
		self.bar:SetAlpha(0)
	end)

	self.fadeBarIn:SetScript("OnFinished", function()
		self.bar:SetAlpha(1)
	end)

	self.fadeBarOut = CreateAnimationGroup(self.bar):CreateAnimation("Fade")
	self.fadeBarOut:SetDuration(0.9)
	self.fadeBarOut:SetChange(-1)

	self.fadeBarOut:SetScript("OnFinished", function()
		self.bar:SetAlpha(0)
		self.time = self.time - 0.9

		self.digit.startNumbers:Play()
	end)
end

function module:CreateTimer(...)
	local timerType, timeSeconds, totalTime = ...
	if not timerType then
		return
	end

	local timer
	local numTimers = 0
	local isTimerRunning = false

	for a, b in pairs(self.timerList) do
		if b.type == timerType and not b.isFree then
			timer = b
			isTimerRunning = true
			break
		end
	end

	if isTimerRunning then
		-- don't interupt the final count down
		if not timer.digit.startNumbers:IsPlaying() then
			timer.time = timeSeconds
			timer.endTime = GetTime() + timeSeconds
		end
	else
		for a, b in pairs(self.timerList) do
			if not timer and b.isFree then
				timer = b
			else
				numTimers = numTimers + 1
			end
		end

		if not timer then
			timer = CreateFrame("FRAME", "ElvUI_Timer"..(#self.timerList+1), UIParent, "StartTimerBar")
			self:StartTimerBar(timer)
			self.timerList[#self.timerList+1] = timer
		end

		timer:ClearAllPoints()
		timer:SetPoint("TOP", 0, -155 - (24*numTimers))

		timer.isFree = false
		timer.type = timerType
		timer.time = timeSeconds
		timer.endTime = GetTime() + timeSeconds
		timer.totalTime = totalTime
		timer.bar:SetMinMaxValues(0, totalTime)
		timer.style = TIMER_NUMBERS_SETS["BigGold"]

		timer.digit1 = timer.digit.digit1
		timer.digit2 = timer.digit.digit2

		timer.digit1:SetTexture(timer.style.texture)
		timer.digit2:SetTexture(timer.style.texture)
		timer.digit1:SetSize(timer.style.w/2, timer.style.h/2)
		timer.digit2:SetSize(timer.style.w/2, timer.style.h/2)
		--This is to compensate texture size not affecting GetWidth() right away.
		timer.digit1.width, timer.digit2.width = timer.style.w/2, timer.style.w/2

		timer.digit1.glow = timer.glow1
		timer.digit2.glow = timer.glow2
		timer.glow1:SetTexture(timer.style.texture.."Glow")
		timer.glow2:SetTexture(timer.style.texture.."Glow")

		timer.updateTime = TIMER_DATA[timer.type].updateInterval
		timer:SetScript("OnUpdate", self.BigNumberOnUpdate)
		timer:Show()
	end
	self:SetGoTexture(timer)
end

function module:BigNumberOnUpdate(elapsed)
	self.time = self.endTime - GetTime()
	self.updateTime = self.updateTime - elapsed
	local minutes, seconds = floor(self.time/60), floor(mod(self.time, 60))

	if self.time < TIMER_DATA[self.type].mediumMarker then
		self.anchorCenter = false
		if self.time < TIMER_DATA[self.type].largeMarker then
			module:SwitchToLargeDisplay(self)
			self.bar:SetAlpha(0)
		end
		self:SetScript("OnUpdate", nil)
		if self.barShowing then
			self.barShowing = false
			self.fadeBarOut:Play()
		else
			self.digit.startNumbers:Play()
		end
	elseif not self.barShowing then
		self.fadeBarIn:Play()
		self.barShowing = true
	elseif self.updateTime <= 0 then
		self.updateTime = TIMER_DATA[self.type].updateInterval
	end

	self.bar:SetValue(self.time)
	local r, g, b = E:ColorGradient((self.time - 10)/self.totalTime, 1,0,0, 1,1,0, 0,1,0)
	self.bar:SetStatusBarColor(r, g, b)
	self.bar.bg:SetVertexColor(r * 0.25, g * 0.25, b * 0.25)
	self.timeText:SetText(format(TIMER_MINUTES_DISPLAY, minutes, seconds))
end


function module:BarOnlyOnUpdate(elapsed)
	self.time = self.endTime - GetTime()
	local minutes, seconds = floor(self.time/60), mod(self.time, 60)

	self.bar:SetValue(self.time)
	self.timeText:SetText(format(TIMER_MINUTES_DISPLAY, minutes, seconds))

	if self.time < 0 then
		self:SetScript("OnUpdate", nil)
		self.barShowing = false
		self.isFree = true
		self:Hide()
	end

	if not self.barShowing then
		self.fadeBarIn:Play()
		self.barShowing = true
	end
end

function module:SetTexNumbers(timer, ...)
	local digits = {...}
	local timeDigits = floor(timer.time)
	local digit
	local style = timer.style
	local i = 1

	local texCoW = style.w/style.texW
	local texCoH = style.h/style.texH
	local l,r,t,b
	local columns = floor(style.texW/style.w)
	local numberOffset = 0
	local numShown = 0

	while digits[i] do
		if timeDigits > 0 then
			digit = mod(timeDigits, 10)

			digits[i].hw = style.numberHalfWidths[digit+1]*digits[i].width
			numberOffset  = numberOffset + digits[i].hw

			l = mod(digit, columns) * texCoW
			r = l + texCoW
			t = floor(digit/columns) * texCoH
			b = t + texCoH
			digits[i]:SetTexCoord(l, r, t, b)
			digits[i].glow:SetTexCoord(l, r, t, b)

			timeDigits = floor(timeDigits/10)
			numShown = numShown + 1
		else
			digits[i]:SetTexCoord(0, 0, 0, 0)
			digits[i].glow:SetTexCoord(0, 0, 0, 0)
		end
		i = i + 1
	end

	if numberOffset > 0 then
		digits[1]:ClearAllPoints()
		if(timer.anchorCenter) then
			digits[1]:SetPoint("CENTER", UIParent, "CENTER", numberOffset - digits[1].hw, 0)
		else
			digits[1]:SetPoint("CENTER", timer, "CENTER", numberOffset - digits[1].hw, 0)
		end

		for i = 2, numShown do
			digits[i]:ClearAllPoints()
			digits[i]:SetPoint("CENTER", digits[i-1], "CENTER", -(digits[i].hw + digits[i-1].hw), 0)
			i = i + 1
		end
	end
end

function module:SetGoTexture(timer)
	if timer.type == TIMER_TYPE_PVP then
		local factionGroup = UnitFactionGroup("player")
		if factionGroup and factionGroup ~= "Neutral" then
			timer.GoTexture:SetTexture("Interface\\AddOns\\ElvUI\\media\\textures\\"..factionGroup.."-Logo")
			timer.GoTextureGlow:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\media\\textures\\"..factionGroup.."Glow-Logo")
		end
	elseif timer.type == TIMER_TYPE_CHALLENGE_MODE then
		timer.GoTexture:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\media\\textures\\Challenges-Logo")
		timer.GoTextureGlow:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\media\\textures\\ChallengesGlow-Logo")
	end
end

function module:NumberAnimOnFinished(timer)
	timer.time = timer.time - 1
	if timer.time > 0 then
		if timer.time < TIMER_DATA[timer.type].largeMarker then
			self:SwitchToLargeDisplay(timer)
		end
		timer.digit.startNumbers:Play()
	else
		timer.anchorCenter = false
		timer.isFree = true
		timer.GoTexture.GoTextureAnim:Play()
		timer.GoTextureGlow.GoTextureAnim:Play()
	end
end

function module:SwitchToLargeDisplay(timer)
	if not timer.anchorCenter then
		timer.anchorCenter = true

		timer.digit1.width, timer.digit2.width = timer.style.w, timer.style.w
		timer.digit1:SetSize(timer.style.w, timer.style.h)
		timer.digit2:SetSize(timer.style.w, timer.style.h)
	end
end

function module:CHAT_MSG_BG_SYSTEM_NEUTRAL(event, msg)
	if msg and msg ~= nil and chatMesage[msg] then
		local timerType, timeSeconds, totalTime = split(";", chatMesage[msg])
		module:CreateTimer(tonumber(timerType), tonumber(timeSeconds), tonumber(totalTime))
	end
end

function module:HookDBM()
	if DBM then
		if E.db.enhanced.timerTracker.dbm then
			self:SecureHook(DBM, "CreatePizzaTimer", function(_, time, text)
				if text == DBM_CORE_TIMER_PULL then
					DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL)
					self:CreateTimer(2, tonumber(time), tonumber(time))
				end
			end)
		else
			self:Unhook(DBM, "CreatePizzaTimer")
		end
	end
end

function module:Initialize()
	if not E.db.enhanced.timerTracker.enable then return end

	self.timerList = {}
	self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")

	self:HookDBM()
end

local function InitializeCallback()
	module:Initialize()
end

E:RegisterModule(module:GetName(), InitializeCallback)