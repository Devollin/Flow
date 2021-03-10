--!strict

--[[======================================================================

Flow | Written by Devi (Devollin) | 2021 | v1.0.1
	Description: Interface for tweening.

========================================================================]]

local Styles = require(script.Styles)
local Presets = require(script.Presets)
local Types = require(script.Types)

local function applier(target: any, property: string, goal: any)
	local iterator = Types[typeof(goal)]
	if ((typeof(target) == "Instance") and (target:GetAttribute(property) ~= nil)) then
		local init = target:GetAttribute(property)
		return function(delta: number)
			target:SetAttribute(property, iterator(init, goal, delta))
		end
	else
		local init = target[property]
		return function(delta: number)
			target[property] = iterator(init, goal, delta)
		end
	end
end

local flow = {}
flow.__index = flow

function flow.new(targets: any, goals: any, modifiers: any)
	local applicators = {}
	if typeof(modifiers) == "table" then
		local preset = modifiers.Preset or modifiers.P or "Default"
		modifiers.P = nil
		modifiers.Preset = nil
		modifiers = Presets:Merge(preset, modifiers)
	else
		modifiers = Presets:Merge("Default", {})
	end
	if typeof(targets) == "table" then
		local valueType
		for _, target in pairs(targets) do
			valueType = typeof(target)
			break
		end
		if valueType == "Instance" then
			for _, target in ipairs(targets) do
				for property, goal in pairs(goals) do
					table.insert(applicators, applier(target, property, goal))
				end
			end
			-- I would enable this if I can be certain that the table isn't another set of data in the dictionary.

			--elseif valueType == "table" then
			--	for _, target in ipairs(targets) do
			--		for property, goal in pairs(goals) do
			--			table.insert(applicators, applier(target, property, goal))
			--		end
			--	end
		else
			for property, goal in pairs(goals) do
				table.insert(applicators, applier(targets, property, goal))
			end
		end
	else
		for property, goal in pairs(goals) do
			table.insert(applicators, applier(targets, property, goal))
		end
	end
	local newTargets = typeof(targets) == "table" and {} or targets
	if typeof(targets) == "table" then
		for index, target in pairs(targets) do
			newTargets[index] = target
		end
	end
	

	local self = setmetatable({
		targets = newTargets,
		goals = goals,
		applicators = applicators,
		connection = game:GetService("RunService")[modifiers.StepType]:Connect(function() end),
		modifiers = modifiers,
		duration = 0,
		repeats = modifiers.RepeatCount,
		running = false,
		reverse = modifiers.Reverses,
		direction = 1,
		style = Styles[modifiers.Style],
		died = false,
		Completed = nil,
		Stepped = nil,
		Cancelled = nil,
	}, flow)

	self.connection:Disconnect()
	self.connection = nil

	if self.modifiers.AutoPlay then
		self:Play()
	end

	return self
end

function flow:Play()
	self.running = true
	self.connection = self.connection or game:GetService("RunService")[self.modifiers.StepType]:Connect(function(step, deltaTime)
		local delta = deltaTime or step

		if not self.running then return end
		if self.died then self.connection:Disconnect() self.connection = nil return end

		spawn(function()
			self.duration = math.clamp(self.duration + delta, -self.modifiers.Time, self.modifiers.Time)
			if self.modifiers.Time <= self.duration then
				self.duration = 0
				if self.Completed then spawn(function() self.Completed() end) end
				if self.reverse then
					if self.direction == 1 then
						if self.repeats > 0 or self.repeats < 0 then
							self.repeats -= 1
						else
							self.running = false
							if self.connection then
								self.connection:Disconnect()
								self.connection = nil
								self.running = false
							end
							if self.modifiers.Destroy then
								self:Destroy()
							end
						end
					end
					self.direction = -1 * self.direction
				else
					if self.repeats > 0 or self.repeats < 0 then
						self.repeats -= 1
					else
						self.running = false
						if self.connection then
							self.connection:Disconnect()
							self.connection = nil
							self.running = false
						end
						if self.modifiers.Destroy then
							self:Destroy()
						end
					end
				end
			end
			for _, applicator in ipairs(self.applicators) do
				spawn(function()
					if (not self.connection) then applicator(self.died and 1 or 0) return end
					if self.direction == -1 then
						applicator(self.style(1 - (self.duration / self.modifiers.Time)))
					else
						applicator(self.style(self.duration / self.modifiers.Time))
					end
				end)
			end
			if self.Stepped then spawn(function() self.Stepped() end) end
		end)
	end)
end

function flow:Stop()
	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
		if self.Cancelled then spawn(function() self.Cancelled() end) end
	end
	self.running = false
	self.duration = 0
	if self.modifiers.Destroy then
		self:Destroy()
	end
end

function flow:Pause()
	self.running = false
	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end
end

function flow:Destroy()
	table.clear(self.applicators)
	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end
	self.died = true
	self.running = false
	if typeof(self.targets) == "table" then
		table.clear(self.targets)
	else
		self.targets = nil
	end
	self = nil
end

function flow:Restart()
	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end
	self.repeats = self.modifiers.RepeatCount
	self:Play()
end

return function(targets: any, goals: any, modifiers: any)
	local success, result = pcall(function()
		assert(targets and goals, "First and second parameters need to be defined in order to tween! " .. debug.traceback())
		assert(typeof(targets) == "table" or typeof(targets) == "Instance", "First parameter needs to be an Instance or array of Instances! " .. debug.traceback())
		assert(typeof(goals) == "table", "Second parameter needs to be an array! " .. debug.traceback())
		
		return flow.new(targets, goals, modifiers)
	end)
	if not success then
		warn("Failed to tween : " .. (result :: string))
		return
	end
	return result
end
