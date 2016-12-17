local E, L, V, P, G = unpack(ElvUI);

P.general.minimap.locationText = "ABOVE";
P.general.movertransparancy = .8;

--Unitframes
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

P.watchframe = {
	["city"] = "COLLAPSED",
	["pvp"] = "HIDDEN",
	["arena"] = "HIDDEN",
	["party"] = "COLLAPSED",
	["raid"] = "COLLAPSED",
};