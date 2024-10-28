#pragma warning(disable:4786)
#pragma warning(disable:4700)
#pragma warning(disable:4800)

#ifndef __def_language_native_included__
#define __def_language_native_included__

/* overview ==========================================================
as of now this is a very simple implementation of the native. This will
be upgraded to an "native common layer" with interface between the processor and
the native system. This interface would be a collection of abstract links 
(of any linkage type).
*/

// native incluides ==================================================
#include <string>
#include <list>
#include <map>
using namespace std;

// ===================================================================
namespace __language {
	namespace __native {

// native data types ==============================
typedef void nvd;
typedef nvd* nvp;
typedef int nint;
typedef string nstr;
typedef char*  nchrp;
typedef bool nbln;

typedef nvp (nvp_fp)();
typedef nvp (nvp_fp_nvp)(nvp);
typedef nvp (nvp_fp_nstr)(nstr);
typedef nvp (nvp_fp_nchrp)(nchrp);

typedef nint (nint_fp_nvp)(nvp ptr);
typedef nstr (nstr_fp_nvp)(nvp ptr);
typedef nbln (nbln_fp_nvp)(nvp ptr);
typedef nchrp (nchrp_fp_nvp)(nvp ptr);

// native macros =================================
// helper macros
#define $ct2vp(v) ((vp*) &v)
#define $vp2ct(X, v) ((X*) v)
#define $reref(X, ptr) (*((X*) ptr))
#define $NI_deref(ptr) (*ptr)
#define find_criteria(X) (match_criteria)(X)

// enums =========================================
enum match_criteria {
	match_deep = 1,
	match_first = 2,
	match_last = 4, 
	match_from_left = 8,
	match_from_right = 16,
	match_from_top = 32,
	match_from_bottom = 64,
	match_next = 128
};

/*
nvp get_nvp() {return NULL;}
nvp get_nvp(nvp ptr) {return ptr;}
nvp get_nvp(nstr ptr) {return (nvp) ptr;}
nvp get_nvp(nchrp ptr) {return (nvp) ptr;}
nvp get_nvp(nint ptr) {return (nvp) ptr;}
nvp get_nvp(nbln ptr) {return (nvp) ptr;}

nint get_nint(nvp ptr) {return (nint) ptr;}
nstr get_nstr(nvp ptr) {return *((nstr*) ptr);}
nbln get_nbln(nvp ptr) {return (nbln) ptr;}
nchrp get_nchrp(nvp ptr) {return (nchrp) ptr;}
*/
}}
#endif