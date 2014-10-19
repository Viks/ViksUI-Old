local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Switch theme mouseover button on minimap
----------------------------------------------------------------------------------------
local theme = CreateFrame("Button", "SwitchTheme", UIParent)
theme:SetTemplate("Transparent")
theme:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -3, 0)
theme:SetSize(19, 19)
theme:SetAlpha(0)

theme.t = theme:CreateTexture(nil, "OVERLAY")
theme.t:SetTexture(Viks.media.blank)
theme.t:SetVertexColor(unpack(Viks.media.bordercolor))
theme.t:SetPoint("TOPLEFT", theme, 2, -2)
theme.t:SetPoint("BOTTOMRIGHT", theme, -2, 2)

local function ThemeBorderC(r, g, b, a)
	if not ViksConfigAll then return end
	if ViksConfigAll[T.realm][T.name] == true then
		if ViksConfig == nil then ViksConfig = {} end
		if ViksConfig["media"] == nil then ViksConfig["media"] = {} end
		ViksConfig["media"]["bordercolor"] = {r, g, b, a}
	else
		if ViksConfigSettings == nil then ViksConfigSettings = {} end
		if ViksConfigSettings["media"] == nil then ViksConfigSettings["media"] = {} end
		ViksConfigSettings["media"]["bordercolor"] = {r, g, b, a}
	end
end

local function ThemeBackdropC(r, g, b, a)
	if not ViksConfigAll then return end
	if ViksConfigAll[T.realm][T.name] == true then
		if ViksConfig == nil then ViksConfig = {} end
		if ViksConfig["media"] == nil then ViksConfig["media"] = {} end
		ViksConfig["media"]["backdropcolor"] = {r, g, b, a}
	else
		if ViksConfigSettings == nil then ViksConfigSettings = {} end
		if ViksConfigSettings["media"] == nil then ViksConfigSettings["media"] = {} end
		ViksConfigSettings["media"]["backdropcolor"] = {r, g, b, a}
	end
end

local function ThemeOverlayC(r, g, b, a)
	if not ViksConfigAll then return end
	if ViksConfigAll[T.realm][T.name] == true then
		if ViksConfig == nil then ViksConfig = {} end
		if ViksConfig["media"] == nil then ViksConfig["media"] = {} end
		ViksConfig["media"]["overlay_color"] = {r, g, b, a}
	else
		if ViksConfigSettings == nil then ViksConfigSettings = {} end
		if ViksConfigSettings["media"] == nil then ViksConfigSettings["media"] = {} end
		ViksConfigSettings["media"]["overlay_color"] = {r, g, b, a}
	end
end

local menuFrame = CreateFrame("Frame", "MinimapSwitchThemeButton", UIParent, "UIDropDownMenuTemplate")
local thememenu = {
	{text = "Style", isTitle = 1, notCheckable = 1, notClickable = 1},
	{text = "Classic", notCheckable = 1, func = function()
		ThemeBorderC(0, .38, .651, 1)
		ThemeBackdropC(.06,.06,.06, 1)
		ThemeOverlayC(0, 0, 0, 0.9)
		ReloadUI()
	end},
	{text = "ClassicTransp", notCheckable = 1, func = function()
		ThemeBorderC(0, .38, .651, 1)
		ThemeBackdropC(.06,.06,.06, 1)
		ThemeOverlayC(0, 0, 0, 0.5)
		ReloadUI()
	end},
	{text = "Dark", notCheckable = 1, func = function()
		ThemeBorderC(.31, .31, .31, 1)
		ThemeBackdropC(.1, .1, .1, 1)
		ThemeOverlayC(.054, .054, .054, .8)
		ReloadUI()
	end},
	{text = "Black", notCheckable = 1, func = function()
		ThemeBorderC(.125, .125, .125)
		ThemeBackdropC(.05, .05, .05)
		ThemeOverlayC(0, 0, 0, 0.4)
		ReloadUI()
	end},
	{text = format("|cff%02x%02x%02x%s|r", 255 * T.color.r, 255 * T.color.g, 255 * T.color.b, "ClassColor"), notCheckable = 1, func = function()
		ThemeBorderC(T.color.r, T.color.g, T.color.b, 1)
		ThemeBackdropC(.06,.06,.06, 1)
		ThemeOverlayC(0, 0, 0, 0.9)
		ReloadUI()
	end},
}

theme:EnableMouse(true)
theme:SetScript("OnClick", function()
	EasyMenu(thememenu, menuFrame, "cursor", 0, 0, "MENU")
end)

theme:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	theme:FadeIn()
end)

theme:SetScript("OnLeave", function()
	theme:FadeOut()
end)