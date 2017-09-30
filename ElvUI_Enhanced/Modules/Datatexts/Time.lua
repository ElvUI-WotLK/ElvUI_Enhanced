local E, L, V, P, G = unpack(ElvUI)
local EDTT = E:NewModule("Enhanced_DatatextTime")
local DT = E:GetModule("DataTexts")

local time = time
local join = string.join

local displayNumberString = ""

local original_OnUpdate
local lastPanel
local int = 5

local function OnUpdate(self, t)
	int = int - t

	if(int > 0) then return end

	if(GameTimeFrame.flashInvite) then
		E:Flash(self, 0.53)
	else
		E:StopFlash(self)
	end

	self.text:SetText(BetterDate(E.db.datatexts.timeFormat .. " " .. E.db.datatexts.dateFormat, time()):gsub("%W", displayNumberString):gsub(TIMEMANAGER_AM, displayNumberString):gsub(TIMEMANAGER_PM, displayNumberString))

	lastPanel = self
	int = 1
end

local function ValueColorUpdate(hex)
	displayNumberString = join("", hex, "%1|r")

	if(lastPanel ~= nil) then
		OnUpdate(lastPanel, 20000)
	end
end

local function GetLastPanel(name)
	local db = E.db.datatexts
	local pointIndex

	for panelName, panel in pairs(DT.RegisteredPanels) do
		for i = 1, panel.numPoints do
			pointIndex = DT.PointLocation[i]

			for option, value in pairs(db.panels) do
				if(value and type(value) == "table") then
					if(option == panelName and db.panels[option][pointIndex] and db.panels[option][pointIndex] == name) then
						return panel.dataPanels[pointIndex]
					end
				elseif(value and type(value) == "string" and value == name) then
					return panel.dataPanels[pointIndex]
				end
			end
		end
	end
end

function EDTT:UpdateSettings()
	if not (DT.RegisteredDataTexts and DT.RegisteredDataTexts["Time"]) then return end

	lastPanel = GetLastPanel("Time")

	if E.db.enhanced.datatexts.timeColorEnch then
		original_OnUpdate = DT.RegisteredDataTexts["Time"]["onUpdate"]

		DT.RegisteredDataTexts["Time"]["onUpdate"] = OnUpdate

		E["valueColorUpdateFuncs"][ValueColorUpdate] = true
	else
		DT.RegisteredDataTexts["Time"]["onUpdate"] = original_OnUpdate

		for func, _ in pairs(E["valueColorUpdateFuncs"]) do
			if func == ValueColorUpdate then
				func = nil
				break
			end
		end
	end

	E:ValueFuncCall()

	if lastPanel then
		lastPanel:SetScript("OnUpdate", DT.RegisteredDataTexts["Time"]["onUpdate"])
		DT.RegisteredDataTexts["Time"]["onUpdate"](lastPanel, 1)
	end
end

function EDTT:Initialize()
	if not E.db.enhanced.datatexts.timeColorEnch then return end

	self:UpdateSettings()
end

local function InitializeCallback()
	EDTT:Initialize()
end

E:RegisterModule(EDTT:GetName(), InitializeCallback)