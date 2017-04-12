-- Russian localization file for ruRU.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "ruRU")
if not L then return end

-- Init
L["ENH_LOGIN_MSG"] = "Вы используете |cff1784d1ElvUI Enhanced|r |cffff8000(WotLK)|r версии %s%s|r."

-- Chat
L["Replaces long reports from damage meters with a clickeble hyperlink to reduce chat spam."] = "Заменяет длинные отчеты от аддонов для измерения УВС на гиперссылку, сокращая уровень спама в чате."

-- Equipment
L["Equipment"] = "Экипировка"

L["DURABILITY_DESC"] = "Настройка параметров информации о прочности предметов в окне персонажа."
L["Enable/Disable the display of durability information on the character screen."] = "Включить/Выключить отображение информации о прочности предметов в окне персонажа."
L["Damaged Only"] = "Только поврежденные"
L["Only show durabitlity information for items that are damaged."] = "Показывать уровень прочности только на поврежденных предметах."

L["ITEMLEVEL_DESC"] = "Настройка параметров информации об уровне предмета в окне персонажа."
L["Enable/Disable the display of item levels on the character screen."] = "Включить/Выключить отображение уровня предмета в окне персонажа."

-- Movers
L["Mover Transparency"] = "Прозрачность фиксаторов"
L["Changes the transparency of all the movers."] = "Изменяет прозрачность фиксаторов"

-- Minimap Location
L["Location Panel"] = true
L["Toggle Location Panel."] = true
L["Above Minimap"] = "Над миникартой"
L["Location Digits"] = "Цифры координат"
L["Number of digits for map location."] = "Колличество цифр после запятой в координатах."

-- Minimap Combat Hide
L["Combat Hide"] = true;
L["Hide minimap while in combat."] = "Скрывать миникарту во время боя."
L["FadeIn Delay"] = "Задержка появления"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Время ожидания появления миникарты после выхода из боя. (0 = Выключено)"

-- PvP Autorelease
L["PvP Autorelease"] = "Автовыход из тела"
L["Automatically release body when killed inside a battleground."] = "Автоматически покидать тело после смерти на полях боя."

-- Track Reputation
L["Track Reputation"] = "Отслеживание репутации"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Автоматическое изменение фракции на панели репутации на ту, очки репутации которой вы получили."

-- Item Level Datatext
L["Item Level"] = "Уровень предметов"

-- Range Datatext
L["Target Range"] = "Расстояние до цели"
L["Distance"] = "Дистанция"

-- Time Datatext
L["Enhanced Time Color"] = true

-- Tooltip
L["Progress Info"] = "Прогресс"
L["Check Player"] = "Проверять себя";
L["Tiers"] = "Тиры";
L["Ruby Sanctum"] = "Рубиновое Святилище";
L["Icecrown Citadel"] = "Цитадель Ледяной Короны";
L["Trial of the Crusader"] = "Испытание Крестоносца";
L["Ulduar"] = "Ульдуар";
L["RS"] = "РС";
L["ICC"] = "ЦЛК";
L["TotC"] = "ИК";

-- WatchFrame
L["WatchFrame"] = "Список заданий"
L["WATCHFRAME_DESC"] = "Настройте отображение списка заданий (квест лог) исходя из ваших личных предпочтений."
L["Hidden"] = "Скрыть"
L["Collapsed"] = "Развернуть"
L["Settings"] = "Настройки"
L["City (Resting)"] = "Город (отдых)"
L["PvP"] = "PvP"
L["Arena"] = "Арена"
L["Party"] = "Группа"
L["Raid"] = "Рейд"