local E, L, V, P, G = unpack(ElvUI);

P.general.minimap.locationText = "ABOVE";
P.general.movertransparancy = .8;

--Unitframes
P["unitframe"]["healglow"] = true
P["unitframe"]["hideroleincombat"] = false
P["unitframe"]["glowtime"] = .8
P["unitframe"]["glowcolor"] = { r = 1, g = 1, b = 0}

P["unitframe"]["units"]["target"]["attackicon"] = {
	["enable"] = true,
	["xOffset"] = 24,
	["yOffset"] = 6,
}

P["unitframe"]["units"]["target"]["classicon"] = {
	["enable"] = true,
	["size"] = 28,
	["xOffset"] = -58,
	["yOffset"] = -22,
}

P.nameplate.showthreat = true;
P.nameplate.targetcount = true;

P.datatexts.Actionbar1DataPanel = false;
P.datatexts.Actionbar3DataPanel = false;
P.datatexts.Actionbar5DataPanel = false;

P.datatexts.panels.Actionbar1DataPanel = {
	["left"] = "",
	["middle"] = "",
	["right"] = ""
};

P.datatexts.panels.Actionbar3DataPanel = "";
P.datatexts.panels.Actionbar5DataPanel = "";

P.watchframe = {
	["city"] = "COLLAPSED",
	["pvp"] = "HIDDEN",
	["arena"] = "HIDDEN",
	["party"] = "COLLAPSED",
	["raid"] = "COLLAPSED",
};