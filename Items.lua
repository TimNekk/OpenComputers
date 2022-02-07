local component = require('component')
local gpu = component.gpu
local unicode = require('unicode')
local term = require('term')
local sides = require("sides")
local event = require("event")
local thread = require("thread")
 
local FPS = 0.5
 
local requiredItems = {}
requiredItems[#requiredItems+1] = {label = "Свинцовый блок", deposit = "Lead", size = "0", required = 4400, color = 0x7783AF, sing = {label = "Свинцовая сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Лазуритовый блок", deposit = "Lapis", size = "0", required = 4200, color = 0x234395, sing = {label = "Лазуритовая сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Никелевый блок", deposit = "Nickel", size = "0", required = 4600, color = 0xDED9A8, sing = {label = "Никелевая сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Медный блок", deposit = "Copper", size = "0", required = 4600, color = 0x9E6048, sing = {label = "Медная сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Железный блок", deposit = "Iron", size = "0", required = 4600, color = 0xE0E0E0, sing = {label = "Железная сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Редстоуновый блок", deposit = "Cinnabar", size = "0", required = 4800, color = 0xC9230B, sing = {label = "Редстоуновая сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Оловянный блок", deposit = "Cassiterite",  size = "0", required = 4600, color = 0xDBDFDF, sing = {label = "Оловянная сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Серебряный блок", deposit = "Silver", size = "0", required = 4400, color = 0x9CBEC7, sing = {label = "Серебряная сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Золотой блок", deposit = "Gold", size = "0", required = 4200, color = 0xFFF144, sing = {label = "Золотая сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Алмазный блок", deposit = "Coal", size = "0", required = 4200, color = 0x67BAAB, sing = {label = "Алмазная сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Изумрудный блок", deposit = "Coal", size = "0", required = 4200, color = 0x34C255, sing = {label = "Изумрудная сингулярность", size = "0"}}
requiredItems[#requiredItems+1] = {label = "Кварцевый блок", deposit = "Quarzite", size = "0", required = 4200, color = 0xEDEBE5, sing = {label = "Кварцевая сингулярность", size = "0"}}

-- Компоненты
local components = {redControllers = {quarry = {}, sing = {}}, MESystems = {}}

components.MESystems.main = {id = "b02e65dc-a363-4a2c-a90e-5b67be8c6338"}

components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "032af69f-72fc-4ae9-b6ae-a967ee2a015b"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "2b5f43ac-c34f-417f-b87a-1400636e535b"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "a30454c9-0032-46e2-b968-b149e3a38f9e"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "3aac7466-813c-43ae-b49a-1c1680b1b8d6"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "9e38a46c-5bbb-4fac-8364-0fa0b892a547"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "8cc871e7-5b34-4318-a0f6-76acc1f09bb3"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "dd402595-7ff1-4e6f-a7d6-0553c3af97f3"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "74ee8d02-9737-485e-9ae1-060831983a67"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "51bc4f54-14bb-450c-8f27-a5bc0691a354"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "ad69e0f4-5c1f-45ca-9c09-17b13e1bb13e"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "bc54363f-1158-40aa-81d4-e375f216793a"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "a9594429-73b5-44b5-8d73-41203fa2f835"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "661b9adf-c5e6-40d4-a717-a94718b1413f"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "1142a220-0d6e-40e8-8a72-d66d94813801"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "43c34150-c009-4df6-b794-dc469392ad25"}
components.redControllers.quarry[#components.redControllers.quarry+1] = {id = "e5fe1860-015e-4e33-80b4-66ce0957637c"}

components.redControllers.sing[#components.redControllers.sing+1] = {id = "e0a9ba66-9e0a-4a1c-9668-fea781872c5c", name = "Золотая сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "894169a0-0a71-4b6f-9a2a-55872cde9ffc", name = "Кварцевая сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "ca0a4549-82c2-4794-90bc-d80e305aea37", name = "Медная сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "e44723ac-d510-4267-857c-8070bac6d9da", name = "Свинцовая сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "68dd8b3c-306e-4e14-aa36-0aedd7fdd9ee", name = "Лазуритовая сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "3590f66e-fb94-4f6d-991e-8d5f54bdd1b5", name = "Железная сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "39661c10-5416-4c24-a1ab-94beff7072e2", name = "Оловянная сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "bf3fec28-ec6c-4ea6-bcf3-07b86977cce4", name = "Серебряная сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "89318e4e-0fdc-4322-878b-ea23d9652b56", name = "Алмазная сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "def98839-ea7d-49e5-a2fa-2187deb3dd34", name = "Никелевая сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "763a2985-01d1-46a0-b74e-dc5ffd19eaa5", name = "Редстоуновая сингулярность"}
components.redControllers.sing[#components.redControllers.sing+1] = {id = "de352611-7ad1-4b74-a1e4-d4df9ca1435c", name = "Изумрудная сингулярность"}


local colors = {black = 0x000000, white = 0xFFFFFF, green = 0x22FA00, red = 0xFF302E, grey = 0x131313, light_gray = 0x6E6E6E}

 
function getItems()
  local items = {}
 
  -- Все предметы
  local itemsInNetwork, err = component.proxy(components.MESystems.main.id).getItemsInNetwork()
 
  for _, requiredItem in pairs(requiredItems) do
    for i=1, #itemsInNetwork do
      local item = itemsInNetwork[i]
 
      -- Блок
      if item.label == requiredItem.label then
        requiredItem.size = tostring(item.size)
 
      -- Сингулярность
      elseif item.label == requiredItem.sing.label then
        requiredItem.sing.size = tostring(item.size)
      end
    end
    items[#items+1] = requiredItem
  end
 
 
  return items
end
 
 
function setSings(init, items)
  if init then
    -- Заполнение блока серым
    gpu.setBackground(colors.grey)
    gpu.fill(3, 2, gpu.getResolution()-4, #items+4, " ")
   
    -- Верх таблицы
    gpu.setForeground(colors.white)
    gpu.set(9, 3, "Название")
    gpu.set(30, 3, "Нужно")
    gpu.set(40, 3, "Имеется")
    gpu.set(50, 3, "Осталось")
    gpu.set(60, 3, "Создать")
    gpu.set(70, 3, "Сингул.")
    gpu.set(80, 3, "Жила")
  else
    -- Надписи
    for y, item in pairs(items) do
        -- Иконка блока
        gpu.setBackground(item.color)
        gpu.set(6, y+4, " ")
        gpu.set(7, y+4, " ")
        gpu.setBackground(colors.grey)
     
        local difference = item.required - tonumber(item.size)
        local canCreate = math.floor(tonumber(item.size) / item.required)
     
        if difference <= 0 then
          gpu.setForeground(colors.green)
          difference = 0
        else
          gpu.setForeground(colors.red)
        end
        gpu.set(9, y+4, item.label)  -- Название
        gpu.set(30, y+4, item.required .. "   ")  -- Нужно
        gpu.set(40, y+4, item.size:sub(1, #item.size-2) .. "   ")  -- Имеется
        gpu.set(50, y+4, tostring(difference):sub(1, #tostring(difference)-2) .. "   ")  -- Осталось
        gpu.set(60, y+4, tostring(canCreate) .. "   ")  -- Создать
     
        gpu.setForeground(colors.white)
        gpu.set(80, y+4, item.deposit)  -- Жила

        gpu.setBackground(colors.light_gray)
        gpu.set(95, y+4, 'Создать')
        gpu.setBackground(colors.grey)
     
        if item.sing.size == "0" then
          gpu.setForeground(colors.red)
        end

        gpu.set(70, y+4, item.sing.size:sub(1, #item.sing.size-2) .. "     ")  -- Сингулярностей
    end
  end
end


function setRedStones()
  -- Заполнение блока серым
  gpu.setForeground(colors.white)
  gpu.setBackground(colors.grey)
  gpu.fill(3, 19, gpu.getResolution()-4, 6, " ")

  local effeciency = 0
  for i, redController in pairs(components.redControllers.quarry) do
    redController = component.proxy(redController.id)

    -- Номер
    gpu.setBackground(colors.grey)
    gpu.set(1 + i*7, 20, tostring(i))

    -- Кнопки
    if redController.getOutput(sides.top) == 0 then
      gpu.setBackground(colors.red)
    else
      gpu.setBackground(colors.green)
      effeciency = effeciency + 1
    end
    gpu.fill(i*7, 22, 4, 2, " ")
  end

  -- Эффективность
  effeciency = math.floor(effeciency*145/60*10)/10
  gpu.setBackground(colors.grey)
  gpu.set(#components.redControllers.quarry*7 + 8, 20, "Скорость: " .. tostring(effeciency) .. " рес/сек     ")
end


function touchEventManager()
  while true do

    local _, _, x, y = event.pull("touch")
    gpu.set(1, 1, "x: " .. tostring(x) .. " y: " .. tostring(y) .. "        ")

    for i, redController in pairs(components.redControllers.quarry) do
      redController = component.proxy(redController.id)

      if x >= i*7  and x <= 3 + i*7 and y >= 22 and y <= 24 then
        if redController.getOutput(sides.top) == 0 then
          redController.setOutput(sides.top, 1)
          setRedStones()
        else
          redController.setOutput(sides.top, 0)
          setRedStones()
        end
      end
    end
  end
end

 
function start()
  term.clear()

  setRedStones()
  thread.create(touchEventManager)

  local items = getItems()
  local old_items
  setSings(true, items)

  while true do
    old_items = getItems()

    os.sleep(0.1)

    items = getItems(AE, requiredItems)
    if old_items ~= items then 
      setSings(false, items)
    end
  end
end
 
start()