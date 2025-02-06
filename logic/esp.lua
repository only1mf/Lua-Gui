local ESP_Color = Color3.fromRGB(255, 0, 0) -- Red ESP
local ESP_Transparency = 0.5
local ESP_Size = UDim2.new(2, 0, 2, 0)

local config = {
    esp_enabled = false, -- Set to true to enable ESP
}

-- Function to create ESP for a character
local function createESP(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        local highlight = Instance.new("BillboardGui")
        highlight.Adornee = obj.HumanoidRootPart
        highlight.Size = UDim2.new(2, 0, 2, 0)
        highlight.StudsOffset = Vector3.new(0, 2, 0)
        highlight.AlwaysOnTop = true
        highlight.Name = "ESP"

        local frame = Instance.new("Frame", highlight)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = ESP_Transparency
        frame.BackgroundColor3 = ESP_Color

        highlight.Parent = game.CoreGui
    end
end

-- Function to enable ESP
local function esp_enable()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            if not obj:FindFirstChild("ESP") then
                createESP(obj)
            end
        end
    end
end

-- Function to disable ESP
local function esp_disable()
    for _, obj in ipairs(game.CoreGui:GetChildren()) do
        if obj.Name == "ESP" then
            obj:Destroy()
        end
    end
end

-- Assign functions to config for external access
config.esp_enable = esp_enable
config.esp_disable = esp_disable

-- Listen for player spawn or character reset to add ESP to new players
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if config.esp_enabled then
            createESP(character)
        end
    end)
end)

-- Return config to be used in other scripts (if necessary)
return config
