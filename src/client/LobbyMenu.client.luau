local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RED = Color3.fromRGB(220, 20, 20)
local RED_DARK = Color3.fromRGB(110, 0, 0)
local BLACK = Color3.fromRGB(15, 0, 0)
local WHITE = Color3.new(1, 1, 1)

local function mk(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = parent
	return o
end

-- Simple shape icons drawn from UI parts (original, no uploads needed)
local function drawIcon(parent, kind)
	local holder = mk("Frame", { Size = UDim2.fromOffset(22, 22), Position = UDim2.fromOffset(8, 7), BackgroundTransparency = 1 }, parent)
	if kind == "shop" then
		mk("Frame", { Size = UDim2.new(1, 0, 0.72, 0), Position = UDim2.new(0, 0, 0.28, 0), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
		mk("Frame", { Size = UDim2.new(0.5, 0, 0.4, 0), Position = UDim2.new(0.25, 0, 0, 0), BackgroundTransparency = 1 }, holder)
		local handle = holder:FindFirstChildWhichIsA("Frame", true)
		local stroke = Instance.new("UIStroke") stroke.Color = WHITE stroke.Thickness = 2 stroke.Parent = handle
		Instance.new("UICorner", handle).CornerRadius = UDim.new(0.5, 0)
	elseif kind == "shield" then
		local s = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", s).CornerRadius = UDim.new(0.35, 0)
		mk("Frame", { Size = UDim2.fromScale(0.45, 0.45), Position = UDim2.fromScale(0.275, 0.275), BackgroundColor3 = RED, BorderSizePixel = 0 }, holder)
	elseif kind == "book" then
		local b = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", b).CornerRadius = UDim.new(0.15, 0)
		mk("Frame", { Size = UDim2.fromScale(0.22, 1), BackgroundColor3 = RED, BorderSizePixel = 0 }, holder)
	end
end

local gui = mk("ScreenGui", { Name = "LobbyMenu", ResetOnSpawn = false }, playerGui)

local stack = mk("Frame", {
	Size = UDim2.fromOffset(96, 150),
	Position = UDim2.new(0, 12, 0.5, -75),
	BackgroundTransparency = 1,
}, gui)

mk("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, stack)

local buttons = {
	{ name = "Shop", icon = "shop", action = function() print("Open shop") end },
	{ name = "Classes", icon = "shield", action = function() print("Open classes") end },
	{ name = "Journal", icon = "book", action = function() print("Open journal") end },
}

for i, info in ipairs(buttons) do
	local lip = mk("Frame", { Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = RED_DARK, BorderSizePixel = 0, LayoutOrder = i }, stack)
	Instance.new("UICorner", lip).CornerRadius = UDim.new(0, 10)

	local button = mk("TextButton", {
		Size = UDim2.new(1, 0, 0, 40),
		Position = UDim2.new(0, 0, 0, -3),
		BackgroundColor3 = BLACK,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBlack,
		Text = string.upper(info.name),
		TextColor3 = WHITE,
		TextScaled = true,
	}, lip)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)
	mk("UIPadding", { PaddingLeft = UDim.new(0, 36), PaddingRight = UDim.new(0, 6) }, button)
	mk("UIStroke", { Color = RED, Thickness = 2 }, button)
	drawIcon(button, info.icon)

	button.MouseButton1Down:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.08), { Position = UDim2.new(0, 0, 0, -1) }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), { Position = UDim2.new(0, 0, 0, -3) }):Play()
	end)
	button.Activated:Connect(info.action)
end