--!strict

--[[======================================================================

Presets | Written by Devi (Devollin) | 2021 | v1.0.0
	Description: Contains a list of user-defined and pre-designated 
		flow modifiers.

========================================================================]]

local presets = {
	Default = {                        -- DO NOT REMOVE THIS TABLE.
		Time        = 0.25,            -- [T] Duration of the flow.
		Style       = "OutLinear",     -- [S] The style of the flow.
		AutoPlay    = true,            -- [AP] Plays on creation.
		Destroy     = true,            -- [D] Destroys on finish.
		Reverses    = false,           -- [R] Reverse when completed.
		RepeatCount = 0,               -- [RC] Times to repeat; -1 is looped.
		DelayTime   = 0,               -- [DT] Time between each repeat.
		StepType    = "RenderStepped", -- [ST] Event to attach the update to.
	}, Usual = {
		Style       = "InOutQuad",
	}, TransitionIn = {
		Time        = 0.5,
		Style       = "OutBack",
	}, TransitionOut = {
		Time        = 0.5,
		Style       = "InBack",
	}
}

local interface = {}

function interface:Merge(name: any, modifiers: any)
	modifiers = modifiers or {}
	local preset = self:GetPreset(name)
	local result = {}
	
	for index, value in pairs(presets.Default) do
		local capture = modifiers[string.gsub(index, "%l", "")]
		if capture ~= nil then
			result[index] = capture
		else
			if preset[index] ~= nil then
				result[index] = preset[index]
			else
				if modifiers[index] ~= nil then
					result[index] = modifiers[index]
				else
					result[index] = value
				end
			end
		end
	end
	
	return result
end

function interface:GetPreset(name: string | nil)
	return presets[name or "Default"] or presets.Default
end

return interface
