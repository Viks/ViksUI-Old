local T, Viks, L, _ = unpack(select(2, ...))
-----------------------------
-- INIT
-----------------------------
	local addon, ns = ...
	local cfg = ns.cfg
	local cast = ns.cast
	local lib = CreateFrame("Frame")  
	local _, playerClass = UnitClass("player")
	--local cast = CreateFrame("Frame")  
	local oUF = ns.oUF or oUF
	--local r25w = cfg.RH25width
	--local r10w = cfg.RH10width
	oUF.colors.power['MANA'] = {0.0, 0.56, 1.0}
	oUF.colors.power['RAGE'] = {1.0,0,0}
	oUF.colors.power['FOCUS'] = {1.0,0.75,0.25}
	oUF.colors.power['ENERGY'] = {0.65,0.65,0.35}
	oUF.colors.power['ENERGY'] = {0.65,0.65,0.35}
	oUF.colors.power['RUNIC_POWER'] = {0.44,0.44,0.44}
	oUF.colors.power['AMMOSLOT'] = {0.8,0.6,0}
	oUF.colors.power['FUEL'] = {0,0.55,0.5}
	oUF.colors.power['POWER_TYPE_STEAM'] = {0.55,0.57,0.61}
	oUF.colors.power['POWER_TYPE_PYRITE'] = {0.6,0.09,0.17}
	oUF.colors.power['POWER_TYPE_HEAT'] = {0.9,0.45,0.1}
	oUF.colors.power['POWER_TYPE_OOZE'] = {0.1,0.1,0.9}
	oUF.colors.power['POWER_TYPE_BLOOD_POWER'] = {0.9,0.1,0.1}
	local _, pType = UnitPowerType("player")
	local pcolor = oUF.colors.power[pType] or {.3,.45,.65} 
	oUF.colors.runes = {{196/255, 30/255, 58/255};{173/255, 217/255, 25/255};{35/255, 127/255, 255/255};{178/255, 53/255, 240/255};}


T.oUF_colors = setmetatable({
	tapped = {0.6, 0.6, 0.6},
	disconnected = {0.84, 0.75, 0.65},
	power = setmetatable({
		["MANA"] = {0.31, 0.45, 0.63},
		["RAGE"] = {0.69, 0.31, 0.31},
		["FOCUS"] = {0.71, 0.43, 0.27},
		["ENERGY"] = {0.65, 0.63, 0.35},
		["RUNES"] = {0.55, 0.57, 0.61},
		["RUNIC_POWER"] = {0, 0.82, 1},
		["AMMOSLOT"] = {0.8, 0.6, 0},
		["FUEL"] = {0, 0.55, 0.5},
	}, {__index = oUF.colors.power}),
	runes = setmetatable({
		[1] = {0.69, 0.31, 0.31},
		[2] = {0.33, 0.59, 0.33},
		[3] = {0.31, 0.45, 0.63},
		[4] = {0.84, 0.75, 0.65},
	}, {__index = oUF.colors.runes}),
	reaction = setmetatable({
		[1] = {0.85, 0.27, 0.27}, -- Hated
		[2] = {0.85, 0.27, 0.27}, -- Hostile
		[3] = {0.85, 0.27, 0.27}, -- Unfriendly
		[4] = {0.85, 0.77, 0.36}, -- Neutral
		[5] = {0.33, 0.59, 0.33}, -- Friendly
		[6] = {0.33, 0.59, 0.33}, -- Honored
		[7] = {0.33, 0.59, 0.33}, -- Revered
		[8] = {0.33, 0.59, 0.33}, -- Exalted
	}, {__index = oUF.colors.reaction}),
}, {__index = oUF.colors})	
-----------------------------
--MISC STYLING 
-----------------------------
  
local shadows = {
	edgeFile = cfg.shadowedge, 
	edgeSize = 4,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}
	
local shadows2 = {
	bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
	edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
	insets = {left = -1, right = -1, top = -1, bottom = -1} 
	}
function CreateShadow(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0,0,0, 1)
	f.shadow = shadow
	return shadow
end

function CreateShadow_1(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function framefix1px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = -1, right = -1, top = -1, bottom = -1} 
	})
	f:SetBackdropColor(unpack(cfg.backdropcolor))
	f:SetBackdropBorderColor(unpack(cfg.bordercolor))
end
function CreateShadowClassbar3(f) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = 1, right = -1, top = 1, bottom = -1} 
	})
	shadow:SetBackdropColor(unpack(cfg.backdropcolor))
	shadow:SetBackdropBorderColor(unpack(cfg.bordercolor))
	f.shadow = shadow
	return shadow
end

function frame1px2_2(f) --//Viks
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = 1, right = 1, top = 1, bottom = 1} 
	})
	f:SetPoint("TOPLEFT", -1, 1)
	f:SetPoint("BOTTOMRIGHT", 1, -1)
	f:SetBackdropColor(unpack(cfg.backdropcolor))
	f:SetBackdropBorderColor(unpack(cfg.bordercolor))
end
--TODO: Restyle this next one?? Unsure
function frame11px_1(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = 1, right = 1, top = 1, bottom = 1} 
	})
	f:SetPoint("TOPLEFT", -2, 2)
	f:SetPoint("BOTTOMRIGHT", 2, -2)
	f:SetBackdropColor(.09,.09,.09,1)
	f:SetBackdropBorderColor(.2,.2,.2,1)
end
function frame1px1(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = -1, right = -1, top = -1, bottom = -1} 
	})
	f:SetPoint("TOPLEFT", -2, 2)
	f:SetPoint("BOTTOMRIGHT", 2, -2)
	f:SetBackdropColor(unpack(cfg.backdropcolor))
	f:SetBackdropBorderColor(unpack(cfg.bordercolor))
end
-- Creating Icon for the CastBar
function frame(f)
    if f.frame==nil then
      local frame = CreateFrame("Frame", nil, f)
      frame = CreateFrame("Frame", nil, f)
      frame:SetFrameLevel(12)
      frame:SetFrameStrata(f:GetFrameStrata())
      frame:SetPoint("TOPLEFT", 4, -4)
      frame:SetPoint("BOTTOMLEFT", 4, 4)
      frame:SetPoint("TOPRIGHT", -4, -4)
      frame:SetPoint("BOTTOMRIGHT", -4, 4)
      frame:SetBackdrop( { 
        edgeFile = "Interface\\Buttons\\WHITE8x8", 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
      })
     
      frame:SetBackdropColor(.09,.09,.09,1)
      frame:SetBackdropBorderColor(.2,.2,.2,1)
      f.frame = frame
    end
end 
function CreateShadow1_1(f)
    if f.frameBD==nil then
      local frameBD = CreateFrame("Frame", nil, f)
      frameBD = CreateFrame("Frame", nil, f)
      frameBD:SetFrameLevel(1)
      frameBD:SetFrameStrata(f:GetFrameStrata())
      frameBD:SetPoint("TOPLEFT", -0, 0)
      frameBD:SetPoint("BOTTOMLEFT", 0, 0)
      frameBD:SetPoint("TOPRIGHT", 0, 0)
      frameBD:SetPoint("BOTTOMRIGHT", 0, 0)
      frameBD:SetBackdrop( { 
         edgeFile = cfg.shadowedge, edgeSize = 4,
         insets = {left = 3, right = 3, top = 3, bottom = 3},
         tile = false, tileSize = 0,
      })
      frameBD:SetBackdropColor(0, 0, 0, 0)
      frameBD:SetBackdropBorderColor(0, 0, 0, 1)
      f.frameBD = frameBD
    end
end

-----------------------------
-- FUNCTIONS
-----------------------------
--Size for Frames; (f, "player/target", "Everything Else", "Raid/Party")
 local retVal = function(f, val1, val2, val3, val4)
	if f.mystyle == "player" or f.mystyle == "target" or f.mystyle == "arena" then
		return val1
	elseif f.mystyle == "raid" or f.mystyle == "raid25" or f.mystyle == "party" then
		return val3
	elseif f.mystyle == "oUF_MT" then
		return val4
	else
		return val2
	end
end

--status bar filling fix
local fixStatusbar = function(b)
	b:GetStatusBarTexture():SetHorizTile(false)
	b:GetStatusBarTexture():SetVertTile(false)
end

-- Right Click Menu
lib.spawnMenu = function(self)
	local unit = self.unit:sub(1, -2)
	local cunit = self.unit:gsub("^%l", string.upper)

	if(cunit == "Vehicle") then
		cunit = "Pet"
	end

	if(unit == "party") then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
	elseif(_G[cunit.."FrameDropDown"]) then
		ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
	elseif unit == "raid" then
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1,nil,FriendsDropDown,"cursor")		
	end
end

UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
end
--Fast focus/clearfocus function
lib.focus = function(f)
    f:RegisterForClicks("AnyDown")
	local ModKey = 'alt-ctrl-shift'
    local MouseButton = 1
    local key = ModKey .. '-type' .. (MouseButton or '')
		f:SetAttribute(key, 'focus')
end

lib.cfocus = function(f)
    f:RegisterForClicks("AnyDown")
	local ModKey = 'alt-ctrl-shift'
    local MouseButton = 1
    local key = ModKey .. '-type' .. (MouseButton or '')
		f:SetAttribute(key, 'macro')
		f:SetAttribute('macrotext', '/clearfocus')
end

--fontstring func
lib.gen_fontstring = function(f, name, size, outline)
    local fs = f:CreateFontString(nil, "OVERLAY")
    fs:SetFont(name, size, outline)
    fs:SetShadowColor(0,0,0,0.8)
    fs:SetShadowOffset(1,-1)
    return fs
end

SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(cfg.font, 11, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

do
	UpdateHoly = function(self, event, unit, powerType)
	if self.unit ~= unit or (powerType and powerType ~= "HOLY_POWER") then return end
	local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
	local numMax = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)
	local barWidth = self.HolyPower:GetWidth()
	local spacing = select(4, self.HolyPower[4]:GetPoint())
	local lastBar = 0

	if numMax ~= self.HolyPower.maxPower then
		if numMax == 3 then
			self.HolyPower[4]:Hide()
			self.HolyPower[5]:Hide()
			for i = 1, 3 do
				if i ~= 3 then
					self.HolyPower[i]:SetWidth(barWidth / 3)
					lastBar = lastBar + (barWidth / 3 + spacing)
				else
					self.HolyPower[i]:SetWidth(barWidth - lastBar)
				end
			end
	else
			self.HolyPower[4]:Show()
			self.HolyPower[5]:Show()
			for i = 1, 5 do
				self.HolyPower[i]:SetWidth((self.HolyPower:GetWidth() -4 )/5)
			end
		end
		self.HolyPower.maxPower = numMax
	end

		for i = 1, 5 do
			if i <= num then
				self.HolyPower[i]:SetAlpha(1)
			else
				self.HolyPower[i]:SetAlpha(0.2)
			end
		end
	end
			
	ComboDisplay = function(self, event, unit)
		if(unit == 'pet') then return end
		
		local cpoints = self.CPoints
		local cp
		if (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then
			cp = GetComboPoints('vehicle', 'target')
		else
			cp = GetComboPoints('player', 'target')
		end

		for i=1, MAX_COMBO_POINTS do
			if(i <= cp) then
				cpoints[i]:SetAlpha(1)
			else
				cpoints[i]:SetAlpha(0.15)
			end
		end
		
		if cpoints[1]:GetAlpha() == 1 then
			for i=1, MAX_COMBO_POINTS do
				cpoints[i]:Show()
			end
			
		else
			for i=1, MAX_COMBO_POINTS do
				cpoints[i]:Hide()
			end
			
		end
	end
end

function AltPowerBarOnToggle(self)
	local unit = self:GetParent().unit or self:GetParent():GetParent().unit					
end

function AltPowerBarPostUpdate(self, min, cur, max)
	local perc = math.floor((cur/max)*100)
		
	if perc < 35 then
		self:SetStatusBarColor(0, 1, 0)
	elseif perc < 70 then
		self:SetStatusBarColor(1, 1, 0)
	else
		self:SetStatusBarColor(1, 0, 0)
	end
		
	local unit = self:GetParent().unit or self:GetParent():GetParent().unit
			
	local type = select(10, UnitAlternatePowerInfo(unit))
				
	
end	

-----------------------------
-- SETTING UP THE BARS
-----------------------------

--Setting up the health bar
lib.gen_hpbar = function(f)
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
	s:GetStatusBarTexture():SetHorizTile(true)
	s.Smooth = true
	fixStatusbar(s)
	if f.mystyle == "raid" or f.mystyle == "raid25" then
	s:SetFrameLevel(0)
	else
	s:SetFrameLevel(5)
	end
	if cfg.HealFrames then
	s:SetHeight(retVal(f,32,18,25,22))
	else
	s:SetHeight(retVal(f,32,18,25,22))
	end
	if not cfg.HealthcolorClass then
	s:SetStatusBarColor(.2,.2,.2,1)
	end
    s:SetWidth(f:GetWidth())
    s:SetPoint("TOP",0,0)
    local h = CreateFrame("Frame", nil, s)
    h:SetPoint("TOPLEFT",-5,5)

	if f.mystyle == "target" or f.mystyle == "player" or f.mystyle == "focus" or f.mystyle == "arena" then
		h:SetFrameLevel(1)
		s:SetPoint("TOP",0,2)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		h:SetFrameStrata("MEDIUM")
		h:SetFrameLevel(5)
		frame1px2_2(h)
	elseif f.mystyle == "raid" then
		h:SetFrameLevel(0)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame11px_1(h)
	elseif f.mystyle == "raid" or f.mystyle == "raid25" then
		--h:SetFrameLevel(0)
		--h:SetPoint("BOTTOMRIGHT",5,-5)
		--frame11px_1(h)
	else
		h:SetFrameLevel(0)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)
	end
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
	b:SetVertexColor(.1,.1,.1)
	f.Health = s
end


-- Placing Text/Tags on the health Frames
lib.gen_hpstrings = function(f)
    --creating helper frame here so our font strings don't inherit healthbar parameters
    local h = CreateFrame("Frame", nil, f)
    h:SetAllPoints(f.Health)
    h:SetFrameLevel(15)
    local fontsize1
		if f.mystyle == "player" then fontsize1 = 26
		elseif f.mystyle == "target" or f.mystyle == "arena" then fontsize1 =18 
		elseif f.mystyle == "raid" or f.mystyle == "party" then fontsize1 = 15 
		elseif f.mystyle == "raid25" then fontsize1 = 15 
		else fontsize1 = 16 
	end 
	local fontsize2
		if f.mystyle == "player" then fontsize2 = 16
		elseif f.mystyle == "target" or f.mystyle == "arena" then fontsize2 =14
		elseif f.mystyle == "raid" or f.mystyle == "party" then fontsize2 = 12
		elseif f.mystyle == "raid25" then fontsize2 = 10
		else fontsize2 = 10 
	end 
    local name = lib.gen_fontstring(f.Health, cfg.oUFfont, fontsize1, retVal(f,17,12,12,15), "NONE")
    name:SetPoint("LEFT", f.Health, "TOPLEFT", retVal(f,3,3,3,3), retVal(f,-14,-10,-12,-10))
    name:SetJustifyH("LEFT")
	if f.mystyle == "raid" then
		name:SetPoint("TOP", f.Health, "TOP", 0, -2)
		name:SetJustifyH("CENTER")
	end
	if f.mystyle == "raid25" then
		name:SetPoint("TOP", f.Health, "TOP", 0, -2)
		name:SetJustifyH("CENTER")
	end
    local hpval = lib.gen_fontstring(f.Health, cfg.font, fontsize2, retVal(f,17,12,10,12), "NONE")
    hpval:SetPoint("RIGHT", f.Health, "TOPRIGHT", retVal(f,-3,-3,-1,-3), retVal(f,-14,-10,-12,-11))
    hpval.frequentUpdates = 0.1
	if f.mystyle == "raid" or f.mystyle == "party" then
	hpval:SetPoint("BOTTOMRIGHT", f.Health, "BOTTOMRIGHT", -2, -2)
	hpval:SetJustifyH("LEFT")
	end
	if f.mystyle == "raid25" then
	hpval:SetPoint("BOTTOMRIGHT", f.Health, "BOTTOMRIGHT", -2, 0)
	hpval:SetJustifyH("LEFT")
	end
	if f.mystyle == "tank" then
	hpval:SetPoint("RIGHT", f.Health, "RIGHT", -50, 0)
	hpval:SetJustifyH("CENTER")
	
	end
	if f.mystyle == "raid" or f.mystyle == "raid25" then
		name:SetPoint("RIGHT", f, "RIGHT", -1, -2)
	else
		name:SetPoint("RIGHT", hpval, "LEFT", -2, 0)
	end
	if f.mystyle == "player" then
		f:Tag(name, "[drk:color][name][drk:afkdnd]")
		f:Tag(hpval, retVal(f,"[drk:color][drk:Shp]"))
	elseif f.mystyle == "target" or f.mystyle == "arena" then 
		f:Tag(name, "[drk:level] [drk:color][name][drk:afkdnd]")
		f:Tag(hpval, retVal(f,"[drk:color][drk:Shp]"))
	elseif f.mystyle == "raid" or f.mystyle == "raid25" or f.mystyle == "party" then
		f:Tag(name, "[drk:color][name][drk:afkdnd]")
		f:Tag(hpval, "[drk:color][drk:Shp]")
	elseif f.mystyle == "tank" then
	f:Tag(name, "[drk:color][name][drk:afkdnd]")
	f:Tag(hpval, "[drk:color][drk:Shp]")
	else
		f:Tag(name, "[drk:color][name]")
	end
	--f:Tag(hpval, retVal(f,"[drk:color][drk:hp]"))
end

--Setting up the Power Bar. TODO: Clean up the SetHight and SetWidth, by fixing RetVal
lib.gen_ppbar = function(f)
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.powerbar_texture)
	s:GetStatusBarTexture():SetHorizTile(true)
	fixStatusbar(s)
	s:SetHeight(retVal(f,5,5,5,5))
	s:SetFrameLevel(1)
    s:SetPoint("BOTTOM",UIParent,"BOTTOM",0,1)
	if f.mystyle == "player" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",-7,22)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Player.h-25)
		s:SetWidth(cfg.unit_size.Player.w+2)
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)

	end
	if f.mystyle == "target" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",7,22)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Target.h-25)
		s:SetWidth(cfg.unit_size.Target.w+2)
		h:SetPoint("TOPLEFT",-5,15)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)

	end
	if f.mystyle == "arena" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",7,22)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Arena.h-25)
		s:SetWidth(cfg.unit_size.Arena.w+2)
		h:SetPoint("TOPLEFT",-5,15)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)

	end
	if f.mystyle == "focus" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",4,2)
		h:SetFrameLevel(0)
		s:SetSize(cfg.unit_size.Focus.w, cfg.unit_size.Focus.h-3)
		frame1px2_2(h)
	end
	if f.mystyle == "raid" then	
		local h = CreateFrame("Frame", nil, s)
		s:SetWidth(f:GetWidth())
		s:SetHeight(5)
		s:SetPoint("BOTTOM",f,"BOTTOM",0,5)
		h:SetFrameLevel(1)
		h:SetFrameStrata("LOW")
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)
	end
	if f.mystyle == "raid25" then	
		local h = CreateFrame("Frame", nil, s)
		s:SetWidth(4)
		s:SetHeight(25)
		s:SetPoint("BOTTOMLEFT",f,"BOTTOMLEFT",-4,5)
		s:SetOrientation("VERTICAL")

		--frame1px2_2(h)
	end
	if f.mystyle == "party" then --// Not in use yet. TODO: Fix this and not use RaidStyle as Partyframes	
		local h = CreateFrame("Frame", nil, s)
		--s:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -10)
		--s:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", 0, -10)
		s:SetWidth(f:GetWidth())
		s:SetHeight(5)
		s:SetPoint("BOTTOM",f,"BOTTOM",0,5)
		h:SetFrameLevel(1)
		h:SetFrameStrata("LOW")
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)
	end	
	if f.mystyle == "tank" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",15,3)
		s:SetWidth(25)
		h:SetFrameLevel(10)
		h:SetFrameStrata("LOW")
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)

	end
	if f.mystyle == "boss" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",0,-6)
		h:SetFrameLevel(10)
		h:SetFrameStrata("LOW")
		s:SetWidth(cfg.unit_size.Boss.w)
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)
	end
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.powerbar_texture)
    b:SetAllPoints(s)
    f.Power = s
    f.Power.bg = b
end

-- Creating the text bar
lib.gen_textbar = function(f)
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.Textbar_texture)
	s:GetStatusBarTexture():SetHorizTile(true)
	s:SetStatusBarColor(.106,.106,.106,1) -------------------------------------------
	fixStatusbar(s)
    s:SetWidth(cfg.unit_size.Player.w)
	s:SetFrameLevel(0)
	s:SetFrameStrata("background")
    s:SetPoint("BOTTOM",UIParent,"BOTTOM",0,1)
	if f.mystyle == "player" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",6,6)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Player.h-23)
		s:SetWidth(cfg.unit_size.Player.w)
		h:SetFrameStrata("background")
		frame1px2_2(h)
	end
	if f.mystyle == "target" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",-6,6)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Target.h-23)
		s:SetWidth(cfg.unit_size.Target.w)
		h:SetFrameStrata("background")
		frame1px2_2(h)
	end
	if f.mystyle == "arena" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",-6,6)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Arena.h-23)
		s:SetWidth(cfg.unit_size.Arena.w)
		h:SetFrameStrata("background")
		frame1px2_2(h)
	end
	if f.mystyle == "focus" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",-4,-6)
		h:SetFrameLevel(0)
		s:SetHeight(cfg.unit_size.Focus.h-3)
		s:SetWidth(cfg.unit_size.Focus.w)
		h:SetFrameStrata("background")
		frame1px2_2(h)
	end
	if f.mystyle == "raid" then
	if cfg.HealFrames then
	end	
	end
	if f.mystyle == "tank" then
		local h = CreateFrame("Frame", nil, s)
		s:SetPoint("BOTTOM",f,"BOTTOM",15,3)
		s:SetWidth(25)
		h:SetFrameLevel(10)
		h:SetPoint("TOPLEFT",-5,5)
		h:SetPoint("BOTTOMRIGHT",5,-5)
		frame1px2_2(h)
	end
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.powerbar_texture)
    b:SetAllPoints(s)
	b:SetVertexColor(.149,.149,.149,0) -----------------------------
end

-- Setting up the text/tag strings on the text bar
lib.gen_textstrings = function(f)
	--//Left Tag positioning bottombar
    local name = lib.gen_fontstring(f.Health, cfg.oUFfont, cfg.fontsize, retVal(f,17,12,12,12), "NONE")
    name:SetPoint("LEFT", f.Health, "TOPLEFT", retVal(f,6,3,3,3), retVal(f,-49,-10,-10,-10))
    name:SetJustifyH("LEFT")
	name.frequentUpdates = 0.1
	if f.mystyle == "focus" then
		name:SetPoint("LEFT", f.Health, "BOTTOMLEFT", retVal(f,6,3,3,3), retVal(f,-49,-11,-11,-11))
	elseif f.mystyle == "target" or f.mystyle == "arena" then
		name:SetPoint("LEFT", f.Health, "TOPLEFT", retVal(f,-3,3,3,3), retVal(f,-49,-10,-10,-10))
	end
	--//Right Tag positioning bottombar	
    local hpval = lib.gen_fontstring(f.Health, cfg.oUFfont, 12, retVal(f,17,12,10,10), "NONE")
    hpval:SetPoint("RIGHT", f.Health, "TOPRIGHT", retVal(f,3,-3,-1,-1), retVal(f,-49,-10,-20,-20))
    hpval.frequentUpdates = 0.1
	if f.mystyle == "focus" then
		hpval:SetPoint("RIGHT", f.Health, "TOPRIGHT", retVal(f,-6,-3,-1,-1), retVal(f,-49,-11,-11,-11))
	elseif f.mystyle == "target" or f.mystyle == "arena" then
		hpval:SetPoint("RIGHT", f.Health, "TOPRIGHT", retVal(f,-3,-3,-1,-1), retVal(f,-49,-10,-20,-20))
	elseif f.mystyle == "raid" or f.mystyle == "raid25" then
		hpval:SetPoint("RIGHT", f.Health, "TOPRIGHT", retVal(f,-3,-3,-1,-1), retVal(f,-49,-10,-20,-20))
	end
	--Right Tag
	if f.mystyle == "player" then
	f:Tag(hpval, "[drk:color][cur|max]")
	elseif f.mystyle == "target" or f.mystyle == "arena" then
	f:Tag(hpval, "[drk:color][cur|max]")
	elseif f.mystyle == "focus" then
	f:Tag(hpval, "[drk:color][cur|max] | [perhp]%")
	elseif f.mystyle == "raid25" then
	hpval:SetFont(cfg.font,8)
	f:Tag(hpval, "[drk:color][drk:Shp]")
	elseif f.mystyle == "raid" then
	hpval:SetFont(cfg.font,8)
	f:Tag(hpval, "[drk:color][drk:Shp]")
	elseif f.mystyle == "tank" then
	hpval:SetFont(cfg.font,8)
	f:Tag(hpval, "[drk:color][drk:Shp]")
	end
	--Left Tag
	if f.mystyle == "player" then
		f:Tag(name, "[drk:color][drk:power2]")
	elseif f.mystyle == "target" or f.mystyle == "arena" then
		f:Tag(name, "[drk:color][drk:power2]")
	end
	--f:Tag(hpval, retVal(f,"[drk:color][drk:Shp]"))
end

-----------------------------
-- ICONS AND OTHER STYLING
-----------------------------
PortraitUpdate = function(self, unit) 
		self:SetAlpha(0) self:SetAlpha(0.35)
		if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then
			self:SetPortraitZoom(1)
		end	
end
	
HidePortrait = function(self, unit)
	if self.unit == "target" then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
			self.Portrait:SetAlpha(0)
		else
			self.Portrait:SetAlpha(1)
		end
	end
end
--Portrait

lib.gen_portrait = function(f)
	if cfg.portraitHPbar then
    local portrait = CreateFrame("PlayerModel", nil, f)
	portrait.PostUpdate = function(f)
	portrait:SetPortraitZoom(0.85)
	portrait:SetPosition(0,0,-0.05)
	portrait:SetAlpha(0.2) 
	end
	portrait:SetAllPoints(f.Health)
	portrait:SetFrameStrata("HIGH")
	portrait:SetFrameLevel(13)
	table.insert(f.__elements, HidePortrait)
	f.Portrait = portrait
	end
	if cfg.showPortrait then
	local p = CreateFrame("PlayerModel", nil, f)
    p:SetFrameStrata("BACKGROUND")
	p:SetFrameLevel(3)
    p:SetWidth(cfg.unit_size.Portrait.w)
    p:SetHeight(cfg.unit_size.Portrait.h)
	if f.mystyle == 'player' then
	p:SetPoint("LEFT", f, "RIGHT", 11, 4.5)
	end
	if f.mystyle == 'target' or f.mystyle == 'arena' then
	p:SetPoint("RIGHT", f, "LEFT", -11, 4.5)
	end
    f.Portrait = p
	local h = CreateFrame("Frame", nil, p)
	h:SetFrameLevel(2)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	frame1px2_2(h)
	end	
end

  --gen combat and LFD icons
lib.gen_InfoIcons = function(f)
    local h = CreateFrame("Frame",nil,f)
    h:SetAllPoints(f)
    h:SetFrameLevel(10)
	if f.mystyle == 'player' then
		f.Combat = h:CreateTexture(nil, 'OVERLAY')
		f.Combat:SetSize(24,24)
		f.Combat:SetPoint('LEFT', -14, -8)
		f.Combat:SetTexture(cfg.combatico)
    end
	-- rest icon
    if f.mystyle == 'player' then
		f.Resting = h:CreateTexture(nil, 'OVERLAY')
		f.Resting:SetSize(24,24)
		f.Resting:SetPoint('TOPLEFT', -8, 16)
		f.Resting:SetTexture(cfg.restico)
		f.Resting:SetAlpha(0.75)
	end
    if f.mystyle =='raid' or f.mystyle =='raid25' or f.mystyle =='party' and cfg.showLFDIcons then 
		if cfg.customLFDIcons then
		local lfdi = lib.gen_fontstring(f.Health, cfg.symbol, 10, "OUTLINE", 1, 1, 1)
		lfdi:SetPoint("BOTTOMLEFT", f.Health, 2, 2)
		lfdi:SetJustifyH"LEFT"
	    f:Tag(lfdi, '[rollico:LFD]')
		elseif cfg.customLFDText then
		local lfd = lib.gen_fontstring(f.Health, cfg.oUFfont, 10, "THINOUTLINE")
		lfd:SetPoint('BOTTOMLEFT', f.Health, 'BOTTOMLEFT', 2, 2)
		f:Tag(lfd, "[rolltext:LFD]")
		else
		f.LFDRole = f.Health:CreateTexture(nil, 'OVERLAY')
		f.LFDRole:SetSize(12, 12)
		f.LFDRole:SetPoint('CENTER', f, 'TOPRIGHT', 0, 0)
		end
    end
    li = h:CreateTexture(nil, "OVERLAY")
    li:SetPoint("TOPLEFT", f, 0, 8)
    li:SetSize(10,10)
    f.Leader = li
    ai = h:CreateTexture(nil, "OVERLAY")
    ai:SetPoint("TOPLEFT", f, 0, 8)
    ai:SetSize(10,10)
    f.Assistant = ai
    local ml = h:CreateTexture(nil, 'OVERLAY')
    ml:SetSize(8,8)
    ml:SetPoint('LEFT', f.Leader, 'RIGHT')
    f.MasterLooter = ml
end

lib.addPhaseIcon = function(self)
	local picon = self.Health:CreateTexture(nil, 'OVERLAY')
	picon:SetPoint('TOPRIGHT', self, 'TOPRIGHT', 40, 8)
	picon:SetSize(12, 12)
	self.PhaseIcon = picon
end

lib.addQuestIcon = function(self)
	local qicon = self.Health:CreateTexture(nil, 'OVERLAY')
	qicon:SetPoint('TOPLEFT', self, 'TOPLEFT', 0, 8)
	qicon:SetSize(12, 12)
	self.QuestIcon = qicon
end

lib.gen_RaidMark = function(f)
	local h = CreateFrame("Frame", nil, f)
	h:SetAllPoints(f)
	h:SetFrameLevel(10)
	h:SetAlpha(0.8)
	local ri = h:CreateTexture(nil,'HIGHLIGHT ',h)
	ri:SetPoint("CENTER", f, "TOP", 0, 2)
	local size = retVal(f, 12, 11, 9)
	ri:SetTexture(cfg.raidmarkicon)
	ri:SetSize(size, size)
	f.RaidIcon = ri
end

--gen hilight texture
lib.gen_highlight = function(f)
	local OnEnter = function(f)
		UnitFrame_OnEnter(f)
		f.Highlight:Show()
	end
	local OnLeave = function(f)
	  UnitFrame_OnLeave(f)
	  f.Highlight:Hide()
	end
	f:SetScript("OnEnter", OnEnter)
	f:SetScript("OnLeave", OnLeave)
	local hl = f.Health:CreateTexture(nil, "OVERLAY")
	hl:SetAllPoints(f.Health)
	hl:SetTexture(cfg.highlight_texture)
	hl:SetVertexColor(.5,.5,.5,.1)
	hl:SetBlendMode("ADD")
	hl:Hide()
	f.Highlight = hl
end

-- Target Border
function lib.CreateTargetBorder(self)
	local glowBorder = {edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1}
	self.TargetBorder = CreateFrame("Frame", nil, self)
	if self.mystyle == "raid25" then
	self.TargetBorder:SetPoint("TOPLEFT", self, "TOPLEFT", -6, 2)
	self.TargetBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 2, 3)
	else
	self.TargetBorder:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2)
	self.TargetBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 2, 1)
	end
	self.TargetBorder:SetBackdrop(glowBorder)
	self.TargetBorder:SetFrameLevel(2)
	self.TargetBorder:SetBackdropBorderColor(.6,.6,.6,1)
	self.TargetBorder:Hide()
end

-- Target Border Updater
function lib.ChangedTarget(self, event, unit)
	if UnitIsUnit('target', self.unit) then
		self.TargetBorder:Show()
	else
		self.TargetBorder:Hide()
	end
end

-- Create Raid Threat Status Border
function lib.CreateThreatBorder(self)
	local glowBorder = {edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 2}
	self.Thtborder = CreateFrame("Frame", nil, self)
	if self.mystyle == "raid25" then
	self.Thtborder:SetPoint("TOPLEFT", self, "TOPLEFT", -6, 2)
	self.Thtborder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 2, 3)
	else
	self.Thtborder:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2)
	self.Thtborder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 2, -2)
	end
	self.Thtborder:SetBackdrop(glowBorder)
	self.Thtborder:SetFrameLevel(1)
	self.Thtborder:Hide()	
end

-- Raid Frames Threat Highlight
function lib.UpdateThreat(self, event, unit)
	if (self.unit ~= unit) then return end
		local status = UnitThreatSituation(unit)
		unit = unit or self.unit
	if status and status > 1 then
		local r, g, b = GetThreatStatusColor(status)
		self.Thtborder:Show()
		self.Thtborder:SetBackdropBorderColor(r, g, b, 1)
	else
		self.Thtborder:SetBackdropBorderColor(r, g, b, 0)
		self.Thtborder:Hide()
	end
end

---- Castbar
lib.gen_castbar = function(f)
	if not cfg.Castbars then return end
	local cbColor = {95/255, 182/255, 255/255}
	local s = CreateFrame("StatusBar", "oUF_Castbar"..f.mystyle, f)
	s:SetHeight(cfg.unit_size.CastbarFocus.h)
	s:SetWidth(f:GetWidth()-22)
	if f.mystyle == "focus" then
		s:SetWidth(cfg.unit_size.Focus.w-26)
	end
	if f.mystyle == "player" then
		s:SetHeight(cfg.unit_size.CastbarPlayer.h)
		s:SetWidth(cfg.unit_size.Player.w+33)
		if cfg.HealFrames then
				s:SetPoint("BOTTOM", Anchorviksplayercastbar)
			else
				s:SetPoint("BOTTOM", AnchorviksplayercastbarDps)
			end
	elseif f.mystyle == "target" then
		s:SetHeight(cfg.unit_size.CastbarTarget.h)
		s:SetWidth(cfg.unit_size.Target.w+33)
		if cfg.HealFrames then
				s:SetPoint("BOTTOM", Anchorvikstargetcastbar)
			else
				s:SetPoint("BOTTOM", AnchorvikstargetcastbarDps)
			end
	elseif f.mystyle == "arena" then
		s:SetHeight(cfg.unit_size.CastbarArena.h)
		s:SetWidth(cfg.unit_size.Arena.w+33)
		if cfg.HealFrames then
			s:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",0,-31)
		else
			s:SetPoint("TOPRIGHT",f,"BOTTOMRIGHT",cfg.unit_positions.ACastbar.x,cfg.unit_positions.ACastbar.y)
		end	
	elseif f.mystyle == "party" then
		s:SetPoint("CENTER",UIParent,"CENTER",10,100)
	elseif f.mystyle == "focus" then
		if cfg.HealFrames then
			s:SetPoint("BOTTOM", Anchorviksfocuscastbar)
			else
			s:SetPoint("BOTTOM", AnchorviksfocuscastbarDps)
			end
	end
	if f.mystyle == "boss" then
		s:SetHeight(cfg.unit_size.CastbarBoss.h)
		s:SetWidth(cfg.unit_size.Boss.w)
		s:SetPoint("TOPRIGHT",f,"BOTTOMRIGHT",0,-16)
	end
	s:SetStatusBarTexture(cfg.statusbar_texture)
	s:SetStatusBarColor(95/255, 182/255, 255/255,1)
	s:SetFrameLevel(1)
	--Color
	s.CastingColor = cbColor
	s.CompleteColor = {20/255, 208/255, 0/255}
	s.FailColor = {255/255, 12/255, 0/255}
	s.ChannelingColor = cbColor
	--Helper
	local h = CreateFrame("Frame", nil, s)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	frame1px2_2(h)
	CreateShadow_1(h)
	--Spark
	sp = s:CreateTexture(nil, "OVERLAY")
	sp:SetBlendMode("ADD")
	sp:SetAlpha(0.5)
	sp:SetHeight(s:GetHeight()*2.5)
	--Spell Text
	local txt = lib.gen_fontstring(s, cfg.oUFfont, 12, "NONE")
	txt:SetPoint("LEFT", 2, 0)
	txt:SetJustifyH("LEFT")
	--Time
	local t = lib.gen_fontstring(s, cfg.oUFfont, 10, "NONE")
	t:SetPoint("RIGHT", -2, 0)
	txt:SetPoint("RIGHT", t, "LEFT", -5, 0)
	--Icon
	local i = s:CreateTexture(nil, "ARTWORK")
	i:SetSize(s:GetHeight()+2,s:GetHeight()+2)
	if f.mystyle == "target" or f.mystyle == "arena" then
		i:SetSize(s:GetHeight()+2,s:GetHeight()+2)
	end
	i:SetPoint("RIGHT", s, "LEFT", -8, 0)
	i:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	--Helper 2 For Icon
	local h2 = CreateFrame("Frame", nil, s)
	h2:SetFrameLevel(0)
	h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
	h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
	frame(h2)
	CreateShadow1_1(h2)

	if f.mystyle == "player" then
		--Latency (Only for Player Unit)
		local z = s:CreateTexture(nil,"OVERLAY")
		z:SetTexture(cfg.statusbar_texture)
		z:SetVertexColor(1,0.1,0,.6)
		z:SetPoint("TOPRIGHT")
		z:SetPoint("BOTTOMRIGHT")
		s:SetFrameLevel(10)
		s.SafeZone = z
		-- Custom Latency Display
		local l = lib.gen_fontstring(s, cfg.oUFfont, 10, "OUTLINE")
		l:SetPoint("CENTER", -2, 17)
		l:SetJustifyH("RIGHT")
		l:Hide()
		s.Lag = l
		f:RegisterEvent("UNIT_SPELLCAST_SENT", cast.OnCastSent)
	end
	s.OnUpdate = cast.OnCastbarUpdate
	s.PostCastStart = cast.PostCastStart
	s.PostChannelStart = cast.PostCastStart
	s.PostCastStop = cast.PostCastStop
	s.PostChannelStop = cast.PostChannelStop
	s.PostCastFailed = cast.PostCastFailed
	s.PostCastInterrupted = cast.PostCastFailed
	
	f.Castbar = s
	f.Castbar.Text = txt
	f.Castbar.Time = t
	f.Castbar.Icon = i
	f.Castbar.Spark = sp
end


-- mirror castbar!
lib.gen_mirrorcb = function(f)
	for _, bar in pairs({'MirrorTimer1','MirrorTimer2','MirrorTimer3',}) do   
	  for i, region in pairs({_G[bar]:GetRegions()}) do
		if (region.GetTexture and region:GetTexture() == cfg.statusbar_texture) then
		  region:Hide()
		end
	  end
	  _G[bar..'Border']:Hide()
	  _G[bar]:SetParent(UIParent)
	  _G[bar]:SetScale(1)
	  _G[bar]:SetHeight(15)
	  _G[bar]:SetWidth(280)
	  _G[bar]:SetBackdropColor(.1,.1,.1)
	  _G[bar..'Background'] = _G[bar]:CreateTexture(bar..'Background', 'BACKGROUND', _G[bar])
	  _G[bar..'Background']:SetTexture(cfg.statusbar_texture)
	  _G[bar..'Background']:SetAllPoints(bar)
	  _G[bar..'Background']:SetVertexColor(.15,.15,.15,.75)
	  _G[bar..'Text']:SetFont(cfg.font, 13)
	  _G[bar..'Text']:ClearAllPoints()
	  _G[bar..'Text']:SetPoint('CENTER', MirrorTimer1StatusBar, 0, 1)
	  _G[bar..'StatusBar']:SetAllPoints(_G[bar])
	  --glowing borders
	  local h = CreateFrame("Frame", nil, _G[bar])
	  h:SetFrameLevel(0)
	  h:SetPoint("TOPLEFT",-5,5)
	  h:SetPoint("BOTTOMRIGHT",5,-5)
	  frame11px_1(h)
	  CreateShadow_1(h)
	end
end

local myPostCreateIcon = function(self, button)
	self.showDebuffType = true
	self.disableCooldown = true
	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.icon:SetTexCoord(.07, .93, .07, .93)
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	button.overlay:SetTexture(border)
	button.overlay:SetTexCoord(0,1,0,1)
	button.overlay.Hide = function(self) self:SetVertexColor(0.3, 0.3, 0.3) end
	button.time = lib.gen_fontstring(button, cfg.pixelfont, 10, "THINOUTLINE")
	button.time:SetPoint("CENTER", button, 2, 0)
	button.time:SetJustifyH('CENTER')
	button.time:SetVertexColor(1,1,1)
	button.count = lib.gen_fontstring(button, cfg.pixelfont, 10, "THINOUTLINE")
	button.count:ClearAllPoints()
	button.count:SetPoint("BOTTOMRIGHT", button, 7, -5)
	button.count:SetVertexColor(1,1,1)	
	local h = CreateFrame("Frame", nil, button)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	frame1px1(h)
	CreateShadow(h)
end
local updateTooltip = function(self)
	GameTooltip:SetUnitAura(self:GetParent().__owner.unit, self:GetID(), self.filter)

	if self.owner and UnitExists(self.owner) then
		GameTooltip:AddLine(format("|cff1369ca* Cast by %s|r", UnitName(self.owner) or UNKNOWN))
	end

	GameTooltip:Show()
end	

-----------------------------------------------------------------------------------
local formatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s/day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s/hour + 0.5)), s % hour
	elseif s >= minute then
		if s <= minute * 5 then
			return format("%d:%02d", floor(s/60), s % minute), s - floor(s)
		end
		return format("%d", floor(s/minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100))/100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100
end

-- Create Buff/Debuff Timer Function 
local setTimer = function (self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = formatTime(self.timeLeft)
					self.time:SetText(time)
				if self.timeLeft < 5 then
					self.time:SetTextColor(1, 0.5, 0.5)
				else
					self.time:SetTextColor(.7, .7, .7)
				end
			else
				self.time:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

-- Post Create Icon Function
local postCreateIcon = function(element, button)
	local diffPos = 0
	local self = element:GetParent()
	if self.mystyle == "target" then diffPos = 1 end
	--if self.mystyle == "arena" then diffPos = 1 end
	
	element.disableCooldown = true
	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	
	local h = CreateFrame("Frame", nil, button)
	h:SetFrameLevel(0)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	local count = lib.gen_fontstring(button, cfg.pixelfont, 10, "OUTLINE")
	count:SetPoint("CENTER", button, "BOTTOMRIGHT", 0, 3)
	count:SetJustifyH("RIGHT")
	--CreateShadowClassbar3(h)
		if self.mystyle == "player" then
		local time = lib.gen_fontstring(button, cfg.pixelfont, 15, "OUTLINE")
		time:SetPoint("CENTER", button, "CENTER", 1, 0)
		time:SetJustifyH("CENTER")
		time:SetVertexColor(1,1,1)
		button.time = time
		frame1px1(h)
	elseif self.mystyle == "raid25" then
		local time = lib.gen_fontstring(button, cfg.pixelfont, 1, "OUTLINE")
		time:SetAlpha(0)
		button.time = time
	elseif self.mystyle == "tank" then 
		local count = lib.gen_fontstring(button, cfg.pixelfont, 8, "THINOUTLINE")
		local time = lib.gen_fontstring(button, cfg.pixelfont, 8, "THINOUTLINE")
		time:SetPoint("CENTER", button, "CENTER", 1, 0)
		time:SetJustifyH("CENTER")
		time:SetVertexColor(1,1,1)
		button.time = time
	else
		local time = lib.gen_fontstring(button, cfg.pixelfont, 10, "OUTLINE")
		time:SetPoint("CENTER", button, "CENTER", 1, 0)
		time:SetJustifyH("CENTER")
		time:SetVertexColor(1,1,1)
		button.time = time
		frame1px1(h)
		end
	
	button.count = count
	button.UpdateTooltip = updateTooltip		
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer("ARTWORK")
end

-- Post Update Icon Function
local postUpdateIcon = function(element, unit, button, index)
	local _, _, _, _, _, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, button.filter)
	
	if duration and duration > 0 then
		button.time:Show()
		button.timeLeft = expirationTime	
		button:SetScript("OnUpdate", setTimer)			
	else
		button.time:Hide()
		button.timeLeft = math.huge
		button:SetScript("OnUpdate", nil)
	end
-- Desaturate non-Player Debuffs	
		if button.isPlayer or UnitIsFriend("player", unit) or not button.isDebuff then
				button.icon:SetDesaturated(false)                 
			elseif(not UnitPlayerControlled(unit)) then -- If Unit is Player Controlled don"t desaturate debuffs
				button:SetBackdropColor(0, 0, 0)
				button.overlay:SetVertexColor(0.3, 0.3, 0.3)      
				button.icon:SetDesaturated(true)  
				button.time:Hide()
			end


-- Right Click Cancel Buff/Debuff
	button:SetScript('OnMouseUp', function(self, mouseButton)
		if mouseButton == 'RightButton' then
			CancelUnitBuff('player', index)
	end end)
	button.first = true
end

 --Create Auras
	  lib.createAuras = function(f)
		Auras = CreateFrame("Frame", nil, f)
		Auras.size = 18		
		Auras:SetHeight(41)
		Auras:SetWidth(f:GetWidth())
		Auras.spacing = 7
		if f.mystyle == "target" then
			Auras:SetPoint("LEFT", f, "TOPRIGHT", 15, 5)
			Auras.numBuffs = 20
			Auras.numDebuffs = 15
			Auras.size = 17	
			--Auras.onlyShowPlayer = true
			Auras.spacing = 5.9
		end
		if f.mystyle == "arena" then
			Auras:SetPoint("LEFT", f, "LEFT", 0, -9)
			Auras.numBuffs = 0
			Auras.numDebuffs = 5
			Auras.spacing = 10
			Auras.size = 12			
		end		
		if f.mystyle == "tot" then
			Auras:SetPoint("LEFT", f, "LEFT", 0, -9)
			Auras.numBuffs = 0
			Auras.numDebuffs = 5
			Auras.spacing = 10
			Auras.size = 12			
		end
		if f.mystyle == "focus" then
		Auras.size = 14	
		Auras:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 1, 8)
			Auras.numBuffs = 2
			Auras.numDebuffs = 7
			Auras.spacing = 9
		end
		Auras.gap = true
		Auras.initialAnchor = "BOTTOMLEFT"
		Auras["growth-x"] = "RIGHT"		
		Auras["growth-y"] = "DOWN"
		Auras.PostCreateIcon = postCreateIcon
		Auras.PostUpdateIcon = postUpdateIcon
		f.Auras = Auras
		
			if f.mystyle == "oUF_MT" then
			Auras:SetPoint("CENTER", f, "RIGHT", 0, 0)
			Auras.numBuffs = 0
			Auras.numDebuffs = 5
			Auras.spacing = 10
			Auras.size = 16			
		end
	end

-- Generates the Buffs
lib.createBuffs = function(f)
	b = CreateFrame("Frame", nil, f)
	b.size = 20
	b.num = 40
	b.spacing = 8
	b.onlyShowPlayer = cfg.buffsOnlyShowPlayer
	b:SetHeight((b.size+b.spacing)*4)
	b:SetWidth(f:GetWidth())
	if f.mystyle == "target" then
		b.num = 8
		b:SetPoint("TOPLEFT", f, "TOPRIGHT", 20, 0)
		b.initialAnchor = "TOPLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "UP"
		b.spacing = 6
	elseif f.mystyle == "arena" then
		b.showBuffType = true
		b.size = 21
		b:SetPoint("CENTER", UIParent, "CENTER", -8, 0)
		b.initialAnchor = "TOPRIGHT"
		b["growth-x"] = "LEFT"
		b["growth-y"] = "DOWN"
		b.num = 5
	elseif f.mystyle == "player" then
		b.size = 28
		b.num = 60
		b:SetPoint("TOPRIGHT", AnchorviksBuff,  0, 0)
		b.initialAnchor = "TOPRIGHT"
		b["growth-x"] = "LEFT"
		b["growth-y"] = "DOWN"
	elseif f.mystyle == "boss" then
		b.size = 21
		b:SetPoint("TOPRIGHT", f, "TOPLEFT", -8, 0)
		b.initialAnchor = "TOPRIGHT"
		b["growth-x"] = "LEFT"
		b["growth-y"] = "DOWN"
		b.num = 5
	else
		b.num = 0
	end
	b.PostCreateIcon = postCreateIcon
	b.PostUpdateIcon = postUpdateIcon
	f.Buffs = b

end

-- Generates the Debuffs
lib.createDebuffs = function(f)
	b = CreateFrame("Frame", nil, f)
	b.size = 20
	b.num = 12
	b.onlyShowPlayer = cfg.debuffsOnlyShowPlayer
	b.spacing = 5
	b:SetHeight((b.size+b.spacing)*4)
	b:SetWidth(f:GetWidth())
	if f.mystyle == "target" or f.mystyle == "arena" then
		b.num = 8
		b:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", 20, 6)
		b.initialAnchor = "BOTTOMLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"
		b.spacing = 6
	elseif f.mystyle == "player" then
		b.size = 40
		b:SetPoint("TOPRIGHT", AnchorviksDeBuff, 0, 0)
		b.initialAnchor = "TOPRIGHT"
		b["growth-x"] = "LEFT"
		b["growth-y"] = "DOWN"
		b.spacing = 7.4
	elseif f.mystyle == "raid" then
		b.size = 14
		b:SetPoint("LEFT", f, "LEFT", 0, -5)
		b.initialAnchor = "LEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"
		b.spacing = 4
		b.num = 4
	elseif f.mystyle == "tank" then
		b.size = 16
		b:SetPoint("LEFT", f, "LEFT", 0, 0)
		b.initialAnchor = "RIGHT"
		b["growth-x"] = "LEFT"
		b["growth-y"] = "DOWN"
		b.spacing = 1
		b.num = 4
		b:SetFrameLevel(8)
	elseif f.mystyle == "raid25" then
		b.size = 10
		b:SetPoint("LEFT", f, "LEFT", 0, -10)
		b.initialAnchor = "LEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"
		b.spacing = 1
		b.num = 4
	else
		b.num = 0
	end
	b.PostCreateIcon = postCreateIcon
	b.PostUpdateIcon = postUpdateIcon
	f.Debuffs = b
end

lib.gen_WeaponEnchant = function(self)
	self.Enchant = CreateFrame("Frame", nil, self)
	self.Enchant:SetSize(52, 24)
	self.Enchant:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -25, -200)
	self.Enchant.size = 26
	self.Enchant.spacing = 6
	self.Enchant.initialAnchor = "LEFT"
	self.Enchant["growth-y"] = "RIGHT"
	self.Enchant:SetFrameLevel(10)

	self.PostCreateEnchantIcon = postCreateIcon
	self.PostUpdateEnchantIcon = postUpdateIcon
end
	
-- Portrait Update
lib.PortraitPostUpdate = function(element, unit)
	if not UnitExists(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit) then
		element:Hide()
	else
		element:Show()
		element:SetPortraitZoom(1)
	end
end
	
-- raid post update
lib.PostUpdateRaidFrame = function(Health, unit, min, max)
	local disconnnected = not UnitIsConnected(unit)
	local dead = UnitIsDead(unit)
	local ghost = UnitIsGhost(unit)
	if disconnnected or dead or ghost then
		Health:SetValue(max)	
		if(disconnnected) then
			Health:SetStatusBarColor(0,0,0,0.6)
		elseif(ghost) then
			Health:SetStatusBarColor(1,1,1,0.6)
		elseif(dead) then
			Health:SetStatusBarColor(1,0,0,0.7)
		end
	else
		Health:SetValue(min)
		if(unit == 'vehicle') then
			Health:SetStatusBarColor(22/255, 106/255, 44/255)
		end
	end
end
------------------------------
--Class Related stuff
------------------------------

-- BOOMKIN Eclipse Bar
local eclipseBarBuff = function(self, unit)
	if self.hasSolarEclipse then
		self.eBarBG:SetBackdropBorderColor(1,1,.5,.7)
	elseif self.hasLunarEclipse then
		self.eBarBG:SetBackdropBorderColor(.2,.2,1,.7)
	else
		self.eBarBG:SetBackdropBorderColor(0,0,0,1)
	end
end

lib.addEclipseBar = function(self)
	if playerClass ~= "DRUID" then return end
	
	local eclipseBar = CreateFrame('Frame', nil, self)
	eclipseBar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 1, 6)
	eclipseBar:CreateBackdrop("Default")
	eclipseBar:SetHeight(7)
    eclipseBar:SetWidth(self:GetWidth()-2)
		
	local lunarBar = CreateFrame('StatusBar', nil, eclipseBar)
	--lunarBar:SetPoint('LEFT', eclipseBar, 'LEFT', 0, 0)
	--lunarBar:SetSize(cfg.unit_size.Player.w, 5)
	--lunarBar:SetStatusBarTexture(cfg.statusbar_texture)
	--lunarBar:SetStatusBarColor(0, 0, 1)
	--eclipseBar.LunarBar = lunarBar

	lunarBar:SetPoint("LEFT", eclipseBar, "LEFT", 0, 0)
	lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
	lunarBar:SetStatusBarTexture(Viks.media.texture)
	lunarBar:SetStatusBarColor(0.80, 0.80, 0.20)
	eclipseBar.LunarBar = lunarBar
	
	local solarBar = CreateFrame('StatusBar', nil, eclipseBar)
	--solarBar:SetPoint('LEFT', lunarBar:GetStatusBarTexture(), 'RIGHT', 0, 0)
	--solarBar:SetSize(cfg.unit_size.Player.w, 5)
	--solarBar:SetStatusBarTexture(cfg.statusbar_texture)
	--solarBar:SetStatusBarColor(1, 3/5, 0)
	
	solarBar:SetPoint("LEFT", lunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
	solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
	solarBar:SetStatusBarTexture(Viks.media.texture)
	solarBar:SetStatusBarColor(0.30, 0.30, 0.80)
	eclipseBar.SolarBar = solarBar

	eclipseBar.Text = T.SetFontString(solarBar, Viks.font.unit_frames_font, Viks.font.unit_frames_font_size, Viks.font.unit_frames_font_style)
	eclipseBar.Text:SetPoint("CENTER", eclipseBar, "CENTER", -6, 0)
				
	local eclipseBarText = solarBar:CreateFontString(nil, 'OVERLAY')
	eclipseBarText:SetPoint("LEFT", eclipseBar.Text, "RIGHT", 2, 0)
	eclipseBarText:SetFont(cfg.oUFfont, 9, "OUTLINE")
	self:Tag(eclipseBarText, '[pereclipse]%')
	self.EclipseBar = eclipseBar
	
	eclipseBar:SetScript("OnShow", function() T.UpdateEclipse(self, false) end)
	eclipseBar:SetScript("OnUpdate", function() T.UpdateEclipse(self, true) end)
	eclipseBar:SetScript("OnHide", function() T.UpdateEclipse(self, false) end)
	self.EclipseBar.PostUpdatePower = T.EclipseDirection
end

--WARLOCK
lib.genShards = function(self)
    if playerClass ~= "WARLOCK" then return end
 
    local ShardsFrame = CreateFrame("Frame", self:GetName().."_WarlockSpecBar", self)
	ShardsFrame:CreateBackdrop("Default")
    ShardsFrame:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1,7)
    ShardsFrame:SetHeight(7)
    ShardsFrame:SetWidth(self:GetWidth()-2)
    ShardsFrame:SetFrameLevel(4)
    -- Tukz color scheme again
    local Colors = {  
    [1] = {109/255, 51/255, 188/255, 1},
    [2] = {139/255, 51/255, 188/255, 1},
    [3] = {179/255, 51/255, 188/255, 1},
    [4] = {209/255, 51/255, 188/255, 1},
    }
    local totalShards = 4 
        for i= 1, totalShards do
            local Shards = CreateFrame("StatusBar", nil, ShardsFrame)
            Shards:SetSize((ShardsFrame:GetWidth())/totalShards, 7)
            Shards:SetStatusBarTexture(cfg.statusbar_texture)
            Shards:SetFrameLevel(4)
			Shards:SetStatusBarColor(unpack(Colors[i]))
            local h = CreateFrame("Frame", nil, Shards)
            h:SetFrameLevel(1)
            h:SetPoint("TOPLEFT",-5,5)
            h:SetPoint("BOTTOMRIGHT",5,-5)
			--frame1px2_2(h)
            
            if (i == 1) then
                Shards:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
            else
                Shards:SetPoint("TOPLEFT", ShardsFrame[i-1], "TOPRIGHT", 1, 0)
            end
            
            ShardsFrame[i] = Shards
    end  
    self.WarlockSpecBars = ShardsFrame
end


-- Paladins, HolyPowerbar
lib.genHolyPower = function(self)
	if playerClass ~= "PALADIN" then return end
			self.HolyPower = CreateFrame("Frame", self:GetName().."_HolyPowerBar", self)
			self.HolyPower:CreateBackdrop("Default")
			self.HolyPower:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
			self.HolyPower:SetSize(self:GetWidth()-2, 7)

			for i = 1, 5 do
				self.HolyPower[i] = CreateFrame("StatusBar", nil, self.HolyPower)
				self.HolyPower[i]:SetSize((self:GetWidth()-6) / 5, 7)
				if i == 1 then
					self.HolyPower[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
				else
					self.HolyPower[i]:SetPoint("TOPLEFT", self.HolyPower[i-1], "TOPRIGHT", 1, 0)
				end
				self.HolyPower[i]:SetStatusBarTexture(Viks.media.texture)
				self.HolyPower[i]:SetStatusBarColor(0.89, 0.88, 0.1)

				self.HolyPower[i].bg = self.HolyPower[i]:CreateTexture(nil, "BORDER")
				self.HolyPower[i].bg:SetAllPoints()
				self.HolyPower[i].bg:SetTexture(Viks.media.texture)
				self.HolyPower[i].bg:SetVertexColor(0.89, 0.88, 0.1, 0.2)

				self.HolyPower[i].width = self.HolyPower[i]:GetWidth()
			end

			self.HolyPower.Override = T.UpdateHoly
end

-- Deathknight, runebar
lib.genRunes = function(self)
	if playerClass ~= "DEATHKNIGHT" then return end
	local runes = CreateFrame("Frame", nil, self)
	runes:SetPoint("BOTTOMLEFT", self, "TOPLEFT",1,7)
	runes:SetWidth(cfg.unit_size.Player.w - 2)
	runes:SetHeight(6)
	for i = 1, 6 do
		runes[i] = CreateFrame("StatusBar", nil, runes)
		runes[i]:SetHeight(runes:GetHeight())
		runes[i]:SetWidth((runes:GetWidth() - 5) / 6)
		if (i == 1) then
			runes[i]:SetPoint("LEFT", runes)
		else
			runes[i]:SetPoint("LEFT", runes[i-1], "RIGHT", 1, 0)
		end
		runes[i]:SetStatusBarTexture(cfg.statusbar_texture)
		runes[i]:GetStatusBarTexture():SetHorizTile(false)
	end
				
	runes.backdrop = CreateFrame("Frame", nil, runes)
	frame11px_1(runes.backdrop)
	runes.backdrop:SetBackdropBorderColor(unpack(cfg.bordercolor))
	runes.backdrop:SetPoint("TOPLEFT", -2, 2)
	runes.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	runes.backdrop:SetFrameLevel(runes:GetFrameLevel() - 1)
	self.Runes = runes
end

-- Combo Points
lib.genCPoints = function(self)
				self.CPoints = CreateFrame("Frame", self:GetName().."_ComboBar", self)
				self.CPoints:CreateBackdrop("Default")
				self.CPoints:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
				self.CPoints:SetBackdropBorderColor(unpack(cfg.bordercolor))
				self.CPoints:SetHeight(7)
				self.CPoints:SetWidth(self:GetWidth()-3)

				for i = 1, 5 do
					self.CPoints[i] = CreateFrame("StatusBar", nil, self.CPoints)
					self.CPoints[i]:SetSize((self.CPoints:GetWidth()-4) / 5, 7)
					if i == 1 then
						self.CPoints[i]:SetPoint("LEFT", self.CPoints, 0.5, 0)
					else
						self.CPoints[i]:SetPoint("LEFT", self.CPoints[i-1], "RIGHT", 1, 0)
					end
					self.CPoints[i]:SetStatusBarTexture(Viks.media.texture)
				end

				self.CPoints[1]:SetStatusBarColor(0.9, 0.1, 0.1)
				self.CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
				self.CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
				self.CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
				self.CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)

				self.CPoints.Override = T.UpdateComboPoint
end

lib.genHarmony = function(self)
if playerClass ~= "MONK" then return end
			self.HarmonyBar = CreateFrame("Frame", self:GetName().."_HarmonyBar", self)
			self.HarmonyBar:CreateBackdrop("Default")
			self.HarmonyBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
			self.HarmonyBar:SetSize((self:GetWidth()-2), 7)

			for i = 1, 5 do
				self.HarmonyBar[i] = CreateFrame("StatusBar", nil, self.HarmonyBar)
				self.HarmonyBar[i]:SetSize((self.HarmonyBar:GetWidth()-4) / 5, 7)
				if i == 1 then
					self.HarmonyBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
				else
					self.HarmonyBar[i]:SetPoint("TOPLEFT", self.HarmonyBar[i-1], "TOPRIGHT", 1, 0)
				end
				self.HarmonyBar[i]:SetStatusBarTexture(Viks.media.texture)
				self.HarmonyBar[i]:SetStatusBarColor(0.33, 0.63, 0.33)

				self.HarmonyBar[i].bg = self.HarmonyBar[i]:CreateTexture(nil, "BORDER")
				self.HarmonyBar[i].bg:SetAllPoints()
				self.HarmonyBar[i].bg:SetTexture(Viks.media.texture)
				self.HarmonyBar[i].bg:SetVertexColor(0.33, 0.63, 0.33, 0.2)
			end
end

lib.genShadowOrbsBar = function(self)
	if playerClass ~= "PRIEST" then return end
			self.ShadowOrbsBar = CreateFrame("Frame", nil, self)
			self.ShadowOrbsBar:CreateBackdrop("Default")
			self.ShadowOrbsBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
			self.ShadowOrbsBar:SetHeight(7)
			self.ShadowOrbsBar:SetWidth(self:GetWidth()-2)
			
			for i = 1, 5 do
				self.ShadowOrbsBar[i] = CreateFrame("StatusBar", nil, self.ShadowOrbsBar)
				self.ShadowOrbsBar[i]:SetSize((self.Health:GetWidth()-6) / 5, 7)
				if i == 1 then
					self.ShadowOrbsBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
				else
					self.ShadowOrbsBar[i]:SetPoint("TOPLEFT", self.ShadowOrbsBar[i-1], "TOPRIGHT", 1, 0)
				end
				self.ShadowOrbsBar[i]:SetStatusBarTexture(Viks.media.texture)
				self.ShadowOrbsBar[i]:SetStatusBarColor(0.70, 0.32, 0.75)

				self.ShadowOrbsBar[i].bg = self.ShadowOrbsBar[i]:CreateTexture(nil, "BORDER")
				self.ShadowOrbsBar[i].bg:SetAllPoints()
				self.ShadowOrbsBar[i].bg:SetTexture(Viks.media.texture)
				self.ShadowOrbsBar[i].bg:SetVertexColor(0.70, 0.32, 0.75, 0.2)
			end

			self.ShadowOrbsBar = self.ShadowOrbsBar
end
	--f:SetBackdropColor(unpack(cfg.backdropcolor))
	--f:SetBackdropBorderColor(unpack(cfg.bordercolor))
lib.AltPowerBar = function(self)
	local AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
	AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	
	AltPowerBar:SetStatusBarTexture(cfg.statusbar_texture)
	AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
	AltPowerBar:EnableMouse(true)
	AltPowerBar:SetFrameStrata("HIGH")
	AltPowerBar:SetFrameLevel(5)
	
	if self.unit == "boss" then
		AltPowerBar:SetPoint("BOTTOM", self, "BOTTOM", 0, -2)
		AltPowerBar:SetWidth(self:GetWidth()-30)
		AltPowerBar:SetHeight(5)
	elseif self.unit == "pet" then
		AltPowerBar:SetPoint("BOTTOM", self, "BOTTOM", 0, -2)
		AltPowerBar:SetWidth(self:GetWidth())
		AltPowerBar:SetHeight(6)
	else
	AltPowerBar:SetPoint('BOTTOM', self,'BOTTOM', 0, -21)
	AltPowerBar:SetWidth(self:GetWidth())
	AltPowerBar:SetHeight(5)
	end
			
	local h = CreateFrame("Frame", nil, AltPowerBar)
	h:SetFrameLevel(4)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	frame1px2_2(h)
	CreateShadow(h)
				
	AltPowerBar.text = SetFontString(AltPowerBar, cfg.oUFfont, 9, "OUTLINE")
	AltPowerBar.text:SetPoint("CENTER")
	AltPowerBar.text:SetJustifyH("CENTER")
	self:Tag(AltPowerBar.text, '[altpower]')
		
	AltPowerBar:HookScript("OnShow", AltPowerBarOnToggle)
	AltPowerBar:HookScript("OnHide", AltPowerBarOnToggle)
	self.AltPowerBar = AltPowerBar		
	self.AltPowerBar.PostUpdate = AltPowerBarPostUpdate
end

lib.TotemBars = function(self)
if cfg.TotemBars then
	if playerClass ~= "SHAMAN" then return end
	local totems = CreateFrame("Frame", nil, self)
	totems:SetPoint("BOTTOMLEFT", self, "TOPLEFT",1,7)
	totems:SetWidth(self.Health:GetWidth()-2)
	totems:SetHeight(5)
	totems:SetFrameLevel(6)
	totems.Destroy = true
	totems.colors = {{233/255, 46/255, 16/255};{173/255, 217/255, 25/255};{35/255, 127/255, 255/255};{178/255, 53/255, 240/255};}
			
	for i = 1, 4 do
		totems[i] = CreateFrame("StatusBar", nil, totems)
		totems[i]:SetHeight(totems:GetHeight())
		totems[i]:SetWidth((self.Health:GetWidth() - 5) / 4)

		if (i == 1) then
			totems[i]:SetPoint("LEFT", totems)
		else
			totems[i]:SetPoint("LEFT", totems[i-1], "RIGHT", 1, 0)
		end
		totems[i]:SetStatusBarTexture(cfg.statusbar_texture)
		totems[i]:GetStatusBarTexture():SetHorizTile(false)
		totems[i]:SetMinMaxValues(0, 1)

		totems[i].bg = totems[i]:CreateTexture(nil, "BORDER")
		totems[i].bg:SetAllPoints()
		totems[i].bg:SetTexture(cfg.statusbar_texture)
		totems[i].bg.multiplier = 0.3
	end
	totems.backdrop = CreateFrame("Frame", nil, totems)
	
	frame11px_1(totems.backdrop)
	--CreateShadow(totems.backdrop)
	totems.backdrop:SetBackdropBorderColor(unpack(cfg.bordercolor))
	totems.backdrop:SetPoint("TOPLEFT", -2, 2)
	totems.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	totems.backdrop:SetFrameLevel(totems:GetFrameLevel() - 1)
	self.TotemBar = totems			
	end
end

-- Vengeance bar
lib.Vengeance = function(self)
		self.VengeanceBar = CreateFrame("Frame", self:GetName().."_VengeanceBar", self)
		self.VengeanceBar:CreateBackdrop("Default")
		if (playerClass == "PALADIN" and Viks.unitframe_class_bar.holy == true)
		or (playerClass == "DEATHKNIGHT" and Viks.unitframe_class_bar.rune == true)
		or (playerClass == "MONK" and Viks.unitframe_class_bar.chi == true) then
			self.VengeanceBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 21)
		else
			self.VengeanceBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 1, 7)
		end
		self.VengeanceBar:SetSize(self:GetWidth()-2, 7)

		self.VengeanceBar.Bar = CreateFrame("StatusBar", nil, self.VengeanceBar)
		self.VengeanceBar.Bar:SetPoint("LEFT", self.VengeanceBar, "LEFT", 0, 0)
		self.VengeanceBar.Bar:SetSize(self.VengeanceBar:GetWidth()-2, 7)
		self.VengeanceBar.Bar:SetStatusBarTexture(Viks.media.texture)
		self.VengeanceBar.Bar:SetStatusBarColor(T.color.r, T.color.g, T.color.b)

		self.VengeanceBar.bg = self.VengeanceBar.Bar:CreateTexture(nil, "BORDER")
		self.VengeanceBar.bg:SetAllPoints()
		self.VengeanceBar.bg:SetTexture(Viks.media.texture)
		self.VengeanceBar.bg:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.2)

		self.VengeanceBar.Text = T.SetFontString(self.VengeanceBar.Bar, Viks.font.unit_frames_font, Viks.font.unit_frames_font_size, Viks.font.unit_frames_font_style)
		self.VengeanceBar.Text:SetPoint("CENTER", self.VengeanceBar.Bar, "CENTER", 0, 0)
end


lib.Experience = function(self)
	if cfg.Experiencebar then 
	local Experience = CreateFrame('StatusBar', nil, self)
	Experience:SetStatusBarTexture(cfg.statusbar_texture)
	Experience:SetStatusBarColor(0, 0.7, 1)
	Experience:SetPoint('RIGHT', oUF_Player,'RIGHT', 10, -6)
	Experience:SetHeight(31)
	Experience:SetWidth(3)
	Experience:SetFrameLevel(2)
	Experience.Tooltip = true
	Experience:SetOrientation("VERTICAL")
	
	local h = CreateFrame("Frame", nil, Experience)
	h:SetFrameLevel(1)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	frame1px2_2(h)
	CreateShadow(h)
				
	local Rested = CreateFrame('StatusBar', nil, Experience)
	Rested:SetStatusBarTexture(cfg.statusbar_texture)
	Rested:SetStatusBarColor(0, 0.4, 1, 0.4)
	Rested:SetFrameLevel(2)
	Rested:SetOrientation("VERTICAL")
	Rested:SetAllPoints(Experience)
				
	self.Experience = Experience
	self.Experience.Rested = Rested
	self.Experience.PostUpdate = ExperiencePostUpdate
	end
end

lib.Reputation = function(self)
	if cfg.Reputationbar then 
	local Reputation = CreateFrame('StatusBar', nil, self)
	Reputation:SetStatusBarTexture(cfg.statusbar_texture)
	Reputation:SetWidth(3)
	Reputation:SetHeight(31)
	
	Reputation:SetPoint('RIGHT', oUF_Player,'RIGHT', 10, -6)
	Reputation:SetFrameLevel(2)
	Reputation:SetOrientation("VERTICAL")
	
	local h = CreateFrame("Frame", nil, Reputation)
	h:SetFrameLevel(1)
	h:SetPoint("TOPLEFT",-5,5)
	h:SetPoint("BOTTOMRIGHT",5,-5)
	frame1px2_2(h)
	CreateShadow(h)
	
	Reputation.PostUpdate = UpdateReputationColor
	Reputation.Tooltip = true
	self.Reputation = Reputation
	end
end

lib.ReadyCheck = function(self)
	if cfg.RCheckIcon then
		rCheck = self.Health:CreateTexture(nil, "OVERLAY")
		rCheck:SetSize(18, 18)
		rCheck:SetPoint("BOTTOMLEFT", self.Health, "TOP", -13, -12)
		rCheck.finishedTimer = 10
		rCheck.fadeTimer = 3
		self.ReadyCheck = rCheck
	end
end

-- raid debuffs
lib.raidDebuffs = function(f)
	if cfg.showRaidDebuffs then
		local raid_debuffs = cfg.DebuffWatchList

		local instDebuffs = {}
		local instances = raid_debuffs.instances
		local getzone = function()
			local zone = GetInstanceInfo()
			if instances[zone] then
				instDebuffs = instances[zone]
			else
				instDebuffs = {}
			end
		end

		local debuffs = raid_debuffs.debuffs
		local CustomFilter = function(icons, ...)
			local _, icon, name, _, _, _, dtype = ...
			if instDebuffs[name] then
				icon.priority = instDebuffs[name]
				return true
			elseif debuffs[name] then
				icon.priority = debuffs[name]
				return true
			else
				icon.priority = 0
			end
		end
		--if f.mystyle == "raid25" then
		local dbsize = 10
		local debuffs = CreateFrame("Frame", nil, f)
		debuffs:SetWidth(dbsize) debuffs:SetHeight(dbsize)
		debuffs:SetPoint("TOPRIGHT", -10, 3)
		debuffs.size = dbsize
		
		debuffs.CustomFilter = CustomFilter
		f.raidDebuffs = debuffs
	end
end

lib.debuffHighlight = function(self)
	if cfg.enableDebuffHighlight then
		local dbh = self.Health:CreateTexture(nil, "OVERLAY")
		dbh:SetAllPoints(self.Health)
		dbh:SetTexture(cfg.statusbar_texture)
		dbh:SetBlendMode("ADD")
		dbh:SetVertexColor(0,0,0,1) -- set alpha to 0 to hide the texture
		self.DebuffHighlight = dbh
		self.DebuffHighlightAlpha = 0.5
		self.DebuffHighlightFilter = true
	end
end

local AWPostCreateIcon = function(AWatch, icon, spellID, name, self)
	icon.cd:SetReverse(true)
	local count = lib.gen_fontstring(icon, cfg.pixelfont, 10, "OUTLINE")
	count:SetPoint("CENTER", icon, "BOTTOM", 3, 3)
	icon.count = count		
	local h = CreateFrame("Frame", nil, icon)
	h:SetFrameLevel(4)
	h:SetPoint("TOPLEFT",-3,3)
	h:SetPoint("BOTTOMRIGHT",3,-3)
end

lib.createAuraWatch = function(self, unit)
	if cfg.showAuraWatch then
		local auras = {}
		local spellIDs = cfg.AuraWatchList
		auras.onlyShowPresent = true
		auras.anyUnit = true
		auras.PostCreateIcon = AWPostCreateIcon
		-- Set any other AuraWatch settings
		auras.icons = {}
		for i, sid in pairs(spellIDs[playerClass]) do
			local icon = CreateFrame("Frame", nil, self)
			icon.spellID = sid
			-- set the dimensions and positions
			icon:SetWidth(12)
			icon:SetHeight(12)
			icon:SetFrameLevel(5)
			icon:SetPoint("TOPRIGHT", self, "TOPLEFT", 9 * i, 1)
			auras.icons[sid] = icon
		end
		self.AuraWatch = auras
	end
end

lib.createIndicators = function(self, unit)
	if cfg.showIndicators then
		local auraStatus
		auraStatus = self:CreateFontString(nil, "ARTWORK")
		auraStatus:SetPoint("TOPLEFT", -5, 5)
		auraStatus:SetFont(cfg.font, 10, "THINOUTLINE")
		self:Tag(auraStatus, oUF.Indicators["TL"])	
		self.AuraStatusTopLeft = auraStatus	
		auraStatus = self:CreateFontString(nil, "OVERLAY")
		auraStatus:SetPoint("TOPRIGHT", 5, 5)
		auraStatus:SetFont(cfg.font, 10, "OUTLINE")
		self:Tag(auraStatus, oUF.Indicators["TR"])		
		self.AuraStatusTopRight = auraStatus	
		auraStatus = self:CreateFontString(nil, "ARTWORK")
		auraStatus:ClearAllPoints()
		auraStatus:SetPoint("BOTTOMLEFT", -5, -5)
		auraStatus:SetFont(cfg.font, 10, "THINOUTLINE")
		self:Tag(auraStatus, oUF.Indicators["BL"])		
		self.AuraStatusBottomLeft = auraStatus		
		auraStatus = self:CreateFontString(nil, "ARTWORK")
		auraStatus:SetPoint("CENTER", self, "BOTTOMRIGHT", 8, -8)
		auraStatus:SetFont(cfg.font, 11, "THINOUTLINE")
		self:Tag(auraStatus, oUF.Indicators["BR"])		
		self.AuraStatusBottomRight = auraStatus
	end
end

-- oUF_HealPred
lib.healcomm = function(self, unit)
if cfg.ShowIncHeals then
		local mhpb = CreateFrame('StatusBar', nil, self.Health)
		mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
		mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
		mhpb:SetWidth(self:GetWidth())
		mhpb:SetStatusBarTexture(cfg.statusbar_texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
		local ohpb = CreateFrame('StatusBar', nil, self.Health)
		ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
		ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
		ohpb:SetWidth(self:GetWidth())
		ohpb:SetStatusBarTexture(cfg.statusbar_texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)
		self.HealPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1.1,
		}
	end
end
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
  --gen trinket and aura tracker for arena frames
  lib.UpdateAuraTracker = function(self, elapsed)
	if self.active then
	  self.timeleft = self.timeleft - elapsed
	  if self.timeleft <= 5 then
		self.text:SetTextColor(1, .3, .2)
	  else
		self.text:SetTextColor(.9, .7, .2)
	  end
	  if self.timeleft <= 0 then
		self.icon:SetTexture('')
		self.text:SetText('')
	  end	
	  self.text:SetFormattedText('%.1f', self.timeleft)
	end
  end
  
  lib.gen_arenatracker = function(f)
    t = CreateFrame("Frame", nil, f)
    t:SetSize(21,21)
    t:SetPoint("CENTER", f.Power, "CENTER", 0, 0)
    t:SetFrameLevel(30)
    t:SetAlpha(0.8)
    t.trinketUseAnnounce = true
    t.bg = CreateFrame("Frame", nil, t)
    t.bg:SetPoint("TOPLEFT",-4,4)
    t.bg:SetPoint("BOTTOMRIGHT",4,-4)
    t.bg:SetBackdrop(backdrop_tab);
    t.bg:SetBackdropColor(0,0,0,0)
    t.bg:SetBackdropBorderColor(0,0,0,1)
    f.Trinket = t
	at = CreateFrame('Frame', nil, f)
	at:SetAllPoints(f.Trinket)
	at:SetFrameStrata('HIGH')
	at.icon = at:CreateTexture(nil, 'ARTWORK')
	at.icon:SetAllPoints(at)
	at.icon:SetTexCoord(0.07,0.93,0.07,0.93)
	at.text = lib.gen_fontstring(at, cfg.pixelfont, cfg.ATSize-1, "THINOUTLINE")
	at.text:SetPoint('CENTER', at, 0, 0)
	at:SetScript('OnUpdate', lib.UpdateAuraTracker)
	f.AuraTracker = at
  end
  
  --gen current target indicator
  lib.gen_targeticon = function(f)
    local h = CreateFrame("Frame", nil, f)
    h:SetAllPoints(f.Health)
    h:SetFrameLevel(10)
    local ti = lib.gen_fontstring(h, cfg.pixelfont, 12, "THINOUTLINE")
    ti:SetPoint("LEFT", f.Health, "BOTTOMLEFT",-5,0)
    ti:SetJustifyH("LEFT")
    f:Tag(ti, '[mono:targeticon]')
  end
  
  --gen fake target bars
  lib.gen_faketarget = function(f)
    local fhp = CreateFrame("frame","FakeHealthBar",UIParent) 
    fhp:SetAlpha(.6)
    fhp:SetSize(f.width,f.height)
    fhp:SetPoint("TOPLEFT",oUF_monoTargetFrame,"TOPLEFT",0,0)
    fhp.bg = fhp:CreateTexture(nil, "PARENT")
    fhp.bg:SetTexture(cfg.statusbar_texture)
    fhp.bg:ClearAllPoints()
    fhp.bg:SetAllPoints(fhp)
    fhp.bg:SetVertexColor(.3,.3,.3)
    local h = CreateFrame("Frame",nil,fhp)
    h:SetBackdrop(backdrop_tab)
    h:SetPoint("TOPLEFT",-3.5,3.5)
    h:SetPoint("BOTTOMRIGHT",3.5,-3.5)
    h:SetBackdropColor(0,0,0,0)
    h:SetBackdropBorderColor(0,0,0,.7)

    local fpp = CreateFrame("frame","FakeManaBar",fhp)
    fpp:SetWidth(fhp:GetWidth())
    fpp:SetHeight(f.height/3)
    fpp:SetPoint("TOPLEFT",FakeHealthBar,"BOTTOMLEFT",0,-2)
    fpp.bg = fpp:CreateTexture(nil, "PARENT")
    fpp.bg:SetTexture(cfg.statusbar_texture)
    fpp.bg:ClearAllPoints()
    fpp.bg:SetAllPoints(fpp)
    fpp.bg:SetVertexColor(.30,.45,.65)
    local h2 = CreateFrame("Frame",nil,fpp)
    h2:SetBackdrop(backdrop_tab)
    h2:SetPoint("TOPLEFT",-3.5,5)
    h2:SetPoint("BOTTOMRIGHT",3.5,-5)
    h2:SetBackdropColor(0,0,0,0)
    h2:SetBackdropBorderColor(0,0,0,1)

    fhp:RegisterEvent('PLAYER_TARGET_CHANGED')
    fhp:SetScript('OnEvent', function(self)
      if UnitExists("target") then
        self:Hide()
      else
        self:Show()
      end
    end)
  end
  
  -- oUF_CombatFeedback
  lib.gen_combat_feedback = function(f)
	if cfg.EnableCombatFeedback then
		local h = CreateFrame("Frame", nil, f.Health)
		h:SetAllPoints(f.Health)
		h:SetFrameLevel(30)
		local cfbt = lib.gen_fontstring(h, cfg.font, 18, "THINOUTLINE")
		cfbt:SetPoint("CENTER", f.Health, "BOTTOM", 0, -1)
		cfbt.maxAlpha = 0.75
		cfbt.ignoreEnergize = true
		f.CombatFeedbackText = cfbt
	end
  end
  
  -- oUF_Swing
  lib.gen_swing_timer = function(f)
	if not IsAddOnLoaded("oUF_Swing") then return end
	if cfg.EnableSwingTimer then
		sw = CreateFrame("StatusBar", f:GetName().."_Swing", f)
		sw:SetStatusBarTexture(cfg.statusbar_texture)
		sw:SetStatusBarColor(.3, .3, .3)
		sw:SetHeight(4)
		sw:SetWidth(f.width)
		sw:SetPoint("TOP", f.Power, "BOTTOM", 0, -3)
		sw.bg = sw:CreateTexture(nil, "BORDER")
		sw.bg:SetAllPoints(sw)
		sw.bg:SetTexture(cfg.statusbar_texture)
		sw.bg:SetVertexColor(.1, .1, .1, 0.25)
		sw.bd = CreateFrame("Frame", nil, sw)
		sw.bd:SetFrameLevel(1)
		sw.bd:SetPoint("TOPLEFT", -4, 4)
		sw.bd:SetPoint("BOTTOMRIGHT", 4, -4)
		lib.gen_backdrop(sw.bd)
		sw.Text = lib.gen_fontstring(sw, cfg.font, 10, "THINOUTLINE")
		sw.Text:SetPoint("CENTER", 0, 0)
		sw.Text:SetTextColor(1, 1, 1)
		f.Swing = sw
	end
  end
  
--hand the lib to the namespace for further usage
ns.lib = lib
