local Workspace = game:GetService("Workspace")

-- Match floor, placed well away from the lobby (lobby is at 0, 0, 0)
local matchFloor = Instance.new("Part")
matchFloor.Name = "MatchFloor"
matchFloor.Size = Vector3.new(120, 1, 120)
matchFloor.Position = Vector3.new(0, 0, 300)
matchFloor.Anchored = true
matchFloor.Parent = Workspace

-- Pad in the lobby that sends players to the match area
local toMatchPad = Instance.new("Part")
toMatchPad.Name = "LobbyToMatchPad"
toMatchPad.Size = Vector3.new(8, 1, 8)
toMatchPad.Position = Vector3.new(0, 0.5, 40)
toMatchPad.Anchored = true
toMatchPad.Color = Color3.fromRGB(180, 0, 0)
toMatchPad.Parent = Workspace

local busy = false

toMatchPad.Touched:Connect(function(hit)
	if busy then return end
	local character = hit.Parent
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	busy = true
	character:PivotTo(matchFloor.CFrame + Vector3.new(0, 4, 0))
	task.delay(2, function() busy = false end)
end)