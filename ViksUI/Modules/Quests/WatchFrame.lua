
local T, Viks, L, _ = unpack(select(2, ...))
if Viks.misc.WatchFrame then
local _, class = UnitClass("player")
local r, g, b = unpack(Viks.media.pxcolor1)
------------------------------
--Watch Frame
------------------------------
local noop = function() end
local showTitle = false
local showCollapseButton = false
local origTitleShow, origCollapseShow = WatchFrameTitle.Show, WatchFrameCollapseExpandButton.Show
local frame = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
frame:SetPoint("TOPRIGHT", CPMinimb1, "BOTTOMLEFT", 40, 10)
frame:SetHeight(150)

if GetCVar("watchFrameWidth") == "1" then
	frame:SetWidth(326)
else
	frame:SetWidth(224)
end

function ToggleTitle()
	if showTitle then
		WatchFrameTitle.Show = origTitleShow
		WatchFrameTitle:Show()
	else
		WatchFrameTitle:Hide()
		WatchFrameTitle.Show = noop
	end
end
ToggleTitle()

WatchFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
WatchFrame:SetHeight(450)

hooksecurefunc(WatchFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		WatchFrame:ClearAllPoints()
		WatchFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end
end)

function ToggleButton()
	if showCollapseButton then
		WatchFrameCollapseExpandButton.Show = origCollapseShow
		WatchFrameCollapseExpandButton:Show()
	else
		WatchFrameCollapseExpandButton:Hide()
		WatchFrameCollapseExpandButton.Show = noop
	end
end
ToggleButton()

function watchFButton()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d",  i)]
		local button = CreateFrame("Button", format("ButtonCF%d", i), cf)
		button:SetHeight(CPMinimb1:GetHeight())
		button:SetWidth(CPMinimb1:GetWidth())
		button:SetPoint("CENTER", CPMinimb1, "CENTER")
			
		local buttontext = button:CreateFontString(nil,"OVERLAY",nil)
		buttontext:SetFont(Viks.media.pxfont,Viks.media.pxfontsize,"OUTLINE")
		buttontext:SetText("Watch")
		buttontext:SetPoint("CENTER", 1, 1)
		buttontext:SetJustifyH("CENTER")
		buttontext:SetJustifyV("CENTER")
		buttontext:SetTextColor(unpack(Viks.media.bordercolor)) 
		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:AddLine("Left-click to toggle the Watch Frame.")
			GameTooltip:AddLine("Shift-click to toggle the achievements window.")
			GameTooltip:AddLine("Right-click to open the Quest Frame")
			GameTooltip:Show()
		end)
	button:SetScript("OnLeave", function() GameTooltip:Hide() end)				
		button:SetScript("OnMouseUp", function(self, btn)
			if IsShiftKeyDown() then
			ToggleAchievementFrame()
			elseif btn == "RightButton" then
				ToggleFrame(QuestLogFrame)
			else
				WatchFrame_CollapseExpandButton_OnClick()
			end
		end)
	end

end
watchFButton()

----------------------------------------------------------------------------------------
--	Skin WatchFrame item buttons
----------------------------------------------------------------------------------------
hooksecurefunc("WatchFrameItem_UpdateCooldown", function(self)
	if not self.skinned and not InCombatLockdown() then
		local icon = _G[self:GetName().."IconTexture"]
		local border = _G[self:GetName().."NormalTexture"]
		local count = _G[self:GetName().."Count"]
		local hotkey = _G[self:GetName().."HotKey"]

		self:SetSize(25, 25)
		self:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", self, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", self, -2, 2)

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 0, 2)
		count:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
		count:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)

		border:SetTexture(nil)

		self:StyleButton()

		self.skinned = true
	end
end)

----------------------------------------------------------------------------------------
--	Difficulty color for WatchFrame lines
----------------------------------------------------------------------------------------
hooksecurefunc("WatchFrame_Update", function()
	local numQuestWatches = GetNumQuestWatches()

	for i = 1, numQuestWatches do
		local questIndex = GetQuestIndexForWatch(i)
		if questIndex then
			local title, level = GetQuestLogTitle(questIndex)
			local col = GetQuestDifficultyColor(level)

			for j = 1, #WATCHFRAME_QUESTLINES do
				if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					WATCHFRAME_QUESTLINES[j].text:SetTextColor(col.r, col.g, col.b)
					WATCHFRAME_QUESTLINES[j].col = col
				end
			end
			for k = 1, #WATCHFRAME_ACHIEVEMENTLINES do
				WATCHFRAME_ACHIEVEMENTLINES[k].col = nil
			end
		end
	end
end)

hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
	i = self.startLine
	if not (self.lines[i] and self.lines[i].col) then return end
	if onEnter then
		self.lines[i].text:SetTextColor(1, 0.8, 0)
	else
		self.lines[i].text:SetTextColor(self.lines[i].col.r, self.lines[i].col.g, self.lines[i].col.b)
	end
end)

----------------------------------------------------------------------------------------
--	Skin WatchFrameCollapseExpandButton
----------------------------------------------------------------------------------------
if Viks.skins.blizzard_frames == true then
	T.SkinCloseButton(WatchFrameCollapseExpandButton, nil, "-", true)
	WatchFrameCollapseExpandButton:HookScript("OnClick", function(self)
		if WatchFrame.collapsed then
			self.text:SetText("+")
		else
			self.text:SetText("-")
		end
	end)
end


------------------------------
--Watch Frame Ends
------------------------------
end

local frame1 = CreateFrame("Frame")
frame1:RegisterEvent("PLAYER_ENTERING_WORLD")
frame1:SetScript("OnEvent", function(self, event)
		WatchFrameCollapseExpandButton:Click()
end)