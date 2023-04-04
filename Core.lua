local function dumpTable(table, depth)
  	if (depth > 200) then
		print("Error: Depth > 200 in dumpTable()")
	return
  end
  for k,v in pairs(table) do
	if (type(v) == "table") then
		print(string.rep("  ", depth)..k..":")
		dumpTable(v, depth+1)
	else
		print(string.rep("  ", depth)..k..": ",v)
	end
  end
end

local whitelist = {
	["Shadow Word: Pain"] = "player",
	["Mind Soothe"] = "all",
	["Rend"] = true,
	["Punish"] = true,
	["Thunderous Roar"] = true,
	["Charge"] = true,
	["Intimidating Shout"] = true,
}

local function newShouldShowBuff(_, name, caster)
	print(caster)
	return whitelist[name["name"]]
end

local function Mixin(baseFrame)
	baseFrame.UnitFrame.BuffFrame.ShouldShowBuff = newShouldShowBuff
end

local f = CreateFrame("Frame")
	f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	f:SetScript("OnEvent", function(_, _, unitId)

	Mixin(C_NamePlate.GetNamePlateForUnit(unitId))
end)

for _,baseFrame in pairs(C_NamePlate.GetNamePlates()) do
	Mixin(baseFrame)
end
