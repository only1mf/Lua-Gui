local config = {
    aimbot = {
        aim = false,
        a_target_part = "head",
        a_hit_chance = 100,
        a_field_of_view = false,
        a_field_of_view_range = 180,
    },
    silent = {
        silent_aim = false,
        s_target_part = "head",
        s_hit_chance = 100,
        s_field_of_view = false,
        s_field_of_view_range = 180,
    },
    visuals = {
        esp_enabled = false,
        outline_enabled = false,
    },
    gunmod = {
        fast_reload = false,
        fast_equip = false,
    },
    character = {
        walkspeed = false,
        jumppower = false,
        auto_deploy = false,
        fake_lag = false,
        fake_lag_limit = 15,
        antiaim = false,
        antiaim_stance = "stand",
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/only1mf/Lua-Gui/refs/heads/main/lib.lua"))()

-- local aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/only1mf/Lua-Gui/refs/heads/main/logic/aimbot.lua"))()
-- local silent = loadstring(game:HttpGet("https://raw.githubusercontent.com/only1mf/Lua-Gui/refs/heads/main/logic/silent.lua"))()
local esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/only1mf/Lua-Gui/refs/heads/main/logic/esp.lua"))()
local outline = loadstring(game:HttpGet("https://raw.githubusercontent.com/only1mf/Lua-Gui/refs/heads/main/logic/outline.lua"))()

local window = library:CreateWindow({
    WindowName = "Normality.cc - v1.0.0",
    Color = Color3.fromRGB(98, 24, 150) -- Normality.cc deep purple
}, game.CoreGui)

local aimbot_tab = window:CreateTab("Aimbot")
local visuals_tab = window:CreateTab("Visuals")
local character_tab = window:CreateTab("Character")
local misc_tab = window:CreateTab("Misc")
local menu_tab = window:CreateTab("Menu")

-- Aimbot section
local aimbot_sector = aimbot_tab:CreateSection("Aimbot")
aimbot_sector:CreateToggle("enabled", config.aimbot.aim, function(state)
    config.aimbot.aim = state
end)
aimbot_sector:CreateDropdown("hit part", {"head", "torso"}, function(state)
    config.aimbot.a_target_part = state
end)
aimbot_sector:CreateSlider("hit chance %", 0, 100, config.aimbot.a_hit_chance, true, function(state)
    config.aimbot.a_hit_chance = state
end)

-- FOV section
local fieldofview_sector = aimbot_tab:CreateSection("FOV")
fieldofview_sector:CreateToggle("enabled", config.aimbot.a_field_of_view, function(state)
    config.aimbot.a_field_of_view = state
end)
fieldofview_sector:CreateSlider("range", 0, 360, config.aimbot.a_field_of_view_range, true, function(state)
    config.aimbot.a_field_of_view_range = state
end)

-- Silent Aim section
local silentaim_sector = aimbot_tab:CreateSection("Silent Aim")
silentaim_sector:CreateToggle("enabled", config.silent.silent_aim, function(state)
    config.silent.silent_aim = state
end)
silentaim_sector:CreateDropdown("hit part", {"head", "torso"}, function(state)
    config.silent.s_target_part = state
end)
silentaim_sector:CreateSlider("hit chance %", 0, 100, config.silent.s_hit_chance, true, function(state)
    config.silent.s_hit_chance = state
end)
silentaim_sector:CreateSlider("range", 0, 360, config.silent.s_field_of_view_range, true, function(state)
    config.silent.s_field_of_view_range = state
end)

local esp_sector = visuals_tab:CreateSection("ESP")
esp_sector:CreateToggle("Enable ESP", config.visuals.esp_enabled, function(state)
    config.visuals.esp_enabled = state
    if state then
        esp.esp_enable()  -- Call esp_enable function from esp.lua
    else
        esp.esp_disable() -- Call esp_disable function from esp.lua
    end
end)

local outline_sector = visuals_tab:CreateSection("Outline")
outline_sector:CreateToggle("Enable Outline", config.visuals.esp_enabled, function(state)
    config.visuals.esp_enabled = state
    if state then
        outline.outline_enable()  -- Call outline_enable function from outline.lua
    else
        outline.outline_disable() -- Call outline_disable function from outline.lua
    end
end)

-- Gun Mods section
local gunmod_sector = aimbot_tab:CreateSection("Gun Mods")
gunmod_sector:CreateToggle("fast reload", config.gunmod.fast_reload, function(state)
    config.gunmod.fast_reload = state
end)
gunmod_sector:CreateToggle("fast equip", config.gunmod.fast_equip, function(state)
    config.gunmod.fast_equip = state
end)

-- Movement Mods section (Character tab)
local movement_sector = character_tab:CreateSection("Character Mods")
movement_sector:CreateToggle("walkspeed", config.character.walkspeed, function(state)
    config.character.walkspeed = state
end)
movement_sector:CreateToggle("jumppower", config.character.jumppower, function(state)
    config.character.jumppower = state
end)
movement_sector:CreateToggle("auto deploy", config.character.auto_deploy, function(state)
    config.character.auto_deploy = state
end)
movement_sector:CreateToggle("fake lag", config.character.fake_lag, function(state)
    config.character.fake_lag = state
end)

-- Settings section
local settings_sector = character_tab:CreateSection("Settings")
settings_sector:CreateSlider("walkspeed amount", 0, 100, 35, true, function(state)
    config.character.walkspeed = state
end)
settings_sector:CreateSlider("jumppower amount", 0, 100, 35, true, function(state)
    config.character.jumppower = state
end)

-- Anti-Aim section
local antiaim_sector = character_tab:CreateSection("Anti-Aim")
antiaim_sector:CreateToggle("enabled", config.character.antiaim, function(state)
    config.character.antiaim = state
end)
antiaim_sector:CreateDropdown("stance type", {"prone", "crouch", "stand"}, function(state)
    config.character.antiaim_stance = state
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Xenira",
    Text = "mY mUsCleS ArE gEtTinG bIGeR - Ur stong now papi",
    Duration = 8
})

-- Debugging to check if sections are created properly
print("Normality: Sections created successfully!")
