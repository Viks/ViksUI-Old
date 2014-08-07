
------------------------------------------------------------------------------------------
--	Kill textture for ExtraActionBarFrame & Add new profile to Masque
------------------------------------------------------------------------------------------
local button = ExtraActionButton1
local texture = button.style
local icon = button.icon
local disableTexture = function(style, texture)
	if texture then
		style:SetTexture(nil)
	end
end
icon:SetTexCoord(.08, .92, .08, .92)
icon:SetPoint("TOPLEFT", button, 2,-2)
icon:SetPoint("BOTTOMRIGHT", button, -2,2)
button.style:SetTexture(nil)
hooksecurefunc(texture, "SetTexture", disableTexture)

--Creating Masque group for the button
local MSQ = LibStub and LibStub("Masque", true)
if MSQ then
	MSQ:Group("ExtraActionButton1_"):AddButton(ExtraActionButton1)
end
