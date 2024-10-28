#ifndef _RV_RULE_RENDERER_
#define _RV_RULE_RENDERER_

#include "rvXPCOMIDs.h"
#include "rvRuleBase.h"
#include "rvMainWindow.h"
#include "rvRuleResult.h"

class CRuleRenderer : public CRuleBase
{
public:
	CRuleRenderer();
	~CRuleRenderer();

	// The following member is a DOM node (with children+tree) 
	// that contains all the rule information for spotting a DOM node
	nsIDOMHTMLDocument* m_html_document;
	nsIDOMElement* m_dom_node;
	nsVoidArray m_other_dom_nodes_to_display;
	nsAutoString m_rule_name;
	nsAutoString m_url;
	rvMainWindow* mAlertBrowser;

	II_RESULT ProcessPickMeCommand(nsIDOMElement* p_matched_html_node, nsIDOMElement* p_processed_rule_node, PRBool p_content_has_changed);
};

#endif