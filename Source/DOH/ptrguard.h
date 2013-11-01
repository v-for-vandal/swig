/* -----------------------------------------------------------------------------
 * This file is part of SWIG, which is licensed as a whole under version 3 
 * (or any later version) of the GNU General Public License. Some additional
 * terms also apply to certain portions of SWIG. The full details of the SWIG
 * license and copyrights can be found in the LICENSE and COPYRIGHT files
 * included with the SWIG source code as distributed by the SWIG developers
 * and at http://www.swig.org/legal.html.
 *
 * ptrguard.h
 *
 *     This file defines guardian over DOH* pointer
 * ----------------------------------------------------------------------------- */
#ifndef _DOH_PTR_GUARD
#define _DOH_PTR_GUARD

#include "doh.h"

// The use-case for this class is storing temporal objects. When you have temporal object, say,
// String* tmp = NewString("abc")
// it will return object with refcount equal to 1. You must later manually call Delete(tmp) before
// leaving it's scope. If you function has multiple exit points, then doing this quickly become a mess.
// DohPtrGuard attempts to solve this problem. It should be assigned NEWLY created object and it will
// automatically release it in destructor. PtrGuard DOES NOT call Incref when taking ownership.
// you MIGHT NOT assign already existing object to the guardian or you will have severe memory problems. E.g.
// this is incorrect:
// DohPtrGuard wrong( Getattr(n, "name") )
// Getattr doesn't increase refcount of return value. When 'wrong' is to be deleted, it will destroy
// attribute value and leave Node n with hanging pointer.
//
// The drawback of this class is that it can't be used directly in varargs methods because there are
// no arguments casts in vararg methods.
//   Printf( stdout, "%s", guard ) is incorrect. You have to use
//   Printf( stdout, "%s", guard.ptr() )
// Usual functions, with defined signature, has no such problems:
//   Swig_name_mangle( guard )
//
// typename T is effectively ignored, because everything is DOH*. But it is more readable to
// write
//   PtrGuard<String> string_name;
//   PtrGuard<Hash> hash_name;
// rather than
//   PtrGuard is_it_string_or_hash;
//   PtrGuard and_what_about_this_one;
template<typename T> 
class DohPtrGuard {
  public:
    // Creates guardian. Don't pass NIL - use default constructor for that
    DohPtrGuard( DOH* _ptr ):
      p_ptr(_ptr)
      {
        assert( p_ptr != 0 );
      }
    // Creates empty pointer
    DohPtrGuard():
      p_ptr(0) {}

    ~DohPtrGuard() {
      release();
    }

    // This function can be used for assigning new value to empty guard or to releasing object
    // that is guarded.
    // If guard is empty (p_ptr == 0), then you can assign any new, semantically correct ptr to it.
    // If guard is guarding some pointer, then you can only assign 0 (NIL), and guard will release
    // current object.
    void operator=( DOH* ptr ) {
      attach(ptr);
    }

    // Accessing underlying pointer
    DOH* ptr() { return p_ptr; }
    const DOH* ptr() const { return p_ptr; }
    operator DOH* () { return p_ptr; }
    operator DOH* () const { return p_ptr; }

  private:
      DOH* p_ptr; // pointer to actual object

      void attach(DOH* ptr) {
        if( p_ptr != 0 ) { // If some object already attached, then we can't attach another one
          assert(ptr == 0);
          if( ptr == 0 ) {
            release();
          }
        } else {
          p_ptr = ptr;
        }
      }

      void release() {
        if( p_ptr != 0 ) {
          Delete(p_ptr);
          p_ptr = 0;
        }
      }
    // Copying is forbiden
    DohPtrGuard( const DohPtrGuard& rhs );
    void operator=( const DohPtrGuard& rhs );

};

// Overloading DohDelete for DohPtrGuard. You might not call DohDelete on DohPtrGuard instances,
// as it is supposed to manage underlying pointer by itself

void DohDelete(const DohPtrGuard<DOH>& /*guard*/) {
  Printf( stderr, "ERROR: Attempt to delete guarded pointer without deleting it's guardian\n" );
  assert(false);
}
void DohDelete(DohPtrGuard<DOH>& /*guard*/) {
  Printf( stderr, "ERROR: Attempt to delete guarded pointer without deleting it's guardian\n" );
  assert(false);
}


#define PtrGuard DohPtrGuard

#endif
