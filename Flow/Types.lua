--!strict

--[[======================================================================

Types | Written by Devi (Devollin) | 2021 | v1.0.1
	Description: Contains a list of userdata functions used in easing.

========================================================================]]

return {
	["CFrame"] = function(i: CFrame, g: CFrame, t: number)
		return i:Lerp(g, t)
	end,
	["Vector3"] = function(i: Vector3, g: Vector3, t: number)
		return i:Lerp(g, t)
	end,
	["Vector3int16"] = function(i: Vector3int16, g: Vector3int16, t: number)
		local lerped = Vector3.new(i.X, i.Y, i.Z):Lerp(Vector3.new(g.X, g.Y, g.Z), t)
		return Vector3int16.new(math.round(lerped.X), math.round(lerped.Y), math.round(lerped.Z))
	end,
	["Vector2"] = function(i: Vector2, g: Vector2, t: number)
		return i:Lerp(g, t)
	end,
	["Vector2int16"] = function(i: Vector2int16, g: Vector2int16, t: number)
		local lerped = Vector2.new(i.X, i.Y):Lerp(Vector2.new(g.X, g.Y), t)
		return Vector2int16.new(math.round(lerped.X), math.round(lerped.Y))
	end,
	["Color3"] = function(i: Color3, g: Color3, t: number)
		return i:Lerp(g, t)
	end,
	["Rect"] = function(i: Rect, g: Rect, t: number)
		return Rect.new(i.Min:Lerp(g.Min, t), i.Max:Lerp(g.Max, t))
	end,
	["UDim"] = function(i: UDim, g: UDim, t: number)
		return UDim.new(((g.Scale - i.Scale) * t) + (i.Scale - g.Scale), ((g.Offset - i.Offset) * t) + (i.Offset - g.Offset))
	end,
	["UDim2"] = function(i: UDim2, g: UDim2, t: number)
		return i:Lerp(g, t)
	end,
	["NumberRange"] = function(i: NumberRange, g: NumberRange, t: number)
		return NumberRange.new(((g.Min - i.Min) * t) + (i.Min - g.Min), ((g.Max - i.Max) * t) + (i.Max - g.Max))
	end,
	["number"] = function(i: number, g: number, t: number)
		return i + ((g - i) * t)
	end,
	["boolean"] = function(i: boolean, g: boolean, t: number)
		return math.round(((g and 1 or 0) - (i and 1 or 0)) * t) == 1
	end,
	["Region3"] = function(i: Region3, g: Region3, t: number)
		local m1 = (i.CFrame.RightVector * (i.Size.Z / 2)) + (i.CFrame.UpVector * (i.Size.Y / 2)) - (i.CFrame.LookVector * (i.Size.X / 2))
		local m2 = (g.CFrame.RightVector * (g.Size.Z / 2)) + (g.CFrame.UpVector * (g.Size.Y / 2)) - (g.CFrame.LookVector * (g.Size.X / 2))
		local a, b, c, d = i.CFrame.Position - m1, i.CFrame.Position + m1, g.CFrame.Position - m2, g.CFrame.Position + m2
		local e, f = a:Lerp(c, t), b:Lerp(d, t)
		return Region3.new(e, f)
	end,
	["Region3int16"] = function(i: Region3, g: Region3, t: number)
		local m1 = (i.CFrame.RightVector * (i.Size.Z / 2)) + (i.CFrame.UpVector * (i.Size.Y / 2)) - (i.CFrame.LookVector * (i.Size.X / 2))
		local m2 = (g.CFrame.RightVector * (g.Size.Z / 2)) + (g.CFrame.UpVector * (g.Size.Y / 2)) - (g.CFrame.LookVector * (g.Size.X / 2))
		local a, b, c, d = i.CFrame.Position - m1, i.CFrame.Position + m1, g.CFrame.Position - m2, g.CFrame.Position + m2
		local e, f = a:Lerp(c, t), b:Lerp(d, t)
		return Region3int16.new(Vector3int16.new(e.X, e.Y, e.Z), Vector3int16.new(f.X, f.Y, f.Z))
	end,
	
	["ColorSequence"] = function(i: ColorSequence, g: ColorSequence, t: number)
		return g -- TODO: Add in support for ColorSequence tweening!
	end,
	["NumberSequence"] = function(i: NumberSequence, g: NumberSequence, t: number)
		return g -- TODO: Add in support for NumberSequence tweening!
	end,
}
