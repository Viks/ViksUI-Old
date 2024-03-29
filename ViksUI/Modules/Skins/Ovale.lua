﻿local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.ovale ~= true then return end

----------------------------------------------------------------------------------------
--	OvaleSpellPriority skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("Ovale") then return end

	if not OvaleDB then OvaleDB = {} end
	if not OvaleDB["profiles"] then OvaleDB["profiles"] = {} end
	if not OvaleDB["profiles"][T.name.." - "..T.realm] then OvaleDB["profiles"][T.name.." - "..T.realm] = {} end
	if not OvaleDB["profiles"][T.name.." - "..T.realm]["apparence"] then OvaleDB["profiles"][T.name.." - "..T.realm]["apparence"] = {} end

	OvaleDB["profiles"][T.name.." - "..T.realm]["apparence"]["iconScale"] = 1
	OvaleDB["profiles"][T.name.." - "..T.realm]["apparence"]["smallIconScale"] = 1
	OvaleDB["profiles"][T.name.." - "..T.realm]["apparence"]["secondIconScale"] = 1
	OvaleDB["profiles"][T.name.." - "..T.realm]["apparence"]["margin"] = 3

	for i = 1, 10 do
		for j = 1, 2 do
			local button = _G["Icon"..i.."n"..j]

			if button and not button.isSkinned then
				button.cd.noOCC = true
				button:StyleButton()
				button:SetNormalTexture("")
				button:CreateBackdrop("Transparent")
				button.backdrop:SetAllPoints()

				button.icone:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button.icone:SetPoint("TOPLEFT", button, 2, -2)
				button.icone:SetPoint("BOTTOMRIGHT", button, -2, 2)

				button.remains:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
				button.remains:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)

				button.shortcut:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
				button.shortcut:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)

				button.focusText:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
				button.focusText:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)

				button.isSkinned = true
			end
		end
	end
end)