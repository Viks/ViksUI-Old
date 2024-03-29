local T, Viks, L, _ = unpack(select(2, ...))
local _, ns = ...

local spellcache = setmetatable({}, {__index=function(t,v) local a = {GetSpellInfo(v)} if GetSpellInfo(v) then t[v] = a end return a end})
local function GetSpellInfo(a)
    return unpack(spellcache[a])
end


ns.auras = {
    ascending = {
        --[GetSpellInfo(92956)] = true, -- Wrack
		--[6788] = true, -- Weakened Soul
    },
	debuffs = {
		-- Any Zone
		--["Weakened Soul"] = 12, -- testing purpposes only
		--[6788] = 12, -- Weakened Soul
		--["Sated"] = 12, -- testing purpposes only
		[GetSpellInfo(12294)] = 8, -- Mortal Strike 
		--WoD[GetSpellInfo(82928)] = 8, -- Aimed Shot 
		[GetSpellInfo(2139)] = 10, -- Counterspell 
		[GetSpellInfo(2094)] = 10, -- Blind 
		[GetSpellInfo(33786)] = 10, -- Cyclone 
		[GetSpellInfo(118)] = 7, -- Polymorph 
		[GetSpellInfo(339)] = 7, -- Entangling Roots 
		[GetSpellInfo(1499)] = 7, -- Freezing Trap 
		[GetSpellInfo(25809)] = 6, -- Crippling Poison 
		[GetSpellInfo(1715)] = 5, -- Hamstring 
		[GetSpellInfo(5782)] = 3, -- Fear 
		[GetSpellInfo(8122)] = 3, -- Psychic Scream 
		[GetSpellInfo(5484)] = 3, -- Howl of Terror 
		[GetSpellInfo(6788)] = 10 -- Weakened Soul
	},
	instances = {
		["Mogu'shan Vaults"] = {
			-- The Stone Guard
			[GetSpellInfo(116281)] = 7, -- Cobalt Mine Blast, Magic root

			--Feng the Accursed
			[GetSpellInfo(116040)] = 7, -- Epicenter, roomwide aoe.
			[GetSpellInfo(116784)] = 7, -- Wildfire Spark, Debuff that explodes leaving fire on the ground after 5 sec.
			[GetSpellInfo(116374)] = 7, -- Lightning Charge, Stun debuff.
			[GetSpellInfo(116417)] = 7, -- Arcane Resonance, aoe-people-around-you-debuff.
			[GetSpellInfo(116942)] = 7, -- Flaming Spear, fire damage dot.

			-- Gara'jal the Spiritbinder
			[GetSpellInfo(122151)] = 7,	-- Voodoo Doll, shared damage with the tank.
			[GetSpellInfo(116161)] = 7,	-- Crossed Over, people in the spirit world.

			-- The Spirit Kings
			[GetSpellInfo(117708)] = 7, -- Meddening Shout, The mind control debuff.
			[GetSpellInfo(118303)] = 7, -- Fixate, the once targeted by the shadows.
			[GetSpellInfo(118048)] = 7, -- Pillaged, the healing/Armor/damage debuff.
			[GetSpellInfo(118135)] = 7, -- Pinned Down, Najentus spine 2.0

			--Elegon
			[GetSpellInfo(117878)] = 7, -- Overcharged, the stacking increased damage taken debuff.	
			[GetSpellInfo(117870)] = 7, -- Touch of the Titans, the debuff everybody gets increasing damage done and healing taken.
			[GetSpellInfo(117949)] = 7, -- Closed Circuit, Magic Healing debuff.

			--Will of the Emperor
			[GetSpellInfo(116969)] = 7, -- Stomp, Stun from the bosses.
			[GetSpellInfo(116835)] = 7, -- Devestating Arc, Armor debuff from the boss.
			[GetSpellInfo(116778)] = 7, -- Focused Defense, Fixate from the Emperors Courage.
			[GetSpellInfo(117485)] = 7, -- Impending Thrust, Stacking slow from the Emperors Courage.
			[GetSpellInfo(116525)] = 7, -- Focused Assault, Fixate from the Emperors Rage
			[GetSpellInfo(116550)] = 7, -- Energizing Smash, Knockdown from the Emperors Strength
		},
		["Heart of Fear"] = {
			-- Imperial Vizier Zor'lok
			[GetSpellInfo(122761)] = 7, -- Exhale, The person targeted for Exhale. 
			[GetSpellInfo(123812)] = 7, -- Pheromones of Zeal, the gas in the middle of the room.
			[GetSpellInfo(122706)] = 7, -- Noise Cancelling, The "safe zone" from the roomwide aoe.
			[GetSpellInfo(122740)] = 7, -- Convert, The mindcontrol Debuff.

			-- Blade Lord Ta'yak
			[GetSpellInfo(123180)] = 7, -- Wind Step, Bleeding Debuff from stealth.
			[GetSpellInfo(123474)] = 7, -- Overwhelming Assault, stacking tank swap debuff. 

			-- Garalon
			[GetSpellInfo(122774)] = 7, -- Crush, stun from the crush ability.
			[GetSpellInfo(123426)] = 7, -- Weak Points, Increased damage done to one leg.
			[GetSpellInfo(123428)] = 7, -- Weak Points, Increased damage to another leg.
			[GetSpellInfo(123423)] = 7, -- Weak Points, Increased damage to another leg.
			[GetSpellInfo(123235)] = 7, -- Weak Points, Increased damage to another leg.
			[GetSpellInfo(122835)] = 7, -- Pheromones, The buff indicating who is carrying the pheramone.
			[GetSpellInfo(123081)] = 7, -- Punchency, The stacking debuff causing the raid damage.

			--Wind Lord Mel'jarak
			[GetSpellInfo(122055)] = 7, -- Residue, The debuff after breaking a prsion preventing further breaking.
			[GetSpellInfo(121885)] = 7, -- Amber Prison, The stun that somebody has to click off.
			[GetSpellInfo(121881)] = 7, -- Amber Prison, not sure what the differance is but both were used.
			[GetSpellInfo(122125)] = 7, -- Corrosive Resin pool, the **** on the floor your not supposed to stand in.
			[GetSpellInfo(122064)] = 7, -- Corrosive Resin, the dot you clear by moving/jumping.

			-- Amber-Shaper Un'sok 
			[GetSpellInfo(122370)] = 7, -- Reshape Life, the transformation ala putricide.
			[GetSpellInfo(122784)] = 7, -- Reshape Life, Both were used.
			[GetSpellInfo(124802)] = 7, -- The transformed players increase damage taken cooldown.
			[GetSpellInfo(122395)] = 7, -- Struggle for Control, the self stun used to interupt the channel.
			[GetSpellInfo(122457)] = 7, -- Rough Landing, The stun from being tossed and being hit by the toss from the add in Phase 2.
			[GetSpellInfo(121949)] = 7, -- Parasitic Growth, the dot that scales with healing taken.
		},
		["Terrace of Endless Spring"] = {
			--Protectors Of the Endless
			[GetSpellInfo(117519)] = 7, -- Touch of Sha, Dot that lasts untill Kaolan is defeated.
			[GetSpellInfo(117235)] = 7, -- Purified, haste buff gained by killing mist and being in range.
			[GetSpellInfo(117353)] = 7, -- Overwhelming Corruption, stacking raidwide softenrage debuff.
			[GetSpellInfo(118091)] = 7, -- Defiled Ground, Increased damage taken from Defiled ground debuff.
			[GetSpellInfo(117436)] = 7, -- Lightning Prison, Magic stun.

			--Tsulong
			[GetSpellInfo(122768)] = 7, -- Dread Shadows, Stacking raid damage debuff (ragnaros superheated style) 
			[GetSpellInfo(122789)] = 7, -- Sunbeam, standing in the sunbeam, used to clear dread shadows.
			[GetSpellInfo(122858)] = 7, -- Bathed in Light, 500% increased healing done debuff.
			[GetSpellInfo(122752)] = 7, -- Shadow Breath, increased shadow breath damage debuff.
			[GetSpellInfo(123011)] = 7, -- Terrorize, Magical dot dealing % health.
			[GetSpellInfo(123036)] = 7, -- Fright, 2 second fear.
			[GetSpellInfo(122777)] = 7, -- Nightmares, 3 second fear.

			--Lei Shi
			[GetSpellInfo(123121)] = 7, -- Spray, Stacking frost damage taken debuff.

			--Sha of Fear
			[GetSpellInfo(129147)] = 7, -- Ominous Cackle, Debuff that sends players to the outer platforms.
			[GetSpellInfo(119086)] = 7, -- Penetrating Bolt, Increased Shadow damage debuff.
			[GetSpellInfo(119775)] = 7, -- Reaching Attack, Increased Shadow damage debuff.
			[GetSpellInfo(119985)] = 7, -- Dread Spray, stacking magic debuff, fears at 2 stacks.
			[GetSpellInfo(119983)] = 7, -- Dread Spray, is also used.
			[GetSpellInfo(119414)] = 7, -- Breath of Fear, Fear+Massiv damage.
		},
		["Dragon Soul"] = {
			-- Morchok
			[GetSpellInfo(103687)] = 7, -- Crush Armor
			-- Warlord Zon'ozz
			[GetSpellInfo(103434)] = 8, -- Disrupting Shadows
			-- some shit boss with blobs
			[GetSpellInfo(104849)] = 8, -- Void Bolt
			[109389] = 12, 				-- Deep Corruption stacks (108220)
			[103628] = 12,				-- Deep Corruption stacks
			-- Hagara the Stormbinder
			[GetSpellInfo(109325)] = 7, -- Frostflake, HC
			[GetSpellInfo(104451)] = 7, -- Ice Tomb
			[GetSpellInfo(105313)] = 7, -- Ice Lance
			[GetSpellInfo(105289)] = 7, -- Shattered Ice
			-- Blackhorn
			-- Ultraxion
			[GetSpellInfo(109075)] = 8, -- Fading Light
			-- Spine of Deathwing
			[GetSpellInfo(109379)] = 7, -- Searing Plasma
			[GetSpellInfo(105490)] = 8, -- Fiery Grip
			-- Madness 
			[GetSpellInfo(105841)] = 7,  -- Degenerative Bite
			[GetSpellInfo(105445)] = 8,  -- Blistering Heat
			[GetSpellInfo(106444)] = 9,  -- Impale
		
		},
	["Siege of Orgrimmar"] = {
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
		
		},
	},
}
