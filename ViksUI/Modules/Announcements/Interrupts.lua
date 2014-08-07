local T, Viks, L, _ = unpack(select(2, ...))
if Viks.announcements.interrupts ~= true then return end

----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID = ...
	if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end

	SendChatMessage(INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), T.CheckChat())
end)