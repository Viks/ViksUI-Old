--[[
local T, Viks, L, _ = unpack(select(2, ...))
local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

if not IsAddOnLoaded("Viks_ConfigUI") then return end

if not ViksConfigAll then ViksConfigAll = {} end		
if (ViksConfigAll[myPlayerRealm] == nil) then ViksConfigAll[myPlayerRealm] = {} end
if (ViksConfigAll[myPlayerRealm][myPlayerName] == nil) then ViksConfigAll[myPlayerRealm][myPlayerName] = false end

if ViksConfigAll[myPlayerRealm][myPlayerName] == true and not ViksConfig then return end
if ViksConfigAll[myPlayerRealm][myPlayerName] == false and not ViksConfigSettings then return end


if ViksConfigAll[myPlayerRealm][myPlayerName] == true then
	for group,options in pairs(ViksConfig) do
		if Viks[group] then
			local count = 0
			for option,value in pairs(options) do
				if Viks[group][option] ~= nil then
					if Viks[group][option] == value then
						ViksConfig[group][option] = nil	
					else
						count = count+1
						Viks[group][option] = value
					end
				end
			end
			-- keeps ViksConfig clean and small
			if count == 0 then ViksConfig[group] = nil end
		else
			ViksConfig[group] = nil
		end
	end
else
	for group,options in pairs(ViksConfigSettings) do
		if Viks[group] then
			local count = 0
			for option,value in pairs(options) do
				if Viks[group][option] ~= nil then
					if Viks[group][option] == value then
						ViksConfigSettings[group][option] = nil	
					else
						count = count+1
						Viks[group][option] = value
					end
				end
			end
			-- keeps ViksConfig clean and small
			if count == 0 then ViksConfigSettings[group] = nil end
		else
			ViksConfigSettings[group] = nil
		end
	end
end

--]]