﻿local T, Viks, L, _ = unpack(select(2, ...))


local _, class = UnitClass("player")
local rv, gv, bv = 0, .38, .651

----------------------------------------------------------------------------------------
--	Media
----------------------------------------------------------------------------------------
Viks["media"] = {
	["font"] = [=[Interface\Addons\ViksUI\Media\Font\normal_font.ttf]=], 			    -- main font in Viks UI
	["fontcombat"] = [=[Interface\Addons\ViksUI\Media\Font\LinkinPark.ttf]=], 			-- Combat Text Font (Require Game Restart)
	["pxfont"] = [=[Interface\Addons\ViksUI\Media\Font\pixel.ttf]=], 					-- DataText Font Normal
	["pxfontHeader"] = "Interface\\Addons\\ViksUI\\Media\\Font\\LinkinPark.ttf", 		-- DataText Font for Headers. Used on Top Line
	["pxfontFlag"] = "NONE", 															-- Normal Text Flags like: "OVERLAY", "OUTLINE", "THINOUTLINE", "THICKOUTLINE" and "MONOCHROME"
	["pxfontHFlag"] = "NONE", 															-- Normal Text Flags like: "OVERLAY", "OUTLINE", "THINOUTLINE", "THICKOUTLINE" and "MONOCHROME"
	["pxfontsize"] = 14, 																-- Size of font Datatext
	["pxfontHsize"] = 14, 																-- Size of font Datatext
	["fontsize"] = 12, 														    		-- Size of font 
	["bordercolor"] = { rv, gv, bv,1 }, 												-- border color of Viks UI panels
	["backdropcolor"] = { .06,.06,.06,1 }, 												-- background color of Viks UI panels
	["overlay_color"] = {0, 0, 0, 0.9},													-- Color for action bars overlay
	["texture"] = "Interface\\Addons\\ViksUI\\Media\\Other\\statusbar",
	["blank"] = "Interface\\Buttons\\WHITE8x8",
	["blank_border"] = [[Interface\AddOns\ViksUI\Media\textures\White.tga]],			-- Texture for borders			-- Texture for status bars
	["highlight"] = [[Interface\AddOns\ViksUI\Media\textures\Highlight.tga]],			-- Texture for debuffs highlight
	["pxcolor1"] = { .001,.38,.651,1 },													-- Color for Name on Datatext
	["pxcolor2"] = { .41,.80,.94,1 },													-- Color for Value on Datatext if not dynamic color by value
	["oUFfont"] = "Interface\\Addons\\ViksUI\\Media\\Font\\ROADWAY.ttf", 				-- DataText Font Normal
	["oUFfontsize"] = 12, 																-- Size of font Datatext
	["whisp_sound"] = [[Interface\AddOns\ViksUI\Media\sounds\Whisper.ogg]],				-- Sound for wispers
	["warning_sound"] = [[Interface\AddOns\ViksUI\Media\sounds\Warning.ogg]],			-- Sound for warning
	["proc_sound"] = [[Interface\AddOns\ViksUI\Media\sounds\Proc.ogg]],					-- Sound for procs
}

----------------------------------------------------------------------------------------
--	General
----------------------------------------------------------------------------------------
Viks["general"] = {
	["AutoScale"] = true,  					-- mainly enabled for users that don't want to mess with the config file
	["UiScale"] = 0.96,						-- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["welcome_message"] = true,					-- Enable welcome message in chat
	["BlizzardsErrorFrameHiding"] = false,
}	

----------------------------------------------------------------------------------------
--	Miscellaneous options
----------------------------------------------------------------------------------------
Viks["misc"] = {
	["shift_marking"] = true,					-- Marks target when you push "shift"
	["invite_keyword"] = "invite",				-- Short keyword for invite(for enable - in game type /ainv)
	["afk_spin_camera"] = true,					-- Spin camera while afk
	["vehicle_mouseover"] = false,				-- Vehicle frame on mouseover
	["quest_auto_button"] = true,				-- Quest auto button
	["raid_tools"] = true,						-- Raid tools
	["profession_tabs"] = true,					-- Professions tabs on TradeSkill frames
	["profession_database"] = false,			-- Professions Database on Professions frame
	["hide_bg_spam"] = true,					-- Remove Boss Emote spam during BG("Arathi Basin" and "The Battle for Gilneas")
	["item_level"] = true,						-- Item level on character slot buttons
	["gem_counter"] = true,						-- Displays how many red/blue/yellow gems you have
	["already_known"] = true,					-- Colorizes recipes/mounts/pets that is already known
	["disenchanting"] = true,					-- One-click Milling, Prospecting and Disenchanting
	["sum_buyouts"] = true,						-- Sum up all current auctions
	["click_cast"] = true,						-- Simple click2cast spell binder
	["click_cast_filter"] = false,				-- Ignore Player and Target frames for click2cast
	["move_blizzard"] = true,					-- Move some Blizzard frames
	["color_picker"] = true,					-- Improved ColorPicker
	["enchantment_scroll"] = true,				-- Enchantment scroll on TradeSkill frame
	["archaeology"] = true,						-- Archaeology artifacts and cooldown
	["chars_currency"] = true,					-- Tracks your currency tokens across multiple characters
	["markbar"] = true,							-- Markbar for Raid Icons and flares
	["filger"] = true,							-- Filger, shows buff/debuff/dots in combat.
	["filgerCD"] = false,						-- Filger, shows Cooldowns on a bar list.
	["classtimer"] = true,						-- Shows buff/debuffs/procs as bar on player/target frame
	["CooldownFlash"] = false,					-- Flash icon on screen when spell are ready after cd
	["raidcooldowns"] = true,					-- Shows and tracks cooldowns used from raid members
	["WatchFrame"] = true,						-- Use custom Quest watch frame
	["MMBFbutton"] = true,						-- Minimap Button Frame Custom toggle button
	["BT4Bars"] = true,
	["Pscale"] = 1,
	["panelsh"] = true,
	["Threatbar"] = false,						-- Custom Threath Bar, that show on bar under main actionbars.
}

----------------------------------------------------------------------------------------
--	Announcements options
----------------------------------------------------------------------------------------
Viks["announcements"] = {
	["drinking"] = true,						-- Announce when arena enemy is drinking
	["interrupts"] = false,						-- Announce when you interrupt
	["spells"] = false,							-- Announce when you cast some spell
	["spells_from_all"] = false,				-- Check spells cast from all members
	["lightwell"] = false,						-- Announce your Lightwell
	["toys"] = false,							-- Announce some toys
	["says_thanks"] = false,					-- Says thanks for some spells
	["pull_countdown"] = true,					-- Pull countdown announce(/pc #)
	["flask_food"] = false,						-- Announce the usage of flasks and food
	["flask_food_auto"] = false,				-- Auto announce when ReadyCheck(if enable, announce to raid channel)
	["flask_food_raid"] = false,				-- Announce to raid channel
	["feasts"] = true,							-- Announce Feasts/Souls/Repair Bots cast
	["portals"] = true,							-- Announce Portals/Ritual of Summoning cast
	["bad_gear"] = true,						-- Check bad gear in instance
}

----------------------------------------------------------------------------------------
--	Automation options
----------------------------------------------------------------------------------------
Viks["automation"] = {
	["resurrection"] = true,					-- Auto resurrection in battlegrounds
	["screenshot"] = true,						-- Take screenshot when player get achievement
	["solve_artifact"] = true,					-- Auto popup for solve artifact
	["chefs_hat"] = true,						-- Auto equip Chef's Hat
	["safari_hat"] = true,						-- Auto equip Safari Hat
	["accept_invite"] = true,					-- Auto accept invite
	["decline_duel"] = true,					-- Auto decline duel
	["accept_quest"] = true,					-- Auto accept quests(if hold shift or alt, auto accept is disable)
	["auto_collapse"] = true,					-- Auto collapse WatchFrame in instance
	["skip_cinematic"] = false,					-- Auto skip cinematics/movies
	["auto_role"] = true,						-- Auto set your role
	["cancel_bad_buffs"] = false,				-- Auto cancel various buffs
	["tab_binder"] = true,						-- Auto change Tab key to only target enemy players
	["logging_combat"] = false,					-- Auto enables combat log text file in raid instances
	["currency_cap"] = true,					-- Auto popup for currency cap
	["buff_on_scroll"] = false,					-- Cast buff on mouse scroll
	["vendor"] = true,							-- Auto sell grey items
	["AutoRepair"] = true,						-- automaticly repair?
	["AutoRepairG"] = true,						-- automaticly repair and Use guild funds?
}

----------------------------------------------------------------------------------------
--	Skins options
----------------------------------------------------------------------------------------
Viks["skins"] = {
	["blizzard_frames"] = true,					-- Blizzard frames skin
	["minimap_buttons"] = false,				-- Skin addons icons on minimap
	["clcprot"] = false,						-- CLCProt skin
	["clcret"] = false,							-- CLCRet skin
	["combustion_helper"] = false,				-- CombustionHelper skin
	["bigwigs"] = false,						-- BigWigs skin
	["dbm"] = true,							-- DBM skin
	["dxe"] = false,							-- DXE skin
	["omen"] = false,							-- Omen skin
	["recount"] = false,						-- Recount skin
	["blood_shield_tracker"] = false,			-- BloodShieldTracker skin
	["dominos"] = false,						-- Dominos skin
	["flyout_button"] = false,					-- FlyoutButtonCustom skin
	["nug_running"] = false,					-- NugRunning skin
	["ovale"] = false,							-- OvaleSpellPriority skin
	["clique"] = false,							-- Clique skin
	["ace3"] = false,							-- Ace3 options elements skin
	["bartender"] = false,						-- Bartender elements skin
	["pallypower"] = false,						-- PallyPower skin
	["capping"] = false,						-- Capping skin
	["cool_line"] = false,						-- CoolLine skin
	["atlasloot"] = false,						-- AtlasLoot skin
	["tiny_dps"] = false,						-- TinyDPS skin
	["face_shooter"] = false,					-- FaceShooter skin
	["mage_nuggets"] = false,					-- MageNuggets skin
	["npcscan"] = false,						-- NPCScan skin
	["vanaskos"] = false,						-- VanasKoS skin
	["weak_auras"] = false,						-- WeakAuras skin
	["skada"] = true,							-- Skada skin
	["my_role_play"] = false,					-- MyRolePlay skin
	["ExtraActionBarFrame"] = true, 		-- Skinn ExtraActionBarFrame with Masque
}

----------------------------------------------------------------------------------------
--	Combat text options
----------------------------------------------------------------------------------------
Viks["combattext"] = {
	["enable"] = true,							-- Global enable combat text
	["blizz_head_numbers"] = false,				-- Use blizzard damage/healing output(above mob/player head)
	["damage_style"] = true,					-- Change default damage/healing font above mobs/player heads(you need to restart WoW to see changes)
	["damage"] = true,							-- Show outgoing damage in it's own frame
	["healing"] = true,							-- Show outgoing healing in it's own frame
	["show_hots"] = true,						-- Show periodic healing effects in healing frame
	["show_overhealing"] = true,				-- Show outgoing overhealing
	["pet_damage"] = true,						-- Show your pet damage
	["dot_damage"] = true,						-- Show damage from your dots
	["damage_color"] = true,					-- Display damage numbers depending on school of magic
	["crit_prefix"] = "*",						-- Symbol that will be added before crit
	["crit_postfix"] = "*",						-- Symbol that will be added after crit
	["icons"] = true,							-- Show outgoing damage icons
	["icon_size"] = 16,							-- Icon size of spells in outgoing damage frame, also has effect on dmg font size
	["treshold"] = 1,							-- Minimum damage to show in damage frame
	["heal_treshold"] = 1,						-- Minimum healing to show in incoming/outgoing healing messages
	["scrollable"] = false,						-- Allows you to scroll frame lines with mousewheel
	["max_lines"] = 15,							-- Max lines to keep in scrollable mode(more lines = more memory)
	["time_visible"] = 3,						-- Time(seconds) a single message will be visible
	["dk_runes"] = true,						-- Show deathknight rune recharge
	["killingblow"] = false,					-- Tells you about your killingblows
	["merge_aoe_spam"] = true,					-- Merges multiple aoe damage spam into single message
	["merge_melee"] = true,						-- Merges multiple auto attack damage spam
	["dispel"] = true,							-- Tells you about your dispels(works only with ["damage"] = true)
	["interrupt"] = true,						-- Tells you about your interrupts(works only with ["damage"] = true)
	["direction"] = "bottom",					-- Scrolling Direction("top"(goes down) or "bottom"(goes up))
}

----------------------------------------------------------------------------------------
--	Addon Skins  //-- These are still the best to use atm
----------------------------------------------------------------------------------------
Viks["addonskins"] = {				 
	["PallyPower"] = false, 					-- Pally Power skinning
	["Skada"] = true, 						-- Skada skinning
	["Recount"] = false, 					-- Recount skinning
	["Omen"] = false, 						-- Omen skinning
	["KLE"] = false, 						-- KLE skinning
	["Quartz"] = true, 						-- Quartz skinning
	["Bigwigs"] = true, 					-- BigWigs Bossmod skinning
	["DXE"] = false,
}

----------------------------------------------------------------------------------------
--	Buffs reminder options
----------------------------------------------------------------------------------------
Viks["reminder"] = {
	-- Self buffs
	["solo_buffs_enable"] = true,				-- Enable buff reminder
	["solo_buffs_sound"] = true,				-- Enable warning sound notification for buff reminder
	["solo_buffs_size"] = 45,					-- Icon size
	-- Raid buffs
	["raid_buffs_enable"] = true,				-- Show missing raid buffs
	["raid_buffs_always"] = false,				-- Show frame always
	["raid_buffs_size"] = 20.1,					-- Icon size
	["raid_buffs_alpha"] = 0.3,					-- Transparent icons when the buff is present
}

----------------------------------------------------------------------------------------
--	Raid cooldowns options
----------------------------------------------------------------------------------------
Viks["raidcooldown"] = {
	["enable"] = true,							-- Enable raid cooldowns
	["height"] = 15,							-- Bars height
	["width"] = 186,							-- Bars width(if show_icon = false, bar width+28)
	["upwards"] = false,						-- Sort upwards bars
	["show_icon"] = true,						-- Show icons
	["show_inraid"] = true,						-- Show in raid zone
	["show_inparty"] = true,					-- Show in party zone
	["show_inarena"] = true,					-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Enemy cooldowns options
----------------------------------------------------------------------------------------
Viks["enemycooldown"] = {
	["enable"] = true,							-- Enable enemy cooldowns
	["size"] = 30,								-- Icon size
	["direction"] = "RIGHT",					-- Icon direction
	["show_always"] = false,					-- Show everywhere
	["show_inpvp"] = false,						-- Show in bg zone
	["show_inarena"] = true,					-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Pulse cooldowns options
----------------------------------------------------------------------------------------
Viks["pulsecooldown"] = {
	["enable"] = false,							-- Show cooldowns pulse
	["size"] = 75,								-- Icon size
	["sound"] = false,							-- Warning sound notification
	["anim_scale"] = 1.5,						-- Animation scaling
	["hold_time"] = 0,							-- Max opacity hold time
	["threshold"] = 3,							-- Minimal threshold time
}

----------------------------------------------------------------------------------------
--	Threat options
----------------------------------------------------------------------------------------
Viks["threat"] = {
	["enable"] = false,							-- Enable threat meter
	["height"] = 12,							-- Bars height
	["width"] = 217,							-- Bars width
	["bar_rows"] = 7,							-- Number of bars
	["hide_solo"] = false,						-- Show only in party/raid
}

----------------------------------------------------------------------------------------
--	Tooltip options
----------------------------------------------------------------------------------------
Viks["tooltip"] = {
	["enable"] = true,							-- Enable tooltip
	["shift_modifer"] = false,					-- Show tooltip when "shift" is pushed
	["cursor"] = false,							-- Tooltip above cursor
	["item_icon"] = true,						-- Item icon in tooltip
	["health_value"] = false,					-- Numeral health value
	["hidebuttons"] = false,					-- Hide tooltip for actions bars
	["hide_combat"] = false,					-- Hide tooltip in combat
	-- Plugins
	["talents"] = true,						-- Show tooltip talents
	["achievements"] = false,					-- Comparing achievements in tooltip
	["target"] = true,							-- Target player in tooltip
	["title"] = true,							-- Player title and realm name in tooltip
	["rank"] = true,							-- Player guild-rank in tooltip
	["arena_experience"] = true,				-- Player PvP experience in arena
	["spell_id"] = true,						-- Id number spells
	["average_lvl"] = true,					-- Average items level
	["raid_icon"] = true,						-- Raid icon
	["who_targetting"] = true,					-- Show who is targetting the unit(in raid or party)
	["item_count"] = true,						-- Item count in tooltip
	["unit_role"] = true,						-- Unit role in tooltip
	["instance_lock"] = true,					-- Your instance lock status in tooltip
	["item_transmogrify"] = false,				-- Displays items can not be transmogrified
}

----------------------------------------------------------------------------------------
--	Minimap options
----------------------------------------------------------------------------------------
Viks["minimapp"] = {
	["enable"] = true,
	["minimb1"] = true,						--Background for Minimap bottom right
	["minimb2"] = true,						--Background for Minimap bottom left
	["Picomenu"] = true,					--Use Picomenu
	["compass"] = true,						--Show N/S/E/W
	["size"] = 136,
	["toggle_menu"] = false,						-- Show toggle menu
}
----------------------------------------------------------------------------------------
--	Panels options
----------------------------------------------------------------------------------------
Viks["panels"] = {
	["CPwidth"] = 300 ,								-- Width for Left and RIght side panels that holds text. 
	["CPTextheight"] = 140, 						-- Hight for panel where chat window is inside
	["CPbarsheight"] = 16, 							-- Hight for Panels under/above Chat window
	["CPABarSide"] = 30, 							-- Width for Action Bars next to chat windows
	["CPXPBa_r"] = 20, 								-- Hight for the XP bar above Left Chat
	["xoffset"] = 3, 								-- Horisontal spacing between panels
	["yoffset"] = 3, 								-- Vertical spacing between panels
	["CPSidesWidth"] = 178, 						-- Width of panels that is used to hold dmg meter and threathbar (Recount & Omen) 
	["CPMABwidth"] = 538, 							-- Width for Main Actionbar
	["CPMABheight"] = 32, 							-- Hight for Main Actionbar
	["CPMAByoffset"] = 68, 							-- Hight for Main Actionbar
	["CPCooldheight"] = 18, 						-- Hight for Cooldown Bar
	["CPTop"] = 1912, 								-- Width for Top Panels
	["CPMinimap"] = Viks["minimapp"].size, 			-- Width/Hight for Minimap Panel
	["Pscale"] = Viks["misc"].Pscale,				-- Can be used to resize all panels. It does not change X Y Values
	["NoPanels"] = false,							-- Will Set all panels to hidden and show lines instead. On test stage still!
}
----------------------------------------------------------------------------------------
--	Chat options
----------------------------------------------------------------------------------------
Viks["chat"] = {
	["enable"] = true,							-- Enable chat
	["background"] = true,						-- Enable background for chat
	["background_alpha"] = 0.7,					-- Background alpha
	["filter"] = true,							-- Removing some systems spam("Player1" won duel "Player2")
	["spam"] = false,							-- Removing some players spam(gold/portals/etc)
	["width"] = Viks.panels.CPwidth - 4,							-- Chat width
	["height"] = Viks.panels.CPTextheight - 4,							-- Chat height
	["chat_bar"] = false,						-- Lite Button Bar for switch chat channel
	["chat_bar_mouseover"] = false,				-- Lite Button Bar on mouseover
	["time_color"] = {1, 1, 0},					-- Timestamp coloring(http://www.december.com/html/spec/colorcodes.html)
	["whisp_sound"] = true,						-- Sound when whisper
	["bubbles"] = true,							-- Skin Blizzard chat bubbles
	["transp_bubbles"] = true,					-- Transparent Chat Bubbles.
	["transp_bubbles_a"] = 0.35,					-- Alpha for Transparent Chat Bubbles.
	["combatlog"] = true,						-- Show CombatLog tab(need two reloads when false)
	["tabs_mouseover"] = false,					-- Chat tabs on mouseover
	["sticky"] = true,							-- Remember last channel
	["damage_meter_spam"] = false,				-- Merge damage meter spam in one line-link
}

----------------------------------------------------------------------------------------
--	Bag options
----------------------------------------------------------------------------------------
Viks["bag"] = {
	["enable"] = true,							-- Enable bags
	["BagBars"] = false,
	["SortTop"] = true,							-- Sort from top down
	["button_size"] = 27,						-- Buttons size
	["button_space"] = 3,						-- Buttons space
	["bank_columns"] = 17,						-- Horizontal number of columns in bank
	["bag_columns"] = 10,						-- Horizontal number of columns in main bag
}

----------------------------------------------------------------------------------------
--	Map options
----------------------------------------------------------------------------------------
Viks["map"] = {
	["bg_map_stylization"] = true,				-- BG map stylization
	["map_boss_count"] = true,					-- Show boss count in World Map
	["explore_map"] = true,						-- Tracking Explorer and Lore Master achievements in World Map
	["fog_of_war"] = true,						-- Fog of war on World Map
}

----------------------------------------------------------------------------------------
--	Loot and Roll Frames
----------------------------------------------------------------------------------------
Viks["loot"] = {
	["lootframe"] = true,                  
	["rolllootframe"] = true,
	["icon_size"] = 22,							-- Icon size
	["width"] = 221,							-- Loot window width
	["auto_greed"] = true,						-- Push "greed" or "disenchant" button when an item roll
	["auto_confirm_de"] = true,					-- Auto confirm disenchant
}

----------------------------------------------------------------------------------------
--	Nameplate options
----------------------------------------------------------------------------------------
Viks["nameplate"] = {
	["enable"] = true, 							-- Enable nameplate
	["height"] = 9,								-- Nameplate height
	["width"] = 120,							-- Nameplate width
	["ad_height"] = 0,							-- Additional height for selected nameplate
	["ad_width"] = 0,							-- Additional width for selected nameplate
	["combat"] = false,							-- Automatically show nameplate in combat
	["health_value"] = false,					-- Numeral health value
	["show_castbar_name"] = false,				-- Show castbar name
	["enhance_threat"] = true,					-- If tank good aggro = green, bad = red
	["class_icons"] = false,					-- Icons by class in PvP
	["name_abbrev"] = false,					-- Display the abbreviated names
	["good_color"] = {0.2, 0.8, 0.2},			-- Good threat color
	["near_color"] = {1, 1, 0},					-- Near threat color
	["bad_color"] = {1, 0, 0},					-- Bad threat color
	["track_auras"] = false,					-- Show debuffs
	["auras_size"] = 22,						-- Debuffs size
	["healer_icon"] = false,					-- Show icon above enemy healers nameplate in battlegrounds
}

----------------------------------------------------------------------------------------
--	Auras/Buffs/Debuffs options
----------------------------------------------------------------------------------------
Viks["aura"] = {
	["player_buff_size"] = 30,					-- Player buffs size
	["player_debuff_size"] = 25,				-- Player debuffs size
	["show_spiral"] = true,						-- Spiral on aura icons
	["show_timer"] = true,						-- Show cooldown timer on aura icons
	["player_auras"] = true,					-- Auras on player frame
	["target_auras"] = true,					-- Auras on target frame
	["focus_debuffs"] = false,					-- DeBuffs on focus frame
	["fot_debuffs"] = false,					-- DeBuffs on focustarget frame
	["pet_debuffs"] = false,					-- DeBuffs on pet frame
	["tot_debuffs"] = false,					-- DeBuffs on targettarget frame
	["boss_buffs"] = true,						-- Buffs on boss frame
	["player_aura_only"] = false,				-- Only your debuff on target frame
	["debuff_color_type"] = true,				-- Color debuff by type
	["cast_by"] = true,							-- Show who cast a buff/debuff in its tooltip
	["classcolor_border"] = false,				-- Enable classcolor border for player buffs
}

----------------------------------------------------------------------------------------
--	Unit Frames options
----------------------------------------------------------------------------------------
Viks["unitframes"] = {
	["enable"] = true,																	-- enable/disable action bars
	["HealFrames"] = false,																-- Healing layout/positions
	["ShowRaid"] = true,																-- Show Raid Frames
	["ShowParty"] = true,																-- show party frames (shown as 5man raid)
	["RaidShowAllGroups"] = true,														-- Show All 8 Raid Groups, if not then 5	
	["RaidShowSolo"] = false,															-- show raid frames even when solo
	["HealthcolorClass"] = false,														-- health color = class color
	["bigcastbar"] = true,
	["Powercolor"] = true,																-- power color = class color
	["showtot"] = true, 																-- show target of target frame
	["showpet"] = true,																	-- show pet frame
	["showfocus"] = true, 																-- show focus frame
	["showfocustarget"] = true, 														-- show focus targets frame
	["showBossFrames"] = true, 															-- show boss frame
	["TotemBars"] = true, 																-- show totem bars
	["MTFrames"] = true, 																-- show main tank frames
	["ArenaFrames"]  = true, 															-- show arena frame
	["Reputationbar"] = true, 															-- show reputation bar
	["Experiencebar"] = true, 															-- show experience bar
	["showPlayerAuras"] = false, 														-- use a custom player buffs/debuffs frame instead of blizzard's default.
	["ThreatBar"] = true,																-- show threat bar
	["showPortrait"] = true,															-- show portraits Icon
	["showPortraitHPbar"] = false,														-- show portraits on Healthbar
	["Castbars"] = true, 																-- Show built-in castbars
	["VuhDo"] = false, 																	-- Always Hide Raidframes if VuhDo is loaded.
	["showRaidDebuffs"] = true,															-- Shows debuff as icon on your raid frames
	["showAuraWatch"] = true,															-- Watch specific auras
	["enableDebuffHighlight"] = true,													-- Highlight Unit Frame if having a Debuffs
	["ShowIncHeals"] = true,															-- Show incoming heals in player and raid frames
	["RCheckIcon"] = true,																-- Show Ready Check Icons On Health Frames
	["IndicatorIcons2"] = false,														-- Toggles different Indicator types.	
	["UFfont"] = "Interface\\Addons\\ViksUI\\Media\\Font\\ROADWAY.ttf",
	["UFNamefont"] = "Interface\\Addons\\ViksUI\\Media\\Font\\ROADWAY.ttf",				-- Font to use on Names
	["aurasize"] = 18,																	-- Aura Size for indicator type 2
	["indicatorsize"] = 6,																-- Size on Squares on Indicator type 2
	["symbolsize"] = 11,																-- Size on Symbols on Indicator type 2
	["fontsizeEdge"] = 12,
	["Findoutline"] = "OUTLINE",
	["insideAlpha"] = 1,																-- Alpha when Unitframe is in range	
	["outsideAlpha"] = 0.6,																-- Alpha when Unitframe is out of range	
	["showLFDIcons"] = true,															-- Show Raid Roll Icon on Frames
	["customLFDIcons"] = true,															-- Show Custom Raid Roll Icon on Frames
	["customLFDText"] = false,															-- Show Raid Roll Icon as Text on Frames
	["showIndicators"] = true,															-- Show Indicators on frames
	["debuffsOnlyShowPlayer"] = false,													-- only show your debuffs on target
	["buffsOnlyShowPlayer"] = false,													-- only show your buffs
	}

----------------------------------------------------------------------------------------
--	Unit Frames Class bar options
----------------------------------------------------------------------------------------
Viks["unitframe_class_bar"] = {
	["combo"] = true,							-- Rogue/Druid Combo bar
	["shadow"] = true,							-- Shadow Orbs bar
	["chi"] = true,								-- Chi bar
	["vengeance"] = true,						-- Vengeance bar
	["eclipse"] = true,							-- Eclipse bar
	["holy"] = true,							-- Holy Power bar
	["shard"] = true,							-- Shard/Burning bar
	["rune"] = true,							-- Rune bar
	["totem"] = true,							-- Totem bar
	["range"] = false,							-- Range bar (only for Priest)
}	
----------------------------------------------------------------------------------------
--	Raid Frames options
----------------------------------------------------------------------------------------
Viks["raidframes"] = {
	["enable"] = false,
	["scale"] = 1.0,
	["width"] = 101,
    ["height"] = 30,
	["width25"] = 60,
    ["height25"] = 30,
	["width40"] = 60,
    ["height40"] = 24,
    ["fontsize"] = 12,
    ["fontsizeEdge"] = 12,
    ["outline"] = "OUTLINE",
    ["solo"] = false,
    ["player"] = true,
    ["party"] = false,
    ["numCol"] = 5,
    ["numUnits"] = 5,
    ["spacing"] = 7,
    ["orientation"] = "HORIZONTAL",
    ["porientation"] = "HORIZONTAL",
    ["horizontal"] = true, 
    ["growth"] = "UP", 
    ["reversecolors"] = true,
    ["definecolors"] = true,
    ["powerbar"] = true,
    ["powerbarsize"] = 0.12,
    ["outsideRange"] = .40,
    ["healtext"] = true,
    ["healbar"] = true,
    ["healoverflow"] = true,
    ["healothersonly"] = false,
    ["healalpha"] = .40,
    ["roleicon"] = true,
	["showIndicators"] = true,
    ["indicatorsize"] = 6,
    ["symbolsize"] = 11,
    ["leadersize"] = 12,
	["autorez"] = true,
    ["aurasize"] = 18,
    ["multi"] = true, --Use multiple headers for better group sorting. Note: This disables units per group and sets it to 5.
    ["deficit"] = true,
	["multi2"] = true,
    ["perc"] = true,
    ["actual"] = true,
    ["myhealcolor"] = { 0, 1, 0.5, 0.4 },
    ["otherhealcolor"] = { 0, 1, 0, 0.4 },
    ["hpcolor"] = { 0.1, 0.1, 0.1, 1 },
    ["hpbgcolor"] = { 0.5, 0.5, 0.5, 1 },
    ["powercolor"] = { 1, 1, 1, 1 },
    ["powerbgcolor"] = { 0.33, 0.33, 0.33, 1 },
    ["powerdefinecolors"] = false,
    ["colorSmooth"] = false,
    ["gradient"] = { 1, 0, 0, 1 },
    ["tborder"] = true,
    ["fborder"] = true,
    ["afk"] = true,
    ["highlight"] = true,
    ["dispel"] = true,
    ["powerclass"] = true,
    ["tooltip"] = true,
    ["sortName"] = false,
    ["sortClass"] = false,
    ["classOrder"] = "DEATHKNIGHT,DRUID,HUNTER,MAGE,PALADIN,PRIEST,ROGUE,SHAMAN,WARLOCK,WARRIOR", --Uppercase English class names separated by a comma. \n { CLASS[,CLASS]... }"
    ["hidemenu"] = false,
	["plugins_aura_watch"] = true,				-- Raid debuff icons
	["plugins_aura_watch_timer"] = false,		-- Timer on raid debuff icons
}

----------------------------------------------------------------------------------------
--	Panel options (The datatext that is hidden on top with mouseover)
----------------------------------------------------------------------------------------
Viks["toppanel"] = {
	["enable"] = true,							-- Enable top panel
	["mouseover"] = true,						-- Top panel on mouseover
	["height"] = 100,							-- Panel height
	["width"] = 250,							-- Panel width
}

----------------------------------------------------------------------------------------
--	Stats options
----------------------------------------------------------------------------------------
Viks["stats"] = {
	["battleground"] = true,					-- BG Score
	["clock"] = false,							-- Clock
	["latency"] = false,						-- Latency
	["memory"] = false,							-- Memory
	["fps"] = false,							-- FPS
	["friend"] = false,							-- Friends
	["guild"] = false,							-- Guild
	["durability"] = false,						-- Durability
	["experience"] = true,						-- Experience
	["coords"] = false,							-- Coords
	["location"] = false,						-- Location
}

----------------------------------------------------------------------------------------
--	Error options (All errors on www.wowwiki.com/WoW_Constants/Errors)
----------------------------------------------------------------------------------------
Viks["error"] = {
	["black"] = true,							-- Hide errors from black list
	["white"] = false,							-- Show errors from white list
	["combat"] = false,							-- Hide all errors in combat
}

----------------------------------------------------------------------------------------
--	Datatext
----------------------------------------------------------------------------------------
Viks["datatext"] = {
	["Arena"] = 0, 
	["Armor"] = 0,                          -- show your armor value against the level mob you are currently targeting	
	["Avd"] = 0,                            -- show your current avoidance against the level of the mob your targeting
	["Bags"] = 5,                			-- show space used in bags on panels
	["Battleground"] = true,                   -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["Crit"] = 0,                           -- show your crit rating on panels.
	["Durability"] = 6,                		-- show your equipment durability on panels.
	["Friends"] = 9,                		-- show number of friends connected.
	["Gold"] = 4,                			-- show your current gold on panels
	["Guild"] = 11,                			-- show number on guildmate connected on panels
	["Haste"] = 2,                          -- show your haste rating on panels.
	["Versatility"] = 3,                    -- show versatility
	["location"] = 10,                      -- show location
	["Mastery"] = 0,                        -- show mastery rating
	["Power"] = 1,                          -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["Regen"] = 0,  						-- show mana regeneration
	["System"] = 7,                			-- show fps and ms on panels, and total addon memory in tooltip
	["Talents"] = 12,                       -- Show Your Talent's. Shift Click to change spec. 
	["togglemenu"] = 0,  			  		-- minimenu
	["Wowtime"] = true,              		-- THIS IS BLOCKED TO FIXED POSITION! SO CAN'T BE CHANGED HERE! NUMBER MUST BE > 0, BUT DOESN'T USE UP A SPOT!
	["Time24"] = true,            			-- set time to 24h format.
	["Localtime"] = true,  					-- Show Local time instead of server time
	["classcolor"] = true,
	["color"] = { .7, .7, .7, 1 }, 			-- if ["classcolor"] = false
	["CurrArchaeology"] = true,
	["CurrCooking"] = true,
	["CurrProfessions"] = true,
	["CurrMiscellaneous"] = true, 
	["CurrPvP"] = true,
	["CurrRaid"] = true,
	
	["Time24HrFormat"] = false,
	["NameColor"] = {1, 1, 1},
	["ValueColor"] = {1, 1, 1},
	["Font"] = [=[Interface\Addons\ViksUI\Media\Font\normal_font.ttf]=],
}

----------------------------------------------------------------------------------------
--	Cooldown Timer for Actionbars
----------------------------------------------------------------------------------------
Viks["cooldown"] = {
	["enable"] = true,                     
}
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

Viks["togglemenu"] = {
	["enable"] = true,
	["buttonwidth"] = 98,					-- Width of menu buttons
	["buttonheight"] = 18,					-- Height of menu buttons
	["classcolor"] = true,					-- Class color buttons
}

Viks["XPBar"] = {
	["enable"] = true,								--Enables XPBar, Based on SaftExperience
	["pos1"] = true,								--Set position to Cooldown Bar (Get sizes from that)
	["pos2"] = false,								--Set position to anchor that is movable with /ui
	["height"] = 10,  								--Set Height for it when using pos2
	["width"] = 300,								--Set Width for it when using pos2
	["text"] = true,  								--Show text at all
	["mouse"] = true,  								--Show text only when mouseover
}

----------------------------------------------------------------------------------------
--	Action Bars // Removed from addon pack. Note: Actionbars are removed, but to much code build around these to remove at this stage!
----------------------------------------------------------------------------------------
Viks["actionbar"] = {		
	["enable"] = false,                                  -- enable tukui action bars
	["hotkey"] = true,                                  -- enable hotkey display because it was a lot requested
	["hideSTANCE"] = false,                         -- hide STANCE or totembar because it was a lot requested.
	["showgrid"] = true,                                -- show grid on empty button
	["buttonsize"] = 35,                                -- normal buttons size
	["petbuttonsize"] = 36,                             -- pet & stance buttons size
	["buttonspacing"] = 1,                              -- buttons spacing
	["petbuttonspacing"] = 1,
	["mainbarWidth"] = 12,		
	["ownshdbar"] = false,                              -- use a complete new stance bar for shadow dance (rogue only)
	["lowversion"] = false,
	["sidebarWidth"] = 6,								-- amount of buttons per row on side bars (set between 1-6 only), option work if lowversion - false
}

----------------------------------------------------------------------------------------
--	Position options
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
Viks["position"] = {
	-- Miscellaneous positions
	["minimap_buttons"] = {"TOPRIGHT", Minimap, "TOPLEFT", -3, -30},					-- Minimap buttons
	["minimap"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24},				-- Minimap
	["map"] = {"BOTTOM", UIParent, "BOTTOM", -120, 320},							-- Map
	["chat"] = {"BOTTOMLEFT", LChat, "BOTTOMLEFT", 5, 21},						-- Chat
	["bag"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},							-- Bag
	["bank"] = {"LEFT", UIParent, "LEFT", 23, 150},									-- Bank
	["bn_popup"] = {"BOTTOMLEFT", LChatTab, "BOTTOMLEFT", 10, 20},					-- Battle.net popup
	["achievement"] = {"TOP", UIParent, "TOP", 0, -21},								-- Achievements frame
	["tooltip"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},						-- Tooltip
	["attempt"] = {"TOP", UIParent, "TOP", -85, -25},								-- Attempts frame
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 3},								-- BG capture bars
	["vehicle"] = {"BOTTOM", Minimap, "TOP", 0, 27},								-- Vehicle frame
	["ghost"] = {"BOTTOM", Minimap, "TOP", 0, 5},									-- Ghost frame
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},									-- Errors frame
	["quest"] = {"TOPLEFT", UIParent, "TOPLEFT", 21, -2},							-- Quest log
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},							-- Loot
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 500},						-- Group roll loot
	["threat_meter"] = {"CENTER", UIParent, "CENTER", 0, 0},		-- Threat meter
	["raid_cooldown"] = {"TOPLEFT", UIParent, "TOPLEFT", 21, -21},					-- Raid cooldowns
	["enemy_cooldown"] = {"BOTTOMLEFT", "oUF_Player", "TOPRIGHT", 33, 62},			-- Enemy cooldowns
	["pulse_cooldown"] = {"CENTER", UIParent, "CENTER", 0, 0},						-- Pulse cooldowns
	["bg_score"] = {"CENTER", UIParent, "BOTTOM", 0, 28},			-- BG stats
	["player_buffs"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -21, -21},				-- Player buffs
	["self_buffs"] = {"CENTER", UIParent, "CENTER", 0, 0},						-- Self buff reminder
	["raid_buffs"] = {"CENTER", UIParent, "CENTER", 0, 0},						-- Raid buff reminder
	["top_panel"] = {"TOP", UIParent, "TOP", 0, -20},								-- Top panel
	["raid_utility"] = {"TOP", UIParent, "TOP", -280, 1},							-- Raid utility
	["archaeology"] = {"TOPRIGHT", SideBar, "TOPRIGHT", -2, 0},					-- Archaeology frame
	["auto_button"] = {"LEFT", UIParent, "LEFT", 0, 0},					-- Auto button
	["extra_button"] = {"BOTTOM", UIParent, "BOTTOM", 0, 350},						-- Extra action button
	["alt_power_bar"] = {"TOP", UIParent, "TOP", 0, -21},							-- Alt power bar
	-- ActionBar positions
	["bottom_bars"] = {"BOTTOM", UIParent, "BOTTOM", 0, 8},							-- Bottom bars
	["right_bars"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 330},			-- Right bars
	["pet_horizontal"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -175, 167},			-- Horizontal pet bar
	["stance_bar"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -202, 167},				-- Stance bar
	["vehicle_bar"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Vehicle button
	["micro_menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -2},						-- Micro menu
	-- UnitFrame positions
	unitframes = {
		["player"] = {"BOTTOMRIGHT", "ActionBarAnchor", "TOPLEFT", -9, 175},		-- Player frame
		["target"] = {"BOTTOMLEFT", "ActionBarAnchor", "TOPRIGHT", 9, 175},			-- Target frame
		["target_target"] = {"TOPRIGHT", "oUF_Target", "BOTTOMRIGHT", 0, -11},		-- ToT frame
		["pet"] = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", 0, -11},					-- Pet frame
		["focus"] = {"TOPRIGHT", "oUF_Player", "BOTTOMRIGHT", 0, -11},				-- Focus frame
		["focus_target"] = {"TOPLEFT", "oUF_Target", "BOTTOMLEFT", 0, -11},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 23, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 22, -22},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -60, -70},					-- Arena frames
		["boss"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -23, -70},					-- Boss frames
		["tank"] = {"BOTTOMLEFT", "ActionBarAnchor", "BOTTOMRIGHT", 10, 18},		-- Tank frames
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -12, 27},		-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 10, 27},		-- Target Portrait
		["player_castbar"] = {"BOTTOM", "ActionBarAnchor", "TOP", 0, 175},			-- Player Castbar
		["target_castbar"] = {"BOTTOM", "oUF_Player_Castbar", "TOP", 0, 7},			-- Target Castbar
		["focus_castbar"] = {"CENTER", UIParent, "CENTER", 0, 250},					-- Focus Castbar icon
	},
}


----------------------------------------------------------------------------------------
--	ViksUI fonts configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- Viks["font"] = {
--		-- Stats font
--		["stats_font"] = "Interface\\AddOns\\ViksUI\\Media\\Font\\Normal.ttf",
-- 		["stats_font_size"] = 11,
--		["stats_font_style"] = "",
--		["stats_font_shadow"] = true,
-- }
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Fonts options
----------------------------------------------------------------------------------------
Viks["font"] = {
	-- Stats font
	["stats_font"] = Viks.media.pxfont,
	["stats_font_size"] = 8,
	["stats_font_style"] = "OUTLINEMONOCHROME",
	["stats_font_shadow"] = false,



	-- Combat text font
	["combat_text_font"] = Viks.media.pxfont,
	["combat_text_font_size"] = 16,
	["combat_text_font_style"] = "OUTLINEMONOCHROME",
	["combat_text_font_shadow"] = false,

	-- Chat font
	["chat_font"] = Viks.media.font,
	["chat_font_style"] = "",
	["chat_font_shadow"] = true,

	-- Chat tabs font
	["chat_tabs_font"] = "Interface\\Addons\\ViksUI\\Media\\Font\\DICTATOR.ttf",
	["chat_tabs_font_size"] = 13,
	["chat_tabs_font_style"] = "OUTLINEMONOCHROME",
	["chat_tabs_font_shadow"] = false,

	-- Action bars font
	["action_bars_font"] = Viks.media.pxfont,
	["action_bars_font_size"] = 8,
	["action_bars_font_style"] = "OUTLINEMONOCHROME",
	["action_bars_font_shadow"] = false,

	-- Threat meter font
	["threat_meter_font"] = Viks.media.pxfont,
	["threat_meter_font_size"] = 8,
	["threat_meter_font_style"] = "OUTLINEMONOCHROME",
	["threat_meter_font_shadow"] = false,

	-- Raid cooldowns font
	["raid_cooldowns_font"] = Viks.media.pxfont,
	["raid_cooldowns_font_size"] = 8,
	["raid_cooldowns_font_style"] = "OUTLINEMONOCHROME",
	["raid_cooldowns_font_shadow"] = false,

	-- Cooldowns timer font
	["cooldown_timers_font"] = Viks.media.pxfont,
	["cooldown_timers_font_size"] = 16,
	["cooldown_timers_font_style"] = "OUTLINEMONOCHROME",
	["cooldown_timers_font_shadow"] = false,

	-- Loot font
	["loot_font"] = Viks.media.pxfont,
	["loot_font_size"] = 8,
	["loot_font_style"] = "OUTLINEMONOCHROME",
	["loot_font_shadow"] = false,

	-- Nameplates font
	["nameplates_font"] = Viks.media.pxfont,
	["nameplates_font_size"] = 8,
	["nameplates_font_style"] = "OUTLINEMONOCHROME",
	["nameplates_font_shadow"] = false,

	-- Unit frames font
	["unit_frames_font"] = Viks.media.pxfont,
	["unit_frames_font_size"] = 8,
	["unit_frames_font_style"] = "OUTLINEMONOCHROME",
	["unit_frames_font_shadow"] = false,

	-- Auras font
	["auras_font"] = Viks.media.pxfont,
	["auras_font_size"] = 8,
	["auras_font_style"] = "OUTLINEMONOCHROME",
	["auras_font_shadow"] = false,

	-- Filger font
	["filger_font"] = Viks.media.pxfont,
	["filger_font_size"] = 8,
	["filger_font_style"] = "OUTLINEMONOCHROME",
	["filger_font_shadow"] = false,

	-- Stylization font
	["stylization_font"] = Viks.media.pxfont,
	["stylization_font_size"] = 8,
	["stylization_font_style"] = "OUTLINEMONOCHROME",
	["stylization_font_shadow"] = false,

	-- Bags font
	["bags_font"] = Viks.media.pxfont,
	["bags_font_size"] = 8,
	["bags_font_style"] = "OUTLINEMONOCHROME",
	["bags_font_shadow"] = false,
}

-- pet action icons
PET_DEFENSIVE_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_defensive]]
PET_ASSIST_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_aggressive]]
PET_PASSIVE_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_passive]]
PET_ATTACK_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_attack]]
PET_FOLLOW_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_follow]]
PET_WAIT_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_wait]]
PET_MOVE_TO_TEXTURE = [[Interface\Addons\ViksUI\Media\textures\icon_moveto]]

SLASH_RELOADUI1 = "/rl"
SLASH_RELOADUI2 = "/reloadui"
SlashCmdList.RELOADUI = ReloadUI

Viks["spacer"] = {} -- Just spacer for config menu



----------------------------------------------------------------------------------------
--	WORKING ON! Do NOT turn anything on!
----------------------------------------------------------------------------------------
Viks["WorkTemp"] = {
	["show_arena"] = true,	
	["class_bar_range"] = true,	
	["vengeance"] = true,	
}