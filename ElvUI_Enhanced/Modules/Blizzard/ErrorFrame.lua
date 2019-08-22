local E, L, V, P, G = unpack(ElvUI)
local mod = E:GetModule("Enhanced_Blizzard")
local LSM = LibStub("LibSharedMedia-3.0")

function mod:ErrorFrameSize()
	UIErrorsFrame:SetSize(E.db.enhanced.blizzard.errorFrame.width, E.db.enhanced.blizzard.errorFrame.height)
	UIErrorsFrame:SetFont(LSM:Fetch("font", E.db.enhanced.blizzard.errorFrame.font), E.db.enhanced.blizzard.errorFrame.fontSize, E.db.enhanced.blizzard.errorFrame.fontOutline)

	E:CreateMover(UIErrorsFrame, "UIErrorsFrameMover", L["Error Frame"], nil, nil, nil, nil, nil, "elvuiPlugins,enhanced,miscGroup,errorFrame")
end