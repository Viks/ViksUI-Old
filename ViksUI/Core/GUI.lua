local T, Viks, L, _ = unpack(select(2, ...))
if not IsAddOnLoaded("Viks_ConfigUI") then return end

----------------------------------------------------------------------------------------
--	This Module loads new user settings if ViksUI_Config is loaded
----------------------------------------------------------------------------------------
if not ViksConfigAll then ViksConfigAll = {} end
if ViksConfigAll[T.realm] == nil then ViksConfigAll[T.realm] = {} end
if ViksConfigAll[T.realm][T.name] == nil then ViksConfigAll[T.realm][T.name] = false end

if ViksConfigAll[T.realm][T.name] == true and not ViksConfig then return end
if ViksConfigAll[T.realm][T.name] == false and not ViksConfigSettings then return end

if ViksConfigAll[T.realm][T.name] == true then
	for group, options in pairs(ViksConfig) do
		if Viks[group] then
			local count = 0
			for option, value in pairs(options) do
				if Viks[group][option] ~= nil then
					if Viks[group][option] == value then
						ViksConfig[group][option] = nil
					else
						count = count + 1
						Viks[group][option] = value
					end
				end
			end
			if count == 0 then ViksConfig[group] = nil end
		else
			ViksConfig[group] = nil
		end
	end
else
	for group, options in pairs(ViksConfigSettings) do
		if Viks[group] then
			local count = 0
			for option, value in pairs(options) do
				if Viks[group][option] ~= nil then
					if Viks[group][option] == value then
						ViksConfigSettings[group][option] = nil
					else
						count = count + 1
						Viks[group][option] = value
					end
				end
			end
			if count == 0 then ViksConfigSettings[group] = nil end
		else
			ViksConfigSettings[group] = nil
		end
	end
end