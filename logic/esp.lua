local ESP_Color = Color3.fromRGB(255, 0, 0) -- Red ESP
local ESP_Transparency = 0.5
local ESP_Size = UDim2.new(2, 0, 2, 0)

-- Function to create ESP for a character
local function createESP(playerModel)
    if not config.esp_enable then return end -- ESP is disabled, stop

    if playerModel:FindFirstChild("HumanoidRootPart") then
        local highlight = Instance.new("BillboardGui")
        highlight.Adornee = playerModel.HumanoidRootPart
        highlight.Size = ESP_Size
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
