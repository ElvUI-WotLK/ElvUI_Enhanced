-- German localisation file for deDE
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "deDE")
if not L then return end

-- Translation by: Kaltzifar

-- Init
L["ENH_LOGIN_MSG"] = "Sie verwenden |cff1784d1ElvUI Enhanced|r |cffff8000(WotLK)|r Version %s%s|r."

-- Equipment
L["Equipment"] = "Ausrüstung"

L["DURABILITY_DESC"] = "Passen Sie die Einstellungen für die Haltbarkeit im Charakterfenster an."
L["Enable/Disable the display of durability information on the character screen."] = "Anzeige der Haltbarkeit im Charakterfenster."
L["Damaged Only"] = "Nur Beschädigte"
L["Only show durabitlity information for items that are damaged."] = "Nur die Haltbarkeit für beschädigte Ausrüstungsteile anzeigen."

L["ITEMLEVEL_DESC"] = "Passen Sie die Einstellungen für die Anzeige von Gegenstandsstufen im Charakterfenster an."
L["Enable/Disable the display of item levels on the character screen."] = "Anzeige von Gegenstandsstufen im Charakterfenster aktivieren / deaktivieren."

-- Movers
L["Mover Transparency"] = "Transparenz Ankerpunkte"
L["Changes the transparency of all the movers."] = "Konfiguriere die Einstellungen der Transparenz der Ankerpukte"

-- Auto Hide Role Icons in combat
L["Hide Role Icon in combat"] = "Verstecke Rollensymbol im Kampf"
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = "Alle Rollensymbole (Schaden/Heiler/Tank) auf den Einheitenfenstern werden versteckt, wenn der Charakter sich im Kampf befindet."

-- Minimap Location
L["Above Minimap"] = "Oberhalb der Minimap"
L["Location Digits"] = "Koordinaten Nachkommastellen"
L["Number of digits for map location."] = "Anzahl der Nachkommastellen der Koordinaten."

-- Minimap Combat Hide
L["Combat Hide"] = true;
L["Hide minimap while in combat."] = "Ausblenden der Minimap während des Kampfes."
L["FadeIn Delay"] = "Einblendungsverzögerung"
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Die Zeit vor dem wieder Einblenden der Minimap nach dem Kampf. (0 = deaktiviert)"

-- PvP Autorelease
L["PvP Autorelease"] = "Automatische Freigabe im PvP"
L["Automatically release body when killed inside a battleground."] = "Gibt automatisch Ihren Geist frei, wenn Sie auf dem Schlachtfeld getötet wurden."

-- Track Reputation
L["Track Reputation"] = "Ruf beobachten"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Ändere automatisch die beobachtete Fraktion auf der Erfahrungsleiste zu der Fraktion für die Sie grade Rufpunkte erhalten haben."

-- Item Level Datatext
L["Item Level"] = "Gegenstandsstufe"

-- Range Datatext
L["Target Range"] = "Zielabstand"
L["Distance"] = "Entfernung"

-- WatchFrame
L["WatchFrame"] = "Questlog"
L["WATCHFRAME_DESC"] = "Passen Sie die Einstellungen für die Sichtbarkeit des Questlogs ganz an ihre persönlichen Bedürfnisse an."
L["Hidden"] = "Versteckt"
L["Collapsed"] = "Eingeklappt"
L["Settings"] = "Einstellungen"
L["City (Resting)"] = "Stadt (erholend)"
L["PvP"] = "PvP"
L["Arena"] = "Arena"
L["Party"] = "Gruppe"
L["Raid"] = "Schlachtzug"