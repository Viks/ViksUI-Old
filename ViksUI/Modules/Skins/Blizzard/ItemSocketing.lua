local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemSocketingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemSocketingFrame:StripTextures()
	ItemSocketingFrame:CreateBackdrop("Transparent")
	ItemSocketingFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	ItemSocketingFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	ItemSocketingFrameInset:StripTextures()
	ItemSocketingScrollFrame:StripTextures()
	ItemSocketingScrollFrame:CreateBackdrop("Overlay")

	for i = 1, MAX_NUM_SOCKETS do
		local button = _G["ItemSocketingSocket"..i]
		local button_bracket = _G["ItemSocketingSocket"..i.."BracketFrame"]
		local button_bg = _G["ItemSocketingSocket"..i.."Background"]
		local button_icon = _G["ItemSocketingSocket"..i.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Overlay")
		button_bracket:Kill()
		button_bg:Kill()

		button_icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button_icon:ClearAllPoints()
		button_icon:SetPoint("TOPLEFT", 2, -2)
		button_icon:SetPoint("BOTTOMRIGHT", -2, 2)
		ItemSocketingFrame:HookScript("OnUpdate", function(self)
			gemColor = GetSocketTypes(i)
			local color = GEM_TYPE_INFO[gemColor]
			button:SetBackdropBorderColor(color.r, color.g, color.b)
			button.overlay:SetVertexColor(color.r, color.g, color.b, 0.35)
		end)
	end

	ItemSocketingFramePortrait:Kill()
	ItemSocketingSocketButton:ClearAllPoints()
	ItemSocketingSocketButton:SetPoint("BOTTOMRIGHT", ItemSocketingFrame.backdrop, "BOTTOMRIGHT", -5, 5)
	ItemSocketingSocketButton:SkinButton()
	T.SkinCloseButton(ItemSocketingFrameCloseButton, ItemSocketingFrame.backdrop)
end

T.SkinFuncs["Blizzard_ItemSocketingUI"] = LoadSkin