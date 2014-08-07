local T, Viks, L, _ = unpack(select(2, ...))
if Viks.misc.MMBFbutton then
local _, class = UnitClass("player")
--local r, g, b = CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b
local r, g, b = unpack(Viks.media.pxcolor1)
-----------------------------------------------------------------------------
--MBF TOGGLE
-----------------------------------------------------------------------------
function MBFTOGGLE()
		local button = CreateFrame("Button", "MBFToggle", UIParent)
		button:SetHeight(22)
		button:SetWidth(20)
		button:SetPoint("LEFT", CPMinimb2,"LEFT", 4, 2)
				
		local buttontext = button:CreateFontString(nil,"OVERLAY",nil)
		buttontext:SetFont(Viks.media.pxfont,Viks.media.pxfontsize,"OUTLINE")
		buttontext:SetText("MB")
		buttontext:SetPoint("CENTER", 0, -1)
		buttontext:SetJustifyH("CENTER")
		buttontext:SetJustifyV("CENTER")
		buttontext:SetTextColor(r,g,b) 
						
		button:SetScript("OnMouseUp", function(self, btn)
				MBFC_Visible(1)
		end)
end
MBFTOGGLE()


end
