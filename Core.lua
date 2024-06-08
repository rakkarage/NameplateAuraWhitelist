-- TTOM = CreateFrame("Frame")
-- TTOM.name = "TTOM"
-- TTOM.notes = "ToolTip On Mouse"
-- TTOM.defaults = {x = "32", y = "-32", anchor = "TOPLEFT"}
-- TTOM.tooltips = {}

-- function TTOM:OnEvent(event, ...)
-- 	self[event](self, event, ...)
-- end
-- TTOM:SetScript("OnEvent", TTOM.OnEvent)
-- TTOM:RegisterEvent("ADDON_LOADED")

-- function TTOM:ADDON_LOADED(event, name)
-- 	if name == TTOM.name then
-- 		TTOMDB = TTOMDB or {}
-- 		for key, value in pairs(self.defaults) do
-- 			if not TTOMDB[key] then
-- 				TTOMDB[key] = value
-- 			end
-- 		end
-- 		self:InitializeOptions()
-- 		self:UnregisterEvent(event)
-- 	end
-- end

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
		((aura.nameplateShowPersonal or whitelist[aura.name]) and
		(aura.sourceUnit == "player" or aura.sourceUnit == "pet" or aura.sourceUnit == "vehicle"))
end

local function Mixin(baseFrame)
	baseFrame.UnitFrame.BuffFrame.ShouldShowBuff = newShouldShowBuff
end

NAW = CreateFrame("Frame")
NAW:RegisterEvent("NAME_PLATE_UNIT_ADDED")
NAW:SetScript("OnEvent", function(_, _, unitId) Mixin(C_NamePlate.GetNamePlateForUnit(unitId)) end)
-- self:InitializeOptions()

for _, baseFrame in pairs(C_NamePlate.GetNamePlates()) do
	Mixin(baseFrame)
end
