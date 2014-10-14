local T, Viks, L, _ = unpack(select(2, ...))
local csf = CreateFrame("Frame")
csf:SetScript("OnEvent", function()
SetCVar("cameraDistanceMax", 50)
SetCVar("cameraDistanceMaxFactor", 3.4)
SetCVar("consolidateBuffs", 0)
SetCVar("ShowClassColorInNameplate", 1)
SetCVar("consolidateBuffs",0) 
SetCVar("buffDurations",1)

end)
csf:RegisterEvent("PLAYER_LOGIN")

----------------------------------------------------------------------------------------
-- Launcher
----------------------------------------------------------------------------------------
local function positionsetup()
	ViksDataPerChar = {}
end

local ViksOnLogon = CreateFrame("Frame")
ViksOnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
ViksOnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	if (ViksData == nil) then ViksData = {} end
	if (ViksDataPerChar == nil) then ViksDataPerChar = {} end
	
		SetCVar("useUiScale", 1)
		if Viks.general.UiScale > 1 then Viks.general.UiScale = 1 end
		if Viks.general.UiScale < 0.64 then Viks.general.UiScale = 0.64 end
		SetCVar("uiScale", Viks.general.UiScale)
	
	print("Welcome to |cFF00A2FFViks UI|r")
	print(" ")
	print("|cFF00A2FF/config |r - Config Viks UI;")
	print("|cFF00A2FF/ui |r - Command for change all UI positions.")
	print("|cFF00A2FF/ui reset |r - Set default UI postions.")
end)