local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.weak_auras ~= true then return end

----------------------------------------------------------------------------------------
--	WeakAuras skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("WeakAuras") then return end

	local function Skin_WeakAuras(frame)
		if not frame.backdrop then
			frame:CreateBackdrop("Default")
		end

		if frame.icon then
			frame.icon.SetTexCoord = T.dummy
		end

		if frame.bar then
			frame.bar.fg:SetTexture(Viks.media.texture)
			frame.bar.bg:SetTexture(Viks.media.texture)
		end

		if frame.stacks then
			frame.stacks:SetFont(Viks.font.filger_font, select(2, frame.stacks:GetFont()), Viks.font.filger_font_style)
			frame.stacks:SetShadowOffset(Viks.media.filger_font_shadow and 1 or 0, Viks.media.filger_font_shadow and -1 or 0)
		end

		if frame.timer then
			frame.timer:SetFont(Viks.font.filger_font, select(2, frame.timer:GetFont()), Viks.font.filger_font_style)
			frame.timer:SetShadowOffset(Viks.font.filger_font_shadow and 1 or 0, Viks.font.filger_font_shadow and -1 or 0)
		end

		if frame.text then
			frame.text:SetFont(Viks.font.filger_font, select(2, frame.text:GetFont()), Viks.font.filger_font_style)
			frame.text:SetShadowOffset(Viks.font.filger_font_shadow and 1 or 0, Viks.font.filger_font_shadow and -1 or 0)
		end
	end

	for weakAura, _ in pairs(WeakAuras.regions) do
		if WeakAuras.regions[weakAura].regionType == "icon" or WeakAuras.regions[weakAura].regionType == "aurabar" then
			Skin_WeakAuras(WeakAuras.regions[weakAura].region)
		end
	end
end)