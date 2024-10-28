#include "processor.h"
#include "processor_instructions.h"

#include "construct.h"
#include "construct_core.h"
#include "constructs_instructions.h"

#include "constructs_linker.h"
using namespace iil::l_cns::l_lnk;

// =======================================================================
namespace iil {
	namespace l_prc {

// dispatcher class functions ============================================
dispatcher::dispatcher(processor *p) 
{
	proc_ref=p;
	args_count = 0;
	args_list = NULL;
}

dispatcher::~dispatcher() 
{
	proc_ref = NULL;
	args_count = 0;
	args_list = NULL;
}

nvd dispatcher::mount()
{
	scan_standard_inputs();
}

nvd dispatcher::unmount()
{
	flush_ins_and_outs();
}

nvd dispatcher::scan_standard_inputs()
{
}

nvd dispatcher::flush_ins_and_outs()
{
}

nvd dispatcher::set_args(nint args_c, nchrp* args) 
{
	args_count = args_c;
	args_list = args;
}
nint dispatcher::get_argsc() {return args_count;}
nchrp* dispatcher::get_args() {return args_list;}

// =======================================================================
construct* dispatcher::dispatcher_start()
{
	//__pl::test_boot_constructs();

	// read in all the constructs
	$PI_PROC->registerc();

	// read the main link..
	construct* exit_code = NULL;
	collection_construct* _start = get_start_instructions();

	// ok the user or the interface has given start instrctns
	if (_start != NULL)
	{
		map<nstr, construct*>::iterator its = _start->construct_list->begin();

		for (its = _start->construct_list->begin(); its != _start->construct_list->end(); its++)
		{
			// iterate through the methods and execute them
			method* m = (method*) its->second;

			link* exec_link = execute_method_ret_link(m);
			exit_code = dispatch_link(exec_link);
		}
	}
	else
	{ // ok the user or the interface has NOT given start instrctns
		// start the hardcoded default
		proc_ref->init();
		exit_code = proc_ref->process();
		proc_ref->clean();
	}

	return exit_code;
}

collection_construct* dispatcher::get_start_instructions()
{
	// check if there is any dispatch instrctns
	// assume none.

	// get the defualt start methods
	construct* sc = $PI_MEM_C(_stack_m, _constructions_m);
	context* defaults = (context*) (*sc)["_processor_default_"];

	if (defaults != NULL)
		return defaults->relations();

	return NULL;
}

construct* dispatcher::dispatcher_stop(construct* exit_code)
{
	return exit_code;
}

// =======================================================================
// things: determing where the input has come from and then accordingly start the right process instance..
nvd dispatcher::registerc()
{
	// read from standard inputs and registerc constructs
	registerc_from_inputs();
}

nvd dispatcher::init() 	
{
}

construct* dispatcher::process(construct* cons) {return NULL;}
construct* dispatcher::process() {return NULL;}

nvd dispatcher::clean() 	
{
}

nvd dispatcher::registerc_from_inputs()
{
}

// =======================================================================
// generic construct dispatches
// mem related
construct* dispatcher::register_construct(nstr cname, nstr ctype, nstr scope, nstr order, construct* parent)
{
	return $PI_MEM->register_construct(cname, ctype, scope, order, parent);
}

construct* dispatcher::register_construct_relation(construct* referer, construct* referee, 
																				nstr rel_name, nstr rel_type, construct* parent_rel, 
																				nstr scope, nstr order, nstr add_ref)
{
	return $PI_MEM->register_construct_relation(referer, referee, rel_name, rel_type, parent_rel, scope, order, add_ref);
}

// linker related
construct* dispatcher::dispatch_instruction(construct* instrctn) {return NULL;}
link* dispatcher::dispatch_get_link(construct* cons, nstr instrctn) {return NULL;}
link* dispatcher::dispatch_get_dnative_link(construct* cons) {return NULL;}

// dispatching links
link* dispatcher::dispatch_nlink(construct* cons) 
{
	if (cons == NULL)
		return NULL;

	construct_type* bt = cons->type()->get_base_construct_type();
	nstr bname;
	if (bt == NULL)
		bname = cons->type_str();
	else
		bname = bt->type_str();
	
	if (bname == "variable")
		return (link*) ((variable*) cons)->getnl();

	return (link*) cons->process();
}

link* dispatcher::dispatch_link(construct* cons, nstr instrctn) 
{
	if (cons == NULL)
		return NULL;

	link* l = (link*) cons->process(instrctn);
	link* ret = dispatch_link(l);
	return ret;
}

link* dispatcher::dispatch_link(link* lnk) 
{
	$PI_LNK->jump_link(lnk);

	// things: if failed, then try pl, native, cl, user...
	// things: check if it exists in an other related processor??
	
	return lnk;
} // the final jump

// =======================================================================
// construct_types related
// data
link* dispatcher::get_dvalue(data_construct* data, nstr in_dtype) {return NULL;}
link* dispatcher::get_dvalue(nstr name, nstr in_dtype) {return NULL;}

data_construct* dispatcher::new_data(nstr dname, nvp dvalue, nstr in_dtypenvp, construct* parent) {return NULL;}
data_construct* dispatcher::set_dvalue(data_construct* data, nvp dvalue, nstr in_dtype, construct* parent){return NULL;} 

// variable
link* dispatcher::get_vvalue(variable* data, nstr in_typenvp) {return NULL;}
link* dispatcher::get_vvalue(nstr vname, nstr in_vtypenvp) {return NULL;}

nvp dispatcher::get_vvalue_native(variable* data, nstr in_typenvp)
{
	return data->getn();
}

nvp dispatcher::get_vvalue_native(nstr vname, nstr in_vtypenvp);

data_construct* dispatcher::new_variable(nstr vname, nvp vvalue, nstr in_vtypenvp, construct* parent) {return NULL;}
data_construct* dispatcher::set_vvalue(variable* data, nvp dvalue, nstr dtypenvp) {return NULL;}

// methods
construct* dispatcher::execute_method(method* method, ...) {return NULL;}
variable* dispatcher::execute_method_ret_var(method* method, ...) {return NULL;}

link* dispatcher::execute_method_ret_link(method* m, ...)
{
	return m->set_up_exec_link(); 
}
}}