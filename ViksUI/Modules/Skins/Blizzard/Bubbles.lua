local T, Viks, L, _ = unpack(select(2, ...))
if Viks.chat.bubbles ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBubbles skin(by Haleth)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame", nil, UIParent)
local noscalemult = T.mult * Viks.general.UiScale
local total = 0
local numKids = 0

backdropr, backdropg, backdropb, backdropa = unpack(Viks.media.overlay_color)
if Viks.chat.transp_bubbles == true then
backdropa = Viks.chat.transp_bubbles_a
else
end

local function styleBubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		end
	end

	frame:SetBackdrop({
		bgFile = Viks.media.blank_border, edgeFile = Viks.media.blank_border, edgeSize = noscalemult,
		insets = {left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
	})
	frame:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	frame:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
	frame:SetClampedToScreen(false)
	frame:SetFrameStrata("BACKGROUND")
end


f:SetScript("OnUpdate", function(self, elapsed)
	total = total + elapsed
	if total > 0.1 then
		total = 0
		local newNumKids = WorldFrame:GetNumChildren()
		if newNumKids ~= numKids then
			for i = numKids + 1, newNumKids do
				local frame = select(i, WorldFrame:GetChildren())
				local b = frame:GetBackdrop()
				if b and b.bgFile == [[Interface\Tooltips\ChatBubble-Background]] then
					styleBubble(frame)
				end
			end
			numKids = newNumKids
		end
	end
end)