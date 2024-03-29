﻿local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.nug_running ~= true then return end

----------------------------------------------------------------------------------------
--	NugRunning skin(by MrRuben5)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("NugRunning") then return end

	local NugRunning = NugRunning
	local TimerBar = NugRunning and NugRunning.TimerBar

	-- Creates timerbar
	local _ConstructTimerBar = NugRunning.ConstructTimerBar
	function NugRunning.ConstructTimerBar(w, h)
		local f = _ConstructTimerBar(w, h)

		f:SetBackdrop(nil)

		local ic = f.icon:GetParent()
		ic:CreateBackdrop("Default")

		f.bar:CreateBackdrop("Default")

		f.bar:SetStatusBarTexture(Viks.media.texture)
		f.bar:GetStatusBarTexture():SetDrawLayer("ARTWORK")
		f.bar.bg:SetTexture(Viks.media.texture)
		f.bar.bg:SetAlpha(0.3)

		f.timeText:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
		f.timeText:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)
		f.spellText:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
		f.spellText:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)
		f.stacktext:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
		f.stacktext:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)

		TimerBar.Resize(f, w, h)

		return f
	end

	-- Resizes timerbar
	local _Resize = TimerBar.VScale
	function TimerBar.Resize(f, w, h)
		_Resize(f, w, h)

		local ic = f.icon:GetParent()
		ic:ClearAllPoints()
		ic:SetPoint("TOPLEFT", f, 1, -1)
		ic:SetPoint("BOTTOMLEFT", f, 1, 0)

		f.bar:ClearAllPoints()
		f.bar:SetPoint("TOPRIGHT", f, -1, -1)
		f.bar:SetPoint("BOTTOMRIGHT", f, -1, 0)
		f.bar:SetPoint("LEFT", ic, "RIGHT", 5, 0)

		f.timeText:SetJustifyH("RIGHT")
		f.timeText:ClearAllPoints()
		f.timeText:SetPoint("RIGHT", 1, 0)

		f.spellText:SetJustifyH("LEFT")
		f.spellText:ClearAllPoints()
		f.spellText:SetPoint("LEFT", 2, 0)
		f.spellText:SetWidth(f.bar:GetWidth() - 10)
	end
end)