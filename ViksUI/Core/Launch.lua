local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	First Time Launch and On Login file
----------------------------------------------------------------------------------------
function ViksUI:Install_AddonSV() -- install saved variables
	ViksUI:InstallBartender4()
	ViksUI:InstallMasque()
end

local function InstallUI()
	-- Don't need to set CVar multiple time
	SetCVar("screenshotQuality", 8)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("showTutorials", 0)
	SetCVar("gameTip", "0")
	SetCVar("UberTooltips", 1)
	SetCVar("chatMouseScroll", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("WhisperMode", "inline")
	SetCVar("BnWhisperMode", "inline")
	SetCVar("colorblindMode", 0)
	SetCVar("lootUnderMouse", 0)
	SetCVar("autoLootDefault", 1)
	SetCVar("RotateMinimap", 0)
	SetCVar("ConsolidateBuffs", 0)
	SetCVar("autoQuestProgress", 1)
	SetCVar("scriptErrors", 0)
	SetCVar("taintLog", 0)
	SetCVar("buffDurations", 1)
	SetCVar("enableCombatText", 1)
	SetCVar("autoOpenLootHistory", 0)
	SetCVar("lossOfControl", 0)


	-- Setting chat frames
	if Viks.chat.enable == true and not (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
	FCF_ResetChatWindows()
	FCF_ToggleLock()
	FCF_OpenNewWindow()
	FCF_OpenNewWindow()
	FCF_SetWindowName(ChatFrame1, "Group")
	FCF_SetWindowName(ChatFrame2, "Log")
	FCF_SetWindowName(ChatFrame3, "Trade/Spam")
	FCF_SetWindowName(ChatFrame4, "Guild")
	FCF_UnDockFrame(ChatFrame4)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_DockFrame(ChatFrame3)
	FCF_SetLocked(ChatFrame3, 1)
	ChatFrame1:SetParent(nil)
	ChatFrame1Tab:SetParent(nil)
	ChatFrame1:ClearAllPoints()
	ChatFrame1Tab:ClearAllPoints()
	ChatFrame1:SetParent(LChat)
	ChatFrame1Tab:SetParent(LChatTab)
	ChatFrame1:SetFrameLevel(LChat:GetFrameLevel()+2)
	ChatFrame1:SetWidth(LChat:GetWidth()-8)
	ChatFrame1:SetHeight(LChat:GetHeight()-8)
	ChatFrame1:SetPoint("BOTTOMLEFT",LChat,"BOTTOMLEFT",4,6)
	ChatFrame1:SetPoint("TOPRIGHT",LChat,"TOPRIGHT",-4,-2)
	ChatFrame1TabText:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\LinkinPark.ttf", 14, "THINOUTLINE")
	ChatFrame1TabText:SetTextColor(.5,.5,.5)
	FCF_SavePositionAndDimensions(ChatFrame1)
	ChatFrame4:SetParent(nil)
	ChatFrame4Tab:SetParent(nil)
	ChatFrame4:ClearAllPoints()
	ChatFrame4Tab:ClearAllPoints()
	ChatFrame4:SetParent(RChat)
	ChatFrame4Tab:SetParent(RChatTab)
	ChatFrame4:SetFrameLevel(RChat:GetFrameLevel()+2)
	ChatFrame4:SetWidth(RChat:GetWidth()-8)
	ChatFrame4:SetHeight(RChat:GetHeight()-8)
	ChatFrame4:SetPoint("BOTTOMLEFT",RChat,"BOTTOMLEFT",4,4)
	ChatFrame4:SetPoint("TOPRIGHT",RChat,"TOPRIGHT",-4,-2)
	ChatFrame4TabText:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\LinkinPark.ttf", 14, "THINOUTLINE")
	ChatFrame4TabText:SetTextColor(.5,.5,.5)
	FCF_SavePositionAndDimensions(ChatFrame4)
	FCF_SetLocked(ChatFrame1, 1)
	
-----------------------------------
---Chat Channels Setup
-----------------------------------
	--Chatwindow 1 is used for Party and Raid so lets remove spam channels
		ChatFrame_RemoveChannel(ChatFrame1, "Trade")
		ChatFrame_RemoveChannel(ChatFrame1, "General")
		ChatFrame_RemoveChannel(ChatFrame1, "LocalDefense")
		ChatFrame_RemoveChannel(ChatFrame1, "GuildRecruitment")
		ChatFrame_RemoveChannel(ChatFrame1, "LookingForGroup")
	--Lets setup what to show, we start by killing all msg first.
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame5, "INSTANCE_CHAT")
		ChatFrame_AddMessageGroup(ChatFrame5, "INSTANCE_CHAT_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "LOOT")




	-- Setup the spam chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddChannel(ChatFrame3, "Trade")
		ChatFrame_AddChannel(ChatFrame3, "General")
		ChatFrame_AddChannel(ChatFrame3, "LocalDefense")
		ChatFrame_AddChannel(ChatFrame3, "GuildRecruitment")
		ChatFrame_AddChannel(ChatFrame3, "LookingForGroup")
		ChatFrame_AddMessageGroup(ChatFrame5, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame5, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame5, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame5, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame5, "MONEY")
		ChatFrame_AddMessageGroup(ChatFrame5, "SKILL")
		ChatFrame_AddMessageGroup(ChatFrame5, "CURRENCY")
		ChatFrame_AddMessageGroup(ChatFrame5, "OPENING")
		ChatFrame_AddMessageGroup(ChatFrame5, "TRADESKILLS")
		
	-- Setup the guild chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
		ChatFrame_AddMessageGroup(ChatFrame4, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame4, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame4, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame4, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame4, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame4, "BN_CONVERSATION")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_GUILD_XP_GAIN")
		
		
	-- Enable classcolor automatically on login and on each character without doing /configure each time
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	end

	-- Reset saved variables on char
	SavedPositions = {}
	SavedOptionsPerChar = {}
	
	SavedOptionsPerChar.Install = true
	SavedOptionsPerChar.FogOfWar = false
	SavedOptionsPerChar.AutoInvite = false
	SavedOptionsPerChar.Archaeology = false
	SavedOptionsPerChar.BarsLocked = false
	SavedOptionsPerChar.SplitBars = true
	SavedOptionsPerChar.LootFrame = true
	SavedOptionsPerChar.DamageMeter = false
	SavedOptionsPerChar.RightBars = Viks.actionbar.rightbars
	SavedOptionsPerChar.BottomBars = Viks.actionbar.bottombars
	--ViksUI:Install_AddonSV()
	ReloadUI()
end

local function DisableUI()
	DisableAddOn("ViksUI")
	ReloadUI()
end

----------------------------------------------------------------------------------------
--	Popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.INSTALL_UI = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = false end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

StaticPopupDialogs.DISABLE_UI = {
	text = L_POPUP_DISABLEUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableUI,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_UI = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	OnCancel = function() SavedOptionsPerChar.Install = true end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.RESET_STATS = {
	text = L_POPUP_RESETSTATS,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() SavedStats = {} ReloadUI() end,
	showAlert = true,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

StaticPopupDialogs.SWITCH_RAID = {
	text = L_POPUP_SWITCH_RAID,
	button1 = DAMAGER,
	button2 = HEALER,
	button3 = "Blizzard",
	OnAccept = function() SavedOptions.RaidLayout = "DPS" ReloadUI() end,
	OnCancel = function() SavedOptions.RaidLayout = "HEAL" ReloadUI() end,
	OnAlt = function() SavedOptions.RaidLayout = "NONE" ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("RESET_UI") end

SLASH_CONFIGURE1 = "/installui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("INSTALL_UI") end

SLASH_RESETSTATS1 = "/resetstats"
SlashCmdList.RESETSTATS = function() StaticPopup_Show("RESET_STATS") end
----------------------------------------------------------------------------------------
--	On logon function
----------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	-- Create empty CVar if they doesn't exist
	if SavedOptions == nil then SavedOptions = {} end
	if SavedPositions == nil then SavedPositions = {} end
	if SavedAddonProfiles == nil then SavedAddonProfiles = {} end
	if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end
	if SavedOptions.RaidLayout == nil then SavedOptions.RaidLayout = "UNKNOWN" end
	if SavedOptionsPerChar.FogOfWar == nil then SavedOptionsPerChar.FogOfWar = false end
	if SavedOptionsPerChar.AutoInvite == nil then SavedOptionsPerChar.AutoInvite = false end
	if SavedOptionsPerChar.Archaeology == nil then SavedOptionsPerChar.Archaeology = false end
	if SavedOptionsPerChar.BarsLocked == nil then SavedOptionsPerChar.BarsLocked = false end
	if SavedOptionsPerChar.SplitBars == nil then SavedOptionsPerChar.SplitBars = true end
	if SavedOptionsPerChar.RightBars == nil then SavedOptionsPerChar.RightBars = Viks.actionbar.rightbars end
	if SavedOptionsPerChar.BottomBars == nil then SavedOptionsPerChar.BottomBars = Viks.actionbar.bottombars end

	if T.getscreenwidth < 1024 and GetCVar("gxMonitor") == "0" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if Viks.general.MultisampleProtect == true and GetCVar("gxMultisample") ~= "1" then
			SetMultisampleFormat(1)
		end
		if Viks.general.UiScale > 1.28 then Viks.general.UiScale = 1.28 end
		if Viks.general.UiScale < 0.64 then Viks.general.UiScale = 0.64 end

		-- Set our UiScale
		SetCVar("UiScale", Viks.general.UiScale)

		-- Install default if we never ran ViksUI on this character
		if not SavedOptionsPerChar.Install then
			StaticPopup_Show("INSTALL_UI")
		end
	end

	if SavedOptions.RaidLayout == "UNKNOWN" then
		StaticPopup_Show("SWITCH_RAID")
	end

	-- Welcome message
	if Viks.general.welcome_message == true then
		print("|cffffff00".."Welcome to ViksUI "..T.version.." "..T.client..", "..T.name..".|r")
		print("|cffffff00".."Type /config to config interface".." |cffffff00".."for more informations.")
	end
end)

