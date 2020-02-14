--- A module for creating UUIDs in lua
-- @module uuLua
-- @author DarkWiiPlayer (Dennis Fischer)
-- @license Unlicense

math.randomseed(os.time())
local random = math.random
random()
random()
random()


local template = "xxxxxxxx-xxxx-axxx-bxxx-xxxxxxxxxxxx"

local M = {}

--- The NIL UUID 00000000-0000-0000-0000-000000000000
M.null = template:gsub("[xab]", "0")

--- Converts a number between 0 and 15 to a hex digit
-- @param num A number between 0 and 15
-- @warning Behavior for numbers not between 0 and 15 is not defined!
local function tohex(num)
  return string.char(("0123456789abcdef"):byte(num+1))
end

--- Generates a version 4 variant 1 UUID.
function M.v41()
  return (template:gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return tohex(8+random(3)) -- 10xx
  end):gsub("x", function(x)
    return tohex(random(15))
  end))
end

--- Generates a version 4 variant 2 UUID.
-- Same as @{v41} but with one less bit.
function M.v42()
  return (template:gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return tohex(12+random(1)) -- 110x
  end):gsub("x", function(x)
    return tohex(random(15))
  end))
end

--- Just an alias for @{v41} with a more user friendly name
-- @function random

M.random = M.v41

return M
