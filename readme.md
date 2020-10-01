uuLua
=========

A small library that implements some UUID generating functions (so far only
random UUIDs)

Give it a try:
  
	local uu = require "uulua"
	for i=1,20 do
		print(uu.random())
	end

...or in moonscript:

	uu = require "uulua"
	for i=1,20
		print uu.random!

uuLua also supports generating [ULIDs](https://github.com/ulid/spec) with the
`uulua.ulid(time)` function.

Next planned feature:
date-time and MAC-based (aka. version 1) UUIDs

License: [The Unlicense](license.md)
