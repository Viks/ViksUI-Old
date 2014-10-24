﻿local T, Viks, L, _ = unpack(select(2, ...))
if Viks.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Style chat frame(by Tukz and p3lim)
----------------------------------------------------------------------------------------
local origs = {}

local function Strip(info, name)
	return string.format("|Hplayer:%s|h[%s]|h", info, name:gsub("%-[^|]+", ""))
end
-- Function to rename channel and other stuff
local AddMessage = function(self, text, ...)
	if type(text) == "string" then
		text = text:gsub("|h%[(%d+)%. .-%]|h", "|h[%1]|h")
		text = text:gsub("|Hplayer:(.-)|h%[(.-)%]|h", Strip)
	end
	return origs[self](self, text, ...)
end

local format = string.format
local gsub = string.gsub
local sub = string.sub
local find = string.find
local len = string.len


local smileyPack = {
	['exclamation'] = [[Interface\AddOns\ViksUI\Media\smileys\!.blp]], -- ["%:!"] = "exclamation",
	['Angry'] = [[Interface\AddOns\ViksUI\Media\smileys\angry.blp]],
	['BrokenHeart'] = [[Interface\AddOns\ViksUI\Media\smileys\brokenheart.blp]],
	['Cool'] = [[Interface\AddOns\ViksUI\Media\smileys\cool.blp]], --- ["%B|"] = "Cool",
	['EEK'] = [[Interface\AddOns\ViksUI\Media\smileys\eek.blp]], --- ["%:eek"] = "EEK",
	['Embarrassment'] = [[Interface\AddOns\ViksUI\Media\smileys\embarrassment.blp]], --- ["%:$"] = "Embarrassment",
	['Gasp'] = [[Interface\AddOns\ViksUI\Media\smileys\gasp.blp]], --- ["%:o"] = "Gasp",
	['Glasses'] = [[Interface\AddOns\ViksUI\Media\smileys\glasses.blp]], --- ["%B)"] = "Glasses",
	['Grin'] = [[Interface\AddOns\ViksUI\Media\smileys\grin.blp]],
	['Grumpy'] = [[Interface\AddOns\ViksUI\Media\smileys\grumpy.blp]], --- ["%>:("] = "Grumpy",
	--['Kiss'] = [[Interface\AddOns\ViksUI\Media\smileys\kiss.blp]], --- ["%:*"] = "Kiss",
	['Like'] = [[Interface\AddOns\ViksUI\Media\smileys\like.blp]], --- ["%(y)"] = "Like",
	--['LOL'] = [[Interface\AddOns\ViksUI\Media\smileys\lol.blp]], --- ["%lol"] = "LOL",
	--['ROFL'] = [[Interface\AddOns\ViksUI\Media\smileys\rofl.blp]], --- ["%rofl"] = "ROFL",
	['Hmm'] = [[Interface\AddOns\ViksUI\Media\smileys\unsure.blp]],
	['MiddleFinger'] = [[Interface\AddOns\ViksUI\Media\smileys\MiddleFinger.blp]],
	['Sad'] = [[Interface\AddOns\ViksUI\Media\smileys\sad.blp]],
	['Surprise'] = [[Interface\AddOns\ViksUI\Media\smileys\Surprise.blp]],
	['Tongue'] = [[Interface\AddOns\ViksUI\Media\smileys\tongue.blp]],
	['Cry'] = [[Interface\AddOns\ViksUI\Media\smileys\cry.blp]],
	['Wink'] = [[Interface\AddOns\ViksUI\Media\smileys\wink.blp]],
	['Happy'] = [[Interface\AddOns\ViksUI\Media\smileys\happy.blp]],
	['Heart'] = [[Interface\AddOns\ViksUI\Media\smileys\heart.blp]],
}

local smileyKeys = {
	--["%:!"] = "exclamation",
	--["%:%eek"] = "EEK",
	--["%:%$"] = "Embarrassment",
	--["%B)"] = "Glasses",
	--["%>%:%("] = "Grumpy",
	--["%:%*"] = "Kiss",
	--["%:y"] = "Like",
	--["%:lol"] = "LOL",
	--["%:rofl"] = "ROFL",
	["%:%-%@"] = "Angry",
	["%:%@"] = "Angry",
	["%:%-%)"] = "Happy",
	["%:%)"] = "Happy",
	["%:D"] = "Grin",
	["%:%-D"] = "Grin",
	["%;%-D"] = "Grin",
	["%;D"] = "Grin",
	["%=D"] = "Grin",
	["xD"] = "Grin",
	["XD"] = "Grin",
	["%:%-%("] = "Sad",
	["%:%("] = "Sad",
	["%:o"] = "Gasp",
	["%:%-o"] = "Surprise",
	["%:%-O"] = "Surprise",
	["%:O"] = "Gasp",
	["%:%-0"] = "Surprise",
	["%:P"] = "Tongue",
	["%:%-P"] = "Tongue",
	["%:p"] = "Tongue",
	["%:%-p"] = "Tongue",
	["%=P"] = "Tongue",
	["%=p"] = "Tongue",
	["%;%-p"] = "Tongue",
	["%;p"] = "Tongue",
	["%;P"] = "Tongue",
	["%;%-P"] = "Tongue",
	["%;%-%)"] = "Wink",
	["%;%)"] = "Wink",
	["%:S"] = "Hmm",
	["%:%-S"] = "Hmm",
	["%:%,%("] = "Cry",
	["%:%,%-%("] = "Cry",
	["%:%'%("] = "Cry",
	["%:%'%-%("] = "Cry",
	["%:%F"] = "MiddleFinger",
	["<3"] = "Heart",
	["</3"] = "BrokenHeart",
}

local function InsertEmotions( msg )
	for k, v in pairs( smileyKeys ) do
		msg = gsub( msg, k, '|T' .. smileyPack[v] .. ':16|t' )
	end

	return msg
end

local function GetSmileyReplacementText( msg )
	if( not msg ) then
		return
	end

	if not (Viks.chat.smileys or msg:find( '/run' ) or msg:find( '/dump' ) or msg:find( '/script' ) ) then
		return msg
	end

	local outstr = ''
	local origlen = len( msg )
	local startpos = 1
	local endpos

	while( startpos <= origlen ) do
		endpos = origlen

		local pos = find( msg, '|H', startpos, true )
		if( pos ~= nil ) then
			endpos = pos
		end

		outstr = outstr .. InsertEmotions( sub( msg, startpos, endpos ) )
		startpos = endpos + 1

		if( pos ~= nil ) then
			endpos = find( msg, '|h]|r', startpos, -1 ) or find( msg, '|h', startpos, -1 )
			endpos = endpos or origlen

			if( startpos < endpos ) then
				outstr = outstr .. sub( msg, startpos, endpos )
				startpos = endpos + 1
			end
		end
	end

	return outstr
end

local function AddMessage( Frame, String, ... )
	local Smilies = true
	local MessageString

	String = String:gsub( '|Hplayer:(.-)|h%[(.-)%]|h', '|Hplayer:%1|h%2|h' )
	String = String:gsub( '|HBNplayer:(.-)|h%[(.-)%]|h', '|HBNplayer:%1|h%2|h' )
	String = String:gsub( '^To (.-|h)', '|cffad2424@|r%1' )
	String = String:gsub( '^(.-|h) whispers', '%1' )
	String = String:gsub( '^(.-|h) says', '%1' )
	String = String:gsub( '^(.-|h) yells', '%1' )
	String = String:gsub( '<' .. AFK .. '>', "AFK" )
	String = String:gsub( '<' .. DND .. '>', "DND" )
	String = String:gsub( '^%[' .. RAID_WARNING .. '%]', "Raid Warning" )

	if( Smilies ) then
		MessageString = origs[Frame]( Frame, GetSmileyReplacementText( String ), ... )
	else
		MessageString = origs[Frame]( Frame, String, ... )
	end

	return MessageString
end

-- Global strings
_G.CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h["..L_CHAT_INSTANCE_CHAT.."]|h %s:\32"
_G.CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h["..L_CHAT_INSTANCE_CHAT_LEADER.."]|h %s:\32"
_G.CHAT_BN_WHISPER_GET = L_CHAT_BN_WHISPER.." %s:\32"
_G.CHAT_GUILD_GET = "|Hchannel:GUILD|h["..L_CHAT_GUILD.."]|h %s:\32"
_G.CHAT_OFFICER_GET = "|Hchannel:OFFICER|h["..L_CHAT_OFFICER.."]|h %s:\32"
_G.CHAT_PARTY_GET = "|Hchannel:PARTY|h["..L_CHAT_PARTY.."]|h %s:\32"
_G.CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h["..L_CHAT_PARTY_LEADER.."]|h %s:\32"
_G.CHAT_PARTY_GUIDE_GET = CHAT_PARTY_LEADER_GET
_G.CHAT_RAID_GET = "|Hchannel:RAID|h["..L_CHAT_RAID.."]|h %s:\32"
_G.CHAT_RAID_LEADER_GET = "|Hchannel:RAID|h["..L_CHAT_RAID_LEADER.."]|h %s:\32"
_G.CHAT_RAID_WARNING_GET = "["..L_CHAT_RAID_WARNING.."] %s:\32"
_G.CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h["..L_CHAT_PET_BATTLE.."]|h:\32"
_G.CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h["..L_CHAT_PET_BATTLE.."]|h:\32"
_G.CHAT_SAY_GET = "%s:\32"
_G.CHAT_WHISPER_GET = L_CHAT_WHISPER.." %s:\32"
_G.CHAT_YELL_GET = "%s:\32"
_G.CHAT_FLAG_AFK = "|cffE7E716"..L_CHAT_AFK.."|r "
_G.CHAT_FLAG_DND = "|cffFF0000"..L_CHAT_DND.."|r "
_G.CHAT_FLAG_GM = "|cff4154F5"..L_CHAT_GM.."|r "
_G.ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h "..L_CHAT_COME_ONLINE
_G.ERR_FRIEND_OFFLINE_S = "[%s] "..L_CHAT_GONE_OFFLINE

-- Hide friends micro button
FriendsMicroButton:Kill()

-- Hide chat bubble menu button
ChatFrameMenuButton:Kill()

-- Set chat style
local function SetChatStyle(frame)
	local id = frame:GetID()
	local chat = frame:GetName()

	-- Removes crap from the bottom of the chatbox so it can go to the bottom of the screen
	_G[chat]:SetClampedToScreen(false)

	-- Stop the chat chat from fading out
	_G[chat]:SetFading(false)

	-- Move the chat edit box
	_G[chat.."EditBox"]:ClearAllPoints()
	_G[chat.."EditBox"]:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", -10, 23)
	_G[chat.."EditBox"]:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 11, 23)

	-- Hide textures
	for j = 1, #CHAT_FRAME_TEXTURES do
		_G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
	end

	-- Removes Default ChatFrame Tabs texture
	_G[format("ChatFrame%sTabLeft", id)]:Kill()
	_G[format("ChatFrame%sTabMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabRight", id)]:Kill()

	_G[format("ChatFrame%sTabSelectedLeft", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", id)]:Kill()

	_G[format("ChatFrame%sTabHighlightLeft", id)]:Kill()
	_G[format("ChatFrame%sTabHighlightMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabHighlightRight", id)]:Kill()

	-- Killing off the new chat tab selected feature
	_G[format("ChatFrame%sTabSelectedLeft", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", id)]:Kill()

	-- Kills off the new method of handling the Chat Frame scroll buttons as well as the resize button
	-- Note: This also needs to include the actual frame textures for the ButtonFrame onHover
	_G[format("ChatFrame%sButtonFrameUpButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrameDownButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrameBottomButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrameMinimizeButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrame", id)]:Kill()

	-- Kills off the retarded new circle around the editbox
	_G[format("ChatFrame%sEditBoxFocusLeft", id)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusMid", id)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusRight", id)]:Kill()

	_G[format("ChatFrame%sTabGlow", id)]:Kill()

	-- Kill off editbox artwork
	local a, b, c = select(6, _G[chat.."EditBox"]:GetRegions()) a:Kill() b:Kill() c:Kill()

	-- Kill bubble tex/glow
	if _G[chat.."Tab"].conversationIcon then _G[chat.."Tab"].conversationIcon:Kill() end

	-- Disable alt key usage
	_G[chat.."EditBox"]:SetAltArrowKeyMode(false)

	-- Hide editbox on login
	_G[chat.."EditBox"]:Hide()

	-- Script to hide editbox instead of fading editbox to 0.35 alpha via IM Style
	_G[chat.."EditBox"]:HookScript("OnEditFocusGained", function(self) self:Show() end)
	_G[chat.."EditBox"]:HookScript("OnEditFocusLost", function(self) self:Hide() end)

	-- Hide edit box every time we click on a tab
	_G[chat.."Tab"]:HookScript("OnClick", function() _G[chat.."EditBox"]:Hide() end)

	-- Create our own texture for edit box
	if Viks.chat.background == true and Viks.chat.tabs_mouseover ~= true then
		local EditBoxBackground = CreateFrame("Frame", "ChatEditBoxBackground", _G[chat.."EditBox"])
		EditBoxBackground:CreatePanel("Transparent", 1, 1, "LEFT", _G[chat.."EditBox"], "LEFT", 0, 0)
		EditBoxBackground:ClearAllPoints()
		EditBoxBackground:SetPoint("TOPLEFT", _G[chat.."EditBox"], "TOPLEFT", 7, -5)
		EditBoxBackground:SetPoint("BOTTOMRIGHT", _G[chat.."EditBox"], "BOTTOMRIGHT", -7, 4)
		EditBoxBackground:SetFrameStrata("LOW")
		EditBoxBackground:SetFrameLevel(1)

		local function colorize(r, g, b)
			EditBoxBackground:SetBackdropBorderColor(r, g, b)
		end

		-- Update border color according where we talk
		hooksecurefunc("ChatEdit_UpdateHeader", function()
			local type = _G[chat.."EditBox"]:GetAttribute("chatType")
			if type == "CHANNEL" then
				local id = GetChannelName(_G[chat.."EditBox"]:GetAttribute("channelTarget"))
				if id == 0 then
					colorize(unpack(Viks.media.bordercolor))
				else
					colorize(ChatTypeInfo[type..id].r, ChatTypeInfo[type..id].g, ChatTypeInfo[type..id].b)
				end
			else
				colorize(ChatTypeInfo[type].r, ChatTypeInfo[type].g, ChatTypeInfo[type].b)
			end
		end)
	end

	-- Rename combat log tab
	if _G[chat] == _G["ChatFrame2"] then
		FCF_SetWindowName(_G[chat], GUILD_BANK_LOG)
		CombatLogQuickButtonFrame_Custom:StripTextures()
		CombatLogQuickButtonFrame_Custom:CreateBackdrop("Transparent")
		CombatLogQuickButtonFrame_Custom.backdrop:SetPoint("TOPLEFT", 1, -4)
		CombatLogQuickButtonFrame_Custom.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		T.SkinCloseButton(CombatLogQuickButtonFrame_CustomAdditionalFilterButton, CombatLogQuickButtonFrame_Custom.backdrop, " ", true)
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton:SetSize(12, 12)
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton:SetHitRectInsets (0, 0, 0, 0)
		CombatLogQuickButtonFrame_CustomProgressBar:ClearAllPoints()
		CombatLogQuickButtonFrame_CustomProgressBar:SetPoint("TOPLEFT", CombatLogQuickButtonFrame_Custom.backdrop, 2, -2)
		CombatLogQuickButtonFrame_CustomProgressBar:SetPoint("BOTTOMRIGHT", CombatLogQuickButtonFrame_Custom.backdrop, -2, 2)
		CombatLogQuickButtonFrame_CustomProgressBar:SetStatusBarTexture(Viks.media.texture)
		CombatLogQuickButtonFrameButton1:SetPoint("BOTTOM", 0, 0)
	end

	if _G[chat] ~= _G["ChatFrame2"] then
		origs[_G[chat]] = _G[chat].AddMessage
		_G[chat].AddMessage = AddMessage
		-- Custom timestamps color
		_G.TIMESTAMP_FORMAT_HHMM = T.RGBToHex(unpack(Viks.chat.time_color)).."[%I:%M]|r "
		_G.TIMESTAMP_FORMAT_HHMMSS = T.RGBToHex(unpack(Viks.chat.time_color)).."[%I:%M:%S]|r "
		_G.TIMESTAMP_FORMAT_HHMMSS_24HR = T.RGBToHex(unpack(Viks.chat.time_color)).."[%H:%M:%S]|r "
		_G.TIMESTAMP_FORMAT_HHMMSS_AMPM = T.RGBToHex(unpack(Viks.chat.time_color)).."[%I:%M:%S %p]|r "
		_G.TIMESTAMP_FORMAT_HHMM_24HR = T.RGBToHex(unpack(Viks.chat.time_color)).."[%H:%M]|r "
		_G.TIMESTAMP_FORMAT_HHMM_AMPM = T.RGBToHex(unpack(Viks.chat.time_color)).."[%I:%M %p]|r "
	end

	frame.skinned = true
end

-- Setup chatframes 1 to 10 on login
local function SetupChat(self)
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		SetChatStyle(frame)
	end

	-- Remember last channel
	local var
	if Viks.chat.sticky == true then
		var = 1
	else
		var = 0
	end
	ChatTypeInfo.SAY.sticky = var
	ChatTypeInfo.PARTY.sticky = var
	ChatTypeInfo.PARTY_LEADER.sticky = var
	ChatTypeInfo.GUILD.sticky = var
	ChatTypeInfo.OFFICER.sticky = var
	ChatTypeInfo.RAID.sticky = var
	ChatTypeInfo.RAID_WARNING.sticky = var
	ChatTypeInfo.INSTANCE_CHAT.sticky = var
	ChatTypeInfo.INSTANCE_CHAT_LEADER.sticky = var
	ChatTypeInfo.WHISPER.sticky = var
	ChatTypeInfo.BN_WHISPER.sticky = var
	ChatTypeInfo.CHANNEL.sticky = var
end

local function SetupChatPosAndFont(self)
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G[format("ChatFrame%s", i)]
		local id = chat:GetID()
		local _, fontSize = FCF_GetChatWindowInfo(id)
		ChatFrame1:SetFrameLevel(LChat:GetFrameLevel()+2)    --//Force correct strata. Quick Fix for text hidden at start.

		-- Min. size for chat font
		if fontSize < 11 then
			FCF_SetChatWindowFontSize(nil, chat, 11)
		else
			FCF_SetChatWindowFontSize(nil, chat, fontSize)
		end

		-- Font and font style for chat
		chat:SetFont(Viks.font.chat_font, fontSize, Viks.font.chat_font_style)
		chat:SetShadowOffset(Viks.font.chat_font_shadow and 1 or 0, Viks.font.chat_font_shadow and -1 or 0)

		-- Force chat position
		if i == 1 then
			chat:ClearAllPoints()
			chat:SetSize(Viks.chat.width, Viks.chat.height)
			if Viks.chat.background == true then
				chat:SetPoint(Viks.position.chat[1], Viks.position.chat[2], Viks.position.chat[3], Viks.position.chat[4], Viks.position.chat[5] + 4)
			else
				chat:SetPoint(Viks.position.chat[1], Viks.position.chat[2], Viks.position.chat[3], Viks.position.chat[4], Viks.position.chat[5])
			end
			FCF_SavePositionAndDimensions(chat)
		elseif i == 2 then
			if Viks.chat.combatlog ~= true then
				FCF_DockFrame(chat)
				ChatFrame2Tab:EnableMouse(false)
				ChatFrame2Tab:SetText("LOG")
				ChatFrame2Tab:SetScale(0.001)
			end
		end
	end

	-- Reposition battle.net popup over chat #1
	BNToastFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint(unpack(Viks.position.bn_popup))
	end)
end

local UIChat = CreateFrame("Frame")
UIChat:RegisterEvent("ADDON_LOADED")
UIChat:RegisterEvent("PLAYER_ENTERING_WORLD")
UIChat:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "Blizzard_CombatLog" then
			self:UnregisterEvent("ADDON_LOADED")
			SetupChat(self)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		SetupChatPosAndFont(self)
	end
end)

-- Setup temp chat (BN, WHISPER) when needed
local function SetupTempChat()
	local frame = FCF_GetCurrentChatFrame()
	if frame.skinned then return end
	SetChatStyle(frame)
end
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

-- Disable pet battle tab
local old = FCFManager_GetNumDedicatedFrames
function FCFManager_GetNumDedicatedFrames(...)
	return select(1, ...) ~= "PET_BATTLE_COMBAT_LOG" and old(...) or 1
end

-- Remove player's realm name
local function RemoveRealmName(self, event, msg, author, ...)
	local realm = string.gsub(T.realm, " ", "")
	if msg:find("-" .. realm) then
		return false, gsub(msg, "%-"..realm, ""), author, ...
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", RemoveRealmName)
----------------------------------------------------------------------------------------
--	Save slash command typo
----------------------------------------------------------------------------------------
local function TypoHistory_Posthook_AddMessage(chat, text)
	if strfind(text, HELP_TEXT_SIMPLE) then
		ChatEdit_AddHistory(chat.editBox)
	end
end

for i = 1, NUM_CHAT_WINDOWS do
	if i ~= 2 then
		hooksecurefunc(_G["ChatFrame"..i], "AddMessage", TypoHistory_Posthook_AddMessage)
	end
end