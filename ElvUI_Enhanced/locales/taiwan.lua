-- Taiwanese localization file for zhTW.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhTW")
if not L then return end

-- Translation by: xjjxfpyyyf, zhouf616, mcc

-- Init
L["ENH_LOGIN_MSG"] = "您正在使用 |cff1784d1ElvUI Enhanced|r |cffff8000(WotLK)|r version %s%s|r."

-- Chat
L["Replaces long reports from damage meters with a clickeble hyperlink to reduce chat spam."] = true

-- Equipment
L["Equipment"] = "自動換裝"

L["DURABILITY_DESC"] = "調整設置人物窗口裝備耐久度顯示."
L["Enable/Disable the display of durability information on the character screen."] = "開啓/關閉 人物窗口裝備耐久度顯示."
L["Damaged Only"] = "受損顯示"
L["Only show durabitlity information for items that are damaged."] = "只在裝備受損時顯示耐久度."

L["ITEMLEVEL_DESC"] = "調整在角色資訊上顯示物品裝等的各種設定."
L["Enable/Disable the display of item levels on the character screen."] = "在角色資訊上顯示各裝備裝等"

-- Movers
L["Mover Transparency"] = "定位器透明度"
L["Changes the transparency of all the movers."] = "改變所有定位器的透明度"

-- Minimap Location
L["Location Panel"] = true
L["Toggle Location Panel."] = true
L["Above Minimap"] = "小地圖之上"
L["Location Digits"] = "坐標位數"
L["Number of digits for map location."] = "坐標顯示的小數位數"

-- Minimap Combat Hide
L["Combat Hide"] = true;
L["Hide minimap while in combat."] = "戰鬥中隱藏小地圖"
L["FadeIn Delay"] = "隱藏延遲"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "戰鬥開始後隱藏小地圖前的延遲時間 (0=停用)"

-- PvP Autorelease
L["PvP Autorelease"] = "PVP自動釋放靈魂"
L["Automatically release body when killed inside a battleground."] = "在戰場死亡後自動釋放靈魂."

-- Track Reputation
L["Track Reputation"] = "聲望追蹤"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "當你獲得某個陣營的聲望時, 將自動追蹤此陣營的聲望至經驗值欄位."

-- Item Level Datatext
L["Item Level"] = "物品等級"

-- Range Datatext
L["Target Range"] = "目標距離"
L["Distance"] = "距離"

-- Time Datatext
L["Enhanced Time Color"] = true

-- Tooltip
L["Progress Info"] = true
L["Check Player"] = true;
L["Tiers"] = true;
L["Ruby Sanctum"] = true;
L["Icecrown Citadel"] = true;
L["Trial of the Crusader"] = true;
L["Ulduar"] = true;
L["RS"] = true;
L["ICC"] = true;
L["TotC"] = true;

-- WatchFrame
L["WatchFrame"] = "追蹤器"
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."
L["Hidden"] = "隱藏"
L["Collapsed"] = "收起"
L["Settings"] = "設定"
L["City (Resting)"] = "城市 (休息)"
L["PvP"] = true
L["Arena"] = "競技場"
L["Party"] = "隊伍"
L["Raid"] = "團隊"