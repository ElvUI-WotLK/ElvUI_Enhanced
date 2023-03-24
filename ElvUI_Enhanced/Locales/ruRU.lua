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
L["Enable All"] = "Включить все"
L["Dependencies: "] = "Зависимости: "
L["Disable All"] = "Выключить все"
L["Load AddOn"] = "Загрузить дополнение"
L["Requires Reload"] = "Требуется перезагрузка"

-- Chat
L["Filter DPS meters Spam"] = "Фильтровать спам счетчиков DPS"
L["Replaces reports from damage meters with a clickable hyperlink to reduce chat spam"] = "Заменяет сообщения от счетчиков ущерба кликабельной гиперссылкой, чтобы уменьшить спам в чате"

-- Datatext
L["Ammo/Shard Counter"] = "Счетчик патронов и фрагментов"
L["Combat Indicator"] = "Боевые показатели"
L["Distance"] = "Дистанция"
L["In Combat"] = "В бою"
L["New Mail"] = "Новое письмо"
L["No Mail"] = "Нет писем"
L["Out of Combat"] = "Вне боя"
L["Reincarnation"] = "Реинкарнация"
L["Target Range"] = "Дальность поражения цели"

-- Death Recap
L["Death Recap Frame"] = "Смертельный фрэйм"
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
L["Decline Duel"] = "Дуэль на понижение"
L["Declined duel request from "] = "DДуэль отклонена от "

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = "Фон персонажа"
L["Enhanced Character Frame"] = "Улучшенная рамка персонажа"
L["Enhanced Model Frames"] = "Расширенные рамки модели"
L["Inspect Background"] = "Осмотр фона"
L["Paperdoll Backgrounds"] = "Фоны бумажной куклы"
L["Pet Background"] = "Фон для питомцев"

-- Equipment
L["Damaged Only"] = "Только поврежденные"
L["Enable/Disable the display of durability information on the character screen."] = "Включить/Выключить отображение информации о прочности предметов в окне персонажа."
L["Enable/Disable the display of item levels on the character screen."] = "Включить/Выключить отображение уровня предмета в окне персонажа."
L["Only show durabitlity information for items that are damaged."] = "Показывать уровень прочности только на поврежденных предметах."
L["Quality Color"] = "Цвет качества"

-- General
L["Add button to Dressing Room frame with ability to undress model."] = "Добавьте кнопку во фрейм раздевалки с возможностью раздевать модель."
L["Add button to Trainer frame with ability to train all available skills in one click."] = "Добавить кнопку в фрейм тренера с возможностью тренировки всех доступных навыков одним щелчком мыши."
L["Alt-Click Merchant"] = "Торговец Alt-Click"
L["Already Known"] = "Уже известно"
L["Animated Achievement Bars"] = "Анимированные бары достижений"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Автоматическое изменение фракции на панели репутации на ту, очки репутации которой вы получили."
L["Automatically release body when killed inside a battleground."] = "Автоматически покидать тело после смерти на полях боя."
L["Automatically select the quest reward with the highest vendor sell value."] = "Автоматически выбирать награду за квест с самой высокой стоимостью продажи у продавца."
L["Change color of item icons which already known."] = "Изменить цвет иконок предметов, которые уже известны."
L["Changes the transparency of all the movers."] = "Изменяет прозрачность фиксаторов"
L["Display quest levels at Quest Log."] = "Отображать уровни квестов в журнале квестов."
L["Hide Zone Text"] = "Скрыть текст зоны"
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = "Удерживая клавишу Alt при покупке чего-либо у продавца, теперь можно купить целую стопку."
L["Mover Transparency"] = "Прозрачность фиксаторов"
L["PvP Autorelease"] = "Автовыход из тела"
L["Select Quest Reward"] = "Выбрать награду за квест"
L["Show Quest Level"] = "Показать уровень квеста"
L["Track Reputation"] = "Отслеживание репутации"
L["Train All Button"] = "Тренировать все кнопка"
L["Undress Button"] = "Кнопка раздеться"
L["Undress"] = "Раздеть"

-- HD Models Portrait Fix
L["Debug"] = "Отладка"
L["List of models with broken portrait camera. Separete each model name with ';' simbol"] = "Список моделей со сломанной портретной камерой. Разделите название каждой модели символом ';'"
L["Models to fix"] = "Модели для исправления"
L["Portrait HD Fix"] = "Исправление портрета HD"
L["Print to chat model names of units with enabled 3D portraits."] = "Вывести в чат названия моделей юнитов с включенными 3D-портретами."

-- Interrupt Tracker
L["Interrupt Tracker"] = "Отслеживание прерываний"

-- Nameplates
L["Cache Unit Class"] = "Класс единицы кэша"

-- Minimap
L["Above Minimap"] = "Над миникартой"
L["Combat Hide"] = "Скрыть в бою"
L["FadeIn Delay"] = "Задержка появления"
L["Hide minimap while in combat."] = "Скрывать миникарту во время боя."
L["Show Location Digits"] = "Показать координаты"
L["Toggle Location Digits."] = "Переключите координаты."
L["Location Digits"] = "Цифры координат"
L["Location Panel"] = "Панель местоположения"
L["Number of digits for map location."] = "Колличество цифр после запятой в координатах."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Время ожидания появления миникарты после выхода из боя. (0 = Выключено)"
L["Toggle Location Panel."] = "Переключите панель местоположения."

-- Timer Tracker
L["Timer Tracker"] = "Таймер слежения"
L["Hook DBM"] = "подключение ДБМ"

-- Tooltip
L["Check Player"] = "Проверить игрока"
L["Check achievement completion instead of boss kill stats.\nSome servers log incorrect boss kill statistics, this is an alternative way to get player progress."] = "Проверяйте выполнение достижений вместо статистики убийств боссов.\nНекоторые серверы регистрируют неверную статистику убийств боссов, это альтернативный способ узнать прогресс игрока."
L["Colorize the tooltip border based on item quality."] = "Окрашивать бордюр тултипа в цвет качества предмета"
L["Icecrown Citadel"] = "Цитадель Ледяной Короны"
L["Item Border Color"] = "Цвет рамки предметов"
L["Progress Info"] = "Прогресс"
L["Ruby Sanctum"] = "Рубиновое святилище"
L["Show/Hides an Icon for Achievements on the Tooltip."] = "Показать/скрыть значок достижений во всплывающей подсказке."
L["Show/Hides an Icon for Items on the Tooltip."] = "Показать/скрыть значок для предметов на всплывающей подсказке"
L["Show/Hides an Icon for Spells on the Tooltip."] = "Показать/скрыть иконку заклинания на всплывающей подсказке"
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = "Показать/скрыть иконку заклинаний и предметов во всплывающей подсказке"
L["Tiers"] = "Уровни"
L["Tooltip Icon"] = "Иконка подсказки"
L["Trial of the Crusader"] = "Испытание крестоносца"
L["Ulduar"] = "Ульдуар"

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
L["Class Icons"] = "Значки классов"
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

L["%d mails\nShift-Click to remove empty mails."] = "%d писем\nShift-Click для удаления пустых писем"
L["Addon |cffFFD100%s|r was merged into |cffFFD100ElvUI_Enhanced|r.\nPlease remove it to avoid conflicts."] = "Аддон |cffFFD100%s|r был объединен с |cffFFD100ElvUI_Enhanced|r.\nПожалуйста, удалите его, чтобы избежать конфликтов."
L["Cache Unit Guilds / NPC Titles"] = "Кеш едениц гильдии / Звания NPC"
L["Check Achievements"] = "Проверка достижений"
L["Collected "] = "Собрано "
L["Collection completed."] = "Сбор завершен."
L["Collection stopped, inventory is full."] = "Сбор остановлен, инвентарь заполнен"
L["Color based on reaction type."] = "Цвет зависит от типа реакции"
L["Compact mode"] = "Компактный режим"
L["Companion Background"] = "Фон компаньона"
L["Desaturate"] = "Опустошение"
L["Detached Portrait"] = "Отдельный портрет"
L["Dressing Room"] = "Гардеробная"
L["Enhanced"] = "Расширенный"
L["Equipment Info"] = "Информация о экипировке"
L["Error Frame"] = "Фрейм ошибок"
L["Everywhere"] = "Везде"
L["Fog of War"] = "Туман войны"
L["Grow direction"] = "Направление развития"
L["Guild"] = "Гильдия"
L["Inside Minimap"] = "Внутри мини-картины"
L["Key Press Animation"] = "Анимация нажатия клавиш"
L["Map"] = "Карта"
L["Minimap Button Grabber"] = "Сборщик кнопок миникарты"
L["NPC"] = "НИП"
L["Overlay Color"] = "Цвет наложения"
L["Reaction Color"] = "Цвет реакции"
L["Reported by %s"] = "Сообщено %s"
L["Rotation"] = "Вращение"
L["Separator"] = "Разделитель"
L["Set the height of Error Frame. Higher frame can show more lines at once."] = "Установите высоту фрейма ошибки. Более высокая рамка может показывать больше линий одновременно."
L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"] = "Установите ширину рамки ошибок. Слишком узкая рамка может привести к тому, что сообщения будут разбиты на несколько строк"
L["Show Everywhere"] = "Показывать везде"
L["Show on Arena."] = "Показать на Арене"
L["Show on Battleground."] = "Показать на поле боя"
L["Smooth Animations"] = "Плавная анимация"
L["Take All"] = "Принять все"
L["Take All Mail"] = "Забрать всю почту"
L["Take Cash"] = "Возьмите деньги"
L["This addon has been disabled. You should install an updated version."] = "Этот аддон был отключен. Вам следует установить обновленную версию."
L["Where to show"] = "Где показать"
L["seconds"] = "секунды"
