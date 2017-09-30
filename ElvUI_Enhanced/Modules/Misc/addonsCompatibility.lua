local E, L, V, P, G = unpack(ElvUI);
local AC = E:NewModule("Enhanced_AddonsCompat", "AceEvent-3.0");

local tinsert, tremove = table.insert, table.remove
local pairs = pairs

local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn

local addonFixes = {
	-- Deadly Boss Mods 3.22
	["DBM_API"] = function()
		local function MessageFilter()
			if event and arg1 then
				if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" then
					if string.sub(arg1, 1, 4) == "LVPN" or string.sub(arg1, 1, 4) == "LVBM" then
						if event == "CHAT_MSG_WHISPER_INFORM" then
							DBM.HideDNDAFKMessages[arg2] = 1.5
						end
						return true
					elseif event == "CHAT_MSG_WHISPER_INFORM" and DBM.HiddenWhisperMessages[string.gsub(arg1, "%%", "")] and DBM.HiddenWhisperMessages[string.gsub(arg1, "%%", "")]["targets"] and DBM.HiddenWhisperMessages[string.gsub(arg1, "%%", "")]["targets"][arg2] then
						return true
					elseif event == "CHAT_MSG_WHISPER" then
						local whisperCheck = DBM.InterceptWhisper(arg1, arg2, arg6)
						if whisperCheck == "AUTO_RESPONDED" then
							if DBM.Options.ShowWhispersDuringCombat then
								E:GetModule("Chat"):ChatFrame_MessageEventHandler(event)
								if DBM.Options.ShowAutoRespondInfo and DBM.Options.HideOutgoingInfoWhisper then
									DBM.AddMsg(DBM_AUTO_RESPOND_SHORT, nil, true)
								end
								return true
							else
								if DBM.Options.ShowAutoRespondInfo and DBM.Options.HideOutgoingInfoWhisper then
									DBM.AddMsg(string.format(DBM_AUTO_RESPOND_LONG, arg2), nil, true)
								end
								return true
							end
						elseif whisperCheck == "HIDE" then
							if not DBM.Options.ShowWhispersDuringCombat then
								return true
							end
						elseif whisperCheck == "FORCE_HIDE" then
							return true
						end
					end
				elseif event == "CHAT_MSG_AFK" or event == "CHAT_MSG_DND" then
					if DBM.HideDNDAFKMessages[arg2] then
						return true
					end
				elseif event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_BATTLEGROUND" or event == "CHAT_MSG_BATTLEGROUND_LEADER" then
					if DBM.CheckForSpam(event, arg1, arg2) then
						return true
					else
						if event == "CHAT_MSG_RAID_WARNING" then
							local colorCode = ""
							if arg1:find("^%*%*%*%s%s.+%s%s%*%*%*$") then
								colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[2]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[2]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[2]["b"])
							elseif arg1:find("^%*%*%*%s.+%s%*%*%*$") then
								colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[1]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[1]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[1]["b"])
							elseif arg1:find("^%s%*%*%*%s.+%s%*%*%*%s$") then
								colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[3]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[3]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[3]["b"])
							elseif arg1:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then
								colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[5]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[5]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[5]["b"])
							elseif arg1:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then
								colorCode = "|cff"..("%.2x"):format(255 * DBM.Options.RaidWarningColors[4]["r"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[4]["g"])..("%.2x"):format(255 * DBM.Options.RaidWarningColors[4]["b"])
							end

							arg1 = arg1:gsub(">[^%s]+<", function(capture)
								capture = capture:sub(2, -2)
								if DBM.RaidClasses[capture] then
									capture = "|r|cff"..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].r)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].g)..("%.2x"):format(255 * RAID_CLASS_COLORS[DBM.RaidClasses[capture]].b)..capture.."|r"..colorCode
								end
								return capture
							end)

							if arg1:find("^%*%*%*%s%s.+%s%s%*%*%*$") then
								arg1 = colorCode..arg1:sub(6, -6).."|r"
							elseif arg1:find("^%*%*%*%s.+%s%*%*%*$") then
								arg1 = colorCode..arg1:sub(5, -5).."|r"
							elseif arg1:find("^%s%*%*%*%s.+%s%*%*%*%s$") then
								arg1 = colorCode..arg1:sub(6, -6).."|r"
							elseif arg1:find("^%s%s%*%*%*%s%s.+%s%s%*%*%*%s%s$") then
								arg1 = colorCode..arg1:sub(8, -8).."|r"
							elseif arg1:find("^%s%s%*%*%*%s.+%s%*%*%*%s%s$") then
								arg1 = colorCode..arg1:sub(7, -7).."|r"
							end
						end
						return false, arg1
					end
				end
			end
		end

		local events = {
			"CHAT_MSG_WHISPER",
			"CHAT_MSG_WHISPER_INFORM",
			"CHAT_MSG_RAID_WARNING",
			"CHAT_MSG_RAID",
			"CHAT_MSG_RAID_LEADER",
			"CHAT_MSG_BATTLEGROUND",
			"CHAT_MSG_BATTLEGROUND_LEADER",
			"CHAT_MSG_AFK",
			"CHAT_MSG_DND"
		}

		for _, event in pairs(events) do
			ChatFrame_AddMessageEventFilter(event, MessageFilter)
		end
	end,
}

local function table_count(t)
	local i = 0
	for _, _ in pairs(t) do
		i = i + 1
	end
	return i
end

function AC:AddAddon(addon)
	if not addon then return end

	if IsAddOnLoaded(addon) then
		self:ApplyFix(addon)
	elseif IsAddOnLoadOnDemand(addon) then
		tinsert(self.addonQueue, addon)
		self:RegisterEvent("ADDON_LOADED")
	end
end

function AC:ApplyFix(addon, onDemandID)
	addonFixes[addon]()

	if onDemandID then
		tremove(self.addonQueue, onDemandID)
	end
end

function AC:ADDON_LOADED(_, AddonName)
	for i, addon in pairs(self.addonQueue) do
		if addon == AddonName then
			self:ApplyFix(addon, i)

			if table_count(self.addonQueue) == 0 then
				self:UnregisterEvent("ADDON_LOADED")
			end

			break
		end
	end
end

function AC:Initialize()
	self.addonQueue = {}

	for addon, func in pairs(addonFixes) do
		self:AddAddon(addon, func)
	end
end

local function InitializeCallback()
	AC:Initialize()
end

E:RegisterModule(AC:GetName(), InitializeCallback)