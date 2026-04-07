--[[ 
   CREATED BY XYCOOLCRAFT
   MY ROBLOX: XYCoolcraft 
   MY 2 ROBLOX: XayzPrime
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local XY = {
    Visible = true, Prefix = ";",
    ESP = false, Tracers = false, Boxes = false, Names = false,
    Aimbot = false, AimLock = false, AimPart = "Head", AimSpeed = 50,
    Admin = true, Fly = false, FlySpeed = 50,
    GodV1 = false, GodV2 = false,
    Target = ""
}

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then return nil end
    if method == "GetRankInGroup" or method == "GetRoleInGroup" then return 255 end
    return old(self, ...)
end)
setreadonly(mt, true)

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Xayz CoreTX"

local Float = Instance.new("TextButton", Screen)
Float.Size = UDim2.new(0, 50, 0, 50)
Float.Position = UDim2.new(0, 10, 0.4, 0)
Float.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Float.Text = "XY"
Float.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 270, 0, 430)
Main.Position = UDim2.new(0.5, -135, 0.5, -215)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Draggable = true
Main.Active = true

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 35)
Top.BackgroundColor3 = Color3.fromRGB(180, 0, 0)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Text = "  Xayz Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0, 35, 1, 0)
MinBtn.Position = UDim2.new(1, -35, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -35)
Scroll.Position = UDim2.new(0, 0, 0, 35)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 10, 0)

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
    end)
end

local function AddInput(placeholder, callback)
    local box = Instance.new("TextBox", Scroll)
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.Position = UDim2.new(0.05, 0, 0, (#Scroll:GetChildren() * 40) + 5)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.FocusLost:Connect(function() callback(box.Text) end)
end

AddToggle("Master ESP", "ESP")
AddToggle("Show Tracers", "Tracers")
AddToggle("Show Boxes", "Boxes")
AddToggle("Show Names", "Names")
AddToggle("Aimbot Master", "Aimbot")
AddToggle("Aim Lock", "AimLock")
AddToggle("Fly Mode", "Fly")
AddInput("Fly Speed (Default 50)", function(t) XY.FlySpeed = tonumber(t) or 50 end)
AddToggle("God Mode V1 (ForceField)", "GodV1")
AddToggle("God Mode V2 (Health Loop)", "GodV2")
AddInput("Target Username (Ban/Kick)", function(t) XY.Target = t end)

local BV = Instance.new("BodyVelocity")
local BG = Instance.new("BodyGyro")
BV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
BG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

local function DrawESP(p)
    local L = Drawing.new("Line")
    local B = Drawing.new("Square")
    local N = Drawing.new("Text")
    
    RunService.RenderStepped:Connect(function()
        if XY.ESP and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = p.Character.HumanoidRootPart
            local Pos, Vis = Camera:WorldToViewportPoint(HRP.Position)
            if Vis then
                if XY.Tracers then
                    L.Visible = true; L.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); L.To = Vector2.new(Pos.X, Pos.Y); L.Color = Color3.fromRGB(255, 0, 0)
                else L.Visible = false end
                if XY.Boxes then
                    B.Visible = true; B.Size = Vector2.new(2000/Pos.Z, 2500/Pos.Z); B.Position = Vector2.new(Pos.X-B.Size.X/2, Pos.Y-B.Size.Y/2); B.Color = Color3.fromRGB(255, 255, 255)
                else B.Visible = false end
                if XY.Names then
                    N.Visible = true; N.Text = p.Name; N.Position = Vector2.new(Pos.X, Pos.Y - 40); N.Center = true; N.Outline = true
                else N.Visible = false end
            else L.Visible = false; B.Visible = false; N.Visible = false end
        else L.Visible = false; B.Visible = false; N.Visible = false end
    end)
end
for _, p in pairs(Players:GetPlayers()) do DrawESP(p) end
Players.PlayerAdded:Connect(DrawESP)

RunService.RenderStepped:Connect(function()
    if XY.Aimbot and XY.AimLock then
        local target = nil; local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(XY.AimPart) then
                local pos, vis = Camera:WorldToViewportPoint(p.Character[XY.AimPart].Position)
                if vis then
                    local m = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if m < dist then dist = m; target = p end
                end
            end
        end
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character[XY.AimPart].Position) end
    end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        if XY.Fly then
            BV.Parent = HRP; BG.Parent = HRP; BG.CFrame = Camera.CFrame
            BV.Velocity = Camera.CFrame.LookVector * XY.FlySpeed
        else BV.Parent = nil; BG.Parent = nil end
        
        if XY.GodV1 and not LocalPlayer.Character:FindFirstChildOfClass("ForceField") then
            Instance.new("ForceField", LocalPlayer.Character).Visible = false
        end
        if XY.GodV2 then
            LocalPlayer.Character.Humanoid.MaxHealth = 9e9
            LocalPlayer.Character.Humanoid.Health = 9e9
        end
    end
end)

local L = Instance.new("Frame", Screen); L.Size = UDim2.new(1,0,1,0); L.BackgroundColor3 = Color3.fromRGB(0,0,0)
local LT = Instance.new("TextLabel", L); LT.Size = UDim2.new(1,0,1,0); LT.TextColor3 = Color3.fromRGB(255,0,0)
for i = 1, 100 do task.wait(0.01); LT.Text = "Xayz Loading: "..i.."%" end; L:Destroy()
