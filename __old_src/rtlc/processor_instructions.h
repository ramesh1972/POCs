#ifndef __def_language_processor_instructions_included__
#define __def_language_processor_instructions_included__

// =======================================================================
#include "native.h"
using namespace __language::__native; 

#include "common_defs.h"
using namespace __language::__constructs; 

// MACROS
#define $PI_NEW_MEM(rc, rct, n) __language::__processor::__instructions::pi_new_mem(rc, rct, n)
#define $PI_FILL_MEM(b, s, sz) __language::__processor::__instructions::pi_fill_mem(b, (nvp) &s, sz)

// =======================================================================
namespace __language {
	namespace __processor {
		namespace __instructions {

// processor instructions ================================================
// memory instructions ===================================================
construct* pi_get_root_mem_section(string rc, string rc_type);
nvp pi_new_mem(nstr root_context, nstr rc_type, nint size);
nvp pi_fill_mem(nvp buffer, nvp source, nint size); 
nvd pi_dump_memory();

// dispatcher instructions ===============================================
// VERY IMPORTANT : THE FIRST INTERFACE TO/FROM THE USER CODE....
// level 1 instructions  ========================
// language constructs creation =================
construct* pi_register_construct(nstr cname, construct* parent = NULL, nstr ctype = "construct", nstr scope = "global", nstr order = "-1", nstr add_ref = "1");
construct* pi_register_construct_relation(construct* referer, construct* referee, 
																					nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
																					nstr scope = "global", nstr order = "-1", nstr add_ref = "1");

data_construct* pi_register_data_construct(nstr dname, nvp dvalue = NULL, nstr dtype = "dvp", construct* parent = NULL, nstr scope = "global", 
																					 nstr order = "-1");
construct_type* pi_register_construct_type(nstr type_name, construct* base_type = NULL, nstr scope = "global", nstr order = "-1");
link* pi_register_link(nstr link_name, nstr link_type = "link", construct* for_construct = NULL, 
										nstr link_fp_name = "", nvp dfp_value = NULL, nstr dfp_type = "dfp");

context* pi_register_context(nstr context_name, construct* parent = NULL);
variable* pi_register_variable(nstr variable_name, nstr variable_type = "", construct* parent = NULL, nvp dvalue = NULL, nstr dtype = "");
method* pi_register_method(nstr method_name, nstr method_type = "", construct* parent = NULL, nvp dfp_value = NULL, nstr dfp_type = "");
method* pi_register_method_return_type(construct* m, nstr ret_type = "dvp");
method* pi_register_method_argument(construct* m, nstr arg_name, nstr arg_type = "dvp", nvp arg_val = NULL);

collection_construct* pi_register_collection(nstr coll_name, construct* parent = NULL, nstr col_type = "collection_construct");

// access =======================================
collection_construct* traverse(nstr root_context, nstr name);
collection_construct* traverse_types_info(nstr types);
collection_construct* traverse_ctype_links(nstr ctype);

// level 2 instructions ==================================================
// core dispatch functions ======================
link* pi_dispatch_link(link* l);
nvp pi_get_vvalue_native(variable* data, nstr in_type = "");

/*
// dispatch of generic constructs, init, process, clean mode.....
// task is essentially an instruction.
construct* dispatch_task(construct* cons, nstr task) {return NULL;}
construct* dispatch_native(construct* cons, nstr task) {return NULL;}

link* dispatch_get_link(construct* cons, nstr task) {return NULL;}
link* dispatch_get_dnative_link(construct* cons) {return NULL;}

// special purpose methods ====================================
// construct_types
link* get_dvalue(data_construct* data, nstr in_dtype = "") {return NULL;}
link* get_dvalue(nstr name, nstr in_dtype = "") {return NULL;}

data_construct* new_data(nstr dname, nvp dvalue, nstr in_dtype = "", construct* parent = NULL) {return NULL;}
data_construct* set_dvalue(data_construct* data, nvp dvalue, nstr in_dtype, construct* parent) {return NULL;}

link* get_vvalue(variable* data, nstr in_type = "") {return NULL;}
link* get_vvalue(nstr vname, nstr in_vtype = "") {return NULL;}

data_construct* new_variable(nstr vname, nvp vvalue, nstr in_vtype = "", construct* parent = NULL) {return NULL;}
data_construct* set_vvalue(variable* data, nvp dvalue, nstr dtype = "") {return NULL;}

variable* execute_method(method* method, ...) {return NULL;} // things support for ellipses
data_construct* execute_method_data(method* method, ...) {return NULL;} // things support for ellipses
*/
}}}
#endif