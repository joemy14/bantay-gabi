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

-- Original shape icons, built from UI parts
local function drawIcon(parent, kind)
	local holder = mk("Frame", { Size = UDim2.fromOffset(34, 34), Position = UDim2.new(1, -44, 0.5, -17), BackgroundTransparency = 1 }, parent)
	if kind == "shield" then
		local s = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", s).CornerRadius = UDim.new(0.35, 0)
		mk("Frame", { Size = UDim2.fromScale(0.42, 0.42), Position = UDim2.fromScale(0.29, 0.29), BackgroundColor3 = RED, BorderSizePixel = 0 }, holder)
	elseif kind == "cross" then
		mk("Frame", { Size = UDim2.fromScale(0.3, 1), Position = UDim2.fromScale(0.35, 0), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
		mk("Frame", { Size = UDim2.fromScale(1, 0.3), Position = UDim2.fromScale(0, 0.35), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
	elseif kind == "moon" then
		local m = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", m).CornerRadius = UDim.new(1, 0)
		mk("Frame", { Size = UDim2.fromScale(0.85, 0.85), Position = UDim2.fromScale(0.35, 0.05), BackgroundColor3 = RED_DARK, BorderSizePixel = 0 }, holder)
		Instance.new("UICorner", holder:FindFirstChildWhichIsA("Frame")).CornerRadius = UDim.new(1, 0)
	end
end

local gui = mk("ScreenGui", { Name = "ClassPicker", ResetOnSpawn = false, IgnoreGuiInset = true }, playerGui)

local overlay = mk("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.4,
	BorderSizePixel = 0,
}, gui)

local panel = mk("Frame", {
	Size = PANEL_SIZE,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	BackgroundColor3 = BLACK,
	BorderSizePixel = 0,
}, overlay)
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)
mk("UIStroke", { Color = RED, Thickness = 3 }, panel)

local title = mk("TextLabel", {
	Size = UDim2.new(1, -20, 0, 36),
	Position = UDim2.new(0, 10, 0, 10),
	BackgroundColor3 = RED,
	BorderSizePixel = 0,
	Font = Enum.Font.GothamBlack,
	Text = "PICK YOUR CLASS",
	TextColor3 = WHITE,
	TextScaled = true,
}, panel)
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)
mk("UIStroke", { Color = RED_DARK, Thickness = 2 }, title)

for i, className in ipairs(Config.Classes) do
	local y = 56 + (i - 1) * 74

	local lip = mk("Frame", {
		Size = UDim2.new(1, -20, 0, 62),
		Position = UDim2.new(0, 10, 0, y + 4),
		BackgroundColor3 = RED_DARK,
		BorderSizePixel = 0,
	}, panel)
	Instance.new("UICorner", lip).CornerRadius = UDim.new(0, 10)

	local button = mk("TextButton", {
		Size = UDim2.new(1, -20, 0, 62),
		Position = UDim2.new(0, 10, 0, y),
		BackgroundColor3 = RED,
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
		TextColor3 = WHITE,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, button)

	mk("TextLabel", {
		Size = UDim2.new(1, -60, 0, 16),
		Position = UDim2.new(0, 10, 0, 38),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = DESCRIPTIONS[className] or "",
		TextColor3 = Color3.fromRGB(255, 220, 220),
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