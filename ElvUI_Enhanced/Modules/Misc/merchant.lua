local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local BuyMerchantItem = BuyMerchantItem
local GetItemInfo = GetItemInfo
local GetMerchantItemLink = GetMerchantItemLink
local GetMerchantItemMaxStack = GetMerchantItemMaxStack

function M:MerchantItemButton_OnModifiedClick(self)
	if IsAltKeyDown() then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))

		if maxStack and maxStack > 1 then
			BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
		end
	end
end

function M:BuyStackToggle()
	if E.db.enhanced.general.altBuyMaxStack then
		if not self:IsHooked("MerchantItemButton_OnModifiedClick") then
			self:SecureHook("MerchantItemButton_OnModifiedClick")
		end
	else
		if self:IsHooked("MerchantItemButton_OnModifiedClick") then
			self:Unhook("MerchantItemButton_OnModifiedClick")
		end
	end
end