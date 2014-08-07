﻿local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.omen ~= true or not IsAddOnLoaded("Omen") then return end

----------------------------------------------------------------------------------------
--	Omen skin
----------------------------------------------------------------------------------------
local Omen = LibStub("AceAddon-3.0"):GetAddon("Omen")

-- Skin Bar Texture
Omen.UpdateBarTextureSettings_ = Omen.UpdateBarTextureSettings
Omen.UpdateBarTextureSettings = function(self)
	for i, v in ipairs(self.Bars) do
		v.texture:SetTexture(Viks.media.texture)
		v:CreateBackdrop("Transparent")
	end
end

-- Skin Bar fonts
Omen.UpdateBarLabelSettings_ = Omen.UpdateBarLabelSettings
Omen.UpdateBarLabelSettings = function(self)
	self:UpdateBarLabelSettings_()
	for i, v in ipairs(self.Bars) do
		v.Text1:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
		v.Text1:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)
		v.Text2:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
		v.Text2:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)
		v.Text3:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
		v.Text3:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)
	end
end

-- Skin Title Bar
Omen.UpdateTitleBar_ = Omen.UpdateTitleBar
Omen.UpdateTitleBar = function(self)
	Omen.db.profile.Scale = 1
	Omen.db.profile.Background.EdgeSize = 1
	Omen.db.profile.Background.BarInset = 2
	Omen.db.profile.TitleBar.UseSameBG = true
	self:UpdateTitleBar_()
	self.TitleText:SetFont(Viks.font.stylization_font, Viks.font.stylization_font_size, Viks.font.stylization_font_style)
	self.TitleText:SetShadowOffset(Viks.font.stylization_font_shadow and 1 or 0, Viks.font.stylization_font_shadow and -1 or 0)
	self.BarList:SetPoint("TOPLEFT", self.Title, "BOTTOMLEFT", 0, -3)
end

-- Skin Title/Bars backgrounds
Omen.UpdateBackdrop_ = Omen.UpdateBackdrop
Omen.UpdateBackdrop = function(self)
	Omen.db.profile.Scale = 1
	Omen.db.profile.Background.EdgeSize = 1
	Omen.db.profile.Background.BarInset = 2
	self:UpdateBackdrop_()
	self.Title:SetTemplate("Transparent")
	self.BarList:SetPoint("TOPLEFT", self.Title, "BOTTOMLEFT", 0, -3)
end

-- Hook bar creation to apply settings
local omen_mt = getmetatable(Omen.Bars)
local oldidx = omen_mt.__index
omen_mt.__index = function(self, barID)
	local bar = oldidx(self, barID)
	Omen:UpdateBarTextureSettings()
	Omen:UpdateBarLabelSettings()
	return bar
end

-- Option Overrides
Omen.db.profile.NumBars = 7
if Viks.skins.minimap_buttons == true then
	Omen.db.profile.MinimapIcon.hide = false
else
	Omen.db.profile.MinimapIcon.hide = true
end
Omen.db.profile.Autocollapse = true
Omen.db.profile.Bar.Spacing = 7
Omen.db.profile.Bar.Height = 12
Omen.db.profile.Bar.Texture = "Smooth"
Omen.db.profile.Bar.FontSize = 8
Omen.db.profile.Bar.Font = "Hooge"
Omen.db.profile.Bar.ShowHeadings = false
Omen.db.profile.TitleBar.ShowTitleBar = false
Omen.db.profile.TitleBar.FontSize = 8
Omen.db.profile.TitleBar.Font = "Hooge"
Omen.db.profile.Background.Texture = "Smooth"
Omen.db.profile.Bar.FontSize = 8
Omen.db.profile.Bar.ShowHeadings = false
Omen.db.profile.Shown = true
Omen.db.profile.Locked = true

-- Force updates
Omen:UpdateBarTextureSettings()
Omen:UpdateBarLabelSettings()
Omen:UpdateTitleBar()
Omen:UpdateBackdrop()
Omen:ReAnchorBars()
Omen:ResizeBars()