local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Pet Battles UI
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "PetBattleBarHolder", UIParent, "SecureHandlerStateTemplate")
bar:SetSize(((Viks.actionbar.buttonsize * 1.5) * 6) + (Viks.actionbar.buttonspacing * 5), Viks.actionbar.buttonsize * 1.5)
bar:EnableMouse(true)
bar:SetFrameStrata("LOW")
bar:SetPoint(unpack(Viks.position.bottom_bars))
RegisterStateDriver(bar, "visibility", "[petbattle] show; hide")

local f = PetBattleFrame
local bf = f.BottomFrame
local units = {
	f.ActiveAlly,
	f.ActiveEnemy
}

-- General
f:StripTextures()

-- Pets unitframes
for i, unit in pairs(units) do
	unit.Border:SetAlpha(0)
	unit.Border2:SetAlpha(0)
	unit.healthBarWidth = 300

	unit.IconBackdrop = CreateFrame("Frame", nil, unit)
	unit.IconBackdrop:SetFrameLevel(unit:GetFrameLevel() - 1)
	unit.IconBackdrop:SetPoint("TOPLEFT", unit.Icon, -2, 2)
	unit.IconBackdrop:SetPoint("BOTTOMRIGHT", unit.Icon, 2, -2)
	unit.IconBackdrop:SetTemplate("Default")

	unit.HealthBarBG:Kill()
	unit.HealthBarFrame:Kill()
	unit.HealthBarBackdrop = CreateFrame("Frame", nil, unit)
	unit.HealthBarBackdrop:SetFrameLevel(unit:GetFrameLevel() - 1)
	unit.HealthBarBackdrop:SetTemplate("Transparent")
	unit.HealthBarBackdrop:SetWidth(unit.healthBarWidth + 4)
	unit.ActualHealthBar:SetTexture(Viks.media.texture)

	unit.ActualHealthBar:ClearAllPoints()
	unit.Name:ClearAllPoints()

	unit.PetTypeFrame = CreateFrame("Frame", nil, unit)
	unit.PetTypeFrame:SetSize(100, 23)
	unit.PetTypeFrame:FontString("text", Viks.media.font, 12)
	unit.PetTypeFrame.text:SetShadowOffset(1, -1)
	unit.PetTypeFrame.text:SetText("")

	unit.SpeedIcon:SetAlpha(0)
	unit.SpeedUnderlay:SetAlpha(0)

	unit.FirstAttack = unit:CreateTexture(nil, "ARTWORK")
	unit.FirstAttack:SetSize(20, 20)
	unit.FirstAttack:SetTexture("Interface\\PetBattles\\PetBattle-StatIcons")
	unit.FirstAttack:Hide()

	if i == 1 then
		unit.HealthBarBackdrop:SetPoint("TOPLEFT", unit.ActualHealthBar, "TOPLEFT", -2, 2)
		unit.HealthBarBackdrop:SetPoint("BOTTOMLEFT", unit.ActualHealthBar, "BOTTOMLEFT", -2, -2)
		f.Ally2.iconPoint = unit.IconBackdrop
		f.Ally3.iconPoint = unit.IconBackdrop

		unit.ActualHealthBar:SetPoint("BOTTOMLEFT", unit.Icon, "BOTTOMRIGHT", 10, 0)
		unit.Name:SetPoint("BOTTOMLEFT", unit.ActualHealthBar, "TOPLEFT", 0, 10)

		unit.PetTypeFrame:SetPoint("BOTTOMRIGHT", unit.HealthBarBackdrop, "TOPRIGHT", 4, 4)
		unit.PetTypeFrame.text:SetPoint("RIGHT", -3, 0)

		unit.FirstAttack:SetPoint("LEFT", unit.HealthBarBackdrop, "RIGHT", 5, 0)
		unit.FirstAttack:SetTexCoord(unit.SpeedIcon:GetTexCoord())
		unit.FirstAttack:SetVertexColor(0.1, 0.1, 0.1, 1)
	else
		unit.HealthBarBackdrop:SetPoint("TOPRIGHT", unit.ActualHealthBar, "TOPRIGHT", 2, 2)
		unit.HealthBarBackdrop:SetPoint("BOTTOMRIGHT", unit.ActualHealthBar, "BOTTOMRIGHT", 2, -2)
		f.Enemy2.iconPoint = unit.IconBackdrop
		f.Enemy3.iconPoint = unit.IconBackdrop

		unit.ActualHealthBar:SetPoint("BOTTOMRIGHT", unit.Icon, "BOTTOMLEFT", -10, 0)
		unit.Name:SetPoint("BOTTOMRIGHT", unit.ActualHealthBar, "TOPRIGHT", 0, 10)

		unit.PetTypeFrame:SetPoint("BOTTOMLEFT", unit.HealthBarBackdrop, "TOPLEFT", -2, 4)
		unit.PetTypeFrame.text:SetPoint("LEFT", 3, 0)

		unit.FirstAttack:SetPoint("RIGHT", unit.HealthBarBackdrop, "LEFT", -5, 0)
		unit.FirstAttack:SetTexCoord(0.5, 0, 0.5, 1)
		unit.FirstAttack:SetVertexColor(0.1, 0.1, 0.1, 1)
	end

	unit.PetType:ClearAllPoints()
	unit.PetType:SetAllPoints(unit.PetTypeFrame)
	unit.PetType:SetFrameLevel(unit.PetTypeFrame:GetFrameLevel() + 2)
	unit.PetType:SetAlpha(0)

	unit.HealthText:ClearAllPoints()
	unit.HealthText:SetPoint("CENTER", unit.HealthBarBackdrop, "CENTER")

	unit.LevelUnderlay:SetAlpha(0)
	unit.Level:SetFontObject(SystemFont_Large)
	unit.Level:ClearAllPoints()
	unit.Level:SetPoint("BOTTOMLEFT", unit.Icon, "BOTTOMLEFT", 2, 2)

	unit.BorderFlash:Kill()
end

-- Pets speed indicator update
hooksecurefunc("PetBattleFrame_UpdateSpeedIndicators", function(self)
	if not f.ActiveAlly.SpeedIcon:IsShown() and not f.ActiveEnemy.SpeedIcon:IsShown() then
		f.ActiveAlly.FirstAttack:Hide()
		f.ActiveEnemy.FirstAttack:Hide()
		return
	end

	for i, unit in pairs(units) do
		unit.FirstAttack:Show()
		if unit.SpeedIcon:IsShown() then
			unit.FirstAttack:SetVertexColor(0, 1, 0, 1)
		else
			unit.FirstAttack:SetVertexColor(0.8, 0, 0.3, 1)
		end
	end
end)

-- Localized pets type
local pet_type = {
	[1] = BATTLE_PET_DAMAGE_NAME_1,
	[2] = BATTLE_PET_DAMAGE_NAME_2,
	[3] = BATTLE_PET_DAMAGE_NAME_3,
	[4] = BATTLE_PET_DAMAGE_NAME_4,
	[5] = BATTLE_PET_DAMAGE_NAME_5,
	[6] = BATTLE_PET_DAMAGE_NAME_6,
	[7] = BATTLE_PET_DAMAGE_NAME_7,
	[8] = BATTLE_PET_DAMAGE_NAME_8,
	[9] = BATTLE_PET_DAMAGE_NAME_9,
	[10] = BATTLE_PET_DAMAGE_NAME_10,
}

-- Pets unitframes pet type update
hooksecurefunc("PetBattleUnitFrame_UpdatePetType", function(self)
	if self.PetType then
		local petType = C_PetBattles.GetPetType(self.petOwner, self.petIndex)
		if self.PetTypeFrame then
			self.PetTypeFrame.text:SetText(pet_type[petType])
		end
	end
end)

-- Pets unitframes aura skins
hooksecurefunc("PetBattleAuraHolder_Update", function(self)
	if not self.petOwner or not self.petIndex then return end

	local nextFrame = 1
	for i = 1, C_PetBattles.GetNumAuras(self.petOwner, self.petIndex) do
		local _, _, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(self.petOwner, self.petIndex, i)
		if (isBuff and self.displayBuffs) or (not isBuff and self.displayDebuffs) then
			local frame = self.frames[nextFrame]

			frame:SetWidth(frame:GetHeight())

			-- Always hide the border
			frame.DebuffBorder:Hide()

			if not frame.isSkinned then
				frame:CreateBackdrop("Default")
				frame.backdrop:SetPoint("TOPLEFT", frame, 2, -2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame, -2, 2)

				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.Icon:SetPoint("TOPLEFT", frame.backdrop, 2, -2)
				frame.Icon:SetPoint("BOTTOMRIGHT", frame.backdrop, -2, 2)
			end

			if isBuff then
				frame.backdrop:SetBackdropBorderColor(0, 1, 0)
			else
				frame.backdrop:SetBackdropBorderColor(1, 0, 0)
			end

			if turnsRemaining > 0 then
				frame.Duration:SetText(turnsRemaining)
			end

			frame.Duration:SetFont(Viks.media.font, 12)
			frame.Duration:SetShadowOffset(1, -1)
			frame.Duration:ClearAllPoints()
			frame.Duration:SetPoint("CENTER", frame.Icon, "CENTER", 1, 0)

			nextFrame = nextFrame + 1
		end
	end
end)

-- Reposition "vs" text
f.TopVersusText:ClearAllPoints()
f.TopVersusText:SetPoint("TOP", f, "TOP", 0, -76)

-- Pets #2 and #3
local extraUnits = {
	f.Ally2,
	f.Ally3,
	f.Enemy2,
	f.Enemy3
}

for i, unit in pairs(extraUnits) do
	unit.BorderAlive:SetAlpha(0)
	unit.HealthBarBG:SetAlpha(0)
	unit.HealthDivider:SetAlpha(0)
	unit:SetSize(40, 40)
	unit:CreateBackdrop("Default")
	unit:ClearAllPoints()

	unit.healthBarWidth = 40
	unit.ActualHealthBar:ClearAllPoints()
	unit.ActualHealthBar:SetPoint("TOPLEFT", unit.backdrop, "BOTTOMLEFT", 2, -3)

	unit.HealthBarBackdrop = CreateFrame("Frame", nil, unit)
	unit.HealthBarBackdrop:SetFrameLevel(unit:GetFrameLevel() - 1)
	unit.HealthBarBackdrop:SetTemplate("Default")
	unit.HealthBarBackdrop:SetWidth(unit.healthBarWidth + 4)
	unit.HealthBarBackdrop:SetPoint("TOPLEFT", unit.ActualHealthBar, "TOPLEFT", -2, 2)
	unit.HealthBarBackdrop:SetPoint("BOTTOMLEFT", unit.ActualHealthBar, "BOTTOMLEFT", -2, -1)
end

f.Ally2:SetPoint("TOPRIGHT", f.Ally2.iconPoint, "TOPLEFT", -6, -2)
f.Ally3:SetPoint("TOPRIGHT", f.Ally2, "TOPLEFT", -8, 0)
f.Enemy2:SetPoint("TOPLEFT", f.Enemy2.iconPoint, "TOPRIGHT", 6, -2)
f.Enemy3:SetPoint("TOPLEFT", f.Enemy2, "TOPRIGHT", 8, 0)

-- Weather
hooksecurefunc("PetBattleWeatherFrame_Update", function(self)
	local weather = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_WEATHER, PET_BATTLE_PAD_INDEX, 1)
	if weather then
		self.Icon:Hide()
		self.Name:Hide()
		self.DurationShadow:Hide()
		self.Label:Hide()
		self.Duration:SetPoint("CENTER", self, 0, 8)
		self:ClearAllPoints()
		self:SetPoint("TOP", UIParent, 0, -15)
	end
end)

bf:StripTextures()
bf.TurnTimer:StripTextures()
bf.TurnTimer.SkipButton:SetParent(bar)
bf.TurnTimer.SkipButton:SkinButton()
bf.TurnTimer.SkipButton:SetWidth(bar:GetWidth())
bf.TurnTimer.SkipButton:SetHeight(21)
bf.TurnTimer.SkipButton:ClearAllPoints()
bf.TurnTimer.SkipButton:SetPoint("BOTTOM", bar, "TOP", 0, 3)
bf.TurnTimer.SkipButton.ClearAllPoints = T.dummy
bf.TurnTimer.SkipButton.SetPoint = T.dummy

bf.xpBar:SetParent(bar)
bf.xpBar:SetWidth(bar:GetWidth() - 4)
bf.xpBar:CreateBackdrop("Overlay")
bf.xpBar:ClearAllPoints()
bf.xpBar:SetPoint("BOTTOM", bf.TurnTimer.SkipButton, "TOP", 0, 5)
bf.xpBar:SetScript("OnShow", function(self) self:StripTextures() self:SetStatusBarTexture(Viks.media.texture) end)

bf.TurnTimer:SetParent(bar)
bf.TurnTimer:SetSize(bf.TurnTimer.SkipButton:GetWidth(), bf.TurnTimer.SkipButton:GetHeight())
bf.TurnTimer:ClearAllPoints()
bf.TurnTimer:SetPoint("BOTTOM", bf.xpBar, "TOP", 0, 5)
bf.TurnTimer.TimerText:SetPoint("CENTER")

bf.MicroButtonFrame:StripTextures()
bf.MicroButtonFrame:Hide()
bf.Delimiter:StripTextures()
bf.FlowFrame:Kill()

-- Pets selection skin
for i = 1, 3 do
	local unit = bf.PetSelectionFrame["Pet"..i]

	unit.HealthBarBG:SetAlpha(0)
	unit.HealthDivider:SetAlpha(0)
	unit.ActualHealthBar:SetAlpha(0)
	unit.SelectedTexture:SetAlpha(0)
	unit.MouseoverHighlight:SetAlpha(0)
	unit.Framing:SetAlpha(0)
	unit.Icon:SetAlpha(0)
	unit.Name:SetAlpha(0)
	unit.DeadOverlay:SetAlpha(0)
	unit.Level:SetAlpha(0)
	unit.HealthText:SetAlpha(0)
end

-- Move default position of pets selection
hooksecurefunc("PetBattlePetSelectionFrame_Show", function()
	bf.PetSelectionFrame:ClearAllPoints()
	bf.PetSelectionFrame:SetPoint("BOTTOM", bf.xpBar, "TOP", 0, 8)
end)

-- Function to skin pet action buttons
local function SkinPetButton(self)
	self:SetNormalTexture("")

	self:CreateBackdrop("Transparent")
	self.backdrop:SetAllPoints()
	if Viks.actionbar.classcolor_border == true then
		self.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	end

	self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	self.Icon:SetPoint("TOPLEFT", self, 2, -2)
	self.Icon:SetPoint("BOTTOMRIGHT", self, -2, 2)

	self.checked = true
	self:StyleButton()
	self.SelectedHighlight:SetAlpha(0)

	self.CooldownShadow:SetAllPoints()
	self.CooldownFlash:SetAllPoints()

	if Viks.actionbar.hotkey == true then
		self.HotKey:SetPoint("TOPRIGHT", 0, 0)
		self.HotKey:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
		self.HotKey:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)
		self.HotKey:SetWidth((Viks.actionbar.buttonsize * 1.5) - 1)
	else
		self.HotKey:Kill()
	end
end

-- Setup pet action bar
hooksecurefunc("PetBattleFrame_UpdateActionBarLayout", function(self)
	for i = 1, NUM_BATTLE_PET_ABILITIES do
		local b = bf.abilityButtons[i]

		SkinPetButton(b)
		b:SetParent(bar)
		b:SetSize(Viks.actionbar.buttonsize * 1.5, Viks.actionbar.buttonsize * 1.5)
		b:ClearAllPoints()
		if i == 1 then
			b:SetPoint("BOTTOMLEFT", 0, 0)
		else
			local previous = bf.abilityButtons[i-1]
			b:SetPoint("LEFT", previous, "RIGHT", Viks.actionbar.buttonspacing, 0)
		end
	end

	bf.SwitchPetButton:SetParent(bar)
	bf.SwitchPetButton:SetSize(Viks.actionbar.buttonsize * 1.5, Viks.actionbar.buttonsize * 1.5)
	bf.SwitchPetButton:ClearAllPoints()
	bf.SwitchPetButton:SetPoint("LEFT", bf.abilityButtons[3], "RIGHT", Viks.actionbar.buttonspacing, 0)

	bf.SwitchPetButton:SetScript("OnClick", function(self)
		PetBattlePetSelectionFrame_Show(bf.PetSelectionFrame)
	end)

	bf.CatchButton:SetParent(bar)
	bf.CatchButton:SetSize(Viks.actionbar.buttonsize * 1.5, Viks.actionbar.buttonsize * 1.5)
	bf.CatchButton:ClearAllPoints()
	bf.CatchButton:SetPoint("LEFT", bf.SwitchPetButton, "RIGHT", Viks.actionbar.buttonspacing, 0)

	bf.ForfeitButton:SetParent(bar)
	bf.ForfeitButton:ClearAllPoints()
	bf.ForfeitButton:SetSize(Viks.actionbar.buttonsize * 1.5, Viks.actionbar.buttonsize * 1.5)
	bf.ForfeitButton:SetPoint("LEFT", bf.CatchButton, "RIGHT", Viks.actionbar.buttonspacing, 0)

	SkinPetButton(bf.SwitchPetButton)
	SkinPetButton(bf.CatchButton)
	SkinPetButton(bf.ForfeitButton)
end)

-- Tooltips skinning
local tooltips = {BattlePetTooltip, PetBattlePrimaryAbilityTooltip, PetBattlePrimaryUnitTooltip, FloatingPetBattleAbilityTooltip, FloatingBattlePetTooltip}

for i, tt in pairs(tooltips) do
	tt:SetTemplate("Transparent")

	tt.Background:SetTexture(nil)

	tt.BorderLeft:SetTexture(nil)
	tt.BorderRight:SetTexture(nil)
	tt.BorderTop:SetTexture(nil)
	tt.BorderTopLeft:SetTexture(nil)
	tt.BorderTopRight:SetTexture(nil)
	tt.BorderBottom:SetTexture(nil)
	tt.BorderBottomLeft:SetTexture(nil)
	tt.BorderBottomRight:SetTexture(nil)

	if tt.CloseButton then
		T.SkinCloseButton(tt.CloseButton)
	end

	if tt.Delimiter1 then
		tt.Delimiter1:SetTexture(nil)
		tt.Delimiter2:SetTexture(nil)
	elseif tt.Delimiter then
		tt.Delimiter:SetTexture(nil)
	end
end

table.insert(UISpecialFrames, "FloatingBattlePetTooltip")

-- Tooltip position
hooksecurefunc("PetBattleAbilityTooltip_Show", function()
	PetBattlePrimaryAbilityTooltip:ClearAllPoints()
	PetBattlePrimaryAbilityTooltip:SetPoint(unpack(Viks.position.tooltip))
end)

----------------------------------------------------------------------------------------
--	Coloring borders/names by pets quality(PetBattleQualityGlow by Tia Lynn)
----------------------------------------------------------------------------------------
hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", function(self)
	self.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	self.Icon:SetPoint("TOP", f, "TOP", 0, -36)

	-- There must be a petOwner and a petIndex
	if not self.petOwner or not self.petIndex then return end

	-- Is this Enemy or Player? (This Value will be Added to the Glow Index)
	local nEnemy = 0
	if self.petOwner == LE_BATTLE_PET_ENEMY then nEnemy = 3 end

	-- Check if this is the Tooltip
	local isTooltip = false
	if self:GetName() == "PetBattlePrimaryUnitTooltip" then isTooltip = true end

	-- Set which Glow frame this will use (Enemy Frames are +3 / Tooltip is 7)
	local sGlow = "Glow7"
	if not isTooltip then sGlow = "Glow"..tostring(self.petIndex + nEnemy) end

	-- Set the color for the Glow
	local nQuality = C_PetBattles.GetBreedQuality(self.petOwner, self.petIndex) - 1
	local r, g, b, hex = GetItemQualityColor(nQuality)
	if nQuality >= 2 and not isTooltip and self.IconBackdrop then
		self.IconBackdrop:SetBackdropBorderColor(r, g, b)
	elseif self.IconBackdrop then
		self.IconBackdrop:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	end

	-- Color the Name with the Quality color
	if self.Name then
		local sPetName = C_PetBattles.GetName(self.petOwner, self.petIndex)
		if sPetName then
			self.Name:SetText("|c"..hex..sPetName.."|r")
		end
	end

	-- Color the non-active Health Bars with the Quality color
	if self.ActualHealthBar and not isTooltip then
		self.ActualHealthBar:SetVertexColor(r, g, b)
	end
end)