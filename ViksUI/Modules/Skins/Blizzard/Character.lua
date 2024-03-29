local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Character skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinCloseButton(CharacterFrameCloseButton)

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot"
	}

	select(11, _G["CharacterMainHandSlot"]:GetRegions()):Hide()
	select(11, _G["CharacterSecondaryHandSlot"]:GetRegions()):Hide()
	
	for _, i in pairs(slots) do
		_G["Character"..i.."Frame"]:Hide()
		local icon = _G["Character"..i.."IconTexture"]
		local slot = _G["Character"..i]
		local border = _G["Character"..i].IconBorder

		border:Kill()

		slot:StyleButton()
		slot:SetNormalTexture("")
		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	-- Strip Textures
	local charframe = {
		"CharacterFrame",
		"CharacterModelFrame",
		"CharacterFrameInset",
		"CharacterStatsPane",
		"CharacterFrameInsetRight",
		"PaperDollSidebarTabs",
		"PaperDollEquipmentManagerPane"
	}

	CharacterFrameExpandButton:SetSize(CharacterFrameExpandButton:GetWidth() - 7, CharacterFrameExpandButton:GetHeight() - 7)
	T.SkinNextPrevButton(CharacterFrameExpandButton)

	EquipmentFlyoutFrameHighlight:Kill()
	local function SkinItemFlyouts()
		EquipmentFlyoutFrameButtons:StripTextures()

		for i = 1, 23 do
			local button = _G["EquipmentFlyoutFrameButton"..i]
			local icon = _G["EquipmentFlyoutFrameButton"..i.."IconTexture"]
			if button then
				button:StyleButton()
				button.IconBorder:Hide()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button:GetNormalTexture():SetTexture(nil)

				icon:ClearAllPoints()
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetPoint("BOTTOMRIGHT", -2, 2)
				button:SetFrameStrata("DIALOG")
				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetAllPoints()
				end
			end
		end
	end

	-- Swap item flyout frame (shown when holding alt over a slot)
	EquipmentFlyoutFrame:HookScript("OnShow", SkinItemFlyouts)
	hooksecurefunc("EquipmentFlyout_Show", SkinItemFlyouts)

	-- Icon in upper right corner of character frame
	CharacterFramePortrait:Kill()
	CharacterModelFrame:CreateBackdrop("Default")
	CharacterModelFrame.backdrop:SetPoint("TOPLEFT", -3, 4)
	CharacterModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)

	local scrollbars = {
		"PaperDollTitlesPaneScrollBar",
		"PaperDollEquipmentManagerPaneScrollBar",
		"CharacterStatsPaneScrollBar",
		"TokenFrameContainerScrollBar"
	}

	for _, scrollbar in pairs(scrollbars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	for _, object in pairs(charframe) do
		_G[object]:StripTextures()
	end

	-- Titles
	PaperDollTitlesPane:HookScript("OnShow", function(self)
		for x, object in pairs(PaperDollTitlesPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)
			object.Check:SetTexture(nil)
		end
	end)

	-- Equipement Manager
	PaperDollEquipmentManagerPaneEquipSet:SkinButton()
	PaperDollEquipmentManagerPaneSaveSet:SkinButton()
	PaperDollEquipmentManagerPaneEquipSet:SetWidth(PaperDollEquipmentManagerPaneEquipSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneSaveSet:SetWidth(PaperDollEquipmentManagerPaneSaveSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneEquipSet:SetPoint("TOPLEFT", PaperDollEquipmentManagerPane, "TOPLEFT", 8, 0)
	PaperDollEquipmentManagerPaneSaveSet:SetPoint("LEFT", PaperDollEquipmentManagerPaneEquipSet, "RIGHT", 4, 0)
	PaperDollEquipmentManagerPaneEquipSet.ButtonBackground:SetTexture(nil)
	PaperDollEquipmentManagerPane:HookScript("OnShow", function(self)
		for x, object in pairs(PaperDollEquipmentManagerPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)

			object.Check:SetTexture(nil)
			object.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			if not object.backdrop then
				object:CreateBackdrop("Default")
			end

			object.backdrop:SetPoint("TOPLEFT", object.icon, "TOPLEFT", -2, 2)
			object.backdrop:SetPoint("BOTTOMRIGHT", object.icon, "BOTTOMRIGHT", 2, -2)
			object.icon:SetParent(object.backdrop)

			-- Making all icons the same size and position because otherwise BlizzardUI tries to attach itself to itself when it refreshes
			object.icon:SetPoint("LEFT", object, "LEFT", 4, 0)
			object.icon.SetPoint = T.dummy
			object.icon:SetSize(36, 36)
			object.icon.SetSize = T.dummy
		end
		GearManagerDialogPopup:StripTextures()
		GearManagerDialogPopup:SetTemplate("Transparent")
		GearManagerDialogPopup:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT", 3, 0)
		GearManagerDialogPopupScrollFrame:StripTextures()
		GearManagerDialogPopupEditBox:StripTextures(true)
		GearManagerDialogPopupEditBox:SetTemplate("Overlay")
		GearManagerDialogPopupEditBox:SetTextInsets(3, 0, 0, 0)
		GearManagerDialogPopupOkay:SkinButton()
		GearManagerDialogPopupCancel:SkinButton()

		for i = 1, NUM_GEARSET_ICONS_SHOWN do
			local button = _G["GearManagerDialogPopupButton"..i]
			local icon = button.icon

			if button then
				button:StripTextures()
				button:StyleButton(true)

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["GearManagerDialogPopupButton"..i.."Icon"]:SetTexture(nil)

				icon:ClearAllPoints()
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetPoint("BOTTOMRIGHT", -2, 2)
				button:SetFrameLevel(button:GetFrameLevel() + 2)
				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetAllPoints()
				end
			end
		end
	end)

	-- Handle Tabs at bottom of character frame
	for i = 1, 4 do
		T.SkinTab(_G["CharacterFrameTab"..i])
	end

	-- Buttons used to toggle between equipment manager, titles, and character stats
	local function FixSidebarTabCoords()
		for i = 1, #PAPERDOLL_SIDEBARS do
			local tab = _G["PaperDollSidebarTab"..i]
			if tab then
				tab.Highlight:SetTexture(1, 1, 1, 0.3)
				tab.Highlight:SetPoint("TOPLEFT", 3, -4)
				tab.Highlight:SetPoint("BOTTOMRIGHT", -1, 0)
				tab.Hider:SetTexture(0.4, 0.4, 0.4, 0.4)
				tab.Hider:SetPoint("TOPLEFT", 3, -4)
				tab.Hider:SetPoint("BOTTOMRIGHT", -1, 0)
				tab.TabBg:Kill()

				if i == 1 then
					for i = 1, tab:GetNumRegions() do
						local region = select(i, tab:GetRegions())
						region:SetTexCoord(0.16, 0.86, 0.16, 0.86)
						region.SetTexCoord = T.dummy
					end
				end
				tab:CreateBackdrop("Default")
				tab.backdrop:SetPoint("TOPLEFT", 1, -2)
				tab.backdrop:SetPoint("BOTTOMRIGHT", 1, -2)
			end
		end
	end
	hooksecurefunc("PaperDollFrame_UpdateSidebarTabs", FixSidebarTabCoords)

	hooksecurefunc("PaperDollFrame_CollapseStatCategory", function(categoryFrame)
		categoryFrame.BgMinimized:Hide()
	end)

	hooksecurefunc("PaperDollFrame_ExpandStatCategory", function(categoryFrame)
		categoryFrame.BgTop:Hide()
		categoryFrame.BgMiddle:Hide()
		categoryFrame.BgBottom:Hide()
	end)

	-- Reputation
	local function UpdateFactionSkins()
		ReputationListScrollFrame:StripTextures()
		ReputationFrame:StripTextures(true)
		for i = 1, GetNumFactions() do
			local statusbar = _G["ReputationBar"..i.."ReputationBar"]

			if statusbar then
				statusbar:SetStatusBarTexture(Viks.media.texture)

				if not statusbar.backdrop then
					statusbar:CreateBackdrop("Overlay")
				end

				_G["ReputationBar"..i.."Background"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarHighlight1"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarHighlight2"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarAtWarHighlight1"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarAtWarHighlight2"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarLeftTexture"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarRightTexture"]:SetTexture(nil)
			end
		end
		ReputationDetailFrame:StripTextures()
		ReputationDetailFrame:SetTemplate("Transparent")
		ReputationDetailFrame:SetPoint("TOPLEFT", ReputationFrame, "TOPRIGHT", 3, 0)
		T.SkinCloseButton(ReputationDetailCloseButton)
		T.SkinCheckBox(ReputationDetailMainScreenCheckBox)
		T.SkinCheckBox(ReputationDetailInactiveCheckBox)
		T.SkinCheckBox(ReputationDetailAtWarCheckBox)
		T.SkinCheckBox(ReputationDetailLFGBonusReputationCheckBox)
	end
	ReputationFrame:HookScript("OnShow", UpdateFactionSkins)
	hooksecurefunc("ExpandFactionHeader", UpdateFactionSkins)
	hooksecurefunc("CollapseFactionHeader", UpdateFactionSkins)

	-- Currency
	TokenFrame:HookScript("OnShow", function()
		for i = 1, GetCurrencyListSize() do
			local button = _G["TokenFrameContainerButton"..i]

			if button then
				button.highlight:Kill()
				button.categoryMiddle:Kill()
				button.categoryLeft:Kill()
				button.categoryRight:Kill()

				if button.icon then
					button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				end
			end
		end
		TokenFramePopup:StripTextures()
		TokenFramePopup:SetTemplate("Transparent")
		TokenFramePopup:SetPoint("TOPLEFT", TokenFrame, "TOPRIGHT", 3, 0)
		T.SkinCloseButton(TokenFramePopupCloseButton)
		T.SkinCheckBox(TokenFramePopupBackpackCheckBox)
		T.SkinCheckBox(TokenFramePopupInactiveCheckBox)
	end)

	-- Pet
	PetModelFrame:CreateBackdrop("Default")
	PetModelFrame.backdrop:SetPoint("TOPLEFT", -2, 2)
	PetModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 1, -2)
	T.SkinRotateButton(PetModelFrameRotateRightButton)
	T.SkinRotateButton(PetModelFrameRotateLeftButton)
	PetModelFrameRotateLeftButton:ClearAllPoints()
	PetModelFrameRotateLeftButton:SetPoint("TOPLEFT", PetModelFrame.backdrop, "TOPLEFT", 6, -6)
	PetModelFrameRotateRightButton:ClearAllPoints()
	PetModelFrameRotateRightButton:SetPoint("LEFT", PetModelFrameRotateLeftButton, "RIGHT", 4, 0)

	local xtex = PetPaperDollPetInfo:GetRegions()
	xtex:SetTexCoord(0.12, 0.63, 0.15, 0.55)
	PetPaperDollPetInfo:CreateBackdrop("Default")
	PetPaperDollPetInfo:SetSize(24, 24)

	CharacterFrame:SetTemplate("Transparent")

	-- Unit Background Texture
	CharacterModelFrameBackgroundTopLeft:SetPoint("TOPLEFT", CharacterModelFrame.backdrop, "TOPLEFT", 2, -2)
	CharacterModelFrameBackgroundTopRight:SetPoint("TOPRIGHT", CharacterModelFrame.backdrop, "TOPRIGHT", -2, -2)
	CharacterModelFrameBackgroundBotLeft:SetPoint("BOTTOMLEFT", CharacterModelFrame.backdrop, "BOTTOMLEFT", 2, -50)
	CharacterModelFrameBackgroundBotRight:SetPoint("BOTTOMRIGHT", CharacterModelFrame.backdrop, "BOTTOMRIGHT", -2, -50)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)