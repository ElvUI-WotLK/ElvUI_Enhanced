local E, L, V, P, G = unpack(ElvUI)
local ENP = E:GetModule("Enhanced_NamePlates")
local mod = E:GetModule("NamePlates")
local M = E:GetModule("Misc")

local ipairs = ipairs
local next = next
local sub = string.sub

local events = {
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
}

local inactiveBubbles = {}

local function ReleaseBubble(frame)
	inactiveBubbles[#inactiveBubbles + 1] = frame
	frame:GetParent().bubbleFrame = nil
	frame:Hide()
end

local function FadeClosure(frame)
	if frame.fadeInfo.mode == "OUT" then
		ReleaseBubble(frame)
	end
end

local function Bubble_OnUpdate(self, elapsed)
	self.delay = self.delay - elapsed
	if self.delay <= 0 then
		self.delay = 0
		E:UIFrameFadeOut(self, .2, self:GetAlpha(), 0)
	end
end

local function CreateBubble()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:Hide()
	frame.text = frame:CreateFontString()
	frame.text:SetJustifyH("CENTER")
	frame.text:SetJustifyV("MIDDLE")
	frame.text:SetWordWrap(true)
	frame.text:SetNonSpaceWrap(true)
	frame:SetPoint("TOPLEFT", frame.text, -15, 15)
	frame:SetPoint("BOTTOMRIGHT", frame.text, 15, -15)
	M:SkinBubble(frame)

	frame.delay = 0
	frame.FadeObject = {
		finishedFuncKeep = true,
		finishedArg1 = frame,
		finishedFunc = FadeClosure
	}

	frame:SetScript("OnUpdate", Bubble_OnUpdate)

	return frame
end

local function AcquireBubble()
	local numInactiveObjects = #inactiveBubbles
	if numInactiveObjects > 0 then
		local frame = inactiveBubbles[numInactiveObjects]
		inactiveBubbles[numInactiveObjects] = nil
		return frame
	end

	return CreateBubble()
end

function ENP:FindNameplateByChatMsg(event, msg, author, _, _, _, _, _, channelID)
	if author == UnitName("player") then return end
	if not next(mod.VisiblePlates) then return end

	local chatType = sub(event, 10)
	if sub(chatType, 1, 7) == "CHANNEL" then
		chatType = "CHANNEL"..channelID
	end

	local info = ChatTypeInfo[chatType]
	if not info then return end

	for frame in pairs(mod.VisiblePlates) do
		if (frame.UnitType == "FRIENDLY_PLAYER" or frame.UnitType == "ENEMY_PLAYER") and frame.UnitName == author then
			local nameplateBubble
			if not frame.bubbleFrame then
				nameplateBubble = AcquireBubble()
				frame.bubbleFrame = nameplateBubble
				nameplateBubble:SetParent(frame)
				nameplateBubble.text:ClearAllPoints()
				nameplateBubble.text:SetPoint("BOTTOM", frame, "TOP", 0, 20)
				nameplateBubble:Show()
				E:UIFrameFadeIn(nameplateBubble, .2, 0, 1)
			else
				nameplateBubble = frame.bubbleFrame
			end

			nameplateBubble.text:SetSize(0, 0)
			nameplateBubble.text:SetText(msg)
			nameplateBubble.text:SetTextColor(info.r, info.g, info.b)

			if nameplateBubble.text:GetStringWidth() > 300 then
				nameplateBubble.text:SetWidth(300)
			end

			M.UpdateBubbleBorder(nameplateBubble)

			if nameplateBubble.delay == 0 then
				E:UIFrameFadeRemoveFrame(nameplateBubble)
				E:UIFrameFadeIn(nameplateBubble, .2, nameplateBubble:GetAlpha(), 1)
			end

			nameplateBubble.delay = 5
		end
	end
end

local function Nameplate_OnHide(frame)
	if frame.UnitFrame.bubbleFrame then
		ReleaseBubble(frame.UnitFrame.bubbleFrame)
	end
end

function ENP:ChatBubbles()
	if E.db.enhanced.nameplates.chatBubbles then
		for _, event in ipairs(events) do
			ENP:RegisterEvent(event, "FindNameplateByChatMsg")
		end

		if not ENP:IsHooked(mod, "OnHide") then
			ENP:Hook(mod, "OnHide", Nameplate_OnHide)
		end
	else
		for _, event in ipairs(events) do
			ENP:UnregisterEvent(event)
		end

		if ENP:IsHooked(mod, "OnHide") then
			ENP:Unhook(mod, "OnHide")
		end
	end
end