#include "processor.h"
#include "processor_instructions.h"

#include "construct.h"
#include "construct_core.h"
#include "constructs_instructions.h"

#include "constructs_linker.h"
using namespace __language::__constructs::__linker;

// =======================================================================
namespace __language {
	namespace __processor {

// =======================================================================
processor* processor::__proc = NULL;

// generic static accessors ==============================================
processor* processor::p() { return __proc; }
dispatcher* processor::d() 
{ 
	if (p() != NULL) 
		return p()->__disp; 

	return NULL;
}

memory* processor::m() 
{ 
	if (p() != NULL)
		return p()->__memory; 
	
	return NULL;
}

linker* processor::l() 
{ 
	if (p() != NULL)
		return p()->__linker; 
	
	return NULL;
}

// =======================================================================
// S T A R T     H E R E     F O R    A L L    T Y P E S  OF  PROCESSORS
// - Called from main() the following function
nint processor::create_processor()
{
	// create the global processor object (singleton) and boot
	if (__proc == NULL)
		__proc = new processor(); // boot() is automatically called.

	// start the processor......
	__proc->mount();
	__proc->run();
	__proc->unmount();

	// =========================================
	// STOP. THIS IS THE   F I N A L   SHUT DOWN
	delete __proc;

	return 1;
}
// =======================================================================

// boot sequence =========================================================
processor::processor() {boot();}
processor::~processor() {shutdown();}

nvd processor::boot()
{
	// return control to main
	printf("done startup\n");
	return;
}

nvd processor::shutdown()
{
	if (__proc == NULL)
		return;
	
	__proc->unmount();

	printf("done shutdown\n");
}

nvd processor::mount()
{
	__disp = new dispatcher(this);
	__disp->mount();

	__memory = new memory(this);
	__memory->mount();

	__linker= new linker(this);
	__linker->mount();
}

nvd processor::unmount()
{
	if (__proc == NULL)
		return;

	__disp->unmount();
	__memory->unmount();
	__linker->unmount();
	
	delete __disp;
	delete __memory;
	delete __linker;

	__disp = NULL;;
	__memory = NULL;
	__linker = NULL;

	__proc = NULL;
	printf("done stop\n");
}

// =======================================================================
nvd processor::run()
{
	construct* exit_code = __disp->dispatcher_start();
	__disp->dispatcher_stop(exit_code);
}

nvd processor::registerc()
{
	// register __disp and memory contructs for this instance of the processor.h first..
	$PI_MEM->registerc();
	$PI_LNK->registerc();
	$PI_DISP->registerc();
	
	// IMPORTANT::
	// at this point all registrations of constructs available should be done.
	// good point to take a dump of the memory.
	$PI_MEM_DMP
}

nvd processor::init() 	
{
	__disp->init();
	__memory->init(); 
	__linker->init();
}

construct* processor::process(construct* instrctn) {return NULL;}
construct* processor::process() {return NULL;}

nvd processor::clean() 	
{
	__disp->clean();
	__memory->clean();
	__linker->clean();
}

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

// memory class ==========================================================
memory::memory(processor* p ) : proc_ref(p)
{
	reset_sections();
}

memory::~memory()
{
	proc_ref = NULL;
	reset_sections();
}

nvd memory::reset_sections()
{
  _proc_m = NULL;
}

nvd memory::mount()
{	
	create_memory();
}

nvd memory::unmount()
{	
	destroy_memory();
}

nvd memory::create_memory() 
{
} // things:control over the heap.

nvd memory::destroy_memory() 
{
} // things; 		// things: IMPORTANT: To delete the actual memory of the constructs

// =======================================================================
nvd memory::registerc()
{
	// create the _proc_m procs...in the boot mem..
	_proc_m = __instructions::pi_register_context("_processor_m");

	// create the basic contruct types that are required for the boot constructs.
	construct* cons = __instructions::pi_register_construct_type("construct", _proc_m);
		construct* ctxcons = __instructions::pi_register_construct_type("context", cons);

	// set the context
	context* disp_m = __instructions::pi_register_context("_dispatcher_m", _proc_m);
		__instructions::pi_register_context("_types_m", disp_m);
		__instructions::pi_register_context("_constructions_m", disp_m);
		__instructions::pi_register_context("_data_m", disp_m);
	context* stack_m = __instructions::pi_register_context("_stack_m", _proc_m);
		context* s_types = __instructions::pi_register_context("_types_m", stack_m);
		context* s_constructs = __instructions::pi_register_context("_constructions_m", stack_m);
		__instructions::pi_register_context("_data_m", stack_m);
	context* heap_m = __instructions::pi_register_context("_heap_m", _proc_m);
		construct* t = __instructions::pi_register_context("_types_m", heap_m);
		__instructions::pi_register_context("_constructions_m", heap_m);
		__instructions::pi_register_context("_data_m", heap_m);

	// the types of cons and ctxcons would not be set.
	construct* tcons = __instructions::pi_register_construct_type("construct_type", cons);
	cons->set_type((construct_type*) tcons);
	tcons->set_type((construct_type*) tcons);

	// This is the context in which the process starter methods are set.
	// this interface puts in default start methods in this, which can be overridden
	context* st_cons = __instructions::pi_register_context("_starter_constructs_m", s_constructs);
			__instructions::pi_register_context("_processor_default_", st_cons);

	// since the stack_m will be wrongly available during the creation of types, we need to set the type explicitly,
	// otherwise it will be null.
	s_types->set_type((construct_type*) ctxcons);

	// put all this in place.
	// move and set the parent of construct_type construct to that of the stack\types_m...
	move_child_construct(cons, s_types); 
}

nvd memory::init() 	
{
	// now all the basic construct types, root contexts and correspoding dtypes are complete.
	// move the whole thing out of the boot memory ninto the proc memory
/*	construct* p_m = $NI_deref(_boot_memory)["_processor_m"];
	remove_child_construct(p_m);
	_proc_m = p_m;

	delete_construct(_boot_memory);
	_boot_memory = NULL;
*/
}

construct* memory::process() {return NULL;}

nvd memory::clean() 	
{
}

// ============================================================
construct* memory::get_memory_section(nstr rc, nstr rc_type)
{
	// get root context
	construct* ret_m = NULL;

	// set the root context for search
	construct* parent = NULL;

	// if this is called during boot stage..mostly
	if (_proc_m != NULL)
		parent = _proc_m;

	// if _proc_m was requested then return the parent
	if (rc == "_proc_m" || rc == "")
		return parent;

	// if a particular rc, rc_type is requested then this code is reached.
	// e.g. stack, constructs or heap, data.

	construct* rc_c = NULL;
	if (parent != NULL && parent->relations() != NULL)
	{
		rc_c = $NI_deref(parent)[rc];

		if (rc_c != NULL)
		{
			ret_m = $NI_deref(rc_c)[rc_type];
			if (ret_m == NULL)
				ret_m = rc_c;
		}
		else
			ret_m = parent;
	}

	// This should return the best available memory 
	return ret_m;
}

nvd memory::dump() 
{
	if (_proc_m != NULL)
	{
		_proc_m->dump_deep();
		return;
	}
}

// =======================================================================
construct* memory::register_construct(nstr cname, nstr ctype, nstr scope, nstr order, construct* parent)
{
	construct* c = __constructs::__instructions::ci_create_construct(cname, ctype, parent, scope, order);
	return c;
}


construct* memory::register_construct_relation(construct* referer, construct* referee, 
																							nstr rel_name, nstr rel_type, construct* parent_rel, 
																							nstr scope, nstr order, nstr add_ref)
{
	construct* c = __constructs::__instructions::ci_add_relative(referer, referee, rel_name, rel_type, parent_rel, scope, order, add_ref);
	return c;
}

nvp memory::new_memory(nstr root_context, nstr rc_type, nint size)
{
	nvp cspace = allocate_memory(size);
	return cspace;
}

nvd* memory::allocate_memory(nint size) 
{
	nvp ptr = new char[size];
	return (nvp) ptr;
}

nvd* memory::fill_memory(nvp buffer, nvp source, nint size) 
{
	memcpy(buffer, source, size);
	return buffer;
}

nvd memory::delete_construct(construct* cons)
{
}

// =======================================================================
nvd memory::move_child_construct(construct* cons, construct* new_parent)
{
	// remove it from the original parent and add it to the new parent
	if (cons == NULL || new_parent == NULL)
		return;

	remove_child_construct(cons);
	cons->set_owner(new_parent);
}

nvd memory::remove_child_construct(construct* cons)
{
	if (cons == NULL || cons->owner == NULL)
		return;

	cons->owner()->relations()->remove_childc(cons);
}

// =======================================================================
collection_construct* memory::traverse(construct*, nstr type) {return NULL;}
collection_construct* memory::traverse_types_info(construct*, nstr type) {return NULL;}
collection_construct* memory::traverse_ctype_links(construct*, nstr type) {return NULL;}

// =======================================================================
linker::linker(processor* p) : proc_ref(p) {}
linker::~linker() {}

nvd linker::mount() {}
nvd linker::unmount() {}

nvd linker::registerc() 
{
	__constructs::__linker::registerc();
	__processor::__linker::registerc();
	__constructs::__linker::register_default_start_methods();
}

nvd linker::init() {}
construct* linker::process(link* l) {return NULL;}
construct* linker::process(...) {return NULL;}
nvd linker::clean() {}

// =======================================================================
nvp linker::jump_link(link* l) 
{
	if (l == NULL)
		return NULL;

	if (l->name() == "link_function" ||
			l->name() == "link_data")
	{
		nstr lo_name = l->get_fptr_type();

		tmpl_linker_object_global_function* lo = (tmpl_linker_object_global_function*) dtypes_links[lo_name];
		lo->set(l->get_fptr());
		lo->linking_info = l;

		// set the params
		collection_construct* paramsl = l->relations();

		int i = 0;
		map<nstr, construct*>::iterator its = paramsl->construct_list->begin();

		for (its = paramsl->construct_list->begin(); its != paramsl->construct_list->end(); its++)
		{
			construct* c = ((construct*) its->second);
			if (c == NULL)
				continue;

			lo->params[i] = ((data_construct*) c)->_dc_buf; 
		}

		nvp ret = lo->process();

		l->set_ret_value(ret);
		return ret;
	}

	return NULL;
}

nvp linker::add_linker(linker_object* lnkr)
{
	if (lnkr != NULL)
		dtypes_links[lnkr->linker_name] = lnkr; 
 
	return NULL;
}
}}