UULua
=========

A small library that implements some UUID generating functions (so far only random UUIDs)

Give it a try:
  
	uu = require "uulua"
	for i=1,20 do
		print(uu.random())
	end

Next planned feature:
date-time and MAC-based (aka. version 1) UUIDs

License: [The Unlicense](license.md)
