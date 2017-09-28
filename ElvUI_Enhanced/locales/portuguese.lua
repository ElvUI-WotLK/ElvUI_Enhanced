local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "ptBR")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "Você está a usar |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(Cataclysm)|r versão %s%s|r."
L["EQUIPMENT_DESC"] = "Ajuste os parâmetros para a mudança de equipamento quando muda de especialização ou entra num campo de batalha."
L["DURABILITY_DESC"] = "Ajuste as opções para a informação de durabilidade no ecrã de informação do personagem."
L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."

-- Actionbars
L["Equipped Item Border"] = true;
L["Sets actionbars' backgrounds to transparent template."] = true;
L["Sets actionbars buttons' backgrounds to transparent template."] = true;
L["Transparent ActionBars"] = true;
L["Transparent Backdrop"] = true;
L["Transparent Buttons"] = true;

-- AddOn List
L["Enable All"] = true;
L["Dependencies: "] = true;
L["Disable All"] = true;
L["Load AddOn"] = true;
L["Requires Reload"] = true;

-- Animated Loss
L["Animated Loss"] = true;
L["Pause Delay"] = true;
L["Start Delay"] = true;
L["Postpone Delay"] = true;

-- Chat
L["Filter DPS meters Spam"] = true;
L["Replaces long reports from damage meters with a clickable hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"] = true;

-- Datatext
L["Combat Indicator"] = true;
L["Datatext Disabled"] = true;
L["Distance"] = true;
L["Enhanced Time Color"] = true;
L["Equipped"] = true;
L["In Combat"] = true;
L["New Mail"] = true;
L["No Mail"] = true;
L["Out of Combat"] = true;
L["Reincarnation"] = true;
L["Target Range"] = true;
L["Total"] = true;
L["You are not playing a |cff0070DEShaman|r, datatext disabled."] = true;

-- Death Recap
L["%s %s"] = true;
L["%s by %s"] = true;
L["%s sec before death at %s%% health."] = true;
L["(%d Absorbed)"] = true;
L["(%d Blocked)"] = true;
L["(%d Overkill)"] = true;
L["(%d Resisted)"] = true;
L["Death Recap unavailable."] = true;
L["Death Recap"] = true;
L["Killing blow at %s%% health."] = true;
L["Recap"] = true;
L["You died."] = true;

-- Decline Duels
L["Auto decline all duels"] = true;
L["Decline Duel"] = true;
L["Declined duel request from "] = true;

-- Equipment
L["Choose the equipment set to use for your primary specialization."] = "Escolha o conjunto de equipamento para usar com a especialização primária."
L["Choose the equipment set to use for your secondary specialization."] = "Escolha o conjunto de equipamento para usar com a especialização secundária."
L["Choose the equipment set to use when you enter a battleground or arena."] = "Escolha o conjunto de equipamento para usar quando entra num Campo de batalha."
L["Damaged Only"] = "Só Danificados"
L["Enable/Disable the battleground switch."] = "Activar/desactivar a mudança em Campo de batalha."
L["Enable/Disable the display of durability information on the character screen."] = "Activar/desactivar a informação de durabilidade no ecrã de informação do personagem."
L["Enable/Disable the display of item levels on the character screen."] = true;
L["Enable/Disable the specialization switch."] = "Activar/desactivar a mudança com a especialização."
L["Equipment Set Overlay"] = true;
L["Equipment Set"] = "Conjunto de Equipamento"
L["Equipment"] = "Equipamento"
L["No Change"] = "Sem mudança"
L["Only show durabitlity information for items that are damaged."] = "Só mostrar informação de durabilidade para itens danificados."
L["Quality Color"] = true;
L["Show the associated equipment sets for the items in your bags (or bank)."] = true;
L["Specialization"] = "Especialização"
L["You have equipped equipment set: "] = "Você tem equipado o conjunto: "

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true;
L["Add button to Trainer frame with ability to train all available skills in one click."] = true;
L["Alt-Click Merchant"] = true;
L["Already Known"] = true;
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Mudar automaticamente a facção controlada para a facção na qual acabou de ganhar pontos de reputação." 
L["Automatically release body when killed inside a battleground."] = "Automaticamente libertar o corpo quando morto num campo de batalha."
L["Automatically select the quest reward with the highest vendor sell value."] = true;
L["Changes the transparency of all the movers."] = true;
L["Colorizes recipes, mounts & pets that are already known"] = true;
L["Display quest levels at Quest Log."] = true;
L["Hide Zone Text"] = true;
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true;
L["Mover Transparency"] = true;
L["Original Close Button"] = true;
L["PvP Autorelease"] = "Auto-libertar em JxJ"
L["Select Quest Reward"] = true;
L["Show Quest Level"] = true;
L["Skin Animations"] = true;
L["Track Reputation"] = "Controlar Reputação"
L["Undress"] = true;
L["Use blizzard close buttons, but desaturated"] = true;

-- Nameplates
L["Bars will transition smoothly."] = true;
L["Cache Unit Class"] = true;
L["Smooth Bars"] = true;

-- Minimap
L["Above Minimap"] = true;
L["Combat Hide"] = true;
L["FadeIn Delay"] = true;
L["Hide minimap while in combat."] = true;
L["Location Digits"] = true;
L["Location Panel"] = true;
L["Number of digits for map location."] = true;
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = true;
L["Toggle Location Panel."] = true;

-- Tooltip
L["Baradin Hold"] = true;
L["Bastion of Twilight"] = true;
L["Blackwing Descend"] = true;
L["Check Player"] = true;
L["Colorize the tooltip border based on item quality."] = true
L["Display the players raid progression in the tooltip, this may not immediately update when mousing over a unit."] = true;
L["Dragon Soul"] = true;
L["Firelands"] = true;
L["Item Border Color"] = true
L["Progress Info"] = true;
L["Show/Hides an Icon for Achievements on the Tooltip."] = true;
L["Show/Hides an Icon for Items on the Tooltip."] = true;
L["Show/Hides an Icon for Spells on the Tooltip."] = true;
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = true;
L["Throne of the Four Winds"] = true;
L["Tiers"] = true;
L["Tooltip Icon"] = true;

-- Movers
L["Loss Control Icon"] = "Ícone de Perda de Controle"
L["Player Portrait"] = true;
L["Target Portrait"] = true;

-- Loss Control
L["CC"] = true;
L["Disarm"] = true;
L["Lose Control"] = true;
L["PvE"] = true;
L["Root"] = true;
L["Silence"] = true;
L["Snare"] = true;

-- Unitframes
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = true;
L["Class Icons"] = true;
L["Detached Height"] = true;
L["Hide Role Icon in combat"] = true;
L["Show class icon for units."] = true;
L["Target"] = true;

-- WatchFrame
L["Hidden"] = true;
L["Collapsed"] = true;
L["City (Resting)"] = true;
L["PvP"] = true;
L["Arena"] = true;
L["Party"] = true;
L["Raid"] = true;