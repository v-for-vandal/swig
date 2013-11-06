/* -----------------------------------------------------------------------------
 * lua.swg
 *
 * SWIG Configuration File for Lua.
 * This file is parsed by SWIG before reading any other interface file.
 * ----------------------------------------------------------------------------- */

/* -----------------------------------------------------------------------------
 *                          includes
 * ----------------------------------------------------------------------------- */

/* ------------------------------------------------------------
 *  Inner macros
 * ------------------------------------------------------------ */
%include <luamacros.swg>

/* ------------------------------------------------------------
 *  The runtime part
 * ------------------------------------------------------------ */
%include <luaruntime.swg>

/* ------------------------------------------------------------
 *  Typemap specializations
 * ------------------------------------------------------------ */
%include <luatypemaps.swg>


/* -----------------------------------------------------------------------------
 *                          Overloaded operator support
 * ----------------------------------------------------------------------------- */
%include <luaopers.swg>

/* ------------------------------------------------------------
 *                              Exceptions
 * ------------------------------------------------------------ */
/* Confession: I don't really like C++ exceptions
The python/lua ones are great, but C++ ones I don't like
(mainly because I cannot get the stack trace out of it)
Therefore I have not bothered to try doing much in this

Therefore currently its just enough to get a few test cases running ok

note: if you wish to throw anything related to std::exception
use %include <std_except.i> instead
*/

// number as number+error
%typemap(throws) int,unsigned int,signed int,
				long,unsigned long,signed long,
				short,unsigned short,signed short,
				float,double,
				long long,unsigned long long,
				unsigned char, signed char,
                int&,unsigned int&,signed int&,
				long&,unsigned long&,signed long&,
				short&,unsigned short&,signed short&,
				float&,double&,
				long long&,unsigned long long&,
				unsigned char&, signed char&
%{lua_pushnumber(L,(lua_Number)$1);SWIG_fail; %}

%typemap(throws) bool,bool& 
%{lua_pushboolean(L,(int)($1==true));SWIG_fail; %}

// enum as number+error
%typemap(throws) enum SWIGTYPE
%{lua_pushnumber(L,(lua_Number)(int)$1);SWIG_fail; %}

// strings are just sent as errors
%typemap(throws) char *, const char *
%{lua_pushstring(L,$1);SWIG_fail;%}

// char is changed to a string
%typemap(throws) char
%{lua_pushfstring(L,"%c",$1);SWIG_fail;%}

/*
Throwing object is a serious problem:
Assuming some code throws a 'FooBar'
There are a few options:
- return a pointer to it: but its unclear how long this will last for.
- return a copy of it: but not all objects are copyable
	(see exception_partial_info in the test suite for a case where you cannot do this)
- convert to a string & throw that
	it's not so useful, but it works (this is more lua like).
The third option (though not nice) is used
For a more useful solution: see std_except for more details
*/

// basic typemap for structs, classes, pointers & references
// convert to string and error
%typemap(throws) SWIGTYPE
%{(void)$1; /* ignore it */
lua_pushfstring(L,"object exception:%s",SWIG_TypePrettyName($1_descriptor));
SWIG_fail;%}

// code to make a copy of the object and return this
// if you have a function which throws a FooBar & you want SWIG to return a copy of the object as its error
// then use one of the below
//	%apply SWIGTYPE EXCEPTION_BY_VAL {FooBar};
//	%apply SWIGTYPE& EXCEPTION_BY_VAL {FooBar&}; // note: need & twice
%typemap(throws) SWIGTYPE EXCEPTION_BY_VAL
%{SWIG_NewPointerObj(L,(void *)new $1_ltype(($1_ltype &) $1),$&1_descriptor,1);
SWIG_fail;%}

// similar for object reference
// note: swig typemaps seem a little confused around here, therefore we use $basetype
%typemap(throws) SWIGTYPE& EXCEPTION_BY_VAL
%{SWIG_NewPointerObj(L,(void *)new $basetype($1),$1_descriptor,1);
SWIG_fail;%}


// note: no support for object pointers
// its not clear how long the pointer is valid for, therefore not supporting it

/* -----------------------------------------------------------------------------
 *                          extras
 * ----------------------------------------------------------------------------- */
// this %define is to allow insertion of lua source code into the wrapper file
#define %luacode  %insert("luacode")


/* ------------------------------ end lua.swg  ------------------------------ */
