#ifndef __def_language_constructs_linker_included__
#define __def_language_constructs_linker_included__

// =======================================================================
#include "native.h"
using namespace iil::l_ntv;

#include "processor_linker.h"
using namespace iil::l_prc::l_lnk;

#include "processor.h"

// =======================================================================
//ADD_LINKER_GF_CONS(nvp_fp)

// =======================================================================
namespace iil {
	namespace l_cns {
		namespace l_lnk {

// register  =============================================================
nvd registerc();
nvd register_default_start_methods();

// type defs =============================================================
// natve type methods =========
typedef nvp dvp;

// native pdt links, defs are in native.h
// things: need to get the linker logic into native.h and move these there
DECLARE_FUNCTION_TYPE(nvp, nvp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(nint, nint_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(nstr, nstr_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(nchrp, nchrp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(nbln, nbln_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(nvp, nvp_fp_dvp, (dvp));

DECLARE_LINKER_CLASS_GF(nvp_fp)
DECLARE_LINKER_CLASS_GF(nvp_fp_nvp)
DECLARE_LINKER_CLASS_GF(nvp_fp_nchrp)
DECLARE_LINKER_CLASS_GF(nvp_fp_dvp)
DECLARE_LINKER_CLASS_GF(nvp_fp_nstr)
DECLARE_LINKER_CLASS_GF(nint_fp_dvp)
DECLARE_LINKER_CLASS_GF(nstr_fp_dvp)
DECLARE_LINKER_CLASS_GF(nchrp_fp_dvp)
DECLARE_LINKER_CLASS_GF(nbln_fp_dvp)

nvp get_dvp(dvp ptr);
nint get_dint(dvp ptr);
nstr get_dstr(dvp ptr);
nbln get_dbln(dvp ptr);
nchrp get_dchrp(dvp ptr);

// construct type methods =================================================
DECLARE_FUNCTION_TYPE(construct*, dcp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(data_construct*, ddp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(variable*, dvrp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(method*, dmp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(context*, dctxp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(link*, dlp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(construct_type*, dctp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(collection_construct*, dccp_fp_dvp, (dvp));
DECLARE_FUNCTION_TYPE(construct*, dcp_fp_dvp, (dvp));

DECLARE_LINKER_CLASS_GF(dcp_fp_dvp)
DECLARE_LINKER_CLASS_GF(ddp_fp_dvp)
DECLARE_LINKER_CLASS_GF(dvrp_fp_dvp)
DECLARE_LINKER_CLASS_GF(dmp_fp_dvp)
DECLARE_LINKER_CLASS_GF(dctxp_fp_dvp)
DECLARE_LINKER_CLASS_GF(dlp_fp_dvp)
DECLARE_LINKER_CLASS_GF(dctp_fp_dvp)
DECLARE_LINKER_CLASS_GF(dccp_fp_dvp)

construct* get_cons(dvp ptr);
data_construct* get_data(dvp ptr);
context* get_ctx(dvp ptr);
method* get_mth(dvp ptr);
variable* get_var(dvp ptr);
construct_type* get_typ(dvp ptr);
link* get_lnk(dvp ptr);
collection_construct* get_collection_cons(dvp ptr);

// few common functions ===================================================
DECLARE_FUNCTION_TYPE(construct*, dcp_fp, ());
DECLARE_FUNCTION_TYPE(construct*, dcp_fp_dcp, (construct*));
DECLARE_FUNCTION_TYPE(construct*, dcp_fp_dcp2, (construct*, construct*));
DECLARE_FUNCTION_TYPE(construct*, dcp_fp_dcp3, (construct*, construct*, construct*));
DECLARE_FUNCTION_TYPE(data_construct*, dcdp_fp, ());
DECLARE_FUNCTION_TYPE(data_construct*, dcdp_fp_dcdp, (data_construct*));
DECLARE_FUNCTION_TYPE(data_construct*, dcdp_fp_dcdp2, (data_construct*, data_construct*));
DECLARE_FUNCTION_TYPE(data_construct*, dcdp_fp_dcdp3, (data_construct*, data_construct*, data_construct*));
DECLARE_FUNCTION_TYPE(variable*, dcvp_fp, ());
DECLARE_FUNCTION_TYPE(variable*, dcvp_fp_dcvp, (variable*));
DECLARE_FUNCTION_TYPE(variable*, dcvp_fp_dcvp2, (variable*, variable*));
DECLARE_FUNCTION_TYPE(variable*, dcvp_fp_dcvp3, (variable*, variable*, variable*));

}}}
#endif

