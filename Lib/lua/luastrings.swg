%fragment("SWIG_AsCharPtrAndSize","header",fragment="SWIG_pchar_descriptor") {
%define SWIG_AsCharPtrAndSize(index, cptr, psize, alloc) SWIG_Lua_AsCharPtrAndSize(L, index, cptr, psize, alloc) %enddef
SWIGINTERN int
SWIG_Lua_AsCharPtrAndSize(lua_State *L, int index, char** cptr, size_t* psize, int *alloc)
{
  const char* cstr = 0;
  size_t len = 0;
  if(lua_type(L,index) == LUA_TSTRING) {
    cstr = lua_tolstring(L,index,&len);
    if (cptr) {
      if (alloc) {
        /* 
           In lua the user should not be able to modify the inner
           string representation. To warranty that, if you define
           SWIG_LUA_SAFE_CSTRINGS, a new/copy of the python string
           buffer is always returned.

           The default behavior is just to return the pointer value,
           so, be careful.
        */ 
%#if defined(SWIG_LUA_SAFE_CSTRINGS)
        if (*alloc != SWIG_OLDOBJ)
%#else
        if (*alloc == SWIG_NEWOBJ)
%#endif
        {
          *cptr = %new_copy_array(cstr, len + 1, char);
          *alloc = SWIG_NEWOBJ;
        } else {
          *cptr = %const_cast(cstr, char*);
          *alloc = SWIG_OLDOBJ;
        }
      } else {
        *cptr = %const_cast(cstr, char*);
      }
    }
    if (psize) *psize = len; // TODO: CHeck: len or len+1?
    return SWIG_OK;
  } else {
    swig_type_info* pchar_descriptor = SWIG_pchar_descriptor();
    if (pchar_descriptor) {
      void* vptr = 0;
      if (SWIG_ConvertPtr(index, &vptr, pchar_descriptor, 0) == SWIG_OK) {
	if (cptr) *cptr = (char *) vptr;
	if (psize) *psize = vptr ? (strlen((char *)vptr) + 1) : 0;
	if (alloc) *alloc = SWIG_OLDOBJ;
	return SWIG_OK;
      }
    }
  }
  return SWIG_TypeError;
}
}

%fragment("SWIG_FromCharPtrAndSize","header",fragment="SWIG_pchar_descriptor") {
%define SWIG_FromCharPtrAndSize(carray, size) SWIG_Lua_FromCharPtrAndSize(L, carray, size) %enddef
SWIGINTERNINLINE int
SWIG_Lua_FromCharPtrAndSize(lua_State *L, const char* carray, size_t size)
{
  if (carray) {
    if (size > INT_MAX) {
      swig_type_info* pchar_descriptor = SWIG_pchar_descriptor();
      if (pchar_descriptor)
        SWIG_NewPointerObj(%const_cast(carray,char *), pchar_descriptor, 0);
      else
        lua_pushnil(L);
    } else {
      lua_pushlstring(L, carray, size);
    }
  } else {
      lua_pushnil(L);
  }
  return SWIG_LUA_UNUSED;
}
}
