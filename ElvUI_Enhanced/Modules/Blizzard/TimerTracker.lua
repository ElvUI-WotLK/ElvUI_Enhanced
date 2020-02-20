local E, L, V, P, G = unpack(ElvUI)
local TT = E:NewModule("Enhanced_TimerTracker", "AceHook-3.0", "AceEvent-3.0")

local ipairs = ipairs
local tonumber = tonumber
local unpack = unpack
local floor, fmod = math.floor, math.fmod

local GetTime = GetTime
local UnitFactionGroup = UnitFactionGroup

local timerTypes = {
	["30-120"] = {1, 30, 120},
	["60-120"] = {1, 60, 120},
	["120-120"] = {1, 120, 120},
	["15-60"] = {1, 15, 60},
	["30-60"] = {1, 30, 60},
	["60-60"] = {1, 60, 60},
}

local chatMessage = {
	-- Ущелье Песни Войны
	["Битва за Ущелье Песни Войны начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Битва за Ущелье Песни Войны начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение в Ущелье Песни Войны начнется через 2 минуты."] = timerTypes["120-120"],
	-- Низина Арати
	["Битва за Низину Арати начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Битва за Низину Арати начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение в Низине Арати начнется через 2 минуты."] = timerTypes["120-120"],
	-- Око Бури
	["Битва за Око Бури начнется через 30 секунд."] = timerTypes["30-120"],
	["Битва за Око Бури начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение в Око Бури начнется через 2 минуты."] = timerTypes["120-120"],
	-- Альтеракская долина
	["Сражение на Альтеракской долине начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Сражение на Альтеракской долине начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение на Альтеракской долине начнется через 2 минуты."] = timerTypes["120-120"],
	-- Берег Древних
	["Битва за Берег Древних начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Битва за Берег Древних начнется через 1 минуту."] = timerTypes["60-120"],
	["Битва за Берег Древних начнется через 2 минуты."] = timerTypes["120-120"],
	-- Берег древних 2-й раунд
	["Второй раунд начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-60"],
	["Второй раунд битвы за Берег Древних начнется через 1 минуту."] = timerTypes["60-60"],
	-- Другие
	["Битва начнется через 30 секунд!"] = timerTypes["30-120"],
	["Битва начнется через 1 минуту."] = timerTypes["60-120"],
	["Битва начнется через 2 минуты."] = timerTypes["120-120"],
	-- Арена
	["15 секунд до начала боя на арене!"] = timerTypes["15-60"],
	["30 секунд до начала боя на арене!"] = timerTypes["30-60"],
	["1 минута до начала боя на арене!"] = timerTypes["60-60"],
	["Пятнадцать секунд до начала боя на арене!"] = timerTypes["15-60"],
	["Тридцать секунд до начала боя на арене !"] = timerTypes["30-60"],

	-- WSG
	["The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-120"],
	["The battle for Warsong Gulch begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Warsong Gulch begins in 2 minutes."] = timerTypes["120-120"],
	-- AB
	["The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-120"],
	["The Battle for Arathi Basin begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Arathi Basin begins in 2 minutes."] = timerTypes["120-120"],
	-- EotS
	["The Battle for Eye of the Storm begins in 30 seconds."] = timerTypes["30-120"],
	["The Battle for Eye of the Storm begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Eye of the Storm begins in 2 minutes."] = timerTypes["120-120"],
	-- AV
	["The Battle for Alterac Valley begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-120"],
	["The Battle for Alterac Valley begins in 1 minute."] = timerTypes["60-120"],
	["The Battle for Alterac Valley begins in 2 minutes."] = timerTypes["120-120"],
	-- SotA
	["The battle for Strand of the Ancients begins in 30 seconds. Prepare yourselves!."] = timerTypes["30-120"],
	["The battle for Strand of the Ancients begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Strand of the Ancients begins in 2 minutes."] = timerTypes["120-120"],
	-- SotA 2 round
	["Round 2 begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-60"],
	["Round 2 of the Battle for the Strand of the Ancients begins in 1 minute."] = timerTypes["60-60"],
	-- Other
	["The battle will begin in 30 seconds!"] = timerTypes["30-120"],
	["The battle will begin in 1 minute."] = timerTypes["60-120"],
	["The battle will begin in two minutes."] = timerTypes["120-120"],
	["The battle begins in 30 seconds!"] = timerTypes["30-120"],
	["The battle begins in 1 minute!"] = timerTypes["60-120"],
	["The battle begins in 2 minutes!"] = timerTypes["120-120"],
	-- Arena
	["Fifteen seconds until the Arena battle begins!"] = timerTypes["15-60"],
	["Thirty seconds until the Arena battle begins!"] = timerTypes["30-60"],
	["One minute until the Arena battle begins!"] = timerTypes["60-60"]
}

local TIMER_MINUTES_DISPLAY = "%d:%02d"
local TIMER_TYPE_PVP = 1
local TIMER_TYPE_CHALLENGE_MODE = 2

local TIMER_DATA = {
	[1] = {mediumMarker = 11, largeMarker = 6, updateInterval = 10},
	[2] = {mediumMarker = 100, largeMarker = 100, updateInterval = 100}
}

local TIMER_NUMBERS_SETS = {}
TIMER_NUMBERS_SETS["BigGold"] = {
	texture = "Interface\\AddOns\\ElvUI_Enhanced\\media\\textures\\BigTimerNumbers",
	w = 256, h = 170, texW = 1024, texH = 512,
	numberHalfWidths = {
		35/128, -- 0
		14/128, -- 1
		33/128, -- 2
		32/128, -- 3
		36/128, -- 4
		32/128, -- 5
		33/128, -- 6
		29/128, -- 7
		31/128, -- 8
		31/128, -- 9
	}
}

function TT:OnShow(timer)
	timer.time = timer.endTime - GetTime()

	if timer.time <= 0 then
		timer:Hide()
		timer.isFree = true
	elseif timer.digit.startNumbers:IsPlaying() then
		timer.digit.startNumbers:Stop()
		timer.digit.startNumbers:Play()
	end
end

function TT:CreateTimer(timerType, timeSeconds, totalTime)
	if not timerType then return end

	local timer
	local isTimerRunning = false

	for _, frame in ipairs(self.timerList) do
		if frame.type == timerType and not frame.isFree then
			timer = frame
			isTimerRunning = true
			break
		end
	end

	if isTimerRunning then
		if not timer.digit.startNumbers:IsPlaying() then
			timer.time = timeSeconds
			timer.endTime = GetTime() + timeSeconds
		end
	else
		for _, frame in ipairs(self.timerList) do
			if frame.isFree then
				timer = frame
				break
			end
		end

		if not timer then
			timer = CreateFrame("Frame", "ElvUI_Timer"..(#self.timerList + 1), UIParent, "ElvUI_StartTimerBar")
			self:CreateTimerBar(timer)
			self.timerList[#self.timerList+1] = timer
		end

		timer:ClearAllPoints()
		timer:Point("TOP", 0, -155 - (24 * #self.timerList))

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
		timer.digit1:Size(timer.style.w / 2, timer.style.h / 2)
		timer.digit2:Size(timer.style.w / 2, timer.style.h / 2)
		timer.digit1.width = timer.style.w / 2
		timer.digit2.width = timer.style.w / 2

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

function TT:CreateTimerBar(timer)
	timer.bar = CreateFrame("StatusBar", "$parentStatusBar", timer)
	timer.bar:SetSize(195, 13)
	timer.bar:SetPoint("TOP", 0, -2)
	timer.bar:SetAlpha(0)
	timer.bar:SetStatusBarTexture(E.media.glossTex)
	E:RegisterStatusBar(timer.bar)
	timer.bar:CreateBackdrop("Default")

	timer.bar.bg = timer.bar:CreateTexture("$parentBackgrund", "BORDER")
	timer.bar.bg:SetAllPoints()
	timer.bar.bg:SetTexture(E.media.blankTex)

	timer.timeText = timer.bar:CreateFontString("$parentTimeText", "OVERLAY", "GameFontHighlight")
	timer.timeText:SetSize(0, 9)
	timer.timeText:SetPoint("CENTER", 0, 0)

	timer.fadeBarIn = CreateAnimationGroup(timer.bar):CreateAnimation("Fade")
	timer.fadeBarIn:SetDuration(1.9)
	timer.fadeBarIn:SetChange(1)

	timer.fadeBarIn:SetScript("OnPlay", function()
		timer.bar:SetAlpha(0)
	end)

	timer.fadeBarIn:SetScript("OnFinished", function()
		timer.bar:SetAlpha(1)
	end)

	timer.fadeBarOut = CreateAnimationGroup(timer.bar):CreateAnimation("Fade")
	timer.fadeBarOut:SetDuration(0.9)
	timer.fadeBarOut:SetChange(-1)

	timer.fadeBarOut:SetScript("OnFinished", function()
		timer.bar:SetAlpha(0)
		timer.time = timer.time - 0.9

		timer.digit.startNumbers:Play()
	end)
end

function TT:BigNumberOnUpdate(elapsed)
	self.time = self.endTime - GetTime()
	self.updateTime = self.updateTime - elapsed

	local minutes, seconds = floor(self.time / 60), floor(fmod(self.time, 60))

	if self.time < TIMER_DATA[self.type].mediumMarker then
		self.anchorCenter = false

		if self.time < TIMER_DATA[self.type].largeMarker then
			TT:SwitchToLargeDisplay(self)
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
	self.timeText:SetFormattedText(TIMER_MINUTES_DISPLAY, minutes, seconds)

	local r, g, b = E:ColorGradient((self.time - 10) / self.totalTime, 1,0,0, 1,1,0, 0,1,0)
	self.bar:SetStatusBarColor(r, g, b)
	self.bar.bg:SetVertexColor(r * 0.25, g * 0.25, b * 0.25)
end

function TT:BarOnlyOnUpdate(elapsed)
	self.time = self.endTime - GetTime()
	local minutes, seconds = floor(self.time / 60), fmod(self.time, 60)

	self.bar:SetValue(self.time)
	self.timeText:SetFormattedText(TIMER_MINUTES_DISPLAY, minutes, seconds)

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

function TT:SetTexNumbers(timer, ...)
	local digits = {...}
	local timeDigits = floor(timer.time)
	local style = timer.style

	local texCoW = style.w / style.texW
	local texCoH = style.h / style.texH
	local columns = floor(style.texW / style.w)

	local digit, l, r, t, b
	local numberOffset, numShown = 0, 0
	local i = 1

	while digits[i] do
		if timeDigits > 0 then
			digit = fmod(timeDigits, 10)

			digits[i].hw = style.numberHalfWidths[digit+1] * digits[i].width
			numberOffset = numberOffset + digits[i].hw

			l = fmod(digit, columns) * texCoW
			r = l + texCoW
			t = floor(digit / columns) * texCoH
			b = t + texCoH

			digits[i]:SetTexCoord(l, r, t, b)
			digits[i].glow:SetTexCoord(l, r, t, b)

			timeDigits = floor(timeDigits / 10)
			numShown = numShown + 1
		else
			digits[i]:SetTexCoord(0, 0, 0, 0)
			digits[i].glow:SetTexCoord(0, 0, 0, 0)
		end

		i = i + 1
	end

	if numberOffset > 0 then
		digits[1]:ClearAllPoints()

		if timer.anchorCenter then
			digits[1]:Point("CENTER", UIParent, "CENTER", numberOffset - digits[1].hw, 0)
		else
			digits[1]:Point("CENTER", timer, "CENTER", numberOffset - digits[1].hw, 0)
		end

		for j = 2, numShown do
			digits[j]:ClearAllPoints()
			digits[j]:Point("CENTER", digits[j-1], "CENTER", -(digits[j].hw + digits[j-1].hw), 0)
		end
	end
end

function TT:SetGoTexture(timer)
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

function TT:NumberAnimOnFinished(timer)
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

function TT:SwitchToLargeDisplay(timer)
	if not timer.anchorCenter then
		timer.anchorCenter = true

		timer.digit1.width = timer.style.w
		timer.digit2.width = timer.style.w

		timer.digit1:Size(timer.style.w, timer.style.h)
		timer.digit2:Size(timer.style.w, timer.style.h)
	end
end

function TT:ReleaseTimers()
	for _, timer in ipairs(self.timerList) do
		timer.barShowing = false
		timer.isFree = true
	end
end

function TT:OnEvent(event, msg)
	if event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then
		if msg and chatMessage[msg] then
			self:CreateTimer(unpack(chatMessage[msg]))
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:ReleaseTimers()
	end
end

function TT:HookDBM()
	if not DBM then return end

	if E.db.enhanced.timerTracker.dbm then
		self:SecureHook(DBM, "CreatePizzaTimer", function(_, time, text)
			if text == DBM_CORE_TIMER_PULL then
				DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL)
				time = tonumber(time)
				self:CreateTimer(2, time, time)
			end
		end)
	else
		self:Unhook(DBM, "CreatePizzaTimer")
	end
end

function TT:ToggleState()
	if E.db.enhanced.timerTracker.enable then
		self.timerList = self.timerList or {}

		self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "OnEvent")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")

		self:HookDBM()
	else
		self:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")

		self:Unhook(DBM, "CreatePizzaTimer")
		self:ReleaseTimers()
	end
end

function TT:Initialize()
	if not E.db.enhanced.timerTracker.enable then return end

	self:ToggleState()
end

local function InitializeCallback()
	TT:Initialize()
end

E:RegisterModule(TT:GetName(), InitializeCallback)