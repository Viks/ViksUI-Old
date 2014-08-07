local T, Viks, L, _ = unpack(select(2, ...))
local addon, ns = ...
local cfg = CreateFrame("Frame")

	-----------------------------
	-- Media Defaults
	-----------------------------
local mediapath = "Interface\\AddOns\\ViksUI\\Media\\"
cfg.statusbar_texture = mediapath.."textures\\normTex"
cfg.powerbar_texture = mediapath.."textures\\normTex"
cfg.Textbar_texture = mediapath.."textures\\backdrop"
cfg.highlight_texture = mediapath.."textures\\raidbg"
cfg.debuffBorder = mediapath.."textures\\iconborder"
cfg.squarefont = mediapath.."Font\\squares.ttf"
cfg.font = Viks.unitframes.UFfont
cfg.symbol = mediapath.."Font\\symbol.ttf"
cfg.symbols2 = mediapath.."Font\\PIZZADUDEBULLETS.ttf"
cfg.fontsize = 12
cfg.raidmarkicon = mediapath.."Other\\raidicons"
cfg.hordepvpico = mediapath.."Other\\Horde"									-- Icon to show for PVP Horde Side.
cfg.alliancepvpico = mediapath.."Other\\Alliance"								-- Icon to show for PVP Horde Side.
cfg.combatico = mediapath.."Other\\combat2"									-- Setting the icon to show when in combat on unitframe
cfg.restico = mediapath.."Other\\resting"										-- Setting the icon to show when in resting on unitframe. Credit to Karma for the icon.
cfg.oUFfont = Viks.unitframes.UFNamefont								-- Font to use on Names
cfg.shadowedge = mediapath.."Other\\glowTex"
cfg.backdropcolor = Viks.media.backdropcolor
cfg.bordercolor = Viks.media.bordercolor
cfg.aurasize = Viks.unitframes.aurasize								-- Aura Size for indicator type 2
cfg.insideAlpha = Viks.unitframes.insideAlpha						-- Alpha when Unitframe is in range	
cfg.outsideAlpha = Viks.unitframes.outsideAlpha						-- Alpha when Unitframe is out of range
cfg.pixelfont = mediapath.."Font\\pixel.ttf"							-- Pixelfont, working on adding this atm!


	-----------------------------
	-- Enable / disable parts (true/false)
	-----------------------------
cfg.ShowRaid = Viks.unitframes.ShowRaid								-- Show Raid Frames
cfg.portraitHPbar = Viks.unitframes.showPortraitHPbar				-- show portraits on Healthbar
cfg.showPortrait = Viks.unitframes.showPortrait						-- show portraits Icon
cfg.HealFrames = Viks.unitframes.HealFrames							-- Healing layout/positions
cfg.HealthcolorClass = Viks.unitframes.HealthcolorClass				-- health color = class color
cfg.showLFDIcons = Viks.unitframes.showLFDIcons						-- Show LFD Icons, must be true to show the other 2 options. False on next 2 to show default icons.
cfg.customLFDIcons = Viks.unitframes.customLFDIcons					-- Use Custom Icons; cfg.customLFDText must be false
cfg.customLFDText = Viks.unitframes.customLFDText					-- Use Text instead of Icon; Tank/Dps/Heal. cfg.customLFDIcons must be false
cfg.RCheckIcon = Viks.unitframes.RCheckIcon							-- Show Ready Check Icons On Health Frames
cfg.TotemBars = Viks.unitframes.TotemBars							-- show totem bars
cfg.Experiencebar = Viks.unitframes.Experiencebar					-- show experience bar
cfg.Reputationbar = Viks.unitframes.Reputationbar					-- show reputation bar
cfg.enableDebuffHighlight = Viks.unitframes.enableDebuffHighlight	-- Highlight Unit Frame if having a Debuffs
cfg.showAuraWatch = Viks.unitframes.showAuraWatch					-- watch specific auras
cfg.showIndicators = Viks.unitframes.showIndicators					-- Show Indicators on frames
cfg.ShowIncHeals = Viks.unitframes.ShowIncHeals						-- Show incoming heals in player and raid frames
cfg.Castbars = Viks.unitframes.Castbars								-- Show built-in castbars
cfg.debuffsOnlyShowPlayer = Viks.unitframes.debuffsOnlyShowPlayer 	-- only show your debuffs on target
cfg.buffsOnlyShowPlayer = Viks.unitframes.buffsOnlyShowPlayer 		-- only show your buffs
cfg.showRaidDebuffs = Viks.unitframes.showRaidDebuffs 				-- Shows debuff as icon on your raid frames
cfg.scale = 1
cfg.showPlayerAuras = Viks.unitframes.showPlayerAuras				-- use a custom player buffs/debuffs frame instead of blizzard's default
cfg.Powercolor = Viks.unitframes.Powercolor							-- power color = class color
cfg.showEclipsebar = Viks.unitframes.showEclipsebar					-- show druid eclipse bar
cfg.showShardbar = Viks.unitframes.showShardbar						-- show warlock soulShard bar
cfg.showHolybar = Viks.unitframes.showHolybar						-- show paladin HolyPower bar
cfg.showRunebar = Viks.unitframes.showRunebar						-- show dk rune bar
cfg.showHarmony = Viks.unitframes.showHarmony 						-- show Monk Harmony bar
cfg.showShadowOrbsBar = Viks.unitframes.showShadowOrbsBar 			-- show Shadow Priest Shadow Orbs bar
cfg.IndicatorIcons2 = Viks.unitframes.IndicatorIcons2				-- Toggles different Indicator types.
cfg.RaidShowAllGroups = Viks.unitframes.RaidShowAllGroups			-- Show All 8 Raid Groups, if not then 5
cfg.RaidShowSolo = Viks.unitframes.RaidShowSolo						-- show raid frames even when solo
cfg.ShowParty = Viks.unitframes.ShowParty							-- show party frames (shown as 5man raid)
cfg.showtot = Viks.unitframes.showtot								-- show target of target frame
cfg.showpet = Viks.unitframes.showpet								-- show pet frame 
cfg.showfocus = Viks.unitframes.showfocus							-- show focus frame
cfg.showfocustarget = Viks.unitframes.showfocustarget				-- show focus targets frame		
cfg.showBossFrames = Viks.unitframes.showBossFrames					-- show boss frame
cfg.showTankFrames = Viks.unitframes.MTFrames						-- show main tank frames			
cfg.indicatorsize = Viks.unitframes.indicatorsize					-- Size on Squares on Indicator type 2
cfg.symbolsize = Viks.unitframes.symbolsize							-- Size on Symbols on Indicator type 2
cfg.fontsizeEdge = Viks.unitframes.fontsizeEdge
cfg.Findoutline = Viks.unitframes.Findoutline
cfg.showVengeance = Viks.unitframes.vengeance
cfg.class_bar_range = Viks.unitframes.class_bar_range


cfg.ABspacing = 59
cfg.showarena = false

--Flytt denne til move.lua
	-----------------------------
	-- Frames Size and Positions
	-----------------------------
	

 cfg.unit_size = { 			
             Portrait = { w=   56, 	h= 56},  
               Player = { w=  245, 	h= 60},  
               Target = { w=  245, 	h= 60},  
         Targettarget = { w=  120, 	h= 27},  
                Focus = { w=  200, 	h= 24},  
          Focustarget = { w=  120, 	h= 27},  
                  Pet = { w=  120, 	h= 27},
            PetTarget = { w=   95, 	h= 24}, 				  
                 Boss = { w=  150,	h= 20},  
                 Tank = { w=  180, 	h= 20},
                TankH = { w=  150, 	h= 20},				 
              Raid10H = { w=  100, 	h= 40},
              Raid25H = { w=   60, 	h= 30},		
			   Raid25 = { w=   45, 	h= 30},
              Raid40H = { w=   40, 	h= 30},
               Raid40 = { w=   40, 	h= 30},				  
	            Party = { w=  100,	h= 40},
                Arena = { w=  245, 	h= 60},
		CastbarPlayer = { w=   	0, 	h= 16},		--Only Hight	
		CastbarTarget = { w=   	0, 	h= 16},		--Only Hight
		 CastbarArena = { w=   	0, 	h= 16},		--Only Hight
		  CastbarBoss = { w=   	0, 	h= 10},		--Only Hight
		 CastbarFocus = { w=   	0, 	h= 13},		--Only Hight		  
}
--Position if healframes
 cfg.unit_positionsH = { 				
             Player = { x= -270, y=   305},  
             Target = { x=	270, y=   305},  
       Targettarget = { x=  560, y=   400},  
              Focus = { x=  196, y=   230},  
                Pet = { x=	  0, y=   289},  
               Boss = { x= -100, y=   -90},  
               Tank = { x=	  0, y=     0},  
               Raid = { x=	  0, y=   180},   
	          Party = { x=	  0, y=     0},
              Arena = { x= 	  0, y=     0},
           PCastbar = { x= 	  0, y=     0},
           TCastbar = { x= 	  0, y=     0},
           FCastbar = { x= 	  0, y=     0},	
           ACastbar = { x= 	  0, y=     0},			   
}
--Positions if not Healframes
 cfg.unit_positions = { 				
             Player = { x= -158, y=   320},  
             Target = { x=	158, y=   320},  
       Targettarget = { x=    0, y=   259},  
              Focus = { x=  430, y=   382},  
                Pet = { x=	  0, y=   289},  
               Boss = { x= -100, y=   -90},  
               Tank = { x=	  0, y=     0},  
               Raid = { x=	  0, y=   180},   
	          Party = { x=	  0, y=     0},
              Arena = { x= 	  0, y=     0},	
           PCastbar = { x= 	 32, y=    -2},
           TCastbar = { x= 	 -6, y=    -2},
           FCastbar = { x= 	 -5, y=   -12},
           ACastbar = { x= 	 -6, y=   -2},		   
}
	-----------------------------
	-- Debuff List
	-----------------------------
	
-- Credit to oUF_Drk Fanupdate for the idea on creating this.
------------------------------------------------------------------------------------------------
-- Indicator list to show on raid frames. These are tags that have to be created inside tag.lua
------------------------------------------------------------------------------------------------
	cfg.IndicatorList = {
		["NUMBERS"] = {
			--["DEATHKNIGHT"] 	= ,
			["DRUID"]			= "[Druid:Lifebloom][Druid:Rejuv][Druid:Regrowth]",
			["HUNTER"]			= "[Hunter:Misdirection]",
			--["MAGE"]			= ,
			["MONK"]			= "[Monk:EnvelopingMist][Monk:RenewingMist]",
			--["PALADIN"]		= ,
			["PRIEST"]			= "[Priest:Renew][Priest:PowerWordShield]",
			--["ROGUE"]			= tricks,
			["SHAMAN"]			= "[Shaman:Riptide][Shaman:EarthShield]",
			--["WARLOCK"]		= ,
			--["WARRIOR"]			= ,
		},
		["SQUARE"] = {
			--["DEATHKNIGHT"] 	= ,
			--["DRUID"]			= ,
			--["HUNTER"]		= ,
			--["MAGE"]			= ,
			--["MONK"]			= ,
			["PALADIN"]			= "[Paladin:Forbearance][Paladin:Beacon]",
			--["PRIEST"]		= ,
			--["ROGUE"]			= ,
			--["SHAMAN"]		= ,
			--["WARLOCK"]		= ,
			--["WARRIOR"]		= ,
		},
	}
	
------------------------------------------------------------------------------------------------
-- Aura Watch list to show on raid frames. Add the spell id below to add it.
------------------------------------------------------------------------------------------------
	cfg.AuraWatchList = { -- List of all buffs you want to watch on raid frames, sorted by class
			DEATHKNIGHT = {
			},
			DRUID = {
				33763, -- Lifebloom
				8936, -- Regrowth
				774, -- Rejuvenation
				48438, -- Wild Growth
			},
			HUNTER = {
				34477, -- Misdirection
			},
			MAGE = {
				1459, -- Arcane Brilliance
				61316, -- Dalaran Brilliance
			},
			MONK = {

			},
			PALADIN = {
				53563, -- Beacon of Light
				25771, -- Forbearance
			},
			PRIEST = { 
				17, -- Power Word: Shield
				139, -- Renew
				33076, -- Prayer of Mending
			},
			ROGUE = {
				57934, -- Tricks of the Trade
			},
			SHAMAN = {
				974, -- Earth Shield
				61295, -- Riptide
			},
			WARLOCK = {
				20707, -- Soulstone Resurrection
			},
			WARRIOR = {
			},
	}
	cfg.DebuffWatchList = {
		debuffs = {
-----------------------------------------------------------------------------------------------------------------------		
			--?? USAGE: [GetSpellInfo(SpelliD)] = PRIORITY, ??-- Best to use
			--OR--
			--?? USAGE: ["DEBUFF_NAME"] = PRIORITY, ??--
			--?? PRIORITY -> 10: high, 9: medium, 8: low, dispellable debuffs have standard priority of 5. ??--
------------------------------------------------------------------------------------------------------------------------
---------------------------CLASSES/PVP--------------------------------------------------------------------------------------
----------------------------------------------------------------------------			--------------------------------
			-- Death Knight
			[GetSpellInfo(115001)] = 3,	-- Remorseless Winter
			[GetSpellInfo(108194)] = 3,	-- Asphyxiate
			[GetSpellInfo(47476)] = 3,	-- Strangulate
			[GetSpellInfo(47481)] = 3,	-- Gnaw (Ghoul)
			[GetSpellInfo(91797)] = 3,	-- Monstrous Blow (Mutated Ghoul)
			-- Druid
			[GetSpellInfo(33786)] = 3,	-- Cyclone
			[GetSpellInfo(2637)] = 3,	-- Hibernate
			[GetSpellInfo(339)] = 3,		-- Entangling Roots
			[GetSpellInfo(78675)] = 3,	-- Solar Beam
			-- Hunter
			[GetSpellInfo(3355)] = 3,	-- Freezing Trap
			[GetSpellInfo(117526)] = 3,	-- Binding Shot
			[GetSpellInfo(1513)] = 3,	-- Scare Beast
			[GetSpellInfo(19503)] = 3,	-- Scatter Shot
			[GetSpellInfo(34490)] = 3,	-- Silence Shot
			[GetSpellInfo(19386)] = 3,	-- Wyvern Sting

			-- Mage
			[GetSpellInfo(31661)] = 3,	-- Dragon's Breath
			[GetSpellInfo(82691)] = 3,	-- Ring of Frost
			[GetSpellInfo(61305)] = 3,	-- Polymorph
			[GetSpellInfo(102051)] = 3,	-- Frostjaw
			[GetSpellInfo(55021)] = 3,	-- Improved Counterspell
			[GetSpellInfo(122)] = 3,		-- Frost Nova
			[GetSpellInfo(111340)] = 3,	-- Ice Ward
			-- Monk
			[GetSpellInfo(115078)] = 3,	-- Paralysis
			-- Paladin
			[GetSpellInfo(20066)] = 3,	-- Repentance
			[GetSpellInfo(853)] = 3,	-- Hammer of Justice
			[GetSpellInfo(105593)] = 3,	-- Fist of Justice
			[GetSpellInfo(105421)] = 3,	-- Blinding Light
			[GetSpellInfo(25771)] = 10,	-- Forebance
			-- Priest
			[GetSpellInfo(605)] = 3,		-- Dominate Mind
			[GetSpellInfo(8122)] = 3,	-- Psychic Scream
			[GetSpellInfo(113792)] = 3,	-- Psychic Terror
			[GetSpellInfo(64044)] = 3,	-- Psychic Horror
			[GetSpellInfo(15487)] = 3,	-- Silence
			[GetSpellInfo(6788)] = 10,	-- Weaken Soul
			-- Rogue
			[GetSpellInfo(2094)] = 3,	-- Blind
			[GetSpellInfo(1776)] = 3,	-- Gouge
			[GetSpellInfo(6770)] = 3,	-- Sap
			-- Shaman
			[GetSpellInfo(51514)] = 3,	-- Hex
			[GetSpellInfo(118905)] = 3,	-- Static Charge
			[GetSpellInfo(3600)] = 3,	-- Earthbind
			[GetSpellInfo(8056)] = 3,	-- Frost Shock
			[GetSpellInfo(63685)] = 3,	-- Freeze
			-- Warlock
			[GetSpellInfo(118699)] = 3,	-- Fear
			[GetSpellInfo(104045)] = 3,	-- Sleep
			[GetSpellInfo(6789)] = 3,	-- Mortal Coil
			[GetSpellInfo(5484)] = 3,	-- Howl of Terror
			[GetSpellInfo(6358)] = 3,	-- Seduction (Succubus)
			[GetSpellInfo(115268)] = 3,	-- Mesmerize (Shivarra)
			[GetSpellInfo(30283)] = 3,	-- Shadowfury
			-- Warrior
			[GetSpellInfo(46968)] = 3,	-- Shockwave
			[GetSpellInfo(20511)] = 3,	-- Intimidating Shout
	-- Racial
		[GetSpellInfo(25046)] = 3, --Arcane Torrent
		[GetSpellInfo(20549)] = 3, --War Stomp
	
----------------------------------------------------------------------------
-----------------------DRAGON SOUL------------------------------------------
----------------------------------------------------------------------------
		--Morchok
		[GetSpellInfo(103687)] = 4,--Crush Armor
		[GetSpellInfo(103821)] = 3, --Earthen Vortex
		[GetSpellInfo(103785)] = 6, --Black Blood of the Earth
		[GetSpellInfo(103534)] = 5, --Danger (Red)
		[GetSpellInfo(103536)] = 5, --Warning (Yellow)
		-- Don't need to show Safe people
		[GetSpellInfo(103541)] = 5, --Safe (Blue)
		--Warlord Zon'ozz
		[GetSpellInfo(104378)] = 3, --Black Blood of Go'rath
		[GetSpellInfo(103434)] = 5, --Disrupting Shadows (dispellable)
		--Yor'sahj the Unsleeping
		[GetSpellInfo(104849)] = 5, --Void Bolt
		[GetSpellInfo(105171)] = 4,  --Deep Corruption
		--Hagara the Stormbinder
		[GetSpellInfo(105316)] = 4, --Ice Lance
		[GetSpellInfo(105465)] = 6, --Lightning Storm
		[GetSpellInfo(105369)] = 5, --Lightning Conduit
		[GetSpellInfo(105289)] = 3, --Shattered Ice (dispellable)
		[GetSpellInfo(105285)] = 6, --Target (next Ice Lance)
		[GetSpellInfo(104451)] = 5, --Ice Tomb
		[GetSpellInfo(110317)] = 6, --Watery Entrenchment
		--Ultraxion
		[GetSpellInfo(105925)] = 6, --Fading Light
		[GetSpellInfo(106108)] = 5, --Heroic Will
		[GetSpellInfo(105984)] = 3, --Timeloop
		[GetSpellInfo(105927)] = 4, --Faded Into Twilight
		--Warmaster Blackhorn
		[GetSpellInfo(108043)] = 4, --Sunder Armor
		[GetSpellInfo(107558)] = 3, --Degeneration
		[GetSpellInfo(107567)] = 3, --Brutal Strike
		[GetSpellInfo(108046)] = 5, --Shockwave
		--Spine of Deathwing
		[GetSpellInfo(105563)] = 3, --Grasping Tendrils
		[GetSpellInfo(105479)] = 6, --Searing Plasma
		[GetSpellInfo(105490)] = 5, --Fiery Grip
		--Madness of Deathwing
		[GetSpellInfo(105445)] = 3, --Blistering Heat
		[GetSpellInfo(105841)] = 4, --Degenerative Bite
		[GetSpellInfo(106385)] = 5, --Crush
		[GetSpellInfo(106730)] = 5, --Tetanus
		[GetSpellInfo(106444)] = 5, --Impale
		[GetSpellInfo(106794)] = 6, --Shrapnel (target)	
----------------------------------------------------------------------------
-----------------------MISTS OF PANDARIA------------------------------------
----------------------------------------------------------------------------
	--World Bosses
		--Sha of Anger
			[GetSpellInfo(119622)] = 7, --Growing Anger
			[GetSpellInfo(119626)] = 9, --Aggressive Behavior
		--Galleon's / Chief Salyis's Warmongers
			[GetSpellInfo(34716)] = 8, --Stomp
		--Nalak <The Storm Lord>
			[GetSpellInfo(136339)] = 8, --Lightning Tether
			[GetSpellInfo(136340)] = 8, --Stormcloud
		--Oondasta
			[GetSpellInfo(137504)] = 10, --Crush, stacking tank debuff
						
	--Heart of Fear
		-- Imperial Vizier Zor'lok
			[GetSpellInfo(122761)] = 9, -- Exhale, The person targeted for Exhale. 
			[GetSpellInfo(122760)] = 9, -- Exhale, The person targeted for Exhale.
			[GetSpellInfo(123812)] = 7, -- Pheromones of Zeal, the gas in the middle of the room.
			[GetSpellInfo(122706)] = 9, -- Noise Cancelling, The "safe zone" from the roomwide aoe.
			[GetSpellInfo(122740)] = 7, -- Convert, The mindcontrol Debuff.

		-- Blade Lord Ta'yak
			[GetSpellInfo(123180)] = 9, -- Wind Step, Bleeding Debuff from stealth.
			[GetSpellInfo(122994)] = 9, -- Unseen Strike (Hug to splitt dmg).
			[GetSpellInfo(123474)] = 10, -- Overwhelming Assault, stacking tank swap debuff. 

		-- Garalon
			[GetSpellInfo(122774)] = 7, -- Crush, stun from the crush ability.
			[GetSpellInfo(123426)] = 7, -- Weak Points, Increased damage done to one leg.
			[GetSpellInfo(123428)] = 7, -- Weak Points, Increased damage to another leg.
			[GetSpellInfo(123423)] = 7, -- Weak Points, Increased damage to another leg.
			[GetSpellInfo(123235)] = 7, -- Weak Points, Increased damage to another leg.
			[GetSpellInfo(122835)] = 7, -- Pheromones, The buff indicating who is carrying the pheramone.
			[GetSpellInfo(123081)] = 10, -- Punchency, The stacking debuff causing the raid damage.

		--Wind Lord Mel'jarak
			[GetSpellInfo(122055)] = 7, -- Residue, The debuff after breaking a prsion preventing further breaking.
			[GetSpellInfo(121885)] = 10, -- Amber Prison, The stun that somebody has to click off.
			[GetSpellInfo(129078)] = 10, -- Amber Prison, The stun that somebody has to click off.
			[GetSpellInfo(121881)] = 7, -- Amber Prison, not sure what the differance is but both were used.
			[GetSpellInfo(122125)] = 7, -- Corrosive Resin pool, the **** on the floor your not supposed to stand in.
			[GetSpellInfo(122064)] = 7, -- Corrosive Resin, the dot you clear by moving/jumping.

		-- Amber-Shaper Un'sok 
			[GetSpellInfo(122370)] = 7, -- Reshape Life, the transformation ala putricide.
			[GetSpellInfo(122784)] = 7, -- Reshape Life, Both were used.
			[GetSpellInfo(124802)] = 7, -- The transformed players increase damage taken cooldown.
			[GetSpellInfo(122395)] = 7, -- Struggle for Control, the self stun used to interupt the channel.
			[GetSpellInfo(122457)] = 7, -- Rough Landing, The stun from being tossed and being hit by the toss from the add in Phase 2.
			[GetSpellInfo(121949)] = 10, -- Parasitic Growth, the dot that scales with healing taken.
			
		--Grand Empress Shek'zeer
			[GetSpellInfo(123707)] = 8, -- Eyes of the Empress
			[GetSpellInfo(124097)] = 8, -- Sticky Resin
			[GetSpellInfo(123788)] = 9, -- Cry of Terror
			[GetSpellInfo(124862)] = 10, -- Visions of Demise
			[GetSpellInfo(124863)] = 10, -- Visions of Demise
			
	--Mogu'shan Vaults
		--The Stone Guard
			[GetSpellInfo(116281)] = 8, -- Cobalt Mine
			[GetSpellInfo(130395)] = 10, -- Jasper Chains
			[GetSpellInfo(116301)] = 9, -- Living Jade
			[GetSpellInfo(116304)] = 9, -- Living Jasper
			[GetSpellInfo(116199)] = 9, -- Living Cobalt
			[GetSpellInfo(116322)] = 9, -- Living Amethyst
		--Feng the Accursed
			[GetSpellInfo(116942)] = 8, -- Flaming Spear
			[GetSpellInfo(116784)] = 9, -- Wildfire Spark
			[GetSpellInfo(116577)] = 10, -- Arcane Resonance
			[GetSpellInfo(116576)] = 10, -- Arcane Resonance
			[GetSpellInfo(116574)] = 10, -- Arcane Resonance
			[GetSpellInfo(116417)] = 10, -- Arcane Resonance
		--Gara'jal the Spiritbinder
			[GetSpellInfo(117723)] = 8, -- Frail Soul
			[GetSpellInfo(122151)] = 9, -- Voodoo Doll
			[GetSpellInfo(122181)] = 10, -- Conduit to the Spirit Realm
		--The Spirit Kings
			[GetSpellInfo(117708)] = 8, -- Maddening Shout
			[GetSpellInfo(118047)] = 8, -- Pillage
			[GetSpellInfo(118048)] = 8, -- Pillage
			[GetSpellInfo(118141)] = 9, -- Pinning Arrow
			[GetSpellInfo(118163)] = 8, -- Robbed Blind
			[GetSpellInfo(117514)] = 9, -- Undying Shadows
			[GetSpellInfo(117529)] = 9, -- Undying Shadows 
			[GetSpellInfo(117506)] = 9, -- Undying Shadows
		--Elegon
			[GetSpellInfo(117878)] = 8, -- Overcharged
			[GetSpellInfo(117949)] = 9, -- Closed Circuit
			[GetSpellInfo(132222)] = 10, -- Destabilizing Energies
			[GetSpellInfo(132226)] = 10, -- Destabilized
		--Will of the Emperor
			[GetSpellInfo(116829)] = 10, -- Focused Energy
			[GetSpellInfo(116835)] = 10,	-- Devastating Arc
			[GetSpellInfo(116778)] = 10,	-- Focused Defense
			[GetSpellInfo(116525)] = 10,	-- Focused Assault
			
			
	--Terrace of Endless Spring
		--Protectors of the Endless
			[GetSpellInfo(117436)] = 10, -- Lightning Prison 
			[GetSpellInfo(131931)] = 10, -- Lightning Prison
			[GetSpellInfo(111850)] = 10, -- Lightning Prison
			[GetSpellInfo(118091)] = 10,-- Defiled Ground
			[GetSpellInfo(117519)] = 8,	-- Touch of Sha 118191
			[GetSpellInfo(118191)] = 10,-- Corrupted Essence (Heroic)	
		--Tsulong
			[GetSpellInfo(122777)] = 8, -- Nightmares
			[GetSpellInfo(122752)] = 10, -- Shadow Breath
			[GetSpellInfo(122768)] = 8, -- Nightmares
			[GetSpellInfo(123011)] = 10, -- Terrorize
			[GetSpellInfo(123018)] = 10, -- Terrorize
			[GetSpellInfo(122858)] = 8, -- Bathed in Light, 25%mana & 500% healing done buff
		--Lei Shi
			[GetSpellInfo(123121)] = 10, -- Spray, Stacking frost damage taken debuff.
			[GetSpellInfo(123705)] = 10, -- Scary Fog
		--Sha of Fear
			[GetSpellInfo(129147)] = 7, -- Ominous Cackle, Debuff that sends players to the outer platforms.
			[GetSpellInfo(119086)] = 7, -- Penetrating Bolt, Increased Shadow damage debuff.
			[GetSpellInfo(119775)] = 7, -- Reaching Attack, Increased Shadow damage debuff.
			[GetSpellInfo(119985)] = 7, -- Dread Spray, stacking magic debuff, fears at 2 stacks.
			[GetSpellInfo(119983)] = 7, -- Dread Spray, is also used.
			[GetSpellInfo(119414)] = 7, -- Breath of Fear, Fear+Massiv damage.	
			[GetSpellInfo(120669)] = 10,	-- Naked and Afraid
			[GetSpellInfo(120629)] = 8, -- Huddle in Terror
	--[[ T15 ]]--
	--Throne of Thunder
	--Trash
			[GetSpellInfo(138349)] = 8, -- Static Wound
			[GetSpellInfo(137371)] = 8, -- Thundering Throw
		--Jin'rokh the Breaker
					[GetSpellInfo(137422)] = 4, -- Focused Lightning
					[GetSpellInfo(138349)] = 10, -- Static Burst
					[GetSpellInfo(138002)] = 7, -- Fluidity
					[GetSpellInfo(138006)] = 10, -- Electrified waters
		--Horridon
					[GetSpellInfo(136708)] = 6, -- Stone Gaze (so it's > Sunbeam Debuff)
					[GetSpellInfo(138768)] = 10, -- Triple Puncture. Debuff on tank
					[GetSpellInfo(136719)] = 5, -- Blazing Sunlight, cast by Wastewalker add.
		--Council of Elders
					[GetSpellInfo(137641)] = 9, -- Soul Fragment (Ball)
					[GetSpellInfo(137650)] = 7, -- Shadowed Soul
					[GetSpellInfo(136990)] = 8, -- Frostbite
					[GetSpellInfo(136992)] = 8, -- Biting Cold
		--Tortos
					[GetSpellInfo(137552)] = 8, 
					[GetSpellInfo(137633)] = 8, --Crystal Shell
					[GetSpellInfo(140701)] = 9, -- Crystal Shell: Max Capacity
		--Megaera
					[GetSpellInfo(139857)] = 9, -- Torrent of Ice
					[GetSpellInfo(139822)] = 9, -- Cinderssd
		--Ji-Kun
					[GetSpellInfo(134256)] = 9, -- Slimed
		--Durumu the Forgotten
					[GetSpellInfo(139204)] = 9, -- Infrared Tracking
					[GetSpellInfo(139202)] = 9, -- Blue Ray Tracking
					[GetSpellInfo(133767)] = 10, -- Serious Wound
					[GetSpellInfo(133768)] = 10, -- Arterial Cut
					[GetSpellInfo(133597)] = 10, -- Dark Parasite
					[GetSpellInfo(133798)] = 10, -- Life Drain
		--Primordius
					[GetSpellInfo(136228)] = 10, -- Volatile Pathogen
					[GetSpellInfo(136050)] = 9, -- Malformed Blood
					[GetSpellInfo(137000)] = 9, -- Black Blood
		--Dark Animus
					[GetSpellInfo(138486)] = 9, -- Crimson Wake Target Debuff
					[GetSpellInfo(138609)] = 9, -- Matter Swap
					[GetSpellInfo(136962)] = 8, -- Anima Ring
		--Iron Qon
					[GetSpellInfo(134647)] = 8, -- Scorched
					[GetSpellInfo(137668)] = 9, -- Burning Cinders
					[GetSpellInfo(137669)] = 9, -- Arcing Lightning
					[GetSpellInfo(135145)] = 9, -- Freeze
					[GetSpellInfo(137664)] = 8, -- Frozen Blood
		--Twin Consorts
					[GetSpellInfo(137341)] = 4, -- Beast of Nightmares
					[GetSpellInfo(137360)] = 4, -- Corrupted Healing
					[GetSpellInfo(137408)] = 7, -- Fan of Flames
					[GetSpellInfo(137440)] = 8, -- Icy Shadows
		--Lei Shen
					[GetSpellInfo(135695)] = 8, -- Static Shock
					[GetSpellInfo(136295)] = 8, -- Overcharge
					[GetSpellInfo(139011)] = 9, -- Helm of Command
					[GetSpellInfo(136478)] = 7, -- Fusion Slash
		--Ra-den
-- Siege of Orgrimmar
	-- Immerseus
	[GetSpellInfo(143436)] = 4,	-- Corrosive Blast (Tank switch)
	[GetSpellInfo(143459)] = 3,	-- Sha Residue
	-- The Fallen Protectors
	[GetSpellInfo(143434)] = 4,	-- Shadow Word: Bane (Dispel)
	[GetSpellInfo(143198)] = 3,	-- Garrote (DoT)
	[GetSpellInfo(143842)] = 5,	-- Mark of Anguish
	[GetSpellInfo(147383)] = 3,	-- Debilitation
	-- Norushen
	[GetSpellInfo(146124)] = 4,	-- Self Doubt (Tank switch)
	[GetSpellInfo(144514)] = 3,	-- Lingering Corruption (Dispel)
	-- Sha of Pride
	[GetSpellInfo(144358)] = 4,	-- Wounded Pride (Tank switch)
	[GetSpellInfo(144351)] = 3,	-- Mark of Arrogance (Dispel)
	[GetSpellInfo(146594)] = 3,	-- Gift of the Titans
	[GetSpellInfo(147207)] = 3,	-- Weakened Resolve (Heroic)
	-- Galakras
	[GetSpellInfo(147029)] = 3,	-- Flames of Galakrond (DoT)
	[GetSpellInfo(146765)] = 3,	-- Flame Arrows (DoT)
	[GetSpellInfo(146902)] = 3,	-- Poison-Tipped Blades (Poison stacks)
	-- Iron Juggernaut
	[GetSpellInfo(144467)] = 4,	-- Ignite Armor (Tank stacks)
	[GetSpellInfo(144459)] = 3,	-- Laser Burn (DoT)
	-- Kor'kron Dark Shaman
	[GetSpellInfo(144215)] = 3,	-- Froststorm Strike (Tank stacks)
	[GetSpellInfo(144089)] = 3,	-- Toxic Mist (DoT)
	[GetSpellInfo(144330)] = 3,	-- Iron Prison (Heroic)
	-- General Nazgrim
	[GetSpellInfo(143494)] = 3,	-- Sundering Blow (Tank stacks)
	[GetSpellInfo(143638)] = 3,	-- Bonecracker (DoT)
	[GetSpellInfo(143431)] = 3,	-- Magistrike (Dispel)
	-- Malkorok
	[GetSpellInfo(142990)] = 3,	-- Fatal Strike (Tank stacks)
	[GetSpellInfo(142864)] = 3,	-- Ancient Barrier
	[GetSpellInfo(142865)] = 3,	-- Strong Ancient Barrier
	[GetSpellInfo(142913)] = 3,	-- Displaced Energy (Dispel)
	-- Spoils of Pandaria
	[GetSpellInfo(145218)] = 3,	-- Harden Flesh (Dispel)
	[GetSpellInfo(146235)] = 3,	-- Breath of Fire (Dispel)
	-- Thok the Bloodthirsty
	[GetSpellInfo(143766)] = 3,	-- Panic (Tank stacks)
	[GetSpellInfo(143780)] = 3,	-- Acid Breath (Tank stacks)
	[GetSpellInfo(143773)] = 3,	-- Freezing Breath (Tank Stacks)
	[GetSpellInfo(143800)] = 3,	-- Icy Blood (Random Stacks)
	[GetSpellInfo(143767)] = 3,	-- Scorching Breath (Tank Stacks)
	[GetSpellInfo(143791)] = 3,	-- Corrosive Blood (Dispel)
	-- Siegecrafter Blackfuse
	[GetSpellInfo(143385)] = 3,	-- Electrostatic Charge (Tank stacks)
	[GetSpellInfo(144236)] = 3,	-- Pattern Recognition
	-- Paragons of the Klaxxi
	[GetSpellInfo(142929)] = 3,	-- Tenderizing Strikes (Tank stacks)
	[GetSpellInfo(143275)] = 3,	-- Hewn (Tank stacks)
	[GetSpellInfo(143279)] = 3,	-- Genetic Alteration (Tank stacks)
	[GetSpellInfo(143974)] = 3,	-- Shield Bash (Tank stun)
	[GetSpellInfo(142948)] = 3,	-- Aim
	-- Garrosh Hellscream
	[GetSpellInfo(145183)] = 3,	-- Gripping Despair (Tank stacks)
	[GetSpellInfo(145195)] = 3,	-- Empowered Gripping Despair (Tank stacks)
-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------

		},
	}



cfg.spec = nil
cfg.updateSpec = function()
	cfg.spec = GetSpecialization()
end
------------------------------------------------------------------

--Hand it over :)	
ns.cfg = cfg