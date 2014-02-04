local frame, events = CreateFrame("Frame"), {};

function events:UNIT_POWER(...)
 local curr_power = UnitPower("player")
 local power_regen, OOC_regen = GetPowerRegen()

 local start, duration, enable = GetSpellCooldown("Keg Smash")
 local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo("Keg Smash")

 if duration > 0
 	-- Do all your calculations here!
 	-- TODO Don't forget jab cost
 	if curr_power + power_regen * duration >= powerCost
 		-- Rejoice!
 	else
 		-- You're in trouble
 	end
 end
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end