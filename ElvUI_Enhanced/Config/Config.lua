local E, L, V, P, G = unpack(ElvUI)
local EE = E:GetModule("ElvUI_Enhanced")

local function GeneralOptions()
	local M = E:GetModule("Enhanced_Misc")

	return {
		type = "group",
		name = L["General"],
		get = function(info) return E.db.enhanced.general[info[#info]] end,
		args = {
			header = {
				order = 1,
				type = "header",
				name = EE:ColorizeSettingName(L["General"])
			},
			pvpAutoRelease = {
				type = "toggle",
				name = L["PvP Autorelease"],
				desc = L["Automatically release body when killed inside a battleground."],
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					M:AutoRelease()
				end
			},
			autoRepChange = {
				type = "toggle",
				name = L["Track Reputation"],
				desc = L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."],
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					M:WatchedFaction()
				end
			},
			selectQuestReward = {
				type = "toggle",
				name = L["Select Quest Reward"],
				desc = L["Automatically select the quest reward with the highest vendor sell value."],
				get = function(info) return E.private.general[info[#info]] end,
				set = function(info, value)
					E.private.general[info[#info]] = value
					M:ToggleQuestReward()
				end
			},
			declineduel = {
				type = "toggle",
				name = L["Decline Duel"],
				desc = L["Auto decline all duels"],
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					M:DeclineDuel()
				end
			},
			hideZoneText = {
				type = "toggle",
				name = L["Hide Zone Text"],
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					M:HideZone()
				end
			},
			alreadyKnown = {
				type = "toggle",
				name = L["Already Known"],
				desc = L["Change color of item icons which already known."],
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					E:GetModule("Enhanced_AlreadyKnown"):ToggleState()
				end
			},
			altBuyMaxStack = {
				type = "toggle",
				name = L["Alt-Click Merchant"],
				desc = L["Holding Alt key while buying something from vendor will now buy an entire stack."],
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					M:BuyStackToggle()
				end
			},
			trainAllSkills = {
				type = "toggle",
				name = L["Train All Button"],
				desc = L["Add button to Trainer frame with ability to train all available skills in one click."],
				set = function(info, value)
					E.db.enhanced.general.trainAllSkills = value
					E:GetModule("Enhanced_TrainAll"):ToggleState()
				end
			},
			showQuestLevel = {
				type = "toggle",
				name = L["Show Quest Level"],
				desc = L["Display quest levels at Quest Log."],
				set = function(info, value)
					E.db.enhanced.general.showQuestLevel = value
					M:QuestLevelToggle()
				end
			},
			dpsLinks = {
				type = "toggle",
				name = L["Filter DPS meters Spam"],
				desc = L["Replaces reports from damage meters with a clickable hyperlink to reduce chat spam"],
				get = function(info) return E.db.enhanced.chat.dpsLinks end,
				set = function(info, value)
					E.db.enhanced.chat.dpsLinks = value
					E:GetModule("Enhanced_DPSLinks"):UpdateSettings()
				end
			},
			moverTransparancy = {
				order = -2,
				type = "range",
				isPercent = true,
				name = L["Mover Transparency"],
				desc = L["Changes the transparency of all the movers."],
				min = 0, max = 1, step = 0.01,
				set = function(info, value)
					E.db.enhanced.general[info[#info]] = value
					M:UpdateMoverTransparancy()
				end
			}
		}
	}
end

local function ActionbarOptions()
	local KPA = E:GetModule("Enhanced_KeyPressAnimation")

	return {
		type = "group",
		name = L["ActionBars"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["ActionBars"])
			},
			keyPressAnimation = {
				order = 1,
				type = "group",
				name = L["Key Press Animation"],
				guiInline = true,
				get = function(info) return E.db.enhanced.actionbar.keyPressAnimation[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.actionbar.keyPressAnimation[info[#info]] = value
					KPA:UpdateSetting()
				end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						get = function(info) return E.private.enhanced.actionbar.keyPressAnimation end,
						set = function(info, value)
							E.private.enhanced.actionbar.keyPressAnimation = value
							E:StaticPopup_Show("PRIVATE_RL")
						end,
					},
					color = {
						order = 2,
						type = "color",
						name = L["COLOR"],
						get = function(info)
							local t = E.db.enhanced.actionbar.keyPressAnimation[info[#info]]
							local d = P.enhanced.actionbar.keyPressAnimation[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
						end,
						set = function(info, r, g, b)
							local t = E.db.enhanced.actionbar.keyPressAnimation[info[#info]]
							t.r, t.g, t.b = r, g, b
							KPA:UpdateSetting()
						end,
						disabled = function() return not E.private.enhanced.actionbar.keyPressAnimation end,
					},
					scale = {
						order = 3,
						type = "range",
						min = 1, max = 3, step = 0.1,
						isPercent = true,
						name = L["Scale"],
						disabled = function() return not E.private.enhanced.actionbar.keyPressAnimation end,
					},
					rotation = {
						order = 4,
						type = "range",
						min = 0, max = 360, step = 1,
						name = L["Rotation"],
						disabled = function() return not E.private.enhanced.actionbar.keyPressAnimation end,
					},
				}
			}
		}
	}
end

local function BlizzardOptions()
	local B = E:GetModule("Enhanced_Blizzard")
	local WF = E:GetModule("Enhanced_WatchFrame")
	local TAM = E:GetModule("Enhanced_TakeAllMail")
	local CHAR = E:GetModule("Enhanced_CharacterFrame")

	local choices = {
		["NONE"] = L["NONE"],
		["COLLAPSED"] = L["Collapsed"],
		["HIDDEN"] = L["Hidden"]
	}

	return {
		type = "group",
		childGroups = "tree",
		name = L["BlizzUI Improvements"],
		get = function(info) return E.private.enhanced[info[#info]] end,
		set = function(info, value)
			E.private.enhanced[info[#info]] = value
			E:StaticPopup_Show("PRIVATE_RL")
		end,
		args = {
			header = {
				order = 1,
				type = "header",
				name = EE:ColorizeSettingName(L["BlizzUI Improvements"])
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
					deathRecap = {
						order = 2,
						type = "toggle",
						name = L["Death Recap Frame"]
					},
					takeAllMail = {
						order = 3,
						type = "toggle",
						name = L["Take All Mail"],
						get = function(info) return E.db.enhanced.blizzard.takeAllMail end,
						set = function(info, value)
							E.db.enhanced.blizzard.takeAllMail = value
							if value and not TAM.initialized then
								TAM:Initialize()
							elseif not value then
								E:StaticPopup_Show("CONFIG_RL")
							end
						end
					},
					animatedAchievementBars = {
						order = 4,
						type = "toggle",
						name = L["Animated Achievement Bars"]
					}
				}
			},
			characterFrame = {
				order = 3,
				type = "group",
				name = L["Character Frame"],
				get = function(info) return E.private.enhanced.character[info[#info]] end,
				set = function(info, value)
					E.private.enhanced.character[info[#info]] = value
					E:StaticPopup_Show("PRIVATE_RL")
				end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Character Frame"]
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enhanced Character Frame"]
					},
					modelFrames = {
						order = 3,
						type = "toggle",
						name = L["Enhanced Model Frames"]
					},
					animations = {
						order = 4,
						type = "toggle",
						name = L["Smooth Animations"],
						get = function(info) return E.db.enhanced.character.animations end,
						set = function(info, value)
							E.db.enhanced.character.animations = value
							E:StaticPopup_Show("PRIVATE_RL")
						end,
						disabled = function() return not E.private.enhanced.character.enable end
					},
					paperdollBackgrounds = {
						order = 5,
						type = "group",
						name = L["Paperdoll Backgrounds"],
						guiInline = true,
						get = function(info) return E.db.enhanced.character[info[#info]] end,
						disabled = function() return not E.private.enhanced.character.enable end,
						args = {
							characterBackground = {
								order = 1,
								type = "toggle",
								name = L["Character Background"],
								set = function(info, value)
									E.db.enhanced.character.characterBackground = value
									CHAR:UpdateCharacterModelFrame()
								end
							},
							desaturateCharacter = {
								order = 2,
								type = "toggle",
								name = L["Desaturate"],
								get = function(info) return E.db.enhanced.character.desaturateCharacter end,
								set = function(info, value)
									E.db.enhanced.character.desaturateCharacter = value
									CHAR:UpdateCharacterModelFrame()
								end,
								disabled = function() return not E.private.enhanced.character.enable or not E.db.enhanced.character.characterBackground end
							},
							spacer = {
								order = 3,
								type = "description",
								name = " "
							},
							petBackground = {
								order = 4,
								type = "toggle",
								name = L["Pet Background"],
								set = function(info, value)
									E.db.enhanced.character.petBackground = value
									CHAR:UpdatePetModelFrame()
								end
							},
							desaturatePet = {
								order = 5,
								type = "toggle",
								name = L["Desaturate"],
								get = function(info) return E.db.enhanced.character.desaturatePet end,
								set = function(info, value)
									E.db.enhanced.character.desaturatePet = value
									CHAR:UpdatePetModelFrame()
								end,
								disabled = function() return not E.private.enhanced.character.enable or not E.db.enhanced.character.petBackground end
							},
							spacer2 = {
								order = 6,
								type = "description",
								name = " "
							},
							inspectBackground = {
								order = 6,
								type = "toggle",
								name = L["Inspect Background"],
								set = function(info, value)
									E.db.enhanced.character.inspectBackground = value
									CHAR:UpdateInspectModelFrame()
								end
							},
							desaturateInspect = {
								order = 8,
								type = "toggle",
								name = L["Desaturate"],
								get = function(info) return E.db.enhanced.character.desaturateInspect end,
								set = function(info, value)
									E.db.enhanced.character.desaturateInspect = value
									CHAR:UpdateInspectModelFrame()
								end,
								disabled = function() return not E.private.enhanced.character.enable or not E.db.enhanced.character.inspectBackground end
							},
							spacer3 = {
								order = 9,
								type = "description",
								name = " "
							},
							companionBackground = {
								order = 10,
								type = "toggle",
								name = L["Companion Background"],
								set = function(info, value)
									E.db.enhanced.character.companionBackground = value
									CHAR:UpdateCompanionModelFrame()
								end
							},
							desaturateCompanion = {
								order = 11,
								type = "toggle",
								name = L["Desaturate"],
								get = function(info) return E.db.enhanced.character.desaturateCompanion end,
								set = function(info, value)
									E.db.enhanced.character.desaturateCompanion = value
									CHAR:UpdateCompanionModelFrame()
								end,
								disabled = function() return not E.private.enhanced.character.enable or not E.db.enhanced.character.companionBackground end
							}
						}
					}
				}
			},
			dressingRoom = {
				order = 4,
				type = "group",
				name = L["Dressing Room"],
				get = function(info) return E.db.enhanced.blizzard.dressUpFrame[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.blizzard.dressUpFrame[info[#info]] = value
					E:GetModule("Enhanced_Blizzard"):UpdateDressUpFrame()
				end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Dressing Room"],
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value)
							E.db.enhanced.blizzard.dressUpFrame[info[#info]] = value
							E:StaticPopup_Show("PRIVATE_RL")
						end,
					},
					multiplier = {
						order = 3,
						type = "range",
						min = 1, max = 2, step = 0.01,
						isPercent = true,
						name = L["Scale"],
						disabled = function() return not E.db.enhanced.blizzard.dressUpFrame.enable end
					},
					undressButton = {
						order = 4,
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
			timerTracker = {
				order = 5,
				type = "group",
				name = L["Timer Tracker"],
				get = function(info) return E.db.enhanced.timerTracker[info[#info]] end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Timer Tracker"]
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value)
							E.db.enhanced.timerTracker.enable = value
							E:GetModule("Enhanced_TimerTracker"):ToggleState()
						end
					},
					dbm = {
						order = 3,
						type = "toggle",
						name = L["Hook DBM"],
						set = function(info, value)
							E.db.enhanced.timerTracker.dbm = value
							E:GetModule("Enhanced_TimerTracker"):HookDBM()
						end,
						disabled = function() return not E.db.enhanced.timerTracker.enable end
					}
				}
			},
			watchframe = {
				order = 6,
				type = "group",
				name = L["Watch Frame"],
				get = function(info) return E.db.enhanced.watchframe[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.watchframe[info[#info]] = value
					WF:UpdateSettings()
				end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Watch Frame"],
					},
					intro = {
						order = 2,
						type = "description",
						name = L["WATCHFRAME_DESC"]
					},
					enable = {
						order = 3,
						type = "toggle",
						name = L["Enable"]
					},
					settings = {
						order = 4,
						type = "group",
						name = L["Visibility State"],
						guiInline = true,
						get = function(info) return E.db.enhanced.watchframe[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.watchframe[info[#info]] = value
							WF:ChangeState()
						end,
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
			},
			errorFrame = {
				order = 7,
				type = "group",
				name = L["Error Frame"],
				get = function(info) return E.db.enhanced.blizzard.errorFrame[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.blizzard.errorFrame[info[#info]] = value
					B:ErrorFrameSize()
				end,
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Error Frame"]
					},
					enable = {
						order = 2,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value)
							E.db.enhanced.blizzard.errorFrame[info[#info]] = value
							B:CustomErrorFrameToggle()
						end
					},
					width = {
						order = 3,
						type = "range",
						min = 100, max = 1000, step = 1,
						name = L["Width"],
						desc = L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"],
						disabled = function() return not E.db.enhanced.blizzard.errorFrame.enable end
					},
					height = {
						order = 4,
						type = "range",
						min = 30, max = 300, step = 1,
						name = L["Height"],
						desc = L["Set the height of Error Frame. Higher frame can show more lines at once."],
						disabled = function() return not E.db.enhanced.blizzard.errorFrame.enable end
					},
					spacer = {
						order = 5,
						type = "description",
						name = " "
					},
					font = {
						order = 6,
						type = "select",
						dialogControl = "LSM30_Font",
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font,
						disabled = function() return not E.db.enhanced.blizzard.errorFrame.enable end
					},
					fontSize = {
						order = 7,
						type = "range",
						min = 6, max = 36, step = 1,
						name = L["FONT_SIZE"],
						disabled = function() return not E.db.enhanced.blizzard.errorFrame.enable end
					},
					fontOutline = {
						order = 8,
						type = "select",
						name = L["Font Outline"],
						values = {
							["NONE"] = L["NONE"],
							["OUTLINE"] = "OUTLINE",
							["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE"
						},
						disabled = function() return not E.db.enhanced.blizzard.errorFrame.enable end
					}
				}
			}
		}
	}
end

local function EquipmentInfoOptions()
	local EI = E:GetModule("Enhanced_EquipmentInfo")

	return {
		type = "group",
		name = L["Equipment Info"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = EE:ColorizeSettingName(L["Equipment Info"])
			},
			enable = {
				order = 2,
				type = "toggle",
				width = "full",
				name = L["Enable"],
				get = function(info) return E.db.enhanced.equipment[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment[info[#info]] = value
					EI:ToggleState()
				end,
			},
			itemlevel = {
				order = 3,
				type = "group",
				guiInline = true,
				name = L["Item Level"],
				get = function(info) return E.db.enhanced.equipment.itemlevel[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment.itemlevel[info[#info]] = value
					EI:UpdateText()
				end,
				disabled = function() return not (E.db.enhanced.equipment.enable and E.db.enhanced.equipment.itemlevel.enable) end,
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
						desc = L["Enable/Disable the display of item levels on the character screen."],
						disabled = function() return not E.db.enhanced.equipment.enable end,
					},
					qualityColor = {
						order = 3,
						type = "toggle",
						name = L["Quality Color"]
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
						set = function(info, value)
							E.db.enhanced.equipment.itemlevel[info[#info]] = value
							EI:UpdateTextSettings()
						end
					},
					xOffset = {
						order = 6,
						type = "range",
						min = -50, max = 50, step = 1,
						name = L["X-Offset"],
						set = function(info, value)
							E.db.enhanced.equipment.itemlevel[info[#info]] = value
							EI:UpdateTextSettings()
						end
					},
					yOffset = {
						order = 7,
						type = "range",
						min = -50, max = 50, step = 1,
						name = L["Y-Offset"],
						set = function(info, value)
							E.db.enhanced.equipment.itemlevel[info[#info]] = value
							EI:UpdateTextSettings()
						end
					}
				}
			},
			durability = {
				order = 4,
				type = "group",
				name = DURABILITY,
				guiInline = true,
				get = function(info) return E.db.enhanced.equipment.durability[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment.durability[info[#info]] = value
					EI:UpdateText()
				end,
				disabled = function() return not (E.db.enhanced.equipment.enable and E.db.enhanced.equipment.durability.enable) end,
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
						desc = L["Enable/Disable the display of durability information on the character screen."],
						disabled = function() return not E.db.enhanced.equipment.enable end,
					},
					onlydamaged = {
						order = 3,
						type = "toggle",
						name = L["Damaged Only"],
						desc = L["Only show durabitlity information for items that are damaged."],
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
						set = function(info, value)
							E.db.enhanced.equipment.durability[info[#info]] = value
							EI:UpdateTextSettings()
						end
					},
					xOffset = {
						order = 6,
						type = "range",
						min = -50, max = 50, step = 1,
						name = L["X-Offset"],
						set = function(info, value)
							E.db.enhanced.equipment.durability[info[#info]] = value
							EI:UpdateTextSettings()
						end
					},
					yOffset = {
						order = 7,
						type = "range",
						min = -50, max = 50, step = 1,
						name = L["Y-Offset"],
						set = function(info, value)
							E.db.enhanced.equipment.durability[info[#info]] = value
							EI:UpdateTextSettings()
						end
					}
				}
			},
			fontGroup = {
				order = 5,
				type = "group",
				guiInline = true,
				name = L["Font"],
				get = function(info) return E.db.enhanced.equipment[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.equipment[info[#info]] = value
					EI:UpdateTextSettings()
				end,
				disabled = function() return not E.db.enhanced.equipment.enable end,
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
						min = 6, max = 36, step = 1,
						name = L["FONT_SIZE"]
					},
					fontOutline = {
						order = 3,
						type = "select",
						name = L["Font Outline"],
						values = {
							["NONE"] = L["NONE"],
							["OUTLINE"] = "OUTLINE",
							["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE"
						}
					}
				}
			}
		}
	}
end

local function MapOptions()
	local MFC = E:GetModule("Enhanced_FogClear")

	return {
		type = "group",
		name = L["Map"],
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["Map"])
			},
			fogClear ={
				type = "group",
				name = L["Fog of War"],
				guiInline = true,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						get = function(info) return E.db.enhanced.map.fogClear.enable end,
						set = function(info, value)
							E.db.enhanced.map.fogClear.enable = value
							MFC:UpdateFog()
						end
					},
					overlay = {
						order = 2,
						type = "color",
						name = L["Overlay Color"],
						hasAlpha = true,
						get = function(info)
							local t = E.db.enhanced.map.fogClear.color
							local d = E.db.enhanced.map.fogClear.color
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a
						end,
						set = function(_, r, g, b, a)
							local color = E.db.enhanced.map.fogClear.color
							color.r, color.g, color.b, color.a = r, g, b, a
							MFC:UpdateWorldMapOverlays()
						end,
						disabled = function() return not E.db.enhanced.map.fogClear.enable end
					}
				}
			}
		}
	}
end

local function MinimapOptions()
	E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText.values = {
		["MOUSEOVER"] = L["Minimap Mouseover"],
		["SHOW"] = L["Always Display"],
		["ABOVE"] = EE:ColorizeSettingName(L["Above Minimap"]),
		["HIDE"] = L["HIDE"]
	}

	local MBG = E:GetModule("Enhanced_MinimapButtonGrabber")

	return {
		type = "group",
		name = L["Minimap"],
		get = function(info) return E.db.enhanced.minimap[info[#info]] end,
		set = function(info, value)
			E.db.enhanced.minimap[info[#info]] = value
			E:GetModule("Enhanced_MinimapLocation"):UpdateSettings()
		end,
		disabled = function() return not E.private.general.minimap.enable end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["Minimap"])
			},
			location = {
				order = 1,
				type = "toggle",
				name = L["Location Panel"],
				desc = L["Toggle Location Panel."]
			},
			locationText = E.Options.args.maps.args.minimap.args.locationTextGroup.args.locationText,
			showlocationdigits = {
				order = 2,
				type = "toggle",
				name = L["Show Location Digits"],
				desc = L["Toggle Location Digits."],
				disabled = function() return not (E.db.enhanced.minimap.location and E.db.general.minimap.locationText == "ABOVE") end
			},
			locationdigits = {
				order = 3,
				type = "range",
				name = L["Location Digits"],
				desc = L["Number of digits for map location."],
				min = 0, max = 2, step = 1,
				set = function(info, value)
					E.db.enhanced.minimap[info[#info]] = value
					E:GetModule("Minimap"):UpdateSettings()
				end,
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
			},
			minimapButtons = {
				order = 5,
				type = "group",
				name = L["Minimap Button Grabber"],
				guiInline = true,
				get = function(info) return E.db.enhanced.minimap.buttonGrabber[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.minimap.buttonGrabber[info[#info]] = value
					MBG:UpdateLayout()
				end,
				disabled = function() return not E.private.enhanced.minimapButtonGrabber end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						get = function(info) return E.private.enhanced.minimapButtonGrabber end,
						set = function(info, value)
							E.private.enhanced.minimapButtonGrabber = value
							if value and not MBG.initialized then
								MBG:Initialize()
							elseif not value then
								E:StaticPopup_Show("PRIVATE_RL")
							end
						end,
						disabled = false
					},
					spacer = {
						order = 2,
						type = "description",
						name = " ",
						width = "full"
					},
					growFrom = {
						order = 3,
						type = "select",
						name = L["Grow direction"],
						values = {
							["TOPLEFT"] = "DOWN -> RIGHT",
							["TOPRIGHT"] = "DOWN -> LEFT",
							["BOTTOMLEFT"] = "UP -> RIGHT",
							["BOTTOMRIGHT"] = "UP -> LEFT"
						}
					},
					buttonsPerRow = {
						order = 4,
						type = "range",
						name = L["Buttons Per Row"],
						desc = L["The amount of buttons to display per row."],
						min = 1, max = 12, step = 1
					},
					buttonSize = {
						order = 5,
						type = "range",
						name = L["Button Size"],
						min = 2, max = 60, step = 1
					},
					buttonSpacing = {
						order = 6,
						type = "range",
						name = L["Button Spacing"],
						desc = L["The spacing between buttons."],
						min = -1, max = 24, step = 1
					},
					backdrop = {
						order = 7,
						type = "toggle",
						name = L["Backdrop"]
					},
					backdropSpacing = {
						order = 8,
						type = "range",
						name = L["Backdrop Spacing"],
						desc = L["The spacing between the backdrop and the buttons."],
						min = -1, max = 15, step = 1,
						disabled = function() return not E.private.enhanced.minimapButtonGrabber or not E.db.enhanced.minimap.buttonGrabber.backdrop end,
					},
					mouseover = {
						order = 9,
						type = "toggle",
						name = L["Mouse Over"],
						desc = L["The frame is not shown unless you mouse over the frame."],
						set = function(info, value)
							E.db.enhanced.minimap.buttonGrabber[info[#info]] = value
							MBG:ToggleMouseover()
						end
					},
					alpha = {
						order = 10,
						type = "range",
						name = L["Alpha"],
						min = 0, max = 1, step = 0.01,
						set = function(info, value)
							E.db.enhanced.minimap.buttonGrabber[info[#info]] = value
							MBG:UpdateAlpha()
						end
					},
					insideMinimapGroup = {
						order = 11,
						type = "group",
						name = L["Inside Minimap"],
						guiInline = true,
						get = function(info) return E.db.enhanced.minimap.buttonGrabber.insideMinimap[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.minimap.buttonGrabber.insideMinimap[info[#info]] = value
							MBG:UpdatePosition()
						end,
						disabled = function() return not E.db.enhanced.minimap.buttonGrabber.insideMinimap.enable end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								disabled = function() return not E.private.enhanced.minimapButtonGrabber end
							},
							position = {
								order = 2,
								type = "select",
								name = L["Position"],
								values = {
									["TOPLEFT"] = "TOPLEFT",
									["LEFT"] = "LEFT",
									["BOTTOMLEFT"] = "BOTTOMLEFT",
									["RIGHT"] = "RIGHT",
									["TOPRIGHT"] = "TOPRIGHT",
									["BOTTOMRIGHT"] = "BOTTOMRIGHT",
									["CENTER"] = "CENTER",
									["TOP"] = "TOP",
									["BOTTOM"] = "BOTTOM"
								}
							},
							xOffset = {
								order = 3,
								type = "range",
								name = L["xOffset"],
								min = -20, max = 20, step = 1
							},
							yOffset = {
								order = 4,
								type = "range",
								name = L["yOffset"],
								min = -20, max = 20, step = 1
							}
						}
					}
				}
			}
		}
	}
end

local function NamePlatesOptions()
	return {
		type = "group",
		name = L["NamePlates"],
		get = function(info) return E.db.enhanced.nameplates[info[#info]] end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["NamePlates"])
			},
			classCache = {
				order = 1,
				type = "toggle",
				name = L["Cache Unit Class"],
				set = function(info, value)
					E.db.enhanced.nameplates[info[#info]] = value
					E:GetModule("Enhanced_NamePlates"):UpdateAllSettings()
				end
			},
			chatBubbles = {
				order = 2,
				type = "toggle",
				name = L["Chat Bubbles"],
				set = function(info, value)
					E.db.enhanced.nameplates[info[#info]] = value
					E:GetModule("Enhanced_NamePlates"):UpdateAllSettings()
					E:GetModule("NamePlates"):ConfigureAll()
				end
			},
			titleCacheGroup = {
				order = 3,
				type = "group",
				name = L["Cache Unit Guilds / NPC Titles"],
				guiInline = true,
				get = function(info) return E.db.enhanced.nameplates[info[#info]] end,
				args = {
					titleCache = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value)
							E.db.enhanced.nameplates[info[#info]] = value
							E:GetModule("Enhanced_NamePlates"):UpdateAllSettings()
							E:GetModule("NamePlates"):ConfigureAll()
						end
					},
					guildGroup = {
						order = 3,
						type = "group",
						name = L["Guild"],
						guiInline = true,
						get = function(info) return E.db.enhanced.nameplates.guild[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.nameplates.guild[info[#info]] = value
							E:GetModule("NamePlates"):ConfigureAll()
						end,
						disabled = function() return not E.db.enhanced.nameplates.titleCache end,
						args = {
							font = {
								order = 1,
								type = "select",
								dialogControl = "LSM30_Font",
								name = L["Font"],
								values = AceGUIWidgetLSMlists.font,
							},
							fontSize = {
								order = 2,
								type = "range",
								name = L["FONT_SIZE"],
								min = 4, max = 33, step = 1,
							},
							fontOutline = {
								order = 3,
								type = "select",
								name = L["Font Outline"],
								values = {
									["NONE"] = L["NONE"],
									["OUTLINE"] = "OUTLINE",
									["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE"
								}
							},
							separator = {
								order = 4,
								type = "select",
								name = L["Separator"],
								values = {
									[" "] = L["NONE"],
									["<"] = "< >",
									["("] = "( )",
									["["] = "[ ]",
									["{"] = "{ }"
								}
							},
							colorsGroup = {
								order = 5,
								type = "group",
								name = L["COLORS"],
								guiInline = true,
								get = function(info)
									local t = E.db.enhanced.nameplates.guild.colors[info[#info]]
									local d = P.enhanced.nameplates.guild.colors[info[#info]]
									return t.r, t.g, t.b, t.a, d.r, d.g, d.b
								end,
								set = function(info, r, g, b)
									local t = E.db.enhanced.nameplates.guild.colors[info[#info]]
									t.r, t.g, t.b = r, g, b
									E:GetModule("NamePlates"):ConfigureAll()
								end,
								args = {
									raid = {
										order = 1,
										type = "color",
										name = L["RAID"],
									},
									party = {
										order = 2,
										type = "color",
										name = L["PARTY"],
									},
									guild = {
										order = 3,
										type = "color",
										name = L["GUILD"],
									},
									none = {
										order = 4,
										type = "color",
										name = L["ALL"],
									},
								}
							},
							visabilityGroup = {
								order = 6,
								type = "group",
								name = L["Visibility State"],
								guiInline = true,
								get = function(info) return E.db.enhanced.nameplates.guild.visibility[info[#info]] end,
								set = function(info, value)
									E.db.enhanced.nameplates.guild.visibility[info[#info]] = value
									E:GetModule("NamePlates"):ConfigureAll()
								end,
								args = {
									city = {
										order = 1,
										type = "toggle",
										name = L["City (Resting)"]
									},
									pvp = {
										order = 2,
										type = "toggle",
										name = L["PvP"]
									},
									arena = {
										order = 3,
										type = "toggle",
										name = L["Arena"]
									},
									party = {
										order = 4,
										type = "toggle",
										name = L["Party"]
									},
									raid = {
										order = 5,
										type = "toggle",
										name = L["Raid"]
									}
								}
							}
						}
					},
					npcGroup = {
						order = 3,
						type = "group",
						name = L["NPC"],
						guiInline = true,
						get = function(info) return E.db.enhanced.nameplates.npc[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.nameplates.npc[info[#info]] = value
							E:GetModule("NamePlates"):ConfigureAll()
						end,
						disabled = function() return not E.db.enhanced.nameplates.titleCache end,
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
								name = L["FONT_SIZE"],
								min = 4, max = 33, step = 1
							},
							fontOutline = {
								order = 3,
								type = "select",
								name = L["Font Outline"],
								values = {
									["NONE"] = L["NONE"],
									["OUTLINE"] = "OUTLINE",
									["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE"
								}
							},
							reactionColor = {
								order = 4,
								type = "toggle",
								name = L["Reaction Color"],
								desc = L["Color based on reaction type."]
							},
							color = {
								order = 5,
								type = "color",
								name = L["COLOR"],
								get = function(info)
									local t = E.db.enhanced.nameplates.npc[info[#info]]
									local d = P.enhanced.nameplates.npc[info[#info]]
									return t.r, t.g, t.b, t.a, d.r, d.g, d.b
								end,
								set = function(info, r, g, b)
									local t = E.db.enhanced.nameplates.npc[info[#info]]
									t.r, t.g, t.b = r, g, b
									E:GetModule("NamePlates"):ConfigureAll()
								end,
								disabled = function() return E.db.enhanced.nameplates.npc.reactionColor end
							},
							separator = {
								order = 5,
								type = "select",
								name = L["Separator"],
								values = {
									[" "] = L["NONE"],
									["<"] = "< >",
									["("] = "( )"
								}
							}
						}
					}
				}
			}
		}
	}
end

local function TooltipOptions()
	local TI = E:GetModule("Enhanced_TooltipIcon")
	local PI = E:GetModule("Enhanced_ProgressionInfo")

	return {
		type = "group",
		name = L["Tooltip"],
		get = function(info) return E.db.enhanced.tooltip[info[#info]] end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["Tooltip"])
			},
			itemQualityBorderColor = {
				order = 1,
				type = "toggle",
				name = L["Item Border Color"],
				desc = L["Colorize the tooltip border based on item quality."],
				set = function(info, value)
					E.db.enhanced.tooltip.itemQualityBorderColor = value
					E:GetModule("Enhanced_ItemBorderColor"):ToggleState()
				end
			},
			tooltipIcon = {
				order = 2,
				type = "group",
				name = L["Tooltip Icon"],
				guiInline = true,
				get = function(info) return E.db.enhanced.tooltip.tooltipIcon[info[#info]] end,
				args = {
					tooltipIcon = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Show/Hides an Icon for Spells and Items on the Tooltip."],
						get = function(info) return E.db.enhanced.tooltip.tooltipIcon.enable end,
						set = function(info, value)
							E.db.enhanced.tooltip.tooltipIcon.enable = value
							TI:ToggleItemsState()
							TI:ToggleSpellsState()
							TI:ToggleAchievementsState()
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
							TI:ToggleSpellsState()
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
							TI:ToggleItemsState()
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
							TI:ToggleAchievementsState()
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
				disabled = function() return not E.db.enhanced.tooltip.progressInfo.enable end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						set = function(info, value)
							E.db.enhanced.tooltip.progressInfo[info[#info]] = value
							PI:ToggleState()
						end,
						disabled = false
					},
					checkAchievements = {
						order = 2,
						type = "toggle",
						name = L["Check Achievements"],
						desc = L["Check achievement completion instead of boss kill stats.\nSome servers log incorrect boss kill statistics, this is an alternative way to get player progress."]
					},
					checkPlayer = {
						order = 3,
						type = "toggle",
						name = L["Check Player"]
					},
					modifier = {
						order = 4,
						type = "select",
						name = L["Visibility"],
						set = function(info, value)
							E.db.enhanced.tooltip.progressInfo[info[#info]] = value
							PI:UpdateModifier()
						end,
						values = {
							["ALL"] = ALWAYS,
							["SHIFT"] = L["SHIFT_KEY"],
							["ALT"] = L["ALT_KEY"],
							["CTRL"] = L["CTRL_KEY"]
						}
					},
					tiers = {
						order = 5,
						type = "group",
						name = L["Tiers"],
						get = function(info) return E.db.enhanced.tooltip.progressInfo.tiers[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.tooltip.progressInfo.tiers[info[#info]] = value
							PI:UpdateSettings()
						end,
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
end

local function LoseControlOptions()
	return {
		type = "group",
		name = L["Lose Control"],
		get = function(info) return E.db.enhanced.loseControl[info[#info]] end,
		set = function(info, value)
			E.db.enhanced.loseControl[info[#info]] = value
			E:GetModule("Enhanced_LoseControl"):UpdateSettings()
		end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["Lose Control"])
			},
			enable = {
				order = 1,
				type = "toggle",
				width = "full",
				name = L["Enable"],
				get = function(info) return E.private.enhanced.loseControl.enable end,
				set = function(info, value)
					E.private.enhanced.loseControl.enable = value
					E:GetModule("Enhanced_LoseControl"):ToggleState()
				end,
			},
			compactMode = {
				order = 2,
				type = "toggle",
				name = L["Compact mode"],
				disabled = function() return not E.private.enhanced.loseControl.enable end
			},
			iconSize = {
				order = 3,
				type = "range",
				min = 30, max = 120, step = 1,
				name = L["Icon Size"],
				disabled = function() return not E.private.enhanced.loseControl.enable end
			},
			typeGroup = {
				order = 4,
				type = "group",
				name = TYPE,
				guiInline = true,
				get = function(info) return E.db.enhanced.loseControl[info[#info]] end,
				set = function(info, value) E.db.enhanced.loseControl[info[#info]] = value end,
				disabled = function() return not E.private.enhanced.loseControl.enable end,
				args = {
					CC = {
						order = 1,
						type = "toggle",
						name = L["CC"]
					},
					PvE = {
						order = 2,
						type = "toggle",
						name = L["PvE"]
					},
					Silence = {
						order = 3,
						type = "toggle",
						name = L["Silence"]
					},
					Disarm = {
						order = 4,
						type = "toggle",
						name = L["Disarm"]
					},
					Root = {
						order = 5,
						type = "toggle",
						name = L["Root"]
					},
					Snare = {
						order = 6,
						type = "toggle",
						name = L["Snare"]
					}
				}
			}
		}
	}
end

local function InterruptTrackerOptions()
	return {
		type = "group",
		name = L["Interrupt Tracker"],
		get = function(info) return E.db.enhanced.interruptTracker[info[#info]] end,
		set = function(info, value)
			E.db.enhanced.interruptTracker[info[#info]] = value
			E:GetModule("Enhanced_InterruptTracker"):UpdateAllIconsTimers()
		end,
		args = {
			header = {
				order = 0,
				type = "header",
				name = EE:ColorizeSettingName(L["Interrupt Tracker"])
			},
			enable = {
				order = 1,
				type = "toggle",
				width = "full",
				name = L["Enable"],
				get = function(info) return E.private.enhanced.interruptTracker.enable end,
				set = function(info, value)
					E.private.enhanced.interruptTracker.enable = value
					E:StaticPopup_Show("PRIVATE_RL")
				end
			},
			size = {
				order = 2,
				type = "range",
				min = 10, max = 120, step = 1,
				name = L["Size"],
				disabled = function() return not E.private.enhanced.interruptTracker.enable end,
			},
			enableGroup = {
				order = 3,
				type = "group",
				name = L["Where to show"],
				guiInline = true,
				get = function(info) return E.private.enhanced.interruptTracker[info[#info]] end,
				set = function(info, value)
					E.private.enhanced.interruptTracker[info[#info]] = value
					E:GetModule("Enhanced_InterruptTracker"):UpdateState()
				end,
				disabled = function() return not E.private.enhanced.interruptTracker.enable end,
				args = {
					everywhere = {
						order = 1,
						type = "toggle",
						name = L["Everywhere"],
						desc = L["Show Everywhere"]
					},
					arena = {
						order = 2,
						type = "toggle",
						name = ARENA,
						desc = L["Show on Arena."],
						disabled = function() return not E.private.enhanced.interruptTracker.enable or E.private.enhanced.interruptTracker.everywhere end
					},
					battleground = {
						order = 3,
						type = "toggle",
						name = BATTLEGROUND,
						desc = L["Show on Battleground."],
						disabled = function() return not E.private.enhanced.interruptTracker.enable or E.private.enhanced.interruptTracker.everywhere end
					}
				}
			},
			textGroup = {
				order = 4,
				type = "group",
				name = L["Text"],
				guiInline = true,
				get = function(info) return E.db.enhanced.interruptTracker.text[info[#info]] end,
				set = function(info, value)
					E.db.enhanced.interruptTracker.text[info[#info]] = value
					E:GetModule("Enhanced_InterruptTracker"):UpdateAllIconsTimers()
				end,
				disabled = function() return not E.private.enhanced.interruptTracker.enable end,
				args = {
					position = {
						order = 1,
						type = "select",
						name = L["Text Position"],
						values = {
							TOPLEFT = "TOPLEFT",
							LEFT = "LEFT",
							BOTTOMLEFT = "BOTTOMLEFT",
							RIGHT = "RIGHT",
							TOPRIGHT = "TOPRIGHT",
							BOTTOMRIGHT = "BOTTOMRIGHT",
							CENTER = "CENTER",
							TOP = "TOP",
							BOTTOM = "BOTTOM"
						}
					},
					xOffset = {
						order = 2,
						type = "range",
						name = L["X-Offset"],
						min = -300, max = 300, step = 1
					},
					yOffset = {
						order = 3,
						type = "range",
						name = L["Y-Offset"],
						min = -300, max = 300, step = 1
					},
					font = {
						order = 4,
						type = "select",
						dialogControl = "LSM30_Font",
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font
					},
					fontSize = {
						order = 5,
						type = "range",
						name = L["FONT_SIZE"],
						min = 6, max = 32, step = 1
					},
					fontOutline = {
						order = 6,
						type = "select",
						name = L["Font Outline"],
						desc = L["Set the font outline."],
						values = {
							["NONE"] = L["NONE"],
							["OUTLINE"] = "OUTLINE",
							["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE"
						}
					}
				}
			}
		}
	}
end

local function UnitFrameOptions()
	local TC = E:GetModule("Enhanced_TargetClass")

	return {
		type = "group",
		name = L["UnitFrames"],
		childGroups = "tab",
		args = {
			header = {
				order = 1,
				type = "header",
				name = EE:ColorizeSettingName(L["UnitFrames"])
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
					portraitHDModelFix = {
						order = 2,
						type = "group",
						guiInline = true,
						name = L["Portrait HD Fix"],
						get = function(info) return E.db.enhanced.unitframe.portraitHDModelFix[info[#info]] end,
						set = function(info, value) E.db.enhanced.unitframe.portraitHDModelFix[info[#info]] = value end,
						disabled = function() return not E.db.enhanced.unitframe.portraitHDModelFix.enable end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								set = function(info, value)
									E.db.enhanced.unitframe.portraitHDModelFix.enable = value
									E:GetModule("Enhanced_PortraitHDModelFix"):ToggleState()
								end,
								disabled = false
							},
							debug = {
								order = 2,
								type = "toggle",
								name = L["Debug"],
								desc = L["Print to chat model names of units with enabled 3D portraits."]
							},
							modelsToFix = {
								order = 3,
								type = "input",
								name = L["Models to fix"],
								desc = L["List of models with broken portrait camera. Separete each model name with ';' simbol"],
								width = "full",
								multiline = true,
								set = function(info, value)
									E.db.enhanced.unitframe.portraitHDModelFix.modelsToFix = value
									E:GetModule("Enhanced_PortraitHDModelFix"):UpdatePortraits()
								end
							}
						}
					}
				}
			},
			player = {
				order = 3,
				type = "group",
				name = L["PLAYER"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["PLAYER"]
					},
					detachPortrait = {
						order = 3,
						type = "group",
						name = L["Detached Portrait"],
						get = function(info) return E.db.enhanced.unitframe.detachPortrait.player[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.unitframe.detachPortrait.player[info[#info]] = value
							E:GetModule("UnitFrames"):CreateAndUpdateUF("player")
						end,
						disabled = function() return not E.db.unitframe.units.player.portrait.enable or E.db.unitframe.units.player.portrait.overlay end,
						args = {
							header = {
								order = 0,
								type = "header",
								name = L["Portrait"]
							},
							enable = {
								order = 1,
								type = "toggle",
								name = L["Detach From Frame"],
								set = function(info, value)
									E.db.enhanced.unitframe.detachPortrait.player[info[#info]] = value
									E:GetModule("Enhanced_DetachedPortrait"):ToggleState("player")
								end
							},
							spacer = {
								order = 2,
								type = "description",
								name = " "
							},
							width = {
								order = 3,
								type = "range",
								name = L["Detached Width"],
								min = 10, max = 600, step = 1
							},
							height = {
								order = 4,
								type = "range",
								name = L["Detached Height"],
								min = 10, max = 600, step = 1
							}
						}
					}
				}
			},
			target = {
				order = 4,
				type = "group",
				name = L["TARGET"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["TARGET"]
					},
					classIcon = {
						order = 2,
						type = "group",
						name = L["Class Icons"],
						get = function(info) return E.db.enhanced.unitframe.units.target.classicon[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.unitframe.units.target.classicon[info[#info]] = value
							TC:ToggleSettings()
						end,
						disabled = function() return not E.db.enhanced.unitframe.units.target.classicon.enable end,
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
								disabled = false
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
								min = 16, max = 40, step = 1
							},
							xOffset = {
								order = 4,
								type = "range",
								name = L["X-Offset"],
								min = -100, max = 100, step = 1
							},
							yOffset = {
								order = 5,
								type = "range",
								name = L["Y-Offset"],
								min = -80, max = 40, step = 1
							}
						}
					},
					detachPortrait = {
						order = 3,
						type = "group",
						name = L["Detached Portrait"],
						get = function(info) return E.db.enhanced.unitframe.detachPortrait.target[info[#info]] end,
						set = function(info, value)
							E.db.enhanced.unitframe.detachPortrait.target[info[#info]] = value
							E:GetModule("UnitFrames"):CreateAndUpdateUF("target")
						end,
						disabled = function() return not E.db.unitframe.units.target.portrait.enable or E.db.unitframe.units.target.portrait.overlay end,
						args = {
							header = {
								order = 0,
								type = "header",
								name = L["Portrait"]
							},
							enable = {
								order = 1,
								type = "toggle",
								name = L["Detach From Frame"],
								set = function(info, value)
									E.db.enhanced.unitframe.detachPortrait.target[info[#info]] = value
									E:GetModule("Enhanced_DetachedPortrait"):ToggleState("target")
								end
							},
							spacer = {
								order = 2,
								type = "description",
								name = " "
							},
							width = {
								order = 3,
								type = "range",
								name = L["Detached Width"],
								min = 10, max = 600, step = 1
							},
							height = {
								order = 4,
								type = "range",
								name = L["Detached Height"],
								min = 10, max = 600, step = 1
							}
						}
					}
				}
			}
		}
	}
end

function EE:GetOptions()
	E.Options.args.enhanced = {
		order = 50,
		type = "group",
		childGroups = "tab",
		name = EE:ColorizeSettingName(L["Enhanced"]),
		args = {
			generalGroup = GeneralOptions(),
			actionbarGroup = ActionbarOptions(),
			blizzardGroup = BlizzardOptions(),
			equipmentInfoGroup = EquipmentInfoOptions(),
			mapGroup = MapOptions(),
			minimapGroup = MinimapOptions(),
			namePlatesGroup = NamePlatesOptions(),
			tooltipGroup = TooltipOptions(),
			unitframesGroup = UnitFrameOptions(),
			loseControlGroup = LoseControlOptions(),
			interruptGroup = InterruptTrackerOptions(),
		}
	}

	E.Options.args.enhanced.args.generalGroup.order = 1
	E.Options.args.enhanced.args.blizzardGroup.order = 2
--	E.Options.args.enhanced.args.actionbarGroup.order = 3
--	E.Options.args.enhanced.args.equipmentInfoGroup.order = 4
--	E.Options.args.enhanced.args.minimapGroup.order = 5
--	E.Options.args.enhanced.args.namePlatesGroup.order = 6
--	E.Options.args.enhanced.args.tooltipGroup.order = 7
--	E.Options.args.enhanced.args.loseControlGroup.order = 8
--	E.Options.args.enhanced.args.interruptGroup.order = 9
--	E.Options.args.enhanced.args.unitframesGroup.order = 10
end
