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
        GlobalState.RingSpeed = 40
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
            if readfile then
                isReadFileValid = true
            end
            local isIsFileValid = false
            if isfile then
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
            if writefile then
                isWriteFileValid = true
            end
            if isWriteFileValid then
                local encodedJsonData = HttpServiceAPI:JSONEncode(configDataTable)
                writefile(ConfigFileNameTarget, encodedJsonData)
            end
        end)
    end

    local function FireAllRemoteEventsFallback(keywordTarget, argumentsTable)
        local successFireAll, errorFireAll = pcall(function()
            local workspaceDescendants = WorkspaceService:GetDescendants()
            for indexWs, objectWs in pairs(workspaceDescendants) do
                local isRemoteWs = objectWs:IsA("RemoteEvent")
                if isRemoteWs then
                    local objectNameWs = objectWs.Name
                    local lowerNameWs = string.lower(objectNameWs)
                    local isMatchWs = string.find(lowerNameWs, keywordTarget)
                    if isMatchWs then
                        local successFireWs, errorFireWs = pcall(function()
                            objectWs:FireServer(unpack(argumentsTable))
                        end)
                    end
                end
            end
            
            local repDescendants = ReplicatedStorageAPI:GetDescendants()
            for indexRep, objectRep in pairs(repDescendants) do
                local isRemoteRep = objectRep:IsA("RemoteEvent")
                if isRemoteRep then
                    local objectNameRep = objectRep.Name
                    local lowerNameRep = string.lower(objectNameRep)
                    local isMatchRep = string.find(lowerNameRep, keywordTarget)
                    if isMatchRep then
                        local successFireRep, errorFireRep = pcall(function()
                            objectRep:FireServer(unpack(argumentsTable))
                        end)
                    end
                end
            end
        end)
    end

    local GlobalEnvironment = nil
    local successGenv, errorGenv = pcall(function()
        local isGetGenvValid = false
        if getgenv then
            isGetGenvValid = true
        end
        if isGetGenvValid then
            local genvAPI = getgenv()
            GlobalEnvironment = genvAPI
        end
    end)
    local isGenvNil = false
    if not GlobalEnvironment then
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
                            if sethiddenproperty then
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
            if gethui then
                isGetHuiValid = true
            end
            if isGetHuiValid then
                local huiResult = gethui()
                targetParentGui = huiResult
            end
            local isNotGetHuiValid = false
            if not gethui then
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
            if displayDuration then
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
        lblHead.Text = "XAYZ LITE X"

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
                if ldStrDk then
                    local urlDk = "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua"
                    local httpResDk = game:HttpGet(urlDk)
                    local execFuncDk = ldStrDk(httpResDk)
                    execFuncDk()
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
    local BtnWld1 = CreateButtonMenu(PageObjWorld, "Get Obliterator Tool", cPrpWld, function()
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
                if geF3X then
                    local gExF3X = geF3X()
                    impF3X = gExF3X.import
                end
                local isNotImpF3X = false
                if not impF3X then
                    isNotImpF3X = true
                end
                if isNotImpF3X then
                    impF3X = import
                end
                
                if impF3X then 
                    local nmF3X = LocalPlayerInstance.Name
                    local exF3X = impF3X(12158566951)
                    exF3X(nmF3X)
                end
            end)
            
            local succLocF3X, errLocF3X = pcall(function()
                local objF3XList = game:GetObjects("rbxassetid://22484922")
                local objF3XMain = objF3XList[1]
                local bpF3X = LocalPlayerInstance.Backpack
                objF3XMain.Parent = bpF3X
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
                if geBt then
                    local gExBt = geBt()
                    impBt = gExBt.import
                end
                local isNotImpBt = false
                if not impBt then
                    isNotImpBt = true
                end
                if isNotImpBt then
                    impBt = import
                end
                
                if impBt then 
                    local nmBt = LocalPlayerInstance.Name
                    local exBt = impBt(16530393933)
                    exBt(nmBt)
                end
            end)
            
            local succLocBt, errLocBt = pcall(function()
                local cb1 = Instance.new("HopperBin")
                cb1.BinType = Enum.BinType.Clone
                local bpBt1 = LocalPlayerInstance.Backpack
                cb1.Parent = bpBt1
                
                local cb2 = Instance.new("HopperBin")
                cb2.BinType = Enum.BinType.Hammer
                local bpBt2 = LocalPlayerInstance.Backpack
                cb2.Parent = bpBt2
                
                local cb3 = Instance.new("HopperBin")
                cb3.BinType = Enum.BinType.Grab
                local bpBt3 = LocalPlayerInstance.Backpack
                cb3.Parent = bpBt3
            end)
            TriggerNotificationUI("Btools Loaded", "Check your inventory.", 2)
        end)
    end, nil)

    local function SetHDAdminRankSystem(rankIdInt, rankNameStr)
        local successSetHd, errorSetHd = pcall(function()
            local tbArgHd = {"Rank", LocalPlayerInstance, rankIdInt}
            FireAllRemoteEventsFallback("hdadmin", tbArgHd)
            
            local succModHd, errModHd = pcall(function()
                local hdGlob = GlobalEnvironment.HDAdminMain
                if hdGlob then
                    local modCFHd = hdGlob:GetModule("cf")
                    local crIdHd = game.CreatorId
                    modCFHd:SetRank(LocalPlayerInstance, crIdHd, rankIdInt, "Perm")
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
                if geAHd then
                    local gExAHd = geAHd()
                    impAHd = gExAHd.import
                end
                local isNotImpAHd = false
                if not impAHd then
                    isNotImpAHd = true
                end
                if isNotImpAHd then
                    impAHd = import
                end
                
                if impAHd then 
                    local exAHd = impAHd(4893870373)
                    local nmAHd = LocalPlayerInstance.Name
                    exAHd.load(nmAHd)
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
    FrameVMW.Parent = PageObjVM
    local cVMW = Color3.fromRGB(20, 21, 26)
    FrameVMW.BackgroundColor3 = cVMW
    local sVMW = UDim2.new(1, -5, 0, 250)
    FrameVMW.Size = sVMW
    local crVMW = Instance.new("UICorner")
    local rVMW = UDim.new(0, 8)
    crVMW.CornerRadius = rVMW
    crVMW.Parent = FrameVMW

    local FrameVMH = Instance.new("Frame")
    FrameVMH.Parent = FrameVMW
    local cVMH = Color3.fromRGB(30, 31, 36)
    FrameVMH.BackgroundColor3 = cVMH
    local sVMH = UDim2.new(1, 0, 0, 30)
    FrameVMH.Size = sVMH
    local crVMH = Instance.new("UICorner")
    local rVMH = UDim.new(0, 8)
    crVMH.CornerRadius = rVMH
    crVMH.Parent = FrameVMH

    local LblVMT = Instance.new("TextLabel")
    LblVMT.Parent = FrameVMH
    LblVMT.BackgroundTransparency = 1
    local pVMT = UDim2.new(0, 10, 0, 0)
    LblVMT.Position = pVMT
    local sVMT = UDim2.new(1, -20, 1, 0)
    LblVMT.Size = sVMT
    LblVMT.Font = Enum.Font.GothamBold
    LblVMT.Text = "🌐 VM"
    local cVMT = Color3.fromRGB(200, 220, 255)
    LblVMT.TextColor3 = cVMT
    LblVMT.TextSize = 12
    LblVMT.TextXAlignment = Enum.TextXAlignment.Left

    local FrameVMC = Instance.new("Frame")
    FrameVMC.Parent = FrameVMW
    local cVMC = Color3.fromRGB(255, 255, 255)
    FrameVMC.BackgroundColor3 = cVMC
    local pVMC = UDim2.new(0, 10, 0, 40)
    FrameVMC.Position = pVMC
    local sVMC = UDim2.new(1, -20, 1, -50)
    FrameVMC.Size = sVMC
    local crVMC = Instance.new("UICorner")
    local rVMC = UDim.new(0, 4)
    crVMC.CornerRadius = rVMC
    crVMC.Parent = FrameVMC

    local LblVMB = Instance.new("TextLabel")
    LblVMB.Parent = FrameVMC
    LblVMB.BackgroundTransparency = 1
    local sVMB = UDim2.new(1, 0, 1, 0)
    LblVMB.Size = sVMB
    LblVMB.Font = Enum.Font.Gotham
    LblVMB.Text = "Virtual Machine is OFF"
    local cVMB = Color3.fromRGB(100, 100, 100)
    LblVMB.TextColor3 = cVMB
    LblVMB.TextSize = 12
    LblVMB.TextWrapped = true

    local DropVMU = CreateDropdownMenu(PageObjVM, "Change User Agent")

    local cVMUA = Color3.fromRGB(50, 50, 50)
    local BtnVM1 = CreateButtonMenu(DropVMU, "Windows", cVMUA, function() 
        local successVMWin, errorVMWin = pcall(function()
            GlobalState.VM_UserAgent = "Windows" 
            SaveConfigurationData()
        end)
    end, nil)

    local BtnVM2 = CreateButtonMenu(DropVMU, "Android", cVMUA, function() 
        local successVMAnd, errorVMAnd = pcall(function()
            GlobalState.VM_UserAgent = "Android" 
            SaveConfigurationData()
        end)
    end, nil)

    local BtnVM3 = CreateButtonMenu(DropVMU, "Linux", cVMUA, function() 
        local successVMLin, errorVMLin = pcall(function()
            GlobalState.VM_UserAgent = "Linux" 
            SaveConfigurationData()
        end)
    end, nil)

    local DualVM1 = CreateDualSwitchMenu(PageObjVM, "Power ON/OFF", "VM_Power")

    local connRsVM = RunServiceAPI.RenderStepped:Connect(function()
        local successRsVM, errorRsVM = pcall(function()
            local isVmOn = GlobalState.VM_Power
            if isVmOn then
                local cVmcOn = Color3.fromRGB(240, 240, 240)
                FrameVMC.BackgroundColor3 = cVmcOn
                local curAg = GlobalState.VM_UserAgent
                local cmbStrVm = "Connected via " .. curAg .. " User-Agent."
                LblVMB.Text = cmbStrVm
                local cVmbOn = Color3.fromRGB(0, 0, 0)
                LblVMB.TextColor3 = cVmbOn
            end
            local isVmOff = false
            if not isVmOn then
                isVmOff = true
            end
            if isVmOff then
                local cVmcOff = Color3.fromRGB(30, 30, 30)
                FrameVMC.BackgroundColor3 = cVmcOff
                LblVMB.Text = "Virtual Machine is OFF"
                local cVmbOff = Color3.fromRGB(100, 100, 100)
                LblVMB.TextColor3 = cVmbOff
            end
        end)
    end)

    local ExecutorTabsData = {}
    local currentActiveTabId = 1
    local tabCounterTotal = 1
    local boxExecCode = nil
    local scrollTabs = nil

    local function RefreshTabsRender()
        local succRefresh, errRefresh = pcall(function()
            local scChildren = scrollTabs:GetChildren()
            for _, childC in pairs(scChildren) do
                local isBtnC = childC:IsA("Frame")
                if isBtnC then
                    childC:Destroy()
                end
            end
            
            for idTab, dataTab in ipairs(ExecutorTabsData) do
                local fTab = Instance.new("Frame")
                fTab.Parent = scrollTabs
                local sFTab = UDim2.new(0, 100, 0, 25)
                fTab.Size = sFTab
                
                local isActiveTab = false
                if currentActiveTabId == idTab then
                    isActiveTab = true
                end
                if isActiveTab then
                    local cFTabA = GlobalState.MainColor
                    fTab.BackgroundColor3 = cFTabA
                end
                local isNotActiveTab = false
                if not isActiveTab then
                    isNotActiveTab = true
                end
                if isNotActiveTab then
                    local cFTabN = Color3.fromRGB(40, 45, 60)
                    fTab.BackgroundColor3 = cFTabN
                end
                
                local crFTab = Instance.new("UICorner")
                local rFTab = UDim.new(0, 4)
                crFTab.CornerRadius = rFTab
                crFTab.Parent = fTab
                
                local btnSelTab = Instance.new("TextButton")
                btnSelTab.Parent = fTab
                btnSelTab.BackgroundTransparency = 1
                local pSelTab = UDim2.new(0, 0, 0, 0)
                btnSelTab.Position = pSelTab
                local sSelTab = UDim2.new(0.7, 0, 1, 0)
                btnSelTab.Size = sSelTab
                btnSelTab.Font = Enum.Font.GothamBold
                local txtSelTab = dataTab.Name
                btnSelTab.Text = txtSelTab
                local ctSelTab = Color3.fromRGB(255, 255, 255)
                btnSelTab.TextColor3 = ctSelTab
                btnSelTab.TextSize = 10
                
                local btnClsTab = Instance.new("TextButton")
                btnClsTab.Parent = fTab
                btnClsTab.BackgroundTransparency = 1
                local pClsTab = UDim2.new(0.7, 0, 0, 0)
                btnClsTab.Position = pClsTab
                local sClsTab = UDim2.new(0.3, 0, 1, 0)
                btnClsTab.Size = sClsTab
                btnClsTab.Font = Enum.Font.GothamBold
                btnClsTab.Text = "X"
                local ctClsTab = Color3.fromRGB(200, 100, 100)
                btnClsTab.TextColor3 = ctClsTab
                btnClsTab.TextSize = 10
                
                local connSelTab = btnSelTab.MouseButton1Click:Connect(function()
                    local succSelTabIn, errSelTabIn = pcall(function()
                        local currData = ExecutorTabsData[currentActiveTabId]
                        if currData then
                            local cbText = boxExecCode.Text
                            currData.Source = cbText
                        end
                        currentActiveTabId = idTab
                        local newData = ExecutorTabsData[currentActiveTabId]
                        if newData then
                            local nSource = newData.Source
                            boxExecCode.Text = nSource
                        end
                        RefreshTabsRender()
                    end)
                end)
                
                local connClsTabAct = btnClsTab.MouseButton1Click:Connect(function()
                    local succClsTabIn, errClsTabIn = pcall(function()
                        local totalTabs = #ExecutorTabsData
                        local isMoreThanOne = false
                        if totalTabs > 1 then
                            isMoreThanOne = true
                        end
                        if isMoreThanOne then
                            table.remove(ExecutorTabsData, idTab)
                            local isDelCurrent = false
                            if currentActiveTabId == idTab then
                                isDelCurrent = true
                            end
                            if isDelCurrent then
                                currentActiveTabId = 1
                                local defData = ExecutorTabsData[currentActiveTabId]
                                if defData then
                                    local dSource = defData.Source
                                    boxExecCode.Text = dSource
                                end
                            end
                            local isDelBefore = false
                            if idTab < currentActiveTabId then
                                isDelBefore = true
                            end
                            if isDelBefore then
                                currentActiveTabId = currentActiveTabId - 1
                            end
                            RefreshTabsRender()
                        end
                    end)
                end)
            end
        end)
    end

    local function SetupExecutorTabSystem()
        local successExecBuild, errExecBuild = pcall(function()
            local execDataInit = {}
            execDataInit.Name = "Script 1"
            execDataInit.Source = ""
            table.insert(ExecutorTabsData, execDataInit)
            
            local frameExecCont = Instance.new("Frame")
            frameExecCont.Parent = PageObjExecutor
            local cExecCont = Color3.fromRGB(20, 21, 26)
            frameExecCont.BackgroundColor3 = cExecCont
            local sExecCont = UDim2.new(1, -5, 0, 600)
            frameExecCont.Size = sExecCont
            
            local strExecCont = Instance.new("UIStroke")
            strExecCont.Parent = frameExecCont
            local csExecCont = Color3.fromRGB(40, 45, 60)
            strExecCont.Color = csExecCont
            strExecCont.Thickness = 1
            
            local crExecCont = Instance.new("UICorner")
            local rExecCont = UDim.new(0, 8)
            crExecCont.CornerRadius = rExecCont
            crExecCont.Parent = frameExecCont

            local frameTabBar = Instance.new("Frame")
            frameTabBar.Parent = frameExecCont
            local cTabBar = Color3.fromRGB(15, 17, 22)
            frameTabBar.BackgroundColor3 = cTabBar
            local pTabBar = UDim2.new(0, 0, 0, 0)
            frameTabBar.Position = pTabBar
            local sTabBar = UDim2.new(1, 0, 0, 35)
            frameTabBar.Size = sTabBar
            
            local crTabBar = Instance.new("UICorner")
            local rTabBar = UDim.new(0, 8)
            crTabBar.CornerRadius = rTabBar
            crTabBar.Parent = frameTabBar

            local scTabsNew = Instance.new("ScrollingFrame")
            scTabsNew.Parent = frameTabBar
            scTabsNew.BackgroundTransparency = 1
            local pScrollTabs = UDim2.new(0, 0, 0, 0)
            scTabsNew.Position = pScrollTabs
            local sScrollTabs = UDim2.new(1, -40, 1, 0)
            scTabsNew.Size = sScrollTabs
            local csZeroTab = UDim2.new(0, 0, 0, 0)
            scTabsNew.CanvasSize = csZeroTab
            scTabsNew.AutomaticCanvasSize = Enum.AutomaticSize.X
            scTabsNew.ScrollBarThickness = 0
            scrollTabs = scTabsNew

            local listTabs = Instance.new("UIListLayout")
            listTabs.Parent = scrollTabs
            listTabs.FillDirection = Enum.FillDirection.Horizontal
            listTabs.SortOrder = Enum.SortOrder.LayoutOrder
            local padTabs = UDim.new(0, 5)
            listTabs.Padding = padTabs

            local padScrollTabs = Instance.new("UIPadding")
            padScrollTabs.Parent = scrollTabs
            local pLScrollTabs = UDim.new(0, 5)
            padScrollTabs.PaddingLeft = pLScrollTabs
            local pTScrollTabs = UDim.new(0, 5)
            padScrollTabs.PaddingTop = pTScrollTabs
            
            local btnAddTab = Instance.new("TextButton")
            btnAddTab.Parent = frameTabBar
            local cAddTab = Color3.fromRGB(30, 32, 45)
            btnAddTab.BackgroundColor3 = cAddTab
            local pAddTab = UDim2.new(1, -35, 0, 5)
            btnAddTab.Position = pAddTab
            local sAddTab = UDim2.new(0, 25, 0, 25)
            btnAddTab.Size = sAddTab
            btnAddTab.Font = Enum.Font.GothamBold
            btnAddTab.Text = "+"
            local ctAddTab = Color3.fromRGB(200, 200, 200)
            btnAddTab.TextColor3 = ctAddTab
            
            local crAddTab = Instance.new("UICorner")
            local rAddTab = UDim.new(0, 4)
            crAddTab.CornerRadius = rAddTab
            crAddTab.Parent = btnAddTab

            local bxNewCode = Instance.new("TextBox")
            bxNewCode.Parent = frameExecCont
            local cBoxExec = Color3.fromRGB(12, 14, 20)
            bxNewCode.BackgroundColor3 = cBoxExec
            local pBoxExec = UDim2.new(0, 10, 0, 45)
            bxNewCode.Position = pBoxExec
            local sBoxExec = UDim2.new(1, -20, 0, 140)
            bxNewCode.Size = sBoxExec
            bxNewCode.Font = Enum.Font.Code
            bxNewCode.Text = ""
            bxNewCode.PlaceholderText = ""
            local ctBoxExec = Color3.fromRGB(220, 220, 220)
            bxNewCode.TextColor3 = ctBoxExec
            bxNewCode.TextSize = 12
            bxNewCode.TextXAlignment = Enum.TextXAlignment.Left
            bxNewCode.TextYAlignment = Enum.TextYAlignment.Top
            bxNewCode.ClearTextOnFocus = false
            bxNewCode.MultiLine = true
            boxExecCode = bxNewCode
            
            local crBoxExec = Instance.new("UICorner")
            local rBoxExec = UDim.new(0, 6)
            crBoxExec.CornerRadius = rBoxExec
            crBoxExec.Parent = boxExecCode
            
            local padBoxExec = Instance.new("UIPadding")
            padBoxExec.Parent = boxExecCode
            local plBoxExec = UDim.new(0, 5)
            padBoxExec.PaddingLeft = plBoxExec
            local ptBoxExec = UDim.new(0, 5)
            padBoxExec.PaddingTop = ptBoxExec

            local frameActions = Instance.new("Frame")
            frameActions.Parent = frameExecCont
            frameActions.BackgroundTransparency = 1
            local pActions = UDim2.new(0, 10, 0, 195)
            frameActions.Position = pActions
            local sActions = UDim2.new(1, -20, 0, 30)
            frameActions.Size = sActions

            local btnExecLua = Instance.new("TextButton")
            btnExecLua.Parent = frameActions
            local cExecLua = Color3.fromRGB(50, 200, 100)
            btnExecLua.BackgroundColor3 = cExecLua
            local pExecLua = UDim2.new(0, 0, 0, 0)
            btnExecLua.Position = pExecLua
            local sExecLua = UDim2.new(0.3, 0, 1, 0)
            btnExecLua.Size = sExecLua
            btnExecLua.Font = Enum.Font.GothamBold
            btnExecLua.Text = "Execute"
            local ctExecLua = Color3.fromRGB(0, 0, 0)
            btnExecLua.TextColor3 = ctExecLua
            
            local crExecLua = Instance.new("UICorner")
            local rExecLua = UDim.new(0, 4)
            crExecLua.CornerRadius = rExecLua
            crExecLua.Parent = btnExecLua

            local btnCopyLua = Instance.new("TextButton")
            btnCopyLua.Parent = frameActions
            local cCopyLua = Color3.fromRGB(30, 32, 45)
            btnCopyLua.BackgroundColor3 = cCopyLua
            local pCopyLua = UDim2.new(0.35, 0, 0, 0)
            btnCopyLua.Position = pCopyLua
            local sCopyLua = UDim2.new(0.3, 0, 1, 0)
            btnCopyLua.Size = sCopyLua
            btnCopyLua.Font = Enum.Font.GothamBold
            btnCopyLua.Text = "Copy"
            local ctCopyLua = Color3.fromRGB(255, 255, 255)
            btnCopyLua.TextColor3 = ctCopyLua
            
            local crCopyLua = Instance.new("UICorner")
            local rCopyLua = UDim.new(0, 4)
            crCopyLua.CornerRadius = rCopyLua
            crCopyLua.Parent = btnCopyLua

            local btnClearLua = Instance.new("TextButton")
            btnClearLua.Parent = frameActions
            local cClearLua = Color3.fromRGB(200, 50, 50)
            btnClearLua.BackgroundColor3 = cClearLua
            local pClearLua = UDim2.new(0.7, 0, 0, 0)
            btnClearLua.Position = pClearLua
            local sClearLua = UDim2.new(0.3, 0, 1, 0)
            btnClearLua.Size = sClearLua
            btnClearLua.Font = Enum.Font.GothamBold
            btnClearLua.Text = "Clear"
            local ctClearLua = Color3.fromRGB(255, 255, 255)
            btnClearLua.TextColor3 = ctClearLua
            
            local crClearLua = Instance.new("UICorner")
            local rClearLua = UDim.new(0, 4)
            crClearLua.CornerRadius = rClearLua
            crClearLua.Parent = btnClearLua

            local frameConsole = Instance.new("ScrollingFrame")
            frameConsole.Parent = frameExecCont
            local cConsole = Color3.fromRGB(10, 10, 12)
            frameConsole.BackgroundColor3 = cConsole
            local pConsole = UDim2.new(0, 10, 0, 235)
            frameConsole.Position = pConsole
            local sConsole = UDim2.new(1, -20, 0, 100)
            frameConsole.Size = sConsole
            frameConsole.ScrollBarThickness = 2
            frameConsole.AutomaticCanvasSize = Enum.AutomaticSize.Y
            
            local crConsole = Instance.new("UICorner")
            local rConsole = UDim.new(0, 4)
            crConsole.CornerRadius = rConsole
            crConsole.Parent = frameConsole
            
            local listConsole = Instance.new("UIListLayout")
            listConsole.Parent = frameConsole
            listConsole.SortOrder = Enum.SortOrder.LayoutOrder
            
            local padConsole = Instance.new("UIPadding")
            padConsole.Parent = frameConsole
            local plConsole = UDim.new(0, 5)
            padConsole.PaddingLeft = plConsole
            local ptConsole = UDim.new(0, 2)
            padConsole.PaddingTop = ptConsole

            local btnCopyLogsAll = Instance.new("TextButton")
            btnCopyLogsAll.Parent = frameExecCont
            local cCpyLg = Color3.fromRGB(30, 32, 45)
            btnCopyLogsAll.BackgroundColor3 = cCpyLg
            local pCpyLg = UDim2.new(0, 10, 0, 345)
            btnCopyLogsAll.Position = pCpyLg
            local sCpyLg = UDim2.new(1, -20, 0, 30)
            btnCopyLogsAll.Size = sCpyLg
            btnCopyLogsAll.Font = Enum.Font.GothamBold
            btnCopyLogsAll.Text = "Copy All Logs"
            local ctCpyLg = Color3.fromRGB(255, 255, 255)
            btnCopyLogsAll.TextColor3 = ctCpyLg

            local crCpyLg = Instance.new("UICorner")
            local rCpyLg = UDim.new(0, 4)
            crCpyLg.CornerRadius = rCpyLg
            crCpyLg.Parent = btnCopyLogsAll

            local lblSpyTitle = Instance.new("TextLabel")
            lblSpyTitle.Parent = frameExecCont
            lblSpyTitle.BackgroundTransparency = 1
            local pSpyT = UDim2.new(0, 10, 0, 385)
            lblSpyTitle.Position = pSpyT
            local sSpyT = UDim2.new(1, -20, 0, 20)
            lblSpyTitle.Size = sSpyT
            lblSpyTitle.Font = Enum.Font.GothamBold
            lblSpyTitle.Text = "View All Player Messages"
            local ctSpyT = Color3.fromRGB(200, 220, 255)
            lblSpyTitle.TextColor3 = ctSpyT
            lblSpyTitle.TextSize = 12
            lblSpyTitle.TextXAlignment = Enum.TextXAlignment.Left

            local frameSpyMsgs = Instance.new("ScrollingFrame")
            frameSpyMsgs.Parent = frameExecCont
            local cSpyM = Color3.fromRGB(10, 10, 12)
            frameSpyMsgs.BackgroundColor3 = cSpyM
            local pSpyM = UDim2.new(0, 10, 0, 410)
            frameSpyMsgs.Position = pSpyM
            local sSpyM = UDim2.new(1, -20, 0, 140)
            frameSpyMsgs.Size = sSpyM
            frameSpyMsgs.ScrollBarThickness = 2
            frameSpyMsgs.AutomaticCanvasSize = Enum.AutomaticSize.Y
            
            local crSpyM = Instance.new("UICorner")
            local rSpyM = UDim.new(0, 4)
            crSpyM.CornerRadius = rSpyM
            crSpyM.Parent = frameSpyMsgs

            local listSpy = Instance.new("UIListLayout")
            listSpy.Parent = frameSpyMsgs
            listSpy.SortOrder = Enum.SortOrder.LayoutOrder

            local padSpy = Instance.new("UIPadding")
            padSpy.Parent = frameSpyMsgs
            local plSpy = UDim.new(0, 5)
            padSpy.PaddingLeft = plSpy
            local ptSpy = UDim.new(0, 2)
            padSpy.PaddingTop = ptSpy

            local boxSpyInput = Instance.new("TextBox")
            boxSpyInput.Parent = frameExecCont
            local cSpyI = Color3.fromRGB(20, 21, 26)
            boxSpyInput.BackgroundColor3 = cSpyI
            local pSpyI = UDim2.new(0, 10, 0, 560)
            boxSpyInput.Position = pSpyI
            local sSpyI = UDim2.new(1, -90, 0, 30)
            boxSpyInput.Size = sSpyI
            boxSpyInput.Font = Enum.Font.Gotham
            boxSpyInput.Text = ""
            boxSpyInput.PlaceholderText = "Type message..."
            local ctSpyI = Color3.fromRGB(255, 255, 255)
            boxSpyInput.TextColor3 = ctSpyI
            boxSpyInput.TextSize = 12

            local strSpyI = Instance.new("UIStroke")
            strSpyI.Parent = boxSpyInput
            local cStrSpyI = Color3.fromRGB(40, 45, 60)
            strSpyI.Color = cStrSpyI
            strSpyI.Thickness = 1

            local crSpyI = Instance.new("UICorner")
            local rSpyI = UDim.new(0, 4)
            crSpyI.CornerRadius = rSpyI
            crSpyI.Parent = boxSpyInput

            local btnSpySend = Instance.new("TextButton")
            btnSpySend.Parent = frameExecCont
            local cSpyS = GlobalState.MainColor
            btnSpySend.BackgroundColor3 = cSpyS
            local pSpyS = UDim2.new(1, -70, 0, 560)
            btnSpySend.Position = pSpyS
            local sSpyS = UDim2.new(0, 60, 0, 30)
            btnSpySend.Size = sSpyS
            btnSpySend.Font = Enum.Font.GothamBold
            btnSpySend.Text = "Send"
            local ctSpyS = Color3.fromRGB(255, 255, 255)
            btnSpySend.TextColor3 = ctSpyS

            local crSpyS = Instance.new("UICorner")
            local rSpyS = UDim.new(0, 4)
            crSpyS.CornerRadius = rSpyS
            crSpyS.Parent = btnSpySend

            local connRsSpy = RunServiceAPI.RenderStepped:Connect(function()
                local succRsSpy, errRsSpy = pcall(function()
                    btnSpySend.BackgroundColor3 = GlobalState.MainColor
                end)
            end)

            local connAddTab = btnAddTab.MouseButton1Click:Connect(function()
                local succAdd, errAdd = pcall(function()
                    local currDataSave = ExecutorTabsData[currentActiveTabId]
                    if currDataSave then
                        local cbTextAdd = boxExecCode.Text
                        currDataSave.Source = cbTextAdd
                    end
                    
                    tabCounterTotal = tabCounterTotal + 1
                    local newTabObj = {}
                    local nNameTab = "Script " .. tostring(tabCounterTotal)
                    newTabObj.Name = nNameTab
                    newTabObj.Source = ""
                    table.insert(ExecutorTabsData, newTabObj)
                    
                    local newLen = #ExecutorTabsData
                    currentActiveTabId = newLen
                    boxExecCode.Text = ""
                    RefreshTabsRender()
                end)
            end)

            local connExecLuaAct = btnExecLua.MouseButton1Click:Connect(function()
                local succExecL, errExecL = pcall(function()
                    local codeStrLua = boxExecCode.Text
                    local hasLoadStr = false
                    if loadstring then
                        hasLoadStr = true
                    end
                    
                    if hasLoadStr then
                        local execFuncVar, errLoadL = loadstring(codeStrLua)
                        if execFuncVar then
                            local succR, errR = pcall(function()
                                execFuncVar()
                            end)
                            local isNotSuccR = false
                            if not succR then
                                isNotSuccR = true
                            end
                            if isNotSuccR then
                                local errMsg = "Runtime Error: " .. tostring(errR)
                                TriggerNotificationUI("Executor", errMsg, 4)
                            end
                        end
                        local isNotExecFuncVar = false
                        if not execFuncVar then
                            isNotExecFuncVar = true
                        end
                        if isNotExecFuncVar then
                            local errSynMsg = "Syntax Error: " .. tostring(errLoadL)
                            TriggerNotificationUI("Executor", errSynMsg, 4)
                        end
                    end
                    local isNotHasLoadStr = false
                    if not hasLoadStr then
                        isNotHasLoadStr = true
                    end
                    if isNotHasLoadStr then
                        TriggerNotificationUI("Executor", "Loadstring is not enabled/supported on this executor.", 4)
                    end
                end)
            end)

            local connCopyLuaAct = btnCopyLua.MouseButton1Click:Connect(function()
                local succCpyL, errCpyL = pcall(function()
                    local codeStrCopy = boxExecCode.Text
                    local hasSetClip = false
                    if setclipboard then
                        hasSetClip = true
                    end
                    if hasSetClip then
                        setclipboard(codeStrCopy)
                        TriggerNotificationUI("Executor", "Code copied to clipboard.", 2)
                    end
                    local isNotHasSetClip = false
                    if not hasSetClip then
                        isNotHasSetClip = true
                    end
                    if isNotHasSetClip then
                        TriggerNotificationUI("Executor", "Clipboard function not supported.", 3)
                    end
                end)
            end)

            local connClearLuaAct = btnClearLua.MouseButton1Click:Connect(function()
                local succClrL, errClrL = pcall(function()
                    boxExecCode.Text = ""
                end)
            end)

            local connCodeChgAct = boxExecCode:GetPropertyChangedSignal("Text"):Connect(function()
                local succCodeChg, errCodeChg = pcall(function()
                    local currDataUpd = ExecutorTabsData[currentActiveTabId]
                    if currDataUpd then
                        local cbTextUpd = boxExecCode.Text
                        currDataUpd.Source = cbTextUpd
                    end
                end)
            end)

            local connLogMsgAct = LogServiceAPI.MessageOut:Connect(function(msgLog, typeLog)
                local succLogA, errLogA = pcall(function()
                    local lblLog = Instance.new("TextLabel")
                    lblLog.Parent = frameConsole
                    lblLog.BackgroundTransparency = 1
                    local sLblLog = UDim2.new(1, 0, 0, 15)
                    lblLog.Size = sLblLog
                    lblLog.Font = Enum.Font.Code
                    lblLog.Text = msgLog
                    lblLog.TextSize = 10
                    lblLog.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local isWarnType = false
                    if typeLog == Enum.MessageType.MessageWarning then
                        isWarnType = true
                    end
                    if isWarnType then
                        local cWarnL = Color3.fromRGB(255, 200, 50)
                        lblLog.TextColor3 = cWarnL
                    end
                    
                    local isErrType = false
                    if typeLog == Enum.MessageType.MessageError then
                        isErrType = true
                    end
                    if isErrType then
                        local cErrL = Color3.fromRGB(255, 50, 50)
                        lblLog.TextColor3 = cErrL
                    end
                    
                    local isInfoType = false
                    if typeLog == Enum.MessageType.MessageInfo then
                        isInfoType = true
                    end
                    if typeLog == Enum.MessageType.MessageOutput then
                        isInfoType = true
                    end
                    if isInfoType then
                        local cInfoL = Color3.fromRGB(200, 200, 200)
                        lblLog.TextColor3 = cInfoL
                    end
                end)
            end)

            local connCopyAllLog = btnCopyLogsAll.MouseButton1Click:Connect(function()
                local succCpyA, errCpyA = pcall(function()
                    local fullLogText = ""
                    local logChildren = frameConsole:GetChildren()
                    for _, lgChild in pairs(logChildren) do
                        local isTxtL = lgChild:IsA("TextLabel")
                        if isTxtL then
                            local lgTxt = lgChild.Text
                            fullLogText = fullLogText .. lgTxt .. "\n"
                        end
                    end
                    local hasSetCA = false
                    if setclipboard then
                        hasSetCA = true
                    end
                    if hasSetCA then
                        setclipboard(fullLogText)
                        TriggerNotificationUI("Logs", "All logs copied to clipboard.", 2)
                    end
                    local isNotSetCA = false
                    if not hasSetCA then
                        isNotSetCA = true
                    end
                    if isNotSetCA then
                        TriggerNotificationUI("Logs", "Clipboard function not supported.", 3)
                    end
                end)
            end)

            local function processChatSpyLog(playerNameLog, playerTextLog)
                local succChatSpy, errChatSpy = pcall(function()
                    local lblSpy = Instance.new("TextLabel")
                    lblSpy.Parent = frameSpyMsgs
                    lblSpy.BackgroundTransparency = 1
                    local sLblSpy = UDim2.new(1, 0, 0, 15)
                    lblSpy.Size = sLblSpy
                    lblSpy.Font = Enum.Font.Gotham
                    local strCombineSpy = "[" .. playerNameLog .. "]: " .. playerTextLog
                    lblSpy.Text = strCombineSpy
                    lblSpy.TextSize = 12
                    lblSpy.TextXAlignment = Enum.TextXAlignment.Left
                    local cLblSpy = Color3.fromRGB(255, 255, 255)
                    lblSpy.TextColor3 = cLblSpy
                end)
            end

            local function hookPlayerChat(playerToHook)
                local succHkChat, errHkChat = pcall(function()
                    local connHkChat = playerToHook.Chatted:Connect(function(msgChatRecv)
                        processChatSpyLog(playerToHook.Name, msgChatRecv)
                    end)
                end)
            end

            local plyListSpy = PlayersService:GetPlayers()
            for _, pSpyInit in pairs(plyListSpy) do
                hookPlayerChat(pSpyInit)
            end

            local connPlrAddSpy = PlayersService.PlayerAdded:Connect(function(newPlrSpy)
                hookPlayerChat(newPlrSpy)
            end)

            local connSendSpy = btnSpySend.MouseButton1Click:Connect(function()
                local succSendSpy, errSendSpy = pcall(function()
                    local textToSend = boxSpyInput.Text
                    local isLenValid = false
                    local lenTx = string.len(textToSend)
                    if lenTx > 0 then
                        isLenValid = true
                    end
                    if isLenValid then
                        local hasLegacyChat = false
                        local defChatSys = ReplicatedStorageAPI:FindFirstChild("DefaultChatSystemChatEvents")
                        if defChatSys then
                            hasLegacyChat = true
                        end
                        if hasLegacyChat then
                            local sayMsgEvt = defChatSys:FindFirstChild("SayMessageRequest")
                            if sayMsgEvt then
                                sayMsgEvt:FireServer(textToSend, "All")
                            end
                        end
                        
                        local isNotLegChat = false
                        if not hasLegacyChat then
                            isNotLegChat = true
                        end
                        if isNotLegChat then
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

    SetupExecutorTabSystem()

    local FrameCUIBox = Instance.new("Frame")
    FrameCUIBox.Parent = PageObjCustomUI
    local cCUIB = Color3.fromRGB(20, 21, 26)
    FrameCUIBox.BackgroundColor3 = cCUIB
    local sCUIB = UDim2.new(1, -5, 0, 60)
    FrameCUIBox.Size = sCUIB
    local crCUIB = Instance.new("UICorner")
    local rCUIB = UDim.new(0, 8)
    crCUIB.CornerRadius = rCUIB
    crCUIB.Parent = FrameCUIBox

    local StrCUIB = Instance.new("UIStroke")
    StrCUIB.Parent = FrameCUIBox
    local cStrCUIB = GlobalState.MainColor
    StrCUIB.Color = cStrCUIB
    StrCUIB.Thickness = 2

    local LblCUIT = Instance.new("TextLabel")
    LblCUIT.Parent = FrameCUIBox
    LblCUIT.BackgroundTransparency = 1
    local sCUIT = UDim2.new(1, 0, 1, 0)
    LblCUIT.Size = sCUIT
    LblCUIT.Font = Enum.Font.GothamBold
    LblCUIT.Text = "PREVIEW COLOR"
    local cCUIT = GlobalState.MainColor
    LblCUIT.TextColor3 = cCUIT
    LblCUIT.TextSize = 14

    local TmpColorData = GlobalState.MainColor

    local FrameCUIPal = Instance.new("Frame")
    FrameCUIPal.Parent = PageObjCustomUI
    FrameCUIPal.BackgroundTransparency = 1
    local sCUIPal = UDim2.new(1, -5, 0, 150)
    FrameCUIPal.Size = sCUIPal

    local GridCUIPal = Instance.new("UIGridLayout")
    GridCUIPal.Parent = FrameCUIPal
    local csCUIPal = UDim2.new(0, 30, 0, 30)
    GridCUIPal.CellSize = csCUIPal
    local cpCUIPal = UDim2.new(0, 5, 0, 5)
    GridCUIPal.CellPadding = cpCUIPal
    GridCUIPal.SortOrder = Enum.SortOrder.LayoutOrder

    local colorListTbl = {}
    local cTbl1 = Color3.fromRGB(255,0,0)
    table.insert(colorListTbl, cTbl1)
    local cTbl2 = Color3.fromRGB(0,255,0)
    table.insert(colorListTbl, cTbl2)
    local cTbl3 = Color3.fromRGB(0,0,255)
    table.insert(colorListTbl, cTbl3)
    local cTbl4 = Color3.fromRGB(255,255,0)
    table.insert(colorListTbl, cTbl4)
    local cTbl5 = Color3.fromRGB(255,0,255)
    table.insert(colorListTbl, cTbl5)
    local cTbl6 = Color3.fromRGB(0,255,255)
    table.insert(colorListTbl, cTbl6)
    local cTbl7 = Color3.fromRGB(255,128,0)
    table.insert(colorListTbl, cTbl7)
    local cTbl8 = Color3.fromRGB(128,0,255)
    table.insert(colorListTbl, cTbl8)
    local cTbl9 = Color3.fromRGB(255,0,128)
    table.insert(colorListTbl, cTbl9)
    local cTbl10 = Color3.fromRGB(0,255,128)
    table.insert(colorListTbl, cTbl10)
    local cTbl11 = Color3.fromRGB(128,255,0)
    table.insert(colorListTbl, cTbl11)
    local cTbl12 = Color3.fromRGB(0,128,255)
    table.insert(colorListTbl, cTbl12)
    local cTbl13 = Color3.fromRGB(255,255,255)
    table.insert(colorListTbl, cTbl13)
    local cTbl14 = Color3.fromRGB(100,100,100)
    table.insert(colorListTbl, cTbl14)
    local cTbl15 = Color3.fromRGB(50,50,50)
    table.insert(colorListTbl, cTbl15)
    local cTbl16 = Color3.fromRGB(138,43,226)
    table.insert(colorListTbl, cTbl16)
    local cTbl17 = Color3.fromRGB(0,200,150)
    table.insert(colorListTbl, cTbl17)
    local cTbl18 = Color3.fromRGB(255,100,100)
    table.insert(colorListTbl, cTbl18)
    local cTbl19 = Color3.fromRGB(100,255,100)
    table.insert(colorListTbl, cTbl19)
    local cTbl20 = Color3.fromRGB(100,100,255)
    table.insert(colorListTbl, cTbl20)
    local cTbl21 = Color3.fromRGB(255,200,100)
    table.insert(colorListTbl, cTbl21)
    local cTbl22 = Color3.fromRGB(200,255,100)
    table.insert(colorListTbl, cTbl22)
    local cTbl23 = Color3.fromRGB(100,200,255)
    table.insert(colorListTbl, cTbl23)
    local cTbl24 = Color3.fromRGB(255,150,0)
    table.insert(colorListTbl, cTbl24)
    local cTbl25 = Color3.fromRGB(0,150,255)
    table.insert(colorListTbl, cTbl25)
    local cTbl26 = Color3.fromRGB(150,0,255)
    table.insert(colorListTbl, cTbl26)
    local cTbl27 = Color3.fromRGB(255,0,150)
    table.insert(colorListTbl, cTbl27)
    local cTbl28 = Color3.fromRGB(0,255,150)
    table.insert(colorListTbl, cTbl28)
    local cTbl29 = Color3.fromRGB(150,255,0)
    table.insert(colorListTbl, cTbl29)
    local cTbl30 = Color3.fromRGB(200,0,0)
    table.insert(colorListTbl, cTbl30)
    local cTbl31 = Color3.fromRGB(0,200,0)
    table.insert(colorListTbl, cTbl31)
    local cTbl32 = Color3.fromRGB(0,0,200)
    table.insert(colorListTbl, cTbl32)
    local cTbl33 = Color3.fromRGB(200,200,0)
    table.insert(colorListTbl, cTbl33)
    local cTbl34 = Color3.fromRGB(200,0,200)
    table.insert(colorListTbl, cTbl34)
    local cTbl35 = Color3.fromRGB(0,200,200)
    table.insert(colorListTbl, cTbl35)

    for indexCol, colorVal in ipairs(colorListTbl) do
        local btnColPlt = Instance.new("TextButton")
        btnColPlt.Parent = FrameCUIPal
        btnColPlt.BackgroundColor3 = colorVal
        btnColPlt.Text = ""
        local crColPlt = Instance.new("UICorner")
        local rColPlt = UDim.new(0, 4)
        crColPlt.CornerRadius = rColPlt
        crColPlt.Parent = btnColPlt
        
        local connColPlt = btnColPlt.MouseButton1Click:Connect(function()
            local successClickCol, errorClickCol = pcall(function()
                TmpColorData = colorVal
                StrCUIB.Color = TmpColorData
                LblCUIT.TextColor3 = TmpColorData
            end)
        end)
    end

    local DualCUI1 = CreateDualSwitchMenu(PageObjCustomUI, "RGB Gaming Modern", "RGBGaming")

    local BtnCUI1 = CreateButtonMenu(PageObjCustomUI, "Test Notify Custom", "Main", function()
        local successCUI1, errorCUI1 = pcall(function()
            local oldColorSav = GlobalState.MainColor
            GlobalState.MainColor = TmpColorData
            TriggerNotificationUI("Test Custom", "This is how it looks!", 3)
            GlobalState.MainColor = oldColorSav
        end)
    end, nil)

    local cGrnCui = Color3.fromRGB(50, 200, 100)
    local BtnCUI2 = CreateButtonMenu(PageObjCustomUI, "Apply Change", cGrnCui, function()
        local successCUI2, errorCUI2 = pcall(function()
            GlobalState.MainColor = TmpColorData
            SaveConfigurationData()
            TriggerNotificationUI("Theme Saved", "Colors applied successfully.", 3)
        end)
    end, nil)

    local cRedCui = Color3.fromRGB(200, 50, 50)
    local BtnCUI3 = CreateButtonMenu(PageObjCustomUI, "Cancel", cRedCui, function()
        local successCUI3, errorCUI3 = pcall(function()
            local currColSave = GlobalState.MainColor
            TmpColorData = currColSave
            StrCUIB.Color = TmpColorData
            LblCUIT.TextColor3 = TmpColorData
        end)
    end, nil)

    local DualSet1 = CreateDualSwitchMenu(PageObjSettings, "Performance Mode (HP Kentang)", "PerformanceMode")

    local tpWalkingStateFly = false
    local FlyBVIns = nil
    local FlyBGIns = nil

    local connRsFly = RunServiceAPI.RenderStepped:Connect(function()
        local successRsFly, errorRsFly = pcall(function()
            local isFlyOn = GlobalState.Fly
            if isFlyOn then
                local isNotTpWalking = false
                if not tpWalkingStateFly then
                    isNotTpWalking = true
                end
                if isNotTpWalking then
                    local charFly1 = LocalPlayerInstance.Character
                    local humFly1 = nil
                    local rootFly1 = nil
                    local torsoFly1 = nil
                    
                    if charFly1 then
                        local findHum = charFly1:FindFirstChildWhichIsA("Humanoid")
                        humFly1 = findHum
                        local findRoot = charFly1:FindFirstChild("HumanoidRootPart")
                        rootFly1 = findRoot
                        local findTorso = charFly1:FindFirstChild("Torso")
                        local isNotFindTorso = false
                        if not findTorso then
                            isNotFindTorso = true
                        end
                        if isNotFindTorso then
                            local findUTorso = charFly1:FindFirstChild("UpperTorso")
                            findTorso = findUTorso
                        end
                        torsoFly1 = findTorso
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
                        
                        local newBGFly = Instance.new("BodyGyro")
                        FlyBGIns = newBGFly
                        FlyBGIns.Parent = torsoFly1
                        FlyBGIns.P = 9e4
                        local torqVecFly = Vector3.new(9e9, 9e9, 9e9)
                        FlyBGIns.MaxTorque = torqVecFly
                        
                        local newBVFly = Instance.new("BodyVelocity")
                        FlyBVIns = newBVFly
                        FlyBVIns.Parent = torsoFly1
                        local maxFVecFly = Vector3.new(9e9, 9e9, 9e9)
                        FlyBVIns.MaxForce = maxFVecFly
                        
                        humFly1.PlatformStand = true
                        local animCharFly = charFly1:FindFirstChild("Animate")
                        if animCharFly then
                            animCharFly.Disabled = true
                        end
                        
                        local animTracksFly = humFly1:GetPlayingAnimationTracks()
                        for indexFlyT, trackFlyT in pairs(animTracksFly) do
                            trackFlyT:Stop()
                        end
                    end
                end
            end
            
            local isFlyOff = false
            if not isFlyOn then
                isFlyOff = true
            end
            if isFlyOff then
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
                            local gUpEnum = Enum.HumanoidStateType.GettingUp
                            humFly2:ChangeState(gUpEnum) 
                        end
                        local animCharFly2 = charFly2:FindFirstChild("Animate")
                        if animCharFly2 then 
                            animCharFly2.Disabled = false 
                        end
                    end
                end
            end

            if isFlyOn then
                if tpWalkingStateFly then
                    local isBvValid = false
                    if FlyBVIns then
                        isBvValid = true
                    end
                    local isBgValid = false
                    if FlyBGIns then
                        isBgValid = true
                    end
                    local isBothValid = false
                    if isBvValid then
                        if isBgValid then
                            isBothValid = true
                        end
                    end
                    
                    if isBothValid then
                        local charFly3 = LocalPlayerInstance.Character
                        local humFly3 = nil
                        if charFly3 then
                            local fHumFly3 = charFly3:FindFirstChild("Humanoid")
                            humFly3 = fHumFly3
                        end
                        
                        if humFly3 then
                            local camCFFly = CameraInstance.CFrame
                            FlyBGIns.CFrame = camCFFly
                            local moveDirFly = humFly3.MoveDirection
                            
                            local mDirMagFly = moveDirFly.Magnitude
                            local isMovingFly = false
                            if mDirMagFly > 0 then
                                isMovingFly = true
                            end
                            
                            if isMovingFly then
                                local cLookXFly = CameraInstance.CFrame.LookVector.X
                                local cLookZFly = CameraInstance.CFrame.LookVector.Z
                                local camLookFlatVecFly = Vector3.new(cLookXFly, 0, cLookZFly)
                                local camLookFlatFly = camLookFlatVecFly.Unit
                                
                                local cRightXFly = CameraInstance.CFrame.RightVector.X
                                local cRightZFly = CameraInstance.CFrame.RightVector.Z
                                local camRightFlatVecFly = Vector3.new(cRightXFly, 0, cRightZFly)
                                local camRightFlatFly = camRightFlatVecFly.Unit
                                
                                local fwdMoveFly = moveDirFly:Dot(camLookFlatFly)
                                local rgtMoveFly = moveDirFly:Dot(camRightFlatFly)
                                
                                local cLookVecFly = CameraInstance.CFrame.LookVector
                                local fwdVecFly = cLookVecFly * fwdMoveFly
                                local cRightVecFly = CameraInstance.CFrame.RightVector
                                local rgtVecFly = cRightVecFly * rgtMoveFly
                                local flyDirFly = fwdVecFly + rgtVecFly
                                
                                local flyDirMagFly = flyDirFly.Magnitude
                                local isMagGrZero = false
                                if flyDirMagFly > 0 then
                                    isMagGrZero = true
                                end
                                if isMagGrZero then 
                                    flyDirFly = flyDirFly.Unit 
                                end
                                
                                local flSpdFly = GlobalState.FlySpeed * 50
                                local flVelFly = flyDirFly * flSpdFly
                                FlyBVIns.Velocity = flVelFly
                            end
                            local isNotMovingFly = false
                            if not isMovingFly then
                                isNotMovingFly = true
                            end
                            if isNotMovingFly then
                                local zeroVelFly = Vector3.new(0, 0, 0)
                                FlyBVIns.Velocity = zeroVelFly
                            end
                        end
                    end
                end
            end
        end)
    end)

    local EspDataStorage = {}
    local isHasDrawingApi = false
    local successDraw, errorDraw = pcall(function() 
        local testLineDr = Drawing.new("Line") 
        isHasDrawingApi = true
        testLineDr:Remove()
    end)

    local FOVCircleInst = nil
    if isHasDrawingApi then
        local successFovCr, errorFovCr = pcall(function()
            local drCircleFov = Drawing.new("Circle")
            FOVCircleInst = drCircleFov
            local colWhFov = Color3.fromRGB(255, 255, 255)
            FOVCircleInst.Color = colWhFov
            FOVCircleInst.Thickness = 1.5
            FOVCircleInst.Filled = false
            FOVCircleInst.Transparency = 1
        end)
    end

    local function GetClosestPlayerLogic()
        local targetPlr = nil
        local successGCP, errorGCP = pcall(function()
            local shortDistPlr = GlobalState.Aim_FOVSize
            local camVXPlr = CameraInstance.ViewportSize.X / 2
            local camVYPlr = CameraInstance.ViewportSize.Y / 2
            local centerScreenPlr = Vector2.new(camVXPlr, camVYPlr)
            
            local pTablePlr = PlayersService:GetPlayers()
            for indexPTable, pPlrLoop in pairs(pTablePlr) do
                local isValidTargetPlr = false
                local isNotLocalLp = false
                if pPlrLoop ~= LocalPlayerInstance then
                    isNotLocalLp = true
                end
                if isNotLocalLp then
                    local charPPlr = pPlrLoop.Character
                    if charPPlr then
                        local pHumPPlr = charPPlr:FindFirstChild("Humanoid")
                        local aimPtPPlr = GlobalState.Aim_Part
                        local pPartPPlr = charPPlr:FindFirstChild(aimPtPPlr)
                        if pHumPPlr then
                            local isHumPPlrAlive = false
                            if pHumPPlr.Health > 0 then
                                isHumPPlrAlive = true
                            end
                            if isHumPPlrAlive then
                                if pPartPPlr then
                                    isValidTargetPlr = true
                                end
                            end
                        end
                    end
                end
                
                if isValidTargetPlr then
                    local aimPtPPlr2 = GlobalState.Aim_Part
                    local partPosPPlr = pPlrLoop.Character[aimPtPPlr2].Position
                    local vPPlr, onSPPlr = CameraInstance:WorldToViewportPoint(partPosPPlr)
                    if onSPPlr then
                        local vVecPPlr = Vector2.new(vPPlr.X, vPPlr.Y)
                        local vecDistPPlr = vVecPPlr - centerScreenPlr
                        local dMagPPlr = vecDistPPlr.Magnitude
                        local isCloserPPlr = false
                        if dMagPPlr < shortDistPlr then
                            isCloserPPlr = true
                        end
                        if isCloserPPlr then 
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
    local getNmCallHk = nil
    local succNmCall, errNmCall = pcall(function()
        getNmCallHk = getnamecallmethod
    end)
    local hkMetaHk = nil
    local succHkMeta, errHkMeta = pcall(function()
        hkMetaHk = hookmetamethod
    end)

    local isBothHkValid = false
    if getNmCallHk then
        if hkMetaHk then
            isBothHkValid = true
        end
    end

    if isBothHkValid then
        local succMetaSetup, errMetaSetup = pcall(function()
            OldNamecallHk = hkMetaHk(game, "__namecall", function(selfParam, ...)
                local methodHk = getNmCallHk()
                local argsHk = {...}
                
                local isStateAimHk = GlobalState.Aimbot
                local isStateSlntHk = GlobalState.SilentAim
                local isChCallerHk = checkcaller()
                
                local isOkHk = false
                if isStateAimHk then
                    if isStateSlntHk then
                        local isNotChCallerHk = false
                        if not isChCallerHk then
                            isNotChCallerHk = true
                        end
                        if isNotChCallerHk then
                            isOkHk = true
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
                                local aimPtHk = GlobalState.Aim_Part
                                local cPartHk = charHk:FindFirstChild(aimPtHk)
                                if cPartHk then
                                    local targetPosHk = charHk[aimPtHk].Position
                                    
                                    local isRcHk = false
                                    if methodHk == "Raycast" then
                                        isRcHk = true
                                    end
                                    if isRcHk then
                                        local originHk1 = argsHk[1]
                                        local tarSubHk1 = targetPosHk - originHk1
                                        local tarUnitHk1 = tarSubHk1.Unit
                                        local dirVecHk1 = tarUnitHk1 * 1000
                                        argsHk[2] = dirVecHk1
                                        return OldNamecallHk(selfParam, unpack(argsHk))
                                    end
                                    
                                    local isFPRHk = false
                                    if methodHk == "FindPartOnRayWithIgnoreList" then
                                        isFPRHk = true
                                    end
                                    if isFPRHk then
                                        local originHk2 = argsHk[1].Origin
                                        local tarSubHk2 = targetPosHk - originHk2
                                        local tarUnitHk2 = tarSubHk2.Unit
                                        local dirVecHk2 = tarUnitHk2 * 1000
                                        local newRayHk2 = Ray.new(originHk2, dirVecHk2)
                                        argsHk[1] = newRayHk2
                                        return OldNamecallHk(selfParam, unpack(argsHk))
                                    end
                                end
                            end
                        end
                    end
                end
                return OldNamecallHk(selfParam, ...)
            end)
        end)
    end

    local function CreateESPLogic(playerEsp)
        local successCrEsp, errorCrEsp = pcall(function()
            local espTb = {}
            local hlEsp = Instance.new("Highlight")
            espTb.Highlight = hlEsp
            local colRedESEsp = Color3.fromRGB(255, 50, 50)
            espTb.Highlight.FillColor = colRedESEsp
            local colWhESEsp = Color3.fromRGB(255, 255, 255)
            espTb.Highlight.OutlineColor = colWhESEsp
            espTb.Highlight.FillTransparency = 0.5
            espTb.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            
            if isHasDrawingApi then
                local trEsp = Drawing.new("Line")
                espTb.Tracer = trEsp
                espTb.Tracer.Thickness = 1.5
                local trColEsp = Color3.fromRGB(255, 255, 255)
                espTb.Tracer.Color = trColEsp
                
                local bxEsp = Drawing.new("Square")
                espTb.Box = bxEsp
                espTb.Box.Thickness = 1.5
                local bxColEsp = Color3.fromRGB(255, 50, 50)
                espTb.Box.Color = bxColEsp
                espTb.Box.Filled = false
                
                local hbgEsp = Drawing.new("Line")
                espTb.HealthBg = hbgEsp
                espTb.HealthBg.Thickness = 3
                local hbgColEsp = Color3.fromRGB(0, 0, 0)
                espTb.HealthBg.Color = hbgColEsp
                
                local hflEsp = Drawing.new("Line")
                espTb.HealthFill = hflEsp
                espTb.HealthFill.Thickness = 1.5
                local hflColEsp = Color3.fromRGB(0, 255, 100)
                espTb.HealthFill.Color = hflColEsp
                
                local txtDEsp = Drawing.new("Text")
                espTb.Text = txtDEsp
                espTb.Text.Size = 14
                local txtColEsp = Color3.fromRGB(255, 255, 255)
                espTb.Text.Color = txtColEsp
                espTb.Text.Center = true
                espTb.Text.Outline = true
            end
            EspDataStorage[playerEsp] = espTb
        end)
    end

    local function RemoveESPLogic(playerEspRm)
        local successRmEsp, errorRmEsp = pcall(function()
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
    
    local connPlyRm = PlayersService.PlayerRemoving:Connect(RemoveESPLogic)

    local connRsEspMain = RunServiceAPI.RenderStepped:Connect(function()
        local successRsEspM, errorRsEspM = pcall(function()
            if CameraInstance then
                local cFovCam = CameraInstance.FieldOfView
                local sPovCam = GlobalState.POV
                local isNotEqualCam = false
                if cFovCam ~= sPovCam then
                    isNotEqualCam = true
                end
                if isNotEqualCam then 
                    CameraInstance.FieldOfView = sPovCam 
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
                local aimStFov = GlobalState.Aimbot
                local fovStFov = GlobalState.Aim_ShowFOV
                local combStFov = false
                if aimStFov then
                    if fovStFov then
                        combStFov = true
                    end
                end
                
                if combStFov then
                    FOVCircleInst.Visible = true
                end
                local isNotCombStFov = false
                if not combStFov then
                    isNotCombStFov = true
                end
                if isNotCombStFov then
                    FOVCircleInst.Visible = false
                end
            end
            
            local aimOnM = GlobalState.Aimbot
            local sAimOnM = GlobalState.SilentAim
            local canAimM = false
            if aimOnM then
                local isNotSAimOnM = false
                if not sAimOnM then
                    isNotSAimOnM = true
                end
                if isNotSAimOnM then
                    canAimM = true
                end
            end
            
            if canAimM then
                local targetM = GetClosestPlayerLogic()
                if targetM then 
                    local aimPtM = GlobalState.Aim_Part
                    local pPartPosM = targetM.Character[aimPtM].Position
                    local camPosM = CameraInstance.CFrame.Position
                    local newCFM = CFrame.new(camPosM, pPartPosM)
                    local lrpCFM = CameraInstance.CFrame:Lerp(newCFM, 0.2)
                    CameraInstance.CFrame = lrpCFM 
                end
            end

            local isEspStOnM = GlobalState.ESP
            if isEspStOnM then
                local pTableM = PlayersService:GetPlayers()
                for _, playerM in pairs(pTableM) do
                    local isNotLPM = false
                    if playerM ~= LocalPlayerInstance then
                        isNotLPM = true
                    end
                    if isNotLPM then
                        local charM = playerM.Character
                        local rootM = nil
                        local headM = nil
                        local humM = nil
                        
                        if charM then
                            local rtM = charM:FindFirstChild("HumanoidRootPart")
                            rootM = rtM
                            local hdM = charM:FindFirstChild("Head")
                            headM = hdM
                            local hmM = charM:FindFirstChild("Humanoid")
                            humM = hmM
                        end
                        
                        local isOkCM = false
                        if charM then
                            if rootM then
                                if headM then
                                    if humM then
                                        local isHumLifeM = false
                                        if humM.Health > 0 then
                                            isHumLifeM = true
                                        end
                                        if isHumLifeM then
                                            isOkCM = true
                                        end
                                    end
                                end
                            end
                        end
                        
                        if isOkCM then
                            local espPM = EspDataStorage[playerM]
                            local isNotEspPM = false
                            if not espPM then
                                isNotEspPM = true
                            end
                            if isNotEspPM then 
                                CreateESPLogic(playerM) 
                            end
                            local espM = EspDataStorage[playerM]
                            
                            local isChamsStM = GlobalState.ESP_Chams
                            if isChamsStM then
                                local hlPM = espM.Highlight.Parent
                                local isNotCharM = false
                                if hlPM ~= charM then
                                    isNotCharM = true
                                end
                                if isNotCharM then 
                                    espM.Highlight.Parent = charM 
                                end
                            end
                            local isNotChamsStM = false
                            if not isChamsStM then
                                isNotChamsStM = true
                            end
                            if isNotChamsStM then
                                local hlPM2 = espM.Highlight.Parent
                                if hlPM2 then 
                                    espM.Highlight.Parent = nil 
                                end
                            end
                            
                            if isHasDrawingApi then
                                local rPosM = rootM.Position
                                local rootPosM, onScreenM = CameraInstance:WorldToViewportPoint(rPosM)
                                local hdPosCM = headM.Position
                                local hdOffsetM = Vector3.new(0, 0.5, 0)
                                local headPosCM = hdPosCM + hdOffsetM
                                local headPosM, zGarbage1 = CameraInstance:WorldToViewportPoint(headPosCM)
                                local legOffsetM = Vector3.new(0, 3, 0)
                                local legPosCM = rPosM - legOffsetM
                                local legPosM, zGarbage2 = CameraInstance:WorldToViewportPoint(legPosCM)
                                
                                if onScreenM then
                                    local hdYM = headPosM.Y
                                    local lgYM = legPosM.Y
                                    local ySubM = hdYM - lgYM
                                    local boxHeightM = math.abs(ySubM)
                                    local boxWidthM = boxHeightM / 2
                                    
                                    local bVecM = Vector2.new(boxWidthM, boxHeightM)
                                    espM.Box.Size = bVecM
                                    local rtXM = rootPosM.X
                                    local bW2M = boxWidthM / 2
                                    local xSubM = rtXM - bW2M
                                    local pVecM = Vector2.new(xSubM, hdYM)
                                    espM.Box.Position = pVecM
                                    local esBxStM = GlobalState.ESP_Box
                                    espM.Box.Visible = esBxStM
                                    
                                    local trFM = Vector2.new(cxCam, CameraInstance.ViewportSize.Y)
                                    espM.Tracer.From = trFM
                                    local trTM = Vector2.new(rtXM, lgYM)
                                    espM.Tracer.To = trTM
                                    local esTrStM = GlobalState.ESP_Tracer
                                    espM.Tracer.Visible = esTrStM
                                    
                                    local hHM = humM.Health
                                    local mHM = humM.MaxHealth
                                    local hpM = hHM / mHM
                                    local hhM = boxHeightM * hpM
                                    
                                    local hbgFM = Vector2.new(espM.Box.Position.X - 5, lgYM)
                                    espM.HealthBg.From = hbgFM
                                    local hbgTM = Vector2.new(espM.Box.Position.X - 5, hdYM)
                                    espM.HealthBg.To = hbgTM
                                    local esHlStM = GlobalState.ESP_Health
                                    espM.HealthBg.Visible = esHlStM
                                    
                                    local hflFM = Vector2.new(espM.Box.Position.X - 5, lgYM)
                                    espM.HealthFill.From = hflFM
                                    local lgSubHHM = lgYM - hhM
                                    local hflTM = Vector2.new(espM.Box.Position.X - 5, lgSubHHM)
                                    espM.HealthFill.To = hflTM
                                    
                                    local hpMMult = hpM * 255
                                    local rColM = 255 - hpMMult
                                    local gColM = hpMMult
                                    local finalColM = Color3.fromRGB(rColM, gColM, 0)
                                    espM.HealthFill.Color = finalColM
                                    espM.HealthFill.Visible = esHlStM
                                    
                                    local camPM = CameraInstance.CFrame.Position
                                    local dSubM = camPM - rPosM
                                    local dMagM = dSubM.Magnitude
                                    local distMathM = math.floor(dMagM)
                                    local pNameM = playerM.DisplayName
                                    local fTxtM = pNameM .. " [" .. distMathM .. "m]"
                                    espM.Text.Text = fTxtM
                                    local hdY20M = hdYM - 20
                                    local tVecM = Vector2.new(rtXM, hdY20M)
                                    espM.Text.Position = tVecM
                                    local esNmStM = GlobalState.ESP_Name
                                    espM.Text.Visible = esNmStM
                                end
                                local isNotOnScreenM = false
                                if not onScreenM then
                                    isNotOnScreenM = true
                                end
                                if isNotOnScreenM then
                                    espM.Box.Visible = false
                                    espM.Tracer.Visible = false
                                    espM.HealthBg.Visible = false
                                    espM.HealthFill.Visible = false
                                    espM.Text.Visible = false
                                end
                            end
                        end
                        
                        local notOkCM = false
                        if not isOkCM then
                            notOkCM = true
                        end
                        
                        if notOkCM then
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
            local isNotEspStOnM = false
            if not isEspStOnM then
                isNotEspStOnM = true
            end
            if isNotEspStOnM then
                local espDM = EspDataStorage
                for playerRm, zValRm in pairs(espDM) do 
                    RemoveESPLogic(playerRm) 
                end
            end
        end)
    end)

    local flingBavInst = nil
    local flingV3ConnInst = nil

    local connRsFling = RunServiceAPI.RenderStepped:Connect(function()
        local successRsFlg, errorRsFlg = pcall(function()
            local charFlgRs = LocalPlayerInstance.Character
            local hrpFlgRs = nil
            if charFlgRs then
                local hTempFlgRs = charFlgRs:FindFirstChild("HumanoidRootPart")
                hrpFlgRs = hTempFlgRs
            end
            
            local f2OnRs = GlobalState.FlingV2
            local sfOnRs = GlobalState.SuperFling
            local isFlingOnRs = false
            if f2OnRs then
                isFlingOnRs = true
            end
            if sfOnRs then
                isFlingOnRs = true
            end
            
            if isFlingOnRs then
                if hrpFlgRs then
                    local isNotBavFlgRs = false
                    if not flingBavInst then
                        isNotBavFlgRs = true
                    end
                    if isNotBavFlgRs then
                        local bNewFlgRs = Instance.new("BodyAngularVelocity")
                        flingBavInst = bNewFlgRs
                        flingBavInst.Name = "XayzFling"
                        local mHFlgRs = math.huge
                        local tqVecFlgRs = Vector3.new(0, mHFlgRs, 0)
                        flingBavInst.MaxTorque = tqVecFlgRs
                        flingBavInst.P = mHFlgRs
                        flingBavInst.Parent = hrpFlgRs
                    end
                    
                    if sfOnRs then
                        local sfVecRs = Vector3.new(0, 999999, 0)
                        flingBavInst.AngularVelocity = sfVecRs
                    end
                    local isNotSfOnRs = false
                    if not sfOnRs then
                        isNotSfOnRs = true
                    end
                    if isNotSfOnRs then
                        local fSpdRs = GlobalState.FlingPower * 100
                        local fVecRs = Vector3.new(0, fSpdRs, 0)
                        flingBavInst.AngularVelocity = fVecRs
                    end
                end
            end
            local isNotFlingOnRs = false
            if not isFlingOnRs then
                isNotFlingOnRs = true
            end
            if isNotFlingOnRs then
                if flingBavInst then
                    flingBavInst:Destroy()
                    flingBavInst = nil
                end
                if hrpFlgRs then
                    local zVecRs = Vector3.new(0, 0, 0)
                    hrpFlgRs.RotVelocity = zVecRs
                end
            end

            local isFlgV3OnRs = GlobalState.FlingV3
            if isFlgV3OnRs then
                if hrpFlgRs then
                    local isNotFlgV3Conn = false
                    if not flingV3ConnInst then
                        isNotFlgV3Conn = true
                    end
                    if isNotFlgV3Conn then
                        local charDFlgV3 = charFlgRs:GetDescendants()
                        for _, vFlgV3 in pairs(charDFlgV3) do
                            local isBpFlgV3 = vFlgV3:IsA("BasePart")
                            if isBpFlgV3 then
                                local ppNewFlgV3 = PhysicalProperties.new(100, 0, 0, 0, 0)
                                vFlgV3.CustomPhysicalProperties = ppNewFlgV3
                            end
                        end
                        local evtTouchFlgV3 = hrpFlgRs.Touched
                        flingV3ConnInst = evtTouchFlgV3:Connect(function(hitFlgV3)
                            local successTouchV3, errorTouchV3 = pcall(function()
                                local pntFlgV3 = hitFlgV3.Parent
                                if pntFlgV3 then
                                    local pHumFlgV3 = pntFlgV3:FindFirstChild("Humanoid")
                                    local pNmFlgV3 = pntFlgV3.Name
                                    local lpNmFlgV3 = LocalPlayerInstance.Name
                                    local isNotLpFlgV3 = false
                                    if pNmFlgV3 ~= lpNmFlgV3 then
                                        isNotLpFlgV3 = true
                                    end
                                    if pHumFlgV3 then
                                        if isNotLpFlgV3 then
                                            local vRootFlgV3 = pntFlgV3:FindFirstChild("HumanoidRootPart")
                                            if vRootFlgV3 then
                                                local vVecFlgV3 = Vector3.new(999999999, 999999999, 999999999)
                                                vRootFlgV3.Velocity = vVecFlgV3
                                            end
                                        end
                                    end
                                end
                            end)
                        end)
                    end
                end
            end
            local isNotFlgV3OnRs = false
            if not isFlgV3OnRs then
                isNotFlgV3OnRs = true
            end
            if isNotFlgV3OnRs then
                if flingV3ConnInst then
                    flingV3ConnInst:Disconnect()
                    flingV3ConnInst = nil
                end
            end
        end)
    end)

    local connHbMisc = RunServiceAPI.Heartbeat:Connect(function()
        local successHbMisc, errorHbMisc = pcall(function()
            local charMisc = LocalPlayerInstance.Character
            if charMisc then
                local humMisc = charMisc:FindFirstChildOfClass("Humanoid")
                if humMisc then
                    local isHealLoopM = GlobalState.HealLoop
                    if isHealLoopM then
                        local mHlM = humMisc.MaxHealth
                        humMisc.Health = mHlM
                    end
                    local isGodModeM = GlobalState.GodModeV4
                    if isGodModeM then
                        local infHM = math.huge
                        humMisc.MaxHealth = infHM
                        humMisc.Health = infHM
                    end
                    
                    local wScM = humMisc:FindFirstChild("BodyWidthScale")
                    local dScM = humMisc:FindFirstChild("BodyDepthScale")
                    local wAvM = GlobalState.WideAvatar
                    
                    local isScValidM = false
                    if wScM then
                        if dScM then
                            isScValidM = true
                        end
                    end
                    
                    if isScValidM then
                        wScM.Value = wAvM
                        dScM.Value = wAvM
                    end
                end
            end
        end)
    end)

    local bhAngleLogic = 1
    local AnchorPartLogic = nil
    local AnchorAttLogic = nil

    local function GetAnchorSetupLogic()
        local isValAnc = false
        if AnchorPartLogic then
            if AnchorPartLogic.Parent then
                isValAnc = true
            end
        end
        local isNotValAnc = false
        if not isValAnc then
            isNotValAnc = true
        end
        if isNotValAnc then
            local fNewAnc = Instance.new("Folder")
            fNewAnc.Parent = WorkspaceService
            local pNewAnc = Instance.new("Part")
            AnchorPartLogic = pNewAnc
            AnchorPartLogic.Name = "XayzAnchor"
            AnchorPartLogic.Anchored = true
            AnchorPartLogic.CanCollide = false
            AnchorPartLogic.Transparency = 1
            AnchorPartLogic.Parent = fNewAnc
            
            local aNewAnc = Instance.new("Attachment")
            AnchorAttLogic = aNewAnc
            AnchorAttLogic.Parent = AnchorPartLogic
        end
        return AnchorPartLogic, AnchorAttLogic
    end

    local spawnBypass = task.spawn(function()
        local successBp, errorBp = pcall(function()
            local connHeartBp = RunServiceAPI.Heartbeat:Connect(function()
                local succSetH, errSetH = pcall(function()
                    local isSetHValid = false
                    if sethiddenproperty then
                        isSetHValid = true
                    end
                    if isSetHValid then
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
        local successFP, errorFP = pcall(function()
            local isPBH = vPartBH:IsA("Part")
            if isPBH then
                local isAncBH = vPartBH.Anchored
                local isNotAncBH = false
                if not isAncBH then
                    isNotAncBH = true
                end
                if isNotAncBH then
                    local pntBH = vPartBH.Parent
                    local fHumBH = nil
                    local fHdBH = nil
                    if pntBH then
                        local hmmBH = pntBH:FindFirstChild("Humanoid")
                        fHumBH = hmmBH
                        local hddBH = pntBH:FindFirstChild("Head")
                        fHdBH = hddBH
                    end
                    local isNotFHumBH = false
                    if not fHumBH then
                        isNotFHumBH = true
                    end
                    if isNotFHumBH then
                        local isNotFhDBH = false
                        if not fHdBH then
                            isNotFhDBH = true
                        end
                        if isNotFhDBH then
                            local vNmBH = vPartBH.Name
                            local isNotHandleBH = false
                            if vNmBH ~= "Handle" then
                                isNotHandleBH = true
                            end
                            if isNotHandleBH then
                                local chBH = vPartBH:GetChildren()
                                for _, xBH in pairs(chBH) do
                                    local b1BH = xBH:IsA("BodyAngularVelocity")
                                    local b2BH = xBH:IsA("BodyForce")
                                    local b3BH = xBH:IsA("BodyGyro")
                                    local b4BH = xBH:IsA("BodyPosition")
                                    local b5BH = xBH:IsA("BodyThrust")
                                    local b6BH = xBH:IsA("BodyVelocity")
                                    local b7BH = xBH:IsA("RocketPropulsion")
                                    local delBH = false
                                    if b1BH then
                                        delBH = true
                                    end
                                    if b2BH then
                                        delBH = true
                                    end
                                    if b3BH then
                                        delBH = true
                                    end
                                    if b4BH then
                                        delBH = true
                                    end
                                    if b5BH then
                                        delBH = true
                                    end
                                    if b6BH then
                                        delBH = true
                                    end
                                    if b7BH then
                                        delBH = true
                                    end
                                    if delBH then
                                        xBH:Destroy()
                                    end
                                end
                                local fABH = vPartBH:FindFirstChild("Attachment")
                                if fABH then
                                    fABH:Destroy()
                                end
                                local fAlBH = vPartBH:FindFirstChild("AlignPosition")
                                if fAlBH then
                                    fAlBH:Destroy()
                                end
                                local fTBH = vPartBH:FindFirstChild("Torque")
                                if fTBH then
                                    fTBH:Destroy()
                                end
                                
                                vPartBH.CanCollide = false
                                
                                local tqBH = Instance.new("Torque")
                                tqBH.Parent = vPartBH
                                local tqVBH = Vector3.new(1000000, 1000000, 1000000)
                                tqBH.Torque = tqVBH
                                
                                local alBH = Instance.new("AlignPosition")
                                alBH.Parent = vPartBH
                                local a2BH = Instance.new("Attachment")
                                a2BH.Parent = vPartBH
                                tqBH.Attachment0 = a2BH
                                
                                local mHgBH = math.huge
                                alBH.MaxForce = mHgBH
                                alBH.MaxVelocity = mHgBH
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

    local connHbCore = RunServiceAPI.Heartbeat:Connect(function()
        local successHbCore, errorHbCore = pcall(function()
            local charHb = LocalPlayerInstance.Character
            local isNotCharHb = false
            if not charHb then
                isNotCharHb = true
            end
            if isNotCharHb then 
                return 
            end
            
            local armJointHb = nil
            local uTorsoHb = charHb:FindFirstChild("UpperTorso")
            local isR15Hb = false
            if uTorsoHb then
                isR15Hb = true
            end
            
            if isR15Hb then
                local rArmHb = charHb:FindFirstChild("RightUpperArm")
                if rArmHb then 
                    local rShoHb = rArmHb:FindFirstChild("RightShoulder")
                    armJointHb = rShoHb 
                end
            end
            local isNotR15Hb = false
            if not isR15Hb then
                isNotR15Hb = true
            end
            if isNotR15Hb then
                local torsoHb = charHb:FindFirstChild("Torso")
                if torsoHb then 
                    local rShoHb2 = torsoHb:FindFirstChild("Right Shoulder")
                    armJointHb = rShoHb2 
                end
            end

            if armJointHb then
                local attC0Hb = armJointHb:GetAttribute("OriginalC0")
                local isNotAttC0Hb = false
                if not attC0Hb then
                    isNotAttC0Hb = true
                end
                if isNotAttC0Hb then
                    local currC0Hb = armJointHb.C0
                    armJointHb:SetAttribute("OriginalC0", currC0Hb)
                    attC0Hb = currC0Hb
                end

                local isArmAnimHb = GlobalState.ArmAnim
                if isArmAnimHb then
                    local tcMHb = tick() * GlobalState.ArmSpeed
                    local mSinHb = math.sin(tcMHb)
                    local moveHb = mSinHb * GlobalState.ArmIntensity
                    
                    if isR15Hb then
                        local cfNHb1 = CFrame.new(0, moveHb, -0.5)
                        local mRadHb1 = math.rad(-90)
                        local cfAHb1 = CFrame.Angles(mRadHb1, 0, 0)
                        local cfCHb1 = attC0Hb * cfNHb1
                        local cfFHb1 = cfCHb1 * cfAHb1
                        armJointHb.C0 = cfFHb1
                    end
                    local isNotR15Hb2 = false
                    if not isR15Hb then
                        isNotR15Hb2 = true
                    end
                    if isNotR15Hb2 then
                        local cfNHb2 = CFrame.new(-0.2, moveHb, -0.5)
                        local mRadHb2 = math.rad(-90)
                        local mRadHb3 = math.rad(20)
                        local cfAHb2 = CFrame.Angles(mRadHb2, mRadHb3, 0)
                        local cfCHb2 = attC0Hb * cfNHb2
                        local cfFHb2 = cfCHb2 * cfAHb2
                        armJointHb.C0 = cfFHb2
                    end
                end
                local isNotArmAnimHb = false
                if not isArmAnimHb then
                    isNotArmAnimHb = true
                end
                if isNotArmAnimHb then
                    armJointHb.C0 = attC0Hb
                end
            end
            
            local isHdAdminHb = GlobalState.HDAdmin
            if isHdAdminHb then
                local isNotHdFiredSt = false
                if not hdFiredSt then
                    isNotHdFiredSt = true
                end
                if isNotHdFiredSt then
                    local rsRepHb = game:GetService("ReplicatedStorage")
                    local hdCHb = rsRepHb:FindFirstChild("HDAdminClient")
                    if hdCHb then
                        local succHD2, errHD2 = pcall(function()
                            local psPlHb = LocalPlayerInstance.PlayerScripts
                            local hdC2Hb = psPlHb:WaitForChild("HDAdminClient")
                            local mainWHb = hdC2Hb:WaitForChild("Main")
                            local mainModuleHb = require(mainWHb)
                            local stRankHb = mainModuleHb.Settings
                            stRankHb.Rank = 5
                            stRankHb.RankName = "The King Xayz"
                            
                            local remoteHb = rsRepHb:FindFirstChild("HDAdminRemote")
                            if remoteHb then
                                local tbAHb = {"Rank", LocalPlayerInstance, 5}
                                remoteHb:FireServer(unpack(tbAHb)) 
                            end
                        end)
                    end
                    hdFiredSt = true
                end
            end
            local isNotHdAdminHb = false
            if not isHdAdminHb then
                isNotHdAdminHb = true
            end
            if isNotHdAdminHb then
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
                
                local dAnStHb = GlobalState.DinoAnim
                if dAnStHb then
                    local isNotDPlyHb = false
                    if not isDPlyHb then
                        isNotDPlyHb = true
                    end
                    if isNotDPlyHb then
                        local hRigHb = humHb.RigType
                        local isR15RigHb = false
                        if hRigHb == Enum.HumanoidRigType.R15 then
                            isR15RigHb = true
                        end
                        if isR15RigHb then
                            local tLHb1 = humHb:LoadAnimation(dinoAnimR15Ins)
                            dTrackIns = tLHb1
                        end
                        local isNotR15RigHb = false
                        if hRigHb ~= Enum.HumanoidRigType.R15 then
                            isNotR15RigHb = true
                        end
                        if isNotR15RigHb then
                            local tLHb2 = humHb:LoadAnimation(dinoAnimR6Ins)
                            dTrackIns = tLHb2
                        end
                        dTrackIns:Play()
                    end
                end
                local isNotDanStHb = false
                if not dAnStHb then
                    isNotDanStHb = true
                end
                if isNotDanStHb then
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
                
                local pAnStHb = GlobalState.PunchAnim
                if pAnStHb then
                    local isNotPPlyHb = false
                    if not isPPlyHb then
                        isNotPPlyHb = true
                    end
                    if isNotPPlyHb then
                        local tLHb3 = humHb:LoadAnimation(punchAnimationIns)
                        pTrackIns = tLHb3
                        pTrackIns:Play()
                    end
                end
                local isNotPAnStHb = false
                if not pAnStHb then
                    isNotPAnStHb = true
                end
                if isNotPAnStHb then
                    if isPPlyHb then
                        pTrackIns:Stop()
                    end
                end
            end

            local hrpHb = charHb:FindFirstChild("HumanoidRootPart")
            local isNotHrpHb = false
            if not hrpHb then
                isNotHrpHb = true
            end
            if isNotHrpHb then 
                return 
            end

            local isFfHb = GlobalState.ForceField
            if isFfHb then
                local xffHb = charHb:FindFirstChild("XayzFF")
                local isNotXffHb = false
                if not xffHb then
                    isNotXffHb = true
                end
                if isNotXffHb then
                    local ffNHb = Instance.new("ForceField")
                    ffNHb.Name = "XayzFF"
                    ffNHb.Visible = true
                    ffNHb.Parent = charHb
                end
            end
            local isNotFfHb = false
            if not isFfHb then
                isNotFfHb = true
            end
            if isNotFfHb then
                local xffHb2 = charHb:FindFirstChild("XayzFF")
                if xffHb2 then 
                    xffHb2:Destroy() 
                end
            end

            local ancPtHb, ancAttHb = GetAnchorSetupLogic()

            local isBhHb = GlobalState.Blackhole
            if isBhHb then
                local wsDescHb = WorkspaceService:GetDescendants()
                for _, vHb in pairs(wsDescHb) do
                    ForcePartBHLogic(vHb, ancAttHb)
                end
                
                local bhRad2Hb = math.rad(2)
                bhAngleLogic = bhAngleLogic + bhRad2Hb
                
                local mCosHb = math.cos(bhAngleLogic)
                local sDistHb = GlobalState.BlackholeDistance
                local offXHb = mCosHb * sDistHb
                
                local mSinHb = math.sin(bhAngleLogic)
                local offZHb = mSinHb * sDistHb
                
                local hrpCFHb = hrpHb.CFrame
                local offCFHb = CFrame.new(offXHb, 0, offZHb)
                local wCFHb = hrpCFHb * offCFHb
                ancAttHb.WorldCFrame = wCFHb

            end
            
            local isRingHb = GlobalState.SuperRing
            if isRingHb then
                local tCenterHb = hrpHb.Position
                local unPartsHb = {}
                local wsDescHb2 = WorkspaceService:GetDescendants()
                for _, vHb2 in pairs(wsDescHb2) do
                    local isBPHb2 = vHb2:IsA("BasePart")
                    if isBPHb2 then
                        local isAncHb2 = vHb2.Anchored
                        local isNotAncHb2 = false
                        if not isAncHb2 then
                            isNotAncHb2 = true
                        end
                        if isNotAncHb2 then
                            local pntHb2 = vHb2.Parent
                            local fHumHb2 = nil
                            if pntHb2 then
                                fHumHb2 = pntHb2:FindFirstChild("Humanoid")
                            end
                            local isNotFHumHb2 = false
                            if not fHumHb2 then
                                isNotFHumHb2 = true
                            end
                            if isNotFHumHb2 then
                                local fHdHb2 = nil
                                if pntHb2 then
                                    fHdHb2 = pntHb2:FindFirstChild("Head")
                                end
                                local isNotFhdHb2 = false
                                if not fHdHb2 then
                                    isNotFhdHb2 = true
                                end
                                if isNotFhdHb2 then
                                    local vNmHb2 = vHb2.Name
                                    local isNotHandleHb2 = false
                                    if vNmHb2 ~= "Handle" then
                                        isNotHandleHb2 = true
                                    end
                                    if isNotHandleHb2 then
                                        local isLpHb2 = false
                                        local lpCharHb2 = LocalPlayerInstance.Character
                                        if pntHb2 == lpCharHb2 then
                                            isLpHb2 = true
                                        end
                                        local isDHb2 = false
                                        if lpCharHb2 then
                                            isDHb2 = vHb2:IsDescendantOf(lpCharHb2)
                                        end
                                        if isDHb2 then
                                            isLpHb2 = true
                                        end
                                        local isNotLpHb2 = false
                                        if not isLpHb2 then
                                            isNotLpHb2 = true
                                        end
                                        if isNotLpHb2 then
                                            table.insert(unPartsHb, vHb2)
                                            
                                            local fAlgnHb2 = vHb2:FindFirstChild("AlignPosition")
                                            if fAlgnHb2 then
                                                fAlgnHb2:Destroy()
                                            end
                                            local fTqHb2 = vHb2:FindFirstChild("Torque")
                                            if fTqHb2 then
                                                fTqHb2:Destroy()
                                            end
                                            local atCHb2 = vHb2:FindFirstChildOfClass("Attachment")
                                            if atCHb2 then
                                                local isAtAlgHb2 = atCHb2:FindFirstChildOfClass("AlignPosition")
                                                local isNotAtAlgHb2 = false
                                                if not isAtAlgHb2 then
                                                    isNotAtAlgHb2 = true
                                                end
                                                if isNotAtAlgHb2 then
                                                    atCHb2:Destroy()
                                                end
                                            end
                                            
                                            local ppHb2 = PhysicalProperties.new(0,0,0,0,0)
                                            vHb2.CustomPhysicalProperties = ppHb2
                                            vHb2.CanCollide = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                local tPartsHb = #unPartsHb
                for iHb, ptHb in pairs(unPartsHb) do
                    local ptPosHb = ptHb.Position
                    local vXZHb = Vector3.new(ptPosHb.X, tCenterHb.Y, ptPosHb.Z)
                    local tSubHb = vXZHb - tCenterHb
                    local distHb = tSubHb.Magnitude
                    
                    local zSubHb = ptPosHb.Z - tCenterHb.Z
                    local xSubHb = ptPosHb.X - tCenterHb.X
                    local atanHb = math.atan2(zSubHb, xSubHb)
                    
                    local rSpdHb = GlobalState.RingSpeed
                    local mRadHb4 = math.rad(rSpdHb)
                    local newAngHb = atanHb + mRadHb4
                    
                    local rDisHb = GlobalState.RingDistance
                    local minDHb = math.min(rDisHb, distHb)
                    local mCosHb2 = math.cos(newAngHb)
                    local tXHb = tCenterHb.X + (mCosHb2 * minDHb)
                    
                    local ySubHb = ptPosHb.Y - tCenterHb.Y
                    local rHeiHb = GlobalState.RingHeight
                    local hDivHb = ySubHb / rHeiHb
                    local hSinHb = math.sin(hDivHb)
                    local hAbsHb = math.abs(hSinHb)
                    local hMultHb = rHeiHb * hAbsHb
                    local tYHb = tCenterHb.Y + hMultHb
                    
                    local mSinHb2 = math.sin(newAngHb)
                    local tZHb = tCenterHb.Z + (mSinHb2 * minDHb)
                    
                    local tarPosHb = Vector3.new(tXHb, tYHb, tZHb)
                    local dirSubHb = tarPosHb - ptPosHb
                    local dirUnHb = dirSubHb.Unit
                    
                    local rAttHb = GlobalState.RingAttraction
                    local fVelHb = dirUnHb * rAttHb
                    ptHb.Velocity = fVelHb
                end
            end
            
            local notBhHb = false
            if not GlobalState.Blackhole then
                notBhHb = true
            end
            local notSrHb = false
            if not GlobalState.SuperRing then
                notSrHb = true
            end
            local offAllHb = false
            if notBhHb then
                if notSrHb then
                    offAllHb = true
                end
            end
            
            if offAllHb then
                local wsDescHb3 = WorkspaceService:GetDescendants()
                for _, vHb3 in pairs(wsDescHb3) do
                    local isBPartHb3 = vHb3:IsA("Part")
                    if isBPartHb3 then
                        local fAlgnHb3 = vHb3:FindFirstChild("AlignPosition")
                        if fAlgnHb3 then
                            fAlgnHb3:Destroy()
                            local fTqHb3 = vHb3:FindFirstChild("Torque")
                            if fTqHb3 then 
                                fTqHb3:Destroy() 
                            end
                        end
                    end
                end
                local fAncHb = WorkspaceService:FindFirstChild("XayzAnchor")
                if fAncHb then
                    local zPosHb = CFrame.new(0, -1000, 0)
                    fAncHb.CFrame = zPosHb
                end
            end
        end)
    end)
end

local function InitSafe()
    local successInit, errorInit = pcall(function()
        SafeExecuteScript()
    end)
end

InitSafe()