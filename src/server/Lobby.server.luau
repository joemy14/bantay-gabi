local Workspace = game:GetService("Workspace")

local spawnPart = Instance.new("SpawnLocation")
spawnPart.Name = "LobbySpawn"
spawnPart.Size = Vector3.new(12, 1, 12)
spawnPart.Position = Vector3.new(0, 5, 0)
spawnPart.Anchored = true
spawnPart.Neutral = true
spawnPart.Parent = Workspace

local floor = Instance.new("Part")
floor.Name = "LobbyFloor"
floor.Size = Vector3.new(120, 1, 120)
floor.Position = Vector3.new(0, 0, 0)
floor.Anchored = true
floor.Parent = Workspace
