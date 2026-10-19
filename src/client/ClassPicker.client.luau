local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Config = require(ReplicatedStorage.Shared.Config)
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local BRICK = Color3.fromRGB(142, 52, 56)
local MAROON = Color3.fromRGB(74, 28, 32)
local WINE_BLACK = Color3.fromRGB(38, 22, 24)
local TEXT = Color3.fromRGB(232, 220, 218)
local SOFT_TEXT = Color3.fromRGB(196, 166, 166)
local ICON = Color3.fromRGB(214, 190, 188)

local PANEL_SIZE = UDim2.fromOffset(250, 290)

local DESCRIPTIONS = {
	Tanod = "Sturdy guardian. Takes more hits.",
	Manghihilot = "Healer. Mends allies on the spot.",
	Albularyo = "Charm caster. Wards off the undead.",
}

local ICONS = { Tanod = "shield", Manghihilot = "cross", Albularyo = "moon" }

local function mk(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = parent
	return o
end

local function drawIcon(parent, kind)
	local holder = mk("Frame", {
		Size = UDim2.fromOffset(34, 34),
		Position = UDim2.new(1, -44, 0.5, -17),
		BackgroundTransparency = 1,
	}, parent)

	if kind == "shield" then
		local s = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", s).CornerRadius = UDim.new(0.3, 0)
		mk("Frame", { Size = UDim2.fromScale(0.4, 0.4), Position = UDim2.fromScale(0.3, 0.3), BackgroundColor3 = BRICK, BorderSizePixel = 0 }, holder)
	elseif kind == "cross" then
		mk("Frame", { Size = UDim2.fromScale(0.3, 1), Position = UDim2.fromScale(0.35, 0), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
		mk("Frame", { Size = UDim2.fromScale(1, 0.3), Position = UDim2.fromScale(0, 0.35), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
	elseif kind == "moon" then
		local m = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = ICON, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", m).CornerRadius = UDim.new(1, 0)
		local bite = mk("Frame", { Size = UDim2.fromScale(0.8, 0.8), Position = UDim2.fromScale(0.35, 0.02), BackgroundColor3 = MAROON, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", bite).CornerRadius = UDim.new(1, 0)
	end
end

local gui = mk("ScreenGui", { Name = "ClassPicker", ResetOnSpawn = false, IgnoreGuiInset = true }, playerGui)

local overlay = mk("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.5,
	BorderSizePixel = 0,
}, gui)

local panel = mk("Frame", {
	Size = PANEL_SIZE,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	BackgroundColor3 = WINE_BLACK,
	BorderSizePixel = 0,
}, overlay)
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)
mk("UIStroke", { Color = BRICK, Thickness = 3 }, panel)

mk("TextLabel", {
	Size = UDim2.new(1, -20, 0, 36),
	Position = UDim2.new(0, 10, 0, 10),
	BackgroundColor3 = BRICK,
	BorderSizePixel = 0,
	Font = Enum.Font.GothamBlack,
	Text = "PICK YOUR CLASS",
	TextColor3 = TEXT,
	TextScaled = true,
}, panel)
Instance.new("UICorner", panel:FindFirstChildWhichIsA("TextLabel")).CornerRadius = UDim.new(0, 8)

for i, className in ipairs(Config.Classes) do
	local y = 56 + (i - 1) * 74

	local lip = mk("Frame", {
		Size = UDim2.new(1, -20, 0, 62),
		Position = UDim2.new(0, 10, 0, y + 4),
		BackgroundColor3 = MAROON,
		BorderSizePixel = 0,
	}, panel)
	Instance.new("UICorner", lip).CornerRadius = UDim.new(0, 10)

	local button = mk("TextButton", {
		Size = UDim2.new(1, -20, 0, 62),
		Position = UDim2.new(0, 10, 0, y),
		BackgroundColor3 = BRICK,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	}, panel)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

	mk("TextLabel", {
		Size = UDim2.new(1, -60, 0, 26),
		Position = UDim2.new(0, 10, 0, 8),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBlack,
		Text = string.upper(className),
		TextColor3 = TEXT,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, button)

	mk("TextLabel", {
		Size = UDim2.new(1, -60, 0, 16),
		Position = UDim2.new(0, 10, 0, 38),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = DESCRIPTIONS[className] or "",
		TextColor3 = SOFT_TEXT,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, button)

	drawIcon(button, ICONS[className])

	button.MouseButton1Down:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.08), { Position = UDim2.new(0, 12, 0, y + 2) }):Play()
	end)
	button.MouseButton1Up:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), { Position = UDim2.new(0, 10, 0, y) }):Play()
	end)
	button.Activated:Connect(function()
		player:SetAttribute("Class", className)
		TweenService:Create(panel, TweenInfo.new(0.2), { Size = UDim2.fromOffset(0, 0) }):Play()
		task.delay(0.2, function() gui:Destroy() end)
	end)
end

panel.Size = UDim2.fromOffset(0, 0)
TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back), { Size = PANEL_SIZE }):Play()