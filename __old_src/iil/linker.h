#ifndef __def_language_processor_linker_included__
#define __def_language_processor_linker_included__

// =======================================================================
#include "native.h"
using namespace iil::l_ntv; 

#include "defs.h"
using namespace iil::l_cns; 

// =======================================================================
namespace iil {
	namespace l_prc {
		namespace l_lnk {

// processor callbacks =======================	
nvd registerc(); // to register the core processors constructs..

// class =================================================================
// forwards
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

// ========================================================================
class linker_object // basic support for a global function call. advanced links should be 
										// derived from this..
{
public:
	link* linking_info; 
	nstr linker_name;

public:
	linker_object();
	~linker_object();

	// runtime
	nvd set_link(link* link_info);

	virtual nvp init(); 
	virtual nvp process(...) = 0; // this should be overriden by a specfic type of 
														 // linking object, like global method, or a class object etc..
	nvd clean();

	virtual nvd set(nvp native_fp) = 0;
};

// =============================================================================
class tmpl_linker_object_global_function : public linker_object
{
	protected:
		nvp ret_value;
		nvp dfp_value;	
	public:
		map<int, nvp> params;

		// refs to the link_info collection of data_constructs...
		data_construct* dfp_ref; 
		data_construct* retd_ref;
		data_construct* params_ref;

	public:
		// setting and getting, for the native fp...
		virtual nvd set(nvp native_fp);
		
		// for methods
		nvd convert_params_to_native(); // this will convert processor language params to native. should be called before calling execute.
		nvp get_return();

		// ok, this is the key thing...the next class actually is declared by the user himself, using the macros below...
		// for e.g. see constructs_linker.h/.cpp
		virtual nvp process(...);    
};

// =======================================================================
// Macros for declaring a global function type linking object in c++, 
// the Ft below here is the function pointer type

// function type declaration =============================================
#define	DECLARE_FUNCTION_RETURN_TYPE(Rt) Rt
#define	DECLARE_FUNCTION_TYPE_NAME(Ft) Ft
#define	DECLARE_FUNCTION_ARGUMENT(Alist) Alist

#define	DECLARE_FUNCTION_TYPE(Rt, Ft, Alist) 	typedef \
	DECLARE_FUNCTION_RETURN_TYPE(Rt)  \
	DECLARE_FUNCTION_TYPE_NAME(Ft) \
	DECLARE_FUNCTION_ARGUMENT(Alist);

// Linker class ==========================================================
#define	DECLARE_LINKER_CLASS_GF(Ft) \
class tmpl_linker_object_global_function_jump__##Ft : public tmpl_linker_object_global_function \
{\
	private: \
		Ft* native_value; \
		\
	public:\
		virtual nvd set(nvp fp_value); \
		virtual nvp process(...); \
}; \

// Linker functions ======================================================
// ========================================== Not Used
#define IMPLEMENT_LINKER_CLASS_GF(Ft)  \
		tmpl_linker_object_global_function_jump__##Ft::tmpl_linker_object_global_function_jump__##Ft() \
		{} \
		tmpl_linker_object_global_function_jump__##Ft::~tmpl_linker_object_global_function_jump__##Ft() \
		{}

// ==========================================
#define IMPLEMENT_LINKER_CLASS_GF_GET_SET(Ft) \
		nvd tmpl_linker_object_global_function_jump__##Ft::set(nvp fp_value) \
		{ \
			native_value = (Ft*) fp_value; \
			dfp_value = fp_value; \
		} 

// ==========================================
#define IMPLEMENT_LINKER_CLASS_GF_PROCESS_BEGIN(Ft)  \
		nvp tmpl_linker_object_global_function_jump__##Ft::process(...) \
		{  \
			nvp ret = NULL; \
			printf("process called %i", dfp_value); \
			ret = (nvp) (*native_value)(

#define	LINKER_GF_ARGUMENT(Atype, i) ((Atype) (params[i]))
//---------------------------------
// add arguments using ADD_LINKER_ARGUMENT(Atype, i) 
//---------------------------------

#define IMPLEMENT_LINKER_CLASS_GF_PROCESS_END	\
															); \
			printf("function returned"); \
			return ret; \
		} 
		
// ==========================================
#define IMPLEMENT_LINKER_CLASS_GF_BEGIN(Ft) \
	IMPLEMENT_LINKER_CLASS_GF_GET_SET(Ft)   \
	IMPLEMENT_LINKER_CLASS_GF_PROCESS_BEGIN(Ft)

#define IMPLEMENT_LINKER_CLASS_GF_END \
	IMPLEMENT_LINKER_CLASS_GF_PROCESS_END

// ============================================
#define REGISTER_LINKER_GF(Ft)  \
	tmpl_linker_object_global_function_jump__##Ft* lo__##Ft = new tmpl_linker_object_global_function_jump__##Ft(); \
	lo__##Ft->linker_name = #Ft; \
	$PI_LNK->add_linker(lo__##Ft);
}}}

#endif


