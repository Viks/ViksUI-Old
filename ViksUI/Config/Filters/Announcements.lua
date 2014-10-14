﻿local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if Viks.announcements.spells == true then
	T.AnnounceSpells = {
		34477,	-- Misdirection
		19801,	-- Tranquilizing Shot
		57934,	-- Tricks of the Trade
		633,	-- Lay on Hands
		20484,	-- Rebirth
		61999,	-- Raise Ally
		20707,	-- Soulstone
		2908,	-- Soothe
	}
end

if Viks.announcements.toys == true then
	T.AnnounceToys = {
		[61031] = true,		-- Toy Train Set
		[49844] = true,		-- Direbrew's Remote
	}
end

if Viks.announcements.feasts == true then
	T.AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
		[44389] = true,		-- Field Repair Bot 110G
		[54711] = true,		-- Scrapbot
		[67826] = true,		-- Jeeves
		[126459] = true,	-- Blingtron 4000
	}
end

if Viks.announcements.portals == true then
	T.AnnouncePortals = {
		-- Alliance
		[10059] = true,		-- Stormwind
		[11416] = true,		-- Ironforge
		[11419] = true,		-- Darnassus
		[32266] = true,		-- Exodar
		[49360] = true,		-- Theramore
		[33691] = true,		-- Shattrath
		[88345] = true,		-- Tol Barad
		[132620] = true,	-- Vale of Eternal Blossoms
		-- Horde
		[11417] = true,		-- Orgrimmar
		[11420] = true,		-- Thunder Bluff
		[11418] = true,		-- Undercity
		[32267] = true,		-- Silvermoon
		[49361] = true,		-- Stonard
		[35717] = true,		-- Shattrath
		[88346] = true,		-- Tol Barad
		[132626] = true,	-- Vale of Eternal Blossoms
		-- Alliance/Horde
		[53142] = true,		-- Dalaran
	}
end


if Viks.announcements.bad_gear == true then
	T.AnnounceBadGear = {
		-- Head
		[1] = {
			88710,	-- Nat's Hat
			33820,	-- Weather-Beaten Fishing Hat
			19972,	-- Lucky Fishing Hat
			46349,	-- Chef's Hat
			92738,	-- Safari Hat
		},
		-- Neck
		[2] = {
			32757,	-- Blessed Medallion of Karabor
		},
		-- Feet
		[8] = {
			50287,	-- Boots of the Bay
			19969,	-- Nat Pagle's Extreme Anglin' Boots
		},
		-- Back
		[15] = {
			65360,	-- Cloak of Coordination
			65274,	-- Cloak of Coordination
		},
		-- Main-Hand
		[16] = {
			44050,	-- Mastercraft Kalu'ak Fishing Pole
			19970,	-- Arcanite Fishing Pole
			84660,	-- Pandaren Fishing Pole
			84661,	-- Dragon Fishing Pole
			45992,	-- Jeweled Fishing Pole
			86559,	-- Frying Pan
			45991,	-- Bone Fishing Pole
		},
		-- Off-hand
		[17] = {
			86558,	-- Rolling Pin
		},
	}
end