--Russian localization
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "ruRU")
if not L then return end

-- Init
L["ENH_LOGIN_MSG"] = "Вы используете |cff1784d1ElvUI Enhanced Again|r |cffff8000(Legion)|r версии %s%s|r."
L["Your version of ElvUI is to old (required v5.25 or higher). Please, download the latest version from tukui.org."] = "Ваша версия ElvUI устарела(требуется v5.25 или выше). Пожалуйста, скачайте последнюю версию с tukui.org."

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

-- Auto Hide Role Icons in combat
L["Hide Role Icon in combat"] = "Скрыть иконку роли в бою"
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = "Все иконки ролей (дд/хил/танк) на фреймах юнитов будут скрыты во время боя."

-- Attack Icon
L["Attack Icon"] = "Иконка атаки"
L["Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked."] = "Показывать иконку атаки на цели, которая не была затронута вами или вашей группой, но которая принесет почетную победу при атаке."

-- Class Icon
L["Show class icon for units."] = "Показывать иконку класса на цели."

-- Minimap Location
L["Above Minimap"] = "Над миникартой"
L["Location Digits"] = "Цифры координат"
L["Number of digits for map location."] = "Колличество цифр после запятой в координатах."

-- Minimap Combat Hide
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

-- Extra Datatexts
L["Actionbar1DataPanel"] = "Панель 1"
L["Actionbar3DataPanel"] = "Панель 3"
L["Actionbar5DataPanel"] = "Панель 5"

-- Nameplates
L["Threat Text"] = "Текст угрозы";
L["Display threat level as text on targeted, boss or mouseover nameplate."] = "Показывать уровень угрозы на цели, боссе или при наведении курсора на индикатор здоровья.";
L["Target Count"] = "Число целей";
L["Display the number of party / raid members targetting the nameplate unit."] = "Показывать количество членов группы/рейда выбравших текущую цель на индикаторе здоровья.";

-- HealGlow
L["Heal Glow"] = "Подсветка лечения"
L["Direct AoE heals will let the unit frames of the affected party / raid members glow for the defined time period."] = "Прямое АоЕ лечение будет подсвечивать рамки юнитов раненых членов группы/рейда в течении определенного времени."
L["Glow Duration"] = "Продолжительность подсветки"
L["The amount of time the unit frames of party / raid members will glow when affected by a direct AoE heal."] = "Время подсветки рамок юнитов группы/рейда во время прямого АоЕ лечения"
L["Glow Color"] = "Цвет подсветки"

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
