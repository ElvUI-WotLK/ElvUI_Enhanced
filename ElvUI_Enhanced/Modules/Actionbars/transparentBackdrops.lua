local E, L, V, P, G = unpack(ElvUI)
local ETB = E:NewModule("Enhanced_TransparentBackdrops")

local _G = _G

local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

function ETB:StyleBackdrops()
	local styleBackdrop = E.db.enhanced.actionbars.transparentActionbars.transparentBackdrops and "Transparent" or "Default"
	local styleButtons = E.db.enhanced.actionbars.transparentActionbars.transparentButtons and "Transparent" or "Default"
	local glossTex = styleButtons == "Default"

	local frame

	for i = 1, 10 do
		frame = _G["ElvUI_Bar"..i]
		if frame then
			if frame.backdrop then
				frame.backdrop:SetTemplate(styleBackdrop)
			end

			for j = 1, NUM_ACTIONBAR_BUTTONS do
				frame = _G["ElvUI_Bar"..i.."Button"..j]

				if frame and frame.backdrop then
					frame.backdrop:SetTemplate(styleButtons, glossTex)
				end
			end
		end
	end

	frame = ElvUI_BarPet
	if frame.backdrop then
		frame.backdrop:SetTemplate(styleBackdrop)
	end

	for i = 1, NUM_PET_ACTION_SLOTS do
		frame = _G["PetActionButton"..i]

		if frame and frame.backdrop then
			frame.backdrop:SetTemplate(styleButtons, glossTex)
		end
	end
end

function ETB:Initialize()
	if not (E.private.actionbar.enable and (E.db.enhanced.actionbars.transparentActionbars.transparentBackdrops or E.db.enhanced.actionbars.transparentActionbars.transparentButtons)) then return end

	self:StyleBackdrops()
end

local function InitializeCallback()
	ETB:Initialize()
end

E:RegisterModule(ETB:GetName(), InitializeCallback)