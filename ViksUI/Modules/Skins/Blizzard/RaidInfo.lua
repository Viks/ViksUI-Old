local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	RaidInfo skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"RaidInfoScrollFrame",
		"RaidInfoFrame",
		"RaidInfoInstanceLabel",
		"RaidInfoIDLabel"
	}

	local KillTextures = {
		"RaidInfoScrollFrameScrollBarBG",
		"RaidInfoScrollFrameScrollBarTop",
		"RaidInfoScrollFrameScrollBarBottom",
		"RaidInfoScrollFrameScrollBarMiddle"
	}

	local buttons = {
		"RaidFrameConvertToRaidButton",
		"RaidFrameRaidInfoButton",
		-- wod "RaidFrameRaidBrowserButton",
		"RaidInfoExtendButton",
		"RaidInfoCancelButton"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	RaidInfoFrame:CreateBackdrop("Transparent")
	RaidInfoFrame.backdrop:SetPoint("TOPLEFT", RaidInfoFrame, "TOPLEFT")
	RaidInfoFrame.backdrop:SetPoint("BOTTOMRIGHT", RaidInfoFrame, "BOTTOMRIGHT")
	RaidInfoFrame:SetPoint("TOPLEFT", FriendsFrame, "TOPRIGHT", 3, 0)
	T.SkinCloseButton(RaidInfoCloseButton, RaidInfoFrame)
	T.SkinCheckBox(RaidFrameAllAssistCheckButton)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)