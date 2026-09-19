-- Vibecoded Better Anti Fling, integrates itself into the Classic Style Matcha UI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local steppedConnection = nil
local cachedParts = {}
local originalCollision = {}
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
						count += 1
						newCache[count] = object

						-- Only save the original state once.
						if originalCollision[object] == nil then
							originalCollision[object] = object.CanCollide
						end

						object.CanCollide = false
					end
				end
			end
		end
	end

	cachedParts = newCache
end

local function enforceAntiFling(dt)
	-- Hot path: no GetDescendants() here.
	for i = 1, #cachedParts do
		cachedParts[i].CanCollide = false
	end

	-- Occasionally pick up newly created character parts/accessories.
	refreshTimer += dt

	if refreshTimer >= 0.25 then
		refreshTimer = 0
		rebuildCache()
	end
end

local function restoreCollisions()
	for part, originalState in pairs(originalCollision) do
		part.CanCollide = originalState
	end

	cachedParts = {}
	originalCollision = {}
end

local function setAntiFling(state)
	if state then
		if steppedConnection then
			return
		end

		refreshTimer = 0
		rebuildCache()

		steppedConnection = RunService.Stepped:Connect(enforceAntiFling)
	else
		-- Stop enforcement FIRST.
		if steppedConnection then
			steppedConnection:Disconnect()
			steppedConnection = nil
		end

		-- Then restore what every part had before Anti-Fling.
		restoreCollisions()

		refreshTimer = 0
	end
end

UI.AddTab("Anti Fling", function(tab)
	local sec = tab:Section("Protection", "Left")

	sec:Toggle("anti_fling", "Anti-Fling", false, function(state)
		setAntiFling(state)
	end)
end)
