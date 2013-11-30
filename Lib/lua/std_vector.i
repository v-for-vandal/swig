/* -----------------------------------------------------------------------------
 * std_vector.i
 *
 * std::vector typemaps for LUA
 * ----------------------------------------------------------------------------- */
%fragment("StdVectorTraits","header",fragment="StdSequenceTraits")
%{
  namespace swig {
    template <class T>
    struct traits_asptr<std::vector<T> >  {
      static int asptr(lua_State *L, int obj, std::vector<T> **vec) {
	return traits_asptr_stdseq<std::vector<T> >::asptr(L, obj, vec);
      }
    };
    
    template <class T>
    struct traits_from<std::vector<T> > {
      static void from(lua_State *L, const std::vector<T>& vec) {
	return traits_from_stdseq<std::vector<T> >::from(L,vec);
      }
    };
  }
%}

#define %swig_vector_methods(Type...) %swig_sequence_methods(Type)
#define %swig_vector_methods_val(Type...) %swig_sequence_methods_val(Type);

%include <std/std_vector.i>
