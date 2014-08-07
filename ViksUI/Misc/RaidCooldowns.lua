local T, Viks, L, _ = unpack(select(2, ...))
if not Viks.misc.raidcooldowns then return end

----------------------------------------------------------------------------------------
--	Raid cooldowns(alRaidCD by Allez)
----------------------------------------------------------------------------------------
local show = {
	raid = true,
	party = true,
	arena = true,
}

local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
local band = bit.band
local sformat = string.format
local floor = math.floor
local timer = 0
local bars = {}

AnchorRaidCD = CreateFrame("Frame","Move_RaidCD",UIParent)
AnchorRaidCD:SetPoint("TOPLEFT", 26, -230)
CreateAnchor(AnchorRaidCD, "Move RaidCD", 186 + 32, 192)

local RaidCDAnchor = CreateFrame("Frame", "RaidCDAnchor", UIParent)
RaidCDAnchor:SetPoint("BOTTOM", AnchorRaidCD)
RaidCDAnchor:SetSize(186 + 32, 20)


local FormatTime = function(time)
	if time >= 60 then
		return sformat("%.2d:%.2d", floor(time / 60), time % 60)
	else
		return sformat("%.2d", time)
	end
end

local CreateFS = function(frame, fsize, fstyle)
	local fstring = frame:CreateFontString(nil, "OVERLAY")
	fstring:SetFont(Viks.media.font, 10, "OUTLINE")
	fstring:SetShadowOffset(1 and 1 or 0, 1 and -1 or 0)
	return fstring
end

local UpdatePositions = function()
	for i = 1, #bars do
		bars[i]:ClearAllPoints()
		if i == 1 then
			bars[i]:SetPoint("BOTTOMRIGHT", RaidCDAnchor, "BOTTOMRIGHT", -2, 2)
		else
			bars[i]:SetPoint("BOTTOMLEFT", bars[i-1], "TOPLEFT", 0, 8)
		end
		bars[i].id = i
	end
end

local StopTimer = function(bar)
	bar:SetScript("OnUpdate", nil)
	bar:Hide()
	tremove(bars, bar.id)
	UpdatePositions()
end

local BarUpdate = function(self, elapsed)
	local curTime = GetTime()
	if self.endTime < curTime then
		StopTimer(self)
		return
	end
	self:SetValue(100 - (curTime - self.startTime) / (self.endTime - self.startTime) * 100)
	self.right:SetText(FormatTime(self.endTime - curTime))
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddDoubleLine(self.spell, self.right:GetText())
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
			SendChatMessage(sformat("CD: ".." %s: %s", self.left:GetText(), self.right:GetText()), "INSTANCE_CHAT")
	elseif button == "RightButton" then
		StopTimer(self)
	end
end


local CreateBar = function()
	local bar = CreateFrame("Statusbar", nil, UIParent)
	bar:SetFrameStrata("HIGH")
	bar:SetSize(186 + 28, 14)
	
	bar:SetStatusBarTexture(Viks.media.texture)
	bar:SetMinMaxValues(0, 100)

	bar.backdrop = CreateFrame("Frame", nil, bar)
	bar.backdrop:SetPoint("TOPLEFT", -2, 2)
	bar.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	frame1px1_1(bar.backdrop)
	bar.backdrop:SetFrameStrata("BACKGROUND")

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(Viks.media.texture)

	bar.left = CreateFS(bar)
	bar.left:SetPoint("LEFT", 2, 0)
	bar.left:SetJustifyH("LEFT")
	bar.left:SetSize(186 - 30, 20)

	bar.right = CreateFS(bar)
	bar.right:SetPoint("RIGHT", 1, 0)
	bar.right:SetJustifyH("RIGHT")

	
		bar.icon = CreateFrame("Button", nil, bar)
		bar.icon:SetWidth(bar:GetHeight())
		bar.icon:SetHeight(bar.icon:GetWidth())
		bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -7, 0)

		bar.icon.backdrop = CreateFrame("Frame", nil, bar.icon)
		bar.icon.backdrop:SetPoint("TOPLEFT", -2, 2)
		bar.icon.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
		frame1px1_1(bar.icon.backdrop)
		bar.icon.backdrop:SetFrameStrata("BACKGROUND")
	
	return bar
end
raid_spells = {
		[20484] = 600,	-- Rebirth
		[61999] = 600,	-- Raise Ally
		[20707] = 900,	-- Soulstone
		[6346] = 180,	-- Fear Ward
		[29166] = 180,	-- Innervate
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
		[80353] = 300,	-- Time Warp
		[90355] = 300,	-- Ancient Hysteria
			-- Сейвы
		[64843] = 480,  -- Divine Hymn (Божественный гимн)
		[33206] = 180,  -- Pain Suppression (Подавление боли)
		[62618] = 180,  -- Power Word: Barrier (Купол)
		[97462] = 180,  -- Rallying Cry (Ободряющий клич)
		[31821] = 120,  -- Aura Mastery (Мастер Аур)
		[70940] = 180,  -- Divine Guardian (Масс Сакра)
		[98008] = 180,  -- Spirit Link Totem (Тотем духовной связи)
		[6940] = 120,   -- Hand of Sacrifice (Сакра)
}
local StartTimer = function(name, spellId)
	local bar = CreateBar()
	local spell, rank, icon = GetSpellInfo(spellId)
	bar.endTime = GetTime() + raid_spells[spellId]
	bar.startTime = GetTime()
	bar.left:SetText(name.." - "..spell)
	bar.right:SetText(FormatTime(raid_spells[spellId]))
	bar.icon:SetNormalTexture(icon)
	bar.icon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	
	bar.spell = spell
	bar:Show()
	local color = RAID_CLASS_COLORS[select(2, UnitClass(name))]
	if color then
		bar:SetStatusBarColor(color.r, color.g, color.b)
		bar.bg:SetVertexColor(color.r, color.g, color.b, 0.25)
	else
		bar:SetStatusBarColor(0.3, 0.7, 0.3)
		bar.bg:SetVertexColor(0.3, 0.7, 0.3, 0.25)
	end
	bar:SetScript("OnUpdate", BarUpdate)
	bar:EnableMouse(true)
	bar:SetScript("OnEnter", OnEnter)
	bar:SetScript("OnLeave", OnLeave)
	bar:SetScript("OnMouseDown", OnMouseDown)
	tinsert(bars, bar)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, _, sourceName, sourceFlags = ...

		if band(sourceFlags, filter) == 0 then return end
		local spellId = select(12, ...)

		if raid_spells[spellId] and show[select(2, IsInInstance())] then
			if eventType == "SPELL_RESURRECT" and not spellId == 61999 then
				if spellId == 95750 then spellId = 6203 end
				StartTimer(sourceName, spellId)
			elseif eventType == "SPELL_AURA_APPLIED" then
				if spellId == 20707 then
					local _, class = UnitClass(sourceName)
					if class == "WARLOCK" then
						StartTimer(sourceName, spellId)
					end
				end
			elseif eventType == "SPELL_CAST_SUCCESS" then
				StartTimer(sourceName, spellId)
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) ~= "raid" and UnitIsGhost("player") then
		for k, v in pairs(bars) do
			v.endTime = 0
	end
	elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) == "arena" or not IsInGroup() then
		for k, v in pairs(bars) do
			v.endTime = 0
		end
	end
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList.RaidCD = function(msg)
	StartTimer(UnitName("player"), 20484)	-- Rebirth
	StartTimer(UnitName("player"), 20707)	-- Soulstone
	StartTimer(UnitName("player"), 6346)	-- Fear Ward
	StartTimer(UnitName("player"), 29166)	-- Innervate
	StartTimer(UnitName("player"), 32182)	-- Heroism
	StartTimer(UnitName("player"), 2825)	-- Bloodlust
end
SLASH_RaidCD1 = "/raidcd"
SLASH_RaidCD2 = "/кфшвсв"