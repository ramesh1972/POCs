#ifndef _RV_RULE_CREATOR_
#define _RV_RULE_CREATOR_

#include "rvRuleBase.h"

class CRuleCreator : public CRuleBase
{
public:
	CRuleCreator();
	~CRuleCreator();

	// The following member is a DOM node (with children+tree) 
	// that contains all the rule information for spotting a DOM node
	RuleInfo* m_rule_info;

	// ********* THE CORE: Important functions ************
	// Rules are created upon a selection of a DOM Node on a WWW Page
	void CreateRule(RuleInfo* p_rinfo);

	void CreateRootNode();
	void CreateCommands();

	void CreateRuleNode();
	II_RESULT CreateRuleNode_AddContent(nsIDOMElement* p_dom_node,nsIDOMElement* l_rule_node);
	void CreateRuleNode_ParentTree(nsIDOMElement* p_dom_node, nsIDOMElement** p_rule_node);
	void CreateRuleNode_MakeAttributes(nsIDOMElement* p_dom_node, nsIDOMElement* p_rule_node);
	void CreateRuleNode_AddSiblings(nsIDOMElement* p_dom_node, nsIDOMElement* p_rule_node);
	void CreateRuleNode_ChildTree(nsIDOMElement* p_dom_node, nsIDOMElement* p_rule_node);

	// Util functions
	bool SetURL();
	bool SetTitle();
};

#endif