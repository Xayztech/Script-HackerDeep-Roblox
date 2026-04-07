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
    ESP = false, Tracers = false, Boxes = false, Names = false, Dist = false, Health = false, Antenna = false,
    Aimbot = false, AimLock = false, AimLegit = false, AutoAim = false, AimPart = "Head",
    Admin = false, Fly = false, FlySpeed = 50,
    Dex = false, FPSBoost = false, SmoothCam = false,
    Visible = true, Prefix = ";"
}

local function Bypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" or method == "BreakJoints" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(Bypass)

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Xayz CoreXT"

local Float = Instance.new("TextButton", Screen)
Float.Size = UDim2.new(0, 50, 0, 50)
Float.Position = UDim2.new(0, 10, 0.4, 0)
Float.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Float.Text = "Xayz CoreXT"
Float.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 260, 0, 400)
Main.Position = UDim2.new(0.5, -130, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.Active = true
Main.Draggable = true

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 35)
Top.BackgroundColor3 = Color3.fromRGB(180, 0, 0)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Text = "  By XYCoolcraft"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0, 35, 1, 0)
MinBtn.Position = UDim2.new(1, -35, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -35)
Scroll.Position = UDim2.new(0, 0, 0, 35)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 5, 0)

Float.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
MinBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local function AddToggle(name, key, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, (#Scroll:GetChildren() * 37) + 5)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        XY[key] = not XY[key]
        btn.Text = name .. (XY[key] and ": ON" or ": OFF")
        btn.BackgroundColor3 = XY[key] and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(30, 30, 30)
        if callback then callback(XY[key]) end
    end)
end

AddToggle("Master ESP", "ESP")
AddToggle("Show Tracers", "Tracers")
AddToggle("Show Boxes", "Boxes")
AddToggle("Show Names", "Names")
AddToggle("Show Distance", "Dist")
AddToggle("Show Health", "Health")
AddToggle("Show Antenna", "Antenna")

AddToggle("Aimbot Master", "Aimbot")
AddToggle("Aim Lock", "AimLock")
AddToggle("Aim Legit", "AimLegit")
AddToggle("Auto Aim", "AutoAim")

local PartBtn = Instance.new("TextButton", Scroll)
PartBtn.Size = UDim2.new(0.9, 0, 0, 32)
PartBtn.Position = UDim2.new(0.05, 0, 0, (#Scroll:GetChildren() * 37) + 5)
PartBtn.Text = "Aim Part: HEAD"
PartBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
PartBtn.MouseButton1Click:Connect(function()
    XY.AimPart = (XY.AimPart == "Head" and "HumanoidRootPart" or "Head")
    PartBtn.Text = "Aim Part: " .. (XY.AimPart == "Head" and "HEAD" or "TORSO")
end)

AddToggle("Bypass Admin (Prefix ;)", "Admin")
AddToggle("Dex Explorer Root", "Dex", function(v)
    if v then for _, o in pairs(game:GetChildren()) do print("ROOT: " .. o.Name) end end
end)
AddToggle("FPS Booster", "FPSBoost", function(v)
    if v then for _, d in pairs(game:GetDescendants()) do if d:IsA("BasePart") then d.Material = "SmoothPlastic" end end end
end)
AddToggle("Ultra Smooth Camera", "SmoothCam")

LocalPlayer.Chatted:Connect(function(m)
    if not XY.Admin then return end
    local args = m:lower():split(" ")
    if args[1] == XY.Prefix.."fly" then XY.Fly = true
    elseif args[1] == XY.Prefix.."unfly" then XY.Fly = false
    elseif args[1] == XY.Prefix.."speed" then LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(args[2]) or 100
    elseif args[1] == XY.Prefix.."jump" then LocalPlayer.Character.Humanoid.JumpPower = tonumber(args[2]) or 200
    elseif args[1] == XY.Prefix.."re" then LocalPlayer.Character:BreakJoints() end
end)

RunService.RenderStepped:Connect(function()
    if XY.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(0, 2, 0)
        hrp.CFrame = hrp.CFrame + (Camera.CFrame.LookVector * (XY.FlySpeed / 10))
    end
    if XY.SmoothCam then Camera.FieldOfView = 90 end
end)

local function CreateESP(p)
    local Line = Drawing.new("Line")
    local Box = Drawing.new("Square")
    local NameText = Drawing.new("Text")
    
    RunService.RenderStepped:Connect(function()
        if XY.ESP and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = p.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)
            if OnScreen then
                if XY.Tracers then
                    Line.Visible = true
                    Line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    Line.To = Vector2.new(Pos.X, Pos.Y)
                    Line.Color = Color3.fromRGB(255, 0, 0)
                else Line.Visible = false end
                if XY.Boxes then
                    Box.Visible = true
                    Box.Size = Vector2.new(2000/Pos.Z, 2500/Pos.Z)
                    Box.Position = Vector2.new(Pos.X - Box.Size.X/2, Pos.Y - Box.Size.Y/2)
                    Box.Color = Color3.fromRGB(255, 255, 255)
                else Box.Visible = false end
                if XY.Names then
                    NameText.Visible = true
                    NameText.Text = p.Name .. (XY.Dist and " ["..math.floor((HRP.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m]" or "")
                    NameText.Position = Vector2.new(Pos.X, Pos.Y - 40)
                    NameText.Center = true
                    NameText.Outline = true
                else NameText.Visible = false end
            else Line.Visible = false; Box.Visible = false; NameText.Visible = false end
        else Line.Visible = false; Box.Visible = false; NameText.Visible = false end
    end)
end
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)

RunService.RenderStepped:Connect(function()
    if (XY.Aimbot or XY.AutoAim) and XY.AimLock then
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

local LFrame = Instance.new("Frame", Screen)
LFrame.Size = UDim2.new(1, 0, 1, 0)
LFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
local LBar = Instance.new("Frame", LFrame)
LBar.Size = UDim2.new(0, 0, 0, 5)
LBar.Position = UDim2.new(0, 0, 0.5, 0)
LBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local LText = Instance.new("TextLabel", LFrame)
LText.Size = UDim2.new(1, 0, 0, 50)
LText.Position = UDim2.new(0, 0, 0.4, 0)
LText.TextColor3 = Color3.fromRGB(255, 255, 255)
for i = 1, 100 do task.wait(0.015); LBar.Size = UDim2.new(i/100, 0, 0, 5); LText.Text = "Xayz Loading: "..i.."%" end
LFrame:Destroy()
