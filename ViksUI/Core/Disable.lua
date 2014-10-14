local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Prevent users config errors
----------------------------------------------------------------------------------------
--[[
if Viks.actionbar.rightbars > 3 then
	Viks.actionbar.rightbars = 3
end

if Viks.actionbar.bottombars > 3 then
	Viks.actionbar.bottombars = 3
end

if Viks.actionbar.bottombars == 3 and Viks.actionbar.rightbars == 3 then
	Viks.actionbar.bottombars = 3
	Viks.actionbar.rightbars = 2
end

if Viks.actionbar.split_bars == true then
	Viks.actionbar.bottombars = 3
	Viks.actionbar.rightbars = 2
end

if Viks.actionbar.bottombars < 1 then
	Viks.actionbar.bottombars = 1
end

if Viks.actionbar.petbar_horizontal == true then
	Viks.actionbar.stancebar_horizontal = false
end
--]]
if Viks.error.black == true and Viks.error.white == true then
	Viks.error.white = false
end

if Viks.error.combat == true then
	Viks.error.black = false
	Viks.error.white = false
end

----------------------------------------------------------------------------------------
--	Auto-overwrite script config is X addon is found
----------------------------------------------------------------------------------------
if IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") then
	Viks.unitframes.enable = false
end

if IsAddOnLoaded("Grid") or IsAddOnLoaded("Grid2") or IsAddOnLoaded("HealBot") or IsAddOnLoaded("VuhDo") or IsAddOnLoaded("oUF_Freebgrid") then
	Viks.raidframes.show_party = false
	Viks.raidframes.show_raid = false
end

if IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft") or IsAddOnLoaded("dNamePlates") or IsAddOnLoaded("caelNamePlates") then
	Viks.nameplate.enable = false
end

if IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("RazerNaga") then
	Viks.actionbar.enable = false
	Viks.actionbar.toggle_mode = false
end

if IsAddOnLoaded("Mapster") then
	C.map.explore_map = false
	C.map.fog_of_war = false
	C.map.map_boss_count = false
end

if IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter") then
	Viks.chat.enable = false
end

if IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar") then
	Viks.unitframes.unit_castbar = false
	Viks.unitframes.plugins_swing = false
	Viks.unitframes.plugins_gcd = false
end

if IsAddOnLoaded("Afflicted3") or IsAddOnLoaded("InterruptBar") or IsAddOnLoaded("alEnemyCD") then
	Viks.enemycooldown.enable = false
end

if IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("bTooltip") or IsAddOnLoaded("PhoenixTooltip") or IsAddOnLoaded("Icetip") then
	Viks.tooltip.enable = false
end

if IsAddOnLoaded("Gladius") then
	Viks.unitframes.show_arena = false
end

if IsAddOnLoaded("Omen") or IsAddOnLoaded("sThreatMeter2") or IsAddOnLoaded("SkadaThreat") or IsAddOnLoaded("RecountThreat") then
	Viks.threat.enable = false
end

if IsAddOnLoaded("DBM-SpellTimers") or IsAddOnLoaded("alRaidCD") then
	Viks.raidcooldown.enable = false
end

if IsAddOnLoaded("TipTacTalents") then
	Viks.tooltip.talents = false
end

if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") then
	Viks.bag.enable = false
end

if IsAddOnLoaded("MikScrollingBattleText") or IsAddOnLoaded("Parrot") or IsAddOnLoaded("xCT") or IsAddOnLoaded("sct") then
	Viks.combattext.enable = false
end

if IsAddOnLoaded("Doom_CooldownPulse") then
	Viks.pulsecooldown.enable = false
end

if IsAddOnLoaded("GnomishVendorShrinker") or IsAddOnLoaded("AlreadyKnown") then
	Viks.misc.already_known = false
end

if IsAddOnLoaded("Clique") or IsAddOnLoaded("sBinder") then
	Viks.misc.click_cast = false
end

if IsAddOnLoaded("RaidSlackCheck") then
	Viks.announcements.flask_food = false
	Viks.announcements.feasts = false
end

if IsAddOnLoaded("PhoenixStyle") then
	Viks.announcements.toys = false
end

if IsAddOnLoaded("Overachiever") then
	Viks.tooltip.achievements = false
end

if IsAddOnLoaded("ChatSounds") then
	Viks.chat.whisp_sound = false
end

if IsAddOnLoaded("Aurora") then
	Viks.skins.blizzard_frames = false
end

if IsAddOnLoaded("BigWigs") or IsAddOnLoaded("DBM-Core") then
	Viks.automation.auto_role = false
end