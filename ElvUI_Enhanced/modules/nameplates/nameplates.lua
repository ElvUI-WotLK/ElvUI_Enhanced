local E, L, V, P, G = unpack(ElvUI)
local ENP = E:NewModule("Enhanced_NamePlates", "AceHook-3.0", "AceEvent-3.0")

function ENP:Initialize()
	self:CacheUnitClass()
	self:Smooth()
end

local function InitializeCallback()
	ENP:Initialize()
end

E:RegisterModule(ENP:GetName(), InitializeCallback)