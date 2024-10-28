#include "construct.h"
#include "construct_core.h"

#include "processor.h"
#include "processor_instructions.h"

#include "constructs_linker.h"
#include "process.h"

// =======================================================================
namespace iil {
	namespace l_cns {
		namespace l_lnk {

void register_links();

// processor related =====================================================
// This is called by the processor during the registration process
// register all the processor related constructs. related to boot
nvd registerc()
{
	// create all the basic data types...that are fptrs..
	construct* root = $PI_MEM_C(_stack_m, _types_m);
	root = (*root)["construct"];

	// stage 1
	// create all the other standard constructs types
	/*construct* dcons = l_prc::l_ins::pi_register_construct_type("data_construct", get_data, "ddp_fp_dvp", root);
	construct* vcons  = l_prc::l_ins::pi_register_construct_type("variable", get_var, "dvrp_fp_dvp", root);
	construct* mcons  = l_prc::l_ins::pi_register_construct_type("method", get_mth, "dmp_fp_dvp", root);
	construct* lcons  = l_prc::l_ins::pi_register_construct_type("link", get_lnk, "dlp_fp_dvp", root);
	construct* cccons = l_prc::l_ins::pi_register_construct_type("collection_construct", get_collection_cons, "dccp_fp_dvp", root);

	// data types
	l_prc::l_ins::pi_register_construct_type("dvp", get_dvp, "dvp_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dfp", NULL, "dfp", dcons);
	l_prc::l_ins::pi_register_construct_type("dint", get_dint, "nint_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dstr", get_dstr, "nstr_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dchrp", get_dchrp, "nchrp_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dbln", get_dbln, "nbln_fp_dvp", dcons);

	// link types
	l_prc::l_ins::pi_register_construct_type("link_data", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_function", NULL, "", lcons);
	construct* rclink = l_prc::l_ins::pi_register_construct_type("link_related_construct", NULL, "", lcons);
		l_prc::l_ins::pi_register_construct_type("link_link_data", NULL, "", rclink);
		l_prc::l_ins::pi_register_construct_type("link_rc_encapsulation", NULL, "", rclink);
		l_prc::l_ins::pi_register_construct_type("link_rc_inhertiance", NULL, "", rclink);
		l_prc::l_ins::pi_register_construct_type("link_rc_container", NULL, "", rclink);
		l_prc::l_ins::pi_register_construct_type("link_rc_reference", NULL, "", rclink);
		l_prc::l_ins::pi_register_construct_type("link_rc_composition", NULL, "", rclink);
		l_prc::l_ins::pi_register_construct_type("link_rc_aggregation", NULL, "", rclink);
		construct* rclink_e = l_prc::l_ins::pi_register_construct_type("link_rc_extension", NULL, "", rclink);
			l_prc::l_ins::pi_register_construct_type("link_rc_extension_runtime_derivation", NULL, "", rclink_e);

	// variable types
	l_prc::l_ins::pi_register_construct_type("param_variable", NULL, "", vcons);

	// method types
	// none ....

	// stage 2
	construct* objcons = l_prc::l_ins::pi_register_construct_type("object_construct", NULL, "dfp", root);
	construct* clscons = l_prc::l_ins::pi_register_construct_type("class_construct", NULL, "dfp", root);

	l_prc::l_ins::pi_register_construct_type("dobj", get_dbln, "nbln_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dptr", get_dbln, "nbln_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dptrptr", get_dbln, "nbln_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("ddptrptr", get_dbln, "nbln_fp_dvp", dcons);

	l_prc::l_ins::pi_register_construct_type("link_object", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_object_data", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_object_function", NULL, "", lcons);

	// collection types
	l_prc::l_ins::pi_register_construct_type("data_collection", NULL, "", cccons);
	l_prc::l_ins::pi_register_construct_type("dstr_collection", NULL, "", cccons);
	l_prc::l_ins::pi_register_construct_type("dobj_collection", NULL, "", cccons);
	l_prc::l_ins::pi_register_construct_type("dptr_collection", NULL, "", cccons);
	l_prc::l_ins::pi_register_construct_type("dptrptr_collection", NULL, "", cccons);

	// stage 3
//	l_prc::l_ins::pi_register_construct_type("dcons", get_dcons, "dcons_fp_dvp", dobj);
//	l_prc::l_ins::pi_register_construct_type("dvars", get_dvar, "dvar_fp_dvp", dcons);

	l_prc::l_ins::pi_register_construct_type("link_construct", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_variable", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_method", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_context", NULL, "", lcons);
	l_prc::l_ins::pi_register_construct_type("link_collection", NULL, "", lcons);
*/
	// stage 4
	// language types (will have a new type of "language class")
	// iilcp --> pi, ci, ni ---> pl, ptl, pll, pxl, psl, pcsl, pmlcpsl, pcmpl, scmpll

	// section types (will have a new type of "language_consturct" class)
	// code format --> xml, db, text files (including code_pages), 

	// native code files, user code...
	// language_constructs (used by "language_interpreter" class, this inteprets code and converts to instructions)
	//											since this is language and code page format specific, an intepreter will use the right
	//											code format type language_construct object and also the right planguage)
	//											The code lan_cons and planguage objects are off classes derived from the
	//											base language_construct and language_processor classes respectively.
	//											The language_processor is a collection of instruction object and their construct objects.
	//											instruction object is itself a type of language_construct, which can directly be used by the code.
	//											The language_construct class is a tree of classes of code page format types. Based on the format,
	//											the keywords, expressions, code itself, statements, etc..have special functions, overriding the
	//											base abstract implementation.
	//											These code constructs in a certain format are actaully represent a language..In case of code feeds,
	//											The ouput of language construct processing is instructions and construct objects in text format.
	//											These are intepreted by the intepreter for that language into..real instructions and construct objects...
	//											Then once all the code is intepreted, it is executed. 
	//											If the code page is an external feed, then that has to be updated at the end of the processing.
	//											So at every stage of processing an instruction, these documents in their "runtime" format has to be updated.
	//											This is accomplished by deriving a new construct_object type from the native processor and then overriding the gets/sets methods..
	//											and def..even executing a certain method in the native language...essentially the native links have to be shunted temporarily,
	//											while shifting formats.
	//											So for a plang and nlang combination, the construct_object, the processor_language, the language_construct classes all have to be derived..
	//											Also for such a combition there will be the linker namespace, registration of types, links etc.., startup methods,
	//											global scope, instructions (dispatched to the instructor), native inclusions, makefile inclusions etc...
	// language_construct->code --> code format (planguage and nlanguage) ->expressions, keywords --> statements tree --> constructs, instructions -------------->instructor.

	// instruction types
	// processor and constructs (operators on var and data)
	// language specific instructions.
	// interrupts

	// keyword types
	// programming text based, code section keyword type, xml, db, macro

/*	l_prc::l_ins::pi_register_construct_type("dxmldoc", get_dcons, "dcons_fp_dvp", dobj);
	l_prc::l_ins::pi_register_construct_type("dxmlnode", get_dcons, "dcons_fp_dvp", dobj);
	l_prc::l_ins::pi_register_construct_type("dxmlvalue", get_dcons, "dcons_fp_dvp", dobj);
	l_prc::l_ins::pi_register_construct_type("dxmlnodes", get_dcons, "dcons_fp_dvp", dobj);

	l_prc::l_ins::pi_register_construct_type("ddb", get_dvar, "dvar_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dtable", get_dvar, "dvar_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("drecordset", get_dvar, "dvar_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("drecord", get_dvar, "dvar_fp_dvp", dcons);
	l_prc::l_ins::pi_register_construct_type("dcell", get_dvar, "dvar_fp_dvp", dcons);

	l_prc::l_ins::pi_register_construct_type("xml_collection", NULL, "", cccons);
	l_prc::l_ins::pi_register_construct_type("records_collection", NULL, "", cccons);
*/

	// stage 5
//	construct* intptcons = l_prc::l_ins::pi_register_construct_type("interrupt_construct", NULL, "dfp", root);

	// register the linker objects	
	register_links();

	// register links...

	$PI_MEM_DMP
}

// native linking ============================================================
IMPLEMENT_LINKER_CLASS_GF_BEGIN(nvp_fp)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(nvp_fp_nvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(nvp_fp_nchrp)
LINKER_GF_ARGUMENT(nchrp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(nvp_fp_nstr)
LINKER_GF_ARGUMENT(nchrp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

// constructs pdt linking
IMPLEMENT_LINKER_CLASS_GF_BEGIN(nvp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(nint_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

//IMPLEMENT_LINKER_CLASS_GF_BEGIN(nstr_fp_dvp)
//LINKER_GF_ARGUMENT(nvp, 0)
//IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(nchrp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(nbln_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

// constructs linking
IMPLEMENT_LINKER_CLASS_GF_BEGIN(dcp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(ddp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(dvrp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(dmp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(dctxp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(dlp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(dctp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

IMPLEMENT_LINKER_CLASS_GF_BEGIN(dccp_fp_dvp)
LINKER_GF_ARGUMENT(nvp, 0)
IMPLEMENT_LINKER_CLASS_GF_END

void register_links()
{
	// All the types of linkers supported by this core constructs ns should be registered...
	// register all data type native links->global c++ functions, pass in fp type.
	REGISTER_LINKER_GF(nvp_fp);
	REGISTER_LINKER_GF(nvp_fp_nvp);
	REGISTER_LINKER_GF(nvp_fp_nchrp);
	REGISTER_LINKER_GF(nvp_fp_nstr);

	REGISTER_LINKER_GF(nvp_fp_dvp)
	REGISTER_LINKER_GF(nint_fp_dvp)
//	REGISTER_LINKER_GF(nstr_fp_dvp)
	REGISTER_LINKER_GF(nchrp_fp_dvp)
	REGISTER_LINKER_GF(nbln_fp_dvp)

	REGISTER_LINKER_GF(dcp_fp_dvp)
	REGISTER_LINKER_GF(ddp_fp_dvp)
	REGISTER_LINKER_GF(dvrp_fp_dvp)
	REGISTER_LINKER_GF(dmp_fp_dvp)
	REGISTER_LINKER_GF(dctxp_fp_dvp)
	REGISTER_LINKER_GF(dlp_fp_dvp)
	REGISTER_LINKER_GF(dctp_fp_dvp)
	REGISTER_LINKER_GF(dccp_fp_dvp)
}

nvd register_default_start_methods()
{
	construct* root = $PI_MEM_C(_stack_m, _constructions_m);
	context* defaults = (context*) (*root)["_processor_default_"];

/*	l_prc::l_ins::register_method("register_constructs", "method", defaults, register_constructs, "nvp_fp");
	l_prc::l_ins::register_method("user_init", "method", defaults, user_init, "nvp_fp");
	l_prc::l_ins::register_method("user_process", "method", defaults, user_process, "nvp_fp");
	l_prc::l_ins::register_method("user_clean", "method", defaults, user_clean, "nvp_fp");*/
}

// native type methods ===================================================
nvp get_dvp(dvp ptr) {return ptr;}
nstr get_dstr(dvp ptr) {return *((nstr*) ptr);}
nbln get_dbln(dvp ptr) {return (nbln) ptr;}
nchrp get_dchrp(dvp ptr) {return (nchrp) ptr;}
nint get_dint(dvp ptr) {return (nint) ptr;}

construct* get_cons(dvp ptr) {return (construct*) ptr;}
data_construct* get_data(dvp ptr) {return (data_construct*) ptr;}
context* get_ctx(dvp ptr) {return (context*) ptr;}
method* get_mth(dvp ptr) {return (method*) ptr;}
variable* get_var(dvp ptr) {return (variable*) ptr;}
construct_type* get_typ(dvp ptr) {return (construct_type*) ptr;}
collection_construct* get_collection_cons(dvp ptr) {return (collection_construct*) ptr;}
link* get_lnk(dvp ptr) {return (link*) ptr;}

// data methods ==========================================================
construct* n_convert(construct* from, construct* to)
{
	variable* f = (variable*) from;
	variable* t = (variable*) to;

	nstr frm_t = f->type()->name();
	nstr to_t = t->type()->name();

	if (frm_t == to_t)
	{
//		nint s = sizeof(f->buffer()->getn());
		
/*		if (s <= 4)
			t->get_buffer()->set(f->get_buffer()->getn());
		else
		{
			nvp val = malloc(s);
			memcpy(val, f->get_buffer()->getn(), s);
			t->get_buffer()->setn(val);
		}*/

		return t;
	}

/*	if (frm_t == "cstr" && to_t == "cnint")
	{
		const char* s = (char*) f->value;
		nint* i = new nint();
		*i = atoi(s);
		t->value = (nvp) (*i);
	}
	else if (frm_t == "cnint" && to_t == "cstr")
	{
		char *s = new char[32];
		nint i = (nint) f->value;
		sprnintf(s, "%i", i);
		t->value = (nvp) s;
	}*/
	return t;
}
}}}
