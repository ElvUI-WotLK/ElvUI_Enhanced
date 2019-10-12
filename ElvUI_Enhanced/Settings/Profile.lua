local E, L, V, P, G = unpack(ElvUI)

P.enhanced = {
	general = {
		pvpAutoRelease = false,
		autoRepChange = false,
		merchant = false,
		moverTransparancy = 0.8,
		showQuestLevel = false,
		declineduel = false,
		hideZoneText = false,
		trainAllSkills = false,
		undressButton = false,
		alreadyKnown = false,
	},
	actionbars = {
		transparentActionbars = {
			transparentBackdrops = false,
			transparentButtons = false
		}
	},
	blizzard = {
		dressUpFrame = {
			enable = false,
			multiplier = 1.25
		},
		errorFrame = {
			enable = false,
			width = 300,
			height = 60,
			font = "PT Sans Narrow",
			fontSize = 12,
			fontOutline = "NONE"
		}
	},
	chat = {
		dpsLinks = false,
	},
	character = {
		animations = false,
		background = false,
		petBackground = false,
		inspectBackground = false,
		companionBackground = false,
	},
	equipment = {
		enable = false,
		font = "Homespun",
		fontSize = 10,
		fontOutline = "MONOCHROMEOUTLINE",
		itemlevel = {
			enable = true,
			qualityColor = true,
			position = "BOTTOMLEFT",
			xOffset = 1,
			yOffset = 4
		},
		durability = {
			enable = false,
			onlydamaged = true,
			position = "TOPLEFT",
			xOffset = 1,
			yOffset = 0
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
		classCache = false,
		chatBubbles = false,
		titleCache = false,
		guild = {
			font = "PT Sans Narrow",
			fontSize = 11,
			fontOutline = "OUTLINE",
			separator = " ",
			colors = {
				raid = {r = 1, g = 127/255, b = 0},
				party = {r = 118/255, g = 200/255, b = 1},
				guild = {r = 64/255, g = 1, b = 64/255},
				none = {r = 1, g = 1, b = 1}
			},
			visibility = {
				city = true,
				pvp = true,
				arena = true,
				party = true,
				raid = true
			}
		},
		npc = {
			font = "PT Sans Narrow",
			fontSize = 11,
			fontOutline = "OUTLINE",
			color = {r = 1, g = 1, b = 1},
			separator = " ",
		}
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
		iconSize = 60,
		compactMode = false,
		CC = true,
		PvE = true,
		Silence = true,
		Disarm = true,
		Root = false,
		Snare = false
	},
	timerTracker = {
		dbm = true
	},
	interruptTracker = {
		size = 32,
		text = {
			enable = true,
			font = "PT Sans Narrow",
			fontSize = 10,
			fontOutline = "OUTLINE",
			position = "CENTER",
			xOffset = 0,
			yOffset = 0,
		}
	},
	unitframe = {
		portraitHDModelFix = {
			enable = false,
			debug = false,
			modelsToFix = "scourgemale.m2; scourgefemale.m2; humanfemale.m2; dwarfmale.m2; orcmalenpc.m2; scourgemalenpc.m2; scourgefemalenpc.m2; dwarfmalenpc.m2; humanmalekid.m2; humanfemalekid.m2; chicken.m2; rat.m2"
		},
		detachPortrait = {
			player = {
				enable = false,
				width = 54,
				height = 54
			},
			target = {
				enable = false,
				width = 54,
				height = 54
			}
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