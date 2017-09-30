local E, L, V, P, G = unpack(ElvUI)

V.general.selectQuestReward = true

V.equipment = {
	["durability"] = {
		enable = true,
		onlydamaged = false
	},
	["itemlevel"] = {
		enable = true
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