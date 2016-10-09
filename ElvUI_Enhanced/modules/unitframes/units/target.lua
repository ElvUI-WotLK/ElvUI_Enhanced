local E, L, V, P, G = unpack(ElvUI);
local UF = E:GetModule("UnitFrames");

hooksecurefunc(UF, "Update_TargetFrame", function(self, frame, db)
	local gps = frame.gps;
	if(not gps) then return; end

	if(db.gps.enable) then
		local x, y = UF:GetPositionOffset(db.gps.position);
		gps:ClearAllPoints();
		gps:Point(db.gps.position, frame.Health, db.gps.position, x, y);
		gps:SetFrameStrata("MEDIUM");
		gps:Show();

		gps.timer = UF:ScheduleRepeatingTimer("UpdateGPS", 0.1, frame);
	else
		if(gps.timer) then
			UF:CancelTimer(gps.timer);
			gps.timer = nil;
		end
		gps:Hide();
	end
end);
