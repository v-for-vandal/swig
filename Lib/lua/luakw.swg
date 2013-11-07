/*
  Warnings for Lua keywords.
*/

#define LUAKW(x) %keywordwarn("'" `x` "' is a python keyword, renaming to '_" `x` "'", rename="_%s")  `x`

/* Lua keywords : http://www.lua.org/manual/5.2/manual.html#3.1 */
LUAKW(and)
LUAKW(break)
LUAKW(do)
LUAKW(else)
LUAKW(elseif)
LUAKW(end)
LUAKW(false)
LUAKW(for)
LUAKW(function)
LUAKW(goto)
LUAKW(if)
LUAKW(in)
LUAKW(local)
LUAKW(nil)
LUAKW(not)
LUAKW(or)
LUAKW(repeat)
LUAKW(return)
LUAKW(then)
LUAKW(true)
LUAKW(until)
LUAKW(while)
