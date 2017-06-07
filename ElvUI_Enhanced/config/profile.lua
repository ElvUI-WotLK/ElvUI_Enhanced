local E, L, V, P, G = unpack(ElvUI);

P.general.minimap.locationText = "ABOVE";

P.enhanced = {
	general = {
		pvpAutoRelease = false,
		autoRepChange = false,
		moverTransparancy = 0.8,
	},
	chat = {
		dpsLinks = false,
	},
	datatexts = {
		timeColorEnch = false,
	},
	equipment = {
		enable = false,
		durability = {
			enable = true,
			onlydamaged = true
		},
		itemlevel = {
			enable = true
		}
	},
	minimap = {
		location = false,
		locationdigits = 1,
		hideincombat = false,
		fadeindelay = 5,
	},
	nameplates = {
		cacheUnitClass = false,
		smooth = false,
		smoothSpeed = 0.3,
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
	unitframe = {
		portraitHDModelFix = {
			enable = false,
			debug = false,
			modelsToFix = "scourgemale.m2; scourgefemale.m2; humanfemale.m2; dwarfmale.m2; orcmalenpc.m2; scourgemalenpc.m2; scourgefemalenpc.m2; dwarfmalenpc.m2; humanmalekid.m2; chicken.m2; rat.m2"
		}
	},
	watchframe = {
		enable = false,
		city = "COLLAPSED",
		pvp = "HIDDEN",
		arena = "HIDDEN",
		party = "COLLAPSED",
		raid = "COLLAPSED",
	},
};