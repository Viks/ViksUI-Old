local T, Viks, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ViksUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = UnitName("player")
_, T.class = UnitClass("player")
_, T.race = UnitRace("player")
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("ViksUI", "Version")
T.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
T.Resolution = GetCVar("gxResolution")
T.ScreenHeight = tonumber(string.match(T.Resolution, "%d+x(%d+)"))
T.ScreenWidth = tonumber(string.match(T.Resolution, "(%d+)x+%d"))
