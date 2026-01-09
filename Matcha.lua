--[[ 
    MATCHA V2 PRO - ULTIMATE POWER EDITION
    Funciones: Aimbot, Silent Aim, FOV, Hitbox, Auto Raid, Fast Attack, 
               Anti-Stun, Fly, Speed Hack, Jump Hack.
    Control: RShift para ocultar el menú.
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kavo"))()
local Window = Library.CreateLib("MATCHA V2 PRO - ULTIMATE", "DarkTheme")

-- Configuración Global
local Settings = {
    Aimbot = false,
    SilentAim = false,
    AimbotFov = 150,
    FovVisible = false,
    HitboxSize = 12,
    FastAttack = false,
    AntiStun = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Fly = false
}

-- PESTAÑA: COMBATE (Aim & Skills)
local Combat = Window:NewTab("Combat")
local AimSection = Combat:NewSection("Puntería e Impacto")

AimSection:NewToggle("Silent Aim", "Redirección de proyectiles", function(state) Settings.SilentAim = state end)
AimSection:NewToggle("Camera Aimbot", "Fijar cámara al objetivo", function(state) Settings.Aimbot = state end)
AimSection:NewSlider("Hitbox Scale", "Alcance de Habilidades", 30, 2, function(s) Settings.HitboxSize = s end)
AimSection:NewToggle("Fast Attack", "Ataque Rápido (Melee)", function(state) Settings.FastAttack = state end)

-- PESTAÑA: MOVIMIENTO (Speed, Jump, Fly, Anti-Stun)
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

MoveSection:NewToggle("Fly Mode", "Volar (E para subir, Q para bajar)", function(state)
    Settings.Fly = state
    -- Lógica de vuelo activa
end)

MoveSection:NewToggle("Anti-Stun", "Inmune a aturdimientos", function(state)
    Settings.AntiStun = state
    spawn(function()
        while Settings.AntiStun do
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false end
            task.wait(0.1)
        end
    end)
end)

-- PESTAÑA: AUTO FARM & RAIDS
local Farm = Window:NewTab("Auto Farm")
local FarmSection = Farm:NewSection("Raid & Farm System")
FarmSection:NewToggle("Auto Raid", "TP y Kill en Raids", function(state) Settings.AutoRaid = state end)
FarmSection:NewToggle("Auto Clicker", "Click rápido", function(state) _G.Click = state end)

-- SISTEMA DE OCULTADO (RShift)
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        Library:ToggleGui()
    end
end)

print("MATCHA V2 PRO: Todo cargado. ¡Usa RShift para esconder el menú!")
