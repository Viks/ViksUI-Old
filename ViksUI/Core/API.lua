﻿local T, Viks, L, _ = unpack(select(2, ...))

local backdropr, backdropg, backdropb, backdropa = unpack(Viks.media.backdropcolor)
local borderr, borderg, borderb, bordera = unpack(Viks.media.bordercolor)

----------------------------------------------------------------------------------------
--	Template functions
----------------------------------------------------------------------------------------
local function CreateOverlay(f)
	if f.overlay then return end

	local overlay = f:CreateTexture("$parentOverlay", "BORDER", f)
	overlay:SetPoint("TOPLEFT", 2, -2)
	overlay:SetPoint("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(Viks.media.blank_border)
	overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	f.overlay = overlay
end

local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", "$parentInnerBorder", f)
		border:SetPoint("TOPLEFT", T.mult, -T.mult)
		border:SetPoint("BOTTOMRIGHT", -T.mult, T.mult)
		border:SetBackdrop({
			edgeFile = Viks.media.blank_border, edgeSize = T.mult,
			insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
		})
		border:SetBackdropBorderColor(unpack(Viks.media.backdropcolor))
		f.iborder = border
	end

	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", "$parentOuterBorder", f)
		border:SetPoint("TOPLEFT", -T.mult, T.mult)
		border:SetPoint("BOTTOMRIGHT", T.mult, -T.mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop({
			edgeFile = Viks.media.blank_border, edgeSize = T.mult,
			insets = {left = T.mult, right = T.mult, top = T.mult, bottom = T.mult}
		})
		border:SetBackdropBorderColor(unpack(Viks.media.backdropcolor))
		f.oborder = border
	end
end

local function GetTemplate(t)
	if t == "ClassColor" then
		local c = T.oUF_colors.class[T.class]
		borderr, borderg, borderb, bordera = c[1], c[2], c[3], c[4]
		backdropr, backdropg, backdropb, backdropa = unpack(Viks.media.backdropcolor)
	else
		borderr, borderg, borderb, bordera = unpack(Viks.media.bordercolor)
		backdropr, backdropg, backdropb, backdropa = unpack(Viks.media.backdropcolor)
	end
end

local function SetTemplate(f, t)
	GetTemplate(t)

	f:SetBackdrop({
		bgFile = Viks.media.blank_border, edgeFile = Viks.media.blank_border, edgeSize = T.mult,
		insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
	})

	if t == "Transparent" then
		backdropa = Viks.media.overlay_color[4]
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	else
		backdropa = Viks.media.backdropcolor[4]
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	GetTemplate(t)

	f:SetWidth(w)
	f:SetHeight(h)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
		bgFile = Viks.media.blank_border, edgeFile = Viks.media.blank_border, edgeSize = T.mult,
		insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
	})

	if t == "Transparent" then
		backdropa = Viks.media.overlay_color[4]
		f:CreateBorder(true, true)
	elseif t == "Overlay" then
		backdropa = 1
		f:CreateOverlay()
	elseif t == "Invisible" then
		backdropa = 0
		bordera = 0
	else
		backdropa = Viks.media.backdropcolor[4]
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
end

local function CreateBackdrop(f, t)
	if not t then t = "Default" end

	local b = CreateFrame("Frame", "$parentBackdrop", f)
	b:SetPoint("TOPLEFT", -2, 2)
	b:SetPoint("BOTTOMRIGHT", 2, -2)
	b:SetTemplate(t)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end

	f.backdrop = b
end

local function StripTextures(object, kill)
	for i = 1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Kill()
			else
				region:SetTexture(nil)
			end
		end
	end
end

--Old Border style, TODO on cleaning up.
function frame1px1_1(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = T.mult, 
		insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult} 
	})
	f:SetPoint("TOPLEFT", -2, 2)
	f:SetPoint("BOTTOMRIGHT", 2, -2)
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
end

function frame1px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = T.mult, 
		insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult} 
	})
	f:SetBackdropColor(unpack(Viks.media.backdropcolor))
	f:SetBackdropBorderColor(unpack(Viks.media.bordercolor))	
end
----------------------------------------------------------------------------------------
--	Kill object function
----------------------------------------------------------------------------------------
local HiddenFrame = CreateFrame("Frame")
HiddenFrame:Hide()
local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
		object:SetParent(HiddenFrame)
	else
		object.Show = T.dummy
	end
	object:Hide()
end

----------------------------------------------------------------------------------------
--	Style ActionBars/Bags buttons function(by Chiril & Karudon)
----------------------------------------------------------------------------------------
local function StyleButton(button, t, size)
	if not size then size = 2 end
	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture(nil, nil, self)
		hover:SetTexture(1, 1, 1, 0.3)
		hover:SetPoint("TOPLEFT", button, size, -size)
		hover:SetPoint("BOTTOMRIGHT", button, -size, size)
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if not t and button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture(nil, nil, self)
		pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		pushed:SetPoint("TOPLEFT", button, size, -size)
		pushed:SetPoint("BOTTOMRIGHT", button, -size, size)
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture(nil, nil, self)
		checked:SetTexture(0, 1, 0, 0.3)
		checked:SetPoint("TOPLEFT", button, size, -size)
		checked:SetPoint("BOTTOMRIGHT", button, -size, size)
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, size, -size)
		cooldown:SetPoint("BOTTOMRIGHT", button, -size, size)
	end
end

----------------------------------------------------------------------------------------
--	Style buttons function
----------------------------------------------------------------------------------------
T.SetModifiedBackdrop = function(self)
	if self:GetButtonState() == "DISABLED" then return end
	self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	if self.overlay then
		self.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
	end
end

T.SetOriginalBackdrop = function(self)
	if self:GetButtonState() == "DISABLED" then return end
	self:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	if self.overlay then
		self.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	end
end

local function SkinButton(f, strip)
	if strip then f:StripTextures() end

	if f.SetNormalTexture then f:SetNormalTexture("") end
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	if f.SetPushedTexture then f:SetPushedTexture("") end
	if f.SetDisabledTexture then f:SetDisabledTexture("") end

	if f.Left then f.Left:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.LeftSeparator then f.LeftSeparator:SetAlpha(0) end
	if f.RightSeparator then f.RightSeparator:SetAlpha(0) end
	if f.Flash then f.Flash:SetAlpha(0) end

	if f.TopLeft then f.TopLeft:Hide() end
	if f.TopRight then f.TopRight:Hide() end
	if f.BottomLeft then f.BottomLeft:Hide() end
	if f.BottomRight then f.BottomRight:Hide() end
	if f.TopMiddle then f.TopMiddle:Hide() end
	if f.MiddleLeft then f.MiddleLeft:Hide() end
	if f.MiddleRight then f.MiddleRight:Hide() end
	if f.BottomMiddle then f.BottomMiddle:Hide() end
	if f.MiddleMiddle then f.MiddleMiddle:Hide() end

	f:SetTemplate("Overlay")
	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

----------------------------------------------------------------------------------------
--	Font function
----------------------------------------------------------------------------------------
local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")

	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end

	return fs
end

----------------------------------------------------------------------------------------
--	Fade in/out functions
----------------------------------------------------------------------------------------
local function FadeIn(f)
	UIFrameFadeIn(f, 0.4, f:GetAlpha(), 1)
end

local function FadeOut(f)
	UIFrameFadeOut(f, 0.8, f:GetAlpha(), 0)
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.Size then mt.Size = Size end
	if not object.Width then mt.Width = Width end
	if not object.Height then mt.Height = Height end
	if not object.Point then mt.Point = Point end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
	if not object.CreatePanel then mt.CreatePanel = CreatePanel end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.Kill then mt.Kill = Kill end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.SkinButton then mt.SkinButton = SkinButton end
	if not object.FontString then mt.FontString = FontString end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end