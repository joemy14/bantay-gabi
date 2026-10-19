local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local BRICK = Color3.fromRGB(142, 52, 56)
local MAROON = Color3.fromRGB(74, 28, 32)
local WINE_BLACK = Color3.fromRGB(38, 22, 24)
local TEXT = Color3.fromRGB(232, 220, 218)
local ICON = Color3.fromRGB(214, 190, 188)

local function mk(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = parent
	return o
end

-- Icons sit in their own left column, so they never overlap the label
local function drawIcon(parent, kind)
	local holder = mk("Frame", {
		Size = UDim2.fromOffset(26, 26),
		Position = UDim2.new(0, 10, 0.5, -13),
		BackgroundTransparency = 1,
	}, parent)

	if kind == "shop" then
		-- bag: body plus handle
		mk("Frame", { Size = UDim2.fromScale(1, 0.8), Position = UDim2.fromScale(0, 0.2), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
		mk("Frame", { Size = UDim2.fromScale(0.5, 0.35), Position = UDim2.fromScale(0.25, 0), BackgroundTransparency = 1 }, holder)
		local handle = holder:FindFirstChildWhichIsA("Frame")
		mk("UIStroke", { Color = ICON, Thickness = 3 }, handle)
		Instance.new("UICorner", handle).CornerRadius = UDim.new(0.5, 0)
	elseif kind == "shield" then
		local s = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", s).CornerRadius = UDim.new(0.3, 0)
		mk("Frame", { Size = UDim2.fromScale(0.4, 0.4), Position = UDim2.fromScale(0.3, 0.3), BackgroundColor3 = BRICK, BorderSizePixel = 0 }, holder)
	elseif kind == "book" then
		local b = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", b).CornerRadius = UDim.new(0.15, 0)
		mk("Frame", { Size = UDim2.fromScale(0.18, 1), BackgroundColor3 = BRICK, BorderSizePixel = 0 }, holder)
	end
end

local gui = mk("ScreenGui", { Name = "LobbyMenu", ResetOnSpawn = false }, playerGui)

local stack = mk("Frame", {
	Size = UDim2.fromOffset(112, 150),
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
	local lip = mk("Frame", { Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = MAROON, BorderSizePixel = 0, LayoutOrder = i }, stack)
	Instance.new("UICorner", lip).CornerRadius = UDim.new(0, 10)

	local button = mk("TextButton", {
		Size = UDim2.new(1, 0, 0, 40),
		Position = UDim2.new(0, 0, 0, -3),
		BackgroundColor3 = WINE_BLACK,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.GothamBlack,
		Text = string.upper(info.name),
		TextColor3 = TEXT,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, lip)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)
	mk("UIPadding", { PaddingLeft = UDim.new(0, 44), PaddingRight = UDim.new(0, 8) }, button)
	mk("UIStroke", { Color = BRICK, Thickness = 2 }, button)
	drawIcon(button, info.icon)

	button.MouseButton1Down:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.08), { Position = UDim2.new(0, 0, 0, -1) }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), { Position = UDim2.new(0, 0, 0, -3) }):Play()
	end)
	button.Activated:Connect(info.action)
end