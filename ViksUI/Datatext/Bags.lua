local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
 -- BAGS
--------------------------------------------------------------------

if Viks.datatext.Bags and Viks.datatext.Bags > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
	Text:SetTextColor(unpack(Viks.media.pxcolor1))
	Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	PP(Viks.datatext.Bags, Text)

	local function OnEvent(self, event, ...)
		local free, total, used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
		Text:SetText("Bags: "..qColor..free)
		Stat:SetAllPoints(Text)
		Stat:SetScript("OnEnter", function()
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6);
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine("Bags")
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine("Total:",total,0, 0.6, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine("Used:",used,0, 0.6, 1, 1, 1, 1)
		end
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
          
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("BAG_UPDATE")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() ToggleAllBags() end)
end