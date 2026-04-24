local CoreGui = nil
pcall(function()
    CoreGui = game:GetService("CoreGui")
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera or Workspace:FindFirstChild("Camera")

local State = {
    PerformanceMode = false,
    
    Fly = false,
    FlySpeed = 1,
    
    Aimbot = false,
    SilentAim = false,
    Aim_ShowFOV = false,
    Aim_FOVSize = 150,
    Aim_Part = "Head",
    
    ESP = false,
    ESP_Box = false,
    ESP_Tracer = false,
    ESP_Health = false,
    ESP_Name = false,
    ESP_Chams = false,
    POV = 70,
    
    FlingV2 = false,
    FlingV3 = false,
    FlingPower = 50, 
    SuperFling = false,
    ForceField = false,
    
    DinoAnim = false,
    PunchAnim = false,
    
    SuperRing = false,
    RingSpeed = 50,
    RingHeight = 5,
    RingDistance = 40,
    RingAttraction = 1000,
    Blackhole = false,
    BlackholeDistance = 30,
    HDAdmin = false
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

local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Parent = ScreenGui
NotifContainer.BackgroundTransparency = 1
NotifContainer.Position = UDim2.new(1, -260, 1, -20)
NotifContainer.Size = UDim2.new(0, 250, 0, 0)
NotifContainer.AnchorPoint = Vector2.new(0, 1)

local NotifList = Instance.new("UIListLayout")
NotifList.Parent = NotifContainer
NotifList.SortOrder = Enum.SortOrder.LayoutOrder
NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifList.Padding = UDim.new(0, 10)

local function XayzNotify(title, text, duration)
    local notifDuration = duration or 3
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Parent = NotifContainer
    NotifFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    NotifFrame.Size = UDim2.new(1, 0, 0, 65)
    NotifFrame.BackgroundTransparency = State.PerformanceMode and 0 or 1
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = NotifFrame
    
    local Accent = Instance.new("Frame")
    Accent.Parent = NotifFrame
    Accent.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    Accent.Size = UDim2.new(0, 4, 1, 0)
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 8)
    AccentCorner.Parent = Accent
    
    local Tbl = Instance.new("TextLabel")
    Tbl.Parent = NotifFrame
    Tbl.BackgroundTransparency = 1
    Tbl.Position = UDim2.new(0, 15, 0, 5)
    Tbl.Size = UDim2.new(1, -20, 0, 20)
    Tbl.Font = Enum.Font.GothamBold
    Tbl.Text = title
    Tbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tbl.TextSize = 14
    Tbl.TextXAlignment = Enum.TextXAlignment.Left
    Tbl.TextTransparency = State.PerformanceMode and 0 or 1
    
    local Dbl = Instance.new("TextLabel")
    Dbl.Parent = NotifFrame
    Dbl.BackgroundTransparency = 1
    Dbl.Position = UDim2.new(0, 15, 0, 25)
    Dbl.Size = UDim2.new(1, -20, 0, 30)
    Dbl.Font = Enum.Font.Gotham
    Dbl.Text = text
    Dbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    Dbl.TextSize = 12
    Dbl.TextWrapped = true
    Dbl.TextXAlignment = Enum.TextXAlignment.Left
    Dbl.TextTransparency = State.PerformanceMode and 0 or 1
    
    local ProgBg = Instance.new("Frame")
    ProgBg.Parent = NotifFrame
    ProgBg.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    ProgBg.Position = UDim2.new(0, 15, 1, -5)
    ProgBg.Size = UDim2.new(1, -25, 0, 3)
    ProgBg.BackgroundTransparency = State.PerformanceMode and 0 or 1
    
    local ProgBgCorner = Instance.new("UICorner")
    ProgBgCorner.CornerRadius = UDim.new(1, 0)
    ProgBgCorner.Parent = ProgBg
    
    local ProgFill = Instance.new("Frame")
    ProgFill.Parent = ProgBg
    ProgFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    ProgFill.Size = UDim2.new(1, 0, 1, 0)
    ProgFill.BackgroundTransparency = State.PerformanceMode and 0 or 1
    
    local ProgFillCorner = Instance.new("UICorner")
    ProgFillCorner.CornerRadius = UDim.new(1, 0)
    ProgFillCorner.Parent = ProgFill
    
    if not State.PerformanceMode then
        local tInfoIn = TweenInfo.new(0.3)
        TweenService:Create(NotifFrame, tInfoIn, {BackgroundTransparency = 0}):Play()
        TweenService:Create(Tbl, tInfoIn, {TextTransparency = 0}):Play()
        TweenService:Create(Dbl, tInfoIn, {TextTransparency = 0}):Play()
        TweenService:Create(ProgBg, tInfoIn, {BackgroundTransparency = 0}):Play()
        TweenService:Create(ProgFill, tInfoIn, {BackgroundTransparency = 0}):Play()
        
        local progTweenInfo = TweenInfo.new(notifDuration, Enum.EasingStyle.Linear)
        local progTween = TweenService:Create(ProgFill, progTweenInfo, {Size = UDim2.new(0, 0, 1, 0)})
        progTween:Play()
        
        progTween.Completed:Connect(function()
            local tInfoOut = TweenInfo.new(0.3)
            TweenService:Create(NotifFrame, tInfoOut, {BackgroundTransparency = 1}):Play()
            TweenService:Create(Tbl, tInfoOut, {TextTransparency = 1}):Play()
            TweenService:Create(Dbl, tInfoOut, {TextTransparency = 1}):Play()
            TweenService:Create(ProgBg, tInfoOut, {BackgroundTransparency = 1}):Play()
            TweenService:Create(ProgFill, tInfoOut, {BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            NotifFrame:Destroy()
        end)
    else
        task.spawn(function()
            task.wait(notifDuration)
            NotifFrame:Destroy()
        end)
    end
end

local RGBWrapper = Instance.new("Frame")
RGBWrapper.Parent = ScreenGui
RGBWrapper.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RGBWrapper.Position = UDim2.new(0.5, -241, 0.5, -161)
RGBWrapper.Size = UDim2.new(0, 482, 0, 362)
MakeDraggable(RGBWrapper) 

local RGBWrapperCorner = Instance.new("UICorner")
RGBWrapperCorner.CornerRadius = UDim.new(0, 11)
RGBWrapperCorner.Parent = RGBWrapper

local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = RGBWrapper
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(148, 0, 211))
}

RunService.RenderStepped:Connect(function()
    if not State.PerformanceMode then
        UIGradient.Rotation = (UIGradient.Rotation + 1) % 360
    else
        UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 150, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 150, 255))
        }
    end
end)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = RGBWrapper
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
MainFrame.Position = UDim2.new(0, 1, 0, 1)
MainFrame.Size = UDim2.new(1, -2, 1, -2)
MainFrame.ClipsDescendants = true

local MainFrameCorner = Instance.new("UICorner")
MainFrameCorner.CornerRadius = UDim.new(0, 10)
MainFrameCorner.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "🖥️ Xayz Panel LiteX"

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
MinimizeBtn.Position = UDim2.new(1, -95, 0.5, -12)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local MaximizeBtn = Instance.new("TextButton")
MaximizeBtn.Parent = Header
MaximizeBtn.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
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
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 13, 17)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.BorderSizePixel = 0

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 140, 0, 50)
ContentArea.Size = UDim2.new(1, -150, 1, -60)

MinimizeBtn.MouseButton1Click:Connect(function()
    if not State.PerformanceMode then
        local tInfo = TweenInfo.new(0.3)
        TweenService:Create(RGBWrapper, tInfo, {Size = UDim2.new(0, 482, 0, 42)}):Play()
    else
        RGBWrapper.Size = UDim2.new(0, 482, 0, 42)
    end
    Sidebar.Visible = false
    ContentArea.Visible = false
end)

MaximizeBtn.MouseButton1Click:Connect(function()
    if not State.PerformanceMode then
        local tInfo = TweenInfo.new(0.3)
        TweenService:Create(RGBWrapper, tInfo, {Size = UDim2.new(0, 482, 0, 362)}):Play()
        task.wait(0.3)
    else
        RGBWrapper.Size = UDim2.new(0, 482, 0, 362)
    end
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
    Btn.TextColor3 = Color3.fromRGB(120, 120, 130)
    Btn.TextSize = 12
    Btn.Text = text

    Btn.MouseButton1Click:Connect(function()
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.TextColor3 = Color3.fromRGB(120, 120, 130)
            end
        end
        Btn.TextColor3 = Color3.fromRGB(100, 150, 255)
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

local PageSettings = CreatePage("Settings")
local PageCombat = CreatePage("Combat")
local PageVisual = CreatePage("Visual")
local PageFlings = CreatePage("Flings")
local PageWorld = CreatePage("World")

SwitchPage("Settings")
local TabSet = CreateTabBtn("⚙️ SETTING", "Settings", 10)
TabSet.TextColor3 = Color3.fromRGB(100, 150, 255)
CreateTabBtn("⚔️ COMBAT", "Combat", 50)
CreateTabBtn("👁️ VISUAL", "Visual", 90)
CreateTabBtn("🌪️ FLINGS", "Flings", 130)
CreateTabBtn("🌍 WORLD", "World", 170)

local function CreateDualSwitch(page, text, stateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
    Frame.Size = UDim2.new(1, -5, 0, 45)
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Center
    Label.Text = text
    
    local OnBtn = Instance.new("TextButton")
    OnBtn.Parent = Frame
    OnBtn.Position = UDim2.new(0.1, 0, 0, 20)
    OnBtn.Size = UDim2.new(0.35, 0, 0, 20)
    OnBtn.BackgroundColor3 = State[stateKey] and Color3.fromRGB(50, 255, 100) or Color3.fromRGB(40, 40, 40)
    OnBtn.Text = "ON"
    OnBtn.Font = Enum.Font.GothamBold
    OnBtn.TextColor3 = State[stateKey] and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
    
    local OnCorner = Instance.new("UICorner")
    OnCorner.CornerRadius = UDim.new(0, 4)
    OnCorner.Parent = OnBtn

    local OffBtn = Instance.new("TextButton")
    OffBtn.Parent = Frame
    OffBtn.Position = UDim2.new(0.55, 0, 0, 20)
    OffBtn.Size = UDim2.new(0.35, 0, 0, 20)
    OffBtn.BackgroundColor3 = not State[stateKey] and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(40, 40, 40)
    OffBtn.Text = "OFF"
    OffBtn.Font = Enum.Font.GothamBold
    OffBtn.TextColor3 = not State[stateKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    
    local OffCorner = Instance.new("UICorner")
    OffCorner.CornerRadius = UDim.new(0, 4)
    OffCorner.Parent = OffBtn

    OnBtn.MouseButton1Click:Connect(function()
        State[stateKey] = true
        OnBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        OnBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OffBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        OffBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        XayzNotify("Setting", text .. " Enabled", 2)
    end)
    
    OffBtn.MouseButton1Click:Connect(function()
        State[stateKey] = false
        OffBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        OffBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        OnBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        OnBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        XayzNotify("Setting", text .. " Disabled", 2)
    end)
    return Frame
end

local function CreateDropdown(page, text)
    local Container = Instance.new("Frame")
    Container.Parent = page
    Container.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
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
    HeaderBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
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
    
    UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        updateSize()
    end)
    
    return ItemsFrame
end

local function CreateToggle(page, text, stateKey, parentStateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
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
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    
    local Button = Instance.new("TextButton")
    Button.Parent = Frame
    Button.Position = UDim2.new(1, -50, 0.5, -8)
    Button.Size = UDim2.new(0, 36, 0, 16)
    Button.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
    Button.Text = ""
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(1, 0)
    BCorner.Parent = Button
    
    local Status = Instance.new("Frame")
    Status.Parent = Button
    Status.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Status.Position = UDim2.new(0, 2, 0.5, -6)
    Status.Size = UDim2.new(0, 12, 0, 12)
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(1, 0)
    SCorner.Parent = Status

    local function updateUI()
        if State[stateKey] then
            Status.Position = UDim2.new(1, -14, 0.5, -6)
            Status.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        else
            Status.Position = UDim2.new(0, 2, 0.5, -6)
            Status.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        end
    end

    RunService.RenderStepped:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            Label.TextColor3 = Color3.fromRGB(80, 80, 90)
            Button.AutoButtonColor = false
        else
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Button.AutoButtonColor = true
        end
    end)
    
    updateUI()

    Button.MouseButton1Click:Connect(function()
        if parentStateKey and not State[parentStateKey] then 
            return 
        end
        State[stateKey] = not State[stateKey]
        
        if not State.PerformanceMode then
            local tInfo = TweenInfo.new(0.2)
            local tGoal = {}
            if State[stateKey] then
                tGoal.Position = UDim2.new(1, -14, 0.5, -6)
                tGoal.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            else
                tGoal.Position = UDim2.new(0, 2, 0.5, -6)
                tGoal.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            end
            TweenService:Create(Status, tInfo, tGoal):Play()
        else
            if State[stateKey] then
                Status.Position = UDim2.new(1, -14, 0.5, -6)
                Status.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            else
                Status.Position = UDim2.new(0, 2, 0.5, -6)
                Status.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        
        local onOffText = "Disabled"
        if State[stateKey] then
            onOffText = "Enabled"
        end
        XayzNotify(text, onOffText, 2)
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
            Btn.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
            Btn.TextColor3 = Color3.fromRGB(80, 80, 90)
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
    Box.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
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
            Box.TextColor3 = Color3.fromRGB(80, 80, 90)
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
    Frame.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
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
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    
    local MinusBtn = Instance.new("TextButton")
    MinusBtn.Parent = Frame
    MinusBtn.Position = UDim2.new(1, -100, 0.5, -12)
    MinusBtn.Size = UDim2.new(0, 24, 0, 24)
    MinusBtn.BackgroundColor3 = Color3.fromRGB(35, 36, 42)
    MinusBtn.Text = "-"
    MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local MCorner = Instance.new("UICorner")
    MCorner.CornerRadius = UDim.new(0, 4)
    MCorner.Parent = MinusBtn
    
    local ValueBox = Instance.new("TextBox")
    ValueBox.Parent = Frame
    ValueBox.Position = UDim2.new(1, -70, 0.5, -12)
    ValueBox.Size = UDim2.new(0, 34, 0, 24)
    ValueBox.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
    ValueBox.Text = tostring(State[stateKey])
    ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local VCorner = Instance.new("UICorner")
    VCorner.CornerRadius = UDim.new(0, 4)
    VCorner.Parent = ValueBox
    
    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Parent = Frame
    PlusBtn.Position = UDim2.new(1, -30, 0.5, -12)
    PlusBtn.Size = UDim2.new(0, 24, 0, 24)
    PlusBtn.BackgroundColor3 = Color3.fromRGB(35, 36, 42)
    PlusBtn.Text = "+"
    PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local PCorner = Instance.new("UICorner")
    PCorner.CornerRadius = UDim.new(0, 4)
    PCorner.Parent = PlusBtn

    RunService.RenderStepped:Connect(function()
        if parentStateKey and not State[parentStateKey] then
            Label.TextColor3 = Color3.fromRGB(80, 80, 90)
            ValueBox.TextColor3 = Color3.fromRGB(80, 80, 90)
            ValueBox.TextEditable = false
            MinusBtn.AutoButtonColor = false
            PlusBtn.AutoButtonColor = false
        else
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
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
        if parentStateKey and not State[parentStateKey] then 
            return 
        end
        if State[stateKey] > 1 then 
            update(State[stateKey] - 1) 
        end 
    end)
    
    PlusBtn.MouseButton1Click:Connect(function() 
        if parentStateKey and not State[parentStateKey] then 
            return 
        end
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

CreateDualSwitch(PageSettings, "Performance Mode", "PerformanceMode")

CreateToggle(PageCombat, "Aimbot", "Aimbot", nil)
local DropAim = CreateDropdown(PageCombat, "Advanced Aimbot")
CreateToggle(DropAim, "Show FOV Circle", "Aim_ShowFOV", "Aimbot")
CreateToggle(DropAim, "Silent Aim", "SilentAim", "Aimbot")
CreateStepper(DropAim, "Set FOV Size", "Aim_FOVSize", "Aimbot")
CreateButton(DropAim, "Switch Target: HEAD/TORSO", Color3.fromRGB(200, 100, 0), function(btn)
    if State.Aim_Part == "Head" then
        State.Aim_Part = "HumanoidRootPart"
    else
        State.Aim_Part = "Head"
    end
    btn.Text = "Target: " .. string.upper(State.Aim_Part)
end, "Aimbot")

CreateToggle(PageCombat, "ForceField", "ForceField", nil)
CreateToggle(PageCombat, "Fly", "Fly", nil)
CreateStepper(PageCombat, "Fly Speed", "FlySpeed", "Fly")

CreateToggle(PageVisual, "ESP", "ESP", nil)
local DropESP = CreateDropdown(PageVisual, "Advanced ESP")
CreateToggle(DropESP, "Show Box", "ESP_Box", "ESP")
CreateToggle(DropESP, "Show Name & Distance", "ESP_Name", "ESP")
CreateToggle(DropESP, "Show Healthbar", "ESP_Health", "ESP")
CreateToggle(DropESP, "Show Tracer (Lines)", "ESP_Tracer", "ESP")
CreateToggle(DropESP, "Show Chams (Highlight)", "ESP_Chams", "ESP")

CreateInput(PageVisual, "Set POV Camera (1-120)", "POV", nil)

CreateToggle(PageFlings, "Fling", "FlingV2", nil)
CreateToggle(PageFlings, "Fling V2", "FlingV3", nil)
CreateInput(PageFlings, "Set Fling Power (Def: 50)", "FlingPower", nil)
CreateToggle(PageFlings, "Super Touch Fling", "SuperFling", nil)

CreateButton(PageFlings, "Teleport to ALL Players", Color3.fromRGB(100, 150, 255), function()
    XayzNotify("Teleporting", "Transporting to all players...", 3)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            task.wait(0.2)
        end
    end
end, nil)

CreateButton(PageFlings, "Fling ALL Players", Color3.fromRGB(255, 50, 50), function()
    XayzNotify("Fling All", "Executing mass fling...", 3)
    local oldFling = State.SuperFling
    State.SuperFling = true
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            task.wait(0.3)
        end
    end
    State.SuperFling = oldFling
end, nil)

CreateButton(PageFlings, "Dropkick", Color3.fromRGB(150, 50, 255), function()
    XayzNotify("Executing", "Loading Dropkick script...", 2)
    pcall(function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua"))() 
    end)
end, nil)

CreateToggle(PageFlings, "Dino Animation", "DinoAnim", nil)
CreateToggle(PageFlings, "Punch Animation", "PunchAnim", nil)

CreateButton(PageWorld, "Obliterator Tool", Color3.fromRGB(138, 43, 226), function()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local tool1 = Instance.new("Tool")
    tool1.Name = "OBLITERATOR"
    tool1.RequiresHandle = true
    local handle1 = Instance.new("Part", tool1)
    handle1.Name = "Handle"
    handle1.Size = Vector3.new(1, 1, 1)
    handle1.Color = Color3.fromRGB(138, 43, 226)

    tool1.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        if target and target:IsA("BasePart") and not target:IsDescendantOf(LocalPlayer.Character) then
            target.CanCollide = false
            target.Transparency = 1
            target:BreakJoints()
            target.Position = Vector3.new(0, -1000, 0)
        end
    end)
    tool1.Parent = backpack
    XayzNotify("Obliterator", "Tool added to Backpack!", 2)
end, nil)

CreateButton(PageWorld, "Get F3X (Btools)", Color3.fromRGB(0, 200, 100), function()
    pcall(function()
        loadstring(game:GetObjects("rbxassetid://142785488")[1].Source)()
    end)
    XayzNotify("F3X Loaded", "Check your inventory.", 2)
end, nil)

CreateButton(PageWorld, "Get F3X (Btools) (Backup)", Color3.fromRGB(0, 200, 100), function()
    pcall(function()
        loadstring(game:GetObjects("rbxassetid://142485815")[1].Source)()
    end)
    XayzNotify("F3X Loaded", "Check your inventory.", 2)
end, nil)

CreateToggle(PageWorld, "Become HD Admin Owner", "HDAdmin", nil)

CreateToggle(PageWorld, "Super Rings", "SuperRing", nil)
local DropRing = CreateDropdown(PageWorld, "Advanced Rings")
CreateStepper(DropRing, "Ring Speed", "RingSpeed", "SuperRing")
CreateStepper(DropRing, "Ring Height", "RingHeight", "SuperRing")
CreateStepper(DropRing, "Ring Distance", "RingDistance", "SuperRing")
CreateStepper(DropRing, "Attraction Power", "RingAttraction", "SuperRing")

CreateToggle(PageWorld, "Blackhole", "Blackhole", nil)
CreateStepper(PageWorld, "Blackhole Distance", "BlackholeDistance", "Blackhole")

local FlyLoop = nil
local FlyBV = nil
local FlyBG = nil
local tpwalking = false

RunService.RenderStepped:Connect(function()
    if State.Fly and not tpwalking then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
        
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
        local hum = char and char:FindFirstChild("Humanoid")
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

local function GetClosestPlayer()
    local target = nil
    local shortDist = State.Aim_FOVSize
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
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
    return target
end

local OldNamecall = nil
if getnamecallmethod and hookmetamethod then
    OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if State.Aimbot and State.SilentAim and not checkcaller() and (method == "FindPartOnRayWithIgnoreList" or method == "Raycast") then
            local closest = GetClosestPlayer()
            if closest and closest.Character and closest.Character:FindFirstChild(State.Aim_Part) then
                local targetPos = closest.Character[State.Aim_Part].Position
                
                if method == "Raycast" then
                    local origin = args[1]
                    local direction = (targetPos - origin).Unit * 1000
                    args[2] = direction
                    return OldNamecall(self, unpack(args))
                elseif method == "FindPartOnRayWithIgnoreList" then
                    local origin = args[1].Origin
                    local direction = (targetPos - origin).Unit * 1000
                    args[1] = Ray.new(origin, direction)
                    return OldNamecall(self, unpack(args))
                end
            end
        end
        return OldNamecall(self, ...)
    end)
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
    
    if State.Aimbot and not State.SilentAim then
        local target = GetClosestPlayer()
        if target then 
            local pPartPos = target.Character[State.Aim_Part].Position
            local newCF = CFrame.new(Camera.CFrame.Position, pPartPos)
            Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.2) 
        end
    end

    if State.ESP then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local head = char and char:FindFirstChild("Head")
                local hum = char and char:FindFirstChild("Humanoid")
                
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

local flingBav = nil
local flingV3Conn = nil
local hdFired = false

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if State.FlingV2 or State.SuperFling then
        if hrp then
            if not flingBav then
                flingBav = Instance.new("BodyAngularVelocity")
                flingBav.Name = "XayzFling"
                flingBav.MaxTorque = Vector3.new(0, math.huge, 0)
                flingBav.P = math.huge
                flingBav.Parent = hrp
            end
            
            if State.SuperFling then
                flingBav.AngularVelocity = Vector3.new(0, 999999, 0)
            else
                flingBav.AngularVelocity = Vector3.new(0, State.FlingPower * 100, 0)
            end
        end
    else
        if flingBav then
            flingBav:Destroy()
            flingBav = nil
        end
        if hrp then
            hrp.RotVelocity = Vector3.new(0, 0, 0)
        end
    end
    
    if State.FlingV3 then
        if hrp and not flingV3Conn then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
                end
            end
            flingV3Conn = hrp.Touched:Connect(function(hit)
                if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= LocalPlayer.Name then
                    local victimRoot = hit.Parent:FindFirstChild("HumanoidRootPart")
                    if victimRoot then
                        victimRoot.Velocity = Vector3.new(999999999, 999999999, 999999999)
                    end
                end
            end)
        end
    else
        if flingV3Conn then
            flingV3Conn:Disconnect()
            flingV3Conn = nil
        end
    end
    
    if State.HDAdmin then
        if not hdFired then
            local HD = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdminClient")
            if HD then
                pcall(function()
                    local mainModule = require(LocalPlayer.PlayerScripts:WaitForChild("HDAdminClient"):WaitForChild("Main"))
                    mainModule.Settings.Rank = 5
                    mainModule.Settings.RankName = "The King Xayz 👑"
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdminRemote")
                    if remote then
                        remote:FireServer("Rank", LocalPlayer, 5) 
                    end
                end)
            end
            hdFired = true
        end
    else
        hdFired = false
    end
end)

local AnchorPart = nil
local AnchorAtt = nil

local function GetAnchorSetup()
    if not AnchorPart or not AnchorPart.Parent then
        AnchorPart = Instance.new("Part")
        AnchorPart.Name = "XayzAnchor"
        AnchorPart.Anchored = true
        AnchorPart.CanCollide = false
        AnchorPart.Transparency = 1
        AnchorPart.Parent = Workspace
        
        AnchorAtt = Instance.new("Attachment")
        AnchorAtt.Parent = AnchorPart
    end
    return AnchorPart, AnchorAtt
end

task.spawn(function()
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if sethiddenproperty then
                sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            end
        end)
    end)
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
    local char = LocalPlayer.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
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

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if State.ForceField then
        if not char:FindFirstChild("XayzFF") then
            local ff = Instance.new("ForceField")
            ff.Name = "XayzFF"
            ff.Visible = true
            ff.Parent = char
        end
    else
        local ff = char:FindFirstChild("XayzFF")
        if ff then 
            ff:Destroy() 
        end
    end

    local anchor, anchorAttachment = GetAnchorSetup()

    if State.Blackhole then
        anchor.CFrame = hrp.CFrame * CFrame.new(0, 0, -State.BlackholeDistance)
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and v.Name ~= "Handle" then
                v.CanCollide = false
                
                if not v:FindFirstChild("XayzAlign") then
                    local att0 = Instance.new("Attachment", v)
                    local align = Instance.new("AlignPosition", v)
                    align.Name = "XayzAlign"
                    align.Attachment0 = att0
                    align.Attachment1 = anchorAttachment
                    align.MaxForce = math.huge
                    align.MaxVelocity = math.huge
                    align.Responsiveness = 200
                    
                    local torque = Instance.new("Torque", v)
                    torque.Name = "XayzTorque"
                    torque.Attachment0 = att0
                    torque.Torque = Vector3.new(100000, 100000, 100000)
                end
            end
        end
    elseif State.SuperRing then
        local unanchoredParts = {}
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and v.Name ~= "Handle" then
                table.insert(unanchoredParts, v)
                v.CanCollide = false
                
                if v:FindFirstChild("XayzAlign") then
                    v:FindFirstChild("XayzAlign"):Destroy()
                end
                if v:FindFirstChild("XayzTorque") then
                    v:FindFirstChild("XayzTorque"):Destroy()
                end
                local att = v:FindFirstChildOfClass("Attachment")
                if att and not att:FindFirstChildOfClass("AlignPosition") then
                    att:Destroy()
                end
            end
        end
        
        local totalParts = #unanchoredParts
        for i, part in ipairs(unanchoredParts) do
            local angle = (i / totalParts) * math.pi * 2
            local newAngle = angle + math.rad(tick() * State.RingSpeed * 10)
            
            local targetPos = Vector3.new(
                hrp.Position.X + math.cos(newAngle) * State.RingDistance,
                hrp.Position.Y + State.RingHeight,
                hrp.Position.Z + math.sin(newAngle) * State.RingDistance
            )
            
            local dir = (targetPos - part.Position).Unit
            part.Velocity = dir * State.RingAttraction
        end
    else
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") and v:FindFirstChild("XayzAlign") then
                v:FindFirstChild("XayzAlign"):Destroy()
                if v:FindFirstChild("XayzTorque") then
                    v:FindFirstChild("XayzTorque"):Destroy()
                end
            end
        end
    end
end)