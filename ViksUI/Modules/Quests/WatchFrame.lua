local T, Viks, L, _ = unpack(select(2, ...))
if Viks.misc.WatchFrame then

----------------------------------------------------------------------------------------
--	Move ObjectiveTrackerFrame
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
frame:SetPoint("TOPRIGHT", CPMinimb1, "BOTTOMLEFT", 0, 10)
frame:SetHeight(150)
frame:SetWidth(224)
--frame:SetClampedToScreen(true)
--frame:SetMovable(true)

ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
ObjectiveTrackerFrame:SetHeight(T.getscreenheight / 1.6)
ObjectiveTrackerFrame:SetWidth(180)

hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		ObjectiveTrackerFrame:ClearAllPoints()
		ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
	end
end)

ObjectiveTrackerBlocksFrame.QuestHeader:SetAlpha(0)
ObjectiveTrackerFrame.HeaderMenu.Title:SetAlpha(0)


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
		buttontext:SetTextColor(unpack(Viks.media.pxcolor1)) 
		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(CPMinimb2, "ANCHOR_BOTTOMLEFT", -4, 16)
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
				ToggleQuestLog()
			else
				    if ( ObjectiveTrackerFrame.collapsed ) then
					ObjectiveTracker_Expand();
					else
					ObjectiveTracker_Collapse();
					end
			end
		end)
	end

end
watchFButton()

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame item buttons
----------------------------------------------------------------------------------------
hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	local item = block.itemButton

	if item and not item.skinned then
		item:SetSize(22, 22)
		item:SetTemplate("Default")
		item:StyleButton()

		item:SetNormalTexture(nil)

		item.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item.icon:SetPoint("TOPLEFT", item, 2, -2)
		item.icon:SetPoint("BOTTOMRIGHT", item, -2, 2)

		item.HotKey:ClearAllPoints()
		item.HotKey:SetPoint("BOTTOMRIGHT", 0, 2)
		item.HotKey:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
		item.HotKey:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)

		item.Count:ClearAllPoints()
		item.Count:SetPoint("TOPLEFT", 1, -1)
		item.Count:SetFont(Viks.font.action_bars_font, Viks.font.action_bars_font_size, Viks.font.action_bars_font_style)
		item.Count:SetShadowOffset(Viks.font.action_bars_font_shadow and 1 or 0, Viks.font.action_bars_font_shadow and -1 or 0)

		item.skinned = true
	end
end)

----------------------------------------------------------------------------------------
--	Difficulty color for ObjectiveTrackerFrame lines
----------------------------------------------------------------------------------------
--WoD hooksecurefunc("ObjectiveTracker_Update", function()
	-- local numQuestWatches = GetNumQuestWatches()

	-- for i = 1, numQuestWatches do
		-- local questIndex = GetQuestIndexForWatch(i)
		-- if questIndex then
			-- local title, level = GetQuestLogTitle(questIndex)
			-- local col = GetQuestDifficultyColor(level)

			-- for j = 1, #WATCHFRAME_QUESTLINES do
				-- if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					-- WATCHFRAME_QUESTLINES[j].text:SetTextColor(col.r, col.g, col.b)
					-- WATCHFRAME_QUESTLINES[j].col = col
				-- end
			-- end
			-- for k = 1, #WATCHFRAME_ACHIEVEMENTLINES do
				-- WATCHFRAME_ACHIEVEMENTLINES[k].col = nil
			-- end
		-- end
	-- end
-- end)

--WoD hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
	-- i = self.startLine
	-- if not (self.lines[i] and self.lines[i].col) then return end
	-- if onEnter then
		-- self.lines[i].text:SetTextColor(1, 0.8, 0)
	-- else
		-- self.lines[i].text:SetTextColor(self.lines[i].col.r, self.lines[i].col.g, self.lines[i].col.b)
	-- end
-- end)

for _, headerName in pairs({"QuestHeader", "AchievementHeader", "ScenarioHeader"}) do
	local header = ObjectiveTrackerFrame.BlocksFrame[headerName].Background:Hide()
end

----------------------------------------------------------------------------------------
--	Skin ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
----------------------------------------------------------------------------------------
if Viks.skins.blizzard_frames == true then
	T.SkinCloseButton(ObjectiveTrackerFrame.HeaderMenu.MinimizeButton, nil, "-", true)

	hooksecurefunc("ObjectiveTracker_Collapse", function()
		ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.text:SetText("+")
	end)

	hooksecurefunc("ObjectiveTracker_Expand", function()
		ObjectiveTrackerFrame.HeaderMenu.MinimizeButton.text:SetText("-")
	end)
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:Hide()
end
end

local frame1 = CreateFrame("Frame")
frame1:RegisterEvent("PLAYER_ENTERING_WORLD")
frame1:SetScript("OnEvent", function(self, event)
		ObjectiveTracker_Collapse()
end)