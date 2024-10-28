#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvParentWindow.h"
#include "rvMainWindow.h"
#include "nsWebBrowserChrome.h"
#include "rvRuleProcessor.h"
#include "rvRuleRenderer.h"

extern rvMyMozApp* theApp;
extern rvXmlDocument* _rules_doc;

// Constructor Destructor
CRuleRenderer::CRuleRenderer()
{
}

CRuleRenderer::~CRuleRenderer()
{
}

nsresult CRuleRenderer::ProcessPickMeCommand(nsIDOMElement* p_matched_html_node, nsIDOMElement* p_processed_rule_node, PRBool p_content_has_changed)
{
	if (CRuleProcessor::m_always_show == PR_FALSE && p_content_has_changed == PR_FALSE)
		return nsnull;

	// Now we are ok to display the node
	nsIDOMElement* node_to_display = nsnull;

	// Check if the parent node has to be displayed
	nsIDOMElement* dom_node = p_matched_html_node;
	nsIDOMElement* rule_node = GetMainRuleNode(p_processed_rule_node); // addrefs
	node_to_display = dom_node;

	nsAutoString display_parent = _rules_doc->GetNodeAttributeValue(rule_node, MozStr(RN_DISPLAY_PARENT)); 
	while (display_parent.EqualsIgnoreCase("true"))
	{
		nsIDOMElement* parent = nsnull;
		
		node_to_display->GetParentNode((nsIDOMNode**) &parent);  // addrefs
		if (parent == nsnull)
			break;

		// clone the parent node, but not deep
		nsIDOMElement* parent_clone;
		parent->CloneNode(PR_FALSE, (nsIDOMNode**) &parent_clone); // addrefs
		
		NS_RELEASE(parent);

		// append the dom node to the parent
		nsIDOMNode* old; 
		parent_clone->AppendChild((nsIDOMNode*) node_to_display, &old); //addrefs
		NS_IF_RELEASE(old);

		// now replace the node to display to that of the parent
		node_to_display = parent_clone;
		NS_RELEASE(parent_clone);

		// check iteratively for the grand parent node
		nsIDOMElement* parent_rule_node = nsnull;
		rule_node->GetParentNode((nsIDOMNode**) &parent_rule_node); // addrefs
		if (parent_rule_node == nsnull)
			break;

		display_parent = _rules_doc->GetNodeAttributeValue(parent_rule_node, MozStr(RN_DISPLAY_PARENT)); 
		NS_RELEASE(parent_rule_node);
	}

	// Done with the rule
	NS_RELEASE(rule_node);

	// Check if any other nodes have to be displayed
	// usually all scripts, stypes etc..have to be included in the display

	// first:special nodes
	nsIDOMElement* current_node = node_to_display;

	while (true)
	{
		if (current_node == nsnull)
			break;

		nsAutoString dom_node_name = _rules_doc->GetNodeName(current_node);
		if (dom_node_name.EqualsIgnoreCase("map"))
		{// Map element has an id that is used by other nodes like image nodes
			nsAutoString map_id = _rules_doc->GetNodeID(node_to_display);
			//_ILOG("MAP NAME");_ILOG(map_id);

			// now check if there are any nodes in the html doc that have the usemap attribute set to this id
			nsAutoString map_id_with_hash(MozStr("#"));
			map_id_with_hash.Append(map_id);
			//_ILOG(map_id_with_hash);

			// add those nodes that use the map
			_rules_doc->GetNodesWithAttributeValue((nsIDOMElement*) m_html_document, MozStr("usemap"), map_id_with_hash, m_other_dom_nodes_to_display); // addrefs
		}
		
		// check if there is usemap for the spotted node
		// get the map name
		nsAutoString map_attr_val = _rules_doc->GetNodeAttributeValue(current_node, MozStr("usemap"));
		if (!map_attr_val.EqualsIgnoreCase(""))
		{
			map_attr_val.StripChar('#');
			
			// get the map
			// add those nodes that use the map
			_rules_doc->GetNodesWithAttributeValue((nsIDOMElement*) m_html_document, MozStr("id"), map_attr_val, m_other_dom_nodes_to_display); // addrefs
			_rules_doc->GetNodesWithAttributeValue((nsIDOMElement*) m_html_document, MozStr("name"), map_attr_val, m_other_dom_nodes_to_display); // addrefs
		}

		// do the same things for the parent nodes as well
		nsIDOMNode* next_parent;
		current_node->GetParentNode(&next_parent); 
		current_node = (nsIDOMElement*) next_parent;
		NS_IF_RELEASE(next_parent);
	}

	// second: add all the standard nodes scripts, links, style sheet etc..
	nsresult rv;
  nsCOMPtr<nsIDOMDocumentTraversal> trav = do_QueryInterface(m_html_document, &rv);
  NS_ENSURE_SUCCESS(rv, NS_ERROR_FAILURE);
  nsCOMPtr<nsIDOMTreeWalker> walker;

	nsCOMPtr<nsIDOMNode> docAsNode = do_QueryInterface(m_html_document);
  rv = trav->CreateTreeWalker(docAsNode, 
															nsIDOMNodeFilter::SHOW_ALL,
															nsnull, PR_TRUE, getter_AddRefs(walker));
  NS_ENSURE_SUCCESS(rv, NS_ERROR_FAILURE);

  nsCOMPtr<nsIDOMNode> currentNode;
  walker->GetCurrentNode(getter_AddRefs(currentNode));
  while (currentNode)
  {
		nsAutoString name;
		currentNode->GetNodeName(name);
		if (name.EqualsIgnoreCase("script") || name.EqualsIgnoreCase("style") || name.EqualsIgnoreCase("link") || name.EqualsIgnoreCase("menu"))
		{
			nsIDOMNode* node = currentNode;
			NS_ADDREF(node);
			m_other_dom_nodes_to_display.AppendElement(node);
		}

		walker->NextNode(getter_AddRefs(currentNode));
	}

	// Clone and clear the results array for the next parse
	m_dom_node = node_to_display;
	NS_ADDREF(m_dom_node);

	// show the document
	// Load an empty URL
	nsString url(NS_LITERAL_STRING("file:///c:/MyMozFiles/AppFiles/empty.html"));  
	mAlertBrowser = new rvMainWindow();
  NS_ENSURE_TRUE(mAlertBrowser, NS_ERROR_FAILURE);
  NS_ADDREF(mAlertBrowser);

  mAlertBrowser->SetApp(theApp);
	mAlertBrowser->m_window_type = eWindowType_toplevel;
	mAlertBrowser->m_border_style = eBorderStyle_all;
  mAlertBrowser->Init(theApp->mParentWindow,theApp->mAppShell,nsRect(0, 0, 400, 300));
	mAlertBrowser->mSubWinType = IIW_AlertView;
	mAlertBrowser->SetRuleRenderer(this);

  // add the browser
  theApp->mParentWindow->AddBrowser(mAlertBrowser);

  // load the page
	mAlertBrowser->GoTo(url);

	return NS_OK;
}

nsresult CRuleRenderer::FinishedLoadingAlertDocument()
{
	// flash the content
	// add it to the Alert Window
	nsIDOMHTMLDocument * aDocument;
	mAlertBrowser->GetDocument(aDocument); // addrefs

	if (aDocument == nsnull)
		return NS_OK; // ERR: Should Not Happen 

	nsIDOMHTMLElement* body;
	aDocument->GetBody(&body); // addrefs

	// *****************************************
	// append all the other elements, while doing so fix up URLs
	PRUint32 len = m_other_dom_nodes_to_display.Count();
	if (len > 0)
	{
		for (PRUint32 idx = 0; idx < len; idx++)
		{
			nsIDOMNode* node = (nsIDOMNode*) m_other_dom_nodes_to_display[idx];
			nsIDOMNode* clone;
			node->CloneNode(PR_TRUE, &clone);
			NS_RELEASE(node);

			nsIDOMNode* old;
			body->AppendChild(clone, &old);
			NS_IF_RELEASE(old);
			NS_RELEASE(clone);
		}
	}
	m_other_dom_nodes_to_display.Clear();

	// append THEE DOM ELEMENT! 	
	nsIDOMNode* node_new = nsnull;
	m_dom_node->CloneNode(PR_TRUE, &node_new);
	NS_RELEASE(m_dom_node);

	nsIDOMNode* ret;
	body->AppendChild(node_new, &ret);
	NS_RELEASE(node_new);
	NS_IF_RELEASE(ret);
	// *****************************************
 
  nsCOMPtr<nsIDocument> doc = do_QueryInterface(aDocument);
  if (!doc) 
	{
		NS_RELEASE(body);
		NS_RELEASE(aDocument);
		NS_RELEASE(mAlertBrowser);
		mAlertBrowser = nsnull;
		delete this;
		
		return NS_ERROR_FAILURE;
	}

	// Set the right URI
	nsCAutoString spec;
	nsIURI* uri;
	NS_NewURI(&uri, m_url);
	doc->SetDocumentURI(uri);
	doc->SetBaseURI(uri);

	// persist/archive the page
	mAlertBrowser->mSubWinType = IIW_AlertView;
	mAlertBrowser->SavePage(m_rule_name);

	NS_RELEASE(uri);
	NS_RELEASE(body);
	NS_RELEASE(aDocument);
	NS_RELEASE(mAlertBrowser);
	mAlertBrowser = nsnull;
	delete this;
  return NS_OK;
}
