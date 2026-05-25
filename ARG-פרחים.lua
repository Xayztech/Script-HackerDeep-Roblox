local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local TweenService    = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui      = game:GetService("StarterGui")
local Lighting        = game:GetService("Lighting")
local SoundService    = game:GetService("SoundService")

local lp             = Players.LocalPlayer
local playerGui      = lp:WaitForChild("PlayerGui")
local camera         = workspace.CurrentCamera
local char           = lp.Character or lp.CharacterAdded:Wait()

local WIN11_BG        = Color3.fromRGB(32, 32, 32)
local WIN11_TITLEBAR  = Color3.fromRGB(43, 43, 43)
local WIN11_ACCENT    = Color3.fromRGB(0, 120, 212)
local WIN11_TEXT      = Color3.fromRGB(255, 255, 255)
local WIN11_BTN_HOVER = Color3.fromRGB(60, 60, 60)
local WIN11_CLOSE     = Color3.fromRGB(196, 43, 28)
local WIN11_MIN       = Color3.fromRGB(60, 60, 60)
local WIN11_MAX       = Color3.fromRGB(60, 60, 60)

local function makeFrame(parent, props)
    local f = Instance.new("Frame")
    for k,v in pairs(props) do f[k] = v end
    f.Parent = parent
    return f
end

local function makeLabel(parent, props)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    for k,v in pairs(props) do l[k] = v end
    l.Parent = parent
    return l
end

local function makeButton(parent, props)
    local b = Instance.new("TextButton")
    b.BackgroundColor3 = WIN11_BTN_HOVER
    b.BorderSizePixel  = 0
    b.Font             = Enum.Font.GothamBold
    b.TextColor3       = WIN11_TEXT
    for k,v in pairs(props) do b[k] = v end
    b.Parent = parent
    return b
end

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
end

local function makeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color     = color or Color3.fromRGB(80,80,80)
    s.Thickness = thickness or 1
    s.Parent    = parent
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name            = "ARGRoblox"
screenGui.ResetOnSpawn    = false
screenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset  = true
screenGui.Parent          = playerGui

local panel = makeFrame(screenGui, {
    Size              = UDim2.new(0, 420, 0, 260),
    Position          = UDim2.new(0.5, -210, 0.5, -130),
    BackgroundColor3  = WIN11_BG,
    BorderSizePixel   = 0,
    ClipsDescendants  = true,
    ZIndex            = 10,
})
makeCorner(panel, 10)
makeStroke(panel, Color3.fromRGB(70,70,70), 1)

local shadow = makeFrame(screenGui, {
    Size             = UDim2.new(0, 430, 0, 270),
    Position         = UDim2.new(0, panel.AbsolutePosition.X - 5, 0, panel.AbsolutePosition.Y + 5),
    BackgroundColor3 = Color3.fromRGB(0,0,0),
    BackgroundTransparency = 0.6,
    BorderSizePixel  = 0,
    ZIndex           = 9,
})
makeCorner(shadow, 12)

local titleBar = makeFrame(panel, {
    Size             = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = WIN11_TITLEBAR,
    BorderSizePixel  = 0,
    ZIndex           = 11,
})

local winIcon = makeLabel(titleBar, {
    Size      = UDim2.new(0, 30, 1, 0),
    Position  = UDim2.new(0, 8, 0, 0),
    Text      = "⊞",
    TextSize  = 18,
    TextColor3 = WIN11_ACCENT,
    ZIndex    = 12,
})

local titleLabel = makeLabel(titleBar, {
    Size      = UDim2.new(1, -120, 1, 0),
    Position  = UDim2.new(0, 40, 0, 0),
    Text      = "ARG פרחים — Whistler Occurrence",
    TextSize  = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = WIN11_TEXT,
    ZIndex    = 12,
})

local btnMin = makeButton(titleBar, {
    Size             = UDim2.new(0, 36, 1, 0),
    Position         = UDim2.new(1, -108, 0, 0),
    Text             = "─",
    TextSize         = 14,
    BackgroundColor3 = WIN11_MIN,
    ZIndex           = 12,
})
local btnMax = makeButton(titleBar, {
    Size             = UDim2.new(0, 36, 1, 0),
    Position         = UDim2.new(1, -72, 0, 0),
    Text             = "□",
    TextSize         = 14,
    BackgroundColor3 = WIN11_MAX,
    ZIndex           = 12,
})
local btnClose = makeButton(titleBar, {
    Size             = UDim2.new(0, 36, 1, 0),
    Position         = UDim2.new(1, -36, 0, 0),
    Text             = "✕",
    TextSize         = 14,
    BackgroundColor3 = WIN11_CLOSE,
    ZIndex           = 12,
})
makeCorner(btnClose, 0)

for _, btn in ipairs({btnMin, btnMax}) do
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(80,80,80) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = WIN11_BTN_HOVER end)
end
btnClose.MouseEnter:Connect(function() btnClose.BackgroundColor3 = Color3.fromRGB(220,50,35) end)
btnClose.MouseLeave:Connect(function() btnClose.BackgroundColor3 = WIN11_CLOSE end)

local contentFrame = makeFrame(panel, {
    Size             = UDim2.new(1, 0, 1, -36),
    Position         = UDim2.new(0, 0, 0, 36),
    BackgroundTransparency = 1,
    ZIndex           = 11,
})

local argTitle = makeLabel(contentFrame, {
    Size      = UDim2.new(1, 0, 0, 50),
    Position  = UDim2.new(0, 0, 0, 10),
    Text      = "פרחים",
    TextSize  = 36,
    TextColor3 = Color3.fromRGB(180, 0, 0),
    Font      = Enum.Font.GothamBold,
    ZIndex    = 12,
})

local subTitle = makeLabel(contentFrame, {
    Size      = UDim2.new(1, 0, 0, 20),
    Position  = UDim2.new(0, 0, 0, 58),
    Text      = "WHISTLER OCCURRENCE — CURSED EDITION",
    TextSize  = 11,
    TextColor3 = Color3.fromRGB(160, 160, 160),
    ZIndex    = 12,
})

local divider = makeFrame(contentFrame, {
    Size             = UDim2.new(0.85, 0, 0, 1),
    Position         = UDim2.new(0.075, 0, 0, 84),
    BackgroundColor3 = Color3.fromRGB(70,70,70),
    ZIndex           = 12,
})

local btnStart = makeButton(contentFrame, {
    Size             = UDim2.new(0, 170, 0, 44),
    Position         = UDim2.new(0.5, -180, 0, 100),
    Text             = "▶  Start ARG",
    TextSize         = 15,
    BackgroundColor3 = Color3.fromRGB(180, 0, 0),
    TextColor3       = WIN11_TEXT,
    ZIndex           = 12,
})
makeCorner(btnStart, 8)
makeStroke(btnStart, Color3.fromRGB(220,50,50), 1)

local btnBecome = makeButton(contentFrame, {
    Size             = UDim2.new(0, 170, 0, 44),
    Position         = UDim2.new(0.5, 10, 0, 100),
    Text             = "☠  Become פרחים",
    TextSize         = 13,
    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
    TextColor3       = Color3.fromRGB(200, 0, 0),
    ZIndex           = 12,
})
makeCorner(btnBecome, 8)
makeStroke(btnBecome, Color3.fromRGB(150, 0, 0), 1)

local infoLabel = makeLabel(contentFrame, {
    Size      = UDim2.new(1, -20, 0, 30),
    Position  = UDim2.new(0, 10, 0, 155),
    Text      = "⚠ Prepare Screen Recorder before starting.",
    TextSize  = 10,
    TextColor3 = Color3.fromRGB(180, 130, 0),
    ZIndex    = 12,
})

local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging  = true
        dragStart = input.Position
        startPos  = panel.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        shadow.Position = UDim2.new(
            0, panel.AbsolutePosition.X - 5,
            0, panel.AbsolutePosition.Y + 5
        )
    end
end)

local isMinimized  = false
local isMaximized  = false
local normalSize   = panel.Size
local normalPos    = panel.Position

btnMin.MouseButton1Click:Connect(function()
    if not isMinimized then
        isMinimized = true
        TweenService:Create(panel, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 420, 0, 36)
        }):Play()
        contentFrame.Visible = false
    else
        isMinimized = false
        contentFrame.Visible = true
        TweenService:Create(panel, TweenInfo.new(0.2), {
            Size = normalSize
        }):Play()
    end
end)

btnMax.MouseButton1Click:Connect(function()
    if not isMaximized then
        isMaximized = true
        normalSize = panel.Size
        normalPos  = panel.Position
        TweenService:Create(panel, TweenInfo.new(0.2), {
            Size     = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
        }):Play()
    else
        isMaximized = false
        TweenService:Create(panel, TweenInfo.new(0.2), {
            Size     = normalSize,
            Position = normalPos,
        }):Play()
    end
end)

btnClose.MouseButton1Click:Connect(function()
    TweenService:Create(panel, TweenInfo.new(0.15), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 420, 0, 0),
    }):Play()
    task.wait(0.2)
    screenGui:Destroy()
end)

local function sysNotif(title, text, dur)
    StarterGui:SetCore("SendNotification", {
        Title    = title,
        Text     = text,
        Duration = dur or 5,
    })
end

local function showPopup(msg, duration, textSize)
    local popup = Instance.new("ScreenGui")
    popup.Name           = "ARG_Popup"
    popup.ResetOnSpawn   = false
    popup.IgnoreGuiInset = true
    popup.ZIndex         = 100
    popup.Parent         = playerGui

    local bg = makeFrame(popup, {
        Size             = UDim2.new(0, 500, 0, 80),
        Position         = UDim2.new(0.5, -250, 0.1, 0),
        BackgroundColor3 = Color3.fromRGB(10,0,0),
        BackgroundTransparency = 0.1,
        ZIndex           = 100,
    })
    makeCorner(bg, 6)
    makeStroke(bg, Color3.fromRGB(180,0,0), 2)

    makeLabel(bg, {
        Size      = UDim2.new(1, -20, 1, 0),
        Position  = UDim2.new(0, 10, 0, 0),
        Text      = msg,
        TextSize  = textSize or 16,
        TextColor3 = Color3.fromRGB(255, 50, 50),
        TextWrapped = true,
        ZIndex    = 101,
    })

    if duration then
        task.delay(duration, function()
            if popup and popup.Parent then popup:Destroy() end
        end)
    end
    return popup
end

local function addVignette()
    local v = Instance.new("ScreenGui")
    v.Name           = "ARG_Vignette"
    v.ResetOnSpawn   = false
    v.IgnoreGuiInset = true
    v.ZIndex         = 50
    v.Parent         = playerGui

    local f = makeFrame(v, {
        Size             = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        ZIndex           = 51,
    })
    local vColors = {
        {UDim2.new(0,0,0,0),    UDim2.new(0.3,0,1,0)},
        {UDim2.new(0.7,0,0,0),  UDim2.new(0.3,0,1,0)},
        {UDim2.new(0,0,0,0),    UDim2.new(1,0,0.25,0)},
        {UDim2.new(0,0,0.75,0), UDim2.new(1,0,0.25,0)},
    }
    for _, d in ipairs(vColors) do
        local bar = makeFrame(f, {
            Position         = d[1],
            Size             = d[2],
            BackgroundColor3 = Color3.fromRGB(80,0,0),
            BackgroundTransparency = 0.5,
            ZIndex           = 52,
        })
    end
    return v
end

local function removeVignette()
    local v = playerGui:FindFirstChild("ARG_Vignette")
    if v then v:Destroy() end
end

local function fakeLag(duration)
    local start = tick()
    local lagGui = Instance.new("ScreenGui")
    lagGui.Name           = "ARG_FakeLag"
    lagGui.ResetOnSpawn   = false
    lagGui.IgnoreGuiInset = true
    lagGui.ZIndex         = 200
    lagGui.Parent         = playerGui

    local overlay = makeFrame(lagGui, {
        Size             = UDim2.new(1,0,1,0),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.85,
        ZIndex           = 201,
    })

    local lagLabel = makeLabel(overlay, {
        Size      = UDim2.new(1,0,0,40),
        Position  = UDim2.new(0,0,0.5,-20),
        Text      = "...",
        TextSize  = 14,
        TextColor3 = Color3.fromRGB(200,0,0),
        ZIndex    = 202,
    })

    task.spawn(function()
        local msgs = {"...", "█▓▒░", "NOT FOUND", "ERROR", "פרחים", "DO YOU HEAR IT?"}
        while lagGui.Parent do
            lagLabel.Text = msgs[math.random(1,#msgs)]
            task.wait(0.08)
        end
    end)

    task.delay(duration, function()
        if lagGui and lagGui.Parent then lagGui:Destroy() end
    end)
end

local originalLighting = {
    Ambient         = Lighting.Ambient,
    OutdoorAmbient  = Lighting.OutdoorAmbient,
    Brightness      = Lighting.Brightness,
    FogEnd          = Lighting.FogEnd,
    FogStart        = Lighting.FogStart,
    FogColor        = Lighting.FogColor,
    TimeOfDay       = Lighting.TimeOfDay,
}

local function applyHorrorLighting()
    TweenService:Create(Lighting, TweenInfo.new(2), {
        Ambient        = Color3.fromRGB(80, 0, 0),
        OutdoorAmbient = Color3.fromRGB(40, 0, 0),
        Brightness     = 0.3,
        FogEnd         = 100,
        FogStart       = 10,
        FogColor       = Color3.fromRGB(60, 0, 0),
    }):Play()
    Lighting.TimeOfDay = "00:00:00"

    for _, c in ipairs(Lighting:GetChildren()) do
        if c:IsA("ColorCorrectionEffect") or c:IsA("BlurEffect") then c:Destroy() end
    end

    local cc = Instance.new("ColorCorrectionEffect")
    cc.Brightness = -0.15
    cc.Contrast   = 0.4
    cc.Saturation = -0.5
    cc.TintColor  = Color3.fromRGB(200, 80, 80)
    cc.Parent     = Lighting

    local blur = Instance.new("BlurEffect")
    blur.Size   = 3
    blur.Parent = Lighting
end

local function restoreLighting()
    for k,v in pairs(originalLighting) do
        Lighting[k] = v
    end
    for _, c in ipairs(Lighting:GetChildren()) do
        if c:IsA("ColorCorrectionEffect") or c:IsA("BlurEffect") then c:Destroy() end
    end
end

local function applyHorrorSkybox()
    for _, sky in ipairs(Lighting:GetChildren()) do
        if sky:IsA("Sky") then sky:Destroy() end
    end
    local sky = Instance.new("Sky")
    sky.SkyboxBk = "rbxassetid://6523286724"
    sky.SkyboxDn = "rbxassetid://6523286724"
    sky.SkyboxFt = "rbxassetid://6523286724"
    sky.SkyboxLf = "rbxassetid://6523286724"
    sky.SkyboxRt = "rbxassetid://6523286724"
    sky.SkyboxUp = "rbxassetid://6523286724"
    sky.Parent   = Lighting
end

local hiddenChars = {}

local function hideAllPlayers()
    hiddenChars = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    hiddenChars[part] = part.Transparency
                    part.Transparency = 1
                end
            end
        end
    end
end

local function showAllPlayers()
    for part, trans in pairs(hiddenChars) do
        if part and part.Parent then
            part.Transparency = trans
        end
    end
    hiddenChars = {}
end

local shaking = false

local function shakeCamera(duration, intensity)
    shaking = true
    local camConn
    local startTime = tick()
    camConn = RunService.RenderStepped:Connect(function()
        if not shaking or tick() - startTime >= duration then
            shaking = false
            camConn:Disconnect()
            return
        end
        local i = intensity or 0.5
        camera.CFrame = camera.CFrame
            * CFrame.new(
                math.random(-100,100)/100 * i,
                math.random(-100,100)/100 * i,
                0
            )
    end)
end

local praximNPCs = {}

local function spawnPrakimNPC()
    local camCF     = camera.CFrame
    local offsets   = {
        camCF * CFrame.new(-15, 0, -20),
        camCF * CFrame.new(15,  0, -20),
        camCF * CFrame.new(-20, 0,  10),
        camCF * CFrame.new(20,  0,  10),
    }
    local targetCF  = offsets[math.random(1, #offsets)]
    local npcPos    = targetCF.Position + Vector3.new(
        math.random(-5,5), 0, math.random(-5,5)
    )

    local model    = Instance.new("Model")
    model.Name     = "פרחים"

    local root     = Instance.new("Part")
    root.Name      = "HumanoidRootPart"
    root.Size      = Vector3.new(2,2,1)
    root.Anchored  = true
    root.CanCollide = false
    root.BrickColor = BrickColor.new("Really black")
    root.Position  = npcPos
    root.Parent    = model

    local head     = Instance.new("Part")
    head.Name      = "Head"
    head.Size      = Vector3.new(2,1,1)
    head.Anchored  = true
    head.CanCollide = false
    head.BrickColor = BrickColor.new("Bright red")
    head.Position  = npcPos + Vector3.new(0,1.5,0)
    head.Parent    = model

    local bb       = Instance.new("BillboardGui")
    bb.Size        = UDim2.new(0,100,0,30)
    bb.StudsOffset = Vector3.new(0,3,0)
    bb.Parent      = head

    local nameTag  = Instance.new("TextLabel")
    nameTag.Size   = UDim2.new(1,0,1,0)
    nameTag.BackgroundTransparency = 1
    nameTag.Text   = "פרחים"
    nameTag.TextColor3 = Color3.fromRGB(200,0,0)
    nameTag.Font   = Enum.Font.GothamBold
    nameTag.TextSize = 16
    nameTag.Parent = bb

    local hum      = Instance.new("Humanoid")
    hum.Parent     = model

    model.Parent   = workspace
    table.insert(praximNPCs, model)

    task.spawn(function()
        local duration = 3
        local startT   = tick()
        while model.Parent and tick()-startT < duration do
            local jitter = Vector3.new(
                math.random(-3,3)*0.5,
                math.random(-1,1)*0.3,
                math.random(-3,3)*0.5
            )
            root.Position  = npcPos + jitter
            head.Position  = npcPos + jitter + Vector3.new(0,1.5,0)
            task.wait(math.random(30,70)/100)
        end
        if model and model.Parent then model:Destroy() end
    end)
end

local function clearPrakimNPCs()
    for _, m in ipairs(praximNPCs) do
        if m and m.Parent then m:Destroy() end
    end
    praximNPCs = {}
end

local function sendChat(msg)
    local chatGui = playerGui:FindFirstChild("Chat")
    if chatGui then
        local frame = chatGui:FindFirstChild("Frame")
    end
    if char and char:FindFirstChild("Head") then
        local cb = Instance.new("BillboardGui")
        cb.Size        = UDim2.new(0,200,0,50)
        cb.StudsOffset = Vector3.new(0,3,0)
        cb.Parent      = char.Head

        local cl = Instance.new("TextLabel")
        cl.Size   = UDim2.new(1,0,1,0)
        cl.BackgroundColor3 = Color3.fromRGB(10,0,0)
        cl.BackgroundTransparency = 0.2
        cl.Text   = msg
        cl.TextColor3 = Color3.fromRGB(255,50,50)
        cl.Font   = Enum.Font.GothamBold
        cl.TextSize = 13
        cl.TextWrapped = true
        cl.Parent = cb

        game:GetService("Debris"):AddItem(cb, 5)
    end
end

local function selfKick()
    local kickGui = Instance.new("ScreenGui")
    kickGui.Name           = "ARG_Kick"
    kickGui.ResetOnSpawn   = false
    kickGui.IgnoreGuiInset = true
    kickGui.ZIndex         = 999
    kickGui.Parent         = playerGui

    local bg = makeFrame(kickGui, {
        Size             = UDim2.new(1,0,1,0),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        ZIndex           = 1000,
    })

    local errMsg = makeLabel(bg, {
        Size      = UDim2.new(0.8,0,0.4,0),
        Position  = UDim2.new(0.1,0,0.3,0),
        Text      = [[
⚠ CONNECTION TERMINATED ⚠

פרחים FOUND YOU.

"You should not have listened."
"The Whistler knows your real name."

Error Code: 666
        ]],
        TextSize  = 18,
        TextColor3 = Color3.fromRGB(200,0,0),
        TextWrapped = true,
        ZIndex    = 1001,
    })

    task.wait(4)

    Players.LocalPlayer:Kick([[
⚠ פרחים ⚠

"Do you hear the Whistler?"

ERROR CODE: 666
The flowers are watching.
You cannot escape.

— פרחים
    ]])
end

local function becomePrakim()
    panel.Visible = false

    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.BrickColor = BrickColor.new("Really black")
            end
            if part:IsA("SpecialMesh") then
                part.TextureId = ""
            end
        end
        if char:FindFirstChild("Head") then
            local bb = Instance.new("BillboardGui")
            bb.Size        = UDim2.new(0,120,0,35)
            bb.StudsOffset = Vector3.new(0,3,0)
            bb.Parent      = char.Head

            local nt = Instance.new("TextLabel")
            nt.Size   = UDim2.new(1,0,1,0)
            nt.BackgroundTransparency = 1
            nt.Text   = "פרחים"
            nt.TextColor3 = Color3.fromRGB(200,0,0)
            nt.Font   = Enum.Font.GothamBold
            nt.TextSize = 18
            nt.Parent = bb
        end
    end

    applyHorrorLighting()
    addVignette()

    local anomalyConn
    local anomalyStart = tick()
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        anomalyConn = RunService.Heartbeat:Connect(function()
            if tick() - anomalyStart > 30 then
                anomalyConn:Disconnect()
                return
            end
            if math.random(1,10) <= 3 then
                hrp.CFrame = hrp.CFrame * CFrame.new(
                    math.random(-5,5),
                    math.random(0,2),
                    math.random(-5,5)
                )
            end
        end)
    end

    showPopup("פרחים", 5, 20)
    task.wait(5)
    showPopup("Do you hear the Whistler?", 5, 18)
end

local function startARG()
    panel.Visible = false

    showPopup("⚠ Set up your Screen Recorder in 10 seconds...", 10, 16)
    task.wait(10)

    showPopup("Enjoy the game...", 3, 14)
    task.wait(60)

    showPopup("...", 2, 20)
    task.wait(2)
    hideAllPlayers()
    shakeCamera(10, 0.6)
    task.wait(10)
    showAllPlayers()

    task.wait(120)

    local fase4Start = tick()
    while tick() - fase4Start < 180 do
        spawnPrakimNPC()
        task.wait(math.random(15, 35))
    end
    clearPrakimNPCs()

    task.wait(35)

    applyHorrorLighting()
    applyHorrorSkybox()
    addVignette()

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj ~= char:FindFirstChild("HumanoidRootPart") then
            TweenService:Create(obj, TweenInfo.new(1.5), {
                Color = Color3.fromRGB(
                    math.random(80,150),
                    math.random(0,20),
                    math.random(0,20)
                )
            }):Play()
        end
    end

    local otherPlayers = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp then table.insert(otherPlayers, plr) end
    end

    for _, plr in ipairs(otherPlayers) do
        task.wait(math.random(3,7))
        if plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = 1 end
            end
        end
    end

    if #otherPlayers > 0 then
        local lastPlr = otherPlayers[#otherPlayers]
        if lastPlr and lastPlr.Character then
            for _, part in ipairs(lastPlr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                    part.BrickColor   = BrickColor.new("Really black")
                end
            end
            local head2 = lastPlr.Character:FindFirstChild("Head")
            if head2 then
                local bb2 = Instance.new("BillboardGui")
                bb2.Size        = UDim2.new(0,120,0,35)
                bb2.StudsOffset = Vector3.new(0,3,0)
                bb2.Parent      = head2

                local nt2 = Instance.new("TextLabel")
                nt2.Size   = UDim2.new(1,0,1,0)
                nt2.BackgroundTransparency = 1
                nt2.Text   = "פרחים"
                nt2.TextColor3 = Color3.fromRGB(200,0,0)
                nt2.Font   = Enum.Font.GothamBold
                nt2.TextSize = 18
                nt2.Parent = bb2

                task.spawn(function()
                    local hrp2 = lastPlr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp2 then
                        for i = 1, 30 do
                            hrp2.CFrame = hrp2.CFrame * CFrame.new(
                                math.random(-6,6),
                                math.random(0,3),
                                math.random(-6,6)
                            )
                            task.wait(0.5)
                        end
                    end
                end)
            end
        end
        task.wait(15)
    end

    restoreLighting()
    removeVignette()
    showAllPlayers()

    task.wait(3)

    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp    = char.HumanoidRootPart
        local behind = hrp.CFrame * CFrame.new(0, 0, 3)

        local ghostModel = Instance.new("Model")
        ghostModel.Name  = "פרחים_Shadow"

        local gPart      = Instance.new("Part")
        gPart.Size       = Vector3.new(2, 4, 1)
        gPart.BrickColor = BrickColor.new("Really black")
        gPart.Anchored   = true
        gPart.CanCollide = false
        gPart.CFrame     = behind
        gPart.Parent     = ghostModel

        local gBB = Instance.new("BillboardGui")
        gBB.Size        = UDim2.new(0,150,0,40)
        gBB.StudsOffset = Vector3.new(0,3,0)
        gBB.Parent      = gPart

        local gLabel = Instance.new("TextLabel")
        gLabel.Size   = UDim2.new(1,0,1,0)
        gLabel.BackgroundTransparency = 1
        gLabel.Text   = "פרחים"
        gLabel.TextColor3 = Color3.fromRGB(200,0,0)
        gLabel.Font   = Enum.Font.GothamBold
        gLabel.TextSize = 18
        gLabel.Parent = gBB

        ghostModel.Parent = workspace

        task.wait(1)
        sendChat("Do you hear the whistler?")
        task.wait(3)
        sendChat("Cover The Ears!")
        task.wait(3)

        game:GetService("Debris"):AddItem(ghostModel, 5)
    end

    task.wait(2)
    applyHorrorLighting()
    applyHorrorSkybox()
    addVignette()
    shakeCamera(5, 1.0)
    task.wait(2)
    fakeLag(3)

    local redGui = Instance.new("ScreenGui")
    redGui.Name           = "ARG_RedFlash"
    redGui.IgnoreGuiInset = true
    redGui.ZIndex         = 500
    redGui.Parent         = playerGui

    local redFrame = makeFrame(redGui, {
        Size             = UDim2.new(1,0,1,0),
        BackgroundColor3 = Color3.fromRGB(120,0,0),
        BackgroundTransparency = 0,
        ZIndex           = 501,
    })

    makeLabel(redFrame, {
        Size      = UDim2.new(1,0,0.3,0),
        Position  = UDim2.new(0,0,0.35,0),
        Text      = "•••\n\"Do you hear the Whistler?\"\nCOVER YOUR EARS.",
        TextSize  = 28,
        TextColor3 = Color3.fromRGB(255,255,255),
        TextWrapped = true,
        ZIndex    = 502,
    })

    task.wait(3)
    selfKick()
end

btnStart.MouseButton1Click:Connect(function()
    task.spawn(startARG)
end)

btnBecome.MouseButton1Click:Connect(function()
    task.spawn(becomePrakim)
end)

btnStart.MouseEnter:Connect(function()
    TweenService:Create(btnStart, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(210,0,0)
    }):Play()
end)
btnStart.MouseLeave:Connect(function()
    TweenService:Create(btnStart, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(180,0,0)
    }):Play()
end)

btnBecome.MouseEnter:Connect(function()
    TweenService:Create(btnBecome, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(40,0,0)
    }):Play()
end)
btnBecome.MouseLeave:Connect(function()
    TweenService:Create(btnBecome, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(20,20,20)
    }):Play()
end)

sysNotif("ARG פרחים", "The script has been successfully loaded. The panel is ready to use..", 5)

print("[ARG פרחים] Script loaded successfully. Panel ready.")
