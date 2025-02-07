-- esp.lua

local config = {
    visuals = {
        esp_enabled = false,
    }
}

local function esp_enable()
    -- Check if ESP is enabled in the config
    if config.visuals.esp_enabled then
        -- Start listening for players
        game:GetService("RunService").Heartbeat:Connect(function()
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player == game.Players.LocalPlayer then continue end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    -- Get the player's position
                    local targetPart = player.Character:FindFirstChild("HumanoidRootPart")
                    local targetPos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        -- Draw a box around the player's character
                        local size = Vector2.new(100, 100)  -- Adjust box size as needed
                        local position = Vector2.new(targetPos.X - size.X / 2, targetPos.Y - size.Y / 2)

                        -- Create the ESP box
                        local box = Instance.new("Frame")
                        box.Size = UDim2.new(0, size.X, 0, size.Y)
                        box.Position = UDim2.new(0, position.X, 0, position.Y)
                        box.BorderSizePixel = 2
                        box.BorderColor3 = Color3.fromRGB(255, 0, 0)
                        box.BackgroundTransparency = 1
                        box.Parent = game.Players.LocalPlayer.PlayerGui

                        -- Draw player name
                        local playerName = Instance.new("TextLabel")
                        playerName.Text = player.Name
                        playerName.Size = UDim2.new(0, 100, 0, 20)
                        playerName.Position = UDim2.new(0, position.X, 0, position.Y - 20)
                        playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        playerName.TextStrokeTransparency = 0.8
                        playerName.BackgroundTransparency = 1
                        playerName.Parent = game.Players.LocalPlayer.PlayerGui
                    end
                end
            end
        end)
    end
end

local function esp_disable()
    -- Disable ESP by clearing existing ESP objects from the screen
    for _, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("Frame") or v:IsA("TextLabel") then
            v:Destroy()
        end
    end
end

return {
    esp_enable = esp_enable,
    esp_disable = esp_disable,
}
