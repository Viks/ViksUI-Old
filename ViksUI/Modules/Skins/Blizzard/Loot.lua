local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Loot skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if Viks.loot.lootframe == true or (IsAddOnLoaded("cargBags") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("Bagnon")) then return end

	LootFrame:StripTextures(true)
	LootFrameInset:StripTextures()
	LootFrame:SetTemplate("Transparent")

	T.SkinNextPrevButton(LootFrameDownButton, true)
	T.SkinNextPrevButton(LootFrameUpButton, true)

	T.SkinCloseButton(LootFrameCloseButton)

	for i = 1, LOOTFRAME_NUMBUTTONS do
		local slot = _G["LootButton"..i]
		local icon = _G["LootButton"..i.."IconTexture"]
		local name = _G["LootButton"..i.."NameFrame"]
		_G["LootButton"..i.."IconQuestTexture"]:SetAlpha(0)

		slot:StyleButton()
		slot:SetNormalTexture("")
		slot:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		name:Hide()
		name.border = CreateFrame("Frame", nil, slot)
		name.border:CreateBackdrop("Overlay")
		name.border.backdrop:SetPoint("TOPLEFT", name, 11, -13)
		name.border.backdrop:SetPoint("BOTTOMRIGHT", name, -8, 12)
	end
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)