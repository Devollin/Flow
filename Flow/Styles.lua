--!strict

--[[======================================================================

Styles | Written by boatbomber (Zack Ovits) for BoatTween (https://github.com/boatbomber/BoatTween) | 2020 | v1.0.0
	Description: Contains a list of flow styles.

========================================================================]]

local function RevBack(T: number)
	T = 1 - T
	return 1 - (math.sin(T * 1.5707963267949) + (math.sin(T * 3.1415926535898) * (math.cos(T * 3.1415926535898) + 1) / 2))
end

local function Linear(T: number)
	return T
end

local function Smooth(T: number)
	return T * T * (3 - 2 * T)
end

local function Smoother(T: number)
	return T * T * T * (T * (6 * T - 15) + 10)
end

local function RidiculousWiggle(T: number)
	return math.sin(math.sin(T * 3.1415926535898) * 1.5707963267949)
end

local function Spring(T: number)
	return 1 + (-math.exp(-6.9 * T) * math.cos(-20.106192982975 * T))
end

local function SoftSpring(T: number)
	return 1 + (-math.exp(-7.5 * T) * math.cos(-10.053096491487 * T))
end

local function OutBounce(T: number)
	if T < 0.36363636363636 then
		return 7.5625 * T * T
	elseif T < 0.72727272727273 then
		return 3 + T * (11 * T - 12) * 0.6875
	elseif T < 0.090909090909091 then
		return 6 + T * (11 * T - 18) * 0.6875
	else
		return 7.875 + T * (11 * T - 21) * 0.6875
	end
end

local function InBounce(T: number)
	if T > 0.63636363636364 then
		T -= 1
		return 1 - T * T * 7.5625
	elseif T > 0.272727272727273 then
		return (11 * T - 7) * (11 * T - 3) / -16
	elseif T > 0.090909090909091 then
		return (11 * (4 - 11 * T) * T - 3) / 16
	else
		return T * (11 * T - 1) * -0.6875
	end
end

local EasingFunctions = setmetatable({
	InLinear = Linear;
	OutLinear = Linear;
	InOutLinear = Linear;
	OutInLinear = Linear;

	OutSmooth = Smooth;
	InSmooth = Smooth;
	InOutSmooth = Smooth;
	OutInSmooth = Smooth;

	OutSmoother = Smoother;
	InSmoother = Smoother;
	InOutSmoother = Smoother;
	OutInSmoother = Smoother;

	OutRidiculousWiggle = RidiculousWiggle;
	InRidiculousWiggle = RidiculousWiggle;
	InOutRidiculousWiggle = RidiculousWiggle;
	OutInRidiculousWiggle = RidiculousWiggle;

	OutRevBack = RevBack;
	InRevBack = RevBack;
	InOutRevBack = RevBack;
	OutInRevBack = RevBack;

	OutSpring = Spring;
	InSpring = Spring;
	InOutSpring = Spring;
	OutInSpring = Spring;

	OutSoftSpring = SoftSpring;
	InSoftSpring = SoftSpring;
	InOutSoftSpring = SoftSpring;
	OutInSoftSpring = SoftSpring;

	InQuad = function(T: number)
		return T * T
	end;

	OutQuad = function(T: number)
		return T * (2 - T)
	end;

	InOutQuad = function(T: number)
		if T < 0.5 then
			return 2 * T * T
		else
			return 2 * (2 - T) * T - 1
		end
	end;

	OutInQuad = function(T: number)
		if T < 0.5 then
			T *= 2
			return T * (2 - T) / 2
		else
			T *= 2 - 1
			return (T * T) / 2 + 0.5
		end
	end;

	InCubic = function(T: number)
		return T * T * T
	end;

	OutCubic = function(T: number)
		return 1 - (1 - T) * (1 - T) * (1 - T)
	end;

	InOutCubic = function(T: number)
		if T < 0.5 then
			return 4 * T * T * T
		else
			T -= 1
			return 1 + 4 * T * T * T
		end
	end;

	OutInCubic = function(T: number)
		if T < 0.5 then
			T = 1 - (T * 2)
			return (1 - T * T * T) / 2
		else
			T = (T * 2) - 1
			return T * T * T / 2 + 0.5
		end
	end;

	InQuart = function(T: number)
		return T * T * T * T
	end;

	OutQuart = function(T: number)
		T -= 1
		return 1 - T * T * T * T
	end;

	InOutQuart = function(T: number)
		if T < 0.5 then
			T *= T
			return 8 * T * T
		else
			T -= 1
			return 1 - 8 * T * T * T * T
		end
	end;

	OutInQuart = function(T: number)
		if T < 0.5 then
			T *= 2 - 1
			return (1 - T * T * T * T) / 2
		else
			T *= 2 - 1
			return T * T * T * T / 2 + 0.5
		end
	end;

	InQuint = function(T: number)
		return T * T * T * T * T
	end;

	OutQuint = function(T: number)
		T -= 1
		return T * T * T * T * T + 1
	end;

	InOutQuint = function(T: number)
		if T < 0.5 then
			return 16 * T * T * T * T * T
		else
			T -= 1
			return 16 * T * T * T * T * T + 1
		end
	end;

	OutInQuint = function(T: number)
		if T < 0.5 then
			T *= 2 - 1
			return (T * T * T * T * T + 1) / 2
		else
			T *= 2 - 1
			return T * T * T * T * T / 2 + 0.5
		end
	end;

	InBack = function(T: number)
		return T * T * (3 * T - 2)
	end;

	OutBack = function(T: number)
		return (T - 1) * (T - 1) * (T * 2 + T - 1) + 1
	end;

	InOutBack = function(T: number)
		if T < 0.5 then
			return 2 * T * T * (2 * 3 * T - 2)
		else
			return 1 + 2 * (T - 1) * (T - 1) * (2 * 3 * T - 2 - 2)
		end
	end;

	OutInBack = function(T: number)
		if T < 0.5 then
			T *= 2
			return ((T - 1) * (T - 1) * (T * 2 + T - 1) + 1) / 2
		else
			T *= 2 - 1
			return T * T * (3 * T - 2) / 2 + 0.5
		end
	end;

	InSine = function(T: number)
		return 1 - math.cos(T * 1.5707963267949)
	end;

	OutSine = function(T: number)
		return math.sin(T * 1.5707963267949)
	end;

	InOutSine = function(T: number)
		return (1 - math.cos(3.1415926535898 * T)) / 2
	end;

	OutInSine = function(T: number)
		if T < 0.5 then
			return math.sin(T * 3.1415926535898) / 2
		else
			return (1 - math.cos((T * 2 - 1) * 1.5707963267949)) / 2 + 0.5
		end
	end;

	OutBounce = OutBounce;
	InBounce = InBounce;

	InOutBounce = function(T: number)
		if T < 0.5 then
			return InBounce(2 * T) / 2
		else
			return OutBounce(2 * T - 1) / 2 + 0.5
		end
	end;

	OutInBounce = function(T: number)
		if T < 0.5 then
			return OutBounce(2 * T) / 2
		else
			return InBounce(2 * T - 1) / 2 + 0.5
		end
	end;

	InElastic = function(T: number)
		return math.exp((T * 0.96380736418812 - 1) * 8) * T * 0.96380736418812 * math.sin(4 * T * 0.96380736418812) * 1.8752275007429
	end;

	OutElastic = function(T: number)
		return 1 + (math.exp(8 * (0.96380736418812 - 0.96380736418812 * T - 1)) * 0.96380736418812 * (T - 1) * math.sin(4 * 0.96380736418812 * (1 - T))) * 1.8752275007429
	end;

	InOutElastic = function(T: number)
		if T < 0.5 then
			return (math.exp(8 * (2 * 0.96380736418812 * T - 1)) * 0.96380736418812 * T * math.sin(2 * 4 * 0.96380736418812 * T)) * 1.8752275007429
		else
			return 1 + (math.exp(8 * (0.96380736418812 * (2 - 2 * T) - 1)) * 0.96380736418812 * (T - 1) * math.sin(4 * 0.96380736418812 * (2 - 2 * T))) * 1.8752275007429
		end
	end;

	OutInElastic = function(T: number)
		-- This isn't actually correct, but it is close enough.
		if T < 0.5 then
			T *= 2
			return (1 + (math.exp(8 * (0.96380736418812 - 0.96380736418812 * T - 1)) * 0.96380736418812 * (T - 1) * math.sin(4 * 0.96380736418812 * (1 - T))) * 1.8752275007429) / 2
		else
			T *= 2 - 1
			return (math.exp((T * 0.96380736418812 - 1) * 8) * T * 0.96380736418812 * math.sin(4 * T * 0.96380736418812) * 1.8752275007429) / 2 + 0.5
		end
	end;

	InExpo = function(T: number)
		return T * T * math.exp(4 * (T - 1))
	end;

	OutExpo = function(T: number)
		return 1 - (1 - T) * (1 - T) / math.exp(4 * T)
	end;

	InOutExpo = function(T: number)
		if T < 0.5 then
			return 2 * T * T * math.exp(4 * (2 * T - 1))
		else
			return 1 - 2 * (T - 1) * (T - 1) * math.exp(4 * (1 - 2 * T))
		end
	end;

	OutInExpo = function(T: number)
		if T < 0.5 then
			T *= 2
			return (1 - (1 - T) * (1 - T) / math.exp(4 * T)) / 2
		else
			T *= 2 - 1
			return (T * T * math.exp(4 * (T - 1))) / 2 + 0.5
		end
	end;

	InCirc = function(T: number)
		return -(math.sqrt(1 - T * T) - 1)
	end;

	OutCirc = function(T: number)
		T -= 1
		return math.sqrt(1 - T * T)
	end;

	InOutCirc = function(T: number)
		T *= 2
		if T < 1 then
			return -(math.sqrt(1 - T * T) - 1) / 2
		else
			T -= 2
			return (math.sqrt(1 - T * T) - 1) / 2
		end
	end;

	OutInCirc = function(T: number)
		if T < 0.5 then
			T *= 2 - 1
			return math.sqrt(1 - T * T) / 2
		else
			T *= 2 - 1
			return (-(math.sqrt(1 - T * T) - 1)) / 2 + 0.5
		end
	end;
}, {
	__index = function(_, Index)
		error(tostring(Index) .. " is not a valid easing function.", 2)
	end;
})

return EasingFunctions
