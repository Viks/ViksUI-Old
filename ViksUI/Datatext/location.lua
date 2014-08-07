local T, Viks, L, _ = unpack(select(2, ...))
--------------------------------------------------------------------
-- Location and Coords
--------------------------------------------------------------------

if Viks.datatext.location and Viks.datatext.location > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = LBottom:CreateFontString(nil, "OVERLAY")
if Viks.datatext.location >= 9 then
Text:SetTextColor(unpack(Viks.media.pxcolor1))
Text:SetFont(Viks.media.pxfontHeader, Viks.media.pxfontHsize, Viks.media.pxfontHFlag)
else
Text:SetTextColor(unpack(Viks.media.pxcolor1))
Text:SetFont(Viks.media.pxfont, Viks.media.pxfontsize, Viks.media.pxfontFlag)
end
	PP(Viks.datatext.location, Text)

	local int = 1
	
	-- Location Colors for MoP
function LocMopColoring()
	local pvpType = GetZonePVPInfo()
	if pvpType == "arena" then
		return 0.84, 0.03, 0.03
	elseif pvpType == "friendly" then
		return 0.05, 0.85, 0.03
	elseif pvpType == "contested" then
		return 0.9, 0.85, 0.05
	elseif pvpType == "hostile" then 
		return 0.84, 0.03, 0.03
	elseif pvpType == "sanctuary" then
		return 0.035, 0.58, 0.84
	elseif pvpType == "combat" then
		return 0.84, 0.03, 0.03
	else
		return 1, 1, 0
	end
end

	local ela = 0
local function Update(self, t)
	ela = ela - t
	if ela > 0 then return end
	local subZoneText = GetMinimapZoneText() or ""
	local zoneText = _G.GetRealZoneText() or _G.UNKNOWN;
	local x,y = GetPlayerMapPosition("player")
	x = math.floor(100 * x)
	y = math.floor(100 * y)
	local displayLine

	-- zone and subzone
	if Viks.datatext.location and Viks.datatext.location > 0 then
		if (subZoneText ~= "") and (subZoneText ~= zoneText) then
			displayLine = zoneText .. ": " .. subZoneText
			else
			displayLine = subZoneText
			end
		else
			displayLine = subZoneText
		end
		local r, g, b = LocMopColoring()
			Text:SetText(qColor..x.." ".. string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, displayLine)..qColor.." "..y)
	end
	ela = .2
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end
