local component = require('component')


function getIDs()
  local reds = ""
  i = 1
  for id, name in pairs(component.list()) do
    if name == "redstone" then
      reds = reds .. i .. ") " .. name .. " - " .. id .. "\n"
    	i = i + 1
    end
  end
  return reds
end

local test = assert(io.open("reds.txt", "w"))
test:write(getIDs())
test:close()