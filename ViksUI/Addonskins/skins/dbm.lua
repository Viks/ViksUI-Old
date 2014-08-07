local T, Viks, L, _ = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	DBM skin(by Affli)
----------------------------------------------------------------------------------------
if not Viks.addonskins.DBM or not IsAddOnLoaded("DBM-Core") == true then return end
local forcebosshealthclasscolor = false		-- Forces BossHealth to be classcolored. Not recommended.
local croprwicons = true					-- Crops blizz shitty borders from icons in RaidWarning messages
local rwiconsize = 12						-- RaidWarning icon size. Works only if croprwicons = true
local backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8x8",
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local DBMSkin = CreateFrame("Frame")
DBMSkin:RegisterEvent("PLAYER_LOGIN")
DBMSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("DBM-Core") then
		local function SkinBars(self)
			for bar in self:GetBarIterator() do
				if not bar.injected then
					bar.ApplyStyle = function()
						local frame = bar.frame
						local tbar = _G[frame:GetName().."Bar"]
						local spark = _G[frame:GetName().."BarSpark"]
						local texture = _G[frame:GetName().."BarTexture"]
						local icon1 = _G[frame:GetName().."BarIcon1"]
						local icon2 = _G[frame:GetName().."BarIcon2"]
						local name = _G[frame:GetName().."BarName"]
						local timer = _G[frame:GetName().."BarTimer"]

						if (icon1.overlay) then
							icon1.overlay = _G[icon1.overlay:GetName()]
						else
							icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
							icon1.overlay:SetWidth(20)
							icon1.overlay:SetHeight(20)
							icon1.overlay:SetFrameStrata("BACKGROUND")
							icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -5, -2)
							frame1px(icon1.overlay)
							CreateShadow(icon1.overlay)
						end

						if (icon2.overlay) then
							icon2.overlay = _G[icon2.overlay:GetName()]
						else
							icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
							icon2.overlay:SetWidth(20)
							icon2.overlay:SetHeight(20)
							icon2.overlay:SetFrameStrata("BACKGROUND")
							icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", 5, -2)
							frame1px(icon2.overlay)
							CreateShadow(icon2.overlay)
						end

						if bar.color then
							tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
							tbar:SetBackdrop(backdrop)
							tbar:SetBackdropColor(bar.color.r, bar.color.g, bar.color.b, 0.15)
						else
							tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
							tbar:SetBackdrop(backdrop)
							tbar:SetBackdropColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB, 0.15)
						end
						
						if bar.enlarged then frame:SetWidth(bar.owner.options.HugeWidth) else frame:SetWidth(bar.owner.options.Width) end
						if bar.enlarged then tbar:SetWidth(bar.owner.options.HugeWidth) else tbar:SetWidth(bar.owner.options.Width) end

						frame:SetScale(1)
						if not frame.styled then
							frame:SetHeight(20)
							frame1px(frame)
							CreateShadow(frame)
							frame.styled = true
						end

						if not spark.killed then
							spark:SetAlpha(0)
							spark:SetTexture(nil)
							spark.killed = true
						end
			
						if not icon1.styled then
							icon1:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon1:ClearAllPoints()
							icon1:SetPoint("TOPLEFT", icon1.overlay, 2, -2)
							icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, -2, 2)
							icon1.styled = true
						end
						
						if not icon2.styled then
							icon2:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon2:ClearAllPoints()
							icon2:SetPoint("TOPLEFT", icon2.overlay, 2, -2)
							icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, -2, 2)
							icon2.styled = true
						end
						
						if not texture.styled then
							texture:SetTexture(Viks.media.texture)
							texture.styled = true
						end
						
						if not tbar.styled then
							tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
							tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
							tbar.styled = true
						end

						if not name.styled then
							name:ClearAllPoints()
							name:SetPoint("LEFT", frame, "LEFT", 4, 0)
							name:SetWidth(130)
							name:SetHeight(8)
							name:SetFont(Viks.media.font, 10, "OUTLINE")
							name:SetShadowOffset(0, 0, 0, 0)
							name:SetJustifyH("LEFT")
							name.SetFont = dummy
							name.styled = true
						end
						
						if not timer.styled then	
							timer:ClearAllPoints()
							timer:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
							timer:SetFont(Viks.media.font, 10, "OUTLINE")
							timer:SetShadowOffset(0, 0, 0, 0)
							timer:SetJustifyH("RIGHT")
							timer.SetFont = dummy
							timer.styled = true
						end
						
						DBMRangeCheckRadar:HookScript("OnShow",function(self)
						frame1px(self)
						CreateShadow(self)
						end)
						if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
						if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
						tbar:SetAlpha(1)
						frame:SetAlpha(1)
						texture:SetAlpha(1)
						frame:Show()
						bar:Update(0)
						bar.injected = true
					end
					bar:ApplyStyle()
				end
			end
		end

		local SkinBossTitle = function()
			local anchor = DBMBossHealthDropdown:GetParent()
			if not anchor.styled then
				local header = {anchor:GetRegions()}
				if header[1]:IsObjectType("FontString") then
					header[1]:SetFont(Viks.media.font, 10, "OUTLINE")
					header[1]:SetShadowOffset(0, 0, 0, 0)
					header[1]:SetTextColor(1, 1, 1, 1)
					anchor.styled = true	
				end
				header = nil
			end
			anchor = nil
		end
		
		local SkinBoss = function()
			local count = 1
			while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
				local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
				local background = _G[bar:GetName().."BarBorder"]
				local progress = _G[bar:GetName().."Bar"]
				local name = _G[bar:GetName().."BarName"]
				local timer = _G[bar:GetName().."BarTimer"]
				local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]

				if (count == 1) then
					local _, anch, _ , _, _ = bar:GetPoint()
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOM", anch, "TOP", 0, 3)
					else
						bar:SetPoint("TOP", anch, "BOTTOM", 0, -3)
					end
				else
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOMLEFT", prev, "TOPLEFT", 0, 3)
					else
						bar:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -3)
					end
				end

				if not bar.styled then
					bar:SetScale(1)
					bar:SetHeight(19)
					frame1px(bar)
					CreateShadow(bar)
					background:SetNormalTexture(nil)
					bar.styled = true
				end	
				
				if not progress.styled then
					progress:SetStatusBarTexture(Viks.media.texture)
					progress:SetBackdrop(backdrop)
					progress:SetBackdropColor(r,g,b,1)
					if forcebosshealthclasscolor then
						local tslu = 0
						progress:SetStatusBarColor(r,g,b,1)
						progress:HookScript("OnUpdate", function(self, elapsed)
							tslu = tslu+ elapsed
							if tslu > 0.025 then
								self:SetStatusBarColor(r,g,b,1)
								tslu = 0
							end
						end)
					end
					progress.styled = true
				end
				progress:ClearAllPoints()
				progress:SetPoint("TOPLEFT", bar, "TOPLEFT", 2, -2)
				progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("LEFT", bar, "LEFT", 4, 0)
					name:SetFont(Viks.media.font, 10, "OUTLINE")
					name:SetShadowOffset(0, 0, 0, 0)
					name:SetJustifyH("LEFT")
					name.styled = true
				end
				
				if not timer.styled then
					timer:ClearAllPoints()
					timer:SetPoint("RIGHT", bar, "RIGHT", -5, 0)
					timer:SetFont(Viks.media.font, 10, "OUTLINE")
					timer:SetShadowOffset(0, 0, 0, 0)
					timer:SetJustifyH("RIGHT")
					timer.styled = true
				end
				count = count + 1
			end
		end
		
		hooksecurefunc(DBT, "CreateBar", SkinBars)
		hooksecurefunc(DBM.BossHealth, "Show", SkinBossTitle)
		hooksecurefunc(DBM.BossHealth, "AddBoss", SkinBoss)
		hooksecurefunc(DBM.BossHealth,"UpdateSettings",SkinBoss)
		
		DBM.RangeCheck:Show()
		DBM.RangeCheck:Hide()

		DBMRangeCheck:HookScript("OnShow", function(self)
			frame1px(self)
			CreateShadow(self)
		end)
		
		if croprwicons then
			local replace = string.gsub
			local old = RaidNotice_AddMessage
			RaidNotice_AddMessage = function(noticeFrame, textString, colorInfo)
				if textString:find(" |T") then
					textString=replace(textString,"(:12:12)",":"..rwiconsize..":"..rwiconsize..":0:0:64:64:5:59:5:59")
				end
				return old(noticeFrame, textString, colorInfo)
			end
		end
	end
end)
local UploadDBM = function()
if IsAddOnLoaded("DBM-Core") then
	DBM_SavedOptions.Enabled=true
	DBM_SavedOptions.WarningIconLeft=false
	DBM_SavedOptions.WarningIconRight=false
	DBT_PersistentOptions["DBM"].Scale=1
	DBT_PersistentOptions["DBM"].HugeScale=1
	DBT_PersistentOptions["DBM"].BarXOffset=0
	DBT_PersistentOptions["DBM"].BarYOffset=5
	DBT_PersistentOptions["DBM"].IconLeft=true
	DBT_PersistentOptions["DBM"].ExpandUpwards=true
	DBT_PersistentOptions["DBM"].Texture= "Interface\\Buttons\\WHITE8x8"
	DBT_PersistentOptions["DBM"].IconRight=false
end
end
local pr = function(msg)
    print("|cffC495DDDBMskin|r:", tostring(msg))
end

local loadOptions = CreateFrame("Frame")
loadOptions:RegisterEvent("PLAYER_LOGIN")
loadOptions:SetScript("OnEvent", UploadDBM)
local function rt(i) return function() return i end end
local function healthdemo()
		DBM.BossHealth:Show("Scary bosses")
		DBM.BossHealth:AddBoss(rt(25), "Algalon")
		DBM.BossHealth:AddBoss(rt(50), "Mimiron")
		DBM.BossHealth:AddBoss(rt(75), "Sindragosa")
		DBM.BossHealth:AddBoss(rt(100), "Hogger")
end
SLASH_DBMSKIN1 = "/dbmskin"
SlashCmdList["DBMSKIN"] = function(msg)
	if(msg=="apply") then
		StaticPopup_Show("APPLY_SKIN")        
	elseif(msg=="test") then
		DBM:DemoMode()
	elseif(msg=="bh")then
		healthdemo()
	else
		pr("use |cffFF0000/dbmskin apply|r to apply DBM settings.")
		pr("use |cffFF0000/dbmskin test|r to launch DBM testmode.")
		pr("use |cffFF0000/dbmskin bh|r to show test BossHealth frame")
	end
end
StaticPopupDialogs["APPLY_SKIN"] = {
	text = "We need to set some DBM options to apply Viks UI DBM skin.\nMost of your settings will remain untouched.",
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = function() UploadDBM() ReloadUI() end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = true,
}

-- Load DBM varriables on demand
local SetDBM = function()
if(DBM_SavedOptions) then table.wipe(DBM_SavedOptions) end
	DBM_SavedOptions = {
	["SpecialWarningFontSize"] = 79,
	["CountdownVoice2"] = "Kolt",
	["SpecialWarningFlashAlph2"] = 0.3,
	["ArrowPosX"] = 0,
	["SpecialWarningFlashDura3"] = 1,
	["MovieFilter"] = "Never",
	["HPFramePoint"] = "RIGHT",
	["UseMasterVolume"] = true,
	["StatusEnabled"] = true,
	["InfoFrameX"] = -331.3992919921875,
	["CountdownPullTimer"] = true,
	["AprilFools"] = true,
	["RangeFrameX"] = -46.2591438293457,
	["SpecialWarningFlashCol3"] = {
		1, -- [1]
		0, -- [2]
		0, -- [3]
	},
	["WarningColors"] = {
		{
			["b"] = 0.9411764705882353,
			["g"] = 0.8,
			["r"] = 0.4117647058823529,
		}, -- [1]
		{
			["b"] = 0,
			["g"] = 0.9490196078431372,
			["r"] = 0.9490196078431372,
		}, -- [2]
		{
			["b"] = 0,
			["g"] = 0.5019607843137255,
			["r"] = 1,
		}, -- [3]
		{
			["b"] = 0.1019607843137255,
			["g"] = 0.1019607843137255,
			["r"] = 1,
		}, -- [4]
	},
	["AlwaysShowSpeedKillTimer"] = true,
	["RangeFrameY"] = 189.0348663330078,
	["FilterSayAndYell"] = false,
	["EnableModels"] = true,
	["SpecialWarningFlashAlph3"] = 0.4,
	["ArrowPoint"] = "TOP",
	["ModelSoundValue"] = "Short",
	["HideTooltips"] = false,
	["SpecialWarningSound2"] = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.wav",
	["InfoFramePoint"] = "RIGHT",
	["RangeFrameRadarPoint"] = "RIGHT",
	["SpecialWarningY"] = -71.50007629394531,
	["AutologBosses"] = false,
	["SpecialWarningFlashCol2"] = {
		1, -- [1]
		0.5, -- [2]
		0, -- [3]
	},
	["RangeFrameUpdates"] = "Average",
	["SpecialWarningPoint"] = "TOP",
	["DontShowInfoFrame"] = false,
	["RaidWarningSound"] = "Sound\\Doodad\\BellTollNightElf.wav",
	["RangeFrameRadarY"] = 136.9606781005859,
	["ShowRecoveryMessage"] = true,
	["RangeFrameSound1"] = "none",
	["SpecialWarningX"] = -44.99987411499023,
	["WhisperStats"] = true,
	["RaidWarningPosition"] = {
		["Y"] = -60.00005340576172,
		["X"] = -9.000001907348633,
		["Point"] = "TOP",
	},
	["DontSendBossWhispers"] = false,
	["DontPlayPTCountdown"] = false,
	["SpecialWarningFlashDura2"] = 0.4,
	["ShowKillMessage"] = true,
	["HealthFrameWidth"] = 200,
	["StripServerName"] = true,
	["WarningIconLeft"] = false,
	["ShowAdvSWSound"] = true,
	["HPFrameY"] = 66.01372528076172,
	["FixCLEUOnCombatStart"] = false,
	["ShowAdvSWSounds"] = false,
	["ShowMinimapButton"] = true,
	["MoviesSeen"] = {
	},
	["ShowEngageMessage"] = true,
	["SettingsMessageShown"] = true,
	["ForumsMessageShown"] = 10055,
	["DebugMode"] = false,
	["LastRevision"] = 8060,
	["ShowWarningsInChat"] = true,
	["DontSetIcons"] = false,
	["BigBrotherAnnounceToRaid"] = false,
	["ShowSpecialWarnings"] = true,
	["CountdownVoice"] = "Corsica",
	["AutoRespond"] = true,
	["SpecialWarningFontColor"] = {
		0, -- [1]
		0, -- [2]
		1, -- [3]
	},
	["DontShowPTCountdownText"] = false,
	["InfoFrameY"] = -143.2654113769531,
	["ChatFrame"] = "DEFAULT_CHAT_FRAME",
	["WarningIconRight"] = false,
	["HealthFrameGrowUp"] = false,
	["RangeFrameRadarX"] = -38.00067901611328,
	["HideBossEmoteFrame"] = false,
	["ShowCountdownText"] = false,
	["ShowBigBrotherOnCombatStart"] = false,
	["SpecialWarningFlashAlph1"] = 0.3,
	["SpecialWarningFlashCol1"] = {
		1, -- [1]
		1, -- [2]
		0, -- [3]
	},
	["BlockVersionUpdatePopup"] = true,
	["AdvancedAutologBosses"] = false,
	["PTCountThreshold"] = 5,
	["DontShowRangeFrame"] = false,
	["RangeFrameFrames"] = "radar",
	["InfoFrameShowSelf"] = false,
	["SpecialWarningFont"] = "Fonts\\FRIZQT__.TTF",
	["DontSendBossAnnounces"] = false,
	["DontShowPTNoID"] = false,
	["SpamBlockRaidWarning"] = true,
	["ShowFakedRaidWarnings"] = false,
	["LatencyThreshold"] = 200,
	["ShowLoadMessage"] = true,
	["DontShowBossAnnounces"] = false,
	["LFDEnhance"] = true,
	["SpecialWarningFlashDura1"] = 0.4,
	["SetPlayerRole"] = true,
	["ArrowPosY"] = -150,
	["RangeFramePoint"] = "RIGHT",
	["WarningIconChat"] = true,
	["HPFrameMaxEntries"] = 5,
	["BlockVersionUpdateNotice"] = false,
	["DontShowCTCount"] = false,
	["HideWatchFrame"] = false,
	["ShowPizzaMessage"] = true,
	["RangeFrameSound2"] = "none",
	["ShowLHFrame"] = true,
	["DisableCinematicsOutside"] = false,
	["DontShowPTText"] = false,
	["Enabled"] = true,
	["HealthFrameLocked"] = false,
	["SpecialWarningSound"] = "Sound\\Spells\\PVPFlagTaken.wav",
	["DisableCinematics"] = false,
	["MovieFilters"] = {
	},
	["SpecialWarningSound3"] = "Sound\\Creature\\Illidan\\BLACK_Illidan_04.wav",
	["ShowWipeMessage"] = true,
	["LogOnlyRaidBosses"] = false,
	["SetCurrentMapOnPull"] = true,
	["RangeFrameLocked"] = false,
	["AlwaysShowHealthFrame"] = false,
	["HPFrameX"] = -106.9998779296875,
	["ChallengeBest"] = "Realm",
	["SpamBlockBossWhispers"] = false,
	["DontShowPT"] = false,
	["ShowFlashFrame"] = true,
}
if(DBT_SavedOptions) then table.wipe(DBT_SavedOptions) end
	DBT_SavedOptions = {
		["DBM"] = {
		["EndColorG"] = 0,
		["HugeTimerY"] = -236.8703765869141,
		["HugeBarXOffset"] = 0,
		["Scale"] = 1,
		["IconLeft"] = true,
		["StartColorR"] = 1,
		["HugeWidth"] = 272,
		["BarYOffset"] = 5,
		["IconRight"] = false,
		["Texture"] = "Interface\\Buttons\\WHITE8x8",
		["ClickThrough"] = true,
		["ExpandUpwards"] = true,
		["TimerPoint"] = "BOTTOMRIGHT",
		["StartColorG"] = 0.7019607843137254,
		["HugeBarYOffset"] = 0,
		["HugeTimerX"] = 11.00008201599121,
		["EndColorR"] = 1,
		["Width"] = 186,
		["HugeTimerPoint"] = "CENTER",
		["FontSize"] = 13,
		["HugeScale"] = 1,
		["TimerX"] = -94.99992370605469,
		["StartColorB"] = 0,
		["TimerY"] = 163.7758026123047,
		["BarXOffset"] = 0,
		["EndColorB"] = 0,
	},
}
end
SLASH_SETDBM1 = "/setdbm"
SlashCmdList["SETDBM"] = function() SetDBM() ReloadUI() end