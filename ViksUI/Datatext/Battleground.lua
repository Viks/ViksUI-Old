local T, Viks, L, _ = unpack(select(2, ...))
--if Viks.stats.battleground ~= true then return end

----------------------------------------------------------------------------------------
--	BGScore(by Elv22, edited by Tukz)
----------------------------------------------------------------------------------------
-- Map IDs
local WSG = 443
local TP = 626
local AV = 401
local SOTA = 512
local IOC = 540
local EOTS = 482
local TBFG = 736
local AB = 461
local TOK = 856
local SSM = 860

local classcolor = ("|cff%.2x%.2x%.2x"):format(T.color.r * 255, T.color.g * 255, T.color.b * 255)

local bgframe = CreateFrame("Frame", "InfoBattleGround", UIParent)
bgframe:CreatePanel("Invisible", 300, Viks.font.stats_font_size, unpack(Viks.position.bg_score))
bgframe:EnableMouse(true)
bgframe:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
	for i = 1, numScores do
		local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
		if name then
			if name == UnitName("player") then
				local curmapid = GetCurrentMapAreaID()
				SetMapToCurrentZone()
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, T.Scale(4))
				GameTooltip:ClearLines()
				GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(STATISTICS, classcolor..name.."|r")
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(KILLING_BLOWS..":", killingBlows, 1, 1, 1)
				GameTooltip:AddDoubleLine(HONORABLE_KILLS..":", honorableKills, 1, 1, 1)
				GameTooltip:AddDoubleLine(DEATHS..":", deaths, 1, 1, 1)
				GameTooltip:AddDoubleLine(HONOR_GAINED..":", format("%d", honorGained), 1, 1, 1)
				GameTooltip:AddDoubleLine(SCORE_DAMAGE_DONE..":", damageDone, 1, 1, 1)
				GameTooltip:AddDoubleLine(SCORE_HEALING_DONE..":", healingDone, 1, 1, 1)
				-- Add extra statistics to watch based on what BG you are in
				if curmapid == IOC or curmapid == TBFG or curmapid == AB then
					GameTooltip:AddDoubleLine(L_DATATEXT_BASESASSAULTED, GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_BASESDEFENDED, GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif curmapid == WSG or curmapid == TP then
					GameTooltip:AddDoubleLine(L_DATATEXT_FLAGSCAPTURED, GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_FLAGSRETURNED, GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif curmapid == EOTS then
					GameTooltip:AddDoubleLine(L_DATATEXT_FLAGSCAPTURED, GetBattlefieldStatData(i, 1), 1, 1, 1)
				elseif curmapid == AV then
					GameTooltip:AddDoubleLine(L_DATATEXT_GRAVEYARDSASSAULTED, GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_GRAVEYARDSDEFENDED, GetBattlefieldStatData(i, 2), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_TOWERSASSAULTED, GetBattlefieldStatData(i, 3), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_TOWERSDEFENDED, GetBattlefieldStatData(i, 4), 1, 1, 1)
				elseif curmapid == SOTA then
					GameTooltip:AddDoubleLine(L_DATATEXT_DEMOLISHERSDESTROYED, GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_GATESDESTROYED, GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif CurrentMapID == TOK then
					GameTooltip:AddDoubleLine(L_DATATEXT_ORB_POSSESSIONS, GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L_DATATEXT_VICTORY_POINTS, GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif CurrentMapID == SSM then
					GameTooltip:AddDoubleLine(L_DATATEXT_CARTS_CONTROLLED, GetBattlefieldStatData(i, 1), 1, 1, 1)
				end
				GameTooltip:Show()
			end
		end
	end
end)
bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
bgframe:SetScript("OnMouseUp", function(self, button)
	if QueueStatusMinimapButton:IsShown() then
		if button == "RightButton" then
			ToggleBattlefieldMinimap()
		else
			ToggleWorldStateScoreFrame()
		end
	end
end)

local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)

local Text1 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
Text1:SetFont(Viks.font.stats_font, Viks.font.stats_font_size, Viks.font.stats_font_style)
Text1:SetShadowOffset(Viks.font.stats_font_shadow and 1 or 0, Viks.font.stats_font_shadow and -1 or 0)
Text1:SetPoint("LEFT", 5, 0)
Text1:SetHeight(Viks.font.stats_font_size)

local Text2 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
Text2:SetFont(Viks.font.stats_font, Viks.font.stats_font_size, Viks.font.stats_font_style)
Text2:SetShadowOffset(Viks.font.stats_font_shadow and 1 or 0, Viks.font.stats_font_shadow and -1 or 0)
Text2:SetPoint("LEFT", Text1, "RIGHT", 5, 0)
Text2:SetHeight(Viks.font.stats_font_size)

local Text3 = InfoBattleGround:CreateFontString(nil, "OVERLAY")
Text3:SetFont(Viks.font.stats_font, Viks.font.stats_font_size, Viks.font.stats_font_style)
Text3:SetShadowOffset(Viks.font.stats_font_shadow and 1 or 0, Viks.font.stats_font_shadow and -1 or 0)
Text3:SetPoint("LEFT", Text2, "RIGHT", 5, 0)
Text3:SetHeight(Viks.font.stats_font_size)

local int = 2
local function Update(self, t)
	int = int - t
	if int < 0 then
		local dmgtxt
		RequestBattlefieldScoreData()
		local numScores = GetNumBattlefieldScores()
		for i = 1, numScores do
			local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
			if healingDone > damageDone then
				dmgtxt = (classcolor..SHOW_COMBAT_HEALING.." :|r "..healingDone)
			else
				dmgtxt = (classcolor..COMBATLOG_HIGHLIGHT_DAMAGE.." :|r "..damageDone)
			end
			if name then
				if name == T.name then
					Text2:SetText(classcolor..COMBAT_HONOR_GAIN.." :|r "..format("%d", honorGained))
					Text1:SetText(dmgtxt)
					Text3:SetText(classcolor..KILLING_BLOWS.." :|r "..killingBlows)
				end
			end
		end
		int = 2
	end
end

-- Hide text when not in an bg
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and (instanceType == "pvp") then
			bgframe:Show()
		else
			Text1:SetText("")
			Text2:SetText("")
			Text3:SetText("")
			bgframe:Hide()
		end
	end
end

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnUpdate", Update)
Update(Stat, 2)