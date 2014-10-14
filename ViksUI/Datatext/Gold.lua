local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
-- GOLD
--------------------------------------------------------------------

if not Viks.datatext.Gold or Viks.datatext.Gold == 0 then return end
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
	Text:SetTextColor(unpack(Viks.media.pxcolor1))
	Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	PP(Viks.datatext.Gold, Text)

	local Profit	= 0
	local Spent		= 0
	local OldMoney	= 0
	local myPlayerRealm = T.realm
	
	local function formatMoney(money)
		local gold = floor(math.abs(money) / 10000)
		local silver = mod(floor(math.abs(money) / 100), 100)
		local copper = mod(floor(math.abs(money)), 100)
		if gold ~= 0 then
			return format("%s".."|cffffd700g|r", gold)
		elseif silver ~= 0 then
			return format("%s".."|cffc7c7cfs|r".." %s".."|cffeda55fc|r", silver, copper)
		else
			return format("%s".."|cffeda55fc|r", copper)
		end
	end

	local function FormatTooltipMoney(money)
		local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
		local cash = ""
		cash = format("%d".."|cffffd700g|r".." %d".."|cffc7c7cfs|r".." %d".."|cffeda55fc|r", gold, silver, copper)		
		return cash
	end	

local function Currency(id, weekly, capped)
	local name, amount, tex, week, weekmax, maxed, discovered = GetCurrencyInfo(id)

	local r, g, b = 1, 1, 1
	for i = 1, GetNumWatchedTokens() do
		local _, _, _, itemID = GetBackpackCurrencyInfo( i )
		if id == itemID then r, g, b = .77, .12, .23 end
	end

	if (amount == 0 and r == 1) then return end
	if weekly then
		if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, "Current: " .. amount .. " - " .. WEEKLY .. ": " .. week .. " / " .. weekmax, r, g, b, r, g, b) end
	elseif capped  then
		if id == 392 then maxed = 4000 end
		if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount .. " / " .. maxed, r, g, b, r, g, b) end
	else
		if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount, r, g, b, r, g, b) end
	end
end
	
	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			OldMoney = GetMoney()
		end
		
		local NewMoney	= GetMoney()
		local Change = NewMoney-OldMoney -- Positive if we gain money
		
		if OldMoney>NewMoney then		-- Lost Money
			Spent = Spent - Change
		else							-- Gained Moeny
			Profit = Profit + Change
		end
		
		Text:SetText(formatMoney(NewMoney))
		-- Setup Money Tooltip
		self:SetAllPoints(Text)

		local realm = GetRealmName();
		local name  = UnitName("player");				
		if (ViksData == nil) then ViksData = {}; end
		if (ViksData.gold == nil) then ViksData.gold = {}; end
		if (ViksData.gold[realm]==nil) then ViksData.gold[realm]={}; end
		ViksData.gold[realm][name] = GetMoney();
		OldMoney = NewMoney
end

	Stat:RegisterEvent("PLAYER_MONEY")
	Stat:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
	Stat:RegisterEvent("SEND_MAIL_COD_CHANGED")
	Stat:RegisterEvent("PLAYER_TRADE_MONEY")
	Stat:RegisterEvent("TRADE_MONEY_CHANGED")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")

	
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnEnter", function(self)
	if InCombatLockdown() then return end
	local prof1, prof2, archaeology, _, cooking = GetProfessions()
	
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6);
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
	GameTooltip:ClearLines()
	GameTooltip:AddLine("Session: ")
	GameTooltip:AddDoubleLine("Earned:", formatMoney(Profit), 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine("Spent:", formatMoney(Spent), 1, 1, 1, 1, 1, 1)

	if Profit < Spent then
		GameTooltip:AddDoubleLine("Deficit:", formatMoney(Profit - Spent), 1, 0, 0, 1, 1, 1)
	elseif (Profit-Spent) > 0 then
		GameTooltip:AddDoubleLine("Profit:", formatMoney(Profit - Spent), 0, 1, 0, 1, 1, 1)
	end

	GameTooltip:AddLine(" ")

	local totalGold = 0
	GameTooltip:AddLine("Character: ")

	local thisRealmList = ViksData.gold[myPlayerRealm]
	for k, v in pairs(thisRealmList) do
		GameTooltip:AddDoubleLine(k, FormatTooltipMoney(v), 1, 1, 1, 1, 1, 1)
		totalGold = totalGold + v
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("Server: ")
	GameTooltip:AddDoubleLine("Total: ", FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

	if archaeology and Viks.datatext.CurrArchaeology then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PROFESSIONS_ARCHAEOLOGY .. ": ")
		Currency(398)
		Currency(384)
		Currency(393)
		Currency(677)
		Currency(400)
		Currency(394)
		Currency(397)
		Currency(676)
		Currency(401)
		Currency(385)
		Currency(399)
		Currency(829)
		Currency(944)
		Currency(810)
		Currency(821)
		Currency(754)
		Currency(677)
		Currency(676)
	end

	if cooking and Viks.datatext.CurrCooking then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PROFESSIONS_COOKING .. ": ")
		Currency(81)
		Currency(402)
	end

	if Viks.datatext.CurrProfessions then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Profession Token")
		Currency(61)
		Currency(361)
		Currency(698)
		Currency(910)
		Currency(1020)
		Currency(1008)
		Currency(1017)
		Currency(999)
	end

	if Viks.datatext.CurrRaid then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Raid")
		Currency(776, false, true)
		Currency(752, false, true)
		Currency(697, false, true)
		Currency(738)
		Currency(615)
		Currency(614)
		Currency(823)
	end

	if Viks.datatext.CurrPvP then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PVP_FLAG)
		Currency(390, true)
		Currency(392, false, true)
		Currency(391)
	end

	if Viks.datatext.CurrMiscellaneous then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(MISCELLANEOUS)
		Currency(241)
		Currency(416)
		Currency(515)
		Currency(777)
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("Bags: Left Click")
	GameTooltip:AddLine("Reset Currency: Hold Shift + Right Click")
	GameTooltip:AddLine("Currency is controlled under config-Datatext")

	GameTooltip:Show()
	--GameTooltip:SetTemplate("Transparent")
end)

Stat:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)


local function RESETGOLD()
	local myPlayerRealm = T.realm
	local myPlayerName  = UnitName("player")

	ViksData.gold = {}
	ViksData.gold[myPlayerRealm] = {}
	ViksData.gold[myPlayerRealm][myPlayerName] = GetMoney()
end
SLASH_RESETGOLD1 = "/resetgold"
SlashCmdList["RESETGOLD"] = RESETGOLD

Stat:SetScript("OnMouseDown", function(self, btn)
	if btn == "RightButton" and IsShiftKeyDown() then
		local myPlayerRealm = T.realm
		local myPlayerName  = UnitName("player")
	
		ViksData.gold = {}
		ViksData.gold[myPlayerRealm] = {}
		ViksData.gold[myPlayerRealm][myPlayerName] = GetMoney()
	elseif btn == "LeftButton" then
		ToggleAllBags()
	else
	end
end)