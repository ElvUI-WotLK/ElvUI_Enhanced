local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	S:SearchBoxTemplate(BrowseName)
end

S:AddCallbackForAddon("Blizzard_AuctionUI", "Enhanced_AuctionUI", LoadSkin)