local T, Viks, L, _ = unpack(select(2, ...))
if Viks.aura.player_auras ~= true then return end

----------------------------------------------------------------------------------------
--	Style player buff(by Tukz)
----------------------------------------------------------------------------------------
local mainhand, _, _, offhand = GetWeaponEnchantInfo()
local rowbuffs = 16

local GetFormattedTime = function(s)
	if s >= 86400 then
		return format("%dd", floor(s / 86400 + 0.5))
	elseif s >= 3600 then
		return format("%dh", floor(s / 3600 + 0.5))
	elseif s >= 60 then
		return format("%dm", floor(s / 60 + 0.5))
	end
	return floor(s + 0.5)
end

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
BuffsAnchor:SetPoint("TOPRIGHT", AnchorBuff)
BuffsAnchor:SetSize((15 * Viks.aura.player_buff_size) + 42, (Viks.aura.player_buff_size * 2) + 3)


ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
ConsolidatedBuffs:SetSize(Viks.aura.player_buff_size, Viks.aura.player_buff_size)
ConsolidatedBuffs.SetPoint = T.dummy
ConsolidatedBuffs:CreateBackdrop("Default")
ConsolidatedBuffs.backdrop:SetAllPoints()

if Viks.aura.classcolor_border == true then
	ConsolidatedBuffs.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
end

ConsolidatedBuffsIcon:SetTexCoord(0.16, 0.34, 0.29, 0.7)
ConsolidatedBuffsIcon:SetSize(Viks.aura.player_buff_size - 4, Viks.aura.player_buff_size - 4)

ConsolidatedBuffsCount:SetPoint("BOTTOMRIGHT", 0, 1)
ConsolidatedBuffsCount:SetFont(Viks.font.auras_font, Viks.font.auras_font_size, Viks.font.auras_font_style)
ConsolidatedBuffsCount:SetShadowOffset(Viks.font.auras_font_shadow and 1 or 0, Viks.font.auras_font_shadow and -1 or 0)



for i = 1, NUM_TEMP_ENCHANT_FRAMES do
	local buff = _G["TempEnchant"..i]
	local icon = _G["TempEnchant"..i.."Icon"]
	local border = _G["TempEnchant"..i.."Border"]
	local duration = _G["TempEnchant"..i.."Duration"]

	if border then border:Hide() end

	if i ~= 3 then
		buff:SetTemplate("Default")
		if Viks.aura.classcolor_border == true then
			buff:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		end
	end

	buff:SetSize(Viks.aura.player_buff_size, Viks.aura.player_buff_size)

	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetPoint("TOPLEFT", buff, 2, -2)
	icon:SetPoint("BOTTOMRIGHT", buff, -2, 2)
	icon:SetDrawLayer("BORDER")

	duration:ClearAllPoints()
	duration:SetPoint("CENTER", 2, 1)
	duration:SetDrawLayer("ARTWORK")
	duration:SetFont(Viks.font.auras_font, Viks.font.auras_font_size, Viks.font.auras_font_style)
	duration:SetShadowOffset(Viks.font.auras_font_shadow and 1 or 0, Viks.font.auras_font_shadow and -1 or 0)

	_G["TempEnchant2"]:ClearAllPoints()
	_G["TempEnchant2"]:SetPoint("RIGHT", _G["TempEnchant1"], "LEFT", -3, 0)
end

local function StyleBuffs(buttonName, index)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]

	if border then border:Hide() end

	if icon and not buff.isSkinned then
		buff:SetTemplate("Default")
		if Viks.aura.classcolor_border == true then
			buff:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		end
		
		buff:SetSize(Viks.aura.player_buff_size, Viks.aura.player_buff_size)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", buff, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", buff, -2, 2)
		icon:SetDrawLayer("BORDER")

		duration:ClearAllPoints()
		duration:SetPoint("CENTER", 2, 1)
		duration:SetDrawLayer("ARTWORK")
		duration:SetFont(Viks.font.auras_font, Viks.font.auras_font_size, Viks.font.auras_font_style)
		duration:SetShadowOffset(Viks.font.auras_font_shadow and 1 or 0, Viks.font.auras_font_shadow and -1 or 0)

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 2, 0)
		count:SetDrawLayer("ARTWORK")
		count:SetFont(Viks.font.auras_font, Viks.font.auras_font_size, Viks.font.auras_font_style)
		count:SetShadowOffset(Viks.font.auras_font_shadow and 1 or 0, Viks.font.auras_font_shadow and -1 or 0)

		buff.isSkinned = true
	end
end


local function StyleDeBuffs(buttonName, index)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]
	local dtype = select(5, UnitDebuff("player",i))  
	local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
	
	if border then border:Hide() end

	if icon and not buff.isSkinned then
		buff:SetTemplate("Default")
		buff:SetBackdropBorderColor(color.r * 3/5, color.g * 3/5, color.b * 3/5)
		buff:SetSize(Viks.aura.player_buff_size*1.5, Viks.aura.player_buff_size*1.5)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", buff, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", buff, -2, 2)
		icon:SetDrawLayer("BORDER")

		duration:ClearAllPoints()
		duration:SetPoint("CENTER", 2, 1)
		duration:SetDrawLayer("ARTWORK")
		duration:SetFont(Viks.font.auras_font, Viks.font.auras_font_size*2, Viks.font.auras_font_style)
		duration:SetShadowOffset(Viks.font.auras_font_shadow and 1 or 0, Viks.font.auras_font_shadow and -1 or 0)

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 2, 0)
		count:SetDrawLayer("ARTWORK")
		count:SetFont(Viks.font.auras_font, Viks.font.auras_font_size*2, Viks.font.auras_font_style)
		count:SetShadowOffset(Viks.font.auras_font_shadow and 1 or 0, Viks.font.auras_font_shadow and -1 or 0)

		buff.isSkinned = true
	end
end


local function UpdateFlash(self, elapsed)
	local index = self:GetID()
	self:SetAlpha(1)
end

local function UpdateDuration(auraButton, timeLeft)
	local duration = auraButton.duration
	if timeLeft and Viks.aura.show_timer == true then
		duration:SetFormattedText(GetFormattedTime(timeLeft))
		duration:SetVertexColor(1, 1, 1)
		duration:Show()
	else
		duration:Hide()
	end
end

local function UpdateBuffAnchors()
	local buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff
	local numBuffs = 0
	local numAuraRows = 0
	local slack = BuffFrame.numEnchants
	local mainhand, _, _, offhand = GetWeaponEnchantInfo()

	if ShouldShowConsolidatedBuffFrame() then
		slack = slack + 1
	end

	for index = 1, BUFF_ACTUAL_DISPLAY do
		StyleBuffs(buttonName, index)
		local buff = _G[buttonName..index]
		if not buff.consolidated then
			numBuffs = numBuffs + 1
			index = numBuffs + slack
			buff:ClearAllPoints()
			if (index > 1) and (mod(index, rowbuffs) == 1) then
				numAuraRows = numAuraRows + 1
				if index == rowbuffs + 1 then
					buff:SetPoint("TOP", ConsolidatedBuffs, "BOTTOM", 0, -3)
				else
					buff:SetPoint("TOP", aboveBuff, "BOTTOM", 0, -3)
				end
				aboveBuff = buff
			elseif index == 1 then
				numAuraRows = 1
				buff:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
			else
				if numBuffs == 1 then
					if mainhand and offhand and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant2, "LEFT", -3, 0)
					elseif ((mainhand and not offhand) or (offhand and not mainhand)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant1, "LEFT", -3, 0)
					else
						buff:SetPoint("TOPRIGHT", ConsolidatedBuffs, "TOPLEFT", -3, 0)
					end
				else
					buff:SetPoint("RIGHT", previousBuff, "LEFT", -3, 0)
				end
			end
			previousBuff = buff
		end
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	_G[buttonName..index]:Show()
	local debuff = _G[buttonName..index]
	StyleDeBuffs(buttonName, index)
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
hooksecurefunc("AuraButton_UpdateDuration", UpdateDuration)
hooksecurefunc("AuraButton_OnUpdate", UpdateFlash)