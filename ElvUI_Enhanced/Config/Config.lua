local E, L, V, P, G = unpack(ElvUI)
local addon = E:GetModule("ElvUI_Enhanced")

local format = string.format
local tsort = table.sort

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

-- General
local function GeneralOptions()
	local M = E:GetModule("Enhanced_Misc")

	local config = {
		order = 1,
		type = "group",
		name = L["General"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = ColorizeSettingName(L["General"])
			},
			pvpAutoRelease = {
				order = 2,
				type = "toggle",
				name = L["PvP Autorelease"],
				desc = L["Automatically release body when killed inside a battleground."],
				get = function(info) return E.db.enhanced.general.pvpAutoRelease end,
				set = function(info, value) E.db.enhanced.general.pvpAutoRelease = value M:AutoRelease() end
			},
			autoRepChange = {
				order = 3,
				type = "toggle",
				name = L["Track Reputation"],
				desc = L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."],
				get = function(info) return E.db.enhanced.general.autoRepChange end,
				set = function(info, value) E.db.enhanced.general.autoRepChange = value M:WatchedFaction() end
			},
			selectQuestReward = {
				order = 4,
				type = "toggle",
				name = L["Select Quest Reward"],
				desc = L["Automatically select the quest reward with the highest vendor sell value."],
				get = function(info) return E.private.general.selectQuestReward end,
				set = function(info, value) E.private.general.selectQuestReward = value; end
			},
			declineduel = {
				order = 5,
				type = "toggle",
				name = L["Decline Duel"],
				desc = L["Auto decline all duels"],
				get = function(info) return E.db.enhanced.general.declineduel end,
				set = function(info, value) E.db.enhanced.general.declineduel = value M:DeclineDuel() end
			},
			hideZoneText = {
				order = 6,
				type = "toggle",
				name = L["Hide Zone Text"],
				get = function(info) return E.db.enhanced.general.hideZoneText end,
				set = function(info, value) E.db.enhanced.general.hideZoneText = value M:HideZone() end
			},
			alreadyKnown = {
				order = 7,
				type = "toggle",
				name = L["Already Known"],
				desc = L["Change color of item icons which already known."],
				get = function(info) return E.db.enhanced.general.alreadyKnown end,
				set = function(info, value)
					E.db.enhanced.general.alreadyKnown = value
					E:GetModule("Enhanced_AlreadyKnown"):ToggleState()
				end
			},
			altBuyMaxStack = {
				order = 8,
				type = "toggle",
				name = L["Alt-Click Merchant"],
				desc = L["Holding Alt key while buying something from vendor will now buy an entire stack."],
				get = function(info) return E.db.enhanced.general.altBuyMaxStack end,
				set = function(info, value)
					E.db.enhanced.general.altBuyMaxStack = value
					M:BuyStackToggle()
				end
			},
			moverTransparancy = {
				order = 9,
				type = "range",
				isPercent = true,
				name = L["Mover Transparency"],
				desc = L["Changes the transparency of all the movers."],
				min = 0, max = 1, step = 0.01,
				get = function(info) return E.db.enhanced.general.moverTransparancy end,
				set = function(info, value) E.db.enhanced.general.moverTransparancy = value M:UpdateMoverTransparancy() end
			}
		}
	}
	return config
end

-- Actionbars
local function ActionbarOptions()
	local EAB = E:GetModule("Enhanced_ActionBars")
	local ETAB = E:GetModule("Enhanced_TransparentActionbars")

	local config = {
		order = 2,
		type = "group",
		name = L["ActionBars"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["ActionBars"])
			},
			equipped = {
				order = 1,
				type = "group",
				name = L["Equipped Item Border"],
				guiInline = true,
				args = {
					equipped = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						get = function(info) return E.db.enhanced.actionbars[ info[#info] ] end,
						set = function(info, value) E.db.enhanced.actionbars[ info[#info] ] = value EAB:UpdateCallback() E:GetModule("ActionBars"):UpdateButtonSettings() end
					},
					equippedColor = {
						order = 2,
						type = "color",
						name = L["Border Color"],
						get = function(info)
							local t = E.db.enhanced.actionbars[ info[#info] ]
							local d = P.enhanced.actionbars[ info[#info] ]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
						end,
						set = function(info, r, g, b)
							local t = E.db.enhanced.actionbars[ info[#info] ]
							t.r, t.g, t.b = r, g, b
							E:GetModule("ActionBars"):UpdateButtonSettings()
						end,
						disabled = function() return not E.db.enhanced.actionbars.equipped end
					}
				}
			},
			transparentActionbars = {
				order = 2,
				type = "group",
				name = L["Transparent ActionBars"],
				guiInline = true,
				get = function(info) return E.db.enhanced.actionbars.transparentActionbars[ info[#info] ] end,
				set = function(info, value) E.db.enhanced.actionbars.transparentActionbars[ info[#info] ] = value end,
				args = {
					transparentBackdrops = {
						order = 1,
						type = "toggle",
						name = L["Transparent Backdrop"],
						desc = L["Sets actionbars' backgrounds to transparent template."],
						set = function(info, value) E.db.enhanced.actionbars.transparentActionbars[ info[#info] ] = value ETAB:StyleBackdrops() end
					},
					transparentButtons = {
						order = 2,
						type = "toggle",
						name = L["Transparent Buttons"],
						desc = L["Sets actionbars buttons' backgrounds to transparent template."],
						set = function(info, value) E.db.enhanced.actionbars.transparentActionbars[ info[#info] ] = value ETAB:StyleBackdrops() end
					}
				},
				disabled = function() return not E.private.actionbar.enable end
			}
		}
	}
	return config
end

-- Chat
local function ChatOptions()
	local config = {
		order = 3,
		type = "group",
		name = L["Chat"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Chat"])
			},
			dpsLinks = {
				order = 1,
				type = "toggle",
				name = L["Filter DPS meters Spam"],
				desc = L["Replaces long reports from damage meters with a clickable hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"],
				get = function(info) return E.db.enhanced.chat.dpsLinks end,
				set = function(info, value) E.db.enhanced.chat.dpsLinks = value E:GetModule("Enhanced_DPSLinks"):UpdateSettings() end
			}
		}
	}
	return config
end

-- Equipment
local function CharacterFrameOptions()
	local PD = E:GetModule("Enhanced_PaperDoll")

	local config = {
		order = 4,
		type = "group",
		name = L["Equipment"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = ColorizeSettingName(L["Equipment"])
			},
			enable = {
				order = 2,
				type = "toggle",
				name = L["Enable"],
				get = function(info) return E.db.enhanced.equipment[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment[info[#info]] = value
					LoadAddOn("Blizzard_InspectUI")
					PD:ToggleState()
				end,
			},
			durability = {
				order = 3,
				type = "group",
				name = DURABILITY,
				guiInline = true,
				get = function(info) return E.db.enhanced.equipment.durability[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment.durability[info[#info]] = value
					LoadAddOn("Blizzard_InspectUI")
					PD:ToggleState()
					PD:UpdateInfoText("Character")
				end,
				args = {
					info = {
						order = 1,
						type = "description",
						name = L["DURABILITY_DESC"]
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enable"],
						desc = L["Enable/Disable the display of durability information on the character screen."]
					},
					onlydamaged = {
						order = 3,
						type = "toggle",
						name = L["Damaged Only"],
						desc = L["Only show durabitlity information for items that are damaged."],
						disabled = function() return not E.db.enhanced.equipment.durability.enable end
					},
					spacer = {
						order = 4,
						type = "description",
						name = " "
					},
					position = {
						order = 5,
						type = "select",
						name = L["Position"],
						values = {
							["TOP"] = "TOP",
							["TOPLEFT"] = "TOPLEFT",
							["TOPRIGHT"] = "TOPRIGHT",
							["BOTTOM"] = "BOTTOM",
							["BOTTOMLEFT"] = "BOTTOMLEFT",
							["BOTTOMRIGHT"] = "BOTTOMRIGHT"
						},
						disabled = function() return not E.db.enhanced.equipment.durability.enable end
					},
					xOffset = {
						order = 6,
						type = "range",
						name = L["X-Offset"],
						min = -50, max = 50, step = 1,
						disabled = function() return not E.db.enhanced.equipment.durability.enable end
					},
					yOffset = {
						order = 7,
						type = "range",
						name = L["Y-Offset"],
						min = -50, max = 50, step = 1,
						disabled = function() return not E.db.enhanced.equipment.durability.enable end
					}
				}
			},
			itemlevel = {
				order = 4,
				type = "group",
				name = L["Item Level"],
				guiInline = true,
				get = function(info) return E.db.enhanced.equipment.itemlevel[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment.itemlevel[info[#info]] = value
					LoadAddOn("Blizzard_InspectUI")
					PD:ToggleState()
					PD:UpdateInfoText("Character")
				end,
				args = {
					info = {
 						order = 1,
						type = "description",
						name = L["ITEMLEVEL_DESC"]
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enable"],
						desc = L["Enable/Disable the display of item levels on the character screen."]
					},
					qualityColor = {
 						order = 3,
						type = "toggle",
						name = L["Quality Color"],
						disabled = function() return not E.db.enhanced.equipment.itemlevel.enable end
					},
					spacer = {
						order = 4,
						type = "description",
						name = " "
					},
					position = {
						order = 5,
						type = "select",
						name = L["Position"],
						values = {
							["TOP"] = "TOP",
							["TOPLEFT"] = "TOPLEFT",
							["TOPRIGHT"] = "TOPRIGHT",
							["BOTTOM"] = "BOTTOM",
							["BOTTOMLEFT"] = "BOTTOMLEFT",
							["BOTTOMRIGHT"] = "BOTTOMRIGHT"
						},
						disabled = function() return not E.db.enhanced.equipment.itemlevel.enable end
					},
					xOffset = {
						order = 6,
						type = "range",
						name = L["X-Offset"],
						min = -50, max = 50, step = 1,
						disabled = function() return not E.db.enhanced.equipment.itemlevel.enable end
					},
					yOffset = {
						order = 7,
						type = "range",
						name = L["Y-Offset"],
						min = -50, max = 50, step = 1,
						disabled = function() return not E.db.enhanced.equipment.itemlevel.enable end
					}
				}
			},
			fontGroup = {
				order = 5,
				type = "group",
				name = L["Font"],
				guiInline = true,
				get = function(info) return E.db.enhanced.equipment[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment[info[#info]] = value
					LoadAddOn("Blizzard_InspectUI")
					PD:ToggleState()
					PD:UpdateInfoText("Character")
				end,
				args = {
					font = {
						order = 1,
						type = "select",
						dialogControl = "LSM30_Font",
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font
					},
					fontSize = {
						order = 2,
						type = "range",
						name = FONT_SIZE,
						min = 6, max = 36, step = 1
					},
					fontOutline = {
						order = 3,
						type = "select",
						name = L["Font Outline"],
						values = {
							["NONE"] = NONE,
							["OUTLINE"] = "OUTLINE",
							["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE"
						}
					}
				}
			}
		}
	}
	return config
end

-- Datatext
local function DataTextsOptions()
	local config = {
		order = 5,
		type = "group",
		name = L["DataTexts"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["DataTexts"])
			},
			timeColorEnch = {
				order = 1,
				type = "toggle",
				name = L["Enhanced Time Color"],
				get = function(info) return E.db.enhanced.datatexts.timeColorEnch end,
				set = function(info, value) E.db.enhanced.datatexts.timeColorEnch = value E:GetModule("Enhanced_DatatextTime"):UpdateSettings() end
			}
		}
	}
	return config
end

-- Minimap
local function MinimapOptions()
	local config = {
		order = 6,
		type = "group",
		name = L["Minimap"],
		get = function(info) return E.db.enhanced.minimap[info[#info]] end,
		set = function(info, value) E.db.enhanced.minimap[info[#info]] = value E:GetModule("Minimap"):UpdateSettings() end,
		disabled = function() return not E.private.general.minimap.enable end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Minimap"])
			},
			location = {
				order = 1,
				type = "toggle",
				name = L["Location Panel"],
				desc = L["Toggle Location Panel."],
				set = function(info, value)
					E.db.enhanced.minimap[info[#info]] = value
					E:GetModule("Enhanced_MinimapLocation"):UpdateSettings()
				end
			},
			showlocationdigits = {
				order = 2,
				type = "toggle",
				name = L["Show Location Digits"],
				desc = L["Toggle Location Digits."],
				set = function(info, value)
					E.db.enhanced.minimap.showlocationdigits = value
					E:GetModule("Enhanced_MinimapLocation"):UpdateSettings()
				end,
				disabled = function() return not (E.db.enhanced.minimap.location and E.db.general.minimap.locationText == "ABOVE") end
			},
			locationdigits = {
				order = 3,
				type = "range",
				name = L["Location Digits"],
				desc = L["Number of digits for map location."],
				min = 0, max = 2, step = 1,
				disabled = function() return not (E.db.enhanced.minimap.location and E.db.general.minimap.locationText == "ABOVE" and E.db.enhanced.minimap.showlocationdigits) end
			},
			combatHide = {
				order = 4,
				type = "group",
				name = L["Combat Hide"],
				guiInline = true,
				args = {
					hideincombat = {
						order = 5,
						type = "toggle",
						name = L["Enable"],
						desc = L["Hide minimap while in combat."],
					},
					fadeindelay = {
						order = 6,
						type = "range",
						name = L["FadeIn Delay"],
						desc = L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"],
						min = 0, max = 20, step = 1,
						disabled = function() return not E.db.enhanced.minimap.hideincombat end
					}
				}
			}
		}
	}
	E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText.values = {
		["MOUSEOVER"] = L["Minimap Mouseover"],
		["SHOW"] = L["Always Display"],
		["ABOVE"] = ColorizeSettingName(L["Above Minimap"]),
		["HIDE"] = L["Hide"]
	}
	config.args.locationText = E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText
	return config
end

-- Nameplates
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
				name = ColorizeSettingName(L["NamePlates"])
			},
			cacheUnitClass = {
				order = 1,
				type = "toggle",
				name = L["Cache Unit Class"],
				set = function(info, value) E.db.enhanced.nameplates[info[#info]] = value E:GetModule("Enhanced_NamePlates"):CacheUnitClass() E:GetModule("NamePlates"):ConfigureAll() end,
			},
			smooth = {
				type = "toggle",
				order = 2,
				name = L["Smooth Bars"],
				desc = L["Bars will transition smoothly."],
				set = function(info, value) E.db.enhanced.nameplates[ info[#info] ] = value E:GetModule("NamePlates"):ConfigureAll() end
			},
			smoothSpeed = {
				type = "range",
				order = 3,
				name = L["Animation Speed"],
				desc = L["Speed in seconds"],
				min = 0.1, max = 3, step = 0.01,
				disabled = function() return not E.db.enhanced.nameplates.smooth end,
				set = function(info, value) E.db.enhanced.nameplates[ info[#info] ] = value E:GetModule("NamePlates"):ConfigureAll() end
			},
		}
	}
	return config
end

-- Skins
local function SkinsOptions()
	local B = E:GetModule("Enhanced_Blizzard")
	local M = E:GetModule("Enhanced_Misc")

	local config = {
		order = 8,
		type = "group",
		name = L["Skins"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = ColorizeSettingName(L["Skins"])
			},
			achievements = {
				order = 2,
				type = "group",
				name = ACHIEVEMENTS,
				get = function(info) return E.private.skins.animations; end,
				set = function(info, value) E.private.skins.animations = value; end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = ACHIEVEMENTS
					},
					animations = {
						order = 2,
						type = "toggle",
						name = L["Animated Bars"]
					}
				}
			},
			characterFrame = {
				order = 2,
				type = "group",
				name = L["Character Frame"],
				get = function(info) return E.private.skins.animations; end,
				set = function(info, value) E.private.skins.animations = value; end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Character Frame"]
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enhanced Character Frame"],
						get = function(info) return E.private.enhanced.character.enable end,
						set = function(info, value) E.private.enhanced.character.enable = value; E:StaticPopup_Show("PRIVATE_RL") end
					},
					model = {
						order = 3,
						type = "toggle",
						name = L["Enhanced Control Panel"],
						get = function(info) return E.private.enhanced.character.model.enable end,
						set = function(info, value) E.private.enhanced.character.model.enable = value; E:StaticPopup_Show("PRIVATE_RL") end
					},
					paperdollBackgrounds = {
						order = 4,
						type = "group",
						name = L["Paperdoll Backgrounds"],
						guiInline = true,
						args = {
							background = {
								order = 2,
								type = "toggle",
								name = L["Character Background"],
								get = function(info) return E.db.enhanced.character.background end,
								set = function(info, value) E.db.enhanced.character.background = value; E:GetModule("Enhanced_CharacterFrame"):UpdateCharacterModelFrame() end,
								disabled = function() return not E.private.enhanced.character.enable end
							},
							petBackground = {
								order = 3,
								type = "toggle",
								name = L["Pet Background"],
								get = function(info) return E.db.enhanced.character.petBackground end,
								set = function(info, value) E.db.enhanced.character.petBackground = value; E:GetModule("Enhanced_CharacterFrame"):UpdatePetModelFrame() end,
								disabled = function() return not E.private.enhanced.character.enable end
							},
							inspectBackground = {
								order = 4,
								type = "toggle",
								name = L["Inspect Background"],
								get = function(info) return E.db.enhanced.character.inspectBackground end,
								set = function(info, value) E.db.enhanced.character.inspectBackground = value; end,
								disabled = function() return not E.private.enhanced.character.enable end
							},
							companionBackground = {
								order = 5,
								type = "toggle",
								name = L["Companion Background"],
								get = function(info) return E.db.enhanced.character.companionBackground end,
								set = function(info, value) E.db.enhanced.character.companionBackground = value; E:GetModule("Enhanced_CharacterFrame"):UpdateCompanionModelFrame() end,
								disabled = function() return not E.private.enhanced.character.enable end
							}
						}
					}
				}
			},
			dressingRoom = {
				order = 3,
				type = "group",
				name = L["Dressing Room"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Dressing Room"]
					},
					enhancedDressingRoom = {
						order = 2,
						type = "group",
						name = L["Enhanced Dressing Room"],
						guiInline = true,
						get = function(info) return E.db.enhanced.blizzard.dressUpFrame[ info[#info] ] end,
						set = function(info, value) E.db.enhanced.blizzard.dressUpFrame[ info[#info] ] = value; B:UpdateDressUpFrame() end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"]
							},
							multiplier = {
								order = 2,
								type = "range",
								isPercent = true,
								name = L["Scale"],
								min = 1, max = 2, step = 0.01
							}
						}
					},
					undressButton = {
						order = 3,
						type = "toggle",
						name = L["Undress Button"],
						desc = L["Add button to Dressing Room frame with ability to undress model."],
						get = function(info) return E.db.enhanced.general.undressButton end,
						set = function(info, value)
							E.db.enhanced.general.undressButton = value
							E:GetModule("Enhanced_UndressButtons"):ToggleState()
						end
					}
				}
			},
			trainer = {
				order = 4,
				type = "group",
				name = L["Trainer Frame"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Trainer Frame"]
					},
					trainAllButton = {
						order = 2,
						type = "toggle",
						name = L["Train All Button"],
						desc = L["Add button to Trainer frame with ability to train all available skills in one click."],
						get = function(info) return E.db.enhanced.general.trainAllButton end,
						set = function(info, value)
							E.db.enhanced.general.trainAllButton = value
							E:GetModule("Enhanced_TrainAll"):ToggleState()
						end
					}
				}
			},
			quest = {
				order = 5,
				type = "group",
				name = L["Quest Frames"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Quest Frames"]
					},
					showQuestLevel = {
						order = 2,
						type = "toggle",
						name = L["Show Quest Level"],
						desc = L["Display quest levels at Quest Log."],
						get = function(info) return E.db.enhanced.general.showQuestLevel end,
						set = function(info, value)
							E.db.enhanced.general.showQuestLevel = value
							M:QuestLevelToggle()
						end
					}
				}
			}
		}
	}

	return config
end

-- Tooltip
local function TooltipOptions()
	local config = {
		order = 9,
		type = "group",
		name = L["Tooltip"],
		get = function(info) return E.db.enhanced.tooltip[info[#info]] end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Tooltip"])
			},
			itemQualityBorderColor = {
				order = 1,
				type = "toggle",
				name = L["Item Border Color"],
				desc = L["Colorize the tooltip border based on item quality."],
				get = function(info) return E.db.enhanced.tooltip.itemQualityBorderColor end,
				set = function(info, value) E.db.enhanced.tooltip.itemQualityBorderColor = value E:GetModule("Enhanced_ItemBorderColor"):ToggleState() end
			},
			tooltipIcon = {
				order = 2,
				type = "group",
				name = L["Tooltip Icon"],
				guiInline = true,
				args = {
					tooltipIcon = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Show/Hides an Icon for Spells and Items on the Tooltip."],
						get = function(info) return E.db.enhanced.tooltip.tooltipIcon.enable end,
						set = function(info, value)
							E.db.enhanced.tooltip.tooltipIcon.enable = value
							E:GetModule("Enhanced_TooltipIcon"):ToggleItemsState()
							E:GetModule("Enhanced_TooltipIcon"):ToggleSpellsState()
							E:GetModule("Enhanced_TooltipIcon"):ToggleAchievementsState()
						end
					},
					spacer = {
						order = 2,
						type = "description",
						name = "",
						width = "full"
					},
					tooltipIconSpells = {
						order = 3,
						type = "toggle",
						name = SPELLS,
						desc = L["Show/Hides an Icon for Spells on the Tooltip."],
						get = function(info) return E.db.enhanced.tooltip.tooltipIcon.tooltipIconSpells end,
						set = function(info, value)
							E.db.enhanced.tooltip.tooltipIcon.tooltipIconSpells = value
							E:GetModule("Enhanced_TooltipIcon"):ToggleSpellsState()
						end,
						disabled = function() return not E.db.enhanced.tooltip.tooltipIcon.enable end
					},
					tooltipIconItems = {
						order = 4,
						type = "toggle",
						name = ITEMS,
						desc = L["Show/Hides an Icon for Items on the Tooltip."],
						get = function(info) return E.db.enhanced.tooltip.tooltipIcon.tooltipIconItems end,
						set = function(info, value)
							E.db.enhanced.tooltip.tooltipIcon.tooltipIconItems = value
							E:GetModule("Enhanced_TooltipIcon"):ToggleItemsState()
						end,
						disabled = function() return not E.db.enhanced.tooltip.tooltipIcon.enable end
					},
					tooltipIconAchievements = {
						order = 5,
						type = "toggle",
						name = ACHIEVEMENTS,
						desc = L["Show/Hides an Icon for Achievements on the Tooltip."],
						get = function(info) return E.db.enhanced.tooltip.tooltipIcon.tooltipIconAchievements end,
						set = function(info, value)
							E.db.enhanced.tooltip.tooltipIcon.tooltipIconAchievements = value
							E:GetModule("Enhanced_TooltipIcon"):ToggleAchievementsState()
						end,
						disabled = function() return not E.db.enhanced.tooltip.tooltipIcon.enable end
					}
				}
			},
			progressInfo = {
				order = 3,
				type = "group",
				name = L["Progress Info"],
				guiInline = true,
				get = function(info) return E.db.enhanced.tooltip.progressInfo[info[#info]] end,
				set = function(info, value) E.db.enhanced.tooltip.progressInfo[info[#info]] = value end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value) E.db.enhanced.tooltip.progressInfo[info[#info]] = value E:GetModule("Enhanced_ProgressionInfo"):ToggleState() end
					},
					checkPlayer = {
						order = 2,
						type = "toggle",
						name = L["Check Player"],
						disabled = function() return not E.db.enhanced.tooltip.progressInfo.enable end
					},
					modifier = {
						order = 3,
						type = "select",
						name = L["Visibility"],
						set = function(info, value) E.db.enhanced.tooltip.progressInfo[info[#info]] = value E:GetModule("Enhanced_ProgressionInfo"):UpdateModifier() end,
						values = {
							["ALL"] = ALWAYS,
							["SHIFT"] = SHIFT_KEY,
							["ALT"] = ALT_KEY,
							["CTRL"] = CTRL_KEY
						},
						disabled = function() return not E.db.enhanced.tooltip.progressInfo.enable end
					},
					tiers = {
						order = 4,
						type = "group",
						name = L["Tiers"],
						get = function(info) return E.db.enhanced.tooltip.progressInfo.tiers[info[#info]] end,
						set = function(info, value) E.db.enhanced.tooltip.progressInfo.tiers[info[#info]] = value E:GetModule("Enhanced_ProgressionInfo"):UpdateSettings() end,
						disabled = function() return not E.db.enhanced.tooltip.progressInfo.enable end,
						args = {
							RS = {
								order = 1,
								type = "toggle",
								name = L["Ruby Sanctum"]
							},
							ICC = {
								order = 2,
								type = "toggle",
								name = L["Icecrown Citadel"]
							},
							ToC = {
								order = 3,
								type = "toggle",
								name = L["Trial of the Crusader"]
							},
							Ulduar = {
								order = 4,
								type = "toggle",
								name = L["Ulduar"]
							}
						}
					}
				}
			}
		}
	}
	return config
end

-- WatchFrame
local function WatchFrameOptions()
	local WF = E:GetModule("Enhanced_WatchFrame")

	local choices = {
		["NONE"] = NONE,
		["COLLAPSED"] = L["Collapsed"],
		["HIDDEN"] = L["Hidden"]
	}

	local config = {
		order = 10,
		type = "group",
		name = L["Watch Frame"],
		get = function(info) return E.db.enhanced.watchframe[info[#info]] end,
		set = function(info, value) E.db.enhanced.watchframe[info[#info]] = value WF:UpdateSettings() end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Watch Frame"])
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
				name = L["Visibility State"],
				guiInline = true,
				get = function(info) return E.db.enhanced.watchframe[info[#info]] end,
				set = function(info, value) E.db.enhanced.watchframe[info[#info]] = value WF:ChangeState() end,
				disabled = function() return not E.db.enhanced.watchframe.enable end,
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
	}
	return config
end

-- Lose Control
local function LoseControlOptions()
	local config = {
		order = 11,
		type = "group",
		name = L["Lose Control"],
		get = function(info) return E.db.enhanced.tooltip[info[#info]] end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Lose Control"])
			},
			enable = {
				order = 1,
				type = "toggle",
				name = L["Enable"],
				get = function(info) return E.db.enhanced.loseControl.enable end,
				set = function(info, value) E.db.enhanced.loseControl.enable = value E:StaticPopup_Show("PRIVATE_RL") end
			},
			typeGroup = {
				order = 2,
				type = "group",
				name = TYPE,
				guiInline = true,
				get = function(info) return E.db.enhanced.loseControl[ info[#info] ] end,
				set = function(info, value) E.db.enhanced.loseControl[ info[#info] ] = value end,
				disabled = function() return not E.db.enhanced.loseControl.enable end,
				args = {
					CC = {
						type = "toggle",
						name = L["CC"]
					},
					PvE = {
						type = "toggle",
						name = L["PvE"]
					},
					Silence = {
						type = "toggle",
						name = L["Silence"]
					},
					Disarm = {
						type = "toggle",
						name = L["Disarm"]
					},
					Root = {
						type = "toggle",
						name = L["Root"]
					},
					Snare = {
						type = "toggle",
						name = L["Snare"]
					}
				}
			}
		}
	}
	return config
end

-- Interrupt Tracker
local function InterruptTrackerOptions()
	local config = {
		order = 12,
		type = "group",
		name = L["Interrupt Tracker"],
		get = function(info) return E.db.enhanced.interruptTracker[ info[#info] ] end,
		set = function(info, value) E.db.enhanced.interruptTracker[ info[#info] ] = value E:GetModule("Enhanced_InterruptTracker"):UpdateAllIconsTimers() end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Interrupt Tracker"])
			},
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				get = function(info) return E.db.enhanced.interruptTracker.enable end,
				set = function(info, value) E.db.enhanced.interruptTracker.enable = value E:StaticPopup_Show("PRIVATE_RL") end
			},
			size = {
				order = 2,
				name = L["Size"],
				type = "range",
				min = 10, max = 120, step = 1,
				disabled = function() return not E.db.enhanced.interruptTracker.enable end,
			},
			textGroup = {
				order = 300,
				type = "group",
				name = L["Text"],
				guiInline = true,
				get = function(info) return E.db.enhanced.interruptTracker.text[ info[#info] ] end,
				set = function(info, value) E.db.enhanced.interruptTracker.text[ info[#info] ] = value E:GetModule("Enhanced_InterruptTracker"):UpdateAllIconsTimers() end,
				disabled = function() return not E.db.enhanced.interruptTracker.enable end,
				args = {
					position = {
						type = "select",
						order = 2,
						name = L["Text Position"],
						values =  {
							TOPLEFT = "TOPLEFT",
							LEFT = "LEFT",
							BOTTOMLEFT = "BOTTOMLEFT",
							RIGHT = "RIGHT",
							TOPRIGHT = "TOPRIGHT",
							BOTTOMRIGHT = "BOTTOMRIGHT",
							CENTER = "CENTER",
							TOP = "TOP",
							BOTTOM = "BOTTOM",
						}
					},
					xOffset = {
						order = 3,
						type = "range",
						name = L["Text xOffset"],
						desc = L["Offset position for text."],
						min = -300, max = 300, step = 1,
					},
					yOffset = {
						order = 4,
						type = "range",
						name = L["Text yOffset"],
						desc = L["Offset position for text."],
						min = -300, max = 300, step = 1
					},
					font = {
						type = "select", dialogControl = "LSM30_Font",
						order = 5,
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font,
					},
					fontSize = {
						order = 6,
						name = L["Font Size"],
						type = "range",
						min = 6, max = 32, step = 1,
					},
					fontOutline = {
						order = 7,
						name = L["Font Outline"],
						desc = L["Set the font outline."],
						type = "select",
						values = {
							["NONE"] = L["None"],
							["OUTLINE"] = "OUTLINE",
							["MONOCHROME"] = (not E.isMacClient) and "MONOCHROME" or nil,
							["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE"
						}
					}
				}
			}
		}
	}
	return config
end

-- Timer Tracker
local function TimerTrackerOptions()
	local config = {
		order = 13,
		type = "group",
		name = L["Timer Tracker"],
		get = function(info) return E.db.enhanced.timerTracker[ info[#info] ] end,
		set = function(info, value) E.db.enhanced.timerTracker[ info[#info] ] = value E:GetModule("Enhanced_TimerTracker"):UpdateAllIconsTimers() end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = ColorizeSettingName(L["Timer Tracker"])
			},
			enable = {
				order = 1,
				type = "toggle",
				name = L["Enable"],
				get = function(info) return E.db.enhanced.timerTracker.enable end,
				set = function(info, value) E.db.enhanced.timerTracker.enable = value E:StaticPopup_Show("PRIVATE_RL") end
			},
			dbm = {
				order = 2,
				type = "toggle",
				name = L["Hook DBM"],
				get = function(info) return E.db.enhanced.timerTracker.dbm end,
				set = function(info, value) E.db.enhanced.timerTracker.dbm = value E:GetModule("Enhanced_TimerTracker"):HookDBM() end,
				disabled = function() return not E.db.enhanced.timerTracker.enable end
			}
		}
	}
	return config
end

-- Unitframes
local function UnitFrameOptions()
	local TC = E:GetModule("Enhanced_TargetClass")

	local config = {
		order = 14,
		type = "group",
		name = L["UnitFrames"],
		childGroups = "tab",
		args = {
			header = {
				order = 1,
				type = "header",
				name = ColorizeSettingName(L["UnitFrames"])
			},
			general = {
				order = 2,
				type = "group",
				name = L["General"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["General"]
					},
					hideRoleInCombat = {
						order = 2,
						type = "toggle",
						name = L["Hide Role Icon in combat"],
						desc = L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."],
						get = function(info) return E.db.enhanced.unitframe.hideRoleInCombat end,
						set = function(info, value) E.db.enhanced.unitframe.hideRoleInCombat = value E:StaticPopup_Show("PRIVATE_RL") end
					},
					portraitHDModelFix = {
						order = 3,
						type = "group",
						guiInline = true,
						name = L["Portrait HD Fix"],
						get = function(info) return E.db.enhanced.unitframe.portraitHDModelFix[info[#info]] end,
						set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix[info[#info]] = value end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix.enable = value E:GetModule("Enhanced_PortraitHDModelFix"):ToggleState() end
							},
							debug = {
								order = 2,
								type = "toggle",
								name = L["Debug"],
								desc = L["Print to chat model names of units with enabled 3D portraits."],
								set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix.debug = value end,
								disabled = function() return not E.db.enhanced.unitframe.portraitHDModelFix.enable end
							},
							modelsToFix = {
								order = 3,
								type = "input",
								name = L["Models to fix"],
								desc = L["List of models with broken portrait camera. Separete each model name with \"\" simbol"],
								width = "full",
								multiline = true,
								set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix.modelsToFix = value E:GetModule("Enhanced_PortraitHDModelFix"):UpdatePortraits() end,
								disabled = function() return not E.db.enhanced.unitframe.portraitHDModelFix.enable end
							}
						}
					}
				}
			},
			player = {
				order = 3,
				type = "group",
				name = L["Player"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Player"]
					},
					animatedLoss = {
						order = 2,
						type = "group",
						name = L["Animated Loss"],
						get = function(info) return E.db.unitframe.units["player"]["animatedLoss"][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units["player"]["animatedLoss"][ info[#info] ] = value E:GetModule("UnitFrames"):CreateAndUpdateUF("player") end,
						args = {
							header = {
								order = 1,
								type = "header",
								name = L["Animated Loss"]
							},
							enable = {
								order = 2,
								type = "toggle",
								name = L["Enable"]
							},
							spacer = {
								order = 3,
								type = "description",
								name = " "
							},
							duration = {
								order = 4,
								type = "range",
								name = L["Duration"],
								min = 0.01, max = 1.50, step = 0.01,
								disabled = function() return not E.db.unitframe.units.player.animatedLoss.enable end
							},
							startDelay = {
								order = 5,
								type = "range",
								name = L["Start Delay"],
								min = 0.01, max = 1.00, step = 0.01,
								disabled = function() return not E.db.unitframe.units.player.animatedLoss.enable end
							},
							pauseDelay = {
								order = 6,
								type = "range",
								name = L["Pause Delay"],
								min = 0.01, max = 0.30, step = 0.01,
								disabled = function() return not E.db.unitframe.units.player.animatedLoss.enable end
							},
							postponeDelay = {
								order = 7,
								type = "range",
								name = L["Postpone Delay"],
								min = 0.01, max = 0.30, step = 0.01,
								disabled = function() return not E.db.unitframe.units.player.animatedLoss.enable end
							}
						}
					},
					detachPortrait = {
						order = 3,
						type = "group",
						name = L["Portrait"],
						get = function(info) return E.db.unitframe.units["player"]["portrait"][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units["player"]["portrait"][ info[#info] ] = value E:GetModule("UnitFrames"):CreateAndUpdateUF("player") end,
						args = {
							header = {
								order = 1,
								type = "header",
								name = L["Portrait"]
							},
							detachFromFrame = {
								order = 2,
								type = "toggle",
								name = L["Detach From Frame"],
								disabled = function() return not E.db.unitframe.units.player.portrait.enable end
							},
							spacer = {
								order = 3,
								type = "description",
								name = " "
							},
							detachedWidth = {
								order = 4,
								type = "range",
								name = L["Detached Width"],
								min = 10, max = 600, step = 1,
								disabled = function() return not E.db.unitframe.units.player.portrait.enable end
							},
							detachedHeight = {
								order = 5,
								type = "range",
								name = L["Detached Height"],
								min = 10, max = 600, step = 1,
								disabled = function() return not E.db.unitframe.units.player.portrait.enable end
							}
						}
					}
				}
			},
			target = {
				order = 4,
				type = "group",
				name = L["Target"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Target"]
					},
					classIcon = {
						order = 2,
						type = "group",
						name = L["Class Icons"],
						args = {
							header = {
								order = 0,
								type = "header",
								name = L["Class Icons"]
							},
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								desc = L["Show class icon for units."],
								get = function(info) return E.db.enhanced.unitframe.units.target.classicon.enable end,
								set = function(info, value) E.db.enhanced.unitframe.units.target.classicon.enable = value TC:ToggleSettings() end
							},
							spacer = {
								order = 2,
								type = "description",
								name = " "
							},
							size = {
								order = 3,
								type = "range",
								name = L["Size"],
								desc = L["Size of the indicator icon."],
								min = 16, max = 40, step = 1,
								get = function(info) return E.db.enhanced.unitframe.units.target.classicon.size end,
								set = function(info, value) E.db.enhanced.unitframe.units.target.classicon.size = value TC:ToggleSettings() end,
								disabled = function() return not E.db.enhanced.unitframe.units.target.classicon.enable end
							},
							xOffset = {
								order = 4,
								type = "range",
								name = L["xOffset"],
								min = -100, max = 100, step = 1,
								get = function(info) return E.db.enhanced.unitframe.units.target.classicon.xOffset end,
								set = function(info, value) E.db.enhanced.unitframe.units.target.classicon.xOffset = value TC:ToggleSettings() end,
								disabled = function() return not E.db.enhanced.unitframe.units.target.classicon.enable end
							},
							yOffset = {
								order = 5,
								type = "range",
								name = L["yOffset"],
								min = -80, max = 40, step = 1,
								get = function(info) return E.db.enhanced.unitframe.units.target.classicon.yOffset end,
								set = function(info, value) E.db.enhanced.unitframe.units.target.classicon.yOffset = value TC:ToggleSettings() end,
								disabled = function() return not E.db.enhanced.unitframe.units.target.classicon.enable end
							}
						}
					},
					detachPortrait = {
						order = 3,
						type = "group",
						name = L["Portrait"],
						get = function(info) return E.db.unitframe.units["target"]["portrait"][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units["target"]["portrait"][ info[#info] ] = value E:GetModule("UnitFrames"):CreateAndUpdateUF("target") end,
						args = {
							header = {
								order = 1,
								type = "header",
								name = L["Portrait"]
							},
							detachFromFrame = {
								order = 2,
								type = "toggle",
								name = L["Detach From Frame"],
								disabled = function() return not E.db.unitframe.units.target.portrait.enable end
							},
							spacer = {
								order = 3,
								type = "description",
								name = " "
							},
							detachedWidth = {
								order = 4,
								type = "range",
								name = L["Detached Width"],
								min = 10, max = 600, step = 1,
								disabled = function() return not E.db.unitframe.units.target.portrait.enable end
							},
							detachedHeight = {
								order = 5,
								type = "range",
								name = L["Detached Height"],
								min = 10, max = 600, step = 1,
								disabled = function() return not E.db.unitframe.units.target.portrait.enable end
							}
						}
					}
				}
			}
		}
	}
	return config
end

function addon:GetOptions()
	E.Options.args.enhanced = {
		order = 50,
		type = "group",
		childGroups = "tab",
		name = ColorizeSettingName("Enhanced"),
		args = {
			generalGroup = GeneralOptions(),
			actionbarGroup = ActionbarOptions(),
			chatGroup = ChatOptions(),
			characterFrameGroup = CharacterFrameOptions(),
			datatextsGroup = DataTextsOptions(),
			minimapGroup = MinimapOptions(),
			namePlatesGroup = NamePlatesOptions(),
			skinsGroup = SkinsOptions(),
			tooltipGroup = TooltipOptions(),
			unitframesGroup = UnitFrameOptions(),
			loseControlGroup = LoseControlOptions(),
			interruptGroup = InterruptTrackerOptions(),
			timerGroup = TimerTrackerOptions(),
			watchFrameGroup = WatchFrameOptions(),
		}
	}
end