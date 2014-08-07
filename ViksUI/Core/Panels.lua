local T, Viks, L, _ = unpack(select(2, ...))


----------------------------------------------------------------------------------------
-- Default Size Values
----------------------------------------------------------------------------------------
--//Using UiScale and Tw to calculate width on some panels
local UiScale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
local Tw = WorldFrame:GetWidth()


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

if Viks.panels.NoPanels == true then
pAlpha = 0
else
pAlpha = 1
end
----------------------------------------------------------------------------------------
-- LEFT Panels
----------------------------------------------------------------------------------------

--Left Bottom Panel
local LBottom = CreateFrame("Frame", "LBottom", UIParent) 			
LBottom:CreatePanel("Transparent", CPwidth*Pscale, CPbarsheight*Pscale, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xoffset, yoffset)
LBottom:SetFrameLevel(2)
LBottom:SetAlpha(pAlpha)

--Left Chat Panel
local LChat = CreateFrame("Frame", "LChat", UIParent) 			
LChat:CreatePanel("Transparent", CPwidth*Pscale, CPTextheight*Pscale, "BOTTOMLEFT", LBottom, "TOPLEFT", 0, yoffset)
LChat:SetFrameLevel(2)
LChat:SetAlpha(pAlpha)

--Left Chat Tab Panel
local LChatTab = CreateFrame("Frame", "LChatTab", UIParent) 			
LChatTab:CreatePanel("Transparent", CPwidth*Pscale, CPbarsheight*Pscale, "BOTTOMLEFT", LChat, "TOPLEFT", 0, yoffset+1)
LChatTab:SetFrameLevel(2)
LChatTab:SetAlpha(pAlpha)

-- Left Action Bar Next to chat
local LABar = CreateFrame("Frame", "LABar", UIParent) 
LABar:CreatePanel("Transparent", CPABarSide*Pscale, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset+1), "BOTTOMLEFT", LBottom, "BOTTOMRIGHT", xoffset, 0)
LABar:SetFrameLevel(2)
LABar:SetAlpha(pAlpha)

--Background Panel For Recount if used
if IsAddOnLoaded("Recount") then
local L_Recount = CreateFrame("Frame", "L_Recount", Recount_MainWindow)
L_Recount:CreatePanel("Transparent", Pscale*CPSidesWidth, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset), "BOTTOMLEFT", LABar, "BOTTOMRIGHT", xoffset, 0)
L_Recount:SetFrameLevel(2)
L_Recount:SetAlpha(pAlpha)
 else

end

----------------------------------------------------------------------------------------
-- RIGHT SIDE PANELS
----------------------------------------------------------------------------------------

--Right Bottom Panel
local RBottom = CreateFrame("Frame", "RBottom", UIParent)
RBottom:CreatePanel("Transparent", Pscale*CPwidth, Pscale*CPbarsheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -xoffset, yoffset)
RBottom:SetFrameLevel(2)
RBottom:SetAlpha(pAlpha)

--Right Chat Panel
local RChat = CreateFrame("Frame", "RChat", UIParent)
RChat:CreatePanel("Transparent", Pscale*CPwidth, Pscale*CPTextheight, "BOTTOMLEFT", RBottom, "TOPLEFT", 0, yoffset)
RChat:SetFrameLevel(2)
RChat:SetAlpha(pAlpha)

--Right Chat Tab Panel
local RChatTab = CreateFrame("Frame", "RChatTab", UIParent)
RChatTab:CreatePanel("Transparent", Pscale*CPwidth, Pscale*CPbarsheight, "BOTTOMLEFT", RChat, "TOPLEFT", 0, yoffset+1)
RChatTab:SetFrameLevel(2)
RChatTab:SetAlpha(pAlpha)

-- Right Action Bar Next to chat
local RABar = CreateFrame("Frame", "RABar", UIParent)
RABar:CreatePanel("Transparent", Pscale*CPABarSide, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset+1), "BOTTOMRIGHT", RBottom, "BOTTOMLEFT", -xoffset, 0)
RABar:SetFrameLevel(2)
RABar:SetAlpha(pAlpha)

--Background Panel For Omen if used
if IsAddOnLoaded("Omen") then
local R_Omen = CreateFrame("Frame", "R_Omen",OmenBarList)
R_Omen:CreatePanel("Transparent", Pscale*CPSidesWidth, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset), "BOTTOMRIGHT", RABar, "BOTTOMLEFT", -xoffset, 0)
R_Omen:SetFrameLevel(2)
R_Omen:SetAlpha(pAlpha)
 else

end

----------------------------------------------------------------------------------------
-- OTHER PANELS
----------------------------------------------------------------------------------------

--Top of Screen Panel
local CPTopp = CreateFrame("Frame", "CPTopp",UIParent)
CPTopp:CreatePanel("Transparent", (Tw/UiScale)-5, CPbarsheight, "TOP", UIParent, "TOP", 0, -1)
CPTopp:SetFrameLevel(2)
CPTopp:SetAlpha(pAlpha)

--Background for Minimap
local CPMinim = CreateFrame("Frame", "CPMinim",UIParent)
CPMinim:CreatePanel("Transparent", Pscale*CPMinimap, Pscale*CPMinimap, "TOPRIGHT", CPTopp, "BOTTOMRIGHT", 0, -(yoffset+1))
CPMinim:SetFrameLevel(2)
--If minimap is turned off hide the panel. We are anchoring stuff to this frame so it's needed!
if Viks.minimapp.enable == true then
CPMinim:SetAlpha(pAlpha)
else
CPMinim:SetAlpha(pAlpha)
end

--Background for Minimap Button 1, Right
local CPMinimb1 = CreateFrame("Frame", "CPMinimb1",UIParent)
CPMinimb1:CreatePanel("Transparent", (.5*(Pscale*CPMinimap))-(xoffset/2), Pscale*CPbarsheight, "TOPRIGHT", CPMinim, "BOTTOMRIGHT", 0, -yoffset)
CPMinimb1:SetFrameLevel(2)
if Viks.minimapp.minimb1 == true then
CPMinimb1:SetAlpha(pAlpha)
else
CPMinimb1:SetAlpha(pAlpha)
end

--Background for Minimap Button 1, LEFT
local CPMinimb2 = CreateFrame("Frame", "CPMinimb2",UIParent)
CPMinimb2:CreatePanel("Transparent", (.5*(Pscale*CPMinimap))-(xoffset/2), Pscale*CPbarsheight, "TOPLEFT", CPMinim, "BOTTOMLEFT", 0, -yoffset)
CPMinimb2:SetFrameLevel(2)
if Viks.minimapp.minimb2 == true then
CPMinimb2:SetAlpha(pAlpha)
else
CPMinimb2:SetAlpha(pAlpha)
end

--Background for Cooldownbar
local CPCool = CreateFrame("Frame", "CPCool",UIParent)
CPCool:CreatePanel("Transparent", Pscale*CPMABwidth, Pscale*CPCooldheight, "BOTTOM", UIParent, "BOTTOM", 0, 5)
CPCool:SetFrameLevel(2)
CPCool:SetAlpha(pAlpha)


--Backgrounds for Extra Actionbar Buttons
if Viks.misc.BT4Bars == true then
 -- Right side Actionbar (Close to right edge)
local SideBar = CreateFrame("Frame", "SideBar", UIParent)
SideBar:CreatePanel("Transparent", 1+(CPABarSide*Pscale), Pscale*(400), "RIGHT", UIParent, "RIGHT", -xoffset, 1)
SideBar:SetFrameLevel(2)
SideBar:SetAlpha(pAlpha)

 -- Left Side Action Bar Next to chat
local EBarL = CreateFrame("Frame", "EBarL", UIParent)
EBarL:CreatePanel("Transparent", ((Pscale*((CPMABwidth/13)*3))*0.75), 0.75*(Pscale*CPMABheight), "RIGHT", CPMAB, "LEFT", -10, 0)
EBarL:SetFrameLevel(2)
EBarL:SetAlpha(pAlpha)

 -- Left Side Action Bar Next to chat
local EBarR = CreateFrame("Frame", "EBarR", UIParent) -- Left Side Action Bar Next to chat
EBarR:CreatePanel("Transparent", ((Pscale*((CPMABwidth/13)*3))*0.75), 0.75*(Pscale*CPMABheight), "LEFT", CPMAB, "RIGHT", 10, 0)
EBarR:SetFrameLevel(2)
EBarR:SetAlpha(pAlpha)
end


----------------------------------------------------------------------------------------
--	Lines when panels are hidden
----------------------------------------------------------------------------------------

if Viks.panels.NoPanels == true then

----------------------------------------------------------------------------------------
--	Bottom line
----------------------------------------------------------------------------------------
local bottompanel = CreateFrame("Frame", "BottomPanel", UIParent)
bottompanel:CreatePanel("ClassColor", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:SetPoint("LEFT", UIParent, "LEFT", 3, 0)
bottompanel:SetPoint("RIGHT", UIParent, "RIGHT", -3, 0)


----------------------------------------------------------------------------------------
--	Chat Lines
----------------------------------------------------------------------------------------
local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
leftpanel:CreatePanel("ClassColor", 1, Viks.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)

local rightpanel = CreateFrame("Frame", "RightPanel", UIParent)
rightpanel:CreatePanel("ClassColor", 1, Viks.chat.height - 2, "BOTTOMRIGHT", bottompanel, "RIGHT", 0, 0)

local CPCool = CreateFrame("Frame", "CPCool",UIParent)
CPCool:CreatePanel("ClassColor", Pscale*CPMABwidth, Pscale*CPCooldheight, "BOTTOM", UIParent, "BOTTOM", 0, 5)

--Background for Main Action Bar
local CPMAB = CreateFrame("Frame", "CPMAB",UIParent)
CPMAB:CreatePanel("ClassColor", Pscale*CPMABwidth, Pscale*CPMABheight, "BOTTOM", UIParent, "BOTTOM", 0, CPMAByoffset)
CPMAB:SetFrameLevel(2)
CPMAB:SetBackdropColor(0, 0, 0, 0)
else
--Background for Main Action Bar
local CPMAB = CreateFrame("Frame", "CPMAB",UIParent)
CPMAB:CreatePanel("Transparent", Pscale*CPMABwidth, Pscale*CPMABheight, "BOTTOM", UIParent, "BOTTOM", 0, CPMAByoffset)
CPMAB:SetFrameLevel(2)
end
RegisterStateDriver(CPCool, "visibility", "[petbattle] hide; show")
RegisterStateDriver(CPMAB, "visibility", "[petbattle] hide; show")

--[[
----------------------------------------------------------------------------------------
--	Bottom bars anchor
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", oUF_PetBattleFrameHider)
bottombaranchor:CreatePanel("Invisible", 1, 1, unpack(Viks.position.bottom_bars))
bottombaranchor:SetWidth((Viks.actionbar.button_size * 12) + (Viks.actionbar.button_space * 11))
if Viks.actionbar.bottombars == 2 then
	bottombaranchor:SetHeight((Viks.actionbar.button_size * 2) + Viks.actionbar.button_space)
elseif Viks.actionbar.bottombars == 3 then
	if Viks.actionbar.split_bars == true then
		bottombaranchor:SetHeight((Viks.actionbar.button_size * 2) + Viks.actionbar.button_space)
	else
		bottombaranchor:SetHeight((Viks.actionbar.button_size * 3) + (Viks.actionbar.button_space * 2))
	end
else
	bottombaranchor:SetHeight(Viks.actionbar.button_size)
end
bottombaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars anchor
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", oUF_PetBattleFrameHider)
rightbaranchor:CreatePanel("Invisible", 1, 1, unpack(Viks.position.right_bars))
rightbaranchor:SetHeight((Viks.actionbar.button_size * 12) + (Viks.actionbar.button_space * 11))
if Viks.actionbar.rightbars == 1 then
	rightbaranchor:SetWidth(Viks.actionbar.button_size)
elseif Viks.actionbar.rightbars == 2 then
	rightbaranchor:SetWidth((Viks.actionbar.button_size * 2) + Viks.actionbar.button_space)
elseif Viks.actionbar.rightbars == 3 then
	rightbaranchor:SetWidth((Viks.actionbar.button_size * 3) + (Viks.actionbar.button_space * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Split bar anchor
----------------------------------------------------------------------------------------
if Viks.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", oUF_PetBattleFrameHider)
	SplitBarLeft:CreatePanel("Invisible", (Viks.actionbar.button_size * 3) + (Viks.actionbar.button_space * 2), (Viks.actionbar.button_size * 2) + Viks.actionbar.button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -Viks.actionbar.button_space, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", oUF_PetBattleFrameHider)
	SplitBarRight:CreatePanel("Invisible", (Viks.actionbar.button_size * 3) + (Viks.actionbar.button_space * 2), (Viks.actionbar.button_size * 2) + Viks.actionbar.button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", Viks.actionbar.button_space, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar anchor
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", oUF_PetBattleFrameHider)
petbaranchor:SetFrameStrata("LOW")
if Viks.actionbar.rightbars > 0 then
	if Viks.actionbar.petbar_horizontal == true then
		petbaranchor:CreatePanel("Invisible", (Viks.actionbar.button_size * 10) + (Viks.actionbar.button_space * 9), (Viks.actionbar.button_size + Viks.actionbar.button_space), unpack(Viks.position.pet_horizontal))
	else
		petbaranchor:CreatePanel("Invisible", Viks.actionbar.button_size + 3, (Viks.actionbar.button_size * 10) + (Viks.actionbar.button_space * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
	end
else
	petbaranchor:CreatePanel("Invisible", (Viks.actionbar.button_size + Viks.actionbar.button_space), (Viks.actionbar.button_size * 10) + (Viks.actionbar.button_space * 9), unpack(Viks.position.right_bars))
end

----------------------------------------------------------------------------------------
--	Stance bar anchor
----------------------------------------------------------------------------------------
if Viks.actionbar.stancebar_hide ~= true then
	local shiftanchor = CreateFrame("Frame", "ShapeShiftBarAnchor", oUF_PetBattleFrameHider)
	shiftanchor:RegisterEvent("PLAYER_LOGIN")
	shiftanchor:RegisterEvent("PLAYER_ENTERING_WORLD")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	shiftanchor:SetScript("OnEvent", function(self, event, ...)
		local forms = GetNumShapeshiftForms()
		if forms > 0 then
			if Viks.actionbar.stancebar_horizontal ~= true then
				shiftanchor:SetWidth(Viks.actionbar.button_size + 3)
				shiftanchor:SetHeight((Viks.actionbar.button_size * forms) + ((Viks.actionbar.button_space * forms) - 3))
				shiftanchor:SetPoint("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
			else
				shiftanchor:SetWidth((Viks.actionbar.button_size * forms) + ((Viks.actionbar.button_space * forms) - 3))
				shiftanchor:SetHeight(Viks.actionbar.button_size)
				shiftanchor:SetPoint("TOPLEFT", _G["StanceButton1"], "TOPLEFT")
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Bottom line
----------------------------------------------------------------------------------------
local bottompanel = CreateFrame("Frame", "BottomPanel", UIParent)
bottompanel:CreatePanel("ClassColor", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:SetPoint("LEFT", UIParent, "LEFT", 21, 0)
bottompanel:SetPoint("RIGHT", UIParent, "RIGHT", -21, 0)

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if Viks.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", Viks.chat.width + 7, Viks.chat.height + 4, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 1)
	chatbd:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	chatbd:SetBackdropColor(0, 0, 0, Viks.chat.background_alpha)

	if Viks.chat.tabs_mouseover ~= true then
		local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
		chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3)
		chattabs:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		chattabs:SetBackdropColor(0, 0, 0, Viks.chat.background_alpha)
	end
else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel("ClassColor", 1, Viks.chat.height - 2, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
end

--]]
----------------------------------------------------------------------------------------
--	Top panel
----------------------------------------------------------------------------------------
if Viks.toppanel.enable ~= true then return end

local toppanelanchor = CreateFrame("Frame", "TopPanelAnchor", oUF_PetBattleFrameHider)
toppanelanchor:SetPoint(unpack(Viks.position.top_panel))
toppanelanchor:SetSize(Viks.toppanel.width, Viks.toppanel.height / 2)

local toppanel = CreateFrame("Frame", "TopPanel", oUF_PetBattleFrameHider)
toppanel:SetPoint("CENTER", toppanelanchor, "CENTER", 0, 0)
toppanel:SetSize(Viks.toppanel.width, Viks.toppanel.height / 2)
if Viks.toppanel.mouseover == true then
	toppanel:SetAlpha(0)
	toppanel:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		toppanel:SetAlpha(1)
	end)
	toppanel:SetScript("OnLeave", function()
		toppanel:SetAlpha(0)
	end)
end

toppanel.bgl = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgl:SetPoint("RIGHT", toppanel, "CENTER", 0, 0)
toppanel.bgl:SetSize(Viks.toppanel.width / 2, Viks.toppanel.height / 2)
toppanel.bgl:SetTexture(Viks.media.blank_border)
toppanel.bgl:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0, T.color.r, T.color.g, T.color.b, 0.1)

toppanel.bgr = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgr:SetPoint("LEFT", toppanel, "CENTER", 0, 0)
toppanel.bgr:SetSize(Viks.toppanel.width / 2, Viks.toppanel.height / 2)
toppanel.bgr:SetTexture(Viks.media.blank_border)
toppanel.bgr:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0.1, T.color.r, T.color.g, T.color.b, 0)

toppanel.tbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tbl:SetSize(Viks.toppanel.width / 2, 3)
toppanel.tbl:SetTexture(Viks.media.blank_border)
toppanel.tbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.tcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tcl:SetSize(Viks.toppanel.width / 2, 1)
toppanel.tcl:SetTexture(Viks.media.blank_border)
toppanel.tcl:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0, T.color.r, T.color.g, T.color.b, 1)

toppanel.tbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tbr:SetSize(Viks.toppanel.width / 2, 3)
toppanel.tbr:SetTexture(Viks.media.blank_border)
toppanel.tbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.tcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tcr:SetSize(Viks.toppanel.width / 2, 1)
toppanel.tcr:SetTexture(Viks.media.blank_border)
toppanel.tcr:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 1, T.color.r, T.color.g, T.color.b, 0)

toppanel.bbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bbl:SetSize(Viks.toppanel.width / 2, 3)
toppanel.bbl:SetTexture(Viks.media.blank_border)
toppanel.bbl:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, 0, 0, 0, 1)

toppanel.bcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bcl:SetSize(Viks.toppanel.width / 2, 1)
toppanel.bcl:SetTexture(Viks.media.blank_border)
toppanel.bcl:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 0, T.color.r, T.color.g, T.color.b, 1)

toppanel.bbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bbr:SetSize(Viks.toppanel.width / 2, 3)
toppanel.bbr:SetTexture(Viks.media.blank_border)
toppanel.bbr:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 1, 0, 0, 0, 0)

toppanel.bcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bcr:SetSize(Viks.toppanel.width / 2, 1)
toppanel.bcr:SetTexture(Viks.media.blank_border)
toppanel.bcr:SetGradientAlpha("HORIZONTAL", T.color.r, T.color.g, T.color.b, 1, T.color.r, T.color.g, T.color.b, 0)