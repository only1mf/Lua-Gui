local ESP_Color = Color3.fromRGB(255, 0, 0) -- Red ESP
local ESP_Transparency = 0.5
local ESP_Size = UDim2.new(2, 0, 2, 0)

local config = {
    esp_enable = false, -- Set to true to enable ESP
}

-- Function to create ESP for a character
local function esp_enable()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            if not obj:FindFirstChild("ESP") then
                local highlight = Instance.new("BillboardGui")
                highlight.Adornee = obj.HumanoidRootPart
                highlight.Size = UDim2.new(2, 0, 2, 0)
                highlight.StudsOffset = Vector3.new(0, 2, 0)
                highlight.AlwaysOnTop = true
                highlight.Name = "ESP"

                local frame = Instance.new("Frame", highlight)
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundTransparency = 0.5
                frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red ESP

                highlight.Parent = game.CoreGui
            end
        end
    end
end

local function esp_disable()
    for _, obj in ipairs(game.CoreGui:GetChildren()) do
        if obj.Name == "ESP" then
            obj:Destroy()
        end
    end
end

-- Assign functions to config
config.esp_enable = esp_enable
config.esp_disable = esp_disable


-- Function to scan for players
local function scanPlayers()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            if not obj:FindFirstChild("ESP") then
                createESP(obj)
            end
        end
    end
end

-- Main loop to update ESP
while true do
    if config.esp_enable then
        scanPlayers()
    else
        for _, obj in ipairs(game.CoreGui:GetChildren()) do
            if obj.Name == "ESP" then
                obj:Destroy() -- Remove ESP when disabled
            end
        end
    end
    wait(1)
end
