local parent, ns = ...
local oUF = ns.oUF or oUF

local classList = {
    ["DRUID"] = {
        combat = GetSpellInfo(20484), -- Rebirth
        ooc = GetSpellInfo(50769), -- Revive    
    },

    ["WARLOCK"] = {
        combat = GetSpellInfo(6203), -- Soulstone
        ooc = GetSpellInfo(6203), -- Soulstone
    },

    ["PRIEST"] = {
        ooc = GetSpellInfo(2006), -- Resurrection
    },

    ["SHAMAN"] = {
        ooc = GetSpellInfo(2008), -- Ancestral Spirit
    },

    ["PALADIN"] = {
        ooc = GetSpellInfo(7328), -- Redemption
    },

    ["DEATHKNIGHT"] = {
        combat = GetSpellInfo(61999), -- Raise Ally
    }
}

local body = ""
local function macroBody(class)
    local combatspell = classList[class].combat
    local oocspell = classList[class].ooc

    body = "/stopmacro [nodead,@mouseover]\n"
    if combatspell then
        body = body .. "/cast [combat,help,dead,@mouseover] " .. combatspell .. "; "

        if oocspell then
            body = body .. "[help,dead,@mouseover] " .. oocspell .. "; "
        end

        if class == "WARLOCK" then
            body = body .. "\n/cast Create Soulstone\n "
        end
    elseif oocspell then
        body = body .. "/cast [help,dead,@mouseover] " .. oocspell .. "; "
    end

    return body
end

local Enable = function(self)
    local _, class = UnitClass("player")
    if not class or not Viks["raidframes"].autorez then return end

    if classList[class] and not IsAddOnLoaded("Clique") then
        self:SetAttribute("*type3", "macro")
        self:SetAttribute("macrotext3", macroBody(class))
    end
end

local Disable = function(self)
    if Viks["raidframes"].autorez then return end

    self:SetAttribute("*type3", nil)
end

oUF:AddElement('freebAutoRez', nil, Enable, Disable)
