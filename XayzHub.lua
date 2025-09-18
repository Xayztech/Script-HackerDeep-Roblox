local GITHUB_DATABASE_URL = "https://raw.githubusercontent.com/Xayztech/Script-HackerDeep-Roblox/main/script_my.json"
local LOCAL_SCRIPTS_PATH = "xayz_save_script.json"
local REQUIRED_KEY = "XAYZTECH#EMPEROR@11279108300088174971970"
local KEY_WEBSITE_URL = "https://your-website-for-key.com"

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if not game:IsLoaded() then game.Loaded:Wait() end
if not getgenv then getgenv = function() return _G end end
if not isfile or not writefile or not readfile then
    warn("Executor does not support 'readfile'/'writefile'. The save feature will not work.")
    local fake_storage = {}
    function isfile(path) return fake_storage[path] ~= nil end
    function readfile(path) return fake_storage[path] or "[]" end
    function writefile(path, content) fake_storage[path] = content end
end

local combined_script_database = {}

local function load_all_scripts()
    combined_script_database = {}
    

    local success, response = pcall(function() return game:HttpGet(GITHUB_DATABASE_URL) end)
    if success then
        local decode_success, decoded_data = pcall(function() return HttpService:JSONDecode(response) end)
        if decode_success then
            for _, script_data in ipairs(decoded_data) do
                table.insert(combined_script_database, script_data)
            end
            print("Loading...")
        else
            warn("Eror Reading:", decoded_data)
        end
    else
        warn("Eror Take Data:", response)
    end

    if isfile(LOCAL_SCRIPTS_PATH) then
        local local_content = readfile(LOCAL_SCRIPTS_PATH)
        local decode_success, local_data = pcall(function() return HttpService:JSONDecode(local_content) end)
        if decode_success then
            for _, script_data in ipairs(local_data) do
                table.insert(combined_script_database, script_data)
            end
            print("User local script loaded successfully!")
        end
    end
end

local function save_local_script(new_script)
    local local_scripts = {}

    if isfile(LOCAL_SCRIPTS_PATH) then
        local success, data = pcall(function() return HttpService:JSONDecode(readfile(LOCAL_SCRIPTS_PATH)) end)
        if success then local_scripts = data end
    end
    
    table.insert(local_scripts, new_script)
    local success, encoded = pcall(function() return HttpService:JSONEncode(local_scripts) end)
    if success then
        writefile(LOCAL_SCRIPTS_PATH, encoded)
    end
end

local function check_key()
    if isfile and isfile("xayzkey_sv.txt") and readfile("xayzkey_sv.txt") == REQUIRED_KEY then return true end
    return false
end

local function save_key(key)
    if writefile then writefile("xayzkey_sv.txt", key) end
end

local UI = {}
UI.DraggableWindows = {}
function UI:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "XayzHub MainGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
    mainFrame.BorderSizePixel = 2
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    table.insert(UI.DraggableWindows, mainFrame)
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    topBar.BorderColor3 = Color3.fromRGB(0, 255, 0)
    topBar.BorderSizePixel = 1
    topBar.Parent = mainFrame
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0.02, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    titleLabel.Font = Enum.Font.Code
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.Code
    closeButton.TextSize = 20
    closeButton.Parent = topBar
    closeButton.MouseButton1Click:Connect(function() screenGui:Destroy() end)
    local maximizeButton = Instance.new("TextButton")
    maximizeButton.Size = UDim2.new(0, 30, 0, 30)
    maximizeButton.Position = UDim2.new(1, -60, 0, 0)
    maximizeButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    maximizeButton.Text = "[]"
    maximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeButton.Font = Enum.Font.Code
    maximizeButton.TextSize = 20
    maximizeButton.Parent = topBar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -90, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    minimizeButton.Text = "_"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.Code
    minimizeButton.TextSize = 20
    minimizeButton.Parent = topBar
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    local originalSize = mainFrame.Size
    local originalPosition = mainFrame.Position
    local isMaximized = false
    maximizeButton.MouseButton1Click:Connect(function()
        isMaximized = not isMaximized
        if isMaximized then
            mainFrame:TweenSizeAndPosition(UDim2.new(0.9, 0, 0.9, 0), UDim2.new(0.05, 0, 0.05, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        else
            mainFrame:TweenSizeAndPosition(originalSize, originalPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        end
    end)
    local isMinimized = false
    local mainContent = {}
    for _, child in pairs(mainFrame:GetChildren()) do if child ~= topBar then table.insert(mainContent, child) end end
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        for _, v in pairs(mainContent) do v.Visible = not isMinimized end
        if isMinimized then
            mainFrame:TweenSize(UDim2.new(0, 200, 0, 30), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        else
             mainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        end
    end)
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.8, true)
    return screenGui, mainFrame, contentFrame
end
local function create_background_effects(parent)
    local glitch = Instance.new("ImageLabel")
    glitch.Size = UDim2.new(1, 0, 1, 0)
    glitch.Image = "rbxassetid://212523420"
    glitch.ImageTransparency = 0.95
    glitch.ScaleType = Enum.ScaleType.Tile
    glitch.TileSize = UDim2.new(0, 50, 0, 50)
    glitch.Parent = parent
    coroutine.wrap(function()
        while wait(math.random(1, 5)) do
            if not parent.Parent then break end
            glitch.ImageTransparency = 0.8
            wait(0.05)
            glitch.ImageTransparency = 0.95
        end
    end)()
    local matrixContainer = Instance.new("Frame")
    matrixContainer.Size = UDim2.new(1, 0, 1, 0)
    matrixContainer.BackgroundTransparency = 1
    matrixContainer.ClipsDescendants = true
    matrixContainer.Parent = parent
    for i = 1, 30 do
        local column = Instance.new("TextLabel")
        column.Size = UDim2.new(0, 20, 1, 0)
        column.Position = UDim2.new(0, math.random(0, parent.AbsoluteSize.X), 0, -parent.AbsoluteSize.Y)
        column.BackgroundTransparency = 1
        column.TextColor3 = Color3.fromRGB(0, 255, 0)
        column.Text = "1\n0\n1\n0\n1\n0\n1\n0\n1\n0\n1\n0\n1\n0\n1\n0\n1\n0\n1\n0"
        column.Font = Enum.Font.Code
        column.TextSize = 14
        column.TextWrapped = true
        column.Parent = matrixContainer
        coroutine.wrap(function()
            while wait() do
                if not column.Parent then break end
                column:TweenPosition(UDim2.new(column.Position.X.Scale, column.Position.X.Offset, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, math.random(5, 10), true)
                wait(math.random(5, 10))
                column.Position = UDim2.new(0, math.random(0, parent.AbsoluteSize.X), 0, -parent.AbsoluteSize.Y)
            end
        end)()
    end
end

local function execute_script(code)
    local func, err = loadstring(code)
    if func then pcall(func) else warn("Error loadstring:", err) end
end
local function show_confirmation(script_name, script_code)
    local confirmGui, confirmFrame, confirmContent = UI:CreateWindow("Konfirmasi")
    confirmFrame.Size = UDim2.new(0, 400, 0, 150)
    confirmFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
    confirmGui.Parent = game.CoreGui
    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -20, 0, 60)
    msg.Position = UDim2.new(0, 10, 0, 10)
    msg.Text = "📢⚠️? Are you sure you want to run the script? '".. script_name .."'?"
    msg.TextColor3 = Color3.fromRGB(255, 255, 255)
    msg.Font = Enum.Font.SourceSans
    msg.TextSize = 18
    msg.TextWrapped = true
    msg.BackgroundTransparency = 1
    msg.Parent = confirmContent
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0.4, 0, 0, 40)
    yesButton.Position = UDim2.new(0.05, 0, 1, -50)
    yesButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    yesButton.Text = "Yes"
    yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesButton.Font = Enum.Font.Code
    yesButton.TextSize = 18
    yesButton.Parent = confirmContent
    yesButton.MouseButton1Click:Connect(function() confirmGui:Destroy(); execute_script(script_code) end)
    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0.4, 0, 0, 40)
    noButton.Position = UDim2.new(0.55, 0, 1, -50)
    noButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    noButton.Text = "No"
    noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noButton.Font = Enum.Font.Code
    noButton.TextSize = 18
    noButton.Parent = confirmContent
    noButton.MouseButton1Click:Connect(function() confirmGui:Destroy() end)
end
local function view_script(script_name, script_code)
    local viewGui, viewFrame, viewContent = UI:CreateWindow("View Script: " .. script_name)
    viewFrame.Size = UDim2.new(0, 500, 0, 350)
    viewFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    viewGui.Parent = game.CoreGui
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(1, -20, 1, -20)
    scriptBox.Position = UDim2.new(0, 10, 0, 10)
    scriptBox.MultiLine = true
    scriptBox.Text = script_code
    scriptBox.ClearTextOnFocus = false
    scriptBox.TextColor3 = Color3.fromRGB(0, 255, 0)
    scriptBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextSize = 14
    scriptBox.TextXAlignment = Enum.TextXAlignment.Left
    scriptBox.TextYAlignment = Enum.TextYAlignment.Top
    scriptBox.Parent = viewContent
end
local function add_script_popup(onAddCallback)
    local addGui, addFrame, addContent = UI:CreateWindow("Add Script (Saved on Your Device)")
    addFrame.Size = UDim2.new(0, 500, 0, 350)
    addFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    addGui.Parent = game.CoreGui

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -20, 0, 20)
    nameLabel.Position = UDim2.new(0, 10, 0, 10)
    nameLabel.Text = "Script Name:"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.SourceSans
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.BackgroundTransparency = 1
    nameLabel.Parent = addContent
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(1, -20, 0, 30)
    nameBox.Position = UDim2.new(0, 10, 0, 30)
    nameBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    nameBox.TextColor3 = Color3.fromRGB(0, 255, 0)
    nameBox.Font = Enum.Font.Code
    nameBox.PlaceholderText = "Enter the script name..."
    nameBox.Parent = addContent
    local codeLabel = Instance.new("TextLabel")
    codeLabel.Size = UDim2.new(1, -20, 0, 20)
    codeLabel.Position = UDim2.new(0, 10, 0, 70)
    codeLabel.Text = "Code (Lua or URL Link):"
    codeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    codeLabel.Font = Enum.Font.SourceSans
    codeLabel.TextXAlignment = Enum.TextXAlignment.Left
    codeLabel.BackgroundTransparency = 1
    codeLabel.Parent = addContent
    local codeBox = Instance.new("TextBox")
    codeBox.Size = UDim2.new(1, -20, 1, -150)
    codeBox.Position = UDim2.new(0, 10, 0, 90)
    codeBox.MultiLine = true
    codeBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    codeBox.TextColor3 = Color3.fromRGB(0, 255, 0)
    codeBox.Font = Enum.Font.Code
    codeBox.TextXAlignment = Enum.TextXAlignment.Left
    codeBox.TextYAlignment = Enum.TextYAlignment.Top
    codeBox.PlaceholderText = "Paste the .lua link or lua code directly here"
    codeBox.Parent = addContent
    local okButton = Instance.new("TextButton")
    okButton.Size = UDim2.new(1, -20, 0, 40)
    okButton.Position = UDim2.new(0, 10, 1, -50)
    okButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    okButton.Text = "OK"
    okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    okButton.Font = Enum.Font.Code
    okButton.TextSize = 18
    okButton.Parent = addContent
    okButton.MouseButton1Click:Connect(function()
        local name = nameBox.Text
        local code = codeBox.Text
        if name and code and name ~= "" and code ~= "" then
            local final_code
            local trimmed_code = code:gsub("%s", "")
            if trimmed_code:sub(1, 8):lower() == "https://" or trimmed_code:sub(1, 7):lower() == "http://" then
                final_code = "loadstring(game:HttpGet(\"" .. code .. "\", true))()"
            else
                final_code = code
            end
            onAddCallback({Name = name, Code = final_code})
            addGui:Destroy()
        end
    end)
end
function show_main_app()
    local mainGui, mainFrame, contentFrame = UI:CreateWindow("XΛYZ ƬΣCΉ - Executor Hub")
    mainGui.Parent = game:GetService("CoreGui")
    create_background_effects(mainFrame)
    
    local welcomeMessage = Instance.new("TextLabel")
    welcomeMessage.Size = UDim2.new(1, -20, 0, 60)
    welcomeMessage.Position = UDim2.new(0, 10, 0, 10)
    welcomeMessage.BackgroundTransparency = 1
    welcomeMessage.Font = Enum.Font.SourceSans
    welcomeMessage.TextSize = 18
    welcomeMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeMessage.TextWrapped = true
    welcomeMessage.Text = "Hello👋, Thank you for using the script made by XΛYZ ƬΣCΉ.! 😄 And it's free to use! Enjoy using and trying it out 😄!."
    welcomeMessage.Parent = contentFrame

    local addScriptButton = Instance.new("TextButton")
    addScriptButton.Size = UDim2.new(0, 120, 0, 30)
    addScriptButton.Position = UDim2.new(1, -130, 0, 70)
    addScriptButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    addScriptButton.Text = "Add Script"
    addScriptButton.Font = Enum.Font.Code
    addScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    addScriptButton.Parent = contentFrame

    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -140, 0, 30)
    searchBox.Position = UDim2.new(0, 10, 0, 70)
    searchBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    searchBox.TextColor3 = Color3.fromRGB(0, 255, 0)
    searchBox.Font = Enum.Font.Code
    searchBox.PlaceholderText = "Search script..."
    searchBox.Parent = contentFrame

    local scriptList = Instance.new("ScrollingFrame")
    scriptList.Size = UDim2.new(1, -20, 1, -120)
    scriptList.Position = UDim2.new(0, 10, 0, 110)
    scriptList.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    scriptList.CanvasSize = UDim2.new(0, 0, 0, 0)
    scriptList.Parent = contentFrame
    
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 5)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = scriptList

    local function populate_scripts(filter)
        filter = filter and filter:lower() or ""
        for _, child in pairs(scriptList:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
        
        local count = 0
        for _, script_data in ipairs(combined_script_database) do
            if filter == "" or script_data.Name:lower():find(filter) then
                local scriptFrame = Instance.new("Frame")
                scriptFrame.Size = UDim2.new(1, 0, 0, 40)
                scriptFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                scriptFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
                scriptFrame.Parent = scriptList
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(0.5, 0, 1, 0)
                nameLabel.Position = UDim2.new(0, 10, 0, 0)
                nameLabel.Text = script_data.Name
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.Font = Enum.Font.SourceSans
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.BackgroundTransparency = 1
                nameLabel.Parent = scriptFrame
                
                local executeButton = Instance.new("TextButton")
                executeButton.Size = UDim2.new(0, 80, 0, 30)
                executeButton.Position = UDim2.new(1, -90, 0.5, -15)
                executeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                executeButton.Text = "Execute"
                executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                executeButton.Font = Enum.Font.Code
                executeButton.Parent = scriptFrame
                executeButton.MouseButton1Click:Connect(function() show_confirmation(script_data.Name, script_data.Code) end)
                
                local viewButton = Instance.new("TextButton")
                viewButton.Size = UDim2.new(0, 80, 0, 30)
                viewButton.Position = UDim2.new(1, -180, 0.5, -15)
                viewButton.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
                viewButton.Text = "View"
                viewButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                viewButton.Font = Enum.Font.Code
                viewButton.Parent = scriptFrame
                viewButton.MouseButton1Click:Connect(function() view_script(script_data.Name, script_data.Code) end)
                
                count = count + 1
            end
        end
        scriptList.CanvasSize = UDim2.new(0, 0, 0, (40 + 5) * count)
    end
    
    searchBox:GetPropertyChangedSignal("Text"):Connect(function() populate_scripts(searchBox.Text) end)
    
    addScriptButton.MouseButton1Click:Connect(function()
        add_script_popup(function(new_script)
            save_local_script(new_script)
            table.insert(combined_script_database, new_script)
            populate_scripts(searchBox.Text)
        end)
    end)

    populate_scripts()
end

function show_loading_screen_and_start()
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "XayzHub Loading..."
    loadingGui.ResetOnSpawn = false
    loadingGui.Parent = game.CoreGui
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.Parent = loadingGui
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0.5, -80)
    title.Text = "LOADING DATABASE..."
    title.TextColor3 = Color3.fromRGB(0, 255, 0)
    title.Font = Enum.Font.Code
    title.TextSize = 40
    title.BackgroundTransparency = 1
    title.Parent = background
    
    load_all_scripts()
    
    title.Text = "XΛYZ ƬΣCΉ HUB ( BETA TEST )"
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0.4, 0, 0, 30)
    progressBar.Position = UDim2.new(0.5, -progressBar.AbsoluteSize.X/2, 0.5, -15)
    progressBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    progressBar.BorderColor3 = Color3.fromRGB(0, 255, 0)
    progressBar.Parent = background
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    progressFill.Parent = progressBar
    local percentText = Instance.new("TextLabel")
    percentText.Size = UDim2.new(1, 0, 1, 0)
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(0, 0, 0)
    percentText.Font = Enum.Font.Code
    percentText.TextSize = 20
    percentText.BackgroundTransparency = 1
    percentText.Parent = progressFill
    
    progressFill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 1)
    for i = 0, 100 do percentText.Text = i .. "%"; wait(0.01) end
    loadingGui:Destroy()

    if check_key() then
        show_main_app()
    else

        local keyGui = Instance.new("ScreenGui")
        keyGui.Name = "XayzHub Key"
        keyGui.ResetOnSpawn = false
        keyGui.Parent = game.CoreGui
        local background = Instance.new("Frame")
        background.Size = UDim2.new(1, 0, 1, 0)
        background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        background.BackgroundTransparency = 0.7
        background.Parent = keyGui
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 400, 0, 200)
        mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
        mainFrame.Parent = background
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.Text = "Enter Key"
        title.TextColor3 = Color3.fromRGB(0, 255, 0)
        title.Font = Enum.Font.Code
        title.TextSize = 24
        title.BackgroundTransparency = 1
        title.Parent = mainFrame
        local keyBox = Instance.new("TextBox")
        keyBox.Size = UDim2.new(1, -20, 0, 40)
        keyBox.Position = UDim2.new(0, 10, 0, 50)
        keyBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        keyBox.TextColor3 = Color3.fromRGB(0, 255, 0)
        keyBox.Font = Enum.Font.Code
        keyBox.PlaceholderText = "Enter key here..."
        keyBox.Parent = mainFrame
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(1, -20, 0, 20)
        statusLabel.Position = UDim2.new(0, 10, 0, 95)
        statusLabel.Text = ""
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        statusLabel.Font = Enum.Font.SourceSans
        statusLabel.BackgroundTransparency = 1
        statusLabel.Parent = mainFrame
        local getKeyButton = Instance.new("TextButton")
        getKeyButton.Size = UDim2.new(0.45, 0, 0, 40)
        getKeyButton.Position = UDim2.new(0, 10, 1, -50)
        getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
        getKeyButton.Text = "Get Key"
        getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        getKeyButton.Font = Enum.Font.Code
        getKeyButton.Parent = mainFrame
        getKeyButton.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(KEY_WEBSITE_URL); statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0); statusLabel.Text = "Link disalin! Membuka website..." else statusLabel.Text = "Executor tidak mendukung setclipboard." end
            if identifyexecutor then pcall(identifyexecutor) end
        end)
        local submitButton = Instance.new("TextButton")
        submitButton.Size = UDim2.new(0.45, 0, 0, 40)
        submitButton.Position = UDim2.new(1, -10 - submitButton.AbsoluteSize.X, 1, -50)
        submitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        submitButton.Text = "Submit"
        submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        submitButton.Font = Enum.Font.Code
        submitButton.Parent = mainFrame
        submitButton.MouseButton1Click:Connect(function()
            if keyBox.Text == REQUIRED_KEY then
                save_key(keyBox.Text)
                keyGui:Destroy()
                show_main_app()
            else
                statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                statusLabel.Text = "Wrong key!"
            end
        end)
    end
end

show_loading_screen_and_start()
