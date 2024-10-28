#include "constructs_instructions.h"

#include "processor.h"
#include "processor_instructions.h"

#include "construct.h"
#include "construct_core.h"

// =======================================================================
namespace iil {
	namespace l_cns {
		namespace l_ins {

// constructs related ====================================================
// things overloads of this with value and stuff
construct* ci_create_construct(nstr cname, nstr ctype, construct* parent, nstr scope, nstr order)
{
	construct* c = NULL;

	if (parent == NULL)
		parent = ci_get_root_mem(ctype);

	// determine the base ctype
	nstr btype = ctype;

	if (parent != NULL)
	{
		construct_type* ctypec = (construct_type*) $NI_deref($PI_MEM_C(_stack_m, _types_m))[ctype];

		if (ctypec != NULL)
		{
			construct_type* btypec = ctypec->get_base_construct_type();
			if (btypec != NULL)
				btype = btypec->name();
		}
	}

	// create the construct. This call will call the meory handler which will create the actual
	// memory in its own native way and return a construct pointer to that memory location.
	construct* ret = ci_new_cons(btype);
	if (btype == "rels_construct" || ctype == "rels_construct")
	{
		if (parent != NULL)
			parent->set_relations((rels_construct*) ret); 
		
		return ret;
	}

	// Now set all the basic identity related info 
	if (ret != NULL)
	{
		// create the relations construct.
		ci_create_construct("construct_relations", "rels_construct", ret); 

		ret->set(cname, ctype, scope, order);
		ret->set_owner(parent);
	}

	return ret;
}

construct* ci_add_relative(nstr referee_name, nstr referee_type, nvp referee_value, construct* referer, 
													 nstr rel_name, nstr rel_type, construct* parent_rel, 
													 nstr scope, nstr order, nstr ref)
{
	// create the rel_construct 
	if (parent_rel == NULL)
		parent_rel = referer;

	rel_construct* rel = (rel_construct*) ci_create_construct(rel_name, rel_type, parent_rel, scope, order);

	// create the relative
	construct* reltive = ci_create_construct(referee_name, referee_type, rel);

	// set the relationship
	rel->set_relationship(referer, reltive, rel_type, ref);
	
	// add this relation
	rels_construct* crels = referer->relations();
	crels->add_relation(rel);

	return reltive;
}

construct* ci_add_relative(construct* referer, construct* referee, 
													nstr rel_name, nstr rel_type, construct* parent_rel, 
													nstr scope, nstr order, nstr ref)
{
	// create the rel_construct 
	if (parent_rel == NULL)
		parent_rel = referer;

	rel_construct* rel = (rel_construct*) ci_create_construct(rel_name, rel_type, parent_rel, scope, order);

	// set the relation
	// set the relationship
	rel->set_relationship(referer, referee, rel_type, ref);

	// add this relation
	rels_construct* crels = referer->relations();
	crels->add_relation(rel);

	return referee;
}

construct* ci_new_cons(nstr btype) // the base type like method, construct_type should be passed
{
	if (btype == "construct")
		$CI_NEW_CONS(construct)
	else if (btype == "rel_construct")
		$CI_NEW_CONS(rel_construct)
	else if (btype == "data_construct")
		$CI_NEW_CONS(data_construct)
	else if (btype == "collection_construct")
		$CI_NEW_CONS(collection_construct)
	else if (btype == "rels_construct")
		$CI_NEW_CONS(rels_construct)
	else if (btype == "construct_type")
		$CI_NEW_CONS(construct_type)
	else if (btype == "link")
		$CI_NEW_CONS(link)
	else if (btype == "variable")
		$CI_NEW_CONS(variable)
	else if (btype == "method")
		$CI_NEW_CONS(method)
	else if (btype == "context")
		$CI_NEW_CONS(context)

	return NULL;
}

nint ci_get_construct_size(nstr btype)
{
	nint s;
	if (btype == "construct")
		s = sizeof(construct);
	else if (btype == "rel_construct")
		s = sizeof(rel_construct);
	else if (btype == "data_construct")
		s = sizeof(data_construct);
	else if (btype == "collection_construct")
		s = sizeof(collection_construct);
	else if (btype == "rels_construct")
		s = sizeof(rels_construct);
	else if (btype == "construct_type")
		s = sizeof(construct_type);
	else if (btype == "link")
		s = sizeof(link);
	else if (btype == "variable")
		s = sizeof(variable);
	else if (btype == "method")
		s = sizeof(method);
	else if (btype == "context")
		s = sizeof(context);

	return s;
}

construct* ci_get_root_mem(nstr ctype)
{
		if (ctype == "construct_type" || ctype == "link")
			return $PI_MEM_C(_stack_m, _types_m);
		else if (ctype == "data_construct")
			return $PI_MEM_C(_stack_m, _data_m);

		return $PI_MEM_C(_stack_m, _constructions_m);
}

nstr ci_get_root_mem_name(nstr ctype)
{
		if (ctype == "construct_type" || ctype == "link")
			return "_types_m";
		else if (ctype == "data_construct")
			return "_data_m";

		return "_constructions_m";
}

nbln ci_is_supported_construct_type(nstr btype)
{
	if (btype == "construct")
		return true;
	else if (btype == "rel_construct")
		return true;
	else if (btype == "data_construct")
		return true;
	else if (btype == "collection_construct")
		return true;
	else if (btype == "rels_construct")
		return true;
	else if (btype == "construct_type")
		return true;
	else if (btype == "link")
		return true;
	else if (btype == "variable")
		return true;
	else if (btype == "method")
		return true;
	else if (btype == "context")
		return true;

	return false;
}
}}}