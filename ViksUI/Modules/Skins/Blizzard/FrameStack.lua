local T, Viks, L, _ = unpack(select(2, ...))
if Viks.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	FrameStackTooltip skin(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", nil, UIParent)
frame:SetScript("OnUpdate", function(self, elapsed)
	if IsAddOnLoaded("Aurora") then return end

	if self.elapsed and self.elapsed > 0.1 then
		if FrameStackTooltip then
			FrameStackTooltip:SetBackdrop({
				bgFile = Viks.media.blank, edgeFile = Viks.media.blank, edgeSize = T.noscalemult,
				insets = {left = -T.noscalemult, right = -T.noscalemult, top = -T.noscalemult, bottom = -T.noscalemult}
			})
			FrameStackTooltip:SetBackdropColor(unpack(Viks.media.overlay_color))
			FrameStackTooltip:SetBackdropBorderColor(unpack(Viks.media.bordercolor))
			FrameStackTooltip.SetBackdropColor = T.dummy
			FrameStackTooltip.SetBackdropBorderColor = T.dummy
			self.elapsed = nil
			self:SetScript("OnUpdate", nil)
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
end)