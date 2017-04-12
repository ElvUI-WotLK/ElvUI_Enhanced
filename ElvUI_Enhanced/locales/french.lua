-- French localization file for frFR.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("ElvUI", "frFR");
if not L then return; end

-- Translation by: Alex586, Deadse10

-- Init
L["ENH_LOGIN_MSG"] = "Vous utilisez |cff1784d1ElvUI Enhanced|r |cffff8000(WotLK)|r version %s%s|r."

-- Chat
L["Replaces long reports from damage meters with a clickeble hyperlink to reduce chat spam."] = true

-- Equipment
L["Equipment"] = "Équipement"

L["DURABILITY_DESC"] = "Ajustez les réglages pour afficher la durabilité sur l'écran d'infos de personnage."
L["Enable/Disable the display of durability information on the character screen."] = "Activer / Désactiver l'affichage des informations de durabilité sur l'écran d'infos de personnage."
L["Damaged Only"] = "Dégâts seulement"
L["Only show durabitlity information for items that are damaged."] = "Afficher la durabilité seulement quand l'équipement est endommagé."

L["ITEMLEVEL_DESC"] = "Réglez les paramètres pour afficher le niveau d'objet sur l'écran d'infos de personnage."
L["Enable/Disable the display of item levels on the character screen."] = "Activer / Désactiver l'affichage des informations du niveau d'objet sur l'écran d'infos de personnage."

-- Movers
L["Mover Transparency"] = "Transparence des Ancres"
L["Changes the transparency of all the movers."] = "Change la transparence des Ancres"

-- Minimap Location
L["Location Panel"] = true
L["Toggle Location Panel."] = true
L["Above Minimap"] = "Sous la minicarte"
L["Location Digits"] = "Chiffres d'emplacement"
L["Number of digits for map location."] = "Nombre de chiffres pour l'emplacement."

-- Minimap Combat Hide
L["Combat Hide"] = true;
L["Hide minimap while in combat."] = "Cacher la minicarte quand vous êtes en combat"
L["FadeIn Delay"] = "Délais d'estompage"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Le temps à attendre avant que la minicarte s'estompe avec que le combat ait commencé. (0 = désactié)"

-- PvP Autorelease
L["PvP Autorelease"] = "Libération automatique en PVP"
L["Automatically release body when killed inside a battleground."] = "Libère automatiquement votre corps quand vous êtes tué en Champs de Bataille."

-- Track Reputation
L["Track Reputation"] = "Suivre la Réputation"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Change automatiquement la réputation suivie sur la barre de réputation avec la faction que vous êtes en train de faire."

-- Item Level Datatext
L["Item Level"] = "Niveau d'objet"

-- Range Datatext
L["Target Range"] = true
L["Distance"] = "Distance"

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
L["WatchFrame"] = "Fenêtre d'objectifs"
L["WATCHFRAME_DESC"] = "Réglez les paramètres pour la visibilité de la fenêtre d'objectifs (journal de quête) avec vos préférences personnelles."
L["Hidden"] = "Caché"
L["Collapsed"] = "Replié"
L["Settings"] = "Paramètres"
L["City (Resting)"] = "Ville (repos)"
L["PvP"] = "PvP"
L["Arena"] = "Arêne"
L["Party"] = "Groupe"
L["Raid"] = "Raid"