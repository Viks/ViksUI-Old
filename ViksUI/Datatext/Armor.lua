local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
-- player Armor
--------------------------------------------------------------------

if Viks.datatext.Armor and Viks.datatext.Armor > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
	--Set font based on where.
	if Viks.datatext.Armor >= 6 then
		Text:SetTextColor(unpack(Viks.media.pxcolor1))
		Text:SetFont(Viks.media.pxfontHeader, Viks.media.pxfontHsize, Viks.media.pxfontHFlag)
	else
		Text:SetTextColor(unpack(Viks.media.pxcolor1))
		Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	end

	PP(Viks.datatext.Armor, Text)

	local function Update(self)
		baseArmor , effectiveArmor, Armor, posBuff, negBuff = UnitArmor("player");
		shortArmor = effectiveArmor/1000
		if Viks.datatext.Armor >= 6 then
		Text:SetText("|cffFFFFFF"..format("%.1f",(shortArmor)).."K "..qColor2.."Armor")
		else
		Text:SetText(qColor..format("%.1f",(shortArmor)).."K "..qColor2.."Armor")
		end
		--Setup Armor Tooltip
		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)	
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine("Mitigation By Level: ")
			local lv = 83
			for i = 1, 4 do
				local format = string.format
				local mitigation = (effectiveArmor/(effectiveArmor+(467.5*lv-22167.5)));
				if mitigation > .75 then
					mitigation = .75
				end
				GameTooltip:AddDoubleLine(lv,format("%.2f", mitigation*100) .. "%",1,1,1)
				lv = lv - 1
			end
			if UnitLevel("target") > 0 and UnitLevel("target") < UnitLevel("player") then
				mitigation = (effectiveArmor/(effectiveArmor+(467.5*(UnitLevel("target"))-22167.5)));
				if mitigation > .75 then
					mitigation = .75
				end
				GameTooltip:AddDoubleLine(UnitLevel("target"),format("%.2f", mitigation*100) .. "%",1,1,1)
			end
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end
