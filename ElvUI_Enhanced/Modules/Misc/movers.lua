local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local _G = _G
local pairs = pairs

function M:UpdateMoverTransparancy()
	local mover

	for name in pairs(E.CreatedMovers) do
		mover = _G[name]

		if mover then
			mover:SetAlpha(E.db.enhanced.general.moverTransparancy)
		end
	end
end

function M:LoadMoverTransparancy()
	hooksecurefunc(E, "CreateMover", function(_, parent)
		if parent.mover then
			parent.mover:SetAlpha(E.db.enhanced.general.moverTransparancy)
		end
	end)

	self:UpdateMoverTransparancy()
end