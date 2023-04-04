local whitelist = {
    ["Shadow Word: Pain"] = "player",
    ["Mind Soothe"] = "all",
}

local function newShouldShowBuff(_, name, caster)
    return name and caster and (whitelist[name] == caster or whitelist[name] == "all")
end

local function Mixin(baseFrame)
    baseFrame.UnitFrame.BuffFrame.ShouldShowBuff = newShouldShowBuff
end

local f = CreateFrame("Frame")
    f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    f:SetScript("OnEvent", function(_,_,unitId)

    Mixin(C_NamePlate.GetNamePlateForUnit(unitId))
end)

for _,baseFrame in pairs(C_NamePlate.GetNamePlates()) do
    Mixin(baseFrame)
end
