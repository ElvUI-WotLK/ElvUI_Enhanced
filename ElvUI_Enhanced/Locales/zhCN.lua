local E = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("ElvUI", "zhCN")

-- DESC locales
L["ENH_LOGIN_MSG"] = "你正在使用 |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(WotLK)|r version %s%s|r。"
L["DURABILITY_DESC"] = "调整角色界面中装备耐久度信息的设置。"
L["ITEMLEVEL_DESC"] = "调整角色界面中物品等级信息的设置。"
L["WATCHFRAME_DESC"] = "根据个人喜好调整任务追踪框架的设置。"
L["Enhanced"] = "功能增强"

-- Incompatibility
L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"] = "GearScore '3.1.20b - Release'并非是为WotLK设计的，请下载版本3.1.7。要禁用此插件吗？"

-- AddOn List
L["Enable All"] = "全部启用"
L["Dependencies: "] = "依赖性："
L["Disable All"] = "全部禁用"
L["Load AddOn"] = "加载插件"
L["Requires Reload"] = "需要重载"

-- Chat
L["Filter DPS meters Spam"] = "过滤DPS统计的垃圾讯息"
L["Replaces reports from damage meters with a clickable hyperlink to reduce chat spam"] = "用可点击的超链接替换DPS统计的长篇报告，以减少聊天中的垃圾讯息。"

-- Datatext
L["Ammo/Shard Counter"] = "弹药/碎片 计数"
L["Combat Indicator"] = "战斗指示"
L["Distance"] = "距离"
L["In Combat"] = "战斗中"
L["New Mail"] = "新邮件"
L["No Mail"] = "无邮件"
L["Out of Combat"] = "脱离战斗"
L["Reincarnation"] = "灵魂状态"
L["Target Range"] = "目标距离"

-- Death Recap
L["Death Recap Frame"] = "死亡回顾框架"
L["%s %s"] = true
L["%s by %s"] = "%s 来自于 %s"
L["%s sec before death at %s%% health."] = "死亡前 %s 秒，血量 %s%% 。"
L["(%d Absorbed)"] = "(%d 吸收)"
L["(%d Blocked)"] = "(%d 格挡)"
L["(%d Overkill)"] = "(%d 过量伤害)"
L["(%d Resisted)"] = "(%d 抵抗)"
L["Death Recap unavailable."] = "死因回顾不可用"
L["Death Recap"] = "死因回顾"
L["Killing blow at %s%% health."] = "血量 %s%% 时被一击致命。"
L["You died."] = "你死了。"

-- Decline Duels
L["Auto decline all duels"] = "自动拒绝决斗请求"
L["Decline Duel"] = "拒绝决斗"
L["Declined duel request from "] = "已拒绝决斗请求，发起者"

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = "角色界面背景"
L["Companion Background"] = "小伙伴界面背景"
L["Dressing Room"] = "试衣间"
L["Enhanced Character Frame"] = "增强角色界面框架"
L["Enhanced Model Frames"] = "增强模型框架"
L["Error Frame"] = "错误信息框架"
L["Inspect Background"] = "观察界面背景"
L["Paperdoll Backgrounds"] = "纸娃娃系统背景"
L["Pet Background"] = "宠物界面背景"
L["Smooth Animations"] = "平滑动画"

-- Equipment
L["Damaged Only"] = "仅显示受损"
L["Enable/Disable the display of durability information on the character screen."] = "开启/关闭 角色界面装备耐久度显示。"
L["Enable/Disable the display of item levels on the character screen."] = "开启/关闭 角色界面物品等级显示。"
L["Only show durabitlity information for items that are damaged."] = "只在装备受损时显示耐久度信息。"
L["Quality Color"] = "品质颜色"

-- General
L["Add button to Dressing Room frame with ability to undress model."] = "在试衣间界面添加<裸体>按钮。"
L["Add button to Trainer frame with ability to train all available skills in one click."] = "在训练师界面添加<学习全部>按钮，以便一键学习所有可用技能。"
L["Alt-Click Merchant"] = "Alt-点击快速购买"
L["Already Known"] = "已经学会"
L["Animated Achievement Bars"] = "动成就画条"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "当你获得某个阵营的声望时，自动用声望条追踪此阵营的声望。"
L["Automatically release body when killed inside a battleground."] = "在战场中死亡后自动释放灵魂。"
L["Automatically select the quest reward with the highest vendor sell value."] = "自动选择任务奖励中售价最高的物品。"
L["Change color of item icons which already known."] = "改变已经学会的物品图标颜色。"
L["Changes the transparency of all the movers."] = "改变所有移动框架的透明度。"
L["Display quest levels at Quest Log."] = "在任务日志中显示任务等级。"
L["Hide Zone Text"] = "隐藏区域文字"
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = "按下Alt键可在商人处购买整组物品。"
L["Mover Transparency"] = "移动框架透明度"
L["PvP Autorelease"] = "PVP自动释放灵魂"
L["Select Quest Reward"] = "选择任务奖励"
L["Show Quest Level"] = "显示任务等级"
L["Track Reputation"] = "声望追踪"
L["Train All Button"] = "学习全部按钮"
L["Undress Button"] = "裸体按钮"
L["Undress"] = "裸体"

-- HD Models Portrait Fix
L["Debug"] = true
L["List of models with broken portrait camera. Separete each model name with ';' simbol"] = "头像镜头破损的模型列表。每个模型名称之间使用 ';' 符号分隔。"
L["Models to fix"] = "待修复的模型"
L["Portrait HD Fix"] = "高清头像修复"
L["Print to chat model names of units with enabled 3D portraits."] = "将可用3D头像的单位模型名称发布到聊天框中。"

-- Interrupt Tracker
L["Interrupt Tracker"] = "打断追踪"
L["Everywhere"] = "任何区域"
L["Where to show"] = "何处显示"

-- Nameplates
L["Cache Unit Class"] = "缓存单位职业"
L["Cache Unit Guilds / NPC Titles"] = "缓存单位公会/NPC头衔"
L["Guild"] = "公会"

-- Minimap
L["Above Minimap"] = "小地图之上"
L["Combat Hide"] = "战斗隐藏"
L["FadeIn Delay"] = "淡入延迟"
L["Hide minimap while in combat."] = "战斗中隐藏小地图。"
L["Show Location Digits"] = "显示坐标"
L["Toggle Location Digits."] = "开关坐标"
L["Location Digits"] = "坐标"
L["Location Panel"] = "位置面板"
L["Number of digits for map location."] = "地图位置的数字坐标。"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "脱离战斗后小地图淡入的等待时间。(0 = 禁用)"
L["Toggle Location Panel."] = "开关位置面板。"

-- Timer Tracker
L["Timer Tracker"] = "计时器"
L["Hook DBM"] = "连接DBM"

-- Tooltip
L["Check Player"] = "检查玩家"
L["Check achievement completion instead of boss kill stats.\nSome servers log incorrect boss kill statistics, this is an alternative way to get player progress."] = true
L["Colorize the tooltip border based on item quality."] = "以物品品质着色鼠标提示边框。"
L["Icecrown Citadel"] = "冰冠堡垒"
L["Item Border Color"] = "物品边框颜色"
L["Progress Info"] = "进度信息"
L["Ruby Sanctum"] = "红玉圣殿"
L["Show/Hides an Icon for Achievements on the Tooltip."] = "在鼠标提示中显示成就图标。"
L["Show/Hides an Icon for Items on the Tooltip."] = "在鼠标提示中显示物品图标。"
L["Show/Hides an Icon for Spells on the Tooltip."] = "在鼠标提示中显示技能图标。"
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = "在鼠标提示中显示技能和物品图标。"
L["Tiers"] = "阶段"
L["Tooltip Icon"] = "鼠标提示图标"
L["Trial of the Crusader"] = "十字军的试炼"
L["Ulduar"] = "奥杜尔"

-- Movers
L["Loss Control"] = "失控图标"
L["Player Portrait"] = "玩家头像"
L["Target Portrait"] = "目标头像"

-- Lose Control
L["CC"] = "控制类技能"
L["Disarm"] = "缴械类技能"
L["Lose Control"] = "失控"
L["PvE"] = "PvE"
L["Root"] = "定身类技能"
L["Silence"] = "沉默类技能"
L["Snare"] = "减速类技能"

-- Unitframes
L["Class Icons"] = "职业图标"
L["Detached Height"] = "分离后的高度"
L["Show class icon for units."] = "显示单位的职业图标。"

-- WatchFrame
L["Hidden"] = "隐藏"
L["Collapsed"] = "折叠"
L["City (Resting)"] = "城市 (休息)"
L["PvP"] = true
L["Party"] = "小队"
L["Raid"] = "团队"

--
L["Drag"] = "拖动"
L["Left-click on character and drag to rotate."] = "左键点击角色并拖动可以旋转模型。"
L["Mouse Wheel Down"] = "鼠标滚轮向下"
L["Mouse Wheel Up"] = "鼠标滚轮向上"
L["Reset Position"] = "重置位置"
L["Right-click on character and drag to move it within the window."] = "右键点击角色并拖动可以在窗口内移动模型。"
L["Rotate Left"] = "向左旋转"
L["Rotate Right"] = "向右旋转"
L["Zoom In"] = "放大"
L["Zoom Out"] = "缩小"

--
L["Character Stats"] = "角色属性"
L["Damage Per Second"] = "DPS"
L["Equipment Manager"] = "装备管理"
L["Hide Character Information"] = "隐藏角色信息"
L["Hide Pet Information"] = "隐藏宠物信息"
L["Item Level"] = "物品等级"
L["New Set"] = "新套装"
L["Resistance"] = "抗性"
L["Show Character Information"] = "显示角色信息"
L["Show Pet Information"] = "显示宠物信息"
L["Titles"] = "头衔"
L["Total Companions"] = "所有小伙伴"
L["Total Mounts"] = "所有坐骑"

L["ALL"] = "全部"
L["ALT_KEY"] = "ALT键"

L["%d mails\nShift-Click to remove empty mails."] = true
L["Addon |cffFFD100%s|r was merged into |cffFFD100ElvUI_Enhanced|r.\nPlease remove it to avoid conflicts."] = true
L["Check Achievements"] = true
L["Collected "] = true
L["Collection completed."] = true
L["Collection stopped, inventory is full."] = true
L["Color based on reaction type."] = true
L["Compact mode"] = true
L["Desaturate"] = true
L["Detached Portrait"] = true
L["Equipment Info"] = true
L["Fog of War"] = true
L["Grow direction"] = true
L["Inside Minimap"] = true
L["Key Press Animation"] = true
L["Map"] = true
L["Minimap Button Grabber"] = true
L["NPC"] = true
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
L["Take All"] = true
L["Take All Mail"] = true
L["Take Cash"] = true
L["This addon has been disabled. You should install an updated version."] = true
L["seconds"] = true
