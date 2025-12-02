local PLAYER_NAME_HERE = game.Players.LocalPlayer.Name
local AFFECTED_PARTS_FOLDER_NAME = "TornadoDebris"
local RADIUS = 150  
local STRENGTH = 3000  
local UPWARD_FORCE = 500 
local PULL_SPEED = 0.05    
local DAMAGE_PER_HIT = 15 
local KNOCKBACK_POWER = 5000   
local DURATION = 0.5  
local VISUAL_EFFECTS = true 

local DebrisService = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local function setupDebrisFolder()
    local folder = Workspace:FindFirstChild(AFFECTED_PARTS_FOLDER_NAME)
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = AFFECTED_PARTS_FOLDER_NAME
        folder.Parent = Workspace
    end
    return folder
end

local debrisFolder = setupDebrisFolder()

local function applyTornadoForce(part, targetPosition)
    if not part:IsA("BasePart") or part.Anchored or part:IsDescendantOf(debrisFolder) then
        return
    end

    if part:IsA("Part") or part:IsA("MeshPart") or part:IsA("WedgePart") then
        part.CanCollide = false 
        part.Massless = true 
    end

    if part.Parent ~= debrisFolder then
        part.Parent = debrisFolder
    end

    local partPosition = part.Position
    local direction = (targetPosition - partPosition).unit
    local distance = (targetPosition - partPosition).magnitude

    local pullForce = direction * STRENGTH * (1 / math.max(1, distance * PULL_SPEED))
    
    local upwardForce = Vector3.new(0, UPWARD_FORCE, 0)

    local bodyForce = part:FindFirstChild("TornadoForce")
    if not bodyForce then
        bodyForce = Instance.new("BodyForce")
        bodyForce.Name = "TornadoForce"
        bodyForce.Parent = part
    end

    bodyForce.Force = pullForce + upwardForce
end

local function affectOtherPlayer(targetCharacter, userHRP)
    local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")

    if not targetHRP or not targetHumanoid or targetHumanoid.Health <= 0 then
        return
    end

    if targetCharacter.Name == PLAYER_NAME_HERE then
        return
    end
    
    local direction = (targetHRP.Position - userHRP.Position).unit
    local knockbackVector = (direction * KNOCKBACK_POWER) + Vector3.new(0, KNOCKBACK_POWER * 0.5, 0)

    if not targetHRP:GetAttribute("IsKnocked") then
        targetHRP:SetAttribute("IsKnocked", true)
        
        targetHRP:ApplyImpulse(knockbackVector) -- Gunakan ApplyImpulse untuk dorongan instan
        targetHumanoid:TakeDamage(DAMAGE_PER_HIT)

        DebrisService:AddItem(targetHRP, DURATION)
        delay(DURATION, function()
            if targetHRP and targetHRP:GetAttribute("IsKnocked") then
                 targetHRP:SetAttribute("IsKnocked", false)
            end
        end)
    end
end

local function createVisualEffects(centerPart)
    if not VISUAL_EFFECTS then return end

    local effect = Instance.new("ParticleEmitter")
    effect.Color = ColorSequence.new(Color3.new(0.1, 0.1, 0.1), Color3.new(0.5, 0.5, 0.5))
    effect.Texture = "rbxassetid://474251214"
    effect.Size = NumberSequence.new(0.5, 3)
    effect.Rate = 50
    effect.Speed = NumberRange.new(5, 15)
    effect.Lifetime = NumberRange.new(0.5, 1.5)
    effect.SpreadAngle = Vector2.new(360, 360)
    effect.Shape = Enum.ParticleEmitterShape.Cylinder
    effect.EmissionDirection = Enum.ParticleEmissionDirection.In
    effect.LightEmission = 0.5
    effect.Transparency = NumberSequence.new(0, 1)

    effect.Parent = centerPart
end

local localPlayer = game.Players:FindFirstChild(PLAYER_NAME_HERE)
if not localPlayer or not localPlayer.Character then
    warn("Player or Character not found.")
    return
end

local userHRP = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not userHRP then
    warn("HumanoidRootPart tidak ditemukan.")
    return
end

createVisualEffects(userHRP)

local lastCleanupTime = tick()
game:GetService("RunService").Heartbeat:Connect(function(dt)
    local character = localPlayer.Character
    if not character or not character.Parent then return end

    userHRP = character:FindFirstChild("HumanoidRootPart")
    if not userHRP then return end
    
    local centerPosition = userHRP.Position -- Pusat topan adalah posisi user
    
    local partsInRadius = Workspace:GetPartsInPart(
        CFrame.new(centerPosition) * CFrame.Angles(0, 0, 0),
        Vector3.new(RADIUS * 2, RADIUS * 2, RADIUS * 2)
    )

    for _, part in ipairs(partsInRadius) do
        if part:IsDescendantOf(localPlayer.Character) then
            continue
        end

        local char = part.Parent
        if char and char:FindFirstChildOfClass("Humanoid") then
            affectOtherPlayer(char, userHRP)
            continue
        end
        
        if part:IsA("BasePart") and part.Anchored == false and part.CanCollide == true then
            applyTornadoForce(part, centerPosition)
        end
    end

    if tick() - lastCleanupTime > 5 then
        lastCleanupTime = tick()
        for _, part in ipairs(debrisFolder:GetChildren()) do
            if part:IsA("BasePart") then
                local distance = (part.Position - centerPosition).magnitude
                
                if distance > RADIUS * 2 and part:FindFirstChild("TornadoForce") then
                    part.CanCollide = true
                    part.Massless = false
                    part:FindFirstChild("TornadoForce"):Destroy()
                    part.Parent = Workspace
                end
            end
        end
    end
end)

print("Cheat Activate ✓:", RADIUS, "studs.")
