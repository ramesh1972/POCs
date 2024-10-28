#include "processor_instructions.h"

#include "constructs_instructions.h"
#include "construct.h"
#include "construct_core.h"

// =======================================================================
namespace iil {
	namespace l_cns {

// implementation of construct ===========================================
construct::construct()
{
	cname = "";	
	cscope = "";
	corder="-1";

	owner_parent_ref = NULL;
	ctype_ref = NULL;
	crels = NULL;
}

construct::~construct()
{
	cname = "";	
	cscope = "";
	corder="-1";

	owner_parent_ref = NULL;
	ctype_ref = NULL;
	crels = NULL;
}

construct* construct::clone(construct*) {return NULL;}

nvd construct::init() {}
nvd construct::clean() {}
construct* construct::process(...) {return NULL;}
construct* construct::operator()(...) {return NULL;}

// identity ===========================================================================================
nvd construct::set(nstr cname, nstr ctype, nstr cscope, nstr order)
{
		set_name(cname);
		set_type(ctype);
		set_scope(cscope);
		set_order(order);
}

nstr construct::name() 
{
	data_construct* r = (data_construct*) crels->get_relative("cname");
	if (r == NULL)
		return "";

	return *((nstr*) r->get());
}

nvd construct::set_name(nstr n) 
{
	data_construct* o = (data_construct*) crels->get_relative("cname");
	if (o == NULL) // create a relation
	{
		relations()->add_relative("cname", "dstr", (nvp) &n, this, "cname", "rel_encapsulation");
		return;
	}
	else	
		// set the new value
		o->set((nvp) &n);
}

construct* construct::owner() 
{
	construct* o = crels->get_relative("owner");
	return o;
}

nvd construct::set_owner(construct* p) 
{
	if (p == NULL)
		return;

	construct* o = crels->get_relative("owner");
	if (o == NULL) // create a relation
	{
		relations()->add_relative(this, p, "owner", "rel_container");
		return;
	}
	else	
		// set the new value
		crels->get_relation("owner")->set_referee(p);	
}

construct_type* construct::type() 
{
	construct* t = crels->get_relative("ctype");
	return (construct_type*) t;
}

nstr construct::type_str() 
{
	construct_type* t = type();
	if (t == NULL) return "";

	return t->name();
}

nvd construct::set_type(nstr type) 
{
	construct_type* t = NULL;
	construct* types_mem = $PI_MEM_C(_stack_m, _types_m);
	if (types_mem != NULL)
			t = (construct_type*) $NI_deref(types_mem)[type];

	if (t == NULL)
		return;

	construct* r = crels->get_relative("ctype");
	if (r == NULL) // create a relation
	{
		relations()->add_relative(this, t, "ctype", "rel_encapsulation");
		return;
	}
	else	
		// set the new value
		crels->get_relation("ctype")->set_referee(t);	
}

nstr construct::scope() 
{
	construct* r = crels->get_relative("cscope");
	if (r == NULL) return "";

	return r->name();
}

nvd construct::set_scope(nstr scope) 
{
	construct_type* t = NULL;
	construct* types_mem = $PI_MEM_C(_stack_m, _types_m);
	if (types_mem != NULL)
			t = (construct_type*) $NI_deref(types_mem)[scope];

	if (t == NULL)
		return;

	construct* r = crels->get_relative("cscope");
	if (r == NULL) // create a relation
	{
		relations()->add_relative(this, t, "cscope", "rel_encapsulation");
		return;
	}
	else	
		// set the new value
		crels->get_relation("owner")->set_referee(t);	
}

nstr construct::order() 
{
	data_construct* r = (data_construct*) crels->get_relative("corder");
	if (r == NULL)
		return "";

	return *((nstr*) r->get());
}

nvd construct::set_order(nstr order) 
{
	data_construct* o = (data_construct*) crels->get_relative("corder");
	if (o == NULL) // create a relation
	{
		relations()->add_relative("corder", "dstr", (nvp) &order, this, "corder", "rel_encapsulation");
		return;
	}
	else	
		// set the new value
		o->set((nvp) &order);
} 

// ==================================================================================================
// child constructs
nvd construct::set_relations(rels_construct* col) 
{
	crels = col;
	col->set_owner_ref(this);
}

construct* construct::operator [] (nstr relative)
{
	return (*relations())[relative]; 
}

// =================================================================================================================
collection_construct::collection_construct() 
{
	construct_list = new map<nstr, construct*>;
}
collection_construct::~collection_construct() 
{
}

nvd collection_construct::sort() 
{
	construct_list->begin();
}
	
// accessors
map<nstr, construct*>::iterator collection_construct::begin() 
{
	return construct_list->begin();
}

map<nstr, construct*>::iterator collection_construct::end() 
{
	return construct_list->end();
}

construct* collection_construct::operator [] (nstr child_name)
{
	return get_childc(child_name);
}

construct* collection_construct::get_childc(nstr xname, nstr xtype, 
																						match_criteria m)
{
	// is the self being queried?
	construct* p = owner();
	if (p != NULL)
		if (p->name() == xname)
			return p;

	// check if there is a ::
	nstr pname = xname;
	nstr cname = xname;
	nint pos = xname.find_first_of("::");
	
	if (pos != -1)
		pname = xname.substr(0, pos);

	construct* fc = NULL;

	if (construct_list->size() < 1)
		return NULL;

	for (it = construct_list->begin(); it != construct_list->end(); it++)
	{
		construct* c = ((construct*) it->second);
		if (c == NULL)
			continue;

		// things :: should be supported for xtype.
		if (!xtype.empty() && c->type() == NULL)
			continue;
		
		if (c->name() == pname)   
		{
			if (pos != -1 || 
				 xtype.empty() ||
				 (c->type() != NULL && 
				 construct_type::is_type_of_type(c->type()->name(), xtype)))
				 // IMMEDIATE
			{
				fc = c;
				break;
			}
		}
	}

	// recurse
	nbln deep = m & match_deep;
	if (fc == NULL && (!deep || pos != -1))
		return NULL;

	if (fc != NULL && pos != -1)
		return fc->relations()->get_childc(xname.substr(pos+2), xtype, m); 
	else if (fc != NULL)
		return fc;
	
	if (fc == NULL && deep)
	{
		construct* cc = NULL;
		for (it = begin(); it != end(); it++)
		{
			cc = ((construct*) it->second);
			if (cc != NULL && cc->relations() != NULL)
			{
				construct* ccc = cc->relations()->get_childc(xname, xtype, m); 
				if (ccc != NULL)
					return ccc;
			}
		}
	}

	return NULL;
}

collection_construct* collection_construct::get_children(nstr name, nstr type, 
																														match_criteria m)
{
	return NULL;
}

construct* collection_construct::get_childc_conditional(nstr name, nstr type, 
																									condition_construct* condition,
																									match_criteria m)
{
	return NULL;
}

construct* collection_construct::get_childc_linked(nstr member_construct, nstr member_type, 
																									 match_criteria m)
{
	// check to see if the link exists as a child of the current construct.
	construct* ret = (construct*) (*construct_list)[member_construct];
	if (ret) return ret;

	// get the ctype_ref and check if the link exists in it.
	if (type() != NULL)
	{
		ret = type()->relations()->get_childc_linked(member_construct, member_type, m);
		if (ret) 
			return ret;

		// check if the link exists in parent of ctype_ref..
		if (type()->owner() != NULL)
			return type()->owner()->relations()->get_childc_linked(member_construct, member_type, m);
	}

	return NULL;
}

// modify functions
construct* collection_construct::add_childc(construct* child)
{
	if (child != NULL)
		(*construct_list)[child->name()] = child;
	
	return child;
}

nvd collection_construct::remove_childc(construct* child)
{
	construct_list->erase(child->name());
}

// ================================ DEBUG FUNCTIONS ======================
nvd construct::dump_deep() { dump_construct_data(true);}
nvd construct::dump_construct_data(nbln deep, nint indent)
{
	if ((type() != NULL && 
			type()->name() != "collection_construct" && 
			type()->name() != "data_construct") || 
			type() == NULL ||
			name().find("cbuffer_data") == -1)
	{	
		nstr ind = "|";
		for (nint x=0;x<indent;x++)
			ind+=" |";

		ind+="--";
		nchrp t = "null";
		if (type() != NULL)
		{
			nstr h = type()->name();
			if (h != "")
				t = (nchrp) h.c_str();
		}
		else
		{
			nstr h = type_string;
			if (h != "")
				t = (nchrp) h.c_str();
		}

		nint ccount = -1;
		if (relations() != NULL)
			ccount = relations()->construct_list->size();

		printf("%s %s             ----------->[%s][%i]\n", ind.c_str(), cname.c_str(), t, ccount);
	}

	if (!deep)
		return;

	if (relations() != NULL)
		for (relations()->it = relations()->begin(); relations()->it != relations()->end(); relations()->it++)
			relations()->it->second->dump_construct_data(true, indent+1);
}

// =============================================================================================================
rel_construct::rel_construct()
{
}

rel_construct::~rel_construct()
{
}

nvd rel_construct::set_relationship(construct* referer, construct* referee, nstr rel_name, nstr rel_type, nstr ref_name, nstr ref_type)
{
	set_name(rel_name);
	set_relationship(rel_type);

	set_referer(referer);
	set_referee(referee);

	add_ref(ref_name, ref_type);
}

construct* rel_construct::get_referer()
{
	return relations()->get_relative("referer"); 
}

construct* rel_construct::get_referee()
{
	return relations()->get_relative("referee"); 
}

nstr rel_construct::get_relationship()
{
	return type_str();
}

nvd rel_construct::set_referer(construct* referer)
{
	// create a data cons called referer
	data_construct* r = (data_construct*) get_referer();
	if (!r)
	{
		relations()->add_relative("referer", "dcons", (nvp) referer, this, "referer", "rel_encapsulation");
		return;
	}
	
	r->set((nvp) referer);
}

nvd rel_construct::set_referee(construct* referee)
{
	data_construct* r = (data_construct*) get_referee();
	if (!r)
	{
		relations()->add_relative("referee", "dcons", (nvp) referee, this, "referee", "rel_encapsulation");
		return;
	}
	
	r->set((nvp) referee);
}

nvd rel_construct::set_relationship(nstr relation)
{
	// create a data cons called referer
	set_type(relation);
}

nvd rel_construct::add_ref(nstr ref_name, nstr ref_type) 
{
	construct* referer = get_referer();
	construct* referee = get_referee();

	referee->relations()->add_relative(referee, referer, ref_name, ref_type);
}

nvd rel_construct::remove_ref() 
{
	construct* referer = get_referer();
	construct* referee = get_referee();

	referee->relations()->remove_relative(referer);
}

// =============================================================================================================
rels_construct::rels_construct()
{
}

rels_construct::~rels_construct()
{
}

nvd rels_construct::add_relation(rel_construct* rel) 
{
	add_childc(rel);
}

construct* rels_construct::operator [] (nstr relative_construct_name)
{
	return get_relative(relative_construct_name);
}

rel_construct* rels_construct::get_relation(nstr relation_name, nstr relation_type, match_criteria m)
{
	return (rel_construct*) get_childc(relation_name, relation_type);
}

construct* rels_construct::get_relative(nstr relative_name, nstr relation_type, match_criteria m)
{
	// TODONOW: iterate and check the referee...name, type and return	
	// need to implement compare override for collections, where the actual compare of construct is overridden along with criteria
	// also need to implement sort in this manner..So you can sort based on the inner construct order value...But the main sort should be on
	// the relations...
	return NULL;
}

rels_construct* rels_construct::get_relations(nstr relation_type, match_criteria m){return NULL;} 	
collection_construct* rels_construct::get_relatives(nstr relation_type, match_criteria m){return NULL;}

construct* rels_construct::add_relative(nstr referee_name, nstr referee_type, nvp referee_value, construct* referer, 
																				nstr rel_name, nstr rel_type, construct* parent_rel, 
																				nstr scope, nstr order)
{
	// create the rel_construct 
	if (parent_rel == NULL)
		parent_rel = referer;

	rel_construct* rel = (rel_construct*) l_ins::ci_create_construct(rel_name, rel_type, parent_rel, scope, order);

	// create the relative
	construct* reltive = l_ins::ci_create_construct(referee_name, referee_type, rel);

	// set the relationship
	rel->set_relationship(referer, reltive, rel_type);
	
	// add this relation
	add_relation(rel);

	return reltive;
}

construct* rels_construct::add_relative(construct* referer, construct* referee, 
																				nstr rel_name, nstr rel_type, construct* parent_rel, 
																				nstr scope, nstr order)
{
	// create the rel_construct 
	if (parent_rel == NULL)
		parent_rel = referer;

	rel_construct* rel = (rel_construct*) l_ins::ci_create_construct(rel_name, rel_type, parent_rel, scope, order);

	// set the relation
	// set the relationship
	rel->set_relationship(referer, referee, rel_type);

	// add this relation
	add_relation(rel);

	return referee;
}

nvd rels_construct::remove_relation(rel_construct* rel) {}
nvd rels_construct::remove_relative(construct* relative) {}
nvd rels_construct::remove_relative(nstr relative_name, nstr relation_type, match_criteria m) {}

}}