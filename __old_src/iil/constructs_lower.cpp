#include "processor_instructions.h"
#include "processor.h"
#include "constructs_instructions.h"
#include "construct.h"
#include "construct_core.h"

// =======================================================================
namespace iil {
	namespace l_cns {
		
// =======================================================================
// makes a copy of the passed in values
nvd data_construct::set(data_construct* buf) 
{
	if (buf == NULL ||
			buf->get() == NULL)
		return;

	construct::set(buf->name(), buf->type_str());
	setn(buf->get());
}

 // based on the type, a cast is made..
nvd data_construct::setn(nvp v)
{
	_dc_buf = v;
}

 // makes a copy of the value, after making an app. native type cast of v
nvd data_construct::set(nvp v, nstr dtype)
{
	if (v == NULL)
		return;

	_dc_buf = v;
}

// simply returns the buffer
nvp data_construct::get()
{
	link* nl = getnl();
	if (nl == NULL)
		return NULL;

	l_prc::l_ins::pi_dispatch_link(nl);
	
	return (nvp) nl->get_ret_value()->_dc_buf;
}

// this gets the native link from which the native value can be got.
link* data_construct::getnl()
{
	// get the link for the v_type.
	construct* ty = $PI_MEM_C(_stack_m, _types_m);
	construct_type* this_type = (construct_type*)(*ty)[type_str()];
	data_construct* lptr = (data_construct*)(*this_type)["native_type_dfp"];

	link* l = (link*)(*ty)["link_data"];

	l->set_fptr(lptr);
	l->add_param(this);

	return l;
}

// returns a copy of the data_construct in a different type
data_construct* data_construct::get(nstr type)
{
	return this;
}

// =======================================================================
nvd construct_type::set_native_fptr(nvp fptr, nstr dtype)
{
	data_construct* fptr_val = (data_construct*) (*this)["native_link_info"];
	
	if (fptr_val != NULL)
		fptr_val->set(fptr, dtype);
}

link* construct_type::get_native_link() 
{
	link* l = (link*) relations()->get_childc("native_link", "link");
	return l;
}

construct_type* construct_type::get_base_construct_type()
{
	// every logical type has a link called the constructs_type..which gets the 
	// hard coded construct class from which it is derived.
	// This is set at processor boot time..just before start of user process.
	// This is essentially a function poninter that gets the base ctype.
	// if a certain ctype does not has this fp defined, then using rules of
	// inheritance, the most derived "constructs_type" link is fetched 
	// , jumped and and the ctype is retured.

	return get_real_base_construct_type(this, type_str());
}

construct_type* construct_type::get_real_base_construct_type(construct_type* t, nstr type)
{
	if (l_ins::ci_is_supported_construct_type(t->name()))
		return t;

	if (owner() == NULL) 
		return NULL;
	
	return get_real_base_construct_type((construct_type*)owner(), type);
}

construct_type* construct_type::get_type(nstr type)
{
		if (relations() != NULL)
			return (construct_type*) relations()->get_childc(type, "construct_type");

		return NULL;
}

nbln construct_type::is_type_of_type(nstr child_type, nstr parent_type)
{
	if (child_type == parent_type)
		return true;

	construct* start = NULL;
	if ($PI_MEM_C(_stack_m, _types_m) == NULL)
		return true;
//	construct_type* p = get_type(parent_type);
//	construct_type* c = get_type(child_type);

//	if (c != NULL)
	//	return true;

	return false;
}

construct* construct_type::operator()(...)
{
	return NULL;
}

// =======================================================================
link::link()
{
	caller_cobject = NULL;  
	ret_value = NULL;
}

link::~link()
{
	caller_cobject = NULL;  
	ret_value = NULL;
}

link* link::get_link(construct* cons)
{
		// This should return the native link construct..
		//link* l = (link*) (*(cons->type()))();
//		return l;
	return NULL;
}

link* link::get_link(construct* cons, nstr link_name)
{
	return NULL;
}
// set/get
nvd link::set_linking_cobject(construct* cobj)
{
	caller_cobject = cobj;
}


nvd link::add_param(data_construct* p)
{
	if (p == NULL || (*this)[p->name()] != NULL)
		return;

	relations()->add_childc(p);
}

nvd link::set_fptr(nvp fptr, nstr type)
{
}

nvd link::set_fptr(data_construct* fptr)
{
	dfptr = fptr;
}

data_construct* link::get_ret_value()
{
	return ret_value;
}

nvd link::set_ret_value(nvp ret)
{
//	if (ret_value != NULL)
		//$PI_MEM->remove_child_construct(ret_value);
	ret_value = l_prc::l_ins::pi_register_data_construct("ret_value", ret, "dvp", this);
}

nvd link::init()
{
}

nvd link::clean()
{
}

construct* link::operator()(...)
{
	return NULL;
}

construct* link::process(...)
{
	return NULL;
}

// =======================================================================
variable::variable() {}
variable::~variable() {}

nvd variable::set(data_construct* v) {}
nvd variable::setn(nvp v) {}
nvd variable::set(nstr v) {}
data_construct* variable::get() {return NULL;}
nvp variable::getn() 
{
	data_construct* v_value = (data_construct*) (*this)["v_value"];
	if (v_value == NULL)
		return NULL;

	return v_value->get();
}

link* variable::getnl() 
{
	data_construct* v_value = (data_construct*) (*this)["v_value"];
	if (v_value == NULL)
		return NULL;

	return v_value->getnl();
}

data_construct* variable::get(nstr type) {return NULL;}
data_construct* variable::get(construct* type) {return NULL;}

// =======================================================================
variable* method::add_argument(nstr name, nstr type, nstr direction) 
{
//	variable* arg = (variable*) relations()->new_child_construct(name, type);
	//return arg;
	return NULL;
}

variable* method::get_argument(nstr arg) 
	{return (variable*) relations()->get_childc(arg, "argument");}

link* method::set_up_exec_link()
{
	link* l = NULL;
	construct* ty = $PI_MEM_C(_stack_m, _types_m);
	data_construct* dfptr = (data_construct*) (*this)["method_ptr"];

	// things need to add arguments
	l = (link*)(*ty)["link_function"];
	l->set_fptr(dfptr);

	return l;
}

nvd method::init()
{
}

nvd method::clean()
{
}

construct* method::operator()(...)
{
	return NULL;
}

construct* method::process(...)
{
	return NULL;
}

// =======================================================================
context::context() {}
context::~context() {}
}}

