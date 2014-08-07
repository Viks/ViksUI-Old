local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
-- Mastery
----------------------------------------------------------------

if not Viks.datatext.Mastery == nil or Viks.datatext.Mastery > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
	--Set font based on where.
	if Viks.datatext.Mastery >= 6 then
		Text:SetTextColor(unpack(Viks.media.pxcolor1))
		Text:SetFont(Viks.media.pxfontHeader, Viks.media.pxfontHsize, Viks.media.pxfontHFlag)
	else
		Text:SetTextColor(unpack(Viks.media.pxcolor1))
		Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	end
	PP(Viks.datatext.Mastery, Text)

	local int = 1
	
	local function Update(self, t)
		int = int - t
		if int < 0 then
			if Viks.datatext.Mastery >= 6 then
			Text:SetText("|cffFFFFFF"..GetCombatRating(26)..qColor2.." Mastery")
			int = 1
			else
			Text:SetText(qColor..GetCombatRating(26)..qColor2.." Mastery")
			int = 1
			end
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end