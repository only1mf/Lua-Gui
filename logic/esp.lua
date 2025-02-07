-- Add this section under the visuals tab in the UI

local player_list_mode = "All Players"  -- Default mode for retrieving players

-- Define different player list retrieval methods
local function getPlayers()
    local players = {}

    if player_list_mode == "All Players" then
        -- Get all players in the game
        players = game:GetService("Players"):GetPlayers()
    elseif player_list_mode == "Closest Players" then
        -- Get players sorted by distance from the local player
        local localPlayer = game:GetService("Players").LocalPlayer
        local allPlayers = game:GetService("Players"):GetPlayers()
        table.sort(allPlayers, function(a, b)
            local distanceA = (a.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            local distanceB = (b.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            return distanceA < distanceB
        end)
        players = allPlayers
    elseif player_list_mode == "Alive Players" then
        -- Filter only alive players
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                table.insert(players, player)
            end
        end
    end

    return players
end

-- Section to control the player list mode
visuals_section:CreateDropdown("Player List Mode", {"All Players", "Closest Players", "Alive Players"}, function(state)
    player_list_mode = state
end)

-- ESP section that applies Chams to selected players based on the selected mode
esp_sector:CreateToggle("Enable ESP", config.visuals.esp_enabled, function(state)
    config.visuals.esp_enabled = state
    if state then
        local players = getPlayers()
        for _, player in ipairs(players) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                createChams(player.Character)
            end
        end
    else
        esp_disable()  -- Call to disable Chams
    end
end)

-- Function to create Chams for a character (same as before)
local function createChams(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
        print("Creating Chams for: " .. obj.Name)  -- Debugging print
        local bodyParts = {"Head", "Torso", "LeftLeg", "RightLeg", "LeftArm", "RightArm"}

        for _, partName in ipairs(bodyParts) do
            local part = obj:FindFirstChild(partName)
            if part then
                local cham = Instance.new("MeshPart")
                cham.Size = part.Size
                cham.Position = part.Position
                cham.Anchored = true
                cham.CanCollide = false
                cham.Parent = game.CoreGui
                cham.Color = ESP_Color
                cham.Transparency = ESP_Transparency
                cham.CFrame = part.CFrame
            end
        end
    end
end

-- Function to disable Chams
local function esp_disable()
    for _, obj in ipairs(game.CoreGui:GetChildren()) do
        if obj.Name == "ESP" then
            obj:Destroy()
        end
    end
end
