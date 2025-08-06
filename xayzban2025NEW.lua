if not game:IsLoaded() then
	game.Loaded:Wait()
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

pcall(function()
    local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ActivationNotice"
	screenGui.ResetOnSpawn = false

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 350, 0, 80)
	mainFrame.Position = UDim2.new(0.5, -175, 0, -100)
	mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	mainFrame.BackgroundTransparency = 0.1
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = mainFrame
	
	local iconLabel = Instance.new("TextLabel")
	iconLabel.Size = UDim2.new(0, 50, 0, 50)
	iconLabel.Position = UDim2.new(0, 15, 0.5, -25)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Font = Enum.Font.GothamBold
	iconLabel.Text = "🔔"
	iconLabel.TextSize = 40
	iconLabel.Parent = mainFrame
	
	local mainText = Instance.new("TextLabel")
	mainText.Size = UDim2.new(1, -80, 0, 30)
	mainText.Position = UDim2.new(0, 70, 0.5, -25)
	mainText.BackgroundTransparency = 1
	mainText.Font = Enum.Font.GothamBold
	mainText.Text = "Script By Xayz Tech Actived✅"
	mainText.TextColor3 = Color3.fromRGB(85, 255, 127)
	mainText.TextXAlignment = Enum.TextXAlignment.Left
	mainText.TextSize = 18
	mainText.Parent = mainFrame
	
	local subText = Instance.new("TextLabel")
	subText.Size = UDim2.new(1, -80, 0, 20)
	subText.Position = UDim2.new(0, 70, 0.5, 5)
	subText.BackgroundTransparency = 1
	subText.Font = Enum.Font.Gotham
	subText.Text = "YouTube: @xycoolcraft  TikTok: @xycoolcraft"
	subText.TextXAlignment = Enum.TextXAlignment.Left
	subText.TextSize = 14
	subText.Parent = mainFrame
	
	screenGui.Parent = player:WaitForChild("PlayerGui")

	mainFrame:TweenPosition(UDim2.new(0.5, -175, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.7, true)

	local runService = game:GetService("RunService")
	local connection = runService.RenderStepped:Connect(function()
		if not subText or not subText.Parent then return end
		local hue = tick() % 5 / 5
		subText.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
	end)

	task.wait(7)

	mainFrame:TweenPosition(UDim2.new(0.5, -175, 0, -100), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.7, true)
	
	task.wait(1)
	connection:Disconnect()
	screenGui:Destroy()
end)

local tool = Instance.new("Tool")
tool.Name = "LocalKickHammer"
tool.ToolTip = "Click or tap to Kick or kick Player Out of the game!"
tool.RequiresHandle = true
tool.TextureId = "rbxassetid://9756243414" 
local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1, 3, 1)
handle.BrickColor = BrickColor.new("Cyan")
handle.Parent = tool

tool.Activated:Connect(function()
	local mouse = player:GetMouse()
	local target = mouse.Target

	if not target then return end

	local targetModel = target:FindFirstAncestorWhichIsA("Model")
	if not targetModel then return end
	
	local targetPlayer = game.Players:GetPlayerFromCharacter(targetModel)
	if targetPlayer and targetPlayer ~= player then
		print("Menghilangkan " .. targetPlayer.Name .. " dari layar Anda.")
		targetModel:Destroy() 
	end
end)

tool.Parent = player.Backpack
print("Kick Hammer has been awarded!")
