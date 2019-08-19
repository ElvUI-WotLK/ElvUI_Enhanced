local E, L, V, P, G = unpack(ElvUI)
local mod = E:NewModule("Enhanced_Blizzard", "AceHook-3.0", "AceEvent-3.0")

function mod:Initialize()
	if E.private.enhanced.blizzard.deathRecap then
		self:DeathRecap()
	end

	self:AddonList()
	self:DressUpFrame()
end

local function InitializeCallback()
	mod:Initialize()
end

E:RegisterModule(mod:GetName(), InitializeCallback)