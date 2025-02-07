-- esp.lua for executor environment

local config = {
    visuals = {
        esp_enabled = false,
    }
}

local function esp_enable()
    -- Only proceed if ESP is enabled in config
    if config.visuals.esp_enabled then
        -- Listen to Heartbeat to update the ESP
        game:GetService("RunService").Heartbeat:Connect(function()
            -- Get all players in the game
            local players = game:GetService("Players"):GetPlayers()

            for _, player in ipairs(players) do
                -- Skip if the player is the local player
                if player == game.Players.LocalPlayer then continue end

                -- Make sure the player's character exists and has the necessary part
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local targetPart = character:FindFirstChild("HumanoidRootPart")

                    -- Check if the part is visible on screen
                    local camera = game:GetService("Workspace").CurrentCamera
                    local targetPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)

                    if onScreen then
                        -- Create ESP box and player name
                        local size = Vector2.new(100, 100)  -- Box size
                        local position = Vector2.new(targetPos.X - size.X / 2, targetPos.Y - size.Y / 2)

                        -- Create a box around the character
                        local box = Instance.new("Frame")
                        box.Size = UDim2.new(0, size.X, 0, size.Y)
                        box.Position = UDim2.new(0, position.X, 0, position.Y)
                        box.BorderSizePixel = 2
                        box.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Red box
                        box.BackgroundTransparency = 1
                        box.Parent = game.Players.LocalPlayer.PlayerGui

                        -- Add player name label
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
    -- Disable ESP by clearing all ESP-related GUI elements
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
