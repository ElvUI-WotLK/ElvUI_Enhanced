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
			},
			portraitHDModelFix = {
				order = 4,
				type = "group",
				guiInline = true,
				name = L["Portrait HD Fix"],
				get = function(info) return E.db.enhanced.unitframe.portraitHDModelFix[info[#info]]; end,
				set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix[info[#info]] = value; end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix.enable = value; E:GetModule("Enhanced_UF_PortraitHDModelFix"):ToggleState(); end
					},
					debug = {
						order = 2,
						type = "toggle",
						name = L["Debug"],
						desc = L["Print to chat model names of units with enabled 3D portraits."],
						set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix.debug = value; end,
						disabled = function() return not E.db.enhanced.unitframe.portraitHDModelFix.enable; end
					},
					modelsToFix = {
						order = 3,
						type = "input",
						name = L["Models to fix"],
						desc = L["List of models with broken portrait camera. Separete each model name with \";\" simbol"],
						width = "full",
						multiline = true,
						set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix.modelsToFix = value; E:GetModule("Enhanced_UF_PortraitHDModelFix"):UpdatePortraits(); end,
						disabled = function() return not E.db.enhanced.unitframe.portraitHDModelFix.enable; end
					}
				}
			}
		}
	};
	return config;
end

local function ChatOptions()
	local config = {
		order = 2,
		type = "group",
		name = L["Chat"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["Chat"]
			},
			dpsLinks = {
				order = 1,
				type = "toggle",
				name = L["Filter DPS meters Spam"],
				desc = L["Replaces long reports from damage meters with a clickeble hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"],
				get = function(info) return E.db.enhanced.chat.dpsLinks; end,
				set = function(info, value) E.db.enhanced.chat.dpsLinks = value; E:GetModule("Enhanced_DPSLinks"):UpdateSettings(); end
			}
		}
	};
	return config;
end

local function DataTextsOptions()
	local config = {
		order = 3,
		type = "group",
		name = L["DataTexts"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["DataTexts"]
			},
			timeColorEnch = {
				order = 1,
				type = "toggle",
				name = L["Enhanced Time Color"],
				get = function(info) return E.db.enhanced.datatexts.timeColorEnch; end,
				set = function(info, value) E.db.enhanced.datatexts.timeColorEnch = value; E:GetModule("Enhanced_DatatextTime"):UpdateSettings(); end
			}
		}
	};
	return config;
end

local function EquipmentOptions()
	local PD = E:GetModule("Enhanced_PaperDoll");

	local config = {
		order = 4,
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
		order = 5,
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
			location = {
				order = 2,
				type = "toggle",
				name = L["Location Panel"],
				desc = L["Toggle Location Panel."],
				set = function(info, value)
					E.db.enhanced.minimap[info[#info]] = value;
					E:GetModule("Enhanced_MinimapLocation"):UpdateSettings();
				end
			},
			hideincombat = {
				order = 3,
				type = "toggle",
				name = L["Combat Hide"],
				desc = L["Hide minimap while in combat."],
				disabled = function() return not (E.db.enhanced.minimap.location and E.db.enhanced.minimap.location) end
			},
			fadeindelay = {
				order = 4,
				type = "range",
				name = L["FadeIn Delay"],
				desc = L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"],
				min = 0, max = 20, step = 1,
				disabled = function() return not (E.db.enhanced.minimap.location and E.db.enhanced.minimap.hideincombat) end
			},
			locationdigits = {
				order = 5,
				type = "range",
				name = L["Location Digits"],
				desc = L["Number of digits for map location."],
				min = 0, max = 2, step = 1,
				disabled = function() return not (E.db.enhanced.minimap.location and E.db.general.minimap.locationText == "ABOVE") end
			}
		}
	};
	E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText.values = {
		["MOUSEOVER"] = L["Minimap Mouseover"],
		["SHOW"] = L["Always Display"],
		["ABOVE"] = ColorizeSettingName(L["Above Minimap"]),
		["HIDE"] = L["Hide"]
	};
	config.args.locationText = E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText
	return config;
end

local function TooltipOptions()
	local config = {
		order = 6,
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
				type = "group",
				name = L["Progress Info"],
				guiInline = true,
				get = function(info) return E.db.enhanced.tooltip.progressInfo[info[#info]]; end,
				set = function(info, value) E.db.enhanced.tooltip.progressInfo[info[#info]] = value; end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value) E.db.enhanced.tooltip.progressInfo[info[#info]] = value; E:GetModule("Enhanced_ProgressionInfo"):ToggleState(); end
					},
					checkPlayer = {
						order = 2,
						type = "toggle",
						name = L["Check Player"]
					},
					modifier = {
						order = 3,
						type = "select",
						name = L["Visibility"],
						set = function(info, value) E.db.enhanced.tooltip.progressInfo[info[#info]] = value; E:GetModule("Enhanced_ProgressionInfo"):UpdateModifier(); end,
						values = {
							["ALL"] = ALWAYS,
							["SHIFT"] = SHIFT_KEY,
							["ALT"] = ALT_KEY,
							["CTRL"] = CTRL_KEY
						}
					},
					tiers = {
						order = 4,
						type = "group",
						name = L["Tiers"],
						get = function(info) return E.db.enhanced.tooltip.progressInfo.tiers[info[#info]]; end,
						set = function(info, value) E.db.enhanced.tooltip.progressInfo.tiers[info[#info]] = value; E:GetModule("Enhanced_ProgressionInfo"):UpdateSettings() end,
						args = {
							RS = {
								order = 1,
								type = "toggle",
								name = E:AbbreviateString(L["Ruby Sanctum"]),
								desc = L["Ruby Sanctum"],
							},
							ICC = {
								order = 2,
								type = "toggle",
								name = E:AbbreviateString(L["Icecrown Citadel"]),
								desc = L["Icecrown Citadel"],
							},
							TotC = {
								order = 3,
								type = "toggle",
								name = E:AbbreviateString(L["Trial of the Crusader"]),
								desc = L["Trial of the Crusader"],
							},
							Ulduar = {
								order = 4,
								type = "toggle",
								name = L["Ulduar"],
								desc = L["Ulduar"],
							}
						}
					}
				}
			}
		}
	};
	return config;
end

local function NamePlatesOptions()
	local config = {
		order = 7,
		type = "group",
		name = L["NamePlates"],
		get = function(info) return E.db.enhanced.nameplates[info[#info]] end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = L["NamePlates"]
			},
			cacheUnitClass = {
				order = 1,
				type = "toggle",
				name = L["Cache Unit Class"],
				set = function(info, value) E.db.enhanced.nameplates[info[#info]] = value; E:GetModule("Enhanced_NamePlates"):CacheUnitClass(); E:GetModule("NamePlates"):ConfigureAll(); end,
			},
			smooth = {
				type = "toggle",
				order = 2,
				name = L["Smooth Bars"],
				desc = L["Bars will transition smoothly."],
				set = function(info, value) E.db.enhanced.nameplates[ info[#info] ] = value; E:GetModule("NamePlates"):ConfigureAll(); end
			},
			smoothSpeed = {
				type = "range",
				order = 3,
				name = L["Animation Speed"],
				desc = L["Speed in seconds"],
				min = 0.1, max = 3, step = 0.01,
				disabled = function() return not E.db.enhanced.nameplates.smooth; end,
				set = function(info, value) E.db.enhanced.nameplates[ info[#info] ] = value; E:GetModule("NamePlates"):ConfigureAll(); end
			},
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
		order = 8,
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
		order = 50,
		type = "group",
		childGroups = "tab",
		name = ColorizeSettingName("Enhanced"),
		args = {
			generalGroup = GeneralOptions(),
			chatGroup = ChatOptions(),
			datatextsGroup = DataTextsOptions(),
			equipmentGroup = EquipmentOptions(),
			minimapGroup = MinimapOptions(),
			namePlatesGroup = NamePlatesOptions(),
			tooltipGroup = TooltipOptions(),
			watchFrameGroup = WatchFrameOptions(),
		}
	};
end