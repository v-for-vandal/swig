/* #define %libtypemap_call(func, Args...) func(L, Args) */

#define SWIG_AS_DECL_ARGS SWIG_LUA_DECL_ARGS_2
#define SWIG_AS_CALL_ARGS SWIG_LUA_CALL_ARGS_2

#define SWIG_FROM_DECL_ARGS  SWIG_LUA_DECL_ARGS_1
#define SWIG_FROM_CALL_ARGS  SWIG_LUA_CALL_ARGS_1

/* Include fundamental fragemt definitions */
%include <typemaps/fragments.swg>

/* Python fragments for fundamental types */
%include <luaprimtypes.swg>

#define SWIG_Object void
#define  VOID_Object void

/* No director supported in Lua. TODO: Enable back */
#ifdef SWIG_DIRECTOR_TYPEMAPS
#undef SWIG_DIRECTOR_TYPEMAPS
#endif

%define %set_output(obj) SWIG_arg++; %enddef

%define %append_output(obj) SWIG_arg++; %enddef

//%define SWIG_LUA_CONSTTAB(Type...) SWIG_LUA_CONSTTAB_ ## Type// TODO: REMOVE
%define %set_constant(name, value) add_lua_constant(name,value)

%define %raise(obj,type,desc) SWIG_Lua_pushferrstring(L,"Error %s", desc); SWIG_fail

/* Include the unified typemap library */
%include <typemaps/swigtypemaps.swg>

