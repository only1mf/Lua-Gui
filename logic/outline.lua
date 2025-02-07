local container = Instance.new("Folder", gethui())
local highlightActive = true
local Players = game:GetService("Players")

local function createOutline(character)
    -- Create an outline for the character
    local highlight = Instance.new("Highlight", container)
    highlight.FillColor = BrickColor.new(character.Parent.Name).Color
    highlight.FillTransparency = 0.5 -- Set transparency of the outline
    highlight.OutlineTransparency = 0
    highlight.DepthMode = "AlwaysOnTop"
    highlight.Adornee = character

    -- Destroy the outline when the character is destroyed
    character.Destroying:Connect(function()
        highlight:Destroy()
    end)

    return highlight
end

-- Function to enable outlines
function outline_enable()
    highlightActive = true
    for _, player in ipairs(Players:GetPlayers()) do
        player.CharacterAdded:Connect(function(character)
            if highlightActive then
                createOutline(character)
            end
        end)
    end

    -- Add outlines for players already in the game
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            createOutline(player.Character)
        end
    end
end

-- Function to disable outlines
function outline_disable()
    highlightActive = false
    for _, highlight in ipairs(container:GetChildren()) do
        if highlight:IsA("Highlight") then
            highlight.Enabled = false
        end
    end
end

-- Monitor new players joining the game
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if highlightActive then
            createOutline(character)
        end
    end)
end)
