local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("XayzAvaMod") then
    CoreGui.PartnerCodingUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XayzAvaMod"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 1.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚙️ Xayz Avatar Mode"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 40)}):Play()
        ContentFrame.Visible = false
    else
        ContentFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 250)}):Play()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    local slideOut = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -200, 1.5, 0)})
    slideOut:Play()
    slideOut.Completed:Wait()
    ScreenGui:Destroy()
end)

local FaceBtn = Instance.new("TextButton")
FaceBtn.Size = UDim2.new(1, -40, 0, 40)
FaceBtn.Position = UDim2.new(0, 20, 0, 20)
FaceBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
FaceBtn.Text = "😎 Classic Face"
FaceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FaceBtn.Font = Enum.Font.GothamSemibold
FaceBtn.TextSize = 14
FaceBtn.Parent = ContentFrame

local FaceCorner = Instance.new("UICorner")
FaceCorner.CornerRadius = UDim.new(0, 6)
FaceCorner.Parent = FaceBtn

FaceBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head
        local faceControls = head:FindFirstChildWhichIsA("FaceControls")
        if faceControls then faceControls:Destroy() end
        
        local faceDecal = head:FindFirstChild("face") or head:FindFirstChild("Face")
        if not faceDecal then
            faceDecal = Instance.new("Decal")
            faceDecal.Name = "face"
            faceDecal.Face = Enum.NormalId.Front
            faceDecal.Texture = "rbxasset://textures/face.png"
            faceDecal.Parent = head
        end
    end
end)

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0, 200, 0, 40)
ToggleLabel.Position = UDim2.new(0, 20, 0, 80)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "🧍 Enable R6"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.Font = Enum.Font.GothamSemibold
ToggleLabel.TextSize = 14
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ContentFrame

local ToggleBg = Instance.new("TextButton")
ToggleBg.Size = UDim2.new(0, 60, 0, 30)
ToggleBg.Position = UDim2.new(1, -80, 0, 85)
ToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
ToggleBg.Text = ""
ToggleBg.Parent = ContentFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBg

local ToggleCircle = Instance.new("Frame")
ToggleCircle.Size = UDim2.new(0, 22, 0, 22)
ToggleCircle.Position = UDim2.new(0, 4, 0.5, -11)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleCircle.Parent = ToggleBg

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = ToggleCircle

local r6Enabled = false

local function ApplyR6Simulation()
    local char = LocalPlayer.Character
    if not char then return end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("MeshPart") and part.Name ~= "Head" then
            part.Transparency = 1
        elseif part.Name == "UpperTorso" or part.Name == "LowerTorso" then
            part.Transparency = 1
        end
    end

    local function lockJoint(upperName, lowerName)
        local upper = char:FindFirstChild(upperName)
        local lower = char:FindFirstChild(lowerName)
        if upper and lower then
            local joint = lower:FindFirstChildWhichIsA("Motor6D")
            if joint then
                local weld = Instance.new("Weld")
                weld.Part0 = upper
                weld.Part1 = lower
                weld.C0 = joint.C0
                weld.C1 = joint.C1
                weld.Parent = upper
                joint:Destroy()
            end
        end
    end

    lockJoint("UpperTorso", "LowerTorso")
    lockJoint("LeftUpperArm", "LeftLowerArm")
    lockJoint("LeftLowerArm", "LeftHand")
    lockJoint("RightUpperArm", "RightLowerArm")
    lockJoint("RightLowerArm", "RightHand")
    lockJoint("LeftUpperLeg", "LeftLowerLeg")
    lockJoint("LeftLowerLeg", "LeftFoot")
    lockJoint("RightUpperLeg", "RightLowerLeg")
    lockJoint("RightLowerLeg", "RightFoot")

    local function createR6Block(name, size, attachTo)
        if not attachTo then return end
        local block = Instance.new("Part")
        block.Name = "R6_" .. name
        block.Size = size
        block.Color = attachTo.Color
        block.Material = attachTo.Material
        block.CanCollide = false
        block.Massless = true
        block.Parent = char

        local weld = Instance.new("Weld")
        weld.Part0 = attachTo
        weld.Part1 = block
        weld.C0 = CFrame.new(0, -0.2, 0)
        weld.Parent = block
    end

    createR6Block("Torso", Vector3.new(2, 2, 1), char:FindFirstChild("UpperTorso"))
    createR6Block("RightArm", Vector3.new(1, 2, 1), char:FindFirstChild("RightUpperArm"))
    createR6Block("LeftArm", Vector3.new(1, 2, 1), char:FindFirstChild("LeftUpperArm"))
    createR6Block("RightLeg", Vector3.new(1, 2, 1), char:FindFirstChild("RightUpperLeg"))
    createR6Block("LeftLeg", Vector3.new(1, 2, 1), char:FindFirstChild("LeftUpperLeg"))
end

ToggleBg.MouseButton1Click:Connect(function()
    r6Enabled = not r6Enabled
    if r6Enabled then
        TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(1, -26, 0.5, -11)}):Play()
        TweenService:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 80)}):Play()
        ApplyR6Simulation()
    else
        TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 4, 0.5, -11)}):Play()
        TweenService:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 65)}):Play()
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = 0
        end
    end
end)

local slideIn = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0.5, -125)})
slideIn:Play()
