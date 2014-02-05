local frame, events = CreateFrame("Frame"), {};

function events:UNIT_POWER(...)
 local curr_power = UnitPower("player")
 local power_regen, OOC_regen = GetPowerRegen()

 local start, cdTimeLeft, enable = GetSpellCooldown("Keg Smash")
 local kegSmashCost = select(4, GetSpellInfo("Keg Smash"))
 local jabCost = select(4, GetSpellInfo("Jab"))

 if cdTimeLeft > 0 then
 	-- Do all your calculations here!
 	if curr_power + jabCost + power_regen * cdTimeLeft >= kegSmashCost
 		-- Rejoice! Have another jab
 	elseif curr_power + power_regen * cdTimeLeft >= kegSmashCost
 		-- Hold off on that jab bro.
 	else
 		-- You're in trouble, you done goof'd, you messed up, *WOMP WOMP*
 	end
 else
 	-- Still good, make sure to handle this case
 end
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end