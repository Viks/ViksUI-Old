local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.cool_line ~= true then return end

----------------------------------------------------------------------------------------
--	CoolLine skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("CoolLine") then return end

	CoolLineDB.border = "None"
	CoolLineDB.bgcolor.a = 0
	CoolLineDB.inactivealpha = 1
	CoolLineDB.activealpha = 1
	CoolLineDB.font = "Hooge"
	CoolLineDB.fontsize = Viks.font.stylization_font_size
	CoolLineDB.w = (Viks.actionbar.buttonsize * 12) + (Viks.actionbar.buttonspacing * 11) - 4
	CoolLineDB.h = Viks.actionbar.buttonsize - 4

	local CoolLineBar = CreateFrame("Frame", "CoolLineBar", CoolLine)
	CoolLineBar:SetPoint("TOPLEFT", CoolLine, "TOPLEFT", -2, 2)
	CoolLineBar:SetPoint("BOTTOMRIGHT", CoolLine, "BOTTOMRIGHT", 2, -2)
	CoolLineBar:SetTemplate("Transparent")
	CoolLineBar:SetFrameStrata("BACKGROUND")
end)