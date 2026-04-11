local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UsernameInput = Instance.new("TextBox")
local CloneButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local UIGradient = Instance.new("UIGradient")

ScreenGui.Name = "CloneTest"
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.fromRGB(255, 0, 0)

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 0))
}
UIGradient.Rotation = 45
UIGradient.Parent = UIStroke

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "CLONE TEST UNIVERSAL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

UsernameInput.Parent = MainFrame
UsernameInput.Size = UDim2.new(0, 240, 0, 40)
UsernameInput.Position = UDim2.new(0.1, 0, 0.3, 0)
UsernameInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UsernameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameInput.PlaceholderText = "TARGET NAME..."
UsernameInput.Text = ""

local InputCorner = Instance.new("UICorner", UsernameInput)

CloneButton.Parent = MainFrame
CloneButton.Size = UDim2.new(0, 240, 0, 50)
CloneButton.Position = UDim2.new(0.1, 0, 0.65, 0)
CloneButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloneButton.Font = Enum.Font.GothamBold
CloneButton.Text = "CLONE NOW"
CloneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloneButton.TextSize = 16

Instance.new("UICorner", CloneButton)

local function ExecuteClone()
    local targetName = UsernameInput.Text
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    
    if not char or not char:FindFirstChild("Humanoid") then return end
    
    local targetId
    local success, err = pcall(function()
        targetId = game.Players:GetUserIdFromNameAsync(targetName)
    end)
    
    if not success or not targetId then
        CloneButton.Text = "TARGET ERROR"
        wait(1)
        CloneButton.Text = "CLONE NOW"
        return
    end

    CloneButton.Text = "PROCESSING..."
    
    pcall(function()
        if setsimulationradius then
            setsimulationradius(math.huge)
        end
        settings().Physics.AllowSleep = false
        lp.MaximumSimulationRadius = math.huge
    end)

    local humDesc = game.Players:GetHumanoidDescriptionFromUserId(targetId)
    
    if humDesc then
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum:ApplyDescription(humDesc)
        
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") then
                v.Velocity = Vector3.new(0, 0.01, 0)
            elseif v:IsA("Accessory") then
                local handle = v:FindFirstChild("Handle")
                if handle then
                    handle.Velocity = Vector3.new(0, 0.01, 0)
                end
            end
        end
        
        CloneButton.Text = "SUCCESS!"
    else
        CloneButton.Text = "DESC ERROR"
    end
    
    wait(1.5)
    CloneButton.Text = "CLONE NOW"
end

CloneButton.MouseButton1Click:Connect(ExecuteClone)

spawn(function()
    while wait() do
        for i = 0, 1, 0.02 do
            UIGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromHSV(i, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV((i + 0.5) % 1, 1, 1))
            }
            wait()
        end
    end
end)

print("Clone Test Loaded Successfully.")
