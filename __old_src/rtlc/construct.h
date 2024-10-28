#ifndef __def_language_construct_included__
#define __def_language_construct_included__

// =======================================================================
#include "native.h"
using namespace __language::__native;

#include "common_defs.h"

// =======================================================================
namespace __language {
	namespace __constructs {

// A basic construct of a prog/scripting language ========================
// implements both compile and runtime language code processing.
class construct
{
private:
	nstr cname;
	nstr cscope;
	nstr corder;
	nstr type_string;
	
	construct* owner_parent_ref;
	construct_type* ctype_ref;

	rels_construct* crels; // everything goes in here as construct*		

public:
	construct();
	~construct();
	
	construct* clone(construct* c);

	nstr name();
	construct* owner();
	construct_type* type();
	nstr type_str();
	nstr scope();
	nstr order();

	nvd set(nstr cname, nstr ctype, nstr cscope = "global", nstr order = "-1");
	nvd set_name(nstr n);
	nvd set_owner(construct*);
	nvd set_owner_ref(construct* p) {owner_parent_ref = p;}
	nvd set_type(nstr type);
	nvd set_type(construct_type* t) {ctype_ref = t;}
	nvd set_scope(nstr scope);
	nvd set_order(nstr order);

	rels_construct* relations() {return crels;}
	nvd set_relations(rels_construct* col);
	construct* operator [] (nstr relative);

	// ================ overrides common to all constructs
	virtual nvd init();
	virtual construct* process(...);
	virtual construct* operator()(...);  // dispatch helper
	virtual nvd clean();

	// debug helpers
	nvd dump_construct_data(nbln deep = false, nint indent = 0);
	nvd dump_deep();
};

// =======================================================================
// things: This should eventually move out to processor.cpp along with memory
// and a version of this can be put in construct_Core to represent a coll
// of generic constructs, from the code perspective, rather than memory perspective.
class collection_construct : public construct
{
/* a collection of contruct* poninters to heap (
and for the cll, it is really a construct "object" with ptr type native linkage).
*/
public:
	map<nstr, construct*>* construct_list;
	map<nstr, construct*>::iterator it;

public:
	collection_construct(); 
	~collection_construct();

	// load functions
	nvd sort();
	
	// accessors
	map<nstr, construct*>::iterator begin();
	map<nstr, construct*>::iterator end();
	virtual construct* operator [](nstr index_name);

	construct* get_childc(nstr name, nstr type = "", 
												match_criteria m = find_criteria(match_deep + match_first + match_from_top));

	construct* get_childc_conditional(nstr name, nstr type, 
															condition_construct* cndns,
															match_criteria m = find_criteria(match_deep + match_first + match_from_top));
	
	collection_construct* get_children(nstr name, nstr type, 
														match_criteria m = find_criteria(match_deep + match_first + match_from_top));

	construct* get_childc_linked(nstr member_construct, nstr member_type,
															 match_criteria m = find_criteria(match_deep + match_first + match_from_top));


	// adding/changing/editing/deleting
	construct* add_childc(construct* child);
	nvd remove_childc(construct* child);

/* 
other methods
search
	- Very simple criteria based search is found in the above.
	- scoping, object member linking, bubbling
	- Conditional search will be useful, like and, or etc...with regexp.
	- comparing constructs...based on name, type, value..etc..standard properties.	

sub collections
	- getting sub collections based on type, and a parent, or a child (upward).
	- sorting, searching, sub collections based on the comparing and conditions.

persistance
	- Linking to Db and converting to XML/Files and synchronizing all these.
	- as and when change is made it should be saved.
	- a standard xml based definition of the ocll, called xocll
	- database and xml libs...that can do lots of good things very easily..
	*/
};

// =======================================================================
// the relation between two language constructs. This could be a parent/child relation, or encapsulation,
// or inhertance etc..
class rel_construct : public construct
{
public:
	rel_construct();
	~rel_construct();

public:
	nvd set_referer(construct* referer);
	nvd set_referee(construct* referee);

	nvd set_relationship(nstr relation);
	nvd set_relationship(construct* referer, construct* referee, nstr rel_name, nstr rel_type = "rel_construct", 
											 nstr ref_name = "", nstr ref_type = "");

	construct* get_referer();
	construct* get_referee();
	nstr get_relationship();
	construct_type* get_relationship_ctype();

	nvd add_ref(nstr ref_name, nstr ref_type = "");
	nvd remove_ref(); 
};

// ===============================================================================
// The following class holds a collection of relations of a given construct object
class rels_construct : public collection_construct
{
public:
	rels_construct();
	~rels_construct();

	nvd add_relation(rel_construct* rel);
	construct* add_relative(nstr referee_name, nstr referee_type, nvp referee_value, construct* referer, 
													 nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
													 nstr scope = "construct", nstr order = "-1");

	construct* add_relative(construct* referer, construct* referee, 
													nstr rel_name, nstr rel_type, construct* parent_rel = NULL, 
													nstr scope = "construct", nstr order = "-1");

	rel_construct* get_relation(nstr relative_name, nstr relation_type = "", match_criteria m = match_first);
	construct* get_relative(nstr relative_name, nstr relative_type = "", match_criteria m = match_first);
	construct* operator [](nstr relative_name);

	rels_construct* get_relations(nstr relation_type, match_criteria m);	
	collection_construct* get_relatives(nstr relation_type, match_criteria m);
	collection_construct* get_relatives(nstr relation_type, nstr relative_type, match_criteria m);

	nvd remove_relation(rel_construct* rel);
	nvd remove_relative(construct* relative);
	nvd remove_relative(nstr relative_name, nstr relation_type="", match_criteria m=match_first);
};


}}
#endif