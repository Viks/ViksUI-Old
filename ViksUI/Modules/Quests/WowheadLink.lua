local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Add quest/achievement wowhead link
----------------------------------------------------------------------------------------
local linkQuest, linkAchievement
if T.client == "ruRU" then
	linkQuest = "http://ru.wowhead.com/quest=%d"
	linkAchievement = "http://ru.wowhead.com/achievement=%d"
elseif T.client == "frFR" then
	linkQuest = "http://fr.wowhead.com/quest=%d"
	linkAchievement = "http://fr.wowhead.com/achievement=%d"
elseif T.client == "deDE" then
	linkQuest = "http://de.wowhead.com/quest=%d"
	linkAchievement = "http://de.wowhead.com/achievement=%d"
elseif T.client == "esES" or T.client == "esMX" then
	linkQuest = "http://es.wowhead.com/quest=%d"
	linkAchievement = "http://es.wowhead.com/achievement=%d"
elseif T.client == "ptBR" or T.client == "ptPT" then
	linkQuest = "http://pt.wowhead.com/quest=%d"
	linkAchievement = "http://pt.wowhead.com/achievement=%d"
else
	linkQuest = "http://www.wowhead.com/quest=%d"
	linkAchievement = "http://www.wowhead.com/achievement=%d"
end

StaticPopupDialogs.WATCHFRAME_URL = {
	text = L_WATCH_WOWHEAD_LINK,
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 350,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	preferredIndex = 5,
}

local tblDropDown = {}
hooksecurefunc("WatchFrameDropDown_Initialize", function(self)
	if self.type == "QUEST" then
		tblDropDown = {
			text = L_WATCH_WOWHEAD_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, watchId)
				local logId = GetQuestIndexForWatch(watchId)
				local _, _, _, _, _, _, _, _, questId = GetQuestLogTitle(logId)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkQuest:format(questId))
				inputBox.editBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	elseif self.type == "ACHIEVEMENT" then
		tblDropDown = {
			text = L_WATCH_WOWHEAD_LINK, notCheckable = true, arg1 = self.index,
			func = function(_, id)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(id))
				inputBox.editBox:HighlightText()
			end
		}
		UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
	end
end)
UIDropDownMenu_Initialize(WatchFrameDropDown, WatchFrameDropDown_Initialize, "MENU")

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		hooksecurefunc("AchievementButton_OnClick", function(self)
			if self.id and IsControlKeyDown() then
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(linkAchievement:format(self.id))
				inputBox.editBox:HighlightText()
			end
		end)
	end
end)