local T, Viks, L, _ = unpack(select(2, ...))
if Viks.actionbar.enable ~= true or Viks.skins.flyout_button ~= true then return end

----------------------------------------------------------------------------------------
--	FlyoutButtonCustom skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("FlyoutButtonCustom") then return end

	FlyoutButtonCustom_Settings.Highlight = false
	FlyoutButtonCustom_Settings.ShowBorders = false
	FlyoutButtonCustom_Settings.ButtonsScale = 1
	FBC_BUTTON_PLACE_SIZE = Viks.actionbar.buttonsize
	FBC_BUTTON_PLACE_OFFSET = Viks.actionbar.buttonspacing
	FBC_FRAME_OFFSET = Viks.actionbar.buttonspacing - 7

	local function CreateBorder(self)
		local name = self:GetName()
		local button = self
		local icon = _G[btn:GetName().."Icon"]
		local cooldown = _G[btn:GetName().."Cooldown"]
		local border = _G[btn:GetName().."Border"]
		local count = _G[btn:GetName().."Count"]
		local btname = _G[btn:GetName().."Name"]
		local hotkey = _G[btn:GetName().."HotKey"]
		local normal = _G[btn:GetName().."NormalTexture"]

		button:StyleButton()
		button:SetNormalTexture("")

		if border then
			border:Hide()
			border = T.dummy
		end

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 0, 2)
		count:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
		count:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)

		if btname then
			if Viks.actionbar.macro == true then
				btname:ClearAllPoints()
				btname:SetPoint("BOTTOM", 0, 0)
				btname:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
				btname:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)
				--btname:SetWidth(Viks.actionbar.buttonsize - 1)
			else
				btname:Kill()
			end
		end

		if Viks.actionbar.hotkey == true then
			hotkey:ClearAllPoints()
			hotkey:SetPoint("TOPRIGHT", 0, 0)
			hotkey:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
			hotkey:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)
			hotkey:SetWidth(Viks.actionbar.buttonsize - 1)
			hotkey.ClearAllPoints = T.dummy
			hotkey.SetPoint = T.dummy
		else
			hotkey:Kill()
		end

		if not button.isSkinned then
			if self:GetHeight() ~= Viks.actionbar.buttonsize and not InCombatLockdown() then
				self:SetSize(Viks.actionbar.buttonsize, Viks.actionbar.buttonsize)
			end

			button:CreateBackdrop("Transparent")
			button.backdrop:SetAllPoints()
			if Viks.actionbar.classcolor_border == true then
				button.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			end

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetPoint("TOPLEFT", button, 2, -2)
			icon:SetPoint("BOTTOMRIGHT", button, -2, 2)

			button.isSkinned = true
		end

		if normal then
			normal:ClearAllPoints()
			normal:SetPoint("TOPLEFT")
			normal:SetPoint("BOTTOMRIGHT")
		end
	end

	hooksecurefunc(FlyoutListButton, "UpdateButton", CreateBorder)
	hooksecurefunc(FlyoutListButton, "OnReceiveDrag", CreateBorder)
	hooksecurefunc(FlyoutListButton, "UpdateTexture", CreateBorder)
end)