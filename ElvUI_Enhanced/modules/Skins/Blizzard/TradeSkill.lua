local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	S:SearchBoxTemplate(TradeSkillFrameEditBox)
end

S:AddCallbackForAddon("Blizzard_TradeSkillUI", "Enhanced_TradeSkillUI", LoadSkin)