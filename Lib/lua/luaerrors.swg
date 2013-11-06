/* -----------------------------------------------------------------------------
 * error manipulation
 * ----------------------------------------------------------------------------- */
SWIGRUNTIME const char*
SWIG_Lua_ErrorType(int code ) {
  switch (code) {
  case SWIG_MemoryError:
    return "SWIG_MemoryError";
  case SWIG_IOError:
    return "SWIG_IOError";
  case SWIG_RuntimeError:
    return "SWIG_RuntimeError";
  case SWIG_IndexError:
    return "SWIG_IndexError";
  case SWIG_TypeError:
    return "SWIG_TypeError";
  case SWIG_DivisionByZero:
    return "SWIG_DivisionByZero";
  case SWIG_OverflowError:
    return "SWIG_OverflowError";
  case SWIG_SyntaxError:
    return "SWIG_SyntaxError";
  case SWIG_ValueError:
    return "SWIG_ValueError";
  case SWIG_SystemError:
    return "SWIG_SystemError";
  case SWIG_AttributeError:
    return "SWIG_AttributeError";
  default:
    return "UnknownErrorType";
  }
}
