local E, L, V, P, G = unpack(ElvUI)
local KPA = E:NewModule("Enhanced_KeyPressAnimation")
local LAB = E.Libs.LAB

local ipairs = ipairs
local tinsert, tremove = table.insert, table.remove

local CreateFrame = CreateFrame

local framePool = {}

local function OnFinished(self)
	tinsert(framePool, self.parent)
end

local function CreateAnimationFrame()
	local db = E.db.enhanced.actionbar.keyPressAnimation

	local frame = CreateFrame("Frame", "Enhanced_KeyPressAnimation"..(#KPA.frames + 1), UIParent)

	local texture = frame:CreateTexture()
	texture:SetTexture([[Interface\Cooldown\star4]])
	texture:SetAlpha(0)
	texture:SetAllPoints()
	texture:SetBlendMode("ADD")
	texture:SetVertexColor(db.color.r, db.color.g, db.color.b)
	frame.texture = texture

	local animationGroup = texture:CreateAnimationGroup()
	animationGroup:SetScript("OnFinished", OnFinished)
	animationGroup.parent = frame
	frame.animationGroup = animationGroup

	local alpha1 = animationGroup:CreateAnimation("Alpha")
	alpha1:SetChange(1)
	alpha1:SetDuration(0)
	alpha1:SetOrder(1)
	frame.alpha1 = alpha1

	local scale1 = animationGroup:CreateAnimation("Scale")
	scale1:SetScale(1.0, 1.0)
	scale1:SetDuration(0)
	scale1:SetOrder(1)
	frame.scale1 = scale1

	local scale2 = animationGroup:CreateAnimation("Scale")
	scale2:SetScale(db.scale, db.scale)
	scale2:SetDuration(0.2)
	scale2:SetOrder(2)
	frame.scale2 = scale2

	local rotation = animationGroup:CreateAnimation("Rotation")
	rotation:SetDegrees(db.rotation)
	rotation:SetDuration(0.2)
	rotation:SetOrder(2)
	frame.rotation = rotation

	tinsert(KPA.frames, frame)

	return frame
end

local function StartAnimation(button)
	if not button:IsVisible() or button:GetParent():GetAlpha() == 0 then return end

	local frame = KPA:GetFreeAnimationFrame()
	local animationGroup = frame.animationGroup

	frame:SetFrameStrata(button:GetFrameStrata())
	frame:SetFrameLevel(button:GetFrameLevel() + 10)
	frame:SetAllPoints(button)

	frame.button = button

	animationGroup:Play()
end

function KPA:GetFreeAnimationFrame()
	return #framePool > 0 and tremove(framePool) or CreateAnimationFrame()
end

function KPA:UpdateSetting()
	local db = E.db.enhanced.actionbar.keyPressAnimation

	for _, frame in ipairs(self.frames) do
		frame.texture:SetVertexColor(db.color.r, db.color.g, db.color.b)
		frame.scale2:SetScale(db.scale, db.scale)
		frame.rotation:SetDegrees(db.rotation)
	end
end

function KPA:Initialize()
	if not E.private.enhanced.actionbar.keyPressAnimation then return end

	self.frames = {}

	for i = 1, 3 do
		tinsert(framePool, CreateAnimationFrame())
	end

	LAB.RegisterCallback(KPA, "OnButtonCreated", function(_, button)
		button:HookScript("PreClick", StartAnimation)
	end)

	for button in pairs(LAB.buttonRegistry) do
		button:HookScript("PreClick", StartAnimation)
	end
end

local function InitializeCallback()
	KPA:Initialize()
end

E:RegisterModule(KPA:GetName(), InitializeCallback)