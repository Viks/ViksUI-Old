local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Skin TimerTracker(by Tukz)
----------------------------------------------------------------------------------------
local function SkinIt(bar)
	for i = 1, bar:GetNumRegions() do
		local region = select(i, bar:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		elseif region:GetObjectType() == "FontString" then
			region:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
			region:SetShadowOffset(0, 0)
		end
	end

	bar:CreateBackdrop("Default")
	bar:SetStatusBarTexture(Viks.media.texture)
	bar:SetStatusBarColor(0.7, 0, 0)

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(Viks.media.texture)
	bar.bg:SetVertexColor(0.7, 0, 0, 0.3)
end

local function SkinBlizzTimer()
	for _, b in pairs(TimerTracker.timerList) do
		if b["bar"] and not b["bar"].skinned then
			SkinIt(b["bar"])
			b["bar"].skinned = true
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("START_TIMER")
frame:SetScript("OnEvent", SkinBlizzTimer)