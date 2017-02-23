local E, L, V, P, G = unpack(ElvUI);

P.general.minimap.locationText = "ABOVE";

P.enhanced = {
	general = {
		pvpAutoRelease = true,
		autoRepChange = true,
		moverTransparancy = 0.8,
	},
	equipment = {
		enable = true,
		durability = {
			enable = true,
			onlydamaged = false
		},
		itemlevel = {
			enable = true
		}
	},
	minimap = {
		locationdigits = 1,
		hideincombat = false,
		fadeindelay = 5,
	},
	tooltip = {
		progressInfo = false,
	},
	watchframe = {
		enable = true,
		city = "COLLAPSED",
		pvp = "HIDDEN",
		arena = "HIDDEN",
		party = "COLLAPSED",
		raid = "COLLAPSED",
	},
};