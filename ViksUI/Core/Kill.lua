local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all shit stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if Viks.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	if addon == "Blizzard_PetJournal" then
		MountJournalSearchBox:Kill()
	end

	if Viks.unitframes.enable and (SavedOptions and (SavedOptions.RaidLayout == "HEAL" or SavedOptions.RaidLayout == "DPS")) then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
		if not InCombatLockdown() then
			CompactRaidFrameManager:Kill()
			CompactRaidFrameContainer:Kill()
		end
		ShowPartyFrame = T.dummy
		HidePartyFrame = T.dummy
		CompactUnitFrame_UpdateAll = T.dummy
		CompactUnitFrameProfiles_ApplyProfile = T.dummy
		CompactRaidFrameManager_UpdateShown = T.dummy
		CompactRaidFrameManager_UpdateOptionsFlowContainer = T.dummy
	end

	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	TutorialFrameAlertButton:Kill()
	HelpOpenTicketButtonTutorial:Kill()
	TalentMicroButtonAlert:Kill()
	CompanionsMicroButtonAlert:Kill()

	if Viks.chat.enable then
		InterfaceOptionsSocialPanelChatStyle:Kill()
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
	end

	if Viks.unitframes.enable then
		if T.class == "DEATHKNIGHT" and Viks.unitframes.showRunebar ~= true then
			RuneFrame:Kill()
		end
		InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
		InterfaceOptionsBuffsPanelCastableBuffs:Kill()
		InterfaceOptionsBuffsPanelDispellableDebuffs:Kill()
		InterfaceOptionsBuffsPanelShowAllEnemyDebuffs:Kill()
		InterfaceOptionsCombatPanelTargetOfTarget:Kill()
		InterfaceOptionsCombatPanelEnemyCastBars:Kill()
		InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait:Kill()
		SetCVar("showPartyBackground", 0)
	end

	if Viks.actionbar.enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end

	if Viks.nameplate.enable then
		InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates:Kill()
		InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors:Kill()
	end

	if Viks.minimapp.enable then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end

	if Viks.combattext.enable then
		InterfaceOptionsCombatTextPanelFCTDropDown:Kill()
		if Viks.combattext.blizz_head_numbers ~= true then
			SetCVar("CombatLogPeriodicSpells", 0)
			SetCVar("PetMeleeDamage", 0)
			SetCVar("CombatDamage", 0)
			SetCVar("CombatHealing", 0)
			InterfaceOptionsCombatTextPanelTargetDamage:Kill()
			InterfaceOptionsCombatTextPanelPeriodicDamage:Kill()
			InterfaceOptionsCombatTextPanelPetDamage:Kill()
			InterfaceOptionsCombatTextPanelHealing:Kill()
		end
	end
end)