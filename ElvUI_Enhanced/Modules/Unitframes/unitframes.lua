local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

hooksecurefunc(UF, "Configure_Portrait", function(self, frame)
	if(frame.unitframeType == "player" or frame.unitframeType == "target") then
		frame.PORTRAIT_DETACHED = frame.USE_PORTRAIT and frame.db.portrait.detachFromFrame and not frame.USE_PORTRAIT_OVERLAY
		frame.PORTRAIT_WIDTH = (frame.USE_PORTRAIT_OVERLAY or frame.PORTRAIT_DETACHED or not frame.USE_PORTRAIT) and 0 or frame.db.portrait.width
		frame.CLASSBAR_WIDTH = frame.UNIT_WIDTH - ((frame.BORDER+frame.SPACING)*2) - frame.PORTRAIT_WIDTH - frame.POWERBAR_OFFSET

		if(frame.USE_PORTRAIT) then
			local portrait = frame.Portrait
			if(frame.PORTRAIT_DETACHED and frame.db.portrait.style == "3D") then
				if(not portrait.Holder or (portrait.Holder and not portrait.Holder.mover)) then
					portrait.Holder = CreateFrame("Frame", nil, UIParent)
					portrait.Holder:Size(frame.db.portrait.detachedWidth, frame.db.portrait.detachedHeight)

					if(frame.ORIENTATION == "LEFT") then
						portrait.Holder:Point("RIGHT", frame, "LEFT", -frame.BORDER, 0)
					elseif(frame.ORIENTATION == "RIGHT") then
						portrait.Holder:Point("LEFT", frame, "RIGHT", frame.BORDER, 0)
					end

					portrait:SetInside(portrait.Holder)
					portrait.backdrop:SetOutside(portrait)

					if(frame.unitframeType == "player") then
						E:CreateMover(portrait.Holder, "PlayerPortraitMover", L["Player Portrait"], nil, nil, nil, "ALL,SOLO")
					elseif(frame.unitframeType == "target") then
						E:CreateMover(portrait.Holder, "TargetPortraitMover", L["Target Portrait"], nil, nil, nil, "ALL,SOLO")
					end
				else
					portrait.Holder:Size(frame.db.portrait.detachedWidth, frame.db.portrait.detachedHeight)
					portrait:SetInside(portrait.Holder)
					portrait.backdrop:SetOutside(portrait)
					E:EnableMover(portrait.Holder.mover:GetName())
				end
			end

			if(not frame.PORTRAIT_DETACHED) then
				if(portrait.Holder and portrait.Holder.mover) then
					E:DisableMover(portrait.Holder.mover:GetName())
				end
			end

			hooksecurefunc(portrait, "PostUpdate", PortraitUpdate)

			self:Configure_HealthBar(frame)
			self:Configure_Power(frame)
		end
	end
end)

function PortraitUpdate(self, unit, ...)
	local frame = self:GetParent()
	local db = frame.db
	if not db then return end
	local portrait = db.portrait
	if portrait.portraitAlpha ~= nil and portrait.enable and frame.USE_PORTRAIT_OVERLAY then
		self:SetAlpha(0)
		self:SetAlpha(portrait.portraitAlpha)	
	end
	if portrait.higherPortrait and frame.USE_PORTRAIT_OVERLAY then
		if not frame.Health.HigherPortrait then
			frame.Health.HigherPortrait = CreateFrame("Frame", frame:GetName().."HigherPortrait", frame)
			frame.Health.HigherPortrait:SetFrameLevel(frame.Health:GetFrameLevel() + 4)
			frame.Health.HigherPortrait:SetPoint("TOPLEFT", frame.Health, "TOPLEFT")
			frame.Health.HigherPortrait:SetPoint("BOTTOMRIGHT", frame.Health, "BOTTOMRIGHT", 0, 0.5)
		end
		self:ClearAllPoints()
		if frame.db.portrait.style == '3D' then self:SetFrameLevel(frame.Health.HigherPortrait:GetFrameLevel()) end
		self:SetAllPoints(frame.Health.HigherPortrait)
		frame.Health.bg:SetParent(frame.Health)
	end
end