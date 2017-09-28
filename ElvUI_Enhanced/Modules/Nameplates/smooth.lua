local E, L, V, P, G = unpack(ElvUI)
local ENP = E:GetModule("Enhanced_NamePlates")
local mod = E:GetModule("NamePlates")

local min, max = math.min, math.max

local smoothing = {}
local function SetSmooth(self, value)
	local _, maxValue = self:GetMinMaxValues()
	if value == self:GetValue() or (self._max and self._max ~= maxValue) then
		smoothing[self] = nil
		self:SetValue_(value)
	else
		smoothing[self] = value
	end
	self._max = maxValue
end

local function Smooth(bar)
	if not bar.SetValue_ then
		bar.SetValue_ = bar.SetValue;
		bar.SetValue = SetSmooth;
	end
	bar.Smooth = E.db.enhanced.nameplates.smooth
	bar.SmoothSpeed = E.db.enhanced.nameplates.smoothSpeed * 10
end

function ENP:UpdateAllFrame(_, frame)
	frame.HealthBar.Smooth = E.db.enhanced.nameplates.smooth
	frame.HealthBar.SmoothSpeed = E.db.enhanced.nameplates.smoothSpeed * 10
end

function ENP:OnCreated(_, frame)
	Smooth(frame.UnitFrame.HealthBar)
end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function()
	local limit = 30/GetFramerate()
	for bar, value in pairs(smoothing) do
		local cur = bar:GetValue()
		local new = cur + min((value-cur)/(bar.SmoothSpeed or 3), max(value-cur, limit))
		if new ~= new then
			-- Mad hax to prevent QNAN.
			new = value
		end
		bar:SetValue_(new)
		if (cur == value or abs(new - value) < 2) and bar.Smooth then
			bar:SetValue_(value)
			smoothing[bar] = nil
		elseif not bar.Smooth then
			bar:SetValue_(value)
			smoothing[bar] = nil
		end
	end
end)

function ENP:Smooth()
	self:SecureHook(mod, "UpdateAllFrame")
	self:SecureHook(mod, "OnCreated")
end