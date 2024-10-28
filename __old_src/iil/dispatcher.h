#ifndef __def_language_processor_included__
#define __def_language_processor_included__

// =======================================================================
#include "native.h"
using namespace iil::l_ntv;

#include "defs.h"
using namespace iil::l_cns;

// processor namespace ===================================================
namespace iil  {
	namespace l_prc {

// class =================================================================
class dispatcher
{
	friend processor;

private:
	processor* proc_ref;

	nvd mount();
	nvd unmount();
	nvd scan_standard_inputs();
	nvd flush_ins_and_outs();

	dispatcher(processor *p);
	~dispatcher();

	collection_construct* get_start_instructions();
	construct* dispatcher_start();
	construct* dispatcher_stop(construct* exit_code);
	
	// self routines
	nvd registerc_from_inputs();
	nvd registerc();
	nvd init();		
	construct* process(construct* cons);
	construct* process();
	nvd clean();

public:

	// mem related disps
	construct* register_construct(nstr cname, nstr ctype, nstr scope, nstr order, construct* parent);
	construct* register_construct_relation(construct* referer, construct* referee, 
																				nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
																				nstr scope = "global", nstr order = "-1", nstr add_ref = "1");

	// linker related disps
	// generic construct dispatches
	link* dispatch_get_link(construct* cons, nstr lname);
	link* dispatch_get_dnative_link(construct* cons);

	// dispatching links
	link* dispatch_nlink(construct* cons);
	link* dispatch_link(construct* cons, nstr link_xname);
	link* dispatch_link(link* lnk); // the final jump

	// instruction related
	construct* dispatch_instruction(construct* instrctn);

	// special purpose methods for standard construct_types
	// data
	link* get_dvalue(data_construct* data, nstr in_dtype = "");
	link* get_dvalue(nstr name, nstr in_dtype = "");
	data_construct* new_data(nstr dname, nvp dvalue, nstr in_dtype = "", construct* parent = NULL);
	data_construct* set_dvalue(data_construct* data, nvp dvalue, nstr in_dtype, construct* parent);

	// variables
	link* get_vvalue(variable* data, nstr in_type = "");
	link* get_vvalue(nstr vname, nstr in_vtype = "");
	nvp get_vvalue_native(variable* data, nstr in_typenvp = "");
	nvp get_vvalue_native(nstr vname, nstr in_vtypenvp = "");

	data_construct* new_variable(nstr vname, nvp vvalue, nstr in_vtype = "", construct* parent = NULL);
	data_construct* set_vvalue(variable* data, nvp dvalue, nstr dtype = "");

	// methods
	construct* execute_method(method* method, ...); // things support for ellipses
	variable* execute_method_ret_var(method* method, ...); // things support for ellipses

	data_construct* execute_method_ret_data(method* method, ...); // things support for ellipses
	link* execute_method_ret_link(method* method, ...); // things support for ellipses

private:
	// for the most basic language version: things. to move this to the language interface.
	nint args_count;
	nchrp* args_list;

	nvd set_args(nint args_c, nchrp* args);
	nint get_argsc();
	nchrp* get_args();
};
}}
#endif