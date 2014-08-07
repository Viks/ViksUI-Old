local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	First Time Launch and On Login file
----------------------------------------------------------------------------------------

local function InstallUI()
	-- Don't need to set CVar multiple time
	SetCVar("screenshotQuality", 8)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("showTutorials", 0)
	SetCVar("gameTip", "0")
	SetCVar("UberTooltips", 1)
	SetCVar("chatMouseScroll", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("WhisperMode", "inline")
	SetCVar("BnWhisperMode", "inline")
	SetCVar("colorblindMode", 0)
	SetCVar("lootUnderMouse", 0)
	SetCVar("autoLootDefault", 1)
	SetCVar("RotateMinimap", 0)
	SetCVar("ConsolidateBuffs", 0)
	SetCVar("autoQuestProgress", 1)
	SetCVar("scriptErrors", 0)
	SetCVar("taintLog", 0)
	SetCVar("buffDurations", 1)
	SetCVar("enableCombatText", 1)
	SetCVar("autoOpenLootHistory", 0)
	SetCVar("lossOfControl", 0)


	-- Setting chat frames
	if Viks.chat.enable == true and not (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
	FCF_ResetChatWindows()
	FCF_ToggleLock()
	FCF_OpenNewWindow()
	FCF_OpenNewWindow()
	FCF_SetWindowName(ChatFrame1, "Group")
	FCF_SetWindowName(ChatFrame2, "Log")
	FCF_SetWindowName(ChatFrame3, "Trade/Spam")
	FCF_SetWindowName(ChatFrame4, "Guild")
	FCF_UnDockFrame(ChatFrame4)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_DockFrame(ChatFrame3)
	FCF_SetLocked(ChatFrame3, 1)
	ChatFrame1:SetParent(nil)
	ChatFrame1Tab:SetParent(nil)
	ChatFrame1:ClearAllPoints()
	ChatFrame1Tab:ClearAllPoints()
	ChatFrame1:SetParent(LChat)
	ChatFrame1Tab:SetParent(LChatTab)
	ChatFrame1:SetFrameLevel(LChat:GetFrameLevel()+2)
	ChatFrame1:SetWidth(LChat:GetWidth()-8)
	ChatFrame1:SetHeight(LChat:GetHeight()-8)
	ChatFrame1:SetPoint("BOTTOMLEFT",LChat,"BOTTOMLEFT",4,6)
	ChatFrame1:SetPoint("TOPRIGHT",LChat,"TOPRIGHT",-4,-2)
	ChatFrame1TabText:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\LinkinPark.ttf", 14, "THINOUTLINE")
	ChatFrame1TabText:SetTextColor(.5,.5,.5)
	FCF_SavePositionAndDimensions(ChatFrame1)
	ChatFrame4:SetParent(nil)
	ChatFrame4Tab:SetParent(nil)
	ChatFrame4:ClearAllPoints()
	ChatFrame4Tab:ClearAllPoints()
	ChatFrame4:SetParent(RChat)
	ChatFrame4Tab:SetParent(RChatTab)
	ChatFrame4:SetFrameLevel(RChat:GetFrameLevel()+2)
	ChatFrame4:SetWidth(RChat:GetWidth()-8)
	ChatFrame4:SetHeight(RChat:GetHeight()-8)
	ChatFrame4:SetPoint("BOTTOMLEFT",RChat,"BOTTOMLEFT",4,4)
	ChatFrame4:SetPoint("TOPRIGHT",RChat,"TOPRIGHT",-4,-2)
	ChatFrame4TabText:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\LinkinPark.ttf", 14, "THINOUTLINE")
	ChatFrame4TabText:SetTextColor(.5,.5,.5)
	FCF_SavePositionAndDimensions(ChatFrame4)
	FCF_SetLocked(ChatFrame1, 1)
	
-----------------------------------
---Chat Channels Setup
-----------------------------------
	--Chatwindow 1 is used for Party and Raid so lets remove spam channels
		ChatFrame_RemoveChannel(ChatFrame1, "Trade")
		ChatFrame_RemoveChannel(ChatFrame1, "General")
		ChatFrame_RemoveChannel(ChatFrame1, "LocalDefense")
		ChatFrame_RemoveChannel(ChatFrame1, "GuildRecruitment")
		ChatFrame_RemoveChannel(ChatFrame1, "LookingForGroup")
	--Lets setup what to show, we start by killing all msg first.
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame5, "INSTANCE_CHAT")
		ChatFrame_AddMessageGroup(ChatFrame5, "INSTANCE_CHAT_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "LOOT")




	-- Setup the spam chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddChannel(ChatFrame3, "Trade")
		ChatFrame_AddChannel(ChatFrame3, "General")
		ChatFrame_AddChannel(ChatFrame3, "LocalDefense")
		ChatFrame_AddChannel(ChatFrame3, "GuildRecruitment")
		ChatFrame_AddChannel(ChatFrame3, "LookingForGroup")
		ChatFrame_AddMessageGroup(ChatFrame5, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame5, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame5, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame5, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame5, "MONEY")
		ChatFrame_AddMessageGroup(ChatFrame5, "SKILL")
		ChatFrame_AddMessageGroup(ChatFrame5, "CURRENCY")
		ChatFrame_AddMessageGroup(ChatFrame5, "OPENING")
		ChatFrame_AddMessageGroup(ChatFrame5, "TRADESKILLS")
		
	-- Setup the guild chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
		ChatFrame_AddMessageGroup(ChatFrame4, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame4, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame4, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame4, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame4, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame4, "BN_CONVERSATION")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_GUILD_XP_GAIN")
		
		
	-- Enable classcolor automatically on login and on each character without doing /configure each time
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	end

	-- Reset saved variables on char
	SavedPositions = {}
	SavedOptionsPerChar = {}
	
	SavedOptionsPerChar.Install = true
	SavedOptionsPerChar.FogOfWar = false
	SavedOptionsPerChar.AutoInvite = false
	SavedOptionsPerChar.Archaeology = false
	SavedOptionsPerChar.BarsLocked = false
	SavedOptionsPerChar.SplitBars = true
	SavedOptionsPerChar.LootFrame = true
	SavedOptionsPerChar.DamageMeter = false
	SavedOptionsPerChar.RightBars = Viks.actionbar.rightbars
	SavedOptionsPerChar.BottomBars = Viks.actionbar.bottombars
----------------------------------------------------------------------------------------
--	Few Addons Settings
----------------------------------------------------------------------------------------
SkadaDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["hasUpgraded"] = true,
	["profileKeys"] = {
		["Mørk - Quel'Thalas"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["modulesBlocked"] = {
				["CC"] = true,
				["Power"] = true,
			},
			["windows"] = {
				{
					["barslocked"] = true,
					["modeincombat"] = "Threat",
					["y"] = 76.50110626220703,
					["x"] = -340.9990234375,
					["name"] = "Threath",
					["point"] = "BOTTOMRIGHT",
					["barwidth"] = 167.0000543678554,
					["mode"] = "Threat",
					["enablebackground"] = true,
					["background"] = {
						["borderthickness"] = 2,
						["height"] = 88.00006072786864,
					},
				}, -- [1]
				{
					["point"] = "BOTTOMRIGHT",
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.8,
					},
					["classcolortext"] = false,
					["mode"] = "Healing",
					["scale"] = 1,
					["reversegrowth"] = false,
					["snapto"] = true,
					["barfontsize"] = 12,
					["modeincombat"] = "",
					["name"] = "Heal",
					["barslocked"] = true,
					["x"] = -340.9996006869089,
					["barorientation"] = 1,
					["enabletitle"] = true,
					["wipemode"] = "",
					["returnaftercombat"] = false,
					["barbgcolor"] = {
						["a"] = 0.6,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
					["bartexture"] = "Armory",
					["set"] = "current",
					["buttons"] = {
						["segment"] = true,
						["menu"] = true,
						["mode"] = true,
						["report"] = true,
						["reset"] = true,
					},
					["barwidth"] = 166.9996692109227,
					["barspacing"] = -0,
					["hidden"] = false,
					["background"] = {
						["borderthickness"] = -0,
						["color"] = {
							["a"] = 0.2,
							["r"] = -0,
							["g"] = -0,
							["b"] = 0.5,
						},
						["height"] = 53.99990795077569,
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Solid",
					},
					["y"] = 5.000074473703773,
					["barfont"] = "Accidental Presidency",
					["title"] = {
						["fontsize"] = 11,
						["font"] = "Accidental Presidency",
						["borderthickness"] = 2,
						["color"] = {
							["a"] = 0.8,
							["r"] = 0.1,
							["g"] = 0.1,
							["b"] = 0.3,
						},
						["fontflags"] = "",
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Aluminium",
					},
					["classcolorbars"] = false,
					["display"] = "bar",
					["clickthrough"] = false,
					["barfontflags"] = "",
					["barheight"] = 12,
				}, -- [2]
				{
					["classcolortext"] = false,
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.8,
					},
					["barheight"] = 15,
					["clickthrough"] = false,
					["scale"] = 1,
					["reversegrowth"] = false,
					["modeincombat"] = "DPS",
					["barfontsize"] = 11,
					["enabletitle"] = true,
					["name"] = "Dps",
					["barslocked"] = true,
					["x"] = 341.000020858108,
					["barorientation"] = 1,
					["mode"] = "DPS",
					["wipemode"] = "",
					["returnaftercombat"] = false,
					["barbgcolor"] = {
						["a"] = 0.6,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
					["buttons"] = {
						["segment"] = true,
						["menu"] = true,
						["mode"] = true,
						["report"] = true,
						["reset"] = true,
					},
					["bartexture"] = "BantoBar",
					["set"] = "current",
					["barwidth"] = 163.0001646080854,
					["barspacing"] = -0,
					["hidden"] = false,
					["background"] = {
						["borderthickness"] = -0,
						["color"] = {
							["a"] = 0.2,
							["r"] = -0,
							["g"] = -0,
							["b"] = 0.5,
						},
						["height"] = 160.0000021883917,
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Solid",
					},
					["y"] = 5.000234226295153,
					["barfont"] = "Accidental Presidency",
					["title"] = {
						["fontsize"] = 11,
						["font"] = "Accidental Presidency",
						["borderthickness"] = 2,
						["color"] = {
							["a"] = 0.8,
							["r"] = 0.1,
							["g"] = 0.1,
							["b"] = 0.3,
						},
						["fontflags"] = "",
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Aluminium",
					},
					["classcolorbars"] = false,
					["display"] = "bar",
					["snapto"] = true,
					["barfontflags"] = "",
					["point"] = "BOTTOMLEFT",
				}, -- [3]
			},
			["feed"] = "Damage: Raid DPS",
			["report"] = {
				["number"] = 6,
				["channel"] = "raid",
				["mode"] = "Healing",
			},
			["columns"] = {
				["Absorbs and healing_HPS"] = true,
			},
		},
	},
}

Bartender4DB = {
	["namespaces"] = {
		["ActionBars"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["actionbars"] = {
						{
							["showgrid"] = true,
							["version"] = 3,
							["position"] = {
								["y"] = 125,
								["x"] = -265.5,
								["point"] = "BOTTOM",
							},
							["padding"] = 8,
						}, -- [1]
						{
							["showgrid"] = true,
							["version"] = 3,
							["fadeoutalpha"] = 0.3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 82,
								["x"] = -265.5,
								["point"] = "BOTTOM",
							},
							["padding"] = 8,
							["states"] = {
								["enabled"] = true,
								["default"] = 2,
							},
						}, -- [2]
						{
							["showgrid"] = true,
							["alpha"] = 0.5,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 116.5,
								["x"] = 0.4,
								["point"] = "LEFT",
								["scale"] = 0.8,
							},
							["padding"] = 9,
						}, -- [3]
						{
							["showgrid"] = true,
							["alpha"] = 0.5,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 82,
								["x"] = 0.4,
								["point"] = "LEFT",
								["scale"] = 0.8,
							},
							["padding"] = 9,
						}, -- [4]
						{
							["showgrid"] = true,
							["rows"] = 2,
							["buttons"] = 6,
							["hidemacrotext"] = true,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 113,
								["x"] = 279,
								["point"] = "BOTTOM",
								["scale"] = 0.75,
							},
							["padding"] = 3,
						}, -- [5]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 201.4,
								["x"] = -35,
								["point"] = "RIGHT",
								["scale"] = 0.76,
							},
							["padding"] = 8,
						}, -- [6]
						{
							["showgrid"] = true,
							["rows"] = 6,
							["enabled"] = true,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 144.5,
								["x"] = 351.5,
								["point"] = "CENTER",
							},
							["padding"] = 11,
							["visibility"] = {
								["custom"] = false,
								["customdata"] = "[mod:ctrl]show;hide",
							},
						}, -- [7]
						{
							["showgrid"] = true,
							["rows"] = 2,
							["enabled"] = true,
							["buttons"] = 6,
							["hidemacrotext"] = true,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 112.5,
								["x"] = -372,
								["point"] = "BOTTOM",
								["scale"] = 0.75,
							},
							["padding"] = 3,
						}, -- [8]
						{
							["showgrid"] = true,
							["rows"] = 6,
							["enabled"] = true,
							["buttons"] = 6,
							["hidemacrotext"] = true,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 180,
								["x"] = 624,
								["point"] = "BOTTOM",
								["scale"] = 0.7,
							},
							["padding"] = 6,
						}, -- [9]
						{
							["showgrid"] = true,
							["rows"] = 7,
							["enabled"] = true,
							["buttons"] = 6,
							["hidemacrotext"] = true,
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buttons",
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 180,
								["x"] = -654.5,
								["point"] = "BOTTOM",
								["scale"] = 0.7,
							},
							["padding"] = 6,
						}, -- [10]
					},
				},
			},
		},
		["LibDualSpec-1.0"] = {
		},
		["ExtraActionBar"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["position"] = {
						["y"] = 47,
						["x"] = 5.3,
						["point"] = "CENTER",
						["scale"] = 1.5,
					},
					["version"] = 3,
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
				},
			},
		},
		["MicroMenu"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["version"] = 3,
					["visibility"] = {
						["custom"] = true,
						["customdata"] = "[mod:ctrl-Shift]show;hide",
					},
					["position"] = {
						["y"] = 222,
						["x"] = -306,
						["point"] = "BOTTOMRIGHT",
					},
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
				},
			},
		},
		["XPBar"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["position"] = {
						["y"] = 57,
						["x"] = -516,
						["point"] = "BOTTOM",
					},
					["version"] = 3,
				},
			},
		},
		["MultiCast"] = {
			["profiles"] = {
				["ViksUI"] = {
					["enabled"] = false,
					["version"] = 3,
					["position"] = {
						["y"] = 35.00000266710234,
						["x"] = 284.3334044788581,
						["point"] = "BOTTOMLEFT",
					},
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
				},
			},
		},
		["BlizzardArt"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["position"] = {
						["y"] = 47,
						["x"] = -512,
						["point"] = "BOTTOM",
					},
					["version"] = 3,
				},
			},
		},
		["BagBar"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["enabled"] = false,
					["onebag"] = true,
					["position"] = {
						["y"] = 41.75,
						["x"] = 463.5,
						["point"] = "BOTTOM",
					},
					["version"] = 3,
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
				},
			},
		},
		["Vehicle"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["version"] = 3,
					["position"] = {
						["y"] = 24.5,
						["x"] = -170.5,
						["point"] = "RIGHT",
					},
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
				},
			},
		},
		["StanceBar"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["version"] = 3,
					["position"] = {
						["y"] = 209,
						["x"] = 335,
						["point"] = "BOTTOMLEFT",
						["scale"] = 0.75,
					},
					["padding"] = 7,
					["visibility"] = {
						["custom"] = false,
						["possess"] = false,
						["always"] = false,
						["customdata"] = "[mod:ctrl]show;hide",
						["stance"] = {
							false, -- [1]
						},
					},
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
				},
			},
		},
		["PetBar"] = {
			["profiles"] = {						
				["ViksUI"] = {
					["position"] = {
						["y"] = 43.45603810374087,
						["x"] = -133.2001136303006,
						["point"] = "BOTTOM",
						["scale"] = 0.6000000238418579,
					},
					["version"] = 3,
					["skin"] = {
						["ID"] = "ViksUI: Buttons",
						["Backdrop"] = false,
					},
					["fadeoutdelay"] = 0.1,
					["padding"] = 15,
					["visibility"] = {
						["possess"] = false,
						["always"] = false,
					},
					["fadeoutalpha"] = 1,
				},
			},	
		},
		["RepBar"] = {
			["profiles"] = {						
				["ViksUI"] = {
				["position"] = {
					["y"] = 65,
					["x"] = -516,
					["point"] = "BOTTOM",
				},
				["version"] = 3,
				},
			},
		},
	},
	["profiles"] = {
		["ViksUI"] = {
			["onkeydown"] = true,
			["selfcastmodifier"] = false,
			["minimapIcon"] = {
				["hide"] = true,
			},
			["buttonlock"] = true,
		},
	},
}

MasqueDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["profiles"] = {
		["Default"] = {
			["Preload"] = true,
			["LDB"] = {
				["hide"] = false,
			},
			["Groups"] = {
				["Bartender4_StanceBar"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_Vehicle"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_1"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["ExtraActionButton1_"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_3"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_2"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_BagBar"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_4"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_10"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_9"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_5"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_PetBar"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Masque"] = {
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_7"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_MicroMenu"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_8"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
				["Bartender4_6"] = {
					["Inherit"] = false,
					["SkinID"] = "ViksUI: Buttons",
				},
			},
			["Button"] = {
				["Bartender4_4"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_BagBar"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_StanceBar"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_9"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_Vehicle"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_8"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_7"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_10"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_PetBar"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_3"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_5"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_2"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_MicroMenu"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_1"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
				["Bartender4_6"] = {
					["Gloss"] = 0,
					["SkinID"] = "ViksUI: Buttons",
					["Import"] = false,
				},
			},
			["LDB"] = {
				["hide"] = false,
			},
		},
	},
}	

MBFDB = {
	["profiles"] = {
		["Default"] = {
			["ButtonOverride"] = {
				[11] = "QueueStatusMinimapButton",
			},
			["columns_or_rows"] = 4,
			["locked"] = true,
			["currentMinimapIcon"] = "QueueStatusMinimapButtonIcon",
			["mbfHidden"] = true,
			["GrowUp"] = false,
			["currentButtonOverride"] = "QueueStatusMinimapButton",
			["minimapButton"] = {
				["minimapPos"] = 192.7577142010699,
			},
			["mbfAnchor"] = "TOPLEFT",
			["MBF_FrameLocation"] = {
				"TOPLEFT", -- [1]
				nil, -- [2]
				-172.2963331240912, -- [3]
				-223.7184393402793, -- [4]
			},
			["currentChild"] = "LibDBIcon10_KLE",
			["colorLocked"] = "All",
			["MinimapIcons"] = {
				[14] = "Compass",
				[17] = "ArchyMinimap",
				[18] = "QueueStatusMinimapButtonIcon",
			},
			["currentTexture"] = "simple Square",
			["customChildren"] = {
				"MinimapButtonFrameDragButton", -- [1]
				"MiniMapMailFrameDisabled", -- [2]
				"LibDBIcon10_MrPlowLDB", -- [3]
				"LibDBIcon10_Bartender4", -- [4]
				"DBMMinimapButton", -- [5]
				"LibDBIcon10_PitBull4", -- [6]
				"LibDBIcon10_Broker_Auditor", -- [7]
				"LibDBIcon10_TravelAgent", -- [8]
				"LibDBIcon10_Omen", -- [9]
				"LibDBIcon10_Skada", -- [10]
				"tdpsButtonFrame", -- [11]
				"LibDBIcon10_DXE", -- [12]
				"LibDBIcon10_Broker_Portals", -- [13]
				"ZygorGuidesViewerMapIcon", -- [14]
				"LibDBIcon10_BugSack", -- [15]
				"FuBarPluginAtlasLootFuFrameMinimapButton", -- [16]
				"OutfitterMinimapButton", -- [17]
				"VuhDoMinimapButton", -- [18]
				"LibDBIcon10_MorgDKP2", -- [19]
				"MageNug_MinimapFrame", -- [20]
				"LibDBIcon10_Broker_Calendar", -- [21]
				"BT_Minimapbtn", -- [22]
				"FuBarPluginBig BrotherFrameMinimapButton", -- [23]
				"LibDBIcon10_ElkGuild", -- [24]
				"RA_MinimapButton", -- [25]
				"Minimalist_Map", -- [26]
				"LibDBIcon10_WoWProIcon", -- [27]
				"LibDBIcon10_AtlasLoot", -- [28]
				"LibDBIcon10_ArchyLDB", -- [29]
				"ArchyMinimap_POI1", -- [30]
				"ArchyMinimap_POI2", -- [31]
				"ArchyMinimap_POI3", -- [32]
				"ArchyMinimap_POI4", -- [33]
				"ArchyMinimap_POI5", -- [34]
				"ArchyMinimap_POI6", -- [35]
				"ArchyMinimap_POI7", -- [36]
				"ArchyMinimap_POI8", -- [37]
				"ArchyMinimap_POI9", -- [38]
				"ArchyMinimap_POI10", -- [39]
				"ArchyMinimap_POI11", -- [40]
				"ArchyMinimap_POI12", -- [41]
				"ArchyMinimap_POI13", -- [42]
				"ArchyMinimap_POI14", -- [43]
				"PS_MinimapButton", -- [44]
				"RBSMinimapButton", -- [45]
				"LibDBIcon10_BigWigs", -- [46]
				"kgPanel7", -- [47]
				"TenTonHammer_MinimapButton", -- [48]
				"LibDBIcon10_KLE", -- [49]
				"Compass", -- [50]
				"LibDBIcon10_MBF", -- [51]
				"LibDBIcon10_Archy", -- [52]
				"LibDBIcon10_TradeSkillMaster", -- [53]
				"bUnitFrames_MinimapButton", -- [54]
				"LibDBIcon10_Masque", -- [55]
				"QueueStatusMinimapButton", -- [56]
				"HealBot_ButtonFrame", -- [57]
				"MMHolder", -- [58]
				"LeftMiniPanel", -- [59]
				"RightMiniPanel", -- [60]
				"ElvConfigToggle", -- [61]
				"ElvUI_ConsolidatedBuffs", -- [62]
			},
			["padding"] = 3,
		},
	},
}

	ReloadUI()
end

local function DisableUI()
	DisableAddOn("ViksUI")
	ReloadUI()
end

local function Skadasetup()
SkadaDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["hasUpgraded"] = true,
	["profileKeys"] = {
		["Mørk - Quel'Thalas"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["modulesBlocked"] = {
				["CC"] = true,
				["Power"] = true,
			},
			["windows"] = {
				{
					["barslocked"] = true,
					["modeincombat"] = "Threat",
					["y"] = 76.50110626220703,
					["x"] = -340.9990234375,
					["name"] = "Threath",
					["point"] = "BOTTOMRIGHT",
					["barwidth"] = 167.0000543678554,
					["mode"] = "Threat",
					["enablebackground"] = true,
					["background"] = {
						["borderthickness"] = 2,
						["height"] = 88.00006072786864,
					},
				}, -- [1]
				{
					["point"] = "BOTTOMRIGHT",
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.8,
					},
					["classcolortext"] = false,
					["mode"] = "Healing",
					["scale"] = 1,
					["reversegrowth"] = false,
					["snapto"] = true,
					["barfontsize"] = 12,
					["modeincombat"] = "",
					["name"] = "Heal",
					["barslocked"] = true,
					["x"] = -340.9996006869089,
					["barorientation"] = 1,
					["enabletitle"] = true,
					["wipemode"] = "",
					["returnaftercombat"] = false,
					["barbgcolor"] = {
						["a"] = 0.6,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
					["bartexture"] = "Armory",
					["set"] = "current",
					["buttons"] = {
						["segment"] = true,
						["menu"] = true,
						["mode"] = true,
						["report"] = true,
						["reset"] = true,
					},
					["barwidth"] = 166.9996692109227,
					["barspacing"] = -0,
					["hidden"] = false,
					["background"] = {
						["borderthickness"] = -0,
						["color"] = {
							["a"] = 0.2,
							["r"] = -0,
							["g"] = -0,
							["b"] = 0.5,
						},
						["height"] = 53.99990795077569,
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Solid",
					},
					["y"] = 5.000074473703773,
					["barfont"] = "Accidental Presidency",
					["title"] = {
						["fontsize"] = 11,
						["font"] = "Accidental Presidency",
						["borderthickness"] = 2,
						["color"] = {
							["a"] = 0.8,
							["r"] = 0.1,
							["g"] = 0.1,
							["b"] = 0.3,
						},
						["fontflags"] = "",
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Aluminium",
					},
					["classcolorbars"] = false,
					["display"] = "bar",
					["clickthrough"] = false,
					["barfontflags"] = "",
					["barheight"] = 12,
				}, -- [2]
				{
					["classcolortext"] = false,
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.8,
					},
					["barheight"] = 15,
					["clickthrough"] = false,
					["scale"] = 1,
					["reversegrowth"] = false,
					["modeincombat"] = "DPS",
					["barfontsize"] = 11,
					["enabletitle"] = true,
					["name"] = "Dps",
					["barslocked"] = true,
					["x"] = 341.000020858108,
					["barorientation"] = 1,
					["mode"] = "DPS",
					["wipemode"] = "",
					["returnaftercombat"] = false,
					["barbgcolor"] = {
						["a"] = 0.6,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
					["buttons"] = {
						["segment"] = true,
						["menu"] = true,
						["mode"] = true,
						["report"] = true,
						["reset"] = true,
					},
					["bartexture"] = "BantoBar",
					["set"] = "current",
					["barwidth"] = 163.0001646080854,
					["barspacing"] = -0,
					["hidden"] = false,
					["background"] = {
						["borderthickness"] = -0,
						["color"] = {
							["a"] = 0.2,
							["r"] = -0,
							["g"] = -0,
							["b"] = 0.5,
						},
						["height"] = 160.0000021883917,
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Solid",
					},
					["y"] = 5.000234226295153,
					["barfont"] = "Accidental Presidency",
					["title"] = {
						["fontsize"] = 11,
						["font"] = "Accidental Presidency",
						["borderthickness"] = 2,
						["color"] = {
							["a"] = 0.8,
							["r"] = 0.1,
							["g"] = 0.1,
							["b"] = 0.3,
						},
						["fontflags"] = "",
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "Aluminium",
					},
					["classcolorbars"] = false,
					["display"] = "bar",
					["snapto"] = true,
					["barfontflags"] = "",
					["point"] = "BOTTOMLEFT",
				}, -- [3]
			},
			["feed"] = "Damage: Raid DPS",
			["report"] = {
				["number"] = 6,
				["channel"] = "raid",
				["mode"] = "Healing",
			},
			["columns"] = {
				["Absorbs and healing_HPS"] = true,
			},
		},
	},
}
	ReloadUI()
end

----------------------------------------------------------------------------------------
--	Popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.INSTALL_UI = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = false end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

StaticPopupDialogs.SKADAINST_UI = {
	text = "Install settings for Skada",
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = Skadasetup,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.DISABLE_UI = {
	text = L_POPUP_DISABLEUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableUI,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_UI = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = true end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_STATS = {
	text = L_POPUP_RESETSTATS,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() SavedStats = {} ReloadUI() end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.SWITCH_RAID = {
	text = L_POPUP_SWITCH_RAID,
	button1 = DAMAGER,
	button2 = HEALER,
	button3 = "Blizzard",
	OnAccept = function() SavedOptions.RaidLayout = "DPS" ReloadUI() end,
	OnCancel = function() SavedOptions.RaidLayout = "HEAL" ReloadUI() end,
	OnAlt = function() SavedOptions.RaidLayout = "NONE" ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("RESET_UI") end

SLASH_CONFIGURE1 = "/installui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("INSTALL_UI") end

SLASH_RESETSTATS1 = "/resetstats"
SlashCmdList.RESETSTATS = function() StaticPopup_Show("RESET_STATS") end

SLASH_SKADA1 = "/skadasetup_ui"
SlashCmdList.SKADA = function() StaticPopup_Show("SKADAINST_UI") end
----------------------------------------------------------------------------------------
--	On logon function
----------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	-- Create empty CVar if they doesn't exist
	if SavedOptions == nil then SavedOptions = {} end
	if SavedPositions == nil then SavedPositions = {} end
	if SavedAddonProfiles == nil then SavedAddonProfiles = {} end
	if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end
	if SavedOptions.RaidLayout == nil then SavedOptions.RaidLayout = "UNKNOWN" end
	if SavedOptionsPerChar.FogOfWar == nil then SavedOptionsPerChar.FogOfWar = false end
	if SavedOptionsPerChar.AutoInvite == nil then SavedOptionsPerChar.AutoInvite = false end
	if SavedOptionsPerChar.Archaeology == nil then SavedOptionsPerChar.Archaeology = false end
	if SavedOptionsPerChar.BarsLocked == nil then SavedOptionsPerChar.BarsLocked = false end
	if SavedOptionsPerChar.SplitBars == nil then SavedOptionsPerChar.SplitBars = true end
	if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = Viks.actionbar.rightbars end
	if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = Viks.actionbar.bottombars end

	if T.getscreenwidth < 1024 and GetCVar("gxMonitor") == "0" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if Viks.general.MultisampleProtect == true and GetCVar("gxMultisample") ~= "1" then
			SetMultisampleFormat(1)
		end
		if Viks.general.UiScale > 1.28 then Viks.general.UiScale = 1.28 end
		if Viks.general.UiScale < 0.64 then Viks.general.UiScale = 0.64 end

		-- Set our UiScale
		SetCVar("UiScale", Viks.general.UiScale)

		-- Install default if we never ran ViksUI on this character
		if not SavedOptionsPerChar.Install then
			StaticPopup_Show("INSTALL_UI")
		end
	end

	if SavedOptions.RaidLayout == "UNKNOWN" then
		StaticPopup_Show("SWITCH_RAID")
	end

	-- Welcome message
	if Viks.general.welcome_message == true then
		print("|cffffff00".."Welcome to ViksUI "..T.version.." "..T.client..", "..T.name..".|r")
		print("|cffffff00".."Type /config to config interface".." |cffffff00".."for more informations.")
	end
end)


