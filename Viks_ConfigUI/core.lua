local realm = GetRealmName()
local name = UnitName("player")
local ALLOWED_GROUPS = {
	["general"] = 1,
	["misc"] = 2,
	["announcements"] = 3,	
	["automation"] = 4,
	["skins"] = 5,
	["combattext"] = 6,	
	["reminder"] = 7,
	["raidcooldown"] = 8,
	["enemycooldown"] = 9,
	["pulsecooldown"] = 11,
	["tooltip"] = 12,
	["chat"] = 13,
	["bag"] = 13,
	["minimapp"] = 14,
	["map"] = 15,
	["loot"] = 16,
	["nameplate"] = 17,
	["aura"] = 18,
	["unitframes"] = 19,
	["unitframe_class_bar"] = 20,
	["raidframes"] = 21,
	["toppanel"] = 22,	
	["cooldown"] = 23,
	["datatext"] = 24,
	["error"] = 25,
	["media"] = 26,
	["panels"] = 27,
	["stats"] = 28,
	["XPBar"] = 29,
}
local function Local(o)
	local T, Viks, L = unpack(ViksUI)
if o == "ViksConfigUIspacer" then o = "-------------------" end	
if o == "ViksConfigUIcooldown" then o = "Cooldown Timer" end
if o == "ViksConfigUIcooldownenable" then o = "Cooldown Timer on Items" end
	
-- Media
if o == "ViksConfigUImedia" then o = "MEDIA" end
if o == "ViksConfigUImediafont" then o = "Main Font In Viks UI" end
if o == "ViksConfigUImediafontcombat" then o = "Scrolling Combat Text Font" end
if o == "ViksConfigUImediapxfont" then o = "DataText Normal Font" end
if o == "ViksConfigUImediapxfontHeader" then o = "DataText Headers Font" end
if o == "ViksConfigUImediapxfontFlag" then o = "DataText Normal Flags" end
if o == "ViksConfigUImediapxfontHFlag" then o = "DataText Header Flags" end
if o == "ViksConfigUImediapxfontsize" then o = "DataText Normal Font Size" end
if o == "ViksConfigUImediapxfontHsize" then o = "DataText Header Font Size" end
if o == "ViksConfigUImediafontsize" then o = "Main Font Size" end
if o == "ViksConfigUImediabordercolor" then o = "Color on Borders" end
if o == "ViksConfigUImediabackdropcolor" then o = "Color on Background" end
if o == "ViksConfigUImediaoverlay_color" then o = "Color for action bars overlay" end
if o == "ViksConfigUImediatexture" then o = "Texture" end
if o == "ViksConfigUImediablank" then o = "Background Texture" end
if o == "ViksConfigUImediablank_border" then o = "Border" end
if o == "ViksConfigUImediahighlight" then o = "Highlight" end
if o == "ViksConfigUImediapxcolor1" then o = "DataText, Color on Names" end
if o == "ViksConfigUImediapxcolor2" then o = "DataText, Color on Values" end
if o == "ViksConfigUImediaoUFfont" then o = "Font on UnitFrames" end
if o == "ViksConfigUImediaoUFfontsize" then o = "Font Size on UnitFrames" end
if o == "ViksConfigUImediawhisp_sound" then o = "Sound for wispers" end
if o == "ViksConfigUImediawarning_sound" then o = "Sound for warning" end
if o == "ViksConfigUImediaproc_sound" then o = "Sound for procs" end

-- general
if o == "ViksConfigUIgeneral" then o = "GENERAL" end
if o == "ViksConfigUIgeneralAutoScale" then o = "Auto UI Scale" end
if o == "ViksConfigUIgeneralUiScale" then o = "UI Scale (if auto-scale is disabled)" end
if o == "ViksConfigUIgeneralAutoRepair" then o = "Auto Repair items" end
if o == "ViksConfigUIgeneralAutoRepairG" then o = "Auto Repair items uses Guild Repair" end
if o == "ViksConfigUIgeneralAutoGreed" then o = "Auto Greed" end													
if o == "ViksConfigUIgeneralAutoDisenchant" then o = "Auto Disenchant" end									  		  
if o == "ViksConfigUIgeneralAutoAcceptInvite" then o = "Enable Auto-Invite (Friends and Guildmates)" end
if o == "ViksConfigUIgeneralBlizzardsErrorFrameHiding" then o = "Hide spamming error at the middle of your screen" end

--	Announcements options
if o == "ViksConfigUIannouncements" then o = L_GUI_ANNOUNCEMENTS end
if o == "ViksConfigUIannouncementsdrinking" then o = L_GUI_ANNOUNCEMENTS_DRINKING end
if o == "ViksConfigUIannouncementsinterrupts" then o = L_GUI_ANNOUNCEMENTS_INTERRUPTS end
if o == "ViksConfigUIannouncementsspells" then o = L_GUI_ANNOUNCEMENTS_SPELLS end
if o == "ViksConfigUIannouncementsspells_from_all" then o = L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL end
if o == "ViksConfigUIannouncementslightwell" then o = L_GUI_ANNOUNCEMENTS_LIGHTWELL end
if o == "ViksConfigUIannouncementstoys" then o = L_GUI_ANNOUNCEMENTS_TOY_TRAIN end
if o == "ViksConfigUIannouncementssays_thanks" then o = L_GUI_ANNOUNCEMENTS_SAYS_THANKS end
if o == "ViksConfigUIannouncementspull_countdown" then o = L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN end
if o == "ViksConfigUIannouncementsflask_food" then o = L_GUI_ANNOUNCEMENTS_FLASK_FOOD end
if o == "ViksConfigUIannouncementsflask_food_auto" then o = L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO end
if o == "ViksConfigUIannouncementsflask_food_raid" then o = L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID end
if o == "ViksConfigUIannouncementsfeasts" then o = L_GUI_ANNOUNCEMENTS_FEASTS end
if o == "ViksConfigUIannouncementsportals" then o = L_GUI_ANNOUNCEMENTS_PORTALS end
if o == "ViksConfigUIannouncementsbad_gear" then o = L_GUI_ANNOUNCEMENTS_BAD_GEAR end

--	Automation options
if o == "ViksConfigUIautomation" then o = L_GUI_AUTOMATION end
if o == "ViksConfigUIautomationresurrection" then o = L_GUI_AUTOMATION_RESURRECTION end
if o == "ViksConfigUIautomationscreenshot" then o = L_GUI_AUTOMATION_SCREENSHOT end
if o == "ViksConfigUIautomationsolve_artifact" then o = L_GUI_AUTOMATION_SOLVE_ARTIFACT end
if o == "ViksConfigUIautomationchefs_hat" then o = L_GUI_AUTOMATION_CHEFS_HAT end
if o == "ViksConfigUIautomationsafari_hat" then o = L_GUI_AUTOMATION_SAFARI_HAT end
if o == "ViksConfigUIautomationaccept_invite" then o = L_GUI_AUTOMATION_ACCEPT_INVITE end
if o == "ViksConfigUIautomationdecline_duel" then o = L_GUI_AUTOMATION_DECLINE_DUEL end
if o == "ViksConfigUIautomationaccept_quest" then o = L_GUI_AUTOMATION_ACCEPT_QUEST end
if o == "ViksConfigUIautomationauto_collapse" then o = L_GUI_AUTOMATION_AUTO_COLLAPSE end
if o == "ViksConfigUIautomationskip_cinematic" then o = L_GUI_AUTOMATION_SKIP_CINEMATIC end
if o == "ViksConfigUIautomationauto_role" then o = L_GUI_AUTOMATION_AUTO_ROLE end
if o == "ViksConfigUIautomationcancel_bad_buffs" then o = L_GUI_AUTOMATION_CANCEL_BAD_BUFFS end
if o == "ViksConfigUIautomationtab_binder" then o = L_GUI_AUTOMATION_TAB_BINDER end
if o == "ViksConfigUIautomationlogging_combat" then o = L_GUI_AUTOMATION_LOGGING_COMBAT end
if o == "ViksConfigUIautomationcurrency_cap" then o = L_GUI_AUTOMATION_CURRENCY_CAP end
if o == "ViksConfigUIautomationbuff_on_scroll" then o = L_GUI_AUTOMATION_BUFF_ON_SCROLL end
if o == "ViksConfigUIautomationvendor" then o = "Auto sell grey items" end
if o == "ViksConfigUIautomationAutoRepair" then o = "Automaticly repair" end
if o == "ViksConfigUIautomationAutoRepairG" then o = "Automaticly repair and Use guild funds" end

-- Skins options
if o == "ViksConfigUIskins" then o = L_GUI_SKINS end
if o == "ViksConfigUIskinsblizzard_frames" then o = L_GUI_SKINS_BLIZZARD end
if o == "ViksConfigUIskinsminimap_buttons" then o = L_GUI_SKINS_MINIMAP_BUTTONS end
if o == "ViksConfigUIskinsclcret" then o = L_GUI_SKINS_CLCR end
if o == "ViksConfigUIskinsclcprot" then o = L_GUI_SKINS_CLCP end
if o == "ViksConfigUIskinscombustion_helper" then o = L_GUI_SKINS_COMBUSTION_HELPER end
if o == "ViksConfigUIskinsbigwigs" then o = L_GUI_SKINS_BW end
if o == "ViksConfigUIskinsdbm" then o = L_GUI_SKINS_DBM end
if o == "ViksConfigUIskinsdxe" then o = L_GUI_SKINS_DXE end
if o == "ViksConfigUIskinsomen" then o = L_GUI_SKINS_OMEN end
if o == "ViksConfigUIskinsrecount" then o = L_GUI_SKINS_RECOUNT end
if o == "ViksConfigUIskinsblood_shield_tracker" then o = L_GUI_SKINS_BLOOD_SHIELD_TRACKER end
if o == "ViksConfigUIskinsdominos" then o = L_GUI_SKINS_DOMINOS end
if o == "ViksConfigUIskinsflyout_button" then o = L_GUI_SKINS_FLYOUT_BUTTON end
if o == "ViksConfigUIskinsnug_running" then o = L_GUI_SKINS_NUG_RUNNING end
if o == "ViksConfigUIskinsovale" then o = L_GUI_SKINS_OVALE end
if o == "ViksConfigUIskinsclique" then o = L_GUI_SKINS_CLIQUE end
if o == "ViksConfigUIskinsace3" then o = L_GUI_SKINS_ACE3 end
if o == "ViksConfigUIskinspallypower" then o = L_GUI_SKINS_PP end
if o == "ViksConfigUIskinscapping" then o = L_GUI_SKINS_CAPPING end
if o == "ViksConfigUIskinscool_line" then o = L_GUI_SKINS_COOL_LINE end
if o == "ViksConfigUIskinsatlasloot" then o = L_GUI_SKINS_ATLASLOOT end
if o == "ViksConfigUIskinstiny_dps" then o = L_GUI_SKINS_TINY_DPS end
if o == "ViksConfigUIskinsface_shooter" then o = L_GUI_SKINS_FACE_SHOOTER end
if o == "ViksConfigUIskinsmage_nuggets" then o = L_GUI_SKINS_MAGE_NUGGETS end
if o == "ViksConfigUIskinsnpcscan" then o = L_GUI_SKINS_NPCSCAN end
if o == "ViksConfigUIskinsvanaskos" then o = L_GUI_SKINS_VANASKOS end
if o == "ViksConfigUIskinsweak_auras" then o = L_GUI_SKINS_WEAK_AURAS end
if o == "ViksConfigUIskinsskada" then o = L_GUI_SKINS_SKADA end
if o == "ViksConfigUIskinsmy_role_play" then o = L_GUI_SKINS_MY_ROLE_PLAY end

-- Combat text options
if o == "ViksConfigUIcombattext" then o = L_GUI_COMBATTEXT end
if o == "ViksConfigUIcombattextenable" then o = L_GUI_COMBATTEXT_ENABLE end
if o == "ViksConfigUIcombattextblizz_head_numbers" then o = L_GUI_COMBATTEXT_BLIZZ_HEAD_NUMBERS end
if o == "ViksConfigUIcombattextdamage_style" then o = L_GUI_COMBATTEXT_DAMAGE_STYLE end
if o == "ViksConfigUIcombattextdamage" then o = L_GUI_COMBATTEXT_DAMAGE end
if o == "ViksConfigUIcombattexthealing" then o = L_GUI_COMBATTEXT_HEALING end
if o == "ViksConfigUIcombattextshow_hots" then o = L_GUI_COMBATTEXT_HOTS end
if o == "ViksConfigUIcombattextshow_overhealing" then o = L_GUI_COMBATTEXT_OVERHEALING end
if o == "ViksConfigUIcombattextpet_damage" then o = L_GUI_COMBATTEXT_PET_DAMAGE end
if o == "ViksConfigUIcombattextdot_damage" then o = L_GUI_COMBATTEXT_DOT_DAMAGE end
if o == "ViksConfigUIcombattextdamage_color" then o = L_GUI_COMBATTEXT_DAMAGE_COLOR end
if o == "ViksConfigUIcombattextcrit_prefix" then o = L_GUI_COMBATTEXT_CRIT_PREFIX end
if o == "ViksConfigUIcombattextcrit_postfix" then o = L_GUI_COMBATTEXT_CRIT_POSTFIX end
if o == "ViksConfigUIcombattexticons" then o = L_GUI_COMBATTEXT_ICONS end
if o == "ViksConfigUIcombattexticon_size" then o = L_GUI_COMBATTEXT_ICON_SIZE end
if o == "ViksConfigUIcombattexttreshold" then o = L_GUI_COMBATTEXT_TRESHOLD end
if o == "ViksConfigUIcombattextheal_treshold" then o = L_GUI_COMBATTEXT_HEAL_TRESHOLD end
if o == "ViksConfigUIcombattextscrollable" then o = L_GUI_COMBATTEXT_SCROLLABLE end
if o == "ViksConfigUIcombattextmax_lines" then o = L_GUI_COMBATTEXT_MAX_LINES end
if o == "ViksConfigUIcombattexttime_visible" then o = L_GUI_COMBATTEXT_TIME_VISIBLE end
if o == "ViksConfigUIcombattextdk_runes" then o = L_GUI_COMBATTEXT_DK_RUNES end
if o == "ViksConfigUIcombattextkillingblow" then o = L_GUI_COMBATTEXT_KILLINGBLOW end
if o == "ViksConfigUIcombattextmerge_aoe_spam" then o = L_GUI_COMBATTEXT_MERGE_AOE_SPAM end
if o == "ViksConfigUIcombattextmerge_melee" then o = L_GUI_COMBATTEXT_MERGE_MELEE end
if o == "ViksConfigUIcombattextdispel" then o = L_GUI_COMBATTEXT_DISPEL end
if o == "ViksConfigUIcombattextinterrupt" then o = L_GUI_COMBATTEXT_INTERRUPT end
if o == "ViksConfigUIcombattextdirection" then o = L_GUI_COMBATTEXT_DIRECTION end

-- Buffs reminder options
if o == "ViksConfigUIreminder" then o = L_GUI_REMINDER end
if o == "ViksConfigUIremindersolo_buffs_enable" then o = L_GUI_REMINDER_SOLO_ENABLE end
if o == "ViksConfigUIremindersolo_buffs_sound" then o = L_GUI_REMINDER_SOLO_SOUND end
if o == "ViksConfigUIremindersolo_buffs_size" then o = L_GUI_REMINDER_SOLO_SIZE end
if o == "ViksConfigUIreminderraid_buffs_enable" then o = L_GUI_REMINDER_RAID_ENABLE end
if o == "ViksConfigUIreminderraid_buffs_always" then o = L_GUI_REMINDER_RAID_ALWAYS end
if o == "ViksConfigUIreminderraid_buffs_size" then o = L_GUI_REMINDER_RAID_SIZE end
if o == "ViksConfigUIreminderraid_buffs_alpha" then o = L_GUI_REMINDER_RAID_ALPHA end

-- Raid cooldowns options
if o == "ViksConfigUIraidcooldown" then o = L_GUI_COOLDOWN_RAID end
if o == "ViksConfigUIraidcooldownenable" then o = L_GUI_COOLDOWN_RAID_ENABLE end
if o == "ViksConfigUIraidcooldownheight" then o = L_GUI_COOLDOWN_RAID_HEIGHT end
if o == "ViksConfigUIraidcooldownwidth" then o = L_GUI_COOLDOWN_RAID_WIDTH end
if o == "ViksConfigUIraidcooldownupwards" then o = L_GUI_COOLDOWN_RAID_SORT end
if o == "ViksConfigUIraidcooldownexpiration" then o = L_GUI_COOLDOWN_RAID_EXPIRATION end
if o == "ViksConfigUIraidcooldownshow_my" then o = L_GUI_COOLDOWN_RAID_SHOW_MY end
if o == "ViksConfigUIraidcooldownshow_icon" then o = L_GUI_COOLDOWN_RAID_ICONS end
if o == "ViksConfigUIraidcooldownshow_inraid" then o = L_GUI_COOLDOWN_RAID_IN_RAID end
if o == "ViksConfigUIraidcooldownshow_inparty" then o = L_GUI_COOLDOWN_RAID_IN_PARTY end
if o == "ViksConfigUIraidcooldownshow_inarena" then o = L_GUI_COOLDOWN_RAID_IN_ARENA end

-- Enemy cooldowns options
if o == "ViksConfigUIenemycooldown" then o = L_GUI_COOLDOWN_ENEMY end
if o == "ViksConfigUIenemycooldownenable" then o = L_GUI_COOLDOWN_ENEMY_ENABLE end
if o == "ViksConfigUIenemycooldownsize" then o = L_GUI_COOLDOWN_ENEMY_SIZE end
if o == "ViksConfigUIenemycooldowndirection" then o = L_GUI_COOLDOWN_ENEMY_DIRECTION end
if o == "ViksConfigUIenemycooldownshow_always" then o = L_GUI_COOLDOWN_ENEMY_EVERYWHERE end
if o == "ViksConfigUIenemycooldownshow_inpvp" then o = L_GUI_COOLDOWN_ENEMY_IN_BG end
if o == "ViksConfigUIenemycooldownshow_inarena" then o = L_GUI_COOLDOWN_ENEMY_IN_ARENA end

-- Pulse cooldown options
if o == "ViksConfigUIpulsecooldown" then o = L_GUI_COOLDOWN_PULSE end
if o == "ViksConfigUIpulsecooldownenable" then o = L_GUI_COOLDOWN_PULSE_ENABLE end
if o == "ViksConfigUIpulsecooldownsize" then o = L_GUI_COOLDOWN_PULSE_SIZE end
if o == "ViksConfigUIpulsecooldownsound" then o = L_GUI_COOLDOWN_PULSE_SOUND end
if o == "ViksConfigUIpulsecooldownanim_scale" then o = L_GUI_COOLDOWN_PULSE_ANIM_SCALE end
if o == "ViksConfigUIpulsecooldownhold_time" then o = L_GUI_COOLDOWN_PULSE_HOLD_TIME end
if o == "ViksConfigUIpulsecooldownthreshold" then o = L_GUI_COOLDOWN_PULSE_THRESHOLD end

-- Threat options
if o == "ViksConfigUIthreat" then o = L_GUI_THREAT end
if o == "ViksConfigUIthreatenable" then o = L_GUI_THREAT_ENABLE end
if o == "ViksConfigUIthreatheight" then o = L_GUI_THREAT_HEIGHT end
if o == "ViksConfigUIthreatwidth" then o = L_GUI_THREAT_WIDTH end
if o == "ViksConfigUIthreatbar_rows" then o = L_GUI_THREAT_ROWS end
if o == "ViksConfigUIthreathide_solo" then o = L_GUI_THREAT_HIDE_SOLO end

-- Tooltip options
if o == "ViksConfigUItooltip" then o = L_GUI_TOOLTIP end
if o == "ViksConfigUItooltipenable" then o = L_GUI_TOOLTIP_ENABLE end
if o == "ViksConfigUItooltipshift_modifer" then o = L_GUI_TOOLTIP_SHIFT end
if o == "ViksConfigUItooltipcursor" then o = L_GUI_TOOLTIP_CURSOR end
if o == "ViksConfigUItooltipitem_icon" then o = L_GUI_TOOLTIP_ICON end
if o == "ViksConfigUItooltiphealth_value" then o = L_GUI_TOOLTIP_HEALTH end
if o == "ViksConfigUItooltiphidebuttons" then o = L_GUI_TOOLTIP_HIDE end
if o == "ViksConfigUItooltiphide_combat" then o = L_GUI_TOOLTIP_HIDE_COMBAT end
if o == "ViksConfigUItooltiptalents" then o = L_GUI_TOOLTIP_TALENTS end
if o == "ViksConfigUItooltipachievements" then o = L_GUI_TOOLTIP_ACHIEVEMENTS end
if o == "ViksConfigUItooltiptarget" then o = L_GUI_TOOLTIP_TARGET end
if o == "ViksConfigUItooltiptitle" then o = L_GUI_TOOLTIP_TITLE end
if o == "ViksConfigUItooltiprank" then o = L_GUI_TOOLTIP_RANK end
if o == "ViksConfigUItooltiparena_experience" then o = L_GUI_TOOLTIP_ARENA_EXPERIENCE end
if o == "ViksConfigUItooltipspell_id" then o = L_GUI_TOOLTIP_SPELL_ID end
if o == "ViksConfigUItooltipaverage_lvl" then o = STAT_AVERAGE_ITEM_LEVEL end
if o == "ViksConfigUItooltipraid_icon" then o = L_GUI_TOOLTIP_RAID_ICON end
if o == "ViksConfigUItooltipwho_targetting" then o = L_GUI_TOOLTIP_WHO_TARGETTING end
if o == "ViksConfigUItooltipitem_count" then o = L_GUI_TOOLTIP_ITEM_COUNT end
if o == "ViksConfigUItooltipunit_role" then o = L_GUI_TOOLTIP_UNIT_ROLE end
if o == "ViksConfigUItooltipinstance_lock" then o = L_GUI_TOOLTIP_INSTANCE_LOCK end
if o == "ViksConfigUItooltipitem_transmogrify" then o = L_GUI_TOOLTIP_ITEM_TRANSMOGRIFY end
if o == "ViksConfigUItooltipbottomleft" then o = "Tooltip shows from BottomLeft of /ui anchor " end
if o == "ViksConfigUItooltipbottomright" then o = "Tooltip shows from Bottomright of /ui anchor " end
if o == "ViksConfigUItooltiptopright" then o = "Tooltip shows from Top Right of /ui anchor " end
if o == "ViksConfigUItooltiptopleft" then o = "Tooltip shows from Top Left of /ui anchor " end

--	Chat options
if o == "ViksConfigUIchat" then o = "CHAT" end
if o == "ViksConfigUIchatenable" then o = L_GUI_CHAT_ENABLE end
if o == "ViksConfigUIchatbackground" then o = L_GUI_CHAT_BACKGROUND end
if o == "ViksConfigUIchatbackground_alpha" then o = L_GUI_CHAT_BACKGROUND_ALPHA end
if o == "ViksConfigUIchatfilter" then o = L_GUI_CHAT_SPAM end
if o == "ViksConfigUIchatspam" then o = L_GUI_CHAT_GOLD end
if o == "ViksConfigUIchatwidth" then o = L_GUI_CHAT_WIDTH end
if o == "ViksConfigUIchatheight" then o = L_GUI_CHAT_HEIGHT end
if o == "ViksConfigUIchatchat_bar" then o = L_GUI_CHAT_BAR end
if o == "ViksConfigUIchatchat_bar_mouseover" then o = L_GUI_CHAT_BAR_MOUSEOVER end
if o == "ViksConfigUIchattime_color" then o = L_GUI_CHAT_TIMESTAMP end
if o == "ViksConfigUIchatwhisp_sound" then o = L_GUI_CHAT_WHISP end
if o == "ViksConfigUIchatbubbles" then o = L_GUI_CHAT_SKIN_BUBBLE end
if o == "ViksConfigUIchattransp_bubbles" then o = L_GUI_CHAT_SKIN_BUBBLE_TRANS end
if o == "ViksConfigUIchattransp_bubbles_a" then o = L_GUI_CHAT_SKIN_BUBBLE_TRANS_A end
if o == "ViksConfigUIchatcombatlog" then o = L_GUI_CHAT_CL_TAB end
if o == "ViksConfigUIchattabs_mouseover" then o = L_GUI_CHAT_TABS_MOUSEOVER end
if o == "ViksConfigUIchatsticky" then o = L_GUI_CHAT_STICKY end
if o == "ViksConfigUIchatdamage_meter_spam" then o = L_GUI_CHAT_DAMAGE_METER_SPAM end
if o == "ViksConfigUIchatsmileys" then o = "Use custom Smileys/icon in chat"  end

--	Bag options
if o == "ViksConfigUIbag" then o = L_GUI_BAGS end
if o == "ViksConfigUIbagenable" then o = L_GUI_BAGS_ENABLE end
if o == "ViksConfigUIbagBagBars" then o = "Bag Bars" end
if o == "ViksConfigUIbagSortTop" then o = "Sort from top down" end
if o == "ViksConfigUIbagbutton_size" then o = L_GUI_BAGS_BUTTON_SIZE end
if o == "ViksConfigUIbagbutton_space" then o = L_GUI_BAGS_BUTTON_SPACE end
if o == "ViksConfigUIbagbank_columns" then o = L_GUI_BAGS_BANK end
if o == "ViksConfigUIbagbag_columns" then o = L_GUI_BAGS_BAG end	
-- Minimap
if o == "ViksConfigUIminimapp" then o = "MINIMAP" end
if o == "ViksConfigUIminimappenable" then o = "Enable Minimap" end
if o == "ViksConfigUIminimappminimb1" then o = "Enable Buttonframe 1" end
if o == "ViksConfigUIminimappminimb2" then o = "Enable Buttonframe 2" end
if o == "ViksConfigUIminimappPicomenu" then o = "Enable Picomenu" end
if o == "ViksConfigUIminimappcompass" then o = "Enable Compass" end
if o == "ViksConfigUIminimappsize" then o = "Size on Minimap" end
if o == "ViksConfigUImap" then o = ViksL.option_Map end
if o == "ViksConfigUImapenable" then o = ViksL.option_mapenable end	
-- Map options
if o == "ViksConfigUImap" then o = WORLD_MAP end
if o == "ViksConfigUImapbg_map_stylization" then o = L_GUI_MAP_BG_STYLIZATION end
if o == "ViksConfigUImapmap_boss_count" then o = L_GUI_MAP_BOSS_COUNT end
if o == "ViksConfigUImapexplore_map" then o = L_GUI_MAP_EXPLORE end
if o == "ViksConfigUImapfog_of_war" then o = L_GUI_MAP_FOG_OF_WAR end

-- Loot options
if o == "ViksConfigUIloot" then o = LOOT end
if o == "ViksConfigUIlootlootframe" then o = L_GUI_LOOT_ENABLE end
if o == "ViksConfigUIlootrolllootframe" then o = L_GUI_LOOT_ROLL_ENABLE end
if o == "ViksConfigUIlooticon_size" then o = L_GUI_LOOT_ICON_SIZE end
if o == "ViksConfigUIlootwidth" then o = L_GUI_LOOT_WIDTH end
if o == "ViksConfigUIlootauto_greed" then o = L_GUI_LOOT_AUTOGREED end
if o == "ViksConfigUIlootauto_confirm_de" then o = L_GUI_LOOT_AUTODE end

-- Nameplate options
if o == "ViksConfigUInameplate" then o = UNIT_NAMEPLATES end
if o == "ViksConfigUInameplateenable" then o = L_GUI_NAMEPLATE_ENABLE end
if o == "ViksConfigUInameplateheight" then o = L_GUI_NAMEPLATE_HEIGHT end
if o == "ViksConfigUInameplatewidth" then o = L_GUI_NAMEPLATE_WIDTH end
if o == "ViksConfigUInameplatead_height" then o = L_GUI_NAMEPLATE_AD_HEIGHT end
if o == "ViksConfigUInameplatead_width" then o = L_GUI_NAMEPLATE_AD_WIDTH end
if o == "ViksConfigUInameplatecombat" then o = L_GUI_NAMEPLATE_COMBAT end
if o == "ViksConfigUInameplatehealth_value" then o = L_GUI_NAMEPLATE_HEALTH end
if o == "ViksConfigUInameplateshow_castbar" then o = L_GUI_NAMEPLATE_CASTBAR end
if o == "ViksConfigUInameplateshow_castbar_name" then o = L_GUI_NAMEPLATE_CASTBAR_NAME end
if o == "ViksConfigUInameplateenhance_threat" then o = L_GUI_NAMEPLATE_THREAT end
if o == "ViksConfigUInameplateclass_icons" then o = L_GUI_NAMEPLATE_CLASS_ICON end
if o == "ViksConfigUInameplatename_abbrev" then o = L_GUI_NAMEPLATE_NAME_ABBREV end
if o == "ViksConfigUInameplategood_color" then o = L_GUI_NAMEPLATE_GOOD_COLOR end
if o == "ViksConfigUInameplatenear_color" then o = L_GUI_NAMEPLATE_NEAR_COLOR end
if o == "ViksConfigUInameplatebad_color" then o = L_GUI_NAMEPLATE_BAD_COLOR end
if o == "ViksConfigUInameplatetrack_auras" then o = L_GUI_NAMEPLATE_SHOW_DEBUFFS end
if o == "ViksConfigUInameplateauras_size" then o = L_GUI_NAMEPLATE_DEBUFFS_SIZE end
if o == "ViksConfigUInameplatehealer_icon" then o = L_GUI_NAMEPLATE_HEALER_ICON end	

--	Auras/Buffs/Debuffs options
if o == "ViksConfigUIaura" then o = BUFFOPTIONS_LABEL end
if o == "ViksConfigUIauraplayer_buff_size" then o = L_GUI_AURA_PLAYER_BUFF_SIZE end
if o == "ViksConfigUIauraplayer_debuff_size" then o = "Player DeBuff Size" end
if o == "ViksConfigUIaurashow_spiral" then o = L_GUI_AURA_SHOW_SPIRAL end
if o == "ViksConfigUIaurashow_timer" then o = L_GUI_AURA_SHOW_TIMER end
if o == "ViksConfigUIauraplayer_auras" then o = L_GUI_AURA_PLAYER_AURAS end
if o == "ViksConfigUIauratarget_auras" then o = L_GUI_AURA_TARGET_AURAS end
if o == "ViksConfigUIaurafocus_debuffs" then o = L_GUI_AURA_FOCUS_DEBUFFS end
if o == "ViksConfigUIaurafot_debuffs" then o = L_GUI_AURA_FOT_DEBUFFS end
if o == "ViksConfigUIaurapet_debuffs" then o = L_GUI_AURA_PET_DEBUFFS end
if o == "ViksConfigUIauratot_debuffs" then o = L_GUI_AURA_TOT_DEBUFFS end
if o == "ViksConfigUIauraboss_buffs" then o = L_GUI_AURA_BOSS_BUFFS end
if o == "ViksConfigUIauraplayer_aura_only" then o = L_GUI_AURA_PLAYER_AURA_ONLY end
if o == "ViksConfigUIauradebuff_color_type" then o = L_GUI_AURA_DEBUFF_COLOR_TYPE end
if o == "ViksConfigUIauraclasscolor_border" then o = "Enable classcolor border for player buffs" end
if o == "ViksConfigUIauracast_by" then o = L_GUI_AURA_CAST_BY end	

-- Unitframes
if o == "ViksConfigUIunitframes" then o = "UNIT FRAMES" end
if o == "ViksConfigUIunitframesenable" then o = ViksL.option_unitframes_enable end
if o == "ViksConfigUIunitframesShowIncHeals" then o = "Show Incomming heals" end
if o == "ViksConfigUIunitframesHealFrames" then o = ViksL.option_unitframes_HealFrames end
if o == "ViksConfigUIunitframesshowIndicators" then o = ViksL.option_unitframes_showIndicators end
if o == "ViksConfigUIunitframesshowAuraWatch" then o = ViksL.option_unitframes_showAuraWatch end
if o == "ViksConfigUIunitframesShowParty" then o = ViksL.option_unitframes_ShowParty end
if o == "ViksConfigUIunitframesShowRaid" then o = ViksL.option_unitframes_ShowRaid end
if o == "ViksConfigUIunitframesRaidShowSolo" then o = ViksL.option_unitframes_RaidShowSolo end
if o == "ViksConfigUIunitframesRaidShowAllGroups" then o = ViksL.option_unitframes_RaidShowAllGroups end
if o == "ViksConfigUIunitframesenableDebuffHighlight" then o = ViksL.option_unitframes_enableDebuffHighlight end
if o == "ViksConfigUIunitframesshowRaidDebuffs" then o = ViksL.option_unitframes_showRaidDebuffs end
if o == "ViksConfigUIunitframesshowtot" then o = ViksL.option_unitframes_showtot end
if o == "ViksConfigUIunitframesshowpet" then o = ViksL.option_unitframes_showpet end
if o == "ViksConfigUIunitframesshowfocus" then o = ViksL.option_unitframes_showfocus end
if o == "ViksConfigUIunitframesshowfocustarget" then o = ViksL.option_unitframes_showfocustarget end
if o == "ViksConfigUIunitframesshowBossFrames" then o = ViksL.option_unitframes_showBossFrames end
if o == "ViksConfigUIunitframesTotemBars" then o = ViksL.option_unitframes_TotemBars end
if o == "ViksConfigUIunitframesMTFrames" then o = ViksL.option_unitframes_MTFrames end
if o == "ViksConfigUIunitframesArenaFrames" then o = ViksL.option_unitframes_ArenaFrames end
if o == "ViksConfigUIunitframesReputationbar" then o = ViksL.option_unitframes_Reputationbar end
if o == "ViksConfigUIunitframesExperiencebar" then o = ViksL.option_unitframes_Experiencebar end
if o == "ViksConfigUIunitframesshowPlayerAuras" then o = ViksL.option_unitframes_showPlayerAuras end
if o == "ViksConfigUIunitframesThreatBar" then o = ViksL.option_unitframes_ThreatBar end
if o == "ViksConfigUIunitframesshowPortrait" then o = ViksL.option_unitframes_showPortrait end
if o == "ViksConfigUIunitframesshowRunebar" then o = ViksL.option_unitframes_showRunebar end
if o == "ViksConfigUIunitframesshowHolybar" then o = ViksL.option_unitframes_showHolybar end
if o == "ViksConfigUIunitframesshowEclipsebar" then o = ViksL.option_unitframes_showEclipsebar end
if o == "ViksConfigUIunitframesshowShardbar" then o = ViksL.option_unitframes_showShardbar end
if o == "ViksConfigUIunitframesRCheckIcon" then o = ViksL.option_unitframes_RCheckIcon end
if o == "ViksConfigUIunitframesCastbars" then o = ViksL.option_unitframes_Castbars end
if o == "ViksConfigUIunitframesshowLFDIcons" then o = ViksL.option_unitframes_showLFDIcons end
if o == "ViksConfigUIunitframesshowPartyFrames" then o = ViksL.option_unitframes_showPartyFrames end
if o == "ViksConfigUIunitframesHealthcolorClass" then o = ViksL.option_unitframes_HealthcolorClass end
if o == "ViksConfigUIunitframesPowercolor" then o = ViksL.option_unitframes_Powercolor end
if o == "ViksConfigUIunitframesbigcastbar" then o = ViksL.option_unitframes_bigcastbar end
if o == "ViksConfigUIunitframesIndicatorIcons2" then o = "Show Indicator Type 2" end
if o == "ViksConfigUIunitframesVuhDo" then o = "Hide Raidframes if VuhDo Addon is loaded" end
if o == "ViksConfigUIunitframesshowHarmony" then o = "Show Monk Harmony bar" end
if o == "ViksConfigUIunitframesshowPortraitHPbar" then o = "Show portraits on Healthbar" end
if o == "ViksConfigUIunitframesbuffsOnlyShowPlayer" then o = "Only show your buffs" end
if o == "ViksConfigUIunitframesshowShadowOrbsBar" then o = "Show Shadow Priest Shadow Orbs bar" end
if o == "ViksConfigUIunitframescustomLFDIcons" then o = "Use Custom Roll Icons; custom Roll Text must be off" end
if o == "ViksConfigUIunitframesinsideAlpha" then o = "Alpha when Unitframe is in range" end
if o == "ViksConfigUIunitframesoutsideAlpha" then o = "Alpha when Unitframe is out of range" end
if o == "ViksConfigUIunitframesFindoutline" then o = "Outline on Indicators" end
if o == "ViksConfigUIunitframesfontsizeEdge" then o = "Font Size on misk tags" end
if o == "ViksConfigUIunitframesUFNamefont" then o = "Font to use on Names" end
if o == "ViksConfigUIunitframesaurasize" then o = "Size on Auras" end
if o == "ViksConfigUIunitframessymbolsize" then o = "Size on Symbols on Indicator type 2" end
if o == "ViksConfigUIunitframesindicatorsize" then o = "Size on Squares on Indicator type 2" end
if o == "ViksConfigUIunitframescustomLFDText" then o = "Use Text instead of Icon; Tank/Dps/Heal. Custom Roll Icons must be off" end
if o == "ViksConfigUIunitframesdebuffsOnlyShowPlayer" then o = "Only show your debuffs on target" end
if o == "ViksConfigUIunitframesUFfont" then o = "Font on unitframes tags (Hp/power++)" end

-- Unit Frames Class bar options
if o == "ViksConfigUIunitframe_class_bar" then o = L_GUI_UF_PLUGINS_CLASS_BAR end
if o == "ViksConfigUIunitframe_class_barcombo" then o = L_GUI_UF_PLUGINS_COMBO_BAR end
if o == "ViksConfigUIunitframe_class_barshadow" then o = L_GUI_UF_PLUGINS_SHADOW_BAR end
if o == "ViksConfigUIunitframe_class_barchi" then o = L_GUI_UF_PLUGINS_CHI_BAR end
if o == "ViksConfigUIunitframe_class_barvengeance" then o = L_GUI_UF_PLUGINS_VENGEANCE_BAR end
if o == "ViksConfigUIunitframe_class_bareclipse" then o = L_GUI_UF_PLUGINS_ECLIPSE_BAR end
if o == "ViksConfigUIunitframe_class_barholy" then o = L_GUI_UF_PLUGINS_HOLY_BAR end
if o == "ViksConfigUIunitframe_class_barshard" then o = L_GUI_UF_PLUGINS_SHARD_BAR end
if o == "ViksConfigUIunitframe_class_barrune" then o = L_GUI_UF_PLUGINS_RUNE_BAR end
if o == "ViksConfigUIunitframe_class_bartotem" then o = L_GUI_UF_PLUGINS_TOTEM_BAR end
if o == "ViksConfigUIunitframe_class_barrange" then o = L_GUI_UF_PLUGINS_RANGE_BAR end
	
--raidframes
if o == "ViksConfigUIraidframes" then o = "RAID FRAMES" end
if o == "ViksConfigUIraidframesenable" then o = ViksL.option_raidframes_enable end
if o == "ViksConfigUIraidframesscale" then o = ViksL.option_raidframes_scale end
if o == "ViksConfigUIraidframeswidth" then o = ViksL.option_raidframes_width end
if o == "ViksConfigUIraidframesheight" then o = ViksL.option_raidframes_height end
if o == "ViksConfigUIraidframesheight25" then o = "Hight on Raidframes in 25man" end
if o == "ViksConfigUIraidframeswidth25" then o = "Width on Raidframes in 25man" end
if o == "ViksConfigUIraidframesheight40" then o = "Hight on Raidframes in 40man" end
if o == "ViksConfigUIraidframeswidth40" then o = "Width on Raidframes in 40man" end
if o == "ViksConfigUIraidframesautorez" then o = "Auto cast Rez" end
if o == "ViksConfigUIraidframesfontsize" then o = ViksL.option_raidframes_fontsize end
if o == "ViksConfigUIraidframesfontsizeEdge" then o = ViksL.option_raidframes_fontsizeEdge end
if o == "ViksConfigUIraidframesoutline" then o = ViksL.option_raidframes_outline end
if o == "ViksConfigUIraidframessolo" then o = ViksL.option_raidframes_solo end
if o == "ViksConfigUIraidframesplayer" then o = ViksL.option_raidframes_player end
if o == "ViksConfigUIraidframesparty" then o = ViksL.option_raidframes_party end
if o == "ViksConfigUIraidframesnumCol" then o = ViksL.option_raidframes_numCol end
if o == "ViksConfigUIraidframesnumUnits" then o = ViksL.option_raidframes_numUnits end
if o == "ViksConfigUIraidframesspacing" then o = ViksL.option_raidframes_spacing end
if o == "ViksConfigUIraidframesorientation" then o = ViksL.option_raidframes_orientation end
if o == "ViksConfigUIraidframesporientation" then o = ViksL.option_raidframes_porientation end
if o == "ViksConfigUIraidframeshorizontal" then o = ViksL.option_raidframes_horizontal end
if o == "ViksConfigUIraidframesgrowth" then o = ViksL.option_raidframes_growth end
if o == "ViksConfigUIraidframesreversecolors" then o = ViksL.option_raidframes_reversecolors end
if o == "ViksConfigUIraidframesdefinecolors" then o = ViksL.option_raidframes_definecolors end
if o == "ViksConfigUIraidframespowerbar" then o = ViksL.option_raidframes_powerbar end
if o == "ViksConfigUIraidframespowerbarsize" then o = ViksL.option_raidframes_powerbarsize end
if o == "ViksConfigUIraidframesoutsideRange" then o = ViksL.option_raidframes_outsideRange end
if o == "ViksConfigUIraidframeshealtext" then o = ViksL.option_raidframes_healtext end
if o == "ViksConfigUIraidframeshealbar" then o = ViksL.option_raidframes_healbar end
if o == "ViksConfigUIraidframeshealoverflow" then o = ViksL.option_raidframes_healoverflow end
if o == "ViksConfigUIraidframeshealothersonly" then o = ViksL.option_raidframes_healothersonly end
if o == "ViksConfigUIraidframeshealalpha" then o = ViksL.option_raidframes_healalpha end
if o == "ViksConfigUIraidframesroleicon" then o = ViksL.option_raidframes_roleicon end
if o == "ViksConfigUIraidframesindicatorsize" then o = ViksL.option_raidframes_indicatorsize end
if o == "ViksConfigUIraidframessymbolsize" then o = ViksL.option_raidframes_symbolsize end
if o == "ViksConfigUIraidframesleadersize" then o = ViksL.option_raidframes_leadersize end
if o == "ViksConfigUIraidframesaurasize" then o = ViksL.option_raidframes_aurasize end
if o == "ViksConfigUIraidframesmulti" then o = ViksL.option_raidframes_multi end
if o == "ViksConfigUIraidframesmulti" then o = ViksL.option_raidframes_multi end
if o == "ViksConfigUIraidframesdeficit" then o = ViksL.option_raidframes_deficit end
if o == "ViksConfigUIraidframesperc" then o = ViksL.option_raidframes_perc end
if o == "ViksConfigUIraidframesactual" then o = ViksL.option_raidframes_actual end
if o == "ViksConfigUIraidframesmyhealcolor" then o = ViksL.option_raidframes_myhealcolor end
if o == "ViksConfigUIraidframesotherhealcolor" then o = ViksL.option_raidframes_otherhealcolor end
if o == "ViksConfigUIraidframeshpcolor" then o = ViksL.option_raidframes_hpcolor end
if o == "ViksConfigUIraidframeshpbgcolor" then o = ViksL.option_raidframes_hpbgcolor end
if o == "ViksConfigUIraidframespowercolor" then o = ViksL.option_raidframes_powercolor end
if o == "ViksConfigUIraidframespowerbgcolor" then o = ViksL.option_raidframes_powerbgcolor end
if o == "ViksConfigUIraidframespowerdefinecolors" then o = ViksL.option_raidframes_powerdefinecolors end
if o == "ViksConfigUIraidframescolorSmooth" then o = ViksL.option_raidframes_colorSmooth end
if o == "ViksConfigUIraidframesgradient" then o = ViksL.option_raidframes_gradient end
if o == "ViksConfigUIraidframestborder" then o = ViksL.option_raidframes_tborder end
if o == "ViksConfigUIraidframesfborder" then o = ViksL.option_raidframes_fborder end
if o == "ViksConfigUIraidframesafk" then o = ViksL.option_raidframes_afk end
if o == "ViksConfigUIraidframeshighlight" then o = ViksL.option_raidframes_highlight end
if o == "ViksConfigUIraidframesdispel" then o = ViksL.option_raidframes_dispel end
if o == "ViksConfigUIraidframespowerclass" then o = ViksL.option_raidframes_powerclass end
if o == "ViksConfigUIraidframestooltip" then o = ViksL.option_raidframes_tooltip end
if o == "ViksConfigUIraidframessortName" then o = ViksL.option_raidframes_sortName end
if o == "ViksConfigUIraidframessortClass" then o = ViksL.option_raidframes_sortClass end
if o == "ViksConfigUIraidframesclassOrder" then o = ViksL.option_raidframes_classOrder end
if o == "ViksConfigUIraidframeshidemenu" then o = ViksL.option_raidframes_hidemenu end
if o == "ViksConfigUIraidframesshowIndicators" then o = "Show Buff Indicators" end	
-- TopPanel options (mouse hidden)
if o == "ViksConfigUItoppanel" then o = L_GUI_TOP_PANEL end
if o == "ViksConfigUItoppanelenable" then o = L_GUI_TOP_PANEL_ENABLE end
if o == "ViksConfigUItoppanelmouseover" then o = L_GUI_TOP_PANEL_MOUSE end
if o == "ViksConfigUItoppanelheight" then o = L_GUI_TOP_PANEL_HEIGHT end
if o == "ViksConfigUItoppanelwidth" then o = L_GUI_TOP_PANEL_WIDTH end
-- Stats options
if o == "ViksConfigUIstats" then o = L_GUI_STATS end
if o == "ViksConfigUIstatsbattleground" then o = L_GUI_STATS_BG end
if o == "ViksConfigUIstatsclock" then o = L_GUI_STATS_CLOCK end
if o == "ViksConfigUIstatslatency" then o = L_GUI_STATS_LATENCY end
if o == "ViksConfigUIstatsmemory" then o = L_GUI_STATS_MEMORY end
if o == "ViksConfigUIstatsfps" then o = L_GUI_STATS_FPS end
if o == "ViksConfigUIstatsfriend" then o = FRIENDS end
if o == "ViksConfigUIstatsguild" then o = GUILD end
if o == "ViksConfigUIstatsdurability" then o = DURABILITY end
if o == "ViksConfigUIstatsexperience" then o = L_GUI_STATS_EXPERIENCE end
if o == "ViksConfigUIstatscoords" then o = L_GUI_STATS_COORDS end
if o == "ViksConfigUIstatslocation" then o = L_GUI_STATS_LOCATION end
-- Error options
if o == "ViksConfigUIerror" then o = L_GUI_ERROR end
if o == "ViksConfigUIerrorblack" then o = L_GUI_ERROR_BLACK end
if o == "ViksConfigUIerrorwhite" then o = L_GUI_ERROR_WHITE end
if o == "ViksConfigUIerrorcombat" then o = L_GUI_ERROR_HIDE_COMBAT end

--datatext
if o == "ViksConfigUIdatatext" then o = "DATA TEXT" end
if o == "ViksConfigUIdatatextArena" then o = "Arena position (0 for disabled)" end
if o == "ViksConfigUIdatatextArmor" then o = "Armor position (0 for disabled)" end
if o == "ViksConfigUIdatatextAvd" then o = "Avoidance position (0 for disabled)" end
if o == "ViksConfigUIdatatextBags" then o = "Bags position (0 for disabled)" end
if o == "ViksConfigUIdatatextBattleground" then o = "Battleground Stats" end
if o == "ViksConfigUIdatatextCrit" then o = "Crit position (0 for disabled)" end
if o == "ViksConfigUIdatatextDurability" then o = "Durability position (0 for disabled)" end
if o == "ViksConfigUIdatatextFriends" then o = "Friends position (0 for disabled)" end
if o == "ViksConfigUIdatatextGold" then o = "Gold position (0 for disabled)" end
if o == "ViksConfigUIdatatextGuild" then o = "Guild position (0 for disabled)" end
if o == "ViksConfigUIdatatextHaste" then o = "Haste position (0 for disabled)" end
if o == "ViksConfigUIdatatextVersatility" then o = "Versatility position (0 for disabled)" end
if o == "ViksConfigUIdatatextMastery" then o = "Mastery position (0 for disabled)" end
if o == "ViksConfigUIdatatextPower" then o = "Power stat position (0 for disabled)" end
if o == "ViksConfigUIdatatextRegen" then o = "Regen position (0 for disabled)" end
if o == "ViksConfigUIdatatextSystem" then o = "Latency and FPS position (0 for disabled)" end
if o == "ViksConfigUIdatatextlocation" then o = "Location and cords (0 for disabled)" end
if o == "ViksConfigUIdatatextTalents" then o = "Talent" end
if o == "ViksConfigUIdatatexttogglemenu" then o = "ToggleMenu" end
if o == "ViksConfigUIdatatextWowtime" then o = "Show Clock" end
if o == "ViksConfigUIdatatextTime24" then o = "Enable 24h time" end
if o == "ViksConfigUIdatatextLocaltime" then o = "Use Local Time instead of Server Time" end
if o == "ViksConfigUIdatatextclasscolor" then o = "Class color data text" end
if o == "ViksConfigUIdatatextcolor" then o = "If Class color data text false then choose color: " end	

--Actionbars	
if o == "ViksConfigUIactionbar" then o = ViksL.option_actionbar end
if o == "ViksConfigUIactionbarenable" then o = ViksL.option_actionbar_enable end
if o == "ViksConfigUIactionbarhotkey" then o = ViksL.option_actionbar_hotkey end
if o == "ViksConfigUIactionbarhideshapeshift" then o = ViksL.option_actionbar_hideshapeshift end
if o == "ViksConfigUIactionbarbuttonsize" then o = ViksL.option_actionbar_buttonsize end
if o == "ViksConfigUIactionbarbuttonspacing" then o = ViksL.option_actionbar_buttonspacing end
if o == "ViksConfigUIactionbarpetbuttonsize" then o = ViksL.option_actionbar_petbuttonsize end
if o == "ViksConfigUIactionbarpetbuttonspacing" then o = ViksL.option_actionbar_petbuttonspacing end
if o == "ViksConfigUIactionbarshowgrid" then o = ViksL.option_actionbar_showgrid end	
if o == "ViksConfigUIactionbarmainbarWidth" then o = ViksL.option_actionbar_mainbarWidth end
if o == "ViksConfigUIactionbarownshdbar" then o = ViksL.option_actionbar_ownshdbar end
if o == "ViksConfigUIactionbarlowversion" then o = ViksL.option_actionbar_lowversion end
if o == "ViksConfigUIactionbarsidebarWidth" then o = ViksL.option_actionbar_sidebarWidth end
--XPBar
if o == "ViksConfigUIXPBar" then o = "XP BAR" end
if o == "ViksConfigUIXPBarenable" then o = "Enable XP BAR" end
if o == "ViksConfigUIXPBarpos1" then o = "Place into the Cooldown frame" end
if o == "ViksConfigUIXPBarpos2" then o = "Anchor to /ui" end
if o == "ViksConfigUIXPBarheight" then o = "Height of XP Bar" end
if o == "ViksConfigUIXPBarwidth" then o = "Width of XP Bar" end
if o == "ViksConfigUIXPBartext" then o = "Enable text on XP BAR" end
if o == "ViksConfigUIXPBarmouse" then o = "Only display text on mouseover" end

--	Miscellaneous options
if o == "ViksConfigUImisc" then o = "Miscellaneous" end
if o == "ViksConfigUImiscshift_marking" then o = L_GUI_MISC_MARKING end
if o == "ViksConfigUImiscinvite_keyword" then o = L_GUI_MISC_INVKEYWORD end
if o == "ViksConfigUImiscafk_spin_camera" then o = L_GUI_MISC_SPIN_CAMERA end
if o == "ViksConfigUImiscvehicle_mouseover" then o = L_GUI_MISC_VEHICLE_MOUSEOVER end
if o == "ViksConfigUImiscquest_auto_button" then o = L_GUI_MISC_QUEST_AUTOBUTTON end
if o == "ViksConfigUImiscraid_tools" then o = L_GUI_MISC_RAID_TOOLS end
if o == "ViksConfigUImiscprofession_tabs" then o = L_GUI_MISC_PROFESSION_TABS end
if o == "ViksConfigUImiscprofession_database" then o = L_GUI_MISC_PROFESSION_DATABASE end
if o == "ViksConfigUImischide_bg_spam" then o = L_GUI_MISC_HIDE_BG_SPAM end
if o == "ViksConfigUImiscitem_level" then o = L_GUI_MISC_ITEM_LEVEL end
if o == "ViksConfigUImiscgem_counter" then o = L_GUI_MISC_GEM_COUNTER end
if o == "ViksConfigUImiscalready_known" then o = L_GUI_MISC_ALREADY_KNOWN end
if o == "ViksConfigUImiscdisenchanting" then o = L_GUI_MISC_DISENCHANTING end
if o == "ViksConfigUImiscsum_buyouts" then o = L_GUI_MISC_SUM_BUYOUTS end
if o == "ViksConfigUImiscclick_cast" then o = L_GUI_MISC_CLICK_CAST end
if o == "ViksConfigUImiscclick_cast_filter" then o = L_GUI_MISC_CLICK_CAST_FILTER end
if o == "ViksConfigUImiscmove_blizzard" then o = L_GUI_MISC_MOVE_BLIZZARD end
if o == "ViksConfigUImisccolor_picker" then o = L_GUI_MISC_COLOR_PICKER end
if o == "ViksConfigUImiscenchantment_scroll" then o = L_GUI_MISC_ENCHANTMENT_SCROLL end
if o == "ViksConfigUImiscarchaeology" then o = L_GUI_MISC_ARCHAEOLOGY end
if o == "ViksConfigUImiscchars_currency" then o = L_GUI_MISC_CHARS_CURRENCY end
if o == "ViksConfigUImiscmarkbar" then o = ViksL.option_markbar end
if o == "ViksConfigUImiscfilger" then o = ViksL.option_filger end
if o == "ViksConfigUImiscfilgerCD" then o = "Show Cooldown Bar with Filger" end
if o == "ViksConfigUImiscclasstimer" then o = ViksL.option_classtimer end
if o == "ViksConfigUImiscCooldownFlash" then o = ViksL.option_CooldownFlash end
if o == "ViksConfigUImiscraidcooldowns" then o = ViksL.option_raidcooldowns end
if o == "ViksConfigUImiscWatchFrame" then o = "Use Custom Quest WatchFrame" end
if o == "ViksConfigUImiscMMBFbutton" then o = "Use Minimap Button Frame" end
if o == "ViksConfigUImiscBT4Bars" then o = "Sidebar & Small bars for Bartender 4" end
if o == "ViksConfigUImiscPscale" then o = "Scale ViksUI Panels" end
if o == "ViksConfigUImiscpanelsh" then o = "Set Panels to hidden" end
if o == "ViksConfigUImiscThreatbar" then o = "Shows threathbar over XP bar location" end

--Panels
if o == "ViksConfigUIpanels" then o = "UI Panels" end
if o == "ViksConfigUIpanelsCPwidth" then o = "Width for Left and Right side panels that holds text." end
if o == "ViksConfigUIpanelsCPTextheight" then o = "Hight for panel where chat window is inside" end
if o == "ViksConfigUIpanelsCPbarsheight" then o = "Hight for Panels under/above Chat window" end
if o == "ViksConfigUIpanelsCPABarSide" then o = "Width for Action Bars next to chat windows" end
if o == "ViksConfigUIpanelsCPXPBa_r" then o = "Hight for the XP bar above Left Chat" end
if o == "ViksConfigUIpanelsxoffset" then o = "Horisontal spacing between panels" end
if o == "ViksConfigUIpanelsyoffset" then o = "Vertical spacing between panels" end
if o == "ViksConfigUIpanelsCPSidesWidth" then o = "Width of panels that is used to hold dmg meter and threathbar (Recount & Omen)" end 
if o == "ViksConfigUIpanelsCPMABwidth" then o = "Width for Main Actionbar" end
if o == "ViksConfigUIpanelsCPMABheight" then o = "Hight for Main Actionbar" end
if o == "ViksConfigUIpanelsCPMAByoffset" then o = "Hight for Main Actionbar" end
if o == "ViksConfigUIpanelsCPCooldheight" then o = "Hight for Cooldown Bar" end
if o == "ViksConfigUIpanelsCPTop" then o = "Width for Top Panels" end

-- Raid cooldowns options
if o == "ViksConfigUIraidcooldown" then o = L_GUI_COOLDOWN_RAID end
if o == "ViksConfigUIraidcooldownenable" then o = L_GUI_COOLDOWN_RAID_ENABLE end
if o == "ViksConfigUIraidcooldownheight" then o = L_GUI_COOLDOWN_RAID_HEIGHT end
if o == "ViksConfigUIraidcooldownwidth" then o = L_GUI_COOLDOWN_RAID_WIDTH end
if o == "ViksConfigUIraidcooldownupwards" then o = L_GUI_COOLDOWN_RAID_SORT end
if o == "ViksConfigUIraidcooldownshow_icon" then o = L_GUI_COOLDOWN_RAID_ICONS end
if o == "ViksConfigUIraidcooldownshow_inraid" then o = L_GUI_COOLDOWN_RAID_IN_RAID end
if o == "ViksConfigUIraidcooldownshow_inparty" then o = L_GUI_COOLDOWN_RAID_IN_PARTY end
if o == "ViksConfigUIraidcooldownshow_inarena" then o = L_GUI_COOLDOWN_RAID_IN_ARENA end
	

	
	
	Viks.option = o
end
local NewButton = function(text, parent)
	local T, Viks, L = unpack(ViksUI)

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)
	result:SetNormalTexture("")
	result:SetHighlightTexture("")
	result:SetPushedTexture("")
	result.Left:SetAlpha(0)
	result.Right:SetAlpha(0)
	result.Middle:SetAlpha(0)

	return result
end

local NormalButton = function(text, parent)
	local T, Viks, L = unpack(ViksUI)

	local result = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	local label = result:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetJustifyH("LEFT")
	label:SetText(text)
	result:SetWidth(100)
	result:SetHeight(23)
	result:SetFontString(label)
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.Reskin(result)
	else
		result:SkinButton()
	end

	return result
end

StaticPopupDialogs.PERCHAR = {
	text = L_GUI_PER_CHAR,
	OnAccept = function()
		if ViksConfigAllCharacters:GetChecked() then
			ViksConfigAll[realm][name] = true
		else
			ViksConfigAll[realm][name] = false
		end
		ReloadUI()
	end,
	OnCancel = function()
		UIConfigCover:Hide()
		if ViksConfigAllCharacters:GetChecked() then
			ViksConfigAllCharacters:SetChecked(false)
		else
			ViksConfigAllCharacters:SetChecked(true)
		end
	end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_PERCHAR = {
	text = L_GUI_RESET_CHAR,
	OnAccept = function()
		ViksConfig = ViksConfigSettings
		ReloadUI()
	end,
	OnCancel = function() if UIConfig and UIConfig:IsShown() then UIConfigCover:Hide() end end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_ALL = {
	text = L_GUI_RESET_ALL,
	OnAccept = function()
		ViksConfigSettings = nil
		ViksConfig = nil
		ReloadUI()
	end,
	OnCancel = function() UIConfigCover:Hide() end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 5,
}

local function SetValue(group, option, value)
	--Determine if we should be copying our default settings to our player settings, this only happens if we're not using player settings by default
	local mergesettings
	if ViksConfig == ViksConfigSettings then
		mergesettings = true
	else
		mergesettings = false
	end
	if ViksConfigAll[realm][name] == true then
		if not ViksConfig then ViksConfig = {} end	
		if not ViksConfig[group] then ViksConfig[group] = {} end
		ViksConfig[group][option] = value
	else
		--Set PerChar settings to the same as our settings if theres no per char settings
		if mergesettings == true then
			if not ViksConfig then ViksConfig = {} end	
			if not ViksConfig[group] then ViksConfig[group] = {} end
			ViksConfig[group][option] = value
		end
		
		if not ViksConfigSettings then ViksConfigSettings = {} end
		if not ViksConfigSettings[group] then ViksConfigSettings[group] = {} end
		ViksConfigSettings[group][option] = value
	end
end

local VISIBLE_GROUP = nil
local lastbutton = nil
local function ShowGroup(group, button)
	local T, Viks, L = unpack(ViksUI)

	if lastbutton then
		lastbutton:SetText(lastbutton:GetText().sub(lastbutton:GetText(), 11, -3))
	end
	if VISIBLE_GROUP then
		_G["UIConfig"..VISIBLE_GROUP]:Hide()
	end
	if _G["UIConfig"..group] then
		local o = "ViksConfigUI"..group
		Local(o)
		_G["UIConfigTitle"]:SetText(Viks.option)
		local height = _G["UIConfig"..group]:GetHeight()
		_G["UIConfig"..group]:Show()
		local scrollamntmax = 400
		local scrollamntmin = scrollamntmax - 10
		local max = height > scrollamntmax and height-scrollamntmin or 1

		if max == 1 then
			_G["UIConfigGroupSlider"]:SetValue(1)
			_G["UIConfigGroupSlider"]:Hide()
		else
			_G["UIConfigGroupSlider"]:SetMinMaxValues(0, max)
			_G["UIConfigGroupSlider"]:Show()
			_G["UIConfigGroupSlider"]:SetValue(1)
		end
		_G["UIConfigGroup"]:SetScrollChild(_G["UIConfig"..group])

		local x
		if UIConfigGroupSlider:IsShown() then
			_G["UIConfigGroup"]:EnableMouseWheel(true)
			_G["UIConfigGroup"]:SetScript("OnMouseWheel", function(self, delta)
				if UIConfigGroupSlider:IsShown() then
					if delta == -1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x + 10)
					elseif delta == 1 then
						x = _G["UIConfigGroupSlider"]:GetValue()
						_G["UIConfigGroupSlider"]:SetValue(x - 30)
					end
				end
			end)
		else
			_G["UIConfigGroup"]:EnableMouseWheel(false)
		end

		VISIBLE_GROUP = group
		lastbutton = button
	end
end

local loaded
function CreateUIConfig()
	if InCombatLockdown() and not loaded then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
	local T, Viks, L = unpack(ViksUI)

	if UIConfigMain then
		ShowGroup("general")
		UIConfigMain:Show()
		return
	end

	-- Main Frame
	local UIConfigMain = CreateFrame("Frame", "UIConfigMain", UIParent)
	UIConfigMain:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 200)
	UIConfigMain:SetWidth(780)
	UIConfigMain:SetHeight(520)
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.CreateBD(UIConfigMain)
		F.CreateSD(UIConfigMain)
	else
		UIConfigMain:SetTemplate("Transparent")
	end
	UIConfigMain:SetFrameStrata("DIALOG")
	UIConfigMain:SetFrameLevel(20)
	tinsert(UISpecialFrames, "UIConfigMain")

	-- Version Title
	local TitleBoxVer = CreateFrame("Frame", "TitleBoxVer", UIConfigMain)
	TitleBoxVer:SetWidth(180)
	TitleBoxVer:SetHeight(24)
	TitleBoxVer:SetPoint("TOPLEFT", UIConfigMain, "TOPLEFT", 23, -15)

	local TitleBoxVerText = TitleBoxVer:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	TitleBoxVerText:SetPoint("CENTER")
	TitleBoxVerText:SetText("Viks UI "..T.version)

	-- Main Frame Title
	local TitleBox = CreateFrame("Frame", "TitleBox", UIConfigMain)
	TitleBox:SetWidth(540)
	TitleBox:SetHeight(24)
	TitleBox:SetPoint("TOPLEFT", TitleBoxVer, "TOPRIGHT", 15, 0)

	local TitleBoxText = TitleBox:CreateFontString("UIConfigTitle", "OVERLAY", "GameFontNormal")
	TitleBoxText:SetPoint("LEFT", TitleBox, "LEFT", 15, 0)

	-- Options Frame
	local UIConfig = CreateFrame("Frame", "UIConfig", UIConfigMain)
	UIConfig:SetPoint("TOPLEFT", TitleBox, "BOTTOMLEFT", 10, -15)
	UIConfig:SetWidth(520)
	UIConfig:SetHeight(400)

	local UIConfigBG = CreateFrame("Frame", "UIConfigBG", UIConfig)
	UIConfigBG:SetPoint("TOPLEFT", -10, 10)
	UIConfigBG:SetPoint("BOTTOMRIGHT", 10, -10)

	-- Group Frame
	local groups = CreateFrame("ScrollFrame", "UIConfigCategoryGroup", UIConfig)
	groups:SetPoint("TOPLEFT", TitleBoxVer, "BOTTOMLEFT", 10, -15)
	groups:SetWidth(160)
	groups:SetHeight(400)

	local groupsBG = CreateFrame("Frame", "groupsBG", UIConfig)
	groupsBG:SetPoint("TOPLEFT", groups, -10, 10)
	groupsBG:SetPoint("BOTTOMRIGHT", groups, 10, -10)

	local UIConfigCover = CreateFrame("Frame", "UIConfigCover", UIConfigMain)
	UIConfigCover:SetPoint("TOPLEFT", 0, 0)
	UIConfigCover:SetPoint("BOTTOMRIGHT", 0, 0)
	UIConfigCover:SetFrameLevel(UIConfigMain:GetFrameLevel() + 20)
	UIConfigCover:EnableMouse(true)
	UIConfigCover:SetScript("OnMouseDown", function(self) print(L_GUI_MAKE_SELECTION) end)
	UIConfigCover:Hide()

	-- Group Scroll
	local slider = CreateFrame("Slider", "UIConfigCategorySlider", groups)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) groups:SetVerticalScroll(value) end)

	local function sortMyTable(a, b)
 		return ALLOWED_GROUPS[a] < ALLOWED_GROUPS[b]
 	end
 	local function pairsByKey(t, f)
 		local a = {}
 		for n in pairs(t) do table.insert(a, n) end
 		table.sort(a, sortMyTable)
 		local i = 0
 		local iter = function()
 			i = i + 1
 			if a[i] == nil then return nil
 			else return a[i], t[a[i]]
 			end
 		end
 		return iter
 	end	
	
	local child = CreateFrame("Frame", nil, groups)
	child:SetPoint("TOPLEFT")
	local offset = 5
	for i in pairsByKey(ALLOWED_GROUPS) do
		local o = "ViksConfigUI"..i
		Local(o)
		local button = NewButton(Viks.option, child)
		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint("TOPLEFT", 5, -offset)
		button:SetScript("OnClick", function(self) ShowGroup(i, button) self:SetText("|cff00ff00"..Viks.option.."|r") end)
		offset = offset + 20
	end
	child:SetWidth(125)
	child:SetHeight(offset)
	slider:SetMinMaxValues(0, (offset == 0 and 1 or offset - 12 * 32))
	slider:SetValue(1)
	groups:SetScrollChild(child)

	local x
	_G["UIConfigCategoryGroup"]:EnableMouseWheel(true)
	_G["UIConfigCategoryGroup"]:SetScript("OnMouseWheel", function(self, delta)
		if _G["UIConfigCategorySlider"]:IsShown() then
			if delta == -1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x + 10)
			elseif delta == 1 then
				x = _G["UIConfigCategorySlider"]:GetValue()
				_G["UIConfigCategorySlider"]:SetValue(x - 20)
			end
		end
	end)

	local group = CreateFrame("ScrollFrame", "UIConfigGroup", UIConfig)
	group:SetPoint("TOPLEFT", 0, 5)
	group:SetWidth(520)
	group:SetHeight(400)

	-- Options Scroll
	local slider = CreateFrame("Slider", "UIConfigGroupSlider", group)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self, value) group:SetVerticalScroll(value) end)

	for i in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame", "UIConfig"..i, UIConfigGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(225)

		local offset = 5

		if type(Viks[i]) ~= "table" then error(i.." GroupName not found in config table.") return end
		for j, value in pairs(Viks[i]) do
			if type(value) == "boolean" then
				local button = CreateFrame("CheckButton", "UIConfig"..i..j, frame, "InterfaceOptionsCheckButtonTemplate")
				if IsAddOnLoaded("Aurora") then
					local F = unpack(Aurora)
					F.ReskinCheck(button)
				else
					T.SkinCheckBox(button)
				end
				local o = "ViksConfigUI"..i..j
				Local(o)
				_G["UIConfig"..i..j.."Text"]:SetText(Viks.option)
				_G["UIConfig"..i..j.."Text"]:SetFontObject(GameFontHighlight)
				_G["UIConfig"..i..j.."Text"]:SetWidth(460)
				_G["UIConfig"..i..j.."Text"]:SetJustifyH("LEFT")
				button:SetChecked(value)
				button:SetScript("OnClick", function(self) SetValue(i, j, (self:GetChecked() and true or false)) end)
				button:SetPoint("TOPLEFT", 5, -offset)
				offset = offset + 20
			elseif type(value) == "number" or type(value) == "string" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "ViksConfigUI"..i..j
				Local(o)
				label:SetText(Viks.option)
				label:SetWidth(460)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)

				local editbox = CreateFrame("EditBox", nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetWidth(230.5)
				editbox:SetHeight(18)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3, 0, 0, 0)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint("TOPLEFT", 8, -(offset + 20))
				editbox:SetText(value)
				if IsAddOnLoaded("Aurora") then
					local F = unpack(Aurora)
					F.CreateBD(editbox)
				else
					editbox:SetTemplate("Overlay")
				end

				local okbutton = CreateFrame("Button", nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SkinButton()
				okbutton:SetPoint("LEFT", editbox, "RIGHT", 2, 0)

				local oktext = okbutton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				oktext:SetText(OKAY)
				oktext:SetPoint("CENTER", okbutton, "CENTER", -1, 0)
				okbutton:SetWidth(oktext:GetWidth())
				okbutton:Hide()

				if type(value) == "number" then
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(i, j, tonumber(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(i, j, tonumber(editbox:GetText())) end)
				else
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(i, j, tostring(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(i, j, tostring(editbox:GetText())) end)
				end

				offset = offset + 45
			elseif type(value) == "table" then
				local label = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				local o = "ViksConfigUI"..i..j
				Local(o)
				label:SetText(Viks.option)
				label:SetWidth(440)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -offset)

				colorbuttonname = (label:GetText().."ColorPicker")

				local colorbutton = CreateFrame("Button", colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetTemplate("Transparent")
				colorbutton:SetBackdropBorderColor(unpack(value))
				colorbutton:SetBackdropColor(value[1], value[2], value[3], 0.3)
				colorbutton:SetPoint("LEFT", label, "RIGHT", 2, 0)

				local colortext = colorbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				colortext:SetText(COLOR)
				colortext:SetPoint("CENTER")
				colortext:SetJustifyH("CENTER")
				colorbutton:SetWidth(colortext:GetWidth() + 5)

				local oldvalue = value

				local function round(number, decimal)
					return (("%%.%df"):format(decimal)):format(number)
				end

				colorbutton:SetScript("OnMouseDown", function(self)
					if ColorPickerFrame:IsShown() then return end
					local newR, newG, newB, newA
					local fired = 0

					local r, g, b, a = self:GetBackdropBorderColor()
					r, g, b, a = round(r, 2), round(g, 2), round(b, 2), round(a, 2)
					local originalR, originalG, originalB, originalA = r, g, b, a

					local function ShowColorPicker(r, g, b, a, changedCallback)
						ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback
						ColorPickerFrame:SetColorRGB(r, g, b)
						a = tonumber(a)
						ColorPickerFrame.hasOpacity = (a ~= nil and a ~= 1)
						ColorPickerFrame.opacity = a
						ColorPickerFrame.previousValues = {originalR, originalG, originalB, originalA}
						ColorPickerFrame:Hide()
						ColorPickerFrame:Show()
					end

					local function myColorCallback(restore)
						fired = fired + 1
						if restore ~= nil then
							-- The user bailed, we extract the old color from the table created by ShowColorPicker
							newR, newG, newB, newA = unpack(restore)
						else
							-- Something changed
							newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
						end

						value = {newR, newG, newB, newA}
						SetValue(i, j, (value))
						self:SetBackdropBorderColor(newR, newG, newB, newA)
						self:SetBackdropColor(newR, newG, newB, 0.3)
					end

					ShowColorPicker(originalR, originalG, originalB, originalA, myColorCallback)
				end)

				offset = offset + 25
			end
		end

		frame:SetHeight(offset)
		frame:Hide()
	end

	local reset = NormalButton(DEFAULT, UIConfigMain)
	reset:SetPoint("TOPLEFT", UIConfig, "BOTTOMLEFT", -10, -25)
	reset:SetScript("OnClick", function(self)
		UIConfigCover:Show()
		if ViksConfigAll[realm][name] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end)

	local close = NormalButton(CLOSE, UIConfigMain)
	close:SetPoint("TOPRIGHT", UIConfig, "BOTTOMRIGHT", 10, -25)
	close:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") UIConfigMain:Hide() end)

	local load = NormalButton(APPLY, UIConfigMain)
	load:SetPoint("RIGHT", close, "LEFT", -4, 0)
	load:SetScript("OnClick", function(self) ReloadUI() end)

	local totalreset = NormalButton(L_GUI_BUTTON_RESET, UIConfigMain)
	totalreset:SetWidth(180)
	totalreset:SetPoint("TOPLEFT", groupsBG, "BOTTOMLEFT", 0, -15)
	totalreset:SetScript("OnClick", function(self)
		StaticPopup_Show("RESET_UI")
		ViksConfig = {}
		if ViksConfigAll[realm][name] == true then
			ViksConfigAll[realm][name] = {}
		end
		ViksConfigSettings = {}
	end)

	if ViksConfigAll then
		local button = CreateFrame("CheckButton", "ViksConfigAllCharacters", TitleBox, "InterfaceOptionsCheckButtonTemplate")
		button:SetScript("OnClick", function(self) StaticPopup_Show("PERCHAR") UIConfigCover:Show() end)
		button:SetPoint("RIGHT", TitleBox, "RIGHT", -3, 0)
		button:SetHitRectInsets(0, 0, 0, 0)
		if IsAddOnLoaded("Aurora") then
			local F = unpack(Aurora)
			F.ReskinCheck(button)
		else
			T.SkinCheckBox(button)
		end

		local label = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		label:SetText(L_GUI_SET_SAVED_SETTTINGS)
		label:SetPoint("RIGHT", button, "LEFT")

		if ViksConfigAll[realm][name] == true then
			button:SetChecked(true)
		else
			button:SetChecked(false)
		end
	end

	local bgskins = {TitleBox, TitleBoxVer, UIConfigBG, groupsBG}
	for _, sb in pairs(bgskins) do
		if IsAddOnLoaded("Aurora") then
			local F = unpack(Aurora)
			F.CreateBD(sb)
		else
			sb:SetTemplate("Overlay")
		end
	end

	ShowGroup("general")
	loaded = true
end

do
	function SlashCmdList.CONFIG(msg, editbox)
		if not UIConfigMain or not UIConfigMain:IsShown() then
			PlaySound("igMainMenuOption")
			CreateUIConfig()
			HideUIPanel(GameMenuFrame)
		else
			PlaySound("igMainMenuOption")
			UIConfigMain:Hide()
		end
	end
	SLASH_CONFIG1 = "/config"
	SLASH_CONFIG2 = "/cfg"
	--SLASH_CONFIG3 = "/configui"

	function SlashCmdList.RESETCONFIG()
		if UIConfigMain and UIConfigMain:IsShown() then UIConfigCover:Show() end

		if ViksConfigAll[realm][name] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end
	SLASH_RESETCONFIG1 = "/resetconfig"
end

do
	local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	frame:Hide()

	frame.name = "ViksUI"
	frame:SetScript("OnShow", function(self)
		if self.show then return end
		local T, Viks, L = unpack(ViksUI)
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText("Info about ViksUI:")

		local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle:SetWidth(580)
		subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		subtitle:SetJustifyH("LEFT")
		subtitle:SetText("WoWInterface: |cff298F00http://www.wowinterface.com/downloads/info21462-ViksUI.html|r\nChange Log: |cff298F00On WoWInterface|r")

		local title2 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title2:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -16)
		title2:SetText("Credits:")

		local subtitle2 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle2:SetWidth(580)
		subtitle2:SetPoint("TOPLEFT", title2, "BOTTOMLEFT", 0, -8)
		subtitle2:SetJustifyH("LEFT")
		subtitle2:SetText("AcidWeb, Aezay, Affli, Ailae, Allez, ALZA, Ammo, Astromech, Beoko, Bitbyte, Blamdarot, Bozo, Caellian, Califpornia, Camealion, Chiril, CrusaderHeimdall, Cybey, Dawn, Don Kaban, Dridzt, Duffed, Durcyn, Eclipse, Egingell, Elv22, Evilpaul, Evl, Favorit, Fernir, Foof, Freebaser, g0st, gi2k15, Gorlasch, Gsuz, Haleth, Haste, Hoochie, Hungtar, HyPeRnIcS, Hydra, Ildyria, iSpawnAtHome, Jaslm, Karl_w_w, Karudon, Katae, Kemayo, Killakhan, Kraftman, Kunda, Leatrix, m2jest1c, Magdain, Meurtcriss, Monolit, MrRuben5, Myrilandell of Lothar, Nathanyel, Nefarion, Nightcracker, Nils Ruesch, p3lim, Partha, Phanx, pvtschlag, Rahanprout, Renstrom, RustamIrzaev, Safturento, Sara.Festung, SDPhantom, Sildor, Silverwind, SinaC, Slakah, Soeters, Starlon, Suicidal Katt, Syzgyn, Tekkub, Telroth, Thalyra, Thizzelle, Tia Lynn, Timmy2250, Tohveli, Tukz, Tuller, Veev, Villiv, Vladinator, Wetxius, Woffle of Dark Iron, Wrug, Xuerian, Yleaf, Zork.")

		local title3 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title3:SetPoint("TOPLEFT", subtitle2, "BOTTOMLEFT", 0, -16)
		title3:SetText("Translation:")

		local subtitle3 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle3:SetWidth(580)
		subtitle3:SetPoint("TOPLEFT", title3, "BOTTOMLEFT", 0, -8)
		subtitle3:SetJustifyH("LEFT")
		subtitle3:SetText("Aelb, Alwa, Baine, Chubidu, Cranan, eXecrate, F5Hellbound, Ianchan, Leg883, Mania, Nanjiqq, Oz, Puree, Seal, Sinaris, Spacedragon, Tat2dawn, Tibles, Vienchen.")

		local title4 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title4:SetPoint("TOPLEFT", subtitle3, "BOTTOMLEFT", 0, -16)
		title4:SetText("Thanks:")

		local subtitle4 = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		subtitle4:SetWidth(580)
		subtitle4:SetPoint("TOPLEFT", title4, "BOTTOMLEFT", 0, -8)
		subtitle4:SetJustifyH("LEFT")
		subtitle4:SetText("Akimba, Antthemage, Crunching, Dandruff, DesFolk, Elfrey, Ente, Erratic, Falchior, Gromcha, Halogen, Homicidal Retribution, ILF7, Illusion, Ipton, k07n, Kazarl, Leots, m2jest1c, MoLLIa, Nefrit, Noobolov, Obakol, Oz, PterOs, Sart, Scorpions, Sitatunga, Sw2rT1, Wetxius, Yakodzuna, UI Users and Russian Community.")

		local title5 = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title5:SetPoint("TOPLEFT", subtitle3, "BOTTOMLEFT", 0, -16)
		title5:SetText("Special thanks to: Shestak and Qulight")
		
		local version = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		version:SetPoint("BOTTOMRIGHT", -16, 16)
		version:SetText("Version: "..T.version)

		self.show = true
	end)

	InterfaceOptions_AddCategory(frame)
end
----------------------------------------------------------------------------------------
--	Button in GameMenuButton frame
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "GameMenuButtonSettingsUI", GameMenuFrame, "GameMenuButtonTemplate")
button:SetText("ViksUI")
button:SetPoint("TOP", "GameMenuButtonAddons", "BOTTOM", 0, -1)

GameMenuFrame:HookScript("OnShow", function()
	GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + button:GetHeight())
	if IsMacClient() then
		GameMenuButtonMacOptions:SetPoint("TOP", button, "BOTTOM", 0, -16)
	else
		GameMenuButtonLogout:SetPoint("TOP", button, "BOTTOM", 0, -16)
	end
end)

button:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfigMain or not UIConfigMain:IsShown() then
		CreateUIConfig()
	else
		UIConfigMain:Hide()
	end
end)