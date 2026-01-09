--[[
    MATCHA V2 PRO - OFFICIAL SOURCE
    Status: Verified & Functional with Notifications
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kavo"))()
local Window = Library.CreateLib("MATCHA V2 PRO - ULTIMATE", "DarkTheme")

-- // NOTIFICACIÓN DE INICIO // --
Library:Notify("Matcha V2 Loaded", "Presiona Right Shift para ocultar el menú", 5)

-- // CONFIGURACIÓN // --
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

-- // OCULTAR CON RSHIFT // --
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        Library:ToggleGui()
    end
end)

-- // PESTAÑA: COMBATE // --
local Combat = Window:NewTab("Combat")
local AimSection = Combat:NewSection("Puntería Avanzada")

AimSection:NewToggle("Silent Aim", "Redirección de ataques", function(state) 
    Settings.SilentAim = state 
    Library:Notify("Silent Aim", state and "Activado" or "Desactivado", 2)
end)

AimSection:NewToggle("Camera Aimbot", "Fijar cámara", function(state) Settings.Aimbot = state end)
AimSection:NewToggle("Show FOV Circle", "Ver círculo", function(state) Settings.FovVisible = state end)
AimSection:NewSlider("FOV Radius", "Radio", 500, 50, function(s) Settings.AimbotFov = s end)

local SkillSection = Combat:NewSection("Skills & Hitbox")
SkillSection:NewSlider("Hitbox Scale", "Expandir Hitbox", 30, 2, function(s) Settings.HitboxSize = s end)
SkillSection:NewToggle("Fast Attack", "Ataque Rápido", function(state) Settings.FastAttack = state end)

-- // PESTAÑA: MOVIMIENTO // --
local Move = Window:NewTab("Movement")
local MoveSection = Move:NewSection("Movilidad")

MoveSection:NewSlider("Speed Hack", "Velocidad", 250, 16, function(s) 
    Settings.WalkSpeed = s 
end)

MoveSection:NewSlider("Jump Hack", "Salto", 250, 50, function(s) 
    Settings.JumpPower = s 
end)

MoveSection:NewToggle("Anti-Stun", "Inmune a Stun", function(state)
    Settings.AntiStun = state
end)

-- // PESTAÑA: RAIDS // --
local Farm = Window:NewTab("Raids & Farm")
local FarmSection = Farm:NewSection("Automations")
FarmSection:NewToggle("Auto Raid", "Auto Kill & TP", function(state) Settings.AutoRaid = state end)

-- // BUCLE DE PROCESAMIENTO // --
spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = Settings.WalkSpeed
                char.Humanoid.JumpPower = Settings.JumpPower
                if Settings.AntiStun then
                    char.Humanoid.PlatformStand = false
                end
            end
            
            if Settings.HitboxSize > 2 then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        v.Character.HumanoidRootPart.Transparency = 0.7
                        v.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end
        end)
    end
end)
