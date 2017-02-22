local E, L, V, P, G = unpack(ElvUI);
local EO = E:NewModule("EnhancedOptions", "AceEvent-3.0");
local EP = LibStub("LibElvUIPlugin-1.0");

local addonName = ...;

local format = string.format

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName);
end

function EO:EquipmentOptions()
	local PD = E:GetModule("PaperDoll");

	E.Options.args.equipment = {
		type = "group",
		name = ColorizeSettingName(L["Equipment"]),
		get = function(info) return E.private.equipment[info[#info]]; end,
		set = function(info, value) E.private.equipment[info[#info]] = value; end,
		args = {
			intro = {
				order = 1,
				type = "description",
				name = L["DURABILITY_DESC"]
			},
			enable = {
				order = 2,
				type = "toggle",
				name = L["Enable"],
				set = function(info, value)
					E.private.equipment[info[#info]] = value
					PD:ToggleState()
				end,
			},
			durability = {
				order = 3,
				type = "group",
				name = DURABILITY,
				guiInline = true,
				get = function(info) return E.private.equipment.durability[info[#info]]; end,
				set = function(info, value) E.private.equipment.durability[info[#info]] = value PD:UpdatePaperDoll("player") end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Enable/Disable the display of durability information on the character screen."]
					},
					onlydamaged = {
						order = 2,
						type = "toggle",
						name = L["Damaged Only"],
						desc = L["Only show durabitlity information for items that are damaged."],
						disabled = function() return not E.private.equipment.durability.enable; end
					}
				}
			},
			intro2 = {
				order = 4,
				type = "description",
				name = L["ITEMLEVEL_DESC"]
			},
			itemlevel = {
				order = 5,
				type = "group",
				name = L["Item Level"],
				guiInline = true,
				get = function(info) return E.private.equipment.itemlevel[info[#info]]; end,
				set = function(info, value) E.private.equipment.itemlevel[info[#info]] = value PD:UpdatePaperDoll("player"); end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Enable/Disable the display of item levels on the character screen."]
					}
				}
			}
		}
	};
end

function EO:MapOptions()
	E.Options.args.maps.args.minimap.args.locationdigits = {
		order = 4,
		type = "range",
		name = ColorizeSettingName(L["Location Digits"]),
		desc = L["Number of digits for map location."],
		min = 0, max = 2, step = 1,
		get = function(info) return E.private.general.minimap.locationdigits; end,
		set = function(info, value) E.private.general.minimap.locationdigits = value; E:GetModule("Minimap"):UpdateSettings(); end,
		disabled = function() return E.db.general.minimap.locationText ~= "ABOVE"; end
	};

	E.Options.args.maps.args.minimap.args.hideincombat = {
		order = 6,
		type = "toggle",
		name = ColorizeSettingName(L["Combat Hide"]),
		desc = L["Hide minimap while in combat."],
		get = function(info) return E.private.general.minimap.hideincombat; end,
		set = function(info, value) E.private.general.minimap.hideincombat = value; E:GetModule("Minimap"):UpdateSettings(); end
	};

	E.Options.args.maps.args.minimap.args.fadeindelay = {
		order = 5,
		type = "range",
		name = ColorizeSettingName(L["FadeIn Delay"]),
		desc = L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"],
		min = 0, max = 20, step = 1,
		get = function(info) return E.private.general.minimap.fadeindelay; end,
		set = function(info, value) E.private.general.minimap.fadeindelay = value; end,
		disabled = function() return not E.private.general.minimap.hideincombat; end
	};

	E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText.values = {
		["MOUSEOVER"] = L["Minimap Mouseover"],
		["SHOW"] = L["Always Display"],
		["ABOVE"] = ColorizeSettingName(L["Above Minimap"]),
		["HIDE"] = L["Hide"]
	};
end

function EO:MiscOptions()
	local M = E:GetModule("MiscEnh")

	E.Options.args.general.args.general.args.pvpautorelease = {
		order = 23,
		type = "toggle",
		name = ColorizeSettingName(L["PvP Autorelease"]),
		desc = L["Automatically release body when killed inside a battleground."],
		get = function(info) return E.private.general.pvpautorelease; end,
		set = function(info, value) E.private.general.pvpautorelease = value; E:StaticPopup_Show("PRIVATE_RL"); end
	};

	E.Options.args.general.args.general.args.autorepchange = {
		order = 24,
		type = "toggle",
		name = ColorizeSettingName(L["Track Reputation"]),
		desc = L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."],
		get = function(info) return E.private.general.autorepchange; end,
		set = function(info, value) E.private.general.autorepchange = value; end
	};

	E.Options.args.general.args.general.args.movertransparancy = {
		order = 4,
		type = "range",
		isPercent = true,
		name = ColorizeSettingName(L["Mover Transparency"]),
		desc = L["Changes the transparency of all the movers."],
		min = 0, max = 1, step = 0.01,
		set = function(info, value) E.db.general.movertransparancy = value M:UpdateMoverTransparancy(); end,
		get = function(info) return E.db.general.movertransparancy; end,
	};
end

function EO:NameplateOptions()
	E.Options.args.nameplate.args.general.args.targetcount = {
		type = "toggle",
		order = 7,
		name = ColorizeSettingName(L["Target Count"]),
		desc = L["Display the number of party / raid members targetting the nameplate unit."],
	}
	E.Options.args.nameplate.args.general.args.showthreat = {
		type = "toggle",
		order = 8,
		name = ColorizeSettingName(L["Threat Text"]),
		desc = L["Display threat level as text on targeted, boss or mouseover nameplate."],
	}
end

function EO:UnitFramesOptions()
	local TC = E:GetModule("TargetClass")

	E.Options.args.unitframe.args.target.args.attackicon = {
		order = 1001,
		type = "group",
		name = ColorizeSettingName(L["Attack Icon"]),
		get = function(info) return E.db.unitframe.units["target"]["attackicon"][info[#info]] end,
		set = function(info, value) E.db.unitframe.units["target"]["attackicon"][info[#info]] = value end,
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked."],
			},
			xOffset = {
				order = 4,
				type = "range",
				name = L["xOffset"],
				min = -60, max = 60, step = 1,
			},
			yOffset = {
				order = 5,
				type = "range",
				name = L["yOffset"],
				min = -60, max = 60, step = 1,
			},
		},
	}

	E.Options.args.unitframe.args.target.args.classicon = {
		order = 1002,
		type = "group",
		name = ColorizeSettingName(L["Class Icons"]),
		get = function(info) return E.db.unitframe.units["target"]["classicon"][info[#info]] end,
		set = function(info, value) E.db.unitframe.units["target"]["classicon"][info[#info]] = value; TC:ToggleSettings() end,
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Show class icon for units."],
			},
			size = {
				order = 4,
				type = "range",
				name = L["Size"],
				desc = L["Size of the indicator icon."],
				min = 16, max = 40, step = 1,
			},
			xOffset = {
				order = 5,
				type = "range",
				name = L["xOffset"],
				min = -100, max = 100, step = 1,
			},
			yOffset = {
				order = 6,
				type = "range",
				name = L["yOffset"],
				min = -80, max = 40, step = 1,
			},
		},
	}

	E.Options.args.unitframe.args.general.args.generalGroup.args.hideroleincombat = {
		order = 7,
		name = ColorizeSettingName(L["Hide Role Icon in combat"]),
		desc = L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."],
		type = "toggle",
		set = function(info, value) E.db.unitframe[info[#info]] = value; E:StaticPopup_Show("PRIVATE_RL"); end
	};
end

function EO:WatchFrame()
	local WF = E:GetModule("WatchFrame")

	local choices = {
		["NONE"] = L["None"],
		["COLLAPSED"] = L["Collapsed"],
		["HIDDEN"] = L["Hidden"],
	}

	E.Options.args.watchframe = {
		type = "group",
		name = ColorizeSettingName(L["WatchFrame"]),
		get = function(info) return E.private.watchframe[info[#info]] end,
		set = function(info, value) E.private.watchframe[info[#info]] = value; WF:UpdateSettings() end,
		args = {
			intro = {
				order = 1,
				type = "description",
				name = L["WATCHFRAME_DESC"],
			},
			enable = {
				order = 2,
				type = "toggle",
				name = L["Enable"],
			},
			settings = {
				order = 3,
				type = "group",
				name = L["Settings"],
				guiInline = true,
				disabled = function() return not E.private.watchframe.enable end,
				get = function(info) return E.db.watchframe[info[#info]] end,
				set = function(info, value) E.db.watchframe[info[#info]] = value end,
				args = {
					city = {
						order = 4,
						type = "select",
						name = L["City (Resting)"],
						values = choices,
					},
					pvp = {
						order = 5,
						type = "select",
						name = L["PvP"],
						values = choices,
					},
					arena = {
						order = 6,
						type = "select",
						name = L["Arena"],
						values = choices,
					},
					party = {
						order = 7,
						type = "select",
						name = L["Party"],
						values = choices,
					},
					raid = {
						order = 8,
						type = "select",
						name = L["Raid"],
						values = choices,
					},
				}
			}
		}
	}
end

local function GetOptions()
	EO:EquipmentOptions()
	EO:MapOptions()
	EO:MiscOptions()
	EO:NameplateOptions()
	EO:UnitFramesOptions()
	EO:WatchFrame()
end

function EO:Initialize()
	EP:RegisterPlugin(addonName, GetOptions);
end

E:RegisterModule(EO:GetName());