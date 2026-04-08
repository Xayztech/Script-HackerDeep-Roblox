--[[ 
   CREATED BY XYCOOLCRAFT
   MY ROBLOX: XYCoolcraft 
   MY 2 ROBLOX: XayzPrime
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local XY = {
    Visible = true, Prefix = ";",
    ESP = false, Tracers = false, Boxes = false, Names = false, Dist = false, Health = false, Antenna = false,
    Aimbot = false, AimLock = false, AimPart = "Head",
    Admin = true, Fly = false, FlySpeed = 50,
    GodV1 = false, GodV2 = false,
    TargetName = ""
}

local function KernelBypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "Kick" or method == "kick" or method == "BreakJoints" then 
            return nil 
        end
        if method == "GetRankInGroup" or method == "GetRoleInGroup" then
            return 255
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(KernelBypass)

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Xayz CoreTX"

local Float = Instance.new("TextButton", Screen)
Float.Size = UDim2.new(0, 50, 0, 50)
Float.Position = UDim2.new(0, 10, 0.4, 0)
Float.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Float.Text = "XY"
Float.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 280, 0, 450)
Main.Position = UDim2.new(0.5, -140, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(180, 0, 0)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Text = "  Xayz Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 40, 1, 0)
MinBtn.Position = UDim2.new(1, -40, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -40)
Scroll.Position = UDim2.new(0, 0, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 12, 0)

Float.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
MinBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local function AddToggle(name, key)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, (#Scroll:GetChildren() * 40) + 5)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.MouseButton1Click:Connect(function()
        XY[key] = not XY[key]
        btn.Text = name .. (XY[key] and ": ON" or ": OFF")
        btn.BackgroundColor3 = XY[key] and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 30, 30)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
    end)
end

local AbusePanel = Instance.new("Frame", Screen)
AbusePanel.Size = UDim2.new(0, 250, 0, 180)
AbusePanel.Position = UDim2.new(0.5, -125, 0.5, -90)
AbusePanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
AbusePanel.Visible = false
AbusePanel.Active = true
AbusePanel.Draggable = true

local UserInput = Instance.new("TextBox", AbusePanel)
UserInput.Size = UDim2.new(0.9, 0, 0, 35)
UserInput.Position = UDim2.new(0.05, 0, 0, 40)
UserInput.PlaceholderText = "Username Target..."
UserInput.Text = ""

local KickBtn = Instance.new("TextButton", AbusePanel)
KickBtn.Size = UDim2.new(0.9, 0, 0, 40)
KickBtn.Position = UDim2.new(0.05, 0, 0, 90)
KickBtn.Text = "KICK PLAYER"
KickBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KickBtn.MouseButton1Click:Connect(function()
    local p = Players:FindFirstChild(UserInput.Text)
    if p then
        local remotes = game:GetDescendants()
        for _, v in pairs(remotes) do
            if v:IsA("RemoteEvent") and (v.Name:lower():find("kick") or v.Name:lower():find("ban")) then
                v:FireServer(p, "Xayz CoreTX Kick System")
            end
        end
    end
end)

local function CreateESP(p)
    local Trac = Drawing.new("Line")
    local Box = Drawing.new("Square")
    local NameText = Drawing.new("Text")
    local DistText = Drawing.new("Text")
    local HPBarBase = Drawing.new("Line")
    local HPBarFill = Drawing.new("Line")

    RunService.RenderStepped:Connect(function()
        if XY.ESP and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            local HRP = p.Character.HumanoidRootPart
            local Hum = p.Character.Humanoid
            local pos, vis = Camera:WorldToViewportPoint(HRP.Position)
            
            if vis then
                local Size = Vector2.new(2000/pos.Z, 2500/pos.Z)
                local TopLeft = Vector2.new(pos.X - Size.X/2, pos.Y - Size.Y/2)

                Trac.Visible = XY.Tracers; Trac.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); Trac.To = Vector2.new(pos.X, pos.Y); Trac.Color = Color3.fromRGB(255, 0, 0)
                Box.Visible = XY.Boxes; Box.Size = Size; Box.Position = TopLeft; Box.Color = Color3.fromRGB(255, 255, 255)
                NameText.Visible = XY.Names; NameText.Text = p.Name; NameText.Position = Vector2.new(pos.X, TopLeft.Y - 15); NameText.Center = true; NameText.Outline = true
                DistText.Visible = XY.Dist; DistText.Text = "["..math.floor((HRP.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m]"; DistText.Position = Vector2.new(pos.X, pos.Y + Size.Y/2 + 5); DistText.Center = true
                if XY.Health then
                    HPBarBase.Visible = true; HPBarBase.From = Vector2.new(TopLeft.X - 5, TopLeft.Y + Size.Y); HPBarBase.To = Vector2.new(TopLeft.X - 5, TopLeft.Y); HPBarBase.Thickness = 3; HPBarBase.Color = Color3.fromRGB(50,0,0)
                    HPBarFill.Visible = true; HPBarFill.From = Vector2.new(TopLeft.X - 5, TopLeft.Y + Size.Y); HPBarFill.To = Vector2.new(TopLeft.X - 5, TopLeft.Y + Size.Y - (Size.Y * (Hum.Health/Hum.MaxHealth))); HPBarFill.Thickness = 3; HPBarFill.Color = Color3.fromRGB(0,255,0)
                else HPBarBase.Visible = false; HPBarFill.Visible = false end
            else
                Trac.Visible = false; Box.Visible = false; NameText.Visible = false; DistText.Visible = false; HPBarBase.Visible = false; HPBarFill.Visible = false
            end
        else
            Trac.Visible = false; Box.Visible = false; NameText.Visible = false; DistText.Visible = false; HPBarBase.Visible = false; HPBarFill.Visible = false
        end
    end)
end

local BV = Instance.new("BodyVelocity"); local BG = Instance.new("BodyGyro")
BV.MaxForce = Vector3.new(1e9, 1e9, 1e9); BG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        if XY.Fly then
            BV.Parent = HRP; BG.Parent = HRP; BG.CFrame = Camera.CFrame
            BV.Velocity = (LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0) and (Camera.CFrame.LookVector * XY.FlySpeed) or Vector3.new(0, 0.1, 0)
        else BV.Parent = nil; BG.Parent = nil end

        if XY.GodV2 then
            LocalPlayer.Character.Humanoid.MaxHealth = 9e9; LocalPlayer.Character.Humanoid.Health = 9e9
        end
    end
    if XY.Aimbot and XY.AimLock then
        local t = nil; local d = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(XY.AimPart) then
                local pos, vis = Camera:WorldToViewportPoint(p.Character[XY.AimPart].Position)
                if vis then
                    local m = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if m < d then d = m; t = p end
                end
            end
        end
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character[XY.AimPart].Position) end
    end
end)

LocalPlayer.Chatted:Connect(function(m)
    local a = m:lower():split(" ")
    if a[1] == XY.Prefix.."fly" then XY.Fly = true
    elseif a[1] == XY.Prefix.."unfly" then XY.Fly = false
    elseif a[1] == XY.Prefix.."speed" then LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(a[2]) or 100
    elseif args[1] == XY.Prefix.."kickv" then
        local target = args[2]
        for _, p in pairs(Players:GetPlayers()) do
            if p.Name:lower():sub(1, #target) == target then p:Kick("Xayz CoreTX Kick System") end
        end
    elseif a[1] == XY.Prefix.."kick" then
        local t = Players:FindFirstChild(a[2])
        if t then t:Kick("Xayz CoreTX Kick System") end
    end
end)

AddToggle("Master ESP", "ESP")
AddToggle("Show Tracers", "Tracers")
AddToggle("Show Boxes", "Boxes")
AddToggle("Show Names", "Names")
AddToggle("Show Distance", "Dist")
AddToggle("Show Health Bars", "Health")
AddToggle("Aimbot Master", "Aimbot")
AddToggle("Aim Lock", "AimLock")
AddToggle("Fly Mode", "Fly")
AddToggle("God Mode V2", "GodV2")

local AbuseBtn = Instance.new("TextButton", Scroll)
AbuseBtn.Size = UDim2.new(0.9, 0, 0, 35); AbuseBtn.Position = UDim2.new(0.05, 0, 0, (#Scroll:GetChildren()*40)+5); AbuseBtn.Text = "OPEN KICK PANEL"; AbuseBtn.BackgroundColor3 = Color3.fromRGB(100,0,0); AbuseBtn.MouseButton1Click:Connect(function() AbusePanel.Visible = not AbusePanel.Visible end)

for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)

local L = Instance.new("Frame", Screen); L.Size = UDim2.new(1,0,1,0); L.BackgroundColor3 = Color3.fromRGB(0,0,0)
local LT = Instance.new("TextLabel", L); LT.Size = UDim2.new(1,0,1,0); LT.TextColor3 = Color3.fromRGB(255,0,0)
for i = 1, 100 do task.wait(0.01); LT.Text = "Xayz Loading: "..i.."%" end; L:Destroy()
