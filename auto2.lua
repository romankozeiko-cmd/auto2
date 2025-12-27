-- Настройки
local ITEM_NAME = "Combat" -- Название предмета

local player = game:GetService("Players").LocalPlayer

local function equipCombat()
    -- Ожидание персонажа и его гуманоида (нужно для всех устройств)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid", 15)
    local backpack = player:WaitForChild("Backpack", 15)
    
    if not humanoid or not backpack then return end

    -- Пауза 1 секунда: на ПК это гарантирует прогрузку инвентаря, 
    -- на телефоне — стабильность при низком FPS
    task.wait(1)
    
    -- Пытаемся найти предмет в рюкзаке
    local item = backpack:FindFirstChild(ITEM_NAME)
    
    -- Если предмет найден и он не в руках — экипируем
    if item and item:IsA("Tool") then
        humanoid:EquipTool(item)
        print("Combat экипирован")
    end
end

-- Запуск при старте
task.spawn(equipCombat)

-- Авто-экипировка после каждого возрождения (работает и на ПК, и на мобилках)
player.CharacterAdded:Connect(function()
    equipCombat()
end)
