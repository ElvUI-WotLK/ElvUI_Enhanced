local E, L, V, P, G, _ = unpack(ElvUI)
local LOS = E:NewModule("Enhanced_LoseControl", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	if not name then
		print("|cff1784d1ElvUI:|r SpellID is not valid: "..id..". Please check for an updated version, if none exists report to ElvUI author.")
		return "Impale"
	else
		return name
	end
end

G.loseControl = {
-- Рыцарь смерти
	[SpellName(47481)] = "CC", -- Отгрызть
	[SpellName(51209)] = "CC", -- Ненасытная стужа
	[SpellName(47476)] = "Silence", -- Удушение
	[SpellName(45524)] = "Snare", -- Ледяные оковы
	[SpellName(55666)] = "Snare", -- Осквернение
	[SpellName(58617)] = "Snare", -- Символ удара в сердце
	[SpellName(50436)] = "Snare", -- Ледяная хватка
-- Друид
	[SpellName(5211)] = "CC", -- Оглушить
	[SpellName(33786)] = "CC", -- Смерч
	[SpellName(2637)] = "CC", -- Спячка
	[SpellName(22570)] = "CC", -- Калечение
	[SpellName(9005)] = "CC", -- Наскок
	[SpellName(339)] = "Root",	-- Гнев деревьев
	[SpellName(19675)] = "Root", -- Звериная атака - эффект
	[SpellName(58179)] = "Snare", -- Зараженные раны
	[SpellName(61391)] = "Snare", -- Тайфун
-- Охотник
	[SpellName(60210)] = "CC", -- Эффект замораживающей стрелы
	[SpellName(3355)] = "CC", -- Эффект замораживающей ловушки
	[SpellName(24394)] = "CC", -- Устрашение
	[SpellName(1513)] = "CC", -- Отпугивание зверя
	[SpellName(19503)] = "CC", -- Дизориентирующий выстрел
	[SpellName(19386)] = "CC", -- Укус виверны
	[SpellName(34490)] = "Silence", -- Глушащий выстрел
	[SpellName(53359)] = "Disarm", -- Выстрел химеры - сорпид
	[SpellName(19306)] = "Root", -- Контратака
	[SpellName(19185)] = "Root", -- Удержание
	[SpellName(35101)] = "Snare", -- Шокирующий залп
	[SpellName(5116)] = "Snare", -- Контузящий выстрел
	[SpellName(13810)] = "Snare", -- Аура ледяной ловушки
	[SpellName(61394)] = "Snare", -- Символ заморажевающей ловушки
	[SpellName(2974)] = "Snare", -- Подрезать крылья
-- Питомец Охотника
	[SpellName(50519)] = "CC", -- Ультразвук
	[SpellName(50541)] = "Disarm", -- Хватка
	[SpellName(54644)] = "Snare", -- Дыхание ледяной бури
	[SpellName(50245)] = "Root", -- Шип
	[SpellName(50271)] = "Snare", -- Повреждение сухожилий
	[SpellName(50518)] = "CC", -- Накинуться
	[SpellName(54706)] = "Root", -- Ядовитая паутина
	[SpellName(4167)] = "Root", -- Сеть
-- Маг
	[SpellName(44572)] = "CC", -- Глубокая замарозка
	[SpellName(31661)] = "CC", -- Дыхание дракона
	[SpellName(12355)] = "CC", -- Сотрясение
	[SpellName(118)] = "CC", -- Превращение
	[SpellName(18469)] = "Silence", -- Антимагия - немота
	[SpellName(64346)] = "Disarm", -- Огненная расплата
	[SpellName(33395)] = "Root", -- Холод
	[SpellName(122)] = "Root", -- Кольцо льда
	[SpellName(11071)] = "Root", -- Обморожение
	[SpellName(55080)] = "Root", -- Разрушенная преграда
	[SpellName(11113)] = "Snare", -- Врзрывная волна
	[SpellName(6136)] = "Snare", -- Окоченение
	[SpellName(120)] = "Snare", -- Конус льда
	[SpellName(116)] = "Snare", -- Ледяная стрела
	[SpellName(47610)] = "Snare", -- Стрела ледяного огня
	[SpellName(31589)] = "Snare", -- Замедление
-- Паладин
	[SpellName(853)] = "CC", -- Молот правосудия
	[SpellName(2812)] = "CC", -- Гнев небес
	[SpellName(20066)] = "CC", -- Покаяние
	[SpellName(20170)] = "CC", -- Оглушение
	[SpellName(10326)] = "CC", -- Изгнание зла
	[SpellName(63529)] = "Silence", -- Немота - Щит храмовника
	[SpellName(20184)] = "Snare", -- Правосудие справедливости
-- Жрец
	[SpellName(605)] = "CC", -- Контроль над разумом
	[SpellName(64044)] = "CC", -- Глубинный ужас
	[SpellName(8122)] = "CC", -- Ментальный крик
	[SpellName(9484)] = "CC", -- Сковывание нежити
	[SpellName(15487)] = "Silence", -- Безмолвие
	[SpellName(64058)] = "Disarm", -- Глубинный ужас
	[SpellName(15407)] = "Snare", -- Пытка разума
-- Разбойник
	[SpellName(2094)] = "CC", -- Ослепление
	[SpellName(1833)] = "CC", -- Подлый трюк
	[SpellName(1776)] = "CC", -- Парализующий удар
	[SpellName(408)] = "CC", -- Удар по почкам
	[SpellName(6770)] = "CC", -- Ошеломление
	[SpellName(1330)] = "Silence", -- Гаррота - немота
	[SpellName(18425)] = "Silence", -- Пинок - немота
	[SpellName(51722)] = "Disarm", -- Долой оружие
	[SpellName(31125)] = "Snare", -- Вращение лезвий
	[SpellName(3409)] = "Snare", -- Калечащий яд
	[SpellName(26679)] = "Snare", -- Смертельный бросок
-- Шаман
	[SpellName(39796)] = "CC", -- Оглушение каменного когтя
	[SpellName(51514)] = "CC", -- Сглаз
	[SpellName(64695)] = "Root", -- Хватка земли
	[SpellName(63685)] = "Root", -- Заморозка
	[SpellName(3600)] = "Snare", -- Оковы земли
	[SpellName(8056)] = "Snare", -- Ледяной шок
	[SpellName(8034)] = "Snare", -- Наложение ледяного клейма
-- Чернокнижник
	[SpellName(710)] = "CC", -- Изгнание
	[SpellName(6789)] = "CC", -- Лик смерти
	[SpellName(5782)] = "CC", -- Страх
	[SpellName(5484)] = "CC", -- Вой ужаса
	[SpellName(6358)] = "CC", -- Соблазн
	[SpellName(30283)] = "CC", -- Неистовство Тьмы
	[SpellName(24259)] = "Silence", -- Запрет чар
	[SpellName(18118)] = "Snare", -- Огненный шлейф
	[SpellName(18223)] = "Snare", -- Проклятие изнеможения
-- Воин
	[SpellName(7922)] = "CC", -- Наскок и оглушение
	[SpellName(12809)] = "CC", -- Оглушающий удар
	[SpellName(20253)] = "CC", -- Перехват
	[SpellName(5246)] = "CC", -- Устрашающий крик
	[SpellName(12798)] = "CC", -- Реванш - оглушение
	[SpellName(46968)] = "CC", -- Ударная волна
	[SpellName(18498)] = "Silence", -- Обет молчания - немота
	[SpellName(676)] = "Disarm", -- Разоружение
	[SpellName(58373)] = "Root", -- Символ подрезанного сухожилия
	[SpellName(23694)] = "Root", -- Улучшенное подрезание сухожилий
	[SpellName(1715)] = "Snare", -- Подрезать сухожилия
	[SpellName(12323)] = "Snare", -- Пронзительный вой
-- Разные
	[SpellName(30217)] = "CC", -- Адамантитовая граната
	[SpellName(67769)] = "CC", -- Кобальтовая осколочная бомба
	[SpellName(30216)] = "CC", -- Бомба из оскверненного железа
	[SpellName(20549)] = "CC", -- Громовая поступь
	[SpellName(25046)] = "Silence", -- Волшебный поток
	[SpellName(39965)] = "Root", -- Замораживающая граната
	[SpellName(55536)] = "Root", -- Сеть из ледяной ткани
	[SpellName(13099)] = "Root", -- Сетестрел
	[SpellName(29703)] = "Snare", -- Головокружение
-- PvE
	[SpellName(28169)] = "PvE", -- Мутагенный укол
	[SpellName(28059)] = "PvE", -- Положительный заряд
	[SpellName(28084)] = "PvE", -- Отрицательный заряд
	[SpellName(27819)] = "PvE", -- Взрыв маны
	[SpellName(63024)] = "PvE", -- Гравитационная бомба
	[SpellName(63018)] = "PvE", -- Опаляющий свет
	[SpellName(62589)] = "PvE", -- Гнев природы
	[SpellName(63276)] = "PvE", -- Метка Безликого
	[SpellName(66770)] = "PvE", -- Свирепое бодание
	[SpellName(71340)] = "PvE", -- Пакт Омраченных
	[SpellName(70126)] = "PvE", -- Ледяная метка
	[SpellName(73785)] = "PvE" -- Мертвящая чума
}

local abilities = {}

function LOS:OnUpdate(elapsed)
	if(self.timeLeft) then
		self.timeLeft = self.timeLeft - elapsed

		if(self.timeLeft >= 10) then
			self.NumberText:SetFormattedText("%d", self.timeLeft)
		elseif (self.timeLeft < 9.95) then
			self.NumberText:SetFormattedText("%.1f", self.timeLeft)
		end
	end
end

function LOS:UNIT_AURA()
	local maxExpirationTime = 0
	local Icon, Duration

	for i = 1, 40 do
		local name, _, icon, _, _, duration, expirationTime = UnitDebuff("player", i)

		if(E.db.enhanced.loseControl[abilities[name]] and expirationTime > maxExpirationTime) then
			maxExpirationTime = expirationTime
			Icon = icon
			Duration = duration

			self.AbilityName:SetText(name)
		end
	end

	if(maxExpirationTime == 0) then
		self.maxExpirationTime = 0
		self.frame.timeLeft = nil
		self.frame:SetScript("OnUpdate", nil)
		self.frame:Hide()
	elseif(maxExpirationTime ~= self.maxExpirationTime) then
		self.maxExpirationTime = maxExpirationTime

		self.Icon:SetTexture(Icon)

		self.Cooldown:SetCooldown(maxExpirationTime - Duration, Duration)

		local timeLeft = maxExpirationTime - GetTime()
		if(not self.frame.timeLeft) then
			self.frame.timeLeft = timeLeft

			self.frame:SetScript("OnUpdate", self.OnUpdate)
		else
			self.frame.timeLeft = timeLeft
		end

		self.frame:Show()
	end
end

function LOS:Initialize()
	if not E.db.enhanced.loseControl.enable then return end

	self.frame = CreateFrame("Frame", "ElvUI_loseControlFrame", UIParent)
	self.frame:Point("CENTER", 0, 0)
	self.frame:Size(54)
	self.frame:SetTemplate()
	self.frame:Hide()

	for name, v in pairs(G.loseControl) do
		if(name) then
			abilities[name] = v
		end
	end

	E:CreateMover(self.frame, "LoseControlMover", L["Lose Control Icon"])

	self.Icon = self.frame:CreateTexture(nil, "ARTWORK")
	self.Icon:SetInside()
	self.Icon:SetTexCoord(.1, .9, .1, .9)

	self.AbilityName = self.frame:CreateFontString(nil, "OVERLAY")
	self.AbilityName:FontTemplate(E["media"].normFont, 20, "OUTLINE")
	self.AbilityName:SetPoint("BOTTOM", self.frame, 0, -28)

	self.Cooldown = CreateFrame("Cooldown", self.frame:GetName().."Cooldown", self.frame, "CooldownFrameTemplate")
	self.Cooldown:SetInside()

	self.frame.NumberText = self.frame:CreateFontString(nil, "OVERLAY")
	self.frame.NumberText:FontTemplate(E["media"].normFont, 20, "OUTLINE")
	self.frame.NumberText:SetPoint("BOTTOM", self.frame, 0, -58)

	self.SecondsText = self.frame:CreateFontString(nil, "OVERLAY")
	self.SecondsText:FontTemplate(E["media"].normFont, 20, "OUTLINE")
	self.SecondsText:SetPoint("BOTTOM", self.frame, 0, -80)
	self.SecondsText:SetText(L["seconds"])

	self:RegisterEvent("UNIT_AURA")
end

local function InitializeCallback()
	LOS:Initialize()
end

E:RegisterModule(LOS:GetName(), InitializeCallback)