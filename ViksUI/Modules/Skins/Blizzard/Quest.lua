local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Quest skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestFrame:StripTextures(true)
	QuestFrameInset:StripTextures(true)
	QuestFrameDetailPanel:StripTextures(true)
	QuestDetailScrollFrame:StripTextures(true)
	QuestDetailScrollChildFrame:StripTextures(true)
	QuestRewardScrollFrame:StripTextures(true)
	QuestRewardScrollChildFrame:StripTextures(true)
	QuestProgressScrollFrame:StripTextures(true)
	QuestFrameProgressPanel:StripTextures(true)
	QuestFrameRewardPanel:StripTextures(true)

	QuestFrame:CreateBackdrop("Transparent")
	QuestFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	QuestFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	QuestFrameAcceptButton:SkinButton(true)
	QuestFrameDeclineButton:SkinButton(true)
	QuestFrameCompleteButton:SkinButton(true)
	QuestFrameGoodbyeButton:SkinButton(true)
	QuestFrameCompleteQuestButton:SkinButton(true)

	T.SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)

	for i = 1, 6 do
		local button = _G["QuestProgressItem"..i]
		local texture = _G["QuestProgressItem"..i.."IconTexture"]

		if button.NameFrame then button.NameFrame:Hide() end
		button.Name:SetFont(Viks.media.font, 12)

		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", texture, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", texture, 2, -2)

		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	hooksecurefunc("QuestFrameProgressItems_Update", function()
		QuestProgressTitleText:SetTextColor(1, 0.8, 0)
		QuestProgressTitleText:SetShadowColor(0, 0, 0)
		QuestProgressText:SetTextColor(1, 1, 1)
		QuestProgressRequiredItemsText:SetTextColor(1, 0.8, 0)
		QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
		QuestProgressRequiredMoneyText:SetTextColor(1, 0.8, 0)
	end)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)