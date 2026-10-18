local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Config = require(ReplicatedStorage.Shared.Config)
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RED = Color3.fromRGB(220, 20, 20)
local RED_DARK = Color3.fromRGB(110, 0, 0)
local BLACK = Color3.fromRGB(15, 0, 0)
local WHITE = Color3.new(1, 1, 1)

local PANEL_SIZE = UDim2.fromOffset(280, 340)

local DESCRIPTIONS = {
	Tanod = "Sturdy guardian. Takes more hits.",
	Manghihilot = "Healer. Mends allies on the spot.",
	Albularyo = "Charm caster. Wards off the undead.",
}

local gui = Instance.new("ScreenGui")
gui.Name = "ClassPicker"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.new(0, 0, 0)
overlay.BackgroundTransparency = 0.4
overlay.BorderSizePixel = 0
overlay.Parent = gui

local panel = Instance.new("Frame")
panel.Size = PANEL_SIZE
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.5)
panel.BackgroundColor3 = BLACK
panel.BorderSizePixel = 0
panel.Parent = overlay
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = RED
panelStroke.Thickness = 4
panelStroke.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -24, 0, 46)
title.Position = UDim2.new(0, 12, 0, 12)
title.BackgroundColor3 = RED
title.BorderSizePixel = 0
title.Font = Enum.Font.GothamBlack
title.Text = "PICK YOUR CLASS"
title.TextColor3 = WHITE
title.TextScaled = true
title.Parent = panel
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local titleStroke = Instance.new("UIStroke")
titleStroke.Color = RED_DARK
titleStroke.Thickness = 3
titleStroke.Parent = title

for i, className in ipairs(Config.Classes) do
	local y = 72 + (i - 1) * 74

	local lip = Instance.new("Frame")
	lip.Size = UDim2.new(1, -32, 0, 62)
	lip.Position = UDim2.new(0, 16, 0, y + 5)
	lip.BackgroundColor3 = RED_DARK
	lip.BorderSizePixel = 0
	lip.Parent = panel
	Instance.new("UICorner", lip).CornerRadius = UDim.new(0, 12)

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -32, 0, 62)
	button.Position = UDim2.new(0, 16, 0, y)
	button.BackgroundColor3 = RED
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Text = ""
	button.Parent = panel
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -20, 0, 28)
	nameLabel.Position = UDim2.new(0, 10, 0, 6)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Font = Enum.Font.GothamBlack
	nameLabel.Text = string.upper(className)
	nameLabel.TextColor3 = WHITE
	nameLabel.TextScaled = true
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = button

	local descLabel = Instance.new("TextLabel")
	descLabel.Size = UDim2.new(1, -20, 0, 18)
	descLabel.Position = UDim2.new(0, 10, 0, 36)
	descLabel.BackgroundTransparency = 1
	descLabel.Font = Enum.Font.GothamMedium
	descLabel.Text = DESCRIPTIONS[className] or ""
	descLabel.TextColor3 = Color3.fromRGB(255, 220, 220)
	descLabel.TextScaled = true
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.Parent = button

	button.MouseButton1Down:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.08), { Position = UDim2.new(0, 18, 0, y + 3) }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), { Position = UDim2.new(0, 16, 0, y) }):Play()
	end)

	button.Activated:Connect(function()
		player:SetAttribute("Class", className)
		TweenService:Create(panel, TweenInfo.new(0.2), { Size = UDim2.fromOffset(0, 0) }):Play()
		task.delay(0.2, function() gui:Destroy() end)
	end)
end

-- Pop-in
panel.Size = UDim2.fromOffset(0, 0)
TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back), { Size = PANEL_SIZE }):Play()