local T, Viks, L, _ = unpack(select(2, ...))
local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
local lib = CreateFrame("Frame")

ns._Objects = {}
ns._Headers = {}

local colors = setmetatable({
    power = setmetatable({
        ['MANA'] = {.31,.45,.63},
    }, {__index = oUF.colors.power}),
}, {__index = oUF.colors})

function ns:hex(r, g, b)
    if(type(r) == 'table') then
        if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
    end
    return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
end
local fs = function(parent, layer, font, fontsiz, outline, r, g, b, justify)
    local string = parent:CreateFontString(nil, layer)
    string:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\pixelfont.ttf", 12)
    string:SetShadowOffset(1, 1)
    string:SetTextColor(r, g, b)
    if justify then
        string:SetJustifyH(justify)
    end
    return string
end

local PetBattleHider = CreateFrame("Frame", "ViksPetBattleHider", UIParent, "SecureHandlerStateTemplate");
PetBattleHider:SetAllPoints(UIParent)
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

--[[
local numpeeps --Number of people in the group.
local InBGFrame = CreateFrame("FRAME", "FooAddonFrame");
InBGFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");

local function eventHandler(self, event, ...)
	numpeeps = GetNumRaidMembers();
	if     (numpeeps == 0 ) then --Not in a raid
		local WidthRaid = Viks.raidframes.width-0;
		local HightRaid = Viks.raidframes.height-0;
	elseif (numpeeps <= 5 ) then --Regular group - large frames.
		local WidthRaid = Viks.raidframes.width-0;
		local HightRaid = Viks.raidframes.height-0;
	elseif (numpeeps <= 15) then --Small raid/BG - medium frames.
		local WidthRaid = Viks.raidframes.width/2;
		local HightRaid = Viks.raidframes.height;
	else                         --Large raid/BG - small frames.
		local WidthRaid = Viks.raidframes.width/3;
		local HightRaid = Viks.raidframes.height/2;
	end
end
InBGFrame:SetScript("OnEvent", eventHandler);
--]]


local function updateHealbar(object)
    object.myHealPredictionBar:ClearAllPoints()
    object.otherHealPredictionBar:ClearAllPoints()

    if Viks.raidframes.orientation == "VERTICAL" then
        object.myHealPredictionBar:SetPoint("BOTTOMLEFT", object.Health:GetStatusBarTexture(), "TOPLEFT", 0, 0)
        object.myHealPredictionBar:SetPoint("BOTTOMRIGHT", object.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.myHealPredictionBar:SetSize(0, Viks.raidframes.height)
        object.myHealPredictionBar:SetOrientation"VERTICAL"

        object.otherHealPredictionBar:SetPoint("BOTTOMLEFT", object.myHealPredictionBar:GetStatusBarTexture(), "TOPLEFT", 0, 0)
        object.otherHealPredictionBar:SetPoint("BOTTOMRIGHT", object.myHealPredictionBar:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.otherHealPredictionBar:SetSize(0, Viks.raidframes.height)
        object.otherHealPredictionBar:SetOrientation"VERTICAL"
    else
        object.myHealPredictionBar:SetPoint("TOPLEFT", object.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.myHealPredictionBar:SetPoint("BOTTOMLEFT", object.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
        object.myHealPredictionBar:SetSize(Viks.raidframes.width, 0)
        object.myHealPredictionBar:SetOrientation"HORIZONTAL"

        object.otherHealPredictionBar:SetPoint("TOPLEFT", object.myHealPredictionBar:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        object.otherHealPredictionBar:SetPoint("BOTTOMLEFT", object.myHealPredictionBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
        object.otherHealPredictionBar:SetSize(Viks.raidframes.width, 0)
        object.otherHealPredictionBar:SetOrientation"HORIZONTAL"
    end

    object.myHealPredictionBar:GetStatusBarTexture():SetTexture(unpack(Viks.raidframes.myhealcolor))
    object.otherHealPredictionBar:GetStatusBarTexture():SetTexture(unpack(Viks.raidframes.otherhealcolor))
end

-- Unit Menu
local dropdown = CreateFrame('Frame', ADDON_NAME .. 'DropDown', UIParent, 'UIDropDownMenuTemplate')

local function menu(self)
    dropdown:SetParent(self)
    return ToggleDropDownMenu(1, nil, dropdown, 'cursor', 0, 0)
end

local init = function(self)
    if Viks.raidframes.hidemenu and InCombatLockdown() then
        return
    end

    local unit = self:GetParent().unit
    local menu, name, id

    if(not unit) then
        return
    end

    if(UnitIsUnit(unit, "player")) then
        menu = "SELF"
    elseif(UnitIsUnit(unit, "vehicle")) then
        menu = "VEHICLE"
    elseif(UnitIsUnit(unit, "pet")) then
        menu = "PET"
    elseif(UnitIsPlayer(unit)) then
        id = UnitInRaid(unit)
        if(id) then
            menu = "RAID_PLAYER"
            name = GetRaidRosterInfo(id)
        elseif(UnitInParty(unit)) then
            menu = "PARTY"
        else
            menu = "PLAYER"
        end
    else
        menu = "TARGET"
        name = RAID_TARGET_ICON
    end

    if(menu) then
        UnitPopup_ShowMenu(self, menu, unit, name, id)
    end
end

UIDropDownMenu_Initialize(dropdown, init, 'MENU')

local backdrop = {
    bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
    insets = {top = 0, left = 0, bottom = 0, right = 0},
}

local border = {
    bgFile = [=[Interface\AddOns\ViksUI\Media\textures\white2.tga]=],
    insets = {top = -2, left = -2, bottom = -2, right = -2},
}

local border2 = {
    bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
    insets = {top = -1, left = -1, bottom = -1, right = -1},
}
-- Show Target Border
local ChangedTarget = function(self)
    if Viks.raidframes.tborder and UnitIsUnit('target', self.unit) then
        self.TargetBorder:Show()
    else
        self.TargetBorder:Hide()
    end
end

-- Show Focus Border
local FocusTarget = function(self)
    if Viks.raidframes.fborder and UnitIsUnit('focus', self.unit) then
        self.FocusHighlight:Show()
    else
        self.FocusHighlight:Hide()
    end
end

local updateThreat = function(self, event, unit)
    if(unit ~= self.unit) then return end

    local status = UnitThreatSituation(unit)

    if(status and status > 1) then
        local r, g, b = GetThreatStatusColor(status)
        self.Threat:SetBackdropBorderColor(r, g, b, 1)
        self.border:SetBackdropColor(r, g, b, 1)
    else
        self.Threat:SetBackdropBorderColor(0, 0, 0, 1)
        self.border:SetBackdropColor(0, 0, 0, 1)
    end
    self.Threat:Show()
end

ns.nameCache = {}
ns.colorCache = {}
ns.debuffColor = {} -- hex debuff colors for tags

local function utf8sub(str, start, numChars) 
    local currentIndex = start 
    while numChars > 0 and currentIndex <= #str do 
        local char = string.byte(str, currentIndex) 
        if char >= 240 then 
            currentIndex = currentIndex + 4 
        elseif char >= 225 then 
            currentIndex = currentIndex + 3 
        elseif char >= 192 then 
            currentIndex = currentIndex + 2 
        else 
            currentIndex = currentIndex + 1 
        end 
        numChars = numChars - 1 
    end 
    return str:sub(start, currentIndex - 1) 
end 

function ns:UpdateName(name, unit) 
    if(unit) then
        local _NAME = UnitName(unit)
        local _, class = UnitClass(unit)
        if not _NAME or not class then return end

        local substring
        for length=#_NAME, 1, -1 do
            substring = utf8sub(_NAME, 1, length)
            name:SetText(substring)

            if name:GetStringWidth() <= Viks.raidframes.width - 8 then name:SetText(nil); break end
			end


        local str = ns.colorCache[class]..substring
        ns.nameCache[_NAME] = str
        name:UpdateTag()
    end
end

local function PostHealth(hp, unit)
    local self = hp.__owner
    local name = UnitName(unit)

    if not ns.nameCache[name] then
        ns:UpdateName(self.Name, unit)
    end
		
    if Viks.raidframes.definecolors and hp.colorSmooth then
        hp.bg:SetVertexColor(unpack(Viks.raidframes.hpbgcolor))
        return
    end

    local suffix = self:GetAttribute'unitsuffix'
    if suffix == 'pet' or unit == 'vehicle' or unit == 'pet' then
        local r, g, b = .2, .9, .1
        hp:SetStatusBarColor(r*.2, g*.2, b*.2)
        hp.bg:SetVertexColor(r, g, b)
        return
    elseif Viks.raidframes.definecolors then
        hp.bg:SetVertexColor(unpack(Viks.raidframes.hpbgcolor))
        hp:SetStatusBarColor(unpack(Viks.raidframes.hpcolor))
        return 
    end

    local r, g, b, t
    if(UnitIsPlayer(unit)) then
        local _, class = UnitClass(unit)
        t = colors.class[class]
    else		
        r, g, b = .2, .9, .1
    end

    if(t) then
        r, g, b = t[1], t[2], t[3]
    end

    if(b) then
        if Viks.raidframes.reversecolors then
            hp.bg:SetVertexColor(r*.2, g*.2, b*.2)
            hp:SetStatusBarColor(r, g, b)
        else
            hp.bg:SetVertexColor(r, g, b)
            hp:SetStatusBarColor(0, 0, 0, .8)
        end
    end
end

function ns:UpdateHealth(hp)
    hp:SetStatusBarTexture(Viks.media.texture)
    hp:SetOrientation(Viks.raidframes.orientation)
    hp.bg:SetTexture(Viks.media.texture)
    hp.Smooth = true

    hp.colorSmooth = Viks.raidframes.colorSmooth
    hp.smoothGradient = { 
        unpack(Viks.raidframes.gradient),
        unpack(Viks.raidframes.hpcolor),
    }

    if not Viks.raidframes.powerbar then
        hp:SetHeight(Viks.raidframes.height)
        hp:SetWidth(Viks.raidframes.width)
    end

    hp:ClearAllPoints()
    hp:SetPoint"TOP"
    if Viks.raidframes.orientation == "VERTICAL" and Viks.raidframes.porientation == "VERTICAL" then
        hp:SetPoint"LEFT"
        hp:SetPoint"BOTTOM"
    elseif Viks.raidframes.orientation == "HORIZONTAL" and Viks.raidframes.porientation == "VERTICAL" then
        hp:SetPoint"RIGHT"
        hp:SetPoint"BOTTOM"
    else
        hp:SetPoint"LEFT"
        hp:SetPoint"RIGHT"
    end
end

local function PostPower(power, unit)
    local self = power.__owner
    local _, ptype = UnitPowerType(unit)
    local _, class = UnitClass(unit)

    if ptype == 'MANA' then
        power:Show()
        if(Viks.raidframes.porientation == "VERTICAL")then
            power:SetWidth(Viks.raidframes.width*Viks.raidframes.powerbarsize)
            self.Health:SetWidth((0.98 - Viks.raidframes.powerbarsize)*Viks.raidframes.width)
        else
            power:SetHeight(Viks.raidframes.height*Viks.raidframes.powerbarsize)
            self.Health:SetHeight((0.98 - Viks.raidframes.powerbarsize)*Viks.raidframes.height)
        end
    else
        power:Hide()
        if(Viks.raidframes.porientation == "VERTICAL")then
            self.Health:SetWidth(Viks.raidframes.width)
        else
            self.Health:SetHeight(Viks.raidframes.height)
        end
    end

    --local perc = oUF.tags.Methods['perpp'](unit)
    -- This kinda conflicts with the threat module, but I don't really care
    --if (perc < 10 and UnitIsConnected(unit) and ptype == 'MANA' and not UnitIsDeadOrGhost(unit)) then
        --self.Threat:SetBackdropBorderColor(0, 0, 1, 1)
        --self.border:SetBackdropColor(0, 0, 1, 1)
    --else
        -- pass the coloring back to the threat func
        updateThreat(self, nil, unit)
   -- end

    if Viks.raidframes.powerdefinecolors then
        power.bg:SetVertexColor(unpack(Viks.raidframes.powerbgcolor))
        power:SetStatusBarColor(unpack(Viks.raidframes.powercolor))
        return
    end

    local r, g, b, t
    t = Viks.raidframes.powerclass and colors.class[class] or colors.power[ptype]

    if(t) then
        r, g, b = t[1], t[2], t[3]
    else
        r, g, b = 1, 1, 1
    end

    if(b) then
        if Viks.raidframes.reversecolors or Viks.raidframes.powerclass then
            power.bg:SetVertexColor(r*.2, g*.2, b*.2)
            power:SetStatusBarColor(r, g, b)
        else
            power.bg:SetVertexColor(r, g, b)
            power:SetStatusBarColor(0, 0, 0, .8)
        end
    end
end

function ns:UpdatePower(power)
    if Viks.raidframes.powerbar then
        power:Show()
        power.PostUpdate = PostPower
    else
        power:Hide()
        power.PostUpdate = nil
        return
    end
    power:SetStatusBarTexture(Viks.media.texture)
    power:SetOrientation(Viks.raidframes.porientation)
    power.bg:SetTexture(Viks.media.texture)

    power:ClearAllPoints()
    if Viks.raidframes.orientation == "HORIZONTAL" and Viks.raidframes.porientation == "VERTICAL" then
        power:SetPoint"LEFT"
        power:SetPoint"TOP"
        power:SetPoint"BOTTOM"
    elseif Viks.raidframes.porientation == "VERTICAL" then
        power:SetPoint"TOP"
        power:SetPoint"RIGHT"
        power:SetPoint"BOTTOM"
    else
        power:SetPoint"LEFT"
        power:SetPoint"RIGHT"
        power:SetPoint"BOTTOM"
    end
end

-- Show Mouseover highlight
local OnEnter = function(self)
    if Viks.raidframes.tooltip then
        UnitFrame_OnEnter(self)
    else
        GameTooltip:Hide()
    end

    if Viks.raidframes.highlight then
        self.Highlight:Show()
    end
end

local OnLeave = function(self)
    if Viks.raidframes.tooltip then
        UnitFrame_OnLeave(self)
    end
    self.Highlight:Hide()
end

lib.focus = function(f)
    f:RegisterForClicks("AnyDown")
	local ModKey = 'alt-ctrl-shift'
    local MouseButton = 1
    local key = ModKey .. '-type' .. (MouseButton or '')
		f:SetAttribute(key, 'focus')
end

local style = function(self)
    self.menu = menu
	lib.focus(self)
	--self:SetParent(PetBattleHider) --\\Hide frames in Pet Battle

    -- Backdrop
    self.BG = CreateFrame("Frame", nil, self)
    self.BG:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.BG:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    self.BG:SetFrameLevel(3)
    self.BG:SetBackdrop(backdrop)
    self.BG:SetBackdropColor(0, 0, 0)

    self.border = CreateFrame("Frame", nil, self)
    self.border:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    self.border:SetFrameLevel(2)
    self.border:SetBackdrop(border2)
    self.border:SetBackdropColor(0, 0, 0)

    -- Mouseover script
    self:SetScript("OnEnter", OnEnter)
    self:SetScript("OnLeave", OnLeave)
    self:RegisterForClicks"AnyUp"

    -- Health
    self.Health = CreateFrame"StatusBar"
    self.Health:SetParent(self)
    self.Health.frequentUpdates = true

    self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
    self.Health.bg:SetAllPoints(self.Health)

    self.Health.PostUpdate = PostHealth
    ns:UpdateHealth(self.Health)

    -- Threat
    local threat = CreateFrame("Frame", nil, self)
    threat:SetPoint("TOPLEFT", self, "TOPLEFT", -5, 5)
    threat:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 5, -5)
    threat:SetFrameLevel(0)
	CreateShadow0(threat)
    threat:SetBackdropColor(0, 0, 0, 0)
    threat:SetBackdropBorderColor(0, 0, 0, 1)
    threat.Override = updateThreat
    self.Threat = threat

    -- Name
    local name = self.Health:CreateFontString(nil, "OVERLAY")
    name:SetPoint("CENTER")
    name:SetJustifyH("CENTER")
    name:SetFont(Viks.media.font, Viks.raidframes.fontsize, Viks.raidframes.outline)
    name:SetShadowOffset(1.25, -1.25)
    name:SetWidth(Viks.raidframes.width)
    name.overrideUnit = true
    self.Name = name
    self:Tag(self.Name, '[color][name]')

    ns:UpdateName(self.Name)

    -- Power
    self.Power = CreateFrame"StatusBar"
    self.Power:SetParent(self)
    self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
    self.Power.bg:SetAllPoints(self.Power)
    ns:UpdatePower(self.Power)

    -- Highlight tex
    local hl = self.Health:CreateTexture(nil, "OVERLAY")
    hl:SetAllPoints(self)
    hl:SetTexture([=[Interface\AddOns\ViksUI\Media\textures\white2.tga]=])
    hl:SetVertexColor(1,1,1,.1)
    hl:SetBlendMode("ADD")
    hl:Hide()
    self.Highlight = hl

    -- Target tex
    local tBorder = CreateFrame("Frame", nil, self)
    tBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
    tBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    tBorder:SetBackdrop(border)
    tBorder:SetBackdropColor(.8, .8, .8, 1)
    tBorder:SetFrameLevel(1)
    tBorder:Hide()
    self.TargetBorder = tBorder

    -- Focus tex
    local fBorder = CreateFrame("Frame", nil, self)
    fBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
    fBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    fBorder:SetBackdrop(border)
    fBorder:SetBackdropColor(.6, .8, 0, 1)
    fBorder:SetFrameLevel(1)
    fBorder:Hide()
    self.FocusHighlight = fBorder

    -- Raid Icons
    local ricon = self.Health:CreateTexture(nil, 'OVERLAY')
    ricon:SetPoint("TOP", self, 0, 5)
	ricon:SetTexture("Interface\\AddOns\\ViksUI\\Media\\Other\\raidicons")	
    ricon:SetSize(Viks.raidframes.leadersize+2, Viks.raidframes.leadersize+2)
    self.RaidIcon = ricon

    -- Leader Icon
    self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
    self.Leader:SetPoint("TOPLEFT", self, 0, 8)
    self.Leader:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    -- Assistant Icon
    self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
    self.Assistant:SetPoint("TOPLEFT", self, 0, 8)
    self.Assistant:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    local masterlooter = self.Health:CreateTexture(nil, 'OVERLAY')
    masterlooter:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)
    masterlooter:SetPoint('LEFT', self.Leader, 'RIGHT')
    self.MasterLooter = masterlooter

    -- Role Icon
    if Viks.raidframes.roleicon then
        local lfd = fs(self.Health, "OVERLAY", fontsymbol, 10, OUTLINE, 1, 1, 1)


		lfd:SetPoint("LEFT", self.Health, 0, 6)
		lfd:SetJustifyH"LEFT"
	    self:Tag(lfd, '[LFD]')
    end
	--self.DrkIndicators = true
    self.freebIndicators = true
    self.freebAfk = true
    self.freebHeals = true

    self.ResurrectIcon = self.Health:CreateTexture(nil, 'OVERLAY')
    self.ResurrectIcon:SetPoint("TOP", self, 0, -2)
    self.ResurrectIcon:SetSize(16, 16)

    -- Range
    self.Range = {
		insideAlpha = 1,
		outsideAlpha = Viks.raidframes.outsideRange,	}
		
    -- ReadyCheck
    self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
    self.ReadyCheck:SetPoint("TOP", self)
    self.ReadyCheck:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    -- Auras
    local auras = CreateFrame("Frame", nil, self)
    auras:SetSize(Viks.raidframes.aurasize, Viks.raidframes.aurasize)
    auras:SetPoint("CENTER", self.Health)
    auras.size = Viks.raidframes.aurasize
    self.freebAuras = auras

    -- Add events
    self:RegisterEvent('PLAYER_FOCUS_CHANGED', FocusTarget)
    self:RegisterEvent('RAID_ROSTER_UPDATE', FocusTarget)
    self:RegisterEvent('PLAYER_TARGET_CHANGED', ChangedTarget)
    self:RegisterEvent('RAID_ROSTER_UPDATE', ChangedTarget)

    self:SetScale(Viks.raidframes.scale)

    table.insert(ns._Objects, self)
end

local style25 = function(self)
    self.menu = menu
	lib.focus(self)
	--self:SetParent(PetBattleHider) --\\Hide frames in Pet Battle

    -- Backdrop
    self.BG = CreateFrame("Frame", nil, self)
    self.BG:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.BG:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    self.BG:SetFrameLevel(3)
    self.BG:SetBackdrop(backdrop)
    self.BG:SetBackdropColor(0, 0, 0)

    self.border = CreateFrame("Frame", nil, self)
    self.border:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    self.border:SetFrameLevel(2)
    self.border:SetBackdrop(border2)
    self.border:SetBackdropColor(0, 0, 0)

    -- Mouseover script
    self:SetScript("OnEnter", OnEnter)
    self:SetScript("OnLeave", OnLeave)
    self:RegisterForClicks"AnyUp"

    -- Health
    self.Health = CreateFrame"StatusBar"
    self.Health:SetParent(self)
    self.Health.frequentUpdates = true

    self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
    self.Health.bg:SetAllPoints(self.Health)

    self.Health.PostUpdate = PostHealth
    ns:UpdateHealth(self.Health)

    -- Threat
    local threat = CreateFrame("Frame", nil, self)
    threat:SetPoint("TOPLEFT", self, "TOPLEFT", -5, 5)
    threat:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 5, -5)
    threat:SetFrameLevel(0)
	CreateShadow0(threat)
    threat:SetBackdropColor(0, 0, 0, 0)
    threat:SetBackdropBorderColor(0, 0, 0, 1)
    threat.Override = updateThreat
    self.Threat = threat

    -- Name
    local name = self.Health:CreateFontString(nil, "OVERLAY")
    name:SetPoint("CENTER")
    name:SetJustifyH("CENTER")
    name:SetFont(Viks.media.font, Viks.raidframes.fontsize-2, Viks.raidframes.outline)
    name:SetShadowOffset(1.25, -1.25)
    name:SetWidth(Viks.raidframes.width25)
    name.overrideUnit = true
    self.Name = name
    self:Tag(self.Name, '[color][name]')

    ns:UpdateName(self.Name)

    -- Power
    self.Power = CreateFrame"StatusBar"
    self.Power:SetParent(self)
    self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
    self.Power.bg:SetAllPoints(self.Power)
    ns:UpdatePower(self.Power)

    -- Highlight tex
    local hl = self.Health:CreateTexture(nil, "OVERLAY")
    hl:SetAllPoints(self)
    hl:SetTexture([=[Interface\AddOns\ViksUI\Media\textures\white2.tga]=])
    hl:SetVertexColor(1,1,1,.1)
    hl:SetBlendMode("ADD")
    hl:Hide()
    self.Highlight = hl

    -- Target tex
    local tBorder = CreateFrame("Frame", nil, self)
    tBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
    tBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    tBorder:SetBackdrop(border)
    tBorder:SetBackdropColor(.8, .8, .8, 1)
    tBorder:SetFrameLevel(1)
    tBorder:Hide()
    self.TargetBorder = tBorder

    -- Focus tex
    local fBorder = CreateFrame("Frame", nil, self)
    fBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
    fBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    fBorder:SetBackdrop(border)
    fBorder:SetBackdropColor(.6, .8, 0, 1)
    fBorder:SetFrameLevel(1)
    fBorder:Hide()
    self.FocusHighlight = fBorder

    -- Raid Icons
    local ricon = self.Health:CreateTexture(nil, 'OVERLAY')
    ricon:SetPoint("TOP", self, 0, 5)
	ricon:SetTexture("Interface\\AddOns\\ViksUI\\Media\\Other\\raidicons")	
    ricon:SetSize(Viks.raidframes.leadersize+2, Viks.raidframes.leadersize+2)
    self.RaidIcon = ricon

    -- Leader Icon
    self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
    self.Leader:SetPoint("TOPLEFT", self, 0, 8)
    self.Leader:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    -- Assistant Icon
    self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
    self.Assistant:SetPoint("TOPLEFT", self, 0, 8)
    self.Assistant:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    local masterlooter = self.Health:CreateTexture(nil, 'OVERLAY')
    masterlooter:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)
    masterlooter:SetPoint('LEFT', self.Leader, 'RIGHT')
    self.MasterLooter = masterlooter

    -- Role Icon
    if Viks.raidframes.roleicon then
        local lfd = fs(self.Health, "OVERLAY", fontsymbol, 10, OUTLINE, 1, 1, 1)


		lfd:SetPoint("LEFT", self.Health, 0, 6)
		lfd:SetJustifyH"LEFT"
	    self:Tag(lfd, '[LFD]')
    end
	--self.DrkIndicators = true
    self.freebIndicators = true
    self.freebAfk = true
    self.freebHeals = true

    self.ResurrectIcon = self.Health:CreateTexture(nil, 'OVERLAY')
    self.ResurrectIcon:SetPoint("TOP", self, 0, -2)
    self.ResurrectIcon:SetSize(16, 16)

    -- Range
    self.Range = {
		insideAlpha = 1,
		outsideAlpha = Viks.raidframes.outsideRange,	}
		
    -- ReadyCheck
    self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
    self.ReadyCheck:SetPoint("TOP", self)
    self.ReadyCheck:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    -- Auras
    local auras = CreateFrame("Frame", nil, self)
    auras:SetSize(Viks.raidframes.aurasize, Viks.raidframes.aurasize)
    auras:SetPoint("CENTER", self.Health)
    auras.size = Viks.raidframes.aurasize
    self.freebAuras = auras

    -- Add events
    self:RegisterEvent('PLAYER_FOCUS_CHANGED', FocusTarget)
    self:RegisterEvent('RAID_ROSTER_UPDATE', FocusTarget)
    self:RegisterEvent('PLAYER_TARGET_CHANGED', ChangedTarget)
    self:RegisterEvent('RAID_ROSTER_UPDATE', ChangedTarget)

    self:SetScale(Viks.raidframes.scale)

    table.insert(ns._Objects, self)
end
local style40 = function(self)
    self.menu = menu
	lib.focus(self)
	--self:SetParent(PetBattleHider) --\\Hide frames in Pet Battle

    -- Backdrop
    self.BG = CreateFrame("Frame", nil, self)
    self.BG:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.BG:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    self.BG:SetFrameLevel(3)
    self.BG:SetBackdrop(backdrop)
    self.BG:SetBackdropColor(0, 0, 0)

    self.border = CreateFrame("Frame", nil, self)
    self.border:SetPoint("TOPLEFT", self, "TOPLEFT")
    self.border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    self.border:SetFrameLevel(2)
    self.border:SetBackdrop(border2)
    self.border:SetBackdropColor(0, 0, 0)

    -- Mouseover script
    self:SetScript("OnEnter", OnEnter)
    self:SetScript("OnLeave", OnLeave)
    self:RegisterForClicks"AnyUp"

    -- Health
    self.Health = CreateFrame"StatusBar"
    self.Health:SetParent(self)
    self.Health.frequentUpdates = true

    self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
    self.Health.bg:SetAllPoints(self.Health)

    self.Health.PostUpdate = PostHealth
    ns:UpdateHealth(self.Health)

    -- Threat
    local threat = CreateFrame("Frame", nil, self)
    threat:SetPoint("TOPLEFT", self, "TOPLEFT", -5, 5)
    threat:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 5, -5)
    threat:SetFrameLevel(0)
	CreateShadow0(threat)
    threat:SetBackdropColor(0, 0, 0, 0)
    threat:SetBackdropBorderColor(0, 0, 0, 1)
    threat.Override = updateThreat
    self.Threat = threat

    -- Name
    local name = self.Health:CreateFontString(nil, "OVERLAY")
    name:SetPoint("CENTER")
    name:SetJustifyH("CENTER")
    name:SetFont(Viks.media.font, Viks.raidframes.fontsize-3, Viks.raidframes.outline)
    name:SetShadowOffset(1.25, -1.25)
    name:SetWidth(Viks.raidframes.width40)
    name.overrideUnit = true
    self.Name = name
    self:Tag(self.Name, '[color][name]')

    ns:UpdateName(self.Name)

    -- Power
    self.Power = CreateFrame"StatusBar"
    self.Power:SetParent(self)
    self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
    self.Power.bg:SetAllPoints(self.Power)
    ns:UpdatePower(self.Power)

    -- Highlight tex
    local hl = self.Health:CreateTexture(nil, "OVERLAY")
    hl:SetAllPoints(self)
    hl:SetTexture([=[Interface\AddOns\ViksUI\Media\textures\white2.tga]=])
    hl:SetVertexColor(1,1,1,.1)
    hl:SetBlendMode("ADD")
    hl:Hide()
    self.Highlight = hl

    -- Target tex
    local tBorder = CreateFrame("Frame", nil, self)
    tBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
    tBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    tBorder:SetBackdrop(border)
    tBorder:SetBackdropColor(.8, .8, .8, 1)
    tBorder:SetFrameLevel(1)
    tBorder:Hide()
    self.TargetBorder = tBorder

    -- Focus tex
    local fBorder = CreateFrame("Frame", nil, self)
    fBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
    fBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
    fBorder:SetBackdrop(border)
    fBorder:SetBackdropColor(.6, .8, 0, 1)
    fBorder:SetFrameLevel(1)
    fBorder:Hide()
    self.FocusHighlight = fBorder

    -- Raid Icons
    local ricon = self.Health:CreateTexture(nil, 'OVERLAY')
    ricon:SetPoint("TOP", self, 0, 5)
	ricon:SetTexture("Interface\\AddOns\\ViksUI\\Media\\Other\\raidicons")	
    ricon:SetSize(Viks.raidframes.leadersize+2, Viks.raidframes.leadersize+2)
    self.RaidIcon = ricon

    -- Leader Icon
    self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
    self.Leader:SetPoint("TOPLEFT", self, 0, 8)
    self.Leader:SetSize(Viks.raidframes.leadersize-2, Viks.raidframes.leadersize-2)

    -- Assistant Icon
    self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
    self.Assistant:SetPoint("TOPLEFT", self, 0, 8)
    self.Assistant:SetSize(Viks.raidframes.leadersize-2, Viks.raidframes.leadersize-2)

    local masterlooter = self.Health:CreateTexture(nil, 'OVERLAY')
    masterlooter:SetSize(Viks.raidframes.leadersize-2, Viks.raidframes.leadersize-2)
    masterlooter:SetPoint('LEFT', self.Leader, 'RIGHT')
    self.MasterLooter = masterlooter

    -- Role Icon
    if Viks.raidframes.roleicon then
        local lfd = fs(self.Health, "OVERLAY", fontsymbol, 10, OUTLINE, 1, 1, 1)


		lfd:SetPoint("LEFT", self.Health, 0, 6)
		lfd:SetJustifyH"LEFT"
	    self:Tag(lfd, '[LFD]')
    end
	--self.DrkIndicators = true
    self.freebIndicators = true
    self.freebAfk = true
    self.freebHeals = true

    self.ResurrectIcon = self.Health:CreateTexture(nil, 'OVERLAY')
    self.ResurrectIcon:SetPoint("TOP", self, 0, -2)
    self.ResurrectIcon:SetSize(16, 16)

    -- Range
    self.Range = {
		insideAlpha = 1,
		outsideAlpha = Viks.raidframes.outsideRange,	}
		
    -- ReadyCheck
    self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
    self.ReadyCheck:SetPoint("TOP", self)
    self.ReadyCheck:SetSize(Viks.raidframes.leadersize, Viks.raidframes.leadersize)

    -- Auras
    local auras = CreateFrame("Frame", nil, self)
    auras:SetSize(Viks.raidframes.aurasize, Viks.raidframes.aurasize)
    auras:SetPoint("CENTER", self.Health)
    auras.size = Viks.raidframes.aurasize
    self.freebAuras = auras

    -- Add events
    self:RegisterEvent('PLAYER_FOCUS_CHANGED', FocusTarget)
    self:RegisterEvent('RAID_ROSTER_UPDATE', FocusTarget)
    self:RegisterEvent('PLAYER_TARGET_CHANGED', ChangedTarget)
    self:RegisterEvent('RAID_ROSTER_UPDATE', ChangedTarget)

    self:SetScale(Viks.raidframes.scale)

    table.insert(ns._Objects, self)
end
oUF:RegisterStyle("Freebgrid", style)
oUF:RegisterStyle("Freebgrid25", style25)
oUF:RegisterStyle("Freebgrid40", style40)

function ns:Colors()
    for class, color in next, colors.class do
        if Viks.raidframes.reversecolors then
            ns.colorCache[class] = "|cffFFFFFF"
        else
            ns.colorCache[class] = ns:hex(color)
        end
    end

    for dtype, color in next, DebuffTypeColor do
        ns.debuffColor[dtype] = ns:hex(color)
    end
end

local pos, posRel, colX, colY
local function freebHeader(name, group, temp, pet, MT)
    local horiz, grow = Viks.raidframes.horizontal, Viks.raidframes.growth
    local numUnits = Viks.raidframes.multi and 5 or Viks.raidframes.numUnits

    local initconfig = [[
    self:SetWidth(%d)
    self:SetHeight(%d)
    ]]

    local point, growth, xoff, yoff
    if horiz then
        point = "LEFT"
        xoff = Viks.raidframes.spacing
        yoff = 0
        if grow == "UP" then
            growth = "BOTTOM"
            pos = "BOTTOMLEFT"
            posRel = "TOPLEFT"
            colY = Viks.raidframes.spacing
        else
            growth = "TOP"
            pos = "TOPLEFT"
            posRel = "BOTTOMLEFT"
            colY = -Viks.raidframes.spacing
        end
    else
        point = "TOP"
        xoff = 0
        yoff = -Viks.raidframes.spacing
        if grow == "RIGHT" then
            growth = "LEFT"
            pos = "TOPLEFT"
            posRel = "TOPRIGHT"
            colX = Viks.raidframes.spacing
        else
            growth = "RIGHT"
            pos = "TOPRIGHT"
            posRel = "TOPLEFT"
            colX = -Viks.raidframes.spacing
        end
    end

    local sort, groupBy, groupOrder = "INDEX", "GROUP", "1,2,3,4,5,6,7,8"
    if not pet and not MT then
        if Viks.raidframes.sortName then
            sort = "NAME"
            groupBy = nil
        end

        if Viks.raidframes.sortClass then
            groupBy = "CLASS"
            groupOrder = Viks.raidframes.classOrder
            group = Viks.raidframes.classOrder
        end
    end

    local template = temp or nil
	---local raid25 = oUF:SpawnHeader("oUF_Raid25", nil, "custom [@raid26,exists] hide; [@raid11,exists] show; hide",
	---local raid10 = oUF:SpawnHeader("oUF_Raid", nil, "custom [@raid11,exists] hide; [group:party,@raid1,exists] show; hide",
	---local raid = oUF:SpawnHeader("oUF_Raid", nil, "custom [@raid1,exists] hide; [group:party,nogroup:raid] show;", 
	---local header = oUF:SpawnHeader(name, template, 'raid,party,solo',"custom [@raid1,exists] hide; [group:party,nogroup:raid] show; [nogroup] show"
    local header = oUF:SpawnHeader(name, template, "custom [@raid11,exists] hide; [group:party,@raid1,exists] show; [@player,exists] show; hide",
    'oUF-initialConfigFunction', (initconfig):format(Viks.raidframes.width, Viks.raidframes.height),
    'showPlayer', Viks.raidframes.player,
    'showSolo', Viks.raidframes.solo,
    'showParty', Viks.raidframes.party,
    'showRaid', true,
    'xOffset', xoff,
    'yOffset', yoff,
    'point', point,
    'sortMethod', sort,
    'groupFilter', group,
    'groupingOrder', groupOrder,
    'groupBy', groupBy,
    'maxColumns', Viks.raidframes.numCol,
    'unitsPerColumn', numUnits,
    'columnSpacing', Viks.raidframes.spacing,
    'columnAnchorPoint', growth)
	return header
end

oUF:Factory(function(self)
    ns:Colors()
	
	CompactRaidFrameManager:UnregisterAllEvents()
	CompactRaidFrameManager.Show = dummy
	CompactRaidFrameManager:Hide()

	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameContainer.Show = dummy
	CompactRaidFrameContainer:Hide()
	
	if Viks.raidframes.enable then
		self:SetActiveStyle"Freebgrid"
		if Viks.raidframes.multi then
			local raid = {}
			for i=1, Viks.raidframes.numCol do
				local group = freebHeader("Raid_Freebgrid"..i, i)
				if i == 1 then
					group:SetPoint("BOTTOM", Anchorviksraid, 0, -30)
				else
					group:SetPoint(pos, raid[i-1], posRel, colX or 0, colY or 0)
				end
				raid[i] = group
				ns._Headers[group:GetName()] = group
			end
		else
			local raid = freebHeader("Raid_Freebgrid")
			raid:SetPoint("BOTTOM", Anchorviksraid, 0, -30)
			ns._Headers[raid:GetName()] = raid
		end
	end
	
end)

local function freebHeader25(name, group, temp, pet, MT)
    local horiz, grow = Viks.raidframes.horizontal, Viks.raidframes.growth
    local numUnits = Viks.raidframes.multi and 5 or Viks.raidframes.numUnits

    local initconfig = [[
    self:SetWidth(%d)
    self:SetHeight(%d)
    ]]

    local point, growth, xoff, yoff
    if horiz then
        point = "LEFT"
        xoff = Viks.raidframes.spacing
        yoff = 0
        if grow == "UP" then
            growth = "BOTTOM"
            pos = "BOTTOMLEFT"
            posRel = "TOPLEFT"
            colY = Viks.raidframes.spacing
        else
            growth = "TOP"
            pos = "TOPLEFT"
            posRel = "BOTTOMLEFT"
            colY = -Viks.raidframes.spacing
        end
    else
        point = "TOP"
        xoff = 0
        yoff = -Viks.raidframes.spacing
        if grow == "RIGHT" then
            growth = "LEFT"
            pos = "TOPLEFT"
            posRel = "TOPRIGHT"
            colX = Viks.raidframes.spacing
        else
            growth = "RIGHT"
            pos = "TOPRIGHT"
            posRel = "TOPLEFT"
            colX = -Viks.raidframes.spacing
        end
    end

    local sort, groupBy, groupOrder = "INDEX", "GROUP", "1,2,3,4,5,6,7,8"
    if not pet and not MT then
        if Viks.raidframes.sortName then
            sort = "NAME"
            groupBy = nil
        end

        if Viks.raidframes.sortClass then
            groupBy = "CLASS"
            groupOrder = Viks.raidframes.classOrder
            group = Viks.raidframes.classOrder
        end
    end
	
    local template = temp or nil
	---local raid25 = oUF:SpawnHeader("oUF_Raid25", nil, "custom [@raid26,exists] hide; [@raid11,exists] show; hide",
	---local raid10 = oUF:SpawnHeader("oUF_Raid", nil, "custom [@raid11,exists] hide; [group:party,@raid1,exists] show; hide",
	---local raid = oUF:SpawnHeader("oUF_Raid", nil, "custom [@raid1,exists] hide; [group:party,nogroup:raid] show;", 
	---local header = oUF:SpawnHeader(name, template, 'raid,party,solo',"custom [@raid1,exists] hide; [group:party,nogroup:raid] show; [nogroup] show"
    local header25 = oUF:SpawnHeader(name, template, "custom [@raid26,exists] hide; [@raid11,exists] show; hide",
    'oUF-initialConfigFunction', (initconfig):format(Viks.raidframes.width25, Viks.raidframes.height25),
    'showPlayer', true,
    'showSolo', false,
    'showParty', false,
    'showRaid', true,
    'xOffset', xoff,
    'yOffset', yoff,
    'point', point,
    'sortMethod', sort,
    'groupFilter', group,
    'groupingOrder', groupOrder,
    'groupBy', groupBy,
    'maxColumns', Viks.raidframes.numCol,
    'unitsPerColumn', numUnits,
    'columnSpacing', Viks.raidframes.spacing,
    'columnAnchorPoint', growth)
	return header25
end

oUF:Factory(function(self)
    ns:Colors()
	
	CompactRaidFrameManager:UnregisterAllEvents()
	CompactRaidFrameManager.Show = dummy
	CompactRaidFrameManager:Hide()

	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameContainer.Show = dummy
	CompactRaidFrameContainer:Hide()
	
	if Viks.raidframes.enable then
		self:SetActiveStyle"Freebgrid25"
		if Viks.raidframes.multi then
			local raid = {}
			for i=1, Viks.raidframes.numCol do
				local group = freebHeader25("Raid_Freebgrid25"..i, i)
				if i == 1 then
					group:SetPoint("BOTTOM", Anchorviksraid, 0, -40)
				else
					group:SetPoint(pos, raid[i-1], posRel, colX or 0, colY or 0)
				end
				raid[i] = group
				ns._Headers[group:GetName()] = group
			end
		else
			local raid = freebHeader25("Raid_Freebgrid25")
			raid:SetPoint("BOTTOM", Anchorviksraid, 0, -40)
			ns._Headers[raid:GetName()] = raid
		end
	end
	
end)
local function freebHeader40(name, group, temp, pet, MT)
    local horiz, grow = Viks.raidframes.horizontal, Viks.raidframes.growth
    local numUnits = 8

    local initconfig = [[
    self:SetWidth(%d)
    self:SetHeight(%d)
    ]]

    local point, growth, xoff, yoff
    if horiz then
        point = "LEFT"
        xoff = Viks.raidframes.spacing
        yoff = 0
        if grow == "UP" then
            growth = "BOTTOM"
            pos = "BOTTOMLEFT"
            posRel = "TOPLEFT"
            colY = Viks.raidframes.spacing
        else
            growth = "TOP"
            pos = "TOPLEFT"
            posRel = "BOTTOMLEFT"
            colY = -Viks.raidframes.spacing
        end
    else
        point = "TOP"
        xoff = 0
        yoff = -Viks.raidframes.spacing
        if grow == "RIGHT" then
            growth = "LEFT"
            pos = "TOPLEFT"
            posRel = "TOPRIGHT"
            colX = Viks.raidframes.spacing
        else
            growth = "RIGHT"
            pos = "TOPRIGHT"
            posRel = "TOPLEFT"
            colX = -Viks.raidframes.spacing
        end
    end

    local sort, groupBy, groupOrder = "INDEX", "GROUP", "1,2,3,4,5,6,7,8"
    if not pet and not MT then
        if Viks.raidframes.sortName then
            sort = "NAME"
            groupBy = nil
        end

        if Viks.raidframes.sortClass then
            groupBy = "CLASS"
            groupOrder = Viks.raidframes.classOrder
            group = Viks.raidframes.classOrder
        end
    end

    local template = temp or nil
	---local raid25 = oUF:SpawnHeader("oUF_Raid25", nil, "custom [@raid26,exists] hide; [@raid11,exists] show; hide",
	---local raid10 = oUF:SpawnHeader("oUF_Raid", nil, "custom [@raid11,exists] hide; [group:party,@raid1,exists] show; hide",
	---local raid = oUF:SpawnHeader("oUF_Raid", nil, "custom [@raid1,exists] hide; [group:party,nogroup:raid] show;", 
	---local header = oUF:SpawnHeader(name, template, 'raid,party,solo',"custom [@raid1,exists] hide; [group:party,nogroup:raid] show; [nogroup] show"
    local header40 = oUF:SpawnHeader(name, template, "custom [@raid26,exists] show; hide",
    'oUF-initialConfigFunction', (initconfig):format(Viks.raidframes.width40, Viks.raidframes.height40),
    'showPlayer', true,
    'showSolo', false,
    'showParty', false,
    'showRaid', true,
    'xOffset', xoff,
    'yOffset', yoff,
    'point', point,
    'sortMethod', sort,
    'groupFilter', "1,2,3,4,5,6,7,8",
    'groupingOrder', "1,2,3,4,5,6,7,8",
    'groupBy', "GROUP",
    'maxColumns', 4,
    'unitsPerColumn', 10,
    'columnSpacing', Viks.raidframes.spacing,
    'columnAnchorPoint', growth)
	return header40
end

oUF:Factory(function(self)
    ns:Colors()
	
	CompactRaidFrameManager:UnregisterAllEvents()
	CompactRaidFrameManager.Show = dummy
	CompactRaidFrameManager:Hide()

	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameContainer.Show = dummy
	CompactRaidFrameContainer:Hide()
	
	if Viks.raidframes.enable then
		self:SetActiveStyle"Freebgrid40"
		if not Viks.raidframes.multi then
			local raid = {}
			for i=1, 5 do
				local group = freebHeader40("Raid_Freebgrid40"..i, i)
				if i == 1 then
					group:SetPoint("BOTTOM", Anchorviksraid, 0, -40)
				else
					group:SetPoint(pos, raid[i-1], posRel, colX or 0, colY or 0)
				end
				raid[i] = group
				ns._Headers[group:GetName()] = group
			end
		else
			local raid = freebHeader40("Raid_Freebgrid40")
			raid:SetPoint("BOTTOM", Anchorviksraid, 0, -40)
			ns._Headers[raid:GetName()] = raid
		end
	end
	
end)