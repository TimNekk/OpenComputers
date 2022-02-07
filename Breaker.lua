local robot = require("robot")

local work = true

function selectSlotWithItems()
  for i=1, robot.inventorySize() do
    robot.select(i)
    if robot.count() ~= 0 then
      return 
    end
  end
  print("Нет блоков!")
  work = false
end


function placeAndBreak()
--  selectSlotWithItems()
  if robot.place() then
    robot.swing()
  else
    robot.drop()
  end
end


function start()
  while work do
    placeAndBreak()
  end
end


start()