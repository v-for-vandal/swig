/* -----------------------------------------------------------------------------
 *                          constants typemaps
 * ----------------------------------------------------------------------------- */
// this basically adds to a table of constants
%typemap(consttab) int, unsigned int, short, unsigned short, long, unsigned long, unsigned char, signed char, bool, enum SWIGTYPE
       {SWIG_LUA_CONSTTAB_INT("$symname", $value)}

%typemap(consttab) float, double
       {SWIG_LUA_CONSTTAB_FLOAT("$symname", $value)}

%typemap(consttab) long long, unsigned long long, signed long long
       {SWIG_LUA_CONSTTAB_FLOAT("$symname", $value)}

%typemap(consttab) const long long&, const unsigned long long&, const signed long long&
       {SWIG_LUA_CONSTTAB_FLOAT("$symname", *$value)}

%typemap(consttab) char *, const char *, char [], const char []
       {SWIG_LUA_CONSTTAB_STRING("$symname", $value)}

// note: char is treated as a seperate special type
// signed char & unsigned char are numbers
%typemap(consttab) char
       {SWIG_LUA_CONSTTAB_CHAR("$symname", $value)}

%typemap(consttab) long long, unsigned long long
       {SWIG_LUA_CONSTTAB_STRING("$symname", "$value")}

%typemap(consttab) SWIGTYPE *, SWIGTYPE *const, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE []
       { SWIG_LUA_POINTER, (char *)"$symname", 0, 0, (void *)$value, &$1_descriptor}

// member function pointers
%typemap(consttab) SWIGTYPE (CLASS::*)
       { SWIG_LUA_BINARY,  (char *)"$symname", sizeof($type), 0, (void *)&$value, &$1_descriptor}

