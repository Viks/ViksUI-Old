local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
-- Player Hit
--------------------------------------------------------------------

-- Hit Rating
if not Viks.datatext.Hit == nil or Viks.datatext.Hit > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
if Viks.datatext.Hit >= 9 then
Text:SetTextColor(unpack(Viks.media.pxcolor1))
Text:SetFont(Viks.media.pxfontHeader, Viks.media.pxfontHsize, Viks.media.pxfontHFlag)
else
Text:SetTextColor(unpack(Viks.media.pxcolor1))
Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
end
	PP(Viks.datatext.Hit, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		local base, posBuff, negBuff = UnitAttackPower("player")
		local effective = base + posBuff + negBuff
		local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
		local Reffective = Rbase + RposBuff + RnegBuff

		Rattackpwr = Reffective
		spellpwr = GetSpellBonusDamage(7)
		attackpwr = effective

		if int < 0 then
			if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
				Text:SetText(qColor..format("%.2f", GetCombatRatingBonus(6))..qColor2.."% Hit")
			elseif select(2, UnitClass("Player")) == "HUNTER" then
				Text:SetText(qColor..format("%.2f", GetCombatRatingBonus(7))..qColor2.."% Hit")
			else
				Text:SetText(qColor..format("%.2f", GetCombatRatingBonus(8))..qColor2.."% Hit")
			end
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end