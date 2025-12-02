local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local flingEnabled = false
local flingSpeed = 999999999
local detectionRange = 4


local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local TitleLabel = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Name = "StealthFlingUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 140)
MainFrame.Active = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(255, 50, 100)
UIStroke.Thickness = 1.2
UIStroke.Transparency = 0.1

TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 25)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.Text = "STEALTH FLING"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextSize = 20

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
ToggleButton.Position = UDim2.new(0.5, -60, 0.5, -5)
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "ENABLE"
ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
ToggleButton.TextSize = 14
ButtonCorner.Parent = ToggleButton

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 15)
StatusLabel.Font = Enum.Font.Code
StatusLabel.Text = "Mode: Passive (Safe)"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 11

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)


local function IsEnemyNear()
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return false end
    
    local MyRoot = Character.HumanoidRootPart
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local EnemyRoot = player.Character.HumanoidRootPart
            local distance = (MyRoot.Position - EnemyRoot.Position).Magnitude
            
            if distance <= detectionRange then
                return true
            end
        end
    end
    return false
end

local function ActivateRotation()
    local Character = LocalPlayer.Character
    if not Character then return end
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    
    if RootPart then

        if not RootPart:FindFirstChild("StealthVelocity") then
            local bav = Instance.new("BodyAngularVelocity")
            bav.Name = "StealthVelocity"
            bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bav.P = math.huge
            bav.AngularVelocity = Vector3.new(0, flingSpeed, 0)
            bav.Parent = RootPart
            
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        RootPart.RotVelocity = Vector3.new(0, flingSpeed, 0)
    end
end

local function DeactivateRotation()
    local Character = LocalPlayer.Character
    if not Character then return end
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    
    if RootPart then
        local oldVel = RootPart:FindFirstChild("StealthVelocity")
        if oldVel then oldVel:Destroy() end
        
        RootPart.RotVelocity = Vector3.new(0, 0, 0)
    end
end

RunService.Heartbeat:Connect(function()
    if flingEnabled then
        if IsEnemyNear() then
            StatusLabel.Text = "STATUS: FLINGING TARGET!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            ActivateRotation()
      else
            StatusLabel.Text = "STATUS: Scanning..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            DeactivateRotation()
        end
    else
        DeactivateRotation()
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        ToggleButton.Text = "ACTIVE"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusLabel.Text = "System: Scanning..."
    else
        ToggleButton.Text = "ENABLE"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        StatusLabel.Text = "Mode: Passive (Safe)"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)
