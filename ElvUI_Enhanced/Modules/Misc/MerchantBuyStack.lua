local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local select = select
local ceil = math.ceil

local BuyMerchantItem = BuyMerchantItem
local GetItemInfo = GetItemInfo
local GetMerchantItemInfo = GetMerchantItemInfo
local GetMerchantItemLink = GetMerchantItemLink
local GetMerchantItemMaxStack = GetMerchantItemMaxStack
local IsAltKeyDown = IsAltKeyDown

function M:MerchantItemButton_OnModifiedClick(button)
	if IsAltKeyDown() then
		local id = button:GetID()
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(id)))

		if maxStack and maxStack > 1 then
			local stack = GetMerchantItemMaxStack(id)

			if stack > 1 then
				BuyMerchantItem(id, stack)
				return
			else
				local _, _, _, quantity, numAvailable = GetMerchantItemInfo(id)
				quantity = ceil(maxStack / quantity)

				if numAvailable > -1 and numAvailable < quantity then
					quantity = numAvailable
				end

				if quantity > 1 then
					BuyMerchantItem(id, quantity)
					return
				end
			end
		end

		BuyMerchantItem(id)
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