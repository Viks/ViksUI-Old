﻿local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Based on LiteStats(by Katae)
----------------------------------------------------------------------------------------
local P = "player"
local realm, char, class, layout = GetRealmName(), UnitName(P), select(2, UnitClass(P)), {}

-- Tooltip text colors
local tthead = {r = 0.40, g = 0.78, b = 1}	-- Headers
local ttsubh = {r = 0.75, g = 0.90, b = 1}	-- Subheaders

-- Strata/Level for text objects
local strata, level = "DIALOG", 20

-- Globals
local profiles = LPSTAT_PROFILES
local font = LPSTAT_FONT
local t_icon = LTIPICONSIZE or 20
local IsAltKeyDown = IsAltKeyDown
local UpdateMemUse = UpdateAddOnMemoryUsage
local format = string.format
local strmatch = string.match
local strfind = string.find
local strtrim = strtrim
local unpack = unpack
local pairs = pairs
local ipairs = ipairs
local floor = math.floor
local select = select
local max = max
local gsub = gsub

-- Config
local modules = LPSTAT_CONFIG
local fps = modules.FPS
local latency = modules.Latency
local memory = modules.Memory
local durability = modules.Durability
local gold = modules.Gold
local clock = modules.Clock
local location = modules.Location
local coords = modules.Coords
local ping = modules.Ping
local guild = modules.Guild
local friends = modules.Friends
local bags = modules.Bags
local talents = modules.Talents
local stats = modules.Stats
local experience = modules.Experience
local loot = modules.Loot
local cloak = modules.Cloak
local helm = modules.Helm
local nameplates = modules.Nameplates

-- Events Reg
local function RegEvents(f, l) for _, e in ipairs{strsplit(" ", l)} do f:RegisterEvent(e) end end

------------------------------------------
-- Saved Vars Init / Coords
local ls, coordX, coordY, conf, Coords = CreateFrame("Frame"), 0, 0, {}
RegEvents(ls, "ADDON_LOADED PLAYER_REGEN_DISABLED PLAYER_REGEN_ENABLED")
ls:SetScript("OnEvent", function(_, event, addon)
	if event == "ADDON_LOADED" and addon == "ViksUI" then
		if not SavedStats then SavedStats = {} end
		if not SavedStats[realm] then SavedStats[realm] = {} end
		if not SavedStats[realm][char] then SavedStats[realm][char] = {} end
		conf = SavedStats[realm][char]

		-- true/false defaults for autosell and autorepair
		if conf.AutoSell == nil then conf.AutoSell = true end
		if conf.AutoRepair == nil then conf.AutoRepair = true end
		if conf.AutoGuildRepair == nil then conf.AutoGuildRepair = true end
	end
	if event == "ZONE_CHANGED_NEW_AREA" and not WorldMapFrame:IsShown() then
		SetMapToCurrentZone()
	end
end)

-- Config missing?
if not modules then return end

if modules and ((coords and coords.enabled) or (location and location.enabled)) then
	ls:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	ls:SetScript("OnUpdate", function() coordX, coordY = GetPlayerMapPosition(P) end)
	WorldMapFrame:HookScript("OnHide", SetMapToCurrentZone)
	function Coords() return format(coords and coords.fmt or "%d, %d", coordX * 100, coordY * 100) end
end

-- Set profile
if profiles then for _, p in ipairs{class,format("%s - %s", char, realm)} do
	if profiles[p] then for k, v in pairs(profiles[p]) do
		for _k, _v in pairs(v) do modules[k][_k] = _v end
	end end
end profiles = nil end


------------------------------------------
local function zsub(s, ...) local t = {...} for i = 1, #t, 2 do s = gsub(s, t[i], t[i + 1]) end return s end


local function comma_value(n) -- credit http://richard.warburton.it
	local left, num, right = string.match(n,"^([^%d]*%d)(%d*)(.-)$")
	return left..(num:reverse():gsub("(%d%d%d)","%1,"):reverse())..right
end
local function formatgold(style, amount)
	local gold, silver, copper = floor(amount * 0.0001), floor(mod(amount * 0.01, 100)), floor(mod(amount, 100))
	if style == 1 then
		return (gold > 0 and format("%s|cffffd700%s|r ", comma_value(gold), GOLD_AMOUNT_SYMBOL) or "")
			.. (silver > 0 and format("%s|cffc7c7cf%s|r ", silver, SILVER_AMOUNT_SYMBOL) or "")
			.. ((copper > 0 or (gold == 0 and silver == 0)) and format("%s|cffeda55f%s|r", copper, COPPER_AMOUNT_SYMBOL) or "")
	elseif style == 2 or not style then
		return format("%.1f|cffffd700%s|r", amount * 0.0001, GOLD_AMOUNT_SYMBOL)
	elseif style == 3 then
		return format("|cffffd700%s|r.|cffc7c7cf%s|r.|cffeda55f%s|r", gold, silver, copper)
	elseif style == 4 then
		return (gold > 0 and format(GOLD_AMOUNT_TEXTURE, gold, 12, 12) or "") .. (silver > 0 and format(SILVER_AMOUNT_TEXTURE, silver, 12, 12) or "")
			.. ((copper > 0 or (gold == 0 and silver == 0)) and format(COPPER_AMOUNT_TEXTURE, copper, 12, 12) or "") .. " "
	end
end

local function abbr(t, s) return t[s] or zsub(_G[strupper(s).."_ONELETTER_ABBR"], "%%d", "", "^%s*", "") end
local function fmttime(sec, t)
	local t = t or {}
	local d, h, m, s = ChatFrame_TimeBreakDown(floor(sec))
	local string = zsub(format(" %dd %dh %dm "..((d == 0 and h == 0) and "%ds" or ""), d, h, m, s), " 0[dhms]", " ", "%s+", " ")
	string = strtrim(gsub(string, "([dhms])", {d = abbr(t, "day"), h = abbr(t, "hour"), m = abbr(t, "minute"), s = abbr(t, "second")}), " ")
	return strmatch(string, "^%s*$") and "0"..abbr(t, "second") or string
end

function gradient(perc)
	perc = perc > 1 and 1 or perc < 0 and 0 or perc -- Stay between 0-1
	local seg, relperc = math.modf(perc*2)
	local r1, g1, b1, r2, g2, b2 = select(seg * 3 + 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0) -- R -> Y -> G
	local r, g, b = r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255), r, g, b
end

local function HideTT(self) GameTooltip:Hide() self.hovered = false end

local pxpx = {height = 1, width = 1}
local function Inject(name, stat)
	if not name then return end
	if not stat then stat = pxpx end

	local m = modules[name]
	for k, v in pairs{ -- retrieving config variables from LPSTAT_CONFIG
		--name = name, anchor_frame = m.anchor_frame,
		name = name, parent = m.anchor_frame,
		anchor_to = m.anchor_to, anchor_from = m.anchor_from,
		x_off = m.x_off, y_off = m.y_off,
		height = m.height, width = m.width,
		strata = strata, level = level
	} do if not stat[k] then stat[k] = v end end
	if not stat.text then stat.text = {} end

	-- retrieve font variables and insert them into text table
	for k,v in pairs(font) do
		if not stat.text[k] then
			stat.text[k] = m[k] or v
		end
	end

	if stat.OnEnter then if stat.OnLeave then hooksecurefunc(stat, "OnLeave", HideTT) else stat.OnLeave = HideTT end end
	tinsert(layout, stat)
end

-- Inject dummy frames for disabled modules
for name, conf in pairs(modules) do
	if not conf.enabled then Inject(name) end
end

local function AltUpdate(self)
	if not self.hovered then return end
	if IsAltKeyDown() and not self.altdown then self.altdown = true self:GetScript("OnEnter")(self)
	elseif not IsAltKeyDown() and self.altdown then self.altdown = false self:GetScript("OnEnter")(self) end
end

local function GetTableIndex(table, fieldIndex, value)
	for k, v in ipairs(table) do
		if (v[fieldIndex] == value) then
			return k
		end
	end
	return -1
end

local menuFrame = CreateFrame("Frame", "ContactDropDownMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{text = OPTIONS_MENU, isTitle = true, notCheckable = true},
	{text = INVITE, hasArrow = true, notCheckable = true},
	{text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable = true}
}

SLASH_LSTATS1, SLASH_LSTATS2, SLASH_LSTATS3 = "/ls", "/lstats", "/litestats"
local function slprint(...)
	local m, l = "|cffbcee68", "|cffff9912 -|r"
	local t = {...} print(m, t[1])
	for i = 2, #t do print(l, t[i]) end
end
function SlashCmdList.LSTATS()
	print("|cffffffffLite|cff66C6FFStats|cffffffff "..L_STATS_TIPS)
	if memory.enabled then
		slprint(L_STATS_MEMORY, L_STATS_RC_COLLECTS_GARBAGE)
	end
	if gold.enabled then
		slprint(strtrim(gsub(MONEY, "%%d", "")), L_STATS_OPEN_CURRENCY, L_STATS_RC_AUTO_SELLING, L_STATS_NOT_TO_SELL, L_STATS_WATCH_CURRENCY)
	end
	if durability.enabled then
		slprint(DURABILITY, L_STATS_OPEN_CHARACTER, L_STATS_RC_AUTO_REPAIRING, L_STATS_EQUIPMENT_CHANGER)
	end
	if location.enabled or coords.enabled then
		slprint(L_STATS_LOCATION, L_STATS_WORLD_MAP, L_STATS_INSERTS_COORDS)
	end
	if clock.enabled then
		slprint(TIMEMANAGER_TITLE, L_STATS_OPEN_CALENDAR, L_STATS_RC_TIME_MANAGER, L_STATS_TOGGLE_TIME)
	end
	if friends.enabled or guild.enabled then
		slprint(format("%s/%s", FRIENDS,GUILD), L_STATS_VIEW_NOTES, L_STATS_CHANGE_SORTING)
	end
	if talents.enabled then
		slprint(TALENTS, L_STATS_OPEN_TALENT, L_STATS_RC_TALENT)
	end
	if experience.enabled then
		slprint(format("%s/%s/%s", COMBAT_XP_GAIN, TIME_PLAYED_MSG, FACTION), L_STATS_RC_EXPERIENCE, L_STATS_WATCH_FACTIONS)
	end
	print("|cffBCEE68", format(L_STATS_OTHER_OPTIONS, "|cff66C6FFViksUI\\Config\\DataText.lua"))
end

CreateFrame("Frame", "LSMenus", UIParent, "UIDropDownMenuTemplate")

----------------------------------------------------------------------------------------
--	FPS
----------------------------------------------------------------------------------------
if fps.enabled then
	Inject("FPS", {
		text = {
			string = function()
				return format(fps.fmt, floor(GetFramerate()))
			end
		},
	})
end

----------------------------------------------------------------------------------------
--	Latency
----------------------------------------------------------------------------------------
if latency.enabled then
	Inject("Latency", {
		text = {
			string = function()
				local _, _, latencyHome, latencyWorld = GetNetStats()
				local lat = math.max(latencyHome, latencyWorld)
				return format(gsub(latency.fmt, "%[color%]", (gradient(1 - lat / 750))), lat)
			end
		},
		OnEnter = function(self)
			local _, _, latencyHome, latencyWorld = GetNetStats()
			local latency = format(MAINMENUBAR_LATENCY_LABEL, latencyHome, latencyWorld)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Latency.tip_anchor, modules.Latency.tip_frame, modules.Latency.tip_x, modules.Latency.tip_y)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(latency, tthead.r, tthead.g, tthead.b)
			GameTooltip:Show()
		end,
	})
end

----------------------------------------------------------------------------------------
--	Memory
----------------------------------------------------------------------------------------
if memory.enabled then
	local function sortdesc(a, b) return a[2] > b[2] end
	local function formatmem(val,dec)
		return format(format("%%.%df %s", dec or 1, val > 1024 and "MB" or "KB"), val / (val > 1024 and 1024 or 1))
	end
	local memoryt = {}
	Inject("Memory", {
		text = {
			string = function(self)
				self.total = 0
				UpdateMemUse()
				local parent = self:GetParent()
				for i = 1, GetNumAddOns() do self.total = self.total + GetAddOnMemoryUsage(i) end
				if parent.hovered then self:GetParent():GetScript("OnEnter")(parent) end
				return self.total >= 1024 and format(memory.fmt_mb, self.total / 1024) or format(memory.fmt_kb, self.total)
			end, update = 5,
		},
		OnEnter = function(self)
			collectgarbage()
			self.hovered = true
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Memory.tip_anchor, modules.Memory.tip_frame, modules.Memory.tip_x, modules.Memory.tip_y)
			GameTooltip:ClearLines()
			local lat, r = select(4, GetNetStats()), 750
			GameTooltip:AddDoubleLine(
				format("|cffffffff%s|r %s, %s%s|r %s", floor(GetFramerate()), FPS_ABBR, gradient(1 - lat / r), lat,MILLISECONDS_ABBR),
				format("%s: |cffffffff%s", ADDONS, formatmem(self.text.total)), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g,tthead.b)
			GameTooltip:AddLine(" ")
			if memory.max_addons ~= 0 or IsAltKeyDown() then
				if not self.timer or self.timer + 5 < time() then
					self.timer = time()
					UpdateMemUse()
					for i = 1, #memoryt do memoryt[i] = nil end
					for i = 1, GetNumAddOns() do
						local addon, name = GetAddOnInfo(i)
						if IsAddOnLoaded(i) then tinsert(memoryt, {name or addon, GetAddOnMemoryUsage(i)}) end
					end
					table.sort(memoryt, sortdesc)
				end
				local exmem = 0
				for i,t in ipairs(memoryt) do
					if memory.max_addons and i > memory.max_addons and not IsAltKeyDown() then
						exmem = exmem + t[2]
					else
						local color = t[2] <= 102.4 and {0,1} -- 0 - 100
							or t[2] <= 512 and {0.75,1} -- 100 - 512
							or t[2] <= 1024 and {1,1} -- 512 - 1mb
							or t[2] <= 2560 and {1,0.75} -- 1mb - 2.5mb
							or t[2] <= 5120 and {1,0.5} -- 2.5mb - 5mb
							or {1,0.1} -- 5mb +
						GameTooltip:AddDoubleLine(t[1], formatmem(t[2]), 1, 1, 1, color[1], color[2], 0)
					end
				end
				if exmem > 0 and not IsAltKeyDown() then
					local more = #memoryt - memory.max_addons
					GameTooltip:AddDoubleLine(format("%d %s (%s)", more, L_STATS_HIDDEN, ALT_KEY), formatmem(exmem), ttsubh.r, ttsubh.g, ttsubh.b, ttsubh.r, ttsubh.g, ttsubh.b)
				end
				GameTooltip:AddDoubleLine(" ", "--------------", 1, 1, 1, 0.5, 0.5, 0.5)
			end
			local bandwidth = GetAvailableBandwidth()
			if bandwidth ~= 0 then
				GameTooltip:AddDoubleLine(L_STATS_BANDWIDTH, format("%s ".."Mbps", T.Round(bandwidth, 2)), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_DOWNLOAD, format("%s%%", floor(GetDownloadedPercentage() * 100 + 0.5)), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddDoubleLine(L_STATS_MEMORY_USAGE, formatmem(gcinfo() - self.text.total), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddDoubleLine(L_STATS_TOTAL_MEMORY_USAGE, formatmem(collectgarbage"count"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:Show()
		end,
		--OnUpdate = AltUpdate,
		OnLeave = function(self) self.hovered = false end,
		OnClick = function(self, button)
			if button == "RightButton" then
				UpdateMemUse()
				local before = gcinfo()
				collectgarbage()
				UpdateMemUse()
				print(format("|cff66C6FF%s:|r %s", L_STATS_GARBAGE_COLLECTED, formatmem(before - gcinfo())))
				self.timer, self.text.elapsed = nil, 5
				self:GetScript("OnEnter")(self)
			elseif button == "LeftButton" then
				if AddonList:IsShown() then
					AddonList_OnCancel()
				else
					PlaySound("igMainMenuOption")
					ShowUIPanel(AddonList)
				end

			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Durability
----------------------------------------------------------------------------------------
if durability.enabled then
	Inject("Durability", {
		OnLoad = function(self)
			CreateFrame("GameTooltip", "LPDURA")
			LPDURA:SetOwner(WorldFrame, "ANCHOR_NONE")
			if durability.man then DurabilityFrame.Show = DurabilityFrame.Hide end
			RegEvents(self, "UPDATE_INVENTORY_DURABILITY MERCHANT_SHOW PLAYER_LOGIN")
		end,
		OnEvent = function(self, event, ...)
			if event == "UPDATE_INVENTORY_DURABILITY" or event == "PLAYER_LOGIN" then
				local dmin = 100
				for id = 1, 18 do
					local dur, dmax = GetInventoryItemDurability(id)
					if dur ~= dmax then dmin = floor(min(dmin, dur / dmax * 100)) end
				end
				self.text:SetText(format(gsub(durability.fmt, "%[color%]", (gradient(dmin / 100))), dmin))
			elseif event == "MERCHANT_SHOW" and not (IsAltKeyDown() or IsShiftKeyDown()) then
				if conf.AutoRepair and CanMerchantRepair() then
					local cost, total = GetRepairAllCost(), 0
					if cost > 0 then
						if conf.AutoGuildRepair and CanGuildBankRepair() then RepairAllItems(1) total = cost end
						if GetRepairAllCost() > 0 then
							if not durability.ignore_inventory and GetRepairAllCost() <= GetMoney() then
								total = GetRepairAllCost(); RepairAllItems()
							else
								for id = 1, 18 do
									local cost = select(3, LPDURA:SetInventoryItem(P, id))
									if cost ~= 0 and cost <= GetMoney() then
										if not InRepairMode() then ShowRepairCursor() end
										PickupInventoryItem(id)
										total = total + cost
									end
								end
							end
							HideRepairCursor()
						end
						if total > 0 then print(format("|cff66C6FF%s |cffFFFFFF%s", REPAIR_COST, formatgold(1, total))) end
					end
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Durability.tip_anchor, modules.Durability.tip_frame, modules.Durability.tip_x, modules.Durability.tip_y)
			GameTooltip:ClearLines()
			if Viks.tooltip.average_lvl == true then
				local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
				avgItemLevel = floor(avgItemLevel)
				avgItemLevelEquipped = floor(avgItemLevelEquipped)
				GameTooltip:AddDoubleLine(DURABILITY, STAT_AVERAGE_ITEM_LEVEL..": "..avgItemLevelEquipped.." / "..avgItemLevel, tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
			else
				GameTooltip:AddLine(DURABILITY, tthead.r, tthead.g, tthead.b)
			end
			GameTooltip:AddLine(" ")
			local nodur, totalcost = true, 0
			for slot, string in gmatch("1HEAD3SHOULDER5CHEST6WAIST7LEGS8FEET9WRIST10HANDS16MAINHAND17SECONDARYHAND", "(%d+)([^%d]+)") do
				local dur, dmax = GetInventoryItemDurability(slot)
				local string = _G[string.."SLOT"]
				if dur ~= dmax then
					local perc = dur ~= 0 and dur/dmax or 0
					local hex = gradient(perc)
					GameTooltip:AddDoubleLine(durability.gear_icons and format("|T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t %s", GetInventoryItemTexture(P, slot), t_icon, string) or string,format("|cffaaaaaa%s/%s | %s%s%%", dur, dmax, hex, floor(perc * 100)), 1, 1, 1)
					totalcost, nodur = totalcost + select(3, LPDURA:SetInventoryItem(P, slot))
				end
			end
			if nodur then
				GameTooltip:AddLine("100%", 0.1, 1, 0.1)
			else
				GameTooltip:AddDoubleLine(" ", "--------------", 1, 1, 1, 0.5, 0.5, 0.5)
				GameTooltip:AddDoubleLine(REPAIR_COST, formatgold(1, totalcost), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(" ", L_STATS_AUTO_REPAIR..": "..(conf.AutoRepair and "|cff55ff55"..L_STATS_ON or "|cffff5555"..strupper(OFF)), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
			GameTooltip:AddDoubleLine(" ", L_STATS_GUILD_REPAIR..": "..(conf.AutoGuildRepair and "|cff55ff55"..L_STATS_ON or "|cffff5555"..strupper(OFF)), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
			GameTooltip:Show()
		end,
		OnClick = function(self, button)
			if button == "RightButton" then
				conf.AutoRepair = not conf.AutoRepair
				self:GetScript("OnEnter")(self)
			elseif button == "MiddleButton" then
				conf.AutoGuildRepair = not conf.AutoGuildRepair
				self:GetScript("OnEnter")(self)
			elseif GetNumEquipmentSets() > 0 and button == "LeftButton" and (IsAltKeyDown() or IsShiftKeyDown()) then
				local menulist = {{isTitle = true, notCheckable = 1, text = format(gsub(EQUIPMENT_SETS, ":", ""), "")}}
				if GetNumEquipmentSets() == 0 then
					tinsert(menulist, {text = NONE, notCheckable = 1, disabled = true})
				else
					for i = 1, GetNumEquipmentSets() do
						local name, icon = GetEquipmentSetInfo(i)
						tinsert(menulist, {text = format("|T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t %s", icon, t_icon, name), notCheckable = 1, func = function() if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end UseEquipmentSet(name) end})
					end
				end
				EasyMenu(menulist, LSMenus, "cursor", 0, 0, "MENU")
			elseif button == "LeftButton" then
				ToggleCharacter("PaperDollFrame")
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Gold
----------------------------------------------------------------------------------------
if gold.enabled then
	Inject("Gold", {
		OnLoad = function(self)
			self.started = GetMoney()
			RegEvents(self, "PLAYER_LOGIN PLAYER_MONEY MERCHANT_SHOW")
			if not SavedStats.JunkIgnore then SavedStats.JunkIgnore = {} end
		end,
		OnEvent = function(self, event)
			conf.Gold = GetMoney()
			if event == "MERCHANT_SHOW" then
				if conf.AutoSell and not (IsAltKeyDown() or IsShiftKeyDown()) then
					local profit = 0
					for bag = 0, NUM_BAG_SLOTS do for slot = 0, GetContainerNumSlots(bag) do
						local link = GetContainerItemLink(bag, slot)
						if link then
							local itemstring, ignore = strmatch(link, "|Hitem:(%d-):"), false
							for _, exception in pairs(SavedStats.JunkIgnore) do
								if exception == itemstring then ignore = true; break end
							end
							if select(3, GetItemInfo(link)) == 0 and not ignore then
								profit = profit + select(11, GetItemInfo(link)) * select(2, GetContainerItemInfo(bag, slot))
								UseContainerItem(bag, slot)
							end
						end
					end end
					if profit > 0 then print(format("|cff66C6FF%s: |cffFFFFFF%s", L_STATS_JUNK_PROFIT, formatgold(1, profit))) end
				end
				return
			end
			self.text:SetText(formatgold(gold.style, conf.Gold))
		end,
		OnEnter = function(self)
			local curgold = GetMoney()
			conf.Gold = curgold
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(gold.tip_anchor, gold.tip_frame, gold.tip_x, gold.tip_y)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(CURRENCY, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			if self.started ~= curgold then
				local gained = curgold > self.started
				local color = gained and "|cff55ff55" or "|cffff5555"
				GameTooltip:AddDoubleLine(L_STATS_SESSION_GAIN, format("%s$|r %s %s$|r", color, formatgold(1, abs(self.started - curgold)), color), 1, 1, 1, 1, 1, 1)
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddLine(L_STATS_SERVER_GOLD, ttsubh.r, ttsubh.g, ttsubh.b)
			local total = 0
			for char, conf in pairs(SavedStats[realm]) do
				if conf.Gold and conf.Gold > 99 then
					GameTooltip:AddDoubleLine(char, formatgold(1, conf.Gold), 1, 1, 1, 1, 1, 1)
					total = total + conf.Gold
				end
			end
			GameTooltip:AddDoubleLine(" ", "-----------------", 1, 1, 1, 0.5, 0.5, 0.5)
			GameTooltip:AddDoubleLine(TOTAL, formatgold(1, total), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddLine(" ")

			local currencies = 0
			for i = 1, GetCurrencyListSize() do
				local name, _, _, _, watched, count, icon = GetCurrencyListInfo(i)
				if watched then
					if currencies == 0 then GameTooltip:AddLine(format("%s %s", STATUS_TEXT_PLAYER, CURRENCY), ttsubh.r, ttsubh.g, ttsubh.b) end
					local r, g, b
					if count > 0 then r, g, b = 1, 1, 1 else r, g, b = 0.5, 0.5, 0.5 end
					GameTooltip:AddDoubleLine(name, format("%d |T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t", count, icon, t_icon), r, g, b, r, g, b)
					currencies = currencies + 1
				end
			end
			if currencies > 0 then GameTooltip:AddLine(" ") end
			GameTooltip:AddDoubleLine(" ", L_STATS_AUTO_SELL..": "..(conf.AutoSell and "|cff55ff55"..L_STATS_ON or "|cffff5555"..strupper(OFF)), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
			GameTooltip:Show()
		end,
		OnClick = function(self, button)
			if button == "LeftButton" then
				ToggleCharacter("TokenFrame")
			elseif button == "RightButton" then
				conf.AutoSell = not conf.AutoSell
				self:GetScript("OnEnter")(self)
			end
		end
	})
	SLASH_KJUNK1 = "/junk"
	function SlashCmdList.KJUNK(s)
		local action = strsplit(" ", s)
		if action == "list" then
			print(format("|cff66C6FF%s:|r %s", L_STATS_JUNK_EXCEPTIONS, (#SavedStats.JunkIgnore == 0 and NONE or "")))
			for i, id in pairs(SavedStats.JunkIgnore) do
				local _, link = GetItemInfo(id)
				print("- ["..i.."]", link)
			end
		elseif action == "clear" then
			SavedStats.JunkIgnore = {}
			print("|cff66C6FF"..L_STATS_CLEARED_JUNK)
		elseif action == "add" or strfind(action, "^del") or strfind(action, "^rem") then
			for id in s:gmatch("|Hitem:(%d-):") do
				local _, link, rarity = GetItemInfo(id)
				if action == "add" then
					if rarity == 0 then
						if not tContains(SavedStats.JunkIgnore,id) then
							tinsert(SavedStats.JunkIgnore, id)
							print(format("|cff66C6FF%s:|r %s", L_STATS_ADDED_JUNK, link))
						else
							print(format("%s |cff66C6FF%s", link, L_STATS_ALREADY_EXCEPTIONS))
						end
					else print(format("|cff66C6FF", link, L_STATS_NOT_JUNK)) end
				elseif strfind(action, "^del") or strfind(action, "^rem") then
					tDeleteItem(SavedStats.JunkIgnore, id)
					print(format("|cff66C6FF%s:|r %s", L_STATS_REMOVED_JUNK, link))
				end
			end
		else
			print("|cffffffffLite|cff66C6FFStats|r: "..L_STATS_JUNK_LIST)
			print(format("/junk <add||rem(ove)> [%s] - %s", L_STATS_ITEMLINK, L_STATS_REMOVE_EXCEPTION))
			print("/junk list - "..L_STATS_IGNORED_ITEMS)
			print("/junk clear - "..L_STATS_CLEAR_EXCEPTIONS)
		end
	end
end

----------------------------------------------------------------------------------------
--	Clock
----------------------------------------------------------------------------------------
if clock.enabled then
	Inject("Clock", {
		text = {
			string = function()
				return zsub(GameTime_GetTime(true), "%s*AM", clock.AM, "%s*PM", clock.PM, ":", clock.colon)
			end
		},
		OnLoad = function(self) RequestRaidInfo() RegEvents(self, "UPDATE_INSTANCE_INFO") end,
		OnEvent = function(self) if self.hovered then self:GetScript("OnEnter")(self) end end,
		OnEnter = function(self)
			if not self.hovered then RequestRaidInfo() self.hovered = true end
			local weekday = select(date"%w"+1,CalendarGetWeekdayNames())
			local month = select(date"%m",CalendarGetMonthNames())
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(clock.tip_anchor, clock.tip_frame, clock.tip_x, clock.tip_y)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(format("%s, %s %s", weekday, month, date"%d %Y"), tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(gsub(TIMEMANAGER_TOOLTIP_LOCALTIME, ":", ""), zsub(GameTime_GetLocalTime(true), "%s*AM", "am", "%s*PM", "pm"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddDoubleLine(gsub(TIMEMANAGER_TOOLTIP_REALMTIME, ":", ""), zsub(GameTime_GetGameTime(true), "%s*AM", "am", "%s*PM", "pm"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddLine(" ")
			for i = 1, 2 do
				local _, localizedName, isActive, _, startTime, _ = GetWorldPVPAreaInfo(i)
				local r, g, b = 1, 1, 1
				if i == 1 then
					SetMapByID(485)
					for i = 1, GetNumMapLandmarks() do
						local index = select(3, GetMapLandmarkInfo(i))
						if index == 46 then
							r, g, b = 0.4, 0.8, 0.94
						elseif index == 48 then
							r, g, b = 1, 0.2, 0.2
						end
					end
					GameTooltip:AddDoubleLine(localizedName, isActive and WINTERGRASP_IN_PROGRESS or fmttime(startTime), ttsubh.r, ttsubh.g, ttsubh.b, r, g, b)
				elseif i == 2 then
					SetMapByID(708)
					for i = 1, GetNumMapLandmarks() do
						local index = select(3, GetMapLandmarkInfo(i))
						if index == 46 then
							r, g, b = 0.4, 0.8, 0.94
						elseif index == 48 then
							r, g, b = 1, 0.2, 0.2
						end
					end
					GameTooltip:AddDoubleLine(localizedName, isActive and WINTERGRASP_IN_PROGRESS or fmttime(startTime), ttsubh.r, ttsubh.g, ttsubh.b, r, g, b)
				end
			end

			local oneraid
			local heroicDifficulty = {DUNGEON_DIFFICULTY2, DUNGEON_DIFFICULTY_5PLAYER_HEROIC, RAID_DIFFICULTY3, RAID_DIFFICULTY4, RAID_DIFFICULTY_10PLAYER_HEROIC, RAID_DIFFICULTY_25PLAYER_HEROIC}
			for i = 1, GetNumSavedInstances() do
				local name, _, reset, _, locked, extended, _, isRaid, maxPlayers, difficulty, numEncounters, encounterProgress  = GetSavedInstanceInfo(i)
				if isRaid and (locked or extended) then
					local tr, tg, tb, diff
					if not oneraid then
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(CALENDAR_FILTER_RAID_LOCKOUTS, ttsubh.r, ttsubh.g, ttsubh.b)
						oneraid = true
					end
					if extended then tr, tg, tb = 0.3, 1, 0.3 else tr, tg, tb = 1, 1, 1 end
					for i, value in pairs(heroicDifficulty) do
						if value == difficulty then
							diff = "H"
							break
						end
					end
					if (numEncounters and numEncounters > 0) and (encounterProgress and encounterProgress > 0) then
						GameTooltip:AddDoubleLine(format("%s |cffaaaaaa[%s%s] (%s/%s)", name, maxPlayers, diff or "", encounterProgress, numEncounters), fmttime(reset), 1, 1, 1, tr, tg, tb)
					else
						GameTooltip:AddDoubleLine(format("%s |cffaaaaaa[%s%s]", name, maxPlayers, diff or ""), fmttime(reset), 1, 1, 1, tr, tg, tb)
					end
				end
			end
			local addedLine
			for i = 1, GetNumSavedWorldBosses() do
				local name, _, reset = GetSavedWorldBossInfo(i)
				if reset then
					if not addedLine then
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(RAID_INFO_WORLD_BOSS, ttsubh.r, ttsubh.g, ttsubh.b)
						addedLine = true
					end
					GameTooltip:AddDoubleLine(name, fmttime(reset), 1, 1, 1, 1, 1, 1)
				end
			end
			GameTooltip:Show()
		end,
		OnClick = function(_, b) (b == "RightButton" and ToggleTimeManager or ToggleCalendar)() end
	})
end

----------------------------------------------------------------------------------------
--	Location
----------------------------------------------------------------------------------------
if location.enabled then
	Inject("Location", {
		OnLoad = function(self)
			RegEvents(self, "ZONE_CHANGED ZONE_CHANGED_INDOORS ZONE_CHANGED_NEW_AREA PLAYER_ENTERING_WORLD")
			self.sanctuary = {SANCTUARY_TERRITORY, {0.41, 0.8, 0.94}}
			self.arena = {FREE_FOR_ALL_TERRITORY, {1, 0.1, 0.1}}
			self.friendly = {FACTION_CONTROLLED_TERRITORY, {0.1, 1, 0.1}}
			self.hostile = {FACTION_CONTROLLED_TERRITORY, {1, 0.1, 0.1}}
			self.contested = {CONTESTED_TERRITORY, {1, 0.7, 0}}
			self.combat = {COMBAT_ZONE, {1, 0.1, 0.1}}
			self.neutral = {format(FACTION_CONTROLLED_TERRITORY, FACTION_STANDING_LABEL4), {1, 0.93, 0.76}}
		end,
		OnEvent = function(self)
			self.subzone, self.zone, self.pvp = GetSubZoneText(), GetZoneText(), {GetZonePVPInfo()}
			if not self.pvp[1] then self.pvp[1] = "neutral" end
			local label = (self.subzone ~= "" and location.subzone) and self.subzone or self.zone
			local r, g, b = unpack(self.pvp[1] and (self[self.pvp[1]][2] or self.other) or self.other)
			self.text:SetText(location.truncate == 0 and label or strtrim(strsub(label, 1, location.truncate)))
			self.text:SetTextColor(r, g, b, font.alpha)
		end,
		OnUpdate = function(self,u)
			if self.hovered then
				self.elapsed = self.elapsed + u
				if self.elapsed > 1 or self.init then
					GameTooltip:ClearLines()
					GameTooltip:AddLine(format("%s |cffffffff(%s)", self.zone, Coords()), tthead.r, tthead.g, tthead.b, 1, 1, 1)
					if self.pvp[1] and not IsInInstance() then
						local r, g, b = unpack(self[self.pvp[1]][2])
						if self.subzone and self.subzone ~= self.zone then GameTooltip:AddLine(self.subzone, r, g, b) end
						GameTooltip:AddLine(format(self[self.pvp[1]][1], self.pvp[3] or ""), r, g, b)
					end
					GameTooltip:Show()
					self.elapsed, self.init = 0, false
				end
			end
		end,
		OnEnter = function(self)
			self.hovered, self.init = true, true
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Location.tip_anchor, modules.Location.tip_frame, modules.Location.tip_x, modules.Location.tip_y)
		end,
		OnClick = function(self,button)
			if IsShiftKeyDown() then
				ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
				ChatEdit_ChooseBoxForSend():Insert(format(" (%s: %s)", self.zone, Coords()))
			else
				ToggleFrame(WorldMapFrame)
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Coordinates
----------------------------------------------------------------------------------------
if coords.enabled then
	Inject("Coords", {
		text = {string = Coords},
		OnClick = function(_, button)
			if button == "LeftButton" then
				ToggleFrame(WorldMapFrame)
			else
				ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
				ChatEdit_ChooseBoxForSend():Insert(format(" (%s: %s)", GetZoneText(), Coords()))
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Ping
----------------------------------------------------------------------------------------
if ping.enabled then
	Inject("Ping", {
		OnLoad = function(self)
			self:RegisterEvent("MINIMAP_PING")
			self.animGroup = self.text:CreateAnimationGroup()
			self.anim = self.animGroup:CreateAnimation("Alpha")
			self.animGroup:SetScript("OnFinished", function() self.text:Hide() end)
			self.anim:SetChange(-1)
			self.anim:SetOrder(1)
			self.anim:SetDuration(2.8)
			self.anim:SetStartDelay(5)
			end,
		OnEvent = function(self, event, unit)
			if unit == P and ping.hide_self then return end
				local class = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(unit))]
				self.text:SetText(format(ping.fmt, UnitName(unit)))
				if class then
					self.text:SetTextColor(class.r, class.g, class.b, 1)
				else
					self.text:SetTextColor(1, 1, 1, 1)
				end
				self.animGroup:Stop()
				self.text:Show()
				self.animGroup:Play()
			end
	})
end

----------------------------------------------------------------------------------------
--	Guild
----------------------------------------------------------------------------------------
if guild.enabled then
	local guildTable = {}
	local function BuildGuildTable()
		wipe(guildTable)
		for i = 1, GetNumGuildMembers() do
			local name, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, mobile = GetGuildRosterInfo(i)
			name = Ambiguate(name, "guild")
			guildTable[i] = {name, rank, level, zone, note, officernote, connected, status, class, mobile}
		end
		table.sort(guildTable, function(a, b)
			if (a and b) then
				return a[1] < b[1]
			end
		end)
	end
	local function ShortValueXP(v)
		if v >= 1e6 then
			return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
		elseif v >= 1e3 or v <= -1e3 then
			return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
		else
			return v
		end
	end
	hooksecurefunc("SortGuildRoster", function(type) CURRENT_GUILD_SORTING = type end)
	Inject("Guild", {
		text = {
			string = function()
				if IsInGuild() then
					local total, _, online = GetNumGuildMembers()
					return format(guild.fmt, online, total)
				else return LOOKINGFORGUILD end
			end, update = 5
		},
		OnLoad = function(self)
			GuildRoster()
			SortGuildRoster(guild.sorting == "note" and "rank" or "note")
			SortGuildRoster(guild.sorting)
			self:RegisterEvent("GROUP_ROSTER_UPDATE")
			self:RegisterEvent("GUILD_ROSTER_UPDATE")
		end,
		OnEvent = function(self, event)
			if self.hovered then
				self:GetScript("OnEnter")(self)
			end
			if IsInGuild() then
				BuildGuildTable()
			end
		end,
		OnUpdate = function(self, u)
			if IsInGuild() then
				AltUpdate(self)
				if not self.gmotd then
					if self.elapsed > 1 then GuildRoster(); self.elapsed = 0 end
					if GetGuildRosterMOTD() ~= "" then self.gmotd = true; if self.hovered then self:GetScript("OnEnter")(self) end end
					self.elapsed = self.elapsed + u
				end
			end
		end,
		OnClick = function(self, b)
			if b == "LeftButton" then
				ToggleGuildFrame()
				if IsInGuild() then
					GuildFrame_TabClicked(GuildFrameTab2)
				end
			elseif b == "MiddleButton" and IsInGuild() then
				local s = CURRENT_GUILD_SORTING
				SortGuildRoster(IsShiftKeyDown() and s or (IsAltKeyDown() and (s == "rank" and "note" or "rank") or s == "class" and "name" or s == "name" and "level" or s == "level" and "zone" or "class"))
				self:GetScript("OnEnter")(self)
			elseif b == "RightButton" and IsInGuild() then
				HideTT(self)

				local classc, levelc, grouped
				local menuCountWhispers = 0
				local menuCountInvites = 0

				menuList[2].menuList = {}
				menuList[3].menuList = {}

				for i = 1, #guildTable do
					if (guildTable[i][7] or guildTable[i][10]) and guildTable[i][1] ~= T.name then
						local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[guildTable[i][9]], GetQuestDifficultyColor(guildTable[i][3])
						if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
							grouped = "|cffaaaaaa*|r"
						else
							grouped = ""
							if not guildTable[i][10] then
								menuCountInvites = menuCountInvites + 1
								menuList[2].menuList[menuCountInvites] = {
									text = string.format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s", levelc.r * 255, levelc.g * 255, levelc.b * 255, guildTable[i][3], classc.r * 255, classc.g * 255, classc.b * 255, guildTable[i][1], ""),
									arg1 = guildTable[i][1],
									notCheckable = true,
									func = function(self, arg1)
										menuFrame:Hide()
										InviteUnit(arg1)
									end
								}
							end
						end
						menuCountWhispers = menuCountWhispers + 1
						menuList[3].menuList[menuCountWhispers] = {
							text = string.format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s", levelc.r * 255, levelc.g * 255, levelc.b * 255, guildTable[i][3], classc.r * 255, classc.g * 255, classc.b * 255, guildTable[i][1], grouped),
							arg1 = guildTable[i][1],
							notCheckable = true,
							func = function(self, arg1)
								menuFrame:Hide()
								SetItemRef("player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton")
							end
						}
					end
				end

				EasyMenu(menuList, menuFrame, self, 0, 0, "MENU")
			end
		end,
		OnEnter = function(self)
			if IsInGuild() then
				self.hovered = true
				GuildRoster()
				local name, rank, level, zone, note, officernote, connected, status, class, isMobile, zone_r, zone_g, zone_b, classc, levelc, grouped
				local total, _, online = GetNumGuildMembers()
				local gmotd = GetGuildRosterMOTD()
				local _, _, standingID, barMin, barMax, barValue = GetGuildFactionInfo()
				local col = T.RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b)

				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint(modules.Guild.tip_anchor, modules.Guild.tip_frame, modules.Guild.tip_x, modules.Guild.tip_y)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(GetGuildInfo(P),format("%s: %d/%d", GUILD_ONLINE_LABEL, online, total), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				if gmotd ~= "" then GameTooltip:AddLine(format("%s |cffaaaaaa- |cffffffff%s", GUILD_MOTD, gmotd), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
				if guild.maxguild ~= 0 and online >= 1 then
					GameTooltip:AddLine(" ")
					for i = 1, total do
						if guild.maxguild and i > guild.maxguild then
							if online > 2 then GameTooltip:AddLine(format("%d %s (%s)", online - guild.maxguild, L_STATS_HIDDEN, ALT_KEY), ttsubh.r, ttsubh.g, ttsubh.b) end
							break
						end
						name, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, isMobile = GetGuildRosterInfo(i)
						if (connected or isMobile) and level >= guild.threshold then
							name = Ambiguate(name, "guild")
							if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1, 0.3 else zone_r, zone_g, zone_b = 1, 1, 1 end
							if isMobile then zone = "|cffa5a5a5"..REMOTE_CHAT.."|r" end
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
							grouped = (UnitInParty(name) or UnitInRaid(name)) and (GetRealZoneText() == zone and " |cff7fff00*|r" or " |cffff7f00*|r") or ""
							if self.altdown then
								GameTooltip:AddDoubleLine(format("%s%s |cff999999- |cffffffff%s", grouped, name, rank), zone, classc.r, classc.g, classc.b, zone_r, zone_g, zone_b)
								if note ~= "" then GameTooltip:AddLine("   "..NOTE_COLON.." "..note, ttsubh.r, ttsubh.g, ttsubh.b, 1) end
								if officernote ~= "" and EPGP then
									local ep, gp = EPGP:GetEPGP(name)
									if ep then
										officernote = "   EP: "..ep.."  GP: "..gp.."  PR: "..string.format("%.3f", ep / gp)
									else
										officernote = "   O."..NOTE_COLON.." "..officernote
									end
								elseif officernote ~= "" then
									officernote = "   O."..NOTE_COLON.." "..officernote
								end
								if officernote ~= "" then GameTooltip:AddLine(officernote, 0.3, 1, 0.3, 1) end
							else
								if status == 1 then
									status = " |cffE7E716"..L_CHAT_AFK.."|r"
								elseif status == 2 then
									status = " |cffff0000"..L_CHAT_DND.."|r"
								else
									status = ""
								end
								GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s%s%s", levelc.r * 255, levelc.g * 255, levelc.b * 255, level, name, status, grouped), zone, classc.r, classc.g, classc.b, zone_r, zone_g, zone_b)
							end
						end
					end
					GameTooltip:AddLine(" ")
					GameTooltip:AddDoubleLine(" ", format("%s %s", L_STATS_SORTING_BY, CURRENT_GUILD_SORTING), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
				end
				GameTooltip:Show()
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Friends
----------------------------------------------------------------------------------------
if friends.enabled then
	local totalFriendsOnline = 0
	local totalBattleNetOnline = 0
	local BNTable = {}
	local friendTable  = {}
	local function BuildFriendTable(total)
		totalFriendsOnline = 0
		wipe(friendTable)

		for i = 1, total do
			local name, level, class, area, connected, status, note = GetFriendInfo(i)
			for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			if GetLocale() ~= "enUS" then
				for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
			end
			friendTable[i] = {name, level, class, area, connected, status, note}
			if connected then
				totalFriendsOnline = totalFriendsOnline + 1
			end
		end

		table.sort(friendTable, function(a, b)
			if a[1] and b[1] then
				return a[1] < b[1]
			end
		end)
	end
	local function BuildBNTable(total)
		totalBattleNetOnline = 0
		wipe(BNTable)

		for i = 1, total do
			local presenceID, presenceName, battleTag, _, toonName, toonID, client, isOnline, _, isAFK, isDND, _, noteText = BNGetFriendInfo(i)
			local _, _, _, realmName, _, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)
			for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			if GetLocale() ~= "enUS" then
				for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
			end
			BNTable[i] = {presenceID, presenceName, battleTag, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level}
			if isOnline then
				totalBattleNetOnline = totalBattleNetOnline + 1
			end
		end

		table.sort(BNTable, function(a, b)
			if a[2] and b[2] and a[3] and b[3] then
				if a[2] == b[2] then return a[3] < b[3] end
				return a[2] < b[2]
			end
		end)
	end
	Inject("Friends", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN PLAYER_ENTERING_WORLD GROUP_ROSTER_UPDATE FRIENDLIST_UPDATE BN_FRIEND_LIST_SIZE_CHANGED BN_FRIEND_ACCOUNT_ONLINE BN_FRIEND_ACCOUNT_OFFLINE BN_FRIEND_INFO_CHANGED BN_FRIEND_TOON_ONLINE BN_FRIEND_TOON_OFFLINE BN_TOON_NAME_UPDATED") end,
		OnEvent = function(self, event)
			if event ~= "GROUP_ROSTER_UPDATE" then
				local numBNetTotal, numBNetOnline = BNGetNumFriends()
				local online, total = 0, GetNumFriends()
				for i = 0, total do if select(5, GetFriendInfo(i)) then online = online + 1 end end
				online = online + numBNetOnline
				total = total + numBNetTotal
				self.text:SetText(format(friends.fmt, online, total))
			end
			if self.hovered then self:GetScript("OnEnter")(self) end
		end,
		OnUpdate = AltUpdate,
		OnClick = function(self, b)
			if b == "MiddleButton" then
				ToggleIgnorePanel()
			elseif b == "LeftButton" then
				ToggleFriendsFrame()
			elseif b == "RightButton" then
				HideTT(self)

				local BNTotal = BNGetNumFriends()
				local total = GetNumFriends()
				BuildBNTable(BNTotal)
				BuildFriendTable(total)

				local classc, levelc, grouped
				local menuCountWhispers = 0
				local menuCountInvites = 0

				menuList[2].menuList = {}
				menuList[3].menuList = {}

				if totalFriendsOnline > 0 then
					for i = 1, #friendTable do
						if friendTable[i][5] then
							if UnitInParty(friendTable[i][1]) or UnitInRaid(friendTable[i][1]) then
								grouped = " |cffaaaaaa*|r"
							else
								grouped = ""
							end

							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]], GetQuestDifficultyColor(friendTable[i][2])
							if classc == nil then
								classc = GetQuestDifficultyColor(friendTable[i][2])
							end

							menuCountWhispers = menuCountWhispers + 1
							menuList[3].menuList[menuCountWhispers] = {
								text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s", levelc.r * 255, levelc.g * 255, levelc.b * 255, friendTable[i][2], classc.r * 255, classc.g * 255, classc.b * 255, friendTable[i][1], grouped),
								arg1 = friendTable[i][1],
								notCheckable = true,
								func = function(self, arg1)
									menuFrame:Hide()
									SetItemRef("player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton")
								end
							}

							if not (UnitInParty(friendTable[i][1]) or UnitInRaid(friendTable[i][1])) then
								menuCountInvites = menuCountInvites + 1
								menuList[2].menuList[menuCountInvites] = {
									text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r", levelc.r * 255, levelc.g * 255, levelc.b * 255, friendTable[i][2], classc.r * 255, classc.g * 255, classc.b * 255, friendTable[i][1]),
									arg1 = friendTable[i][1],
									notCheckable = true,
									func = function(self, arg1)
										menuFrame:Hide()
										InviteUnit(arg1)
									end
								}
							end
						end
					end
				end

				if totalBattleNetOnline > 0 then
					for i = 1, #BNTable do
						if BNTable[i][7] then
							if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
								grouped = " |cffaaaaaa*|r"
							else
								grouped = ""
							end

							menuCountWhispers = menuCountWhispers + 1
							menuList[3].menuList[menuCountWhispers] = {
								text = BNTable[i][2]..grouped,
								arg1 = BNTable[i][2],
								notCheckable = true,
								func = function(self, arg1)
									menuFrame:Hide()
									ChatFrame_SendSmartTell(arg1)
								end
							}

							if BNTable[i][6] == "WoW" and UnitFactionGroup("player") == BNTable[i][12] then
								if not (UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4])) then
									menuCountInvites = menuCountInvites + 1
									menuList[2].menuList[menuCountInvites] = {
										text = BNTable[i][2],
										arg1 = BNTable[i][5],
										notCheckable = true,
										func = function(self, arg1)
											menuFrame:Hide()
											BNInviteFriend(arg1)
										end
									}
								end
							end
						end
					end
				end

				EasyMenu(menuList, menuFrame, self, 0, 0, "MENU")
			end
		end,
		OnEnter = function(self)
			ShowFriends()
			self.hovered = true
			local online, total = 0, GetNumFriends()
			local name, level, class, zone, connected, status, note, classc, levelc, zone_r, zone_g, zone_b, grouped
			for i = 0, total do if select(5, GetFriendInfo(i)) then online = online + 1 end end
			local BNonline, BNtotal = 0, BNGetNumFriends()
			local presenceID, presenceName, toonName, toonID, client, isOnline
			if BNtotal > 0 then
				for i = 1, BNtotal do if select(8, BNGetFriendInfo(i)) then BNonline = BNonline + 1 end end
			end
			local totalonline = online + BNonline
			local totalfriends = total + BNtotal
			if online > 0 or BNonline > 0 then
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint(modules.Friends.tip_anchor, modules.Friends.tip_frame, modules.Friends.tip_x, modules.Friends.tip_y)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(FRIENDS_LIST, format("%s: %s/%s", GUILD_ONLINE_LABEL, totalonline, totalfriends), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				if online > 0 then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(WOW_FRIEND)
					for i = 1, total do
						name, level, class, zone, connected, status, note = GetFriendInfo(i)
						if not connected then break end
						if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1.0, 0.3 else zone_r, zone_g, zone_b = 0.65, 0.65, 0.65 end
						for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
						if GetLocale() ~= "enUS" then
							for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
						end
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
						grouped = (UnitInParty(name) or UnitInRaid(name)) and (GetRealZoneText() == zone and " |cff7fff00*|r" or " |cffff7f00*|r") or ""
						GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s%s%s", levelc.r * 255, levelc.g * 255, levelc.b * 255, level, name, grouped, " "..status), zone, classc.r, classc.g, classc.b, zone_r, zone_g, zone_b)
						if self.altdown and note then GameTooltip:AddLine("  "..note, ttsubh.r, ttsubh.g, ttsubh.b, 1) end
					end
				end
				if BNonline > 0 then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(BATTLENET_FRIEND)
					for i = 1, BNtotal do
						_, presenceName, _, _, toonName, toonID, client, isOnline, _, isAFK, isDND = BNGetFriendInfo(i)
						if not isOnline then break end
						if isAFK then
							status = "|cffE7E716"..L_CHAT_AFK.."|r"
						else
							if isDND then
								status = "|cffff0000"..L_CHAT_DND.."|r"
							else
								status = ""
							end
						end
						if client == "WoW" then
							local _, toonName, client, realmName, _, _, _, class, _, zoneName, level = BNGetToonInfo(toonID)
							for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
							if GetLocale() ~= "enUS" then
								for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
							end
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
							if UnitInParty(toonName) or UnitInRaid(toonName) then grouped = " |cffaaaaaa*|r" else grouped = "" end
							GameTooltip:AddDoubleLine(format("%s (|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r", client, levelc.r * 255, levelc.g * 255, levelc.b * 255, level, classc.r * 255, classc.g * 255, classc.b * 255, toonName, grouped, 255, 0, 0, status), presenceName, 238, 238, 238, 238, 238, 238)
							if self.altdown then
								if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1.0, 0.3 else zone_r, zone_g, zone_b = 0.65, 0.65, 0.65 end
								if GetRealmName() == realmName then realm_r, realm_g, realm_b = 0.3, 1.0, 0.3 else realm_r, realm_g, realm_b = 0.65, 0.65, 0.65 end
								GameTooltip:AddDoubleLine("  "..zoneName, realmName, zone_r, zone_g, zone_b, realm_r, realm_g, realm_b)
							end
						else
							GameTooltip:AddDoubleLine("|cffeeeeee"..client.." ("..toonName..")|r", "|cffeeeeee"..presenceName.."|r")
						end
					end
				end
				GameTooltip:Show()
			else
				HideTT(self)
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Bags
----------------------------------------------------------------------------------------
if bags.enabled then
	Inject("Bags", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN BAG_UPDATE") end,
		OnEvent = function(self)
			local free, total = 0, 0
			for i = 0, NUM_BAG_SLOTS do
				free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
			end
			self.text:SetText(format(bags.fmt, free, total))
		end,
		OnClick = function() ToggleAllBags() end,
		OnEnter = function(self)
			local free, total = 0, 0
			for i = 0, NUM_BAG_SLOTS do
				free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
			end
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			if GetBindingKey("TOGGLEBACKPACK") then
				GameTooltip:AddLine(BACKPACK_TOOLTIP.." ("..GetBindingKey("TOGGLEBACKPACK")..")", tthead.r, tthead.g, tthead.b)
			else
				GameTooltip:AddLine(BACKPACK_TOOLTIP, tthead.r, tthead.g, tthead.b)
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(format(NUM_FREE_SLOTS, free, total), 1, 1, 1)
			GameTooltip:Show()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Talents
----------------------------------------------------------------------------------------
if talents.enabled then
	Inject("Talents", {
		OnLoad = function(self)
			RegEvents(self, "PLAYER_LOGIN PLAYER_TALENT_UPDATE PLAYER_ENTERING_WORLD PLAYER_LEAVING_WORLD")
		end,
		OnEvent = function(self, event, ...)
			if event == "PLAYER_ENTERING_WORLD" then
				self:RegisterEvent("PLAYER_TALENT_UPDATE")
			elseif event == "PLAYER_LEAVING_WORLD" then
				self:UnregisterEvent("PLAYER_TALENT_UPDATE")
			elseif event == "UNIT_SPELLCAST_START" then
				local unit, spell = ...
				if unit == P and (spell == GetSpellInfo(63645) or spell == GetSpellInfo(63644)) then timer = GetTime() end
			else
				if UnitLevel(P) < 10 then
					self.text:SetText(format("%s %s", NO, SPECIALIZATION))
				else
					local active = GetActiveSpecGroup()
					if GetSpecialization(false, false, active) then
						self.text:SetText(select(2, GetSpecializationInfo(GetSpecialization(false, false, active))))
					else
						self.text:SetText(format("%s %s", NO, SPECIALIZATION))
					end
					if self.hovered then self:GetScript("OnEnter")(self) end
				end
			end
		end,
		OnUpdate = function(self)
			if GetNumSpecGroups() > 1 then
				self:SetScript("OnUpdate", nil)
				self:GetScript("OnEvent")(self)
			end
		end,
		OnEnter = function(self)
			self.hovered = true
			if UnitLevel(P) >= 10 then
				GameTooltip:SetOwner(self, talents.tip_anchor, talents.tip_x, talents.tip_y)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(SPECIALIZATION, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(" ")
				for i = 1, GetNumSpecGroups() do
					if GetSpecialization(false, false, i) then
						GameTooltip:AddLine(string.join(" ", string.format("", select(2, GetSpecializationInfo(GetSpecialization(false, false, i)))), (i == GetActiveSpecGroup() and string.join("", "|cff00FF00" , TALENT_ACTIVE_SPEC_STATUS, "|r") or string.join("", "|cffFF0000", FACTION_INACTIVE, "|r"))), 1, 1, 1)
					end
				end
				GameTooltip:Show()
			end
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function(self)
			self.hovered = false
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
		OnClick = function(_, b)
			if b == "RightButton" and GetNumSpecGroups() > 1 then
				SetActiveSpecGroup(3 - GetActiveSpecGroup())
			elseif b == "LeftButton" then
				if not PlayerTalentFrame then
					LoadAddOn("Blizzard_TalentUI")
				end
				if not GlyphFrame then
					LoadAddOn("Blizzard_GlyphUI")
				end
				if T.level >= SHOW_TALENT_LEVEL then
					PlayerTalentFrame_Toggle()
				else
					print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
				end
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Character Stats
----------------------------------------------------------------------------------------
if stats.enabled then
	local function tags(sub)
		local percent, string = true
		if sub == "power" then
			local value, power
			local Base, PosBuff, NegBuff = UnitAttackPower("player")
			local Effective = Base + PosBuff + NegBuff
			local RangedBase, RangedPosBuff, RangedNegBuff = UnitRangedAttackPower("player")
			local range = RangedBase + RangedPosBuff + RangedNegBuff
			heal = GetSpellBonusHealing()
			spell = GetSpellBonusDamage(7)
			attack = Effective
			if heal > spell then
				power = heal
			else
				power = spell
			end
			if attack > power and T.class ~= "HUNTER" then
				value = attack
			elseif T.class == "HUNTER" then
				value = range
			else
				value = power
			end
			string = value
		elseif sub == "mastery" then
			string = GetMasteryEffect()
		elseif sub == "haste" then
			string = GetHaste()
		elseif sub == "resilience" then
			string, percent = GetCombatRating(16)
		elseif sub == "crit" then
			string = GetCritChance()
		elseif sub == "dodge" then
			string = GetDodgeChance()
		elseif sub == "parry" then
			string = GetParryChance()
		elseif sub == "block" then
			string = GetBlockChance()
		elseif sub == "avoidance" then
			string = GetDodgeChance() + GetParryChance()
		elseif sub == "manaregen" then
			local I5SR = true
			if T.class == "ROGUE" or T.class == "WARRIOR" or T.class == "DEATHKNIGHT" then
				string, percent = "??"
			else
				local base, cast = GetManaRegen()
				string, percent = floor((I5SR and cast or base) * 5)
			end
		elseif sub == "armor" then
			local _, eff = UnitArmor(P)
			string, percent = eff
		elseif sub == "strike" then
			string = GetMultistrike()
		elseif sub == "versatility" then
			string = GetCombatRating(29)
		elseif sub == "leech" then
			string = GetCombatRating(17)
		else
			string, percent = format("[%s]", sub)
		end
		if not percent then return string end
		return format("%.1f", string)
	end
	Inject("Stats", {
		OnLoad = function(self)
			RegEvents(self, "PLAYER_LOGIN UNIT_STATS UNIT_DAMAGE UNIT_RANGEDDAMAGE PLAYER_DAMAGE_DONE_MODS UNIT_ATTACK_SPEED UNIT_ATTACK_POWER UNIT_RANGED_ATTACK_POWER")
		end,
		OnEvent = function(self) self.fired = true end,
		OnUpdate = function(self, u)
			self.elapsed = self.elapsed + u
			if self.fired and self.elapsed > 2.5 then
				self.text:SetText(gsub(stats[format("spec%dfmt", GetActiveSpecGroup())], "%[(%w-)%]", tags))
				self.elapsed, self.fired = 0, false
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Experience/Played/Rep
----------------------------------------------------------------------------------------
if experience.enabled then
	local logintime, playedtotal, playedlevel, playedmsg, gained, lastkill, lastquest = GetTime(), 0, 0, 0, 0
	local repname, repcolor, standingname, currep, minrep, maxrep, reppercent
	local mobxp = gsub(COMBATLOG_XPGAIN_FIRSTPERSON, "%%[sd]", "(.*)")
	local questxp = gsub(COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED, "%%[sd]", "(.*)")
	local function short(num, tt)
		if short or tt then
			num = tonumber(num)
			if num >= 1e6 then
				return gsub(format("%.2f%s", num / 1e6, experience.million or "m"), "%.0", "")
			elseif num >= 1e5 then
				return gsub(format("%.0f%s", num / 1e3, experience.thousand or "k"), "%.0", "")
			elseif num >= 1e3 then
				return gsub(format("%.1f%s", num / 1e3, experience.thousand or "k"), "%.0", "")
			end
		end
		return floor(tonumber(num))
	end
	local function tags(sub,tt)
		local t = experience
			-- exp tags
		return sub == "level" and UnitLevel(P)
			or sub == "curxp" and short(UnitXP(P),tt)
			or sub == "remainingxp" and short(UnitXPMax(P) - UnitXP(P), tt)
			or sub == "totalxp" and short(UnitXPMax(P), tt)
			or sub == "cur%" and floor(UnitXP(P) / UnitXPMax(P) * 100)
			or sub == "remaining%" and 100 - floor(UnitXP(P) / UnitXPMax(P) * 100)
			or sub == "restxp" and short(GetXPExhaustion() or 0,tt)
			or sub == "rest%" and min(150, floor((GetXPExhaustion() or 0) / UnitXPMax(P) * 100))
			or sub == "sessiongained" and short(gained,tt)
			or sub == "sessionrate" and short(gained / (GetTime() - playedmsg) * 3600, tt)
			or sub == "levelrate" and short(UnitXP(P) / (playedlevel + GetTime() - playedmsg) * 3600, tt)
			or sub == "sessionttl" and (gained ~= 0 and fmttime((UnitXPMax(P) - UnitXP(P)) / (gained / (GetTime() - playedmsg)), t) or L_STATS_INF)
			or sub == "levelttl" and (UnitXP(P) ~= 0 and fmttime((UnitXPMax(P) - UnitXP(P)) / (UnitXP(P) / (playedlevel + GetTime() - playedmsg)), t) or L_STATS_INF)
			or sub == "questsleft" and (lastquest and ceil((UnitXPMax(P) - UnitXP(P)) / tonumber(lastquest)) or "??")
			or sub == "killsleft" and (lastkill and ceil((UnitXPMax(P) - UnitXP(P)) / tonumber(lastkill)) or "??")
			-- time played tags
			or sub == "playedtotal" and fmttime(playedtotal + GetTime() - playedmsg, t)
			or sub == "playedlevel" and fmttime(playedlevel + GetTime() - playedmsg, t)
			or sub == "playedsession" and fmttime(GetTime() - logintime,t)
			-- rep tags
			or sub == "repname" and (t.faction_subs[repname] or repname)
			or sub == "repcolor" and "|cff"..repcolor
			or sub == "standing" and standingname
			or sub == "currep" and abs(currep - minrep)
			or sub == "repleft" and abs(maxrep - currep)
			or sub == "maxrep" and abs(maxrep - minrep)
			or sub == "rep%" and (currep ~= 0 and floor(abs(currep - minrep) / abs(maxrep - minrep) * 100) or 0)
			or format("[%s]", sub)
	end
	Inject("Experience", {
		text = {
			string = function(self)
				if conf.ExpMode == "rep" then
					return self:GetText()
				elseif conf.ExpMode == "played" then
					return gsub(experience.played_fmt, "%[([%w%%]-)%]", tags)
				elseif conf.ExpMode == "xp" then
					return gsub(experience[format("xp_%s_fmt", (GetXPExhaustion() or 0) > 0 and "rested" or "normal")], "%[([%w%%]-)%]", tags) or " "
				end
			end
		},
		OnLoad = function(self)
			RegEvents(self, "TIME_PLAYED_MSG PLAYER_LOGOUT PLAYER_LOGIN UPDATE_FACTION CHAT_MSG_COMBAT_XP_GAIN PLAYER_LEVEL_UP")
			-- Filter first time played message
			local ofunc = ChatFrame_DisplayTimePlayed
			function ChatFrame_DisplayTimePlayed() ChatFrame_DisplayTimePlayed = ofunc end
			RequestTimePlayed()
			if not conf.ExpMode or conf.ExpMode == "xp" then
				conf.ExpMode = UnitLevel(P) ~= MAX_PLAYER_LEVEL and "xp" or "played"
			end
		end,
		OnEvent = function(self, event, ...)
			if event == "CHAT_MSG_COMBAT_XP_GAIN" then
				local msg = ...
				if msg:find(mobxp) then
					_, lastkill = strmatch(msg, mobxp)
					lastkill = strmatch(lastkill, "%d+")
					gained = gained + lastkill
				elseif msg:find(questxp) then
					lastquest = strmatch(msg, questxp)
					lastquest = strmatch(lastquest, "%d+")
					gained = gained + lastquest
				end
			elseif event == "PLAYER_LEVEL_UP" then
				playedlevel, playedmsg = 0, GetTime()
			elseif event == "TIME_PLAYED_MSG" then
				playedtotal, playedlevel = ...
				playedmsg = GetTime()
			elseif (event == "UPDATE_FACTION" or event == "PLAYER_LOGIN") and conf.ExpMode == "rep" then
				local standing
				repname, standing, minrep, maxrep, currep = GetWatchedFactionInfo()
				if not repname then repname = NONE end
				local color = {}
				if standing == 0 then
					color.r, color.g, color.b = GetItemQualityColor(0)
				elseif standing == 7 then
					color.r, color.g, color.b = GetItemQualityColor(3)
				elseif standing == 8 then
					color.r, color.g, color.b = GetItemQualityColor(4)
				else
					color = FACTION_BAR_COLORS[standing]
				end
				standingname = _G[format("FACTION_STANDING_LABEL%s%s", standing, UnitSex(P) == 3 and "_FEMALE" or "")]
				if not standingname then standingname = UNKNOWN end
				repcolor = format("%02x%02x%02x", min(color.r * 255 + 40, 255), min(color.g * 255 + 40, 255), min(color.b * 255 + 40, 255))
				self.text:SetText(gsub(experience.faction_fmt, "%[([%w%%]-)%]", tags))
			end
			if event == "PLAYER_LOGOUT" or event == "TIME_PLAYED_MSG" then
				conf.Played = floor(playedtotal + GetTime() - playedmsg)
			end
		end,
		OnEnter = function(self)
			self.hovered = true
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Experience.tip_anchor, modules.Experience.tip_frame, modules.Experience.tip_x, modules.Experience.tip_y)
			GameTooltip:ClearLines()
			if conf.ExpMode == "played" then
				GameTooltip:AddLine(TIME_PLAYED_MSG, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_SESSION, tags("playedsession", 1), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_LEVEL, tags("playedlevel", 1), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(L_STATS_ACC_PLAYED, ttsubh.r, ttsubh.g, ttsubh.b)
				local total = 0
				for realm, t in pairs(SavedStats) do
					for name, conf in pairs(t) do
						if conf.Played then
							local r, g, b, player = 1, 1, 1
							if name == UnitName(P) and realm == GetRealmName() then
								conf.Played, player, r, g, b = floor(playedtotal + GetTime() - playedmsg), true, 0.5, 1, 0.5
							end
							if conf.Played > 3600 or player then -- 1hr threshold displayed
								GameTooltip:AddDoubleLine(format("%s-%s", name, realm), fmttime(conf.Played), r, g, b, 1, 1, 1)
							end
							total = total + conf.Played
						end
					end
				end
				GameTooltip:AddDoubleLine(" ", "------------------", 1, 1, 1, 0.5, 0.5, 0.5)
				GameTooltip:AddDoubleLine(TOTAL, fmttime(total), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			elseif conf.ExpMode == "xp" then
				GameTooltip:AddDoubleLine(COMBAT_XP_GAIN, format(LEVEL_GAINED, UnitLevel(P)), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_CURRENT_XP, format("%s/%s (%s%%)", tags"curxp", tags"totalxp", tags"cur%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_REMAINING_XP, format("%s (%s%%)", tags"remainingxp", tags"remaining%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				if GetXPExhaustion() and GetXPExhaustion() ~= 0 then
					GameTooltip:AddDoubleLine(L_STATS_RESTED_XP, format("%s (%s%%)", tags"restxp", tags"rest%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				end
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_SESSION_XP, format("%s/%s (%s)", tags"sessionrate", L_STATS_HR, tags"sessionttl"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_XP_RATE, format("%s/%s (%s)", tags"levelrate", L_STATS_HR, tags"levelttl"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(format(L_STATS_QUESTS_TO, UnitLevel(P) + 1), format("%s:%s %s:%s", L_STATS_QUEST, tags"questsleft", L_STATS_KILLS, tags"killsleft"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_SESSION, tags"playedsession", ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_LEVEL, tags"playedlevel", ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_TOTAL, tags"playedtotal", ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			elseif conf.ExpMode == "rep" then
				local desc, war, watched
				for i = 1, GetNumFactions() do
					_, desc, _, _, _, _, war, _, _, _, _, watched = GetFactionInfo(i)
					if watched then break end
				end
				GameTooltip:AddLine(repname, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(desc, ttsubh.r, ttsubh.g, ttsubh.b, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(format("%s%s", tags"repcolor", tags"standing"), war and format("|cffff5555%s", AT_WAR))
				GameTooltip:AddDoubleLine(format("%s%% | %s/%s", tags"rep%", tags"currep", tags"maxrep"), -tags"repleft", ttsubh.r, ttsubh.g, ttsubh.b, 1, 0.33, 0.33)
			end
			GameTooltip:Show()
		end,
		OnClick = function(self, button)
			if button == "RightButton" then
				conf.ExpMode = conf.ExpMode == "xp" and "played"
					or conf.ExpMode == "played" and "rep"
					or (conf.ExpMode == "rep" and UnitLevel(P) ~= MAX_PLAYER_LEVEL) and "xp"
					or conf.ExpMode == "rep" and "played"
				if conf.ExpMode == "rep" then
					self:GetScript("OnEvent")(self,"UPDATE_FACTION")
				else
					self:GetScript("OnUpdate")(self, 5)
				end
				self:GetScript("OnEnter")(self)
			elseif button == "LeftButton" and conf.ExpMode == "rep" then
				ToggleCharacter("ReputationFrame")
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Loot
----------------------------------------------------------------------------------------
if loot.enabled then
	Inject("Loot", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN CVAR_UPDATE") end,
		OnEvent = function(self)
			if GetCVarBool("AutoLootDefault") then
				self.text:SetText(format(loot.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
			else
				self.text:SetText(format(loot.fmt, "|cffff5555"..strupper(OFF).."|r"))
			end
		end,
		OnClick = function(self, button)
			if button == "RightButton" or button == "LeftButton" then
				if GetCVarBool("AutoLootDefault") then
					SetCVar("AutoLootDefault", 0)
					self.text:SetText(format(loot.fmt, "|cffff5555"..strupper(OFF).."|r"))
				else
					SetCVar("AutoLootDefault", 1)
					self.text:SetText(format(loot.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(AUTO_LOOT_DEFAULT_TEXT, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(OPTION_TOOLTIP_AUTO_LOOT_DEFAULT, 1, 1, 1, 1)
			GameTooltip:Show()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Helm
----------------------------------------------------------------------------------------
if helm.enabled then
	Inject("Helm", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN CVAR_UPDATE") end,
		OnEvent = function(self)
			if ShowingHelm() then
				self.text:SetText(format(helm.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
			else
				self.text:SetText(format(helm.fmt, "|cffff5555"..strupper(OFF).."|r"))
			end
		end,
		OnClick = function(self, button)
			if button == "RightButton" or button == "LeftButton" then
				if ShowingHelm() then
					ShowHelm(false)
					self.text:SetText(format(helm.fmt, "|cffff5555"..strupper(OFF).."|r"))
				else
					ShowHelm(true)
					self.text:SetText(format(helm.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(SHOW_HELM, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(OPTION_TOOLTIP_SHOW_HELM, 1, 1, 1)
			GameTooltip:Show()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Cloak
----------------------------------------------------------------------------------------
if cloak.enabled then
	Inject("Cloak", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN CVAR_UPDATE") end,
		OnEvent = function(self)
			if ShowingCloak() then
				self.text:SetText(format(cloak.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
			else
				self.text:SetText(format(cloak.fmt, "|cffff5555"..strupper(OFF).."|r"))
			end
		end,
		OnClick = function(self, button)
			if button == "RightButton" or button == "LeftButton" then
				if ShowingCloak() then
					ShowCloak(false)
					self.text:SetText(format(cloak.fmt, "|cffff5555"..strupper(OFF).."|r"))
				else
					ShowCloak(true)
					self.text:SetText(format(cloak.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(SHOW_CLOAK, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(OPTION_TOOLTIP_SHOW_CLOAK, 1, 1, 1)
			GameTooltip:Show()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Nameplates
----------------------------------------------------------------------------------------
if nameplates.enabled then
	Inject("Nameplates", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN CVAR_UPDATE") end,
		OnEvent = function(self)
			if GetCVar("nameplateMotion") == "0" then
				self.text:SetText(format(nameplates.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
			else
				self.text:SetText(format(nameplates.fmt, "|cffff5555"..strupper(OFF).."|r"))
			end
		end,
		OnClick = function(self, button)
			if button == "RightButton" or button == "LeftButton" then
				if GetCVar("nameplateMotion") == "0" then
					SetCVar("nameplateMotion", "2")
					self.text:SetText(format(nameplates.fmt, "|cffff5555"..strupper(OFF).."|r"))
				else
					SetCVar("nameplateMotion", "0")
					self.text:SetText(format(nameplates.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(UNIT_NAMEPLATES_ALLOW_OVERLAP, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(OPTION_TOOLTIP_UNIT_NAMEPLATES_ALLOW_OVERLAP, 1, 1, 1, 1)
			GameTooltip:Show()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if Viks.toppanel.enable == true and Viks.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Applying modules
----------------------------------------------------------------------------------------
lpanels:CreateLayout("LiteStats", layout)
lpanels:ApplyLayout(nil, "LiteStats")

Inject = nil