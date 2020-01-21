local E, L, V, P, G = unpack(ElvUI)
local mod = E:NewModule("Enhanced_Blizzard", "AceHook-3.0", "AceEvent-3.0")

function mod:Initialize()
	self:DeathRecap()
	self:AddonList()
	self:DressUpFrame()
	self:ErrorFrameSize()
end

local function InitializeCallback()
	mod:Initialize()
end

E:RegisterModule(mod:GetName(), InitializeCallback)