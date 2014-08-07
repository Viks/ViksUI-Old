local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Pixel perfect script of custom ui Scale
----------------------------------------------------------------------------------------
T.UIScale = function()
	if T.getscreenwidth <= 1440 then
		T.low_resolution = true
	else
		T.low_resolution = false
	end

	if Viks.general.AutoScale == true then
		Viks.general.UiScale = min(2, max(0.64, 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)")))
	end
end
T.UIScale()

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / Viks.general.UiScale
local Scale = function(x)
	return mult * math.floor(x / mult + 0.5)
end

T.Scale = function(x) return Scale(x) end
T.mult = mult
T.noscalemult = T.mult * Viks.general.UiScale

----------------------------------------------------------------------------------------
--	Pixel perfect fonts function
----------------------------------------------------------------------------------------
if T.getscreenheight <= 1200 then return end
Viks.media.pxfontsize = Viks.media.pxfontsize * mult
Viks.font.chat_tabs_font_size = Viks.font.chat_tabs_font_size * mult
Viks.font.action_bars_font_size = Viks.font.action_bars_font_size * mult
Viks.font.threat_meter_font_size = Viks.font.threat_meter_font_size * mult
Viks.font.raid_cooldowns_font_size = Viks.font.raid_cooldowns_font_size * mult
Viks.font.unit_frames_font_size = Viks.font.unit_frames_font_size * mult
Viks.font.auras_font_size = Viks.font.auras_font_size * mult
Viks.font.filger_font_size = Viks.font.filger_font_size * mult
Viks.font.bags_font_size = Viks.font.bags_font_size * mult
Viks.font.loot_font_size = Viks.font.loot_font_size * mult
Viks.font.combat_text_font_size = Viks.font.combat_text_font_size * mult

Viks.font.stats_font_size = Viks.font.stats_font_size * mult
Viks.font.stylization_font_size = Viks.font.stylization_font_size * mult
Viks.font.cooldown_timers_font_size = Viks.font.cooldown_timers_font_size * mult