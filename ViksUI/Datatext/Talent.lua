local T, Viks, L, _ = unpack(select(2, ...))
if not Viks.datatext.Talents or Viks.datatext.Talents == 0 then return end
DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = "ANCHOR_CURSOR"
	local xoff = 0
	local yoff = 20
	return anchor, panel, xoff, yoff
end

local format = string.format
local lastPanel, active
local displayString = '';
local talent = {}
local activeString = string.join("", "|cff00FF00" , ACTIVE_PETS, "|r")
local inactiveString = string.join("", "|cffFF0000", FACTION_INACTIVE, "|r")

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF

ns._Objects = {}
ns._Headers = {}


local Stat = CreateFrame("Frame")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat:EnableMouse(true)

local Text  = LBottom:CreateFontString(nil, "OVERLAY")
if Viks.datatext.Talents >= 9 then
Text:SetTextColor(unpack(Viks.media.pxcolor1))
Text:SetFont(Viks.media.pxfontHeader, Viks.media.pxfontHsize, Viks.media.pxfontHFlag)
else
Text:SetTextColor(unpack(Viks.media.pxcolor1))
Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
end
PP(Viks.datatext.Talents, Text)

local function HasDualSpec() if GetNumTalentGroups() > 1 then return true end end

local int = 1
local function Update(self, t)
	if not GetSpecialization() then Text:SetText("No talents") return end
	int = int - t
	if int < 0 then
			local tree = GetSpecialization()
			local spec = select(2,GetSpecializationInfo(tree)) or ""
	Text:SetText(spec)
	self:SetAllPoints(Text)
	end
end


Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("CONFIRM_TALENT_WIPE")
Stat:RegisterEvent("PLAYER_TALENT_UPDATE")
Stat:SetScript("OnEvent", OnEvent)

Stat:SetScript("OnMouseDown", function()
		local c = GetActiveSpecGroup(false,false)
		SetActiveSpecGroup(c == 1 and 2 or 1)
end)
--[[
Stat:SetScript("OnEnter", function()
	local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	for i = 1, GetNumSpecGroups() do
		if GetSpecialization(false, false, i) then
			GameTooltip:AddLine(string.join(" ", string.format(displayString, select(2, GetSpecializationInfo(GetSpecialization(false, false, i)))), (i == active and activeString or inactiveString)),1,1,1)
		end
	end
	GameTooltip:Show()
end)
--]]
Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:RegisterEvent("PLAYER_LOGIN")
Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnUpdate", Update)
