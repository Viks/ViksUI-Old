local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ViksUI fonts configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- Viks["font"] = {
--		-- Stats font
--		["stats_font"] = "Interface\\AddOns\\ViksUI\\Media\\Fonts\\Normal.ttf",
-- 		["stats_font_size"] = 11,
--		["stats_font_style"] = "",
--		["stats_font_shadow"] = true,
-- }
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Fonts options
----------------------------------------------------------------------------------------
Viks["font"] = {
	-- Stats font
	["stats_font"] = Viks.media.pxfont,
	["stats_font_size"] = 8,
	["stats_font_style"] = "OUTLINEMONOCHROME",
	["stats_font_shadow"] = false,

	-- Combat text font
	["combat_text_font"] = Viks.media.pxfont,
	["combat_text_font_size"] = 16,
	["combat_text_font_style"] = "OUTLINEMONOCHROME",
	["combat_text_font_shadow"] = false,

	-- Chat font
	["chat_font"] = Viks.media.font,
	["chat_font_style"] = "",
	["chat_font_shadow"] = true,

	-- Chat tabs font
	["chat_tabs_font"] = Viks.media.pxfont,
	["chat_tabs_font_size"] = 8,
	["chat_tabs_font_style"] = "OUTLINEMONOCHROME",
	["chat_tabs_font_shadow"] = false,

	-- Action bars font
	["action_bars_font"] = Viks.media.pxfont,
	["action_bars_font_size"] = 8,
	["action_bars_font_style"] = "OUTLINEMONOCHROME",
	["action_bars_font_shadow"] = false,

	-- Threat meter font
	["threat_meter_font"] = Viks.media.pxfont,
	["threat_meter_font_size"] = 8,
	["threat_meter_font_style"] = "OUTLINEMONOCHROME",
	["threat_meter_font_shadow"] = false,

	-- Raid cooldowns font
	["raid_cooldowns_font"] = Viks.media.pxfont,
	["raid_cooldowns_font_size"] = 8,
	["raid_cooldowns_font_style"] = "OUTLINEMONOCHROME",
	["raid_cooldowns_font_shadow"] = false,

	-- Cooldowns timer font
	["cooldown_timers_font"] = Viks.media.pxfont,
	["cooldown_timers_font_size"] = 16,
	["cooldown_timers_font_style"] = "OUTLINEMONOCHROME",
	["cooldown_timers_font_shadow"] = false,

	-- Loot font
	["loot_font"] = Viks.media.pxfont,
	["loot_font_size"] = 8,
	["loot_font_style"] = "OUTLINEMONOCHROME",
	["loot_font_shadow"] = false,

	-- Nameplates font
	["nameplates_font"] = Viks.media.pxfont,
	["nameplates_font_size"] = 8,
	["nameplates_font_style"] = "OUTLINEMONOCHROME",
	["nameplates_font_shadow"] = false,

	-- Unit frames font
	["unit_frames_font"] = Viks.media.pxfont,
	["unit_frames_font_size"] = 8,
	["unit_frames_font_style"] = "OUTLINEMONOCHROME",
	["unit_frames_font_shadow"] = false,

	-- Auras font
	["auras_font"] = Viks.media.pxfont,
	["auras_font_size"] = 8,
	["auras_font_style"] = "OUTLINEMONOCHROME",
	["auras_font_shadow"] = false,

	-- Filger font
	["filger_font"] = Viks.media.pxfont,
	["filger_font_size"] = 8,
	["filger_font_style"] = "OUTLINEMONOCHROME",
	["filger_font_shadow"] = false,

	-- Stylization font
	["stylization_font"] = Viks.media.pxfont,
	["stylization_font_size"] = 8,
	["stylization_font_style"] = "OUTLINEMONOCHROME",
	["stylization_font_shadow"] = false,

	-- Bags font
	["bags_font"] = Viks.media.pxfont,
	["bags_font_size"] = 8,
	["bags_font_style"] = "OUTLINEMONOCHROME",
	["bags_font_shadow"] = false,
}