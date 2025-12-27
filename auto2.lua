-- Настройки
local ITEM_NAME = "Combat" 

local player = game:GetService("Players").LocalPlayer

local function equipLoop()
    while true do
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local backpack = player:FindFirstChild("Backpack")
            
            -- Проверяем, нет ли уже предмета в руках
            if not character:FindFirstChild(ITEM_NAME) then
                -- Если нет в руках, ищем в рюкзаке
                if backpack then
                    local item = backpack:FindFirstChild(ITEM_NAME)
                    if item and humanoid then
                        humanoid:EquipTool(item)
                    end
                end
            end
        end
        -- Проверка каждые 2 секунды (не лагает и гарантирует результат)
        task.wait(2)
    end
end

-- Запуск цикла в отдельном потоке
task.spawn(equipLoop)
