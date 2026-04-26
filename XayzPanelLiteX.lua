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
    HealLoop = false,
    GodModeV4 = false,
    WideAvatar = 1,
    
    DinoAnim = false,
    PunchAnim = false,
    ArmAnim = false,
    ArmSpeed = 15,
    ArmIntensity = 0.5,
    ShowStick = false,
    FakeKiller = false,
    
    SuperRing = false,
    RingSpeed = 40,
    RingHeight = 5,
    RingDistance = 50,
    RingAttraction = 1000,
    Blackhole = false,
    BlackholeRadius = 30,
    BlackholeSpeed = 999,
    
    MainColor = Color3.fromRGB(138, 43, 226),
    RGBGaming = false,
    
    VM_Power = false,
    VM_UserAgent = "Windows"
}

local ConfigFileName = "XayzConfig.json"
pcall(function()
    if readfile and isfile and isfile(ConfigFileName) then
        local data = HttpService:JSONDecode(readfile(ConfigFileName))
        if data.R and data.G and data.B then
            State.MainColor = Color3.fromRGB(data.R, data.G, data.B)
        end
        if data.RGBGaming ~= nil then
            State.RGBGaming = data.RGBGaming
        end
    end
end)

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
    NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
    NotifFrame.Size = UDim2.new(1, 0, 0, 65)
    NotifFrame.BackgroundTransparency = State.PerformanceMode and 0 or 1
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = State.MainColor
    NotifStroke.Thickness = 1
    NotifStroke.Parent = NotifFrame

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = NotifFrame
    
    local Accent = Instance.new("Frame")
    Accent.Parent = NotifFrame
    Accent.BackgroundColor3 = State.MainColor
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
    ProgBg.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
    ProgBg.Position = UDim2.new(0, 15, 1, -5)
    ProgBg.Size = UDim2.new(1, -25, 0, 3)
    ProgBg.BackgroundTransparency = State.PerformanceMode and 0 or 1
    
    local ProgBgCorner = Instance.new("UICorner")
    ProgBgCorner.CornerRadius = UDim.new(1, 0)
    ProgBgCorner.Parent = ProgBg
    
    local ProgFill = Instance.new("Frame")
    ProgFill.Parent = ProgBg
    ProgFill.BackgroundColor3 = State.MainColor
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

local MainWrapper = Instance.new("Frame")
MainWrapper.Parent = ScreenGui
MainWrapper.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
MainWrapper.Position = UDim2.new(0.5, -250, 0.5, -175)
MainWrapper.Size = UDim2.new(0, 500, 0, 350)
MakeDraggable(MainWrapper)

local MainWrapperCorner = Instance.new("UICorner")
MainWrapperCorner.CornerRadius = UDim.new(0, 8)
MainWrapperCorner.Parent = MainWrapper

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainWrapper
MainStroke.Color = State.MainColor
MainStroke.Thickness = 2

local RGBGradient = Instance.new("UIGradient")
RGBGradient.Parent = MainStroke
RGBGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, State.MainColor),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1.00, State.MainColor)
}

RunService.RenderStepped:Connect(function()
    if not State.PerformanceMode then
        RGBGradient.Rotation = (RGBGradient.Rotation + 2) % 360
    end
    if State.RGBGaming then
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 1, 1)
        State.MainColor = color
    end
    MainStroke.Color = State.MainColor
end)

local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = MainWrapper
LoadFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.ZIndex = 100

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 8)
LoadCorner.Parent = LoadFrame

local AuraText = Instance.new("TextLabel")
AuraText.Parent = LoadFrame
AuraText.BackgroundTransparency = 1
AuraText.Position = UDim2.new(0, 0, 0.4, -20)
AuraText.Size = UDim2.new(1, 0, 0, 40)
AuraText.Font = Enum.Font.GothamBlack
AuraText.Text = "X A Y Z   L I T E  X"
AuraText.TextColor3 = Color3.fromRGB(255, 255, 255)
AuraText.TextSize = 28
AuraText.ZIndex = 101

local TextGradient = Instance.new("UIGradient")
TextGradient.Parent = AuraText
TextGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(0.5, State.MainColor),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(50, 50, 50))
}
TextGradient.Offset = Vector2.new(-1, 0)

local Spinner = Instance.new("Frame")
Spinner.Parent = LoadFrame
Spinner.BackgroundTransparency = 1
Spinner.Position = UDim2.new(0.5, -20, 0.6, 0)
Spinner.Size = UDim2.new(0, 40, 0, 40)
Spinner.ZIndex = 101

local SpinnerCorner = Instance.new("UICorner")
SpinnerCorner.CornerRadius = UDim.new(0.5, 0)
SpinnerCorner.Parent = Spinner

local SpinnerStroke = Instance.new("UIStroke")
SpinnerStroke.Parent = Spinner
SpinnerStroke.Thickness = 4
SpinnerStroke.Color = State.MainColor
SpinnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local SpinnerGradient = Instance.new("UIGradient")
SpinnerGradient.Parent = SpinnerStroke
SpinnerGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0.0, 0.0), 
    NumberSequenceKeypoint.new(0.5, 0.8), 
    NumberSequenceKeypoint.new(1.0, 1.0) 
})

task.spawn(function()
    local t = 0
    local loading = true
    
    task.spawn(function()
        while loading do
            t = t + 0.05
            Spinner.Rotation = Spinner.Rotation + 10
            TextGradient.Offset = Vector2.new(math.sin(t), 0)
            SpinnerStroke.Color = State.MainColor
            TextGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.0, Color3.fromRGB(50, 50, 50)),
                ColorSequenceKeypoint.new(0.5, State.MainColor),
                ColorSequenceKeypoint.new(1.0, Color3.fromRGB(50, 50, 50))
            }
            task.wait(0.03)
        end
    end)
    
    task.wait(10)
    loading = false
    
    local fadeOut = TweenInfo.new(0.5)
    TweenService:Create(AuraText, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(SpinnerStroke, fadeOut, {Transparency = 1}):Play()
    task.wait(0.5)
    TweenService:Create(LoadFrame, fadeOut, {BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    LoadFrame.Visible = false
    
    XayzNotify("System Online", "Welcome to Xayz Panel LiteX", 4)
end)

local Header = Instance.new("Frame")
Header.Parent = MainWrapper
Header.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "XAYZ LITE X"

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
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
MaximizeBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
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
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Parent = MainWrapper
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 140, 1, -40)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainWrapper
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 150, 0, 50)
ContentArea.Size = UDim2.new(1, -160, 1, -60)

MinimizeBtn.MouseButton1Click:Connect(function()
    if not State.PerformanceMode then
        local tInfo = TweenInfo.new(0.3)
        TweenService:Create(MainWrapper, tInfo, {Size = UDim2.new(0, 500, 0, 40)}):Play()
    else
        MainWrapper.Size = UDim2.new(0, 500, 0, 40)
    end
    Sidebar.Visible = false
    ContentArea.Visible = false
end)

MaximizeBtn.MouseButton1Click:Connect(function()
    if not State.PerformanceMode then
        local tInfo = TweenInfo.new(0.3)
        TweenService:Create(MainWrapper, tInfo, {Size = UDim2.new(0, 500, 0, 350)}):Play()
        task.wait(0.3)
    else
        MainWrapper.Size = UDim2.new(0, 500, 0, 350)
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

local function CreateTabBtn(text, pageName)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Sidebar
    Btn.BackgroundTransparency = 1
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(120, 130, 150)
    Btn.TextSize = 12
    Btn.Text = text

    Btn.MouseButton1Click:Connect(function()
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.TextColor3 = Color3.fromRGB(120, 130, 150)
            end
        end
        Btn.TextColor3 = State.MainColor
        SwitchPage(pageName)
    end)
    
    RunService.RenderStepped:Connect(function()
        if Pages[pageName].Visible then
            Btn.TextColor3 = State.MainColor
        end
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
local PageWorld = CreatePage("World")
local PageAdmin = CreatePage("Admin")
local PageVM = CreatePage("VirtualMachine")
local PageCustomUI = CreatePage("CustomUI")
local PageSettings = CreatePage("Settings")

SwitchPage("Combat")
local Tab1 = CreateTabBtn("⚔️ COMBAT", "Combat")
Tab1.TextColor3 = State.MainColor
CreateTabBtn("👁️ VISUAL", "Visual")
CreateTabBtn("🌪️ FLINGS", "Flings")
CreateTabBtn("🌍 WORLD", "World")
CreateTabBtn("🛡️ ADMIN", "Admin")
CreateTabBtn("🌐 VM", "VirtualMachine")
CreateTabBtn("🎨 CUSTOM UI", "CustomUI")
CreateTabBtn("⚙️ SETTINGS", "Settings")

local function CreateDualSwitch(page, text, stateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    Frame.Size = UDim2.new(1, -5, 0, 45)
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Frame
    FStroke.Color = Color3.fromRGB(40, 45, 60)
    FStroke.Thickness = 1
    
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
    OnBtn.BackgroundColor3 = State[stateKey] and Color3.fromRGB(50, 255, 100) or Color3.fromRGB(40, 45, 60)
    OnBtn.Text = "ON"
    OnBtn.Font = Enum.Font.GothamBold
    OnBtn.TextColor3 = State[stateKey] and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 200, 200)
    local OnCorner = Instance.new("UICorner")
    OnCorner.CornerRadius = UDim.new(0, 4)
    OnCorner.Parent = OnBtn

    local OffBtn = Instance.new("TextButton")
    OffBtn.Parent = Frame
    OffBtn.Position = UDim2.new(0.55, 0, 0, 20)
    OffBtn.Size = UDim2.new(0.35, 0, 0, 20)
    OffBtn.BackgroundColor3 = not State[stateKey] and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(40, 45, 60)
    OffBtn.Text = "OFF"
    OffBtn.Font = Enum.Font.GothamBold
    OffBtn.TextColor3 = not State[stateKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    local OffCorner = Instance.new("UICorner")
    OffCorner.CornerRadius = UDim.new(0, 4)
    OffCorner.Parent = OffBtn

    OnBtn.MouseButton1Click:Connect(function()
        State[stateKey] = true
        OnBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        OnBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OffBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        OffBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        XayzNotify("Setting", text .. " Enabled", 2)
    end)
    
    OffBtn.MouseButton1Click:Connect(function()
        State[stateKey] = false
        OffBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        OffBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        OnBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        OnBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        XayzNotify("Setting", text .. " Disabled", 2)
    end)
    return Frame
end

local function CreateDropdown(page, text)
    local Container = Instance.new("Frame")
    Container.Parent = page
    Container.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    Container.Size = UDim2.new(1, -5, 0, 35)
    Container.ClipsDescendants = true
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Container
    FStroke.Color = Color3.fromRGB(40, 45, 60)
    FStroke.Thickness = 1

    local ContCorner = Instance.new("UICorner")
    ContCorner.CornerRadius = UDim.new(0, 6)
    ContCorner.Parent = Container

    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.Parent = Container
    HeaderBtn.BackgroundTransparency = 1
    HeaderBtn.Position = UDim2.new(0, 10, 0, 0)
    HeaderBtn.Size = UDim2.new(1, -10, 0, 35)
    HeaderBtn.Font = Enum.Font.GothamBold
    HeaderBtn.TextColor3 = State.MainColor
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
    
    RunService.RenderStepped:Connect(function()
        HeaderBtn.TextColor3 = State.MainColor
    end)
    
    return ItemsFrame
end

local function CreateToggle(page, text, stateKey, parentStateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    Frame.Size = UDim2.new(1, -5, 0, 35)
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Frame
    FStroke.Color = Color3.fromRGB(40, 45, 60)
    FStroke.Thickness = 1
    
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
    Button.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
    Button.Text = ""
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(1, 0)
    BCorner.Parent = Button
    
    local Status = Instance.new("Frame")
    Status.Parent = Button
    Status.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    Status.Position = UDim2.new(0, 2, 0.5, -6)
    Status.Size = UDim2.new(0, 12, 0, 12)
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(1, 0)
    SCorner.Parent = Status

    local function updateUI()
        if State[stateKey] then
            Status.Position = UDim2.new(1, -14, 0.5, -6)
            Status.BackgroundColor3 = State.MainColor
        else
            Status.Position = UDim2.new(0, 2, 0.5, -6)
            Status.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
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
        if State[stateKey] then
            Status.BackgroundColor3 = State.MainColor
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
                tGoal.BackgroundColor3 = State.MainColor
            else
                tGoal.Position = UDim2.new(0, 2, 0.5, -6)
                tGoal.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
            end
            TweenService:Create(Status, tInfo, tGoal):Play()
        else
            if State[stateKey] then
                Status.Position = UDim2.new(1, -14, 0.5, -6)
                Status.BackgroundColor3 = State.MainColor
            else
                Status.Position = UDim2.new(0, 2, 0.5, -6)
                Status.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
            end
        end
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
            if color == "Main" then
                Btn.BackgroundColor3 = State.MainColor
            else
                Btn.BackgroundColor3 = color
            end
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
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Box
    FStroke.Color = Color3.fromRGB(40, 45, 60)
    FStroke.Thickness = 1
    
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

local function CreateStepper(page, text, stateKey, parentStateKey, isFloat)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
    Frame.Size = UDim2.new(1, -5, 0, 35)
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Frame
    FStroke.Color = Color3.fromRGB(40, 45, 60)
    FStroke.Thickness = 1
    
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
    MinusBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    MinusBtn.Text = "-"
    MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local MCorner = Instance.new("UICorner")
    MCorner.CornerRadius = UDim.new(0, 4)
    MCorner.Parent = MinusBtn
    
    local ValueBox = Instance.new("TextBox")
    ValueBox.Parent = Frame
    ValueBox.Position = UDim2.new(1, -70, 0.5, -12)
    ValueBox.Size = UDim2.new(0, 34, 0, 24)
    ValueBox.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
    ValueBox.Text = tostring(State[stateKey])
    ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    local VCorner = Instance.new("UICorner")
    VCorner.CornerRadius = UDim.new(0, 4)
    VCorner.Parent = ValueBox
    
    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Parent = Frame
    PlusBtn.Position = UDim2.new(1, -30, 0.5, -12)
    PlusBtn.Size = UDim2.new(0, 24, 0, 24)
    PlusBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
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

    local stepVal = isFloat and 0.5 or 1

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
        update(State[stateKey] - stepVal) 
    end)
    
    PlusBtn.MouseButton1Click:Connect(function() 
        if parentStateKey and not State[parentStateKey] then 
            return 
        end
        update(State[stateKey] + stepVal) 
    end)
    
    ValueBox.FocusLost:Connect(function()
        if parentStateKey and not State[parentStateKey] then 
            ValueBox.Text = tostring(State[stateKey])
            return 
        end
        local num = tonumber(ValueBox.Text)
        if num then 
            update(num) 
        else 
            update(isFloat and 0.5 or 1) 
        end
    end)
    return Frame
end

CreateToggle(PageCombat, "Aimbot", "Aimbot", nil)
local DropAim = CreateDropdown(PageCombat, "Advanced Aimbot")
CreateToggle(DropAim, "Show FOV Circle", "Aim_ShowFOV", "Aimbot")
CreateToggle(DropAim, "Silent Aim", "SilentAim", "Aimbot")
CreateStepper(DropAim, "Set FOV Size", "Aim_FOVSize", "Aimbot", false)
CreateButton(DropAim, "Switch Target: HEAD/TORSO", Color3.fromRGB(200, 100, 0), function(btn)
    if State.Aim_Part == "Head" then
        State.Aim_Part = "HumanoidRootPart"
    else
        State.Aim_Part = "Head"
    end
    btn.Text = "Target: " .. string.upper(State.Aim_Part)
end, "Aimbot")

CreateToggle(PageCombat, "Heal Loop", "HealLoop", nil)
CreateToggle(PageCombat, "God Mode", "GodModeV4", nil)
CreateToggle(PageCombat, "ForceField", "ForceField", nil)

CreateToggle(PageCombat, "Fly", "Fly", nil)
CreateStepper(PageCombat, "Fly Speed", "FlySpeed", "Fly", false)

CreateToggle(PageVisual, "ESP", "ESP", nil)
local DropESP = CreateDropdown(PageVisual, "Advanced ESP")
CreateToggle(DropESP, "Show Box", "ESP_Box", "ESP")
CreateToggle(DropESP, "Show Name & Distance", "ESP_Name", "ESP")
CreateToggle(DropESP, "Show Healthbar", "ESP_Health", "ESP")
CreateToggle(DropESP, "Show Tracer", "ESP_Tracer", "ESP")
CreateToggle(DropESP, "Show Chams", "ESP_Chams", "ESP")
CreateInput(PageVisual, "Set POV Camera (1-120)", "POV", nil)

CreateToggle(PageFlings, "Fling", "FlingV2", nil)
CreateToggle(PageFlings, "Fling V2", "FlingV3", nil)
CreateInput(PageFlings, "Set Fling Power (Def: 50)", "FlingPower", nil)
CreateToggle(PageFlings, "Super Touch Fling", "SuperFling", nil)

CreateButton(PageFlings, "Teleport to ALL Players", "Main", function()
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

CreateToggle(PageFlings, "Shake Arm", "ArmAnim", nil)
local DropArm = CreateDropdown(PageFlings, "Advanced Arm Mover")
CreateStepper(DropArm, "Arm Speed", "ArmSpeed", "ArmAnim", false)
CreateStepper(DropArm, "Arm Intensity", "ArmIntensity", "ArmAnim", true)

CreateToggle(PageFlings, "married/gay", "FakeKiller", nil)
CreateToggle(PageFlings, "Show penis", "ShowStick", "FakeKiller")
CreateButton(PageFlings, "release sperm fluid", Color3.fromRGB(200, 200, 200), function()
    local char = LocalPlayer.Character
    local myToolFind = char and char:FindFirstChild("StickWood")
    if char and char:FindFirstChild("HumanoidRootPart") and myToolFind and myToolFind:FindFirstChild("Tip") then
        for i = 1, 50 do
            local drop = Instance.new("Part", Workspace)
            drop.Size = Vector3.new(0.2, 0.2, 0.2)
            drop.Color = Color3.fromRGB(255, 255, 255)
            drop.Material = Enum.Material.Neon
            drop.Shape = Enum.PartType.Ball
            drop.Position = myToolFind.Tip.Position
            drop.Velocity = (myToolFind.Tip.CFrame.LookVector * 50) + Vector3.new(0, 20, 0)
            game:GetService("Debris"):AddItem(drop, 2)
            task.wait(0.05)
        end
    end
end, "FakeKiller")

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

CreateButton(PageWorld, "Switch to R6", Color3.fromRGB(0, 150, 200), function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
            local desc = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
            local model = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)
            model:PivotTo(char:GetPivot())
            model.Name = LocalPlayer.Name
            LocalPlayer.Character = model
            model.Parent = Workspace
        end
    end
end, nil)

CreateButton(PageWorld, "Switch to R15", Color3.fromRGB(0, 200, 150), function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            local desc = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
            local model = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15)
            model:PivotTo(char:GetPivot())
            model.Name = LocalPlayer.Name
            LocalPlayer.Character = model
            model.Parent = Workspace
        end
    end
end, nil)

CreateStepper(PageWorld, "Wide Avatar", "WideAvatar", nil, true)

CreateToggle(PageWorld, "Super Rings", "SuperRing", nil)
local DropRing = CreateDropdown(PageWorld, "Advanced Rings")
CreateStepper(DropRing, "Ring Speed", "RingSpeed", "SuperRing", false)
CreateStepper(DropRing, "Ring Height", "RingHeight", "SuperRing", false)
CreateStepper(DropRing, "Ring Distance", "RingDistance", "SuperRing", false)
CreateStepper(DropRing, "Attraction Power", "RingAttraction", "SuperRing", false)

CreateToggle(PageWorld, "Blackhole", "Blackhole", nil)
local DropBH = CreateDropdown(PageWorld, "Advanced Blackhole")
CreateStepper(DropBH, "Blackhole Distance", "BlackholeDistance", "Blackhole", false)
CreateStepper(DropBH, "Blackhole Radius", "BlackholeRadius", "Blackhole", false)
CreateStepper(DropBH, "Blackhole Speed", "BlackholeSpeed", "Blackhole", false)

CreateButton(PageAdmin, "Get F3X", "Main", function()
    pcall(function()
        local importFunc = getgenv and getgenv().import or import
        if importFunc then importFunc(12158566951)(LocalPlayer.Name) end
    end)
    XayzNotify("F3X Loaded", "Check your inventory.", 2)
end, nil)

CreateButton(PageAdmin, "Get Btools", "Main", function()
    pcall(function()
        local importFunc = getgenv and getgenv().import or import
        if importFunc then importFunc(16530393933)(LocalPlayer.Name) end
    end)
    XayzNotify("Btools Loaded", "Check your inventory.", 2)
end, nil)

local function SetHDRank(rankId, rankName)
    pcall(function()
        if _G.HDAdminMain then
            _G.HDAdminMain:GetModule("cf"):SetRank(LocalPlayer, game.CreatorId, rankId, "Perm")
        end
    end)
    XayzNotify("HD Admin", "Rank set to " .. rankName, 2)
end

local DropHD = CreateDropdown(PageAdmin, "HD Admin Roles")
CreateButton(DropHD, "Add HD Admin", Color3.fromRGB(50, 50, 50), function()
    pcall(function()
        local importFunc = getgenv and getgenv().import or import
        if importFunc then importFunc(4893870373).load(LocalPlayer.Name) end
    end)
end, nil)
CreateButton(DropHD, "Rankless (0)", Color3.fromRGB(80, 80, 80), function() SetHDRank(0, "Rankless") end, nil)
CreateButton(DropHD, "VIP (1)", Color3.fromRGB(200, 200, 0), function() SetHDRank(1, "VIP") end, nil)
CreateButton(DropHD, "Mod (2)", Color3.fromRGB(0, 200, 0), function() SetHDRank(2, "Mod") end, nil)
CreateButton(DropHD, "Admin (3)", Color3.fromRGB(0, 100, 255), function() SetHDRank(3, "Admin") end, nil)
CreateButton(DropHD, "HeadAdmin (4)", Color3.fromRGB(255, 100, 0), function() SetHDRank(4, "HeadAdmin") end, nil)
CreateButton(DropHD, "Owner (5)", Color3.fromRGB(255, 0, 0), function() SetHDRank(5, "Owner") end, nil)
CreateButton(DropHD, "Above Owner", Color3.fromRGB(138, 43, 226), function() SetHDRank(math.huge, "Above Owner") end, nil)

local VMWrapper = Instance.new("Frame")
VMWrapper.Parent = PageVM
VMWrapper.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
VMWrapper.Size = UDim2.new(1, -5, 0, 250)
local VMWrapperCorner = Instance.new("UICorner")
VMWrapperCorner.CornerRadius = UDim.new(0, 8)
VMWrapperCorner.Parent = VMWrapper

local VMHeader = Instance.new("Frame")
VMHeader.Parent = VMWrapper
VMHeader.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
VMHeader.Size = UDim2.new(1, 0, 0, 30)
local VMHeaderCorner = Instance.new("UICorner")
VMHeaderCorner.CornerRadius = UDim.new(0, 8)
VMHeaderCorner.Parent = VMHeader

local VMTitle = Instance.new("TextLabel")
VMTitle.Parent = VMHeader
VMTitle.BackgroundTransparency = 1
VMTitle.Position = UDim2.new(0, 10, 0, 0)
VMTitle.Size = UDim2.new(1, -20, 1, 0)
VMTitle.Font = Enum.Font.GothamBold
VMTitle.Text = "🌐 Sandbox"
VMTitle.TextColor3 = Color3.fromRGB(200, 220, 255)
VMTitle.TextSize = 12
VMTitle.TextXAlignment = Enum.TextXAlignment.Left

local VMContent = Instance.new("Frame")
VMContent.Parent = VMWrapper
VMContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VMContent.Position = UDim2.new(0, 10, 0, 40)
VMContent.Size = UDim2.new(1, -20, 1, -50)
local VMContentCorner = Instance.new("UICorner")
VMContentCorner.CornerRadius = UDim.new(0, 4)
VMContentCorner.Parent = VMContent

local VMBrowserMock = Instance.new("TextLabel")
VMBrowserMock.Parent = VMContent
VMBrowserMock.BackgroundTransparency = 1
VMBrowserMock.Size = UDim2.new(1, 0, 1, 0)
VMBrowserMock.Font = Enum.Font.Gotham
VMBrowserMock.Text = "Virtual Machine is OFF"
VMBrowserMock.TextColor3 = Color3.fromRGB(100, 100, 100)
VMBrowserMock.TextSize = 12
VMBrowserMock.TextWrapped = true

local DropUserAgent = CreateDropdown(PageVM, "Change User Agent")
CreateButton(DropUserAgent, "Windows", Color3.fromRGB(50, 50, 50), function() State.VM_UserAgent = "Windows" end, nil)
CreateButton(DropUserAgent, "Android", Color3.fromRGB(50, 50, 50), function() State.VM_UserAgent = "Android" end, nil)
CreateButton(DropUserAgent, "Linux", Color3.fromRGB(50, 50, 50), function() State.VM_UserAgent = "Linux" end, nil)

CreateDualSwitch(PageVM, "Power ON/OFF", "VM_Power")

RunService.RenderStepped:Connect(function()
    if State.VM_Power then
        VMContent.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        VMBrowserMock.Text = "Connected via " .. State.VM_UserAgent .. " User-Agent."
        VMBrowserMock.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        VMContent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        VMBrowserMock.Text = "Virtual Machine is OFF"
        VMBrowserMock.TextColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

local PreviewBox = Instance.new("Frame")
PreviewBox.Parent = PageCustomUI
PreviewBox.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
PreviewBox.Size = UDim2.new(1, -5, 0, 60)
local PreviewBoxCorner = Instance.new("UICorner")
PreviewBoxCorner.CornerRadius = UDim.new(0, 8)
PreviewBoxCorner.Parent = PreviewBox

local PreviewStroke = Instance.new("UIStroke")
PreviewStroke.Parent = PreviewBox
PreviewStroke.Color = State.MainColor
PreviewStroke.Thickness = 2

local PreviewText = Instance.new("TextLabel")
PreviewText.Parent = PreviewBox
PreviewText.BackgroundTransparency = 1
PreviewText.Size = UDim2.new(1, 0, 1, 0)
PreviewText.Font = Enum.Font.GothamBold
PreviewText.Text = "PREVIEW COLOR"
PreviewText.TextColor3 = State.MainColor
PreviewText.TextSize = 14

local TmpColor = State.MainColor

local PaletteFrame = Instance.new("Frame")
PaletteFrame.Parent = PageCustomUI
PaletteFrame.BackgroundTransparency = 1
PaletteFrame.Size = UDim2.new(1, -5, 0, 150)
local PaletteGrid = Instance.new("UIGridLayout")
PaletteGrid.Parent = PaletteFrame
PaletteGrid.CellSize = UDim2.new(0, 30, 0, 30)
PaletteGrid.CellPadding = UDim2.new(0, 5, 0, 5)
PaletteGrid.SortOrder = Enum.SortOrder.LayoutOrder

local colorList = {
    Color3.fromRGB(255,0,0), 
    Color3.fromRGB(0,255,0), 
    Color3.fromRGB(0,0,255), 
    Color3.fromRGB(255,255,0), 
    Color3.fromRGB(255,0,255),
    Color3.fromRGB(0,255,255), 
    Color3.fromRGB(255,128,0), 
    Color3.fromRGB(128,0,255), 
    Color3.fromRGB(255,0,128), 
    Color3.fromRGB(0,255,128),
    Color3.fromRGB(128,255,0), 
    Color3.fromRGB(0,128,255),
    Color3.fromRGB(255,255,255), 
    Color3.fromRGB(100,100,100), 
    Color3.fromRGB(50,50,50),
    Color3.fromRGB(138,43,226), 
    Color3.fromRGB(0,200,150), 
    Color3.fromRGB(255,100,100), 
    Color3.fromRGB(100,255,100), 
    Color3.fromRGB(100,100,255),
    Color3.fromRGB(255,200,100), 
    Color3.fromRGB(200,255,100), 
    Color3.fromRGB(100,200,255), 
    Color3.fromRGB(255,150,0), 
    Color3.fromRGB(0,150,255),
    Color3.fromRGB(150,0,255), 
    Color3.fromRGB(255,0,150), 
    Color3.fromRGB(0,255,150), 
    Color3.fromRGB(150,255,0), 
    Color3.fromRGB(200,0,0),
    Color3.fromRGB(0,200,0), 
    Color3.fromRGB(0,0,200), 
    Color3.fromRGB(200,200,0), 
    Color3.fromRGB(200,0,200), 
    Color3.fromRGB(0,200,200)
}

for i, col in ipairs(colorList) do
    local cBtn = Instance.new("TextButton")
    cBtn.Parent = PaletteFrame
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 4)
    cCorner.Parent = cBtn
    cBtn.MouseButton1Click:Connect(function()
        TmpColor = col
        PreviewStroke.Color = TmpColor
        PreviewText.TextColor3 = TmpColor
    end)
end

CreateDualSwitch(PageCustomUI, "RGB", "RGBGaming")

CreateButton(PageCustomUI, "Test Notify Custom", "Main", function()
    local oldC = State.MainColor
    State.MainColor = TmpColor
    XayzNotify("Test Custom", "This is how it looks!", 3)
    State.MainColor = oldC
end, nil)

CreateButton(PageCustomUI, "Apply Change", Color3.fromRGB(50, 200, 100), function()
    State.MainColor = TmpColor
    local configData = {
        R = math.floor(State.MainColor.R * 255),
        G = math.floor(State.MainColor.G * 255),
        B = math.floor(State.MainColor.B * 255),
        RGBGaming = State.RGBGaming
    }
    pcall(function()
        if writefile then
            writefile(ConfigFileName, HttpService:JSONEncode(configData))
        end
    end)
    XayzNotify("Theme Saved", "Colors applied successfully.", 3)
end, nil)

CreateButton(PageCustomUI, "Cancel", Color3.fromRGB(200, 50, 50), function()
    TmpColor = State.MainColor
    PreviewStroke.Color = TmpColor
    PreviewText.TextColor3 = TmpColor
end, nil)

CreateDualSwitch(PageSettings, "Performance Mode", "PerformanceMode")

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
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if State.HealLoop then
                hum.Health = hum.MaxHealth
            end
            if State.GodModeV4 then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            end
            
            local widthScale = hum:FindFirstChild("BodyWidthScale")
            local depthScale = hum:FindFirstChild("BodyDepthScale")
            if widthScale and depthScale then
                widthScale.Value = State.WideAvatar
                depthScale.Value = State.WideAvatar
            end
        end
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

local function CreateStick()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local model = Instance.new("Model", char)
    model.Name = "StickWood"

    local shaft = Instance.new("Part", model)
    shaft.Name = "Shaft"
    shaft.Size = Vector3.new(0.5, 0.5, 2.5)
    shaft.Color = Color3.fromRGB(255, 204, 153)
    shaft.Material = Enum.Material.SmoothPlastic
    shaft.CanCollide = false

    local tip = Instance.new("Part", model)
    tip.Name = "Tip"
    tip.Size = Vector3.new(0.6, 0.6, 0.6)
    tip.Shape = Enum.PartType.Ball
    tip.Color = Color3.fromRGB(255, 153, 204)
    tip.Parent = model

    local ball1 = Instance.new("Part", model)
    ball1.Size = Vector3.new(0.7, 0.7, 0.7)
    ball1.Shape = Enum.PartType.Ball
    ball1.Color = Color3.fromRGB(255, 204, 153)
    ball1.Parent = model

    local attachment = Instance.new("Attachment", root)
    attachment.Position = Vector3.new(0, -1, -0.5)
    
    local shaftAttachment = Instance.new("Attachment", shaft)
    shaftAttachment.Position = Vector3.new(0, 0, 1.25)

    local rope = Instance.new("BallSocketConstraint", char)
    rope.Attachment0 = attachment
    rope.Attachment1 = shaftAttachment
    
    return model
end

local myTool = nil
local mouse = LocalPlayer:GetMouse()
local targetPlayer = nil

mouse.Button1Down:Connect(function()
    if State.FakeKiller then
        local target = mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") then
            targetPlayer = target.Parent
            task.spawn(function()
                while targetPlayer and State.FakeKiller do
                    char:SetPrimaryPartCFrame(targetPlayer.PrimaryPartCFrame * CFrame.new(0, 0, 1))
            task.wait(0.1)
            char:SetPrimaryPartCFrame(targetPlayer.PrimaryPartCFrame * CFrame.new(0, 0, 0.5))
            task.wait(0.1)
                end
            end)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    local armJoint = nil
    local isR15 = char:FindFirstChild("UpperTorso") ~= nil
    if isR15 then
        local rArm = char:FindFirstChild("RightUpperArm")
        if rArm then armJoint = rArm:FindFirstChild("RightShoulder") end
    else
        local torso = char:FindFirstChild("Torso")
        if torso then armJoint = torso:FindFirstChild("Right Shoulder") end
    end

    if armJoint then
        local originalC0 = armJoint:GetAttribute("OriginalC0")
        if not originalC0 then
            armJoint:SetAttribute("OriginalC0", armJoint.C0)
            originalC0 = armJoint.C0
        end

        if State.ArmAnim then
            local move = math.sin(tick() * State.ArmSpeed) * State.ArmIntensity
            if isR15 then
                armJoint.C0 = originalC0 * CFrame.new(0, move, -0.5) * CFrame.Angles(math.rad(-90), 0, 0)
            else
                armJoint.C0 = originalC0 * CFrame.new(-0.2, move, -0.5) * CFrame.Angles(math.rad(-90), math.rad(20), 0)
            end
        else
            armJoint.C0 = originalC0
        end
    end
    
    if State.FakeKiller then
        if not myTool then
            myTool = CreateStick()
        end
        if myTool then
            myTool.Parent = char
            myTool.Visible = State.ShowStick
        end
    else
        if myTool then
            myTool:Destroy()
            myTool = nil
        end
    end
    
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