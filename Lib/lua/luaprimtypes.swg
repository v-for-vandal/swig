/* ------------------------------------------------------------
 * Primitive Types
 * ------------------------------------------------------------ */

// strings (char * and char[])
%fragment("SWIG_lua_isnilstring", "header") {
SWIGINTERN int SWIG_lua_isnilstring(lua_State *L, int idx) {
  int ret = lua_isstring(L, idx);
  if (!ret)
   ret = lua_isnil(L, idx);
  return ret;
}
}

/* boolean */

%fragment(SWIG_From_frag(bool),"header") {
SWIGINTERNINLINE int
  SWIG_From_dec(bool)(bool value)
{
  lua_pushboolean(L,(value)?1:0);
  return SWIG_LUA_UNUSED;
}
}

%fragment(SWIG_AsVal_frag(bool),"header" ) {
SWIGINTERN int
SWIG_AsVal_dec(bool)(int index, bool *val)
{
  if(!lua_isboolean(L,index))
    return SWIG_ERROR;

  const int r = lua_toboolean(L,index);
  if (val) *val = r == 1 ? true : false;
  return SWIG_OK;
}
}

/* char (not signed char or unsigned char ) is treated as small string
 * signed and unsigned chars are treated as numbers
 */

%fragment(SWIG_From_frag(char),"header") {
SWIGINTERNINLINE int
  SWIG_From_dec(char)(char value)
{
  lua_pushfstring(L,"%c",value);
  return SWIG_LUA_UNUSED;
}
}

%fragment(SWIG_AsVal_frag(char),"header",
   fragment="SWIG_lua_isnilstring" ) {
SWIGINTERN int
SWIG_AsVal_dec(char)(int index, char *val)
{
  if(!SWIG_lua_isnilstring(L,index))
    return SWIG_ERROR;
  if(lua_rawlen(L,index) != 1)
    return SWIG_ERROR;

  if (val) *val = (lua_tostring(L,index)[0]);
  return SWIG_OK;
}
}

/* double */

%fragment(SWIG_From_frag(double),"header") {
SWIGINTERNINLINE int
  SWIG_From_dec(double)(double value)
{
  lua_pushnumber(L,(lua_Number)(value));
  SWIG_LUA_UNUSED;
}
}

%fragment(SWIG_AsVal_frag(double),"header" ) {
SWIGINTERN int
SWIG_AsVal_dec(double)(int index, double *val)
{
  if(!lua_isnumber(L,index))
    return SWIG_ERROR;

  if (val) *val = lua_tonumber(L,index);
  return SWIG_OK;
}
}

/* other numeric */
// TODO: REVIEW: signed/unsigned
//%numeric_double(int, "<limits.h>", INT_MIN, INT_MAX );
//%numeric_double(unsigned int, "<limits.h>", 0, UINT_MAX );
%numeric_type_from(int, double)
%numeric_type_asval(int,double, "<limits.h>", (v < INT_MIN || v > INT_MAX ) )

%numeric_double(short, "<limits.h>", SHRT_MIN, SHRT_MAX );
%numeric_double(unsigned short, "<limits.h>", 0, USHRT_MAX );

%numeric_double(long, "<limits.h>", LONG_MIN, LONG_MAX );
%numeric_double(unsigned long, "<limits.h>", 0, ULONG_MAX );

%numeric_double(long long, "<limits.h>", LONG_MIN, LONG_MAX );
%numeric_double(unsigned long long, "<limits.h>", 0, ULONG_MAX );

%numeric_double(signed char, "<limits.h>", SCHAR_MIN, SCHAR_MAX );
%numeric_double(unsigned char, "<limits.h>", 0, UCHAR_MAX );

