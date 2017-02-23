local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("ElvUI_Enhanced");

local format = string.format

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName);
end

local function GeneralOptions()
	local M = E:GetModule("Enhanced_Misc");

	local config = {
		order = 1,
		type = "group",
		name = L["General"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["General"]
			},
			pvpAutoRelease = {
				order = 1,
				type = "toggle",
				name = L["PvP Autorelease"],
				desc = L["Automatically release body when killed inside a battleground."],
				get = function(info) return E.db.enhanced.general.pvpAutoRelease; end,
				set = function(info, value) E.db.enhanced.general.pvpAutoRelease = value; M:AutoRelease(); end
			},
			autoRepChange = {
				order = 2,
				type = "toggle",
				name = L["Track Reputation"],
				desc = L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."],
				get = function(info) return E.db.enhanced.general.autoRepChange; end,
				set = function(info, value) E.db.enhanced.general.autoRepChange = value; M:WatchedFaction(); end
			},
			moverTransparancy = {
				order = 3,
				type = "range",
				isPercent = true,
				name = L["Mover Transparency"],
				desc = L["Changes the transparency of all the movers."],
				min = 0, max = 1, step = 0.01,
				get = function(info) return E.db.enhanced.general.moverTransparancy; end,
				set = function(info, value) E.db.enhanced.general.moverTransparancy = value M:UpdateMoverTransparancy(); end
			}
		}
	};
	return config;
end

local function EquipmentOptions()
	local PD = E:GetModule("Enhanced_PaperDoll");

	local config = {
		order = 2,
		type = "group",
		name = L["Equipment"],
		get = function(info) return E.db.enhanced.equipment[info[#info]]; end,
		set = function(info, value) E.db.enhanced.equipment[info[#info]] = value; end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["Equipment"]
			},
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
					E.db.enhanced.equipment[info[#info]] = value;
					PD:ToggleState()
				end,
			},
			durability = {
				order = 3,
				type = "group",
				name = DURABILITY,
				guiInline = true,
				get = function(info) return E.db.enhanced.equipment.durability[info[#info]]; end,
				set = function(info, value) E.db.enhanced.equipment.durability[info[#info]] = value PD:UpdatePaperDoll("player") end,
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
						disabled = function() return not E.db.enhanced.equipment.durability.enable; end
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
				get = function(info) return E.db.enhanced.equipment.itemlevel[info[#info]]; end,
				set = function(info, value) E.db.enhanced.equipment.itemlevel[info[#info]] = value PD:UpdatePaperDoll("player"); end,
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
	return config;
end

local function MinimapOptions()
	local config = {
		order = 3,
		type = "group",
		name = L["Minimap"],
		get = function(info) return E.db.enhanced.minimap[info[#info]] end,
		set = function(info, value) E.db.enhanced.minimap[info[#info]] = value; E:GetModule("Minimap"):UpdateSettings(); end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["Minimap"]
			},
			locationdigits = {
				order = 1,
				type = "range",
				name = L["Location Digits"],
				desc = L["Number of digits for map location."],
				min = 0, max = 2, step = 1,
				disabled = function() return E.db.general.minimap.locationText ~= "ABOVE"; end
			},
			hideincombat = {
				order = 2,
				type = "toggle",
				name = L["Combat Hide"],
				desc = L["Hide minimap while in combat."]
			},
			fadeindelay = {
				order = 3,
				type = "range",
				name = L["FadeIn Delay"],
				desc = L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"],
				min = 0, max = 20, step = 1,
				disabled = function() return not E.db.enhanced.minimap.hideincombat; end
			}
		}
	};
	E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText.values = {
		["MOUSEOVER"] = L["Minimap Mouseover"],
		["SHOW"] = L["Always Display"],
		["ABOVE"] = ColorizeSettingName(L["Above Minimap"]),
		["HIDE"] = L["Hide"]
	};
	return config;
end

local function TooltipOptions()
	local config = {
		order = 4,
		type = "group",
		name = L["Tooltip"],
		get = function(info) return E.db.enhanced.tooltip[info[#info]] end,
		set = function(info, value) E.db.enhanced.tooltip[info[#info]] = value; end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["Tooltip"]
			},
			progressInfo = {
				order = 1,
				type = "toggle",
				name = L["Progress Info"],
				set = function(info, value) E.db.enhanced.tooltip[info[#info]] = value; E:GetModule("Enhanced_ProgressionInfo"):ToggleState(); end
			}
		}
	};
	return config;
end

local function WatchFrameOptions()
	local WF = E:GetModule("Enhanced_WatchFrame");

	local choices = {
		["NONE"] = L["None"],
		["COLLAPSED"] = L["Collapsed"],
		["HIDDEN"] = L["Hidden"]
	};

	local config = {
		order = 5,
		type = "group",
		name = L["WatchFrame"],
		get = function(info) return E.db.enhanced.watchframe[info[#info]] end,
		set = function(info, value) E.db.enhanced.watchframe[info[#info]] = value; WF:UpdateSettings(); end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["WatchFrame"]
			},
			intro = {
				order = 1,
				type = "description",
				name = L["WATCHFRAME_DESC"]
			},
			enable = {
				order = 2,
				type = "toggle",
				name = L["Enable"]
			},
			settings = {
				order = 3,
				type = "group",
				name = L["Settings"],
				guiInline = true,
				get = function(info) return E.db.enhanced.watchframe[info[#info]] end,
				set = function(info, value) E.db.enhanced.watchframe[info[#info]] = value; WF:ChangeState(); end,
				disabled = function() return not E.db.enhanced.watchframe.enable; end,
				args = {
					city = {
						order = 1,
						type = "select",
						name = L["City (Resting)"],
						values = choices
					},
					pvp = {
						order = 2,
						type = "select",
						name = L["PvP"],
						values = choices
					},
					arena = {
						order = 3,
						type = "select",
						name = L["Arena"],
						values = choices
					},
					party = {
						order = 4,
						type = "select",
						name = L["Party"],
						values = choices
					},
					raid = {
						order = 5,
						type = "select",
						name = L["Raid"],
						values = choices
					}
				}
			}
		}
	};
	return config;
end

function addon:GetOptions()
	E.Options.args.enhanced = {
		order = 100,
		type = "group",
		childGroups = "tab",
		name = ColorizeSettingName("Enhanced"),
		args = {
			generalGroup = GeneralOptions(),
			equipmentGroup = EquipmentOptions(),
			minimapGroup = MinimapOptions(),
			tooltipGroup = TooltipOptions(),
			watchFrameGroup = WatchFrameOptions(),
		}
	};
end