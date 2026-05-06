local CoreGui = nil
local successCoreGui, errCoreGui = pcall(function()
    local cGui = game:GetService("CoreGui")
    CoreGui = cGui
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
if not Camera then
    local fCam = Workspace:FindFirstChild("Camera")
    Camera = fCam
end

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
    WideAvatar = 100,
    DinoAnim = false,
    PunchAnim = false,
    ArmAnim = false,
    ArmSpeed = 15,
    ArmIntensity = 0.5,
    SuperRing = false,
    RingSpeed = 10,
    RingHeight = 100,
    RingDistance = 50,
    RingAttraction = 1000,
    Blackhole = false,
    BlackholeDistance = 20,
    MainColor = Color3.fromRGB(138, 43, 226),
    RGBGaming = false,
    VM_Power = false,
    VM_UserAgent = "Windows"
}

local ConfigFileName = "XayzConfig.json"

local function LoadConfig()
    local successLoad, errLoad = pcall(function()
        if readfile then
            if isfile then
                local isF = isfile(ConfigFileName)
                if isF then
                    local readStr = readfile(ConfigFileName)
                    local data = HttpService:JSONDecode(readStr)
                    for key, value in pairs(data) do
                        if key == "MainColor" then
                            local cVal = Color3.fromRGB(value.R, value.G, value.B)
                            State.MainColor = cVal
                        end
                        if key ~= "MainColor" then
                            State[key] = value
                        end
                    end
                end
            end
        end
    end)
end

LoadConfig()

local function SaveConfig()
    local configData = {}
    for key, value in pairs(State) do
        if key == "MainColor" then
            local rVal = math.floor(State.MainColor.R * 255)
            local gVal = math.floor(State.MainColor.G * 255)
            local bVal = math.floor(State.MainColor.B * 255)
            local tCol = {
                R = rVal,
                G = gVal,
                B = bVal
            }
            configData.MainColor = tCol
        end
        if key ~= "MainColor" then
            configData[key] = value
        end
    end
    local successSave, errSave = pcall(function()
        if writefile then
            local jsonStr = HttpService:JSONEncode(configData)
            writefile(ConfigFileName, jsonStr)
        end
    end)
end

local function FireAllRemotes(keyword, argsTable)
    local desc = game:GetDescendants()
    for _, obj in pairs(desc) do
        local isRem = obj:IsA("RemoteEvent")
        if isRem then
            local objName = string.lower(obj.Name)
            local isMatch = string.find(objName, keyword)
            if isMatch then
                local successFire, errFire = pcall(function()
                    obj:FireServer(unpack(argsTable))
                end)
            end
        end
    end
end

local getEnv = getgenv
local env = nil
if getEnv then
    env = getEnv()
end
if not env then
    env = _G
end

if not env.Network then
    local netTable = {}
    local basePartsList = {}
    netTable.BaseParts = basePartsList
    local defVel = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    netTable.Velocity = defVel

    local function retainPartFunc(part)
        local tType = typeof(part)
        if tType == "Instance" then
            local isBP = part:IsA("BasePart")
            if isBP then
                local isDesc = part:IsDescendantOf(Workspace)
                if isDesc then
                    table.insert(env.Network.BaseParts, part)
                    local physProp = PhysicalProperties.new(0, 0, 0, 0, 0)
                    part.CustomPhysicalProperties = physProp
                    part.CanCollide = false
                end
            end
        end
    end
    netTable.RetainPart = retainPartFunc
    env.Network = netTable

    local function enablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        local hbConn = RunService.Heartbeat:Connect(function()
            local succ, err = pcall(function()
                if sethiddenproperty then
                    sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                end
            end)
            local pList = env.Network.BaseParts
            for _, pt in pairs(pList) do
                local isD = pt:IsDescendantOf(Workspace)
                if isD then
                    local cVel = env.Network.Velocity
                    pt.Velocity = cVel
                end
            end
        end)
    end
    enablePartControl()
end

local BlackholeFolder = Instance.new("Folder")
BlackholeFolder.Parent = Workspace

local BlackholePart = Instance.new("Part")
BlackholePart.Parent = BlackholeFolder
BlackholePart.Anchored = true
BlackholePart.CanCollide = false
BlackholePart.Transparency = 1

local Attachment1 = Instance.new("Attachment")
Attachment1.Parent = BlackholePart

local function ForcePart(v)
    local isP = v:IsA("Part")
    if isP then
        local isAnc = v.Anchored
        if not isAnc then
            local pnt = v.Parent
            local fHum = nil
            local fHd = nil
            if pnt then
                fHum = pnt:FindFirstChild("Humanoid")
                fHd = pnt:FindFirstChild("Head")
            end
            if not fHum then
                if not fHd then
                    local vNm = v.Name
                    if vNm ~= "Handle" then
                        local children = v:GetChildren()
                        for _, x in pairs(children) do
                            local isBAV = x:IsA("BodyAngularVelocity")
                            local isBF = x:IsA("BodyForce")
                            local isBG = x:IsA("BodyGyro")
                            local isBP = x:IsA("BodyPosition")
                            local isBT = x:IsA("BodyThrust")
                            local isBV = x:IsA("BodyVelocity")
                            local isRP = x:IsA("RocketPropulsion")
                            local del = false
                            if isBAV then
                                del = true
                            end
                            if isBF then
                                del = true
                            end
                            if isBG then
                                del = true
                            end
                            if isBP then
                                del = true
                            end
                            if isBT then
                                del = true
                            end
                            if isBV then
                                del = true
                            end
                            if isRP then
                                del = true
                            end
                            if del then
                                x:Destroy()
                            end
                        end
                        
                        local fAtt = v:FindFirstChild("Attachment")
                        if fAtt then
                            fAtt:Destroy()
                        end
                        local fAlgn = v:FindFirstChild("AlignPosition")
                        if fAlgn then
                            fAlgn:Destroy()
                        end
                        local fTq = v:FindFirstChild("Torque")
                        if fTq then
                            fTq:Destroy()
                        end
                        
                        v.CanCollide = false
                        
                        local tq = Instance.new("Torque")
                        tq.Parent = v
                        local tqV = Vector3.new(1000000, 1000000, 1000000)
                        tq.Torque = tqV
                        
                        local al = Instance.new("AlignPosition")
                        al.Parent = v
                        
                        local att2 = Instance.new("Attachment")
                        att2.Parent = v
                        
                        tq.Attachment0 = att2
                        local mHg = math.huge
                        al.MaxForce = mHg
                        al.MaxVelocity = mHg
                        al.Responsiveness = 500
                        al.Attachment0 = att2
                        al.Attachment1 = Attachment1
                    end
                end
            end
        end
    end
end

local bhAng = 1
local rsConnBH = RunService.RenderStepped:Connect(function()
    local isBhOn = State.Blackhole
    if isBhOn then
        local lpChar = LocalPlayer.Character
        if lpChar then
            local hrp = lpChar:FindFirstChild("HumanoidRootPart")
            if hrp then
                local wsDesc = Workspace:GetDescendants()
                for _, v in pairs(wsDesc) do
                    ForcePart(v)
                end
                
                local mRad = math.rad(2)
                bhAng = bhAng + mRad
                
                local rDist = State.BlackholeDistance
                local mCos = math.cos(bhAng)
                local offX = mCos * rDist
                
                local mSin = math.sin(bhAng)
                local offZ = mSin * rDist
                
                local hrpCF = hrp.CFrame
                local cfOff = CFrame.new(offX, 0, offZ)
                local finalCF = hrpCF * cfOff
                Attachment1.WorldCFrame = finalCF
            end
        end
    end
    if not isBhOn then
        local cfZero = CFrame.new(0, -1000, 0)
        Attachment1.WorldCFrame = cfZero
    end
end)

local function RetainPartRing(part)
    local isBP = part:IsA("BasePart")
    if isBP then
        local isAnc = part.Anchored
        if not isAnc then
            local isDescWS = part:IsDescendantOf(Workspace)
            if isDescWS then
                local lpChar = LocalPlayer.Character
                local isPntChar = false
                local isDescChar = false
                if lpChar then
                    local pnt = part.Parent
                    if pnt == lpChar then
                        isPntChar = true
                    end
                    local dChar = part:IsDescendantOf(lpChar)
                    if dChar then
                        isDescChar = true
                    end
                end
                if isPntChar then
                    return false
                end
                if isDescChar then
                    return false
                end
                local pp = PhysicalProperties.new(0, 0, 0, 0, 0)
                part.CustomPhysicalProperties = pp
                part.CanCollide = false
                return true
            end
        end
    end
    return false
end

local RingPartsList = {}

local function addPartToList(part)
    local canRet = RetainPartRing(part)
    if canRet then
        local isFound = false
        for _, v in pairs(RingPartsList) do
            if v == part then
                isFound = true
            end
        end
        if not isFound then
            table.insert(RingPartsList, part)
        end
    end
end

local function remPartFromList(part)
    local fIdx = nil
    for i, v in ipairs(RingPartsList) do
        if v == part then
            fIdx = i
        end
    end
    if fIdx then
        table.remove(RingPartsList, fIdx)
    end
end

local wsDescList = Workspace:GetDescendants()
for _, part in pairs(wsDescList) do
    addPartToList(part)
end

local connDA = Workspace.DescendantAdded:Connect(addPartToList)
local connDR = Workspace.DescendantRemoving:Connect(remPartFromList)

local rsConnRing = RunService.Heartbeat:Connect(function()
    local isRingOn = State.SuperRing
    if isRingOn then
        local lpChar = LocalPlayer.Character
        if lpChar then
            local hrp = lpChar:FindFirstChild("HumanoidRootPart")
            if hrp then
                local tCenter = hrp.Position
                for _, part in pairs(RingPartsList) do
                    local pnt = part.Parent
                    if pnt then
                        local isAnc = part.Anchored
                        if not isAnc then
                            local pos = part.Position
                            local vPosC = Vector3.new(pos.X, tCenter.Y, pos.Z)
                            local distSub = vPosC - tCenter
                            local distance = distSub.Magnitude
                            
                            local zSub = pos.Z - tCenter.Z
                            local xSub = pos.X - tCenter.X
                            local calcAng = math.atan2(zSub, xSub)
                            
                            local rotSpd = State.RingSpeed
                            local mRad = math.rad(rotSpd)
                            local nAng = calcAng + mRad
                            
                            local rDist = State.RingDistance
                            local minDist = math.min(rDist, distance)
                            
                            local mCos = math.cos(nAng)
                            local tx = tCenter.X + (mCos * minDist)
                            
                            local ySub = pos.Y - tCenter.Y
                            local rHei = State.RingHeight
                            local hDiv = ySub / rHei
                            local mSinH = math.sin(hDiv)
                            local mAbsH = math.abs(mSinH)
                            local ty = tCenter.Y + (rHei * mAbsH)
                            
                            local mSin = math.sin(nAng)
                            local tz = tCenter.Z + (mSin * minDist)
                            
                            local tarPos = Vector3.new(tx, ty, tz)
                            local tDirSub = tarPos - part.Position
                            local tDirUn = tDirSub.Unit
                            
                            local attrStr = State.RingAttraction
                            local fVel = tDirUn * attrStr
                            part.Velocity = fVel
                        end
                    end
                end
            end
        end
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XayzExV3X"
ScreenGui.ResetOnSpawn = false

local successGui = false
if CoreGui then
    local successCheck, errCheck = pcall(function()
        local targetGui = nil
        if gethui then
            local hGui = gethui()
            targetGui = hGui
        end
        if not gethui then
            targetGui = CoreGui
        end
        ScreenGui.Parent = targetGui
    end)
    successGui = successCheck
end

if not successGui then
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Parent = playerGui
end

local function MakeDraggable(frame)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local connBegan = frame.InputBegan:Connect(function(input)
        local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
        local isTouch = input.UserInputType == Enum.UserInputType.Touch
        local isValid = false
        if isMouse then
            isValid = true
        end
        if isTouch then
            isValid = true
        end
        
        if isValid then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    local connEnded = frame.InputEnded:Connect(function(input)
        local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
        local isTouch = input.UserInputType == Enum.UserInputType.Touch
        local isValid = false
        if isMouse then
            isValid = true
        end
        if isTouch then
            isValid = true
        end
        
        if isValid then
            dragging = false
        end
    end)

    local connChanged = frame.InputChanged:Connect(function(input)
        local isMouseM = input.UserInputType == Enum.UserInputType.MouseMovement
        local isTouchM = input.UserInputType == Enum.UserInputType.Touch
        local isValid = false
        if isMouseM then
            isValid = true
        end
        if isTouchM then
            isValid = true
        end
        
        if isValid then
            dragInput = input
        end
    end)

    local connUIS = UserInputService.InputChanged:Connect(function(input)
        if input == dragInput then
            if dragging then
                local delta = input.Position - dragStart
                local newX = startPos.X.Offset + delta.X
                local newY = startPos.Y.Offset + delta.Y
                local newUDim = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                frame.Position = newUDim
            end
        end
    end)
end

local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Parent = ScreenGui
NotifContainer.BackgroundTransparency = 1
local ncPos = UDim2.new(1, -260, 1, -20)
NotifContainer.Position = ncPos
local ncSize = UDim2.new(0, 250, 0, 0)
NotifContainer.Size = ncSize
local ncAnchor = Vector2.new(0, 1)
NotifContainer.AnchorPoint = ncAnchor

local NotifList = Instance.new("UIListLayout")
NotifList.Parent = NotifContainer
NotifList.SortOrder = Enum.SortOrder.LayoutOrder
NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
local nlPad = UDim.new(0, 10)
NotifList.Padding = nlPad

local function XayzNotify(title, text, duration)
    local notifDuration = 3
    if duration then
        notifDuration = duration
    end
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Parent = NotifContainer
    local nfCol = Color3.fromRGB(15, 17, 26)
    NotifFrame.BackgroundColor3 = nfCol
    local nfSize = UDim2.new(1, 0, 0, 65)
    NotifFrame.Size = nfSize
    
    if State.PerformanceMode then
        NotifFrame.BackgroundTransparency = 0
    end
    if not State.PerformanceMode then
        NotifFrame.BackgroundTransparency = 1
    end
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = State.MainColor
    NotifStroke.Thickness = 1
    NotifStroke.Parent = NotifFrame

    local NotifCorner = Instance.new("UICorner")
    local ncRad = UDim.new(0, 8)
    NotifCorner.CornerRadius = ncRad
    NotifCorner.Parent = NotifFrame
    
    local Accent = Instance.new("Frame")
    Accent.Parent = NotifFrame
    Accent.BackgroundColor3 = State.MainColor
    local accSize = UDim2.new(0, 4, 1, 0)
    Accent.Size = accSize
    
    local AccentCorner = Instance.new("UICorner")
    local accRad = UDim.new(0, 8)
    AccentCorner.CornerRadius = accRad
    AccentCorner.Parent = Accent
    
    local Tbl = Instance.new("TextLabel")
    Tbl.Parent = NotifFrame
    Tbl.BackgroundTransparency = 1
    local tblPos = UDim2.new(0, 15, 0, 5)
    Tbl.Position = tblPos
    local tblSize = UDim2.new(1, -20, 0, 20)
    Tbl.Size = tblSize
    Tbl.Font = Enum.Font.GothamBold
    Tbl.Text = title
    local tblCol = Color3.fromRGB(255, 255, 255)
    Tbl.TextColor3 = tblCol
    Tbl.TextSize = 14
    Tbl.TextXAlignment = Enum.TextXAlignment.Left
    
    if State.PerformanceMode then
        Tbl.TextTransparency = 0
    end
    if not State.PerformanceMode then
        Tbl.TextTransparency = 1
    end
    
    local Dbl = Instance.new("TextLabel")
    Dbl.Parent = NotifFrame
    Dbl.BackgroundTransparency = 1
    local dblPos = UDim2.new(0, 15, 0, 25)
    Dbl.Position = dblPos
    local dblSize = UDim2.new(1, -20, 0, 30)
    Dbl.Size = dblSize
    Dbl.Font = Enum.Font.Gotham
    Dbl.Text = text
    local dblCol = Color3.fromRGB(180, 180, 180)
    Dbl.TextColor3 = dblCol
    Dbl.TextSize = 12
    Dbl.TextWrapped = true
    Dbl.TextXAlignment = Enum.TextXAlignment.Left
    
    if State.PerformanceMode then
        Dbl.TextTransparency = 0
    end
    if not State.PerformanceMode then
        Dbl.TextTransparency = 1
    end
    
    local ProgBg = Instance.new("Frame")
    ProgBg.Parent = NotifFrame
    local pbgCol = Color3.fromRGB(30, 32, 45)
    ProgBg.BackgroundColor3 = pbgCol
    local pbgPos = UDim2.new(0, 15, 1, -5)
    ProgBg.Position = pbgPos
    local pbgSize = UDim2.new(1, -25, 0, 3)
    ProgBg.Size = pbgSize
    
    if State.PerformanceMode then
        ProgBg.BackgroundTransparency = 0
    end
    if not State.PerformanceMode then
        ProgBg.BackgroundTransparency = 1
    end
    
    local ProgBgCorner = Instance.new("UICorner")
    local pbgRad = UDim.new(1, 0)
    ProgBgCorner.CornerRadius = pbgRad
    ProgBgCorner.Parent = ProgBg
    
    local ProgFill = Instance.new("Frame")
    ProgFill.Parent = ProgBg
    ProgFill.BackgroundColor3 = State.MainColor
    local pflSize = UDim2.new(1, 0, 1, 0)
    ProgFill.Size = pflSize
    
    if State.PerformanceMode then
        ProgFill.BackgroundTransparency = 0
    end
    if not State.PerformanceMode then
        ProgFill.BackgroundTransparency = 1
    end
    
    local ProgFillCorner = Instance.new("UICorner")
    local pflRad = UDim.new(1, 0)
    ProgFillCorner.CornerRadius = pflRad
    ProgFillCorner.Parent = ProgFill
    
    if not State.PerformanceMode then
        local tInfoIn = TweenInfo.new(0.3)
        local tPropIn1 = {}
        tPropIn1.BackgroundTransparency = 0
        local tw1 = TweenService:Create(NotifFrame, tInfoIn, tPropIn1)
        tw1:Play()
        
        local tPropIn2 = {}
        tPropIn2.TextTransparency = 0
        local tw2 = TweenService:Create(Tbl, tInfoIn, tPropIn2)
        tw2:Play()
        local tw3 = TweenService:Create(Dbl, tInfoIn, tPropIn2)
        tw3:Play()
        
        local tPropIn3 = {}
        tPropIn3.BackgroundTransparency = 0
        local tw4 = TweenService:Create(ProgBg, tInfoIn, tPropIn3)
        tw4:Play()
        local tw5 = TweenService:Create(ProgFill, tInfoIn, tPropIn3)
        tw5:Play()
        
        local progTweenInfo = TweenInfo.new(notifDuration, Enum.EasingStyle.Linear)
        local progTweenProp = {}
        progTweenProp.Size = UDim2.new(0, 0, 1, 0)
        local progTween = TweenService:Create(ProgFill, progTweenInfo, progTweenProp)
        progTween:Play()
        
        local twConn = progTween.Completed:Connect(function()
            local tInfoOut = TweenInfo.new(0.3)
            local tPropOut1 = {}
            tPropOut1.BackgroundTransparency = 1
            local twOut1 = TweenService:Create(NotifFrame, tInfoOut, tPropOut1)
            twOut1:Play()
            
            local tPropOut2 = {}
            tPropOut2.TextTransparency = 1
            local twOut2 = TweenService:Create(Tbl, tInfoOut, tPropOut2)
            twOut2:Play()
            local twOut3 = TweenService:Create(Dbl, tInfoOut, tPropOut2)
            twOut3:Play()
            
            local tPropOut3 = {}
            tPropOut3.BackgroundTransparency = 1
            local twOut4 = TweenService:Create(ProgBg, tInfoOut, tPropOut3)
            twOut4:Play()
            local twOut5 = TweenService:Create(ProgFill, tInfoOut, tPropOut3)
            twOut5:Play()
            
            task.wait(0.3)
            NotifFrame:Destroy()
        end)
    end
    
    if State.PerformanceMode then
        local spwnNotif = task.spawn(function()
            task.wait(notifDuration)
            NotifFrame:Destroy()
        end)
    end
end

local MainWrapper = Instance.new("Frame")
MainWrapper.Parent = ScreenGui
local mwCol = Color3.fromRGB(12, 14, 22)
MainWrapper.BackgroundColor3 = mwCol
local mwPos = UDim2.new(0.5, -250, 0.5, -175)
MainWrapper.Position = mwPos
local mwSize = UDim2.new(0, 500, 0, 350)
MainWrapper.Size = mwSize
MakeDraggable(MainWrapper)

local MainWrapperCorner = Instance.new("UICorner")
local mwcRad = UDim.new(0, 8)
MainWrapperCorner.CornerRadius = mwcRad
MainWrapperCorner.Parent = MainWrapper

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainWrapper
MainStroke.Color = State.MainColor
MainStroke.Thickness = 2

local RGBGradient = Instance.new("UIGradient")
RGBGradient.Parent = MainStroke
local csCol1 = ColorSequenceKeypoint.new(0.00, State.MainColor)
local colWh = Color3.fromRGB(255, 255, 255)
local csCol2 = ColorSequenceKeypoint.new(0.50, colWh)
local csCol3 = ColorSequenceKeypoint.new(1.00, State.MainColor)
local colSeq = ColorSequence.new({csCol1, csCol2, csCol3})
RGBGradient.Color = colSeq

local rsConn1 = RunService.RenderStepped:Connect(function()
    if not State.PerformanceMode then
        local currentRot = RGBGradient.Rotation
        local newRot = (currentRot + 2) % 360
        RGBGradient.Rotation = newRot
    end
    if State.RGBGaming then
        local currentTick = tick()
        local modTick = currentTick % 5
        local hue = modTick / 5
        local color = Color3.fromHSV(hue, 1, 1)
        State.MainColor = color
    end
    MainStroke.Color = State.MainColor
end)

local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = MainWrapper
local lfCol = Color3.fromRGB(12, 14, 22)
LoadFrame.BackgroundColor3 = lfCol
local lfSize = UDim2.new(1, 0, 1, 0)
LoadFrame.Size = lfSize
LoadFrame.ZIndex = 100

local LoadCorner = Instance.new("UICorner")
local lcRad = UDim.new(0, 8)
LoadCorner.CornerRadius = lcRad
LoadCorner.Parent = LoadFrame

local AuraText = Instance.new("TextLabel")
AuraText.Parent = LoadFrame
AuraText.BackgroundTransparency = 1
local atPos = UDim2.new(0, 0, 0.4, -20)
AuraText.Position = atPos
local atSize = UDim2.new(1, 0, 0, 40)
AuraText.Size = atSize
AuraText.Font = Enum.Font.GothamBlack
AuraText.Text = "X A Y Z   L I T E  X"
local atCol = Color3.fromRGB(255, 255, 255)
AuraText.TextColor3 = atCol
AuraText.TextSize = 28
AuraText.ZIndex = 101

local TextGradient = Instance.new("UIGradient")
TextGradient.Parent = AuraText
local tgs1Col = Color3.fromRGB(50, 50, 50)
local tgs1 = ColorSequenceKeypoint.new(0.0, tgs1Col)
local tgs2 = ColorSequenceKeypoint.new(0.5, State.MainColor)
local tgs3Col = Color3.fromRGB(50, 50, 50)
local tgs3 = ColorSequenceKeypoint.new(1.0, tgs3Col)
local tgcSeq = ColorSequence.new({tgs1, tgs2, tgs3})
TextGradient.Color = tgcSeq
local tgoVec = Vector2.new(-1, 0)
TextGradient.Offset = tgoVec

local Spinner = Instance.new("Frame")
Spinner.Parent = LoadFrame
Spinner.BackgroundTransparency = 1
local spPos = UDim2.new(0.5, -20, 0.6, 0)
Spinner.Position = spPos
local spSize = UDim2.new(0, 40, 0, 40)
Spinner.Size = spSize
Spinner.ZIndex = 101

local SpinnerCorner = Instance.new("UICorner")
local scRad = UDim.new(0.5, 0)
SpinnerCorner.CornerRadius = scRad
SpinnerCorner.Parent = Spinner

local SpinnerStroke = Instance.new("UIStroke")
SpinnerStroke.Parent = Spinner
SpinnerStroke.Thickness = 4
SpinnerStroke.Color = State.MainColor
SpinnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local SpinnerGradient = Instance.new("UIGradient")
SpinnerGradient.Parent = SpinnerStroke
local sq1 = NumberSequenceKeypoint.new(0.0, 0.0)
local sq2 = NumberSequenceKeypoint.new(0.5, 0.8)
local sq3 = NumberSequenceKeypoint.new(1.0, 1.0)
local snSeq = NumberSequence.new({sq1, sq2, sq3})
SpinnerGradient.Transparency = snSeq

local loadSpawn = task.spawn(function()
    local t = 0
    local loading = true
    
    local spinSpawn = task.spawn(function()
        while loading do
            t = t + 0.05
            local currentRot = Spinner.Rotation
            local nRot = currentRot + 10
            Spinner.Rotation = nRot
            
            local sinValue = math.sin(t)
            local offsetVec = Vector2.new(sinValue, 0)
            TextGradient.Offset = offsetVec
            
            SpinnerStroke.Color = State.MainColor
            
            local dynCol1 = Color3.fromRGB(50, 50, 50)
            local dynSq1 = ColorSequenceKeypoint.new(0.0, dynCol1)
            local dynSq2 = ColorSequenceKeypoint.new(0.5, State.MainColor)
            local dynCol3 = Color3.fromRGB(50, 50, 50)
            local dynSq3 = ColorSequenceKeypoint.new(1.0, dynCol3)
            local dynCSeq = ColorSequence.new({dynSq1, dynSq2, dynSq3})
            TextGradient.Color = dynCSeq
            task.wait(0.03)
        end
    end)
    
    task.wait(10)
    loading = false
    
    local fadeOutInfo = TweenInfo.new(0.5)
    
    local fadeOutProp1 = {}
    fadeOutProp1.TextTransparency = 1
    local tw1 = TweenService:Create(AuraText, fadeOutInfo, fadeOutProp1)
    tw1:Play()
    
    local fadeOutProp2 = {}
    fadeOutProp2.Transparency = 1
    local tw2 = TweenService:Create(SpinnerStroke, fadeOutInfo, fadeOutProp2)
    tw2:Play()
    
    task.wait(0.5)
    
    local fadeOutProp3 = {}
    fadeOutProp3.BackgroundTransparency = 1
    local tw3 = TweenService:Create(LoadFrame, fadeOutInfo, fadeOutProp3)
    tw3:Play()
    
    task.wait(0.5)
    LoadFrame.Visible = false
    
    XayzNotify("System Online", "Welcome to Xayz Panel LiteX", 4)
end)

local Header = Instance.new("Frame")
Header.Parent = MainWrapper
local hdrCol = Color3.fromRGB(18, 20, 30)
Header.BackgroundColor3 = hdrCol
local hdrSize = UDim2.new(1, 0, 0, 40)
Header.Size = hdrSize
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
local hdrRad = UDim.new(0, 8)
HeaderCorner.CornerRadius = hdrRad
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.BackgroundTransparency = 1
local tlPos = UDim2.new(0, 15, 0, 0)
TitleLabel.Position = tlPos
local tlSize = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Size = tlSize
TitleLabel.Font = Enum.Font.GothamBold
local tlCol = Color3.fromRGB(200, 220, 255)
TitleLabel.TextColor3 = tlCol
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "🖥️ Xayz Panel LiteX"

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
local minCol = Color3.fromRGB(35, 40, 55)
MinimizeBtn.BackgroundColor3 = minCol
local minPos = UDim2.new(1, -95, 0.5, -12)
MinimizeBtn.Position = minPos
local minSize = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Size = minSize
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
local minTxtCol = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextColor3 = minTxtCol

local MinCorner = Instance.new("UICorner")
local minCRad = UDim.new(0, 6)
MinCorner.CornerRadius = minCRad
MinCorner.Parent = MinimizeBtn

local MaximizeBtn = Instance.new("TextButton")
MaximizeBtn.Parent = Header
local maxCol = Color3.fromRGB(35, 40, 55)
MaximizeBtn.BackgroundColor3 = maxCol
local maxPos = UDim2.new(1, -65, 0.5, -12)
MaximizeBtn.Position = maxPos
local maxSize = UDim2.new(0, 24, 0, 24)
MaximizeBtn.Size = maxSize
MaximizeBtn.Font = Enum.Font.GothamBold
MaximizeBtn.Text = "□"
local maxTxtCol = Color3.fromRGB(255, 255, 255)
MaximizeBtn.TextColor3 = maxTxtCol

local MaxCorner = Instance.new("UICorner")
local maxCRad = UDim.new(0, 6)
MaxCorner.CornerRadius = maxCRad
MaxCorner.Parent = MaximizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
local clsCol = Color3.fromRGB(200, 50, 80)
CloseBtn.BackgroundColor3 = clsCol
local clsPos = UDim2.new(1, -35, 0.5, -12)
CloseBtn.Position = clsPos
local clsSize = UDim2.new(0, 24, 0, 24)
CloseBtn.Size = clsSize
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
local clsTxtCol = Color3.fromRGB(255, 255, 255)
CloseBtn.TextColor3 = clsTxtCol

local CloseCorner = Instance.new("UICorner")
local clsCRad = UDim.new(0, 6)
CloseCorner.CornerRadius = clsCRad
CloseCorner.Parent = CloseBtn

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Parent = MainWrapper
local sbCol = Color3.fromRGB(15, 17, 26)
Sidebar.BackgroundColor3 = sbCol
local sbPos = UDim2.new(0, 0, 0, 40)
Sidebar.Position = sbPos
local sbSize = UDim2.new(0, 140, 1, -40)
Sidebar.Size = sbSize
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y

local SidebarCorner = Instance.new("UICorner")
local sbCRad = UDim.new(0, 8)
SidebarCorner.CornerRadius = sbCRad
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainWrapper
ContentArea.BackgroundTransparency = 1
local caPos = UDim2.new(0, 150, 0, 50)
ContentArea.Position = caPos
local caSize = UDim2.new(1, -160, 1, -60)
ContentArea.Size = caSize

local minConn = MinimizeBtn.MouseButton1Click:Connect(function()
    if not State.PerformanceMode then
        local tInfo = TweenInfo.new(0.3)
        local tProp = {}
        local ds = UDim2.new(0, 500, 0, 40)
        tProp.Size = ds
        local twMin = TweenService:Create(MainWrapper, tInfo, tProp)
        twMin:Play()
    end
    if State.PerformanceMode then
        local minFixSize = UDim2.new(0, 500, 0, 40)
        MainWrapper.Size = minFixSize
    end
    Sidebar.Visible = false
    ContentArea.Visible = false
end)

local maxConn = MaximizeBtn.MouseButton1Click:Connect(function()
    if not State.PerformanceMode then
        local tInfo = TweenInfo.new(0.3)
        local tProp = {}
        local ds = UDim2.new(0, 500, 0, 350)
        tProp.Size = ds
        local twMax = TweenService:Create(MainWrapper, tInfo, tProp)
        twMax:Play()
        task.wait(0.3)
    end
    if State.PerformanceMode then
        local maxFixSize = UDim2.new(0, 500, 0, 350)
        MainWrapper.Size = maxFixSize
    end
    Sidebar.Visible = true
    ContentArea.Visible = true
end)

local clsConn = CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Pages = {}

local function SwitchPage(pageName)
    for name, page in pairs(Pages) do
        if name == pageName then
            page.Visible = true
        end
        if name ~= pageName then
            page.Visible = false
        end
    end
end

local function CreateTabBtn(text, pageName)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Sidebar
    Btn.BackgroundTransparency = 1
    local tbSize = UDim2.new(1, 0, 0, 35)
    Btn.Size = tbSize
    Btn.Font = Enum.Font.GothamBold
    local tbCol = Color3.fromRGB(120, 130, 150)
    Btn.TextColor3 = tbCol
    Btn.TextSize = 12
    Btn.Text = text

    local btnConn = Btn.MouseButton1Click:Connect(function()
        local sbChildren = Sidebar:GetChildren()
        for _, child in pairs(sbChildren) do
            local isTxtB = child:IsA("TextButton")
            if isTxtB then
                local resCol = Color3.fromRGB(120, 130, 150)
                child.TextColor3 = resCol
            end
        end
        Btn.TextColor3 = State.MainColor
        SwitchPage(pageName)
    end)
    
    local rsConnTab = RunService.RenderStepped:Connect(function()
        local selectedPage = Pages[pageName]
        if selectedPage then
            local isVis = selectedPage.Visible
            if isVis then
                Btn.TextColor3 = State.MainColor
            end
        end
    end)
    
    return Btn
end

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = ContentArea
    Page.BackgroundTransparency = 1
    local pgSize = UDim2.new(1, 0, 1, 0)
    Page.Size = pgSize
    Page.ScrollBarThickness = 2
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    
    Pages[name] = Page
    
    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Page
    local uiPad = UDim.new(0, 8)
    UIList.Padding = uiPad
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
local Tab1 = CreateTabBtn("COMBAT", "Combat")
Tab1.TextColor3 = State.MainColor
local Tab2 = CreateTabBtn("VISUAL", "Visual")
local Tab3 = CreateTabBtn("FLINGS", "Flings")
local Tab4 = CreateTabBtn("WORLD", "World")
local Tab5 = CreateTabBtn("ADMIN", "Admin")
local Tab6 = CreateTabBtn("VM", "VirtualMachine")
local Tab7 = CreateTabBtn("CUSTOM UI", "CustomUI")
local Tab8 = CreateTabBtn("SETTINGS", "Settings")

local function CreateDualSwitch(page, text, stateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    local fCol = Color3.fromRGB(20, 22, 30)
    Frame.BackgroundColor3 = fCol
    local fSize = UDim2.new(1, -5, 0, 45)
    Frame.Size = fSize
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Frame
    local fsCol = Color3.fromRGB(40, 45, 60)
    FStroke.Color = fsCol
    FStroke.Thickness = 1
    
    local FCorner = Instance.new("UICorner")
    local fcRad = UDim.new(0, 6)
    FCorner.CornerRadius = fcRad
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    local lblPos = UDim2.new(0, 5, 0, 0)
    Label.Position = lblPos
    local lblSize = UDim2.new(1, -10, 0, 20)
    Label.Size = lblSize
    Label.Font = Enum.Font.GothamSemibold
    local lblCol = Color3.fromRGB(220, 220, 220)
    Label.TextColor3 = lblCol
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Center
    Label.Text = text
    
    local OnBtn = Instance.new("TextButton")
    OnBtn.Parent = Frame
    local onBPos = UDim2.new(0.1, 0, 0, 20)
    OnBtn.Position = onBPos
    local onBSize = UDim2.new(0.35, 0, 0, 20)
    OnBtn.Size = onBSize
    
    if State[stateKey] then
        local onColT = Color3.fromRGB(50, 255, 100)
        OnBtn.BackgroundColor3 = onColT
        local onTxtT = Color3.fromRGB(0, 0, 0)
        OnBtn.TextColor3 = onTxtT
    end
    if not State[stateKey] then
        local onColF = Color3.fromRGB(40, 45, 60)
        OnBtn.BackgroundColor3 = onColF
        local onTxtF = Color3.fromRGB(200, 200, 200)
        OnBtn.TextColor3 = onTxtF
    end
    
    OnBtn.Text = "ON"
    OnBtn.Font = Enum.Font.GothamBold
    
    local OnCorner = Instance.new("UICorner")
    local onCRad = UDim.new(0, 4)
    OnCorner.CornerRadius = onCRad
    OnCorner.Parent = OnBtn

    local OffBtn = Instance.new("TextButton")
    OffBtn.Parent = Frame
    local offBPos = UDim2.new(0.55, 0, 0, 20)
    OffBtn.Position = offBPos
    local offBSize = UDim2.new(0.35, 0, 0, 20)
    OffBtn.Size = offBSize
    
    if State[stateKey] then
        local offColT = Color3.fromRGB(40, 45, 60)
        OffBtn.BackgroundColor3 = offColT
        local offTxtT = Color3.fromRGB(200, 200, 200)
        OffBtn.TextColor3 = offTxtT
    end
    if not State[stateKey] then
        local offColF = Color3.fromRGB(255, 50, 50)
        OffBtn.BackgroundColor3 = offColF
        local offTxtF = Color3.fromRGB(255, 255, 255)
        OffBtn.TextColor3 = offTxtF
    end
    
    OffBtn.Text = "OFF"
    OffBtn.Font = Enum.Font.GothamBold
    
    local OffCorner = Instance.new("UICorner")
    local offCRad = UDim.new(0, 4)
    OffCorner.CornerRadius = offCRad
    OffCorner.Parent = OffBtn

    local connOn = OnBtn.MouseButton1Click:Connect(function()
        State[stateKey] = true
        local grnCol = Color3.fromRGB(50, 255, 100)
        OnBtn.BackgroundColor3 = grnCol
        local blkCol = Color3.fromRGB(0, 0, 0)
        OnBtn.TextColor3 = blkCol
        
        local gryCol = Color3.fromRGB(40, 45, 60)
        OffBtn.BackgroundColor3 = gryCol
        local lGryCol = Color3.fromRGB(200, 200, 200)
        OffBtn.TextColor3 = lGryCol
        
        local msg = text .. " Enabled"
        XayzNotify("Setting", msg, 2)
        SaveConfig()
    end)
    
    local connOff = OffBtn.MouseButton1Click:Connect(function()
        State[stateKey] = false
        local redCol = Color3.fromRGB(255, 50, 50)
        OffBtn.BackgroundColor3 = redCol
        local whtCol = Color3.fromRGB(255, 255, 255)
        OffBtn.TextColor3 = whtCol
        
        local gryCol = Color3.fromRGB(40, 45, 60)
        OnBtn.BackgroundColor3 = gryCol
        local lGryCol = Color3.fromRGB(200, 200, 200)
        OnBtn.TextColor3 = lGryCol
        
        local msg = text .. " Disabled"
        XayzNotify("Setting", msg, 2)
        SaveConfig()
    end)
    
    return Frame
end

local function CreateDropdown(page, text)
    local Container = Instance.new("Frame")
    Container.Parent = page
    local cCol = Color3.fromRGB(20, 22, 30)
    Container.BackgroundColor3 = cCol
    local cSize = UDim2.new(1, -5, 0, 35)
    Container.Size = cSize
    Container.ClipsDescendants = true
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Container
    local fsCol = Color3.fromRGB(40, 45, 60)
    FStroke.Color = fsCol
    FStroke.Thickness = 1

    local ContCorner = Instance.new("UICorner")
    local ccRad = UDim.new(0, 6)
    ContCorner.CornerRadius = ccRad
    ContCorner.Parent = Container

    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.Parent = Container
    HeaderBtn.BackgroundTransparency = 1
    local hbPos = UDim2.new(0, 10, 0, 0)
    HeaderBtn.Position = hbPos
    local hbSize = UDim2.new(1, -10, 0, 35)
    HeaderBtn.Size = hbSize
    HeaderBtn.Font = Enum.Font.GothamBold
    HeaderBtn.TextColor3 = State.MainColor
    HeaderBtn.TextSize = 12
    HeaderBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    local combinedText = text .. " ▼"
    HeaderBtn.Text = combinedText

    local ItemsFrame = Instance.new("Frame")
    ItemsFrame.Parent = Container
    ItemsFrame.BackgroundTransparency = 1
    local itPos = UDim2.new(0, 0, 0, 35)
    ItemsFrame.Position = itPos
    local itSize = UDim2.new(1, 0, 0, 0)
    ItemsFrame.Size = itSize

    local Pad = Instance.new("UIPadding")
    Pad.Parent = ItemsFrame
    local pdL = UDim.new(0, 15)
    Pad.PaddingLeft = pdL
    local pdR = UDim.new(0, 5)
    Pad.PaddingRight = pdR

    local UIList = Instance.new("UIListLayout")
    UIList.Parent = ItemsFrame
    local uilPad = UDim.new(0, 5)
    UIList.Padding = uilPad
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    local isOpen = false
    local function updateSize()
        if isOpen then
            local headerTextOpen = text .. " ▲"
            HeaderBtn.Text = headerTextOpen
            
            local cY = UIList.AbsoluteContentSize.Y
            local calcHeight = cY + 10
            local iSize = UDim2.new(1, 0, 0, calcHeight)
            ItemsFrame.Size = iSize
            
            local totalHeight = 35 + calcHeight
            local cntSize = UDim2.new(1, -5, 0, totalHeight)
            Container.Size = cntSize
        end
        if not isOpen then
            local headerTextClose = text .. " ▼"
            HeaderBtn.Text = headerTextClose
            
            local iSize = UDim2.new(1, 0, 0, 0)
            ItemsFrame.Size = iSize
            
            local cntSize = UDim2.new(1, -5, 0, 35)
            Container.Size = cntSize
        end
    end

    local connHBtn = HeaderBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        updateSize()
    end)
    
    local connChg = UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        updateSize()
    end)
    
    local connRS = RunService.RenderStepped:Connect(function()
        HeaderBtn.TextColor3 = State.MainColor
    end)
    
    return ItemsFrame
end

local function CreateToggle(page, text, stateKey, parentStateKey)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    local fCol = Color3.fromRGB(20, 22, 30)
    Frame.BackgroundColor3 = fCol
    local fSize = UDim2.new(1, -5, 0, 35)
    Frame.Size = fSize
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Frame
    local fsCol = Color3.fromRGB(40, 45, 60)
    FStroke.Color = fsCol
    FStroke.Thickness = 1
    
    local FCorner = Instance.new("UICorner")
    local fcRad = UDim.new(0, 6)
    FCorner.CornerRadius = fcRad
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    local lblPos = UDim2.new(0, 10, 0, 0)
    Label.Position = lblPos
    local lblSize = UDim2.new(0.7, 0, 1, 0)
    Label.Size = lblSize
    Label.Font = Enum.Font.GothamSemibold
    local lblCol = Color3.fromRGB(220, 220, 220)
    Label.TextColor3 = lblCol
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    
    local Button = Instance.new("TextButton")
    Button.Parent = Frame
    local bPos = UDim2.new(1, -50, 0.5, -8)
    Button.Position = bPos
    local bSize = UDim2.new(0, 36, 0, 16)
    Button.Size = bSize
    local bCol = Color3.fromRGB(15, 17, 22)
    Button.BackgroundColor3 = bCol
    Button.Text = ""
    
    local BCorner = Instance.new("UICorner")
    local bcRad = UDim.new(1, 0)
    BCorner.CornerRadius = bcRad
    BCorner.Parent = Button
    
    local Status = Instance.new("Frame")
    Status.Parent = Button
    local stCol = Color3.fromRGB(100, 100, 120)
    Status.BackgroundColor3 = stCol
    local stPos = UDim2.new(0, 2, 0.5, -6)
    Status.Position = stPos
    local stSize = UDim2.new(0, 12, 0, 12)
    Status.Size = stSize
    
    local SCorner = Instance.new("UICorner")
    local scRad = UDim.new(1, 0)
    SCorner.CornerRadius = scRad
    SCorner.Parent = Status

    local function updateUI()
        if State[stateKey] then
            local posOn = UDim2.new(1, -14, 0.5, -6)
            Status.Position = posOn
            Status.BackgroundColor3 = State.MainColor
        end
        if not State[stateKey] then
            local posOff = UDim2.new(0, 2, 0.5, -6)
            Status.Position = posOff
            local cOff = Color3.fromRGB(100, 100, 120)
            Status.BackgroundColor3 = cOff
        end
    end

    local connRS = RunService.RenderStepped:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then
            local gCol = Color3.fromRGB(80, 80, 90)
            Label.TextColor3 = gCol
            Button.AutoButtonColor = false
        end
        if not isParentOff then
            local wCol = Color3.fromRGB(220, 220, 220)
            Label.TextColor3 = wCol
            Button.AutoButtonColor = true
        end
        
        if State[stateKey] then
            Status.BackgroundColor3 = State.MainColor
        end
    end)
    
    updateUI()

    local connBtn = Button.MouseButton1Click:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then 
            return 
        end
        
        local currSt = State[stateKey]
        local newSt = not currSt
        State[stateKey] = newSt
        
        if not State.PerformanceMode then
            local tInfo = TweenInfo.new(0.2)
            local tGoal = {}
            if State[stateKey] then
                local posOn = UDim2.new(1, -14, 0.5, -6)
                tGoal.Position = posOn
                tGoal.BackgroundColor3 = State.MainColor
            end
            if not State[stateKey] then
                local posOff = UDim2.new(0, 2, 0.5, -6)
                tGoal.Position = posOff
                local cOff = Color3.fromRGB(100, 100, 120)
                tGoal.BackgroundColor3 = cOff
            end
            local tw = TweenService:Create(Status, tInfo, tGoal)
            tw:Play()
        end
        
        if State.PerformanceMode then
            if State[stateKey] then
                local posOn = UDim2.new(1, -14, 0.5, -6)
                Status.Position = posOn
                Status.BackgroundColor3 = State.MainColor
            end
            if not State[stateKey] then
                local posOff = UDim2.new(0, 2, 0.5, -6)
                Status.Position = posOff
                local cOff = Color3.fromRGB(100, 100, 120)
                Status.BackgroundColor3 = cOff
            end
        end
        
        local onOffText = "Disabled"
        if State[stateKey] then
            onOffText = "Enabled"
        end
        XayzNotify(text, onOffText, 2)
        SaveConfig()
    end)
    
    return Frame
end

local function CreateButton(page, text, color, callback, parentStateKey)
    local Btn = Instance.new("TextButton")
    Btn.Parent = page
    Btn.BackgroundColor3 = color
    local bSize = UDim2.new(1, -5, 0, 35)
    Btn.Size = bSize
    Btn.Font = Enum.Font.GothamBold
    local tCol = Color3.fromRGB(255, 255, 255)
    Btn.TextColor3 = tCol
    Btn.TextSize = 12
    Btn.Text = text
    
    local BCorner = Instance.new("UICorner")
    local cRad = UDim.new(0, 6)
    BCorner.CornerRadius = cRad
    BCorner.Parent = Btn
    
    local connRS = RunService.RenderStepped:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then
            local bgCol = Color3.fromRGB(30, 31, 36)
            Btn.BackgroundColor3 = bgCol
            local txCol = Color3.fromRGB(80, 80, 90)
            Btn.TextColor3 = txCol
        end
        if not isParentOff then
            local stringColor = tostring(color)
            if stringColor == "Main" then
                Btn.BackgroundColor3 = State.MainColor
            end
            if stringColor ~= "Main" then
                Btn.BackgroundColor3 = color
            end
            local wCol = Color3.fromRGB(255, 255, 255)
            Btn.TextColor3 = wCol
        end
    end)

    local connBtn = Btn.MouseButton1Click:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then 
            return 
        end
        callback(Btn)
    end)
    
    return Btn
end

local function CreateInput(page, text, stateKey, parentStateKey)
    local Box = Instance.new("TextBox")
    Box.Parent = page
    local bCol = Color3.fromRGB(20, 21, 26)
    Box.BackgroundColor3 = bCol
    local bSize = UDim2.new(1, -5, 0, 35)
    Box.Size = bSize
    Box.Font = Enum.Font.Gotham
    Box.Text = ""
    Box.PlaceholderText = text
    local tCol = Color3.fromRGB(255, 255, 255)
    Box.TextColor3 = tCol
    Box.TextSize = 12
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Box
    local fsCol = Color3.fromRGB(40, 45, 60)
    FStroke.Color = fsCol
    FStroke.Thickness = 1
    
    local BCorner = Instance.new("UICorner")
    local cRad = UDim.new(0, 6)
    BCorner.CornerRadius = cRad
    BCorner.Parent = Box
    
    local connRS = RunService.RenderStepped:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then
            local gCol = Color3.fromRGB(80, 80, 90)
            Box.TextColor3 = gCol
            Box.TextEditable = false
        end
        if not isParentOff then
            local wCol = Color3.fromRGB(255, 255, 255)
            Box.TextColor3 = wCol
            Box.TextEditable = true
        end
    end)

    local connFoc = Box.FocusLost:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then 
            return 
        end
        
        local bxTxt = Box.Text
        local num = tonumber(bxTxt)
        if num then 
            State[stateKey] = num 
            SaveConfig()
        end
    end)
    return Box
end

local function CreateStepper(page, text, stateKey, parentStateKey, isFloat)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    local fCol = Color3.fromRGB(20, 21, 26)
    Frame.BackgroundColor3 = fCol
    local fSize = UDim2.new(1, -5, 0, 35)
    Frame.Size = fSize
    
    local FStroke = Instance.new("UIStroke")
    FStroke.Parent = Frame
    local fsCol = Color3.fromRGB(40, 45, 60)
    FStroke.Color = fsCol
    FStroke.Thickness = 1
    
    local FCorner = Instance.new("UICorner")
    local cRad = UDim.new(0, 6)
    FCorner.CornerRadius = cRad
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    local lblPos = UDim2.new(0, 10, 0, 0)
    Label.Position = lblPos
    local lblSize = UDim2.new(0.4, 0, 1, 0)
    Label.Size = lblSize
    Label.Font = Enum.Font.GothamSemibold
    local tCol = Color3.fromRGB(220, 220, 220)
    Label.TextColor3 = tCol
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    
    local MinusBtn = Instance.new("TextButton")
    MinusBtn.Parent = Frame
    local minPos = UDim2.new(1, -100, 0.5, -12)
    MinusBtn.Position = minPos
    local minSize = UDim2.new(0, 24, 0, 24)
    MinusBtn.Size = minSize
    local mbCol = Color3.fromRGB(35, 40, 55)
    MinusBtn.BackgroundColor3 = mbCol
    MinusBtn.Text = "-"
    local mbTCol = Color3.fromRGB(255, 255, 255)
    MinusBtn.TextColor3 = mbTCol
    
    local MCorner = Instance.new("UICorner")
    local mcRad = UDim.new(0, 4)
    MCorner.CornerRadius = mcRad
    MCorner.Parent = MinusBtn
    
    local ValueBox = Instance.new("TextBox")
    ValueBox.Parent = Frame
    local vbPos = UDim2.new(1, -70, 0.5, -12)
    ValueBox.Position = vbPos
    local vbSize = UDim2.new(0, 34, 0, 24)
    ValueBox.Size = vbSize
    local vbCol = Color3.fromRGB(12, 14, 20)
    ValueBox.BackgroundColor3 = vbCol
    
    local stVal = State[stateKey]
    local startValStr = tostring(stVal)
    ValueBox.Text = startValStr
    local vbTCol = Color3.fromRGB(255, 255, 255)
    ValueBox.TextColor3 = vbTCol
    
    local VCorner = Instance.new("UICorner")
    local vcRad = UDim.new(0, 4)
    VCorner.CornerRadius = vcRad
    VCorner.Parent = ValueBox
    
    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Parent = Frame
    local pbPos = UDim2.new(1, -30, 0.5, -12)
    PlusBtn.Position = pbPos
    local pbSize = UDim2.new(0, 24, 0, 24)
    PlusBtn.Size = pbSize
    local pbCol = Color3.fromRGB(35, 40, 55)
    PlusBtn.BackgroundColor3 = pbCol
    PlusBtn.Text = "+"
    local pbTCol = Color3.fromRGB(255, 255, 255)
    PlusBtn.TextColor3 = pbTCol
    
    local PCorner = Instance.new("UICorner")
    local pcRad = UDim.new(0, 4)
    PCorner.CornerRadius = pcRad
    PCorner.Parent = PlusBtn

    local connRS = RunService.RenderStepped:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        
        if isParentOff then
            local gCol = Color3.fromRGB(80, 80, 90)
            Label.TextColor3 = gCol
            ValueBox.TextColor3 = gCol
            ValueBox.TextEditable = false
            MinusBtn.AutoButtonColor = false
            PlusBtn.AutoButtonColor = false
        end
        if not isParentOff then
            local wCol1 = Color3.fromRGB(220, 220, 220)
            Label.TextColor3 = wCol1
            local wCol2 = Color3.fromRGB(255, 255, 255)
            ValueBox.TextColor3 = wCol2
            ValueBox.TextEditable = true
            MinusBtn.AutoButtonColor = true
            PlusBtn.AutoButtonColor = true
        end
    end)

    local stepVal = 1
    if isFloat then
        stepVal = 0.5
    end

    local function update(newVal)
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        if isParentOff then 
            return 
        end
        
        State[stateKey] = newVal
        local updatedStr = tostring(State[stateKey])
        ValueBox.Text = updatedStr
        SaveConfig()
    end
    
    local connMin = MinusBtn.MouseButton1Click:Connect(function() 
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        if isParentOff then 
            return 
        end
        
        local currentSt = State[stateKey]
        if currentSt > stepVal then 
            local minResult = currentSt - stepVal
            update(minResult) 
        end 
    end)
    
    local connPls = PlusBtn.MouseButton1Click:Connect(function() 
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        if isParentOff then 
            return 
        end
        
        local currentSt = State[stateKey]
        local plusResult = currentSt + stepVal
        update(plusResult) 
    end)
    
    local connFoc = ValueBox.FocusLost:Connect(function()
        local isParentOff = false
        if parentStateKey then
            if not State[parentStateKey] then
                isParentOff = true
            end
        end
        if isParentOff then 
            local resetStr = tostring(State[stateKey])
            ValueBox.Text = resetStr
            return 
        end
        
        local bxTxt = ValueBox.Text
        local num = tonumber(bxTxt)
        if num then 
            update(num) 
        end
        if not num then
            update(stepVal)
        end
    end)
    return Frame
end

local Toggle1 = CreateToggle(PageCombat, "Aimbot", "Aimbot", nil)
local DropAim = CreateDropdown(PageCombat, "Advanced Aimbot")
local Toggle2 = CreateToggle(DropAim, "Show FOV Circle", "Aim_ShowFOV", "Aimbot")
local Toggle3 = CreateToggle(DropAim, "Silent Aim", "SilentAim", "Aimbot")
local Stepper1 = CreateStepper(DropAim, "Set FOV Size", "Aim_FOVSize", "Aimbot", false)
local cOrng = Color3.fromRGB(200, 100, 0)
local Btn1 = CreateButton(DropAim, "Switch Target: HEAD/TORSO", cOrng, function(btn)
    local currTarget = State.Aim_Part
    if currTarget == "Head" then
        State.Aim_Part = "HumanoidRootPart"
    end
    if currTarget ~= "Head" then
        State.Aim_Part = "Head"
    end
    
    local upperTarget = string.upper(State.Aim_Part)
    local combinedTargetStr = "Target: " .. upperTarget
    btn.Text = combinedTargetStr
    SaveConfig()
end, "Aimbot")

local Toggle4 = CreateToggle(PageCombat, "Heal Loop", "HealLoop", nil)
local Toggle5 = CreateToggle(PageCombat, "God Mode", "GodModeV4", nil)
local Toggle6 = CreateToggle(PageCombat, "ForceField", "ForceField", nil)
local Toggle7 = CreateToggle(PageCombat, "Fly", "Fly", nil)
local Stepper2 = CreateStepper(PageCombat, "Fly Speed", "FlySpeed", "Fly", false)

local Toggle8 = CreateToggle(PageVisual, "Ultimate ESP", "ESP", nil)
local DropESP = CreateDropdown(PageVisual, "Advanced ESP")
local Toggle9 = CreateToggle(DropESP, "Show Box", "ESP_Box", "ESP")
local Toggle10 = CreateToggle(DropESP, "Show Name & Distance", "ESP_Name", "ESP")
local Toggle11 = CreateToggle(DropESP, "Show Healthbar", "ESP_Health", "ESP")
local Toggle12 = CreateToggle(DropESP, "Show Tracer", "ESP_Tracer", "ESP")
local Toggle13 = CreateToggle(DropESP, "Show Chams", "ESP_Chams", "ESP")
local Input1 = CreateInput(PageVisual, "Set POV Camera (1-120)", "POV", nil)

local Toggle14 = CreateToggle(PageFlings, "Fling", "FlingV2", nil)
local Toggle15 = CreateToggle(PageFlings, "Fling V2", "FlingV3", nil)
local Input2 = CreateInput(PageFlings, "Set Fling Power (Def: 50)", "FlingPower", nil)
local Toggle16 = CreateToggle(PageFlings, "Super Touch Fling", "SuperFling", nil)

local Btn2 = CreateButton(PageFlings, "Teleport to ALL Players", "Main", function()
    XayzNotify("Teleporting", "Transporting to all players...", 3)
    local playersTable = Players:GetPlayers()
    for _, p in ipairs(playersTable) do
        local lpTarget = LocalPlayer
        if p ~= lpTarget then
            local charTarget = p.Character
            if charTarget then
                local hrpTarget = charTarget:FindFirstChild("HumanoidRootPart")
                if hrpTarget then
                    local lpChar = LocalPlayer.Character
                    if lpChar then
                        local lpHRP = lpChar:FindFirstChild("HumanoidRootPart")
                        if lpHRP then
                            local cfTarget = hrpTarget.CFrame
                            lpHRP.CFrame = cfTarget
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
    end
end, nil)

local ColRedBtn = Color3.fromRGB(255, 50, 50)
local Btn3 = CreateButton(PageFlings, "Fling ALL Players", ColRedBtn, function()
    XayzNotify("Fling All", "Executing mass fling...", 3)
    local oldFling = State.SuperFling
    State.SuperFling = true
    
    local playersTable = Players:GetPlayers()
    for _, p in ipairs(playersTable) do
        local lpTarget = LocalPlayer
        if p ~= lpTarget then
            local charTarget = p.Character
            if charTarget then
                local hrpTarget = charTarget:FindFirstChild("HumanoidRootPart")
                if hrpTarget then
                    local lpChar = LocalPlayer.Character
                    if lpChar then
                        local lpHRP = lpChar:FindFirstChild("HumanoidRootPart")
                        if lpHRP then
                            local cfTarget = hrpTarget.CFrame
                            lpHRP.CFrame = cfTarget
                            task.wait(0.3)
                        end
                    end
                end
            end
        end
    end
    State.SuperFling = oldFling
end, nil)

local ColPurpBtn = Color3.fromRGB(150, 50, 255)
local Btn4 = CreateButton(PageFlings, "Dropkick", ColPurpBtn, function()
    XayzNotify("Executing", "Loading Dropkick script...", 2)
    local succDK, errDK = pcall(function() 
        local loadStr = loadstring
        if loadStr then
            local urlStr = "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua"
            local httpFunc = game:HttpGet(urlStr)
            local execFunc = loadStr(httpFunc)
            execFunc()
        end
    end)
end, nil)

local Toggle17 = CreateToggle(PageFlings, "Dino Animation", "DinoAnim", nil)
local Toggle18 = CreateToggle(PageFlings, "Punch Animation", "PunchAnim", nil)

local Toggle19 = CreateToggle(PageFlings, "Arm Mover", "ArmAnim", nil)
local DropArm = CreateDropdown(PageFlings, "Advanced Arm Mover")
local Stepper3 = CreateStepper(DropArm, "Arm Speed", "ArmSpeed", "ArmAnim", false)
local Stepper4 = CreateStepper(DropArm, "Arm Intensity", "ArmIntensity", "ArmAnim", true)

local ColPrpObl = Color3.fromRGB(138, 43, 226)
local Btn5 = CreateButton(PageWorld, "Get Obliterator Tool", ColPrpObl, function()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local tool1 = Instance.new("Tool")
    tool1.Name = "OBLITERATOR"
    tool1.RequiresHandle = true
    
    local handle1 = Instance.new("Part")
    handle1.Name = "Handle"
    local hSize = Vector3.new(1, 1, 1)
    handle1.Size = hSize
    local hCol = Color3.fromRGB(138, 43, 226)
    handle1.Color = hCol
    handle1.Parent = tool1

    local connAct = tool1.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        if target then
            local isBasePart = target:IsA("BasePart")
            if isBasePart then
                local lpChar = LocalPlayer.Character
                local isDescendant = target:IsDescendantOf(lpChar)
                if not isDescendant then
                    target.CanCollide = false
                    target.Transparency = 1
                    target:BreakJoints()
                    local vecOffset = Vector3.new(0, -1000, 0)
                    target.Position = vecOffset
                end
            end
        end
    end)
    tool1.Parent = backpack
    XayzNotify("Obliterator", "Tool added to Backpack!", 2)
end, nil)

local ColBluR6 = Color3.fromRGB(0, 150, 200)
local Btn6 = CreateButton(PageWorld, "Switch to R6", ColBluR6, function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local rigType = hum.RigType
            if rigType == Enum.HumanoidRigType.R15 then
                local userId = LocalPlayer.UserId
                local desc = Players:GetHumanoidDescriptionFromUserId(userId)
                local r6Rig = Enum.HumanoidRigType.R6
                local model = Players:CreateHumanoidModelFromDescription(desc, r6Rig)
                
                local currentPivot = char:GetPivot()
                model:PivotTo(currentPivot)
                model.Name = LocalPlayer.Name
                LocalPlayer.Character = model
                model.Parent = Workspace
            end
        end
    end
end, nil)

local ColGrnR15 = Color3.fromRGB(0, 200, 150)
local Btn7 = CreateButton(PageWorld, "Switch to R15", ColGrnR15, function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local rigType = hum.RigType
            if rigType == Enum.HumanoidRigType.R6 then
                local userId = LocalPlayer.UserId
                local desc = Players:GetHumanoidDescriptionFromUserId(userId)
                local r15Rig = Enum.HumanoidRigType.R15
                local model = Players:CreateHumanoidModelFromDescription(desc, r15Rig)
                
                local currentPivot = char:GetPivot()
                model:PivotTo(currentPivot)
                model.Name = LocalPlayer.Name
                LocalPlayer.Character = model
                model.Parent = Workspace
            end
        end
    end
end, nil)

local Stepper5 = CreateStepper(PageWorld, "Wide Avatar", "WideAvatar", nil, true)

local Toggle20 = CreateToggle(PageWorld, "Super Rings", "SuperRing", nil)
local DropRing = CreateDropdown(PageWorld, "Advanced Rings")
local Stepper6 = CreateStepper(DropRing, "Ring Speed", "RingSpeed", "SuperRing", false)
local Stepper7 = CreateStepper(DropRing, "Ring Height", "RingHeight", "SuperRing", false)
local Stepper8 = CreateStepper(DropRing, "Ring Distance", "RingDistance", "SuperRing", false)
local Stepper9 = CreateStepper(DropRing, "Attraction Power", "RingAttraction", "SuperRing", false)

local Toggle21 = CreateToggle(PageWorld, "Blackhole", "Blackhole", nil)
local DropBH = CreateDropdown(PageWorld, "Advanced Blackhole")
local Stepper10 = CreateStepper(DropBH, "Blackhole Distance", "BlackholeDistance", "Blackhole", false)

local Btn8 = CreateButton(PageAdmin, "Get F3X Btools", "Main", function()
    local tbArgs = {}
    FireAllRemotes("btool", tbArgs)
    FireAllRemotes("f3x", tbArgs)
    
    local succF3, errF3 = pcall(function()
        local getEnv = getgenv
        local importFunc = nil
        if getEnv then
            local geExec = getEnv()
            importFunc = geExec.import
        end
        if not importFunc then
            importFunc = import
        end
        
        if importFunc then 
            local lpName = LocalPlayer.Name
            local execFunc = importFunc(12158566951)
            execFunc(lpName)
        end
    end)
    
    local succL, errL = pcall(function()
        local objs = game:GetObjects("rbxassetid://22484922")
        local f3xObj = objs[1]
        local lpBackpack = LocalPlayer.Backpack
        f3xObj.Parent = lpBackpack
    end)
    XayzNotify("F3X Loaded", "Check your inventory.", 2)
end, nil)

local Btn9 = CreateButton(PageAdmin, "Get Btools", "Main", function()
    local tbArgs = {}
    FireAllRemotes("btool", tbArgs)
    
    local succB, errB = pcall(function()
        local getEnv = getgenv
        local importFunc = nil
        if getEnv then
            local geExec = getEnv()
            importFunc = geExec.import
        end
        if not importFunc then
            importFunc = import
        end
        
        if importFunc then 
            local lpName = LocalPlayer.Name
            local execFunc = importFunc(16530393933)
            execFunc(lpName)
        end
    end)
    
    local succC, errC = pcall(function()
        local cloneObj1 = Instance.new("HopperBin")
        cloneObj1.BinType = Enum.BinType.Clone
        local lpBP1 = LocalPlayer.Backpack
        cloneObj1.Parent = lpBP1
        
        local cloneObj2 = Instance.new("HopperBin")
        cloneObj2.BinType = Enum.BinType.Hammer
        local lpBP2 = LocalPlayer.Backpack
        cloneObj2.Parent = lpBP2
        
        local cloneObj3 = Instance.new("HopperBin")
        cloneObj3.BinType = Enum.BinType.Grab
        local lpBP3 = LocalPlayer.Backpack
        cloneObj3.Parent = lpBP3
    end)
    XayzNotify("Btools Loaded", "Check your inventory.", 2)
end, nil)

local function SetHDRank(rankId, rankName)
    local tbArgs = {"Rank", LocalPlayer, rankId}
    FireAllRemotes("hdadmin", tbArgs)
    
    local succHD, errHD = pcall(function()
        local hdGlobal = _G.HDAdminMain
        if hdGlobal then
            local modCF = hdGlobal:GetModule("cf")
            local crId = game.CreatorId
            modCF:SetRank(LocalPlayer, crId, rankId, "Perm")
        end
    end)
    
    local strCombine = "Rank set to " .. rankName
    XayzNotify("HD Admin", strCombine, 2)
end

local DropHD = CreateDropdown(PageAdmin, "HD Admin Roles")

local ColHD1 = Color3.fromRGB(50, 50, 50)
local Btn10 = CreateButton(DropHD, "Add HD Admin", ColHD1, function()
    local tbArgs = {}
    FireAllRemotes("hdadmin", tbArgs)
    
    local succA, errA = pcall(function()
        local getEnv = getgenv
        local importFunc = nil
        if getEnv then
            local gEx = getEnv()
            importFunc = gEx.import
        end
        if not importFunc then
            importFunc = import
        end
        
        if importFunc then 
            local execMod = importFunc(4893870373)
            local lpName = LocalPlayer.Name
            execMod.load(lpName)
        end
    end)
end, nil)

local ColHD2 = Color3.fromRGB(80, 80, 80)
local Btn11 = CreateButton(DropHD, "Rankless (0)", ColHD2, function() 
    SetHDRank(0, "Rankless") 
end, nil)

local ColHD3 = Color3.fromRGB(200, 200, 0)
local Btn12 = CreateButton(DropHD, "VIP (1)", ColHD3, function() 
    SetHDRank(1, "VIP") 
end, nil)

local ColHD4 = Color3.fromRGB(0, 200, 0)
local Btn13 = CreateButton(DropHD, "Mod (2)", ColHD4, function() 
    SetHDRank(2, "Mod") 
end, nil)

local ColHD5 = Color3.fromRGB(0, 100, 255)
local Btn14 = CreateButton(DropHD, "Admin (3)", ColHD5, function() 
    SetHDRank(3, "Admin") 
end, nil)

local ColHD6 = Color3.fromRGB(255, 100, 0)
local Btn15 = CreateButton(DropHD, "HeadAdmin (4)", ColHD6, function() 
    SetHDRank(4, "HeadAdmin") 
end, nil)

local ColHD7 = Color3.fromRGB(255, 0, 0)
local Btn16 = CreateButton(DropHD, "Owner (5)", ColHD7, function() 
    SetHDRank(5, "Owner") 
end, nil)

local ColHD8 = Color3.fromRGB(138, 43, 226)
local Btn17 = CreateButton(DropHD, "Above Owner", ColHD8, function() 
    local maxVal = math.huge
    SetHDRank(maxVal, "Above Owner") 
end, nil)

local Toggle22 = CreateToggle(PageAdmin, "Become HD Admin Owner", "HDAdmin", nil)

local VMWrapper = Instance.new("Frame")
VMWrapper.Parent = PageVM
local vwCol = Color3.fromRGB(20, 21, 26)
VMWrapper.BackgroundColor3 = vwCol
local vwSize = UDim2.new(1, -5, 0, 250)
VMWrapper.Size = vwSize
local VMWrapperCorner = Instance.new("UICorner")
local vwcRad = UDim.new(0, 8)
VMWrapperCorner.CornerRadius = vwcRad
VMWrapperCorner.Parent = VMWrapper

local VMHeader = Instance.new("Frame")
VMHeader.Parent = VMWrapper
local vhCol = Color3.fromRGB(30, 31, 36)
VMHeader.BackgroundColor3 = vhCol
local vhSize = UDim2.new(1, 0, 0, 30)
VMHeader.Size = vhSize
local VMHeaderCorner = Instance.new("UICorner")
local vhcRad = UDim.new(0, 8)
VMHeaderCorner.CornerRadius = vhcRad
VMHeaderCorner.Parent = VMHeader

local VMTitle = Instance.new("TextLabel")
VMTitle.Parent = VMHeader
VMTitle.BackgroundTransparency = 1
local vmtPos = UDim2.new(0, 10, 0, 0)
VMTitle.Position = vmtPos
local vmtSize = UDim2.new(1, -20, 1, 0)
VMTitle.Size = vmtSize
VMTitle.Font = Enum.Font.GothamBold
VMTitle.Text = "🌐 VM"
local vmtCol = Color3.fromRGB(200, 220, 255)
VMTitle.TextColor3 = vmtCol
VMTitle.TextSize = 12
VMTitle.TextXAlignment = Enum.TextXAlignment.Left

local VMContent = Instance.new("Frame")
VMContent.Parent = VMWrapper
local vcCol = Color3.fromRGB(255, 255, 255)
VMContent.BackgroundColor3 = vcCol
local vcPos = UDim2.new(0, 10, 0, 40)
VMContent.Position = vcPos
local vcSize = UDim2.new(1, -20, 1, -50)
VMContent.Size = vcSize
local VMContentCorner = Instance.new("UICorner")
local vccRad = UDim.new(0, 4)
VMContentCorner.CornerRadius = vccRad
VMContentCorner.Parent = VMContent

local VMBrowserMock = Instance.new("TextLabel")
VMBrowserMock.Parent = VMContent
VMBrowserMock.BackgroundTransparency = 1
local vbmSize = UDim2.new(1, 0, 1, 0)
VMBrowserMock.Size = vbmSize
VMBrowserMock.Font = Enum.Font.Gotham
VMBrowserMock.Text = "Virtual Machine is OFF"
local vbmCol = Color3.fromRGB(100, 100, 100)
VMBrowserMock.TextColor3 = vbmCol
VMBrowserMock.TextSize = 12
VMBrowserMock.TextWrapped = true

local DropUserAgent = CreateDropdown(PageVM, "Change User Agent")

local ColVM = Color3.fromRGB(50, 50, 50)
local Btn18 = CreateButton(DropUserAgent, "Windows", ColVM, function() 
    State.VM_UserAgent = "Windows" 
    SaveConfig()
end, nil)

local Btn19 = CreateButton(DropUserAgent, "Android", ColVM, function() 
    State.VM_UserAgent = "Android" 
    SaveConfig()
end, nil)

local Btn20 = CreateButton(DropUserAgent, "Linux", ColVM, function() 
    State.VM_UserAgent = "Linux" 
    SaveConfig()
end, nil)

local Dual1 = CreateDualSwitch(PageVM, "Power ON/OFF", "VM_Power")

local connVM = RunService.RenderStepped:Connect(function()
    if State.VM_Power then
        local vcColOn = Color3.fromRGB(240, 240, 240)
        VMContent.BackgroundColor3 = vcColOn
        local currAgent = State.VM_UserAgent
        local combineStr = "Connected via " .. currAgent .. " User-Agent."
        VMBrowserMock.Text = combineStr
        local vbmColOn = Color3.fromRGB(0, 0, 0)
        VMBrowserMock.TextColor3 = vbmColOn
    end
    if not State.VM_Power then
        local vcColOff = Color3.fromRGB(30, 30, 30)
        VMContent.BackgroundColor3 = vcColOff
        VMBrowserMock.Text = "Virtual Machine is OFF"
        local vbmColOff = Color3.fromRGB(100, 100, 100)
        VMBrowserMock.TextColor3 = vbmColOff
    end
end)

local PreviewBox = Instance.new("Frame")
PreviewBox.Parent = PageCustomUI
local pbCol = Color3.fromRGB(20, 21, 26)
PreviewBox.BackgroundColor3 = pbCol
local pbSize = UDim2.new(1, -5, 0, 60)
PreviewBox.Size = pbSize
local PreviewBoxCorner = Instance.new("UICorner")
local pbcRad = UDim.new(0, 8)
PreviewBoxCorner.CornerRadius = pbcRad
PreviewBoxCorner.Parent = PreviewBox

local PreviewStroke = Instance.new("UIStroke")
PreviewStroke.Parent = PreviewBox
PreviewStroke.Color = State.MainColor
PreviewStroke.Thickness = 2

local PreviewText = Instance.new("TextLabel")
PreviewText.Parent = PreviewBox
PreviewText.BackgroundTransparency = 1
local ptSize = UDim2.new(1, 0, 1, 0)
PreviewText.Size = ptSize
PreviewText.Font = Enum.Font.GothamBold
PreviewText.Text = "PREVIEW COLOR"
PreviewText.TextColor3 = State.MainColor
PreviewText.TextSize = 14

local TmpColor = State.MainColor

local PaletteFrame = Instance.new("Frame")
PaletteFrame.Parent = PageCustomUI
PaletteFrame.BackgroundTransparency = 1
local pfSize = UDim2.new(1, -5, 0, 150)
PaletteFrame.Size = pfSize

local PaletteGrid = Instance.new("UIGridLayout")
PaletteGrid.Parent = PaletteFrame
local pgCell = UDim2.new(0, 30, 0, 30)
PaletteGrid.CellSize = pgCell
local pgPad = UDim2.new(0, 5, 0, 5)
PaletteGrid.CellPadding = pgPad
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

for _, col in ipairs(colorList) do
    local cBtn = Instance.new("TextButton")
    cBtn.Parent = PaletteFrame
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    local cCorner = Instance.new("UICorner")
    local cCRad = UDim.new(0, 4)
    cCorner.CornerRadius = cCRad
    cCorner.Parent = cBtn
    
    local cConn = cBtn.MouseButton1Click:Connect(function()
        TmpColor = col
        PreviewStroke.Color = TmpColor
        PreviewText.TextColor3 = TmpColor
    end)
end

local Dual2 = CreateDualSwitch(PageCustomUI, "RGB", "RGBGaming")

local Btn21 = CreateButton(PageCustomUI, "Test Notify Custom", "Main", function()
    local oldC = State.MainColor
    State.MainColor = TmpColor
    XayzNotify("Test Custom", "This is how it looks!", 3)
    State.MainColor = oldC
end, nil)

local ColGrnCust = Color3.fromRGB(50, 200, 100)
local Btn22 = CreateButton(PageCustomUI, "Apply Change", ColGrnCust, function()
    State.MainColor = TmpColor
    SaveConfig()
    XayzNotify("Theme Saved", "Colors applied successfully.", 3)
end, nil)

local ColRedCust = Color3.fromRGB(200, 50, 50)
local Btn23 = CreateButton(PageCustomUI, "Cancel", ColRedCust, function()
    local currStC = State.MainColor
    TmpColor = currStC
    PreviewStroke.Color = TmpColor
    PreviewText.TextColor3 = TmpColor
end, nil)

local Dual3 = CreateDualSwitch(PageSettings, "Performance Mode", "PerformanceMode")

local FlyLoop = nil
local FlyBV = nil
local FlyBG = nil
local tpwalking = false

RunService.RenderStepped:Connect(function()
    if State.Fly then
        if not tpwalking then
            local char = LocalPlayer.Character
            local hum = nil
            local root = nil
            local torso = nil
            
            if char then
                local hTemp = char:FindFirstChildWhichIsA("Humanoid")
                hum = hTemp
                local rTemp = char:FindFirstChild("HumanoidRootPart")
                root = rTemp
                local tTemp = char:FindFirstChild("Torso")
                if not tTemp then
                    tTemp = char:FindFirstChild("UpperTorso")
                end
                torso = tTemp
            end
            
            local hasAll = false
            if hum then
                if root then
                    if torso then
                        hasAll = true
                    end
                end
            end
            
            if hasAll then
                tpwalking = true
                if FlyBV then 
                    FlyBV:Destroy() 
                end
                if FlyBG then 
                    FlyBG:Destroy() 
                end
                
                local newBG = Instance.new("BodyGyro")
                FlyBG = newBG
                FlyBG.Parent = torso
                FlyBG.P = 9e4
                local torqVec = Vector3.new(9e9, 9e9, 9e9)
                FlyBG.MaxTorque = torqVec
                
                local newBV = Instance.new("BodyVelocity")
                FlyBV = newBV
                FlyBV.Parent = torso
                local maxFVec = Vector3.new(9e9, 9e9, 9e9)
                FlyBV.MaxForce = maxFVec
                
                hum.PlatformStand = true
                local animChar = char:FindFirstChild("Animate")
                if animChar then
                    animChar.Disabled = true
                end
                
                local animTracks = hum:GetPlayingAnimationTracks()
                for _, v in next, animTracks do
                    v:Stop()
                end
            end
        end
    end
    if not State.Fly then
        if tpwalking then
            tpwalking = false
            if FlyBV then 
                FlyBV:Destroy() 
            end
            if FlyBG then 
                FlyBG:Destroy() 
            end
            
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum then 
                    hum.PlatformStand = false 
                    local gUp = Enum.HumanoidStateType.GettingUp
                    hum:ChangeState(gUp) 
                end
                local animChar = char:FindFirstChild("Animate")
                if animChar then 
                    animChar.Disabled = false 
                end
            end
        end
    end

    if State.Fly then
        if tpwalking then
            if FlyBV then
                if FlyBG then
                    local char = LocalPlayer.Character
                    local hum = nil
                    if char then
                        local hTemp = char:FindFirstChild("Humanoid")
                        hum = hTemp
                    end
                    
                    if hum then
                        local camCF = Camera.CFrame
                        FlyBG.CFrame = camCF
                        local moveDir = hum.MoveDirection
                        
                        local mDirMag = moveDir.Magnitude
                        if mDirMag > 0 then
                            local cLookX = Camera.CFrame.LookVector.X
                            local cLookZ = Camera.CFrame.LookVector.Z
                            local camLookFlatVec = Vector3.new(cLookX, 0, cLookZ)
                            local camLookFlat = camLookFlatVec.Unit
                            
                            local cRightX = Camera.CFrame.RightVector.X
                            local cRightZ = Camera.CFrame.RightVector.Z
                            local camRightFlatVec = Vector3.new(cRightX, 0, cRightZ)
                            local camRightFlat = camRightFlatVec.Unit
                            
                            local fwdMove = moveDir:Dot(camLookFlat)
                            local rgtMove = moveDir:Dot(camRightFlat)
                            
                            local cLookVec = Camera.CFrame.LookVector
                            local fwdVec = cLookVec * fwdMove
                            local cRightVec2 = Camera.CFrame.RightVector
                            local rgtVec = cRightVec2 * rgtMove
                            local flyDir = fwdVec + rgtVec
                            
                            local flyDirMag = flyDir.Magnitude
                            if flyDirMag > 0 then 
                                flyDir = flyDir.Unit 
                            end
                            
                            local flSpd = State.FlySpeed * 50
                            local flVel = flyDir * flSpd
                            FlyBV.Velocity = flVel
                        end
                        if mDirMag <= 0 then
                            local zeroVel = Vector3.new(0, 0, 0)
                            FlyBV.Velocity = zeroVel
                        end
                    end
                end
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
    local drCircle = Drawing.new("Circle")
    FOVCircle = drCircle
    local colWh = Color3.fromRGB(255, 255, 255)
    FOVCircle.Color = colWh
    FOVCircle.Thickness = 1.5
    FOVCircle.Filled = false
    FOVCircle.Transparency = 1
end

local function GetClosestPlayer()
    local target = nil
    local shortDist = State.Aim_FOVSize
    local camVX = Camera.ViewportSize.X / 2
    local camVY = Camera.ViewportSize.Y / 2
    local centerScreen = Vector2.new(camVX, camVY)
    
    local pTable = Players:GetPlayers()
    for _, p in pairs(pTable) do
        local isValidTarget = false
        if p ~= LocalPlayer then
            if p.Character then
                local pHum = p.Character:FindFirstChild("Humanoid")
                local aimPt = State.Aim_Part
                local pPart = p.Character:FindFirstChild(aimPt)
                if pHum then
                    if pHum.Health > 0 then
                        if pPart then
                            isValidTarget = true
                        end
                    end
                end
            end
        end
        
        if isValidTarget then
            local aimPt = State.Aim_Part
            local partPos = p.Character[aimPt].Position
            local v, onS = Camera:WorldToViewportPoint(partPos)
            if onS then
                local vVec = Vector2.new(v.X, v.Y)
                local vecDist = vVec - centerScreen
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
local getNmCall = nil
pcall(function()
    getNmCall = getnamecallmethod
end)
local hkMeta = nil
pcall(function()
    hkMeta = hookmetamethod
end)

if getNmCall then
    if hkMeta then
        OldNamecall = hkMeta(game, "__namecall", function(self, ...)
            local method = getNmCall()
            local args = {...}
            
            local isStateAim = State.Aimbot
            local isStateSlnt = State.SilentAim
            local isChCaller = checkcaller()
            
            local isOk = false
            if isStateAim then
                if isStateSlnt then
                    if not isChCaller then
                        isOk = true
                    end
                end
            end
            
            if isOk then
                local isFind = false
                if method == "FindPartOnRayWithIgnoreList" then
                    isFind = true
                end
                if method == "Raycast" then
                    isFind = true
                end
                
                if isFind then
                    local closest = GetClosestPlayer()
                    if closest then
                        if closest.Character then
                            local aimPt = State.Aim_Part
                            local cPart = closest.Character:FindFirstChild(aimPt)
                            if cPart then
                                local targetPos = closest.Character[aimPt].Position
                                
                                if method == "Raycast" then
                                    local origin = args[1]
                                    local tarSub = targetPos - origin
                                    local tarUnit = tarSub.Unit
                                    local dirVec = tarUnit * 1000
                                    args[2] = dirVec
                                    return OldNamecall(self, unpack(args))
                                end
                                if method == "FindPartOnRayWithIgnoreList" then
                                    local origin = args[1].Origin
                                    local tarSub = targetPos - origin
                                    local tarUnit = tarSub.Unit
                                    local dirVec = tarUnit * 1000
                                    local newRay = Ray.new(origin, dirVec)
                                    args[1] = newRay
                                    return OldNamecall(self, unpack(args))
                                end
                            end
                        end
                    end
                end
            end
            return OldNamecall(self, ...)
        end)
    end
end

local function CreateESP(player)
    local esp = {}
    local hl = Instance.new("Highlight")
    esp.Highlight = hl
    local colRedES = Color3.fromRGB(255, 50, 50)
    esp.Highlight.FillColor = colRedES
    local colWhES = Color3.fromRGB(255, 255, 255)
    esp.Highlight.OutlineColor = colWhES
    esp.Highlight.FillTransparency = 0.5
    esp.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    if HasDrawing then
        local tr = Drawing.new("Line")
        esp.Tracer = tr
        esp.Tracer.Thickness = 1.5
        local trCol = Color3.fromRGB(255, 255, 255)
        esp.Tracer.Color = trCol
        
        local bx = Drawing.new("Square")
        esp.Box = bx
        esp.Box.Thickness = 1.5
        local bxCol = Color3.fromRGB(255, 50, 50)
        esp.Box.Color = bxCol
        esp.Box.Filled = false
        
        local hbg = Drawing.new("Line")
        esp.HealthBg = hbg
        esp.HealthBg.Thickness = 3
        local hbgCol = Color3.fromRGB(0, 0, 0)
        esp.HealthBg.Color = hbgCol
        
        local hfl = Drawing.new("Line")
        esp.HealthFill = hfl
        esp.HealthFill.Thickness = 1.5
        local hflCol = Color3.fromRGB(0, 255, 100)
        esp.HealthFill.Color = hflCol
        
        local txtD = Drawing.new("Text")
        esp.Text = txtD
        esp.Text.Size = 14
        local txtCol = Color3.fromRGB(255, 255, 255)
        esp.Text.Color = txtCol
        esp.Text.Center = true
        esp.Text.Outline = true
    end
    ESP_Data[player] = esp
end

local function RemoveESP(player)
    local espP = ESP_Data[player]
    if espP then
        if espP.Highlight then 
            espP.Highlight:Destroy() 
        end
        if HasDrawing then
            espP.Tracer:Remove()
            espP.Box:Remove()
            espP.HealthBg:Remove()
            espP.HealthFill:Remove()
            espP.Text:Remove()
        end
        ESP_Data[player] = nil
    end
end
Players.PlayerRemoving:Connect(RemoveESP)

RunService.RenderStepped:Connect(function()
    if Camera then
        local cFov = Camera.FieldOfView
        local sPov = State.POV
        if cFov ~= sPov then 
            Camera.FieldOfView = sPov 
        end
    end

    local cx = 0
    local cy = 0
    if Camera then
        cx = Camera.ViewportSize.X / 2
        cy = Camera.ViewportSize.Y / 2
    end
    local centerScreen = Vector2.new(cx, cy)
    
    if FOVCircle then
        FOVCircle.Position = centerScreen
        FOVCircle.Radius = State.Aim_FOVSize
        local aimSt = State.Aimbot
        local fovSt = State.Aim_ShowFOV
        local combSt = false
        if aimSt then
            if fovSt then
                combSt = true
            end
        end
        
        if combSt then
            FOVCircle.Visible = true
        end
        if not combSt then
            FOVCircle.Visible = false
        end
    end
    
    local aimOn = State.Aimbot
    local sAimOn = State.SilentAim
    local canAim = false
    if aimOn then
        if not sAimOn then
            canAim = true
        end
    end
    
    if canAim then
        local target = GetClosestPlayer()
        if target then 
            local aimPt = State.Aim_Part
            local pPartPos = target.Character[aimPt].Position
            local camPos = Camera.CFrame.Position
            local newCF = CFrame.new(camPos, pPartPos)
            local lrpCF = Camera.CFrame:Lerp(newCF, 0.2)
            Camera.CFrame = lrpCF 
        end
    end

    if State.ESP then
        local pTable = Players:GetPlayers()
        for _, player in pairs(pTable) do
            if player ~= LocalPlayer then
                local char = player.Character
                local root = nil
                local head = nil
                local hum = nil
                
                if char then
                    local rt = char:FindFirstChild("HumanoidRootPart")
                    root = rt
                    local hd = char:FindFirstChild("Head")
                    head = hd
                    local hm = char:FindFirstChild("Humanoid")
                    hum = hm
                end
                
                local isOkC = false
                if char then
                    if root then
                        if head then
                            if hum then
                                if hum.Health > 0 then
                                    isOkC = true
                                end
                            end
                        end
                    end
                end
                
                if isOkC then
                    local espP = ESP_Data[player]
                    if not espP then 
                        CreateESP(player) 
                    end
                    local esp = ESP_Data[player]
                    
                    if State.ESP_Chams then
                        local hlP = esp.Highlight.Parent
                        if hlP ~= char then 
                            esp.Highlight.Parent = char 
                        end
                    end
                    if not State.ESP_Chams then
                        local hlP = esp.Highlight.Parent
                        if hlP then 
                            esp.Highlight.Parent = nil 
                        end
                    end
                    
                    if HasDrawing then
                        local rPos = root.Position
                        local rootPos, onScreen = Camera:WorldToViewportPoint(rPos)
                        local hdPosC = head.Position
                        local hdOffset = Vector3.new(0, 0.5, 0)
                        local headPosC = hdPosC + hdOffset
                        local headPos, _ = Camera:WorldToViewportPoint(headPosC)
                        local legPosC = rPos - Vector3.new(0, 3, 0)
                        local legPos, _ = Camera:WorldToViewportPoint(legPosC)
                        
                        if onScreen then
                            local hdY = headPos.Y
                            local lgY = legPos.Y
                            local ySub = hdY - lgY
                            local boxHeight = math.abs(ySub)
                            local boxWidth = boxHeight / 2
                            
                            local bVec = Vector2.new(boxWidth, boxHeight)
                            esp.Box.Size = bVec
                            local rtX = rootPos.X
                            local bW2 = boxWidth / 2
                            local xSub = rtX - bW2
                            local pVec = Vector2.new(xSub, hdY)
                            esp.Box.Position = pVec
                            local esBxSt = State.ESP_Box
                            esp.Box.Visible = esBxSt
                            
                            local trF = Vector2.new(cx, Camera.ViewportSize.Y)
                            esp.Tracer.From = trF
                            local trT = Vector2.new(rtX, lgY)
                            esp.Tracer.To = trT
                            local esTrSt = State.ESP_Tracer
                            esp.Tracer.Visible = esTrSt
                            
                            local hH = hum.Health
                            local mH = hum.MaxHealth
                            local hp = hH / mH
                            local hh = boxHeight * hp
                            
                            local hbgF = Vector2.new(esp.Box.Position.X - 5, lgY)
                            esp.HealthBg.From = hbgF
                            local hbgT = Vector2.new(esp.Box.Position.X - 5, hdY)
                            esp.HealthBg.To = hbgT
                            local esHlSt = State.ESP_Health
                            esp.HealthBg.Visible = esHlSt
                            
                            local hflF = Vector2.new(esp.Box.Position.X - 5, lgY)
                            esp.HealthFill.From = hflF
                            local lgSubHH = lgY - hh
                            local hflT = Vector2.new(esp.Box.Position.X - 5, lgSubHH)
                            esp.HealthFill.To = hflT
                            
                            local hpM = hp * 255
                            local rCol = 255 - hpM
                            local gCol = hpM
                            local finalCol = Color3.fromRGB(rCol, gCol, 0)
                            esp.HealthFill.Color = finalCol
                            esp.HealthFill.Visible = esHlSt
                            
                            local camP = Camera.CFrame.Position
                            local dSub = camP - rPos
                            local dMag = dSub.Magnitude
                            local distMath = math.floor(dMag)
                            local pName = player.DisplayName
                            local fTxt = pName .. " [" .. distMath .. "m]"
                            esp.Text.Text = fTxt
                            local hdY20 = hdY - 20
                            local tVec = Vector2.new(rtX, hdY20)
                            esp.Text.Position = tVec
                            local esNmSt = State.ESP_Name
                            esp.Text.Visible = esNmSt
                        end
                        if not onScreen then
                            esp.Box.Visible = false
                            esp.Tracer.Visible = false
                            esp.HealthBg.Visible = false
                            esp.HealthFill.Visible = false
                            esp.Text.Visible = false
                        end
                    end
                end
                
                local notOkC = false
                if not isOkC then
                    notOkC = true
                end
                
                if notOkC then
                    local espP = ESP_Data[player]
                    if espP then
                        if espP.Highlight then 
                            espP.Highlight.Parent = nil 
                        end
                        if HasDrawing then 
                            espP.Box.Visible = false
                            espP.Tracer.Visible = false
                            espP.HealthBg.Visible = false
                            espP.HealthFill.Visible = false
                            espP.Text.Visible = false 
                        end
                    end
                end
            end
        end
    end
    if not State.ESP then
        local espD = ESP_Data
        for player, _ in pairs(espD) do 
            RemoveESP(player) 
        end
    end
end)

local flingBav = nil
local flingV3Conn = nil

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = nil
    if char then
        local hTemp = char:FindFirstChild("HumanoidRootPart")
        hrp = hTemp
    end
    
    local f2On = State.FlingV2
    local sfOn = State.SuperFling
    local isFlingOn = false
    if f2On then
        isFlingOn = true
    end
    if sfOn then
        isFlingOn = true
    end
    
    if isFlingOn then
        if hrp then
            if not flingBav then
                local bNew = Instance.new("BodyAngularVelocity")
                flingBav = bNew
                flingBav.Name = "XayzFling"
                local mH = math.huge
                local tqVec = Vector3.new(0, mH, 0)
                flingBav.MaxTorque = tqVec
                flingBav.P = mH
                flingBav.Parent = hrp
            end
            
            if sfOn then
                local sfVec = Vector3.new(0, 999999, 0)
                flingBav.AngularVelocity = sfVec
            end
            if not sfOn then
                local fSpd = State.FlingPower * 100
                local fVec = Vector3.new(0, fSpd, 0)
                flingBav.AngularVelocity = fVec
            end
        end
    end
    if not isFlingOn then
        if flingBav then
            flingBav:Destroy()
            flingBav = nil
        end
        if hrp then
            local zVec = Vector3.new(0, 0, 0)
            hrp.RotVelocity = zVec
        end
    end

    if State.FlingV3 then
        if hrp then
            if not flingV3Conn then
                local charD = char:GetDescendants()
                for _, v in pairs(charD) do
                    local isBp = v:IsA("BasePart")
                    if isBp then
                        local ppNew = PhysicalProperties.new(100, 0, 0, 0, 0)
                        v.CustomPhysicalProperties = ppNew
                    end
                end
                local evtTouch = hrp.Touched
                flingV3Conn = evtTouch:Connect(function(hit)
                    local pnt = hit.Parent
                    if pnt then
                        local pHum = pnt:FindFirstChild("Humanoid")
                        local pName = pnt.Name
                        local lpName = LocalPlayer.Name
                        local notLp = false
                        if pName ~= lpName then
                            notLp = true
                        end
                        if pHum then
                            if notLp then
                                local vRoot = pnt:FindFirstChild("HumanoidRootPart")
                                if vRoot then
                                    local vVec = Vector3.new(999999999, 999999999, 999999999)
                                    vRoot.Velocity = vVec
                                end
                            end
                        end
                    end
                end)
            end
        end
    end
    if not State.FlingV3 then
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
                local mHl = hum.MaxHealth
                hum.Health = mHl
            end
            if State.GodModeV4 then
                local infH = math.huge
                hum.MaxHealth = infH
                hum.Health = infH
            end
            
            local wSc = hum:FindFirstChild("BodyWidthScale")
            local dSc = hum:FindFirstChild("BodyDepthScale")
            local wAv = State.WideAvatar
            
            local isScValid = false
            if wSc then
                if dSc then
                    isScValid = true
                end
            end
            
            if isScValid then
                wSc.Value = wAv
                dSc.Value = wAv
            end
        end
    end
end)

local bhAngle = 1
local AnchorPart = nil
local AnchorAtt = nil

local function GetAnchorSetup()
    local isVal = false
    if AnchorPart then
        if AnchorPart.Parent then
            isVal = true
        end
    end
    if not isVal then
        local fNew = Instance.new("Folder")
        fNew.Parent = Workspace
        local pNew = Instance.new("Part")
        AnchorPart = pNew
        AnchorPart.Name = "XayzAnchor"
        AnchorPart.Anchored = true
        AnchorPart.CanCollide = false
        AnchorPart.Transparency = 1
        AnchorPart.Parent = fNew
        
        local aNew = Instance.new("Attachment")
        AnchorAtt = aNew
        AnchorAtt.Parent = AnchorPart
    end
    return AnchorPart, AnchorAtt
end

local dinoAnimR15 = Instance.new("Animation")
dinoAnimR15.AnimationId = "rbxassetid://204062532"

local dinoAnimR6 = Instance.new("Animation")
dinoAnimR6.AnimationId = "rbxassetid://20432871"

local punchAnimation = Instance.new("Animation")
punchAnimation.AnimationId = "rbxassetid://84674780"

local dTrack = nil
local pTrack = nil
local hdFired = false

local function ForcePartBH(v, aAtt)
    local isP = v:IsA("Part")
    if isP then
        local isAnc = v.Anchored
        if not isAnc then
            local pnt = v.Parent
            local fHum = nil
            local fHd = nil
            if pnt then
                local hmm = pnt:FindFirstChild("Humanoid")
                fHum = hmm
                local hdd = pnt:FindFirstChild("Head")
                fHd = hdd
            end
            if not fHum then
                if not fHd then
                    local vNm = v.Name
                    if vNm ~= "Handle" then
                        local ch = v:GetChildren()
                        for _, x in pairs(ch) do
                            local b1 = x:IsA("BodyAngularVelocity")
                            local b2 = x:IsA("BodyForce")
                            local b3 = x:IsA("BodyGyro")
                            local b4 = x:IsA("BodyPosition")
                            local b5 = x:IsA("BodyThrust")
                            local b6 = x:IsA("BodyVelocity")
                            local b7 = x:IsA("RocketPropulsion")
                            local del = false
                            if b1 then
                                del = true
                            end
                            if b2 then
                                del = true
                            end
                            if b3 then
                                del = true
                            end
                            if b4 then
                                del = true
                            end
                            if b5 then
                                del = true
                            end
                            if b6 then
                                del = true
                            end
                            if b7 then
                                del = true
                            end
                            if del then
                                x:Destroy()
                            end
                        end
                        local fA = v:FindFirstChild("Attachment")
                        if fA then
                            fA:Destroy()
                        end
                        local fAl = v:FindFirstChild("AlignPosition")
                        if fAl then
                            fAl:Destroy()
                        end
                        local fT = v:FindFirstChild("Torque")
                        if fT then
                            fT:Destroy()
                        end
                        
                        v.CanCollide = false
                        v.Massless = true
                        
                        local tq = Instance.new("Torque")
                        tq.Parent = v
                        local tqV = Vector3.new(1000000, 1000000, 1000000)
                        tq.Torque = tqV
                        
                        local al = Instance.new("AlignPosition")
                        al.Parent = v
                        local a2 = Instance.new("Attachment")
                        a2.Parent = v
                        tq.Attachment0 = a2
                        
                        local mHg = math.huge
                        al.MaxForce = mHg
                        al.MaxVelocity = mHg
                        al.Responsiveness = 500
                        al.Attachment0 = a2
                        al.Attachment1 = aAtt
                    end
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then 
        return 
    end
    
    local armJoint = nil
    local uTorso = char:FindFirstChild("UpperTorso")
    local isR15 = false
    if uTorso then
        isR15 = true
    end
    
    if isR15 then
        local rArm = char:FindFirstChild("RightUpperArm")
        if rArm then 
            local rSho = rArm:FindFirstChild("RightShoulder")
            armJoint = rSho 
        end
    end
    if not isR15 then
        local torso = char:FindFirstChild("Torso")
        if torso then 
            local rSho = torso:FindFirstChild("Right Shoulder")
            armJoint = rSho 
        end
    end

    if armJoint then
        local attC0 = armJoint:GetAttribute("OriginalC0")
        if not attC0 then
            local currC0 = armJoint.C0
            armJoint:SetAttribute("OriginalC0", currC0)
            attC0 = currC0
        end

        if State.ArmAnim then
            local tcM = tick() * State.ArmSpeed
            local mSin = math.sin(tcM)
            local move = mSin * State.ArmIntensity
            
            if isR15 then
                local cfN = CFrame.new(0, move, -0.5)
                local mRad = math.rad(-90)
                local cfA = CFrame.Angles(mRad, 0, 0)
                local cfC = attC0 * cfN
                local cfF = cfC * cfA
                armJoint.C0 = cfF
            end
            if not isR15 then
                local cfN = CFrame.new(-0.2, move, -0.5)
                local mRad1 = math.rad(-90)
                local mRad2 = math.rad(20)
                local cfA = CFrame.Angles(mRad1, mRad2, 0)
                local cfC = attC0 * cfN
                local cfF = cfC * cfA
                armJoint.C0 = cfF
            end
        end
        if not State.ArmAnim then
            armJoint.C0 = attC0
        end
    end
    
    if State.HDAdmin then
        if not hdFired then
            local rsRep = game:GetService("ReplicatedStorage")
            local hdC = rsRep:FindFirstChild("HDAdminClient")
            if hdC then
                local succHD, errHD = pcall(function()
                    local psPl = LocalPlayer.PlayerScripts
                    local hdC2 = psPl:WaitForChild("HDAdminClient")
                    local mainW = hdC2:WaitForChild("Main")
                    local mainModule = require(mainW)
                    local stRank = mainModule.Settings
                    stRank.Rank = 5
                    stRank.RankName = "The King Xayz"
                    
                    local remote = rsRep:FindFirstChild("HDAdminRemote")
                    if remote then
                        local tbA = {"Rank", LocalPlayer, 5}
                        remote:FireServer(unpack(tbA)) 
                    end
                end)
            end
            hdFired = true
        end
    end
    if not State.HDAdmin then
        hdFired = false
    end
    
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        local isDPly = false
        if dTrack then
            if dTrack.IsPlaying then
                isDPly = true
            end
        end
        
        local dAnSt = State.DinoAnim
        if dAnSt then
            if not isDPly then
                local hRig = hum.RigType
                if hRig == Enum.HumanoidRigType.R15 then
                    local tL = hum:LoadAnimation(dinoAnimR15)
                    dTrack = tL
                end
                if hRig ~= Enum.HumanoidRigType.R15 then
                    local tL = hum:LoadAnimation(dinoAnimR6)
                    dTrack = tL
                end
                dTrack:Play()
            end
        end
        if not dAnSt then
            if isDPly then
                dTrack:Stop()
            end
        end

        local isPPly = false
        if pTrack then
            if pTrack.IsPlaying then
                isPPly = true
            end
        end
        
        local pAnSt = State.PunchAnim
        if pAnSt then
            if not isPPly then
                local tL = hum:LoadAnimation(punchAnimation)
                pTrack = tL
                pTrack:Play()
            end
        end
        if not pAnSt then
            if isPPly then
                pTrack:Stop()
            end
        end
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        return 
    end

    if State.ForceField then
        local xff = char:FindFirstChild("XayzFF")
        if not xff then
            local ffN = Instance.new("ForceField")
            ffN.Name = "XayzFF"
            ffN.Visible = true
            ffN.Parent = char
        end
    end
    if not State.ForceField then
        local xff = char:FindFirstChild("XayzFF")
        if xff then 
            xff:Destroy() 
        end
    end

    local ancPt, ancAtt = GetAnchorSetup()

    if State.Blackhole then
        local wsDesc = Workspace:GetDescendants()
        for _, v in pairs(wsDesc) do
            ForcePartBH(v, ancAtt)
        end
        
        local bhRad2 = math.rad(2)
        bhAngle = bhAngle + bhRad2
        
        local mCos = math.cos(bhAngle)
        local sDist = State.BlackholeDistance
        local offX = mCos * sDist
        
        local mSin = math.sin(bhAngle)
        local offZ = mSin * sDist
        
        local hrpCF = hrp.CFrame
        local offCF = CFrame.new(offX, 0, offZ)
        local wCF = hrpCF * offCF
        ancAtt.WorldCFrame = wCF

    end
    
    if State.SuperRing then
        local tCenter = hrp.Position
        local unParts = {}
        local wsDesc = Workspace:GetDescendants()
        for _, v in pairs(wsDesc) do
            local isBP = v:IsA("BasePart")
            if isBP then
                local isAnc = v.Anchored
                if not isAnc then
                    local pnt = v.Parent
                    local fHum = nil
                    if pnt then
                        fHum = pnt:FindFirstChild("Humanoid")
                    end
                    if not fHum then
                        local fHd = nil
                        if pnt then
                            fHd = pnt:FindFirstChild("Head")
                        end
                        if not fHd then
                            local vNm = v.Name
                            if vNm ~= "Handle" then
                                local isLp = false
                                local lpChar = LocalPlayer.Character
                                if pnt == lpChar then
                                    isLp = true
                                end
                                local isD = false
                                if lpChar then
                                    isD = v:IsDescendantOf(lpChar)
                                end
                                if isD then
                                    isLp = true
                                end
                                if not isLp then
                                    table.insert(unParts, v)
                                    
                                    local fAlgn = v:FindFirstChild("AlignPosition")
                                    if fAlgn then
                                        fAlgn:Destroy()
                                    end
                                    local fTq = v:FindFirstChild("Torque")
                                    if fTq then
                                        fTq:Destroy()
                                    end
                                    local atC = v:FindFirstChildOfClass("Attachment")
                                    if atC then
                                        local isAtAlg = atC:FindFirstChildOfClass("AlignPosition")
                                        if not isAtAlg then
                                            atC:Destroy()
                                        end
                                    end
                                    
                                    local pp = PhysicalProperties.new(0,0,0,0,0)
                                    v.CustomPhysicalProperties = pp
                                    v.CanCollide = false
                                    v.Massless = true
                                end
                            end
                        end
                    end
                end
            end
        end
        
        local tParts = #unParts
        for i, pt in pairs(unParts) do
            local ptPos = pt.Position
            local vXZ = Vector3.new(ptPos.X, tCenter.Y, ptPos.Z)
            local tSub = vXZ - tCenter
            local dist = tSub.Magnitude
            
            local zSub = ptPos.Z - tCenter.Z
            local xSub = ptPos.X - tCenter.X
            local atan = math.atan2(zSub, xSub)
            
            local rSpd = State.RingSpeed
            local mRad = math.rad(rSpd)
            local newAng = atan + mRad
            
            local rDis = State.RingDistance
            local minD = math.min(rDis, dist)
            local mCos = math.cos(newAng)
            local tX = tCenter.X + (mCos * minD)
            
            local ySub = ptPos.Y - tCenter.Y
            local rHei = State.RingHeight
            local hDiv = ySub / rHei
            local hSin = math.sin(hDiv)
            local hAbs = math.abs(hSin)
            local hMult = rHei * hAbs
            local tY = tCenter.Y + hMult
            
            local mSin = math.sin(newAng)
            local tZ = tCenter.Z + (mSin * minD)
            
            local tarPos = Vector3.new(tX, tY, tZ)
            local dirSub = tarPos - ptPos
            local dirUn = dirSub.Unit
            
            local rAtt = State.RingAttraction
            local fVel = dirUn * rAtt
            pt.Velocity = fVel
        end
    end
    
    local notBh = not State.Blackhole
    local notSr = not State.SuperRing
    local offAll = false
    if notBh then
        if notSr then
            offAll = true
        end
    end
    
    if offAll then
        local wsDesc = Workspace:GetDescendants()
        for _, v in pairs(wsDesc) do
            local isBPart = v:IsA("Part")
            if isBPart then
                local fAlgn = v:FindFirstChild("AlignPosition")
                if fAlgn then
                    fAlgn:Destroy()
                    local fTq = v:FindFirstChild("Torque")
                    if fTq then 
                        fTq:Destroy() 
                    end
                end
            end
        end
        local fAnc = Workspace:FindFirstChild("XayzAnchor")
        if fAnc then
            local zPos = CFrame.new(0, -1000, 0)
            fAnc.CFrame = zPos
        end
    end
end)