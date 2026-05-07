local function SafeExecuteScript()
    local CoreGuiService = nil
    local successCoreGui, errorCoreGui = pcall(function()
        local guiService = game:GetService("CoreGui")
        CoreGuiService = guiService
    end)

    local PlayersService = nil
    local successPlayers, errorPlayers = pcall(function()
        local pService = game:GetService("Players")
        PlayersService = pService
    end)

    local RunServiceAPI = nil
    local successRunService, errorRunService = pcall(function()
        local rService = game:GetService("RunService")
        RunServiceAPI = rService
    end)

    local UserInputServiceAPI = nil
    local successUserInput, errorUserInput = pcall(function()
        local uiService = game:GetService("UserInputService")
        UserInputServiceAPI = uiService
    end)

    local TweenServiceAPI = nil
    local successTween, errorTween = pcall(function()
        local tService = game:GetService("TweenService")
        TweenServiceAPI = tService
    end)

    local WorkspaceService = nil
    local successWorkspace, errorWorkspace = pcall(function()
        local wService = game:GetService("Workspace")
        WorkspaceService = wService
    end)

    local HttpServiceAPI = nil
    local successHttp, errorHttp = pcall(function()
        local hService = game:GetService("HttpService")
        HttpServiceAPI = hService
    end)

    local LogServiceAPI = nil
    local successLog, errorLog = pcall(function()
        local lService = game:GetService("LogService")
        LogServiceAPI = lService
    end)

    local ReplicatedStorageAPI = nil
    local successRep, errorRep = pcall(function()
        local repService = game:GetService("ReplicatedStorage")
        ReplicatedStorageAPI = repService
    end)

    local TextChatServiceAPI = nil
    local successTextChat, errorTextChat = pcall(function()
        local txtService = game:GetService("TextChatService")
        TextChatServiceAPI = txtService
    end)

    local LocalPlayerInstance = nil
    local successLocalPlayer, errorLocalPlayer = pcall(function()
        local lpInstance = PlayersService.LocalPlayer
        LocalPlayerInstance = lpInstance
    end)

    local CameraInstance = nil
    local successCamera, errorCamera = pcall(function()
        local camInstance = WorkspaceService.CurrentCamera
        local isCamNil = false
        if not camInstance then
            isCamNil = true
        end
        if isCamNil then
            local findCam = WorkspaceService:FindFirstChild("Camera")
            camInstance = findCam
        end
        CameraInstance = camInstance
    end)

    local GlobalState = {}
    local pcallState, errState = pcall(function()
        GlobalState.PerformanceMode = false 
        GlobalState.Fly = false
        GlobalState.FlySpeed = 1
        GlobalState.Aimbot = false
        GlobalState.SilentAim = false
        GlobalState.Aim_ShowFOV = false
        GlobalState.Aim_FOVSize = 150
        GlobalState.Aim_Part = "Head"
        GlobalState.ESP = false
        GlobalState.ESP_Box = false
        GlobalState.ESP_Tracer = false
        GlobalState.ESP_Health = false
        GlobalState.ESP_Name = false
        GlobalState.ESP_Chams = false
        GlobalState.POV = 70
        GlobalState.FlingV2 = false
        GlobalState.FlingV3 = false
        GlobalState.FlingPower = 50 
        GlobalState.SuperFling = false
        GlobalState.ForceField = false
        GlobalState.HealLoop = false
        GlobalState.GodModeV4 = false
        GlobalState.WideAvatar = 55
        GlobalState.DinoAnim = false
        GlobalState.PunchAnim = false
        GlobalState.ArmAnim = false
        GlobalState.ArmSpeed = 15
        GlobalState.ArmIntensity = 0.5
        GlobalState.SuperRing = false
        GlobalState.RingSpeed = 10
        GlobalState.RingHeight = 100
        GlobalState.RingDistance = 50
        GlobalState.RingAttraction = 1000
        GlobalState.Blackhole = false
        GlobalState.BlackholeDistance = 35
        local defaultColor = Color3.fromRGB(138, 43, 226)
        GlobalState.MainColor = defaultColor
        GlobalState.RGBGaming = false
        GlobalState.VM_Power = false
        GlobalState.VM_UserAgent = "Windows"
    end)

    local ConfigFileNameTarget = "XayzConfig.json"

    local function LoadConfigurationData()
        local successLoad, errorLoad = pcall(function()
            local isReadFileValid = false
            if type(readfile) == "function" then
                isReadFileValid = true
            end
            local isIsFileValid = false
            if type(isfile) == "function" then
                isIsFileValid = true
            end

            local canLoad = false
            if isReadFileValid then
                if isIsFileValid then
                    canLoad = true
                end
            end

            if canLoad then
                local checkFileExists = isfile(ConfigFileNameTarget)
                if checkFileExists then
                    local readStringData = readfile(ConfigFileNameTarget)
                    local decodedData = HttpServiceAPI:JSONDecode(readStringData)
                    for dataKey, dataValue in pairs(decodedData) do
                        local isColorKey = false
                        if dataKey == "MainColor" then
                            isColorKey = true
                        end
                        if isColorKey then
                            local rValueColor = dataValue.R
                            local gValueColor = dataValue.G
                            local bValueColor = dataValue.B
                            local combinedColor = Color3.fromRGB(rValueColor, gValueColor, bValueColor)
                            GlobalState.MainColor = combinedColor
                        end
                        local isNotColorKey = false
                        if dataKey ~= "MainColor" then
                            isNotColorKey = true
                        end
                        if isNotColorKey then
                            GlobalState[dataKey] = dataValue
                        end
                    end
                end
            end
        end)
    end

    local function SaveConfigurationData()
        local successSave, errorSave = pcall(function()
            local configDataTable = {}
            for stateKey, stateValue in pairs(GlobalState) do
                local isColorState = false
                if stateKey == "MainColor" then
                    isColorState = true
                end
                if isColorState then
                    local colorR = GlobalState.MainColor.R
                    local mathR = math.floor(colorR * 255)
                    local colorG = GlobalState.MainColor.G
                    local mathG = math.floor(colorG * 255)
                    local colorB = GlobalState.MainColor.B
                    local mathB = math.floor(colorB * 255)
                    local colorTableResult = {}
                    colorTableResult.R = mathR
                    colorTableResult.G = mathG
                    colorTableResult.B = mathB
                    configDataTable.MainColor = colorTableResult
                end
                local isNotColorState = false
                if stateKey ~= "MainColor" then
                    isNotColorState = true
                end
                if isNotColorState then
                    configDataTable[stateKey] = stateValue
                end
            end
            
            local isWriteFileValid = false
            if type(writefile) == "function" then
                isWriteFileValid = true
            end
            if isWriteFileValid then
                local encodedJsonData = HttpServiceAPI:JSONEncode(configDataTable)
                writefile(ConfigFileNameTarget, encodedJsonData)
            end
        end)
    end

    local GlobalEnvironment = nil
    local successGenv, errorGenv = pcall(function()
        local isGetGenvFunc = false
        if type(getgenv) == "function" then
            isGetGenvFunc = true
        end
        if isGetGenvFunc then
            local genvAPI = getgenv()
            GlobalEnvironment = genvAPI
        end
        
        local isGetGenvTable = false
        if type(getgenv) == "table" then
            isGetGenvTable = true
        end
        if isGetGenvTable then
            GlobalEnvironment = getgenv
        end
    end)
    local isGenvNil = false
    if type(GlobalEnvironment) == "nil" then
        isGenvNil = true
    end
    if isGenvNil then
        GlobalEnvironment = _G
    end

    local successNetwork, errorNetwork = pcall(function()
        local isNetworkExist = false
        if GlobalEnvironment.Network then
            isNetworkExist = true
        end
        local isNetworkNotExist = false
        if not isNetworkExist then
            isNetworkNotExist = true
        end
        if isNetworkNotExist then
            local networkTableData = {}
            local basePartsEmptyTable = {}
            networkTableData.BaseParts = basePartsEmptyTable
            local defaultVelocityVector = Vector3.new(14.46262424, 14.46262424, 14.46262424)
            networkTableData.Velocity = defaultVelocityVector

            local function retainPartLogic(partTarget)
                local successRetain, errorRetain = pcall(function()
                    local typeOfPart = typeof(partTarget)
                    local isTypeInstance = false
                    if typeOfPart == "Instance" then
                        isTypeInstance = true
                    end
                    if isTypeInstance then
                        local isBasePartClass = partTarget:IsA("BasePart")
                        if isBasePartClass then
                            local isDescendantWorkspace = partTarget:IsDescendantOf(WorkspaceService)
                            if isDescendantWorkspace then
                                local partsListTarget = GlobalEnvironment.Network.BaseParts
                                table.insert(partsListTarget, partTarget)
                                local newPhysicalProp = PhysicalProperties.new(0, 0, 0, 0, 0)
                                partTarget.CustomPhysicalProperties = newPhysicalProp
                                partTarget.CanCollide = false
                            end
                        end
                    end
                end)
            end
            networkTableData.RetainPart = retainPartLogic
            GlobalEnvironment.Network = networkTableData

            local function enablePartControlLogic()
                local successCtrl, errorCtrl = pcall(function()
                    LocalPlayerInstance.ReplicationFocus = WorkspaceService
                    local heartbeatConnectionNetwork = RunServiceAPI.Heartbeat:Connect(function()
                        local successHidden, errorHidden = pcall(function()
                            local isSetHiddenValid = false
                            if type(sethiddenproperty) == "function" then
                                isSetHiddenValid = true
                            end
                            if isSetHiddenValid then
                                sethiddenproperty(LocalPlayerInstance, "SimulationRadius", math.huge)
                            end
                        end)
                        local successVel, errorVel = pcall(function()
                            local basePartsLoopTable = GlobalEnvironment.Network.BaseParts
                            for indexPart, partLoop in pairs(basePartsLoopTable) do
                                local isDescendantLoop = partLoop:IsDescendantOf(WorkspaceService)
                                if isDescendantLoop then
                                    local currentVelocityNet = GlobalEnvironment.Network.Velocity
                                    partLoop.Velocity = currentVelocityNet
                                end
                            end
                        end)
                    end)
                end)
            end
            enablePartControlLogic()
        end
    end)

    local ScreenGuiMain = nil
    local successCreateGui, errorCreateGui = pcall(function()
        local newScreenGui = Instance.new("ScreenGui")
        newScreenGui.Name = "XayzExV3X"
        newScreenGui.ResetOnSpawn = false
        ScreenGuiMain = newScreenGui
    end)

    local successParentGui = false
    local tryParentGui, errorParentGui = pcall(function()
        local isCoreGuiValid = false
        if CoreGuiService then
            isCoreGuiValid = true
        end
        if isCoreGuiValid then
            local targetParentGui = nil
            local isGetHuiValid = false
            if type(gethui) == "function" then
                isGetHuiValid = true
            end
            if isGetHuiValid then
                local huiResult = gethui()
                targetParentGui = huiResult
            end
            local isNotGetHuiValid = false
            if not isGetHuiValid then
                isNotGetHuiValid = true
            end
            if isNotGetHuiValid then
                targetParentGui = CoreGuiService
            end
            ScreenGuiMain.Parent = targetParentGui
            successParentGui = true
        end
    end)

    local isGuiNotSuccess = false
    if not successParentGui then
        isGuiNotSuccess = true
    end
    if isGuiNotSuccess then
        local pcallFallbackGui, errFallbackGui = pcall(function()
            local playerGuiFolder = LocalPlayerInstance:WaitForChild("PlayerGui")
            ScreenGuiMain.Parent = playerGuiFolder
        end)
    end

    local function MakeElementDraggable(frameTarget)
        local successDrag, errorDrag = pcall(function()
            local draggingState = false
            local dragInputState = nil
            local dragStartState = nil
            local startPosState = nil

            local connectionInputBegan = frameTarget.InputBegan:Connect(function(inputTarget)
                local successBegan, errorBegan = pcall(function()
                    local isMouseOne = false
                    local typeInput1 = inputTarget.UserInputType
                    if typeInput1 == Enum.UserInputType.MouseButton1 then
                        isMouseOne = true
                    end
                    local isTouchInput = false
                    if typeInput1 == Enum.UserInputType.Touch then
                        isTouchInput = true
                    end
                    local isDragValid = false
                    if isMouseOne then
                        isDragValid = true
                    end
                    if isTouchInput then
                        isDragValid = true
                    end
                    if isDragValid then
                        draggingState = true
                        local posInput = inputTarget.Position
                        dragStartState = posInput
                        local framePos = frameTarget.Position
                        startPosState = framePos
                    end
                end)
            end)

            local connectionInputEnded = frameTarget.InputEnded:Connect(function(inputTarget2)
                local successEnded, errorEnded = pcall(function()
                    local isMouseOne2 = false
                    local typeInput2 = inputTarget2.UserInputType
                    if typeInput2 == Enum.UserInputType.MouseButton1 then
                        isMouseOne2 = true
                    end
                    local isTouchInput2 = false
                    if typeInput2 == Enum.UserInputType.Touch then
                        isTouchInput2 = true
                    end
                    local isDragValid2 = false
                    if isMouseOne2 then
                        isDragValid2 = true
                    end
                    if isTouchInput2 then
                        isDragValid2 = true
                    end
                    if isDragValid2 then
                        draggingState = false
                    end
                end)
            end)

            local connectionInputChanged = frameTarget.InputChanged:Connect(function(inputTarget3)
                local successChanged, errorChanged = pcall(function()
                    local isMouseMovement = false
                    local typeInput3 = inputTarget3.UserInputType
                    if typeInput3 == Enum.UserInputType.MouseMovement then
                        isMouseMovement = true
                    end
                    local isTouchMovement = false
                    if typeInput3 == Enum.UserInputType.Touch then
                        isTouchMovement = true
                    end
                    local isDragValid3 = false
                    if isMouseMovement then
                        isDragValid3 = true
                    end
                    if isTouchMovement then
                        isDragValid3 = true
                    end
                    if isDragValid3 then
                        dragInputState = inputTarget3
                    end
                end)
            end)

            local connectionUISChanged = UserInputServiceAPI.InputChanged:Connect(function(inputTarget4)
                local successUIS, errorUIS = pcall(function()
                    local isSameInput = false
                    if inputTarget4 == dragInputState then
                        isSameInput = true
                    end
                    if isSameInput then
                        local isDraggingNow = false
                        if draggingState then
                            isDraggingNow = true
                        end
                        if isDraggingNow then
                            local inputPos = inputTarget4.Position
                            local deltaPos = inputPos - dragStartState
                            local startPosX = startPosState.X.Offset
                            local startPosY = startPosState.Y.Offset
                            local deltaX = deltaPos.X
                            local deltaY = deltaPos.Y
                            local newPosX = startPosX + deltaX
                            local newPosY = startPosY + deltaY
                            local startScaleX = startPosState.X.Scale
                            local startScaleY = startPosState.Y.Scale
                            local finalUDim = UDim2.new(startScaleX, newPosX, startScaleY, newPosY)
                            frameTarget.Position = finalUDim
                        end
                    end
                end)
            end)
        end)
    end

    local NotificationContainerFrame = nil
    local successNotifCreate, errorNotifCreate = pcall(function()
        local frameNotif = Instance.new("Frame")
        frameNotif.Name = "NotificationContainerProtected"
        frameNotif.Parent = ScreenGuiMain
        frameNotif.BackgroundTransparency = 1
        local udimNotifPos = UDim2.new(1, -260, 1, -20)
        frameNotif.Position = udimNotifPos
        local udimNotifSize = UDim2.new(0, 250, 0, 0)
        frameNotif.Size = udimNotifSize
        local vecAnchor = Vector2.new(0, 1)
        frameNotif.AnchorPoint = vecAnchor
        NotificationContainerFrame = frameNotif

        local layoutNotif = Instance.new("UIListLayout")
        layoutNotif.Parent = NotificationContainerFrame
        layoutNotif.SortOrder = Enum.SortOrder.LayoutOrder
        layoutNotif.VerticalAlignment = Enum.VerticalAlignment.Bottom
        local padNotif = UDim.new(0, 10)
        layoutNotif.Padding = padNotif
    end)

    local function TriggerNotificationUI(titleText, bodyText, displayDuration)
        local successTrigger, errorTrigger = pcall(function()
            local finalDuration = 3
            local isDurationValid = false
            if type(displayDuration) == "number" then
                isDurationValid = true
            end
            if isDurationValid then
                finalDuration = displayDuration
            end
            
            local framePopup = Instance.new("Frame")
            framePopup.Parent = NotificationContainerFrame
            local colorPopupBg = Color3.fromRGB(15, 17, 26)
            framePopup.BackgroundColor3 = colorPopupBg
            local sizePopup = UDim2.new(1, 0, 0, 65)
            framePopup.Size = sizePopup
            
            local isPerfOn = GlobalState.PerformanceMode
            if isPerfOn then
                framePopup.BackgroundTransparency = 0
            end
            local isPerfOff = false
            if not isPerfOn then
                isPerfOff = true
            end
            if isPerfOff then
                framePopup.BackgroundTransparency = 1
            end
            
            local strokePopup = Instance.new("UIStroke")
            local colorStroke = GlobalState.MainColor
            strokePopup.Color = colorStroke
            strokePopup.Thickness = 1
            strokePopup.Parent = framePopup

            local cornerPopup = Instance.new("UICorner")
            local radPopup = UDim.new(0, 8)
            cornerPopup.CornerRadius = radPopup
            cornerPopup.Parent = framePopup
            
            local frameAccent = Instance.new("Frame")
            frameAccent.Parent = framePopup
            local colorAccent = GlobalState.MainColor
            frameAccent.BackgroundColor3 = colorAccent
            local sizeAccent = UDim2.new(0, 4, 1, 0)
            frameAccent.Size = sizeAccent
            
            local cornerAccent = Instance.new("UICorner")
            local radAccent = UDim.new(0, 8)
            cornerAccent.CornerRadius = radAccent
            cornerAccent.Parent = frameAccent
            
            local labelTitle = Instance.new("TextLabel")
            labelTitle.Parent = framePopup
            labelTitle.BackgroundTransparency = 1
            local posTitle = UDim2.new(0, 15, 0, 5)
            labelTitle.Position = posTitle
            local sizeTitleLabel = UDim2.new(1, -20, 0, 20)
            labelTitle.Size = sizeTitleLabel
            labelTitle.Font = Enum.Font.GothamBold
            labelTitle.Text = titleText
            local colorTitle = Color3.fromRGB(255, 255, 255)
            labelTitle.TextColor3 = colorTitle
            labelTitle.TextSize = 14
            labelTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local isPerfOn2 = GlobalState.PerformanceMode
            if isPerfOn2 then
                labelTitle.TextTransparency = 0
            end
            local isPerfOff2 = false
            if not isPerfOn2 then
                isPerfOff2 = true
            end
            if isPerfOff2 then
                labelTitle.TextTransparency = 1
            end
            
            local labelBody = Instance.new("TextLabel")
            labelBody.Parent = framePopup
            labelBody.BackgroundTransparency = 1
            local posBody = UDim2.new(0, 15, 0, 25)
            labelBody.Position = posBody
            local sizeBodyLabel = UDim2.new(1, -20, 0, 30)
            labelBody.Size = sizeBodyLabel
            labelBody.Font = Enum.Font.Gotham
            labelBody.Text = bodyText
            local colorBody = Color3.fromRGB(180, 180, 180)
            labelBody.TextColor3 = colorBody
            labelBody.TextSize = 12
            labelBody.TextWrapped = true
            labelBody.TextXAlignment = Enum.TextXAlignment.Left
            
            local isPerfOn3 = GlobalState.PerformanceMode
            if isPerfOn3 then
                labelBody.TextTransparency = 0
            end
            local isPerfOff3 = false
            if not isPerfOn3 then
                isPerfOff3 = true
            end
            if isPerfOff3 then
                labelBody.TextTransparency = 1
            end
            
            local frameProgBg = Instance.new("Frame")
            frameProgBg.Parent = framePopup
            local colorProgBg = Color3.fromRGB(30, 32, 45)
            frameProgBg.BackgroundColor3 = colorProgBg
            local posProgBg = UDim2.new(0, 15, 1, -5)
            frameProgBg.Position = posProgBg
            local sizeProgBg = UDim2.new(1, -25, 0, 3)
            frameProgBg.Size = sizeProgBg
            
            local isPerfOn4 = GlobalState.PerformanceMode
            if isPerfOn4 then
                frameProgBg.BackgroundTransparency = 0
            end
            local isPerfOff4 = false
            if not isPerfOn4 then
                isPerfOff4 = true
            end
            if isPerfOff4 then
                frameProgBg.BackgroundTransparency = 1
            end
            
            local cornerProgBg = Instance.new("UICorner")
            local radProgBg = UDim.new(1, 0)
            cornerProgBg.CornerRadius = radProgBg
            cornerProgBg.Parent = frameProgBg
            
            local frameProgFill = Instance.new("Frame")
            frameProgFill.Parent = frameProgBg
            local colorProgFill = GlobalState.MainColor
            frameProgFill.BackgroundColor3 = colorProgFill
            local sizeProgFill = UDim2.new(1, 0, 1, 0)
            frameProgFill.Size = sizeProgFill
            
            local isPerfOn5 = GlobalState.PerformanceMode
            if isPerfOn5 then
                frameProgFill.BackgroundTransparency = 0
            end
            local isPerfOff5 = false
            if not isPerfOn5 then
                isPerfOff5 = true
            end
            if isPerfOff5 then
                frameProgFill.BackgroundTransparency = 1
            end
            
            local cornerProgFill = Instance.new("UICorner")
            local radProgFill = UDim.new(1, 0)
            cornerProgFill.CornerRadius = radProgFill
            cornerProgFill.Parent = frameProgFill
            
            local isPerfOff6 = false
            if not GlobalState.PerformanceMode then
                isPerfOff6 = true
            end
            if isPerfOff6 then
                local tInfoIn = TweenInfo.new(0.3)
                local tPropIn1 = {}
                tPropIn1.BackgroundTransparency = 0
                local tween1 = TweenServiceAPI:Create(framePopup, tInfoIn, tPropIn1)
                tween1:Play()
                
                local tPropIn2 = {}
                tPropIn2.TextTransparency = 0
                local tween2 = TweenServiceAPI:Create(labelTitle, tInfoIn, tPropIn2)
                tween2:Play()
                local tween3 = TweenServiceAPI:Create(labelBody, tInfoIn, tPropIn2)
                tween3:Play()
                
                local tPropIn3 = {}
                tPropIn3.BackgroundTransparency = 0
                local tween4 = TweenServiceAPI:Create(frameProgBg, tInfoIn, tPropIn3)
                tween4:Play()
                local tween5 = TweenServiceAPI:Create(frameProgFill, tInfoIn, tPropIn3)
                tween5:Play()
                
                local tInfoProg = TweenInfo.new(finalDuration, Enum.EasingStyle.Linear)
                local tPropProg = {}
                tPropProg.Size = UDim2.new(0, 0, 1, 0)
                local tweenProg = TweenServiceAPI:Create(frameProgFill, tInfoProg, tPropProg)
                tweenProg:Play()
                
                local connComplete = tweenProg.Completed:Connect(function()
                    local successTweenOut, errorTweenOut = pcall(function()
                        local tInfoOut = TweenInfo.new(0.3)
                        local tPropOut1 = {}
                        tPropOut1.BackgroundTransparency = 1
                        local tweenOut1 = TweenServiceAPI:Create(framePopup, tInfoOut, tPropOut1)
                        tweenOut1:Play()
                        
                        local tPropOut2 = {}
                        tPropOut2.TextTransparency = 1
                        local tweenOut2 = TweenServiceAPI:Create(labelTitle, tInfoOut, tPropOut2)
                        tweenOut2:Play()
                        local tweenOut3 = TweenServiceAPI:Create(labelBody, tInfoOut, tPropOut2)
                        tweenOut3:Play()
                        
                        local tPropOut3 = {}
                        tPropOut3.BackgroundTransparency = 1
                        local tweenOut4 = TweenServiceAPI:Create(frameProgBg, tInfoOut, tPropOut3)
                        tweenOut4:Play()
                        local tweenOut5 = TweenServiceAPI:Create(frameProgFill, tInfoOut, tPropOut3)
                        tweenOut5:Play()
                        
                        task.wait(0.3)
                        framePopup:Destroy()
                    end)
                end)
            end
            
            local isPerfOn6 = GlobalState.PerformanceMode
            if isPerfOn6 then
                local spawnPerform = task.spawn(function()
                    local successSpwn, errorSpwn = pcall(function()
                        task.wait(finalDuration)
                        framePopup:Destroy()
                    end)
                end)
            end
        end)
    end

    local MainWrapperFrame = nil
    local MainStrokeInstance = nil
    local RGBGradientInstance = nil
    local successMainWrap, errorMainWrap = pcall(function()
        local frameMain = Instance.new("Frame")
        frameMain.Parent = ScreenGuiMain
        local colorMainBg = Color3.fromRGB(12, 14, 22)
        frameMain.BackgroundColor3 = colorMainBg
        local posMain = UDim2.new(0.5, -250, 0.5, -175)
        frameMain.Position = posMain
        local sizeMain = UDim2.new(0, 500, 0, 350)
        frameMain.Size = sizeMain
        MakeElementDraggable(frameMain)
        MainWrapperFrame = frameMain

        local cornerMain = Instance.new("UICorner")
        local radMain = UDim.new(0, 8)
        cornerMain.CornerRadius = radMain
        cornerMain.Parent = MainWrapperFrame

        local strokeMain = Instance.new("UIStroke")
        strokeMain.Parent = MainWrapperFrame
        local colorStrokeMain = GlobalState.MainColor
        strokeMain.Color = colorStrokeMain
        strokeMain.Thickness = 2
        MainStrokeInstance = strokeMain

        local gradRGB = Instance.new("UIGradient")
        gradRGB.Parent = MainStrokeInstance
        local kp1Color = GlobalState.MainColor
        local kp1 = ColorSequenceKeypoint.new(0.00, kp1Color)
        local kp2Color = Color3.fromRGB(255, 255, 255)
        local kp2 = ColorSequenceKeypoint.new(0.50, kp2Color)
        local kp3Color = GlobalState.MainColor
        local kp3 = ColorSequenceKeypoint.new(1.00, kp3Color)
        local seqColor = ColorSequence.new({kp1, kp2, kp3})
        gradRGB.Color = seqColor
        RGBGradientInstance = gradRGB
    end)

    local successLoopGradient, errorLoopGradient = pcall(function()
        local connStepped1 = RunServiceAPI.RenderStepped:Connect(function()
            local successStep1, errorStep1 = pcall(function()
                local isPerfOffGrad = false
                if not GlobalState.PerformanceMode then
                    isPerfOffGrad = true
                end
                if isPerfOffGrad then
                    local currentRotVal = RGBGradientInstance.Rotation
                    local addedRotVal = currentRotVal + 2
                    local modRotVal = addedRotVal % 360
                    RGBGradientInstance.Rotation = modRotVal
                end
                
                local isRGBGamingOn = GlobalState.RGBGaming
                if isRGBGamingOn then
                    local tValue = tick()
                    local mValue = tValue % 5
                    local divValue = mValue / 5
                    local resColor = Color3.fromHSV(divValue, 1, 1)
                    GlobalState.MainColor = resColor
                end
                
                local resColMain = GlobalState.MainColor
                MainStrokeInstance.Color = resColMain
            end)
        end)
    end)

    local LoadFramePanel = nil
    local AuraTextLabel = nil
    local TextGradientAura = nil
    local SpinnerFrame = nil
    local SpinnerStrokeIns = nil
    local successLoadPanel, errorLoadPanel = pcall(function()
        local fLoad = Instance.new("Frame")
        fLoad.Parent = MainWrapperFrame
        local cLoad = Color3.fromRGB(12, 14, 22)
        fLoad.BackgroundColor3 = cLoad
        local sLoad = UDim2.new(1, 0, 1, 0)
        fLoad.Size = sLoad
        fLoad.ZIndex = 100
        LoadFramePanel = fLoad

        local cLoadCorner = Instance.new("UICorner")
        local rLoadCorner = UDim.new(0, 8)
        cLoadCorner.CornerRadius = rLoadCorner
        cLoadCorner.Parent = LoadFramePanel

        local lblAura = Instance.new("TextLabel")
        lblAura.Parent = LoadFramePanel
        lblAura.BackgroundTransparency = 1
        local pAura = UDim2.new(0, 0, 0.4, -20)
        lblAura.Position = pAura
        local sAura = UDim2.new(1, 0, 0, 40)
        lblAura.Size = sAura
        lblAura.Font = Enum.Font.GothamBlack
        lblAura.Text = "X A Y Z   L I T E  X"
        local cAura = Color3.fromRGB(255, 255, 255)
        lblAura.TextColor3 = cAura
        lblAura.TextSize = 28
        lblAura.ZIndex = 101
        AuraTextLabel = lblAura

        local gradAura = Instance.new("UIGradient")
        gradAura.Parent = AuraTextLabel
        local akp1C = Color3.fromRGB(50, 50, 50)
        local akp1 = ColorSequenceKeypoint.new(0.0, akp1C)
        local akp2C = GlobalState.MainColor
        local akp2 = ColorSequenceKeypoint.new(0.5, akp2C)
        local akp3C = Color3.fromRGB(50, 50, 50)
        local akp3 = ColorSequenceKeypoint.new(1.0, akp3C)
        local aSeq = ColorSequence.new({akp1, akp2, akp3})
        gradAura.Color = aSeq
        local aVecOff = Vector2.new(-1, 0)
        gradAura.Offset = aVecOff
        TextGradientAura = gradAura

        local fSpin = Instance.new("Frame")
        fSpin.Parent = LoadFramePanel
        fSpin.BackgroundTransparency = 1
        local pSpin = UDim2.new(0.5, -20, 0.6, 0)
        fSpin.Position = pSpin
        local sSpin = UDim2.new(0, 40, 0, 40)
        fSpin.Size = sSpin
        fSpin.ZIndex = 101
        SpinnerFrame = fSpin

        local cSpin = Instance.new("UICorner")
        local rSpin = UDim.new(0.5, 0)
        cSpin.CornerRadius = rSpin
        cSpin.Parent = SpinnerFrame

        local strSpin = Instance.new("UIStroke")
        strSpin.Parent = SpinnerFrame
        strSpin.Thickness = 4
        local cStrSpin = GlobalState.MainColor
        strSpin.Color = cStrSpin
        strSpin.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        SpinnerStrokeIns = strSpin

        local gradSpin = Instance.new("UIGradient")
        gradSpin.Parent = SpinnerStrokeIns
        local skp1 = NumberSequenceKeypoint.new(0.0, 0.0)
        local skp2 = NumberSequenceKeypoint.new(0.5, 0.8)
        local skp3 = NumberSequenceKeypoint.new(1.0, 1.0)
        local sSeqNum = NumberSequence.new({skp1, skp2, skp3})
        gradSpin.Transparency = sSeqNum
    end)

    local successAnimLoad, errorAnimLoad = pcall(function()
        local spawnMainAnim = task.spawn(function()
            local successSpawnMain, errorSpawnMain = pcall(function()
                local tValueAnim = 0
                local loadingState = true
                
                local spawnLoop = task.spawn(function()
                    local successLoopAnim, errorLoopAnim = pcall(function()
                        while loadingState do
                            tValueAnim = tValueAnim + 0.05
                            local currentRotS = SpinnerFrame.Rotation
                            local nRotS = currentRotS + 10
                            SpinnerFrame.Rotation = nRotS
                            
                            local sinValT = math.sin(tValueAnim)
                            local offVecT = Vector2.new(sinValT, 0)
                            TextGradientAura.Offset = offVecT
                            
                            local stateColMain = GlobalState.MainColor
                            SpinnerStrokeIns.Color = stateColMain
                            
                            local c1A = Color3.fromRGB(50, 50, 50)
                            local kp1A = ColorSequenceKeypoint.new(0.0, c1A)
                            local kp2A = ColorSequenceKeypoint.new(0.5, stateColMain)
                            local c3A = Color3.fromRGB(50, 50, 50)
                            local kp3A = ColorSequenceKeypoint.new(1.0, c3A)
                            local seqAura = ColorSequence.new({kp1A, kp2A, kp3A})
                            TextGradientAura.Color = seqAura
                            
                            task.wait(0.03)
                        end
                    end)
                end)
                
                task.wait(10)
                loadingState = false
                
                local tInfoFade = TweenInfo.new(0.5)
                
                local tPropFade1 = {}
                tPropFade1.TextTransparency = 1
                local tweenFade1 = TweenServiceAPI:Create(AuraTextLabel, tInfoFade, tPropFade1)
                tweenFade1:Play()
                
                local tPropFade2 = {}
                tPropFade2.Transparency = 1
                local tweenFade2 = TweenServiceAPI:Create(SpinnerStrokeIns, tInfoFade, tPropFade2)
                tweenFade2:Play()
                
                task.wait(0.5)
                
                local tPropFade3 = {}
                tPropFade3.BackgroundTransparency = 1
                local tweenFade3 = TweenServiceAPI:Create(LoadFramePanel, tInfoFade, tPropFade3)
                tweenFade3:Play()
                
                task.wait(0.5)
                LoadFramePanel.Visible = false
                
                LoadConfigurationData()
                TriggerNotificationUI("System Online", "Welcome to Xayz Panel LiteX", 4)
            end)
        end)
    end)

    local HeaderPanel = nil
    local MinimizeBtnIns = nil
    local MaximizeBtnIns = nil
    local CloseBtnIns = nil
    local SidebarPanel = nil
    local ContentAreaPanel = nil
    local successUIBuild, errorUIBuild = pcall(function()
        local fHead = Instance.new("Frame")
        fHead.Parent = MainWrapperFrame
        local cHead = Color3.fromRGB(18, 20, 30)
        fHead.BackgroundColor3 = cHead
        local sHead = UDim2.new(1, 0, 0, 40)
        fHead.Size = sHead
        fHead.BorderSizePixel = 0
        HeaderPanel = fHead

        local crHead = Instance.new("UICorner")
        local rHead = UDim.new(0, 8)
        crHead.CornerRadius = rHead
        crHead.Parent = HeaderPanel

        local lblHead = Instance.new("TextLabel")
        lblHead.Parent = HeaderPanel
        lblHead.BackgroundTransparency = 1
        local pLblH = UDim2.new(0, 15, 0, 0)
        lblHead.Position = pLblH
        local sLblH = UDim2.new(0.6, 0, 1, 0)
        lblHead.Size = sLblH
        lblHead.Font = Enum.Font.GothamBold
        local cLblH = Color3.fromRGB(200, 220, 255)
        lblHead.TextColor3 = cLblH
        lblHead.TextSize = 14
        lblHead.TextXAlignment = Enum.TextXAlignment.Left
        lblHead.Text = "🖥️ Xayz Panel LiteX"

        local btnMin = Instance.new("TextButton")
        btnMin.Parent = HeaderPanel
        local cMinBtn = Color3.fromRGB(35, 40, 55)
        btnMin.BackgroundColor3 = cMinBtn
        local pMinBtn = UDim2.new(1, -95, 0.5, -12)
        btnMin.Position = pMinBtn
        local sMinBtn = UDim2.new(0, 24, 0, 24)
        btnMin.Size = sMinBtn
        btnMin.Font = Enum.Font.GothamBold
        btnMin.Text = "-"
        local tMinBtn = Color3.fromRGB(255, 255, 255)
        btnMin.TextColor3 = tMinBtn
        MinimizeBtnIns = btnMin
        
        local crMin = Instance.new("UICorner")
        local rMin = UDim.new(0, 6)
        crMin.CornerRadius = rMin
        crMin.Parent = MinimizeBtnIns

        local btnMax = Instance.new("TextButton")
        btnMax.Parent = HeaderPanel
        local cMaxBtn = Color3.fromRGB(35, 40, 55)
        btnMax.BackgroundColor3 = cMaxBtn
        local pMaxBtn = UDim2.new(1, -65, 0.5, -12)
        btnMax.Position = pMaxBtn
        local sMaxBtn = UDim2.new(0, 24, 0, 24)
        btnMax.Size = sMaxBtn
        btnMax.Font = Enum.Font.GothamBold
        btnMax.Text = "□"
        local tMaxBtn = Color3.fromRGB(255, 255, 255)
        btnMax.TextColor3 = tMaxBtn
        MaximizeBtnIns = btnMax
        
        local crMax = Instance.new("UICorner")
        local rMax = UDim.new(0, 6)
        crMax.CornerRadius = rMax
        crMax.Parent = MaximizeBtnIns

        local btnCls = Instance.new("TextButton")
        btnCls.Parent = HeaderPanel
        local cClsBtn = Color3.fromRGB(200, 50, 80)
        btnCls.BackgroundColor3 = cClsBtn
        local pClsBtn = UDim2.new(1, -35, 0.5, -12)
        btnCls.Position = pClsBtn
        local sClsBtn = UDim2.new(0, 24, 0, 24)
        btnCls.Size = sClsBtn
        btnCls.Font = Enum.Font.GothamBold
        btnCls.Text = "X"
        local tClsBtn = Color3.fromRGB(255, 255, 255)
        btnCls.TextColor3 = tClsBtn
        CloseBtnIns = btnCls
        
        local crCls = Instance.new("UICorner")
        local rCls = UDim.new(0, 6)
        crCls.CornerRadius = rCls
        crCls.Parent = CloseBtnIns

        local fSb = Instance.new("ScrollingFrame")
        fSb.Parent = MainWrapperFrame
        local cSb = Color3.fromRGB(15, 17, 26)
        fSb.BackgroundColor3 = cSb
        local pSb = UDim2.new(0, 0, 0, 40)
        fSb.Position = pSb
        local sSb = UDim2.new(0, 140, 1, -40)
        fSb.Size = sSb
        fSb.BorderSizePixel = 0
        fSb.ScrollBarThickness = 2
        fSb.AutomaticCanvasSize = Enum.AutomaticSize.Y
        SidebarPanel = fSb

        local crSb = Instance.new("UICorner")
        local rSb = UDim.new(0, 8)
        crSb.CornerRadius = rSb
        crSb.Parent = SidebarPanel

        local lstSb = Instance.new("UIListLayout")
        lstSb.Parent = SidebarPanel
        lstSb.SortOrder = Enum.SortOrder.LayoutOrder

        local fCa = Instance.new("Frame")
        fCa.Parent = MainWrapperFrame
        fCa.BackgroundTransparency = 1
        local pCa = UDim2.new(0, 150, 0, 50)
        fCa.Position = pCa
        local sCa = UDim2.new(1, -160, 1, -60)
        fCa.Size = sCa
        ContentAreaPanel = fCa
    end)

    local successBtnLogics, errorBtnLogics = pcall(function()
        local connMin2 = MinimizeBtnIns.MouseButton1Click:Connect(function()
            local successMinEv, errorMinEv = pcall(function()
                local isPerfOffMin = false
                if not GlobalState.PerformanceMode then
                    isPerfOffMin = true
                end
                if isPerfOffMin then
                    local tInfoMin = TweenInfo.new(0.3)
                    local tPropMin = {}
                    local szMinTarget = UDim2.new(0, 500, 0, 40)
                    tPropMin.Size = szMinTarget
                    local twMinA = TweenServiceAPI:Create(MainWrapperFrame, tInfoMin, tPropMin)
                    twMinA:Play()
                end
                
                local isPerfOnMin = GlobalState.PerformanceMode
                if isPerfOnMin then
                    local szMinTargetFix = UDim2.new(0, 500, 0, 40)
                    MainWrapperFrame.Size = szMinTargetFix
                end
                SidebarPanel.Visible = false
                ContentAreaPanel.Visible = false
            end)
        end)

        local connMax2 = MaximizeBtnIns.MouseButton1Click:Connect(function()
            local successMaxEv, errorMaxEv = pcall(function()
                local isPerfOffMax = false
                if not GlobalState.PerformanceMode then
                    isPerfOffMax = true
                end
                if isPerfOffMax then
                    local tInfoMax = TweenInfo.new(0.3)
                    local tPropMax = {}
                    local szMaxTarget = UDim2.new(0, 500, 0, 350)
                    tPropMax.Size = szMaxTarget
                    local twMaxA = TweenServiceAPI:Create(MainWrapperFrame, tInfoMax, tPropMax)
                    twMaxA:Play()
                    task.wait(0.3)
                end
                
                local isPerfOnMax = GlobalState.PerformanceMode
                if isPerfOnMax then
                    local szMaxTargetFix = UDim2.new(0, 500, 0, 350)
                    MainWrapperFrame.Size = szMaxTargetFix
                end
                SidebarPanel.Visible = true
                ContentAreaPanel.Visible = true
            end)
        end)

        local connCls2 = CloseBtnIns.MouseButton1Click:Connect(function()
            local successClsEv, errorClsEv = pcall(function()
                ScreenGuiMain:Destroy()
            end)
        end)
    end)

    local PagesTable = {}

    local function SwitchPageDisplay(pageNameTarget)
        local successSwitch, errorSwitch = pcall(function()
            for namePage, instPage in pairs(PagesTable) do
                local isMatchName = false
                if namePage == pageNameTarget then
                    isMatchName = true
                end
                if isMatchName then
                    instPage.Visible = true
                end
                local isNotMatch = false
                if namePage ~= pageNameTarget then
                    isNotMatch = true
                end
                if isNotMatch then
                    instPage.Visible = false
                end
            end
        end)
    end

    local function CreateSidebarTabButton(textTab, pageNameTab)
        local finalBtn = nil
        local successTabCreate, errorTabCreate = pcall(function()
            local btnTab = Instance.new("TextButton")
            btnTab.Parent = SidebarPanel
            btnTab.BackgroundTransparency = 1
            local szTab = UDim2.new(1, 0, 0, 35)
            btnTab.Size = szTab
            btnTab.Font = Enum.Font.GothamBold
            local cTab = Color3.fromRGB(120, 130, 150)
            btnTab.TextColor3 = cTab
            btnTab.TextSize = 12
            btnTab.Text = textTab

            local connTabC = btnTab.MouseButton1Click:Connect(function()
                local successClickTab, errorClickTab = pcall(function()
                    local sbChildrenList = SidebarPanel:GetChildren()
                    for _, childSb in pairs(sbChildrenList) do
                        local isTxtBtn = childSb:IsA("TextButton")
                        if isTxtBtn then
                            local rColTb = Color3.fromRGB(120, 130, 150)
                            childSb.TextColor3 = rColTb
                        end
                    end
                    local hColTb = GlobalState.MainColor
                    btnTab.TextColor3 = hColTb
                    SwitchPageDisplay(pageNameTab)
                end)
            end)
            
            local connRsTb = RunServiceAPI.RenderStepped:Connect(function()
                local successRsTb, errorRsTb = pcall(function()
                    local slcPage = PagesTable[pageNameTab]
                    if slcPage then
                        local isVisPage = slcPage.Visible
                        if isVisPage then
                            local hColTb2 = GlobalState.MainColor
                            btnTab.TextColor3 = hColTb2
                        end
                    end
                end)
            end)
            finalBtn = btnTab
        end)
        return finalBtn
    end

    local function CreateContentPage(namePageCr)
        local finalPage = nil
        local successPageCr, errorPageCr = pcall(function()
            local fPage = Instance.new("ScrollingFrame")
            fPage.Name = namePageCr
            fPage.Parent = ContentAreaPanel
            fPage.BackgroundTransparency = 1
            local sPage = UDim2.new(1, 0, 1, 0)
            fPage.Size = sPage
            fPage.ScrollBarThickness = 2
            fPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
            fPage.Visible = false
            
            PagesTable[namePageCr] = fPage
            
            local lstPage = Instance.new("UIListLayout")
            lstPage.Parent = fPage
            local pdPage = UDim.new(0, 8)
            lstPage.Padding = pdPage
            lstPage.SortOrder = Enum.SortOrder.LayoutOrder
            finalPage = fPage
        end)
        return finalPage
    end

    local PageObjCombat = CreateContentPage("Combat")
    local PageObjVisual = CreateContentPage("Visual")
    local PageObjFlings = CreateContentPage("Flings")
    local PageObjWorld = CreateContentPage("World")
    local PageObjAdmin = CreateContentPage("Admin")
    local PageObjVM = CreateContentPage("VirtualMachine")
    local PageObjCustomUI = CreateContentPage("CustomUI")
    local PageObjExecutor = CreateContentPage("Executor")
    local PageObjSettings = CreateContentPage("Settings")

    SwitchPageDisplay("Combat")
    local TabObj1 = CreateSidebarTabButton("COMBAT", "Combat")
    local stMainCol = GlobalState.MainColor
    TabObj1.TextColor3 = stMainCol
    local TabObj2 = CreateSidebarTabButton("VISUAL", "Visual")
    local TabObj3 = CreateSidebarTabButton("FLINGS", "Flings")
    local TabObj4 = CreateSidebarTabButton("WORLD", "World")
    local TabObj5 = CreateSidebarTabButton("ADMIN", "Admin")
    local TabObj6 = CreateSidebarTabButton("VM", "VirtualMachine")
    local TabObj7 = CreateSidebarTabButton("CUSTOM UI", "CustomUI")
    local TabObj8 = CreateSidebarTabButton("EXECUTOR", "Executor")
    local TabObj9 = CreateSidebarTabButton("SETTINGS", "Settings")

    local function CreateDualSwitchMenu(pageParent, textStr, stateKeyStr)
        local frameDS = nil
        local successDS, errorDS = pcall(function()
            local fDs = Instance.new("Frame")
            fDs.Parent = pageParent
            local cDs = Color3.fromRGB(20, 22, 30)
            fDs.BackgroundColor3 = cDs
            local sDs = UDim2.new(1, -5, 0, 45)
            fDs.Size = sDs
            
            local strDs = Instance.new("UIStroke")
            strDs.Parent = fDs
            local cStrDs = Color3.fromRGB(40, 45, 60)
            strDs.Color = cStrDs
            strDs.Thickness = 1
            
            local crDs = Instance.new("UICorner")
            local rDs = UDim.new(0, 6)
            crDs.CornerRadius = rDs
            crDs.Parent = fDs
            
            local lblDs = Instance.new("TextLabel")
            lblDs.Parent = fDs
            lblDs.BackgroundTransparency = 1
            local pLblDs = UDim2.new(0, 5, 0, 0)
            lblDs.Position = pLblDs
            local sLblDs = UDim2.new(1, -10, 0, 20)
            lblDs.Size = sLblDs
            lblDs.Font = Enum.Font.GothamSemibold
            local cLblDs = Color3.fromRGB(220, 220, 220)
            lblDs.TextColor3 = cLblDs
            lblDs.TextSize = 12
            lblDs.TextXAlignment = Enum.TextXAlignment.Center
            lblDs.Text = textStr
            
            local btnOnDs = Instance.new("TextButton")
            btnOnDs.Parent = fDs
            local pOnDs = UDim2.new(0.1, 0, 0, 20)
            btnOnDs.Position = pOnDs
            local sOnDs = UDim2.new(0.35, 0, 0, 20)
            btnOnDs.Size = sOnDs
            
            local isStateTrueDs = GlobalState[stateKeyStr]
            if isStateTrueDs then
                local cOnTDs = Color3.fromRGB(50, 255, 100)
                btnOnDs.BackgroundColor3 = cOnTDs
                local tOnTDs = Color3.fromRGB(0, 0, 0)
                btnOnDs.TextColor3 = tOnTDs
            end
            local isStateFalseDs = false
            if not isStateTrueDs then
                isStateFalseDs = true
            end
            if isStateFalseDs then
                local cOnFDs = Color3.fromRGB(40, 45, 60)
                btnOnDs.BackgroundColor3 = cOnFDs
                local tOnFDs = Color3.fromRGB(200, 200, 200)
                btnOnDs.TextColor3 = tOnFDs
            end
            
            btnOnDs.Text = "ON"
            btnOnDs.Font = Enum.Font.GothamBold
            
            local crOnDs = Instance.new("UICorner")
            local rOnDs = UDim.new(0, 4)
            crOnDs.CornerRadius = rOnDs
            crOnDs.Parent = btnOnDs

            local btnOffDs = Instance.new("TextButton")
            btnOffDs.Parent = fDs
            local pOffDs = UDim2.new(0.55, 0, 0, 20)
            btnOffDs.Position = pOffDs
            local sOffDs = UDim2.new(0.35, 0, 0, 20)
            btnOffDs.Size = sOffDs
            
            local isStateTrueDsOff = GlobalState[stateKeyStr]
            if isStateTrueDsOff then
                local cOffTDs = Color3.fromRGB(40, 45, 60)
                btnOffDs.BackgroundColor3 = cOffTDs
                local tOffTDs = Color3.fromRGB(200, 200, 200)
                btnOffDs.TextColor3 = tOffTDs
            end
            local isStateFalseDsOff = false
            if not isStateTrueDsOff then
                isStateFalseDsOff = true
            end
            if isStateFalseDsOff then
                local cOffFDs = Color3.fromRGB(255, 50, 50)
                btnOffDs.BackgroundColor3 = cOffFDs
                local tOffFDs = Color3.fromRGB(255, 255, 255)
                btnOffDs.TextColor3 = tOffFDs
            end
            
            btnOffDs.Text = "OFF"
            btnOffDs.Font = Enum.Font.GothamBold
            
            local crOffDs = Instance.new("UICorner")
            local rOffDs = UDim.new(0, 4)
            crOffDs.CornerRadius = rOffDs
            crOffDs.Parent = btnOffDs

            local connOnDs = btnOnDs.MouseButton1Click:Connect(function()
                local successClickOnDs, errorClickOnDs = pcall(function()
                    GlobalState[stateKeyStr] = true
                    local cGrnDs = Color3.fromRGB(50, 255, 100)
                    btnOnDs.BackgroundColor3 = cGrnDs
                    local cBlkDs = Color3.fromRGB(0, 0, 0)
                    btnOnDs.TextColor3 = cBlkDs
                    
                    local cGryDs = Color3.fromRGB(40, 45, 60)
                    btnOffDs.BackgroundColor3 = cGryDs
                    local cLgrDs = Color3.fromRGB(200, 200, 200)
                    btnOffDs.TextColor3 = cLgrDs
                    
                    local strMsgOnDs = textStr .. " Enabled"
                    TriggerNotificationUI("Setting", strMsgOnDs, 2)
                    SaveConfigurationData()
                end)
            end)
            
            local connOffDs = btnOffDs.MouseButton1Click:Connect(function()
                local successClickOffDs, errorClickOffDs = pcall(function()
                    GlobalState[stateKeyStr] = false
                    local cRedDs = Color3.fromRGB(255, 50, 50)
                    btnOffDs.BackgroundColor3 = cRedDs
                    local cWhtDs = Color3.fromRGB(255, 255, 255)
                    btnOffDs.TextColor3 = cWhtDs
                    
                    local cGryDs2 = Color3.fromRGB(40, 45, 60)
                    btnOnDs.BackgroundColor3 = cGryDs2
                    local cLgrDs2 = Color3.fromRGB(200, 200, 200)
                    btnOnDs.TextColor3 = cLgrDs2
                    
                    local strMsgOffDs = textStr .. " Disabled"
                    TriggerNotificationUI("Setting", strMsgOffDs, 2)
                    SaveConfigurationData()
                end)
            end)
            frameDS = fDs
        end)
        return frameDS
    end

    local function CreateDropdownMenu(pageParent, textStr)
        local frameDrop = nil
        local successDrop, errorDrop = pcall(function()
            local ctnDrop = Instance.new("Frame")
            ctnDrop.Parent = pageParent
            local cCtnDrop = Color3.fromRGB(20, 22, 30)
            ctnDrop.BackgroundColor3 = cCtnDrop
            local sCtnDrop = UDim2.new(1, -5, 0, 35)
            ctnDrop.Size = sCtnDrop
            ctnDrop.ClipsDescendants = true
            
            local strCtnDrop = Instance.new("UIStroke")
            strCtnDrop.Parent = ctnDrop
            local cStrCtnDrop = Color3.fromRGB(40, 45, 60)
            strCtnDrop.Color = cStrCtnDrop
            strCtnDrop.Thickness = 1

            local crCtnDrop = Instance.new("UICorner")
            local rCtnDrop = UDim.new(0, 6)
            crCtnDrop.CornerRadius = rCtnDrop
            crCtnDrop.Parent = ctnDrop

            local btnHeadDrop = Instance.new("TextButton")
            btnHeadDrop.Parent = ctnDrop
            btnHeadDrop.BackgroundTransparency = 1
            local pBtnHeadDrop = UDim2.new(0, 10, 0, 0)
            btnHeadDrop.Position = pBtnHeadDrop
            local sBtnHeadDrop = UDim2.new(1, -10, 0, 35)
            btnHeadDrop.Size = sBtnHeadDrop
            btnHeadDrop.Font = Enum.Font.GothamBold
            local cBtnHeadDrop = GlobalState.MainColor
            btnHeadDrop.TextColor3 = cBtnHeadDrop
            btnHeadDrop.TextSize = 12
            btnHeadDrop.TextXAlignment = Enum.TextXAlignment.Left
            
            local combinedStrDrop = textStr .. " ▼"
            btnHeadDrop.Text = combinedStrDrop

            local itemsDrop = Instance.new("Frame")
            itemsDrop.Parent = ctnDrop
            itemsDrop.BackgroundTransparency = 1
            local pItemsDrop = UDim2.new(0, 0, 0, 35)
            itemsDrop.Position = pItemsDrop
            local sItemsDrop = UDim2.new(1, 0, 0, 0)
            itemsDrop.Size = sItemsDrop

            local padItemsDrop = Instance.new("UIPadding")
            padItemsDrop.Parent = itemsDrop
            local pdLItemsDrop = UDim.new(0, 15)
            padItemsDrop.PaddingLeft = pdLItemsDrop
            local pdRItemsDrop = UDim.new(0, 5)
            padItemsDrop.PaddingRight = pdRItemsDrop

            local listItemsDrop = Instance.new("UIListLayout")
            listItemsDrop.Parent = itemsDrop
            local pListItemsDrop = UDim.new(0, 5)
            listItemsDrop.Padding = pListItemsDrop
            listItemsDrop.SortOrder = Enum.SortOrder.LayoutOrder

            local isDropOpen = false
            local function updateSizeDropLogic()
                local successUpdateSize, errorUpdateSize = pcall(function()
                    if isDropOpen then
                        local headTxtOpen = textStr .. " ▲"
                        btnHeadDrop.Text = headTxtOpen
                        
                        local listYSize = listItemsDrop.AbsoluteContentSize.Y
                        local calcItemsHeight = listYSize + 10
                        local szItemsNew = UDim2.new(1, 0, 0, calcItemsHeight)
                        itemsDrop.Size = szItemsNew
                        
                        local totalDropHeight = 35 + calcItemsHeight
                        local szCtnNew = UDim2.new(1, -5, 0, totalDropHeight)
                        ctnDrop.Size = szCtnNew
                    end
                    local isDropClosed = false
                    if not isDropOpen then
                        isDropClosed = true
                    end
                    if isDropClosed then
                        local headTxtClosed = textStr .. " ▼"
                        btnHeadDrop.Text = headTxtClosed
                        
                        local szItemsZero = UDim2.new(1, 0, 0, 0)
                        itemsDrop.Size = szItemsZero
                        
                        local szCtnZero = UDim2.new(1, -5, 0, 35)
                        ctnDrop.Size = szCtnZero
                    end
                end)
            end

            local connHeadDrop = btnHeadDrop.MouseButton1Click:Connect(function()
                local successClickHeadDrop, errorClickHeadDrop = pcall(function()
                    local currentDropState = isDropOpen
                    local newDropState = not currentDropState
                    isDropOpen = newDropState
                    updateSizeDropLogic()
                end)
            end)
            
            local connListChgDrop = listItemsDrop:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local successListChgDrop, errorListChgDrop = pcall(function()
                    updateSizeDropLogic()
                end)
            end)
            
            local connRsDrop = RunServiceAPI.RenderStepped:Connect(function()
                local successRsDrop, errorRsDrop = pcall(function()
                    local cHeadDropDyn = GlobalState.MainColor
                    btnHeadDrop.TextColor3 = cHeadDropDyn
                end)
            end)
            
            frameDrop = itemsDrop
        end)
        return frameDrop
    end

    local function CreateToggleMenu(pageParent, textStr, stateKeyStr, parentStateKeyStr)
        local frameTog = nil
        local successTog, errorTog = pcall(function()
            local fTog = Instance.new("Frame")
            fTog.Parent = pageParent
            local cTog = Color3.fromRGB(20, 22, 30)
            fTog.BackgroundColor3 = cTog
            local sTog = UDim2.new(1, -5, 0, 35)
            fTog.Size = sTog
            
            local strTog = Instance.new("UIStroke")
            strTog.Parent = fTog
            local cStrTog = Color3.fromRGB(40, 45, 60)
            strTog.Color = cStrTog
            strTog.Thickness = 1
            
            local crTog = Instance.new("UICorner")
            local rTog = UDim.new(0, 6)
            crTog.CornerRadius = rTog
            crTog.Parent = fTog
            
            local lblTog = Instance.new("TextLabel")
            lblTog.Parent = fTog
            lblTog.BackgroundTransparency = 1
            local pLblTog = UDim2.new(0, 10, 0, 0)
            lblTog.Position = pLblTog
            local sLblTog = UDim2.new(0.7, 0, 1, 0)
            lblTog.Size = sLblTog
            lblTog.Font = Enum.Font.GothamSemibold
            local cLblTog = Color3.fromRGB(220, 220, 220)
            lblTog.TextColor3 = cLblTog
            lblTog.TextSize = 12
            lblTog.TextXAlignment = Enum.TextXAlignment.Left
            lblTog.Text = textStr
            
            local btnTog = Instance.new("TextButton")
            btnTog.Parent = fTog
            local pBtnTog = UDim2.new(1, -50, 0.5, -8)
            btnTog.Position = pBtnTog
            local sBtnTog = UDim2.new(0, 36, 0, 16)
            btnTog.Size = sBtnTog
            local cBtnTog = Color3.fromRGB(15, 17, 22)
            btnTog.BackgroundColor3 = cBtnTog
            btnTog.Text = ""
            
            local crBtnTog = Instance.new("UICorner")
            local rBtnTog = UDim.new(1, 0)
            crBtnTog.CornerRadius = rBtnTog
            crBtnTog.Parent = btnTog
            
            local stFrameTog = Instance.new("Frame")
            stFrameTog.Parent = btnTog
            local cStFrameTog = Color3.fromRGB(100, 100, 120)
            stFrameTog.BackgroundColor3 = cStFrameTog
            local pStFrameTog = UDim2.new(0, 2, 0.5, -6)
            stFrameTog.Position = pStFrameTog
            local sStFrameTog = UDim2.new(0, 12, 0, 12)
            stFrameTog.Size = sStFrameTog
            
            local crStFrameTog = Instance.new("UICorner")
            local rStFrameTog = UDim.new(1, 0)
            crStFrameTog.CornerRadius = rStFrameTog
            crStFrameTog.Parent = stFrameTog

            local function updateUIStatusLogic()
                local successUpdTog, errorUpdTog = pcall(function()
                    local isKeyOn = GlobalState[stateKeyStr]
                    if isKeyOn then
                        local pOnTog = UDim2.new(1, -14, 0.5, -6)
                        stFrameTog.Position = pOnTog
                        local cOnTog = GlobalState.MainColor
                        stFrameTog.BackgroundColor3 = cOnTog
                    end
                    local isKeyOff = false
                    if not isKeyOn then
                        isKeyOff = true
                    end
                    if isKeyOff then
                        local pOffTog = UDim2.new(0, 2, 0.5, -6)
                        stFrameTog.Position = pOffTog
                        local cOffTog = Color3.fromRGB(100, 100, 120)
                        stFrameTog.BackgroundColor3 = cOffTog
                    end
                end)
            end

            local connRsTog = RunServiceAPI.RenderStepped:Connect(function()
                local successRsTog, errorRsTog = pcall(function()
                    local isParentKeyOff = false
                    if parentStateKeyStr then
                        local checkParentKey = GlobalState[parentStateKeyStr]
                        if not checkParentKey then
                            isParentKeyOff = true
                        end
                    end
                    
                    if isParentKeyOff then
                        local cGryTog = Color3.fromRGB(80, 80, 90)
                        lblTog.TextColor3 = cGryTog
                        btnTog.AutoButtonColor = false
                    end
                    local isParentKeyOn = false
                    if not isParentKeyOff then
                        isParentKeyOn = true
                    end
                    if isParentKeyOn then
                        local cWhtTog = Color3.fromRGB(220, 220, 220)
                        lblTog.TextColor3 = cWhtTog
                        btnTog.AutoButtonColor = true
                    end
                    
                    local isSelfKeyOn = GlobalState[stateKeyStr]
                    if isSelfKeyOn then
                        local cSelfOnTog = GlobalState.MainColor
                        stFrameTog.BackgroundColor3 = cSelfOnTog
                    end
                end)
            end)
            
            updateUIStatusLogic()

            local connBtnTog = btnTog.MouseButton1Click:Connect(function()
                local successClickTog, errorClickTog = pcall(function()
                    local isParentKeyOffClick = false
                    if parentStateKeyStr then
                        local checkParentKeyClick = GlobalState[parentStateKeyStr]
                        if not checkParentKeyClick then
                            isParentKeyOffClick = true
                        end
                    end
                    
                    if isParentKeyOffClick then 
                        return 
                    end
                    
                    local currSelfKey = GlobalState[stateKeyStr]
                    local newSelfKey = not currSelfKey
                    GlobalState[stateKeyStr] = newSelfKey
                    
                    local isPerfOffTogClick = false
                    if not GlobalState.PerformanceMode then
                        isPerfOffTogClick = true
                    end
                    if isPerfOffTogClick then
                        local tInfoTogClick = TweenInfo.new(0.2)
                        local tGoalTogClick = {}
                        local isNewKeyOnClick = GlobalState[stateKeyStr]
                        if isNewKeyOnClick then
                            local posOnTogClick = UDim2.new(1, -14, 0.5, -6)
                            tGoalTogClick.Position = posOnTogClick
                            local colOnTogClick = GlobalState.MainColor
                            tGoalTogClick.BackgroundColor3 = colOnTogClick
                        end
                        local isNewKeyOffClick = false
                        if not isNewKeyOnClick then
                            isNewKeyOffClick = true
                        end
                        if isNewKeyOffClick then
                            local posOffTogClick = UDim2.new(0, 2, 0.5, -6)
                            tGoalTogClick.Position = posOffTogClick
                            local colOffTogClick = Color3.fromRGB(100, 100, 120)
                            tGoalTogClick.BackgroundColor3 = colOffTogClick
                        end
                        local twTogClick = TweenServiceAPI:Create(stFrameTog, tInfoTogClick, tGoalTogClick)
                        twTogClick:Play()
                    end
                    
                    local isPerfOnTogClick = GlobalState.PerformanceMode
                    if isPerfOnTogClick then
                        local isNewKeyOnClickFast = GlobalState[stateKeyStr]
                        if isNewKeyOnClickFast then
                            local posOnTogClickFast = UDim2.new(1, -14, 0.5, -6)
                            stFrameTog.Position = posOnTogClickFast
                            local colOnTogClickFast = GlobalState.MainColor
                            stFrameTog.BackgroundColor3 = colOnTogClickFast
                        end
                        local isNewKeyOffClickFast = false
                        if not isNewKeyOnClickFast then
                            isNewKeyOffClickFast = true
                        end
                        if isNewKeyOffClickFast then
                            local posOffTogClickFast = UDim2.new(0, 2, 0.5, -6)
                            stFrameTog.Position = posOffTogClickFast
                            local colOffTogClickFast = Color3.fromRGB(100, 100, 120)
                            stFrameTog.BackgroundColor3 = colOffTogClickFast
                        end
                    end
                    
                    local strOnOffMsg = "Disabled"
                    local isFinalKeyOnMsg = GlobalState[stateKeyStr]
                    if isFinalKeyOnMsg then
                        strOnOffMsg = "Enabled"
                    end
                    TriggerNotificationUI(textStr, strOnOffMsg, 2)
                    SaveConfigurationData()
                end)
            end)
            frameTog = fTog
        end)
        return frameTog
    end

    local function CreateButtonMenu(pageParent, textStr, colorVar, callbackFunc, parentStateKeyStr)
        local btnReturn = nil
        local successBtn, errorBtn = pcall(function()
            local btnCreate = Instance.new("TextButton")
            btnCreate.Parent = pageParent
            btnCreate.BackgroundColor3 = colorVar
            local szBtnCr = UDim2.new(1, -5, 0, 35)
            btnCreate.Size = szBtnCr
            btnCreate.Font = Enum.Font.GothamBold
            local txtColBtnCr = Color3.fromRGB(255, 255, 255)
            btnCreate.TextColor3 = txtColBtnCr
            btnCreate.TextSize = 12
            btnCreate.Text = textStr
            
            local crBtnCr = Instance.new("UICorner")
            local rBtnCr = UDim.new(0, 6)
            crBtnCr.CornerRadius = rBtnCr
            crBtnCr.Parent = btnCreate
            
            local connRsBtnCr = RunServiceAPI.RenderStepped:Connect(function()
                local successRsBtnCr, errorRsBtnCr = pcall(function()
                    local isParentKeyOffBtnCr = false
                    if parentStateKeyStr then
                        local checkParentBtnCr = GlobalState[parentStateKeyStr]
                        if not checkParentBtnCr then
                            isParentKeyOffBtnCr = true
                        end
                    end
                    
                    if isParentKeyOffBtnCr then
                        local cGryBgBtnCr = Color3.fromRGB(30, 31, 36)
                        btnCreate.BackgroundColor3 = cGryBgBtnCr
                        local cGryTxBtnCr = Color3.fromRGB(80, 80, 90)
                        btnCreate.TextColor3 = cGryTxBtnCr
                    end
                    local isParentKeyOnBtnCr = false
                    if not isParentKeyOffBtnCr then
                        isParentKeyOnBtnCr = true
                    end
                    if isParentKeyOnBtnCr then
                        local strColCheck = tostring(colorVar)
                        local isMainColStr = false
                        if strColCheck == "Main" then
                            isMainColStr = true
                        end
                        if isMainColStr then
                            local mainColResBtnCr = GlobalState.MainColor
                            btnCreate.BackgroundColor3 = mainColResBtnCr
                        end
                        local isNotMainColStr = false
                        if not isMainColStr then
                            isNotMainColStr = true
                        end
                        if isNotMainColStr then
                            btnCreate.BackgroundColor3 = colorVar
                        end
                        local whtColResBtnCr = Color3.fromRGB(255, 255, 255)
                        btnCreate.TextColor3 = whtColResBtnCr
                    end
                end)
            end)

            local connClickBtnCr = btnCreate.MouseButton1Click:Connect(function()
                local successClickBtnCr, errorClickBtnCr = pcall(function()
                    local isParentKeyOffClkBtnCr = false
                    if parentStateKeyStr then
                        local checkParentClkBtnCr = GlobalState[parentStateKeyStr]
                        if not checkParentClkBtnCr then
                            isParentKeyOffClkBtnCr = true
                        end
                    end
                    
                    if isParentKeyOffClkBtnCr then 
                        return 
                    end
                    callbackFunc(btnCreate)
                end)
            end)
            btnReturn = btnCreate
        end)
        return btnReturn
    end

    local function CreateInputMenu(pageParent, textStr, stateKeyStr, parentStateKeyStr)
        local boxReturn = nil
        local successBox, errorBox = pcall(function()
            local bxCr = Instance.new("TextBox")
            bxCr.Parent = pageParent
            local cBxCr = Color3.fromRGB(20, 21, 26)
            bxCr.BackgroundColor3 = cBxCr
            local szBxCr = UDim2.new(1, -5, 0, 35)
            bxCr.Size = szBxCr
            bxCr.Font = Enum.Font.Gotham
            bxCr.Text = ""
            bxCr.PlaceholderText = textStr
            local tColBxCr = Color3.fromRGB(255, 255, 255)
            bxCr.TextColor3 = tColBxCr
            bxCr.TextSize = 12
            
            local strBxCr = Instance.new("UIStroke")
            strBxCr.Parent = bxCr
            local csBxCr = Color3.fromRGB(40, 45, 60)
            strBxCr.Color = csBxCr
            strBxCr.Thickness = 1
            
            local crBxCr = Instance.new("UICorner")
            local rBxCr = UDim.new(0, 6)
            crBxCr.CornerRadius = rBxCr
            crBxCr.Parent = bxCr
            
            local connRsBxCr = RunServiceAPI.RenderStepped:Connect(function()
                local successRsBxCr, errorRsBxCr = pcall(function()
                    local isParentKeyOffBxCr = false
                    if parentStateKeyStr then
                        local checkParentBxCr = GlobalState[parentStateKeyStr]
                        if not checkParentBxCr then
                            isParentKeyOffBxCr = true
                        end
                    end
                    
                    if isParentKeyOffBxCr then
                        local cgBxCr = Color3.fromRGB(80, 80, 90)
                        bxCr.TextColor3 = cgBxCr
                        bxCr.TextEditable = false
                    end
                    local isParentKeyOnBxCr = false
                    if not isParentKeyOffBxCr then
                        isParentKeyOnBxCr = true
                    end
                    if isParentKeyOnBxCr then
                        local cwBxCr = Color3.fromRGB(255, 255, 255)
                        bxCr.TextColor3 = cwBxCr
                        bxCr.TextEditable = true
                    end
                end)
            end)

            local connFocBxCr = bxCr.FocusLost:Connect(function()
                local successFocBxCr, errorFocBxCr = pcall(function()
                    local isParentKeyOffFocBxCr = false
                    if parentStateKeyStr then
                        local checkParentFocBxCr = GlobalState[parentStateKeyStr]
                        if not checkParentFocBxCr then
                            isParentKeyOffFocBxCr = true
                        end
                    end
                    
                    if isParentKeyOffFocBxCr then 
                        return 
                    end
                    
                    local txtBxCr = bxCr.Text
                    local numBxCr = tonumber(txtBxCr)
                    if numBxCr then 
                        GlobalState[stateKeyStr] = numBxCr 
                        SaveConfigurationData()
                    end
                end)
            end)
            boxReturn = bxCr
        end)
        return boxReturn
    end

    local function CreateStepperMenu(pageParent, textStr, stateKeyStr, parentStateKeyStr, isFloatArg)
        local frameStp = nil
        local successStp, errorStp = pcall(function()
            local fStp = Instance.new("Frame")
            fStp.Parent = pageParent
            local cStp = Color3.fromRGB(20, 21, 26)
            fStp.BackgroundColor3 = cStp
            local szStp = UDim2.new(1, -5, 0, 35)
            fStp.Size = szStp
            
            local strStp = Instance.new("UIStroke")
            strStp.Parent = fStp
            local csStp = Color3.fromRGB(40, 45, 60)
            strStp.Color = csStp
            strStp.Thickness = 1
            
            local crStp = Instance.new("UICorner")
            local rStp = UDim.new(0, 6)
            crStp.CornerRadius = rStp
            crStp.Parent = fStp
            
            local lblStp = Instance.new("TextLabel")
            lblStp.Parent = fStp
            lblStp.BackgroundTransparency = 1
            local pLblStp = UDim2.new(0, 10, 0, 0)
            lblStp.Position = pLblStp
            local sLblStp = UDim2.new(0.4, 0, 1, 0)
            lblStp.Size = sLblStp
            lblStp.Font = Enum.Font.GothamSemibold
            local tcLblStp = Color3.fromRGB(220, 220, 220)
            lblStp.TextColor3 = tcLblStp
            lblStp.TextSize = 12
            lblStp.TextXAlignment = Enum.TextXAlignment.Left
            lblStp.Text = textStr
            
            local minBtnStp = Instance.new("TextButton")
            minBtnStp.Parent = fStp
            local pMinStp = UDim2.new(1, -100, 0.5, -12)
            minBtnStp.Position = pMinStp
            local sMinStp = UDim2.new(0, 24, 0, 24)
            minBtnStp.Size = sMinStp
            local cMinStp = Color3.fromRGB(35, 40, 55)
            minBtnStp.BackgroundColor3 = cMinStp
            minBtnStp.Text = "-"
            local tcMinStp = Color3.fromRGB(255, 255, 255)
            minBtnStp.TextColor3 = tcMinStp
            
            local crMinStp = Instance.new("UICorner")
            local rMinStp = UDim.new(0, 4)
            crMinStp.CornerRadius = rMinStp
            crMinStp.Parent = minBtnStp
            
            local valBxStp = Instance.new("TextBox")
            valBxStp.Parent = fStp
            local pValStp = UDim2.new(1, -70, 0.5, -12)
            valBxStp.Position = pValStp
            local sValStp = UDim2.new(0, 34, 0, 24)
            valBxStp.Size = sValStp
            local cValStp = Color3.fromRGB(12, 14, 20)
            valBxStp.BackgroundColor3 = cValStp
            
            local currStateValStp = GlobalState[stateKeyStr]
            local strStateValStp = tostring(currStateValStp)
            valBxStp.Text = strStateValStp
            local tcValStp = Color3.fromRGB(255, 255, 255)
            valBxStp.TextColor3 = tcValStp
            
            local crValStp = Instance.new("UICorner")
            local rValStp = UDim.new(0, 4)
            crValStp.CornerRadius = rValStp
            crValStp.Parent = valBxStp
            
            local plsBtnStp = Instance.new("TextButton")
            plsBtnStp.Parent = fStp
            local pPlsStp = UDim2.new(1, -30, 0.5, -12)
            plsBtnStp.Position = pPlsStp
            local sPlsStp = UDim2.new(0, 24, 0, 24)
            plsBtnStp.Size = sPlsStp
            local cPlsStp = Color3.fromRGB(35, 40, 55)
            plsBtnStp.BackgroundColor3 = cPlsStp
            plsBtnStp.Text = "+"
            local tcPlsStp = Color3.fromRGB(255, 255, 255)
            plsBtnStp.TextColor3 = tcPlsStp
            
            local crPlsStp = Instance.new("UICorner")
            local rPlsStp = UDim.new(0, 4)
            crPlsStp.CornerRadius = rPlsStp
            crPlsStp.Parent = plsBtnStp

            local connRsStp = RunServiceAPI.RenderStepped:Connect(function()
                local successRsStp, errorRsStp = pcall(function()
                    local isParentKeyOffRsStp = false
                    if parentStateKeyStr then
                        local checkParentRsStp = GlobalState[parentStateKeyStr]
                        if not checkParentRsStp then
                            isParentKeyOffRsStp = true
                        end
                    end
                    
                    if isParentKeyOffRsStp then
                        local cgRsStp = Color3.fromRGB(80, 80, 90)
                        lblStp.TextColor3 = cgRsStp
                        valBxStp.TextColor3 = cgRsStp
                        valBxStp.TextEditable = false
                        minBtnStp.AutoButtonColor = false
                        plsBtnStp.AutoButtonColor = false
                    end
                    local isParentKeyOnRsStp = false
                    if not isParentKeyOffRsStp then
                        isParentKeyOnRsStp = true
                    end
                    if isParentKeyOnRsStp then
                        local cwRsStp1 = Color3.fromRGB(220, 220, 220)
                        lblStp.TextColor3 = cwRsStp1
                        local cwRsStp2 = Color3.fromRGB(255, 255, 255)
                        valBxStp.TextColor3 = cwRsStp2
                        valBxStp.TextEditable = true
                        minBtnStp.AutoButtonColor = true
                        plsBtnStp.AutoButtonColor = true
                    end
                end)
            end)

            local stepValMath = 1
            if isFloatArg then
                stepValMath = 0.5
            end

            local function updateStpLogic(newValArg)
                local successUpdStp, errorUpdStp = pcall(function()
                    local isParentKeyOffUpdStp = false
                    if parentStateKeyStr then
                        local checkParentUpdStp = GlobalState[parentStateKeyStr]
                        if not checkParentUpdStp then
                            isParentKeyOffUpdStp = true
                        end
                    end
                    if isParentKeyOffUpdStp then 
                        return 
                    end
                    
                    GlobalState[stateKeyStr] = newValArg
                    local strNewValArg = tostring(GlobalState[stateKeyStr])
                    valBxStp.Text = strNewValArg
                    SaveConfigurationData()
                end)
            end
            
            local connMinStp = minBtnStp.MouseButton1Click:Connect(function() 
                local successMinStp, errorMinStp = pcall(function()
                    local isParentKeyOffMinStp = false
                    if parentStateKeyStr then
                        local checkParentMinStp = GlobalState[parentStateKeyStr]
                        if not checkParentMinStp then
                            isParentKeyOffMinStp = true
                        end
                    end
                    if isParentKeyOffMinStp then 
                        return 
                    end
                    
                    local currValMinStp = GlobalState[stateKeyStr]
                    local isGreaterMinStp = false
                    if currValMinStp > stepValMath then
                        isGreaterMinStp = true
                    end
                    if isGreaterMinStp then 
                        local minResStp = currValMinStp - stepValMath
                        updateStpLogic(minResStp) 
                    end 
                end)
            end)
            
            local connPlsStp = plsBtnStp.MouseButton1Click:Connect(function() 
                local successPlsStp, errorPlsStp = pcall(function()
                    local isParentKeyOffPlsStp = false
                    if parentStateKeyStr then
                        local checkParentPlsStp = GlobalState[parentStateKeyStr]
                        if not checkParentPlsStp then
                            isParentKeyOffPlsStp = true
                        end
                    end
                    if isParentKeyOffPlsStp then 
                        return 
                    end
                    
                    local currValPlsStp = GlobalState[stateKeyStr]
                    local plsResStp = currValPlsStp + stepValMath
                    updateStpLogic(plsResStp) 
                end)
            end)
            
            local connFocStp = valBxStp.FocusLost:Connect(function()
                local successFocStp, errorFocStp = pcall(function()
                    local isParentKeyOffFocStp = false
                    if parentStateKeyStr then
                        local checkParentFocStp = GlobalState[parentStateKeyStr]
                        if not checkParentFocStp then
                            isParentKeyOffFocStp = true
                        end
                    end
                    if isParentKeyOffFocStp then 
                        local strResetStp = tostring(GlobalState[stateKeyStr])
                        valBxStp.Text = strResetStp
                        return 
                    end
                    
                    local txtFocStp = valBxStp.Text
                    local numFocStp = tonumber(txtFocStp)
                    if numFocStp then 
                        updateStpLogic(numFocStp) 
                    end
                    local isNotNumFocStp = false
                    if not numFocStp then
                        isNotNumFocStp = true
                    end
                    if isNotNumFocStp then
                        updateStpLogic(stepValMath)
                    end
                end)
            end)
            frameStp = fStp
        end)
        return frameStp
    end

    local TogCbt1 = CreateToggleMenu(PageObjCombat, "Aimbot", "Aimbot", nil)
    local DropCbtAim = CreateDropdownMenu(PageObjCombat, "Advanced Aimbot")
    local TogCbt2 = CreateToggleMenu(DropCbtAim, "Show FOV Circle", "Aim_ShowFOV", "Aimbot")
    local TogCbt3 = CreateToggleMenu(DropCbtAim, "Silent Aim", "SilentAim", "Aimbot")
    local StpCbt1 = CreateStepperMenu(DropCbtAim, "Set FOV Size", "Aim_FOVSize", "Aimbot", false)
    local cOrnCbt = Color3.fromRGB(200, 100, 0)
    local BtnCbt1 = CreateButtonMenu(DropCbtAim, "Switch Target: HEAD/TORSO", cOrnCbt, function(btnObj)
        local successSwTgt, errorSwTgt = pcall(function()
            local currTgtCbt = GlobalState.Aim_Part
            local isHeadCbt = false
            if currTgtCbt == "Head" then
                isHeadCbt = true
            end
            if isHeadCbt then
                GlobalState.Aim_Part = "HumanoidRootPart"
            end
            local isNotHeadCbt = false
            if currTgtCbt ~= "Head" then
                isNotHeadCbt = true
            end
            if isNotHeadCbt then
                GlobalState.Aim_Part = "Head"
            end
            
            local uprTgtCbt = string.upper(GlobalState.Aim_Part)
            local cmbTgtCbt = "Target: " .. uprTgtCbt
            btnObj.Text = cmbTgtCbt
            SaveConfigurationData()
        end)
    end, "Aimbot")

    local TogCbt4 = CreateToggleMenu(PageObjCombat, "Heal Loop", "HealLoop", nil)
    local TogCbt5 = CreateToggleMenu(PageObjCombat, "God Mode", "GodModeV4", nil)
    local TogCbt6 = CreateToggleMenu(PageObjCombat, "ForceField", "ForceField", nil)
    local TogCbt7 = CreateToggleMenu(PageObjCombat, "Fly", "Fly", nil)
    local StpCbt2 = CreateStepperMenu(PageObjCombat, "Fly Speed", "FlySpeed", "Fly", false)

    local TogVis1 = CreateToggleMenu(PageObjVisual, "ESP", "ESP", nil)
    local DropVisESP = CreateDropdownMenu(PageObjVisual, "Advanced ESP")
    local TogVis2 = CreateToggleMenu(DropVisESP, "Show Box", "ESP_Box", "ESP")
    local TogVis3 = CreateToggleMenu(DropVisESP, "Show Name & Distance", "ESP_Name", "ESP")
    local TogVis4 = CreateToggleMenu(DropVisESP, "Show Healthbar", "ESP_Health", "ESP")
    local TogVis5 = CreateToggleMenu(DropVisESP, "Show Tracer", "ESP_Tracer", "ESP")
    local TogVis6 = CreateToggleMenu(DropVisESP, "Show Chams", "ESP_Chams", "ESP")
    local InpVis1 = CreateInputMenu(PageObjVisual, "Set POV Camera (1-120)", "POV", nil)

    local TogFlg1 = CreateToggleMenu(PageObjFlings, "Fling", "FlingV2", nil)
    local TogFlg2 = CreateToggleMenu(PageObjFlings, "Fling V2", "FlingV3", nil)
    local InpFlg1 = CreateInputMenu(PageObjFlings, "Set Fling Power (Def: 50)", "FlingPower", nil)
    local TogFlg3 = CreateToggleMenu(PageObjFlings, "Super Touch Fling", "SuperFling", nil)

    local BtnFlg1 = CreateButtonMenu(PageObjFlings, "Teleport to ALL Players", "Main", function()
        local successTpAll, errorTpAll = pcall(function()
            TriggerNotificationUI("Teleporting", "Transporting to all players...", 3)
            local listPlyTp = PlayersService:GetPlayers()
            for indexTp, plyTp in ipairs(listPlyTp) do
                local lpObjTp = LocalPlayerInstance
                local isNotLpTp = false
                if plyTp ~= lpObjTp then
                    isNotLpTp = true
                end
                if isNotLpTp then
                    local charTp = plyTp.Character
                    if charTp then
                        local hrpTp = charTp:FindFirstChild("HumanoidRootPart")
                        if hrpTp then
                            local lpCharTp = LocalPlayerInstance.Character
                            if lpCharTp then
                                local lpHrpTp = lpCharTp:FindFirstChild("HumanoidRootPart")
                                if lpHrpTp then
                                    local cfTp = hrpTp.CFrame
                                    lpHrpTp.CFrame = cfTp
                                    task.wait(0.2)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end, nil)

    local cRedFlg = Color3.fromRGB(255, 50, 50)
    local BtnFlg2 = CreateButtonMenu(PageObjFlings, "Fling ALL Players", cRedFlg, function()
        local successFlgAll, errorFlgAll = pcall(function()
            TriggerNotificationUI("Fling All", "Executing mass fling...", 3)
            local oldSfFlg = GlobalState.SuperFling
            GlobalState.SuperFling = true
            
            local listPlyFlg = PlayersService:GetPlayers()
            for indexFlg, plyFlg in ipairs(listPlyFlg) do
                local lpObjFlg = LocalPlayerInstance
                local isNotLpFlg = false
                if plyFlg ~= lpObjFlg then
                    isNotLpFlg = true
                end
                if isNotLpFlg then
                    local charFlg = plyFlg.Character
                    if charFlg then
                        local hrpFlg = charFlg:FindFirstChild("HumanoidRootPart")
                        if hrpFlg then
                            local lpCharFlg = LocalPlayerInstance.Character
                            if lpCharFlg then
                                local lpHrpFlg = lpCharFlg:FindFirstChild("HumanoidRootPart")
                                if lpHrpFlg then
                                    local cfFlg = hrpFlg.CFrame
                                    lpHrpFlg.CFrame = cfFlg
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                end
            end
            GlobalState.SuperFling = oldSfFlg
        end)
    end, nil)

    local cPrpFlg = Color3.fromRGB(150, 50, 255)
    local BtnFlg3 = CreateButtonMenu(PageObjFlings, "Dropkick", cPrpFlg, function()
        local successDkFlg, errorDkFlg = pcall(function()
            TriggerNotificationUI("Executing", "Loading Dropkick script...", 2)
            local succLoadDk, errLoadDk = pcall(function() 
                local ldStrDk = loadstring
                local isLdStrDkVal = false
                if type(ldStrDk) == "function" then
                    isLdStrDkVal = true
                end
                if isLdStrDkVal then
                    local urlDk = "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua"
                    local httpResDk = game:HttpGet(urlDk)
                    local execFuncDk = ldStrDk(httpResDk)
                    local isExecFuncDkVal = false
                    if type(execFuncDk) == "function" then
                        isExecFuncDkVal = true
                    end
                    if isExecFuncDkVal then
                        execFuncDk()
                    end
                end
            end)
        end)
    end, nil)

    local TogFlg4 = CreateToggleMenu(PageObjFlings, "Dino Animation", "DinoAnim", nil)
    local TogFlg5 = CreateToggleMenu(PageObjFlings, "Punch Animation", "PunchAnim", nil)

    local TogFlg6 = CreateToggleMenu(PageObjFlings, "Arm Mover", "ArmAnim", nil)
    local DropFlgArm = CreateDropdownMenu(PageObjFlings, "Advanced Arm Mover")
    local StpFlg1 = CreateStepperMenu(DropFlgArm, "Arm Speed", "ArmSpeed", "ArmAnim", false)
    local StpFlg2 = CreateStepperMenu(DropFlgArm, "Arm Intensity", "ArmIntensity", "ArmAnim", true)

    local cPrpWld = Color3.fromRGB(138, 43, 226)
    local BtnWld1 = CreateButtonMenu(PageObjWorld, "Obliterator Tool", cPrpWld, function()
        local successObl, errorObl = pcall(function()
            local bpackObl = LocalPlayerInstance:WaitForChild("Backpack")
            local tObl = Instance.new("Tool")
            tObl.Name = "OBLITERATOR"
            tObl.RequiresHandle = true
            
            local hObl = Instance.new("Part")
            hObl.Name = "Handle"
            local szHObl = Vector3.new(1, 1, 1)
            hObl.Size = szHObl
            local clHObl = Color3.fromRGB(138, 43, 226)
            hObl.Color = clHObl
            hObl.Parent = tObl

            local connActObl = tObl.Activated:Connect(function()
                local successActObl, errorActObl = pcall(function()
                    local msObl = LocalPlayerInstance:GetMouse()
                    local tgtObl = msObl.Target
                    if tgtObl then
                        local isBpObl = tgtObl:IsA("BasePart")
                        if isBpObl then
                            local lpChObl = LocalPlayerInstance.Character
                            local isDescObl = tgtObl:IsDescendantOf(lpChObl)
                            local isNotDescObl = false
                            if not isDescObl then
                                isNotDescObl = true
                            end
                            if isNotDescObl then
                                tgtObl.CanCollide = false
                                tgtObl.Transparency = 1
                                tgtObl:BreakJoints()
                                local vecOffObl = Vector3.new(0, -1000, 0)
                                tgtObl.Position = vecOffObl
                            end
                        end
                    end
                end)
            end)
            tObl.Parent = bpackObl
            TriggerNotificationUI("Obliterator", "Tool added to Backpack!", 2)
        end)
    end, nil)

    local cBluWld = Color3.fromRGB(0, 150, 200)
    local BtnWld2 = CreateButtonMenu(PageObjWorld, "Switch to R6", cBluWld, function()
        local successR6, errorR6 = pcall(function()
            local chR6 = LocalPlayerInstance.Character
            if chR6 then
                local humR6 = chR6:FindFirstChildOfClass("Humanoid")
                if humR6 then
                    local rigTypeR6 = humR6.RigType
                    local isR15TypeR6 = false
                    if rigTypeR6 == Enum.HumanoidRigType.R15 then
                        isR15TypeR6 = true
                    end
                    if isR15TypeR6 then
                        local uidR6 = LocalPlayerInstance.UserId
                        local dscR6 = PlayersService:GetHumanoidDescriptionFromUserId(uidR6)
                        local r6Renum = Enum.HumanoidRigType.R6
                        local modR6 = PlayersService:CreateHumanoidModelFromDescription(dscR6, r6Renum)
                        
                        local pvtR6 = chR6:GetPivot()
                        modR6:PivotTo(pvtR6)
                        local nmR6 = LocalPlayerInstance.Name
                        modR6.Name = nmR6
                        LocalPlayerInstance.Character = modR6
                        modR6.Parent = WorkspaceService
                    end
                end
            end
        end)
    end, nil)

    local cGrnWld = Color3.fromRGB(0, 200, 150)
    local BtnWld3 = CreateButtonMenu(PageObjWorld, "Switch to R15", cGrnWld, function()
        local successR15, errorR15 = pcall(function()
            local chR15 = LocalPlayerInstance.Character
            if chR15 then
                local humR15 = chR15:FindFirstChildOfClass("Humanoid")
                if humR15 then
                    local rigTypeR15 = humR15.RigType
                    local isR6TypeR15 = false
                    if rigTypeR15 == Enum.HumanoidRigType.R6 then
                        isR6TypeR15 = true
                    end
                    if isR6TypeR15 then
                        local uidR15 = LocalPlayerInstance.UserId
                        local dscR15 = PlayersService:GetHumanoidDescriptionFromUserId(uidR15)
                        local r15Renum = Enum.HumanoidRigType.R15
                        local modR15 = PlayersService:CreateHumanoidModelFromDescription(dscR15, r15Renum)
                        
                        local pvtR15 = chR15:GetPivot()
                        modR15:PivotTo(pvtR15)
                        local nmR15 = LocalPlayerInstance.Name
                        modR15.Name = nmR15
                        LocalPlayerInstance.Character = modR15
                        modR15.Parent = WorkspaceService
                    end
                end
            end
        end)
    end, nil)

    local StpWld1 = CreateStepperMenu(PageObjWorld, "Wide Avatar", "WideAvatar", nil, true)

    local TogWld1 = CreateToggleMenu(PageObjWorld, "Super Rings", "SuperRing", nil)
    local DropWldRing = CreateDropdownMenu(PageObjWorld, "Advanced Rings")
    local StpWld2 = CreateStepperMenu(DropWldRing, "Ring Speed", "RingSpeed", "SuperRing", false)
    local StpWld3 = CreateStepperMenu(DropWldRing, "Ring Height", "RingHeight", "SuperRing", false)
    local StpWld4 = CreateStepperMenu(DropWldRing, "Ring Distance", "RingDistance", "SuperRing", false)
    local StpWld5 = CreateStepperMenu(DropWldRing, "Attraction Power", "RingAttraction", "SuperRing", false)

    local TogWld2 = CreateToggleMenu(PageObjWorld, "Blackhole", "Blackhole", nil)
    local DropWldBH = CreateDropdownMenu(PageObjWorld, "Advanced Blackhole")
    local StpBH1 = CreateStepperMenu(DropWldBH, "Blackhole Distance", "BlackholeDistance", "Blackhole", false)

    local BtnAdm1 = CreateButtonMenu(PageObjAdmin, "Get F3X Btools", "Main", function()
        local successF3X, errorF3X = pcall(function()
            local tbArgF3x1 = {}
            FireAllRemoteEventsFallback("btool", tbArgF3x1)
            local tbArgF3x2 = {}
            FireAllRemoteEventsFallback("f3x", tbArgF3x2)
            
            local succLoadF3X, errLoadF3X = pcall(function()
                local geF3X = getgenv
                local impF3X = nil
                local isGeF3XFn = false
                if type(geF3X) == "function" then
                    isGeF3XFn = true
                end
                if isGeF3XFn then
                    local gExF3X = geF3X()
                    impF3X = gExF3X.import
                end
                local isNotImpF3X = false
                if not impF3X then
                    isNotImpF3X = true
                end
                if isNotImpF3X then
                    local isImpF3XFn = false
                    if type(import) == "function" then
                        isImpF3XFn = true
                    end
                    if isImpF3XFn then
                        impF3X = import
                    end
                end
                
                local isImpF3XFn2 = false
                if type(impF3X) == "function" then
                    isImpF3XFn2 = true
                end
                if isImpF3XFn2 then 
                    local nmF3X = LocalPlayerInstance.Name
                    local exF3X = impF3X(12158566951)
                    local isExF3XFn = false
                    if type(exF3X) == "function" then
                        isExF3XFn = true
                    end
                    if isExF3XFn then
                        exF3X(nmF3X)
                    end
                end
            end)
            
            local succLocF3X, errLocF3X = pcall(function()
                local objF3XList = game:GetObjects("rbxassetid://22484922")
                if objF3XList then
                    local objF3XMain = objF3XList[1]
                    if objF3XMain then
                        local bpF3X = LocalPlayerInstance:FindFirstChild("Backpack")
                        if bpF3X then
                            objF3XMain.Parent = bpF3X
                        end
                    end
                end
            end)
            TriggerNotificationUI("F3X Loaded", "Check your inventory.", 2)
        end)
    end, nil)

    local BtnAdm2 = CreateButtonMenu(PageObjAdmin, "Get Btools", "Main", function()
        local successBt, errorBt = pcall(function()
            local tbArgBt1 = {}
            FireAllRemoteEventsFallback("btool", tbArgBt1)
            
            local succLoadBt, errLoadBt = pcall(function()
                local geBt = getgenv
                local impBt = nil
                local isGeBtFn = false
                if type(geBt) == "function" then
                    isGeBtFn = true
                end
                if isGeBtFn then
                    local gExBt = geBt()
                    impBt = gExBt.import
                end
                local isNotImpBt = false
                if not impBt then
                    isNotImpBt = true
                end
                if isNotImpBt then
                    local isImpBtFn = false
                    if type(import) == "function" then
                        isImpBtFn = true
                    end
                    if isImpBtFn then
                        impBt = import
                    end
                end
                
                local isImpBtFn2 = false
                if type(impBt) == "function" then
                    isImpBtFn2 = true
                end
                if isImpBtFn2 then 
                    local nmBt = LocalPlayerInstance.Name
                    local exBt = impBt(16530393933)
                    local isExBtFn = false
                    if type(exBt) == "function" then
                        isExBtFn = true
                    end
                    if isExBtFn then
                        exBt(nmBt)
                    end
                end
            end)
            
            local succLocBt, errLocBt = pcall(function()
                local bpBt = LocalPlayerInstance:FindFirstChild("Backpack")
                if bpBt then
                    local cb1 = Instance.new("HopperBin")
                    cb1.BinType = Enum.BinType.Clone
                    cb1.Parent = bpBt
                    
                    local cb2 = Instance.new("HopperBin")
                    cb2.BinType = Enum.BinType.Hammer
                    cb2.Parent = bpBt
                    
                    local cb3 = Instance.new("HopperBin")
                    cb3.BinType = Enum.BinType.Grab
                    cb3.Parent = bpBt
                end
            end)
            TriggerNotificationUI("Btools Loaded", "Check your inventory.", 2)
        end)
    end, nil)

    local function SetHDAdminRankSystem(rankIdInt, rankNameStr)
        local successSetHd, errorSetHd = pcall(function()
            local tbArgHd = {"Rank", LocalPlayerInstance, rankIdInt}
            FireAllRemoteEventsFallback("hdadmin", tbArgHd)
            
            local succModHd, errModHd = pcall(function()
                local geHd = getgenv
                local envHd = nil
                local isGeHdFn = false
                if type(geHd) == "function" then
                    isGeHdFn = true
                end
                if isGeHdFn then
                    envHd = geHd()
                end
                local isEnvHdNil = false
                if not envHd then
                    isEnvHdNil = true
                end
                if isEnvHdNil then
                    envHd = _G
                end
                local hdGlob = envHd.HDAdminMain
                if hdGlob then
                    local modCFHd = hdGlob:GetModule("cf")
                    if modCFHd then
                        local crIdHd = game.CreatorId
                        local setRankFn = modCFHd.SetRank
                        local isSetRankFn = false
                        if type(setRankFn) == "function" then
                            isSetRankFn = true
                        end
                        if isSetRankFn then
                            modCFHd:SetRank(LocalPlayerInstance, crIdHd, rankIdInt, "Perm")
                        end
                    end
                end
            end)
            
            local msgHdCb = "Rank set to " .. rankNameStr
            TriggerNotificationUI("HD Admin", msgHdCb, 2)
        end)
    end

    local DropAdmHD = CreateDropdownMenu(PageObjAdmin, "HD Admin Roles")

    local cHd1 = Color3.fromRGB(50, 50, 50)
    local BtnAdm3 = CreateButtonMenu(DropAdmHD, "Add HD Admin", cHd1, function()
        local successAddHd, errorAddHd = pcall(function()
            local tbArgAhd = {}
            FireAllRemoteEventsFallback("hdadmin", tbArgAhd)
            
            local succLdHd, errLdHd = pcall(function()
                local geAHd = getgenv
                local impAHd = nil
                local isGeAHdFn = false
                if type(geAHd) == "function" then
                    isGeAHdFn = true
                end
                if isGeAHdFn then
                    local gExAHd = geAHd()
                    impAHd = gExAHd.import
                end
                local isNotImpAHd = false
                if not impAHd then
                    isNotImpAHd = true
                end
                if isNotImpAHd then
                    local isImpAHdFn = false
                    if type(import) == "function" then
                        isImpAHdFn = true
                    end
                    if isImpAHdFn then
                        impAHd = import
                    end
                end
                
                local isImpAHdFn2 = false
                if type(impAHd) == "function" then
                    isImpAHdFn2 = true
                end
                if isImpAHdFn2 then 
                    local exAHd = impAHd(4893870373)
                    local isExAHdTb = false
                    if type(exAHd) == "table" then
                        isExAHdTb = true
                    end
                    if isExAHdTb then
                        local loadFnAHd = exAHd.load
                        local isLoadFnAHdVal = false
                        if type(loadFnAHd) == "function" then
                            isLoadFnAHdVal = true
                        end
                        if isLoadFnAHdVal then
                            local nmAHd = LocalPlayerInstance.Name
                            loadFnAHd(nmAHd)
                        end
                    end
                end
            end)
        end)
    end, nil)

    local cHd2 = Color3.fromRGB(80, 80, 80)
    local BtnAdm4 = CreateButtonMenu(DropAdmHD, "Rankless (0)", cHd2, function() 
        SetHDAdminRankSystem(0, "Rankless") 
    end, nil)

    local cHd3 = Color3.fromRGB(200, 200, 0)
    local BtnAdm5 = CreateButtonMenu(DropAdmHD, "VIP (1)", cHd3, function() 
        SetHDAdminRankSystem(1, "VIP") 
    end, nil)

    local cHd4 = Color3.fromRGB(0, 200, 0)
    local BtnAdm6 = CreateButtonMenu(DropAdmHD, "Mod (2)", cHd4, function() 
        SetHDAdminRankSystem(2, "Mod") 
    end, nil)

    local cHd5 = Color3.fromRGB(0, 100, 255)
    local BtnAdm7 = CreateButtonMenu(DropAdmHD, "Admin (3)", cHd5, function() 
        SetHDAdminRankSystem(3, "Admin") 
    end, nil)

    local cHd6 = Color3.fromRGB(255, 100, 0)
    local BtnAdm8 = CreateButtonMenu(DropAdmHD, "HeadAdmin (4)", cHd6, function() 
        SetHDAdminRankSystem(4, "HeadAdmin") 
    end, nil)

    local cHd7 = Color3.fromRGB(255, 0, 0)
    local BtnAdm9 = CreateButtonMenu(DropAdmHD, "Owner (5)", cHd7, function() 
        SetHDAdminRankSystem(5, "Owner") 
    end, nil)

    local cHd8 = Color3.fromRGB(138, 43, 226)
    local BtnAdm10 = CreateButtonMenu(DropAdmHD, "Above Owner", cHd8, function() 
        local mInfHd = math.huge
        SetHDAdminRankSystem(mInfHd, "Above Owner") 
    end, nil)

    local TogAdm1 = CreateToggleMenu(PageObjAdmin, "Become HD Admin Owner", "HDAdmin", nil)

    local FrameVMW = Instance.new("Frame")
    pcall(function()
        FrameVMW.Parent = PageObjVM
        FrameVMW.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        FrameVMW.Size = UDim2.new(1, -5, 0, 250)
        local crVMW = Instance.new("UICorner")
        crVMW.CornerRadius = UDim.new(0, 8)
        crVMW.Parent = FrameVMW

        local FrameVMH = Instance.new("Frame")
        FrameVMH.Parent = FrameVMW
        FrameVMH.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
        FrameVMH.Size = UDim2.new(1, 0, 0, 30)
        local crVMH = Instance.new("UICorner")
        crVMH.CornerRadius = UDim.new(0, 8)
        crVMH.Parent = FrameVMH

        local LblVMT = Instance.new("TextLabel")
        LblVMT.Parent = FrameVMH
        LblVMT.BackgroundTransparency = 1
        LblVMT.Position = UDim2.new(0, 10, 0, 0)
        LblVMT.Size = UDim2.new(1, -20, 1, 0)
        LblVMT.Font = Enum.Font.GothamBold
        LblVMT.Text = "🌐 VM"
        LblVMT.TextColor3 = Color3.fromRGB(200, 220, 255)
        LblVMT.TextSize = 12
        LblVMT.TextXAlignment = Enum.TextXAlignment.Left

        local FrameVMC = Instance.new("Frame")
        FrameVMC.Parent = FrameVMW
        FrameVMC.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FrameVMC.Position = UDim2.new(0, 10, 0, 40)
        FrameVMC.Size = UDim2.new(1, -20, 1, -50)
        local crVMC = Instance.new("UICorner")
        crVMC.CornerRadius = UDim.new(0, 4)
        crVMC.Parent = FrameVMC

        local LblVMB = Instance.new("TextLabel")
        LblVMB.Parent = FrameVMC
        LblVMB.BackgroundTransparency = 1
        LblVMB.Size = UDim2.new(1, 0, 1, 0)
        LblVMB.Font = Enum.Font.Gotham
        LblVMB.Text = "Virtual Machine is OFF"
        LblVMB.TextColor3 = Color3.fromRGB(100, 100, 100)
        LblVMB.TextSize = 12
        LblVMB.TextWrapped = true

        local DropVMU = CreateDropdownMenu(PageObjVM, "Change User Agent")

        local cVMUA = Color3.fromRGB(50, 50, 50)
        local BtnVM1 = CreateButtonMenu(DropVMU, "Windows", cVMUA, function() 
            pcall(function()
                GlobalState.VM_UserAgent = "Windows" 
                SaveConfigurationData()
            end)
        end, nil)

        local BtnVM2 = CreateButtonMenu(DropVMU, "Android", cVMUA, function() 
            pcall(function()
                GlobalState.VM_UserAgent = "Android" 
                SaveConfigurationData()
            end)
        end, nil)

        local BtnVM3 = CreateButtonMenu(DropVMU, "Linux", cVMUA, function() 
            pcall(function()
                GlobalState.VM_UserAgent = "Linux" 
                SaveConfigurationData()
            end)
        end, nil)

        local DualVM1 = CreateDualSwitchMenu(PageObjVM, "Power ON/OFF", "VM_Power")

        RunServiceAPI.RenderStepped:Connect(function()
            pcall(function()
                if GlobalState.VM_Power then
                    FrameVMC.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                    local curAg = GlobalState.VM_UserAgent
                    local cmbStrVm = "Connected via " .. curAg .. " User-Agent."
                    LblVMB.Text = cmbStrVm
                    LblVMB.TextColor3 = Color3.fromRGB(0, 0, 0)
                end
                if not GlobalState.VM_Power then
                    FrameVMC.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    LblVMB.Text = "Virtual Machine is OFF"
                    LblVMB.TextColor3 = Color3.fromRGB(100, 100, 100)
                end
            end)
        end)
    end)

    local ExecutorTabsData = {}
    local currentActiveTabId = 1
    local tabCounterTotal = 1
    local boxExecCode = nil
    local scrollTabs = nil
    local frameConsoleLog = nil
    local frameSpyChat = nil

    local function RefreshTabsRender()
        pcall(function()
            for _, childC in pairs(scrollTabs:GetChildren()) do
                if childC:IsA("Frame") then
                    childC:Destroy()
                end
            end
            
            for idTab, dataTab in ipairs(ExecutorTabsData) do
                local fTab = Instance.new("Frame")
                fTab.Parent = scrollTabs
                fTab.Size = UDim2.new(0, 100, 0, 25)
                
                if currentActiveTabId == idTab then
                    fTab.BackgroundColor3 = GlobalState.MainColor
                end
                if currentActiveTabId ~= idTab then
                    fTab.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
                end
                
                local crFTab = Instance.new("UICorner")
                crFTab.CornerRadius = UDim.new(0, 4)
                crFTab.Parent = fTab
                
                local btnSelTab = Instance.new("TextButton")
                btnSelTab.Parent = fTab
                btnSelTab.BackgroundTransparency = 1
                btnSelTab.Position = UDim2.new(0, 0, 0, 0)
                btnSelTab.Size = UDim2.new(0.7, 0, 1, 0)
                btnSelTab.Font = Enum.Font.GothamBold
                btnSelTab.Text = dataTab.Name
                btnSelTab.TextColor3 = Color3.fromRGB(255, 255, 255)
                btnSelTab.TextSize = 10
                
                local btnClsTab = Instance.new("TextButton")
                btnClsTab.Parent = fTab
                btnClsTab.BackgroundTransparency = 1
                btnClsTab.Position = UDim2.new(0.7, 0, 0, 0)
                btnClsTab.Size = UDim2.new(0.3, 0, 1, 0)
                btnClsTab.Font = Enum.Font.GothamBold
                btnClsTab.Text = "X"
                btnClsTab.TextColor3 = Color3.fromRGB(200, 100, 100)
                btnClsTab.TextSize = 10
                
                btnSelTab.MouseButton1Click:Connect(function()
                    pcall(function()
                        local currData = ExecutorTabsData[currentActiveTabId]
                        if currData then
                            currData.Source = boxExecCode.Text
                        end
                        currentActiveTabId = idTab
                        local newData = ExecutorTabsData[currentActiveTabId]
                        if newData then
                            boxExecCode.Text = newData.Source
                        end
                        RefreshTabsRender()
                    end)
                end)
                
                btnClsTab.MouseButton1Click:Connect(function()
                    pcall(function()
                        if #ExecutorTabsData > 1 then
                            table.remove(ExecutorTabsData, idTab)
                            if currentActiveTabId == idTab then
                                currentActiveTabId = 1
                                local defData = ExecutorTabsData[currentActiveTabId]
                                if defData then
                                    boxExecCode.Text = defData.Source
                                end
                            end
                            if idTab < currentActiveTabId then
                                currentActiveTabId = currentActiveTabId - 1
                            end
                            RefreshTabsRender()
                        end
                    end)
                end)
            end
        end)
    end

    pcall(function()
        local execDataInit = {}
        execDataInit.Name = "Script 1"
        execDataInit.Source = ""
        table.insert(ExecutorTabsData, execDataInit)
        
        local frameExecCont = Instance.new("Frame")
        frameExecCont.Parent = PageObjExecutor
        frameExecCont.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        frameExecCont.Size = UDim2.new(1, -5, 0, 600)
        
        local strExecCont = Instance.new("UIStroke")
        strExecCont.Parent = frameExecCont
        strExecCont.Color = Color3.fromRGB(40, 45, 60)
        strExecCont.Thickness = 1
        
        local crExecCont = Instance.new("UICorner")
        crExecCont.CornerRadius = UDim.new(0, 8)
        crExecCont.Parent = frameExecCont

        local frameTabBar = Instance.new("Frame")
        frameTabBar.Parent = frameExecCont
        frameTabBar.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
        frameTabBar.Position = UDim2.new(0, 0, 0, 0)
        frameTabBar.Size = UDim2.new(1, 0, 0, 35)
        
        local crTabBar = Instance.new("UICorner")
        crTabBar.CornerRadius = UDim.new(0, 8)
        crTabBar.Parent = frameTabBar

        scrollTabs = Instance.new("ScrollingFrame")
        scrollTabs.Parent = frameTabBar
        scrollTabs.BackgroundTransparency = 1
        scrollTabs.Position = UDim2.new(0, 0, 0, 0)
        scrollTabs.Size = UDim2.new(1, -40, 1, 0)
        scrollTabs.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrollTabs.AutomaticCanvasSize = Enum.AutomaticSize.X
        scrollTabs.ScrollBarThickness = 0

        local listTabs = Instance.new("UIListLayout")
        listTabs.Parent = scrollTabs
        listTabs.FillDirection = Enum.FillDirection.Horizontal
        listTabs.SortOrder = Enum.SortOrder.LayoutOrder
        listTabs.Padding = UDim.new(0, 5)

        local padScrollTabs = Instance.new("UIPadding")
        padScrollTabs.Parent = scrollTabs
        padScrollTabs.PaddingLeft = UDim.new(0, 5)
        padScrollTabs.PaddingTop = UDim.new(0, 5)
        
        local btnAddTab = Instance.new("TextButton")
        btnAddTab.Parent = frameTabBar
        btnAddTab.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
        btnAddTab.Position = UDim2.new(1, -35, 0, 5)
        btnAddTab.Size = UDim2.new(0, 25, 0, 25)
        btnAddTab.Font = Enum.Font.GothamBold
        btnAddTab.Text = "+"
        btnAddTab.TextColor3 = Color3.fromRGB(200, 200, 200)
        
        local crAddTab = Instance.new("UICorner")
        crAddTab.CornerRadius = UDim.new(0, 4)
        crAddTab.Parent = btnAddTab

        boxExecCode = Instance.new("TextBox")
        boxExecCode.Parent = frameExecCont
        boxExecCode.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
        boxExecCode.Position = UDim2.new(0, 10, 0, 45)
        boxExecCode.Size = UDim2.new(1, -20, 0, 140)
        boxExecCode.Font = Enum.Font.Code
        boxExecCode.Text = ""
        boxExecCode.PlaceholderText = ""
        boxExecCode.TextColor3 = Color3.fromRGB(220, 220, 220)
        boxExecCode.TextSize = 12
        boxExecCode.TextXAlignment = Enum.TextXAlignment.Left
        boxExecCode.TextYAlignment = Enum.TextYAlignment.Top
        boxExecCode.ClearTextOnFocus = false
        boxExecCode.MultiLine = true
        
        local crBoxExec = Instance.new("UICorner")
        crBoxExec.CornerRadius = UDim.new(0, 6)
        crBoxExec.Parent = boxExecCode
        
        local padBoxExec = Instance.new("UIPadding")
        padBoxExec.Parent = boxExecCode
        padBoxExec.PaddingLeft = UDim.new(0, 5)
        padBoxExec.PaddingTop = UDim.new(0, 5)

        local frameActions = Instance.new("Frame")
        frameActions.Parent = frameExecCont
        frameActions.BackgroundTransparency = 1
        frameActions.Position = UDim2.new(0, 10, 0, 195)
        frameActions.Size = UDim2.new(1, -20, 0, 30)

        local btnExecLua = Instance.new("TextButton")
        btnExecLua.Parent = frameActions
        btnExecLua.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        btnExecLua.Position = UDim2.new(0, 0, 0, 0)
        btnExecLua.Size = UDim2.new(0.3, 0, 1, 0)
        btnExecLua.Font = Enum.Font.GothamBold
        btnExecLua.Text = "Execute"
        btnExecLua.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        local crExecLua = Instance.new("UICorner")
        crExecLua.CornerRadius = UDim.new(0, 4)
        crExecLua.Parent = btnExecLua

        local btnCopyLua = Instance.new("TextButton")
        btnCopyLua.Parent = frameActions
        btnCopyLua.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
        btnCopyLua.Position = UDim2.new(0.35, 0, 0, 0)
        btnCopyLua.Size = UDim2.new(0.3, 0, 1, 0)
        btnCopyLua.Font = Enum.Font.GothamBold
        btnCopyLua.Text = "Copy"
        btnCopyLua.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local crCopyLua = Instance.new("UICorner")
        crCopyLua.CornerRadius = UDim.new(0, 4)
        crCopyLua.Parent = btnCopyLua

        local btnClearLua = Instance.new("TextButton")
        btnClearLua.Parent = frameActions
        btnClearLua.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        btnClearLua.Position = UDim2.new(0.7, 0, 0, 0)
        btnClearLua.Size = UDim2.new(0.3, 0, 1, 0)
        btnClearLua.Font = Enum.Font.GothamBold
        btnClearLua.Text = "Clear"
        btnClearLua.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local crClearLua = Instance.new("UICorner")
        crClearLua.CornerRadius = UDim.new(0, 4)
        crClearLua.Parent = btnClearLua

        frameConsoleLog = Instance.new("ScrollingFrame")
        frameConsoleLog.Parent = frameExecCont
        frameConsoleLog.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        frameConsoleLog.Position = UDim2.new(0, 10, 0, 235)
        frameConsoleLog.Size = UDim2.new(1, -20, 0, 100)
        frameConsoleLog.ScrollBarThickness = 2
        frameConsoleLog.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        local crConsole = Instance.new("UICorner")
        crConsole.CornerRadius = UDim.new(0, 4)
        crConsole.Parent = frameConsoleLog
        
        local listConsole = Instance.new("UIListLayout")
        listConsole.Parent = frameConsoleLog
        listConsole.SortOrder = Enum.SortOrder.LayoutOrder
        
        local padConsole = Instance.new("UIPadding")
        padConsole.Parent = frameConsoleLog
        padConsole.PaddingLeft = UDim.new(0, 5)
        padConsole.PaddingTop = UDim.new(0, 2)

        local btnCopyLogsAll = Instance.new("TextButton")
        btnCopyLogsAll.Parent = frameExecCont
        btnCopyLogsAll.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
        btnCopyLogsAll.Position = UDim2.new(0, 10, 0, 345)
        btnCopyLogsAll.Size = UDim2.new(1, -20, 0, 30)
        btnCopyLogsAll.Font = Enum.Font.GothamBold
        btnCopyLogsAll.Text = "Copy All Logs"
        btnCopyLogsAll.TextColor3 = Color3.fromRGB(255, 255, 255)

        local crCpyLg = Instance.new("UICorner")
        crCpyLg.CornerRadius = UDim.new(0, 4)
        crCpyLg.Parent = btnCopyLogsAll

        local lblSpyTitle = Instance.new("TextLabel")
        lblSpyTitle.Parent = frameExecCont
        lblSpyTitle.BackgroundTransparency = 1
        lblSpyTitle.Position = UDim2.new(0, 10, 0, 385)
        lblSpyTitle.Size = UDim2.new(1, -20, 0, 20)
        lblSpyTitle.Font = Enum.Font.GothamBold
        lblSpyTitle.Text = "View All Player Messages"
        lblSpyTitle.TextColor3 = Color3.fromRGB(200, 220, 255)
        lblSpyTitle.TextSize = 12
        lblSpyTitle.TextXAlignment = Enum.TextXAlignment.Left

        frameSpyChat = Instance.new("ScrollingFrame")
        frameSpyChat.Parent = frameExecCont
        frameSpyChat.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        frameSpyChat.Position = UDim2.new(0, 10, 0, 410)
        frameSpyChat.Size = UDim2.new(1, -20, 0, 140)
        frameSpyChat.ScrollBarThickness = 2
        frameSpyChat.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        local crSpyM = Instance.new("UICorner")
        crSpyM.CornerRadius = UDim.new(0, 4)
        crSpyM.Parent = frameSpyChat

        local listSpy = Instance.new("UIListLayout")
        listSpy.Parent = frameSpyChat
        listSpy.SortOrder = Enum.SortOrder.LayoutOrder

        local padSpy = Instance.new("UIPadding")
        padSpy.Parent = frameSpyChat
        padSpy.PaddingLeft = UDim.new(0, 5)
        padSpy.PaddingTop = UDim.new(0, 2)

        local boxSpyInput = Instance.new("TextBox")
        boxSpyInput.Parent = frameExecCont
        boxSpyInput.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        boxSpyInput.Position = UDim2.new(0, 10, 0, 560)
        boxSpyInput.Size = UDim2.new(1, -90, 0, 30)
        boxSpyInput.Font = Enum.Font.Gotham
        boxSpyInput.Text = ""
        boxSpyInput.PlaceholderText = "Type message..."
        boxSpyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
        boxSpyInput.TextSize = 12

        local strSpyI = Instance.new("UIStroke")
        strSpyI.Parent = boxSpyInput
        strSpyI.Color = Color3.fromRGB(40, 45, 60)
        strSpyI.Thickness = 1

        local crSpyI = Instance.new("UICorner")
        crSpyI.CornerRadius = UDim.new(0, 4)
        crSpyI.Parent = boxSpyInput

        local btnSpySend = Instance.new("TextButton")
        btnSpySend.Parent = frameExecCont
        btnSpySend.BackgroundColor3 = GlobalState.MainColor
        btnSpySend.Position = UDim2.new(1, -70, 0, 560)
        btnSpySend.Size = UDim2.new(0, 60, 0, 30)
        btnSpySend.Font = Enum.Font.GothamBold
        btnSpySend.Text = "Send"
        btnSpySend.TextColor3 = Color3.fromRGB(255, 255, 255)

        local crSpyS = Instance.new("UICorner")
        crSpyS.CornerRadius = UDim.new(0, 4)
        crSpyS.Parent = btnSpySend

        RunServiceAPI.RenderStepped:Connect(function()
            pcall(function()
                btnSpySend.BackgroundColor3 = GlobalState.MainColor
            end)
        end)

        btnAddTab.MouseButton1Click:Connect(function()
            pcall(function()
                local currDataSave = ExecutorTabsData[currentActiveTabId]
                if currDataSave then
                    currDataSave.Source = boxExecCode.Text
                end
                
                tabCounterTotal = tabCounterTotal + 1
                local newTabObj = {}
                newTabObj.Name = "Script " .. tostring(tabCounterTotal)
                newTabObj.Source = ""
                table.insert(ExecutorTabsData, newTabObj)
                
                currentActiveTabId = #ExecutorTabsData
                boxExecCode.Text = ""
                RefreshTabsRender()
            end)
        end)

        btnExecLua.MouseButton1Click:Connect(function()
            pcall(function()
                if type(loadstring) == "function" then
                    local execFuncVar, errLoadL = loadstring(boxExecCode.Text)
                    if type(execFuncVar) == "function" then
                        local succR, errR = pcall(function()
                            execFuncVar()
                        end)
                        if not succR then
                            TriggerNotificationUI("Executor", "Runtime Error: " .. tostring(errR), 4)
                        end
                    end
                    if type(execFuncVar) ~= "function" then
                        TriggerNotificationUI("Executor", "Syntax Error: " .. tostring(errLoadL), 4)
                    end
                end
                if type(loadstring) ~= "function" then
                    TriggerNotificationUI("Executor", "Loadstring is not enabled/supported on this executor.", 4)
                end
            end)
        end)

        btnCopyLua.MouseButton1Click:Connect(function()
            pcall(function()
                if type(setclipboard) == "function" then
                    setclipboard(boxExecCode.Text)
                    TriggerNotificationUI("Executor", "Code copied to clipboard.", 2)
                end
                if type(setclipboard) ~= "function" then
                    TriggerNotificationUI("Executor", "Clipboard function not supported.", 3)
                end
            end)
        end)

        btnClearLua.MouseButton1Click:Connect(function()
            pcall(function()
                boxExecCode.Text = ""
            end)
        end)

        boxExecCode:GetPropertyChangedSignal("Text"):Connect(function()
            pcall(function()
                local currDataUpd = ExecutorTabsData[currentActiveTabId]
                if currDataUpd then
                    currDataUpd.Source = boxExecCode.Text
                end
            end)
        end)

        LogServiceAPI.MessageOut:Connect(function(msgLog, typeLog)
            pcall(function()
                local lblLog = Instance.new("TextLabel")
                lblLog.Parent = frameConsoleLog
                lblLog.BackgroundTransparency = 1
                lblLog.Size = UDim2.new(1, 0, 0, 15)
                lblLog.Font = Enum.Font.Code
                lblLog.Text = msgLog
                lblLog.TextSize = 10
                lblLog.TextXAlignment = Enum.TextXAlignment.Left
                
                if typeLog == Enum.MessageType.MessageWarning then
                    lblLog.TextColor3 = Color3.fromRGB(255, 200, 50)
                end
                if typeLog == Enum.MessageType.MessageError then
                    lblLog.TextColor3 = Color3.fromRGB(255, 50, 50)
                end
                if typeLog == Enum.MessageType.MessageInfo then
                    lblLog.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
                if typeLog == Enum.MessageType.MessageOutput then
                    lblLog.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end)
        end)

        btnCopyLogsAll.MouseButton1Click:Connect(function()
            pcall(function()
                local fullLogText = ""
                for _, lgChild in pairs(frameConsoleLog:GetChildren()) do
                    if lgChild:IsA("TextLabel") then
                        fullLogText = fullLogText .. lgChild.Text .. "\n"
                    end
                end
                if type(setclipboard) == "function" then
                    setclipboard(fullLogText)
                    TriggerNotificationUI("Logs", "All logs copied to clipboard.", 2)
                end
                if type(setclipboard) ~= "function" then
                    TriggerNotificationUI("Logs", "Clipboard function not supported.", 3)
                end
            end)
        end)

        local function processChatSpyLog(playerNameLog, playerTextLog)
            pcall(function()
                local lblSpy = Instance.new("TextLabel")
                lblSpy.Parent = frameSpyChat
                lblSpy.BackgroundTransparency = 1
                lblSpy.Size = UDim2.new(1, 0, 0, 15)
                lblSpy.Font = Enum.Font.Gotham
                lblSpy.Text = "[" .. playerNameLog .. "]: " .. playerTextLog
                lblSpy.TextSize = 12
                lblSpy.TextXAlignment = Enum.TextXAlignment.Left
                lblSpy.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
        end

        local function hookPlayerChat(playerToHook)
            pcall(function()
                playerToHook.Chatted:Connect(function(msgChatRecv)
                    processChatSpyLog(playerToHook.Name, msgChatRecv)
                end)
            end)
        end

        for _, pSpyInit in pairs(PlayersService:GetPlayers()) do
            hookPlayerChat(pSpyInit)
        end

        PlayersService.PlayerAdded:Connect(function(newPlrSpy)
            hookPlayerChat(newPlrSpy)
        end)

        btnSpySend.MouseButton1Click:Connect(function()
            pcall(function()
                local textToSend = boxSpyInput.Text
                if string.len(textToSend) > 0 then
                    local defChatSys = ReplicatedStorageAPI:FindFirstChild("DefaultChatSystemChatEvents")
                    if defChatSys then
                        local sayMsgEvt = defChatSys:FindFirstChild("SayMessageRequest")
                        if sayMsgEvt then
                            sayMsgEvt:FireServer(textToSend, "All")
                        end
                    end
                    
                    if not defChatSys then
                        local txtChans = TextChatServiceAPI:FindFirstChild("TextChannels")
                        if txtChans then
                            local rbxGen = txtChans:FindFirstChild("RBXGeneral")
                            if rbxGen then
                                rbxGen:SendAsync(textToSend)
                            end
                        end
                    end
                    
                    boxSpyInput.Text = ""
                end
            end)
        end)

        RefreshTabsRender()
    end)
end

local FrameCUIBox = Instance.new("Frame")
pcall(function()
    FrameCUIBox.Parent = PageObjCustomUI
    FrameCUIBox.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
    FrameCUIBox.Size = UDim2.new(1, -5, 0, 60)
    local crCUIB = Instance.new("UICorner")
    crCUIB.CornerRadius = UDim.new(0, 8)
    crCUIB.Parent = FrameCUIBox

    local StrCUIB = Instance.new("UIStroke")
    StrCUIB.Parent = FrameCUIBox
    StrCUIB.Color = GlobalState.MainColor
    StrCUIB.Thickness = 2

    local LblCUIT = Instance.new("TextLabel")
    LblCUIT.Parent = FrameCUIBox
    LblCUIT.BackgroundTransparency = 1
    LblCUIT.Size = UDim2.new(1, 0, 1, 0)
    LblCUIT.Font = Enum.Font.GothamBold
    LblCUIT.Text = "PREVIEW COLOR"
    LblCUIT.TextColor3 = GlobalState.MainColor
    LblCUIT.TextSize = 14

    local TmpColorData = GlobalState.MainColor

    local FrameCUIPal = Instance.new("Frame")
    FrameCUIPal.Parent = PageObjCustomUI
    FrameCUIPal.BackgroundTransparency = 1
    FrameCUIPal.Size = UDim2.new(1, -5, 0, 150)

    local GridCUIPal = Instance.new("UIGridLayout")
    GridCUIPal.Parent = FrameCUIPal
    GridCUIPal.CellSize = UDim2.new(0, 30, 0, 30)
    GridCUIPal.CellPadding = UDim2.new(0, 5, 0, 5)
    GridCUIPal.SortOrder = Enum.SortOrder.LayoutOrder

    local colorListTbl = {}
    table.insert(colorListTbl, Color3.fromRGB(255,0,0))
    table.insert(colorListTbl, Color3.fromRGB(0,255,0))
    table.insert(colorListTbl, Color3.fromRGB(0,0,255))
    table.insert(colorListTbl, Color3.fromRGB(255,255,0))
    table.insert(colorListTbl, Color3.fromRGB(255,0,255))
    table.insert(colorListTbl, Color3.fromRGB(0,255,255))
    table.insert(colorListTbl, Color3.fromRGB(255,128,0))
    table.insert(colorListTbl, Color3.fromRGB(128,0,255))
    table.insert(colorListTbl, Color3.fromRGB(255,0,128))
    table.insert(colorListTbl, Color3.fromRGB(0,255,128))
    table.insert(colorListTbl, Color3.fromRGB(128,255,0))
    table.insert(colorListTbl, Color3.fromRGB(0,128,255))
    table.insert(colorListTbl, Color3.fromRGB(255,255,255))
    table.insert(colorListTbl, Color3.fromRGB(100,100,100))
    table.insert(colorListTbl, Color3.fromRGB(50,50,50))
    table.insert(colorListTbl, Color3.fromRGB(138,43,226))
    table.insert(colorListTbl, Color3.fromRGB(0,200,150))
    table.insert(colorListTbl, Color3.fromRGB(255,100,100))
    table.insert(colorListTbl, Color3.fromRGB(100,255,100))
    table.insert(colorListTbl, Color3.fromRGB(100,100,255))
    table.insert(colorListTbl, Color3.fromRGB(255,200,100))
    table.insert(colorListTbl, Color3.fromRGB(200,255,100))
    table.insert(colorListTbl, Color3.fromRGB(100,200,255))
    table.insert(colorListTbl, Color3.fromRGB(255,150,0))
    table.insert(colorListTbl, Color3.fromRGB(0,150,255))
    table.insert(colorListTbl, Color3.fromRGB(150,0,255))
    table.insert(colorListTbl, Color3.fromRGB(255,0,150))
    table.insert(colorListTbl, Color3.fromRGB(0,255,150))
    table.insert(colorListTbl, Color3.fromRGB(150,255,0))
    table.insert(colorListTbl, Color3.fromRGB(200,0,0))
    table.insert(colorListTbl, Color3.fromRGB(0,200,0))
    table.insert(colorListTbl, Color3.fromRGB(0,0,200))
    table.insert(colorListTbl, Color3.fromRGB(200,200,0))
    table.insert(colorListTbl, Color3.fromRGB(200,0,200))
    table.insert(colorListTbl, Color3.fromRGB(0,200,200))

    for _, colorVal in ipairs(colorListTbl) do
        local btnColPlt = Instance.new("TextButton")
        btnColPlt.Parent = FrameCUIPal
        btnColPlt.BackgroundColor3 = colorVal
        btnColPlt.Text = ""
        local crColPlt = Instance.new("UICorner")
        crColPlt.CornerRadius = UDim.new(0, 4)
        crColPlt.Parent = btnColPlt
        
        btnColPlt.MouseButton1Click:Connect(function()
            pcall(function()
                TmpColorData = colorVal
                StrCUIB.Color = TmpColorData
                LblCUIT.TextColor3 = TmpColorData
            end)
        end)
    end

    CreateDualSwitchMenu(PageObjCustomUI, "RGB Gaming Modern", "RGBGaming")

    CreateButtonMenu(PageObjCustomUI, "Test Notify Custom", "Main", function()
        pcall(function()
            local oldColorSav = GlobalState.MainColor
            GlobalState.MainColor = TmpColorData
            TriggerNotificationUI("Test Custom", "This is how it looks!", 3)
            GlobalState.MainColor = oldColorSav
        end)
    end, nil)

    CreateButtonMenu(PageObjCustomUI, "Apply Change", Color3.fromRGB(50, 200, 100), function()
        pcall(function()
            GlobalState.MainColor = TmpColorData
            SaveConfigurationData()
            TriggerNotificationUI("Theme Saved", "Colors applied successfully.", 3)
        end)
    end, nil)

    CreateButtonMenu(PageObjCustomUI, "Cancel", Color3.fromRGB(200, 50, 50), function()
        pcall(function()
            TmpColorData = GlobalState.MainColor
            StrCUIB.Color = TmpColorData
            LblCUIT.TextColor3 = TmpColorData
        end)
    end, nil)

    CreateDualSwitchMenu(PageObjSettings, "Performance Mode (HP Kentang)", "PerformanceMode")

    local tpWalkingStateFly = false
    local FlyBVIns = nil
    local FlyBGIns = nil

    RunServiceAPI.RenderStepped:Connect(function()
        pcall(function()
            if GlobalState.Fly then
                if not tpWalkingStateFly then
                    local charFly1 = LocalPlayerInstance.Character
                    local humFly1 = nil
                    local rootFly1 = nil
                    local torsoFly1 = nil
                    
                    if charFly1 then
                        humFly1 = charFly1:FindFirstChildWhichIsA("Humanoid")
                        rootFly1 = charFly1:FindFirstChild("HumanoidRootPart")
                        torsoFly1 = charFly1:FindFirstChild("Torso")
                        if not torsoFly1 then
                            torsoFly1 = charFly1:FindFirstChild("UpperTorso")
                        end
                    end
                    
                    local hasAllFly1 = false
                    if humFly1 then
                        if rootFly1 then
                            if torsoFly1 then
                                hasAllFly1 = true
                            end
                        end
                    end
                    
                    if hasAllFly1 then
                        tpWalkingStateFly = true
                        if FlyBVIns then 
                            FlyBVIns:Destroy() 
                        end
                        if FlyBGIns then 
                            FlyBGIns:Destroy() 
                        end
                        
                        FlyBGIns = Instance.new("BodyGyro")
                        FlyBGIns.Parent = torsoFly1
                        FlyBGIns.P = 9e4
                        FlyBGIns.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                        
                        FlyBVIns = Instance.new("BodyVelocity")
                        FlyBVIns.Parent = torsoFly1
                        FlyBVIns.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        
                        humFly1.PlatformStand = true
                        local animCharFly = charFly1:FindFirstChild("Animate")
                        if animCharFly then
                            animCharFly.Disabled = true
                        end
                        
                        for _, trackFlyT in pairs(humFly1:GetPlayingAnimationTracks()) do
                            trackFlyT:Stop()
                        end
                    end
                end
            end
            
            if not GlobalState.Fly then
                if tpWalkingStateFly then
                    tpWalkingStateFly = false
                    if FlyBVIns then 
                        FlyBVIns:Destroy() 
                    end
                    if FlyBGIns then 
                        FlyBGIns:Destroy() 
                    end
                    
                    local charFly2 = LocalPlayerInstance.Character
                    if charFly2 then
                        local humFly2 = charFly2:FindFirstChildWhichIsA("Humanoid")
                        if humFly2 then 
                            humFly2.PlatformStand = false 
                            humFly2:ChangeState(Enum.HumanoidStateType.GettingUp) 
                        end
                        local animCharFly2 = charFly2:FindFirstChild("Animate")
                        if animCharFly2 then 
                            animCharFly2.Disabled = false 
                        end
                    end
                end
            end

            if GlobalState.Fly then
                if tpWalkingStateFly then
                    if FlyBVIns then
                        if FlyBGIns then
                            local charFly3 = LocalPlayerInstance.Character
                            local humFly3 = nil
                            if charFly3 then
                                humFly3 = charFly3:FindFirstChild("Humanoid")
                            end
                            
                            if humFly3 then
                                FlyBGIns.CFrame = CameraInstance.CFrame
                                local moveDirFly = humFly3.MoveDirection
                                
                                if moveDirFly.Magnitude > 0 then
                                    local cLookXFly = CameraInstance.CFrame.LookVector.X
                                    local cLookZFly = CameraInstance.CFrame.LookVector.Z
                                    local camLookFlatFly = Vector3.new(cLookXFly, 0, cLookZFly).Unit
                                    
                                    local cRightXFly = CameraInstance.CFrame.RightVector.X
                                    local cRightZFly = CameraInstance.CFrame.RightVector.Z
                                    local camRightFlatFly = Vector3.new(cRightXFly, 0, cRightZFly).Unit
                                    
                                    local fwdMoveFly = moveDirFly:Dot(camLookFlatFly)
                                    local rgtMoveFly = moveDirFly:Dot(camRightFlatFly)
                                    
                                    local fwdVecFly = CameraInstance.CFrame.LookVector * fwdMoveFly
                                    local rgtVecFly = CameraInstance.CFrame.RightVector * rgtMoveFly
                                    local flyDirFly = fwdVecFly + rgtVecFly
                                    
                                    if flyDirFly.Magnitude > 0 then 
                                        flyDirFly = flyDirFly.Unit 
                                    end
                                    
                                    FlyBVIns.Velocity = flyDirFly * (GlobalState.FlySpeed * 50)
                                end
                                if moveDirFly.Magnitude <= 0 then
                                    FlyBVIns.Velocity = Vector3.new(0, 0, 0)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)

    local EspDataStorage = {}
    local isHasDrawingApi = false
    pcall(function() 
        local testLineDr = Drawing.new("Line") 
        isHasDrawingApi = true
        testLineDr:Remove()
    end)

    local FOVCircleInst = nil
    if isHasDrawingApi then
        pcall(function()
            FOVCircleInst = Drawing.new("Circle")
            FOVCircleInst.Color = Color3.fromRGB(255, 255, 255)
            FOVCircleInst.Thickness = 1.5
            FOVCircleInst.Filled = false
            FOVCircleInst.Transparency = 1
        end)
    end

    local function GetClosestPlayerLogic()
        local targetPlr = nil
        pcall(function()
            local shortDistPlr = GlobalState.Aim_FOVSize
            local centerScreenPlr = Vector2.new(CameraInstance.ViewportSize.X / 2, CameraInstance.ViewportSize.Y / 2)
            
            for _, pPlrLoop in pairs(PlayersService:GetPlayers()) do
                local isValidTargetPlr = false
                if pPlrLoop ~= LocalPlayerInstance then
                    local charPPlr = pPlrLoop.Character
                    if charPPlr then
                        local pHumPPlr = charPPlr:FindFirstChild("Humanoid")
                        local pPartPPlr = charPPlr:FindFirstChild(GlobalState.Aim_Part)
                        if pHumPPlr then
                            if pHumPPlr.Health > 0 then
                                if pPartPPlr then
                                    isValidTargetPlr = true
                                end
                            end
                        end
                    end
                end
                
                if isValidTargetPlr then
                    local partPosPPlr = pPlrLoop.Character[GlobalState.Aim_Part].Position
                    local vPPlr, onSPPlr = CameraInstance:WorldToViewportPoint(partPosPPlr)
                    if onSPPlr then
                        local vecDistPPlr = Vector2.new(vPPlr.X, vPPlr.Y) - centerScreenPlr
                        local dMagPPlr = vecDistPPlr.Magnitude
                        if dMagPPlr < shortDistPlr then
                            targetPlr = pPlrLoop
                            shortDistPlr = dMagPPlr 
                        end
                    end
                end
            end
        end)
        return targetPlr
    end

    local OldNamecallHk = nil
    pcall(function()
        if type(getnamecallmethod) == "function" then
            if type(hookmetamethod) == "function" then
                OldNamecallHk = hookmetamethod(game, "__namecall", function(selfParam, ...)
                    local methodHk = getnamecallmethod()
                    local argsHk = {...}
                    
                    local isOkHk = false
                    if GlobalState.Aimbot then
                        if GlobalState.SilentAim then
                            if type(checkcaller) == "function" then
                                if not checkcaller() then
                                    isOkHk = true
                                end
                            end
                        end
                    end
                    
                    if isOkHk then
                        local isFindHk = false
                        if methodHk == "FindPartOnRayWithIgnoreList" then
                            isFindHk = true
                        end
                        if methodHk == "Raycast" then
                            isFindHk = true
                        end
                        
                        if isFindHk then
                            local closestHk = GetClosestPlayerLogic()
                            if closestHk then
                                local charHk = closestHk.Character
                                if charHk then
                                    local cPartHk = charHk:FindFirstChild(GlobalState.Aim_Part)
                                    if cPartHk then
                                        local targetPosHk = charHk[GlobalState.Aim_Part].Position
                                        
                                        if methodHk == "Raycast" then
                                            local originHk1 = argsHk[1]
                                            argsHk[2] = (targetPosHk - originHk1).Unit * 1000
                                            return OldNamecallHk(selfParam, unpack(argsHk))
                                        end
                                        
                                        if methodHk == "FindPartOnRayWithIgnoreList" then
                                            local originHk2 = argsHk[1].Origin
                                            argsHk[1] = Ray.new(originHk2, (targetPosHk - originHk2).Unit * 1000)
                                            return OldNamecallHk(selfParam, unpack(argsHk))
                                        end
                                    end
                                end
                            end
                        end
                    end
                    return OldNamecallHk(selfParam, ...)
                end)
            end
        end
    end)

    local function CreateESPLogic(playerEsp)
        pcall(function()
            local espTb = {}
            espTb.Highlight = Instance.new("Highlight")
            espTb.Highlight.FillColor = Color3.fromRGB(255, 50, 50)
            espTb.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            espTb.Highlight.FillTransparency = 0.5
            espTb.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            
            if isHasDrawingApi then
                espTb.Tracer = Drawing.new("Line")
                espTb.Tracer.Thickness = 1.5
                espTb.Tracer.Color = Color3.fromRGB(255, 255, 255)
                
                espTb.Box = Drawing.new("Square")
                espTb.Box.Thickness = 1.5
                espTb.Box.Color = Color3.fromRGB(255, 50, 50)
                espTb.Box.Filled = false
                
                espTb.HealthBg = Drawing.new("Line")
                espTb.HealthBg.Thickness = 3
                espTb.HealthBg.Color = Color3.fromRGB(0, 0, 0)
                
                espTb.HealthFill = Drawing.new("Line")
                espTb.HealthFill.Thickness = 1.5
                espTb.HealthFill.Color = Color3.fromRGB(0, 255, 100)
                
                espTb.Text = Drawing.new("Text")
                espTb.Text.Size = 14
                espTb.Text.Color = Color3.fromRGB(255, 255, 255)
                espTb.Text.Center = true
                espTb.Text.Outline = true
            end
            EspDataStorage[playerEsp] = espTb
        end)
    end

    local function RemoveESPLogic(playerEspRm)
        pcall(function()
            local espP = EspDataStorage[playerEspRm]
            if espP then
                if espP.Highlight then 
                    espP.Highlight:Destroy() 
                end
                if isHasDrawingApi then
                    espP.Tracer:Remove()
                    espP.Box:Remove()
                    espP.HealthBg:Remove()
                    espP.HealthFill:Remove()
                    espP.Text:Remove()
                end
                EspDataStorage[playerEspRm] = nil
            end
        end)
    end
    
    PlayersService.PlayerRemoving:Connect(RemoveESPLogic)

    RunServiceAPI.RenderStepped:Connect(function()
        pcall(function()
            if CameraInstance then
                if CameraInstance.FieldOfView ~= GlobalState.POV then
                    CameraInstance.FieldOfView = GlobalState.POV 
                end
            end

            local cxCam = 0
            local cyCam = 0
            if CameraInstance then
                cxCam = CameraInstance.ViewportSize.X / 2
                cyCam = CameraInstance.ViewportSize.Y / 2
            end
            local centerScreenCam = Vector2.new(cxCam, cyCam)
            
            if FOVCircleInst then
                FOVCircleInst.Position = centerScreenCam
                FOVCircleInst.Radius = GlobalState.Aim_FOVSize
                local combStFov = false
                if GlobalState.Aimbot then
                    if GlobalState.Aim_ShowFOV then
                        combStFov = true
                    end
                end
                
                if combStFov then
                    FOVCircleInst.Visible = true
                end
                if not combStFov then
                    FOVCircleInst.Visible = false
                end
            end
            
            local canAimM = false
            if GlobalState.Aimbot then
                if not GlobalState.SilentAim then
                    canAimM = true
                end
            end
            
            if canAimM then
                local targetM = GetClosestPlayerLogic()
                if targetM then 
                    local pPartPosM = targetM.Character[GlobalState.Aim_Part].Position
                    CameraInstance.CFrame = CameraInstance.CFrame:Lerp(CFrame.new(CameraInstance.CFrame.Position, pPartPosM), 0.2) 
                end
            end

            if GlobalState.ESP then
                for _, playerM in pairs(PlayersService:GetPlayers()) do
                    if playerM ~= LocalPlayerInstance then
                        local charM = playerM.Character
                        local rootM = nil
                        local headM = nil
                        local humM = nil
                        
                        if charM then
                            rootM = charM:FindFirstChild("HumanoidRootPart")
                            headM = charM:FindFirstChild("Head")
                            humM = charM:FindFirstChild("Humanoid")
                        end
                        
                        local isOkCM = false
                        if charM then
                            if rootM then
                                if headM then
                                    if humM then
                                        if humM.Health > 0 then
                                            isOkCM = true
                                        end
                                    end
                                end
                            end
                        end
                        
                        if isOkCM then
                            if not EspDataStorage[playerM] then
                                CreateESPLogic(playerM) 
                            end
                            local espM = EspDataStorage[playerM]
                            
                            if GlobalState.ESP_Chams then
                                if espM.Highlight.Parent ~= charM then
                                    espM.Highlight.Parent = charM 
                                end
                            end
                            if not GlobalState.ESP_Chams then
                                if espM.Highlight.Parent then
                                    espM.Highlight.Parent = nil 
                                end
                            end
                            
                            if isHasDrawingApi then
                                local rootPosM, onScreenM = CameraInstance:WorldToViewportPoint(rootM.Position)
                                local headPosM, zGarbage1 = CameraInstance:WorldToViewportPoint(headM.Position + Vector3.new(0, 0.5, 0))
                                local legPosM, zGarbage2 = CameraInstance:WorldToViewportPoint(rootM.Position - Vector3.new(0, 3, 0))
                                
                                if onScreenM then
                                    local boxHeightM = math.abs(headPosM.Y - legPosM.Y)
                                    local boxWidthM = boxHeightM / 2
                                    
                                    espM.Box.Size = Vector2.new(boxWidthM, boxHeightM)
                                    espM.Box.Position = Vector2.new(rootPosM.X - boxWidthM / 2, headPosM.Y)
                                    espM.Box.Visible = GlobalState.ESP_Box
                                    
                                    espM.Tracer.From = Vector2.new(cxCam, CameraInstance.ViewportSize.Y)
                                    espM.Tracer.To = Vector2.new(rootPosM.X, legPosM.Y)
                                    espM.Tracer.Visible = GlobalState.ESP_Tracer
                                    
                                    local hpM = humM.Health / humM.MaxHealth
                                    local hhM = boxHeightM * hpM
                                    
                                    espM.HealthBg.From = Vector2.new(espM.Box.Position.X - 5, legPosM.Y)
                                    espM.HealthBg.To = Vector2.new(espM.Box.Position.X - 5, headPosM.Y)
                                    espM.HealthBg.Visible = GlobalState.ESP_Health
                                    
                                    espM.HealthFill.From = Vector2.new(espM.Box.Position.X - 5, legPosM.Y)
                                    espM.HealthFill.To = Vector2.new(espM.Box.Position.X - 5, legPosM.Y - hhM)
                                    espM.HealthFill.Color = Color3.fromRGB(255 - (hpM * 255), hpM * 255, 0)
                                    espM.HealthFill.Visible = GlobalState.ESP_Health
                                    
                                    local distMathM = math.floor((CameraInstance.CFrame.Position - rootM.Position).Magnitude)
                                    espM.Text.Text = playerM.DisplayName .. " [" .. distMathM .. "m]"
                                    espM.Text.Position = Vector2.new(rootPosM.X, headPosM.Y - 20)
                                    espM.Text.Visible = GlobalState.ESP_Name
                                end
                                if not onScreenM then
                                    espM.Box.Visible = false
                                    espM.Tracer.Visible = false
                                    espM.HealthBg.Visible = false
                                    espM.HealthFill.Visible = false
                                    espM.Text.Visible = false
                                end
                            end
                        end
                        
                        if not isOkCM then
                            local espPMFail = EspDataStorage[playerM]
                            if espPMFail then
                                if espPMFail.Highlight then 
                                    espPMFail.Highlight.Parent = nil 
                                end
                                if isHasDrawingApi then 
                                    espPMFail.Box.Visible = false
                                    espPMFail.Tracer.Visible = false
                                    espPMFail.HealthBg.Visible = false
                                    espPMFail.HealthFill.Visible = false
                                    espPMFail.Text.Visible = false 
                                end
                            end
                        end
                    end
                end
            end
            if not GlobalState.ESP then
                for playerRm, _ in pairs(EspDataStorage) do 
                    RemoveESPLogic(playerRm) 
                end
            end
        end)
    end)

    local flingBavInst = nil
    local flingV3ConnInst = nil

    RunServiceAPI.RenderStepped:Connect(function()
        pcall(function()
            local charFlgRs = LocalPlayerInstance.Character
            local hrpFlgRs = nil
            if charFlgRs then
                hrpFlgRs = charFlgRs:FindFirstChild("HumanoidRootPart")
            end
            
            local isFlingOnRs = false
            if GlobalState.FlingV2 then
                isFlingOnRs = true
            end
            if GlobalState.SuperFling then
                isFlingOnRs = true
            end
            
            if isFlingOnRs then
                if hrpFlgRs then
                    if not flingBavInst then
                        flingBavInst = Instance.new("BodyAngularVelocity")
                        flingBavInst.Name = "XayzFling"
                        flingBavInst.MaxTorque = Vector3.new(0, math.huge, 0)
                        flingBavInst.P = math.huge
                        flingBavInst.Parent = hrpFlgRs
                    end
                    
                    if GlobalState.SuperFling then
                        flingBavInst.AngularVelocity = Vector3.new(0, 999999, 0)
                    end
                    if not GlobalState.SuperFling then
                        flingBavInst.AngularVelocity = Vector3.new(0, GlobalState.FlingPower * 100, 0)
                    end
                end
            end
            if not isFlingOnRs then
                if flingBavInst then
                    flingBavInst:Destroy()
                    flingBavInst = nil
                end
                if hrpFlgRs then
                    hrpFlgRs.RotVelocity = Vector3.new(0, 0, 0)
                end
            end

            if GlobalState.FlingV3 then
                if hrpFlgRs then
                    if not flingV3ConnInst then
                        for _, vFlgV3 in pairs(charFlgRs:GetDescendants()) do
                            if vFlgV3:IsA("BasePart") then
                                vFlgV3.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
                            end
                        end
                        flingV3ConnInst = hrpFlgRs.Touched:Connect(function(hitFlgV3)
                            pcall(function()
                                if hitFlgV3.Parent then
                                    if hitFlgV3.Parent:FindFirstChild("Humanoid") then
                                        if hitFlgV3.Parent.Name ~= LocalPlayerInstance.Name then
                                            local vRootFlgV3 = hitFlgV3.Parent:FindFirstChild("HumanoidRootPart")
                                            if vRootFlgV3 then
                                                vRootFlgV3.Velocity = Vector3.new(999999999, 999999999, 999999999)
                                            end
                                        end
                                    end
                                end
                            end)
                        end)
                    end
                end
            end
            if not GlobalState.FlingV3 then
                if flingV3ConnInst then
                    flingV3ConnInst:Disconnect()
                    flingV3ConnInst = nil
                end
            end
        end)
    end)

    RunServiceAPI.Heartbeat:Connect(function()
        pcall(function()
            local charMisc = LocalPlayerInstance.Character
            if charMisc then
                local humMisc = charMisc:FindFirstChildOfClass("Humanoid")
                if humMisc then
                    if GlobalState.HealLoop then
                        humMisc.Health = humMisc.MaxHealth
                    end
                    if GlobalState.GodModeV4 then
                        humMisc.MaxHealth = math.huge
                        humMisc.Health = math.huge
                    end
                    
                    local wScM = humMisc:FindFirstChild("BodyWidthScale")
                    local dScM = humMisc:FindFirstChild("BodyDepthScale")
                    local isScValidM = false
                    if wScM then
                        if dScM then
                            isScValidM = true
                        end
                    end
                    
                    if isScValidM then
                        wScM.Value = GlobalState.WideAvatar
                        dScM.Value = GlobalState.WideAvatar
                    end
                end
            end
        end)
    end)

    local bhAngleLogic = 1
    local AnchorPartLogic = nil
    local AnchorAttLogic = nil

    local function GetAnchorSetupLogic()
        pcall(function()
            local isValAnc = false
            if AnchorPartLogic then
                if AnchorPartLogic.Parent then
                    isValAnc = true
                end
            end
            if not isValAnc then
                local fNewAnc = Instance.new("Folder")
                fNewAnc.Parent = WorkspaceService
                AnchorPartLogic = Instance.new("Part")
                AnchorPartLogic.Name = "XayzAnchor"
                AnchorPartLogic.Anchored = true
                AnchorPartLogic.CanCollide = false
                AnchorPartLogic.Transparency = 1
                AnchorPartLogic.Parent = fNewAnc
                
                AnchorAttLogic = Instance.new("Attachment")
                AnchorAttLogic.Parent = AnchorPartLogic
            end
        end)
        return AnchorPartLogic, AnchorAttLogic
    end

    task.spawn(function()
        pcall(function()
            RunServiceAPI.Heartbeat:Connect(function()
                pcall(function()
                    if type(sethiddenproperty) == "function" then
                        sethiddenproperty(LocalPlayerInstance, "SimulationRadius", math.huge)
                    end
                end)
            end)
        end)
    end)

    local dinoAnimR15Ins = Instance.new("Animation")
    dinoAnimR15Ins.AnimationId = "rbxassetid://204062532"

    local dinoAnimR6Ins = Instance.new("Animation")
    dinoAnimR6Ins.AnimationId = "rbxassetid://20432871"

    local punchAnimationIns = Instance.new("Animation")
    punchAnimationIns.AnimationId = "rbxassetid://84674780"

    local dTrackIns = nil
    local pTrackIns = nil
    local hdFiredSt = false

    local function ForcePartBHLogic(vPartBH, aAttBH)
        pcall(function()
            if vPartBH:IsA("Part") then
                if not vPartBH.Anchored then
                    local pntBH = vPartBH.Parent
                    local fHumBH = nil
                    local fHdBH = nil
                    if pntBH then
                        fHumBH = pntBH:FindFirstChild("Humanoid")
                        fHdBH = pntBH:FindFirstChild("Head")
                    end
                    if not fHumBH then
                        if not fHdBH then
                            if vPartBH.Name ~= "Handle" then
                                for _, xBH in pairs(vPartBH:GetChildren()) do
                                    local delBH = false
                                    if xBH:IsA("BodyAngularVelocity") then delBH = true end
                                    if xBH:IsA("BodyForce") then delBH = true end
                                    if xBH:IsA("BodyGyro") then delBH = true end
                                    if xBH:IsA("BodyPosition") then delBH = true end
                                    if xBH:IsA("BodyThrust") then delBH = true end
                                    if xBH:IsA("BodyVelocity") then delBH = true end
                                    if xBH:IsA("RocketPropulsion") then delBH = true end
                                    if delBH then
                                        xBH:Destroy()
                                    end
                                end
                                if vPartBH:FindFirstChild("Attachment") then
                                    vPartBH:FindFirstChild("Attachment"):Destroy()
                                end
                                if vPartBH:FindFirstChild("AlignPosition") then
                                    vPartBH:FindFirstChild("AlignPosition"):Destroy()
                                end
                                if vPartBH:FindFirstChild("Torque") then
                                    vPartBH:FindFirstChild("Torque"):Destroy()
                                end
                                
                                vPartBH.CanCollide = false
                                vPartBH.Massless = true
                                
                                local tqBH = Instance.new("Torque")
                                tqBH.Parent = vPartBH
                                tqBH.Torque = Vector3.new(1000000, 1000000, 1000000)
                                
                                local alBH = Instance.new("AlignPosition")
                                alBH.Parent = vPartBH
                                local a2BH = Instance.new("Attachment")
                                a2BH.Parent = vPartBH
                                tqBH.Attachment0 = a2BH
                                
                                alBH.MaxForce = math.huge
                                alBH.MaxVelocity = math.huge
                                alBH.Responsiveness = 500
                                alBH.Attachment0 = a2BH
                                alBH.Attachment1 = aAttBH
                            end
                        end
                    end
                end
            end
        end)
    end

    RunServiceAPI.Heartbeat:Connect(function()
        pcall(function()
            local charHb = LocalPlayerInstance.Character
            if not charHb then 
                return 
            end
            
            local armJointHb = nil
            local isR15Hb = false
            if charHb:FindFirstChild("UpperTorso") then
                isR15Hb = true
            end
            
            if isR15Hb then
                local rArmHb = charHb:FindFirstChild("RightUpperArm")
                if rArmHb then 
                    armJointHb = rArmHb:FindFirstChild("RightShoulder")
                end
            end
            if not isR15Hb then
                local torsoHb = charHb:FindFirstChild("Torso")
                if torsoHb then 
                    armJointHb = torsoHb:FindFirstChild("Right Shoulder")
                end
            end

            if armJointHb then
                local attC0Hb = armJointHb:GetAttribute("OriginalC0")
                if not attC0Hb then
                    attC0Hb = armJointHb.C0
                    armJointHb:SetAttribute("OriginalC0", attC0Hb)
                end

                if GlobalState.ArmAnim then
                    local moveHb = math.sin(tick() * GlobalState.ArmSpeed) * GlobalState.ArmIntensity
                    if isR15Hb then
                        local cfCHb1 = attC0Hb * CFrame.new(0, moveHb, -0.5)
                        armJointHb.C0 = cfCHb1 * CFrame.Angles(math.rad(-90), 0, 0)
                    end
                    if not isR15Hb then
                        local cfCHb2 = attC0Hb * CFrame.new(-0.2, moveHb, -0.5)
                        armJointHb.C0 = cfCHb2 * CFrame.Angles(math.rad(-90), math.rad(20), 0)
                    end
                end
                if not GlobalState.ArmAnim then
                    armJointHb.C0 = attC0Hb
                end
            end
            
            if GlobalState.HDAdmin then
                if not hdFiredSt then
                    local hdCHb = ReplicatedStorageAPI:FindFirstChild("HDAdminClient")
                    if hdCHb then
                        pcall(function()
                            local psPlHb = LocalPlayerInstance.PlayerScripts
                            local hdC2Hb = psPlHb:WaitForChild("HDAdminClient")
                            local mainWHb = hdC2Hb:WaitForChild("Main")
                            local mainModuleHb = require(mainWHb)
                            mainModuleHb.Settings.Rank = 5
                            mainModuleHb.Settings.RankName = "The King Xayz"
                            
                            local remoteHb = ReplicatedStorageAPI:FindFirstChild("HDAdminRemote")
                            if remoteHb then
                                remoteHb:FireServer("Rank", LocalPlayerInstance, 5) 
                            end
                        end)
                    end
                    hdFiredSt = true
                end
            end
            if not GlobalState.HDAdmin then
                hdFiredSt = false
            end
            
            local humHb = charHb:FindFirstChild("Humanoid")
            if humHb then
                local isDPlyHb = false
                if dTrackIns then
                    if dTrackIns.IsPlaying then
                        isDPlyHb = true
                    end
                end
                
                if GlobalState.DinoAnim then
                    if not isDPlyHb then
                        if humHb.RigType == Enum.HumanoidRigType.R15 then
                            dTrackIns = humHb:LoadAnimation(dinoAnimR15Ins)
                        end
                        if humHb.RigType ~= Enum.HumanoidRigType.R15 then
                            dTrackIns = humHb:LoadAnimation(dinoAnimR6Ins)
                        end
                        dTrackIns:Play()
                    end
                end
                if not GlobalState.DinoAnim then
                    if isDPlyHb then
                        dTrackIns:Stop()
                    end
                end

                local isPPlyHb = false
                if pTrackIns then
                    if pTrackIns.IsPlaying then
                        isPPlyHb = true
                    end
                end
                
                if GlobalState.PunchAnim then
                    if not isPPlyHb then
                        pTrackIns = humHb:LoadAnimation(punchAnimationIns)
                        pTrackIns:Play()
                    end
                end
                if not GlobalState.PunchAnim then
                    if isPPlyHb then
                        pTrackIns:Stop()
                    end
                end
            end

            local hrpHb = charHb:FindFirstChild("HumanoidRootPart")
            if not hrpHb then 
                return 
            end

            if GlobalState.ForceField then
                if not charHb:FindFirstChild("XayzFF") then
                    local ffNHb = Instance.new("ForceField")
                    ffNHb.Name = "XayzFF"
                    ffNHb.Visible = true
                    ffNHb.Parent = charHb
                end
            end
            if not GlobalState.ForceField then
                if charHb:FindFirstChild("XayzFF") then 
                    charHb:FindFirstChild("XayzFF"):Destroy() 
                end
            end

            local ancPtHb, ancAttHb = GetAnchorSetupLogic()

            if GlobalState.Blackhole then
                for _, vHb in pairs(WorkspaceService:GetDescendants()) do
                    ForcePartBHLogic(vHb, ancAttHb)
                end
                
                bhAngleLogic = bhAngleLogic + math.rad(2)
                
                local offXHb = math.cos(bhAngleLogic) * GlobalState.BlackholeDistance
                local offZHb = math.sin(bhAngleLogic) * GlobalState.BlackholeDistance
                
                ancAttHb.WorldCFrame = hrpHb.CFrame * CFrame.new(offXHb, 0, offZHb)
            end
            
            if GlobalState.SuperRing then
                local tCenterHb = hrpHb.Position
                local unPartsHb = {}
                for _, vHb2 in pairs(WorkspaceService:GetDescendants()) do
                    if vHb2:IsA("BasePart") then
                        if not vHb2.Anchored then
                            local pntHb2 = vHb2.Parent
                            local fHumHb2 = nil
                            if pntHb2 then
                                fHumHb2 = pntHb2:FindFirstChild("Humanoid")
                            end
                            if not fHumHb2 then
                                local fHdHb2 = nil
                                if pntHb2 then
                                    fHdHb2 = pntHb2:FindFirstChild("Head")
                                end
                                if not fHdHb2 then
                                    if vHb2.Name ~= "Handle" then
                                        local isLpHb2 = false
                                        if pntHb2 == LocalPlayerInstance.Character then
                                            isLpHb2 = true
                                        end
                                        if LocalPlayerInstance.Character then
                                            if vHb2:IsDescendantOf(LocalPlayerInstance.Character) then
                                                isLpHb2 = true
                                            end
                                        end
                                        if not isLpHb2 then
                                            table.insert(unPartsHb, vHb2)
                                            
                                            if vHb2:FindFirstChild("AlignPosition") then
                                                vHb2:FindFirstChild("AlignPosition"):Destroy()
                                            end
                                            if vHb2:FindFirstChild("Torque") then
                                                vHb2:FindFirstChild("Torque"):Destroy()
                                            end
                                            local atCHb2 = vHb2:FindFirstChildOfClass("Attachment")
                                            if atCHb2 then
                                                if not atCHb2:FindFirstChildOfClass("AlignPosition") then
                                                    atCHb2:Destroy()
                                                end
                                            end
                                            
                                            vHb2.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
                                            vHb2.CanCollide = false
                                            vHb2.Massless = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                local tPartsHb = #unPartsHb
                for _, ptHb in pairs(unPartsHb) do
                    local ptPosHb = ptHb.Position
                    local vXZHb = Vector3.new(ptPosHb.X, tCenterHb.Y, ptPosHb.Z)
                    local distHb = (vXZHb - tCenterHb).Magnitude
                    
                    local atanHb = math.atan2(ptPosHb.Z - tCenterHb.Z, ptPosHb.X - tCenterHb.X)
                    local newAngHb = atanHb + math.rad(GlobalState.RingSpeed)
                    
                    local minDHb = math.min(GlobalState.RingDistance, distHb)
                    local tXHb = tCenterHb.X + (math.cos(newAngHb) * minDHb)
                    
                    local hDivHb = (ptPosHb.Y - tCenterHb.Y) / GlobalState.RingHeight
                    local hMultHb = GlobalState.RingHeight * math.abs(math.sin(hDivHb))
                    local tYHb = tCenterHb.Y + hMultHb
                    
                    local tZHb = tCenterHb.Z + (math.sin(newAngHb) * minDHb)
                    
                    local tarPosHb = Vector3.new(tXHb, tYHb, tZHb)
                    ptHb.Velocity = (tarPosHb - ptPosHb).Unit * GlobalState.RingAttraction
                end
            end
            
            local offAllHb = false
            if not GlobalState.Blackhole then
                if not GlobalState.SuperRing then
                    offAllHb = true
                end
            end
            
            if offAllHb then
                for _, vHb3 in pairs(WorkspaceService:GetDescendants()) do
                    if vHb3:IsA("Part") then
                        if vHb3:FindFirstChild("AlignPosition") then
                            vHb3:FindFirstChild("AlignPosition"):Destroy()
                            if vHb3:FindFirstChild("Torque") then 
                                vHb3:FindFirstChild("Torque"):Destroy() 
                            end
                        end
                    end
                end
                local fAncHb = WorkspaceService:FindFirstChild("XayzAnchor")
                if fAncHb then
                    fAncHb.CFrame = CFrame.new(0, -1000, 0)
                end
            end
        end)
    end)
end

pcall(function()
    SafeExecuteScript()
end)