local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "deDE")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "Sie verwenden |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(WotLK)|r Version %s%s|r."
L["DURABILITY_DESC"] = "Passen Sie die Einstellungen für die Haltbarkeit im Charakterfenster an."
L["ITEMLEVEL_DESC"] = "Passen Sie die Einstellungen für die Anzeige von Gegenstandsstufen im Charakterfenster an."
L["WATCHFRAME_DESC"] = "Passen Sie die Einstellungen des Watchframe (Questlog) nach ihren Wünschen an."

-- Incompatibility
L["GearScore '3.1.20b - Release' not for WotLK. Download 3.1.7. Disable this version?"] = true

-- Actionbars
L["Equipped Item Border"] = "Rahmen der angelegten Items"
L["Sets actionbars' backgrounds to transparent template."] = "Setzt den Aktionsleisten Hintergrund transparent."
L["Sets actionbars buttons' backgrounds to transparent template."] = "Setzt die Aktionsleisten Tasten transparent."
L["Transparent ActionBars"] = "Transparente Aktionsleisten"
L["Transparent Backdrop"] = "Transparenter Hintergrund"
L["Transparent Buttons"] = "Transparente Tasten"

-- AddOn List
L["Enable All"] = "Alle aktivieren"
L["Dependencies: "] = "Abhängigkeiten"
L["Disable All"] = "Alle deaktivieren"
L["Load AddOn"] = "Lade AddOn"
L["Requires Reload"] = "Benötigt Reload"

-- Animated Loss
L["Animated Loss"] = true
L["Pause Delay"] = true
L["Start Delay"] = true
L["Postpone Delay"] = true

-- Chat
L["Filter DPS meters Spam"] = "Spam von DPS-Metern filtern"
L["Replaces long reports from damage meters with a clickable hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"] = true

-- Datatext
L["Ammo/Shard Counter"] = true
L["Combat Indicator"] = "Kampfanzeige"
L["Distance"] = "Entfernung"
L["Enhanced Time Color"] = "Erweiterte Zeit-Färbung"
L["Equipped"] = "Angelegt"
L["In Combat"] = "Im Kampf"
L["New Mail"] = "Neue Post"
L["No Mail"] = "Keine Post"
L["Out of Combat"] = "Außerhalb des Kampfes"
L["Reincarnation"] = "Wiederbelebung"
L["Target Range"] = "Zielreichweite"
L["Total"] = "Gesamt"

-- Death Recap
L["%s %s"] = true
L["%s by %s"] = "%s durch %s"
L["%s sec before death at %s%% health."] = "%s Sekunden vor Tod bei %s%% Gesundheit."
L["(%d Absorbed)"] = "(%d Absorbiert)"
L["(%d Blocked)"] = "(%d Geblockt)"
L["(%d Overkill)"] = "(%d Über dem Tod)"
L["(%d Resisted)"] = "(%d Widerstanden)"
L["Death Recap unavailable."] = "Todesursache nicht verfügbar."
L["Death Recap"] = "Todesursache"
L["Killing blow at %s%% health."] = "Todesstoß bei %s%% Gesundheit."
L["Recap"] = "Zusammenfassung"
L["You died."] = "Du bist gestorben."

-- Decline Duels
L["Auto decline all duels"] = "Auto-Ablehnen von allen Duellen"
L["Decline Duel"] = "Duell ablehnen"
L["Declined duel request from "] = "Duellaufforderung abgelehnt von "

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = true
L["Enhanced Character Frame"] = true
L["Inspect Background"] = true
L["Model Frames"] = true
L["Paperdoll Backgrounds"] = true
L["Pet Background"] = true

-- Equipment
L["Damaged Only"] = "Nur Beschädigte"
L["Enable/Disable the display of durability information on the character screen."] = "Anzeige der Haltbarkeit im Charakterfenster."
L["Enable/Disable the display of item levels on the character screen."] = "Anzeige von Gegenstandsstufen im Charakterfenster aktivieren / deaktivieren."
L["Equipment"] = "Ausrüstung"
L["Only show durabitlity information for items that are damaged."] = "Nur die Haltbarkeit für beschädigte Ausrüstungsteile anzeigen."
L["Quality Color"] = "Qualitätsfarbe"

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Animated Bars"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Ändere automatisch die beobachtete Fraktion auf der Erfahrungsleiste zu der Fraktion für die Sie grade Rufpunkte erhalten haben."
L["Automatically release body when killed inside a battleground."] = "Gibt automatisch Ihren Geist frei, wenn Sie auf dem Schlachtfeld getötet wurden."
L["Automatically select the quest reward with the highest vendor sell value."] = "Wählt automatisch die Questbelohnung mit dem höchsten Wiederverkaufswert beim Händler"
L["Change color of item icons which already known."] = true
L["Changes the transparency of all the movers."] = "Ändere die Transparenz aller Ankerpukte"
L["Colorizes recipes, mounts & pets that are already known"] = "Rezepte, Reittiere und Begleiter einfärben, die bereits bekannt sind"
L["Display quest levels at Quest Log."] = "Questlevel im Questlog anzeigen."
L["Hide Zone Text"] = "Zonentext verstecken"
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Mover Transparency"] = "Transparenz Ankerpunkte"
L["PvP Autorelease"] = "Automatische Freigabe im PvP"
L["Select Quest Reward"] = "Wähle Questbelohnung"
L["Show Quest Level"] = "Zeige Questlevel"
L["Track Reputation"] = "Ruf beobachten"
L["Train All Button"] = true
L["Undress Button"] = true
L["Undress"] = "Ausziehen"
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
L["Bars will transition smoothly."] = "Balken werden sanft übergehen"
L["Cache Unit Class"] = true
L["Smooth Bars"] = "Sanfte Balken"

-- Minimap
L["Above Minimap"] = "Oberhalb der Minimap"
L["Combat Hide"] = true
L["FadeIn Delay"] = "Einblendungsverzögerung"
L["Hide minimap while in combat."] = "Ausblenden der Minimap während des Kampfes."
L["Show Location Digits"] = "Koordinaten einblenden"
L["Toggle Location Digits."] = "Koordinaten ein- oder ausblenden."
L["Location Digits"] = "Koordinaten Nachkommastellen"
L["Location Panel"] = "Standort-Panel"
L["Number of digits for map location."] = "Anzahl der Nachkommastellen der Koordinaten."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Die Zeit vor dem wieder Einblenden der Minimap nach dem Kampf. (0 = deaktiviert)"
L["Toggle Location Panel."] = "Umschalten des Standort-Panels"

-- Timer Tracker
L["Timer Tracker"] = true
L["Hook DBM"] = true

-- Tooltip
L["Check Player"] = true
L["Colorize the tooltip border based on item quality."] = "Färbe den Tooltip-Rahmen basierend auf der Gegenstandsqualität"
L["Display the players raid progression in the tooltip, this may not immediately update when mousing over a unit."] = true
L["Icecrown Citadel"] = true
L["Item Border Color"] = "Gegenstandsrahmen-Farbe"
L["Progress Info"] = true
L["Ruby Sanctum"] = true
L["Show/Hides an Icon for Achievements on the Tooltip."] = "Icon für Erfolge am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Items on the Tooltip."] = "Icon für Gegenstände am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Spells on the Tooltip."] = "Icon für Zauber am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = "Icon für Zauber oder Gegenstände am Tooltip anzeigen oder ausblenden."
L["Tiers"] = true
L["Tooltip Icon"] = true
L["Trial of the Crusader"] = true
L["Ulduar"] = true

-- Movers
L["Loss Control Icon"] = "Kontrollverlust-Icon"
L["Player Portrait"] = "Spieler-Portrait"
L["Target Portrait"] = "Ziel-Portrait"

-- Loss Control
L["CC"] = "CC"
L["Disarm"] = "Entwaffnen"
L["Lose Control"] = true
L["PvE"] = "PvE"
L["Root"] = "Wurzeln"
L["Silence"] = "Stille"
L["Snare"] = "Verlangsamung"

-- Unitframes
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = "Alle Rollensymbole (Schaden/Heiler/Tank) auf den Einheitenfenstern werden versteckt, wenn der Charakter sich im Kampf befindet."
L["Class Icons"] = "Klassensymbole"
L["Detached Height"] = "Höhe loslösen"
L["Hide Role Icon in combat"] = "Verstecke Rollensymbol im Kampf"
L["Player"] = true
L["Show class icon for units."] = "Zeige Klassensymbole für Einheiten"
L["Target"] = "Ziel"

-- WatchFrame
L["Arena"] = "Arena"
L["City (Resting)"] = "Stadt (erholend)"
L["Collapsed"] = "Eingeklappt"
L["Hidden"] = "Versteckt"
L["Party"] = "Gruppe"
L["PvP"] = "PvP"
L["Raid"] = "Schlachtzug"

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