-- ========================================================
-- ADVANCED EXECUTOR WITH LIVE CONSOLE
-- Dibuat khusus untuk pengujian script & debugging
-- ========================================================

local CoreGui
pcall(function() CoreGui = game:GetService("CoreGui") end)
local Players = game:GetService("Players")
local LogService = game:GetService("LogService")
local LocalPlayer = Players.LocalPlayer

-- 1. Membuat Layar Utama Aman
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LiveConsoleExecutor"
ScreenGui.ResetOnSpawn = false

local successGui = false
if CoreGui then
    successGui, _ = pcall(function()
        local targetGui = (gethui and gethui()) or CoreGui
        ScreenGui.Parent = targetGui
    end)
end
if not successGui then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 2. Membuat Bingkai Utama (Bisa digeser)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
MainFrame.Size = UDim2.new(0, 700, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true -- Memungkinkan GUI untuk digeser

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Header.Size = UDim2.new(1, 0, 0, 30)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "💻 Xayz Live Executor"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 3. Jendela Editor Kode (Kiri)
local EditorFrame = Instance.new("Frame")
EditorFrame.Parent = MainFrame
EditorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
EditorFrame.Position = UDim2.new(0, 10, 0, 40)
EditorFrame.Size = UDim2.new(0.5, -15, 1, -90)

local EditorCorner = Instance.new("UICorner")
EditorCorner.CornerRadius = UDim.new(0, 6)
EditorCorner.Parent = EditorFrame

local CodeInput = Instance.new("TextBox")
CodeInput.Parent = EditorFrame
CodeInput.BackgroundTransparency = 1
CodeInput.Position = UDim2.new(0, 5, 0, 5)
CodeInput.Size = UDim2.new(1, -10, 1, -10)
CodeInput.Font = Enum.Font.Code
CodeInput.Text = "-- Masukkan script atau loadstring di sini\nprint('Halo dunia!')"
CodeInput.TextColor3 = Color3.fromRGB(200, 200, 200)
CodeInput.TextSize = 13
CodeInput.TextXAlignment = Enum.TextXAlignment.Left
CodeInput.TextYAlignment = Enum.TextYAlignment.Top
CodeInput.ClearTextOnFocus = false
CodeInput.MultiLine = true

-- 4. Jendela Live Console (Kanan)
local ConsoleFrame = Instance.new("ScrollingFrame")
ConsoleFrame.Parent = MainFrame
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
ConsoleFrame.Position = UDim2.new(0.5, 5, 0, 40)
ConsoleFrame.Size = UDim2.new(0.5, -15, 1, -90)
ConsoleFrame.ScrollBarThickness = 4
ConsoleFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ConsoleFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ConsoleCorner = Instance.new("UICorner")
ConsoleCorner.CornerRadius = UDim.new(0, 6)
ConsoleCorner.Parent = ConsoleFrame

local ConsolePadding = Instance.new("UIPadding")
ConsolePadding.Parent = ConsoleFrame
ConsolePadding.PaddingTop = UDim.new(0, 5)
ConsolePadding.PaddingLeft = UDim.new(0, 5)

local ConsoleList = Instance.new("UIListLayout")
ConsoleList.Parent = ConsoleFrame
ConsoleList.SortOrder = Enum.SortOrder.LayoutOrder
ConsoleList.Padding = UDim.new(0, 2)

-- Fungsi Pendorong Teks ke Konsol
local function LogToConsole(message, msgType)
    local LogText = Instance.new("TextLabel")
    LogText.Parent = ConsoleFrame
    LogText.BackgroundTransparency = 1
    LogText.Size = UDim2.new(1, -10, 0, 0)
    LogText.AutomaticSize = Enum.AutomaticSize.Y
    LogText.Font = Enum.Font.Code
    LogText.TextSize = 12
    LogText.TextXAlignment = Enum.TextXAlignment.Left
    LogText.TextWrapped = true
    
    -- Pemilihan Warna Berdasarkan Tipe Error/Print
    if msgType == Enum.MessageType.MessageError then
        LogText.TextColor3 = Color3.fromRGB(255, 80, 80) -- Merah (Error)
        LogText.Text = "[ERROR] " .. message
    elseif msgType == Enum.MessageType.MessageWarning then
        LogText.TextColor3 = Color3.fromRGB(255, 200, 50) -- Kuning (Warn)
        LogText.Text = "[WARN] " .. message
    elseif msgType == Enum.MessageType.MessageInfo then
        LogText.TextColor3 = Color3.fromRGB(100, 200, 255) -- Biru Muda (Info Sistem)
        LogText.Text = "[INFO] " .. message
    else
        LogText.TextColor3 = Color3.fromRGB(230, 230, 230) -- Putih (Print biasa)
        LogText.Text = "> " .. message
    end
end

-- Menyadap semua pesan dari Roblox/Eksekutor secara Real-Time
LogService.MessageOut:Connect(function(message, messageType)
    LogToConsole(message, messageType)
end)

-- 5. Tombol Kontrol Bawah
local ExecBtn = Instance.new("TextButton")
ExecBtn.Parent = MainFrame
ExecBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
ExecBtn.Position = UDim2.new(0, 10, 1, -40)
ExecBtn.Size = UDim2.new(0, 100, 0, 30)
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.Text = "EXECUTE"
ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBtn.TextSize = 12
Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 6)

local ClearCodeBtn = Instance.new("TextButton")
ClearCodeBtn.Parent = MainFrame
ClearCodeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
ClearCodeBtn.Position = UDim2.new(0, 120, 1, -40)
ClearCodeBtn.Size = UDim2.new(0, 100, 0, 30)
ClearCodeBtn.Font = Enum.Font.GothamBold
ClearCodeBtn.Text = "CLEAR CODE"
ClearCodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearCodeBtn.TextSize = 12
Instance.new("UICorner", ClearCodeBtn).CornerRadius = UDim.new(0, 6)

local ClearConsoleBtn = Instance.new("TextButton")
ClearConsoleBtn.Parent = MainFrame
ClearConsoleBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
ClearConsoleBtn.Position = UDim2.new(1, -110, 1, -40)
ClearConsoleBtn.Size = UDim2.new(0, 100, 0, 30)
ClearConsoleBtn.Font = Enum.Font.GothamBold
ClearConsoleBtn.Text = "CLEAR LOGS"
ClearConsoleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearConsoleBtn.TextSize = 12
Instance.new("UICorner", ClearConsoleBtn).CornerRadius = UDim.new(0, 6)

-- 6. Logika Tombol
ExecBtn.MouseButton1Click:Connect(function()
    local scriptText = CodeInput.Text
    if scriptText == "" then return end
    
    LogToConsole("Mengeksekusi kode...", Enum.MessageType.MessageInfo)
    
    -- Mencari fungsi loadstring dari eksekutor
    local execLoadstring = loadstring
    if not execLoadstring and getgenv then
        execLoadstring = getgenv().loadstring
    end
    
    if execLoadstring then
        -- 1. Cek Syntax Error (Apakah ada salah ketik?)
        local func, compileError = execLoadstring(scriptText)
        if not func then
            LogToConsole("SYNTAX ERROR: " .. tostring(compileError), Enum.MessageType.MessageError)
            return
        end
        
        -- 2. Jalankan dan Cek Runtime Error (Apakah gagal saat berjalan?)
        task.spawn(function()
            local success, runError = pcall(func)
            if not success then
                LogToConsole("RUNTIME ERROR: " .. tostring(runError), Enum.MessageType.MessageError)
            else
                LogToConsole("Eksekusi selesai tanpa hambatan.", Enum.MessageType.MessageInfo)
            end
        end)
    else
        LogToConsole("Eksekutor kamu tidak mendukung fungsi loadstring!", Enum.MessageType.MessageError)
    end
end)

ClearCodeBtn.MouseButton1Click:Connect(function()
    CodeInput.Text = ""
end)

ClearConsoleBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(ConsoleFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    LogToConsole("Konsol dibersihkan.", Enum.MessageType.MessageInfo)
end)

LogToConsole("Sistem Live Console berhasil dimuat. Siap digunakan!", Enum.MessageType.MessageInfo)
