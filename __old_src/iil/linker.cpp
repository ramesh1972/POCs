#include "processor_linker.h"

// ========================================================================
namespace iil {
	namespace l_prc {
		namespace l_lnk {

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

// =======================================================================
linker::linker(processor* p) : proc_ref(p) {}
linker::~linker() {}

nvd linker::mount() {}
nvd linker::unmount() {}

nvd linker::registerc() 
{
	l_cns::l_lnk::registerc();
	l_prc::l_lnk::registerc();
	l_cns::l_lnk::register_default_start_methods();
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

}}}






