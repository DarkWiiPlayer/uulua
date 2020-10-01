--- A module for creating UUIDs in lua
-- @module uuLua
-- @author DarkWiiPlayer (Dennis Fischer)
-- @license Unlicense

local random = math.random

local template = "xxxxxxxx-xxxx-axxx-bxxx-xxxxxxxxxxxx"

local uulua = {}

local base32_dict = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"

--- Encodes a string of binary data in base32
local function base32(data)
	return data:gsub(".", function(char)
		local byte = char:byte()
		return base32_dict:sub(byte%32+1)..base32_dict:sub(math.floor(byte/32)+1)
	end)
end

--- Returns a random Base32 digit
local function random_base32_digit()
	local number = math.random(32)
	return base32_dict:sub(number, number)
end

--- The NIL UUID 00000000-0000-0000-0000-000000000000
uulua.null = template:gsub("[xab]", "0")

--- Converts a number between 0 and 15 to a hex digit
-- @param num A number between 0 and 15
-- @warning Behavior for numbers not between 0 and 15 is not defined!
local function tohex(num)
  return string.char(("0123456789abcdef"):byte(num+1))
end

--- Generates a version 4 variant 1 UUID.
function uulua.v41()
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
function uulua.v42()
  return (template:gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return tohex(12+random(1)) -- 110x
  end):gsub("x", function(x)
    return tohex(random(15))
  end))
end

--- Generates a Uninversally Unique Lexicographically Sortable Identifier.
-- @tparam number time Number of milliseconds since 1970-01-01. Defaults to current time with a precision of 1 second.
function uulua.ulid(time)
	time = time or os.difftime(os.time(), os.time{year=1970, day=1, month=1})*1000
	local t32 = {}
	for i=1, 10 do
		local number = (time%32)+1
		table.insert(t32, base32_dict:sub(number, number))
		time = math.floor(time / 32)
	end
	return table.concat(t32):reverse() .. ("xxxxxxxxxxxxxxxx"):gsub("x", random_base32_digit)
end

--- Just an alias for @{v41} with a more user friendly name
-- @function random

uulua.random = uulua.v41

print(uulua.ulid())

return uulua
