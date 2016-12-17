-- French localization file for frFR.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("ElvUI", "frFR");
if not L then return; end

-- Translation by: Alex586, Deadse10

-- Init
L["ENH_LOGIN_MSG"] = "Vous utilisez |cff1784d1ElvUI Enhanced Again|r |cffff8000(Legion)|r version %s%s|r."
L["Your version of ElvUI is to old (required v5.25 or higher). Please, download the latest version from tukui.org."] = "Votre version d'ElvUI est trop ancienne (requiert v6.51 ou plus). Merci de télécharger une version plus récente sur tukui.org."

-- Equipment
L["Equipment"] = "Équipement"

L["DURABILITY_DESC"] = "Ajustez les réglages pour afficher la durabilité sur l'écran d'infos de personnage."
L['Enable/Disable the display of durability information on the character screen.'] = "Activer / Désactiver l'affichage des informations de durabilité sur l'écran d'infos de personnage."
L["Damaged Only"] = "Dégâts seulement"
L["Only show durabitlity information for items that are damaged."] = "Afficher la durabilité seulement quand l'équipement est endommagé."

L["ITEMLEVEL_DESC"] = "Réglez les paramètres pour afficher le niveau d'objet sur l'écran d'infos de personnage."
L["Enable/Disable the display of item levels on the character screen."] = "Activer / Désactiver l'affichage des informations du niveau d'objet sur l'écran d'infos de personnage."

-- Movers
L["Mover Transparency"] = "Transparence des Ancres"
L["Changes the transparency of all the movers."] = "Change la transparence des Ancres"

-- Auto Hide Role Icons in combat
L['Hide Role Icon in combat'] = "Cachez les icônes de rôle en combat"
L['All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat.'] = "Cachez toutes les icônes de rôle (Dommages/Healer/Tank) sur les cadres d'unité quand vous serait en combat."

-- Attack Icon
L['Attack Icon'] = "Icône d'Attaque"
L['Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked.'] = "Affiche une icône d'attaque sur les unités que vous ou votre groupe n'avez pas encore tapé, mais dont vous pouvez revendiquer la paternité."

-- Class Icon
L['Show class icon for units.'] = true

-- Minimap Location
L['Above Minimap'] = "Sous la minicarte"
L['Location Digits'] = "Chiffres d'emplacement"
L['Number of digits for map location.'] = "Nombre de chiffres pour l'emplacement."

-- Minimap Combat Hide
L["Combat Hide"] = true;
L["Hide minimap while in combat."] = "Cacher la minicarte quand vous êtes en combat"
L["FadeIn Delay"] = "Délais d'estompage"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Le temps à attendre avant que la minicarte s'estompe avec que le combat ait commencé. (0 = désactié)"

-- PvP Autorelease
L['PvP Autorelease'] = "Libération automatique en PVP"
L['Automatically release body when killed inside a battleground.'] = "Libère automatiquement votre corps quand vous êtes tué en Champs de Bataille."

-- Track Reputation
L['Track Reputation'] = "Suivre la Réputation"
L['Automatically change your watched faction on the reputation bar to the faction you got reputation points for.'] = "Change automatiquement la réputation suivie sur la barre de réputation avec la faction que vous êtes en train de faire."

-- Item Level Datatext
L['Item Level'] = "Niveau d'objet"

-- Range Datatext
L['Target Range'] = true
L['Distance'] = "Distance"

-- Nameplates
L["Threat Text"] = "Texte de menace"
L["Display threat level as text on targeted, boss or mouseover nameplate."] = "Affiche le niveau de menace sur le cadre d'unité de la cible, du boss, ou en passant votre souris."
L["Target Count"] = true
L["Display the number of party / raid members targetting the nameplate unit."] = true

-- HealGlow
L['Heal Glow'] = "Prédiction des soins"
L['Direct AoE heals will let the unit frames of the affected party / raid members glow for the defined time period.'] = "Les soins directs d'AoE laisserons sur les cadres d'unités du groupe / raid un montant fixe défini pour la période du soin."
L["Glow Duration"] = "Durée de la prédiction"
L["The amount of time the unit frames of party / raid members will glow when affected by a direct AoE heal."] = "Le temps que les cadres d'unités du groupe / Raid seront affectés par la prédiction de soin."
L["Glow Color"] = "Couleur de la prédiction"

-- WatchFrame
L['WatchFrame'] = "Fenêtre d'objectifs"
L['WATCHFRAME_DESC'] = "Réglez les paramètres pour la visibilité de la fenêtre d'objectifs (journal de quête) avec vos préférences personnelles."
L['Hidden'] = "Caché"
L['Collapsed'] = "Replié"
L['Settings'] = "Paramètres"
L['City (Resting)'] = "Ville (repos)"
L['PvP'] = "PvP"
L['Arena'] = "Arêne"
L['Party'] = "Groupe"
L['Raid'] = "Raid"