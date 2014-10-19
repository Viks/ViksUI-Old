local T, Viks, L, _ = unpack(select(2, ...))
----------------------------------------------------------------------------------------
-- Default Size Values
----------------------------------------------------------------------------------------

CPwidth = Viks.panels.CPwidth 					-- Width for Left and RIght side panels that holds text. 
CPTextheight = Viks.panels.CPTextheight 			-- Hight for panel where chat window is inside
CPbarsheight = Viks.panels.CPbarsheight 			-- Hight for Panels under/above Chat window
CPABarSide = Viks.panels.CPABarSide 				-- Width for Action Bars next to chat windows
CPXPBa_r = Viks.panels.CPXPBa_r 					-- Hight for the XP bar above Left Chat
xoffset = Viks.panels.xoffset 					-- Horisontal spacing between panels
yoffset = Viks.panels.yoffset 					-- Vertical spacing between panels
CPSidesWidth = Viks.panels.CPSidesWidth 			-- Width of panels that is used to hold dmg meter and threathbar (Recount & Omen) 
CPMABwidth = Viks.panels.CPMABwidth				-- Width for Main Actionbar
CPMABheight = Viks.panels.CPMABheight 			-- Hight for Main Actionbar
CPMAByoffset = Viks.panels.CPMAByoffset 			-- Hight for Main Actionbar
CPCooldheight = Viks.panels.CPCooldheight 		-- Hight for Cooldown Bar
CPTop = Viks.panels.CPTop 						-- Width for Top Panels
CPMinimap = Viks.minimapp.size 					-- Width/Hight for Minimap Panel
Pscale = Viks.misc.Pscale						-- Can be used to resize all panels. It does not change X Y Values


local _, class = UnitClass("player")
local r, g, b = 0,.38,.651
qColor = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
qColor2 = ("|cff%.2x%.2x%.2x"):format(0 * 255, .38 * 255, .651 * 255)

----------------------------------------------------------------------------------------
-- General options   
----------------------------------------------------------------------------------------

mult = T.mult


function CreateShadow0(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", 1, -1)
	shadow:SetPoint("BOTTOMRIGHT", -1, 1)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

buttonsize = Viks.actionbar.buttonsize
buttonspacing = Viks.actionbar.buttonspacing
petbuttonsize = Viks.actionbar.petbuttonsize
petbuttonspacing = Viks.actionbar.buttonspacing

----------------------------------------------------------------------------------------
-- Backdrop/Shadow/Glow/Border
----------------------------------------------------------------------------------------
function CreatePanel(f, w, h, a1, p, a2, x, y)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	sh = T.Scale(h)
	sw = T.Scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
      edgeFile = "Interface\\Buttons\\WHITE8x8", 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	if Viks.misc.panelsh then
	f:SetAlpha(1)
	else
	f:SetAlpha(0)
	end
end
function altCreatePanel(f, w, h, a1, p, a2, x, y)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	sh = T.Scale(h)
	sw = T.Scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
      edgeFile = "Interface\\Buttons\\WHITE8x8", 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(Viks.media.altbackdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end
local function SetTex(f, t, texture)
	f:SetBackdrop({
	  bgFile = Viks.media.blank, 
	  edgeFile = Viks.media.blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	
	local tex = f:CreateTexture(nil, "BORDER")
	tex:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	tex:SetTexture("Interface\\Addons\\ViksUI\\Media\\Other\\statusbar3")
	tex:SetVertexColor(unpack(Viks.media.backdropcolor))
	tex:SetDrawLayer("BORDER", -8)
	f.tex = tex
	
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end

local shadows = {
	edgeFile = "Interface\\AddOns\\ViksUI\\Media\\Other\\glowTex", 
	edgeSize = 4,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
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
function CreateBorder(f)
	if f.border then return end
	local border = CreateFrame("Frame", nil, f)
	border:SetFrameLevel(1)
	border:SetFrameStrata(f:GetFrameStrata())
	border:SetPoint("TOPLEFT", 0, 0)
	border:SetPoint("BOTTOMRIGHT", 0, 0)
	border:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	border:SetBackdropColor(0, 0, 0, 0)
	border:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	f.border = border
	return border
end

local function SetTex2(f, t, texture)
	f:SetBackdrop({
	  bgFile = Viks.media.blank, 
	  edgeFile = Viks.media.blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	
	local tex = f:CreateTexture(nil, "BORDER")
	tex:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	tex:SetTexture("Interface\\Addons\\ViksUI\\Media\\Other\\statusbar3")
	tex:SetVertexColor(unpack(Viks.media.backdropcolor))
	tex:SetDrawLayer("BORDER", -8)
	f.tex = tex
	
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end
function frametexpx(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	SetTex2(f)	
end
function frame1px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))	
end
function frameskada(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetBackdropColor(.06,.06,.06,0)



	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))	
end
function frame11px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetBackdropColor(.1,.1,.1,0)
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end
function frame1px1(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetPoint("TOPLEFT", -2, 2)
	f:SetPoint("BOTTOMRIGHT", 2, -2)
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end
function frame1px2_2(f) --//Viks
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetPoint("TOPLEFT", -1, 1)
	f:SetPoint("BOTTOMRIGHT", 1, -1)
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	--f:SetFrameLevel(12)
end

function frame1px2(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetFrameLevel(31)
	f:SetPoint("TOPLEFT", 1, -1)
	f:SetPoint("BOTTOMRIGHT", -1, 1)
	f:SetBackdropColor(.1,.1,.1,0)
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end
function frame1px3(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult} 
	})
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end
--fucking icon for castbar
function frame12(f)
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
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
      })
     
      frame:SetBackdropColor(unpack(Viks.media.backdropcolor))
      frame:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
      f.frame = frame
    end
end 
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
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
      })
     
      frame:SetBackdropColor(.1,.1,.1,1)
      frame:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
      f.frame = frame
    end
end 
function frame123(f)
    if f.frame==nil then
      local frame = CreateFrame("Frame", nil, f)
      frame = CreateFrame("Frame", nil, f)
      frame:SetFrameLevel(2)
      frame:SetFrameStrata(f:GetFrameStrata())
      frame:SetPoint("TOPLEFT", 9, -9)
      frame:SetPoint("BOTTOMLEFT", 9, 9)
      frame:SetPoint("TOPRIGHT", -9, -9)
      frame:SetPoint("BOTTOMRIGHT", -9, 9)
      frame:SetBackdrop( {
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],	  
        edgeFile = "Interface\\Buttons\\WHITE8x8", 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
      })
	  frame:SetBackdropColor(unpack(Viks.media.backdropcolor))
      frame:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
      f.frame = frame
    end
end 
function CreateShadow1(f)
    if f.frameBD==nil then
      local frameBD = CreateFrame("Frame", nil, f)
      frameBD = CreateFrame("Frame", nil, f)
      frameBD:SetFrameLevel(1)
      frameBD:SetFrameStrata(f:GetFrameStrata())
      frameBD:SetPoint("TOPLEFT", 0, 0)
      frameBD:SetPoint("BOTTOMLEFT", 0, 0)
      frameBD:SetPoint("TOPRIGHT", 0, 0)
      frameBD:SetPoint("BOTTOMRIGHT", 0, 0)
      frameBD:SetBackdrop( { 
         edgeFile = "Interface\\AddOns\\ViksUI\\media\\Other\\glowTex", edgeSize = 4,
         insets = {left = 3, right = 3, top = 3, bottom = 3},
         tile = false, tileSize = 0,
      })
      frameBD:SetBackdropColor(0, 0, 0, 0)
      frameBD:SetBackdropBorderColor(0, 0, 0, 1)
      f.frameBD = frameBD
    end
end
function CreateShadow2(f)
    if f.frameBD==nil then
      local frameBD = CreateFrame("Frame", nil, f)
      frameBD = CreateFrame("Frame", nil, f)
      frameBD:SetFrameLevel(0)
      frameBD:SetFrameStrata(f:GetFrameStrata())
      frameBD:SetPoint("TOPLEFT", 5, -5)
      frameBD:SetPoint("BOTTOMLEFT", 5, 5)
      frameBD:SetPoint("TOPRIGHT", -5, -5)
      frameBD:SetPoint("BOTTOMRIGHT", -5, 5)
      frameBD:SetBackdrop( { 
         edgeFile = "Interface\\AddOns\\ViksUI\\media\\Other\\glowTex", edgeSize = 4,
         insets = {left = 3, right = 3, top = 3, bottom = 3},
         tile = false, tileSize = 0,
      })
      frameBD:SetBackdropColor(0, 0, 0, 0)
      frameBD:SetBackdropBorderColor(0, 0, 0, 0)
      f.frameBD = frameBD
    end
end

function CreateShadow3(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -3, 3)
	shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

function CreateShadowNameplates(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

if Viks.datatext.classcolor == true then
	local classcolor = RAID_CLASS_COLORS[myclass]
	Viks.datatext.color = {classcolor.r,classcolor.g,classcolor.b,1}
end
local r, g, b = unpack(Viks.datatext.color)
qColor = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)


-- convert datatext color from rgb decimal to hex 
local dr, dg, db = unpack(Viks.datatext.color)
panelcolor = ("|cff%.2x%.2x%.2x"):format(dr * 255, dg * 255, db * 255)

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


--BATTLEGROUND STATS FRAME


if Viks.actionbar.enable == true then
---------------------
--Acton Bar Panels
---------------------
local sbWidth = Viks.actionbar.sidebarWidth
local mbWidth = Viks.actionbar.mainbarWidth

AnchorQuBar1 = CreateFrame("Frame","Move_ActionBars1",UIParent)
AnchorQuBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 19)
CreateAnchor(AnchorQuBar1, "Move Bar1", (buttonsize * mbWidth) + (buttonspacing * (mbWidth-1)), 34)
	
local QuBar1 = CreateFrame("Frame", "QuBar1", UIParent, "SecureHandlerStateTemplate")
CreatePanel(QuBar1, 1, 1, "BOTTOM", AnchorQuBar1)
QuBar1:SetWidth((buttonsize * mbWidth) + (buttonspacing * (mbWidth-1)))
QuBar1:SetHeight((buttonsize * 2) + (buttonspacing * 3))
QuBar1:SetFrameStrata("BACKGROUND")
QuBar1:SetFrameLevel(1)

local QuBar2 = CreateFrame("Frame", "QuBar2", UIParent)
CreatePanel(QuBar2, 1, 1, "BOTTOMRIGHT", QuBar1, "BOTTOMLEFT", -1, 0)
if Viks.actionbar.lowversion then
	QuBar2:SetWidth((buttonsize * 6) + (buttonspacing * 7))
else
	QuBar2:SetWidth((buttonsize * sbWidth) + (buttonspacing * (sbWidth-1)))
end
QuBar2:SetHeight((buttonsize * 2) + (buttonspacing * 3))
QuBar2:SetFrameStrata("BACKGROUND")
QuBar2:SetFrameLevel(2)
if Viks.actionbar.lowversion then
	QuBar2:SetAlpha(0)
else
	QuBar2:SetAlpha(1)
end

local QuBar3 = CreateFrame("Frame", "QuBar3", UIParent)
CreatePanel(QuBar3, 1, 1, "BOTTOMLEFT", QuBar1, "BOTTOMRIGHT", 1, 0)
if Viks.actionbar.lowversion then
	QuBar3:SetWidth((buttonsize * 6) + (buttonspacing * 7))
else
	QuBar3:SetWidth((buttonsize * sbWidth) + (buttonspacing * (sbWidth-1)))
end
QuBar3:SetHeight((buttonsize * 2) + (buttonspacing * 3))
QuBar3:SetFrameStrata("BACKGROUND")
QuBar3:SetFrameLevel(2)
if Viks.actionbar.lowversion then
	QuBar2:SetAlpha(0)
else
	QuBar2:SetAlpha(1)
end

AnchorQuBar4 = CreateFrame("Frame","Move_ActionBars4",UIParent)
AnchorQuBar4:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 54)
CreateAnchor(AnchorQuBar4, "Move Bar4", (buttonsize * mbWidth) + (buttonspacing * (mbWidth-1)), 34)

local QuBar4 = CreateFrame("Frame", "QuBar4", UIParent)
CreatePanel(QuBar4, 1, 1, "BOTTOM", AnchorQuBar4, 0, -35)
QuBar4:SetWidth((buttonsize * mbWidth) + (buttonspacing * (mbWidth-1)))
QuBar4:SetHeight((buttonsize * 2) + (buttonspacing * 3))
QuBar4:SetFrameStrata("BACKGROUND")
QuBar4:SetFrameLevel(2)
QuBar4:SetAlpha(0)

local QuBar5 = CreateFrame("Frame", "QuBar5", UIParent)
CreatePanel(QuBar5, 1, (buttonsize * 12) + (buttonspacing * 13), "RIGHT", UIParent, "RIGHT", -20, -14)
QuBar5:SetWidth((buttonsize * 1) + (buttonspacing * 2))
QuBar5:SetFrameStrata("BACKGROUND")
QuBar5:SetFrameLevel(2)
QuBar5:SetAlpha(0)

local QuBar6 = CreateFrame("Frame", "QuBar6", UIParent)
QuBar6:SetWidth((buttonsize * 1) + (buttonspacing * 2))
QuBar6:SetHeight((buttonsize * 12) + (buttonspacing * 13))
QuBar6:SetPoint("LEFT", QuBar5, "LEFT", 0, 0)
QuBar6:SetFrameStrata("BACKGROUND")
QuBar6:SetFrameLevel(2)
QuBar6:SetAlpha(0)

local QuBar7 = CreateFrame("Frame", "QuBar7", UIParent)
QuBar7:SetWidth((buttonsize * 1) + (buttonspacing * 2))
QuBar7:SetHeight((buttonsize * 12) + (buttonspacing * 13))
QuBar7:SetPoint("TOP", QuBar5, "TOP", 0 , 0)
QuBar7:SetFrameStrata("BACKGROUND")
QuBar7:SetFrameLevel(2)
QuBar7:SetAlpha(0)

local petbg = CreateFrame("Frame", "QuPetBar", UIParent, "SecureHandlerStateTemplate")
CreatePanel(petbg, petbuttonsize + (petbuttonspacing * 2), (petbuttonsize * 10) + (petbuttonspacing * 11), "RIGHT", QuBar5, "LEFT", -6, 0)

local ltpetbg1 = CreateFrame("Frame", "QuLineToPetActionBarBackground", petbg)
CreatePanel(ltpetbg1, 24, 265, "LEFT", petbg, "RIGHT", 0, 0)
ltpetbg1:SetParent(petbg)
ltpetbg1:SetFrameStrata("BACKGROUND")
ltpetbg1:SetFrameLevel(0)
CreateShadow(ltpetbg1)

local invbarbg = CreateFrame("Frame", "InvQuActionBarBackground", UIParent)
if Viks.actionbar.lowversion then
	invbarbg:SetPoint("TOPLEFT", QuBar1)
	invbarbg:SetPoint("BOTTOMRIGHT", QuBar1)
	QuBar2:Hide()
	QuBar3:Hide()
else
	invbarbg:SetPoint("TOPLEFT", QuBar2)
	invbarbg:SetPoint("BOTTOMRIGHT", QuBar3)
end
end

local addon = CreateFrame("Frame")

-- Based on the frame list from NDragIt by Nemes.
-- These frames are hooked on login.
local frames = {
  -- ["FrameName"] = true (the parent frame should be moved) or false (the frame itself should be moved)
  -- for child frames (i.e. frames that don't have a name, but only a parentKey="XX" use
  -- "ParentFrameName.XX" as frame name. more than one level is supported, e.g. "Foo.Bar.Baz")

  -- Blizzard Frames
  ["DraenorZoneAbilityFrame"] = false,
  ["SpellBookFrame"] = false,
  ["QuestLogFrame"] = false,
  ["QuestLogDetailFrame"] = false,
  ["FriendsFrame"] = false,
  ["KnowledgeBaseFrame"] = true,
  ["HelpFrame"] = false,
  ["GossipFrame"] = false,
  ["MerchantFrame"] = false,
  ["MailFrame"] = false,
  ["OpenMailFrame"] = false,
  ["GuildRegistrarFrame"] = false,
  ["DressUpFrame"] = false,
  ["TabardFrame"] = false,
  ["TaxiFrame"] = false,
  ["QuestFrame"] = false,
  ["TradeFrame"] = false,
  ["LootFrame"] = false,
  ["PetStableFrame"] = false,
  ["StackSplitFrame"] = false,
  ["PetitionFrame"] = false,
  ["WorldStateScoreFrame"] = false,
  ["BattlefieldFrame"] = false,
  ["ArenaFrame"] = false,
  ["ItemTextFrame"] = false,
  ["GameMenuFrame"] = false,
  ["InterfaceOptionsFrame"] = false,
  ["MacOptionsFrame"] = false,
  ["PetPaperDollFrame"] = true,
  ["PetPaperDollFrameCompanionFrame"] = "CharacterFrame",
  ["PetPaperDollFramePetFrame"] = "CharacterFrame",
  ["PaperDollFrame"] = true,
  ["ReputationFrame"] = true,
  ["SkillFrame"] = true,
  ["PVPFrame"] = not cata, -- changed in cataclysm
  ["PVPBattlegroundFrame"] = true,
  ["SendMailFrame"] = true,
  ["TokenFrame"] = true,
  ["InterfaceOptionsFrame"] = false,
  ["VideoOptionsFrame"] = false,
  ["AudioOptionsFrame"] = false,
  ["BankFrame"] = false,
  ["StaticPopup1"] = false,
  ["EncounterJournal"] = false, -- only in 4.2
  ["RaidParentFrame"] = false,
  ["TutorialFrame"] = false,
  ["MissingLootFrame"] = false,
  ["ScrollOfResurrectionSelectionFrame"] = false,

  -- New frames in MoP
  ["PVPBannerFrame"] = false,
  ["PVEFrame"] = false, -- dungeon finder + challenges
  ["GuildInviteFrame"] = false,
  ["WorldMapFrame"] = false,	
  -- AddOns
  ["LudwigFrame"] = false,
}


-- Frames provided by load on demand addons, hooked when the addon is loaded.
local lodFrames = {
  -- AddonName = { list of frames, same syntax as above }
  Blizzard_AuctionUI = { ["AuctionFrame"] = false },
  Blizzard_BindingUI = { ["KeyBindingFrame"] = false },
  Blizzard_CraftUI = { ["CraftFrame"] = false },
  Blizzard_GMSurveyUI = { ["GMSurveyFrame"] = false },
  Blizzard_InspectUI = { ["InspectFrame"] = false, ["InspectPVPFrame"] = true, ["InspectTalentFrame"] = true },
  Blizzard_ItemSocketingUI = { ["ItemSocketingFrame"] = false },
  Blizzard_MacroUI = { ["MacroFrame"] = false },
  Blizzard_TalentUI = { ["PlayerTalentFrame"] = false },
  Blizzard_TradeSkillUI = { ["TradeSkillFrame"] = false },
  Blizzard_TrainerUI = { ["ClassTrainerFrame"] = false },
  Blizzard_GuildBankUI = { ["GuildBankFrame"] = false, ["GuildBankEmblemFrame"] = true },
  Blizzard_TimeManager = { ["TimeManagerFrame"] = false },
  Blizzard_AchievementUI = { ["AchievementFrame"] = false, ["AchievementFrameHeader"] = true, ["AchievementFrameCategoriesContainer"] = "AchievementFrame" },
  Blizzard_TokenUI = { ["TokenFrame"] = true },
  Blizzard_ItemSocketingUI = { ["ItemSocketingFrame"] = false },
  Blizzard_BarbershopUI = { ["BarberShopFrame"] = false },
  Blizzard_Calendar = { ["CalendarFrame"] = false, ["CalendarCreateEventFrame"] = true },
  Blizzard_GuildUI = { ["GuildFrame"] = false, ["GuildRosterFrame"] = true },
  Blizzard_ReforgingUI = { ["ReforgingFrame"] = false, ["ReforgingFrameInvisibleButton"] = true, ["ReforgingFrame.InvisibleButton"] = true },
  Blizzard_ArchaeologyUI = { ["ArchaeologyFrame"] = false },
  Blizzard_LookingForGuildUI = { ["LookingForGuildFrame"] = false },
  Blizzard_VoidStorageUI = { ["VoidStorageFrame"] = false, ["VoidStorageBorderFrameMouseBlockFrame"] = "VoidStorageFrame" },
  Blizzard_ItemAlterationUI = { ["TransmogrifyFrame"] = false },
  Blizzard_EncounterJournal = { ["EncounterJournal"] = false }, -- as of 4.3

  -- New frames in MoP
  Blizzard_PetJournal = { ["PetJournalParent"] = false },
  Blizzard_BlackMarketUI = { ["BlackMarketFrame"] = false }, -- UNTESTED
  Blizzard_ChallengesUI = { ["ChallengesLeaderboardFrame"] = false }, -- UNTESTED
  Blizzard_ItemUpgradeUI = { ["ItemUpgradeFrame"] = false, }, -- UNTESTED
}

local parentFrame = {}
local hooked = {}

local function print(msg)
  DEFAULT_CHAT_FRAME:AddMessage("DragEmAll: " .. msg)
end

function addon:PLAYER_LOGIN()
  self:HookFrames(frames)
end

function addon:ADDON_LOADED(name)
  local frameList = lodFrames[name]
  if frameList then
    self:HookFrames(frameList)
  end
end

local function MouseDownHandler(frame, button)
  frame = parentFrame[frame] or frame
  if frame and button == "LeftButton" then
    frame:StartMoving()
    frame:SetUserPlaced(false)
  end
end

local function MouseUpHandler(frame, button)
  frame = parentFrame[frame] or frame
  if frame and button == "LeftButton" then
    frame:StopMovingOrSizing()
  end
end

function addon:HookFrames(list)
  for name, child in pairs(list) do
    self:HookFrame(name, child)
  end
end

function addon:HookFrame(name, moveParent)
  -- find frame
  -- name may contain dots for children, e.g. ReforgingFrame.InvisibleButton
  local frame = _G
  local s
  for s in string.gmatch(name, "%w+") do
    if frame then
      frame = frame[s]
    end
  end
  -- check if frame was found
  if frame == _G then
    frame = nil
  end

  local parent
  if frame and not hooked[name] then
    if moveParent then
      if type(moveParent) == "string" then
        parent = _G[moveParent]
      else
        parent = frame:GetParent()
      end
      if not parent then
        print("Parent frame not found: " .. name)
        return
      end
      parentFrame[frame] = parent
    end
    if parent then
      parent:SetMovable(true)
      parent:SetClampedToScreen(false)
    end
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(false)
    self:HookScript(frame, "OnMouseDown", MouseDownHandler)
    self:HookScript(frame, "OnMouseUp", MouseUpHandler)
    hooked[name] = true
  end
end

function addon:HookScript(frame, script, handler)
  if not frame.GetScript then return end
  local oldHandler = frame:GetScript(script)
  if oldHandler then
    frame:SetScript(script, function(...)
      handler(...)
      oldHandler(...)
    end)
  else
    frame:SetScript(script, handler)
  end
end

addon:SetScript("OnEvent", function(f, e, ...) f[e](f, ...) end)
addon:RegisterEvent("PLAYER_LOGIN")
addon:RegisterEvent("ADDON_LOADED")

-- Hook bag frames
-- This is buggy in MoP
if not mop then
  hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, size, id)
    if id <= NUM_BAG_FRAMES or id == KEYRING_CONTAINER then
      addon:HookFrame(frame:GetName())
    end
  end)
end

