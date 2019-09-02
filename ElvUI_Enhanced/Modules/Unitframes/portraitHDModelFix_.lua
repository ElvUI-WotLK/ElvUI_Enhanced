local E, L, V, P, G = unpack(ElvUI)
local UFPM = E:NewModule("Enhanced_PortraitHDModelFix", "AceHook-3.0")
local UF = E:GetModule("UnitFrames")

local find, format, gsub, split = string.find, string.format, string.gsub, string.split
local tinsert, twipe = table.insert, table.wipe
local ipairs = ipairs

local function HdModels()
	local f = CreateFrame("frame", nil)
	local t = f:CreateTexture()
	t:SetPoint("CENTER", WorldFrame)
	t:SetTexture("Character\\Tauren\\Male\\TaurenMaleFaceLower00_00_HD")
	t:SetSize(0, 0)
	local exist = t:GetTexture() and true or false
	t:SetTexture(nil)
	f:Kill()
	return exist
end

local function PortraitHDModelFix(self)
	if self:IsObjectType("Model") then
		local model = self:GetModel()
		if not model or type(model) ~= "string" then return end

		if UFPM.db.debug then
			print(format("|cffc79c6eUnit:|r %s; |cffc79c6eModel:|r %s", self:GetParent().unitframeType, gsub(model, ".+\\(%S+%.m2)", "%1")))
		end

		for _, modelName in ipairs(UFPM.modelsToFix) do
			if find(model, modelName) then
				self:SetCamera(1)
				break
			end
		end

	end
end

local frames = {
	{"player", "target", "targettarget", "targettargettarget", "focus", "focustarget", "pet", "pettarget"},
	{"boss", "arena"},
	{"party", "raid", "raid40"}
}

function UFPM:UpdatePortraits()
	local modelList = self.db.modelsToFix
	modelList = gsub(modelList, "%s+", "")
	twipe(self.modelsToFix)

	for _, modelName in ipairs({split(";", modelList)}) do
		if modelName ~= "" then
			tinsert(self.modelsToFix, modelName)
		end
	end

	for i = 1, 3 do
		for _, frame in ipairs(frames[i]) do
			if i == 1 then
				UF.CreateAndUpdateUF(UF, frame)
			elseif i == 2 then
				if frame == "boss" then
					UF.CreateAndUpdateUFGroup(UF, frame, MAX_BOSS_FRAMES)
				else
					UF.CreateAndUpdateUFGroup(UF, frame, 5)
				end
			else
				UF.CreateAndUpdateHeaderGroup(UF, frame)
			end
		end
	end
end

function UFPM:ToggleState()
	if not self.hdModels then return end

	if self.db.enable then
		self:SecureHook(UF, "PortraitUpdate", PortraitHDModelFix)
	else
		self:UnhookAll()
		return
	end

	local frame, frameName

	for i = 1, 3 do
		for _, unit in ipairs(frames[i]) do
			frameName = E:StringTitle(unit)
			frame = _G["ElvUF_"..frameName]

			if frame and frame.Portrait3D and frame.Portrait3D.PostUpdate then
				if self.db.enable then
					if not self:IsHooked(frame.Portrait3D, "PostUpdate", PortraitHDModelFix) then
						self:SecureHook(frame.Portrait3D, "PostUpdate", PortraitHDModelFix)
					end
				else
					self:UnhookAll()
				end
			end
		end
	end

	self:UpdatePortraits()
end

function UFPM:Initialize()
	if not E.private.unitframe.enable then return end

	self.db = E.db.enhanced.unitframe.portraitHDModelFix
	self.modelsToFix = {}
	self.hdModels = HdModels()

	if not self.db.enable then return end

	self:ToggleState()
end

local function InitializeCallback()
	UFPM:Initialize()
end

E:RegisterModule(UFPM:GetName(), InitializeCallback)