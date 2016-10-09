local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhTW")
if not L then return end

-- Translation by: xjjxfpyyyf, zhouf616, mcc

-- Init
L["ENH_LOGIN_MSG"] = "您正在使用 |cff1784d1ElvUI Enhanced Again|r |cffff8000(Legion)|r version %s%s|r."
L["Your version of ElvUI is to old (required v5.25 or higher). Please, download the latest version from tukui.org."] = "您的ElvUI版本過低(需要 v6.51 或更高), 請前往tukui.org下載最新版本."

-- Equipment
L["Equipment"] = "自動換裝"
L["EQUIPMENT_DESC"] = "當你切換專精或進入戰場時自動更換裝備, 你可以在選項中選擇相關的裝備模組."
L["No Change"] = "不改變"

L["Specialization"] = "專精"
L["Enable/Disable the specialization switch."] = "開啓/關閉 專精切換"

L["Primary Talent"] = "主專精"
L["Choose the equipment set to use for your primary specialization."] = "選擇當你使用主專精時的裝備模組."

L["Secondary Talent"] = "副專精"
L["Choose the equipment set to use for your secondary specialization."] = "選擇當你使用副專精時的裝備模組."

L["Battleground"] = "戰場"
L['Enable/Disable the battleground switch.'] = "開啓/關閉 戰場切換"

L["Equipment Set"] = "裝備模組"
L["Choose the equipment set to use when you enter a battleground or arena."] = "選擇當你進入戰場時的裝備模組."

L["You have equipped equipment set: "] = "你已裝備此模組: "

L["DURABILITY_DESC"] = "調整設置人物窗口裝備耐久度顯示."
L['Enable/Disable the display of durability information on the character screen.'] = "開啓/關閉 人物窗口裝備耐久度顯示."
L["Damaged Only"] = "受損顯示"
L["Only show durabitlity information for items that are damaged."] = "只在裝備受損時顯示耐久度."

L["ITEMLEVEL_DESC"] = "調整在角色資訊上顯示物品裝等的各種設定."
L["Enable/Disable the display of item levels on the character screen."] = "在角色資訊上顯示各裝備裝等"

L["Miscellaneous"] = "雜項"
L['Equipment Set Overlay'] = true
L['Show the associated equipment sets for the items in your bags (or bank).'] = "在你包包或銀行中顯示相關的套裝設定"

-- Movers
L["Mover Transparency"] = "定位器透明度"
L["Changes the transparency of all the movers."] = "改變所有定位器的透明度"

-- Automatic Role Assignment
L['Automatic Role Assignment'] = "自動設定角色定位"
L['Enables the automatic role assignment based on specialization for party / raid members (only work when you are group leader or group assist).'] = "當你是隊長或助理時根據隊員天賦自動指定其角色定位"

-- Auto Hide Role Icons in combat
L['Hide Role Icon in combat'] = true
L['All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat.'] = true

-- GPS module
L['GPS'] = "GPS定位"
L['Show the direction and distance to the selected party or raid member.'] = "顯示你與當前隊伍或團隊成員的方向与距離."

-- Attack Icon
L['Attack Icon'] = "戰鬥標記"
L['Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked.'] = "當目標不是被你或你的隊伍所開,但是可以取得任務道具,獎勵,道具時顯示一個戰鬥標記"

-- Class Icon
L['Show class icon for units.'] = "顯是職業圖標"

-- Minimap Location
L['Above Minimap'] = "小地圖之上"
L['Location Digits'] = "坐標位數"
L['Number of digits for map location.'] = "坐標顯示的小數位數"

-- Minimap Combat Hide
L["Hide minimap while in combat."] = "戰鬥中隱藏小地圖"
L["FadeIn Delay"] = "隱藏延遲"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "戰鬥開始後隱藏小地圖前的延遲時間 (0=停用)"

-- PvP Autorelease
L['PvP Autorelease'] = "PVP自動釋放靈魂"
L['Automatically release body when killed inside a battleground.'] = "在戰場死亡後自動釋放靈魂."

-- Track Reputation
L['Track Reputation'] = "聲望追蹤"
L['Automatically change your watched faction on the reputation bar to the faction you got reputation points for.'] = "當你獲得某個陣營的聲望時, 將自動追蹤此陣營的聲望至經驗值欄位." 

-- Select Quest Reward
L['Select Quest Reward'] = "自動選取任務獎勵"
L['Automatically select the quest reward with the highest vendor sell value.'] = "自動選取有最高賣價的任務獎勵物品"

-- Item Level Datatext
L['Item Level'] = "物品等級"

-- Range Datatext
L['Target Range'] = "目標距離"
L['Distance'] = "距離"

-- Extra Datatexts
L['Actionbar1DataPanel'] = '快捷列 1 資訊框'
L['Actionbar3DataPanel'] = '快捷列 3 資訊框'
L['Actionbar5DataPanel'] = '快捷列 5 資訊框'

-- Nameplates
L["Threat Text"] = "威脅值文字"
L["Display threat level as text on targeted, boss or mouseover nameplate."] = "在首領或鼠標懸停的血條上顯示威脅等級文字."
L["Target Count"] = "目標記數"
L["Display the number of party / raid members targetting the nameplate unit."] = "在血調旁邊顯示隊伍/團隊成員中以其為目標的個數"

-- HealGlow
L['Heal Glow'] = "高亮治療"
L['Direct AoE heals will let the unit frames of the affected party / raid members glow for the defined time period.'] = "受到直接性的範圍治療法術影響的隊伍/團隊成員會被高亮指定的時間"
L["Glow Duration"] = "高量持續時間"
L["The amount of time the unit frames of party / raid members will glow when affected by a direct AoE heal."] = "當隊伍/團隊成員受到直接性範圍治療法術石高亮持續的時間"
L["Glow Color"] = "高亮顏色"

-- WatchFrame
L['WatchFrame'] = "追蹤器"
L['WATCHFRAME_DESC'] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."
L['Hidden'] = "隱藏"
L['Collapsed'] = "收起"
L['Settings'] = "設定"
L['City (Resting)'] = "城市 (休息)"
L['PvP'] = true
L['Arena'] = "競技場"
L['Party'] = "隊伍"
L['Raid'] = "團隊"