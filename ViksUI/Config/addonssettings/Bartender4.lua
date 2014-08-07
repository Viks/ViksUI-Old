local T, Viks, L, _ = unpack(select(2, ...))

function ViksUI:InstallBartender4()
	if not IsAddOnLoaded("Bartender4") then return end
	
		_G.MUI_Bartender4_Install = {
			["namespaces"] = {
				["ActionBars"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["actionbars"] = {
								{
									["showgrid"] = true,
									["version"] = 3,
									["position"] = {
										["y"] = 125,
										["x"] = -265.5,
										["point"] = "BOTTOM",
									},
									["padding"] = 8,
								}, -- [1]
								{
									["showgrid"] = true,
									["version"] = 3,
									["fadeoutalpha"] = 0.3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 82,
										["x"] = -265.5,
										["point"] = "BOTTOM",
									},
									["padding"] = 8,
									["states"] = {
										["enabled"] = true,
										["default"] = 2,
									},
								}, -- [2]
								{
									["showgrid"] = true,
									["alpha"] = 0.5,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 116.5,
										["x"] = 0.4,
										["point"] = "LEFT",
										["scale"] = 0.8,
									},
									["padding"] = 9,
								}, -- [3]
								{
									["showgrid"] = true,
									["alpha"] = 0.5,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 82,
										["x"] = 0.4,
										["point"] = "LEFT",
										["scale"] = 0.8,
									},
									["padding"] = 9,
								}, -- [4]
								{
									["showgrid"] = true,
									["rows"] = 2,
									["buttons"] = 6,
									["hidemacrotext"] = true,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 113,
										["x"] = 279,
										["point"] = "BOTTOM",
										["scale"] = 0.75,
									},
									["padding"] = 3,
								}, -- [5]
								{
									["showgrid"] = true,
									["rows"] = 12,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 201.4,
										["x"] = -35,
										["point"] = "RIGHT",
										["scale"] = 0.76,
									},
									["padding"] = 8,
								}, -- [6]
								{
									["showgrid"] = true,
									["rows"] = 6,
									["enabled"] = true,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 144.5,
										["x"] = 351.5,
										["point"] = "CENTER",
									},
									["padding"] = 11,
									["visibility"] = {
										["custom"] = false,
										["customdata"] = "[mod:ctrl]show;hide",
									},
								}, -- [7]
								{
									["showgrid"] = true,
									["rows"] = 2,
									["enabled"] = true,
									["buttons"] = 6,
									["hidemacrotext"] = true,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 112.5,
										["x"] = -372,
										["point"] = "BOTTOM",
										["scale"] = 0.75,
									},
									["padding"] = 3,
								}, -- [8]
								{
									["showgrid"] = true,
									["rows"] = 6,
									["enabled"] = true,
									["buttons"] = 6,
									["hidemacrotext"] = true,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 180,
										["x"] = 624,
										["point"] = "BOTTOM",
										["scale"] = 0.7,
									},
									["padding"] = 6,
								}, -- [9]
								{
									["showgrid"] = true,
									["rows"] = 7,
									["enabled"] = true,
									["buttons"] = 6,
									["hidemacrotext"] = true,
									["version"] = 3,
									["skin"] = {
										["ID"] = "ViksUI: Buffs",
										["Backdrop"] = false,
									},
									["position"] = {
										["y"] = 180,
										["x"] = -654.5,
										["point"] = "BOTTOM",
										["scale"] = 0.7,
									},
									["padding"] = 6,
								}, -- [10]
							},
						},
					},
				},
				["LibDualSpec-1.0"] = {
				},
				["ExtraActionBar"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["position"] = {
								["y"] = 47,
								["x"] = 5.3,
								["point"] = "CENTER",
								["scale"] = 1.5,
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
						},
					},
				},
				["MicroMenu"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["version"] = 3,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl-Shift]show;hide",
							},
							["position"] = {
								["y"] = 222,
								["x"] = -306,
								["point"] = "BOTTOMRIGHT",
							},
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
						},
					},
				},
				["XPBar"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["position"] = {
								["y"] = 57,
								["x"] = -516,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
						},
					},
				},
				["MultiCast"] = {
					["profiles"] = {
						["ViksUI"] = {
							["enabled"] = false,
							["version"] = 3,
							["position"] = {
								["y"] = 35.00000266710234,
								["x"] = 284.3334044788581,
								["point"] = "BOTTOMLEFT",
							},
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
						},
					},
				},
				["BlizzardArt"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["position"] = {
								["y"] = 47,
								["x"] = -512,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
						},
					},
				},
				["BagBar"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["enabled"] = false,
							["onebag"] = true,
							["position"] = {
								["y"] = 41.75,
								["x"] = 463.5,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
						},
					},
				},
				["Vehicle"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["version"] = 3,
							["position"] = {
								["y"] = 24.5,
								["x"] = -170.5,
								["point"] = "RIGHT",
							},
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
						},
					},
				},
				["StanceBar"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["version"] = 3,
							["position"] = {
								["y"] = 209,
								["x"] = 335,
								["point"] = "BOTTOMLEFT",
								["scale"] = 0.75,
							},
							["padding"] = 7,
							["visibility"] = {
								["custom"] = false,
								["possess"] = false,
								["always"] = false,
								["customdata"] = "[mod:ctrl]show;hide",
								["stance"] = {
									false, -- [1]
								},
							},
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
						},
					},
				},
				["PetBar"] = {
					["profiles"] = {						
						["ViksUI"] = {
							["position"] = {
								["y"] = 43.45603810374087,
								["x"] = -133.2001136303006,
								["point"] = "BOTTOM",
								["scale"] = 0.6000000238418579,
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "ViksUI: Buffs",
								["Backdrop"] = false,
							},
							["fadeoutdelay"] = 0.1,
							["padding"] = 15,
							["visibility"] = {
								["possess"] = false,
								["always"] = false,
							},
							["fadeoutalpha"] = 1,
						},
					},	
				},
				["RepBar"] = {
					["profiles"] = {						
						["ViksUI"] = {
						["position"] = {
							["y"] = 65,
							["x"] = -516,
							["point"] = "BOTTOM",
						},
						["version"] = 3,
						},
					},
				},
			},
			["profiles"] = {
				["ViksUI"] = {
					["onkeydown"] = true,
					["selfcastmodifier"] = false,
					["minimapIcon"] = {
						["hide"] = true,
					},
					["buttonlock"] = true,
				},
			},
		}
		
	for k,v in pairs(MUI_Bartender4_Install) do
		Bartender4DB[k] = v
	end
	end
end