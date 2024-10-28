#include "processor_instructions.h"
#include "processor.h"

#include "construct.h"
#include "construct_core.h"

#include "process.h"

// =======================================================================
namespace iil {
	namespace l_prc {
		namespace l_ins {

// memory instructions ===================================================
construct* pi_get_root_mem_section(string rc, string rc_type)
{
	return $PI_MEM->get_memory_section(rc, rc_type);
}

nvp pi_new_mem(nstr root_context, nstr rc_type, nint size)
{
	return $PI_MEM->new_memory(root_context, rc_type, size);
}

nvp pi_fill_mem(nvp buffer, nvp source, nint size) 
{
	return $PI_MEM->fill_memory(buffer, source, size);
}

nvd pi_dump_memory()
{
	$PI_MEM->dump();
}

// dispatcher instructions ===============================================
construct* pi_register_construct(nstr cname, construct* parent, nstr ctype, nstr scope, nstr order, nstr add_ref)
{
	return $PI_DISP->register_construct(cname, ctype, scope, order, parent);
}

construct* pi_register_construct_relation(construct* referer, construct* referee, 
																					nstr rel_name, nstr rel_type, construct* parent_rel, 
																					nstr scope, nstr order, nstr add_ref)
{
	return NULL;
}

data_construct* pi_register_data_construct(nstr dname, nvp dvalue, nstr dtype, construct* parent, nstr scope, 
																					 nstr order)
{
	data_construct* d = (data_construct*) pi_register_construct(dname, parent, dtype, scope, order);
	if (d != NULL)
		d->set(dvalue);

	return d;
}

construct_type* pi_register_construct_type(nstr type_name, construct* base_type, nstr scope, nstr order)
{
	return NULL;
}

link* pi_register_link(nstr link_name, nstr link_type, construct* for_construct, 
										nstr link_fp_name, nvp dfp_value, nstr dfp_type)
{
	return NULL;
}

context* pi_register_context(nstr context_name, construct* parent)
{
	return NULL;
}

variable* pi_register_variable(nstr variable_name, nstr variable_type, construct* parent, nvp dvalue, nstr dtype)
{
	return NULL;
}

method* pi_register_method(nstr method_name, nstr method_type, construct* parent, nvp dfp_value, nstr dfp_type)
{
	return NULL;
}

method* pi_register_method_return_type(construct* m, nstr ret_type)
{
	return NULL;
}

method* pi_register_method_argument(construct* m, nstr arg_name, nstr arg_type, nvp arg_val)
{
	return NULL;
}

collection_construct* pi_register_collection(nstr coll_name, construct* parent, nstr col_type)
{
	return NULL;
}
// =======================================================================
/*
construct_type* register_construct_type(nstr type_name, nvp native_dfp_value, nstr dtype, construct* parent_type) 
{
	if (type_name == "")
		type_name = "unnamed_type";

	return (construct_type*) register_construct(type_name, "construct_type", parent_type, "native_type_dfp", native_dfp_value, dtype)
}

link* register_link(nstr link_name, nstr link_type, construct* for_parent_construct, nstr link_info_name, 
									nvp dfp_value, nstr dtype) 
{
	return (link*) register_construct(link_name, link_type, for_parent_construct, link_info_name, dfp_value, dtype);
}

variable* register_variable(nstr variable_name, nstr variable_type, construct* parent, 
													nvp dvalue, nstr dtype)
{
	if (variable_type == "")
		variable_type = "variable";

	return (variable*) register_construct(variable_name, variable_type, parent, "v_value", dvalue, dtype)
}


method* register_method(nstr method_name, nstr method_type, construct* parent, nvp dfp_value, nstr dfp_type)
{
	if (method_type == "")
		method_type = "method";

	return (method*) register_construct(method_name, method_type, parent, "method_ptr", dfp_value, dfp_type);
}

context* register_context(nstr context_name, construct* parent) 
{
	return (context*) register_construct(context_name, "context", parent);
}

collection_construct* register_collection(nstr coll_name, construct* parent)
{
	return (collection_construct*) register_construct(coll_name, "collection_construct", parent);
}
*/

// dispatcher level 2 instructions =======================================
link* pi_dispatch_link(link* l) // the final jump
{
	return $PI_DISP->dispatch_link(l);
} 

nvp pi_get_vvalue_native(variable* data, nstr in_type)
{
	return $PI_DISP->get_vvalue_native(data, in_type);
}

}}} 
