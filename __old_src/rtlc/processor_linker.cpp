#include "processor_linker.h"

// ========================================================================
namespace __language {
	namespace __processor {
		namespace __linker {

// processor related =====================================================
// all native links registration should go here. 
nvd registerc() {} 

// class linker_object ====================================================
linker_object::linker_object()  {}
linker_object::~linker_object() {}

// runtime ==================
nvd linker_object::set_link(link* link_info) {}

nvp linker_object::init() {return NULL;}
nvd linker_object::clean() {}

// class ===================================================================
// setting and getting, for the native fp...
nvd tmpl_linker_object_global_function::set(nvp native_fp) 
{
	dfp_value = native_fp;
}

// for methods
nvd tmpl_linker_object_global_function::convert_params_to_native() {}
nvp tmpl_linker_object_global_function::get_return()
{
	return ret_value;
}

nvp tmpl_linker_object_global_function::process(...) {return NULL;} 

}}}






