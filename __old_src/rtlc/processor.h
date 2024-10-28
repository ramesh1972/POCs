#ifndef __def_language_processor_included__
#define __def_language_processor_included__

// =======================================================================
#include "native.h"
using namespace __language::__native;

#include "common_defs.h"
using namespace __language::__constructs;

// processor namespace ===================================================
namespace __language  {
	namespace __processor {

// class processor =======================================================
/* an application can be lauched 
	- with the link/method name and arguments 
	- with a file name while the links/constructs exist
	- xml input
		- from io
		- from file
	- db connection params/db constructs */
class processor
{
private:	
// calling a global method or displaying a variable etc..
	processor();

	// singleton instance of the language construct processor, 
	// with the dispatcher and memory
	static processor* __proc;

	// the main routines of the language/lib processor
	dispatcher* __disp; 
	linker* __linker;
	memory* __memory;

	nvd boot();
	nvd shutdown();
	nvd mount();
	nvd unmount();
	nvd run();

	// ======================================================================
	// S T A R T     H E R E     F O R    A L L    T Y P E S  OF  PROCESSORS
	// - Call from main() the following function
	static nint create_processor();
	// ======================================================================

	// user interface related
	map<string, processor_language*> _languages; // a collection of languages (Singletons) using which
	// code can be written and processed. Also in the collection is native language.

	map<string, user_code_sections*> _sections;	// a collection of sections within code pages which 
																		// hold code in different languages, 
																		// for different processes and users.
public:
	~processor();

public:
	static processor* processor::p();
	static dispatcher* processor::d();
	static memory* processor::m();
	static linker* processor::l();

	nvd registerc();	
	nvd init();		
	construct* process();
	construct* process(construct* instrctn);
	nvd clean();
};

// class =================================================================
// forwards
namespace __linker { class linker_object; }
using namespace __linker;

class linker
{
	friend processor;

private:
	linker(processor* p);
	~linker();
	
	processor* proc_ref;

	// collection of supported data/construct types and their native links...
	map<string, linker_object*> dtypes_links;

	nvd mount();
	nvd unmount();

	nvd registerc();
	nvd init();		
	construct* process(link*);
	construct* process(...);
	nvd clean();

public:	
	nvp jump_link(link* l);

	nvp add_linker(linker_object* lnkr);
	nvp remove_linker(linker_object* lnkr);
	linker_object* remove_linker(string lnkr_name);
};

// class =================================================================
class memory
{
	friend processor;

private: 
	memory(processor* p); // only the processor can create
	~memory();

	processor* proc_ref;
	construct* _proc_m;

	nvd mount();
	nvd unmount();

	nvd registerc();
	nvd init();		
	construct* process();
	nvd clean();

public:
	construct* register_construct(nstr cname, nstr ctype, nstr scope, nstr order, construct* parent);
	construct* register_construct_relation(construct* referer, construct* referee, 
																				nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
																				nstr scope = "global", nstr order = "-1", nstr add_ref = "1");
	nvd delete_construct(construct* cons); 
	
	construct* get_memory_section(nstr rc, nstr rc_type);
	nvp new_memory(nstr root_context, nstr rc_type, nint size);
	nvd* fill_memory(nvp buffer, nvp source, nint size) ;

	nvd move_child_construct(construct* cons, construct* new_parent); 
	nvd remove_child_construct(construct* cons); 

	collection_construct* traverse(construct*, string type);
	collection_construct* traverse_types_info(construct*, string type);
	collection_construct* traverse_ctype_links(construct*, string type);

	nvd dump();

private:
	nvd create_memory(); 
	nvd destroy_memory();
	
	nvp allocate_memory(nint size);
	nvd reset_sections();
};

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