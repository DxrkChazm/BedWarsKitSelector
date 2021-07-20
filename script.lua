local KitSelector = Instance.new("ScreenGui")
local Container = Instance.new("Frame")
local Container_2 = Instance.new("Frame")
local UIPadding = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")
local KitButton = Instance.new("TextButton")
local UIPadding_2 = Instance.new("UIPadding")
local Title = Instance.new("TextLabel")
local UIListLayout_2 = Instance.new("UIListLayout")
local UIGradient = Instance.new("UIGradient")

KitSelector.Name = "Kit Selector"
KitSelector.Parent = game.CoreGui
KitSelector.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Container.Name = "Container"
Container.Parent = KitSelector
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0.5,0,0.5,0)
Container.AnchorPoint = Vector2.new(0.5,0.5)
Container.Size = UDim2.new(0, 175, 0, 226)

local UserInputService = game:GetService("UserInputService")

local gui = Container

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

Container_2.Name = "Container"
Container_2.Parent = Container
Container_2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Container_2.BackgroundTransparency = 0.500
Container_2.BorderSizePixel = 0
Container_2.LayoutOrder = 1
Container_2.Size = UDim2.new(1, 0, 1, -15)

UIPadding.Parent = Container_2
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingLeft = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 3)
UIPadding.PaddingTop = UDim.new(0, 3)

UIListLayout.Parent = Container_2
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 1)

KitButton.Name = "KitButton"
KitButton.Parent = nil
KitButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KitButton.BackgroundTransparency = 0.800
KitButton.BorderSizePixel = 0
KitButton.Size = UDim2.new(1, 0, 0, 20)
KitButton.Font = Enum.Font.ArialBold
KitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KitButton.TextSize = 14.000

UIPadding_2.Parent = Container
UIPadding_2.PaddingBottom = UDim.new(0, 3)
UIPadding_2.PaddingLeft = UDim.new(0, 3)
UIPadding_2.PaddingRight = UDim.new(0, 3)
UIPadding_2.PaddingTop = UDim.new(0, 3)

Title.Name = "Title"
Title.Parent = Container
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(1, 0, 0, 15)
Title.Font = Enum.Font.ArialBold
Title.Text = "Kit Selector"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000

UIListLayout_2.Parent = Container
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 110, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 72, 188))}
UIGradient.Rotation = 35
UIGradient.Parent = Container

local kits = {
	baker = "Baker",
	barbarian = "Barbarian",
	melody = "Melody",
	builder = "Builder",
	shielder = "Infernal Shielder",
	archer = "Archer",
	farmer_cletus = "Farmer Cletus",
	davey = "Pirate Davey"
}

for i,v in pairs(kits) do
	local Clone = KitButton:Clone()
	Clone.Parent = Container_2
	Clone.Text = v

	Clone.MouseButton1Down:Connect(function()
		game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.BedwarsActivateKit:InvokeServer({kit=i})
	end)
end
