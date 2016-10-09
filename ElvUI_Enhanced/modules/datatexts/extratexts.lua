local E, L, V, P, G = unpack(ElvUI);
local EDT = E:NewModule("ExtraDataTexts");
local DT = E:GetModule("DataTexts");
local AB = E:GetModule("ActionBars");
local LO = E:GetModule("Layout");

local floor = math.floor;
local match = string.match;
local twipe, tinsert, tsort = table.wipe, table.insert, table.sort;

local PANEL_HEIGHT = 22;
local SPACING = (E.PixelMode and 1 or 5);

local menu = {}
local menuDatatext
local menuFrame

local extrapanel = {
	[1] = 3,
	[3] = 1,
	[5] = 1
};

local visibility = {};

AB.barDefaults.bar2.position = "BOTTOM,ElvUI_Bar1,TOP,0,0";
AB.barDefaults.bar3.position = "BOTTOMLEFT,ElvUI_Bar1,BOTTOMRIGHT,4,0";
AB.barDefaults.bar5.position = "BOTTOMRIGHT,ElvUI_Bar1,BOTTOMLEFT,-4,0";

function EDT:ToggleSettings(barnumber)
	EDT:RegisterDrivers();

	twipe(visibility);

	for k, v in pairs(extrapanel) do
		local actionBarName = ("bar%d"):format(k);
		local showPanel = E.db.actionbar[actionBarName].enabled and E.db.datatexts[("actionbar%d"):format(k)];
		local mover = _G[("ElvAB_%d"):format(k)];
		if(mover)then
			visibility[k] = {showPanel, mover};
		end
	end

	if(visibility[1][1]) then
		EDT:ResetMover(2);
		EDT:CheckForMoveUp(visibility[1][2]);
	end

	if(visibility[1][1]) then
		if(visibility[3][1]) then
			EDT:ResetMover(3);
		else
			EDT:ForceMover(visibility[3][2], -22);
		end
		if(visibility[5][1]) then
			EDT:ResetMover(5);
		else
			EDT:ForceMover(visibility[5][2], -22);
		end
	else
		EDT:ResetMover(1);
		if(visibility[3][1]) then
			EDT:ForceMover(visibility[3][2], 22);
		else
			EDT:ResetMover(3);
		end
		if(visibility[5][1]) then
			EDT:ForceMover(visibility[5][2], 22);
		else
			EDT:ResetMover(5);
		end
	end
end

function EDT:CheckForMoveUp(mover)
	local point, relativeTo, relativePoint, xOfs, yOfs = mover:GetPoint();

	if(relativePoint == "BOTTOM" and yOfs < 26) then
		EDT:PositionActionBar(mover, point, relativeTo, relativePoint, xOfs, 26);
	end
end

function EDT:ForceMover(mover, offSet)
	local point, relativeTo, relativePoint, xOfs, yOfs = mover:GetPoint();
	EDT:PositionActionBar(mover, point, relativeTo, relativePoint, xOfs, offSet);
end

function EDT:ResetMover(barnumber)
	local bar = _G[("ElvAB_%d"):format(barnumber)];
	if(bar and bar.textString) then
		E:ResetMovers(bar.textString);
	end
end

function EDT:RegisterDrivers()
	for k, v in pairs(extrapanel) do
		local panel = _G[("Actionbar%dDataPanel"):format(k)];
		local showPanel = E.db.datatexts[("actionbar%d"):format(k)];

		if(panel.db.enabled and showPanel) then
			RegisterStateDriver(panel, "visibility", panel.db.visibility);
		else
			UnregisterStateDriver(panel, "visibility");
			panel:Hide();
		end
	end
end

function EDT:PositionActionBar(mover, point, relativeTo, relativePoint, xOfs, yOfs)
	mover:ClearAllPoints();
	mover:Point(point, relativeTo, relativePoint, xOfs, yOfs);
	E:SaveMoverPosition(mover.name);

	mover.parent:ClearAllPoints();
	mover.parent:SetPoint(relativePoint, mover, 0, 0);
end

function EDT:PositionDataPanel(panel, index)
	if(not panel) then return; end

	local actionbar = _G[("ElvUI_Bar%d"):format(index)];
	local spacer = panel.db.backdrop and 0 or panel.db.buttonspacing;

	panel:ClearAllPoints();
	panel:Point("TOPLEFT", actionbar, "BOTTOMLEFT", spacer, 0);
	panel:Point("BOTTOMRIGHT", actionbar, "BOTTOMRIGHT", -spacer, -PANEL_HEIGHT);

	EDT:RegisterDrivers();
end

function EDT:GetPanelDatatextName()
	if(menuPanel.numPoints == 1) then
		return E.db.datatexts.panels[menuPanel:GetName()]
	else
		local index = tonumber(match(menuDatatext:GetName(), "%d+"));
		local pointIndex = DT.PointLocation[index];
		return E.db.datatexts.panels[menuPanel:GetName()][pointIndex];
	end
end

function EDT:ChangeDatatext(name)
	if(menuPanel.numPoints == 1) then
		E.db.datatexts.panels[menuPanel:GetName()] = name;
	else
		local index = tonumber(match(menuDatatext:GetName(), "%d+"));
		local pointIndex = DT.PointLocation[index];
		E.db.datatexts.panels[menuPanel:GetName()][pointIndex] = name;
	end

	DT:LoadDataTexts();
end

function EDT:UpdateCheckedMenuOption()
	local current = EDT:GetPanelDatatextName();
	for _, v in ipairs(menu) do
		v.checked = false;
		if((v.text == current) or (v.text == "None" and current == "")) then
			v.checked = true;
		end
	end
end

local enhancedClickMenu = function(self, button)
	menuDatatext = self;
	menuPanel = DT.RegisteredPanels[self:GetParent():GetName()];

	if(button == "RightButton" and IsAltKeyDown() and IsControlKeyDown()) then
		menuFrame.point = "BOTTOM";
		menuFrame.relativePoint = "TOP";

		EDT:UpdateCheckedMenuOption();

		EasyMenu(menu, menuFrame, menuDatatext, 0 , 0, "MENU", 2);
	else
		local data = DT.RegisteredDataTexts[EDT:GetPanelDatatextName()];
		if(data and data["origOnClick"]) then
			data["origOnClick"](self, button);
		end
	end
end

function EDT:ExtendClickFunction(data)
	if(data["onClick"]) then
		data["origOnClick"] = data["onClick"];
	end
	data["onClick"] = enhancedClickMenu;
end

function EDT:HookClickMenuToEmptyDataText()
	for panelName, panel in pairs(DT.RegisteredPanels) do
		for i = 1, panel.numPoints do
			local pointIndex = DT.PointLocation[i];
			local datatext = panel.dataPanels[pointIndex];
			local isSet;
			if(panel.numPoints == 1) then
				isSet = E.db.datatexts.panels[panelName];
			else
				if(E.db.datatexts.panels[panelName]) then
				    isSet = E.db.datatexts.panels[panelName][pointIndex];
				else
				    isSet = "";
				end
			end
			if(not isSet or isSet == "") then
				datatext:SetScript("OnClick", enhancedClickMenu);
			end
		end
	end
end

function EDT:OnInitialize()
	for k, v in pairs(extrapanel) do
		local actionbar = _G[("ElvUI_Bar%d"):format(k)];
		local panelname = ("Actionbar%dDataPanel"):format(k);

		local panel = CreateFrame("Frame", panelname, E.UIParent);
		panel.db = E.db.actionbar[("bar%d"):format(k)];

		local spacer = panel.db.backdrop and 0 or SPACING;

		panel:SetTemplate(E.db.datatexts.panelTransparency and "Transparent" or "Default", true);

		DT:RegisterPanel(panel, v, "ANCHOR_TOP", 0, -4);
	end

	EDT:RegisterDrivers();

	hooksecurefunc(AB, "PositionAndSizeBar", function(self, barName)
		local barnumber = tonumber(string.match(barName, "%d+"));
		if(extrapanel[barnumber]) then
			EDT:PositionDataPanel(_G[("Actionbar%dDataPanel"):format(barnumber)], barnumber);
		end
	end)

	menuFrame = CreateFrame("Frame", "EDTMenuFrame", E.UIParent, "UIDropDownMenuTemplate");
	menuFrame:SetTemplate("Default");

	for name, data in pairs(DT.RegisteredDataTexts) do
	 	EDT:ExtendClickFunction(DT.RegisteredDataTexts[name]);
	end

	hooksecurefunc(DT, "RegisterDatatext", function(self, name)
		EDT:ExtendClickFunction(DT.RegisteredDataTexts[name]);
	end);

	hooksecurefunc(DT, "LoadDataTexts", function()
		twipe(menu);
		for name, _ in pairs(DT.RegisteredDataTexts) do
			tinsert(menu, {text = name, func = function() EDT:ChangeDatatext(name); end, checked = false});
		end
		tsort(menu, function(a,b) return a.text < b.text end)
		tinsert(menu, 1, {text = "None", func = function() EDT:ChangeDatatext(""); end, checked = false});

		EDT:HookClickMenuToEmptyDataText();
	end);

	hooksecurefunc(LO, "SetDataPanelStyle", function()
		for k, v in pairs(extrapanel) do
			if(E.db.datatexts.panelTransparency) then
				_G[("Actionbar%dDataPanel"):format(k)]:SetTemplate("Transparent");
			else
				_G[("Actionbar%dDataPanel"):format(k)]:SetTemplate("Default", true);
			end
		end
	end);
end

E:RegisterModule(EDT:GetName());