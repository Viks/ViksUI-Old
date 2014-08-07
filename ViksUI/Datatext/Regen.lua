local T, Viks, L, _ = unpack(select(2, ...))
if not Viks.datatext.Regen and not Viks.datatext.Regen > 0 then return end

local regen

local Stat = CreateFrame("Frame")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

local Text  = LBottom:CreateFontString(nil, "OVERLAY")
	if Viks.datatext.Regen >= 6 then
		Text:SetTextColor(unpack(Viks.media.pxcolor1))
		Text:SetFont(Viks.media.pxfontHeader, Viks.media.pxfontHsize, Viks.media.pxfontHFlag)
	else
		Text:SetTextColor(unpack(Viks.media.pxcolor1))
		Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	end
PP(Viks.datatext.Regen, Text)

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("PLAYER_REGEN_DISABLED")
Stat:RegisterEvent("PLAYER_REGEN_ENABLED")
Stat:RegisterEvent("UNIT_STATS")
Stat:RegisterEvent("UNIT_AURA")
Stat:SetScript("OnEvent", function(self)
	local base, casting = GetManaRegen()

	if InCombatLockdown() then
		regen = floor(casting*5)
	else
		regen = floor(base*5)		
	end
	if Viks.datatext.Regen >= 6 then
	Text:SetText("|cffFFFFFF"..regen..qColor2.." "..MANA_REGEN_ABBR)
	else
	Text:SetText(qColor..regen..qColor2.." "..MANA_REGEN_ABBR)
	end
end)