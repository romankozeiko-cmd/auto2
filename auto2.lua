-- Настройки
local SLOT_NUMBER = 2 -- Номер слота (предмет под цифрой 2)

local player = game:GetService("Players").LocalPlayer

local function equipItem()
    -- Ждем появления персонажа и его гуманоида (важно для мобильных устройств)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid", 10)
    local backpack = player:WaitForChild("Backpack", 10)
    
    if not humanoid or not backpack then return end

    -- На телефонах задержка должна быть чуть больше для стабильности
    task.wait(1)
    
    -- Получаем список всех предметов в рюкзаке
    local items = backpack:GetChildren()
    
    -- Проверяем, есть ли предмет в нужном слоте
    if items[SLOT_NUMBER] then
        local item = items[SLOT_NUMBER]
        -- Экипируем предмет
        humanoid:EquipTool(item)
        print("Предмет '" .. item.Name .. "' экипирован.")
    else
        warn("Предмет в слоте " .. SLOT_NUMBER .. " не найден.")
    end
end

-- Запуск
task.spawn(equipItem)

-- Подписка на событие возрождения
player.CharacterAdded:Connect(function()
    equipItem()
end)
