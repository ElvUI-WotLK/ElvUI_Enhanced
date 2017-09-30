local oUF = ElvUF or oUF;

local function GetHealthLossAnimationData(frame, currentHealth, previousHealth)
	if(frame.startTime) then
		local totalElapsedTime = GetTime() - frame.startTime;
		if(totalElapsedTime > 0) then
			local completePercent = totalElapsedTime / frame.duration;
			if(completePercent < 1 and previousHealth > currentHealth) then
				local healthDelta = previousHealth - currentHealth;
				local lossAmount = previousHealth - (completePercent * healthDelta);
				return lossAmount, completePercent;
			end
		else
			return previousHealth, 0;
		end
	end
	return 0, 1;
end

local Update = function(self, event, unit)
	local animatedLoss = self.AnimatedLoss;
	if(not animatedLoss) then return; end

	local health = self.Health;
	if(health.disconnected) then return; end

	if(animatedLoss.PreUpdate) then animatedLoss:PreUpdate(unit); end

	local min, max = UnitHealth(unit), UnitHealthMax(unit);
	animatedLoss:SetMinMaxValues(0, max);

	if(min ~= animatedLoss.min) then
		local delta = min - animatedLoss.min;
		local hasLoss = delta < 0;
		local hasBegun = animatedLoss.startTime ~= nil;
		local isAnimating = hasBegun and animatedLoss.completePercent > 0;

		if(hasLoss and not hasBegun) then
			animatedLoss.startValue = animatedLoss.min - min;
			animatedLoss.startTime = GetTime() + animatedLoss.startDelay;
			animatedLoss.completePercent = 0;
			animatedLoss:Show();
			animatedLoss:SetValue(animatedLoss.startValue);
		elseif(hasLoss and hasBegun and not isAnimating) then
			animatedLoss.startTime = animatedLoss.startTime + animatedLoss.postponeDelay;
		elseif(hasLoss and isAnimating) then
			animatedLoss.startValue = GetHealthLossAnimationData(animatedLoss, animatedLoss.min - min, animatedLoss.startValue);
			animatedLoss.startTime = GetTime() + animatedLoss.pauseDelay;
		end
		animatedLoss.min = min;
	end

	if(animatedLoss.startTime) then
		local value, completePercent = GetHealthLossAnimationData(animatedLoss, animatedLoss.min - min, animatedLoss.startValue);
		animatedLoss.completePercent = completePercent;
		if(completePercent >= 1) then
			animatedLoss:Hide();
			animatedLoss.startTime = nil;
			animatedLoss.completePercent = nil;
		else
			animatedLoss:SetValue(value);
		end

		local r, g, b;
		if(animatedLoss.colorSmooth) then
			r, g, b = self.ColorGradient(min, max, 1, 0, 0, 1, 1, 0, 0, 1, 0);
		else
			r, g, b = 1, 0, 0;
		end

		animatedLoss:SetStatusBarColor(r, g, b);
	end

	if(animatedLoss.PostUpdate) then
		return animatedLoss:PostUpdate(unit);
	end
end

local Path = function(self, ...)
	return (self.AnimatedLoss.Override or Update)(self, ...);
end

local OnAnimatedLossUpdate = function(self)
	return Path(self, "OnAnimatedLossUpdate", self.unit);
end

local Enable = function(self, unit)
	local animatedLoss = self.AnimatedLoss;
	if(animatedLoss) then
		animatedLoss.min = UnitHealth("player");

		animatedLoss.hook = self:GetScript("OnUpdate");
		self:HookScript("OnUpdate", OnAnimatedLossUpdate);
		--animatedLoss:SetScript("OnUpdate", OnAnimatedLossUpdate);

		animatedLoss.duration = .75;
		animatedLoss.startDelay = .2;
		animatedLoss.pauseDelay = .05;
		animatedLoss.postponeDelay = .05;

		if(not animatedLoss:GetStatusBarTexture()) then
			animatedLoss:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
		end

		return true;
	end
end

local Disable = function(self)
	local animatedLoss = self.AnimatedLoss;
	if(animatedLoss) then
		if(self:GetScript("OnUpdate")) then
			self:SetScript("OnUpdate", animatedLoss.hook);
		end
		--if(animatedLoss:GetScript("OnUpdate")) then
		--	animatedLoss:SetScript("OnUpdate", nil);
		--end
	end
end

oUF:AddElement("AnimatedLoss", Update, Enable, Disable);