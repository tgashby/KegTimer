local frame, events = CreateFrame("Frame", "KTFrame", UIParent), {};
local backdrop = {
	bgFile = select(3, GetSpellInfo("Keg Smash")),
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = false, 
	tileSize = 0, 
	edgeSize = 10,
	insets = {
		left = 0, 
		right = 0, 
		top = 0, 
		bottom = 0
	}
};

frame:SetBackdrop(backdrop);
frame:Show();
frame:SetPoint("CENTER");
frame:SetSize(64, 64);

frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnDragStart", frame.StartMoving);
frame:SetScript("OnDragStop", frame.StopMovingOrSizing);

function events:UNIT_POWER(...)
 local curr_power = UnitPower("player")
 local inactive_regen, power_regen = GetPowerRegen()

 local start, duration, enable = GetSpellCooldown("Keg Smash")
 local kegSmashCost = select(4, GetSpellInfo("Keg Smash"))
 local jabCost = select(4, GetSpellInfo("Jab"))

 local cdTimeLeft = (start + duration - GetTime());

 if cdTimeLeft > 0 then
 	-- Do all your calculations here!
 	if curr_power + power_regen * cdTimeLeft >= jabCost + kegSmashCost then
 		-- Rejoice! Have another jab
		frame:SetBackdropColor(1, 1, 1, 1);
 	elseif curr_power + power_regen * cdTimeLeft >= kegSmashCost then
 		-- Hold off on that jab bro.
		frame:SetBackdropColor(0.5, 0.5, 0, 1);
 	else
 		-- You're in trouble, you done goof'd, you messed up, *WOMP WOMP*
		frame:SetBackdropColor(0.5, 0, 0, 1);
 	end
 else
 	if curr_power >= kegSmashCost then
		-- Still good, make sure to handle this case
		frame:SetBackdropColor(1, 1, 1, 1);
 	end
 end
end

function events:PLAYER_REGEN_DISABLED( ... )
	frame:Show();
end

function events:PLAYER_REGEN_ENABLED( ... )
	frame:Hide();
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end
