#ifndef __def_language_core_constructs_included__
#define __def_language_core_constructs_included__

// =======================================================================
#include "native.h"
#include "common_defs.h"

// =======================================================================
namespace __language {
	namespace __constructs {

// =======================================================================
// contructs that are used to link to the native language.
class data_construct  : public construct
{
public:
	nvp _dc_buf;

public:
	data_construct() {_dc_buf=NULL;}
	~data_construct() {}

	nvd set(data_construct* buf); // makes a copy of the passed in values
	nvd setn(nvp v); // based on the type, a cast is made..
	nvd set(nvp v, nstr dtype = "dvp"); // makes a copy of the value, after making an app.
																						 // native type cast of v
	nvp get();  // simply returns the buffer
	link* getnl(); // this gets the native link from which the native value can be got.
	data_construct* get(nstr type); // returns a copy of the data_construct in a different type
};

// =======================================================================
class construct_type : public construct
{
public:
	construct_type() {}
	~construct_type() {}

	nvd set_native_fptr(nvp fptr, nstr dtype);

	construct_type* get_base_construct_type();
	construct_type* get_real_base_construct_type(construct_type* t, nstr type);

	collection_construct* get_ctype_links();
	link* get_native_link();
	link* get_ctype_link(nstr link_name);

	static nbln is_type_of_type(nstr child_type, nstr parent_type);
	construct_type* get_type(nstr type);

	construct* operator()(...);

};

// =======================================================================
class link : public construct
{
private:
	construct* caller_cobject; 
	data_construct* dfptr; 
	data_construct* ret_value;
	nbln sync; // false for callbacks, socket, pipe oriented.
	nbln blocked;
	nint timeout;
	
public:
	link();
	~link();

	static link* get_link(construct* cons);
	static link* get_link(construct* cons, nstr link_name);

	// set/get
	// These function decides whether new space (copy) to be allocated for 
	// the link or whether to ref..
	nvd set_linking_cobject(construct* cobj); // if the linking object is a method, then automatically, the params are added.
	nvd set_return_type(construct_type* ct); 
	nvd add_param(data_construct* p);
	nvd set_fptr(nvp fptr, nstr type);
	nvd set_fptr(data_construct* fptr);
	nstr get_fptr_type() {return dfptr->type_str();}
	nvp get_fptr() {return dfptr->_dc_buf;}
	nvd set_ret_value(nvp ret);
	data_construct* get_ret_value();

	/*
	This function maps 
		1) the caller_link_name to its native link and gets the fptr (stored in buffer) casted to native type
		2) similarly gets the params values in native type, by explicit data casting using macros.
		3) launches the function. and sets the return.
		4) returns to the user nvp.
	The user casts the same to native format. 

	If a map is found which is users, then the following callback (impl by the user) should set it. 
	$jm(user_link_process).
	The param of this method is "this" link. Using this the user can essentially can launch the method.
	
	The functions decide whether new space (copy) to be allocated for 
	the link or whether to ref.. 

	the following three functions are called by the dispatcher.
	*/

	nvd init();
	construct*  process(...); // once the params are added and 
	construct* operator()(...);
	nvd clean();					// once the link is disconnected, this is called.
};


// =======================================================================
// constructs that can be dispatched
class variable  : public construct
{
public:
	variable();
	~variable();

	nvd setn(nvp v);
	nvd set(data_construct* v);
	nvd set(nstr v);

	data_construct* get();
	nvp getn();
	link* variable::getnl();
	data_construct* get(nstr type);
	data_construct* get(construct* type);
};

// =======================================================================
class method : public construct
{
public:
	method() {}
	~method() {}

	link* set_up_exec_link();
	variable* add_argument(nstr name, nstr type, nstr direction);
	variable* get_argument(nstr arg);

	nvd init();
	construct*  process(...); // once the params are added and 
	construct* operator()(...);
	nvd clean();					// once the link is disconnected, this is called.
};

// =======================================================================
class context : public construct
{
public:
	context();
	~context();
};
}}
#endif