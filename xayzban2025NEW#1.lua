local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local masterKickHammer

local function createKickHammer()
	print("Membuat item KickHammer untuk pertama kali...")
	
	local tool = Instance.new("Tool")
	tool.Name = "KickHammer"
	tool.ToolTip = "Gunakan untuk menendang pemain lain."
	tool.RequiresHandle = true
	
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1.2, 4, 1.2)
	handle.BrickColor = BrickColor.new("Bright blue")
	handle.Material = Enum.Material.Plastic
	handle.Parent = tool
	
	local hammerLogicScript = Instance.new("Script")
	hammerLogicScript.Name = "HammerLogic"
	
	hammerLogicScript.Source = [[
		local tool = script.Parent
		local handle = tool.Handle
		
		local debounce = false

		handle.Touched:Connect(function(hit)
			if debounce then return end
			
			local targetModel = hit:FindFirstAncestorWhichIsA("Model")
			if not targetModel then return end
			
			local targetPlayer = game.Players:GetPlayerFromCharacter(targetModel)
			local player = game.Players:GetPlayerFromCharacter(tool.Parent)

			if not targetPlayer or not player or targetPlayer == player then
				return 
			end

			debounce = true
			
			print("Ban Hammer Has been bannedt: " .. targetPlayer.Name)
			targetPlayer:Kick("You have been kicked from the server by another player.")
			
			wait(1)
			debounce = false
		end)
	]]
	
	hammerLogicScript.Parent = tool
	
	print("Ban Hammer Successfull Create ✓.")
	return tool
end


local function handlePlayerJoin(player)
	
	print("Memberikan Kick Hammer kepada: " .. player.Name)
	if masterKickHammer then
		masterKickHammer:Clone().Parent = player.Backpack
	end
	
	local notificationScript = Instance.new("LocalScript")
	notificationScript.Name = "NotificationUI_Loader"
	
	notificationScript.Source = [[
		wait(3)

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
		
		screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

		mainFrame:TweenPosition(UDim2.new(0.5, -175, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.7, true)

		local runService = game:GetService("RunService")
		local connection = runService.RenderStepped:Connect(function()
			if not subText or not subText.Parent then return end
			local hue = tick() % 5 / 5
			subText.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
		end)

		wait(7)

		mainFrame:TweenPosition(UDim2.new(0.5, -175, 0, -100), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.7, true)
		
		wait(1)
		connection:Disconnect()
		screenGui:Destroy()
	]]
	
	
masterKickHammer = createKickHammer()

Players.PlayerAdded:Connect(handlePlayerJoin)

for _, player in ipairs(Players:GetPlayers()) do
	handlePlayerJoin(player)
end

print("Script Kick Hammer (Tanpa DataStore) telah aktif dan berjalan.")
