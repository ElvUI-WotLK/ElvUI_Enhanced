local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

hooksecurefunc(UF, "Configure_Portrait", function(self, frame)
	if frame.unitframeType == "player" or frame.unitframeType == "target" then
		local db = E.db.enhanced.unitframe.detachPortrait[frame.unitframeType]

		frame.PORTRAIT_DETACHED = frame.USE_PORTRAIT and db.enable and not frame.USE_PORTRAIT_OVERLAY
		frame.PORTRAIT_WIDTH = (frame.USE_PORTRAIT_OVERLAY or frame.PORTRAIT_DETACHED or not frame.USE_PORTRAIT) and 0 or frame.db.portrait.width
		frame.CLASSBAR_WIDTH = frame.UNIT_WIDTH - (frame.BORDER + frame.SPACING) * 2 - frame.PORTRAIT_WIDTH - frame.POWERBAR_OFFSET

		if frame.USE_PORTRAIT then
			local portrait = frame.Portrait

			if frame.PORTRAIT_DETACHED --[[and frame.db.portrait.style == "3D"]] then
				if not portrait.Holder or (portrait.Holder and not portrait.Holder.mover) then
					portrait.Holder = CreateFrame("Frame", nil, UIParent)
					portrait.Holder:Size(db.width, db.height)

					if frame.ORIENTATION == "LEFT" then
						portrait.Holder:Point("RIGHT", frame, "LEFT", -frame.BORDER, 0)
					elseif frame.ORIENTATION == "RIGHT" then
						portrait.Holder:Point("LEFT", frame, "RIGHT", frame.BORDER, 0)
					end

					portrait:SetInside(portrait.Holder)
					portrait.backdrop:SetOutside(portrait)

					if frame.unitframeType == "player" then
						E:CreateMover(portrait.Holder, "PlayerPortraitMover", L["Player Portrait"], nil, nil, nil, "ALL,SOLO")
					elseif frame.unitframeType == "target" then
						E:CreateMover(portrait.Holder, "TargetPortraitMover", L["Target Portrait"], nil, nil, nil, "ALL,SOLO")
					end
				else
					portrait.Holder:Size(db.width, db.height)
					portrait:SetInside(portrait.Holder)
					portrait.backdrop:SetOutside(portrait)
					E:EnableMover(portrait.Holder.mover:GetName())
				end
			end

			if not frame.PORTRAIT_DETACHED and portrait.Holder and portrait.Holder.mover then
				E:DisableMover(portrait.Holder.mover:GetName())
			end

			self:Configure_HealthBar(frame)
			self:Configure_Power(frame)
		end
	end
end)