local E, L, V, P, G = unpack(ElvUI)
local mod = E:NewModule("Enhanced_ActionBars")
local LAB = LibStub("LibActionButton-1.0")

function mod:LAB_ButtonUpdate(button)
	local color = E.db.enhanced.actionbars.equippedColor

	if button.backdrop then
		if button:IsEquipped() then
			button.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			button.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end
	end
end

function mod:UpdateCallback()
	if E.db.enhanced.actionbars.equipped then
		LAB.RegisterCallback(self, "OnButtonUpdate", self.LAB_ButtonUpdate)
	else
		for _, bar in pairs(E:GetModule("ActionBars").handledBars) do
			for _, button in pairs(bar.buttons) do
				if button:IsEquipped() then
					button.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
				end
			end
		end

		LAB.UnregisterAllCallbacks(self)
	end
end

function mod:Initialize()
	self:UpdateCallback()
end

local function InitializeCallback()
	mod:Initialize()
end

E:RegisterModule(mod:GetName(), InitializeCallback) 