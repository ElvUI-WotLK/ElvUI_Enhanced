local E, L, V, P, G = unpack(ElvUI);
local M = E:GetModule("MiscEnh");

function M:UpdateMoverTransparancy()
	local mover;
	for name, _ in pairs(E.CreatedMovers) do
		mover = _G[name];
		if(mover) then
			mover:SetAlpha(E.db.general.movertransparancy);
		end
	end
end

function M:LoadMoverTransparancy()
	hooksecurefunc(E, "CreateMover", function(_, parent)
		parent.mover:SetAlpha(E.db.general.movertransparancy);
	end);

	self:UpdateMoverTransparancy();
end