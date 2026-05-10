local ServiceCoreGui = nil
pcall(function()
    local getGuiService = game:GetService("CoreGui")
    ServiceCoreGui = getGuiService
end)

local ServicePlayers = game:GetService("Players")
local ServiceRun = game:GetService("RunService")
local ServiceUserInput = game:GetService("UserInputService")
local ServiceTween = game:GetService("TweenService")
local ServiceWorkspace = game:GetService("Workspace")
local ServiceHttp = game:GetService("HttpService")
local ServiceLog = game:GetService("LogService")
local ServiceMarketplace = game:GetService("MarketplaceService")
local ServiceGui = game:GetService("GuiService")
local ServiceReplicatedStorage = game:GetService("ReplicatedStorage")
local ServiceTextChat = game:GetService("TextChatService")

local PlayerLocal = ServicePlayers.LocalPlayer
local CameraCurrent = ServiceWorkspace.CurrentCamera
if not CameraCurrent then
    local findCamera = ServiceWorkspace:FindFirstChild("Camera")
    CameraCurrent = findCamera
end

task.spawn(function()
    pcall(function()
        local ColorIdleButton = Color3.fromRGB(34, 214, 78)
        local ColorHoverButton = Color3.fromRGB(42, 232, 90)
        local ColorIdleCopy = Color3.fromRGB(255, 154, 46)
        local ColorHoverCopy = Color3.fromRGB(255, 176, 84)
        local ColorIdleAuto = Color3.fromRGB(210, 72, 72)
        local ColorHoverAuto = Color3.fromRGB(232, 98, 98)
        
        local TweenSpeedPass = TweenInfo.new(0.045, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local LastPromptId = nil
        local LastPromptType = nil
        local AutoRunningState = false
        local AutoThreadIdentity = 0
        local StopGuiInstance = nil

        local function TweenColorElement(elementTarget, colorTarget)
            if elementTarget then
                if elementTarget.Parent then
                    local propertiesToTween = {}
                    if elementTarget:IsA("GuiObject") then
                        propertiesToTween.BackgroundColor3 = colorTarget
                    end
                    if elementTarget:IsA("ImageButton") then
                        propertiesToTween.ImageColor3 = colorTarget
                    end
                    if elementTarget:IsA("ImageLabel") then
                        propertiesToTween.ImageColor3 = colorTarget
                    end
                    local createTweenPass = ServiceTween:Create(elementTarget, TweenSpeedPass, propertiesToTween)
                    createTweenPass:Play()
                end
            end
        end

        local function ApplyVisualColorState(rootElement, colorTarget)
            TweenColorElement(rootElement, colorTarget)
            local descendantsRoot = rootElement:GetDescendants()
            for indexDescendant, elementDescendant in ipairs(descendantsRoot) do
                if elementDescendant:IsA("ImageLabel") then
                    TweenColorElement(elementDescendant, colorTarget)
                end
                if elementDescendant:IsA("ImageButton") then
                    TweenColorElement(elementDescendant, colorTarget)
                end
                if elementDescendant:IsA("Frame") then
                    TweenColorElement(elementDescendant, colorTarget)
                end
            end
        end

        local function CapturePromptAction(playerTarget, idTarget, typePrompt)
            if playerTarget == PlayerLocal then
                LastPromptId = idTarget
                LastPromptType = typePrompt
            end
        end

        ServiceMarketplace.PromptGamePassPurchaseRequested:Connect(function(playerTarget, idTarget)
            CapturePromptAction(playerTarget, idTarget, "GamePass")
        end)

        ServiceMarketplace.PromptProductPurchaseRequested:Connect(function(playerTarget, idTarget)
            CapturePromptAction(playerTarget, idTarget, "Product")
        end)

        ServiceMarketplace.PromptPurchaseRequested:Connect(function(playerTarget, idTarget)
            CapturePromptAction(playerTarget, idTarget, "Asset")
        end)

        ServiceMarketplace.PromptBundlePurchaseRequested:Connect(function(playerTarget, idTarget)
            CapturePromptAction(playerTarget, idTarget, "Bundle")
        end)

        ServiceMarketplace.PromptPremiumPurchaseRequested:Connect(function(playerTarget)
            CapturePromptAction(playerTarget, 0, "Premium")
        end)

        local function FinishPurchaseAction(idTarget)
            if LastPromptType == "GamePass" then
                pcall(function()
                    ServiceMarketplace:SignalPromptGamePassPurchaseFinished(PlayerLocal.UserId, idTarget, true)
                end)
            end
            if LastPromptType == "Product" then
                pcall(function()
                    ServiceMarketplace:SignalPromptProductPurchaseFinished(PlayerLocal.UserId, idTarget, true)
                end)
            end
            if LastPromptType == "Asset" then
                pcall(function()
                    ServiceMarketplace:SignalPromptPurchaseFinished(PlayerLocal.UserId, idTarget, true)
                end)
            end
            if LastPromptType == "Bundle" then
                pcall(function()
                    ServiceMarketplace:SignalPromptBundlePurchaseFinished(PlayerLocal.UserId, idTarget, true)
                end)
            end
            if LastPromptType == "Premium" then
                pcall(function()
                    ServiceMarketplace:SignalPromptPremiumPurchaseFinished(true)
                end)
            end
        end

        local function BuildPurchaseOperationString(idTarget)
            local stringCode = "local MarketplaceService = game:GetService(\"MarketplaceService\")\n\n"
            if LastPromptType == "GamePass" then
                local formattedString = string.format("MarketplaceService:SignalPromptGamePassPurchaseFinished(%d, %d, true)", PlayerLocal.UserId, idTarget)
                return stringCode .. formattedString
            end
            if LastPromptType == "Product" then
                local formattedString = string.format("MarketplaceService:SignalPromptProductPurchaseFinished(%d, %d, true)", PlayerLocal.UserId, idTarget)
                return stringCode .. formattedString
            end
            if LastPromptType == "Asset" then
                local formattedString = string.format("MarketplaceService:SignalPromptPurchaseFinished(%d, %d, true)", PlayerLocal.UserId, idTarget)
                return stringCode .. formattedString
            end
            if LastPromptType == "Bundle" then
                local formattedString = string.format("MarketplaceService:SignalPromptBundlePurchaseFinished(%d, %d, true)", PlayerLocal.UserId, idTarget)
                return stringCode .. formattedString
            end
            if LastPromptType == "Premium" then
                local premiumString = "MarketplaceService:SignalPromptPremiumPurchaseFinished(true)"
                return stringCode .. premiumString
            end
            return ""
        end

        local function StopAutoLoopAction()
            AutoRunningState = false
            AutoThreadIdentity = AutoThreadIdentity + 1
        end

        local function DestroyAutoStopGuiAction()
            if StopGuiInstance then
                if StopGuiInstance.Parent then
                    StopGuiInstance:Destroy()
                end
            end
            StopGuiInstance = nil
        end

        local function ToggleRobloxMenuAction()
            pcall(function()
                ServiceGui:SetMenuIsOpen(true)
                ServiceGui:SetMenuIsOpen(false)
            end)
        end

        local function StartAutoLoopAction()
            if not AutoRunningState then
                AutoRunningState = true
                AutoThreadIdentity = AutoThreadIdentity + 1
                local identityThreadLocal = AutoThreadIdentity
                task.spawn(function()
                    while AutoRunningState do
                        if AutoThreadIdentity == identityThreadLocal then
                            local identityPrompt = LastPromptId
                            if identityPrompt then
                                FinishPurchaseAction(identityPrompt)
                                ToggleRobloxMenuAction()
                            end
                            task.wait(0.3)
                        end
                        if AutoThreadIdentity ~= identityThreadLocal then
                            break
                        end
                    end
                end)
            end
        end

        local function MakeAutoGuiDraggable(frameTarget)
            local draggingElement = false
            local dragInputElement = nil
            local dragStartElement = nil
            local startPosElement = nil
            local didDragElement = false
            
            frameTarget.InputBegan:Connect(function(inputTarget)
                if inputTarget.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingElement = true
                    didDragElement = false
                    dragStartElement = inputTarget.Position
                    startPosElement = frameTarget.Position
                end
                if inputTarget.UserInputType == Enum.UserInputType.Touch then
                    draggingElement = true
                    didDragElement = false
                    dragStartElement = inputTarget.Position
                    startPosElement = frameTarget.Position
                end
            end)

            frameTarget.InputEnded:Connect(function(inputTarget)
                if inputTarget.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingElement = false
                end
                if inputTarget.UserInputType == Enum.UserInputType.Touch then
                    draggingElement = false
                end
            end)

            frameTarget.InputChanged:Connect(function(inputTarget)
                if inputTarget.UserInputType == Enum.UserInputType.MouseMovement then
                    dragInputElement = inputTarget
                end
                if inputTarget.UserInputType == Enum.UserInputType.Touch then
                    dragInputElement = inputTarget
                end
            end)

            ServiceUserInput.InputChanged:Connect(function(inputTarget)
                if draggingElement then
                    if inputTarget == dragInputElement then
                        local deltaDrag = inputTarget.Position - dragStartElement
                        if math.abs(deltaDrag.X) > 6 then
                            didDragElement = true
                        end
                        if math.abs(deltaDrag.Y) > 6 then
                            didDragElement = true
                        end
                        local positionX = startPosElement.X.Offset + deltaDrag.X
                        local positionY = startPosElement.Y.Offset + deltaDrag.Y
                        local newPosition = UDim2.new(startPosElement.X.Scale, positionX, startPosElement.Y.Scale, positionY)
                        frameTarget.Position = newPosition
                    end
                end
            end)

            return function()
                local wasDraggedElement = didDragElement
                didDragElement = false
                return wasDraggedElement
            end
        end

        local function CreateAutoStopButtonAction()
            DestroyAutoStopGuiAction()
            local guiScreenStop = Instance.new("ScreenGui")
            guiScreenStop.Name = "AutoStopButtonProtected"
            guiScreenStop.IgnoreGuiInset = true
            guiScreenStop.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            guiScreenStop.Parent = ServiceCoreGui

            local buttonStop = Instance.new("TextButton")
            buttonStop.Name = "ButtonMain"
            buttonStop.Parent = guiScreenStop
            buttonStop.AnchorPoint = Vector2.new(0.5, 0.5)
            buttonStop.Position = UDim2.new(0.5, 0, 0, 34)
            buttonStop.Size = UDim2.new(0.039, 0, 0.069, 0)
            buttonStop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            buttonStop.BackgroundTransparency = 0.4
            buttonStop.BorderSizePixel = 0
            buttonStop.AutoButtonColor = false
            buttonStop.ZIndex = 99999999
            buttonStop.Text = ""

            local cornerStop = Instance.new("UICorner")
            cornerStop.CornerRadius = UDim.new(0, 99999)
            cornerStop.Parent = buttonStop

            local iconStop = Instance.new("ImageLabel")
            iconStop.Parent = buttonStop
            iconStop.BackgroundTransparency = 1
            iconStop.Position = UDim2.new(0.1, 0, 0.1, 0)
            iconStop.Size = UDim2.new(0.8, 0, 0.8, 0)
            iconStop.Image = "rbxassetid://98003862321782"
            iconStop.ImageColor3 = Color3.fromRGB(255, 90, 90)

            local constraintStop = Instance.new("UIAspectRatioConstraint")
            constraintStop.Parent = buttonStop
            constraintStop.AspectRatio = 1

            local checkWasDragged = MakeAutoGuiDraggable(buttonStop)

            buttonStop.Activated:Connect(function()
                local resultDragged = checkWasDragged()
                if not resultDragged then
                    StopAutoLoopAction()
                    DestroyAutoStopGuiAction()
                end
            end)

            StopGuiInstance = guiScreenStop
        end

        local function DecorateInjectedButton(buttonTarget, stringText, indexZ, colorPaletteTarget)
            buttonTarget.Visible = true
            buttonTarget.Active = true
            buttonTarget.Selectable = true
            buttonTarget.AutoButtonColor = false
            buttonTarget.ZIndex = indexZ
            buttonTarget.BackgroundColor3 = colorPaletteTarget
            buttonTarget.BackgroundTransparency = 0.1
            pcall(function()
                buttonTarget.Interactable = true
            end)
            if buttonTarget:IsA("ImageButton") then
                buttonTarget.ImageColor3 = colorPaletteTarget
            end

            local descendantsButton = buttonTarget:GetDescendants()
            for indexElement, elementTarget in ipairs(descendantsButton) do
                if elementTarget:IsA("LocalScript") then
                    elementTarget:Destroy()
                end
                if elementTarget:IsA("Script") then
                    elementTarget:Destroy()
                end
                if elementTarget:IsA("ModuleScript") then
                    elementTarget:Destroy()
                end
                if elementTarget:IsA("GuiObject") then
                    local mathZ = math.max(elementTarget.ZIndex, buttonTarget.ZIndex)
                    elementTarget.ZIndex = mathZ
                    elementTarget.Active = true
                    pcall(function()
                        elementTarget.Interactable = true
                    end)
                    if elementTarget:IsA("TextLabel") then
                        elementTarget.Text = stringText
                        elementTarget.TextTransparency = 0
                    end
                    if elementTarget:IsA("TextButton") then
                        elementTarget.Text = stringText
                        elementTarget.TextTransparency = 0
                    end
                end
            end
        end

        local function InjectButtonsAction(originalButtonElement)
            if originalButtonElement then
                if originalButtonElement.Name ~= "FreeButton" then
                    if originalButtonElement.Name ~= "CopyButton" then
                        if originalButtonElement.Name ~= "AutoButton" then
                            local parentButtonElement = originalButtonElement.Parent
                            if parentButtonElement then
                                local checkFreeButton = parentButtonElement:FindFirstChild("FreeButton")
                                if not checkFreeButton then
                                    task.wait(0.01)
                                    local cloneFreeButton = originalButtonElement:Clone()
                                    cloneFreeButton.Name = "FreeButton"
                                    cloneFreeButton.Parent = parentButtonElement
                                    local zIndexFree = 1
                                    if originalButtonElement.ZIndex then
                                        zIndexFree = originalButtonElement.ZIndex
                                    end
                                    local finalZIndexFree = zIndexFree + 10
                                    DecorateInjectedButton(cloneFreeButton, "Free", finalZIndexFree, ColorIdleButton)
                                    
                                    cloneFreeButton.MouseEnter:Connect(function()
                                        ApplyVisualColorState(cloneFreeButton, ColorHoverButton)
                                    end)
                                    cloneFreeButton.MouseLeave:Connect(function()
                                        ApplyVisualColorState(cloneFreeButton, ColorIdleButton)
                                    end)
                                    cloneFreeButton.Activated:Connect(function()
                                        local idCheck = LastPromptId
                                        if idCheck then
                                            ApplyVisualColorState(cloneFreeButton, ColorHoverButton)
                                            FinishPurchaseAction(idCheck)
                                            ApplyVisualColorState(cloneFreeButton, ColorIdleButton)
                                            ToggleRobloxMenuAction()
                                        end
                                    end)
                                end

                                local checkCopyButton = parentButtonElement:FindFirstChild("CopyButton")
                                if not checkCopyButton then
                                    task.wait(0.01)
                                    local cloneCopyButton = originalButtonElement:Clone()
                                    cloneCopyButton.Name = "CopyButton"
                                    cloneCopyButton.Parent = parentButtonElement
                                    local checkFreeForZ = parentButtonElement:FindFirstChild("FreeButton")
                                    local zIndexCopy = 1
                                    if checkFreeForZ then
                                        zIndexCopy = checkFreeForZ.ZIndex
                                    end
                                    if not checkFreeForZ then
                                        if originalButtonElement.ZIndex then
                                            zIndexCopy = originalButtonElement.ZIndex + 10
                                        end
                                    end
                                    DecorateInjectedButton(cloneCopyButton, "Copy", zIndexCopy, ColorIdleCopy)
                                    
                                    cloneCopyButton.MouseEnter:Connect(function()
                                        ApplyVisualColorState(cloneCopyButton, ColorHoverCopy)
                                    end)
                                    cloneCopyButton.MouseLeave:Connect(function()
                                        ApplyVisualColorState(cloneCopyButton, ColorIdleCopy)
                                    end)
                                    
                                    local checkLayoutCopy = parentButtonElement:FindFirstChildOfClass("UIListLayout")
                                    if checkLayoutCopy then
                                        local orderCopy = 0
                                        if checkFreeForZ then
                                            if checkFreeForZ.LayoutOrder then
                                                orderCopy = checkFreeForZ.LayoutOrder
                                            end
                                        end
                                        cloneCopyButton.LayoutOrder = orderCopy + 1
                                    end
                                    if not checkLayoutCopy then
                                        if checkFreeForZ then
                                            local posFreeCopy = checkFreeForZ.Position
                                            local offFreeCopy = UDim2.fromOffset(0, 42)
                                            cloneCopyButton.Position = posFreeCopy + offFreeCopy
                                        end
                                    end

                                    cloneCopyButton.Activated:Connect(function()
                                        local idCheckCopy = LastPromptId
                                        if idCheckCopy then
                                            local textOperation = BuildPurchaseOperationString(idCheckCopy)
                                            pcall(function()
                                                if setclipboard then
                                                    setclipboard(textOperation)
                                                    ApplyVisualColorState(cloneCopyButton, ColorHoverCopy)
                                                    task.wait(0.05)
                                                    ApplyVisualColorState(cloneCopyButton, ColorIdleCopy)
                                                end
                                            end)
                                        end
                                    end)
                                end

                                local checkAutoButton = parentButtonElement:FindFirstChild("AutoButton")
                                if not checkAutoButton then
                                    task.wait(0.01)
                                    local cloneAutoButton = originalButtonElement:Clone()
                                    cloneAutoButton.Name = "AutoButton"
                                    cloneAutoButton.Parent = parentButtonElement
                                    local checkAnchorAuto = parentButtonElement:FindFirstChild("CopyButton")
                                    if not checkAnchorAuto then
                                        checkAnchorAuto = parentButtonElement:FindFirstChild("FreeButton")
                                    end
                                    
                                    local zIndexAuto = 1
                                    if checkAnchorAuto then
                                        zIndexAuto = checkAnchorAuto.ZIndex
                                    end
                                    if not checkAnchorAuto then
                                        if originalButtonElement.ZIndex then
                                            zIndexAuto = originalButtonElement.ZIndex + 10
                                        end
                                    end
                                    DecorateInjectedButton(cloneAutoButton, "Auto", zIndexAuto, ColorIdleAuto)
                                    
                                    cloneAutoButton.MouseEnter:Connect(function()
                                        ApplyVisualColorState(cloneAutoButton, ColorHoverAuto)
                                    end)
                                    cloneAutoButton.MouseLeave:Connect(function()
                                        ApplyVisualColorState(cloneAutoButton, ColorIdleAuto)
                                    end)
                                    
                                    local checkLayoutAuto = parentButtonElement:FindFirstChildOfClass("UIListLayout")
                                    if checkLayoutAuto then
                                        local orderAuto = 0
                                        if checkAnchorAuto then
                                            if checkAnchorAuto.LayoutOrder then
                                                orderAuto = checkAnchorAuto.LayoutOrder
                                            end
                                        end
                                        cloneAutoButton.LayoutOrder = orderAuto + 1
                                    end
                                    if not checkLayoutAuto then
                                        if checkAnchorAuto then
                                            local posAnchorAuto = checkAnchorAuto.Position
                                            local offAnchorAuto = UDim2.fromOffset(0, 42)
                                            cloneAutoButton.Position = posAnchorAuto + offAnchorAuto
                                        end
                                    end

                                    cloneAutoButton.Activated:Connect(function()
                                        ToggleRobloxMenuAction()
                                        if AutoRunningState then
                                            StopAutoLoopAction()
                                            DestroyAutoStopGuiAction()
                                        end
                                        if not AutoRunningState then
                                            StartAutoLoopAction()
                                            CreateAutoStopButtonAction()
                                            ApplyVisualColorState(cloneAutoButton, ColorHoverAuto)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end

        local function GetActionsFolderFunction(foundationElement)
            local actionsElement = foundationElement:FindFirstChild("SafeAreaFrame")
            if actionsElement then
                actionsElement = actionsElement:FindFirstChild("OverlayPortal")
                if actionsElement then
                    actionsElement = actionsElement:FindFirstChild("SheetContainer")
                    if actionsElement then
                        actionsElement = actionsElement:FindFirstChild("Frame")
                        if actionsElement then
                            actionsElement = actionsElement:FindFirstChild("Sheet")
                            if actionsElement then
                                actionsElement = actionsElement:FindFirstChild("Content")
                                if actionsElement then
                                    actionsElement = actionsElement:FindFirstChild("Actions")
                                end
                            end
                        end
                    end
                end
            end
            if not actionsElement then
                actionsElement = foundationElement:FindFirstChild("Actions", true)
            end
            return actionsElement
        end

        local function ScanActionsFolderFunction(folderTarget)
            local folderChildren = folderTarget:GetChildren()
            for indexChild, childElement in ipairs(folderChildren) do
                local nameChildNumber = tonumber(childElement.Name)
                if nameChildNumber then
                    local childDescendants = childElement:GetDescendants()
                    for indexDesc, descElement in ipairs(childDescendants) do
                        if descElement:IsA("ImageButton") then
                            InjectButtonsAction(descElement)
                        end
                    end
                end
            end
        end

        task.spawn(function()
            while true do
                if ServiceCoreGui then
                    local coreGuiChildren = ServiceCoreGui:GetChildren()
                    for indexCore, childCore in ipairs(coreGuiChildren) do
                        if childCore.Name == "FoundationOverlay" then
                            local actionsFolder = GetActionsFolderFunction(childCore)
                            if actionsFolder then
                                ScanActionsFolderFunction(actionsFolder)
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end)
end)

local StateData = {
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
    SuperRing = false,
    RingSpeed = 10,
    RingHeight = 10,
    RingDistance = 40,
    RingAttraction = 1000,
    Blackhole = false,
    BlackholeDistance = 35,
    MainColor = Color3.fromRGB(138, 43, 226),
    RGBGaming = false
}

local ConfigurationFileName = "XayzConfig.json"

local function LoadConfigurationSettings()
    pcall(function()
        if readfile then
            if isfile then
                if isfile(ConfigurationFileName) then
                    local readStringFile = readfile(ConfigurationFileName)
                    local decodedJsonFile = ServiceHttp:JSONDecode(readStringFile)
                    for keyConfig, valueConfig in pairs(decodedJsonFile) do
                        if keyConfig == "MainColor" then
                            local redValue = valueConfig.R
                            local greenValue = valueConfig.G
                            local blueValue = valueConfig.B
                            StateData.MainColor = Color3.fromRGB(redValue, greenValue, blueValue)
                        end
                        if keyConfig ~= "MainColor" then
                            StateData[keyConfig] = valueConfig
                        end
                    end
                end
            end
        end
    end)
end

LoadConfigurationSettings()

local function SaveConfigurationSettings()
    pcall(function()
        local tableToSave = {}
        for keyState, valueState in pairs(StateData) do
            if keyState == "MainColor" then
                local redSave = StateData.MainColor.R
                local greenSave = StateData.MainColor.G
                local blueSave = StateData.MainColor.B
                local colorTableSave = {}
                colorTableSave.R = math.floor(redSave * 255)
                colorTableSave.G = math.floor(greenSave * 255)
                colorTableSave.B = math.floor(blueSave * 255)
                tableToSave.MainColor = colorTableSave
            end
            if keyState ~= "MainColor" then
                tableToSave[keyState] = valueState
            end
        end
        if writefile then
            local encodedJsonFile = ServiceHttp:JSONEncode(tableToSave)
            writefile(ConfigurationFileName, encodedJsonFile)
        end
    end)
end

local ScreenGuiPanel = Instance.new("ScreenGui")
ScreenGuiPanel.Name = "XayzExV3X"
ScreenGuiPanel.ResetOnSpawn = false

local successParentPanel = false
pcall(function()
    if ServiceCoreGui then
        local targetParentPanel = nil
        pcall(function()
            if gethui then
                targetParentPanel = gethui()
            end
        end)
        if not targetParentPanel then
            targetParentPanel = ServiceCoreGui
        end
        ScreenGuiPanel.Parent = targetParentPanel
        successParentPanel = true
    end
end)

if not successParentPanel then
    pcall(function()
        local playerGuiFolderPanel = PlayerLocal:WaitForChild("PlayerGui")
        ScreenGuiPanel.Parent = playerGuiFolderPanel
    end)
end

local function MakePanelDraggable(frameTargetPanel)
    pcall(function()
        local draggingPanel = false
        local dragInputPanel = nil
        local dragStartPanel = nil
        local startPosPanel = nil

        frameTargetPanel.InputBegan:Connect(function(inputPanel)
            pcall(function()
                local isValidPanel = false
                if inputPanel.UserInputType == Enum.UserInputType.MouseButton1 then
                    isValidPanel = true
                end
                if inputPanel.UserInputType == Enum.UserInputType.Touch then
                    isValidPanel = true
                end
                if isValidPanel then
                    draggingPanel = true
                    dragStartPanel = inputPanel.Position
                    startPosPanel = frameTargetPanel.Position
                end
            end)
        end)

        frameTargetPanel.InputEnded:Connect(function(inputPanel2)
            pcall(function()
                local isValidPanel2 = false
                if inputPanel2.UserInputType == Enum.UserInputType.MouseButton1 then
                    isValidPanel2 = true
                end
                if inputPanel2.UserInputType == Enum.UserInputType.Touch then
                    isValidPanel2 = true
                end
                if isValidPanel2 then
                    draggingPanel = false
                end
            end)
        end)

        frameTargetPanel.InputChanged:Connect(function(inputPanel3)
            pcall(function()
                local isValidPanel3 = false
                if inputPanel3.UserInputType == Enum.UserInputType.MouseMovement then
                    isValidPanel3 = true
                end
                if inputPanel3.UserInputType == Enum.UserInputType.Touch then
                    isValidPanel3 = true
                end
                if isValidPanel3 then
                    dragInputPanel = inputPanel3
                end
            end)
        end)

        ServiceUserInput.InputChanged:Connect(function(inputPanel4)
            pcall(function()
                if inputPanel4 == dragInputPanel then
                    if draggingPanel then
                        local deltaPosPanel = inputPanel4.Position - dragStartPanel
                        local newPosXPanel = startPosPanel.X.Offset + deltaPosPanel.X
                        local newPosYPanel = startPosPanel.Y.Offset + deltaPosPanel.Y
                        local newPosScaleX = startPosPanel.X.Scale
                        local newPosScaleY = startPosPanel.Y.Scale
                        frameTargetPanel.Position = UDim2.new(newPosScaleX, newPosXPanel, newPosScaleY, newPosYPanel)
                    end
                end
            end)
        end)
    end)
end

local NotificationContainerPanel = Instance.new("Frame")
pcall(function()
    NotificationContainerPanel.Name = "NotificationContainerModern"
    NotificationContainerPanel.Parent = ScreenGuiPanel
    NotificationContainerPanel.BackgroundTransparency = 1
    NotificationContainerPanel.Position = UDim2.new(1, -260, 1, -20)
    NotificationContainerPanel.Size = UDim2.new(0, 250, 0, 0)
    NotificationContainerPanel.AnchorPoint = Vector2.new(0, 1)

    local layoutNotifPanel = Instance.new("UIListLayout")
    layoutNotifPanel.Parent = NotificationContainerPanel
    layoutNotifPanel.SortOrder = Enum.SortOrder.LayoutOrder
    layoutNotifPanel.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layoutNotifPanel.Padding = UDim.new(0, 10)
end)

local function TriggerNotificationPanel(titleTextPanel, bodyTextPanel, displayDurationPanel)
    pcall(function()
        local finalDurationPanel = 3
        if displayDurationPanel then
            finalDurationPanel = displayDurationPanel
        end
        
        local framePopupPanel = Instance.new("Frame")
        framePopupPanel.Parent = NotificationContainerPanel
        framePopupPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        framePopupPanel.Size = UDim2.new(1, 0, 0, 65)
        
        if StateData.PerformanceMode then
            framePopupPanel.BackgroundTransparency = 0
        end
        if not StateData.PerformanceMode then
            framePopupPanel.BackgroundTransparency = 1
        end

        local cornerPopupPanel = Instance.new("UICorner")
        cornerPopupPanel.CornerRadius = UDim.new(0, 8)
        cornerPopupPanel.Parent = framePopupPanel
        
        local frameAccentPanel = Instance.new("Frame")
        frameAccentPanel.Parent = framePopupPanel
        frameAccentPanel.BackgroundColor3 = StateData.MainColor
        frameAccentPanel.Size = UDim2.new(0, 4, 1, 0)
        
        local cornerAccentPanel = Instance.new("UICorner")
        cornerAccentPanel.CornerRadius = UDim.new(0, 8)
        cornerAccentPanel.Parent = frameAccentPanel
        
        local labelTitlePanel = Instance.new("TextLabel")
        labelTitlePanel.Parent = framePopupPanel
        labelTitlePanel.BackgroundTransparency = 1
        labelTitlePanel.Position = UDim2.new(0, 15, 0, 5)
        labelTitlePanel.Size = UDim2.new(1, -20, 0, 20)
        labelTitlePanel.Font = Enum.Font.GothamBold
        labelTitlePanel.Text = titleTextPanel
        labelTitlePanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        labelTitlePanel.TextSize = 14
        labelTitlePanel.TextXAlignment = Enum.TextXAlignment.Left
        
        if StateData.PerformanceMode then
            labelTitlePanel.TextTransparency = 0
        end
        if not StateData.PerformanceMode then
            labelTitlePanel.TextTransparency = 1
        end
        
        local labelBodyPanel = Instance.new("TextLabel")
        labelBodyPanel.Parent = framePopupPanel
        labelBodyPanel.BackgroundTransparency = 1
        labelBodyPanel.Position = UDim2.new(0, 15, 0, 25)
        labelBodyPanel.Size = UDim2.new(1, -20, 0, 30)
        labelBodyPanel.Font = Enum.Font.Gotham
        labelBodyPanel.Text = bodyTextPanel
        labelBodyPanel.TextColor3 = Color3.fromRGB(180, 180, 180)
        labelBodyPanel.TextSize = 12
        labelBodyPanel.TextWrapped = true
        labelBodyPanel.TextXAlignment = Enum.TextXAlignment.Left
        
        if StateData.PerformanceMode then
            labelBodyPanel.TextTransparency = 0
        end
        if not StateData.PerformanceMode then
            labelBodyPanel.TextTransparency = 1
        end
        
        local frameProgBgPanel = Instance.new("Frame")
        frameProgBgPanel.Parent = framePopupPanel
        frameProgBgPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        frameProgBgPanel.Position = UDim2.new(0, 15, 1, -5)
        frameProgBgPanel.Size = UDim2.new(1, -25, 0, 3)
        
        if StateData.PerformanceMode then
            frameProgBgPanel.BackgroundTransparency = 0
        end
        if not StateData.PerformanceMode then
            frameProgBgPanel.BackgroundTransparency = 1
        end
        
        local cornerProgBgPanel = Instance.new("UICorner")
        cornerProgBgPanel.CornerRadius = UDim.new(1, 0)
        cornerProgBgPanel.Parent = frameProgBgPanel
        
        local frameProgFillPanel = Instance.new("Frame")
        frameProgFillPanel.Parent = frameProgBgPanel
        frameProgFillPanel.BackgroundColor3 = StateData.MainColor
        frameProgFillPanel.Size = UDim2.new(1, 0, 1, 0)
        
        if StateData.PerformanceMode then
            frameProgFillPanel.BackgroundTransparency = 0
        end
        if not StateData.PerformanceMode then
            frameProgFillPanel.BackgroundTransparency = 1
        end
        
        local cornerProgFillPanel = Instance.new("UICorner")
        cornerProgFillPanel.CornerRadius = UDim.new(1, 0)
        cornerProgFillPanel.Parent = frameProgFillPanel

        pcall(function()
            local runServiceNotifColor = ServiceRun.RenderStepped:Connect(function()
                pcall(function()
                    if frameAccentPanel then
                        frameAccentPanel.BackgroundColor3 = StateData.MainColor
                    end
                    if frameProgFillPanel then
                        frameProgFillPanel.BackgroundColor3 = StateData.MainColor
                    end
                end)
            end)
            
            framePopupPanel.Destroying:Connect(function()
                pcall(function()
                    runServiceNotifColor:Disconnect()
                end)
            end)
        end)
        
        if not StateData.PerformanceMode then
            local tweenInfoInPanel = TweenInfo.new(0.3)
            ServiceTween:Create(framePopupPanel, tweenInfoInPanel, {BackgroundTransparency = 0}):Play()
            ServiceTween:Create(labelTitlePanel, tweenInfoInPanel, {TextTransparency = 0}):Play()
            ServiceTween:Create(labelBodyPanel, tweenInfoInPanel, {TextTransparency = 0}):Play()
            ServiceTween:Create(frameProgBgPanel, tweenInfoInPanel, {BackgroundTransparency = 0}):Play()
            ServiceTween:Create(frameProgFillPanel, tweenInfoInPanel, {BackgroundTransparency = 0}):Play()
            
            local tweenInfoProgPanel = TweenInfo.new(finalDurationPanel, Enum.EasingStyle.Linear)
            local tweenProgPanel = ServiceTween:Create(frameProgFillPanel, tweenInfoProgPanel, {Size = UDim2.new(0, 0, 1, 0)})
            tweenProgPanel:Play()
            
            tweenProgPanel.Completed:Connect(function()
                pcall(function()
                    local tweenInfoOutPanel = TweenInfo.new(0.3)
                    ServiceTween:Create(framePopupPanel, tweenInfoOutPanel, {BackgroundTransparency = 1}):Play()
                    ServiceTween:Create(labelTitlePanel, tweenInfoOutPanel, {TextTransparency = 1}):Play()
                    ServiceTween:Create(labelBodyPanel, tweenInfoOutPanel, {TextTransparency = 1}):Play()
                    ServiceTween:Create(frameProgBgPanel, tweenInfoOutPanel, {BackgroundTransparency = 1}):Play()
                    ServiceTween:Create(frameProgFillPanel, tweenInfoOutPanel, {BackgroundTransparency = 1}):Play()
                    task.wait(0.3)
                    framePopupPanel:Destroy()
                end)
            end)
        end
        
        if StateData.PerformanceMode then
            task.spawn(function()
                pcall(function()
                    task.wait(finalDurationPanel)
                    framePopupPanel:Destroy()
                end)
            end)
        end
    end)
end

local MainWrapperPanel = Instance.new("Frame")
local GradientWrapperPanel = Instance.new("UIGradient")

pcall(function()
    MainWrapperPanel.Parent = ScreenGuiPanel
    MainWrapperPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainWrapperPanel.Position = UDim2.new(0.5, -241, 0.5, -161)
    MainWrapperPanel.Size = UDim2.new(0, 482, 0, 362)
    MakePanelDraggable(MainWrapperPanel)

    local cornerWrapperPanel = Instance.new("UICorner")
    cornerWrapperPanel.CornerRadius = UDim.new(0, 11)
    cornerWrapperPanel.Parent = MainWrapperPanel

    GradientWrapperPanel.Parent = MainWrapperPanel
    local colorSequenceWrapper = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(148, 0, 211))
    })
    GradientWrapperPanel.Color = colorSequenceWrapper
end)

pcall(function()
    ServiceRun.RenderStepped:Connect(function()
        pcall(function()
            if not StateData.PerformanceMode then
                GradientWrapperPanel.Rotation = (GradientWrapperPanel.Rotation + 1) % 360
            end
            if StateData.RGBGaming then
                StateData.MainColor = Color3.fromHSV((tick() % 5) / 5, 1, 1)
            end
            if StateData.PerformanceMode then
                local colorSequenceStatic = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, StateData.MainColor),
                    ColorSequenceKeypoint.new(1.00, StateData.MainColor)
                })
                GradientWrapperPanel.Color = colorSequenceStatic
            end
            if not StateData.PerformanceMode then
                local colorSequenceDynamic = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, StateData.MainColor),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1.00, StateData.MainColor)
                })
                GradientWrapperPanel.Color = colorSequenceDynamic
            end
        end)
    end)
end)

local MainFramePanel = Instance.new("Frame")
local HeaderPanelFrame = Instance.new("Frame")
local MinimizeButtonPanel = Instance.new("TextButton")
local MaximizeButtonPanel = Instance.new("TextButton")
local CloseButtonPanel = Instance.new("TextButton")
local SidebarPanelFrame = Instance.new("ScrollingFrame")
local ContentAreaPanelFrame = Instance.new("Frame")

pcall(function()
    MainFramePanel.Parent = MainWrapperPanel
    MainFramePanel.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
    MainFramePanel.Position = UDim2.new(0, 1, 0, 1)
    MainFramePanel.Size = UDim2.new(1, -2, 1, -2)
    MainFramePanel.ClipsDescendants = true

    local cornerMainFramePanel = Instance.new("UICorner")
    cornerMainFramePanel.CornerRadius = UDim.new(0, 10)
    cornerMainFramePanel.Parent = MainFramePanel

    HeaderPanelFrame.Parent = MainFramePanel
    HeaderPanelFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
    HeaderPanelFrame.Size = UDim2.new(1, 0, 0, 40)
    HeaderPanelFrame.BorderSizePixel = 0

    local titleHeaderPanel = Instance.new("TextLabel")
    titleHeaderPanel.Parent = HeaderPanelFrame
    titleHeaderPanel.BackgroundTransparency = 1
    titleHeaderPanel.Position = UDim2.new(0, 15, 0, 0)
    titleHeaderPanel.Size = UDim2.new(0.6, 0, 1, 0)
    titleHeaderPanel.Font = Enum.Font.GothamBold
    titleHeaderPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleHeaderPanel.TextSize = 14
    titleHeaderPanel.TextXAlignment = Enum.TextXAlignment.Left
    titleHeaderPanel.Text = "🖥️ Xayz Panel LiteX"

    MinimizeButtonPanel.Parent = HeaderPanelFrame
    MinimizeButtonPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
    MinimizeButtonPanel.Position = UDim2.new(1, -95, 0.5, -12)
    MinimizeButtonPanel.Size = UDim2.new(0, 24, 0, 24)
    MinimizeButtonPanel.Font = Enum.Font.GothamBold
    MinimizeButtonPanel.Text = "-"
    MinimizeButtonPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local cornerMinPanel = Instance.new("UICorner")
    cornerMinPanel.CornerRadius = UDim.new(0, 6)
    cornerMinPanel.Parent = MinimizeButtonPanel

    MaximizeButtonPanel.Parent = HeaderPanelFrame
    MaximizeButtonPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
    MaximizeButtonPanel.Position = UDim2.new(1, -65, 0.5, -12)
    MaximizeButtonPanel.Size = UDim2.new(0, 24, 0, 24)
    MaximizeButtonPanel.Font = Enum.Font.GothamBold
    MaximizeButtonPanel.Text = "□"
    MaximizeButtonPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local cornerMaxPanel = Instance.new("UICorner")
    cornerMaxPanel.CornerRadius = UDim.new(0, 6)
    cornerMaxPanel.Parent = MaximizeButtonPanel

    CloseButtonPanel.Parent = HeaderPanelFrame
    CloseButtonPanel.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButtonPanel.Position = UDim2.new(1, -35, 0.5, -12)
    CloseButtonPanel.Size = UDim2.new(0, 24, 0, 24)
    CloseButtonPanel.Font = Enum.Font.GothamBold
    CloseButtonPanel.Text = "X"
    CloseButtonPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local cornerClsPanel = Instance.new("UICorner")
    cornerClsPanel.CornerRadius = UDim.new(0, 6)
    cornerClsPanel.Parent = CloseButtonPanel

    SidebarPanelFrame.Parent = MainFramePanel
    SidebarPanelFrame.BackgroundColor3 = Color3.fromRGB(12, 13, 17)
    SidebarPanelFrame.Position = UDim2.new(0, 0, 0, 40)
    SidebarPanelFrame.Size = UDim2.new(0, 130, 1, -40)
    SidebarPanelFrame.BorderSizePixel = 0
    SidebarPanelFrame.ScrollBarThickness = 2
    SidebarPanelFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local layoutSbPanel = Instance.new("UIListLayout")
    layoutSbPanel.Parent = SidebarPanelFrame
    layoutSbPanel.SortOrder = Enum.SortOrder.LayoutOrder

    ContentAreaPanelFrame.Parent = MainFramePanel
    ContentAreaPanelFrame.BackgroundTransparency = 1
    ContentAreaPanelFrame.Position = UDim2.new(0, 140, 0, 50)
    ContentAreaPanelFrame.Size = UDim2.new(1, -150, 1, -60)
end)

pcall(function()
    MinimizeButtonPanel.MouseButton1Click:Connect(function()
        pcall(function()
            if not StateData.PerformanceMode then
                ServiceTween:Create(MainWrapperPanel, TweenInfo.new(0.3), {Size = UDim2.new(0, 482, 0, 42)}):Play()
            end
            if StateData.PerformanceMode then
                MainWrapperPanel.Size = UDim2.new(0, 482, 0, 42)
            end
            SidebarPanelFrame.Visible = false
            ContentAreaPanelFrame.Visible = false
        end)
    end)

    MaximizeButtonPanel.MouseButton1Click:Connect(function()
        pcall(function()
            if not StateData.PerformanceMode then
                ServiceTween:Create(MainWrapperPanel, TweenInfo.new(0.3), {Size = UDim2.new(0, 482, 0, 362)}):Play()
                task.wait(0.3)
            end
            if StateData.PerformanceMode then
                MainWrapperPanel.Size = UDim2.new(0, 482, 0, 362)
            end
            SidebarPanelFrame.Visible = true
            ContentAreaPanelFrame.Visible = true
        end)
    end)

    CloseButtonPanel.MouseButton1Click:Connect(function()
        pcall(function()
            ScreenGuiPanel:Destroy()
        end)
    end)
end)

local PagesTablePanel = {}

local function SwitchPageDisplayPanel(pageNameTargetPanel)
    pcall(function()
        for namePagePanel, instPagePanel in pairs(PagesTablePanel) do
            if namePagePanel == pageNameTargetPanel then
                instPagePanel.Visible = true
            end
            if namePagePanel ~= pageNameTargetPanel then
                instPagePanel.Visible = false
            end
        end
    end)
end

local function CreateSidebarTabButtonPanel(textTabPanel, pageNameTabPanel)
    local buttonTabPanel = Instance.new("TextButton")
    pcall(function()
        buttonTabPanel.Parent = SidebarPanelFrame
        buttonTabPanel.BackgroundTransparency = 1
        buttonTabPanel.Size = UDim2.new(1, 0, 0, 35)
        buttonTabPanel.Font = Enum.Font.GothamBold
        buttonTabPanel.TextColor3 = Color3.fromRGB(120, 120, 130)
        buttonTabPanel.TextSize = 12
        buttonTabPanel.Text = textTabPanel

        buttonTabPanel.MouseButton1Click:Connect(function()
            pcall(function()
                for _, childSbPanel in pairs(SidebarPanelFrame:GetChildren()) do
                    if childSbPanel:IsA("TextButton") then
                        childSbPanel.TextColor3 = Color3.fromRGB(120, 120, 130)
                    end
                end
                buttonTabPanel.TextColor3 = StateData.MainColor
                SwitchPageDisplayPanel(pageNameTabPanel)
            end)
        end)
        
        ServiceRun.RenderStepped:Connect(function()
            pcall(function()
                local selectedPagePanel = PagesTablePanel[pageNameTabPanel]
                if selectedPagePanel then
                    if selectedPagePanel.Visible then
                        buttonTabPanel.TextColor3 = StateData.MainColor
                    end
                end
            end)
        end)
    end)
    return buttonTabPanel
end

local function CreateContentPagePanel(namePageCrPanel)
    local framePagePanel = Instance.new("ScrollingFrame")
    pcall(function()
        framePagePanel.Name = namePageCrPanel
        framePagePanel.Parent = ContentAreaPanelFrame
        framePagePanel.BackgroundTransparency = 1
        framePagePanel.Size = UDim2.new(1, 0, 1, 0)
        framePagePanel.ScrollBarThickness = 2
        framePagePanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        framePagePanel.Visible = false
        
        PagesTablePanel[namePageCrPanel] = framePagePanel
        
        local listPagePanel = Instance.new("UIListLayout")
        listPagePanel.Parent = framePagePanel
        listPagePanel.Padding = UDim.new(0, 8)
        listPagePanel.SortOrder = Enum.SortOrder.LayoutOrder
    end)
    return framePagePanel
end

local PageCombatPanel = CreateContentPagePanel("Combat")
local PageVisualPanel = CreateContentPagePanel("Visual")
local PageFlingsPanel = CreateContentPagePanel("Flings")
local PageWorldPanel = CreateContentPagePanel("World")
local PageExecutorPanel = CreateContentPagePanel("Executor")
local PageCustomUIPanel = CreateContentPagePanel("CustomUI")
local PageSettingsPanel = CreateContentPagePanel("Settings")

SwitchPageDisplayPanel("Combat")
local TabCombatPanel = CreateSidebarTabButtonPanel("COMBAT", "Combat")
local TabVisualPanel = CreateSidebarTabButtonPanel("VISUAL", "Visual")
local TabFlingsPanel = CreateSidebarTabButtonPanel("FLINGS", "Flings")
local TabWorldPanel = CreateSidebarTabButtonPanel("WORLD", "World")
local TabExecutorPanel = CreateSidebarTabButtonPanel("EXECUTOR", "Executor")
local TabCustomUIPanel = CreateSidebarTabButtonPanel("CUSTOM UI", "CustomUI")
local TabSettingsPanel = CreateSidebarTabButtonPanel("SETTINGS", "Settings")

local function CreateDualSwitchMenuPanel(pageParentPanel, textStrPanel, stateKeyStrPanel)
    local frameDSPanel = Instance.new("Frame")
    pcall(function()
        frameDSPanel.Parent = pageParentPanel
        frameDSPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        frameDSPanel.Size = UDim2.new(1, -5, 0, 45)
        
        local cornerDSPanel = Instance.new("UICorner")
        cornerDSPanel.CornerRadius = UDim.new(0, 6)
        cornerDSPanel.Parent = frameDSPanel
        
        local labelDSPanel = Instance.new("TextLabel")
        labelDSPanel.Parent = frameDSPanel
        labelDSPanel.BackgroundTransparency = 1
        labelDSPanel.Position = UDim2.new(0, 5, 0, 0)
        labelDSPanel.Size = UDim2.new(1, -10, 0, 20)
        labelDSPanel.Font = Enum.Font.GothamSemibold
        labelDSPanel.TextColor3 = Color3.fromRGB(220, 220, 220)
        labelDSPanel.TextSize = 12
        labelDSPanel.TextXAlignment = Enum.TextXAlignment.Center
        labelDSPanel.Text = textStrPanel
        
        local buttonOnDSPanel = Instance.new("TextButton")
        buttonOnDSPanel.Parent = frameDSPanel
        buttonOnDSPanel.Position = UDim2.new(0.1, 0, 0, 20)
        buttonOnDSPanel.Size = UDim2.new(0.35, 0, 0, 20)
        
        if StateData[stateKeyStrPanel] then
            buttonOnDSPanel.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
            buttonOnDSPanel.TextColor3 = Color3.fromRGB(0, 0, 0)
        end
        if not StateData[stateKeyStrPanel] then
            buttonOnDSPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
            buttonOnDSPanel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        
        buttonOnDSPanel.Text = "ON"
        buttonOnDSPanel.Font = Enum.Font.GothamBold
        
        local cornerOnDSPanel = Instance.new("UICorner")
        cornerOnDSPanel.CornerRadius = UDim.new(0, 4)
        cornerOnDSPanel.Parent = buttonOnDSPanel

        local buttonOffDSPanel = Instance.new("TextButton")
        buttonOffDSPanel.Parent = frameDSPanel
        buttonOffDSPanel.Position = UDim2.new(0.55, 0, 0, 20)
        buttonOffDSPanel.Size = UDim2.new(0.35, 0, 0, 20)
        
        if StateData[stateKeyStrPanel] then
            buttonOffDSPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
            buttonOffDSPanel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        if not StateData[stateKeyStrPanel] then
            buttonOffDSPanel.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            buttonOffDSPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        buttonOffDSPanel.Text = "OFF"
        buttonOffDSPanel.Font = Enum.Font.GothamBold
        
        local cornerOffDSPanel = Instance.new("UICorner")
        cornerOffDSPanel.CornerRadius = UDim.new(0, 4)
        cornerOffDSPanel.Parent = buttonOffDSPanel

        buttonOnDSPanel.MouseButton1Click:Connect(function()
            pcall(function()
                StateData[stateKeyStrPanel] = true
                buttonOnDSPanel.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
                buttonOnDSPanel.TextColor3 = Color3.fromRGB(0, 0, 0)
                buttonOffDSPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
                buttonOffDSPanel.TextColor3 = Color3.fromRGB(200, 200, 200)
                TriggerNotificationPanel("Setting", textStrPanel .. " Enabled", 2)
                SaveConfigurationSettings()
            end)
        end)
        
        buttonOffDSPanel.MouseButton1Click:Connect(function()
            pcall(function()
                StateData[stateKeyStrPanel] = false
                buttonOffDSPanel.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                buttonOffDSPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
                buttonOnDSPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
                buttonOnDSPanel.TextColor3 = Color3.fromRGB(200, 200, 200)
                TriggerNotificationPanel("Setting", textStrPanel .. " Disabled", 2)
                SaveConfigurationSettings()
            end)
        end)
    end)
    return frameDSPanel
end

local function CreateDropdownMenuPanel(pageParentPanel, textStrPanel)
    local itemsDropPanel = Instance.new("Frame")
    pcall(function()
        local containerDropPanel = Instance.new("Frame")
        containerDropPanel.Parent = pageParentPanel
        containerDropPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        containerDropPanel.Size = UDim2.new(1, -5, 0, 35)
        containerDropPanel.ClipsDescendants = true
        
        local cornerContainerDropPanel = Instance.new("UICorner")
        cornerContainerDropPanel.CornerRadius = UDim.new(0, 6)
        cornerContainerDropPanel.Parent = containerDropPanel

        local buttonHeadDropPanel = Instance.new("TextButton")
        buttonHeadDropPanel.Parent = containerDropPanel
        buttonHeadDropPanel.BackgroundTransparency = 1
        buttonHeadDropPanel.Position = UDim2.new(0, 10, 0, 0)
        buttonHeadDropPanel.Size = UDim2.new(1, -10, 0, 35)
        buttonHeadDropPanel.Font = Enum.Font.GothamBold
        buttonHeadDropPanel.TextColor3 = StateData.MainColor
        buttonHeadDropPanel.TextSize = 12
        buttonHeadDropPanel.TextXAlignment = Enum.TextXAlignment.Left
        buttonHeadDropPanel.Text = textStrPanel .. " ▼"

        itemsDropPanel.Parent = containerDropPanel
        itemsDropPanel.BackgroundTransparency = 1
        itemsDropPanel.Position = UDim2.new(0, 0, 0, 35)
        itemsDropPanel.Size = UDim2.new(1, 0, 0, 0)

        local paddingItemsDropPanel = Instance.new("UIPadding")
        paddingItemsDropPanel.Parent = itemsDropPanel
        paddingItemsDropPanel.PaddingLeft = UDim.new(0, 15)
        paddingItemsDropPanel.PaddingRight = UDim.new(0, 5)

        local listItemsDropPanel = Instance.new("UIListLayout")
        listItemsDropPanel.Parent = itemsDropPanel
        listItemsDropPanel.Padding = UDim.new(0, 5)
        listItemsDropPanel.SortOrder = Enum.SortOrder.LayoutOrder

        local isDropOpenPanel = false
        local function updateSizeDropLogicPanel()
            pcall(function()
                if isDropOpenPanel then
                    buttonHeadDropPanel.Text = textStrPanel .. " ▲"
                    local calcItemsHeightPanel = listItemsDropPanel.AbsoluteContentSize.Y + 10
                    itemsDropPanel.Size = UDim2.new(1, 0, 0, calcItemsHeightPanel)
                    containerDropPanel.Size = UDim2.new(1, -5, 0, 35 + calcItemsHeightPanel)
                end
                if not isDropOpenPanel then
                    buttonHeadDropPanel.Text = textStrPanel .. " ▼"
                    itemsDropPanel.Size = UDim2.new(1, 0, 0, 0)
                    containerDropPanel.Size = UDim2.new(1, -5, 0, 35)
                end
            end)
        end

        buttonHeadDropPanel.MouseButton1Click:Connect(function()
            pcall(function()
                isDropOpenPanel = not isDropOpenPanel
                updateSizeDropLogicPanel()
            end)
        end)
        
        listItemsDropPanel:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            pcall(function()
                updateSizeDropLogicPanel()
            end)
        end)
        
        ServiceRun.RenderStepped:Connect(function()
            pcall(function()
                buttonHeadDropPanel.TextColor3 = StateData.MainColor
            end)
        end)
    end)
    return itemsDropPanel
end

local function CreateToggleMenuPanel(pageParentPanel, textStrPanel, stateKeyStrPanel, parentStateKeyStrPanel)
    local frameTogPanel = Instance.new("Frame")
    pcall(function()
        frameTogPanel.Parent = pageParentPanel
        frameTogPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        frameTogPanel.Size = UDim2.new(1, -5, 0, 35)
        
        local cornerTogPanel = Instance.new("UICorner")
        cornerTogPanel.CornerRadius = UDim.new(0, 6)
        cornerTogPanel.Parent = frameTogPanel
        
        local labelTogPanel = Instance.new("TextLabel")
        labelTogPanel.Parent = frameTogPanel
        labelTogPanel.BackgroundTransparency = 1
        labelTogPanel.Position = UDim2.new(0, 10, 0, 0)
        labelTogPanel.Size = UDim2.new(0.7, 0, 1, 0)
        labelTogPanel.Font = Enum.Font.GothamSemibold
        labelTogPanel.TextColor3 = Color3.fromRGB(220, 220, 220)
        labelTogPanel.TextSize = 12
        labelTogPanel.TextXAlignment = Enum.TextXAlignment.Left
        labelTogPanel.Text = textStrPanel
        
        local buttonTogPanel = Instance.new("TextButton")
        buttonTogPanel.Parent = frameTogPanel
        buttonTogPanel.Position = UDim2.new(1, -50, 0.5, -8)
        buttonTogPanel.Size = UDim2.new(0, 36, 0, 16)
        buttonTogPanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
        buttonTogPanel.Text = ""
        
        local cornerBtnTogPanel = Instance.new("UICorner")
        cornerBtnTogPanel.CornerRadius = UDim.new(1, 0)
        cornerBtnTogPanel.Parent = buttonTogPanel
        
        local statusFrameTogPanel = Instance.new("Frame")
        statusFrameTogPanel.Parent = buttonTogPanel
        statusFrameTogPanel.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        statusFrameTogPanel.Position = UDim2.new(0, 2, 0.5, -6)
        statusFrameTogPanel.Size = UDim2.new(0, 12, 0, 12)
        
        local cornerStFrameTogPanel = Instance.new("UICorner")
        cornerStFrameTogPanel.CornerRadius = UDim.new(1, 0)
        cornerStFrameTogPanel.Parent = statusFrameTogPanel

        local function updateUIStatusLogicPanel()
            pcall(function()
                if StateData[stateKeyStrPanel] then
                    statusFrameTogPanel.Position = UDim2.new(1, -14, 0.5, -6)
                    statusFrameTogPanel.BackgroundColor3 = StateData.MainColor
                end
                if not StateData[stateKeyStrPanel] then
                    statusFrameTogPanel.Position = UDim2.new(0, 2, 0.5, -6)
                    statusFrameTogPanel.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                end
            end)
        end

        ServiceRun.RenderStepped:Connect(function()
            pcall(function()
                local isParentKeyOffPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffPanel = true
                    end
                end
                
                if isParentKeyOffPanel then
                    labelTogPanel.TextColor3 = Color3.fromRGB(80, 80, 90)
                    buttonTogPanel.AutoButtonColor = false
                end
                if not isParentKeyOffPanel then
                    labelTogPanel.TextColor3 = Color3.fromRGB(220, 220, 220)
                    buttonTogPanel.AutoButtonColor = true
                end
                
                if StateData[stateKeyStrPanel] then
                    statusFrameTogPanel.BackgroundColor3 = StateData.MainColor
                end
            end)
        end)
        
        updateUIStatusLogicPanel()

        buttonTogPanel.MouseButton1Click:Connect(function()
            pcall(function()
                local isParentKeyOffClickPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffClickPanel = true
                    end
                end
                
                if isParentKeyOffClickPanel then 
                    return 
                end
                
                StateData[stateKeyStrPanel] = not StateData[stateKeyStrPanel]
                
                if not StateData.PerformanceMode then
                    local tGoalTogClickPanel = {}
                    if StateData[stateKeyStrPanel] then
                        tGoalTogClickPanel.Position = UDim2.new(1, -14, 0.5, -6)
                        tGoalTogClickPanel.BackgroundColor3 = StateData.MainColor
                    end
                    if not StateData[stateKeyStrPanel] then
                        tGoalTogClickPanel.Position = UDim2.new(0, 2, 0.5, -6)
                        tGoalTogClickPanel.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    end
                    ServiceTween:Create(statusFrameTogPanel, TweenInfo.new(0.2), tGoalTogClickPanel):Play()
                end
                
                if StateData.PerformanceMode then
                    if StateData[stateKeyStrPanel] then
                        statusFrameTogPanel.Position = UDim2.new(1, -14, 0.5, -6)
                        statusFrameTogPanel.BackgroundColor3 = StateData.MainColor
                    end
                    if not StateData[stateKeyStrPanel] then
                        statusFrameTogPanel.Position = UDim2.new(0, 2, 0.5, -6)
                        statusFrameTogPanel.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    end
                end
                
                local strOnOffMsgPanel = "Disabled"
                if StateData[stateKeyStrPanel] then
                    strOnOffMsgPanel = "Enabled"
                end
                TriggerNotificationPanel(textStrPanel, strOnOffMsgPanel, 2)
                SaveConfigurationSettings()
            end)
        end)
    end)
    return frameTogPanel
end

local function CreateButtonMenuPanel(pageParentPanel, textStrPanel, colorVarPanel, callbackFuncPanel, parentStateKeyStrPanel)
    local btnCreatePanel = Instance.new("TextButton")
    pcall(function()
        btnCreatePanel.Parent = pageParentPanel
        btnCreatePanel.BackgroundColor3 = colorVarPanel
        btnCreatePanel.Size = UDim2.new(1, -5, 0, 35)
        btnCreatePanel.Font = Enum.Font.GothamBold
        btnCreatePanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnCreatePanel.TextSize = 12
        btnCreatePanel.Text = textStrPanel
        
        local crBtnCrPanel = Instance.new("UICorner")
        crBtnCrPanel.CornerRadius = UDim.new(0, 6)
        crBtnCrPanel.Parent = btnCreatePanel
        
        ServiceRun.RenderStepped:Connect(function()
            pcall(function()
                local isParentKeyOffBtnCrPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffBtnCrPanel = true
                    end
                end
                
                if isParentKeyOffBtnCrPanel then
                    btnCreatePanel.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
                    btnCreatePanel.TextColor3 = Color3.fromRGB(80, 80, 90)
                end
                if not isParentKeyOffBtnCrPanel then
                    if tostring(colorVarPanel) == "Main" then
                        btnCreatePanel.BackgroundColor3 = StateData.MainColor
                    end
                    if tostring(colorVarPanel) ~= "Main" then
                        btnCreatePanel.BackgroundColor3 = colorVarPanel
                    end
                    btnCreatePanel.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end)
        end)

        btnCreatePanel.MouseButton1Click:Connect(function()
            pcall(function()
                local isParentKeyOffClkBtnCrPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffClkBtnCrPanel = true
                    end
                end
                
                if isParentKeyOffClkBtnCrPanel then 
                    return 
                end
                callbackFuncPanel(btnCreatePanel)
            end)
        end)
    end)
    return btnCreatePanel
end

local function CreateInputMenuPanel(pageParentPanel, textStrPanel, stateKeyStrPanel, parentStateKeyStrPanel)
    local bxCrPanel = Instance.new("TextBox")
    pcall(function()
        bxCrPanel.Parent = pageParentPanel
        bxCrPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        bxCrPanel.Size = UDim2.new(1, -5, 0, 35)
        bxCrPanel.Font = Enum.Font.Gotham
        bxCrPanel.Text = ""
        bxCrPanel.PlaceholderText = textStrPanel
        bxCrPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        bxCrPanel.TextSize = 12
        
        local crBxCrPanel = Instance.new("UICorner")
        crBxCrPanel.CornerRadius = UDim.new(0, 6)
        crBxCrPanel.Parent = bxCrPanel
        
        ServiceRun.RenderStepped:Connect(function()
            pcall(function()
                local isParentKeyOffBxCrPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffBxCrPanel = true
                    end
                end
                
                if isParentKeyOffBxCrPanel then
                    bxCrPanel.TextColor3 = Color3.fromRGB(80, 80, 90)
                    bxCrPanel.TextEditable = false
                end
                if not isParentKeyOffBxCrPanel then
                    bxCrPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    bxCrPanel.TextEditable = true
                end
            end)
        end)

        bxCrPanel.FocusLost:Connect(function()
            pcall(function()
                local isParentKeyOffFocBxCrPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffFocBxCrPanel = true
                    end
                end
                
                if isParentKeyOffFocBxCrPanel then 
                    return 
                end
                
                local numBxCrPanel = tonumber(bxCrPanel.Text)
                if numBxCrPanel then 
                    StateData[stateKeyStrPanel] = numBxCrPanel 
                    SaveConfigurationSettings()
                end
            end)
        end)
    end)
    return bxCrPanel
end

local function CreateStepperMenuPanel(pageParentPanel, textStrPanel, stateKeyStrPanel, parentStateKeyStrPanel, isFloatArgPanel)
    local fStpPanel = Instance.new("Frame")
    pcall(function()
        fStpPanel.Parent = pageParentPanel
        fStpPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
        fStpPanel.Size = UDim2.new(1, -5, 0, 35)
        
        local crStpPanel = Instance.new("UICorner")
        crStpPanel.CornerRadius = UDim.new(0, 6)
        crStpPanel.Parent = fStpPanel
        
        local lblStpPanel = Instance.new("TextLabel")
        lblStpPanel.Parent = fStpPanel
        lblStpPanel.BackgroundTransparency = 1
        lblStpPanel.Position = UDim2.new(0, 10, 0, 0)
        lblStpPanel.Size = UDim2.new(0.4, 0, 1, 0)
        lblStpPanel.Font = Enum.Font.GothamSemibold
        lblStpPanel.TextColor3 = Color3.fromRGB(220, 220, 220)
        lblStpPanel.TextSize = 12
        lblStpPanel.TextXAlignment = Enum.TextXAlignment.Left
        lblStpPanel.Text = textStrPanel
        
        local minBtnStpPanel = Instance.new("TextButton")
        minBtnStpPanel.Parent = fStpPanel
        minBtnStpPanel.Position = UDim2.new(1, -100, 0.5, -12)
        minBtnStpPanel.Size = UDim2.new(0, 24, 0, 24)
        minBtnStpPanel.BackgroundColor3 = Color3.fromRGB(35, 36, 42)
        minBtnStpPanel.Text = "-"
        minBtnStpPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local crMinStpPanel = Instance.new("UICorner")
        crMinStpPanel.CornerRadius = UDim.new(0, 4)
        crMinStpPanel.Parent = minBtnStpPanel
        
        local valBxStpPanel = Instance.new("TextBox")
        valBxStpPanel.Parent = fStpPanel
        valBxStpPanel.Position = UDim2.new(1, -70, 0.5, -12)
        valBxStpPanel.Size = UDim2.new(0, 34, 0, 24)
        valBxStpPanel.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
        valBxStpPanel.Text = tostring(StateData[stateKeyStrPanel])
        valBxStpPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local crValStpPanel = Instance.new("UICorner")
        crValStpPanel.CornerRadius = UDim.new(0, 4)
        crValStpPanel.Parent = valBxStpPanel
        
        local plsBtnStpPanel = Instance.new("TextButton")
        plsBtnStpPanel.Parent = fStpPanel
        plsBtnStpPanel.Position = UDim2.new(1, -30, 0.5, -12)
        plsBtnStpPanel.Size = UDim2.new(0, 24, 0, 24)
        plsBtnStpPanel.BackgroundColor3 = Color3.fromRGB(35, 36, 42)
        plsBtnStpPanel.Text = "+"
        plsBtnStpPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local crPlsStpPanel = Instance.new("UICorner")
        crPlsStpPanel.CornerRadius = UDim.new(0, 4)
        crPlsStpPanel.Parent = plsBtnStpPanel

        ServiceRun.RenderStepped:Connect(function()
            pcall(function()
                local isParentKeyOffRsStpPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffRsStpPanel = true
                    end
                end
                
                if isParentKeyOffRsStpPanel then
                    lblStpPanel.TextColor3 = Color3.fromRGB(80, 80, 90)
                    valBxStpPanel.TextColor3 = Color3.fromRGB(80, 80, 90)
                    valBxStpPanel.TextEditable = false
                    minBtnStpPanel.AutoButtonColor = false
                    plsBtnStpPanel.AutoButtonColor = false
                end
                if not isParentKeyOffRsStpPanel then
                    lblStpPanel.TextColor3 = Color3.fromRGB(220, 220, 220)
                    valBxStpPanel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    valBxStpPanel.TextEditable = true
                    minBtnStpPanel.AutoButtonColor = true
                    plsBtnStpPanel.AutoButtonColor = true
                end
            end)
        end)

        local stepValMathPanel = 1
        if isFloatArgPanel then
            stepValMathPanel = 0.5
        end

        local function updateStpLogicPanel(newValArgPanel)
            pcall(function()
                local isParentKeyOffUpdStpPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffUpdStpPanel = true
                    end
                end
                if isParentKeyOffUpdStpPanel then 
                    return 
                end
                
                StateData[stateKeyStrPanel] = newValArgPanel
                valBxStpPanel.Text = tostring(StateData[stateKeyStrPanel])
                SaveConfigurationSettings()
            end)
        end
        
        minBtnStpPanel.MouseButton1Click:Connect(function() 
            pcall(function()
                local isParentKeyOffMinStpPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffMinStpPanel = true
                    end
                end
                if isParentKeyOffMinStpPanel then 
                    return 
                end
                
                if StateData[stateKeyStrPanel] > stepValMathPanel then 
                    updateStpLogicPanel(StateData[stateKeyStrPanel] - stepValMathPanel) 
                end 
            end)
        end)
        
        plsBtnStpPanel.MouseButton1Click:Connect(function() 
            pcall(function()
                local isParentKeyOffPlsStpPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffPlsStpPanel = true
                    end
                end
                if isParentKeyOffPlsStpPanel then 
                    return 
                end
                
                updateStpLogicPanel(StateData[stateKeyStrPanel] + stepValMathPanel) 
            end)
        end)
        
        valBxStpPanel.FocusLost:Connect(function()
            pcall(function()
                local isParentKeyOffFocStpPanel = false
                if parentStateKeyStrPanel then
                    if not StateData[parentStateKeyStrPanel] then
                        isParentKeyOffFocStpPanel = true
                    end
                end
                if isParentKeyOffFocStpPanel then 
                    valBxStpPanel.Text = tostring(StateData[stateKeyStrPanel])
                    return 
                end
                
                local numFocStpPanel = tonumber(valBxStpPanel.Text)
                if numFocStpPanel then 
                    updateStpLogicPanel(numFocStpPanel) 
                end
                if not numFocStpPanel then
                    updateStpLogicPanel(stepValMathPanel)
                end
            end)
        end)
    end)
    return fStpPanel
end

CreateToggleMenuPanel(PageCombatPanel, "Aimbot", "Aimbot", nil)
local DropCbtAimPanel = CreateDropdownMenuPanel(PageCombatPanel, "Advanced Aimbot")
CreateToggleMenuPanel(DropCbtAimPanel, "Show FOV Circle", "Aim_ShowFOV", "Aimbot")
CreateToggleMenuPanel(DropCbtAimPanel, "Silent Aim", "SilentAim", "Aimbot")
CreateStepperMenuPanel(DropCbtAimPanel, "Set FOV Size", "Aim_FOVSize", "Aimbot", false)
CreateButtonMenuPanel(DropCbtAimPanel, "Switch Target: HEAD/TORSO", Color3.fromRGB(200, 100, 0), function(btnObjPanel)
    pcall(function()
        if StateData.Aim_Part == "Head" then
            StateData.Aim_Part = "HumanoidRootPart"
        else
            StateData.Aim_Part = "Head"
        end
        btnObjPanel.Text = "Target: " .. string.upper(StateData.Aim_Part)
        SaveConfigurationSettings()
    end)
end, "Aimbot")

CreateToggleMenuPanel(PageCombatPanel, "Heal Loop", "HealLoop", nil)
CreateToggleMenuPanel(PageCombatPanel, "God Mode", "GodModeV4", nil)
CreateToggleMenuPanel(PageCombatPanel, "ForceField", "ForceField", nil)
CreateToggleMenuPanel(PageCombatPanel, "Fly", "Fly", nil)
CreateStepperMenuPanel(PageCombatPanel, "Fly Speed", "FlySpeed", "Fly", false)

CreateToggleMenuPanel(PageVisualPanel, "ESP", "ESP", nil)
local DropVisESPPanel = CreateDropdownMenuPanel(PageVisualPanel, "Advanced ESP")
CreateToggleMenuPanel(DropVisESPPanel, "Show Box", "ESP_Box", "ESP")
CreateToggleMenuPanel(DropVisESPPanel, "Show Name & Distance", "ESP_Name", "ESP")
CreateToggleMenuPanel(DropVisESPPanel, "Show Healthbar", "ESP_Health", "ESP")
CreateToggleMenuPanel(DropVisESPPanel, "Show Tracer", "ESP_Tracer", "ESP")
CreateToggleMenuPanel(DropVisESPPanel, "Show Chams", "ESP_Chams", "ESP")
CreateInputMenuPanel(PageVisualPanel, "Set POV Camera (1-120)", "POV", nil)

CreateToggleMenuPanel(PageFlingsPanel, "Fling", "FlingV2", nil)
CreateToggleMenuPanel(PageFlingsPanel, "Fling V2", "FlingV3", nil)
CreateInputMenuPanel(PageFlingsPanel, "Set Fling Power (Def: 50)", "FlingPower", nil)
CreateToggleMenuPanel(PageFlingsPanel, "Super Touch Fling", "SuperFling", nil)

CreateButtonMenuPanel(PageFlingsPanel, "Teleport to ALL Players", "Main", function()
    pcall(function()
        TriggerNotificationPanel("Teleporting", "Transporting to all players...", 3)
        for _, plyTpPanel in ipairs(ServicePlayers:GetPlayers()) do
            if plyTpPanel ~= PlayerLocal then
                local charTpPanel = plyTpPanel.Character
                if charTpPanel then
                    local hrpTpPanel = charTpPanel:FindFirstChild("HumanoidRootPart")
                    if hrpTpPanel then
                        local lpCharTpPanel = PlayerLocal.Character
                        if lpCharTpPanel then
                            local lpHrpTpPanel = lpCharTpPanel:FindFirstChild("HumanoidRootPart")
                            if lpHrpTpPanel then
                                lpHrpTpPanel.CFrame = hrpTpPanel.CFrame
                                task.wait(0.2)
                            end
                        end
                    end
                end
            end
        end
    end)
end, nil)

CreateButtonMenuPanel(PageFlingsPanel, "Fling ALL Players", Color3.fromRGB(255, 50, 50), function()
    pcall(function()
        TriggerNotificationPanel("Fling All", "Executing mass fling...", 3)
        local oldSfFlgPanel = StateData.SuperFling
        StateData.SuperFling = true
        
        for _, plyFlgPanel in ipairs(ServicePlayers:GetPlayers()) do
            if plyFlgPanel ~= PlayerLocal then
                local charFlgPanel = plyFlgPanel.Character
                if charFlgPanel then
                    local hrpFlgPanel = charFlgPanel:FindFirstChild("HumanoidRootPart")
                    if hrpFlgPanel then
                        local lpCharFlgPanel = PlayerLocal.Character
                        if lpCharFlgPanel then
                            local lpHrpFlgPanel = lpCharFlgPanel:FindFirstChild("HumanoidRootPart")
                            if lpHrpFlgPanel then
                                lpHrpFlgPanel.CFrame = hrpFlgPanel.CFrame
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end
        end
        StateData.SuperFling = oldSfFlgPanel
    end)
end, nil)

CreateButtonMenuPanel(PageFlingsPanel, "Dropkick", Color3.fromRGB(150, 50, 255), function()
    pcall(function()
        TriggerNotificationPanel("Executing", "Loading Dropkick script...", 2)
        pcall(function() 
            if type(loadstring) == "function" then
                local urlDkPanel = "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua"
                local httpResDkPanel = game:HttpGet(urlDkPanel)
                local execFuncDkPanel = loadstring(httpResDkPanel)
                if type(execFuncDkPanel) == "function" then
                    execFuncDkPanel()
                end
            end
        end)
    end)
end, nil)

CreateToggleMenuPanel(PageFlingsPanel, "Dino Animation", "DinoAnim", nil)
CreateToggleMenuPanel(PageFlingsPanel, "Punch Animation", "PunchAnim", nil)

CreateToggleMenuPanel(PageFlingsPanel, "Arm Mover", "ArmAnim", nil)
local DropFlgArmPanel = CreateDropdownMenuPanel(PageFlingsPanel, "Advanced Arm Mover")
CreateStepperMenuPanel(DropFlgArmPanel, "Arm Speed", "ArmSpeed", "ArmAnim", false)
CreateStepperMenuPanel(DropFlgArmPanel, "Arm Intensity", "ArmIntensity", "ArmAnim", true)

CreateButtonMenuPanel(PageWorldPanel, "Get Obliterator Tool", Color3.fromRGB(138, 43, 226), function()
    pcall(function()
        local bpackOblPanel = PlayerLocal:WaitForChild("Backpack")
        local tOblPanel = Instance.new("Tool")
        tOblPanel.Name = "OBLITERATOR"
        tOblPanel.RequiresHandle = true
        
        local hOblPanel = Instance.new("Part")
        hOblPanel.Name = "Handle"
        hOblPanel.Size = Vector3.new(1, 1, 1)
        hOblPanel.Color = Color3.fromRGB(138, 43, 226)
        hOblPanel.Parent = tOblPanel

        tOblPanel.Activated:Connect(function()
            pcall(function()
                local msOblPanel = PlayerLocal:GetMouse()
                local tgtOblPanel = msOblPanel.Target
                if tgtOblPanel then
                    if tgtOblPanel:IsA("BasePart") then
                        local lpChOblPanel = PlayerLocal.Character
                        if not tgtOblPanel:IsDescendantOf(lpChOblPanel) then
                            tgtOblPanel.CanCollide = false
                            tgtOblPanel.Transparency = 1
                            tgtOblPanel:BreakJoints()
                            tgtOblPanel.Position = Vector3.new(0, -1000, 0)
                        end
                    end
                end
            end)
        end)
        tOblPanel.Parent = bpackOblPanel
        TriggerNotificationPanel("Obliterator", "Tool added to Backpack!", 2)
    end)
end, nil)

CreateButtonMenuPanel(PageWorldPanel, "Switch to R6", Color3.fromRGB(0, 150, 200), function()
    pcall(function()
        local chR6Panel = PlayerLocal.Character
        if chR6Panel then
            local humR6Panel = chR6Panel:FindFirstChildOfClass("Humanoid")
            if humR6Panel then
                if humR6Panel.RigType == Enum.HumanoidRigType.R15 then
                    local uidR6Panel = PlayerLocal.UserId
                    local dscR6Panel = ServicePlayers:GetHumanoidDescriptionFromUserId(uidR6Panel)
                    local modR6Panel = ServicePlayers:CreateHumanoidModelFromDescription(dscR6Panel, Enum.HumanoidRigType.R6)
                    
                    modR6Panel:PivotTo(chR6Panel:GetPivot())
                    modR6Panel.Name = PlayerLocal.Name
                    PlayerLocal.Character = modR6Panel
                    modR6Panel.Parent = ServiceWorkspace
                end
            end
        end
    end)
end, nil)

CreateButtonMenuPanel(PageWorldPanel, "Switch to R15", Color3.fromRGB(0, 200, 150), function()
    pcall(function()
        local chR15Panel = PlayerLocal.Character
        if chR15Panel then
            local humR15Panel = chR15Panel:FindFirstChildOfClass("Humanoid")
            if humR15Panel then
                if humR15Panel.RigType == Enum.HumanoidRigType.R6 then
                    local uidR15Panel = PlayerLocal.UserId
                    local dscR15Panel = ServicePlayers:GetHumanoidDescriptionFromUserId(uidR15Panel)
                    local modR15Panel = ServicePlayers:CreateHumanoidModelFromDescription(dscR15Panel, Enum.HumanoidRigType.R15)
                    
                    modR15Panel:PivotTo(chR15Panel:GetPivot())
                    modR15Panel.Name = PlayerLocal.Name
                    PlayerLocal.Character = modR15Panel
                    modR15Panel.Parent = ServiceWorkspace
                end
            end
        end
    end)
end, nil)

CreateStepperMenuPanel(PageWorldPanel, "Wide Avatar", "WideAvatar", nil, true)

CreateToggleMenuPanel(PageWorldPanel, "Super Rings", "SuperRing", nil)
local DropWldRingPanel = CreateDropdownMenuPanel(PageWorldPanel, "Advanced Rings")
CreateStepperMenuPanel(DropWldRingPanel, "Ring Speed", "RingSpeed", "SuperRing", false)
CreateStepperMenuPanel(DropWldRingPanel, "Ring Height", "RingHeight", "SuperRing", false)
CreateStepperMenuPanel(DropWldRingPanel, "Ring Distance", "RingDistance", "SuperRing", false)
CreateStepperMenuPanel(DropWldRingPanel, "Attraction Power", "RingAttraction", "SuperRing", false)

CreateToggleMenuPanel(PageWorldPanel, "Blackhole", "Blackhole", nil)
local DropWldBHPanel = CreateDropdownMenuPanel(PageWorldPanel, "Advanced Blackhole")
CreateStepperMenuPanel(DropWldBHPanel, "Blackhole Distance", "BlackholeDistance", "Blackhole", false)

local ExecutorTabsDataList = {}
local currentActiveTabIdVal = 1
local tabCounterTotalVal = 1
local boxExecCodeInput = nil
local scrollTabsContainer = nil
local frameConsoleLogUI = nil
local frameSpyChatUI = nil

local function RefreshTabsRenderUI()
    pcall(function()
        for _, childCP in pairs(scrollTabsContainer:GetChildren()) do
            if childCP:IsA("Frame") then
                childCP:Destroy()
            end
        end
        
        for idTabP, dataTabP in ipairs(ExecutorTabsDataList) do
            local fTabP = Instance.new("Frame")
            fTabP.Parent = scrollTabsContainer
            fTabP.Size = UDim2.new(0, 100, 0, 25)
            
            if currentActiveTabIdVal == idTabP then
                fTabP.BackgroundColor3 = StateData.MainColor
            end
            if currentActiveTabIdVal ~= idTabP then
                fTabP.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
            end
            
            local crFTabP = Instance.new("UICorner")
            crFTabP.CornerRadius = UDim.new(0, 4)
            crFTabP.Parent = fTabP
            
            local btnSelTabP = Instance.new("TextButton")
            btnSelTabP.Parent = fTabP
            btnSelTabP.BackgroundTransparency = 1
            btnSelTabP.Position = UDim2.new(0, 0, 0, 0)
            btnSelTabP.Size = UDim2.new(0.7, 0, 1, 0)
            btnSelTabP.Font = Enum.Font.GothamBold
            btnSelTabP.Text = dataTabP.Name
            btnSelTabP.TextColor3 = Color3.fromRGB(255, 255, 255)
            btnSelTabP.TextSize = 10
            
            local btnClsTabP = Instance.new("TextButton")
            btnClsTabP.Parent = fTabP
            btnClsTabP.BackgroundTransparency = 1
            btnClsTabP.Position = UDim2.new(0.7, 0, 0, 0)
            btnClsTabP.Size = UDim2.new(0.3, 0, 1, 0)
            btnClsTabP.Font = Enum.Font.GothamBold
            btnClsTabP.Text = "X"
            btnClsTabP.TextColor3 = Color3.fromRGB(200, 100, 100)
            btnClsTabP.TextSize = 10
            
            btnSelTabP.MouseButton1Click:Connect(function()
                pcall(function()
                    local currDataP = ExecutorTabsDataList[currentActiveTabIdVal]
                    if currDataP then
                        currDataP.Source = boxExecCodeInput.Text
                    end
                    currentActiveTabIdVal = idTabP
                    local newDataP = ExecutorTabsDataList[currentActiveTabIdVal]
                    if newDataP then
                        boxExecCodeInput.Text = newDataP.Source
                    end
                    RefreshTabsRenderUI()
                end)
            end)
            
            btnClsTabP.MouseButton1Click:Connect(function()
                pcall(function()
                    if #ExecutorTabsDataList > 1 then
                        table.remove(ExecutorTabsDataList, idTabP)
                        if currentActiveTabIdVal == idTabP then
                            currentActiveTabIdVal = 1
                            local defDataP = ExecutorTabsDataList[currentActiveTabIdVal]
                            if defDataP then
                                boxExecCodeInput.Text = defDataP.Source
                            end
                        end
                        if idTabP < currentActiveTabIdVal then
                            currentActiveTabIdVal = currentActiveTabIdVal - 1
                        end
                        RefreshTabsRenderUI()
                    end
                end)
            end)
        end
    end)
end

pcall(function()
    local execDataInitP = {}
    execDataInitP.Name = "Script 1"
    execDataInitP.Source = ""
    table.insert(ExecutorTabsDataList, execDataInitP)
    
    local frameExecContP = Instance.new("Frame")
    frameExecContP.Parent = PageExecutorPanel
    frameExecContP.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
    frameExecContP.Size = UDim2.new(1, -5, 0, 600)
    
    local strExecContP = Instance.new("UIStroke")
    strExecContP.Parent = frameExecContP
    strExecContP.Color = Color3.fromRGB(40, 45, 60)
    strExecContP.Thickness = 1
    
    local crExecContP = Instance.new("UICorner")
    crExecContP.CornerRadius = UDim.new(0, 8)
    crExecContP.Parent = frameExecContP

    local frameTabBarP = Instance.new("Frame")
    frameTabBarP.Parent = frameExecContP
    frameTabBarP.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
    frameTabBarP.Position = UDim2.new(0, 0, 0, 0)
    frameTabBarP.Size = UDim2.new(1, 0, 0, 35)
    
    local crTabBarP = Instance.new("UICorner")
    crTabBarP.CornerRadius = UDim.new(0, 8)
    crTabBarP.Parent = frameTabBarP

    scrollTabsContainer = Instance.new("ScrollingFrame")
    scrollTabsContainer.Parent = frameTabBarP
    scrollTabsContainer.BackgroundTransparency = 1
    scrollTabsContainer.Position = UDim2.new(0, 0, 0, 0)
    scrollTabsContainer.Size = UDim2.new(1, -40, 1, 0)
    scrollTabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollTabsContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
    scrollTabsContainer.ScrollBarThickness = 0

    local listTabsP = Instance.new("UIListLayout")
    listTabsP.Parent = scrollTabsContainer
    listTabsP.FillDirection = Enum.FillDirection.Horizontal
    listTabsP.SortOrder = Enum.SortOrder.LayoutOrder
    listTabsP.Padding = UDim.new(0, 5)

    local padScrollTabsP = Instance.new("UIPadding")
    padScrollTabsP.Parent = scrollTabsContainer
    padScrollTabsP.PaddingLeft = UDim.new(0, 5)
    padScrollTabsP.PaddingTop = UDim.new(0, 5)
    
    local btnAddTabP = Instance.new("TextButton")
    btnAddTabP.Parent = frameTabBarP
    btnAddTabP.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
    btnAddTabP.Position = UDim2.new(1, -35, 0, 5)
    btnAddTabP.Size = UDim2.new(0, 25, 0, 25)
    btnAddTabP.Font = Enum.Font.GothamBold
    btnAddTabP.Text = "+"
    btnAddTabP.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    local crAddTabP = Instance.new("UICorner")
    crAddTabP.CornerRadius = UDim.new(0, 4)
    crAddTabP.Parent = btnAddTabP

    boxExecCodeInput = Instance.new("TextBox")
    boxExecCodeInput.Parent = frameExecContP
    boxExecCodeInput.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
    boxExecCodeInput.Position = UDim2.new(0, 10, 0, 45)
    boxExecCodeInput.Size = UDim2.new(1, -20, 0, 140)
    boxExecCodeInput.Font = Enum.Font.Code
    boxExecCodeInput.Text = ""
    boxExecCodeInput.PlaceholderText = "-- Write your script here..."
    boxExecCodeInput.TextColor3 = Color3.fromRGB(220, 220, 220)
    boxExecCodeInput.TextSize = 12
    boxExecCodeInput.TextXAlignment = Enum.TextXAlignment.Left
    boxExecCodeInput.TextYAlignment = Enum.TextYAlignment.Top
    boxExecCodeInput.ClearTextOnFocus = false
    boxExecCodeInput.MultiLine = true
    
    local crBoxExecP = Instance.new("UICorner")
    crBoxExecP.CornerRadius = UDim.new(0, 6)
    crBoxExecP.Parent = boxExecCodeInput
    
    local padBoxExecP = Instance.new("UIPadding")
    padBoxExecP.Parent = boxExecCodeInput
    padBoxExecP.PaddingLeft = UDim.new(0, 5)
    padBoxExecP.PaddingTop = UDim.new(0, 5)

    local frameActionsP = Instance.new("Frame")
    frameActionsP.Parent = frameExecContP
    frameActionsP.BackgroundTransparency = 1
    frameActionsP.Position = UDim2.new(0, 10, 0, 195)
    frameActionsP.Size = UDim2.new(1, -20, 0, 30)

    local btnExecLuaP = Instance.new("TextButton")
    btnExecLuaP.Parent = frameActionsP
    btnExecLuaP.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    btnExecLuaP.Position = UDim2.new(0, 0, 0, 0)
    btnExecLuaP.Size = UDim2.new(0.3, 0, 1, 0)
    btnExecLuaP.Font = Enum.Font.GothamBold
    btnExecLuaP.Text = "Execute"
    btnExecLuaP.TextColor3 = Color3.fromRGB(0, 0, 0)
    
    local crExecLuaP = Instance.new("UICorner")
    crExecLuaP.CornerRadius = UDim.new(0, 4)
    crExecLuaP.Parent = btnExecLuaP

    local btnCopyLuaP = Instance.new("TextButton")
    btnCopyLuaP.Parent = frameActionsP
    btnCopyLuaP.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
    btnCopyLuaP.Position = UDim2.new(0.35, 0, 0, 0)
    btnCopyLuaP.Size = UDim2.new(0.3, 0, 1, 0)
    btnCopyLuaP.Font = Enum.Font.GothamBold
    btnCopyLuaP.Text = "Copy"
    btnCopyLuaP.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local crCopyLuaP = Instance.new("UICorner")
    crCopyLuaP.CornerRadius = UDim.new(0, 4)
    crCopyLuaP.Parent = btnCopyLuaP

    local btnClearLuaP = Instance.new("TextButton")
    btnClearLuaP.Parent = frameActionsP
    btnClearLuaP.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btnClearLuaP.Position = UDim2.new(0.7, 0, 0, 0)
    btnClearLuaP.Size = UDim2.new(0.3, 0, 1, 0)
    btnClearLuaP.Font = Enum.Font.GothamBold
    btnClearLuaP.Text = "Clear"
    btnClearLuaP.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local crClearLuaP = Instance.new("UICorner")
    crClearLuaP.CornerRadius = UDim.new(0, 4)
    crClearLuaP.Parent = btnClearLuaP

    frameConsoleLogUI = Instance.new("ScrollingFrame")
    frameConsoleLogUI.Parent = frameExecContP
    frameConsoleLogUI.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    frameConsoleLogUI.Position = UDim2.new(0, 10, 0, 235)
    frameConsoleLogUI.Size = UDim2.new(1, -20, 0, 100)
    frameConsoleLogUI.ScrollBarThickness = 2
    frameConsoleLogUI.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local crConsoleP = Instance.new("UICorner")
    crConsoleP.CornerRadius = UDim.new(0, 4)
    crConsoleP.Parent = frameConsoleLogUI
    
    local listConsoleP = Instance.new("UIListLayout")
    listConsoleP.Parent = frameConsoleLogUI
    listConsoleP.SortOrder = Enum.SortOrder.LayoutOrder
    
    local padConsoleP = Instance.new("UIPadding")
    padConsoleP.Parent = frameConsoleLogUI
    padConsoleP.PaddingLeft = UDim.new(0, 5)
    padConsoleP.PaddingTop = UDim.new(0, 2)

    local btnCopyLogsAllP = Instance.new("TextButton")
    btnCopyLogsAllP.Parent = frameExecContP
    btnCopyLogsAllP.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
    btnCopyLogsAllP.Position = UDim2.new(0, 10, 0, 345)
    btnCopyLogsAllP.Size = UDim2.new(1, -20, 0, 30)
    btnCopyLogsAllP.Font = Enum.Font.GothamBold
    btnCopyLogsAllP.Text = "Copy All Logs"
    btnCopyLogsAllP.TextColor3 = Color3.fromRGB(255, 255, 255)

    local crCpyLgP = Instance.new("UICorner")
    crCpyLgP.CornerRadius = UDim.new(0, 4)
    crCpyLgP.Parent = btnCopyLogsAllP

    local lblSpyTitleP = Instance.new("TextLabel")
    lblSpyTitleP.Parent = frameExecContP
    lblSpyTitleP.BackgroundTransparency = 1
    lblSpyTitleP.Position = UDim2.new(0, 10, 0, 385)
    lblSpyTitleP.Size = UDim2.new(1, -20, 0, 20)
    lblSpyTitleP.Font = Enum.Font.GothamBold
    lblSpyTitleP.Text = "View All Player Messages"
    lblSpyTitleP.TextColor3 = Color3.fromRGB(200, 220, 255)
    lblSpyTitleP.TextSize = 12
    lblSpyTitleP.TextXAlignment = Enum.TextXAlignment.Left

    frameSpyChatUI = Instance.new("ScrollingFrame")
    frameSpyChatUI.Parent = frameExecContP
    frameSpyChatUI.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    frameSpyChatUI.Position = UDim2.new(0, 10, 0, 410)
    frameSpyChatUI.Size = UDim2.new(1, -20, 0, 140)
    frameSpyChatUI.ScrollBarThickness = 2
    frameSpyChatUI.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local crSpyMP = Instance.new("UICorner")
    crSpyMP.CornerRadius = UDim.new(0, 4)
    crSpyMP.Parent = frameSpyChatUI

    local listSpyP = Instance.new("UIListLayout")
    listSpyP.Parent = frameSpyChatUI
    listSpyP.SortOrder = Enum.SortOrder.LayoutOrder

    local padSpyP = Instance.new("UIPadding")
    padSpyP.Parent = frameSpyChatUI
    padSpyP.PaddingLeft = UDim.new(0, 5)
    padSpyP.PaddingTop = UDim.new(0, 2)

    local boxSpyInputP = Instance.new("TextBox")
    boxSpyInputP.Parent = frameExecContP
    boxSpyInputP.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
    boxSpyInputP.Position = UDim2.new(0, 10, 0, 560)
    boxSpyInputP.Size = UDim2.new(1, -90, 0, 30)
    boxSpyInputP.Font = Enum.Font.Gotham
    boxSpyInputP.Text = ""
    boxSpyInputP.PlaceholderText = "Type message..."
    boxSpyInputP.TextColor3 = Color3.fromRGB(255, 255, 255)
    boxSpyInputP.TextSize = 12

    local strSpyIP = Instance.new("UIStroke")
    strSpyIP.Parent = boxSpyInputP
    strSpyIP.Color = Color3.fromRGB(40, 45, 60)
    strSpyIP.Thickness = 1

    local crSpyIP = Instance.new("UICorner")
    crSpyIP.CornerRadius = UDim.new(0, 4)
    crSpyIP.Parent = boxSpyInputP

    local btnSpySendP = Instance.new("TextButton")
    btnSpySendP.Parent = frameExecContP
    btnSpySendP.BackgroundColor3 = StateData.MainColor
    btnSpySendP.Position = UDim2.new(1, -70, 0, 560)
    btnSpySendP.Size = UDim2.new(0, 60, 0, 30)
    btnSpySendP.Font = Enum.Font.GothamBold
    btnSpySendP.Text = "Send"
    btnSpySendP.TextColor3 = Color3.fromRGB(255, 255, 255)

    local crSpySP = Instance.new("UICorner")
    crSpySP.CornerRadius = UDim.new(0, 4)
    crSpySP.Parent = btnSpySendP

    ServiceRun.RenderStepped:Connect(function()
        pcall(function()
            btnSpySendP.BackgroundColor3 = StateData.MainColor
        end)
    end)

    btnAddTabP.MouseButton1Click:Connect(function()
        pcall(function()
            local currDataSaveP = ExecutorTabsDataList[currentActiveTabIdVal]
            if currDataSaveP then
                currDataSaveP.Source = boxExecCodeInput.Text
            end
            
            tabCounterTotalVal = tabCounterTotalVal + 1
            local newTabObjP = {}
            newTabObjP.Name = "Script " .. tostring(tabCounterTotalVal)
            newTabObjP.Source = ""
            table.insert(ExecutorTabsDataList, newTabObjP)
            
            currentActiveTabIdVal = #ExecutorTabsDataList
            boxExecCodeInput.Text = ""
            RefreshTabsRenderUI()
        end)
    end)

    btnExecLuaP.MouseButton1Click:Connect(function()
        pcall(function()
            if type(loadstring) == "function" then
                local execFuncVarP, errLoadLP = loadstring(boxExecCodeInput.Text)
                if type(execFuncVarP) == "function" then
                    local succRP, errRP = pcall(function()
                        execFuncVarP()
                    end)
                    if not succRP then
                        TriggerNotificationPanel("Executor", "Runtime Error: " .. tostring(errRP), 4)
                    end
                end
                if type(execFuncVarP) ~= "function" then
                    TriggerNotificationPanel("Executor", "Syntax Error: " .. tostring(errLoadLP), 4)
                end
            end
            if type(loadstring) ~= "function" then
                TriggerNotificationPanel("Executor", "Loadstring is not enabled/supported on this executor.", 4)
            end
        end)
    end)

    btnCopyLuaP.MouseButton1Click:Connect(function()
        pcall(function()
            if type(setclipboard) == "function" then
                setclipboard(boxExecCodeInput.Text)
                TriggerNotificationPanel("Executor", "Code copied to clipboard.", 2)
            end
            if type(setclipboard) ~= "function" then
                TriggerNotificationPanel("Executor", "Clipboard function not supported.", 3)
            end
        end)
    end)

    btnClearLuaP.MouseButton1Click:Connect(function()
        pcall(function()
            boxExecCodeInput.Text = ""
        end)
    end)

    boxExecCodeInput:GetPropertyChangedSignal("Text"):Connect(function()
        pcall(function()
            local currDataUpdP = ExecutorTabsDataList[currentActiveTabIdVal]
            if currDataUpdP then
                currDataUpdP.Source = boxExecCodeInput.Text
            end
        end)
    end)

    ServiceLog.MessageOut:Connect(function(msgLogP, typeLogP)
        pcall(function()
            local lblLogP = Instance.new("TextLabel")
            lblLogP.Parent = frameConsoleLogUI
            lblLogP.BackgroundTransparency = 1
            lblLogP.Size = UDim2.new(1, 0, 0, 15)
            lblLogP.Font = Enum.Font.Code
            lblLogP.Text = msgLogP
            lblLogP.TextSize = 10
            lblLogP.TextXAlignment = Enum.TextXAlignment.Left
            
            if typeLogP == Enum.MessageType.MessageWarning then
                lblLogP.TextColor3 = Color3.fromRGB(255, 200, 50)
            end
            if typeLogP == Enum.MessageType.MessageError then
                lblLogP.TextColor3 = Color3.fromRGB(255, 50, 50)
            end
            if typeLogP == Enum.MessageType.MessageInfo then
                lblLogP.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
            if typeLogP == Enum.MessageType.MessageOutput then
                lblLogP.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end)
    end)

    btnCopyLogsAllP.MouseButton1Click:Connect(function()
        pcall(function()
            local fullLogTextP = ""
            for _, lgChildP in pairs(frameConsoleLogUI:GetChildren()) do
                if lgChildP:IsA("TextLabel") then
                    fullLogTextP = fullLogTextP .. lgChildP.Text .. "\n"
                end
            end
            if type(setclipboard) == "function" then
                setclipboard(fullLogTextP)
                TriggerNotificationPanel("Logs", "All logs copied to clipboard.", 2)
            end
            if type(setclipboard) ~= "function" then
                TriggerNotificationPanel("Logs", "Clipboard function not supported.", 3)
            end
        end)
    end)

    local function processChatSpyLogP(playerNameLogP, playerTextLogP)
        pcall(function()
            local lblSpyP = Instance.new("TextLabel")
            lblSpyP.Parent = frameSpyChatUI
            lblSpyP.BackgroundTransparency = 1
            lblSpyP.Size = UDim2.new(1, 0, 0, 15)
            lblSpyP.Font = Enum.Font.Gotham
            lblSpyP.Text = "[" .. playerNameLogP .. "]: " .. playerTextLogP
            lblSpyP.TextSize = 12
            lblSpyP.TextXAlignment = Enum.TextXAlignment.Left
            lblSpyP.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
    end

    local function hookPlayerChatP(playerToHookP)
        pcall(function()
            playerToHookP.Chatted:Connect(function(msgChatRecvP)
                processChatSpyLogP(playerToHookP.Name, msgChatRecvP)
            end)
        end)
    end

    for _, pSpyInitP in pairs(ServicePlayers:GetPlayers()) do
        hookPlayerChatP(pSpyInitP)
    end

    ServicePlayers.PlayerAdded:Connect(function(newPlrSpyP)
        hookPlayerChatP(newPlrSpyP)
    end)

    btnSpySendP.MouseButton1Click:Connect(function()
        pcall(function()
            local textToSendP = boxSpyInputP.Text
            if string.len(textToSendP) > 0 then
                local defChatSysP = ServiceReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                if defChatSysP then
                    local sayMsgEvtP = defChatSysP:FindFirstChild("SayMessageRequest")
                    if sayMsgEvtP then
                        sayMsgEvtP:FireServer(textToSendP, "All")
                    end
                end
                
                if not defChatSysP then
                    local txtChansP = ServiceTextChat:FindFirstChild("TextChannels")
                    if txtChansP then
                        local rbxGenP = txtChansP:FindFirstChild("RBXGeneral")
                        if rbxGenP then
                            rbxGenP:SendAsync(textToSendP)
                        end
                    end
                end
                
                boxSpyInputP.Text = ""
            end
        end)
    end)

    RefreshTabsRenderUI()
end)

local FrameCUIBoxPanel = Instance.new("Frame")
pcall(function()
    FrameCUIBoxPanel.Parent = PageCustomUIPanel
    FrameCUIBoxPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 26)
    FrameCUIBoxPanel.Size = UDim2.new(1, -5, 0, 60)
    local crCUIBPanel = Instance.new("UICorner")
    crCUIBPanel.CornerRadius = UDim.new(0, 8)
    crCUIBPanel.Parent = FrameCUIBoxPanel

    local StrCUIBPanel = Instance.new("UIStroke")
    StrCUIBPanel.Parent = FrameCUIBoxPanel
    StrCUIBPanel.Color = StateData.MainColor
    StrCUIBPanel.Thickness = 2

    local LblCUITPanel = Instance.new("TextLabel")
    LblCUITPanel.Parent = FrameCUIBoxPanel
    LblCUITPanel.BackgroundTransparency = 1
    LblCUITPanel.Size = UDim2.new(1, 0, 1, 0)
    LblCUITPanel.Font = Enum.Font.GothamBold
    LblCUITPanel.Text = "PREVIEW COLOR"
    LblCUITPanel.TextColor3 = StateData.MainColor
    LblCUITPanel.TextSize = 14

    local TmpColorDataPanel = StateData.MainColor

    local FrameCUIPalPanel = Instance.new("Frame")
    FrameCUIPalPanel.Parent = PageCustomUIPanel
    FrameCUIPalPanel.BackgroundTransparency = 1
    FrameCUIPalPanel.Size = UDim2.new(1, -5, 0, 150)

    local GridCUIPalPanel = Instance.new("UIGridLayout")
    GridCUIPalPanel.Parent = FrameCUIPalPanel
    GridCUIPalPanel.CellSize = UDim2.new(0, 30, 0, 30)
    GridCUIPalPanel.CellPadding = UDim2.new(0, 5, 0, 5)
    GridCUIPalPanel.SortOrder = Enum.SortOrder.LayoutOrder

    local colorListTblPanel = {}
    table.insert(colorListTblPanel, Color3.fromRGB(255,0,0))
    table.insert(colorListTblPanel, Color3.fromRGB(0,255,0))
    table.insert(colorListTblPanel, Color3.fromRGB(0,0,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,255,0))
    table.insert(colorListTblPanel, Color3.fromRGB(255,0,255))
    table.insert(colorListTblPanel, Color3.fromRGB(0,255,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,128,0))
    table.insert(colorListTblPanel, Color3.fromRGB(128,0,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,0,128))
    table.insert(colorListTblPanel, Color3.fromRGB(0,255,128))
    table.insert(colorListTblPanel, Color3.fromRGB(128,255,0))
    table.insert(colorListTblPanel, Color3.fromRGB(0,128,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,255,255))
    table.insert(colorListTblPanel, Color3.fromRGB(100,100,100))
    table.insert(colorListTblPanel, Color3.fromRGB(50,50,50))
    table.insert(colorListTblPanel, Color3.fromRGB(138,43,226))
    table.insert(colorListTblPanel, Color3.fromRGB(0,200,150))
    table.insert(colorListTblPanel, Color3.fromRGB(255,100,100))
    table.insert(colorListTblPanel, Color3.fromRGB(100,255,100))
    table.insert(colorListTblPanel, Color3.fromRGB(100,100,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,200,100))
    table.insert(colorListTblPanel, Color3.fromRGB(200,255,100))
    table.insert(colorListTblPanel, Color3.fromRGB(100,200,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,150,0))
    table.insert(colorListTblPanel, Color3.fromRGB(0,150,255))
    table.insert(colorListTblPanel, Color3.fromRGB(150,0,255))
    table.insert(colorListTblPanel, Color3.fromRGB(255,0,150))
    table.insert(colorListTblPanel, Color3.fromRGB(0,255,150))
    table.insert(colorListTblPanel, Color3.fromRGB(150,255,0))
    table.insert(colorListTblPanel, Color3.fromRGB(200,0,0))
    table.insert(colorListTblPanel, Color3.fromRGB(0,200,0))
    table.insert(colorListTblPanel, Color3.fromRGB(0,0,200))
    table.insert(colorListTblPanel, Color3.fromRGB(200,200,0))
    table.insert(colorListTblPanel, Color3.fromRGB(200,0,200))
    table.insert(colorListTblPanel, Color3.fromRGB(0,200,200))

    for _, colorValPanel in ipairs(colorListTblPanel) do
        local btnColPltPanel = Instance.new("TextButton")
        btnColPltPanel.Parent = FrameCUIPalPanel
        btnColPltPanel.BackgroundColor3 = colorValPanel
        btnColPltPanel.Text = ""
        local crColPltPanel = Instance.new("UICorner")
        crColPltPanel.CornerRadius = UDim.new(0, 4)
        crColPltPanel.Parent = btnColPltPanel
        
        btnColPltPanel.MouseButton1Click:Connect(function()
            pcall(function()
                TmpColorDataPanel = colorValPanel
                StrCUIBPanel.Color = TmpColorDataPanel
                LblCUITPanel.TextColor3 = TmpColorDataPanel
            end)
        end)
    end

    CreateDualSwitchMenuPanel(PageCustomUIPanel, "RGB Gaming Modern", "RGBGaming")

    CreateButtonMenuPanel(PageCustomUIPanel, "Test Notify Custom", "Main", function()
        pcall(function()
            local oldColorSavPanel = StateData.MainColor
            StateData.MainColor = TmpColorDataPanel
            TriggerNotificationPanel("Test Custom", "This is how it looks!", 3)
            StateData.MainColor = oldColorSavPanel
        end)
    end, nil)

    CreateButtonMenuPanel(PageCustomUIPanel, "Apply Change", Color3.fromRGB(50, 200, 100), function()
        pcall(function()
            StateData.MainColor = TmpColorDataPanel
            SaveConfigurationSettings()
            TriggerNotificationPanel("Theme Saved", "Colors applied successfully.", 3)
        end)
    end, nil)

    CreateButtonMenuPanel(PageCustomUIPanel, "Cancel", Color3.fromRGB(200, 50, 50), function()
        pcall(function()
            TmpColorDataPanel = StateData.MainColor
            StrCUIBPanel.Color = TmpColorDataPanel
            LblCUITPanel.TextColor3 = TmpColorDataPanel
        end)
    end, nil)

    CreateDualSwitchMenuPanel(PageSettingsPanel, "Performance Mode (HP Kentang)", "PerformanceMode")

    local tpWalkingStateFlyPanel = false
    local FlyBVInsPanel = nil
    local FlyBGInsPanel = nil

    ServiceRun.RenderStepped:Connect(function()
        pcall(function()
            if StateData.Fly then
                if not tpWalkingStateFlyPanel then
                    local charFly1Panel = PlayerLocal.Character
                    local humFly1Panel = nil
                    local rootFly1Panel = nil
                    local torsoFly1Panel = nil
                    
                    if charFly1Panel then
                        humFly1Panel = charFly1Panel:FindFirstChildWhichIsA("Humanoid")
                        rootFly1Panel = charFly1Panel:FindFirstChild("HumanoidRootPart")
                        torsoFly1Panel = charFly1Panel:FindFirstChild("Torso")
                        if not torsoFly1Panel then
                            torsoFly1Panel = charFly1Panel:FindFirstChild("UpperTorso")
                        end
                    end
                    
                    local hasAllFly1Panel = false
                    if humFly1Panel then
                        if rootFly1Panel then
                            if torsoFly1Panel then
                                hasAllFly1Panel = true
                            end
                        end
                    end
                    
                    if hasAllFly1Panel then
                        tpWalkingStateFlyPanel = true
                        if FlyBVInsPanel then 
                            FlyBVInsPanel:Destroy() 
                        end
                        if FlyBGInsPanel then 
                            FlyBGInsPanel:Destroy() 
                        end
                        
                        FlyBGInsPanel = Instance.new("BodyGyro")
                        FlyBGInsPanel.Parent = torsoFly1Panel
                        FlyBGInsPanel.P = 9e4
                        FlyBGInsPanel.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                        
                        FlyBVInsPanel = Instance.new("BodyVelocity")
                        FlyBVInsPanel.Parent = torsoFly1Panel
                        FlyBVInsPanel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        
                        humFly1Panel.PlatformStand = true
                        local animCharFlyPanel = charFly1Panel:FindFirstChild("Animate")
                        if animCharFlyPanel then
                            animCharFlyPanel.Disabled = true
                        end
                        
                        for _, trackFlyTPanel in pairs(humFly1Panel:GetPlayingAnimationTracks()) do
                            trackFlyTPanel:Stop()
                        end
                    end
                end
            end
            
            if not StateData.Fly then
                if tpWalkingStateFlyPanel then
                    tpWalkingStateFlyPanel = false
                    if FlyBVInsPanel then 
                        FlyBVInsPanel:Destroy() 
                    end
                    if FlyBGInsPanel then 
                        FlyBGInsPanel:Destroy() 
                    end
                    
                    local charFly2Panel = PlayerLocal.Character
                    if charFly2Panel then
                        local humFly2Panel = charFly2Panel:FindFirstChildWhichIsA("Humanoid")
                        if humFly2Panel then 
                            humFly2Panel.PlatformStand = false 
                            humFly2Panel:ChangeState(Enum.HumanoidStateType.GettingUp) 
                        end
                        local animCharFly2Panel = charFly2Panel:FindFirstChild("Animate")
                        if animCharFly2Panel then 
                            animCharFly2Panel.Disabled = false 
                        end
                    end
                end
            end

            if StateData.Fly then
                if tpWalkingStateFlyPanel then
                    if FlyBVInsPanel then
                        if FlyBGInsPanel then
                            local charFly3Panel = PlayerLocal.Character
                            local humFly3Panel = nil
                            if charFly3Panel then
                                humFly3Panel = charFly3Panel:FindFirstChild("Humanoid")
                            end
                            
                            if humFly3Panel then
                                FlyBGInsPanel.CFrame = CameraCurrent.CFrame
                                local moveDirFlyPanel = humFly3Panel.MoveDirection
                                
                                if moveDirFlyPanel.Magnitude > 0 then
                                    local cLookXFlyPanel = CameraCurrent.CFrame.LookVector.X
                                    local cLookZFlyPanel = CameraCurrent.CFrame.LookVector.Z
                                    local camLookFlatFlyPanel = Vector3.new(cLookXFlyPanel, 0, cLookZFlyPanel).Unit
                                    
                                    local cRightXFlyPanel = CameraCurrent.CFrame.RightVector.X
                                    local cRightZFlyPanel = CameraCurrent.CFrame.RightVector.Z
                                    local camRightFlatFlyPanel = Vector3.new(cRightXFlyPanel, 0, cRightZFlyPanel).Unit
                                    
                                    local fwdMoveFlyPanel = moveDirFlyPanel:Dot(camLookFlatFlyPanel)
                                    local rgtMoveFlyPanel = moveDirFlyPanel:Dot(camRightFlatFlyPanel)
                                    
                                    local fwdVecFlyPanel = CameraCurrent.CFrame.LookVector * fwdMoveFlyPanel
                                    local rgtVecFlyPanel = CameraCurrent.CFrame.RightVector * rgtMoveFlyPanel
                                    local flyDirFlyPanel = fwdVecFlyPanel + rgtVecFlyPanel
                                    
                                    if flyDirFlyPanel.Magnitude > 0 then 
                                        flyDirFlyPanel = flyDirFlyPanel.Unit 
                                    end
                                    
                                    FlyBVInsPanel.Velocity = flyDirFlyPanel * (StateData.FlySpeed * 50)
                                end
                                if moveDirFlyPanel.Magnitude <= 0 then
                                    FlyBVInsPanel.Velocity = Vector3.new(0, 0, 0)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)

    local EspDataStoragePanel = {}
    local isHasDrawingApiPanel = false
    pcall(function() 
        local testLineDrPanel = Drawing.new("Line") 
        isHasDrawingApiPanel = true
        testLineDrPanel:Remove()
    end)

    local FOVCircleInstPanel = nil
    if isHasDrawingApiPanel then
        pcall(function()
            FOVCircleInstPanel = Drawing.new("Circle")
            FOVCircleInstPanel.Color = Color3.fromRGB(255, 255, 255)
            FOVCircleInstPanel.Thickness = 1.5
            FOVCircleInstPanel.Filled = false
            FOVCircleInstPanel.Transparency = 1
        end)
    end

    local function GetClosestPlayerLogicPanel()
        local targetPlrPanel = nil
        pcall(function()
            local shortDistPlrPanel = StateData.Aim_FOVSize
            local centerScreenPlrPanel = Vector2.new(CameraCurrent.ViewportSize.X / 2, CameraCurrent.ViewportSize.Y / 2)
            
            for _, pPlrLoopPanel in pairs(ServicePlayers:GetPlayers()) do
                local isValidTargetPlrPanel = false
                if pPlrLoopPanel ~= PlayerLocal then
                    local charPPlrPanel = pPlrLoopPanel.Character
                    if charPPlrPanel then
                        local pHumPPlrPanel = charPPlrPanel:FindFirstChild("Humanoid")
                        local pPartPPlrPanel = charPPlrPanel:FindFirstChild(StateData.Aim_Part)
                        if pHumPPlrPanel then
                            if pHumPPlrPanel.Health > 0 then
                                if pPartPPlrPanel then
                                    isValidTargetPlrPanel = true
                                end
                            end
                        end
                    end
                end
                
                if isValidTargetPlrPanel then
                    local partPosPPlrPanel = pPlrLoopPanel.Character[StateData.Aim_Part].Position
                    local vPPlrPanel, onSPPlrPanel = CameraCurrent:WorldToViewportPoint(partPosPPlrPanel)
                    if onSPPlrPanel then
                        local vecDistPPlrPanel = Vector2.new(vPPlrPanel.X, vPPlrPanel.Y) - centerScreenPlrPanel
                        local dMagPPlrPanel = vecDistPPlrPanel.Magnitude
                        if dMagPPlrPanel < shortDistPlrPanel then
                            targetPlrPanel = pPlrLoopPanel
                            shortDistPlrPanel = dMagPPlrPanel 
                        end
                    end
                end
            end
        end)
        return targetPlrPanel
    end

    local OldNamecallHkPanel = nil
    pcall(function()
        if type(getnamecallmethod) == "function" then
            if type(hookmetamethod) == "function" then
                OldNamecallHkPanel = hookmetamethod(game, "__namecall", function(selfParamPanel, ...)
                    local methodHkPanel = getnamecallmethod()
                    local argsHkPanel = {...}
                    
                    local isOkHkPanel = false
                    if StateData.Aimbot then
                        if StateData.SilentAim then
                            if type(checkcaller) == "function" then
                                if not checkcaller() then
                                    isOkHkPanel = true
                                end
                            end
                        end
                    end
                    
                    if isOkHkPanel then
                        local isFindHkPanel = false
                        if methodHkPanel == "FindPartOnRayWithIgnoreList" then
                            isFindHkPanel = true
                        end
                        if methodHkPanel == "Raycast" then
                            isFindHkPanel = true
                        end
                        
                        if isFindHkPanel then
                            local closestHkPanel = GetClosestPlayerLogicPanel()
                            if closestHkPanel then
                                local charHkPanel = closestHkPanel.Character
                                if charHkPanel then
                                    local cPartHkPanel = charHkPanel:FindFirstChild(StateData.Aim_Part)
                                    if cPartHkPanel then
                                        local targetPosHkPanel = charHkPanel[StateData.Aim_Part].Position
                                        
                                        if methodHkPanel == "Raycast" then
                                            local originHk1Panel = argsHkPanel[1]
                                            argsHkPanel[2] = (targetPosHkPanel - originHk1Panel).Unit * 1000
                                            return OldNamecallHkPanel(selfParamPanel, unpack(argsHkPanel))
                                        end
                                        
                                        if methodHkPanel == "FindPartOnRayWithIgnoreList" then
                                            local originHk2Panel = argsHkPanel[1].Origin
                                            argsHkPanel[1] = Ray.new(originHk2Panel, (targetPosHkPanel - originHk2Panel).Unit * 1000)
                                            return OldNamecallHkPanel(selfParamPanel, unpack(argsHkPanel))
                                        end
                                    end
                                end
                            end
                        end
                    end
                    return OldNamecallHkPanel(selfParamPanel, ...)
                end)
            end
        end
    end)

    local function CreateESPLogicPanel(playerEspPanel)
        pcall(function()
            local espTbPanel = {}
            espTbPanel.Highlight = Instance.new("Highlight")
            espTbPanel.Highlight.FillColor = Color3.fromRGB(255, 50, 50)
            espTbPanel.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            espTbPanel.Highlight.FillTransparency = 0.5
            espTbPanel.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            
            if isHasDrawingApiPanel then
                espTbPanel.Tracer = Drawing.new("Line")
                espTbPanel.Tracer.Thickness = 1.5
                espTbPanel.Tracer.Color = Color3.fromRGB(255, 255, 255)
                
                espTbPanel.Box = Drawing.new("Square")
                espTbPanel.Box.Thickness = 1.5
                espTbPanel.Box.Color = Color3.fromRGB(255, 50, 50)
                espTbPanel.Box.Filled = false
                
                espTbPanel.HealthBg = Drawing.new("Line")
                espTbPanel.HealthBg.Thickness = 3
                espTbPanel.HealthBg.Color = Color3.fromRGB(0, 0, 0)
                
                espTbPanel.HealthFill = Drawing.new("Line")
                espTbPanel.HealthFill.Thickness = 1.5
                espTbPanel.HealthFill.Color = Color3.fromRGB(0, 255, 100)
                
                espTbPanel.Text = Drawing.new("Text")
                espTbPanel.Text.Size = 14
                espTbPanel.Text.Color = Color3.fromRGB(255, 255, 255)
                espTbPanel.Text.Center = true
                espTbPanel.Text.Outline = true
            end
            EspDataStoragePanel[playerEspPanel] = espTbPanel
        end)
    end

    local function RemoveESPLogicPanel(playerEspRmPanel)
        pcall(function()
            local espPPanel = EspDataStoragePanel[playerEspRmPanel]
            if espPPanel then
                if espPPanel.Highlight then 
                    espPPanel.Highlight:Destroy() 
                end
                if isHasDrawingApiPanel then
                    espPPanel.Tracer:Remove()
                    espPPanel.Box:Remove()
                    espPPanel.HealthBg:Remove()
                    espPPanel.HealthFill:Remove()
                    espPPanel.Text:Remove()
                end
                EspDataStoragePanel[playerEspRmPanel] = nil
            end
        end)
    end
    
    ServicePlayers.PlayerRemoving:Connect(RemoveESPLogicPanel)

    ServiceRun.RenderStepped:Connect(function()
        pcall(function()
            if CameraCurrent then
                if CameraCurrent.FieldOfView ~= StateData.POV then
                    CameraCurrent.FieldOfView = StateData.POV 
                end
            end

            local cxCamPanel = 0
            local cyCamPanel = 0
            if CameraCurrent then
                cxCamPanel = CameraCurrent.ViewportSize.X / 2
                cyCamPanel = CameraCurrent.ViewportSize.Y / 2
            end
            local centerScreenCamPanel = Vector2.new(cxCamPanel, cyCamPanel)
            
            if FOVCircleInstPanel then
                FOVCircleInstPanel.Position = centerScreenCamPanel
                FOVCircleInstPanel.Radius = StateData.Aim_FOVSize
                local combStFovPanel = false
                if StateData.Aimbot then
                    if StateData.Aim_ShowFOV then
                        combStFovPanel = true
                    end
                end
                
                if combStFovPanel then
                    FOVCircleInstPanel.Visible = true
                end
                if not combStFovPanel then
                    FOVCircleInstPanel.Visible = false
                end
            end
            
            local canAimMPanel = false
            if StateData.Aimbot then
                if not StateData.SilentAim then
                    canAimMPanel = true
                end
            end
            
            if canAimMPanel then
                local targetMPanel = GetClosestPlayerLogicPanel()
                if targetMPanel then 
                    local pPartPosMPanel = targetMPanel.Character[StateData.Aim_Part].Position
                    CameraCurrent.CFrame = CameraCurrent.CFrame:Lerp(CFrame.new(CameraCurrent.CFrame.Position, pPartPosMPanel), 0.2) 
                end
            end

            if StateData.ESP then
                for _, playerMPanel in pairs(ServicePlayers:GetPlayers()) do
                    if playerMPanel ~= PlayerLocal then
                        local charMPanel = playerMPanel.Character
                        local rootMPanel = nil
                        local headMPanel = nil
                        local humMPanel = nil
                        
                        if charMPanel then
                            rootMPanel = charMPanel:FindFirstChild("HumanoidRootPart")
                            headMPanel = charMPanel:FindFirstChild("Head")
                            humMPanel = charMPanel:FindFirstChild("Humanoid")
                        end
                        
                        local isOkCMPanel = false
                        if charMPanel then
                            if rootMPanel then
                                if headMPanel then
                                    if humMPanel then
                                        if humMPanel.Health > 0 then
                                            isOkCMPanel = true
                                        end
                                    end
                                end
                            end
                        end
                        
                        if isOkCMPanel then
                            if not EspDataStoragePanel[playerMPanel] then
                                CreateESPLogicPanel(playerMPanel) 
                            end
                            local espMPanel = EspDataStoragePanel[playerMPanel]
                            
                            if StateData.ESP_Chams then
                                if espMPanel.Highlight.Parent ~= charMPanel then
                                    espMPanel.Highlight.Parent = charMPanel 
                                end
                            end
                            if not StateData.ESP_Chams then
                                if espMPanel.Highlight.Parent then
                                    espMPanel.Highlight.Parent = nil 
                                end
                            end
                            
                            if isHasDrawingApiPanel then
                                local rootPosMPanel, onScreenMPanel = CameraCurrent:WorldToViewportPoint(rootMPanel.Position)
                                local headPosMPanel, zGarbage1Panel = CameraCurrent:WorldToViewportPoint(headMPanel.Position + Vector3.new(0, 0.5, 0))
                                local legPosMPanel, zGarbage2Panel = CameraCurrent:WorldToViewportPoint(rootMPanel.Position - Vector3.new(0, 3, 0))
                                
                                if onScreenMPanel then
                                    local boxHeightMPanel = math.abs(headPosMPanel.Y - legPosMPanel.Y)
                                    local boxWidthMPanel = boxHeightMPanel / 2
                                    
                                    espMPanel.Box.Size = Vector2.new(boxWidthMPanel, boxHeightMPanel)
                                    espMPanel.Box.Position = Vector2.new(rootPosMPanel.X - boxWidthMPanel / 2, headPosMPanel.Y)
                                    espMPanel.Box.Visible = StateData.ESP_Box
                                    
                                    espMPanel.Tracer.From = Vector2.new(cxCamPanel, CameraCurrent.ViewportSize.Y)
                                    espMPanel.Tracer.To = Vector2.new(rootPosMPanel.X, legPosMPanel.Y)
                                    espMPanel.Tracer.Visible = StateData.ESP_Tracer
                                    
                                    local hpMPanel = humMPanel.Health / humMPanel.MaxHealth
                                    local hhMPanel = boxHeightMPanel * hpMPanel
                                    
                                    espMPanel.HealthBg.From = Vector2.new(espMPanel.Box.Position.X - 5, legPosMPanel.Y)
                                    espMPanel.HealthBg.To = Vector2.new(espMPanel.Box.Position.X - 5, headPosMPanel.Y)
                                    espMPanel.HealthBg.Visible = StateData.ESP_Health
                                    
                                    espMPanel.HealthFill.From = Vector2.new(espMPanel.Box.Position.X - 5, legPosMPanel.Y)
                                    espMPanel.HealthFill.To = Vector2.new(espMPanel.Box.Position.X - 5, legPosMPanel.Y - hhMPanel)
                                    espMPanel.HealthFill.Color = Color3.fromRGB(255 - (hpMPanel * 255), hpMPanel * 255, 0)
                                    espMPanel.HealthFill.Visible = StateData.ESP_Health
                                    
                                    local distMathMPanel = math.floor((CameraCurrent.CFrame.Position - rootMPanel.Position).Magnitude)
                                    espMPanel.Text.Text = playerMPanel.DisplayName .. " [" .. distMathMPanel .. "m]"
                                    espMPanel.Text.Position = Vector2.new(rootPosMPanel.X, headPosMPanel.Y - 20)
                                    espMPanel.Text.Visible = StateData.ESP_Name
                                end
                                if not onScreenMPanel then
                                    espMPanel.Box.Visible = false
                                    espMPanel.Tracer.Visible = false
                                    espMPanel.HealthBg.Visible = false
                                    espMPanel.HealthFill.Visible = false
                                    espMPanel.Text.Visible = false
                                end
                            end
                        end
                        
                        if not isOkCMPanel then
                            local espPMFailPanel = EspDataStoragePanel[playerMPanel]
                            if espPMFailPanel then
                                if espPMFailPanel.Highlight then 
                                    espPMFailPanel.Highlight.Parent = nil 
                                end
                                if isHasDrawingApiPanel then 
                                    espPMFailPanel.Box.Visible = false
                                    espPMFailPanel.Tracer.Visible = false
                                    espPMFailPanel.HealthBg.Visible = false
                                    espPMFailPanel.HealthFill.Visible = false
                                    espPMFailPanel.Text.Visible = false 
                                end
                            end
                        end
                    end
                end
            end
            if not StateData.ESP then
                for playerRmPanel, _ in pairs(EspDataStoragePanel) do 
                    RemoveESPLogicPanel(playerRmPanel) 
                end
            end
        end)
    end)

    local flingBavInstPanel = nil
    local flingV3ConnInstPanel = nil

    ServiceRun.RenderStepped:Connect(function()
        pcall(function()
            local charFlgRsPanel = PlayerLocal.Character
            local hrpFlgRsPanel = nil
            if charFlgRsPanel then
                hrpFlgRsPanel = charFlgRsPanel:FindFirstChild("HumanoidRootPart")
            end
            
            local isFlingOnRsPanel = false
            if StateData.FlingV2 then
                isFlingOnRsPanel = true
            end
            if StateData.SuperFling then
                isFlingOnRsPanel = true
            end
            
            if isFlingOnRsPanel then
                if hrpFlgRsPanel then
                    if not flingBavInstPanel then
                        flingBavInstPanel = Instance.new("BodyAngularVelocity")
                        flingBavInstPanel.Name = "XayzFling"
                        flingBavInstPanel.MaxTorque = Vector3.new(0, math.huge, 0)
                        flingBavInstPanel.P = math.huge
                        flingBavInstPanel.Parent = hrpFlgRsPanel
                    end
                    
                    if StateData.SuperFling then
                        flingBavInstPanel.AngularVelocity = Vector3.new(0, 999999, 0)
                    end
                    if not StateData.SuperFling then
                        flingBavInstPanel.AngularVelocity = Vector3.new(0, StateData.FlingPower * 100, 0)
                    end
                end
            end
            if not isFlingOnRsPanel then
                if flingBavInstPanel then
                    flingBavInstPanel:Destroy()
                    flingBavInstPanel = nil
                end
                if hrpFlgRsPanel then
                    hrpFlgRsPanel.RotVelocity = Vector3.new(0, 0, 0)
                end
            end

            if StateData.FlingV3 then
                if hrpFlgRsPanel then
                    if not flingV3ConnInstPanel then
                        for _, vFlgV3Panel in pairs(charFlgRsPanel:GetDescendants()) do
                            if vFlgV3Panel:IsA("BasePart") then
                                vFlgV3Panel.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
                            end
                        end
                        flingV3ConnInstPanel = hrpFlgRsPanel.Touched:Connect(function(hitFlgV3Panel)
                            pcall(function()
                                if hitFlgV3Panel.Parent then
                                    if hitFlgV3Panel.Parent:FindFirstChild("Humanoid") then
                                        if hitFlgV3Panel.Parent.Name ~= PlayerLocal.Name then
                                            local vRootFlgV3Panel = hitFlgV3Panel.Parent:FindFirstChild("HumanoidRootPart")
                                            if vRootFlgV3Panel then
                                                vRootFlgV3Panel.Velocity = Vector3.new(999999999, 999999999, 999999999)
                                            end
                                        end
                                    end
                                end
                            end)
                        end)
                    end
                end
            end
            if not StateData.FlingV3 then
                if flingV3ConnInstPanel then
                    flingV3ConnInstPanel:Disconnect()
                    flingV3ConnInstPanel = nil
                end
            end
        end)
    end)

    ServiceRun.Heartbeat:Connect(function()
        pcall(function()
            local charMiscPanel = PlayerLocal.Character
            if charMiscPanel then
                local humMiscPanel = charMiscPanel:FindFirstChildOfClass("Humanoid")
                if humMiscPanel then
                    if StateData.HealLoop then
                        humMiscPanel.Health = humMiscPanel.MaxHealth
                    end
                    if StateData.GodModeV4 then
                        humMiscPanel.MaxHealth = math.huge
                        humMiscPanel.Health = math.huge
                    end
                    
                    local wScMPanel = humMiscPanel:FindFirstChild("BodyWidthScale")
                    local dScMPanel = humMiscPanel:FindFirstChild("BodyDepthScale")
                    local isScValidMPanel = false
                    if wScMPanel then
                        if dScMPanel then
                            isScValidMPanel = true
                        end
                    end
                    
                    if isScValidMPanel then
                        wScMPanel.Value = StateData.WideAvatar
                        dScMPanel.Value = StateData.WideAvatar
                    end
                end
            end
        end)
    end)

    local bhAngleLogicPanel = 1
    local AnchorPartLogicPanel = nil
    local AnchorAttLogicPanel = nil

    local function GetAnchorSetupLogicPanel()
        pcall(function()
            local isValAncPanel = false
            if AnchorPartLogicPanel then
                if AnchorPartLogicPanel.Parent then
                    isValAncPanel = true
                end
            end
            if not isValAncPanel then
                local fNewAncPanel = Instance.new("Folder")
                fNewAncPanel.Parent = ServiceWorkspace
                AnchorPartLogicPanel = Instance.new("Part")
                AnchorPartLogicPanel.Name = "XayzAnchor"
                AnchorPartLogicPanel.Anchored = true
                AnchorPartLogicPanel.CanCollide = false
                AnchorPartLogicPanel.Transparency = 1
                AnchorPartLogicPanel.Parent = fNewAncPanel
                
                AnchorAttLogicPanel = Instance.new("Attachment")
                AnchorAttLogicPanel.Parent = AnchorPartLogicPanel
            end
        end)
        return AnchorPartLogicPanel, AnchorAttLogicPanel
    end

    task.spawn(function()
        pcall(function()
            ServiceRun.Heartbeat:Connect(function()
                pcall(function()
                    if type(sethiddenproperty) == "function" then
                        sethiddenproperty(PlayerLocal, "SimulationRadius", math.huge)
                    end
                end)
            end)
        end)
    end)

    local dinoAnimR15InsPanel = Instance.new("Animation")
    dinoAnimR15InsPanel.AnimationId = "rbxassetid://204062532"

    local dinoAnimR6InsPanel = Instance.new("Animation")
    dinoAnimR6InsPanel.AnimationId = "rbxassetid://20432871"

    local punchAnimationInsPanel = Instance.new("Animation")
    punchAnimationInsPanel.AnimationId = "rbxassetid://84674780"

    local dTrackInsPanel = nil
    local pTrackInsPanel = nil

    local function ForcePartBHLogicPanel(vPartBHPanel, aAttBHPanel)
        pcall(function()
            if vPartBHPanel:IsA("Part") then
                if not vPartBHPanel.Anchored then
                    local pntBHPanel = vPartBHPanel.Parent
                    local fHumBHPanel = nil
                    local fHdBHPanel = nil
                    if pntBHPanel then
                        fHumBHPanel = pntBHPanel:FindFirstChild("Humanoid")
                        fHdBHPanel = pntBHPanel:FindFirstChild("Head")
                    end
                    if not fHumBHPanel then
                        if not fHdBHPanel then
                            if vPartBHPanel.Name ~= "Handle" then
                                for _, xBHPanel in pairs(vPartBHPanel:GetChildren()) do
                                    local delBHPanel = false
                                    if xBHPanel:IsA("BodyAngularVelocity") then delBHPanel = true end
                                    if xBHPanel:IsA("BodyForce") then delBHPanel = true end
                                    if xBHPanel:IsA("BodyGyro") then delBHPanel = true end
                                    if xBHPanel:IsA("BodyPosition") then delBHPanel = true end
                                    if xBHPanel:IsA("BodyThrust") then delBHPanel = true end
                                    if xBHPanel:IsA("BodyVelocity") then delBHPanel = true end
                                    if xBHPanel:IsA("RocketPropulsion") then delBHPanel = true end
                                    if delBHPanel then
                                        xBHPanel:Destroy()
                                    end
                                end
                                if vPartBHPanel:FindFirstChild("Attachment") then
                                    vPartBHPanel:FindFirstChild("Attachment"):Destroy()
                                end
                                if vPartBHPanel:FindFirstChild("AlignPosition") then
                                    vPartBHPanel:FindFirstChild("AlignPosition"):Destroy()
                                end
                                if vPartBHPanel:FindFirstChild("Torque") then
                                    vPartBHPanel:FindFirstChild("Torque"):Destroy()
                                end
                                
                                vPartBHPanel.CanCollide = false
                                
                                local tqBHPanel = Instance.new("Torque")
                                tqBHPanel.Parent = vPartBHPanel
                                tqBHPanel.Torque = Vector3.new(1000000, 1000000, 1000000)
                                
                                local alBHPanel = Instance.new("AlignPosition")
                                alBHPanel.Parent = vPartBHPanel
                                local a2BHPanel = Instance.new("Attachment")
                                a2BHPanel.Parent = vPartBHPanel
                                tqBHPanel.Attachment0 = a2BHPanel
                                
                                alBHPanel.MaxForce = math.huge
                                alBHPanel.MaxVelocity = math.huge
                                alBHPanel.Responsiveness = 500
                                alBHPanel.Attachment0 = a2BHPanel
                                alBHPanel.Attachment1 = aAttBHPanel
                            end
                        end
                    end
                end
            end
        end)
    end

    ServiceRun.Heartbeat:Connect(function()
        pcall(function()
            local charHbPanel = PlayerLocal.Character
            if not charHbPanel then 
                return 
            end
            
            local armJointHbPanel = nil
            local isR15HbPanel = false
            if charHbPanel:FindFirstChild("UpperTorso") then
                isR15HbPanel = true
            end
            
            if isR15HbPanel then
                local rArmHbPanel = charHbPanel:FindFirstChild("RightUpperArm")
                if rArmHbPanel then 
                    armJointHbPanel = rArmHbPanel:FindFirstChild("RightShoulder")
                end
            end
            if not isR15HbPanel then
                local torsoHbPanel = charHbPanel:FindFirstChild("Torso")
                if torsoHbPanel then 
                    armJointHbPanel = torsoHbPanel:FindFirstChild("Right Shoulder")
                end
            end

            if armJointHbPanel then
                local attC0HbPanel = armJointHbPanel:GetAttribute("OriginalC0")
                if not attC0HbPanel then
                    attC0HbPanel = armJointHbPanel.C0
                    armJointHbPanel:SetAttribute("OriginalC0", attC0HbPanel)
                end

                if StateData.ArmAnim then
                    local moveHbPanel = math.sin(tick() * StateData.ArmSpeed) * StateData.ArmIntensity
                    if isR15HbPanel then
                        local cfCHb1Panel = attC0HbPanel * CFrame.new(0, moveHbPanel, -0.5)
                        armJointHbPanel.C0 = cfCHb1Panel * CFrame.Angles(math.rad(-90), 0, 0)
                    end
                    if not isR15HbPanel then
                        local cfCHb2Panel = attC0HbPanel * CFrame.new(-0.2, moveHbPanel, -0.5)
                        armJointHbPanel.C0 = cfCHb2Panel * CFrame.Angles(math.rad(-90), math.rad(20), 0)
                    end
                end
                if not StateData.ArmAnim then
                    armJointHbPanel.C0 = attC0HbPanel
                end
            end
            
            local humHbPanel = charHbPanel:FindFirstChild("Humanoid")
            if humHbPanel then
                local isDPlyHbPanel = false
                if dTrackInsPanel then
                    if dTrackInsPanel.IsPlaying then
                        isDPlyHbPanel = true
                    end
                end
                
                if StateData.DinoAnim then
                    if not isDPlyHbPanel then
                        if humHbPanel.RigType == Enum.HumanoidRigType.R15 then
                            dTrackInsPanel = humHbPanel:LoadAnimation(dinoAnimR15InsPanel)
                        end
                        if humHbPanel.RigType ~= Enum.HumanoidRigType.R15 then
                            dTrackInsPanel = humHbPanel:LoadAnimation(dinoAnimR6InsPanel)
                        end
                        dTrackInsPanel:Play()
                    end
                end
                if not StateData.DinoAnim then
                    if isDPlyHbPanel then
                        dTrackInsPanel:Stop()
                    end
                end

                local isPPlyHbPanel = false
                if pTrackInsPanel then
                    if pTrackInsPanel.IsPlaying then
                        isPPlyHbPanel = true
                    end
                end
                
                if StateData.PunchAnim then
                    if not isPPlyHbPanel then
                        pTrackInsPanel = humHbPanel:LoadAnimation(punchAnimationInsPanel)
                        pTrackInsPanel:Play()
                    end
                end
                if not StateData.PunchAnim then
                    if isPPlyHbPanel then
                        pTrackInsPanel:Stop()
                    end
                end
            end

            local hrpHbPanel = charHbPanel:FindFirstChild("HumanoidRootPart")
            if not hrpHbPanel then 
                return 
            end

            if StateData.ForceField then
                if not charHbPanel:FindFirstChild("XayzFF") then
                    local ffNHbPanel = Instance.new("ForceField")
                    ffNHbPanel.Name = "XayzFF"
                    ffNHbPanel.Visible = true
                    ffNHbPanel.Parent = charHbPanel
                end
            end
            if not StateData.ForceField then
                if charHbPanel:FindFirstChild("XayzFF") then 
                    charHbPanel:FindFirstChild("XayzFF"):Destroy() 
                end
            end

            local ancPtHbPanel, ancAttHbPanel = GetAnchorSetupLogicPanel()

            if StateData.Blackhole then
                for _, vHbPanel in pairs(ServiceWorkspace:GetDescendants()) do
                    ForcePartBHLogicPanel(vHbPanel, ancAttHbPanel)
                end
                
                bhAngleLogicPanel = bhAngleLogicPanel + math.rad(2)
                
                local offXHbPanel = math.cos(bhAngleLogicPanel) * StateData.BlackholeDistance
                local offZHbPanel = math.sin(bhAngleLogicPanel) * StateData.BlackholeDistance
                
                ancAttHbPanel.WorldCFrame = hrpHbPanel.CFrame * CFrame.new(offXHbPanel, 0, offZHbPanel)
            end
            
            if StateData.SuperRing then
                local tCenterHbPanel = hrpHbPanel.Position
                local unPartsHbPanel = {}
                for _, vHb2Panel in pairs(ServiceWorkspace:GetDescendants()) do
                    if vHb2Panel:IsA("BasePart") then
                        if not vHb2Panel.Anchored then
                            local pntHb2Panel = vHb2Panel.Parent
                            local fHumHb2Panel = nil
                            if pntHb2Panel then
                                fHumHb2Panel = pntHb2Panel:FindFirstChild("Humanoid")
                            end
                            if not fHumHb2Panel then
                                local fHdHb2Panel = nil
                                if pntHb2Panel then
                                    fHdHb2Panel = pntHb2Panel:FindFirstChild("Head")
                                end
                                if not fHdHb2Panel then
                                    if vHb2Panel.Name ~= "Handle" then
                                        local isLpHb2Panel = false
                                        if pntHb2Panel == PlayerLocal.Character then
                                            isLpHb2Panel = true
                                        end
                                        if PlayerLocal.Character then
                                            if vHb2Panel:IsDescendantOf(PlayerLocal.Character) then
                                                isLpHb2Panel = true
                                            end
                                        end
                                        if not isLpHb2Panel then
                                            table.insert(unPartsHbPanel, vHb2Panel)
                                            
                                            if vHb2Panel:FindFirstChild("AlignPosition") then
                                                vHb2Panel:FindFirstChild("AlignPosition"):Destroy()
                                            end
                                            if vHb2Panel:FindFirstChild("Torque") then
                                                vHb2Panel:FindFirstChild("Torque"):Destroy()
                                            end
                                            local atCHb2Panel = vHb2Panel:FindFirstChildOfClass("Attachment")
                                            if atCHb2Panel then
                                                if not atCHb2Panel:FindFirstChildOfClass("AlignPosition") then
                                                    atCHb2Panel:Destroy()
                                                end
                                            end
                                            
                                            vHb2Panel.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
                                            vHb2Panel.CanCollide = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                for _, ptHbPanel in pairs(unPartsHbPanel) do
                    local ptPosHbPanel = ptHbPanel.Position
                    local vXZHbPanel = Vector3.new(ptPosHbPanel.X, tCenterHbPanel.Y, ptPosHbPanel.Z)
                    local distHbPanel = (vXZHbPanel - tCenterHbPanel).Magnitude
                    
                    local atanHbPanel = math.atan2(ptPosHbPanel.Z - tCenterHbPanel.Z, ptPosHbPanel.X - tCenterHbPanel.X)
                    local newAngHbPanel = atanHbPanel + math.rad(StateData.RingSpeed)
                    
                    local minDHbPanel = math.min(StateData.RingDistance, distHbPanel)
                    local tXHbPanel = tCenterHbPanel.X + (math.cos(newAngHbPanel) * minDHbPanel)
                    
                    local hDivHbPanel = (ptPosHbPanel.Y - tCenterHbPanel.Y) / StateData.RingHeight
                    local hMultHbPanel = StateData.RingHeight * math.abs(math.sin(hDivHbPanel))
                    local tYHbPanel = tCenterHbPanel.Y + hMultHbPanel
                    
                    local tZHbPanel = tCenterHbPanel.Z + (math.sin(newAngHbPanel) * minDHbPanel)
                    
                    local tarPosHbPanel = Vector3.new(tXHbPanel, tYHbPanel, tZHbPanel)
                    ptHbPanel.Velocity = (tarPosHbPanel - ptPosHbPanel).Unit * StateData.RingAttraction
                end
            end
            
            local offAllHbPanel = false
            if not StateData.Blackhole then
                if not StateData.SuperRing then
                    offAllHbPanel = true
                end
            end
            
            if offAllHbPanel then
                for _, vHb3Panel in pairs(ServiceWorkspace:GetDescendants()) do
                    if vHb3Panel:IsA("Part") then
                        if vHb3Panel:FindFirstChild("AlignPosition") then
                            vHb3Panel:FindFirstChild("AlignPosition"):Destroy()
                            if vHb3Panel:FindFirstChild("Torque") then 
                                vHb3Panel:FindFirstChild("Torque"):Destroy() 
                            end
                        end
                    end
                end
                local fAncHbPanel = ServiceWorkspace:FindFirstChild("XayzAnchor")
                if fAncHbPanel then
                    fAncHbPanel.CFrame = CFrame.new(0, -1000, 0)
                end
            end
        end)
    end)
end)

local function InitializeProtected()
    pcall(function()
        SafeExecuteScript()
    end)
end

InitializeProtected()