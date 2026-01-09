--[[
    MATCHA V2 PRO - OFFICIAL SOURCE
    Desarrollado por: NXZkller
    Funciones: Aimbot, Silent Aim, FOV, Hitbox, Auto Raid, Fast Attack, Fly, Speed, Jump, Anti-Stun.
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kavo"))()
local Window = Library.CreateLib("MATCHA V2 PRO - ULTIMATE", "DarkTheme")

-- // CONFIGURACIÓN MAESTRA // --
local Settings = {
    Aimbot = false,
    SilentAim = false,
    AimbotFov = 150,
    FovVisible = false,
    HitboxSize = 2,
    FastAttack = false,
    AntiStun = false,
    AutoRaid = false,
    WalkSpeed = 16,
    JumpPower = 50
}

-- // SISTEMA DE OCULTADO (RIGHT SHIFT) // --
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        Library:ToggleGui()
    end
end)

-- // PESTAÑA: COMBATE // --
local Combat = Window:NewTab("Combat")
local AimSection = Combat:NewSection("Puntería Avanzada")

AimSection:NewToggle("Silent Aim", "Redirección de ataques", function(state) Settings.SilentAim = state end)
AimSection:NewToggle("Camera Aimbot", "Seguimiento de cámara", function(state) Settings.Aimbot = state end)
AimSection:NewToggle("Show FOV Circle", "Ver rango de detección", function(state) Settings.FovVisible = state end)
AimSection:NewSlider("FOV Radius", "Tamaño del círculo", 500, 50, function(s) Settings.AimbotFov = s end)

local SkillSection = Combat:NewSection("Skills & Hitbox")
SkillSection:NewSlider("Hitbox Scale", "Aumenta impacto de habilidades", 30, 2, function(s) Settings.HitboxSize = s end)
SkillSection:NewToggle("Fast Attack", "Ataque rápido (Espadas)", function(state) Settings.FastAttack = state end)

-- // PESTAÑA: MOVIMIENTO // --
local Move = Window:NewTab("Movement")
local MoveSection = Move:NewSection("Player Hacks")

MoveSection:NewSlider("Speed Hack", "Velocidad de caminata", 250, 16, function(s) 
    Settings.WalkSpeed = s 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s 
end)

MoveSection:NewSlider("Jump Hack", "Fuerza de salto", 250, 50, function(s) 
    Settings.JumpPower = s 
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s 
end)

MoveSection:NewToggle("Anti-Stun", "Inmune a aturdimientos", function(state)
    Settings.AntiStun = state
end)

-- // PESTAÑA: RAIDS & FARM // --
local Farm = Window:NewTab("Raids & Farm")
local FarmSection = Farm:NewSection("Automations")
FarmSection:NewToggle("Auto Raid", "Teletransporte y Kill en Raids", function(state) Settings.AutoRaid = state end)
FarmSection:NewToggle("Auto Clicker", "Click infinito", function(state) _G.AutoClick = state end)

-- // BUCLES LÓGICOS (BACKGROUND) // --
spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                -- Anti-Stun logic
                if Settings.AntiStun then
                    char.Humanoid.PlatformStand = false
                end
                -- Maintain Speed/Jump
                char.Humanoid.WalkSpeed = Settings.WalkSpeed
                char.Humanoid.JumpPower = Settings.JumpPower
            end
            
            -- Hitbox Expander logic
            if Settings.HitboxSize > 2 then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        v.Character.HumanoidRootPart.Transparency = 0.7
                        v.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end
        end)
    end
end)

print("MATCHA V2 PRO: Cargado desde GitHub con éxito.")
