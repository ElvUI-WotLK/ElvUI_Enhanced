local E, L, V, P, G = unpack(ElvUI);
local NP = E:GetModule("NamePlates");
local LSM = LibStub("LibSharedMedia-3.0");

local format = string.format;
local twipe = table.wipe;

local UnitCanAttack, UnitDetailedThreatSituation, GetThreatStatusColor = UnitCanAttack, UnitDetailedThreatSituation, GetThreatStatusColor;
local GetNumRaidMembers, GetNumPartyMembers = GetNumRaidMembers, GetNumPartyMembers;
local UnitGUID, UnitName = UnitGUID, UnitName;

local rosterTimer;

function Hex(r, g, b)
	return format("|cFF%02x%02x%02x", r * 255, g * 255, b * 255);
end

NP.GroupMembers = {};

hooksecurefunc(NP, "CreatePlate", function(self, frame)
	if(not frame.threatInfo) then
		frame.threatInfo = frame.HealthBar:CreateFontString(nil, "OVERLAY");
		frame.threatInfo:SetPoint("BOTTOMLEFT", frame.HealthBar, "BOTTOMLEFT", 1, 2);
		frame.threatInfo:SetJustifyH("LEFT");
	end
	if(not frame.targetCount) then
		frame.targetCount = frame.HealthBar:CreateFontString(nil, "OVERLAY");
		frame.targetCount:SetPoint("BOTTOMRIGHT", frame.HealthBar, "BOTTOMRIGHT", 1, 2);
		frame.targetCount:SetJustifyH("RIGHT");
	end
	frame.threatInfo:FontTemplate(LSM:Fetch("font", NP.db.font), NP.db.fontSize, NP.db.fontOutline);
	frame.targetCount:FontTemplate(LSM:Fetch("font", NP.db.font), NP.db.fontSize, NP.db.fontOutline);
end);

hooksecurefunc(NP, "GetThreatReaction", function(self, frame)
	if(frame.threatInfo) then
		frame.threatInfo:SetText();

		if(NP.db.showthreat) then
			local unit = frame.unit;
			if(not unit) then
				for i = 1, 4 do
					if(frame.guid == UnitGUID(("boss%d"):format(i))) then
						unit = ("boss%d"):format(i);
						break;
					end
				end
			end

			if(unit and not UnitIsPlayer(unit) and UnitCanAttack("player", unit)) then
				local status, percent = select(2, UnitDetailedThreatSituation("player", unit));
				if(status) then
					frame.threatInfo:SetFormattedText("%s%.0f%%|r", Hex(GetThreatStatusColor(status)), percent);
				else
					frame.threatInfo:SetFormattedText("|cFF808080%s|r", L["None"]);
				end
			end
		end
	end

	if(NP.db.targetcount and frame.targetCount) then
		frame.targetCount:SetText();
		if(frame.guid) then
			local targetCount = 0;
			local target;
			for name, unitid in pairs(NP.GroupMembers) do
				target = ("%starget"):format(unitid);
				if(UnitExists(target) and UnitGUID(target) == frame.guid) then
					targetCount = targetCount + 1;
				end
			end

			if not (targetCount == 0) then
				frame.targetCount:SetText(("[%d]"):format(targetCount));
			end
		end	
	end
end);

function NP:AddToRoster(unitId)
	local unitName = UnitName(unitId);
	if(unitName) then
		self.GroupMembers[unitName] = unitId;
	end
end

function NP:UpdateRoster()
	twipe(self.GroupMembers);

	local numParty, numRaid = GetNumPartyMembers(), GetNumRaidMembers();
	if(numRaid > 0) then
		for index = 1, numRaid do
			self:AddToRoster("raid" .. index);
		end
	else
		self:AddToRoster("player");
	end
end

function NP:StartRosterUpdate()
	if(not rosterTimer or NP:TimeLeft(rosterTimer) == 0) then
		rosterTimer = NP:ScheduleTimer("UpdateRoster", 1);
	end
end

NP:RegisterEvent("PARTY_MEMBERS_CHANGED", "StartRosterUpdate");
NP:RegisterEvent("RAID_ROSTER_UPDATE", "StartRosterUpdate");