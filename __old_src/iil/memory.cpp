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
	_proc_m = l_ins::pi_register_context("_processor_m");

	// create the basic contruct types that are required for the boot constructs.
	construct* cons = l_ins::pi_register_construct_type("construct", _proc_m);
		construct* ctxcons = l_ins::pi_register_construct_type("context", cons);

	// set the context
	context* disp_m = l_ins::pi_register_context("_dispatcher_m", _proc_m);
		l_ins::pi_register_context("_types_m", disp_m);
		l_ins::pi_register_context("_constructions_m", disp_m);
		l_ins::pi_register_context("_data_m", disp_m);
	context* stack_m = l_ins::pi_register_context("_stack_m", _proc_m);
		context* s_types = l_ins::pi_register_context("_types_m", stack_m);
		context* s_constructs = l_ins::pi_register_context("_constructions_m", stack_m);
		l_ins::pi_register_context("_data_m", stack_m);
	context* heap_m = l_ins::pi_register_context("_heap_m", _proc_m);
		construct* t = l_ins::pi_register_context("_types_m", heap_m);
		l_ins::pi_register_context("_constructions_m", heap_m);
		l_ins::pi_register_context("_data_m", heap_m);

	// the types of cons and ctxcons would not be set.
	construct* tcons = l_ins::pi_register_construct_type("construct_type", cons);
	cons->set_type((construct_type*) tcons);
	tcons->set_type((construct_type*) tcons);

	// This is the context in which the process starter methods are set.
	// this interface puts in default start methods in this, which can be overridden
	context* st_cons = l_ins::pi_register_context("_starter_constructs_m", s_constructs);
			l_ins::pi_register_context("_processor_default_", st_cons);

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
	construct* c = l_cns::l_ins::ci_create_construct(cname, ctype, parent, scope, order);
	return c;
}


construct* memory::register_construct_relation(construct* referer, construct* referee, 
																							nstr rel_name, nstr rel_type, construct* parent_rel, 
																							nstr scope, nstr order, nstr add_ref)
{
	construct* c = l_cns::l_ins::ci_add_relative(referer, referee, rel_name, rel_type, parent_rel, scope, order, add_ref);
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
}}
