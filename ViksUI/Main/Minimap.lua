local T, Viks, L, _ = unpack(select(2, ...))
--[[
--ViksMiniMap, Must be used with ViksUI!
-- Based on qMap and using Picomenu
--]]
if Viks.minimapp.enable then

----------------------------------------------
-- Config
----------------------------------------------

mult = T.mult


-- Minimap
position = "CENTER"        -- Initial Position

--Setup Size and position
Minimap:SetFrameLevel(4)
Minimap:ClearAllPoints()
Minimap:SetPoint(position, AnchorMinimap, -3, 0)
Minimap:SetHeight(Viks.minimapp.size -4)
Minimap:SetWidth(Viks.minimapp.size -4)
--Creating the Borders
	BorderFrame = CreateFrame("Frame", nil, Minimap) --Helpframe
	BorderFrame:SetFrameLevel(2)
	frame1px1_1(BorderFrame) --Style funktion from core.lua
	--CreateShadow(BorderFrame) --Style funktion from core.lua
	
local dummy = function() end
local _G = getfenv(0)
-----------------------------------------------------------
----PLACING / HIDING STUFF
-----------------------------------------------------------
	-- Hide Calendar Button
	GameTimeFrame:Hide()
	MinimapCluster:EnableMouse(false)
	-- Hide Border
	MinimapBorder:Hide()
	MinimapBorderTop:Hide()
	-- Hide Zoom Buttons
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
	-- Hide Voice Chat Frame
	MiniMapVoiceChatFrame:Hide()
	-- Hide North texture at top
	MinimapNorthTag:SetTexture(nil)
	-- Hide Zone Frame
	MinimapZoneTextButton:Hide()
	-- Hide world map button
	MiniMapWorldMapButton:Hide()
	--Tracking
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetParent(Minimap)
	MiniMapTracking:SetPoint('TOPLEFT', 0, -25)
	MiniMapTracking:SetAlpha(0)
	MiniMapTrackingBackground:Hide()
	MiniMapTrackingButtonBorder:SetTexture(nil)
	MiniMapTrackingButton:SetHighlightTexture(nil)
	MiniMapTrackingIconOverlay:SetTexture(nil)
	MiniMapTrackingIcon:SetTexCoord(0.065, 0.935, 0.065, 0.935)
	MiniMapTrackingIcon:SetWidth(20)
	MiniMapTrackingIcon:SetHeight(20)

local function StripTextures(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Hide()
			else
				region:SetTexture(nil)
			end
		end
	end		
end

-- Queue Button and Tooltip
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", 0, 0)
QueueStatusMinimapButtonBorder:Hide()
--StripTextures(QueueStatusFrame)
CreateShadow(QueueStatusFrame)

--LFG icon
local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, 0)
	--MiniMapLFGFrameBorder:Hide()
end

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, 0, 0)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailIcon:SetTexture("Interface\\AddOns\\ViksUI\\media\\Other\\mail.tga")
MiniMapMailBorder:Hide()

MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, 0, 0)
MiniMapInstanceDifficulty:SetFrameStrata("HIGH")
--Hide Instance Difficulty flag
--MiniMapInstanceDifficulty:ClearAllPoints()
--MiniMapInstanceDifficulty:Hide()

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, 0, 0)
GuildInstanceDifficulty:SetScale(0.75)

if Viks.minimapp.Picomenu then
----------------------------------------------------------------------------------------
-- Picomenu: MainMenuBar replacement by Neal, butchered by Qupe 
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {
        text = MAINMENU_BUTTON,
        isTitle = true,
        notCheckable = true,
    },
    {
        text = CHARACTER_BUTTON,
        icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        func = function() 
            securecall(ToggleCharacter, 'PaperDollFrame') 
        end,
                tooltipTitle = 'MOOO',
        notCheckable = true,
    },
    {
        text = SPELLBOOK_ABILITIES_BUTTON,
        icon = 'Interface\\MINIMAP\\TRACKING\\Class',
        func = function() 
            securecall(ToggleSpellBook, BOOKTYPE_SPELL)
        end,
        notCheckable = true,
    },
    {
        text = TALENTS_BUTTON,
        icon = 'Interface\\MINIMAP\\TRACKING\\Ammunition',
        -- icon = 'Interface\\AddOns\\qusemap\\picomenu\\picomenuTalents',
        func = function() 
			if (not PlayerTalentFrame) then 
                LoadAddOn('Blizzard_TalentUI') 
            end

			if (not GlyphFrame) then 
                LoadAddOn('Blizzard_GlyphUI') 
            end 

			PlayerTalentFrame_Toggle()
        end,
        notCheckable = true,
    },
    {
        text = ACHIEVEMENT_BUTTON,
        icon = 'Interface\\AddOns\\ViksUI\\Media\\picomenuAchievement',
        func = function() 
            securecall(ToggleAchievementFrame) 
        end,
        notCheckable = true,
    },
    {
        text = QUESTLOG_BUTTON,
        icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        func = function() 
            securecall(ToggleFrame, QuestLogFrame) 
        end,
        notCheckable = true,
    },
    {
        text = GUILD,
        icon = 'Interface\\GossipFrame\\TabardGossipIcon',
        arg1 = IsInGuild('player'),
        func = function() 
            ToggleGuildFrame()
        end,
        notCheckable = true,
    },
    {
        text = SOCIAL_BUTTON,
        icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet',
        func = function() 
            securecall(ToggleFriendsFrame, 1) 
        end,
        notCheckable = true,
    },
    {
        text = PLAYER_V_PLAYER,
        icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
        func = function() 
		if T.level >= SHOW_PVP_LEVEL then
			if not PVPUIFrame then
				PVP_LoadUI()
			end
			PVPUIFrame_ShowFrame()
		else
			if Viks.error.white == false then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL).."|r")
			end
		end
        end,
        notCheckable = true,
    },
    {
        text = DUNGEONS_BUTTON,
        icon = 'Interface\\MINIMAP\\TRACKING\\None',
        func = function() 
            securecall(ToggleLFDParentFrame)
        end,
        notCheckable = true,
    },
    {
        text = MOUNTS_AND_PETS,
        icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',
        func = function() 
            securecall(TogglePetJournal)
        end,
        notCheckable = true,
    },
    {
        text = RAID,
        icon = 'Interface\\TARGETINGFRAME\\UI-TargetingFrame-Skull',
        func = function() 
            securecall(ToggleFriendsFrame, 4)
        end,
        notCheckable = true,
    },
	{
		text = LOOKING_FOR_RAID, notCheckable = 1, func = function()
                ToggleRaidFrame()
        end
	},
    {
        text = ENCOUNTER_JOURNAL,
        icon = 'Interface\\MINIMAP\\TRACKING\\Profession',
        func = function() 
            securecall(ToggleEncounterJournal)
        end,
        notCheckable = true,
    },
    {
        text = GM_EMAIL_NAME,
        icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz',
        func = function() 
            securecall(ToggleHelpFrame) 
        end,
        notCheckable = true,
    },
    {
        text = BATTLEFIELD_MINIMAP,
        colorCode = '|cff999999',
        func = function() 
            securecall(ToggleBattlefieldMinimap) 
        end,
        notCheckable = true,
    },
	{
		text = LOOT_ROLLS, notCheckable = true, func = function()
		ToggleFrame(LootHistoryFrame)
	end},
	{
		text = BLIZZARD_STORE, notCheckable = true, func = function()
		StoreMicroButton:Click()
	end},
}


local f = CreateFrame('Button', nil, PicoMenuBar)
f:SetFrameStrata('MEDIUM')
f:SetToplevel(true)
f:SetSize(11,8)
f:SetPoint('BOTTOMLEFT', Minimap, 'BOTTOMLEFT', -.5,2)
f:RegisterForClicks('Anyup')
f:RegisterEvent('ADDON_LOADED')

f:SetNormalTexture('Interface\\AddOns\\ViksUI\\Media\\picomenuNormal')
f:GetNormalTexture():SetSize(11,8)

f:SetHighlightTexture('Interface\\AddOns\\ViksUI\\Media\\picomenuHighlight')
f:GetHighlightTexture():SetAllPoints(f:GetNormalTexture())

f:SetScript('OnMouseDown', function(self)
    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetPoint('CENTER', 1, -1)
end)

f:SetScript('OnMouseUp', function(self, button)
    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetPoint('CENTER')

    if (button == 'LeftButton') then
        if (self:IsMouseOver()) then
            if (DropDownList1:IsShown()) then
                DropDownList1:Hide()
            else
                securecall(EasyMenu, menuList, menuFrame, self, -150, 50, 'MENU', 8)
                -- DropDownList1:ClearAllPoints()
                -- DropDownList1:SetPoint('BOTTOMLEFT', self, 'TOPRIGHT')
            end
        end
    else
        if (self:IsMouseOver()) then
            ToggleFrame(GameMenuFrame)
        end
    end

    GameTooltip:Hide()
end)

f:SetScript('OnEnter', function(self) 
    GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 25, -5)
    GameTooltip:AddLine(MAINMENU_BUTTON)
    GameTooltip:Show()
end)

f:SetScript('OnLeave', function() 
    GameTooltip:Hide()
end)


HelpOpenTicketButton:ClearAllPoints()
HelpOpenTicketButton:SetPoint('TOPLEFT', f, 'BOTTOMRIGHT', -26, 26)
HelpOpenTicketButton:SetScale(0.6)
HelpOpenTicketButton:SetParent(f)
end
----------------------------------------------------------------------------------------
-- Right click menu 
----------------------------------------------------------------------------------------
Minimap:SetScript('OnMouseUp', function(self, button)
Minimap:StopMovingOrSizing()
    if (button == 'RightButton') then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
    elseif (button == 'MiddleButton') then
        ToggleCalendar()
    else
        Minimap_OnClick(self)
    end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground');			--Make the Minimap a Square
function GetMinimapShape() return "SQUARE" end

--[[ Clock ]]
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = dummy
	object:Hide()
end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont("Fonts\\FRIZQT__.ttf", 10, "OUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -1)
clockTime:Hide()
TimeManagerClockButton:Hide()
----------------------------------------------------------------------------------------------------------------------------------------
if Viks.minimapp.compass then
function compass()

		frameC = CreateFrame("Frame", "Compass", Minimap)
		frameC:SetAllPoints()
		local north = frameC:CreateFontString(frameC:GetName())
		north:SetPoint("TOP", Minimap, "TOP", 0, -2)
		north:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",12,"OUTLINE")
		north:SetTextColor(1,1,0,1) 
		north:SetText("N")

		local east = frameC:CreateFontString(frameC:GetName())
		east:SetPoint("RIGHT", Minimap, "RIGHT", -2, 0)
		east:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",10,"OUTLINE")
		east:SetTextColor(1,1,.251,1) 
		east:SetText("E")

		local south = frameC:CreateFontString(frameC:GetName())
		south:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 2)
		south:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",10,"OUTLINE")
		south:SetTextColor(1,1,.251,1) 
		south:SetText("S")

		local west = frameC:CreateFontString(frameC:GetName())
		west:SetPoint("LEFT", Minimap, "LEFT", 4, 0)
		west:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",10,"OUTLINE")
		west:SetTextColor(1,1,.251,1) 
		west:SetText("W")
end
compass()
end
----------------------------------------------------------------------------------------
-- Style Zone and Coord panels for Minimap
----------------------------------------------------------------------------------------

local m_zone = CreateFrame("Frame",nil,UIParent)
CreatePanel(m_zone, 0, 16, "TOPLEFT", Minimap, "TOPLEFT", 2,-2)
m_zone:SetFrameLevel(5)
m_zone:SetFrameStrata("LOW")
CreateShadow(m_zone)
m_zone:SetPoint("TOPRIGHT",Minimap,-2,4)
m_zone:SetBackdropColor(unpack(Viks.media.backdropcolor))
m_zone:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
m_zone:Hide()

local m_zone_text = m_zone:CreateFontString(nil,"Overlay")
m_zone_text:SetFont(Viks.media.font,10,"OUTLINE")
m_zone_text:SetPoint("Center",0,0)
m_zone_text:SetJustifyH("CENTER")
m_zone_text:SetJustifyV("MIDDLE")
m_zone_text:SetHeight(10)

local m_coord = CreateFrame("Frame",nil,UIParent)
CreatePanel(m_coord, 36, 16, "BOTTOM", Minimap, "BOTTOM",0,-40)
m_coord:SetFrameStrata("LOW")
CreateShadow(m_coord)
m_coord:SetBackdropColor(unpack(Viks.media.backdropcolor))
m_coord:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
m_coord:Hide()	

local m_coord_text = m_coord:CreateFontString(nil,"Overlay")
m_coord_text:SetFont(Viks.media.font,10,"OUTLINE")
m_coord_text:SetPoint("Center",2,0)
m_coord_text:SetJustifyH("CENTER")
m_coord_text:SetJustifyV("MIDDLE")
 
Minimap:SetScript("OnEnter",function()	
	m_coord:Show()
	m_zone:Show()
end)
 
Minimap:SetScript("OnLeave",function()
	m_coord:Hide()
	m_zone:Hide()
end)
m_coord_text:SetText("00,00")
local ela = 0
local coord_Update = function(self,t)
	local inInstance, _ = IsInInstance()
	ela = ela - t
	if ela > 0 then return end
	local x,y = GetPlayerMapPosition("player")
	local xt,yt
	x = math.floor(100 * x)
	y = math.floor(100 * y)
	if x == 0 and y == 0 and not inInstance then
		SetMapToCurrentZone()
	elseif x ==0 and y==0 then
		m_coord_text:SetText(" ")	
	else
		if x < 10 then
			xt = "0"..x
		else
			xt = x
		end
		if y < 10 then
			yt = "0"..y
		else
			yt = y
		end
		m_coord_text:SetText(xt..",|r"..yt)
	end
	ela = .2
end
m_coord:SetScript("OnUpdate",coord_Update)
local zone_Update = function()
	local pvpType = GetZonePVPInfo()
	m_zone_text:SetText(strsub(GetMinimapZoneText(),1,23))
	if pvpType == "arena" then
		m_zone_text:SetTextColor(0.84, 0.03, 0.03)
	elseif pvpType == "friendly" then
		m_zone_text:SetTextColor(0.05, 0.85, 0.03)
	elseif pvpType == "contested" then
		m_zone_text:SetTextColor(0.9, 0.85, 0.05)
	elseif pvpType == "hostile" then 
		m_zone_text:SetTextColor(0.84, 0.03, 0.03)
	elseif pvpType == "sanctuary" then
		m_zone_text:SetTextColor(0.0352941, 0.58823529, 0.84705882)
	elseif pvpType == "combat" then
		m_zone_text:SetTextColor(0.84, 0.03, 0.03)
	else
		m_zone_text:SetTextColor(0.84, 0.03, 0.03)
	end
end
m_zone:RegisterEvent("PLAYER_ENTERING_WORLD")
m_zone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
m_zone:RegisterEvent("ZONE_CHANGED")
m_zone:RegisterEvent("ZONE_CHANGED_INDOORS")
m_zone:SetScript("OnEvent",zone_Update) 
local a,k = CreateFrame("Frame"),4
a:SetScript("OnUpdate",function(self,t)
	k = k - t
	if k > 0 then return end
	self:Hide()
	zone_Update()
end)
do
	SetFontString = function(parent, fontName, fontHeight, fontStyle)
		local fs = parent:CreateFontString(nil, "OVERLAY")
		fs:SetFont(Viks.media.font, fontHeight, fontStyle)
		fs:SetJustifyH("LEFT")
		fs:SetShadowColor(0, 0, 0)
		fs:SetShadowOffset(1.25, -1.25)
		return fs
	end
end	
end