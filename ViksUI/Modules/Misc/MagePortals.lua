local T, Viks, L, _ = unpack(select(2, ...))
if T.class ~= "MAGE" or T.level < 17 then return end

----------------------------------------------------------------------------------------
--	Mage portals menu(by Foof and Tohveli)
----------------------------------------------------------------------------------------
local spells = (UnitFactionGroup("player") == "Horde") and {
	[1] = {3567,11417},		-- Orgrimmar
	[2] = {3563,11418},		-- Undercity
	[3] = {3566,11420},		-- Thunder Bluff
	[4] = {32272,32267},	-- Silvermoon
	[5] = {49358,49361},	-- Stonard
	[6] = {35715,35717},	-- Shattrath
	[7] = {53140,53142},	-- Dalaran
	[8] = {88344,88346},	-- Tol Barad
	[9] = {132627,132626},	-- Vale of Eternal Blossoms
} or { -- Alliance
	[1] = {3561,10059},		-- Stormwind
	[2] = {3562,11416},		-- Ironforge
	[3] = {3565,11419},		-- Darnassus
	[4] = {32271,32266},	-- Exodar
	[5] = {49359,49360},	-- Theramore
	[6] = {33690,33691},	-- Shattrath
	[7] = {53140,53142},	-- Dalaran
	[8] = {88342,88345},	-- Tol Barad
	[9] = {132621,132620},	-- Vale of Eternal Blossoms
}

if IsSpellKnown(120145) then
	tinsert(spells, {120145,120146}) -- Ancient Dalaran
end
local frame = CreateFrame("Frame", "TeleportMenu", UIParent)
frame:CreatePanel("Invisible", Viks.minimapp.size, (#spells) * 20 + 4, "BOTTOMLEFT", RChatTab, "TOPLEFT", -2, 3)
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)
frame:Hide()
tinsert(UISpecialFrames, "TeleportMenu")

for i, spell in pairs(spells) do
	local teleport = GetSpellInfo(spell[1])

	local b = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	b:CreatePanel("Transparent", Viks.minimapp.size, 20, "BOTTOMLEFT", frame, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	b:SetFrameStrata("HIGH")

	local l = b:CreateFontString(nil, "OVERLAY")
	l:SetFont(Viks.media.pxfont, Viks.media.fontsize, Viks.media.pxfontFlag)
	l:SetText(string.sub(teleport, string.find(teleport, ":") + 1))
	b:SetFontString(l)

	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", teleport)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
end

local button = CreateFrame("Button", nil, UIParent)
button:SetTemplate("ClassColor")
button:SetPoint("TOPLEFT", RChatTab, "TOPLEFT")
button:SetSize(20, 20)
button:SetAlpha(1)

button.t = button:CreateTexture(nil, "OVERLAY")
button.t:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
button.t:SetPoint("TOPLEFT", button, 2, -2)
button.t:SetPoint("BOTTOMRIGHT", button, -2, 2)

button:SetScript("OnClick", function(self)
	if not InCombatLockdown() then
		if _G["TeleportMenu"]:IsShown() then
			_G["TeleportMenu"]:Hide()
		else
			_G["TeleportMenu"]:Show()
		end
		if Viks.minimapp.toggle_menu and _G["TTMenuAddOnBackground"]:IsShown() then
			_G["TTMenuAddOnBackground"]:Hide()
		end
		if Viks.minimapp.toggle_menu and _G["TTMenuBackground"]:IsShown() then
			_G["TTMenuBackground"]:Hide()
		end
	end
end)

button:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	button:FadeIn()
end)

button:SetScript("OnLeave", function()
	button:FadeOut()
end)