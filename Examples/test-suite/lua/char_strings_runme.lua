require("import")	-- the import fn
import("char_strings")	-- import code

assert (char_strings.CharPingPong("hi there") == "hi there")
assert (char_strings.CharPingPong(nil) == nil)

assert (char_strings.CharArrayPingPong("hi there") == "hi there")
assert (char_strings.CharArrayPingPong(nil) == nil)

assert (char_strings.CharArrayDimsPingPong("hi there") == "hi there")

-- Starting from version 3.0 functions returning char[NUM] will
-- always return a sting of given size, even if it consists from
-- NUM zeroes. Thats why char_strings.CharArrayDimsPingPong(nil)
-- will return string with 16 zeroes, not nil
-- assert (char_strings.CharArrayDimsPingPong(nil) == nil)

