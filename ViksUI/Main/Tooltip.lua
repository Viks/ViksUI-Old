--[[
local T, Viks, L, _ = unpack(select(2, ...))
-- credits : Aezay (TipTac) and Caellian for some parts of code.
if not Viks.tooltip.enable then return end
local _, ns = ...
local oUF = ns.oUF or oUF

if not oUF then return end
local Tooltip = CreateFrame("Frame", "Tooltip", UIParent)

local _G = getfenv(0)

local GameTooltip, GameTooltipStatusBar = _G["GameTooltip"], _G["GameTooltipStatusBar"]

local gsub, find, format = string.gsub, string.find, string.format
local Tooltips = {GameTooltip, ItemRefShoppingTooltip1,ItemRefShoppingTooltip2, ItemRefShoppingTooltip3,ShoppingTooltip1,ShoppingTooltip2,ShoppingTooltip3,WorldMapTooltip,WorldMapCompareTooltip1,WorldMapCompareTooltip2,WorldMapCompareTooltip3}
local ItemRefTooltip = ItemRefTooltip

local linkTypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}

local classification = {
	worldboss = "|cffAF5050Boss|r",
	rareelite = "|cffAF5050+ Rare|r",
	elite = "|cffAF5050+|r",
	rare = "|cffAF5050Rare|r",
}

local NeedBackdropBorderRefresh = true

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(160, 160)
anchor:SetFrameStrata("TOOLTIP")
anchor:SetFrameLevel(20)
anchor:SetClampedToScreen(true)
anchor:SetAlpha(0)

AnchorTooltips = CreateFrame("Frame","Move_Tooltip",UIParent)
AnchorTooltips:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 2, -20)
CreateAnchor(AnchorTooltips, "Move tooltips", 120, 80)

if Viks.tooltip.topleft then anchor:SetPoint("TOPLEFT", AnchorTooltips) end
if Viks.tooltip.topright then anchor:SetPoint("TOPRIGHT", AnchorTooltips) end
if Viks.tooltip.bottomleft then anchor:SetPoint("BOTTOMLEFT", AnchorTooltips) end
if Viks.tooltip.bottomright then anchor:SetPoint("BOTTOMRIGHT", AnchorTooltips) end

frame1px(anchor)
CreateShadow(anchor)
anchor:SetBackdropBorderColor(1, 0, 0, 1)
anchor:SetMovable(true)
anchor.text = SetFontString(anchor, Viks.media.font, 10)
anchor.text:SetPoint("CENTER")
anchor.text:SetText("Move Tooltip")

-- Also used because on Eyefinity, SetClampedToScreen doesn't work on left and right side of screen #1
local function UpdateTooltip(self)
	local owner = self:GetOwner()
	if not owner then return end	
	local name = owner:GetName()
	
	-- fix X-offset or Y-offset
	local x = 3
	
	-- mouseover
	if self:GetAnchorType() == "ANCHOR_CURSOR" then
		-- h4x for world object tooltip border showing last border color 
		-- or showing background sometime ~blue :x		
		if NeedBackdropBorderRefresh then
			NeedBackdropBorderRefresh = false			
			self:SetBackdropColor(unpack(Viks.media.backdropcolor))
			if not Viks.tooltip.cursor then
				self:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
			end
		end
	elseif self:GetAnchorType() == "ANCHOR_NONE" and InCombatLockdown() and Viks.tooltip.hidecombat == true then
		self:Hide()
	end
			
	if self:GetAnchorType() == "ANCHOR_NONE" and TooltipAnchor then
		local point = TooltipAnchor:GetPoint()
		if point == "TOPLEFT" then
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT",TooltipAnchor, "TOPLEFT", 0, -x)			
		elseif point == "TOP" then
			self:ClearAllPoints()
			self:SetPoint("TOP", TooltipAnchor, "BOTTOM", 0, -x)			
		elseif point == "TOPRIGHT" then
			self:ClearAllPoints()
			self:SetPoint("BOTTOMRIGHT", AnchorTooltips)		
		elseif point == "BOTTOMLEFT" or point == "LEFT" then
			self:ClearAllPoints()
			self:SetPoint("BOTTOMLEFT", TooltipAnchor, "TOPLEFT", 0, x)		
		elseif point == "BOTTOMRIGHT" or point == "RIGHT" then
			self:ClearAllPoints()
			self:SetPoint("BOTTOMRIGHT", TooltipAnchor, "TOPRIGHT", -1, -70)
		else
			self:ClearAllPoints()
			self:SetPoint("BOTTOM", TooltipAnchor, "TOP", 0, x)		
		end
	end
end


hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
	if Viks.tooltip.cursor == true then
		self:SetOwner(parent, "ANCHOR_CURSOR")
	else
		self:SetOwner(parent, "ANCHOR_NONE")
	end
end)


GameTooltip:HookScript("OnUpdate", function(self, ...) UpdateTooltip(self) end)

local function Hex(color)
	return string.format('|cff%02x%02x%02x', color.r * 255, color.g * 255, color.b * 255)
end

local function GetColor(unit)
	if(UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local _, class = UnitClass(unit)
		local color = RAID_CLASS_COLORS[class]
		if not color then return end -- sometime unit too far away return nil for color :(
		local r,g,b = color.r, color.g, color.b
		return Hex(color), r, g, b	
	else
		local color = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
		if not color then return end -- sometime unit too far away return nil for color :(
		local r,g,b = color.r, color.g, color.b		
		return Hex(color), r, g, b		
	end
end

-- function to short-display HP value on StatusBar
local function ShortValue(value)
	if value >= 1e7 then
		return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e6 then
		return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e5 then
		return ('%.0fk'):format(value / 1e3)
	elseif value >= 1e3 then
		return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return value
	end
end

-- update HP value on status bar
GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
	if not value then
		return
	end
	local min, max = self:GetMinMaxValues()
	
	if (value < min) or (value > max) then
		return
	end
	local _, unit = GameTooltip:GetUnit()
	
	-- fix target of target returning nil
	if (not unit) then
		local GMF = GetMouseFocus()
		unit = GMF and GMF:GetAttribute("unit")
	end

	if not self.text then
		self.text = self:CreateFontString(nil, "OVERLAY")
		if Viks.tooltip.topleft or Viks.tooltip.topright then
			self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, 0)
		else
			self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, 0)
		end
		
		self.text:SetFont(Viks.media.font, 10, "OUTLINE")
		self.text:Show()
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			local hp = ShortValue(min).." / "..ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText("Ghost")
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText("Dead")
			else
				self.text:SetText(hp)
			end
		end
	else
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			self.text:Show()
			local hp = ShortValue(min).." / "..ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText("Ghost")
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText("Dead")
			else
				self.text:SetText(hp)
			end
		else
			self.text:Hide()
		end
	end
end)

local healthBar = GameTooltipStatusBar
healthBar:ClearAllPoints()
healthBar:SetHeight(5)
healthBar:SetPoint("BOTTOMLEFT", healthBar:GetParent(), "TOPLEFT", 2, 5)
healthBar:SetPoint("BOTTOMRIGHT", healthBar:GetParent(), "TOPRIGHT", -2, 5)
healthBar:SetStatusBarTexture(Viks.media.texture)

local healthBarBG = CreateFrame("Frame", "StatusBarBG", healthBar)
healthBarBG:SetFrameLevel(healthBar:GetFrameLevel() - 1)
healthBarBG:SetPoint("TOPLEFT", -2, 2)
healthBarBG:SetPoint("BOTTOMRIGHT", 2, -2)
frame1px(healthBarBG)
CreateShadow(healthBarBG)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local lines = self:NumLines()
	local GMF = GetMouseFocus()
	local unit = (select(2, self:GetUnit())) or (GMF and GMF:GetAttribute("unit"))
	
	-- A mage's mirror images sometimes doesn't return a unit, this would fix it
	if (not unit) and (UnitExists("mouseover")) then
		unit = "mouseover"
	end
	
	-- Sometimes when you move your mouse quicky over units in the worldframe, we can get here without a unit
	if not unit then self:Hide() return end
	
	-- for hiding tooltip on unitframes
	if (self:GetOwner() ~= UIParent and Viks.tooltip.hideuf) then self:Hide() return end
	
	-- A "mouseover" unit is better to have as we can then safely say the tip should no longer show when it becomes invalid.
	if (UnitIsUnit(unit,"mouseover")) then
		unit = "mouseover"
	end

	local race = UnitRace(unit)
	local class = UnitClass(unit)
	local level = UnitLevel(unit)
	local guild, guildRank = GetGuildInfo(unit)
	local name, realm = UnitName(unit)
	local hasGuildTitle;
	local crtype = UnitCreatureType(unit)
	local classif = UnitClassification(unit)
	local title = UnitPVPName(unit)
	local r, g, b = GetQuestDifficultyColor(level).r, GetQuestDifficultyColor(level).g, GetQuestDifficultyColor(level).b

	local color = GetColor(unit)	
	if not color then color = "|CFFFFFFFF" end -- just safe mode for when GetColor(unit) return nil for unit too far away

	if title or name then
		_G["GameTooltipTextLeft1"]:SetFormattedText("%s%s%s", color, title or name, realm and realm ~= "" and " - "..realm.."|r" or "|r")
	end
	
	if(UnitIsPlayer(unit)) then
		if UnitIsAFK(unit) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(unit) then 
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end

		local offset = 2
		local showGuildRank = true
		local guild, guildRank = GetGuildInfo(unit);
		if guild then
			_G["GameTooltipTextLeft2"]:SetFormattedText("%s", IsInGuild() and GetGuildInfo("player") == guild and "|cff0090ff"..guild.." - "..guildRank.."|r" or "|cff00ff10"..guild.." - "..guildRank.."|r")
			offset = offset + 1
		end

		for i= offset, lines do
			if(_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", r*255, g*255, b*255, level > 0 and level or "??", race, color, class.."|r")
				break
			end
		end
	else
		for i = 2, lines do
			if((_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) or (crtype and _G["GameTooltipTextLeft"..i]:GetText():find("^"..crtype))) then
				if level == -1 and classif == "elite" then classif = "worldboss" end
				_G["GameTooltipTextLeft"..i]:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", r*255, g*255, b*255, classif ~= "worldboss" and level ~= 0 and level or "", classification[classif] or "", crtype or "")
				break
			end
		end
	end

	local pvpLine
	for i = 1, lines do
		local text = _G["GameTooltipTextLeft"..i]:GetText()
		if text and text == PVP_ENABLED then
			pvpLine = _G["GameTooltipTextLeft"..i]
			pvpLine:SetText()
			break
		end
	end

	-- ToT line
	if UnitExists(unit.."target") and unit~="player" then
		local targetUnit = unit.."target"
		local hex, r, g, b = GetColor(unit.."target")
		if UnitIsUnit("player", unit.."target") then
		GameTooltip:AddLine("Targeting: <<YOU>>", 1, 1, 1)
		else
		local hex, r, g, b = GetColor(unit.."target")
		if not r and not g and not b then r, g, b = 1, 1, 1 end
		GameTooltip:AddLine("Targeting: "..UnitName(unit.."target"), r, g, b)
		end
	end
	
	-- Sometimes this wasn't getting reset, the fact a cleanup isn't performed at this point, now that it was moved to "OnTooltipCleared" is very bad, so this is a fix
	self.fadeOut = nil
end)
oUF_colors = setmetatable({
	tapped = {0.55, 0.57, 0.61},
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
		["POWER_TYPE_STEAM"] = {0.55, 0.57, 0.61},
		["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
	}, {__index = oUF.colors.power}),
	happiness = setmetatable({
		[1] = {.69,.31,.31},
		[2] = {.65,.63,.35},
		[3] = {.33,.59,.33},
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
			[1] = {.69,.31,.31},
			[2] = {.33,.59,.33},
			[3] = {.31,.45,.63},
			[4] = {.84,.75,.65},
	}, {__index = oUF.colors.runes}),
	reaction = setmetatable({
		[1] = { 222/255, 95/255,  95/255 }, -- Hated
		[2] = { 222/255, 95/255,  95/255 }, -- Hostile
		[3] = { 222/255, 95/255,  95/255 }, -- Unfriendly
		[4] = { 218/255, 197/255, 92/255 }, -- Neutral
		[5] = { 75/255,  175/255, 76/255 }, -- Friendly
		[6] = { 75/255,  175/255, 76/255 }, -- Honored
		[7] = { 75/255,  175/255, 76/255 }, -- Revered
		[8] = { 75/255,  175/255, 76/255 }, -- Exalted	
	}, {__index = oUF.colors.reaction}),
	class = setmetatable({
		["DEATHKNIGHT"] = { 196/255,  30/255,  60/255 },
		["DRUID"]       = { 255/255, 125/255,  10/255 },
		["HUNTER"]      = { 171/255, 214/255, 116/255 },
		["MAGE"]        = { 104/255, 205/255, 255/255 },
		["PALADIN"]     = { 245/255, 140/255, 186/255 },
		["PRIEST"]      = { 212/255, 212/255, 212/255 },
		["ROGUE"]       = { 255/255, 243/255,  82/255 },
		["SHAMAN"]      = {  41/255,  79/255, 155/255 },
		["WARLOCK"]     = { 148/255, 130/255, 201/255 },
		["WARRIOR"]     = { 199/255, 156/255, 110/255 },
	}, {__index = oUF.colors.class}),
}, {__index = oUF.colors})

local BorderColor = function(self)
	local GMF = GetMouseFocus()
	local unit = (select(2, self:GetUnit())) or (GMF and GMF:GetAttribute("unit"))
		
	local reaction = unit and UnitReaction(unit, "player")
	local player = unit and UnitIsPlayer(unit)
	local tapped = unit and UnitIsTapped(unit)
	local tappedbyme = unit and UnitIsTappedByPlayer(unit)
	local connected = unit and UnitIsConnected(unit)
	local dead = unit and UnitIsDead(unit)

	if player then
		local class = select(2, UnitClass(unit))
		local c = oUF_colors.class[class]
		r, g, b = c[1], c[2], c[3]
		healthBar:SetStatusBarColor(r, g, b)
	elseif reaction then
		local c = oUF_colors.reaction[reaction]
		r, g, b = c[1], c[2], c[3]
		healthBar:SetStatusBarColor(r, g, b)
	else
		local _, link = self:GetItem()
		local quality = link and select(3, GetItemInfo(link))
		if quality and quality >= 2 then
			local r, g, b = GetItemQualityColor(quality)
		else
			healthBar:SetStatusBarColor(unpack(Viks.media.bordercolor))
		end
	end
	
	-- need this
	NeedBackdropBorderRefresh = true
end

local SetStyle = function(self)
	frame1px(self)
	CreateShadow(self)
	BorderColor(self)
end

Tooltip:RegisterEvent("PLAYER_ENTERING_WORLD")
Tooltip:SetScript("OnEvent", function(self)
	for _, tt in pairs(Tooltips) do
		tt:HookScript("OnShow", SetStyle)
	end
	
	ItemRefTooltip:HookScript("OnTooltipSetItem", SetStyle)
	ItemRefTooltip:HookScript("OnShow", SetStyle)	
	frame1px(FriendsTooltip)
		
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", nil)
	
	-- move health status bar if anchor is found at top

	if Viks.tooltip.topleft or Viks.tooltip.topright then
		healthBar:ClearAllPoints()
		healthBar:SetPoint("TOPLEFT", healthBar:GetParent(), "BOTTOMLEFT", 2, -5)
		healthBar:SetPoint("TOPRIGHT", healthBar:GetParent(), "BOTTOMRIGHT", -2, -5)
	end
	
	-- Hide tooltips in combat for actions, pet actions and shapeshift
	if Viks.tooltip.hidebuttons == true then
		local CombatHideActionButtonsTooltip = function(self)
			if not IsShiftKeyDown() then
				self:Hide()
			end
		end
	 
		hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
		hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
		hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
	end
	
	if addon ~= "Blizzard_DebugTools" then return end
		
		if FrameStackTooltip then
			FrameStackTooltip:SetScale(1)
			-- Skin it
			FrameStackTooltip:HookScript("OnShow", function(self) CreateShadow(self) end)
		end
		
		if EventTraceTooltip then
			EventTraceTooltip:HookScript("OnShow", function(self) CreateShadow(self) end)
		end
end)


----------------------------------------------------------------------------------------
--	Adds item icons to tooltips()
----------------------------------------------------------------------------------------
local function AddIcon(self, icon)
	if icon then
		local title = _G[self:GetName() .. "TextLeft1"]
		if title and not title:GetText():find("|T" .. icon) then
			title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 20, title:GetText())
		end
	end
end

local function hookItem(tip)
	tip:HookScript("OnTooltipSetItem", function(self, ...)
		local name, link = self:GetItem()
		local icon = link and GetItemIcon(link)
		AddIcon(self, icon)
	end)
end
hookItem(_G["GameTooltip"])
hookItem(_G["ItemRefTooltip"])

local function hookSpell(tip)
	tip:HookScript("OnTooltipSetSpell", function(self, ...)
		if self:GetSpell() then
			local name, rank, icon = GetSpellInfo(self:GetSpell())
			AddIcon(self, icon)
		end
	end)
end
hookSpell(_G["GameTooltip"])
hookSpell(_G["ItemRefTooltip"])

----------------------------------------------------------------------------------------
--	Spell/Item IDs(idTip by silverwind)
----------------------------------------------------------------------------------------
if Viks.tooltip.spellid then

local select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc =
select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc

local function addLine(self, id, isItem)
	if isItem then
		self:AddLine("|cffffffff".."Item ID:".." "..id)
	else
		self:AddLine("|cffffffff".."Spell ID:".." "..id)
	end
	self:Show()
end

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local id = select(11, UnitBuff(...))
	if id then addLine(self, id) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local id = select(11, UnitDebuff(...))
	if id then addLine(self, id) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local id = select(11, UnitAura(...))
	if id then addLine(self, id) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3, self:GetSpell())
	if id then addLine(self, id) end
end)
	
hooksecurefunc("SetItemRef", function(link, ...)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip, id) end
end)

local function attachItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local id = select(3, strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"))
	if id then addLine(self, id, true) end
end
	
GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
end

----------------------------------------------------------------------------------------
--	Target Talents(TipTacTalents by Aezay)
----------------------------------------------------------------------------------------
if Viks.tooltip.talents then
local gtt = GameTooltip
local GetTalentTabInfo = GetTalentTabInfo

-- Constants
local TALENTS_PREFIX = TALENTS..":|cffffffff "
local CACHE_SIZE = 25
local INSPECT_DELAY = 0.2
local INSPECT_FREQ = 2

-- Variables
local ttt = CreateFrame("Frame", "TipTacTalents")
local cache = {}
local current = {}

-- Time of the last inspect reuqest. Init this to zero, just to make sure. This is a global so other addons could use this variable as well
lastInspectRequest = 0

-- Allow these to be accessed through other addons
ttt.cache = cache
ttt.current = current
ttt:Hide()

----------------------------------------------------------------------------------------
--	Gather Talents
----------------------------------------------------------------------------------------
local function GatherTalents(isInspect)
	-- MoP Note: Is it no longer possible to query the different talent spec groups anymore?
	-- Inspect functions will always use the active spec when not inspecting
--	local group = GetActiveTalentGroup and GetActiveTalentGroup(isInspect) or 1;	-- Az: replaced with GetActiveSpecGroup(), but that does not support inspect?
	-- New MoP Code
--	local spec = GetInspectSpecialization(current.unit,nil,group);	-- Az: didn't seem like this func supported pet & talent group index; added it anyway, just in case
	local spec = GetInspectSpecialization(current.unit);
--	local spec = GetSpecialization(isInspect,nil,group);
	if (spec) and (spec > 0) then
		local _, specName = GetSpecializationInfoByID(spec);
		--local _, specName = GetSpecializationInfoForClassID(spec,current.classID);
		current.format = specName or "n/a";
	else
		current.format = "No Talents";
	end
	-- Set the tips line output, for inspect, only update if the tip is still showing a unit!
	if not isInspect then
		gtt:AddLine(TALENTS_PREFIX..current.format)
	elseif gtt:GetUnit() then
		for i = 2, gtt:NumLines() do
			if (_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..TALENTS_PREFIX) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("%s%s",TALENTS_PREFIX,current.format)
				if not gtt.fadeOut then
					gtt:Show()
				end
				break
			end
		end
	end
	-- Organise Cache
	local cacheSize = CACHE_SIZE
	for i = #cache, 1, -1 do
		if current.name == cache[i].name then
			tremove(cache, i)
			break;
		end
	end
	if #cache > cacheSize then
		tremove(cache, 1)
	end
	-- Cache the new entry
	if cacheSize > 0 then
		cache[#cache + 1] = CopyTable(current)
	end
end

----------------------------------------------------------------------------------------
--	Event Handling
----------------------------------------------------------------------------------------
-- OnEvent
ttt:SetScript("OnEvent", function(self, event, guid)
	self:UnregisterEvent(event)
	if guid == current.guid then
		GatherTalents(1)
	end
end)

-- OnUpdate
ttt:SetScript("OnUpdate", function(self, elapsed)
	self.nextUpdate = (self.nextUpdate - elapsed)
	if self.nextUpdate <= 0 then
		self:Hide()
		-- Make sure the mouseover unit is still our unit
		if (UnitGUID("mouseover") == current.guid) then

			lastInspectRequest = GetTime();
			self:RegisterEvent("INSPECT_READY");
			NotifyInspect(current.unit);
		end
	end
end)

-- HOOK: OnTooltipSetUnit
gtt:HookScript("OnTooltipSetUnit", function(self, ...)
	-- Abort any delayed inspect in progress
	ttt:Hide()
	-- Get the unit -- Check the UnitFrame unit if this tip is from a concated unit, such as "targettarget".
	local _, unit = self:GetUnit()
	if not unit then
		local mFocus = GetMouseFocus()
		if mFocus and mFocus.unit then
			unit = mFocus.unit
		end
	end
	-- No Unit or not a Player
	if not unit or not UnitIsPlayer(unit) then
		return
	end
	-- Only bother for players over level 9
	local level = UnitLevel(unit)
	if level > 9 or level == -1 then
		-- Wipe Current Record
		wipe(current)
		current.unit = unit
		current.name = UnitName(unit)
		current.guid = UnitGUID(unit)
		-- No need for inspection on the player
		if UnitIsUnit(unit, "player") then
			GatherTalents()
			return
		end
		-- Show Cached Talents, If Available
		local cacheLoaded = false
		for _, entry in ipairs(cache) do
			if current.name == entry.name then
				self:AddLine(TALENTS_PREFIX..entry.format)

				current.format = entry.format
				current[1], current[2], current[3] = entry[1], entry[2], entry[3]
				cacheLoaded = true
				break
			end
		end
		-- Queue an inspect request

		if CanInspect(unit) and not isInspectOpen then
			local lastInspectTime = GetTime() - lastInspectRequest
			ttt.nextUpdate = (lastInspectTime > INSPECT_FREQ) and INSPECT_DELAY or (INSPECT_FREQ - lastInspectTime + INSPECT_DELAY)
			ttt:Show()
			if not cacheLoaded then
				self:AddLine(TALENTS_PREFIX.."Loading...")
			end
		end
	end
end)
end
if Viks.tooltip.itemlevel then

----------------------------------------------------------------------------------------
--	Equipped average item level(EquippedItemLevel by Villiv)
----------------------------------------------------------------------------------------
-- Additional strings
local WAITING = CONTINUED
local PENDING = CONTINUED..CONTINUED

-- Output prefix
local PREFIX = STAT_FORMAT:format(STAT_AVERAGE_ITEM_LEVEL).."|Heqppditmlvl|h |h"..HIGHLIGHT_FONT_COLOR_CODE

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)	return self[event](self, event, ...)end)
f:Hide()

local playerGUID, inCombat, updateTimer
local currentUnit, currentGUID
local isDelayed, isForced, isNotified, isReady

local function GetTipUnit()
	local _, unit = GameTooltip:GetUnit()
	if not unit then
		local mouseFocus = GetMouseFocus()
		unit = mouseFocus and (mouseFocus.unit or mouseFocus:GetAttribute("unit"))
	end

	return unit and UnitIsPlayer(unit) and unit
end

local SetTipText
do
	local function search(line, numLines)
		if line > numLines then return end

		local fontString = _G["GameTooltipTextLeft"..line]
		local stringText = fontString and fontString:GetText()
		if stringText and stringText:match(PREFIX) then
			return fontString
		end

		return search(line + 1, numLines)
	end

	function SetTipText(text)
		if not text then return end

		local fontString = search(1, GameTooltip:NumLines())
		if fontString then
			fontString:SetText(PREFIX..text)
		else
			GameTooltip:AddLine(PREFIX..text)
		end

		return GameTooltip:Show()
	end
end

local CanSafeInspect
do
	local limit, period = 6, 11
	local count, startTime = 0, 0

	hooksecurefunc("NotifyInspect", function()
		local currentTime = GetTime()
		if currentTime - startTime > period then
			count, startTime = 1, currentTime
			return
		end

		count = count + 1
	end)

	function CanSafeInspect(unit)
		if not CanInspect(unit) or InspectFrame and InspectFrame:IsShown() or Examiner and Examiner:IsShown() then return end

		local pending = count > limit and period - (GetTime() - startTime)
		return true, pending and pending > 0 and pending
	end
end

local UnitItemLevel
do
	local formatString = "%.0f"

	local function scan(unit, slot, total, count, twoHanded, incomplete)
		if slot > INVSLOT_LAST_EQUIPPED then
			return formatString:format(total / (twoHanded and count - 1 or count)), incomplete
		end

		if slot == INVSLOT_BODY or slot == INVSLOT_RANGED or slot == INVSLOT_TABARD then
			return scan(unit, slot + 1, total, count, twoHanded, incomplete)
		end

		local hasItem = GetInventoryItemTexture(unit, slot) and true
		local _, level, equipLoc

		local link = hasItem and GetInventoryItemLink(unit, slot)
		if link then
			repeat
				_, _, _, level, _, _, _, _, equipLoc = GetItemInfo(link)
			until level and equipLoc

			total = total + level
		end

		-- Two-handed weapon and Titan's Grip
		if slot == INVSLOT_MAINHAND then
			twoHanded = equipLoc == "INVTYPE_2HWEAPON" and 1 or equipLoc == "INVTYPE_RANGED" and 1 or equipLoc == "INVTYPE_RANGEDRIGHT" and 1 or not hasItem and 0
		elseif slot == INVSLOT_OFFHAND then
			twoHanded = twoHanded == 1 and not hasItem or twoHanded == 0 and equipLoc == "INVTYPE_2HWEAPON"
		end

		local failed = hasItem and not link
		return scan(unit, slot + 1, total, failed and count or count + 1, twoHanded, incomplete or failed)
	end

	function UnitItemLevel(unit)
		if unit == "player" or UnitIsUnit(unit, "player") then
			local _, level = GetAverageItemLevel()
			return formatString:format(level)
		end

		return scan(unit, INVSLOT_FIRST_EQUIPPED, 0, 0)
	end
end

local UpdateItemLevel
do
	local cache = {}
	local cachedLevel

	local function update(unit, guid)
		local level, incomplete = UnitItemLevel(unit)
		local myLevel = level - UnitItemLevel("player")

		if incomplete then
			updateTimer = TOOLTIP_UPDATE_TIME
			f:Show()
			level = cachedLevel or level
			return SetTipText(WAITING and level..WAITING or level)
		end

		if isReady then
			cache[guid] = level
			return SetTipText(level.." ("..((myLevel > 0) and "|cff00ff00+" or "|cffff0000")..myLevel.."|r|cffffffff)|r")
		end

		level = cachedLevel or level
		return SetTipText(WAITING and level..WAITING or level)
	end

	function UpdateItemLevel()
		cachedLevel = cache[currentGUID]

		if inCombat then
			return SetTipText(cachedLevel)
		end

		if isReady then
			return update(currentUnit, currentGUID)
		end

		if not isForced and cachedLevel then
			return SetTipText(cachedLevel)
		end

		if currentGUID == playerGUID then
			local level = UnitItemLevel("player")
			cache[playerGUID] = level
			return SetTipText(level)
		end

		local canInspect, pending = CanSafeInspect(currentUnit)
		if not canInspect then
			return SetTipText(cachedLevel)
		end

		if pending then
			updateTimer = pending
			f:Show()
			return SetTipText(cachedLevel and cachedLevel..PENDING or PENDING)
		end

		if not isDelayed then
			isDelayed = true
			updateTimer = TOOLTIP_UPDATE_TIME
			f:Show()
			return SetTipText(cachedLevel and (WAITING and cachedLevel..WAITING or cachedLevel) or PENDING)
		end

		if not isNotified then
			isNotified = true
			NotifyInspect(currentUnit)
		end

		return update(currentUnit, currentGUID)
	end
end

local function OnTooltipSetUnit()
	currentUnit, currentGUID, isDelayed, isForced, isNotified, isReady = GetTipUnit(), nil, nil, nil, nil, nil
	if not currentUnit then return end

	currentGUID, isForced = UnitGUID(currentUnit), UnitIsUnit(currentUnit, "target")

	return UpdateItemLevel()
end
GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

f:SetScript("OnUpdate", function(self, elapsed)
	updateTimer = updateTimer - elapsed
	if updateTimer > 0 then return end
	self:Hide()

	if not currentGUID then return end

	local tipUnit = GetTipUnit()
	if not tipUnit or UnitGUID(tipUnit) ~= currentGUID then return end

	return UpdateItemLevel()
end)

function f:INSPECT_READY(_, guid)
	if not currentGUID or guid ~= currentGUID then return end

	local tipUnit = GetTipUnit()
	if not tipUnit or UnitGUID(tipUnit) ~= currentGUID then return end

	isReady = true

	return UpdateItemLevel()
end
f:RegisterEvent("INSPECT_READY")

function f:UNIT_INVENTORY_CHANGED(_, unit)
	if not currentGUID or UnitGUID(unit) ~= currentGUID then return end

	local tipUnit = GetTipUnit()
	if not tipUnit or UnitGUID(tipUnit) ~= currentGUID then return end

	isForced, isNotified, isReady = true, nil, nil

	return UpdateItemLevel()
end
f:RegisterEvent("UNIT_INVENTORY_CHANGED")

function f:PLAYER_TARGET_CHANGED()
	return self:UNIT_INVENTORY_CHANGED(nil, "target")
end
f:RegisterEvent("PLAYER_TARGET_CHANGED")

function f:PLAYER_REGEN_DISABLED()
	inCombat = true
end
f:RegisterEvent("PLAYER_REGEN_DISABLED")

function f:PLAYER_REGEN_ENABLED()
	inCombat = nil
end
f:RegisterEvent("PLAYER_REGEN_ENABLED")

function f:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

	playerGUID = UnitGUID("player")
end

if IsLoggedIn() then
	f:PLAYER_LOGIN()
	inCombat = InCombatLockdown()
	return OnTooltipSetUnit()
end

return f:RegisterEvent("PLAYER_LOGIN")
end


----------------------------------------------------------------------------------------
--	Your achievement status in tooltip(Enhanced Achievements by Syzgyn)
----------------------------------------------------------------------------------------
local colors = {
	["GREEN"] = {
		["r"] = 0.25,
		["g"] = 0.75,
		["b"] = 0.25,
	},
	["GRAY"] = {
		["r"] = 0.5,
		["g"] = 0.5,
		["b"] = 0.5,
	},
}

local function SetHyperlink(tooltip, refString)
	local output = {[0] = {}, [1] = {}}
	if select(3, string.find(refString, "(%a-):")) ~= "achievement" then return end

	local _, _, achievementID = string.find(refString, ":(%d+):")
	local numCriteria = GetAchievementNumCriteria(achievementID)
	local _, _, GUID = string.find(refString, ":%d+:(.-):")

	if GUID == string.sub(UnitGUID("player"), 3) then
		tooltip:Show()
		return
	end

	tooltip:AddLine(" ")
	local _, _, _, completed, month, day, year, _, _, _, _, _, wasEarnedByMe, earnedBy = GetAchievementInfo(achievementID)

	if completed then
		if year < 10 then year = "0"..year end

		if client == "ruRU" then
			tooltip:AddLine("Your Status: Completed on "..day.."/"..month.."/"..year, 0, 1, 0)
		else
			tooltip:AddLine("Your Status: Completed on "..month.."/"..day.."/"..year, 0, 1, 0)
		end

		if earnedBy then
			tooltip:AddLine(format(ACHIEVEMENT_EARNED_BY, earnedBy))
			if not wasEarnedByMe then
				tooltip:AddLine(format(ACHIEVEMENT_NOT_COMPLETED_BY, name))
			elseif name ~= earnedBy then
				tooltip:AddLine(format(ACHIEVEMENT_COMPLETED_BY, name))
			end
		end
	elseif numCriteria == 0 then
		tooltip:AddLine("Your Status: Incomplete")
	else
		tooltip:AddLine("Your Status:")
		for i = 1, numCriteria, 2 do
			for a = 0, 1 do
				output[a].text = nil
				output[a].color = nil
				if i + a <= numCriteria then
					local name, _, completed, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, i + a)
					if completed then
						output[a].text = name
						output[a].color = "GREEN"
					else
						if quantity < reqQuantity and reqQuantity > 1 then
							output[a].text = name.." ("..quantity.."/"..reqQuantity..")"
							output[a].color = "GRAY"
						else
							output[a].text = name
							output[a].color = "GRAY"
						end
					end
				else
					output[a].text = nil
				end
			end
			if output[1].text == nil then
				tooltip:AddLine(output[0].text, colors[output[0].color].r, colors[output[0].color].g, colors[output[0].color].b)
			else
				tooltip:AddDoubleLine(output[0].text, output[1].text, colors[output[0].color].r, colors[output[0].color].g, colors[output[0].color].b, colors[output[1].color].r, colors[output[1].color].g, colors[output[1].color].b)
			end
			output = {[0] = {}, [1] = {}}
		end
	end
	tooltip:Show()
end

hooksecurefunc(GameTooltip, "SetHyperlink", SetHyperlink)
hooksecurefunc(ItemRefTooltip, "SetHyperlink", SetHyperlink)

----------------------------------------------------------------------------------------
--	Displays items can not be transmogrified(Will It Mog by Nathanyel)
----------------------------------------------------------------------------------------
-- Slots
local locs = {
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_SHOULDER"] = 1,
	["INVTYPE_CHEST"] = 1,
	["INVTYPE_ROBE"] = 1,
	["INVTYPE_WAIST"] = 1,
	["INVTYPE_LEGS"] = 1,
	["INVTYPE_FEET"] = 1,
	["INVTYPE_WRIST"] = 1,
	["INVTYPE_HAND"] = 1,
	["INVTYPE_CLOAK"] = 1,
	["INVTYPE_WEAPON"] = 1,
	["INVTYPE_SHIELD"] = 1,
	["INVTYPE_2HWEAPON"] = 1,
	["INVTYPE_HOLDABLE"] = 1,
	["INVTYPE_WEAPONMAINHAND"] = 1,
	["INVTYPE_WEAPONOFFHAND"] = 1,
	["INVTYPE_RANGED"] = 1,
	["INVTYPE_THROWN"] = 1,
	["INVTYPE_RANGEDRIGHT"] = 1,
}

-- White items that are a source for Transmogrify
local wx = {
	[41746] = 1,
	[43600] = 1,
	[43601] = 1,
	[78340] = 1,
	[78341] = 1,
}

local WIMtooltip = function(tooltip)
	local _, link = tooltip:GetItem()
	if not link then return end

	GetItemInfo(link)
	local _, _, quality, _, _, itemType, subType, _, slot = GetItemInfo(link)
	-- No weapon or armor, or misc 'weapon', or invalid slot
	if not itemType or (quality < 2 and not wx[tonumber(link:match("item:(%d+):"))]) or not (itemType == ARMOR or itemType == ENCHSLOT_WEAPON) or (subType == MISCELLANEOUS and not slot == "INVTYPE_HOLDABLE") or not locs[slot] then return end
	local canBeChanged, noChangeReason, canBeSource, noSourceReason = GetItemTransmogrifyInfo(link)

	if not (canBeChanged or canBeSource) then return end

	if noChangeReason or noSourceReason then
		GameTooltip:AddLine(" ")
	end

	if noChangeReason then
		tooltip:AddLine(gsub("|cffff0000"..(_G["ERR_TRANSMOGRIFY_"..noChangeReason] or noChangeReason), "%%s", ""), nil, nil, nil, true)
	end

	if noSourceReason and noSourceReason ~= noChangeReason then
		tooltip:AddLine(gsub("|cffff0000"..(_G["ERR_TRANSMOGRIFY_"..noSourceReason] or noSourceReason), "%%s", ""), nil, nil, nil, true)
	end

	tooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetItem", WIMtooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", WIMtooltip)


----------------------------------------------------------------------------------------
--	Symbiosis info(module from bTooltip by Fernir)
----------------------------------------------------------------------------------------
local symbiosis = {
	gain = {
		["DEATHKNIGHT"] = {["DK_BLOOD"] = 113072, ["DK_FROST"] = 113516, ["DK_UNHOLY"] = 113516},
		["HUNTER"] = {["HUNTER_BM"] = 113073, ["HUNTER_MM"] = 113073, ["HUNTER_SV"] = 113073},
		["MAGE"] = {["MAGE_ARCANE"] = 113074, ["MAGE_FIRE"] = 113074, ["MAGE_FROST"] = 113074},
		["MONK"] = {["MONK_BREW"] = 113306, ["MONK_MIST"] = 127361, ["MONK_WIND"] = 113275},
		["PALADIN"] = {["PALADIN_HOLY"] = 113269, ["PALADIN_PROT"] = 113075, ["PALADIN_RET"] = 122287},
		["PRIEST"] = {["PRIEST_DISC"] = 113506, ["PRIEST_HOLY"] = 113506, ["PRIEST_SHADOW"] = 113277},
		["ROGUE"] = {["ROGUE_ASS"] = 113613, ["ROGUE_COMBAT"] = 113613, ["ROGUE_SUB"] = 113613},
		["SHAMAN"] = {["SHAMAN_ELE"] = 113286, ["SHAMAN_ENHANCE"] = 113286, ["SHAMAN_RESTO"] = 113289},
		["WARLOCK"] = {["WARLOCK_AFFLICTION"] = 113295, ["WARLOCK_DEMO"] = 113295, ["WARLOCK_DESTRO"] = 113295},
		["WARRIOR"] = {["WARRIOR_ARMS"] = 122294, ["WARRIOR_FURY"] = 122294, ["WARRIOR_PROT"] = 122286}
	},
	grant = {
		["DEATHKNIGHT"] = {["DRUID_BALANCE"] = 110570, ["DRUID_FERAL"] = 122282, ["DRUID_GUARDIAN"] = 122285, ["DRUID_RESTO"] = 110575},
		["HUNTER"] = {["DRUID_BALANCE"] = 110588, ["DRUID_FERAL"] = 110597, ["DRUID_GUARDIAN"] = 110600, ["DRUID_RESTO"] = 19263},
		["MAGE"] = {["DRUID_BALANCE"] = 110621, ["DRUID_FERAL"] = 110693, ["DRUID_GUARDIAN"] = 110694, ["DRUID_RESTO"] = 110696},
		["MONK"] = {["DRUID_BALANCE"] = 126458, ["DRUID_FERAL"] = 128844, ["DRUID_GUARDIAN"] = 126453, ["DRUID_RESTO"] = 126456},
		["PALADIN"] = {["DRUID_BALANCE"] = 110698, ["DRUID_FERAL"] = 110700, ["DRUID_GUARDIAN"] = 110701, ["DRUID_RESTO"] = 122288},
		["PRIEST"] = {["DRUID_BALANCE"] = 110707, ["DRUID_FERAL"] = 110715, ["DRUID_GUARDIAN"] = 110717, ["DRUID_RESTO"] = 110718},
		["ROGUE"] = {["DRUID_BALANCE"] = 110788, ["DRUID_FERAL"] = 110730, ["DRUID_GUARDIAN"] = 122289, ["DRUID_RESTO"] = 110791},
		["SHAMAN"] = {["DRUID_BALANCE"] = 110802, ["DRUID_FERAL"] = 110807, ["DRUID_GUARDIAN"] = 110803, ["DRUID_RESTO"] = 110806},
		["WARLOCK"] = {["DRUID_BALANCE"] = 122291, ["DRUID_FERAL"] = 110810, ["DRUID_GUARDIAN"] = 122290, ["DRUID_RESTO"] = 112970},
		["WARRIOR"] = {["DRUID_BALANCE"] = 122292, ["DRUID_FERAL"] = 112997, ["DRUID_GUARDIAN"] = 113002, ["DRUID_RESTO"] = 113004}
	}
}

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local unit = (select(2, self:GetUnit())) or (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover") or nil
	if unit then
		if UnitIsPlayer(unit) and not UnitIsEnemy(unit, "player") then
			for i = 1, 40 do
				if select(11, UnitAura(unit, i, "HELPFUL")) == 110309 then return end
			end
			local _, uclass = UnitClass(unit)
			local ulevel = UnitLevel(unit)
			local uspec = GetSpecialization()
			if not uspec then return end
			local spec = SPEC_CORE_ABILITY_TEXT[GetSpecializationInfo(uspec)]
			local spellID
			if class == "DRUID" and level >= 87 and uclass ~= "DRUID" then
				spellID = symbiosis.grant[uclass][spec]
			elseif class ~= "DRUID" and (uclass == "DRUID" and ulevel >= 87) then
				spellID = symbiosis.gain[class][spec]
			end
			local name = GetSpellInfo(spellID)
			if name then
				GameTooltip:AddLine(GetSpellInfo(110309)..": |cffffffff"..name.."|r")
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Displays a players LFD/LFR role(gTooltipRoles by g0st)
----------------------------------------------------------------------------------------
local function GetLFDRole(unit)
	local role = UnitGroupRolesAssigned(unit)

	if role == "NONE" then
		return "|cFFB5B5B5"..NO_ROLE.."|r"
	elseif role == "TANK" then
		return "|cFF0070DE"..TANK.."|r"
	elseif role == "HEALER" then
		return "|cFF00CC12"..HEALER.."|r"
	else
		return "|cFFFF3030"..DAMAGER.."|r"
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local _, unit = GameTooltip:GetUnit()
	if unit and UnitIsPlayer(unit) and ((UnitInParty(unit) and GetNumGroupMembers() > 0) or (UnitInRaid(unit) and GetNumGroupMembers() > 0)) then
		GameTooltip:AddLine(ROLE..": "..GetLFDRole(unit))
	end
end)
--]]