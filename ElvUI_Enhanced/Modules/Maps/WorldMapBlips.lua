local E, L, V, P, G = unpack(ElvUI)
local WMB = E:NewModule("Enhanced_WorldMapBlips")

local _G = _G

local UnitClass = UnitClass
local UnitInParty = UnitInParty

local BLIP_TEX_COORDS = {
	["WARRIOR"] = {0, 0.125, 0, 0.25},
	["PALADIN"] = {0.125, 0.25, 0, 0.25},
	["HUNTER"] = {0.25, 0.375, 0, 0.25},
	["ROGUE"] = {0.375, 0.5, 0, 0.25},
	["PRIEST"] = {0.5, 0.625, 0, 0.25},
	["DEATHKNIGHT"] = {0.625, 0.75, 0, 0.25},
	["SHAMAN"] = {0.75, 0.875, 0, 0.25},
	["MAGE"] = {0.875, 1, 0, 0.25},
	["WARLOCK"] = {0, 0.125, 0.25, 0.5},
	["DRUID"] = {0.25, 0.375, 0.25, 0.5}
}

local BLIP_RAID_Y_OFFSET = 0.5

local function OnShowParty(self)
	local _, class = UnitClass(self.unit)
	if not class then return end

	if self.class ~= class then
		self.class = class
		self.icon:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
	end
end

local function OnShowRaid(self)
	if not self.unit then return end -- players in the battleground not in your raid

	local _, class = UnitClass(self.unit)
	if not class then return end

	local inParty = UnitInParty(self.unit)

	if self.class ~= class or self.inParty ~= inParty then
		self.class = class
		self.inParty = inParty

		if inParty then
			self.icon:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
		else
			self.icon:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3] + BLIP_RAID_Y_OFFSET, BLIP_TEX_COORDS[class][4] + BLIP_RAID_Y_OFFSET)
		end
	end
end

function WMB:Initialize()
	local _, _, _, enabled, _, reason = GetAddOnInfo("Mapster")
	if reason ~= "MISSED" and enabled then return end

	local frame

	for i = 1, MAX_PARTY_MEMBERS do
		frame = _G["WorldMapParty"..i]
		frame.icon:SetTexture("Interface\\Addons\\ElvUI_Enhanced\\Media\\Textures\\PartyRaidBlips")
		frame:Size(24)
		frame:HookScript("OnShow", OnShowParty)
	end

	for i = 1, MAX_RAID_MEMBERS do
		frame = _G["WorldMapRaid"..i]
		frame.icon:SetTexture("Interface\\Addons\\ElvUI_Enhanced\\Media\\Textures\\PartyRaidBlips")
		frame:Size(24)
		frame:HookScript("OnShow", OnShowRaid)
	end

	Minimap:SetClassBlipTexture("Interface\\Addons\\ElvUI_Enhanced\\Media\\Textures\\PartyRaidBlips")
end

local function InitializeCallback()
	WMB:Initialize()
end

E:RegisterModule(WMB:GetName(), InitializeCallback)