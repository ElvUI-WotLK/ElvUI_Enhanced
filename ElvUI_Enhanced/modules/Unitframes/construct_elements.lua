local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

function UF:EnhanceUpdateRoleIcon()
	local frameGroups = {5, 25, 40}
	local frame

	for _, index in ipairs(frameGroups) do
		for i = 1, (index/5) do
			for j = 1, 5 do
				frame = (index == 5 and _G[("ElvUF_PartyGroup%dUnitButton%i"):format(i, j)] or index == 25 and _G[("ElvUF_RaidGroup%dUnitButton%i"):format(i, j)] or _G[("ElvUF_Raid%dGroup%dUnitButton%i"):format(index, i, j)])
				if(frame) then
					UF:UpdateRoleIconFrame(frame, ((index == 5 and "party%d" or index == 25 and "raid" or "raid%d")):format(i))
				end
			end
		end
	end

	UF:UpdateAllHeaders()
end

function UF:UpdateRoleIconFrame(frame)
	if not frame then return end
	if not frame.LFDRole then return end

	if(E.db.enhanced.unitframe.hideRoleInCombat) then
		RegisterStateDriver(frame.LFDRole:GetParent(), "visibility", "[combat]hideshow")
	end
end

function UF:ApplyUnitFrameEnhancements()
	self:EnhanceUpdateRoleIcon()
end

local CF = CreateFrame("Frame")
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if not E.private["unitframe"].enable then return end

	UF:ApplyUnitFrameEnhancements()
end)
