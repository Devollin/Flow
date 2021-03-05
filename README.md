# Flow

**_Notice: this module is not finished, but basic tweening and tweening dictionary values are currently complete._**

**_Flow_** is an **open source** module to tween nearly anything in **Roblox** in an easy to use function, while also being capable of handling:

- Preset modifiers (Ability to define parameters for time and the like; along with the ability to augment them or not use them at all)
- Bezier Curves (May break off into an add-on; not implemented yet)
- Tweening DataTypes that are not natively able to be tweened and / or lerped
	- NumberSequence (Soon)
	- ColorSequence (Soon)
	- Vector3int16
	- Vector2int16
	- UDim
	- Region3
	- Region3int16
	- Rect
	- NumberRange
- Model tweening (May break off into an add-on; not implemented yet)
- Tweening non-instance (dictionary) objects

## Usage

```lua
local Flow = require(game:GetService("ReplicatedStorage").Flow) -- Or wherever you want to put it!

local partStart = workspace.Start
local partMiddle = workspace.Middle
local partEnd = workspace.End

local startCFrame = partStart.CFrame
local middleCFrame = partMiddle.CFrame
local endCFrame = partEnd.CFrame

local dictionary = {hi = 10, bye = UDim2.new(0, 500, 0, 300)}

local newFlow = Flow(partStart, {CFrame = partEnd.CFrame}, {T = 1})
newFlow.Completed = function()
	print("Completed!")
end

newFlow.Cancelled = function()
	print("Cancelled!")
end

local otherFlow = Flow(dictionary, {hi = 20, bye = UDim2.new(0.5, 0, 0.5, 0)}, {Preset = "Usual"})
otherFlow.Stepped = function()
	print(dictionary.hi, dictionary.bye)
end

wait(0.5)

newFlow:Stop()
```
