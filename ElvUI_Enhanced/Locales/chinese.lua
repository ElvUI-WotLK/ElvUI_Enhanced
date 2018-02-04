local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhCN")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "您正在使用 |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(WotLK)|r version %s%s|r."
L["DURABILITY_DESC"] = "调整设置人物窗口装备耐久度显示."
L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."

-- Incompatibility
L["GearScore '3.1.20b - Release' not for WotLK. Download 3.1.7. Disable this version?"] = true

-- Actionbars
L["Equipped Item Border"] = true
L["Sets actionbars' backgrounds to transparent template."] = true
L["Sets actionbars buttons' backgrounds to transparent template."] = true
L["Transparent ActionBars"] = true
L["Transparent Backdrop"] = true
L["Transparent Buttons"] = true

-- AddOn List
L["Enable All"] = true
L["Dependencies: "] = true
L["Disable All"] = true
L["Load AddOn"] = true
L["Requires Reload"] = true

-- Animated Loss
L["Animated Loss"] = true
L["Pause Delay"] = true
L["Start Delay"] = true
L["Postpone Delay"] = true

-- Chat
L["Filter DPS meters Spam"] = true
L["Replaces long reports from damage meters with a clickable hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"] = true

-- Datatext
L["Ammo/Shard Counter"] = true
L["Combat Indicator"] = true
L["Distance"] = true
L["Enhanced Time Color"] = true
L["Equipped"] = true
L["In Combat"] = true
L["New Mail"] = true
L["No Mail"] = true
L["Out of Combat"] = true
L["Reincarnation"] = true
L["Target Range"] = true
L["Total"] = true

-- Death Recap
L["%s %s"] = true
L["%s by %s"] = true
L["%s sec before death at %s%% health."] = true
L["(%d Absorbed)"] = true
L["(%d Blocked)"] = true
L["(%d Overkill)"] = true
L["(%d Resisted)"] = true
L["Death Recap unavailable."] = true
L["Death Recap"] = "死亡回放"
L["Killing blow at %s%% health."] = true
L["Recap"] = true
L["You died."] = true

-- Decline Duels
L["Auto decline all duels"] = "自动拒绝决斗请求"
L["Decline Duel"] = true
L["Declined duel request from "] = "已拒绝决斗请求自"

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = true
L["Enhanced Character Frame"] = true
L["Inspect Background"] = true
L["Model Frames"] = true
L["Paperdoll Backgrounds"] = true
L["Pet Background"] = true

-- Equipment
L["Damaged Only"] = "受损显示"
L["Enable/Disable the battleground switch."] = "开启/关闭 战场切换"
L["Enable/Disable the display of durability information on the character screen."] = "开启/关闭 人物窗口装备耐久度显示."
L["Enable/Disable the display of item levels on the character screen."] = true
L["Equipment"] = "自动换装"
L["Only show durabitlity information for items that are damaged."] = "只在装备受损时显示耐久度."
L["Quality Color"] = true

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Animated Bars"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "当你获得某个阵营的声望时, 将自动追踪此阵营的声望至经验栏位."
L["Automatically release body when killed inside a battleground."] = "在战场死亡后自动释放灵魂."
L["Automatically select the quest reward with the highest vendor sell value."] = true
L["Change color of item icons which already known."] = true
L["Changes the transparency of all the movers."] = true
L["Colorizes recipes, mounts & pets that are already known"] = true
L["Display quest levels at Quest Log."] = true
L["Hide Zone Text"] = true
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Mover Transparency"] = true
L["PvP Autorelease"] = "PVP自动释放灵魂"
L["Select Quest Reward"] = true
L["Show Quest Level"] = true
L["Track Reputation"] = "声望追踪"
L["Train All Button"] = true
L["Undress Button"] = true
L["Undress"] = "无装备"
L["Use blizzard close buttons, but desaturated"] = true

-- HD Models Portrait Fix
L["Debug"] = true
L["List of models with broken portrait camera. Separete each model name with \"\" simbol"] = true
L["Models to fix"] = true
L["Portrait HD Fix"] = true
L["Print to chat model names of units with enabled 3D portraits."] = true

-- Interrupt Tracker
L["Interrupt Tracker"] = true

-- Nameplates
L["Bars will transition smoothly."] = true
L["Cache Unit Class"] = true
L["Smooth Bars"] = true

-- Minimap
L["Above Minimap"] = true
L["Combat Hide"] = true
L["FadeIn Delay"] = true
L["Hide minimap while in combat."] = true
L["Show Location Digits"] = true
L["Toggle Location Digits."] = true
L["Location Digits"] = true
L["Location Panel"] = true
L["Number of digits for map location."] = true
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = true
L["Toggle Location Panel."] = true

-- Timer Tracker
L["Timer Tracker"] = true
L["Hook DBM"] = true

-- Tooltip
L["Check Player"] = true
L["Colorize the tooltip border based on item quality."] = true
L["Display the players raid progression in the tooltip, this may not immediately update when mousing over a unit."] = true
L["Icecrown Citadel"] = true
L["Item Border Color"] = true
L["Progress Info"] = true
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
L["Loss Control Icon"] = "失去控制图标"
L["Player Portrait"] = true
L["Target Portrait"] = true

-- Lose Control
L["CC"] = "控制类技能"
L["Disarm"] = "缴械类技能"
L["Lose Control"] = true
L["PvE"] = "PvE"
L["Root"] = "定身类技能"
L["Silence"] = "沉默类技能"
L["Snare"] = "减速类技能"

-- Unitframes
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = true
L["Class Icons"] = true
L["Detached Height"] = true
L["Hide Role Icon in combat"] = true
L["Player"] = true
L["Show class icon for units."] = true
L["Target"] = true

-- WatchFrame
L["Hidden"] = true
L["Collapsed"] = true
L["City (Resting)"] = true
L["PvP"] = true
L["Arena"] = true
L["Party"] = true
L["Raid"] = true

--
L["Drag"] = true
L["Left-click on character and drag to rotate."] = true
L["Mouse Wheel Down"] = true
L["Mouse Wheel Up"] = true
L["Reset Position"] = true
L["Right-click on character and drag to move it within the window."] = true
L["Rotate Left"] = true
L["Rotate Right"] = true
L["Zoom In"] = true
L["Zoom Out"] = true

--
L["Change Name/Icon"] = true
L["Character Stats"] = true
L["Damage Per Second"] = "DPS"
L["Equipment Manager"] = true
L["Hide Character Information"] = true
L["Hide Pet Information"] = true
L["Item Level"] = true
L["New Set"] = true
L["Resistance"] = true
L["Show Character Information"] = true
L["Show Pet Information"] = true
L["Titles"] = true
L["Total Companions"] = true
L["Total Mounts"] = true