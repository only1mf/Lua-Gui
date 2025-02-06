local ESP_Color = Color3.fromRGB(255, 0, 0) -- Red Chams
local ESP_Transparency = 0.5 -- Transparency of the Chams
local config = {
    esp_enabled = false, -- Set to true to enable Chams
}

-- Function to apply Chams to a character
local function createChams(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        print("Creating Chams for: " .. obj.Name) -- Debugging print
        local bodyParts = {"Head", "Torso", "LeftLeg", "RightLeg", "LeftArm", "RightArm"}
        
        for _, partName in ipairs(bodyParts) do
            local part = obj:FindFirstChild(partName)
            if part then
                print("Found part: " .. partName) -- Debugging print

                local cham = Instance.new("MeshPart") -- Using MeshPart for Chams
                cham.Size = part.Size
                cham.Position = part.Position
                cham.Anchored = true
                cham.CanCollide = false
                cham.Parent = game.CoreGui

                cham.Color = ESP_Color
                cham.Transparency = ESP_Transparency

                -- Set part position to match the character
                cham.CFrame = part.CFrame
                print("Chams created for part: " .. partName) -- Debugging print
            else
                print("Part not found: " .. partName) -- Debugging print if part is missing
            end
        end
    else
        print("Skipping: " .. obj.Name .. " (not a valid character model)") -- Debugging print for invalid models
    end
end

-- Function to enable Chams
local function esp_enable()
    print("Enabling Chams...") -- Debugging print
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            if not obj:FindFirstChild("ESP") then
                print("Creating Chams for: " .. obj.Name) -- Debugging print
                createChams(obj)
            end
        end
    end
end

-- Function to disable Chams
local function esp_disable()
    print("Disabling Chams...") -- Debugging print
    for _, obj in ipairs(game.CoreGui:GetChildren()) do
        if obj.Name == "ESP" then
            print("Removing Chams: " .. obj.Name) -- Debugging print
            obj:Destroy()
        end
    end
end

-- Assign functions to config for external access
config.esp_enable = esp_enable
config.esp_disable = esp_disable

-- Listen for player spawn or character reset to add Chams to new players
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        print("Character added: " .. character.Name) -- Debugging print
        if config.esp_enabled then
            createChams(character)
        end
    end)
end)

-- Return config to be used in other scripts (if necessary)
return config
