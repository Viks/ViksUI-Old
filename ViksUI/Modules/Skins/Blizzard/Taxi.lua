local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Taxi skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame:CreateBackdrop("Transparent")
	TaxiFrame.backdrop:SetPoint("TOPLEFT", -5, 3)
	TaxiFrame.backdrop:SetPoint("BOTTOMRIGHT", 5, -7)
	TaxiRouteMap:CreateBackdrop("Default")
	T.SkinCloseButton(TaxiFrame.CloseButton)
	TaxiFrame.CloseButton:SetPoint("TOPRIGHT", -4, -1)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)