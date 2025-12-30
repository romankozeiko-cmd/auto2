-- Настройки
local NAMES = {"Вес", "Weight"} -- Проверит оба варианта
local player = game:GetService("Players").LocalPlayer

local function getTool()
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return nil end
    for _, name in pairs(NAMES) do
        local tool = backpack:FindFirstChild(name)
        if tool then return tool end
    end
    return nil
end

local function setupEquip(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if not humanoid then return end

    -- Функция для взятия в руки
    local function doEquip()
        local tool = getTool()
        if tool then
            humanoid:EquipTool(tool)
        end
    end

    -- Берем сразу
    task.wait(1) -- Пауза для прогрузки инвентаря на телефоне
    doEquip()

    -- Если предмет выпал из рук или его убрали — возвращаем
    character.ChildRemoved:Connect(function(child)
        for _, name in pairs(NAMES) do
            if child.Name == name then
                task.wait(0.1) -- Короткая пауза для стабильности
                doEquip()
                break
            end
        end
    end)
end

-- Следим за персонажем (после ресета)
player.CharacterAdded:Connect(setupEquip)

-- Запуск для текущего персонажа
if player.Character then
    setupEquip(player.Character)
end

