local component = require('component')
local sides = require("sides")


function testComponent(id)
  redstone = component.proxy(id)

  redstone.setOutput(sides.west, 1)

  os.sleep(10)
  
  redstone.setOutput(sides.west, 0)

end

testComponent("894169a0-0a71-4b6f-9a2a-55872cde9ffc")