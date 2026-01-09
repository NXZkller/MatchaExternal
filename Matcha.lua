--[[ 
    MATCHA V2 PRO - VERSION FINAL UNIFICADA
    Optimizado para Combate de Frutas, Espadas y Farm
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kavo"))()
local Window = Library.CreateLib("MATCHA V2 PRO - ULTIMATE", "DarkTheme")

-- Configuración Maestra
local Settings = {
    -- Combat
    Aimbot = false,
    SilentAim = false,
    HitboxSize = 12,
    FastAttack = false,
    -- Movement
    AntiStun = false,
    WalkSpeed = 16,
    Fly = false,
    -- Farm
    AutoFarm = false,
    AutoClick = false
}

-- PESTAÑA: COMBATE (Aimbot, Hitbox, Skills)
local Combat = Window:NewTab("Combat")
local CombatSection = Combat:NewSection("PVP & Skills")

CombatSection:NewSlider("Hitbox Scale", "Mejora Z/X de SoulGuitar, Portal, TTK", 30, 2, function(s)
    Settings.HitboxSize = s
end)

CombatSection:NewToggle("Hitbox Expander", "Afecta Cabeza y RootPart", function(state)
    _G.HitboxLoop = state
    spawn(function()
        while _G.HitboxLoop do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    pcall(function()
                        local head = v.Character:FindFirstChild("Head")
                        local root = v.Character:FindFirstChild("HumanoidRootPart")
                        if head then head.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize) head.Transparency = 0.7 head.CanCollide = false end
                        if root then root.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize) root.Transparency = 0.7 root.CanCollide = false end
                    end)
                end
            end
            task.wait(1)
        end
    end)
end)

CombatSection:NewToggle("Fast Attack", "Golpea más rápido con espadas", function(state)
    Settings.FastAttack = state
    local CombatLib = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    local CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
    spawn(function()
        while Settings.FastAttack do
            pcall(function()
                CombatLib.activeController.hitboxMagnitude = 55
                CombatLib.activeController.attackInterval = 0.1
                CameraShaker:Stop()
            end)
            task.wait()
        end
    end)
end)

-- PESTAÑA: MOVIMIENTO & ANTI-STUN
local Move = Window:NewTab("Movement")
local MoveSection = Move:NewSection("Físicas y Anti-Stun")

MoveSection:NewToggle("Anti-Stun", "Inmune a aturdimientos", function(state)
    Settings.AntiStun = state
    spawn(function()
        while Settings.AntiStun do
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
            task.wait(0.1)
        end
    end)
end)

MoveSection:NewSlider("Velocidad", "WalkSpeed", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- PESTAÑA: AUTO FARM
local Farm = Window:NewTab("Auto Farm")
local FarmSection = Farm:NewSection("Farming System")

FarmSection:NewToggle("Auto Clicker", "Click infinito", function(state)
    _G.Clicker = state
    spawn(function()
        while _G.Clicker do
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
            task.wait(0.05)
        end
    end)
end)

FarmSection:NewToggle("Auto Farm (Básico)", "Ataca enemigos cercanos", function(state)
    Settings.AutoFarm = state
    -- Aquí va la lógica de TP al enemigo que configuramos antes
end)

print("MATCHA V2 PRO TOTALMENTE CARGADO")
