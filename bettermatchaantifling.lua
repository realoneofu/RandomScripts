-- Vibecoded Better Anti Fling, integrates itself into the Classic Style Matcha UI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local antiFlingEnabled = false
local steppedConnection = nil

-- Cached BaseParts belonging to other players.
-- Avoids doing GetDescendants() every physics frame.
local cachedParts = {}
local refreshTimer = 0

local function rebuildCache()
	local newCache = {}
	local count = 0

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local character = player.Character

			if character then
				for _, object in ipairs(character:GetDescendants()) do
					if object:IsA("BasePart") then
						count = count + 1
						newCache[count] = object

						-- Apply immediately during refresh too
						object.CanCollide = false
					end
				end
			end
		end
	end

	cachedParts = newCache
end

local function enforceAntiFling(dt)
	-- Enforce collision state immediately before physics.
	for i = 1, #cachedParts do
		local part = cachedParts[i]

		-- Don't bother reading CanCollide first.
		-- Just force the desired value.
		part.CanCollide = false
	end

	-- Characters/accessories can change at runtime.
	-- Periodically rebuild the cache without doing
	-- GetDescendants() every frame.
	refreshTimer = refreshTimer + dt

	if refreshTimer >= 0.25 then
		refreshTimer = 0
		rebuildCache()
	end
end

local function setAntiFling(state)
	antiFlingEnabled = state

	if state then
		if steppedConnection then
			return
		end

		refreshTimer = 0

		-- Populate + disable everything immediately.
		rebuildCache()

		steppedConnection = RunService.Stepped:Connect(function(dt)
			if antiFlingEnabled then
				enforceAntiFling(dt)
			end
		end)
	else
		if steppedConnection then
			steppedConnection:Disconnect()
			steppedConnection = nil
		end

		cachedParts = {}
		refreshTimer = 0
	end
end


UI.AddTab("Anti Fling", function(tab)
	local sec = tab:Section("Protection", "Left")

	sec:Toggle("anti_fling", "Anti-Fling", false, function(state)
		setAntiFling(state)
	end)
end)
