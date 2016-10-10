local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "ptBR")
if not L then return end

-- Translation by: ubios

L["ENH_LOGIN_MSG"] = "Você está a usar |cff1784d1ElvUI Enhanced Again|r |cffff8000(Legion)|r versão %s%s|r."
L["Your version of ElvUI is to old (required v5.25 or higher). Please, download the latest version from tukui.org."] = "A sua versão do ElvUI é muita antiga (requerida v6.51 ou superior). Por favor, descarregue a versão mais recente em tukui.org."

-- Equipment
L["Equipment"] = "Equipamento"

L["DURABILITY_DESC"] = "Ajuste as opções para a informação de durabilidade no ecrã de informação do personagem."
L['Enable/Disable the display of durability information on the character screen.'] = "Activar/desactivar a informação de durabilidade no ecrã de informação do personagem."
L["Damaged Only"] = "Só Danificados"
L["Only show durabitlity information for items that are damaged."] = "Só mostrar informação de durabilidade para itens danificados."

L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
L["Enable/Disable the display of item levels on the character screen."] = true

-- Movers
L["Mover Transparency"] = true
L["Changes the transparency of all the movers."] = true

-- Auto Hide Role Icons in combat
L['Hide Role Icon in combat'] = true
L['All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat.'] = true

-- Attack Icon
L['Attack Icon'] = true
L['Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked.'] = true

-- Class Icon
L['Show class icon for units.'] = true

-- Minimap Location
L['Above Minimap'] = true
L['Location Digits'] = true
L['Number of digits for map location.'] = true

-- Minimap Combat Hide
L["Hide minimap while in combat."] = true
L["FadeIn Delay"] = true
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = true

-- PvP Autorelease
L['PvP Autorelease'] = "Auto-libertar em JxJ"
L['Automatically release body when killed inside a battleground.'] = "Automaticamente libertar o corpo quando morto num campo de batalha."

-- Track Reputation
L['Track Reputation'] = "Controlar Reputação"
L['Automatically change your watched faction on the reputation bar to the faction you got reputation points for.'] = "Mudar automaticamente a facção controlada para a facção na qual acabou de ganhar pontos de reputação." 

-- Item Level Datatext
L['Item Level'] = true

-- Range Datatext
L['Target Range'] = true
L['Distance'] = true

-- Extra Datatexts
L['Actionbar1DataPanel'] = 'Actionbar 1'
L['Actionbar3DataPanel'] = 'Actionbar 3'
L['Actionbar5DataPanel'] = 'Actionbar 5'

-- Nameplates
L["Threat Text"] = true
L["Display threat level as text on targeted, boss or mouseover nameplate."] = true
L["Target Count"] = true
L["Display the number of party / raid members targetting the nameplate unit."] = true

-- HealGlow
L['Heal Glow'] = true
L['Direct AoE heals will let the unit frames of the affected party / raid members glow for the defined time period.'] = true
L["Glow Duration"] = true
L["The amount of time the unit frames of party / raid members will glow when affected by a direct AoE heal."] = true
L["Glow Color"] = true

-- WatchFrame
L['WatchFrame'] = true
L['WATCHFRAME_DESC'] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."
L['Hidden'] = true
L['Collapsed'] = true
L['Settings'] = true
L['City (Resting)'] = true
L['PvP'] = true
L['Arena'] = true
L['Party'] = true
L['Raid'] = true