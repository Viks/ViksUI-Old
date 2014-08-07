local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
-- Crit (Spell or Melee.. or ranged)
--------------------------------------------------------------------

if Viks.datatext.Crit and Viks.datatext.Crit > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
	Text:SetTextColor(unpack(Viks.media.pxcolor1))
	Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	PP(Viks.datatext.Crit, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		meleeCrit = GetCritChance()
		spellCrit = GetSpellCritChance(1)
		rangedCrit = GetRangedCritChance()
		if spellCrit > meleeCrit then
			CritChance = spellCrit
		elseif select(2, UnitClass("Player")) == "HUNTER" then    
			CritChance = rangedCrit
		else
			CritChance = meleeCrit
		end
		if int < 0 then
			Text:SetText(format("%.2f", CritChance) .. "%".."Crit")
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end