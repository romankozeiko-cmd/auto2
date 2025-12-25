-- Настройки
local SLOT_NUMBER = 2 -- Номер слота (предмет под цифрой 2)

local player = game.Players.LocalPlayer

local function equipItem()
    -- Ждем появления персонажа и рюкзака
    local character = player.Character or player.CharacterAdded:Wait()
    local backpack = player:WaitForChild("Backpack")
    
    -- Небольшая задержка, чтобы игра успела прогрузить предметы после ресета
    task.wait(0.5)
    
    -- Получаем список всех предметов в рюкзаке
    local items = backpack:GetChildren()
    
    -- Проверяем, есть ли предмет в нужном слоте
    if items[SLOT_NUMBER] then
        local item = items[SLOT_NUMBER]
        -- Экипируем предмет (переносим из Backpack в Character)
        player.Character.Humanoid:EquipTool(item)
        print("Предмет '" .. item.Name .. "' автоматически экипирован.")
    else
        warn("Предмет в слоте " .. SLOT_NUMBER .. " не найден.")
    end
end

-- Запуск при первом выполнении скрипта
task.spawn(equipItem)

-- Подписка на событие возрождения (CharacterAdded)
player.CharacterAdded:Connect(function()
    equipItem()
end)
