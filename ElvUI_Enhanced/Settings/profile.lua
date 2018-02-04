local E, L, V, P, G = unpack(ElvUI)

-- Minimap
P.general.minimap.locationText = "ABOVE"

-- Unitframes
P.unitframe.units.player.portrait.detachFromFrame = false
P.unitframe.units.player.portrait.detachedWidth = 54
P.unitframe.units.player.portrait.detachedHeight = 54

P.unitframe.units.target.portrait.detachFromFrame = false
P.unitframe.units.target.portrait.detachedWidth = 54
P.unitframe.units.target.portrait.detachedHeight = 54

P.unitframe.units.player.animatedLoss = {
	enable = false,
	duration = .75,
	startDelay = .2,
	pauseDelay = .05,
	postponeDelay = .05
}

-- Enhanced
P.enhanced = {
	general = {
		pvpAutoRelease = false,
		autoRepChange = false,
		merchant = false,
		moverTransparancy = 0.8,
		showQuestLevel = false,
		declineduel = false,
		hideZoneText = false,
		trainAllButton = false,
		undressButton = false,
		alreadyKnown = false,
	},
	actionbars = {
		equipped = false,
		equippedColor = {r = 0, g = 1.0, b = 0},
		transparentActionbars = {
			transparentBackdrops = false,
			transparentButtons = false
		}
	},
	blizzard = {
		dressUpFrame = {
			enable = true,
			multiplier = 1.25
		},
	},
	chat = {
		dpsLinks = false,
	},
	character = {
		background = false,
		petBackground = false,
		inspectBackground = false,
		companionBackground = false,
		collapsed = false,
		style = "Cata",
		player = {
			orderName = "",
			collapsedName = {
				ITEM_LEVEL = false,
				BASE_STATS = false,
				MELEE_COMBAT = false,
				RANGED_COMBAT = false,
				SPELL_COMBAT = false,
				DEFENSES = false,
				RESISTANCE = false,
			},
		},
		pet = {
			orderName = "",
			collapsedName = {
				ITEM_LEVEL = false,
				BASE_STATS = false,
				MELEE_COMBAT = false,
				RANGED_COMBAT = false,
				SPELL_COMBAT = false,
				DEFENSES = false,
				RESISTANCE = false,
			},
		},
	},
	datatexts = {
		timeColorEnch = false,
	},
	equipment = {
		enable = false,
		font = "Homespun",
		fontSize = 10,
		fontOutline = "MONOCHROMEOUTLINE",
		durability = {
			enable = false,
			onlydamaged = true,
			position = "TOPLEFT",
			xOffset = 1,
			yOffset = 0
		},
		itemlevel = {
			enable = false,
			qualityColor = true,
			position = "BOTTOMLEFT",
			xOffset = 1,
			yOffset = 4
		}
	},
	minimap = {
		location = false,
		showlocationdigits = true,
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
		itemQualityBorderColor = false,
		tooltipIcon = {
			enable = false,
			tooltipIconSpells = true,
			tooltipIconItems = true,
			tooltipIconAchievements = true
		},
		progressInfo = {
			enable = false,
			checkPlayer = false,
			modifier = "SHIFT",
			tiers = {
				["DS"] = true,
				["FL"] = true,
				["BH"] = true,
				["TOTFW"] = true,
				["BT"] = true,
				["BWD"] = true
			}
		}
	},
	loseControl = {
		CC = true,
		PvE = true,
		Silence = true,
		Disarm = true,
		Root = false,
		Snare = true
	},
	timerTracker = {
		dbm = true
	},
	interruptTracker = {
		size = 32,
		text = {
			enable = true,
			position = "CENTER",
			xOffset = 0,
			yOffset = 0,
			font = "PT Sans Narrow",
			fontSize = 10,
			fontOutline = "MONOCHROMEOUTLINE"
		}
	},
	unitframe = {
		portraitHDModelFix = {
			enable = false,
			debug = false,
			modelsToFix = "scourgemale.m2; scourgefemale.m2; humanfemale.m2; dwarfmale.m2; orcmalenpc.m2; scourgemalenpc.m2; scourgefemalenpc.m2; dwarfmalenpc.m2; humanmalekid.m2; humanfemalekid.m2; chicken.m2; rat.m2"
		},
		units = {
			target = {
				classicon = {
					enable = false,
					size = 28,
					xOffset = -58,
					yOffset = -22
				}
			}
		},
		hideRoleInCombat = false
	},
	watchframe = {
		enable = false,
		city = "COLLAPSED",
		pvp = "HIDDEN",
		arena = "HIDDEN",
		party = "COLLAPSED",
		raid = "COLLAPSED"
	}
}