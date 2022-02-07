local thread = require("thread")
 

function foo(x, y)
  print(x*y)
  os.sleep(5)
end

thread.create(boo, 3, 5)
print(1)
