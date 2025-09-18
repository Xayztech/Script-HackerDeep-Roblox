local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local isWallhopEnabled = false 

local wallhopPower = 45   
local wallhopDistance = 4    


local mainScreenGui = Instance.new("ScreenGui")
mainScreenGui.Name = "WallhopGUI"
mainScreenGui.Parent = player:WaitForChild("PlayerGui")
mainScreenGui.ResetOnSpawn = false 

local function createPopupMessage()
    local popupFrame = Instance.new("Frame")
    popupFrame.Name = "PopupMessage"
    popupFrame.Size = UDim2.new(0, 350, 0, 150)
    popupFrame.Position = UDim2.new(0.5, 0, 0, -150) 
    popupFrame.AnchorPoint = Vector2.new(0.5, 0)
    popupFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    popupFrame.BorderSizePixel = 2
    popupFrame.BorderColor3 = Color3.fromRGB(120, 120, 120)
    popupFrame.Parent = mainScreenGui

    local tiktokLabel = Instance.new("TextLabel")
    tiktokLabel.Size = UDim2.new(1, 0, 0, 25)
    tiktokLabel.Position = UDim2.new(0, 0, 0.1, 0)
    tiktokLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tiktokLabel.BackgroundTransparency = 1
    tiktokLabel.Text = "TikTok: @xycoolcraft"
    tiktokLabel.Font = Enum.Font.SourceSansBold
    tiktokLabel.TextSize = 20
    tiktokLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tiktokLabel.Parent = popupFrame
    
  
    local youtubeLabel = Instance.new("TextLabel")
    youtubeLabel.Size = UDim2.new(1, 0, 0, 25)
    youtubeLabel.Position = UDim2.new(0, 0, 0.3, 0)
    youtubeLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    youtubeLabel.BackgroundTransparency = 1
    youtubeLabel.Text = "🔔 ✅ YouTube: @XYCoolcraft"
    youtubeLabel.Font = Enum.Font.SourceSansBold
    youtubeLabel.TextSize = 20
    youtubeLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    youtubeLabel.Parent = popupFrame

    local githubLabel = Instance.new("TextLabel")
    githubLabel.Size = UDim2.new(1, 0, 0, 25)
    githubLabel.Position = UDim2.new(0, 0, 0.5, 0)
    githubLabel.BackgroundTransparency = 1
    githubLabel.Text = "GitHub: @XYCoolcraft"
    githubLabel.Font = Enum.Font.SourceSansBold
    githubLabel.TextSize = 20
    githubLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    githubLabel.Parent = popupFrame

    local activatedLabel = Instance.new("TextLabel")
    activatedLabel.Size = UDim2.new(1, 0, 0, 30)
    activatedLabel.Position = UDim2.new(0, 0, 0.75, 0)
    activatedLabel.BackgroundTransparency = 1
    activatedLabel.Text = "|| SCRIPT ACTIVATED ✅ ||"
    activatedLabel.Font = Enum.Font.Code
    activatedLabel.TextSize = 24
    activatedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    activatedLabel.Parent = popupFrame
    
    coroutine.wrap(function()
        while wait() do
            local glitchColor = math.random(1,3)
            if glitchColor == 1 then
                tiktokLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
            elseif glitchColor == 2 then
                 tiktokLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
            else
                tiktokLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
            
            local hue = tick() % 5 / 5
            activatedLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        end
    end)()


    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
    local goal = { Position = UDim2.new(0.5, 0, 0.05, 0) }
    local tweenIn = TweenService:Create(popupFrame, tweenInfo, goal)
    
    tweenIn:Play()
    wait(5)
    
    local tweenOutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local goalOut = { Position = UDim2.new(0.5, 0, 0, -150) }
    local tweenOut = TweenService:Create(popupFrame, tweenOutInfo, goalOut)
    
    tweenOut:Play()
    tweenOut.Completed:Wait()
    popupFrame:Destroy()
end


local function createControlButton()
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "ControlFrame"
    mainFrame.Size = UDim2.new(0, 200, 0, 120)
    mainFrame.Position = UDim2.new(0.1, 0, 0.5, -60)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(150, 150, 150)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = mainScreenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    titleLabel.Text = "Wallhop"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = mainFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0.8, 0, 0, 40)
    toggleButton.Position = UDim2.new(0.5, 0, 0.5, 0)
    toggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    toggleButton.Text = "Off"
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.TextSize = 24
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Parent = mainFrame

    local creditLabel = Instance.new("TextLabel")
    creditLabel.Name = "Credit"
    creditLabel.Size = UDim2.new(1, 0, 0, 20)
    creditLabel.Position = UDim2.new(0, 0, 1, -20)
    creditLabel.BackgroundTransparency = 1
    creditLabel.Text = "Developer: XΛYZ ƬΣCΉ"
    creditLabel.Font = Enum.Font.SourceSans
    creditLabel.TextSize = 14
    creditLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    creditLabel.Parent = mainFrame

    toggleButton.MouseButton1Click:Connect(function()
        isWallhopEnabled = not isWallhopEnabled
        if isWallhopEnabled then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end)
end

RunService.RenderStepped:Connect(function()
    if not isWallhopEnabled or not character or not humanoid or humanoid:GetState() == Enum.HumanoidStateType.Dead then
        return
    end

    if humanoid:GetState() == Enum.HumanoidStateType.Freefall then

        local origin = rootPart.Position
        local direction = rootPart.CFrame.LookVector * wallhopDistance
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

        local raycastResult = workspace:Raycast(origin, direction, raycastParams)

        if raycastResult then
            humanoid.Velocity = Vector3.new(humanoid.Velocity.X, wallhopPower, humanoid.Velocity.Z)
        end
    end
end)

createPopupMessage()
wait(6) 
createControlButton()

print("Wallhop Script by XΛYZ ƬΣCΉ has been activated!")
