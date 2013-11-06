%ensure_fragment(SWIG_AsCharPtrAndSize)
%ensure_fragment(SWIG_FromCharPtrAndSize)

%types(char *);

%fragment("SWIG_pchar_descriptor","header") {
SWIGINTERN swig_type_info*
SWIG_pchar_descriptor(void)
{
  static int init = 0;
  static swig_type_info* info = 0;
  if (!init) {
    info = SWIG_TypeQuery("_p_char");
    init = 1;
  }
  return info;
}
}


%include <typemaps/strings.swg>
%typemaps_string(%checkcode(STRING), %checkcode(CHAR),
		 char, Char, SWIG_AsCharPtrAndSize, SWIG_FromCharPtrAndSize, strlen,
		"<limits.h>", CHAR_MIN, CHAR_MAX)
/* TODO: RETURN
*/
/*
%_typemap2_string(%checkcode(STRING), %checkcode(CHAR),
		  char, Char,
		  SWIG_AsCharPtrAndSize,
		  SWIG_FromCharPtrAndSize,
		  strlen,
		  %new_copy_array,
		  %delete_array,
		  "<limits.h>", CHAR_MIN, CHAR_MAX)
*/

/*
%_typemap_string(%checkcode(STRING), 
		 char,
		 Char,
		 SWIG_AsCharPtrAndSize,
		 SWIG_FromCharPtrAndSize,
		  strlen,
		  %new_copy_array,
		  %delete_array
		 )
*/

/*
#define SWIG_AsCharNamePtr_frag(CharName)   "SWIG_As" #CharName "Ptr"
#define SWIG_AsCharNameArray_frag(CharName)   "SWIG_As" #CharName "Array"
#define SWIG_FromCharNamePtr_frag(CharName)    "SWIG_From" #CharName "Ptr"
#define SWIG_FromCharNameArray_frag(CharName)    "SWIG_From" #CharName "Array"

#define SWIG_AsCharNamePtr_name(CharName)   SWIG_As##CharName##Ptr
#define SWIG_AsCharNameArray_name(CharName)   SWIG_As##CharName##Array
#define SWIG_FromCharNamePtr_name(CharName)    SWIG_From##CharName##Ptr
#define SWIG_FromCharNameArray_name(CharName)    SWIG_From##CharName##Array

#define SWIG_AsCharNamePtr_dec(CharName)   SWIG_AsCharNamePtr_name(CharName) SWIG_AS_DECL_ARGS
#define SWIG_AsCharNameArray_dec(CharName)   SWIG_AsCharNameArray_name(CharName) SWIG_AS_DECL_ARGS
#define SWIG_FromCharNamePtr_dec(CharName)    SWIG_FromCharNamePtr_name(CharName) SWIG_FROM_DECL_ARGS
#define SWIG_FromCharNameArray_dec(CharName)    SWIG_FromCharNameArray_name(CharName) SWIG_FROM_DECL_ARGS

#define SWIG_AsCharNamePtr(CharName)        SWIG_AsCharNamePtr_name(CharName) SWIG_AS_CALL_ARGS
#define SWIG_AsCharNameArray(CharName)        SWIG_AsCharNameArray_name(CharName) SWIG_AS_CALL_ARGS
#define SWIG_FromCharNamePtr(CharName)   	 SWIG_FromCharNamePtr_name(CharName) SWIG_FROM_CALL_ARGS
#define SWIG_FromCharNameArray(CharName)   	  SWIG_FromCharNameArray_name(CharName) SWIG_FROM_CALL_ARGS


#ifndef SWIG_FromCharPtrAndSize
#define SWIG_FromCharPtrAndSize SWIG_MyStubFromCharPtrAndSize
#endif
#ifndef SWIG_AsCharPtrAndSize
#define SWIG_AsCharPtrAndSize SWIG_MyStubAsCharPtrAndSize
#endif

%typemap(in,noblock=1,fragment=SWIG_AsCharNamePtr_frag(Char)) 
  char * (int res, char *buf = 0, int alloc = 0),
  const char * (int res, char *buf = 0, int alloc = 0) {
  res = SWIG_AsCharPtr($input, &buf, &alloc);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res,"$type",$symname, $argnum);
  }
  $1 = %reinterpret_cast(buf, $1_ltype);
}
%typemap(freearg,noblock=1,match="in") char *, const char * {
  if (alloc$argnum == SWIG_NEWOBJ) SWIG_DeleteCharArray(buf$argnum);
}

%typemap(in,noblock=1,fragment=SWIG_AsCharNamePtr_frag(Char)) char const*& (int res, char *buf = 0, int alloc = 0) {
  res = SWIG_AsCharPtr($input, &buf, &alloc);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res,"$type",$symname, $argnum);
  }
  $1 = &buf;
}    
%typemap(freearg, noblock=1,match="in") char const*& {
  if (alloc$argnum == SWIG_NEWOBJ) SWIG_DeleteCharArray(buf$argnum);
}

%typemap(out,noblock=1,fragment=SWIG_FromCharNamePtr_frag(Char)) char *, const char * {
  %set_output(SWIG_FromCharPtr((const char *)$1));
}


%typemap(out,noblock=1,fragment=SWIG_FromCharNamePtr_frag(Char)) char const*& {
  %set_output(
    SWIG_FromCharPtr(*$1)
   );
}

%typemap(newfree,noblock=1) char * {
  SWIG_DeleteCharArray($1);
}

%typemap(varin,fragment="SWIG_SWIG_AsCharPtrAndSize") char * {
  char *cptr = 0; size_t csize = 0; int alloc = SWIG_NEWOBJ;
  int res = SWIG_AsCharPtrAndSize($input, &cptr, &csize, &alloc);
  if (!SWIG_IsOK(res)) {
    %variable_fail(res,"$type","$name");
  }
  if ($1) SWIG_DeleteCharArray($1);
  if (alloc == SWIG_NEWOBJ) {
    $1 = cptr;
  } else {
    $1 = csize ? ($1_type)SWIG_NewCopyCharArray(cptr, csize, char) : 0;
  }
}

%typemap(varin,fragment="SWIG_SWIG_AsCharPtrAndSize",warning=SWIGWARN_TYPEMAP_CHARLEAK_MSG) const char * {
  char *cptr = 0; size_t csize = 0; int alloc = SWIG_NEWOBJ;
  int res = SWIG_AsCharPtrAndSize($input, &cptr, &csize, &alloc);
  if (!SWIG_IsOK(res)) {
    %variable_fail(res, "$type", "$name");
  }
  if (alloc == SWIG_NEWOBJ) {
    $1 = cptr;
  } else {
    $1 = csize ? ($1_type)SWIG_NewCopyCharArray(cptr, csize, char) : 0;
  }
}


%typemap(varout,noblock=1,fragment=SWIG_FromCharNamePtr_frag(Char)) char *, const char * {
  %set_varoutput(SWIG_FromCharPtr($1));
}


%typemap(memberin,noblock=1) char * {
  if ($1) SWIG_DeleteCharArray($1);
  if ($input) {
    size_t size = SWIG_CharPtrLen(%reinterpret_cast($input, const char *)) + 1;
    $1 = ($1_type)SWIG_NewCopyCharArray(%reinterpret_cast($input, const char *), size, char);
  } else {
    $1 = 0;
  }
}

%typemap(memberin,noblock=1,warning=SWIGWARN_TYPEMAP_CHARLEAK_MSG) const char * {
  if ($input) {
    size_t size = SWIG_CharPtrLen(%reinterpret_cast(%reinterpret_cast($input, const char *), const char *)) + 1;
    $1 = ($1_type)SWIG_NewCopyCharArray($input, size, char);
  } else {
    $1 = 0;
  }
}


%typemap(globalin,noblock=1) char * {
  if ($1) SWIG_DeleteCharArray($1);
  if ($input) {
    size_t size = SWIG_CharPtrLen(%reinterpret_cast(%reinterpret_cast($input, const char *), const char *)) + 1;
    $1 = ($1_type)SWIG_NewCopyCharArray($input, size, char);
  } else {
    $1 = 0;
  }
}

%typemap(globalin,noblock=1,warning=SWIGWARN_TYPEMAP_CHARLEAK_MSG) const char * {
  if ($input) {
    size_t size = SWIG_CharPtrLen($input) + 1;
    $1 = ($1_type)SWIG_NewCopyCharArray($input, size, char);
  } else {
    $1 = 0;
  }
}


%typemap(constcode,noblock=1,fragment=SWIG_FromCharNamePtr_frag(Char))
  char *, char const*, char * const, char const* const {
  %set_constant("$symname", SWIG_FromCharPtr($value));
}


#if defined(SWIG_DIRECTOR_TYPEMAPS)


%typemap(directorin,noblock=1,fragment=SWIG_FromCharNamePtr_frag(Char))
  char *, char const*, char *const, char const *const, 
  char const *&, char *const &, char const *const & {
  $input = SWIG_FromCharPtr((const char *)$1);
}



%typemap(directorout,noblock=1,fragment=SWIG_AsCharNamePtr_frag(Char),warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) char * (int res, char *buf = 0, int alloc = SWIG_NEWOBJ) {
  res = SWIG_AsCharPtr($input, &buf, &alloc);
  if (!SWIG_IsOK(res)) {
    %dirout_fail(res, "$type");
  }
  if (alloc == SWIG_NEWOBJ) {
    swig_acquire_ownership_array(buf);
  }
  $result = %reinterpret_cast(buf, $1_ltype);
}
%typemap(directorfree,noblock=1) char *
{
  if (director) {
    director->swig_release_ownership(%as_voidptr($input));
  }
}


%typemap(directorout,noblock=1,fragment=SWIG_AsCharNamePtr_frag(Char),warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) char *const& (int res, char *buf = 0, int alloc = SWIG_NEWOBJ), char const*const& (int res, char *buf = 0, int alloc = SWIG_NEWOBJ) { 
  res = SWIG_AsCharPtr($input, &buf, &alloc);
  if (!SWIG_IsOK(res)) {
    %dirout_fail(res, "$type");
  }
  static $*1_ltype tmp = buf;
  $result = &tmp;
  if (alloc == SWIG_NEWOBJ) {
    swig_acquire_ownership_array(buf);
  }
}
%typemap(directorfree,noblock=1)
  char * const&, char const* const& {
  if (director) {
    director->swig_release_ownership(%as_voidptr(*$input));
  }
}

#endif 


%typemap(typecheck,noblock=1,precedence=%checkcode(STRING),
	 fragment=SWIG_AsCharNamePtr_frag(CharName)) char *, const char *, char const*& {
  int res = SWIG_AsCharPtr($input, 0, 0);
  $1 = SWIG_CheckState(res);
}



%typemap(throws,noblock=1,fragment=SWIG_FromCharNamePtr_frag(Char)) char * {
  %raise(SWIG_FromCharPtr($1), "$type", 0);
}


%apply char * { char [] };
%apply const char * { const char [] };

%typemap(varin,noblock=1,warning="462:Unable to set variable of type char []") char []
{
  %variable_fail(SWIG_AttributeError, "$type", "read-only $name");
}



%typemap(memberin,noblock=1) char [ANY]
{
  if ($input) memcpy($1,$input,$1_dim0*sizeof(char));
  else memset($1,0,$1_dim0*sizeof(char));
}

%typemap(globalin,noblock=1) char [ANY]
{
  if ($input) memcpy($1,$input,$1_dim0*sizeof(char));
  else memset($1,0,$1_dim0*sizeof(char));
}


%typemap(in,noblock=1,fragment=SWIG_AsCharNameArray_frag(Char))
  char [ANY] (char temp[$1_dim0], int res), 
  const char [ANY](char temp[$1_dim0], int res)
{  
  res = SWIG_AsCharArray($input, temp, $1_dim0);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res,"$type",$symname, $argnum);
  }
  $1 = %reinterpret_cast(temp, $1_ltype);
}
%typemap(freearg) char [ANY], const char [ANY] "";

%typemap(in,noblock=1,fragment=SWIG_AsCharNameArray_frag(Char)) const char (&)[ANY] (char temp[$1_dim0], int res)
{  
  res = SWIG_AsCharArray($input, temp, $1_dim0);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res,"$type",$symname, $argnum);
  }
  $1 = &temp;
}
%typemap(freearg) const char (&)[ANY] "";

%typemap(out,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char [ANY], const char[ANY] 
{
  size_t size = $1_dim0;
%#ifndef SWIG_PRESERVE_CARRAY_SIZE
  while (size && ($1[size - 1] == '\0')) --size;
%#endif
   %set_output(SWIG_FromCharPtrAndSize($1, size));
}


%typemap(varin,fragment=SWIG_AsCharNameArray_frag(Char)) char [ANY]
{
  int res = SWIG_AsCharArray($input, $1, $1_dim0);
  if (!SWIG_IsOK(res)) {
    %variable_fail(res, "$type", "$name");
  }
}


%typemap(varout,noblock=1,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char [ANY], const char [ANY] {
  size_t size = $1_dim0;
%#ifndef SWIG_PRESERVE_CARRAY_SIZE
  while (size && ($1[size - 1] == '\0')) --size;
%#endif
  %set_varoutput(SWIG_FromCharPtrAndSize($1, size));
}


%typemap(constcode,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char [ANY], const char [ANY]
{
  size_t size = $value_dim0;
%#ifndef SWIG_PRESERVE_CARRAY_SIZE
  while (size && ($value[size - 1] == '\0')) --size;
%#endif
  %set_constant("$symname", SWIG_FromCharPtrAndSize($value,size));
}


#if defined(SWIG_DIRECTOR_TYPEMAPS)

%typemap(directorin,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char [ANY], const char [ANY] 
{
  size_t size = $1_dim0;
%#ifndef SWIG_PRESERVE_CARRAY_SIZE
  while (size && ($1[size - 1] == '\0')) --size;
%#endif
  $input = SWIG_FromCharPtrAndSize($1, size);
}


%typemap(directorout,noblock=1,fragment=SWIG_AsCharNameArray_frag(Char))
  char [ANY] (char temp[$result_dim0]),
  const char [ANY] (char temp[$result_dim0], int res)
{ 
  res = SWIG_AsCharArray($input, temp, $result_dim0);
  if (!SWIG_IsOK(res)) {
    %dirout_fail(res, "$type");
  }
  $result = temp;
}

#endif 


%typemap(typecheck,noblock=1,precedence=%checkcode(STRING),
	 fragment=SWIG_AsCharNameArray_frag(CharName))  
  char [ANY], const char[ANY] {
  int res = SWIG_AsCharArray($input, (char *)0, $1_dim0);
  $1 = SWIG_CheckState(res);
}



%typemap(throws,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char [ANY], const char[ANY]
{
  size_t size = $1_dim0;
%#ifndef SWIG_PRESERVE_CARRAY_SIZE
  while (size && ($1[size - 1] == '\0')) --size;
%#endif
  %raise(SWIG_FromCharPtrAndSize($1, size), "$type", 0); 
}

%typemap(varout,noblock=1,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char FIXSIZE[ANY], const char FIXSIZE[ANY]
{
  %set_varoutput(SWIG_FromCharPtrAndSize($1, $1_dim0));
}

%typemap(out,noblock=1,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char FIXSIZE[ANY], const char FIXSIZE[ANY]
{
  %set_output(SWIG_FromCharPtrAndSize($1, $1_dim0));
}

#if defined(SWIG_DIRECTOR_TYPEMAPS)

%typemap(directorin,noblock=1,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char FIXSIZE[ANY], const char FIXSIZE[ANY]
{
  $input = SWIG_FromCharPtrAndSize($1, $1_dim0);
}

#endif 

%typemap(throws,noblock=1,fragment="SWIG_SWIG_FromCharPtrAndSize")
  char FIXSIZE[ANY], const char FIXSIZE[ANY] {
  %raise(SWIG_FromCharPtrAndSize($1, $1_dim0), "$type", 0); 
}


%typemap(in,noblock=1,fragment="SWIG_SWIG_AsCharPtrAndSize") 
  (char *STRING, size_t LENGTH) (int res, char *buf = 0, size_t size = 0, int alloc = 0),
  (const char *STRING, size_t LENGTH) (int res, char *buf = 0, size_t size = 0, int alloc = 0)
{
  res = SWIG_AsCharPtrAndSize($input, &buf, &size, &alloc);
  if (!SWIG_IsOK(res)) { 
    %argument_fail(res,"$type",$symname, $argnum);
  }  
  $1 = %reinterpret_cast(buf, $1_ltype);
  $2 = %numeric_cast(size - 1, $2_ltype);
}
%typemap(freearg,noblock=1,match="in") (char *STRING, size_t LENGTH) {
  if (alloc$argnum == SWIG_NEWOBJ) SWIG_DeleteCharArray(buf$argnum);
}
%typemap(in) (char *STRING, int LENGTH) = (char *STRING, size_t LENGTH);
%typemap(freearg) (char *STRING, int LENGTH) = (char *STRING, size_t LENGTH);


%typemap(in,noblock=1,fragment="SWIG_SWIG_AsCharPtrAndSize")
  (char *STRING, size_t SIZE) (int res, char *buf = 0, size_t size = 0, int alloc = 0),
  (const char *STRING, size_t SIZE) (int res, char *buf = 0, size_t size = 0, int alloc = 0)
{
  res = SWIG_AsCharPtrAndSize($input, &buf, &size, &alloc);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res,"$type",$symname, $argnum);
  }
  $1 = %reinterpret_cast(buf, $1_ltype);
  $2 = %numeric_cast(size, $2_ltype);
}
%typemap(freearg,noblock=1,match="in") (char *STRING, size_t SIZE) {
  if (alloc$argnum == SWIG_NEWOBJ) SWIG_DeleteCharArray(buf$argnum);
}
%typemap(in) (char *STRING, int SIZE) = (char *STRING, size_t SIZE);
%typemap(freearg) (char *STRING, int SIZE) = (char *STRING, size_t SIZE);



%typemap(in,noblock=1,fragment="SWIG_SWIG_AsCharPtrAndSize") 
  (size_t LENGTH, char *STRING) (int res, char *buf = 0, size_t size = 0, int alloc = 0),
  (size_t LENGTH, const char *STRING) (int res, char *buf = 0, size_t size = 0, int alloc = 0)
{
  res = SWIG_AsCharPtrAndSize($input, &buf, &size, &alloc);
  if (!SWIG_IsOK(res)) { 
    %argument_fail(res,"$type",$symname, $argnum);
  }  
  $2 = %reinterpret_cast(buf, $2_ltype) ;
  $1 = %numeric_cast(size - 1, $1_ltype) ;
}
%typemap(freearg, noblock=1, match="in") (size_t LENGTH, char *STRING) {
  if (alloc$argnum == SWIG_NEWOBJ) SWIG_DeleteCharArray(buf$argnum);
}
%typemap(in) (int LENGTH, char *STRING) = (size_t LENGTH, char *STRING);
%typemap(freearg) (int LENGTH, char *STRING) = (size_t LENGTH, char *STRING);

%typemap(in,noblock=1,fragment="SWIG_SWIG_AsCharPtrAndSize")
  (size_t SIZE, char *STRING) (int res, char *buf = 0, size_t size = 0, int alloc = 0),
  (size_t SIZE, const char *STRING) (int res, char *buf = 0, size_t size = 0, int alloc = 0)
{
  res = SWIG_AsCharPtrAndSize($input, &buf, &size, &alloc);
  if (!SWIG_IsOK(res)) {
    %argument_fail(res, "$type",$symname, $argnum);
  }
  $2 = %reinterpret_cast(buf, $2_ltype) ;
  $1 = %numeric_cast(size, $1_ltype) ;
}
%typemap(freearg, noblock=1, match="in") (size_t SIZE, char *STRING) {
  if (alloc$argnum == SWIG_NEWOBJ) SWIG_DeleteCharArray(buf$argnum);
}
%typemap(in) (int SIZE, char *STRING) = (size_t SIZE, char *STRING);
%typemap(freearg) (int SIZE, char *STRING) = (size_t SIZE, char *STRING);

*/
