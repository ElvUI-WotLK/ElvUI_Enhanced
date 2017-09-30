local E, L, V, P, G = unpack(ElvUI)

V.general.selectQuestReward = true

V.equipment = {
	["durability"] = {
		enable = false,
		onlydamaged = false
	},
	["itemlevel"] = {
		enable = false
	}
}

V.enhanced = {
	character = {
		enable = true,
		model = {
			enable = true
		}
	},
	timerTracker = {
		enable = true
	},
	loseControl = {
		enable = true
	},
	interruptTracker = {
		enable = false
	}
}