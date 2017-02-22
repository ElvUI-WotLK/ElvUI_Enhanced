local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhCN")
if not L then return end

-- Translation by: zhouf616

-- Init
L["ENH_LOGIN_MSG"] = "您正在使用 |cff1784d1ElvUI Enhanced Again|r |cffff8000(WotLK)|r version %s%s|r."

-- Equipment
L["Equipment"] = "自动换装"

L["DURABILITY_DESC"] = "调整设置人物窗口装备耐久度显示."
L["Enable/Disable the display of durability information on the character screen."] = "开启/关闭 人物窗口装备耐久度显示."
L["Damaged Only"] = "受损显示"
L["Only show durabitlity information for items that are damaged."] = "只在装备受损时显示耐久度."

L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
L["Enable/Disable the display of item levels on the character screen."] = true

-- Movers
L["Mover Transparency"] = true
L["Changes the transparency of all the movers."] = true

-- Auto Hide Role Icons in combat
L["Hide Role Icon in combat"] = true
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = true

-- Attack Icon
L["Attack Icon"] = true
L["Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked."] = true

-- Class Icon
L["Show class icon for units."] = true

-- Minimap Location
L["Above Minimap"] = true
L["Location Digits"] = true
L["Number of digits for map location."] = true

-- Minimap Combat Hide
L["Combat Hide"] = true;
L["Hide minimap while in combat."] = true
L["FadeIn Delay"] = true
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = true

-- PvP Autorelease
L["PvP Autorelease"] = "PVP自动释放灵魂"
L["Automatically release body when killed inside a battleground."] = "在战场死亡后自动释放灵魂."

-- Track Reputation
L["Track Reputation"] = "声望追踪"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "当你获得某个阵营的声望时, 将自动追踪此阵营的声望至经验栏位."

-- Item Level Datatext
L["Item Level"] = true

-- Range Datatext
L["Target Range"] = true
L["Distance"] = "距离"

-- Nameplates
L["Threat Text"] = "威胁值文字"
L["Display threat level as text on targeted, boss or mouseover nameplate."] = "在首领或鼠标悬停的血条上显示威胁值文字."
L["Target Count"] = true
L["Display the number of party / raid members targetting the nameplate unit."] = true

-- WatchFrame
L["WatchFrame"] = true
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."
L["Hidden"] = true
L["Collapsed"] = true
L["Settings"] = true
L["City (Resting)"] = true
L["PvP"] = true
L["Arena"] = true
L["Party"] = true
L["Raid"] = true