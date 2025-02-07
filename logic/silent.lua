-- silentaim.lua

-- Configuration access for silent aim settings
local config = require(game.ReplicatedStorage:WaitForChild("config"))  -- Assuming config is stored here, update path as needed

-- Function to get players within the field of view and target them based on selected options
local function getTarget()
    local players = game:GetService("Players"):GetPlayers()
    local target = nil
    local maxFov = config.silent.s_field_of_view_range
    local closestDist = math.huge
    
    for _, player in ipairs(players) do
        if player == game.Players.LocalPlayer then continue end
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then continue end

        -- Calculate distance
        local targetPart = player.Character:FindFirstChild(config.silent.s_target_part)
        if targetPart then
            local dist = (targetPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist < closestDist and (config.silent.s_field_of_view and dist <= maxFov) then
                closestDist = dist
                target = player
            end
        end
    end
    return target
end

-- Function to perform the silent aimbot logic
local function silentAim()
    if config.silent.silent_aim then
        local target = getTarget()
        if target then
            -- Perform a silent aim (adjust aim to target without the player seeing it)
            local targetPart = target.Character:FindFirstChild(config.silent.s_target_part)
            if targetPart then
                local targetPosition = targetPart.Position
                -- Smooth aiming logic here, or just directly set the CFrame
                -- For silent aim, we would manipulate the camera or torso aim directly
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            end
        end
    end
end

-- Return the silentAim function to be used in the main script
return {
    silentAim = silentAim,
    getTarget = getTarget
}
