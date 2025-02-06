local esp = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function create_esp_box(player)
    if not player or not player.Character then return end
    if player == LocalPlayer then return end -- Ignore yourself

    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character
    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red for enemies
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0) -- Black outline
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0

    return highlight
end

function esp.enable()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Team ~= LocalPlayer.Team then -- Only show enemies
            create_esp_box(player)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(1) -- Ensure character loads
            if player.Team ~= LocalPlayer.Team then
                create_esp_box(player)
            end
        end)
    end)
    print("[ESP] Enabled")
end

function esp.disable()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = player.Character:FindFirstChildOfClass("Highlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
    print("[ESP] Disabled")
end

return esp
