﻿local T, Viks, L, _ = unpack(select(2, ...))
--[[
----------------------------------------------------------------------------------------
--	Movement function(by Allez)
----------------------------------------------------------------------------------------
T.MoverFrames = {
	ActionBarAnchor,
	RightActionBarAnchor,
	PetActionBarAnchor,
	ShiftHolder,
	VehicleButtonAnchor,
	MicroAnchor,
	VehicleAnchor,
	WatchFrameAnchor,
	AchievementAnchor,
	MinimapAnchor,
	TopPanelAnchor,
	BuffsAnchor,
	RaidCDAnchor,
	EnemyCDAnchor,
	ThreatMeterAnchor,
	LootRollAnchor,
	RaidBuffsAnchor,
	DCPAnchor,
	AutoButtonAnchor,
	TooltipAnchor,
	ChatBar,
	oUF_Player_Castbar,
	oUF_Target_Castbar,
	oUF_Player_Portrait,
	oUF_Target_Portrait,
}

local moving = false
local movers = {}
local placed = {
	"Butsu",
	"UIAltPowerBar",
	"LootHistoryFrame",
	"stArchaeologyFrame",
	"StuffingFrameBags",
	"StuffingFrameBank",
	"ExtraActionBarFrame",
	"alDamageMeterFrame"
}

local SetPosition = function(mover)
	local ap, _, rp, x, y = mover:GetPoint()
	SavedPositions[mover.frame:GetName()] = {ap, "UIParent", rp, x, y}
end

local OnDragStart = function(self)
	self:StartMoving()
	self.frame:ClearAllPoints()
	self.frame:SetAllPoints(self)
end

local OnDragStop = function(self)
	self:StopMovingOrSizing()
	SetPosition(self)
end

local CreateMover = function(frame)
	local mover = CreateFrame("Frame", nil, UIParent)
	mover:SetTemplate("Transparent")
	mover:SetBackdropBorderColor(1, 0, 0)
	mover:SetAllPoints(frame)
	mover:SetFrameStrata("TOOLTIP")
	mover:EnableMouse(true)
	mover:SetMovable(true)
	mover:SetClampedToScreen(true)
	mover:RegisterForDrag("LeftButton")
	mover:SetScript("OnDragStart", OnDragStart)
	mover:SetScript("OnDragStop", OnDragStop)
	mover:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b) end)
	mover:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(1, 0, 0) end)
	mover.frame = frame

	mover.name = mover:CreateFontString(nil, "OVERLAY")
	mover.name:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
	mover.name:SetPoint("CENTER")
	mover.name:SetTextColor(1, 1, 1)
	mover.name:SetText(frame:GetName())
	mover.name:SetWidth(frame:GetWidth() - 4)
	movers[frame:GetName()] = mover
end

local GetMover = function(frame)
	if movers[frame:GetName()] then
		return movers[frame:GetName()]
	else
		return CreateMover(frame)
	end
end

local InitMove = function(msg)
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
	if msg and (msg == "reset" or msg == "куыуе") then
		SavedPositions = {}
		SavedOptionsPerChar.UFPos = {}
		for i, v in pairs(placed) do
			if _G[v] then
				_G[v]:SetUserPlaced(false)
			end
		end
		ReloadUI()
		return
	end
	if not moving then
		for i, v in pairs(T.MoverFrames) do
			local mover = GetMover(v)
			if mover then mover:Show() end
		end
		moving = true
	else
		for i, v in pairs(movers) do
			v:Hide()
		end
		moving = false
	end
	if T.MoveUnitFrames then T.MoveUnitFrames() end
end

local RestoreUI = function(self)
	if InCombatLockdown() then
		if not self.shedule then self.shedule = CreateFrame("Frame", nil, self) end
		self.shedule:RegisterEvent("PLAYER_REGEN_ENABLED")
		self.shedule:SetScript("OnEvent", function(self)
			RestoreUI(self:GetParent())
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			self:SetScript("OnEvent", nil)
		end)
		return
	end
	for frame_name, point in pairs(SavedPositions) do
		if _G[frame_name] then
			_G[frame_name]:ClearAllPoints()
			_G[frame_name]:SetPoint(unpack(point))
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent(event)
	RestoreUI(self)
end)

SlashCmdList.MOVING = InitMove
SLASH_MOVING1 = "/moveui"
SLASH_MOVING2 = "/ьщмугш"
SLASH_MOVING3 = "/ui"
SLASH_MOVING4 = "/гш"

--]]