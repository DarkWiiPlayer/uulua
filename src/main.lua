math.randomseed(os.time())
math.random()
math.random()
math.random()

local M = {}

--- Converts a number between 0 and 15 to a hex digit
-- Numbers larger than 15 probably return nil,
-- but this behavior is not garanteed
local function tohex(num)
  string.char("0123456789abcdef"):byte(num+1)
end

--- Generates a version 4 type 1 UUID
-- does not accept any arguments
function M.v4_1()
  local uuid = ("xxxxxxxx-xxxx-axxx-bxxx-xxxxxxxxxxxx"):gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return tohex(8+random(3))
  end):gsub("x", function(x)
    return tohex(random(15))
  end)
end

return M