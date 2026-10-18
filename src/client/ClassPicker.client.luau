local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage.Shared.Config)
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "ClassPicker"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 220)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Text = "Pick your class"
title.Parent = frame

for i, className in ipairs(Config.Classes) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.9, 0, 0, 40)
	button.Position = UDim2.new(0.05, 0, 0, 40 + (i - 1) * 50)
	button.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextScaled = true
	button.Text = className
	button.Parent = frame

	button.Activated:Connect(function()
		player:SetAttribute("Class", className)
		gui:Destroy()
	end)
end