#ifndef _RV_RULE_BASE_
#define _RV_RULE_BASE_

#include "rvXmlDocument.h"
#include "rvRulesDefines.h"

class CRuleBase
{
// db type functions on the rules xml document
public:
	void LoadRules();
	void ClearRules();
	void SaveRules();
	void DestroyRulesObject();

	nsAutoString* GetListOfRules() {}

public:
	CRuleBase();
	~CRuleBase();

	// Util functions
	nsIDOMElement* GetRootRuleNode(nsAutoString rule_name);
	nsIDOMElement* GetMainRuleNode(nsIDOMElement* p_root_rule_node);
	void GetSiblingNodesForRule(nsIDOMElement* p_rule_node, nsIDOMElement** prev, nsIDOMElement** next);
	bool LoadRule(nsAutoString RuleName);
	bool SaveRule();
	LeafNodeType GetLeafNodeType(nsIDOMElement* p_dom_node, nsIDOMElement** p_ret_leaf_node);
	nsresult GetImageFromDOMNode(nsIDOMNode* inNode, nsIImage**outImage);
};

#endif