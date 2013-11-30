
#define SWIG_AS_DECL_ARGS SWIG_LUA_DECL_ARGS_2
#define SWIG_AS_CALL_ARGS SWIG_LUA_CALL_ARGS_2
#define SWIG_AS_ARRAY_DECL_ARGS SWIG_LUA_DECL_ARGS_3
#define SWIG_AS_ARRAY_CALL_ARGS SWIG_LUA_CALL_ARGS_3

#define SWIG_FROM_DECL_ARGS  SWIG_LUA_DECL_ARGS_1
#define SWIG_FROM_CALL_ARGS  SWIG_LUA_CALL_ARGS_1
#define SWIG_FROM_ARRAY_DECL_ARGS  SWIG_LUA_DECL_ARGS_1
#define SWIG_FROM_ARRAY_CALL_ARGS  SWIG_LUA_CALL_ARGS_1

#define SWIG_CHECK_DECL_ARGS SWIG_LUA_CALL_ARGS_1
#define SWIG_CHECK_CALL_ARGS SWIG_LUA_CALL_ARGS_1

/* Lua note:
 * Lua has no 'target language object' (aka SWIG_Object). There is no analog of PyObject* etc. This is why we can't write
 * SWIGINTERNINLINE Lua_Object*
 * SWIG_From_dec(bool) (bool value) {
 *   return Lua_Object(value);
 * }
 * Instead we are passing lua_State *L to every function (it is hidden inside SWIG_FROM_DECL_ARGS, see fragments.swg) and 
 * each function simply pushes return value to the interpreter.
 * SWIG_From_dec(bool) returns integer, special constant SWIG_LUA_UNUSED so that compiler doesn't complain
 * SWIG_Object is set to int. It stores index whe necessary object 
 * is stored. Pair (lua_State*,index) servers as imaginary Lua_Object*.
 */

#define SWIG_LUA_UNUSED (int)(1) // Special constant

#define SWIG_Object int

/* Include fundamental fragemt definitions */
%include <typemaps/fragments.swg>

/* Lua fragments for fundamental types */
%include <luaprimtypes.swg>

/* Lua fragments for char* strings */
%include <luastrings.swg>

/* No director supported in Lua. TODO: Enable back */
#ifdef SWIG_DIRECTOR_TYPEMAPS
#undef SWIG_DIRECTOR_TYPEMAPS
#endif

%define %set_output(obj) DO_SET_OUTPUT;obj;SWIG_arg++; %enddef


%define %append_output(obj) DO_APPEND_OUTPUT;obj;SWIG_arg++; %enddef

//%define SWIG_LUA_CONSTTAB(Type...) SWIG_LUA_CONSTTAB_ ## Type// TODO: REMOVE
%define %set_constant(name, value) add_lua_constant(name,value) %enddef

%define %raise(obj,type,desc) SWIG_Lua_pushferrstring(L,"Error %s", desc); SWIG_fail %enddef

/* Include the unified typemap library */
%include <typemaps/swigtypemaps.swg>

%typemap(out) void "";

// Redefine typemaps for constants
%include <luaconst.swg>

// Redefine some typechecks
%include <luatypechecks.swg>

// This is fix for char[] handling. Current implementation of Lua doesn't respect
// varin typemap and uses globalin instead
%typemap(globalin,noblock=1,warning="462:Unable to set variable of type Char []") char []
{
  %variable_fail(SWIG_AttributeError, "$type", "read-only $name");
}

