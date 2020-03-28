local E = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("ElvUI", "ruRU")

-- DESC locales
L["ENH_LOGIN_MSG"] = "Вы используете |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(WotLK)|r версии %s%s|r."
L["DURABILITY_DESC"] = "Настройка параметров информации о прочности предметов в окне персонажа."
L["ITEMLEVEL_DESC"] = "Настройка параметров информации об уровне предмета в окне персонажа."
L["WATCHFRAME_DESC"] = "Настройте отображение списка заданий (квест лог) исходя из ваших личных предпочтений."

-- Incompatibility
L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"] = "GearScore '3.1.20b - Release' не для WotLK. Загрузите 3.1.7. Отключить эту версию?"

-- AddOn List
L["Enable All"] = true
L["Dependencies: "] = true
L["Disable All"] = true
L["Load AddOn"] = true
L["Requires Reload"] = true

-- Chat
L["Filter DPS meters Spam"] = true
L["Replaces reports from damage meters with a clickable hyperlink to reduce chat spam"] = true

-- Datatext
L["Ammo/Shard Counter"] = true
L["Combat Indicator"] = true
L["Distance"] = true
L["In Combat"] = true
L["New Mail"] = "Новое письмо"
L["No Mail"] = "Нет писем"
L["Out of Combat"] = true
L["Reincarnation"] = true
L["Target Range"] = true

-- Death Recap
L["Death Recap Frame"] = true
L["%s %s"] = "Урон: %s %s"
L["%s by %s"] = "%s - %s"
L["%s sec before death at %s%% health."] = "%s сек. до смерти при объеме здоровья %s%%"
L["(%d Absorbed)"] = "Поглощено: %d ед. урона."
L["(%d Blocked)"] = "Заблокировано: %d уд. урона."
L["(%d Overkill)"] = "Избыточный урон: %d ед."
L["(%d Resisted)"] = "Сопротивление %d еденицам урона."
L["Death Recap unavailable."] = "Информация о смерти не доступна."
L["Death Recap"] = "Информация о смерти"
L["Killing blow at %s%% health."] = "Объем здоровья при получении смертельного удара: %s%%"
L["You died."] = "Вы умерли."

-- Decline Duels
L["Auto decline all duels"] = "Автоматически отклонять все дуэли."
L["Decline Duel"] = true
L["Declined duel request from "] = "DДуэль отклонена от "

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = true
L["Enhanced Character Frame"] = true
L["Enhanced Model Frames"] = true
L["Inspect Background"] = true
L["Paperdoll Backgrounds"] = true
L["Pet Background"] = true

-- Equipment
L["Damaged Only"] = "Только поврежденные"
L["Enable/Disable the display of durability information on the character screen."] = "Включить/Выключить отображение информации о прочности предметов в окне персонажа."
L["Enable/Disable the display of item levels on the character screen."] = "Включить/Выключить отображение уровня предмета в окне персонажа."
L["Only show durabitlity information for items that are damaged."] = "Показывать уровень прочности только на поврежденных предметах."
L["Quality Color"] = true

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Animated Achievement Bars"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Автоматическое изменение фракции на панели репутации на ту, очки репутации которой вы получили."
L["Automatically release body when killed inside a battleground."] = "Автоматически покидать тело после смерти на полях боя."
L["Automatically select the quest reward with the highest vendor sell value."] = true
L["Change color of item icons which already known."] = true
L["Changes the transparency of all the movers."] = "Изменяет прозрачность фиксаторов"
L["Display quest levels at Quest Log."] = true
L["Hide Zone Text"] = true
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Mover Transparency"] = "Прозрачность фиксаторов"
L["PvP Autorelease"] = "Автовыход из тела"
L["Select Quest Reward"] = true
L["Show Quest Level"] = true
L["Track Reputation"] = "Отслеживание репутации"
L["Train All Button"] = true
L["Undress Button"] = true
L["Undress"] = "Раздеть"

-- HD Models Portrait Fix
L["Debug"] = true
L["List of models with broken portrait camera. Separete each model name with ';' simbol"] = true
L["Models to fix"] = true
L["Portrait HD Fix"] = true
L["Print to chat model names of units with enabled 3D portraits."] = true

-- Interrupt Tracker
L["Interrupt Tracker"] = true

-- Nameplates
L["Cache Unit Class"] = true

-- Minimap
L["Above Minimap"] = "Над миникартой"
L["Combat Hide"] = true
L["FadeIn Delay"] = "Задержка появления"
L["Hide minimap while in combat."] = "Скрывать миникарту во время боя."
L["Show Location Digits"] = true
L["Toggle Location Digits."] = true
L["Location Digits"] = "Цифры координат"
L["Location Panel"] = true
L["Number of digits for map location."] = "Колличество цифр после запятой в координатах."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Время ожидания появления миникарты после выхода из боя. (0 = Выключено)"
L["Toggle Location Panel."] = true

-- Timer Tracker
L["Timer Tracker"] = true
L["Hook DBM"] = true

-- Tooltip
L["Check Player"] = true
L["Check achievement completion instead of boss kill stats.\nSome servers log incorrect boss kill statistics, this is an alternative way to get player progress."] = true
L["Colorize the tooltip border based on item quality."] = "Окрашивать бордюр тултипа в цвет качества предмета"
L["Icecrown Citadel"] = true
L["Item Border Color"] = "Цвет рамки предметов"
L["Progress Info"] = "Прогресс"
L["Ruby Sanctum"] = true
L["Show/Hides an Icon for Achievements on the Tooltip."] = true
L["Show/Hides an Icon for Items on the Tooltip."] = true
L["Show/Hides an Icon for Spells on the Tooltip."] = true
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = true
L["Tiers"] = true
L["Tooltip Icon"] = true
L["Trial of the Crusader"] = true
L["Ulduar"] = true

-- Movers
L["Loss Control"] = "Потери контроля"
L["Player Portrait"] = "Портрет игрока"
L["Target Portrait"] = "Портрет цели"

-- Loss Control
L["CC"] = "Потеря контроля"
L["Disarm"] = "Разоружение"
L["Lose Control"] = "Иконка потери контроля"
L["PvE"] = "Рейдовые"
L["Root"] = "Удержание на месте"
L["Silence"] = "Молчание"
L["Snare"] = "Замедление"

-- Unitframes
L["Class Icons"] = true
L["Detached Height"] = "Высота при откреплении"
L["Show class icon for units."] = "Показывать иконку класса на цели."

-- WatchFrame
L["City (Resting)"] = "Город (отдых)"
L["Collapsed"] = "Развернуть"
L["Hidden"] = "Скрыть"
L["Party"] = "Группа"
L["PvP"] = "PvP"
L["Raid"] = "Рейд"

--
L["Drag"] = "Перетащить"
L["Left-click on character and drag to rotate."] = "Зажмите левую кнопку мыши и тащите курсор, чтобы вращать изображение."
L["Mouse Wheel Down"] = "Прокрутка вниз"
L["Mouse Wheel Up"] = "Прокрутка вверх"
L["Reset Position"] = "Сбросить позицию"
L["Right-click on character and drag to move it within the window."] = "Зажмите правую кнопку мыши и тащите курсор, чтобы переместить персонажа."
L["Rotate Left"] = "Вращение влево"
L["Rotate Right"] = "Вращение вправо"
L["Zoom In"] = "Приблизить"
L["Zoom Out"] = "Отдалить"

--
L["Character Stats"] = "Характеристики"
L["Damage Per Second"] = "Урон в секунду"
L["Equipment Manager"] = "Комплекты экипировки"
L["Hide Character Information"] = "Скрыть информацию о персонаже"
L["Hide Pet Information"] = "Скрыть информацию о питомце"
L["Item Level"] = "Уровень предметов"
L["New Set"] = "Новый комплект"
L["Resistance"] = "Cопротивление"
L["Show Character Information"] = "Показать информацию о персонаже"
L["Show Pet Information"] = "Показать информацию о питомце"
L["Titles"] = "Звания"
L["Total Companions"] = "Всего питомцев"
L["Total Mounts"] = "Всего"

L["ALL"] = "Все"
L["ALT_KEY"] = "ALT"

L["%d mails\nShift-Click to remove empty mails."] = true
L["Addon |cffFFD100%s|r was merged into |cffFFD100ElvUI_Enhanced|r.\nPlease remove it to avoid conflicts."] = true
L["Cache Unit Guilds / NPC Titles"] = true
L["Check Achievements"] = true
L["Collected "] = true
L["Collection completed."] = true
L["Collection stopped, inventory is full."] = true
L["Color based on reaction type."] = true
L["Compact mode"] = true
L["Companion Background"] = true
L["Desaturate"] = true
L["Detached Portrait"] = true
L["Dressing Room"] = true
L["Enhanced"] = true
L["Equipment Info"] = true
L["Error Frame"] = true
L["Everywhere"] = true
L["Fog of War"] = true
L["Grow direction"] = true
L["Guild"] = true
L["Inside Minimap"] = true
L["Key Press Animation"] = true
L["Map"] = true
L["Minimap Button Grabber"] = true
L["NPC"] = "НИП"
L["Overlay Color"] = true
L["Reaction Color"] = true
L["Reported by %s"] = true
L["Rotation"] = true
L["Separator"] = true
L["Set the height of Error Frame. Higher frame can show more lines at once."] = true
L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"] = true
L["Show Everywhere"] = true
L["Show on Arena."] = true
L["Show on Battleground."] = true
L["Smooth Animations"] = true
L["Take All"] = true
L["Take All Mail"] = true
L["Take Cash"] = true
L["This addon has been disabled. You should install an updated version."] = true
L["Where to show"] = true
L["seconds"] = true
