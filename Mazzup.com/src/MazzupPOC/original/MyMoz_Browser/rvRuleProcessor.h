#ifndef _RV_RULE_PROCESSOR_
#define _RV_RULE_PROCESSOR_

#include "rvXPCOMIDs.h"
#include "rvRuleBase.h"
#include "rvMainWindow.h"
#include "rvRulesDefines.h"
#include "rvRuleResult.h"

class CRuleProcessor : public CRuleBase
{
public:
	CRuleProcessor();
	~CRuleProcessor();

	// The following member is a DOM node (with children+tree) 
	// that contains all the rule information for spotting a DOM node
	nsIDOMHTMLDocument* m_html_document;
	nsIDOMElement* m_dom_node;
	nsIDOMElement* m_rule_root_node;
	nsIDOMElement* m_rule_node;
	nsVoidArray* m_result_array;
	PRBool m_content_changed;
	static PRBool m_always_show;
	PRBool m_IsCurrentRuleProcessed;
	rvMainWindow* mInternalBrowser;

	// ********* THE CORE: Important functions ************
	// html related members
	nsresult LoadDocument(nsAutoString url);
	void SetFrameHTMLDocument(nsAutoString frame_url, nsAutoString frame_location);
	nsVoidArray* ProcessRule_Parse(nsIDOMElement* p_rule_node);
	nsresult FinishedLoadingDocument();
	nsresult WaitForDocumentToLoad();
	void SetProcessedHTMLDoc(nsIDOMElement* p_html_node);

	// match starter functions
	RuleResult* ProcessRule_MatchDOMNode(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	void ProcessRule_MatchDOMNodeParentTree(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	void ProcessRule_MatchAllDOMNodes(nsIDOMElement* p_root_dom_node, nsIDOMElement* p_rule_node);

	// match core functions
	PRFloat64 ProcessRule_MatchID(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchTagName(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchAttributes(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchDepth(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchPosition(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchBeforeSibCount(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchAfterSibCount(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchChildCount(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchParentNode(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchPrevSibling(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchNextSibling(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchMixedSiblings(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchNodeChildren(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	PRFloat64 ProcessRule_MatchLeafNodeContent(LeafNodeType type, nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node);
	
	// From the DB a Rule is picked and Processed (POST)
	nsVoidArray* ProcessRule_Decide(PRInt32 percentile);
	void SortAndAddRuleResult(RuleResult* result);
	void ClearRuleResultsArray();

	// Util functions
	nsresult UpdateBaseURL();
	PRFloat64 CalculateParityValue(PRFloat64 p_val1, PRFloat64 p_val2);
	PRBool CheckIfNotExpectedToMatch(nsIDOMElement* node, nsAutoString p_attr_name);
};

#endif