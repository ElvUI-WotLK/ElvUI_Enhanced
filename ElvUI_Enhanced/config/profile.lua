local E, L, V, P, G = unpack(ElvUI);

P.general.minimap.locationText = "ABOVE";

P.enhanced = {
	general = {
		pvpAutoRelease = false,
		autoRepChange = false,
		moverTransparancy = 0.8,
	},
	equipment = {
		enable = true,
		durability = {
			enable = true,
			onlydamaged = true
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
		progressInfo = {
			enable = false,
			checkPlayer = false,
			modifier = "SHIFT",
			tiers = {
				["RS"] = false,
				["ICC"] = true,
				["TotC"] = false,
				["Ulduar"] = false
			}
		}
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