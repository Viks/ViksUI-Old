local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if Viks.raidcooldown.enable == true then
	T.raid_spells = {
		[20484] = 600,	-- Rebirth
		[61999] = 600,	-- Raise Ally
		[20707] = 600,	-- Soulstone
		[126393] = 600,	-- Eternal Guardian
		[6346] = 180,	-- Fear Ward
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
		[80353] = 300,	-- Time Warp
		[90355] = 300,	-- Ancient Hysteria
			-- Сейвы
		[108280] = 180,	-- Healing Tide Totem
		[64843] = 180,  -- Divine Hymn (Божественный гимн)
		[33206] = 180,  -- Pain Suppression (Подавление боли)
		[62618] = 180,  -- Power Word: Barrier (Купол)
		[97462] = 180,  -- Rallying Cry (Ободряющий клич)
		[31821] = 120,  -- Devotion Aura
		[98008] = 180,  -- Spirit Link Totem (Тотем духовной связи)
		[6940] = 120,   -- Hand of Sacrifice (Сакра)
	}
end

if Viks.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		[57994] = 12,	-- Wind Shear
		[47528] = 15,	-- Mind Freeze
		[80965] = 15,	-- Skull Bash
		[116705] = 15,	-- Spear Hand Strike
		[96231] = 15,	-- Rebuke
		[1766] = 15,	-- Kick
		[6552] = 15,	-- Pummel
		[102051] = 20,	-- Frostjaw
		[147362] = 24,	-- Counter Shot
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[115781] = 24,	-- Optical Blast
		[102060] = 40,	-- Disrupting Shout
		[15487] = 45,	-- Silence
		[47476] = 60,	-- Strangulate
		[78675] = 60,	-- Solar Beam
		-- Crowd Controls
		[115078] = 15,	-- Paralysis
		[20066] = 15,	-- Repentance
		[10326] = 15,	-- Turn Evil
		[108194] = 30,	-- Asphyxiate
		[1499] = 30,	-- Freezing Trap
		[44572] = 30,	-- Deep Freeze
		[105593] = 30,	-- Fist of Justice
		[8122] = 30,	-- Psychic Scream
		[30283] = 30,	-- Shadowfury
		[107570] = 30,	-- Storm Bolt
		[5484] = 40,	-- Howl of Terror
		[19386] = 45,	-- Wyvern Sting
		[113724] = 45,	-- Ring of Frost
		[119381] = 45,	-- Leg Sweep
		[64044] = 45,	-- Psychic Horror
		[51514] = 45,	-- Hex
		[6789] = 45,	-- Mortal Coil
		[853] = 60,		-- Hammer of Justice
		[108200] = 60,	-- Remorseless Winter
		-- Defense abilities
		[48707] = 45,	-- Anti-Magic Shell
		[31224] = 60,	-- Cloak of Shadows
		[8143] = 60,	-- Tremor Totem
		[46924] = 60,	-- Bladestorm
		[108978] = 90,	-- Alter Time
		[49039] = 120,	-- Lichborne
		[137562] = 120,	-- Nimble Brew
		[47585] = 120,	-- Dispersion
		[1856] = 120,	-- Vanish
		[19263] = 180,	-- Deterrence
		[33206] = 180,	-- Pain Suppression
	}
end

if Viks.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		--GetSpellInfo(779),	-- Swipe
		--GetSpellInfo(6807),	-- Maul
	}
end