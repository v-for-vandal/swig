/*
 * For primitive types Lua provides more effective ways to check type then variant
 * provided by standard typemap library (cast to type and check error code)
 */

/* -----------------------------------------------------------------------------
 *                          typecheck rules
 * ----------------------------------------------------------------------------- */
/* These are needed for the overloaded functions
These define the detection routines which will spot what
parameters match which function
*/

// unfortunately lua only considers one type of number
// so all numbers (int,float,double) match
// you could add an advanced fn to get type & check if its integral
%typecheck(SWIG_TYPECHECK_INTEGER)
	 int, short, long,
 	 unsigned int, unsigned short, unsigned long,
	 signed char, unsigned char,
	 long long, unsigned long long, signed long long,
	 const int &, const short &, const long &,
 	 const unsigned int &, const unsigned short &, const unsigned long &,
	 const signed char&, const unsigned char&,
	 const long long &, const unsigned long long &,
	 enum SWIGTYPE, const enum SWIGTYPE&,
	 float, double, const float &, const double&
{
  $1 = lua_isnumber(L,$input);
}

%typecheck(SWIG_TYPECHECK_BOOL)
    bool, const bool &
{
  $1 = lua_isboolean(L,$input);
}

// special check for a char (string of length 1)
%typecheck(SWIG_TYPECHECK_CHAR,fragment="SWIG_lua_isnilstring") char, const char& {
  $1 = SWIG_lua_isnilstring(L,$input) && (lua_rawlen(L,$input)==1);
}

%typecheck(SWIG_TYPECHECK_STRING,fragment="SWIG_lua_isnilstring") char *, char[] {
  $1 = SWIG_lua_isnilstring(L,$input);
}

%typecheck(SWIG_TYPECHECK_POINTER) SWIGTYPE *, SWIGTYPE [] {
  void *ptr;
  if (SWIG_isptrtype(L,$input)==0 || SWIG_ConvertPtr($input, (void **) &ptr, $1_descriptor, 0)) {
    $1 = 0;
  } else {
    $1 = 1;
  }
}

%typecheck(SWIG_TYPECHECK_POINTER) SWIGTYPE & {
  void *ptr;
  if (lua_isuserdata(L,$input)==0 || SWIG_ConvertPtr($input, (void **) &ptr, $1_descriptor, 0)) {
    $1 = 0;
  } else {
    $1 = 1;
  }
}

%typecheck(SWIG_TYPECHECK_POINTER) SWIGTYPE {
  void *ptr;
  if (lua_isuserdata(L,$input)==0 || SWIG_ConvertPtr($input, (void **) &ptr, $&1_descriptor, 0)) {
    $1 = 0;
  } else {
    $1 = 1;
  }
}

%typecheck(SWIG_TYPECHECK_VOIDPTR) void * {
  void *ptr;
  if (SWIG_isptrtype(L,$input)==0 || SWIG_ConvertPtr($input, (void **) &ptr, 0, 0)) {
    $1 = 0;
  } else {
    $1 = 1;
  }
}

// Also needed for object pointers by const ref
// eg const A* ref_pointer(A* const& a);
// found in mixed_types.i
%typecheck(SWIG_TYPECHECK_POINTER) SWIGTYPE *const&
{
  void *ptr;
  if (lua_isuserdata(L,$input)==0 || SWIG_ConvertPtr($input, (void **) &ptr, $*descriptor, 0)) {
    $1 = 0;
  } else {
    $1 = 1;
  }
}
