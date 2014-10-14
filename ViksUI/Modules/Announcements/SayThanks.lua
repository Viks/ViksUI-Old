﻿local T, Viks, L, _ = unpack(select(2, ...))
if Viks.announcements.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local spells = {
	[29166] = true,		-- Innervate
	[20484] = true,		-- Rebirth
	[61999] = true,		-- Raise Ally
	[20707] = true,		-- Soulstone
	[50769] = true,		-- Revive
	[2006] = true,		-- Resurrection
	[7328] = true,		-- Redemption
	[2008] = true,		-- Ancestral Spirit
	[115178] = true,	-- Resuscitate
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(_, event, _, applied, _, _, buffer, _, _, _, player, _, _, spell, ...)
	for key, value in pairs(spells) do
		if spell == key and value == true and player == T.name and buffer ~= T.name and (applied == "SPELL_AURA_APPLIED" or applied == "SPELL_CAST_SUCCESS") then
			SendChatMessage(L_ANNOUNCE_SS_THANKS..GetSpellLink(spell)..", "..buffer, "WHISPER", nil, buffer)
			print(GetSpellLink(spell)..L_ANNOUNCE_SS_RECEIVED..buffer)
		end
	end
end)