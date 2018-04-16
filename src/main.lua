math.randomseed(os.time())
local random = math.random
random()
random()
random()

local M = {}

--- Converts a number between 0 and 15 to a hex digit
-- Numbers larger than 15 probably return nil,
-- but this behavior is not garanteed
local function tohex(num)
  return string.char(("0123456789abcdef"):byte(num+1))
end

--- Generates a version 4 type 1 UUID
-- does not accept any arguments
function M.v4_1()
  local uuid = "xxxxxxxx-xxxx-axxx-bxxx-xxxxxxxxxxxx"
  uuid = uuid:gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return tohex(8+random(3))
  end):gsub("x", function(x)
    return tohex(random(15))
  end)
  return uuid
end

return M
