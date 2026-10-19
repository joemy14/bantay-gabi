local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RED = Color3.fromRGB(220, 20, 20)
local RED_DARK = Color3.fromRGB(110, 0, 0)
local BLACK = Color3.fromRGB(15, 0, 0)
local WHITE = Color3.new(1, 1, 1)

local gui = Instance.new("ScreenGui")
gui.Name = "LobbyMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local stack = Instance.new("Frame")
stack.Size = UDim2.fromOffset(120, 240)
stack.Position = UDim2.new(0, 12, 0.5, -120)
stack.BackgroundTransparency = 1
stack.Parent = gui

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = stack

local buttons = {
	{ name = "Shop", order = 1, action = function() print("Open shop") end },
	{ name = "Classes", order = 2, action = function() print("Open classes") end },
	{ name = "Journal", order = 3, action = function() print("Open journal") end },
}

for _, info in ipairs(buttons) do
	local lip = Instance.new("Frame")
	lip.Size = UDim2.new(1, 0, 0, 52)
	lip.LayoutOrder = info.order
	lip.BackgroundColor3 = RED_DARK
	lip.BorderSizePixel = 0
	lip.Parent = stack
	Instance.new("UICorner", lip).CornerRadius = UDim.new(0, 12)

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 52)
	button.Position = UDim2.new(0, 0, 0, -4)
	button.BackgroundColor3 = BLACK
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Font = Enum.Font.GothamBlack
	button.Text = string.upper(info.name)
	button.TextColor3 = WHITE
	button.TextScaled = true
	button.Parent = lip
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke")
	stroke.Color = RED
	stroke.Thickness = 3
	stroke.Parent = button

	button.MouseButton1Down:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.08), { Position = UDim2.new(0, 0, 0, -1) }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), { Position = UDim2.new(0, 0, 0, -4) }):Play()
	end)
	button.Activated:Connect(info.action)
end