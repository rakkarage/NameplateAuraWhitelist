local whitelist = {
	["Shadow Word: Pain"] = "player",
	["Mind Soothe"] = "all",
	-- warrior
	["Rend"] = true,
	["Punish"] = true,
	["Thunderous Roar"] = true,
	["Charge"] = true,
	["Intimidating Shout"] = true,
	["Demoralizing Shout"] = true,
	["Shockwave"] = true,
	["Storm Bolt"] = true,
	["Taunt"] = true,
	["Hamstring"] = true,
	["Spear of Bastion"] = true,
	-- hunter
	["Barbed Shot"] = true,
	["Hunter's Mark"] = true,
	["Death Chakram"] = true,
	["Growl"] = true,
	["Intimidation"] = true,
	["Binding Shot"] = true,
	["Tar Trap"] = true,
	["Freezing Trap"] = true,
	["Wing Clip"] = true,
}

local function newShouldShowBuff(_, aura, forceAll)
	if (not aura or not aura.name) then
		return false
	end
	return aura.nameplateShowAll or forceAll or
			((aura.nameplateShowPersonal or whitelist[aura.name]) and (aura.sourceUnit == "player" or aura.sourceUnit == "pet" or aura.sourceUnit == "vehicle"))
end

local function Mixin(baseFrame)
	baseFrame.UnitFrame.BuffFrame.ShouldShowBuff = newShouldShowBuff
end

local f = CreateFrame("Frame")
	f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	f:SetScript("OnEvent", function(_, _, unitId) Mixin(C_NamePlate.GetNamePlateForUnit(unitId))
end)

for _, baseFrame in pairs(C_NamePlate.GetNamePlates()) do
	Mixin(baseFrame)
end
