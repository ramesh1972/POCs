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
}}
#endif