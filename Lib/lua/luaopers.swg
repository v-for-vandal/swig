// lua calls the + operator '__add'
// python likes to call it '__add__'
// Assuming most SWIGers will probably use the __add__ if they extend their classes
// we have two sets of renames
// one to rename the operator+() to __add()
//	(this lets SWIG rename the operator overloads)
// another is to rename __add__() to __add()
//	(this means that people who wrote SWIG code to do that add will also work)

#ifdef __cplusplus
// this is extra renaming for lua
// not all operators are supported, so only those that are, are listed
%rename(__add)			*::operator+;
%rename(__sub)			*::operator-;
%rename(__mul)			*::operator*;
%rename(__div)			*::operator/;
%rename(__unm)      *::operator-();
%rename(__unm)      *::operator-() const;

%rename(__eq)			*::operator==;	
%ignore *::operator!=;      // note: Lua does not have a notequal operator
						// it just uses 'not (a==b)'
%rename(__lt)			*::operator<;
%ignore *::operator>;   	// ditto less than vs greater than
%rename(__le)			*::operator<=;	
%ignore *::operator>=;  // ditto less than vs greater than
%ignore *::operator!;  // does not support not

%rename(__call)			*::operator();	// the fn call operator

// lua does not support overloading of:
// 	logical/bitwise operators
// 	assign operator
// 	+=,-=,*=, etc
// therefore ignoring them for now
// it also doesn't support non class operators
// eg friends or XX operator+(XX,XX)
// also ignoring
// note: some of these might be better to rename, but not doing that for now
%ignore *::operator&&;	%ignore operator&&;
%ignore *::operator||;	%ignore operator||;
%ignore *::operator+=;
%ignore *::operator-=;
%ignore *::operator*=;
%ignore *::operator/=;
%ignore *::operator%=;
%ignore *::operator++;	%ignore *::operator--;

%ignore *::operator=;	// note: this might be better to rename to assign() or similar

%ignore operator+;
%ignore operator-;
%ignore operator*;
%ignore operator/;
%ignore operator%;
%ignore operator[];
%ignore operator>;	%ignore operator>=;	
%ignore operator<;	%ignore operator<=;
%ignore operator==;	%ignore operator!=;


// renaming the python operators to be compatible with lua
// this means that if a developer has written a fn __add__()
// it will be used for the lua +
%rename(__add)			*::__add__;
%rename(__sub)			*::__sub__;
%rename(__mul)			*::__mul__;
%rename(__div)			*::__div__;
%rename(__unm)			*::__neg__;		// lua calls unary minus,'unm' not 'neg'
%rename(__tostring)		*::__str__;		// both map to __tostring
%rename(__tostring)		*::__repr__;	// both map to __tostring


%rename(__pow)			*::__pow__;		// lua power '^' operator
%rename(__concat)		*::__concat__;  // lua concat '..' operator
%rename(__eq)			*::__eq__;
%rename(__lt)			*::__lt__;
%rename(__le)			*::__le__;
%rename(__call)			*::__call__;	// the fn call operator()

// the [] operator has two parts, the get & the set
%rename(__getitem)			*::__getitem__;	// the v=X[i] (get operator)
%rename(__setitem)			*::__setitem__;	// the X[i]=v (set operator)


#endif

