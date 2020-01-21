SLASH_ANALYZE1 = "/analyze"
SlashCmdList.ANALYZE = function(arg)
	if arg == "" then
		arg = GetMouseFocus()
	else
		arg = _G[arg]
	end

	if arg and arg:GetName() then
		ChatFrame1:AddMessage("|cffCC0000----------------------------")
		ChatFrame1:AddMessage(arg:GetName())
		for _, child in ipairs({arg:GetChildren()}) do
			if child:GetName() then
				ChatFrame1:AddMessage("+="..child:GetName())
			end
		end
		ChatFrame1:AddMessage("|cffCC0000----------------------------")
	end
end

SLASH_PROFILE1 = "/profile"
SlashCmdList.PROFILE = function()
	local cpuProfiling = GetCVar("scriptProfile") == "1"
	if cpuProfiling then
		SetCVar("scriptProfile", "0")
	else
		SetCVar("scriptProfile", "1")
	end
	ReloadUI()
end