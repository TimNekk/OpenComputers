local robot = require("robot")

local towers = {}
towers[1] = {x = 3, y = 3, r = 7, farmBlocks = 36, groundBlocks = 168, name = "Маленький"}
towers[2] = {x = 4, y = 3, r = 9, farmBlocks = 48, groundBlocks = 270, name = "Средне-маленький"}
towers[3] = {x = 4, y = 4, r = 9, farmBlocks = 64, groundBlocks = 288, name = "Средний"}
towers[4] = {x = 5, y = 3, r = 11, farmBlocks = 60, groundBlocks = 379, name = "Средне-большой"}
towers[5] = {x = 5, y = 4, r = 11, farmBlocks = 80, groundBlocks = 419, name = "Средне-большой (увелич.)"}
towers[6] = {x = 5, y = 5, r = 11, farmBlocks = 100, groundBlocks = 440, name = "Большой"}

function getUserTower()
  print("\nРазмеры ферм:")
  for i, tower in pairs(towers) do
    print(i .. ") " .. tower.name .. " (" .. tower.x .. "x" .. tower.y .. "x4) Площадь рассадки: " .. tower.groundBlocks)
  end

  print("\nВведите номер фермы:")
  return towers[tonumber(io.read())]
end

function getBlocksStatus(tower)
    if tower.farmBlocks < 65 then
      print("\nПоложите БЛОКИ ФЕРМЫ (" .. tower.farmBlocks .. ") в 1-ый слот")
  else
      print("\nПоложите БЛОКИ ФЕРМЫ (" .. tower.farmBlocks .. ") в 1-ый и 2-ой слоты")
  end

  print("Положите БЛОКИ ПОВЕРХНОСТИ (" .. tower.groundBlocks .. ") начиная с 3-его и в последующие слоты")

  print("\nВсе блоки на месте? [y/n]")

  if io.read() == "y" then
    local blocks = 0
    for i=1, robot.inventorySize() do
      blocks = blocks + robot.count(i)
    end

    if blocks >= tower.farmBlocks + tower.groundBlocks then
      return true
    else
        return 'restart'
    end
  else
    return false
  end
end



function buildTower(tower)
  print("\n -- Начинаю строительство башни -- ")

  robot.select(1)
  robot.up()

  turn = "right"

  for z=1, 4 do

    for y=1, tower.y do

      for x=1, tower.x do
        chechInventory()
        robot.placeDown()
        if x ~= tower.x then
          robot.forward()
        end
      end

      if y ~= tower.y then
        if turn == "right" then
          robot.turnRight()
          robot.forward()
          robot.turnRight()
          turn = "left"
        elseif turn == "left" then
          robot.turnLeft()
          robot.forward()
          robot.turnLeft()
          turn = "right"
        end
      end
    end

    if z ~= 4 then
      robot.up()
      robot.turnAround()
    end
  end
  print("\n -- Cтроительство башни завершено -- \n")
end


function buildPlatform(tower)
  print("\n -- Начинаю строительство платформы -- ")

  robot.select(3)

  
  robot.forward()
  buildPlatformPart(tower.r, tower.y, false)
  buildPlatformPart(tower.r, tower.x, true)
  buildPlatformPart(tower.r, tower.y, true)
  buildPlatformPart(tower.r, tower.x, true)

  for i=1, tower.r + 1 do
    robot.forward()
  end

  print("\n -- Cтроительство платформы завершено -- \n")
end


function buildPlatformPart(radius, length, inverted)
  
  -- Переменные
  if inverted == true then
    turn = "right"

    if length % 2 == 0 then
      skipOneBlock = true
    else
      skipOneBlock = false
    end
  else
    turn = "left"

    if length % 2 == 0 then
      skipOneBlock = false
    else
      skipOneBlock = true
    end
  end

-- Прямоугольник

  for l=1, length do
    for r=1, radius do
      chechInventory()
      robot.placeDown()
      if r ~= radius then
        robot.forward()
      end
    end

    if l ~= length then
      if turn == "right" then
        robot.turnRight()
        robot.forward()
        robot.turnRight()
        turn = "left"
      elseif turn == "left" then
        robot.turnLeft()
        robot.forward()
        robot.turnLeft()
        turn = "right"
      end
    end
  end

  -- Лесенка

  for rr=1, radius do
    if turn == "right" then
      robot.turnRight()
      robot.forward()
      robot.turnRight()
      turn = "left"
    elseif turn == "left" then
      robot.turnLeft()
      robot.forward()
      robot.turnLeft()
      turn = "right"
    end

    if skipOneBlock == true then
      robot.forward()
      skipOneBlock = false
    else
      skipOneBlock = true
    end

    for r=1, radius - rr do
      chechInventory()
      robot.placeDown()
      if r ~= radius - rr then
        robot.forward()
      end
    end
  end

  if skipOneBlock == true then 
    robot.turnAround()
    robot.forward()
  end
  robot.turnLeft()
end


function chechInventory()
  if robot.count() == 0 then
    robot.select(robot.select()+1)
  end
end


function start()
  -- Получить башню пользователя
  local tower = getUserTower()

  -- Все блоки на месте?
  while true do
    local status = getBlocksStatus(tower)
    if status == false then
      return
    elseif status == true then
      break
    end
    print("\nНедостаточно ресурсов!\n")
  end


  buildTower(tower)
  buildPlatform(tower)

  print("\nМультиферма построена!")
end

start()