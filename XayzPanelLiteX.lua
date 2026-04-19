local CoreGui = nil
pcall(function()
    CoreGui = game:GetService("CoreGui")
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera or Workspace:FindFirstChild("Camera")

local State = {
    Fly = false,
    FlySpeed = 1,
    
    Aimbot = false,
    Aim_ShowFOV = false,
    Aim_FOVSize = 150,
    Aim_Part = "Head",
    
    ESP = false,
    ESP_Box = true,
    ESP_Tracer = true,
    ESP_Health = true,
    ESP_Name = true,
    ESP_Chams = true,
    
    POV = 70,
    FlingV2 = false,
    FlingPower = 50,
    SuperFling = false,
    DinoAnim = false,
    PunchAnim = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XayzExV3X"
ScreenGui.ResetOnSpawn = false

local successGui = false
if CoreGui then
    successGui, _ = pcall(function()
        local targetGui = nil
        if gethui then
            targetGui = gethui()
        else
            targetGui = CoreGui
        end
        ScreenGui.Parent = targetGui
    end)
end

if not successGui then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local function MakeDraggable(frame)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local newX = startPos.X.Offset + delta.X
            local newY = startPos.Y.Offset + delta.Y
            frame.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
        end
    end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.Size = UDim2.new(0, 480, 0, 360)
MainFrame.ClipsDescendants = true
MakeDraggable(MainFrame)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.Size = UDim2.new(1, 0, 0, 40)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "🖥️ Xayz Panel LiteX"

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MinimizeBtn.Position = UDim2.new(1, -100, 0.5, -12)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local MaximizeBtn = Instance.new("TextButton")
MaximizeBtn.Parent = Header
MaximizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MaximizeBtn.Position = UDim2.new(1, -65, 0.5, -12)
MaximizeBtn.Size = UDim2.new(0, 24, 0, 24)
MaximizeBtn.Font = Enum.Font.GothamBold
MaximizeBtn.Text = "□"
MaximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local MaxCorner = Instance.new("UICorner")
MaxCorner.CornerRadius = UDim.new(0, 6)
MaxCorner.Parent = MaximizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 130, 1, -40)
local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 140, 0, 50)
ContentArea.Size = UDim2.new(1, -150, 1, -60)

MinimizeBtn.MouseButton1Click:Connect(function()
    local tInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tGoal = {Size = UDim2.new(0, 480, 0, 40)}
    TweenService:Create(MainFrame, tInfo, tGoal):Play()
    Sidebar.Visible = false
    ContentArea.Visible = false
end)

MaximizeBtn.MouseButton1Click:Connect(function()
    local tInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tGoal = {Size = UDim2.new(0, 480, 0, 360)}
    TweenService:Create(MainFrame, tInfo, tGoal):Play()
    task.wait(0.3)
    Sidebar.Visible = true
    ContentArea.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Pages = {}

local function SwitchPage(pageName)
    for name, page in pairs(Pages) do
        if name == pageName then
            page.Visible = true
        else
            page.Visible = false
        end
    end
end

local function CreateTabBtn(text, pageName, yPos)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Sidebar
    Btn.BackgroundTransparency = 1
    Btn.Position = UDim2.new(0, 0, 0, yPos)
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Btn.TextSize = 12
    Btn.Text = text

    Btn.MouseButton1Click:Connect(function()
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SwitchPage(pageName)
    end)
    return Btn
end

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = ContentArea
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.ScrollBarThickness = 2
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Pages[name] = Page

    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Page
    UIList.Padding = UDim.new(0, 8)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    return Page
end

local PageCombat = CreatePage("Combat")
local PageVisual = CreatePage("Visual")
local PageFlings = CreatePage("Flings")

SwitchPage("Combat")
local Tab1 = CreateTabBtn("⚔️ COMBAT", "Combat", 10)
Tab1.TextColor3 = Color3.fromRGB(255, 255, 255)
CreateTabBtn("👁️ VISUAL", "Visual", 50)
CreateTabBtn("🌪️ ULTIMATE", "Flings", 90)

local function CreateDropdown(page, text)
    local Container = Instance.new("Frame")
    Container.Parent = page
    Container.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Container.Size = UDim2.new(1, -5, 0, 35)
    Container.ClipsDescendants = true
    local ContCorner = Instance.new("UICorner")
    ContCorner.CornerRadius = UDim.new(0, 6)
    ContCorner.Parent = Container

    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.Parent = Container
    HeaderBtn.BackgroundTransparency = 1
    HeaderBtn.Position = UDim2.new(0, 10, 0, 0)
    HeaderBtn.Size = UDim2.new(1, -10, 0, 35)
    HeaderBtn.Font = Enum.Font.GothamBold
    HeaderBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
    HeaderBtn.TextSize = 12
    HeaderBtn.TextXAlignment = Enum.TextXAlignment.Left
    HeaderBtn.Text = text .. " ▼"

    local ItemsFrame = Instance.new("Frame")
    ItemsFrame.Parent = Container
    ItemsFrame.BackgroundTransparency = 1
    ItemsFrame.Position = UDim2.new(0, 0, 0, 35)
    ItemsFrame.Size = UDim2.new(1, 0, 0, 0)

    local Pad = Instance.new("UIPadding")
    Pad.Parent = ItemsFrame
    Pad.PaddingLeft = UDim.new(0, 15)
    Pad.PaddingRight = UDim.new(0, 5)

    local UIList = Instance.new("UIListLayout")
    UIList.Parent = ItemsFrame
    UIList.Padding = UDim.new(0, 5)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    local isOpen = false
    local function updateSize()
        if isOpen then
            HeaderBtn.Text = text .. " ▲"
            local height = UIList.AbsoluteContentSize.Y + 10
            ItemsFrame.Size = UDim2.new(1, 0, 0, height)
            Container.Size = UDim2.new(1, -5, 0, 35 + height)
        else
            HeaderBtn.Text = text .. " ▼"
            ItemsFrame.Size = UDim2.new(1, 0, 0, 0)
            Container.Size = UDim2.new(1, -5, 0, 35)
        end
    end

    HeaderBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        updateSize()
    end)

    UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

    return ItemsFrame
end

local function CreateToggle(page, text, stateKey, parentStateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -5, 0, 35)
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    
    local Button = Instance.new("TextButton")
    Button.Parent = Frame
    Button.Position = UDim2.new(1, -50, 0.5, -8)
    Button.Size = UDim2.new(0, 40, 0, 16)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Button.Text = ""
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(1, 0)
    BCorner.Parent = Button
    
    local Status = Instance.new("Frame")
    Status.Parent = Button
    Status.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Status.Position = UDim2.new(0, 2, 0.5, -6)
    Status.Size = UDim2.new(0, 12, 0, 12)
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(1, 0)
    SCorner.Parent = Status

    local function updateUI()
        if State[stateKey] then
            Status.Position = UDim2.new(1, -14, 0.5, -6)
            Status.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        else
            Status.Position = UDim2.new(0, 2, 0.5, -6)
            Status.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end

    RunService.RenderStepped:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            Label.TextColor3 = Color3.fromRGB(100, 100, 100)
            Button.AutoButtonColor = false
        else
            if parentStateKey == nil then
                if State[stateKey] then
                    Label.TextColor3 = Color3.fromRGB(0, 255, 150)
                else
                    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
                end
            else
                Label.TextColor3 = Color3.fromRGB(230, 230, 230)
            end
            Button.AutoButtonColor = true
        end
    end)

    updateUI()

    Button.MouseButton1Click:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            return 
        end
        State[stateKey] = not State[stateKey]
        
        local tInfo = TweenInfo.new(0.2)
        local tGoal = {}
        if State[stateKey] then
            tGoal.Position = UDim2.new(1, -14, 0.5, -6)
            tGoal.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        else
            tGoal.Position = UDim2.new(0, 2, 0.5, -6)
            tGoal.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
        TweenService:Create(Status, tInfo, tGoal):Play()
    end)
    return Frame
end

local function CreateButton(page, text, color, callback, parentStateKey)
    local Btn = Instance.new("TextButton")
    Btn.Parent = page
    Btn.BackgroundColor3 = color
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    Btn.Text = text
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Btn
    
    RunService.RenderStepped:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Btn.TextColor3 = Color3.fromRGB(120, 120, 120)
        else
            Btn.BackgroundColor3 = color
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    Btn.MouseButton1Click:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            return
        end
        callback(Btn)
    end)
    return Btn
end

local function CreateInput(page, text, stateKey, parentStateKey)
    local Box = Instance.new("TextBox")
    Box.Parent = page
    Box.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Box.Size = UDim2.new(1, -5, 0, 35)
    Box.Font = Enum.Font.Gotham
    Box.Text = ""
    Box.PlaceholderText = text
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 12
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Box
    
    RunService.RenderStepped:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            Box.TextColor3 = Color3.fromRGB(100, 100, 100)
            Box.TextEditable = false
        else
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Box.TextEditable = true
        end
    end)

    Box.FocusLost:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            return
        end
        local num = tonumber(Box.Text)
        if num then
            State[stateKey] = num
        end
    end)
    return Box
end

local function CreateStepper(page, text, stateKey, parentStateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -5, 0, 35)
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    
    local MinusBtn = Instance.new("TextButton")
    MinusBtn.Parent = Frame
    MinusBtn.Position = UDim2.new(1, -100, 0.5, -12)
    MinusBtn.Size = UDim2.new(0, 24, 0, 24)
    MinusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinusBtn.Text = "-"
    MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local MCorner = Instance.new("UICorner")
    MCorner.CornerRadius = UDim.new(0, 4)
    MCorner.Parent = MinusBtn
    
    local ValueBox = Instance.new("TextBox")
    ValueBox.Parent = Frame
    ValueBox.Position = UDim2.new(1, -70, 0.5, -12)
    ValueBox.Size = UDim2.new(0, 34, 0, 24)
    ValueBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ValueBox.Text = tostring(State[stateKey])
    ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    local VCorner = Instance.new("UICorner")
    VCorner.CornerRadius = UDim.new(0, 4)
    VCorner.Parent = ValueBox
    
    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Parent = Frame
    PlusBtn.Position = UDim2.new(1, -30, 0.5, -12)
    PlusBtn.Size = UDim2.new(0, 24, 0, 24)
    PlusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    PlusBtn.Text = "+"
    PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local PCorner = Instance.new("UICorner")
    PCorner.CornerRadius = UDim.new(0, 4)
    PCorner.Parent = PlusBtn

    RunService.RenderStepped:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            Label.TextColor3 = Color3.fromRGB(100, 100, 100)
            ValueBox.TextColor3 = Color3.fromRGB(100, 100, 100)
            ValueBox.TextEditable = false
            MinusBtn.AutoButtonColor = false
            PlusBtn.AutoButtonColor = false
        else
            Label.TextColor3 = Color3.fromRGB(230, 230, 230)
            ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueBox.TextEditable = true
            MinusBtn.AutoButtonColor = true
            PlusBtn.AutoButtonColor = true
        end
    end)

    local function update(newVal)
        if parentStateKey and not State[parentStateKey] then
            return
        end
        State[stateKey] = newVal
        ValueBox.Text = tostring(State[stateKey])
    end
    
    MinusBtn.MouseButton1Click:Connect(function() 
        if parentStateKey and not State[parentStateKey] then return end
        if State[stateKey] > 1 then 
            update(State[stateKey] - 1) 
        end 
    end)
    
    PlusBtn.MouseButton1Click:Connect(function() 
        if parentStateKey and not State[parentStateKey] then return end
        update(State[stateKey] + 1) 
    end)
    
    ValueBox.FocusLost:Connect(function()
        if parentStateKey and not State[parentStateKey] then 
            ValueBox.Text = tostring(State[stateKey])
            return 
        end
        local num = tonumber(ValueBox.Text)
        if num and num >= 1 then 
            update(num) 
        else 
            update(1) 
        end
    end)
    return Frame
end

CreateToggle(PageCombat, "Aimbot", "Aimbot", nil)
local DropAim = CreateDropdown(PageCombat, "Advanced Menu")
CreateToggle(DropAim, "Show FOV Circle", "Aim_ShowFOV", "Aimbot")
CreateInput(DropAim, "Set FOV Size", "Aim_FOVSize", "Aimbot")
CreateButton(DropAim, "Switch Target: HEAD/TORSO", Color3.fromRGB(200, 100, 0), function(btn)
    if State.Aim_Part == "Head" then
        State.Aim_Part = "HumanoidRootPart"
    else
        State.Aim_Part = "Head"
    end
    btn.Text = "Target: " .. string.upper(State.Aim_Part)
end, "Aimbot")

CreateToggle(PageCombat, "Fly", "Fly", nil)
CreateStepper(PageCombat, "Set Fly Speed", "FlySpeed", "Fly")

CreateToggle(PageVisual, "Ultimate ESP", "ESP", nil)
local DropESP = CreateDropdown(PageVisual, "Advanced ESP Menu")
CreateToggle(DropESP, "Show Box", "ESP_Box", "ESP")
CreateToggle(DropESP, "Show Name & Distance", "ESP_Name", "ESP")
CreateToggle(DropESP, "Show Healthbar", "ESP_Health", "ESP")
CreateToggle(DropESP, "Show Tracer", "ESP_Tracer", "ESP")
CreateToggle(DropESP, "Show Chams", "ESP_Chams", "ESP")

CreateInput(PageVisual, "Set POV Camera", "POV", nil)

CreateToggle(PageFlings, "Fling V2", "FlingV2", nil)
CreateInput(PageFlings, "Set Fling Power", "FlingPower", "FlingV2")
CreateToggle(PageFlings, "Super Touch Fling", "SuperFling", nil)

CreateToggle(PageFlings, "Dino Animation", "DinoAnim", nil)
CreateToggle(PageFlings, "Punch Animation", "PunchAnim", nil)

local FlyLoop = nil
local FlyBV = nil
local FlyBG = nil
local tpwalking = false

RunService.RenderStepped:Connect(function()
    if State.Fly and not tpwalking then
        local char = LocalPlayer.Character
        local hum = nil
        local root = nil
        local torso = nil
        
        if char then
            hum = char:FindFirstChildWhichIsA("Humanoid")
            root = char:FindFirstChild("HumanoidRootPart")
            torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        end
        
        if hum and root and torso then
            tpwalking = true
            if FlyBV then FlyBV:Destroy() end
            if FlyBG then FlyBG:Destroy() end
            
            FlyBG = Instance.new("BodyGyro")
            FlyBG.Parent = torso
            FlyBG.P = 9e4
            FlyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            
            FlyBV = Instance.new("BodyVelocity")
            FlyBV.Parent = torso
            FlyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            
            hum.PlatformStand = true
            char.Animate.Disabled = true
            
            local animTracks = hum:GetPlayingAnimationTracks()
            for _, v in next, animTracks do
                v:Stop()
            end
        end
    elseif not State.Fly and tpwalking then
        tpwalking = false
        if FlyBV then FlyBV:Destroy() end
        if FlyBG then FlyBG:Destroy() end
        
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then 
                hum.PlatformStand = false 
                hum:ChangeState(Enum.HumanoidStateType.GettingUp) 
            end
            if char:FindFirstChild("Animate") then 
                char.Animate.Disabled = false 
            end
        end
    end

    if State.Fly and tpwalking and FlyBV and FlyBG then
        local char = LocalPlayer.Character
        local hum = nil
        if char then
            hum = char:FindFirstChild("Humanoid")
        end
        
        if hum then
            FlyBG.CFrame = Camera.CFrame
            local moveDir = hum.MoveDirection
            
            if moveDir.Magnitude > 0 then
                local cLookX = Camera.CFrame.LookVector.X
                local cLookZ = Camera.CFrame.LookVector.Z
                local camLookFlat = Vector3.new(cLookX, 0, cLookZ).Unit
                
                local cRightX = Camera.CFrame.RightVector.X
                local cRightZ = Camera.CFrame.RightVector.Z
                local camRightFlat = Vector3.new(cRightX, 0, cRightZ).Unit
                
                local fwdMove = moveDir:Dot(camLookFlat)
                local rgtMove = moveDir:Dot(camRightFlat)
                
                local fwdVec = Camera.CFrame.LookVector * fwdMove
                local rgtVec = Camera.CFrame.RightVector * rgtMove
                local flyDir = fwdVec + rgtVec
                
                if flyDir.Magnitude > 0 then 
                    flyDir = flyDir.Unit 
                end
                
                FlyBV.Velocity = flyDir * (State.FlySpeed * 50)
            else
                FlyBV.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)

local ESP_Data = {}
local HasDrawing = false
pcall(function() 
    local testLine = Drawing.new("Line") 
    HasDrawing = true
    testLine:Remove()
end)

local FOVCircle = nil
if HasDrawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Thickness = 1.5
    FOVCircle.Filled = false
    FOVCircle.Transparency = 1
end

local function CreateESP(player)
    local esp = {}
    esp.Highlight = Instance.new("Highlight")
    esp.Highlight.FillColor = Color3.fromRGB(255, 50, 50)
    esp.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    esp.Highlight.FillTransparency = 0.5
    esp.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    if HasDrawing then
        esp.Tracer = Drawing.new("Line")
        esp.Tracer.Thickness = 1.5
        esp.Tracer.Color = Color3.fromRGB(255, 255, 255)
        
        esp.Box = Drawing.new("Square")
        esp.Box.Thickness = 1.5
        esp.Box.Color = Color3.fromRGB(255, 50, 50)
        esp.Box.Filled = false
        
        esp.HealthBg = Drawing.new("Line")
        esp.HealthBg.Thickness = 3
        esp.HealthBg.Color = Color3.fromRGB(0, 0, 0)
        
        esp.HealthFill = Drawing.new("Line")
        esp.HealthFill.Thickness = 1.5
        esp.HealthFill.Color = Color3.fromRGB(0, 255, 100)
        
        esp.Text = Drawing.new("Text")
        esp.Text.Size = 14
        esp.Text.Color = Color3.fromRGB(255, 255, 255)
        esp.Text.Center = true
        esp.Text.Outline = true
    end
    ESP_Data[player] = esp
end

local function RemoveESP(player)
    if ESP_Data[player] then
        if ESP_Data[player].Highlight then 
            ESP_Data[player].Highlight:Destroy() 
        end
        if HasDrawing then
            ESP_Data[player].Tracer:Remove()
            ESP_Data[player].Box:Remove()
            ESP_Data[player].HealthBg:Remove()
            ESP_Data[player].HealthFill:Remove()
            ESP_Data[player].Text:Remove()
        end
        ESP_Data[player] = nil
    end
end
Players.PlayerRemoving:Connect(RemoveESP)

RunService.RenderStepped:Connect(function()
    if Camera and Camera.FieldOfView ~= State.POV then 
        Camera.FieldOfView = State.POV 
    end

    local cx = Camera.ViewportSize.X / 2
    local cy = Camera.ViewportSize.Y / 2
    local centerScreen = Vector2.new(cx, cy)
    
    if FOVCircle then
        FOVCircle.Position = centerScreen
        FOVCircle.Radius = State.Aim_FOVSize
        if State.Aimbot and State.Aim_ShowFOV then
            FOVCircle.Visible = true
        else
            FOVCircle.Visible = false
        end
    end
    
    if State.Aimbot then
        local target = nil
        local shortDist = State.Aim_FOVSize
        
        for _, p in pairs(Players:GetPlayers()) do
            local isValidTarget = false
            if p ~= LocalPlayer and p.Character then
                local pHum = p.Character:FindFirstChild("Humanoid")
                local pPart = p.Character:FindFirstChild(State.Aim_Part)
                if pHum and pHum.Health > 0 and pPart then
                    isValidTarget = true
                end
            end
            
            if isValidTarget then
                local v, onS = Camera:WorldToViewportPoint(p.Character[State.Aim_Part].Position)
                if onS then
                    local vecDist = Vector2.new(v.X, v.Y) - centerScreen
                    local d = vecDist.Magnitude
                    if d < shortDist then 
                        target = p
                        shortDist = d 
                    end
                end
            end
        end
        
        if target then 
            local pPartPos = target.Character[State.Aim_Part].Position
            local newCF = CFrame.new(Camera.CFrame.Position, pPartPos)
            Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.2) 
        end
    end

    local isFlinging = State.SuperFling or State.FlingV2
    local lChar = LocalPlayer.Character
    if isFlinging and lChar then
        local lHrp = lChar:FindFirstChild("HumanoidRootPart")
        if lHrp then
            lHrp.RotVelocity = Vector3.new(0, 0, 0)
        end
    end

    if State.ESP then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                local root = nil
                local head = nil
                local hum = nil
                
                if char then
                    root = char:FindFirstChild("HumanoidRootPart")
                    head = char:FindFirstChild("Head")
                    hum = char:FindFirstChild("Humanoid")
                end
                
                if char and root and head and hum and hum.Health > 0 then
                    if not ESP_Data[player] then 
                        CreateESP(player) 
                    end
                    local esp = ESP_Data[player]
                    
                    if State.ESP_Chams then
                        if esp.Highlight.Parent ~= char then 
                            esp.Highlight.Parent = char 
                        end
                    else
                        if esp.Highlight.Parent then 
                            esp.Highlight.Parent = nil 
                        end
                    end
                    
                    if HasDrawing then
                        local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                        local headPosC = head.Position + Vector3.new(0, 0.5, 0)
                        local headPos = Camera:WorldToViewportPoint(headPosC)
                        local legPosC = root.Position - Vector3.new(0, 3, 0)
                        local legPos = Camera:WorldToViewportPoint(legPosC)
                        
                        if onScreen then
                            local boxHeight = math.abs(headPos.Y - legPos.Y)
                            local boxWidth = boxHeight / 2
                            
                            esp.Box.Size = Vector2.new(boxWidth, boxHeight)
                            esp.Box.Position = Vector2.new(rootPos.X - boxWidth / 2, headPos.Y)
                            esp.Box.Visible = State.ESP_Box
                            
                            esp.Tracer.From = Vector2.new(cx, Camera.ViewportSize.Y)
                            esp.Tracer.To = Vector2.new(rootPos.X, legPos.Y)
                            esp.Tracer.Visible = State.ESP_Tracer
                            
                            local hp = hum.Health / hum.MaxHealth
                            local hh = boxHeight * hp
                            
                            esp.HealthBg.From = Vector2.new(esp.Box.Position.X - 5, legPos.Y)
                            esp.HealthBg.To = Vector2.new(esp.Box.Position.X - 5, headPos.Y)
                            esp.HealthBg.Visible = State.ESP_Health
                            
                            esp.HealthFill.From = Vector2.new(esp.Box.Position.X - 5, legPos.Y)
                            esp.HealthFill.To = Vector2.new(esp.Box.Position.X - 5, legPos.Y - hh)
                            
                            local rCol = 255 - (hp * 255)
                            local gCol = hp * 255
                            esp.HealthFill.Color = Color3.fromRGB(rCol, gCol, 0)
                            esp.HealthFill.Visible = State.ESP_Health
                            
                            local distToPlayer = (Camera.CFrame.Position - root.Position).Magnitude
                            local distMath = math.floor(distToPlayer)
                            esp.Text.Text = player.DisplayName .. " [" .. distMath .. "m]"
                            esp.Text.Position = Vector2.new(rootPos.X, headPos.Y - 20)
                            esp.Text.Visible = State.ESP_Name
                        else
                            esp.Box.Visible = false
                            esp.Tracer.Visible = false
                            esp.HealthBg.Visible = false
                            esp.HealthFill.Visible = false
                            esp.Text.Visible = false
                        end
                    end
                else
                    if ESP_Data[player] then
                        if ESP_Data[player].Highlight then 
                            ESP_Data[player].Highlight.Parent = nil 
                        end
                        if HasDrawing then 
                            ESP_Data[player].Box.Visible = false
                            ESP_Data[player].Tracer.Visible = false
                            ESP_Data[player].HealthBg.Visible = false
                            ESP_Data[player].HealthFill.Visible = false
                            ESP_Data[player].Text.Visible = false 
                        end
                    end
                end
            end
        end
    else
        for player, _ in pairs(ESP_Data) do 
            RemoveESP(player) 
        end
    end
end)

local dinoAnimR15 = Instance.new("Animation")
dinoAnimR15.AnimationId = "rbxassetid://204062532"

local dinoAnimR6 = Instance.new("Animation")
dinoAnimR6.AnimationId = "rbxassetid://20432871"

local punchAnimation = Instance.new("Animation")
punchAnimation.AnimationId = "rbxassetid://84674780"

local dTrack = nil
local pTrack = nil

RunService.Heartbeat:Connect(function()
    if State.FlingV2 and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.RotVelocity = Vector3.new(0, State.FlingPower * 100, 0)
        end
    end

    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            if State.DinoAnim and not (dTrack and dTrack.IsPlaying) then
                if hum.RigType == Enum.HumanoidRigType.R15 then
                    dTrack = hum:LoadAnimation(dinoAnimR15)
                else
                    dTrack = hum:LoadAnimation(dinoAnimR6)
                end
                dTrack:Play()
            elseif not State.DinoAnim and dTrack and dTrack.IsPlaying then
                dTrack:Stop()
            end

            if State.PunchAnim and not (pTrack and pTrack.IsPlaying) then
                pTrack = hum:LoadAnimation(punchAnimation)
                pTrack:Play()
            elseif not State.PunchAnim and pTrack and pTrack.IsPlaying then
                pTrack:Stop()
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if State.SuperFling and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.RotVelocity = Vector3.new(50000, 50000, 50000)
        end
    end
end)