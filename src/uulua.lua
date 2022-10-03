--- A module for creating UUIDs in lua
-- @module uuLua
-- @author DarkWiiPlayer (Dennis Fischer)
-- @license Unlicense

local crockford = require 'based.32.crockford'

local template = "xxxxxxxx-xxxx-axxx-bxxx-xxxxxxxxxxxx"

local uulua = {}

--- Returns a random crockford digit
local function random_base32_digit()
	local number = math.random(32)
	return crockford.encode_lookup:sub(number, number)
end

--- The NIL UUID 00000000-0000-0000-0000-000000000000
uulua.null = template:gsub("[xab]", "0")

--- Generates a version 4 variant 1 UUID.
function uulua.v41()
  return (template:gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return string.format("%x", 8+math.random(3)) -- 10xx
  end):gsub("x", function(x)
    return string.format("%x", math.random(16))
  end))
end

--- Generates a version 4 variant 2 UUID.
-- Same as @{v41} but with one less bit.
function uulua.v42()
  return (template:gsub("a", function(a)
    return "4"
  end):gsub("b", function(b)
    return string.format("%x", 12+math.random(1)) -- 110x
  end):gsub("x", function(x)
    return string.format("%x", math.random(16))
  end))
end

--- Generates a Uninversally Unique Lexicographically Sortable Identifier.
-- @tparam number time Number of milliseconds since 1970-01-01. Defaults to current time with a precision of 1 second.
function uulua.ulid(time)
	time = time or os.time() * 1000
	-- Note: Encoding the time as a number is not the same as packing it into a big endian char[6] and encoding that
	-- as string encoding puts padding bits at the end but number encoding needs right padding.
	return crockford.encode(time) .. ("xxxxxxxxxxxxxxxx"):gsub("x", random_base32_digit)
end

--- Just an alias for @{v41} with a more user friendly name
-- @function random
uulua.random = uulua.v41

return uulua
