local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.zygor ~= true then return end

----------------------------------------------------------------------------------------
--	Zygor skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("ZygorGuidesViewer") then return end
	ZygorGuidesViewerFrame:StripTextures(true)
	ZygorGuidesViewerFrame_Border:SetTemplate("Transparent")
	ZygorGuidesViewer_CreatureViewer:StripTextures(true)
	ZygorGuidesViewer_CreatureViewer:SetTemplate("Transparent", true)


end)
