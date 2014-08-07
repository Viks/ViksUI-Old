--[[
local T, Viks, L = unpack(select(2, ...))

C["media"] = {
	-- fonts (ENGLISH, SPANISH)
	["font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], -- general font of tukui
	["uffont"] = [[Interface\AddOns\Tukui\medias\fonts\Hooge\HOOG0555.ttf]], -- general font of unitframes
	["uffontsize"] = 14,
	["uffontflags"] = "MONOCHROMEOUTLINE",
	["dmgfont"] = [[Interface\AddOns\Tukui\medias\fonts\combat_font.ttf]], -- general font of dmg / sct
	
	-- fonts (DEUTSCH)
	["de_font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], -- general font of tukui
	["de_uffont"] = [[Interface\AddOns\Tukui\medias\fonts\uf_font.ttf]], -- general font of unitframes
	["de_dmgfont"] = [[Interface\AddOns\Tukui\medias\fonts\combat_font.ttf]], -- general font of dmg / sct
	
	-- fonts (FRENCH)
	["fr_font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], -- general font of tukui
	["fr_uffont"] = [[Interface\AddOns\Tukui\medias\fonts\uf_font.ttf]], -- general font of unitframes
	["fr_dmgfont"] = [=[Interface\AddOns\Tukui\medias\fonts\combat_font.ttf]=], -- general font of dmg / sct
	
	-- fonts (RUSSIAN)
	["ru_font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], -- general font of tukui
	["ru_uffont"] = [[Fonts\ARIALN.TTF]], -- general font of unitframes
	["ru_dmgfont"] = [[Fonts\ARIALN.TTF]], -- general font of dmg / sct
	
	-- fonts (TAIWAN ONLY)
	["tw_font"] = [=[Fonts\bLEI00D.ttf]=], -- general font of tukui
	["tw_uffont"] = [[Fonts\bLEI00D.ttf]], -- general font of unitframes
	["tw_dmgfont"] = [[Fonts\bLEI00D.ttf]], -- general font of dmg / sct
	
	-- fonts (KOREAN ONLY)
	["kr_font"] = [=[Fonts\2002.TTF]=], -- general font of tukui
	["kr_uffont"] = [[Fonts\2002.TTF]], -- general font of unitframes
	["kr_dmgfont"] = [[Fonts\2002.TTF]], -- general font of dmg / sct
	
	-- textures
	["normTex"] = [[Interface\AddOns\Tukui\medias\textures\normTex]], -- texture used for tukui layout healthbar/powerbar/etc
	["glowTex"] = [[Interface\AddOns\Tukui\medias\textures\glowTex]], -- the glow text around some frame.
	["bubbleTex"] = [[Interface\AddOns\Tukui\medias\textures\bubbleTex]], -- unitframes combo points
	["copyicon"] = [[Interface\AddOns\Tukui\medias\textures\copy]], -- copy icon
	["blank"] = [[Interface\AddOns\Tukui\medias\textures\blank]], -- the main texture for all borders/panels
	["bordercolor"] = { .15,.15,.15 }, -- border color of tukui panels
	["backdropcolor"] = { .05,.05,.05 }, -- background color of tukui panels
	["buttonhover"] = [[Interface\AddOns\Tukui\medias\textures\button_hover]],
	
	-- sound
	["whisper"] = [[Interface\AddOns\Tukui\medias\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\Tukui\medias\sounds\warning.mp3]],
}

if Viks.unitframes.layout == "Smelly" then
	Viks.media.uffont = [[Interface\Addons\Tukui\medias\fonts\homespun.TTF]]
	Viks.media.uffontsize = 14
	Viks.media.normTex = [[Interface\AddOns\Tukui\medias\textures\smellyTex]]
end

if Viks.unitframes.layout == "Surgency" or Viks.unitframes.layout == "Slim" then
	Viks.media.normTex = [[Interface\AddOns\Tukui\medias\textures\blank]]
	Viks.media.uffont = [[Interface\Addons\Tukui\medias\fonts\visitor.TTF]]
	Viks.media.uffontsize = 14
end

if Viks.general.alternateFont == true then 
	Viks.media.uffont = [[Interface\Addons\Tukui\medias\fonts\SEMPRG__.TTF]] -- general font of unitframes
end
--]]