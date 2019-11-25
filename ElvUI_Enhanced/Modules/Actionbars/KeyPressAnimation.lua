local E, L, V, P, G = unpack(ElvUI)
local KPA = E:NewModule("Enhanced_KeyPressAnimation")
local LAB = E.Libs.LAB

local ipairs = ipairs
local pairs = pairs

local animationsCount = 5
local animations = {}

for i = 1, animationsCount do
	local frame = CreateFrame("Frame")

	local texture = frame:CreateTexture()
	texture:SetTexture([[Interface\Cooldown\star4]])
	texture:SetAlpha(0)
	texture:SetAllPoints()
	texture:SetBlendMode("ADD")
	frame.texture = texture

	local animationGroup = texture:CreateAnimationGroup()

	local alpha1 = animationGroup:CreateAnimation("Alpha")
	alpha1:SetChange(1)
	alpha1:SetDuration(0)
	alpha1:SetOrder(1)

	local scale1 = animationGroup:CreateAnimation("Scale")
	scale1:SetScale(1.0, 1.0)
	scale1:SetDuration(0)
	scale1:SetOrder(1)

	local scale2 = animationGroup:CreateAnimation("Scale")
	scale2:SetScale(1.5, 1.5)
	scale2:SetDuration(0.2)
	scale2:SetOrder(2)
	frame.scale2 = scale2

	local rotation = animationGroup:CreateAnimation("Rotation")
	rotation:SetDegrees(90)
	rotation:SetDuration(0.2)
	rotation:SetOrder(2)
	frame.rotation = rotation

	animations[i] = {frame = frame, animationGroup = animationGroup}
end

local animationNum = 1
local function animate(button)
	if not button:IsVisible() or button:GetParent():GetAlpha() == 0 then
		return
	end

	local animation = animations[animationNum]
	local frame = animation.frame
	local animationGroup = animation.animationGroup

	frame:SetFrameStrata(button:GetFrameStrata())
	frame:SetFrameLevel(button:GetFrameLevel() + 10)
	frame:SetAllPoints(button)

	animationGroup:Stop()
	animationGroup:Play()

	animationNum = (animationNum % animationsCount) + 1
end

function KPA:LAB_OnButtonCreated(button)
	button:HookScript("PreClick", animate)
end

function KPA:UpdateSetting()
	local db = E.db.enhanced.actionbar.keyPressAnimation
	for i, v in ipairs(animations) do
		local frame = v.frame
		frame.texture:SetVertexColor(db.color.r, db.color.g, db.color.b)
		frame.scale2:SetScale(db.scale, db.scale)
		frame.rotation:SetDegrees(db.rotation)
	end
end

function KPA:Initialize()
	if not E.private.enhanced.actionbar.keyPressAnimation then return end

	self:UpdateSetting()

	LAB.RegisterCallback(KPA, "OnButtonCreated", KPA.LAB_OnButtonCreated)

	for button in pairs(LAB.buttonRegistry) do
		button:HookScript("PreClick", animate)
	end
end

local function InitializeCallback()
	KPA:Initialize()
end

E:RegisterModule(KPA:GetName(), InitializeCallback)