local E = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("ElvUI", "deDE")

-- DESC locales
L["ENH_LOGIN_MSG"] = "Sie verwenden |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(WotLK)|r Version %s%s|r."
L["DURABILITY_DESC"] = "Passen Sie die Einstellungen für die Haltbarkeit im Charakterfenster an."
L["ITEMLEVEL_DESC"] = "Passen Sie die Einstellungen für die Anzeige von Gegenstandsstufen im Charakterfenster an."
L["WATCHFRAME_DESC"] = "Passen Sie die Einstellungen des Watchframe (Questlog) nach ihren Wünschen an."

-- Incompatibility
L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"] = true

-- AddOn List
L["Enable All"] = "Alle aktivieren"
L["Dependencies: "] = "Abhängigkeiten"
L["Disable All"] = "Alle deaktivieren"
L["Load AddOn"] = "Lade AddOn"
L["Requires Reload"] = "Benötigt Reload"

-- Chat
L["Filter DPS meters Spam"] = "Spam von DPS-Metern filtern"
L["Replaces reports from damage meters with a clickable hyperlink to reduce chat spam"] = true

-- Datatext
L["Ammo/Shard Counter"] = true
L["Combat Indicator"] = "Kampfanzeige"
L["Distance"] = "Entfernung"
L["In Combat"] = "Im Kampf"
L["New Mail"] = "Neue Post"
L["No Mail"] = "Keine Post"
L["Out of Combat"] = "Außerhalb des Kampfes"
L["Reincarnation"] = "Wiederbelebung"
L["Target Range"] = "Zielreichweite"

-- Death Recap
L["Death Recap Frame"] = true
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
L["You died."] = "Du bist gestorben."

-- Decline Duels
L["Auto decline all duels"] = "Auto-Ablehnen von allen Duellen"
L["Decline Duel"] = "Duell ablehnen"
L["Declined duel request from "] = "Duellaufforderung abgelehnt von "

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = true
L["Enhanced Character Frame"] = true
L["Enhanced Model Frames"] = true
L["Inspect Background"] = true
L["Paperdoll Backgrounds"] = true
L["Pet Background"] = true

-- Equipment
L["Damaged Only"] = "Nur Beschädigte"
L["Enable/Disable the display of durability information on the character screen."] = "Anzeige der Haltbarkeit im Charakterfenster."
L["Enable/Disable the display of item levels on the character screen."] = "Anzeige von Gegenstandsstufen im Charakterfenster aktivieren / deaktivieren."
L["Only show durabitlity information for items that are damaged."] = "Nur die Haltbarkeit für beschädigte Ausrüstungsteile anzeigen."
L["Quality Color"] = "Qualitätsfarbe"

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Animated Achievement Bars"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Ändere automatisch die beobachtete Fraktion auf der Erfahrungsleiste zu der Fraktion für die Sie grade Rufpunkte erhalten haben."
L["Automatically release body when killed inside a battleground."] = "Gibt automatisch Ihren Geist frei, wenn Sie auf dem Schlachtfeld getötet wurden."
L["Automatically select the quest reward with the highest vendor sell value."] = "Wählt automatisch die Questbelohnung mit dem höchsten Wiederverkaufswert beim Händler"
L["Change color of item icons which already known."] = true
L["Changes the transparency of all the movers."] = "Ändere die Transparenz aller Ankerpukte"
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

-- HD Models Portrait Fix
L["Debug"] = true
L["List of models with broken portrait camera. Separete each model name with ';' simbol"] = true
L["Models to fix"] = true
L["Portrait HD Fix"] = true
L["Print to chat model names of units with enabled 3D portraits."] = true

-- Interrupt Tracker
L["Interrupt Tracker"] = true

-- Nameplates
L["Cache Unit Class"] = true

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
L["Check achievement completion instead of boss kill stats.\nSome servers log incorrect boss kill statistics, this is an alternative way to get player progress."] = true
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
L["Loss Control"] = "Kontrollverlust"
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
L["Class Icons"] = "Klassensymbole"
L["Detached Height"] = "Höhe loslösen"
L["Show class icon for units."] = "Zeige Klassensymbole für Einheiten"

-- WatchFrame
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
L["Reset Position"] = "Position zurücksetzen"
L["Right-click on character and drag to move it within the window."] = true
L["Rotate Left"] = true
L["Rotate Right"] = true
L["Zoom In"] = true
L["Zoom Out"] = true

--
L["Character Stats"] = true
L["Damage Per Second"] = "DPS"
L["Equipment Manager"] = true
L["Hide Character Information"] = true
L["Hide Pet Information"] = true
L["Item Level"] = "Itemlevel"
L["New Set"] = true
L["Resistance"] = true
L["Show Character Information"] = true
L["Show Pet Information"] = true
L["Titles"] = true
L["Total Companions"] = true
L["Total Mounts"] = true

L["ALL"] = "Alle"
L["ALT_KEY"] = "ALT-Taste"

L["%d mails\nShift-Click to remove empty mails."] = true
L["Addon |cffFFD100%s|r was merged into |cffFFD100ElvUI_Enhanced|r.\nPlease remove it to avoid conflicts."] = true
L["Cache Unit Guilds / NPC Titles"] = true
L["Check Achievements"] = true
L["Collected "] = true
L["Collection completed."] = true
L["Collection stopped, inventory is full."] = true
L["Color based on reaction type."] = true
L["Compact mode"] = true
L["Companion Background"] = true
L["Desaturate"] = true
L["Detached Portrait"] = true
L["Dressing Room"] = true
L["Enhanced"] = true
L["Equipment Info"] = true
L["Error Frame"] = true
L["Everywhere"] = true
L["Fog of War"] = true
L["Grow direction"] = true
L["Guild"] = true
L["Inside Minimap"] = true
L["Key Press Animation"] = true
L["Map"] = true
L["Minimap Button Grabber"] = true
L["NPC"] = "NSC"
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
L["Smooth Animations"] = true
L["Take All"] = true
L["Take All Mail"] = true
L["Take Cash"] = true
L["This addon has been disabled. You should install an updated version."] = true
L["Where to show"] = true
L["seconds"] = true
