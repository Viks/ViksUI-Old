﻿local T, Viks, L, _ = unpack(select(2, ...))
if Viks.automation.auto_role ~= true then return end

----------------------------------------------------------------------------------------
--	Automatically sets your role(Auto role setter by iSpawnAtHome)
----------------------------------------------------------------------------------------
local function SetRole()
	local spec = GetSpecialization()
	if T.level >= 10 and not InCombatLockdown() then
		if spec == nil then
			UnitSetRole("player", "No Role")
		elseif spec ~= nil then
			if GetNumGroupMembers() > 0 then
				local role = GetSpecializationRole(spec)
				UnitSetRole("player", role)
			end
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")

frame:SetScript("OnEvent", SetRole)

RolePollPopup:SetScript("OnShow", function() StaticPopupSpecial_Hide(RolePollPopup) end)