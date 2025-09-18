local WALLHOP_ENABLED = true
local WALLHOP_SPEED = 50
local JUMP_POWER = 50
local POPUP_DURATION = 5


local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")


local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local function isNearWall()
    local rayOrigin = RootPart.Position
    local rayDirection = RootPart.CFrame.lookVector
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local result = workspace:Raycast(rayOrigin, rayDirection * 3, raycastParams)
    return result and result.Instance and result.Instance.CanCollide
end

local function performWallhop()
    if WALLHOP_ENABLED and Humanoid and Humanoid.Health > 0 then
        if isNearWall() and Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            Humanoid.JumpPower = JUMP_POWER
            local wallNormal = (RootPart.Position - workspace:FindPartOnRay(Ray.new(RootPart.Position, RootPart.CFrame.lookVector * 3)).Position).unit
            local velocity = (wallNormal + Vector3.new(0, 1, 0)).unit * WALLHOP_SPEED
            RootPart.Velocity = Vector3.new(velocity.X, WALLHOP_SPEED / 2, velocity.Z)
        end
    end
end

RunService.RenderStepped:Connect(performWallhop)


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WallhopGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false


local PopupFrame = Instance.new("Frame")
PopupFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
PopupFrame.Position = UDim2.new(0.35, 0, -0.25, 0)
PopupFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PopupFrame.BorderSizePixel = 0
PopupFrame.Parent = ScreenGui

local UICorner_Popup = Instance.new("UICorner")
UICorner_Popup.CornerRadius = UDim.new(0, 8)
UICorner_Popup.Parent = PopupFrame

local PopupText = Instance.new("TextLabel")
PopupText.Size = UDim2.new(1, 0, 1, 0)
PopupText.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PopupText.Text = [[
|| TikTok: @xycoolcraft
|| YouTube: @XYCoolcraft
|| GitHub: @XYCoolcraft
|| SCRIPT ACTIVATED ✅ ||
]]
PopupText.Font = Enum.Font.SourceSansBold
PopupText.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupText.TextSize = 16
PopupText.TextWrapped = true
PopupText.TextXAlignment = Enum.TextXAlignment.Left
PopupText.TextYAlignment = Enum.TextYAlignment.Center
PopupText.Parent = PopupFrame


PopupFrame:TweenPosition(
    UDim2.new(0.35, 0, 0.05, 0),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Bounce,
    1,
    true
)

wait(POPUP_DURATION)

PopupFrame:TweenPosition(
    UDim2.new(0.35, 0, -0.25, 0),
    Enum.EasingDirection.In,
    Enum.EasingStyle.Quad,
    1,
    true
)


local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 120)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -60)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.CornerRadius = UDim.new(0, 12)
UICorner_Main.Parent = MainFrame


local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.Text = "Wallhop"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Parent = MainFrame

local UICorner_Title = Instance.new("UICorner")
UICorner_Title.CornerRadius = UDim.new(0, 12)
UICorner_Title.Parent = TitleLabel


local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 150, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -75, 0.5, -10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ToggleButton.Text = "Wallhop: ON"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Parent = MainFrame

local UICorner_Button = Instance.new("UICorner")
UICorner_Button.CornerRadius = UDim.new(0, 8)
UICorner_Button.Parent = ToggleButton


local DevLabel = Instance.new("TextLabel")
DevLabel.Size = UDim2.new(1, 0, 0, 20)
DevLabel.Position = UDim2.new(0, 0, 1, -20)
DevLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DevLabel.BackgroundTransparency = 1
DevLabel.Text = "Developer: XΛYZ ƬΣCΉ"
DevLabel.Font = Enum.Font.SourceSans
DevLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DevLabel.TextSize = 12
DevLabel.Parent = MainFrame


ToggleButton.MouseButton1Click:Connect(function()
    WALLHOP_ENABLED = not WALLHOP_ENABLED
    if WALLHOP_ENABLED then
        ToggleButton.Text = "Wallhop: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    else
        ToggleButton.Text = "Wallhop: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    end
end)
