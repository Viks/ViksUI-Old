local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator)
	if initiator ~= "player" then
		PlaySound("ReadyCheck", "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("PET_BATTLE_QUEUE_PROPOSE_MATCH")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" then
		for i = 1, GetMaxBattlefieldID() do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				PlaySound("PVPTHROUGHQUEUE", "Master")
				break
			end
			i = i + 1
		end
	elseif event == "PET_BATTLE_QUEUE_PROPOSE_MATCH" then
		PlaySound("PVPTHROUGHQUEUE", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" then
		PlaySound("ReadyCheck", "Master")
	elseif event == "RESURRECT_REQUEST" then
		PlaySoundFile("Sound\\Spells\\Resurrection.wav", "Master")
	end
end)

----------------------------------------------------------------------------------------
--	Misclicks for some popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE_XREALM.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
PetBattleQueueReadyFrame.hideOnEscape = nil
PVPReadyDialog.leaveButton:Hide()
PVPReadyDialog.enterButton:ClearAllPoints()
PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if Viks.misc.afk_spin_camera == true then
local PName = UnitName("player")
local PLevel = UnitLevel("player")
local PClass = UnitClass("player")
local PRace = UnitRace("player")
local PFaction = UnitFactionGroup("player")
local color = RAID_CLASS_COLORS[T.Class]
local Version = tonumber(GetAddOnMetadata("ViksUI", "Version"))

local PGuild
if(IsInGuild()) then PGuild = select(1, GetGuildInfo("player")) else PGuild = " " end

T.AFK_LIST = {
	"Mouseover minimap shows coords and locations.",
	"Small yellow square on minimap shows micromenu.",
	"Right click the minimap for trackingmenu.",
	"Farm Mode: Toggle with mapbutton (lower left on minimap, hidden) or with /fm or /farmmode",
	"By right-clicking on a quest or achievment at the objective tracker, you can retrieve the wowhead link.",
	"You can type /ui to move the frames from the Interface.",
	"You can type /uihelp to show some supported commands.",
	"/testuf shows UF unitframes",
	"Right click on X button on bags to access soring/stacking. Works with bank to (use same button)",
	"You can see the source of raid buffs, by clicking on raidbuffreminder. Click again to hide",
	"You can find much information about something on screen with /fstack command",
	"You can toggle few things on/off (Helm, Cloak, Auto Loot, Overlapping) on top panel fram. (Under location text)",	
}

local ViksUIAFKPanel = CreateFrame("Frame", "ViksUIAFKPanel", nil)
ViksUIAFKPanel:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -2, -2)
ViksUIAFKPanel:SetPoint("TOPRIGHT", UIParent, "BOTTOMRIGHT", 2, 150)
ViksUIAFKPanel:SetTemplate("Transparent")
ViksUIAFKPanel:Hide()

local ViksUIAFKPanelTop = CreateFrame("Frame", "ViksUIAFKPanelTop", nil)
ViksUIAFKPanelTop:SetPoint("TOPLEFT", UIParent, "TOPLEFT",-2, 2)
ViksUIAFKPanelTop:SetPoint("BOTTOMRIGHT", UIParent, "TOPRIGHT", 2, -80)
ViksUIAFKPanelTop:SetTemplate("Transparent")
ViksUIAFKPanelTop:SetFrameStrata("FULLSCREEN")
ViksUIAFKPanelTop:Hide()

local ViksUIAFKPanelTopIcon = CreateFrame("Frame", "ViksUIAFKPanelTopIcon", ViksUIAFKPanelTop)
ViksUIAFKPanelTopIcon:SetWidth(128)
ViksUIAFKPanelTopIcon:SetHeight(64)
ViksUIAFKPanelTopIcon:SetPoint("CENTER", ViksUIAFKPanelTop, "BOTTOM", 0, -20)
--ViksUIAFKPanelTopIcon:SetTemplate("Default")

local t = ViksUIAFKPanelTopIcon:CreateTexture(nil,"ARTWORK")
t:SetTexture("Interface\\AddOns\\ViksUI\\Media\\textures\\viksui.blp")
t:SetPoint("TOPLEFT", 2, -2)
t:SetPoint("BOTTOMRIGHT", -2, 2)
ViksUIAFKPanelTopIcon.texture = t
ViksUIAFKPanelTopIcon:SetPoint("CENTER", ViksUIAFKPanelTop, "BOTTOM", 0, -20)
ViksUIAFKPanelTopIcon:Show()

ViksUIAFKPanelTop.ViksUIText = ViksUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
ViksUIAFKPanelTop.ViksUIText:SetPoint("CENTER", ViksUIAFKPanelTop, "CENTER", 0, 0)
ViksUIAFKPanelTop.ViksUIText:SetFont(Viks["media"].pxfontHeader, 40, "OUTLINE")
ViksUIAFKPanelTop.ViksUIText:SetText("|cffc41f3bViksUI Version" .. Version)

ViksUIAFKPanelTop.DateText = ViksUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
ViksUIAFKPanelTop.DateText:SetPoint("BOTTOMLEFT", ViksUIAFKPanelTop, "BOTTOMRIGHT", -100, 44)
ViksUIAFKPanelTop.DateText:SetFont(Viks["media"].font, 15, "OUTLINE")

ViksUIAFKPanelTop.ClockText = ViksUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
ViksUIAFKPanelTop.ClockText:SetPoint("BOTTOMLEFT", ViksUIAFKPanelTop, "BOTTOMRIGHT", -100, 20)
ViksUIAFKPanelTop.ClockText:SetFont(Viks["media"].font, 20, "OUTLINE")

ViksUIAFKPanelTop.PlayerNameText = ViksUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
ViksUIAFKPanelTop.PlayerNameText:SetPoint("LEFT", ViksUIAFKPanelTop, "LEFT", 25, 15)
ViksUIAFKPanelTop.PlayerNameText:SetFont(Viks["media"].font, 28, "OUTLINE")
ViksUIAFKPanelTop.PlayerNameText:SetText(PName)
ViksUIAFKPanelTop.PlayerNameText:SetTextColor(T.color.r, T.color.g, T.color.b)

ViksUIAFKPanelTop.GuildText = ViksUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
ViksUIAFKPanelTop.GuildText:SetPoint("LEFT", ViksUIAFKPanelTop, "LEFT", 25, -3)
ViksUIAFKPanelTop.GuildText:SetFont(Viks["media"].font, 15, "OUTLINE")
ViksUIAFKPanelTop.GuildText:SetText("|cffc41f3b" .. PGuild .. "|r")

ViksUIAFKPanelTop.PlayerInfoText = ViksUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
ViksUIAFKPanelTop.PlayerInfoText:SetPoint("LEFT", ViksUIAFKPanelTop, "LEFT", 25, -20)
ViksUIAFKPanelTop.PlayerInfoText:SetFont(Viks["media"].font, 15, "OUTLINE")
ViksUIAFKPanelTop.PlayerInfoText:SetText(LEVEL .. " " .. PLevel .. " " .. PFaction .. " " .. PClass)

local interval = 0
ViksUIAFKPanelTop:SetScript("OnUpdate", function(self, elapsed)
	interval = interval - elapsed
	if interval <= 0 then
		ViksUIAFKPanelTop.ClockText:SetText(format("%s", date("%H|cffc41f3b:|r%M|cffc41f3b:|r%S")))
		ViksUIAFKPanelTop.DateText:SetText(format("%s", date("|cffc41f3b%a|r %b/%d")))
		interval = 0.5
	end
end)

local OnEvent = function(self, event, unit)
	if event == "PLAYER_FLAGS_CHANGED" then
		if unit == "player" then
			if UnitIsAFK(unit) and not UnitIsDead(unit) then
				SpinStart()
				ViksUIAFKPanel:Show()
				ViksUIAFKPanelTop:Show()
				Minimap:Hide()
			else
				SpinStop()
				ViksUIAFKPanel:Hide()
				ViksUIAFKPanelTop:Hide()
				Minimap:Show()
			end
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		SpinStop()
	elseif event == "PLAYER_DEAD" then
		SpinStop()
		ViksUIAFKPanel:Hide()
		ViksUIAFKPanelTop:Hide()
		Minimap:Show()
	end
end

ViksUIAFKPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
ViksUIAFKPanel:RegisterEvent("PLAYER_LEAVING_WORLD")
ViksUIAFKPanel:RegisterEvent("PLAYER_FLAGS_CHANGED")
ViksUIAFKPanel:RegisterEvent("PLAYER_DEAD")
ViksUIAFKPanel:SetScript("OnEvent", OnEvent)

local texts = T.AFK_LIST
local interval = #texts

local ViksUIAFKScrollFrame = CreateFrame("ScrollingMessageFrame", "ViksUIAFKScrollFrame", ViksUIAFKPanel)
ViksUIAFKScrollFrame:SetSize(ViksUIAFKPanel:GetWidth(), ViksUIAFKPanel:GetHeight())
ViksUIAFKScrollFrame:SetPoint("CENTER", ViksUIAFKPanel, "CENTER", 0, 60)
ViksUIAFKScrollFrame:SetFont(Viks["media"].font, 20, "OUTLINE")
ViksUIAFKScrollFrame:SetShadowColor(0, 0, 0, 0)
ViksUIAFKScrollFrame:SetFading(false)
ViksUIAFKScrollFrame:SetFadeDuration(0)
ViksUIAFKScrollFrame:SetTimeVisible(1)
ViksUIAFKScrollFrame:SetMaxLines(1)
ViksUIAFKScrollFrame:SetSpacing(2)
ViksUIAFKScrollFrame:SetScript("OnUpdate", function(self, time)
	interval = interval - (time / 30)
	for index, name in pairs(T.AFK_LIST) do
		if interval < index then
			ViksUIAFKScrollFrame:AddMessage(T.AFK_LIST[index], 1, 1, 1)
			tremove(texts, index)
		end
	end

	if interval < 0 then self:SetScript("OnUpdate", nil) end
end)

ViksUIAFKPanel:SetScript("OnShow", function(self) UIFrameFadeIn(UIParent, .5, 1, 0) end)
ViksUIAFKPanel:SetScript("OnHide", function(self) UIFrameFadeOut(UIParent, .5, 0, 1) end)

function SpinStart()
	spinning = true
	MoveViewRightStart(.1)
end

function SpinStop()
	if(not spinning) then return end
	spinning = nil
	MoveViewRightStop()
end
end

----------------------------------------------------------------------------------------
--	Custom Lag Tolerance(by Elv22)
----------------------------------------------------------------------------------------
if Viks.general.custom_lagtolerance == true then
	InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset:Hide()
	InterfaceOptionsCombatPanelReducedLagTolerance:Hide()

	local customlag = CreateFrame("Frame")
	local int = 5
	local _, _, _, lag = GetNetStats()
	local LatencyUpdate = function(self, elapsed)
		int = int - elapsed
		if int < 0 then
			if GetCVar("reducedLagTolerance") ~= tostring(1) then SetCVar("reducedLagTolerance", tostring(1)) end
			if lag ~= 0 and lag <= 400 then
				SetCVar("maxSpellStartRecoveryOffset", tostring(lag))
			end
			int = 5
		end
	end
	customlag:SetScript("OnUpdate", LatencyUpdate)
	LatencyUpdate(customlag, 10)
end

----------------------------------------------------------------------------------------
--	Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
----------------------------------------------------------------------------------------
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Remove Boss Emote spam during BG(ArathiBasin SpamFix by Partha)
----------------------------------------------------------------------------------------
if Viks.misc.hide_bg_spam == true then
	local Fixer = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame

	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN or GetZoneText() == L_ZONE_GILNEAS then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end

	Fixer:RegisterEvent("PLAYER_ENTERING_WORLD")
	Fixer:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Fixer:SetScript("OnEvent", DisableSpam)
end

----------------------------------------------------------------------------------------
--	Undress button in auction dress-up frame(by Nefarion)
----------------------------------------------------------------------------------------
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetHeight(22)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(self, button)
	if button == "RightButton" then
		self.model:UndressSlot(19)
	else
		self.model:Undress()
	end
	PlaySound("gsTitleOptionOK")
end)
strip.model = DressUpModel

strip:RegisterEvent("AUCTION_HOUSE_SHOW")
strip:RegisterEvent("AUCTION_HOUSE_CLOSED")
strip:SetScript("OnEvent", function(self)
	if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
		self:SetParent(SideDressUpModel)
		self:ClearAllPoints()
		self:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
		self.model = SideDressUpModel
	elseif self.model ~= DressUpModel then
		self:SetParent(DressUpModel)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
		self.model = DressUpModel
	end
end)

----------------------------------------------------------------------------------------
--	GuildTab in FriendsFrame
----------------------------------------------------------------------------------------
local n = FriendsFrame.numTabs + 1
local gtframe = CreateFrame("Button", "FriendsFrameTab"..n, FriendsFrame, "FriendsFrameTabTemplate")
gtframe:SetText(GUILD)
gtframe:SetPoint("LEFT", _G["FriendsFrameTab"..n - 1], "RIGHT", -15, 0)
PanelTemplates_DeselectTab(gtframe)
gtframe:SetScript("OnClick", function() ToggleGuildFrame() end)

----------------------------------------------------------------------------------------
--	Force quit
----------------------------------------------------------------------------------------
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Old achievements filter
----------------------------------------------------------------------------------------
function AchievementFrame_GetCategoryNumAchievements_OldIncomplete(categoryID)
	local numAchievements, numCompleted = GetCategoryNumAchievements(categoryID)
	return numAchievements - numCompleted, 0, numCompleted
end

function old_nocomplete_filter_init()
	AchievementFrameFilters = {
		{text = ACHIEVEMENTFRAME_FILTER_ALL, func = AchievementFrame_GetCategoryNumAchievements_All},
		{text = ACHIEVEMENTFRAME_FILTER_COMPLETED, func = AchievementFrame_GetCategoryNumAchievements_Complete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE, func = AchievementFrame_GetCategoryNumAchievements_Incomplete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE.." ("..ALL.." )", func = AchievementFrame_GetCategoryNumAchievements_OldIncomplete}
	}
end

local filter = CreateFrame("Frame")
filter:RegisterEvent("ADDON_LOADED")
filter:SetScript("OnEvent", function(self, event, addon, ...)
	if addon == "Blizzard_AchievementUI" then
		if AchievementFrame then
			old_nocomplete_filter_init()
			if Viks.skins.blizzard_frames == true then
				AchievementFrameFilterDropDown:SetWidth(AchievementFrameFilterDropDown:GetWidth() + 20)
			end
			filter:UnregisterEvent("ADDON_LOADED")
		end
	end
end)