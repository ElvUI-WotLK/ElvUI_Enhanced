local E, L, V, P, G = unpack(ElvUI)
local UFPM = E:NewModule("Enhanced_PortraitHDModelFix", "AceHook-3.0")
local UF = E:GetModule("UnitFrames")

local _G = _G
local ipairs = ipairs
local find, format, gsub, lower, split = string.find, string.format, string.gsub, string.lower, string.split
local tinsert, twipe = table.insert, table.wipe

local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES
local MAX_ARENA_ENEMIES = 5

local function checkHDModels()
	local hdTexturePathList = {
		"Character\\Tauren\\Male\\TaurenMaleFaceLower00_00_HD",
		"Character\\Draenei\\Male\\DraeneiMalefaceUpper00_00_hd",
	}

	local f = CreateFrame("Frame")
	f:Hide()
	local t = f:CreateTexture()

	for _, modelPath in ipairs(hdTexturePathList) do
		t:SetTexture(modelPath)
		local texturePath = t:GetTexture()
		t:SetTexture(nil)

		if texturePath then
			return true
		end
	end
end

local function portraitHDModelFix(self)
	if self:IsObjectType("Model") then
		local model = self:GetModel()
		if not model then return end

		if E.db.enhanced.unitframe.portraitHDModelFix.debug then
			print(format("|cffc79c6eUnit:|r %s; |cffc79c6eModel:|r %s", self:GetParent().unitframeType, gsub(model, ".+\\(%S+%.m2)", "%1")))
		end

		model = lower(model)

		for _, modelName in ipairs(UFPM.modelsToFix) do
			if find(model, modelName, 1, true) then
				self:SetCamera(1)
				break
			end
		end
	end
end

local unitTypes = {
	{"player", "target", "targettarget", "targettargettarget", "focus", "focustarget", "pet", "pettarget"},
	{"party", "raid", "raid40"},
	{"boss", "arena"},
}

function UFPM:UpdatePortraits()
	if not self.HDModelFound then return end

	twipe(self.modelsToFix)
	local modelList = gsub(E.db.enhanced.unitframe.portraitHDModelFix.modelsToFix, "%s+", "")

	if modelList ~= "" then
		for _, modelName in ipairs({split(";", modelList)}) do
			if modelName ~= "" then
				tinsert(self.modelsToFix, lower(modelName))
			end
		end
	end

	for i = 1, #unitTypes do
		for _, unit in ipairs(unitTypes[i]) do
			if i == 1 then
				UF.CreateAndUpdateUF(UF, unit)
			elseif i == 2 then
				UF.CreateAndUpdateHeaderGroup(UF, unit)
			else
				UF.CreateAndUpdateUFGroup(UF, unit, unit == "boss" and MAX_BOSS_FRAMES or MAX_ARENA_ENEMIES)
			end
		end
	end
end

function UFPM:ToggleState()
	if not self.HDModelFound then return end

	if E.db.enhanced.unitframe.portraitHDModelFix.enable then
		if not self.hooked then
			self:SecureHook(UF, "PortraitUpdate", portraitHDModelFix)
			self.hooked = true
		end
	else
		if self.hooked then
			self:UnhookAll()
			self.hooked = nil
		end
		return
	end

	for i = 1, #unitTypes do
		for _, unit in ipairs(unitTypes[i]) do
			local frame = _G["ElvUF_" .. E:StringTitle(unit)]

			if frame and frame.Portrait3D and frame.Portrait3D.PostUpdate then
				if not self:IsHooked(frame.Portrait3D, "PostUpdate", portraitHDModelFix) then
					self:SecureHook(frame.Portrait3D, "PostUpdate", portraitHDModelFix)
				end
			end
		end
	end

	self:UpdatePortraits()
end

function UFPM:Initialize()
	if not E.private.unitframe.enable then return end

	self.modelsToFix = {}
	self.HDModelFound = checkHDModels()

	if not E.db.enhanced.unitframe.portraitHDModelFix.enable then return end

	self:ToggleState()
end

local function InitializeCallback()
	UFPM:Initialize()
end

E:RegisterModule(UFPM:GetName(), InitializeCallback)