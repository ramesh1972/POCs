#ifndef __def_language_constructs_interface_included__
#define __def_language_constructs_interface_included__

// =======================================================================
#include "native.h"
using namespace iil::l_ntv;

#include "defs.h"

// =======================================================================
namespace iil {
	namespace l_cns {
		namespace l_ins {

// main instructions =====================================================
construct* ci_create_construct(nstr cname, nstr ctype="construct", construct* parent = NULL, nstr scope="context", nstr order="-1");
construct* ci_add_relative(nstr referee_name, nstr referee_type, nvp referee_value, construct* referer, 
													 nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
													 nstr scope = "construct", nstr order = "-1", nstr add_ref="1");
construct* ci_add_relative(construct* referer, construct* referee, 
													nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
													nstr scope = "construct", nstr order = "-1", nstr add_ref="1");

nvd ci_add_ref(rel_construct* rel, nstr ref_name, nstr ref_type = "");
nvd ci_remove_ref(rel_construct* rel); 

construct* ci_new_cons(nstr btype); // the base type like method, construct_type should be passed
nint ci_get_construct_size(nstr btype);
construct* ci_get_root_mem(nstr ctype);
nstr ci_get_root_mem_name(nstr ctype);
nbln ci_is_supported_construct_type(nstr btype);

}}}

// MACROS for CI
// copy from a empty construct instance on the native stack and copy it to a new void buffer
// and then recast that buffer to the cl type and return
#define $CI_NEW_CONS(Ct) \
{ \
		construct* ret = NULL; \
		nint size_c = ci_get_construct_size(#Ct); \
		nstr rc = "_stack_m"; \
		nstr rc_type = ci_get_root_mem_name(#Ct); \
		nvd* vc = $PI_NEW_MEM(rc, rc_type, size_c); \
		Ct c; \
		$PI_FILL_MEM(vc, c, size_c); \
		return (Ct*) vc; \
} 









// OLD Language macros ====================================================
// declarations ===============
#define $dc(P, N, T, V, Td) 	T* v##N = create_construct(#N, v##P, #T, V, #Td); v##N
#define $dv(P, N, T, V, Td)		variable* v##N = (variable*) create_construct(#N, v##P, #T, V, #Td); v##N
#define $dm(P, N, T)			method* v##N = (method*) create_construct(#N, v##P, #T, N, "gmethod"); v##N
#define $dva(M, N, T, D)	v##M->add_argument(#N, #T, D); v##N
#define $dt(P, N, Fp)			construct_type* v##N = (construct_type*) __cl::create_construct_type(#N, Fp, "dfp", v##P);
#define $dn(P, N)					context* v##N = (context*) __cl::create_construct_type(#N, NULL, "context", v##P); v##N
#define $dl(P, N, T, Fp)  link* v##N = (link*) create_construct(#N, v##P, #T, V, "dcfptr"); v##N

// constructs - access macros ===============
// - using $MEM-directly from memory. name or xpath
#define $xc(Np, T, Deep)	($MEM->$cc(Np, T, Deep))

// - child constrct, using construct with -> and then child as name or xpath...
#define $cc(Np, T, Deep)	ccs()->get_childc(#Np, #T, Deep)
#define $cv(Np, Deep) $cc(Np, variable, Deep)
#define $cm(Np, Deep) $cc(Np, method, Deep)
#define $cma(Np, Deep) get_argument(#Np)
#define $cl(Np, Deep) $cc(Np, link, Deep)
#define $cln(Np, Deep) get_native_link()
#define $ct(Np, Deep) $cc(P, Np, type_info, Deep)

// - using construct within the macro and then child as name or xpath...
#define $pc(P, Np, Tp, Deep) (P->$cc(Np, Tp, Deep))

// casting ===============
#define $c(C) ((construct*) C)
#define $v(C) ((variable*) C)
#define $m(C) ((method*) C)
#define $l(C) ((link*) C)
#define $lg(C) ((link_global_function*) C)
#define $t(C) ((construct_type*) C)
#define $a(C) ((variable*) C)
#define $ctx(C) ((context*) C)
#define $d(X) ((nvp) X)

// key macros ============================================================
// method/links ==========
#define $_jm(P, M)  (*((method*) $pc(P, M, method, match_first)))
#define $_jl(C, L, T)  (T*) ((C->$cl(L, match_first)))
#define $_cast(T) get(#T)()
#define $_castn get()()

// accessing value ==========
#define $_v  get()()   // value
#define $_vn(T) get(#T)() 
#define $_sv(v) V->set_buffer((nvp) v)

#endif