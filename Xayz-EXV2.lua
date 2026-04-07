--[[ 
   CREATED BY XYCOOLCRAFT
   MY ROBLOX: XYCoolcraft 
   MY 2 ROBLOX: XayzPrime
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local XY = {
    ESP = false, Tracers = false, Boxes = false, Names = false, 
    Dist = false, Health = false, Antenna = false,
    Aimbot = false, AimLock = false, AimPart = "Head", 
    AimLegit = false, AutoAim = false,
    Admin = false, Fly = false, FlySpeed = 50, WalkSpeed = 16, JumpPower = 50,
    Dex = false, FPSBoost = false, SmoothCam = false,
    Prefix = ";", Visible = true
}

local function BypassSystem()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and (method == "Kick" or method == "kick" or method == "BreakJoints") then 
            return nil 
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(BypassSystem)

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Xayz CoreXT"

local TglBtn = Instance.new("TextButton", Screen)
TglBtn.Size = UDim2.new(0, 55, 0, 55)
TglBtn.Position = UDim2.new(0, 10, 0.4, 0)
TglBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
TglBtn.Text = "XY"
TglBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TglBtn.Font = Enum.Font.Black
Instance.new("UICorner", TglBtn).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 280, 0, 420)
Main.Position = UDim2.new(0.5, -140, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Header.Text = "By XYCoolcraft"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.Font = Enum.Font.GothamBold

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -40)
Scroll.Position = UDim2.new(0, 0, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 5, 0)
Scroll.ScrollBarThickness = 4

TglBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local btnCount = 0
local function AddFeature(name, key, type, callback)
    if type == "Toggle" then
        local btn = Instance.new("TextButton", Scroll)
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = UDim2.new(0.05, 0, 0, (btnCount * 40) + 5)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.Text = name .. ": OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        btn.MouseButton1Click:Connect(function()
            XY[key] = not XY[key]
            btn.Text = name .. (XY[key] and ": ON" or ": OFF")
            btn.BackgroundColor3 = XY[key] and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 30, 30)
            if callback then callback(XY[key]) end
        end)
    elseif type == "Button" then
        local btn = Instance.new("TextButton", Scroll)
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = UDim2.new(0.05, 0, 0, (btnCount * 40) + 5)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.MouseButton1Click:Connect(callback)
    end
    btnCount = btnCount + 1
end

AddFeature("Bypass Become Admin (HD)", "Admin", "Toggle")
AddFeature("Fly Mode (;fly / ;unfly)", "Fly", "Toggle")

AddFeature("Master ESP", "ESP", "Toggle")
AddFeature("Show Tracers", "Tracers", "Toggle")
AddFeature("Show Box Team", "Boxes", "Toggle")
AddFeature("Show Name", "Names", "Toggle")
AddFeature("Show Distance", "Dist", "Toggle")
AddFeature("Show Health Bar", "Health", "Toggle")
AddFeature("Show Antenna", "Antenna", "Toggle")

AddFeature("Aimbot Master", "Aimbot", "Toggle")
AddFeature("Aim Lock", "AimLock", "Toggle")
AddFeature("Auto Aim", "AutoAim", "Toggle")
AddFeature("Aim Legit", "AimLegit", "Toggle")
AddFeature("Switch Target (Head/Torso)", "", "Button", function()
    XY.AimPart = (XY.AimPart == "Head" and "HumanoidRootPart" or "Head")
    game.StarterGui:SetCore("SendNotification", {Title = "XY-INFO", Text = "Target: "..XY.AimPart})
end)

AddFeature("Dex Explorer Root", "Dex", "Toggle", function(v)
    if v then 
        print("--- XY-DEX: DECODING ROOT GAME ---")
        for _, v in pairs(game:GetChildren()) do print("FOLDER: " .. v.Name) end
    end
end)
AddFeature("FPS Booster", "FPSBoost", "Toggle", function(v)
    if v then
        for _, d in pairs(game:GetDescendants()) do
            if d:IsA("DataModelMesh") or d:IsA("BasePart") then d.Material = "SmoothPlastic" end
        end
    end
end)
AddFeature("Ultra Smooth Camera", "SmoothCam", "Toggle")

LocalPlayer.Chatted:Connect(function(msg)
    if not XY.Admin then return end
    local args = msg:lower():split(" ")
    if args[1] == XY.Prefix.."fly" then XY.Fly = true
    elseif args[1] == XY.Prefix.."unfly" then XY.Fly = false
    elseif args[1] == XY.Prefix.."speed" then LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(args[2]) or 100
    elseif args[1] == XY.Prefix.."jump" then LocalPlayer.Character.Humanoid.JumpPower = tonumber(args[2]) or 200
    elseif args[1] == XY.Prefix.."re" then LocalPlayer.Character:BreakJoints() end
end)

RunService.RenderStepped:Connect(function()
    if XY.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(0, 1, 0)
        hrp.CFrame = hrp.CFrame + (Camera.CFrame.LookVector * (XY.FlySpeed / 10))
    end
    if XY.SmoothCam then
        Camera.FieldOfView = 90
    end
end)

local function ImplementESP(p)
    local Line = Drawing.new("Line")
    local Box = Drawing.new("Square")
    local Text = Drawing.new("Text")
    
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
                    Box.Size = Vector2.new(2500/Pos.Z, 3000/Pos.Z)
                    Box.Position = Vector2.new(Pos.X - Box.Size.X/2, Pos.Y - Box.Size.Y/2)
                    Box.Color = Color3.fromRGB(255, 255, 255)
                else Box.Visible = false end

                if XY.Names then
                    Text.Visible = true
                    Text.Text = p.Name .. (XY.Dist and " ["..math.floor((HRP.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m]" or "")
                    Text.Position = Vector2.new(Pos.X, Pos.Y - 40)
                    Text.Center = true
                    Text.Outline = true
                else Text.Visible = false end
            else Line.Visible = false; Box.Visible = false; Text.Visible = false end
        else Line.Visible = false; Box.Visible = false; Text.Visible = false end
    end)
end
for _, p in pairs(Players:GetPlayers()) do ImplementESP(p) end
Players.PlayerAdded:Connect(ImplementESP)

RunService.RenderStepped:Connect(function()
    if (XY.Aimbot or XY.AutoAim) and XY.AimLock then
        local target = nil
        local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(XY.AimPart) then
                local pos, vis = Camera:WorldToViewportPoint(p.Character[XY.AimPart].Position)
                if vis then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then dist = mag; target = p end
                end
            end
        end
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character[XY.AimPart].Position)
        end
    end
end)

local LoadGui = Instance.new("Frame", Screen)
LoadGui.Size = UDim2.new(1, 0, 1, 0)
LoadGui.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
local Bar = Instance.new("Frame", LoadGui)
Bar.Size = UDim2.new(0, 0, 0, 4)
Bar.Position = UDim2.new(0, 0, 0.5, 0)
Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local Lbl = Instance.new("TextLabel", LoadGui)
Lbl.Size = UDim2.new(1, 0, 0, 50)
Lbl.Position = UDim2.new(0, 0, 0.4, 0)
Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
Lbl.Font = Enum.Font.Code

for i = 1, 100 do
    task.wait(0.01)
    Bar.Size = UDim2.new(i/100, 0, 0, 4)
    Lbl.Text = "Xayz Loading: " .. i .. "%"
end
LoadGui:Destroy()