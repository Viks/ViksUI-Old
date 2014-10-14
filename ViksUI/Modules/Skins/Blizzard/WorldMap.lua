local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldMap skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsAddOnLoaded("Mapster") then return end

	hooksecurefunc("WorldMap_ToggleSizeDown", function()
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end)

	local SmallerMap = GetCVarBool("miniWorldMap")
	if not SmallerMap then
		ToggleWorldMap()
		WorldMapFrameSizeUpButton:Click()
		ToggleWorldMap()
	end

	WorldMapFrame:StripTextures()
	WorldMapFrame:CreateBackdrop("Default")
	WorldMapFrame.backdrop:ClearAllPoints()
	WorldMapFrame.backdrop:SetSize(700, 468)
	WorldMapFrame.backdrop:SetPoint("TOPLEFT", 1, -66)
	WorldMapFrame.Header = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMapFrame.Header:SetSize(WorldMapFrame.backdrop:GetWidth(), 23)
	WorldMapFrame.Header:SetPoint("BOTTOMLEFT", WorldMapFrame.backdrop, "TOPLEFT", 0, 2)
	WorldMapFrame.Header:SetTemplate("Overlay")

	WorldMapFrame.BorderFrame:StripTextures()
	WorldMapFrame.BorderFrame.Inset:StripTextures()
	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()
	QuestScrollFrame.Contents.StoryHeader:StripTextures()
	QuestMapFrame:StripTextures()

	QuestScrollFrame.Background:SetAlpha(0)

	WorldMapFrameTutorialButton:Kill()
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button:SetAlpha(0)
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Background:SetAlpha(0)

	QuestScrollFrame:CreateBackdrop("Overlay")
	QuestScrollFrame.backdrop:ClearAllPoints()
	QuestScrollFrame.backdrop:SetSize(284, 468)
	QuestScrollFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)
	T.SkinScrollBar(QuestScrollFrameScrollBar)

	QuestMapDetailsScrollFrame:CreateBackdrop("Overlay")
	QuestMapDetailsScrollFrame.backdrop:SetAllPoints(QuestScrollFrame.backdrop)
	QuestMapDetailsScrollFrame.backdrop:ClearAllPoints()
	QuestMapDetailsScrollFrame.backdrop:SetSize(284, 468)
	QuestMapDetailsScrollFrame.backdrop:SetPoint("LEFT", WorldMapFrame.backdrop, "RIGHT", 2, 0)
	T.SkinScrollBar(QuestMapDetailsScrollFrameScrollBar)

	QuestScrollFrame.ViewAll:SkinButton()
	QuestScrollFrame.ViewAll:ClearAllPoints()
	QuestScrollFrame.ViewAll:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
	QuestScrollFrame.ViewAll:SetSize(284, 23)

	QuestMapFrame.DetailsFrame.BackButton:SkinButton()
	QuestMapFrame.DetailsFrame.BackButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.BackButton:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
	QuestMapFrame.DetailsFrame.BackButton:SetSize(284, 23)

	QuestMapFrame.DetailsFrame.AbandonButton:SkinButton()
	QuestMapFrame.DetailsFrame.AbandonButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.AbandonButton:SetPoint("BOTTOMLEFT", QuestScrollFrame.backdrop, "BOTTOMLEFT", 4, 4)

	QuestMapFrame.DetailsFrame.TrackButton:SkinButton()
	QuestMapFrame.DetailsFrame.TrackButton:SetSize(90, 22)
	QuestMapFrame.DetailsFrame.TrackButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.TrackButton:SetPoint("BOTTOMRIGHT", QuestScrollFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	QuestMapFrame.DetailsFrame.ShareButton:SkinButton(true)
	QuestMapFrame.DetailsFrame.ShareButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.ShareButton:SetPoint("LEFT", QuestMapFrame.DetailsFrame.AbandonButton, "RIGHT", 3, 0)
	QuestMapFrame.DetailsFrame.ShareButton:SetPoint("RIGHT", QuestMapFrame.DetailsFrame.TrackButton, "LEFT", -3, 0)

	QuestNPCModel:StripTextures()
	QuestNPCModel:CreateBackdrop("Transparent")
	QuestNPCModelTextFrame:StripTextures()
	QuestNPCModelTextFrame:CreateBackdrop("Overlay")
	QuestNPCModelTextFrame.backdrop:SetPoint("TOPLEFT", QuestNPCModel.backdrop, "BOTTOMLEFT", 0, -1)
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, x, y)
		if parentFrame == QuestLogPopupDetailFrame or parentFrame == QuestFrame then
			x = x + 8
			y = y + 40
		elseif parentFrame == QuestFrame then
			x = x + 3
		end
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x, y)
	end)

	-- Quests Buttons
	for i = 1, 2 do
		local button = i == 1 and WorldMapFrame.UIElementsFrame.OpenQuestPanelButton or WorldMapFrame.UIElementsFrame.CloseQuestPanelButton
		local texture = i == 1 and "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up" or "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up"

		button:ClearAllPoints()
		button:SetPoint("BOTTOMRIGHT", -2, 2)
		button:SetSize(20, 20)
		button:StripTextures()
		button:SetTemplate("Default")
		button:StyleButton()

		button.icon = button:CreateTexture(nil, "BORDER")
		button.icon:SetTexture(texture)
		button.icon:SetTexCoord(0.3, 0.29, 0.3, 0.79, 0.65, 0.29, 0.65, 0.79)
		button.icon:ClearAllPoints()
		button.icon:SetPoint("TOPLEFT", 2, -2)
		button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	WorldMapFrameNavBar:Hide()
	WorldMapTitleButton:ClearAllPoints()
	WorldMapTitleButton:SetAllPoints(WorldMapFrame.Header)
	WorldMapFrame.BorderFrame.TitleText:ClearAllPoints()
	WorldMapFrame.BorderFrame.TitleText:SetPoint("CENTER", WorldMapFrame.Header)

	T.SkinCloseButton(WorldMapFrameCloseButton)
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("RIGHT", WorldMapFrame.Header, "RIGHT", -4, 0)
	WorldMapFrameCloseButton:SetSize(15, 15)

	WorldMapFrameSizeUpButton:Kill()

	local function SkinReward(button)
		if button.NameFrame then button.NameFrame:Hide() end
		if button.CircleBackground then button.CircleBackground:Hide() end
		if button.CircleBackgroundGlow then button.CircleBackgroundGlow:Hide() end
		if button.ValueText then button.ValueText:SetPoint("BOTTOMRIGHT", button.Icon, 0, 0) end
		button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)
	end

	hooksecurefunc("QuestInfo_GetRewardButton", function(frame, index)
		local button = frame.RewardButtons[index]
		if not button.restyled then
			SkinReward(button)
			if button == frame.RewardButtons[3] then
				button:ClearAllPoints()
				button:SetPoint("TOPLEFT", frame.RewardButtons[1], "BOTTOMLEFT", 0, -3)
				button.SetPoint = T.dummy
			end
			button.restyled = true
		end
	end)

	SkinReward(QuestInfoSkillPointFrame)
	SkinReward(QuestInfoSpellObjectiveFrame)
	SkinReward(MapQuestInfoRewardsFrame.SpellFrame)
	SkinReward(MapQuestInfoRewardsFrame.XPFrame)
	SkinReward(MapQuestInfoRewardsFrame.MoneyFrame)
	SkinReward(MapQuestInfoRewardsFrame.SkillPointFrame)

	T.SkinDropDownBox(WorldMapLevelDropDown)
	WorldMapLevelDropDown:ClearAllPoints()
	WorldMapLevelDropDown:SetPoint("TOPLEFT", -18, -2)

end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)
