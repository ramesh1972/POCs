#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvParentWindow.h"
#include "rvMainWindow.h"
#include "nsWebBrowserChrome.h"
#include "rvRulesCollection.h"
#include "rvRuleProcessor.h"

// externs
IAPPG;
IRULESG;

PRBool CRuleProcessor::m_always_show = PR_FALSE;

// Constructor Destructor

CRuleProcessor::CRuleProcessor()
{
	ILOG << "CRuleProcessor::CRuleProcessor()" << IDBG;
	IL_TAB;

	// Create the result array
	m_result_array = new nsVoidArray();
	m_html_document = nsnull;
	mInternalBrowser = nsnull;

	IL_UNTAB;
}

CRuleProcessor::~CRuleProcessor()
{
	ILOG << "CRuleProcessor::~CRuleProcessor()" << IDBG;
	IL_TAB;

	try
	{
		ClearRuleResultsArray();
		delete m_result_array;

		if (mInternalBrowser != nsnull)
		{
			IPWW->CloseBrowserWindow(mInternalBrowser);
			NS_IF_RELEASE(mInternalBrowser);
			mInternalBrowser = nsnull;
		}

		ILOG << "Destruction Complete" << IDBG;
		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleProcessor::~CRuleProcessor()" << IEXC;
		IL_UNTAB;
	}
}

II_RESULT CRuleProcessor::LoadDocument(nsAutoString url)
{
	ILOG << "CRuleProcessor::LoadDocument() " << "url=" << url << IINF;
	IL_TAB;

	if (url == MozStr(""))
	{
		ILOG << "Invalid URL" << IERR;
		IL_UNTAB;
		return IIR_INVALID_URL;
	}

	// Load the URL
	try
	{
		ILOG << "Creating Browser " << IINF;
		mInternalBrowser = new rvMainWindow();
		if (mInternalBrowser == nsnull)
		{
			ILOG << "rvMainWindow object is null" << IERR;
			IL_UNTAB;
			return IIR_NULL_BROWSER_INSTANCE;
		}

		NS_ADDREF(mInternalBrowser);

		ON_THE_RUN(IIR_APP_EXITED)
		mInternalBrowser->SetApp(IAPP);
		mInternalBrowser->m_window_type = eWindowType_toplevel;
		mInternalBrowser->m_border_style = eBorderStyle_none;

		ON_THE_RUN(IIR_APP_EXITED)
		mInternalBrowser->Init(IPWW,IAPP->mAppShell,nsRect(0,0,0,0));
		mInternalBrowser->m_doc_pos = 0;
		mInternalBrowser->mSubWinType = IIW_RuleProcessor;
		mInternalBrowser->MakeInvisible();

		// add the browser
		ON_THE_RUN(IIR_APP_EXITED)
		IPWW->AddBrowser(mInternalBrowser);

		// load the page
		ILOG << "Done creating Browser " << IINF;

		ILOG << "Loading URL" << IINF;
		mInternalBrowser->GoTo(url);

		// Wait for the document to get loaded
		II_RESULT res_wait = mInternalBrowser->WaitForDocumentToLoad();
		mInternalBrowser->mDocIsLoaded = PR_FALSE; //reset

		IL_UNTAB;
		return res_wait;

		// FinishLoadingDocument is called by the the webBrowserChrome and from which the Parse is initiated on the loaded html document
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleProcessor::LoadDocument() " << "url=" << url << IEXC;
		IL_UNTAB;
		return IIR_FAILED_DOCUMENT_LOAD;
	}
}

// ============== THE PRE PARSING FUNCTIONS ==================================
nsVoidArray* CRuleProcessor::ProcessRule_Parse(nsIDOMElement* p_rule_node)
{
	ILOG << "CRuleProcessor::ProcessRule_Parse() " << IINF;
	IL_TAB;

	try
	{
		if (p_rule_node == nsnull)
		{
			ILOG << "Null pointer passed in. p_rule_node " << IERR;
			IL_UNTAB;
			return nsnull;
		}
		
		m_rule_root_node = p_rule_node;

		// if no document loaded, then handle appropriately
		if (m_html_document == nsnull)
		{
			ILOG << "Null pointer . m_html_document not set" << IERR;
			IL_UNTAB;
			return nsnull;
		}

		// get the rule node which has the dom to be spotted
		m_rule_node = GetMainRuleNode(p_rule_node); // add refs
		if (m_rule_node == nsnull) // Something wrong fatally with the ProcessRule creation process	
		{
			ILOG << "Null pointer . main rule node not found" << IERR;
			IL_UNTAB;
			return nsnull;
		}

		ILOG << "Found main rule node" << IINF;

		//  ************ Check Based On ID If id exists ************
		ILOG << "-----------------------------------------------------" << IINF;
		ILOG << "Processing Rule Based on Id...." << IINF;

		// This will have the winning node match! (and if not multiple spots)
		nsVoidArray* toshow;

		// get the id form the rule
		nsAutoString dom_node_id_from_rule = _rules_doc->GetNodeID(m_rule_node);
		PRInt32 index = 0;
		
		// check if there is an id
		if (dom_node_id_from_rule != MozStr(""))
		{// Yes, then try to match with the help of this id
			
			ILOG << "ID Found " << dom_node_id_from_rule << IDBG;

			// get a list of all DOM elements that have the same id
			nsVoidArray elems_with_id;
			_rules_doc->GetElementsWithID(dom_node_id_from_rule, (nsIDOMElement*) m_html_document, elems_with_id);
			PRInt32 id_node_cnt = elems_with_id.Count();

			ILOG << id_node_cnt  << " dom nodes found with element id=" << dom_node_id_from_rule << IDBG;
			for (PRInt32 idx = 0; idx < id_node_cnt; idx++)
			{
				nsIDOMElement* elem = (nsIDOMElement*) elems_with_id[idx];
				RuleResult* result = ProcessRule_MatchDOMNode(m_rule_node, elem);
				if (result != nsnull)
					SortAndAddRuleResult(result);
				else
					NS_RELEASE(elem);
			}
			elems_with_id.Clear();

			ILOG << "Processed all the elements with same ID" << IDBG;

			// Process the Result Array. pick the highest percentile for nodes with id
			// Since we are matching with id, the match value should be very high
			ILOG << "Making Decision on the processed results" << IDBG;

			toshow = ProcessRule_Decide(90);
			if (toshow != nsnull)
			{
				ILOG << "Found results, Returning" << IDBG;
				NS_RELEASE(m_rule_node);
				ILOG << "Successfully Processed Rule Based on Id." << IINF;
				ILOG << "-----------------------------------------------------" << IINF;
				IL_UNTAB;
				ILOG << toshow->Count() << " results are returned" << IINF;
				return toshow;
			}

			// Ok nothing in the 90 percentile, so continue searching
		}
		else
			ILOG << "No ID Found in the Rule." << IINF;

		ILOG << "-----------------------------------------------------" << IINF;
		//  ************ Check Based On Parent TREE ************
		ILOG << "-----------------------------------------------------" << IINF;
		ILOG << "Processing Rule Based on Parent Tree...." << IINF;

		// got no id or no good match, so check from topmost, that is from p_rule_node that is passed in

		// get the rule start node
		nsIDOMElement* topmost_rule_node = _rules_doc->GetChildNode(m_rule_root_node, MozStr(RN_RULE)); // addrefs
		if (topmost_rule_node != nsnull)
		{
			// NOTE this adds multiple node matches to the ResultArray
			ILOG << "Calling ProcessRule_MatchDOMNodeParentTree...." << IINF;
			ProcessRule_MatchDOMNodeParentTree(topmost_rule_node, (nsIDOMElement*) m_html_document);
			ILOG << "ProcessRule_MatchDOMNodeParentTree done" << IINF;
		}
		else
		{
			ILOG << "Failed to Get instance." << " Topmost Rule node from rule root node" << IFTL;
			NS_IF_RELEASE(topmost_rule_node);
			IL_UNTAB;
			return nsnull;
		}

		NS_IF_RELEASE(topmost_rule_node);

		// Process the Result Array. Since we are matching with parent, the match value should be decently high
		ILOG << "Making Decision on the processed results" << IDBG;

		toshow = ProcessRule_Decide(80);
		if (toshow != nsnull)
		{
			ILOG << "Found results, Returning" << IDBG;
			NS_RELEASE(m_rule_node);
			ILOG << "Successfully processed Rule Based Parent tree." << IINF;
			ILOG << "-----------------------------------------------------" << IINF;
			IL_UNTAB;
			ILOG << toshow->Count() << " results are returned" << IINF;
			return toshow;
		}

		ILOG << "-----------------------------------------------------" << IINF;

		// Ok nothing found so far, so continue searching, the hungry one
		//  ************ Check Based On All the nodes of the document ************
		ILOG << "-----------------------------------------------------" << IINF;
		ILOG << "Processing Rule Based on hungry search over all nodes...." << IINF;

		// NOTE this adds multiple node matches to the ResultArray
		ILOG << "Calling ProcessRule_MatchAllDOMNodes" << IINF;
		ProcessRule_MatchAllDOMNodes((nsIDOMElement*) m_html_document, m_rule_node);
		ILOG << "ProcessRule_MatchAllDOMNodes done" << IINF;

		// Process the Result Array. Since we are matching all nodes, the match value should be very low
		toshow = ProcessRule_Decide(70);
		if (toshow != nsnull)
		{
			ILOG << "Found results, Returning" << IDBG;
			NS_RELEASE(m_rule_node);
			ILOG << "Successfully processed Rule Based on match on all nodes." << IINF;
			ILOG << "--------------------------------------------------------" << IINF;
			IL_UNTAB;
			ILOG << toshow->Count() << " results are returned" << IINF;
			return toshow;
		}
		ILOG << "----------------------------------------------------------" << IINF;

		ILOG << "----------------------------------------------------------" << IINF;
		ILOG << "No Good match found so far. Returning All MATCHED RESULTS" << IINF;

		// Aaaaarg!! no match, so pick the closest one 
		toshow = ProcessRule_Decide(-1);
		NS_RELEASE(m_rule_node);

		ILOG << "Done with ProcessRule_Parse() " << IINF;
		ILOG << m_result_array->Count() << " results are returned" << IINF;
		ILOG << "----------------------------------------------------------" << IINF;
		IL_UNTAB;
		return toshow;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleProcessor::ProcessRule_Parse()" << IEXC;
		ILOG << "Returning Null Results" << IERR;
		IL_UNTAB;
		NS_IF_RELEASE(m_rule_node);
		return nsnull;
	}
}

// ========== THE MAIN MATCH PROCESSING STARTER FUNCTIONS ==================================
RuleResult* CRuleProcessor::ProcessRule_MatchDOMNode(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	ILOG << "CRuleProcessor::ProcessRule_MatchDOMNode" << IDBG;
	IL_TAB;

	RuleResult *result = new RuleResult;
	result->id_match_mv = ProcessRule_MatchID(p_rule_node, p_dom_node);
	result->tag_match_mv = ProcessRule_MatchTagName(p_rule_node, p_dom_node);
	result->tag_attr_mv = ProcessRule_MatchAttributes(p_rule_node, p_dom_node);
	result->depth_mv = ProcessRule_MatchDepth(p_rule_node, p_dom_node);
	result->position_mv = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
	result->sib_before_count_mv = ProcessRule_MatchBeforeSibCount(p_rule_node, p_dom_node);
	result->sib_after_count_mv = ProcessRule_MatchAfterSibCount(p_rule_node, p_dom_node);
	result->child_count_mv = 	ProcessRule_MatchChildCount(p_rule_node, p_dom_node);

	result->sib_before_mv = ProcessRule_MatchPrevSibling(p_rule_node, p_dom_node);
	result->sib_after_mv = ProcessRule_MatchNextSibling(p_rule_node, p_dom_node);
	if (result->sib_before_mv == 0 || result->sib_after_mv == 0)
		result->sib_mixed_sib_mv = ProcessRule_MatchMixedSiblings(p_rule_node, p_dom_node);

	result->parent_mv = ProcessRule_MatchParentNode(p_rule_node, p_dom_node);

	// methods like matchnodechildren, matchnodecontent, matchnodechildrenandcontent are to be 
	// not used during initial searched, since these depend on the determination of the node.
	// These methods are to be used only after the spotting of a node. Incase of multiple matches of a node
	// these methods act like like boosters to determine the right match, or eliminate some of the
	// multiple matches.

	// all the basic matches have been done above. So compute the match value. 
	// If the document structure has not changed, then this will return 100%
	result->ComputeTotalMatchValue();
	ILOG << "Match Value:" << result->weighted_match_value << IDBG;
	result->html_node =  p_dom_node;

	IL_UNTAB;
	return result;
}

void CRuleProcessor::ProcessRule_MatchDOMNodeParentTree(nsIDOMElement* p_parent_rule_node, nsIDOMElement* p_parent_dom_node)
{
	ILOG << "CRuleProcessor::ProcessRule_MatchDOMNodeParentTree()" << IDBG;
	IL_TAB;

	// The Rules for the DOM Node contain the parent tree (and siblings of the parent node) of the 
	// dom to be spotted. Parse this tree top/down and find the dom node.
	// In case a certain parent node does not match, check the siblings
	// In such cases maintain an array of results retrieved from such each tree path

	// Initially pass the root parent of the rule and the dom node.
	// match the basic parameters of the parent. expect 100% match
	RuleResult *result = new RuleResult;
	result->id_match_mv = ProcessRule_MatchID(p_parent_rule_node, p_parent_dom_node);
	result->tag_match_mv = ProcessRule_MatchTagName(p_parent_rule_node, p_parent_dom_node);
	result->tag_attr_mv = ProcessRule_MatchAttributes(p_parent_rule_node, p_parent_dom_node);
	result->depth_mv = ProcessRule_MatchDepth(p_parent_rule_node, p_parent_dom_node);
	result->position_mv = ProcessRule_MatchPosition(p_parent_rule_node, p_parent_dom_node);

	result->ComputeTotalMatchValue();
	PRFloat64 parent_mv = result->weighted_match_value;
	ILOG << "Match Value:" << parent_mv << IDBG;

	// if the match is fairly close (75) then match the child paths
	if (parent_mv > 75)
	{
		ILOG << "Match Value:" << parent_mv << " Greater than 75" << IDBG;
		
		nsIDOMElement* rule_parent_child;
		rule_parent_child = _rules_doc->GetChildNode(p_parent_rule_node, MozStr(RN_RULE)); // addrefs
		nsAutoString rule_node_type = MozStr("");
		if (rule_parent_child != nsnull)
			rule_node_type = _rules_doc->GetNodeAttributeValue(rule_parent_child, MozStr(RN_TYPE));

		ILOG << "Rule Node Type:" << rule_node_type << IDBG;

		// recurse only if the rule nodes are one of the follwoing
		if (rule_node_type == MozStr(RNV_NODE) || rule_node_type == MozStr(RNV_PARENT))
		{
			ILOG << "matching the parent children" << IDBG;

			// get the child nodes of the dom parent
			nsIDOMNodeList* dom_parent_children; 
			p_parent_dom_node->GetChildNodes(&dom_parent_children); // addrefs
			PRUint32 dom_cnt = 0;
			if (dom_parent_children != nsnull)
				dom_parent_children->GetLength(&dom_cnt);

			ILOG << "dom child count:" << dom_cnt << IDBG;

			// Loop through the child nodes of the parent dom node and match
			for (PRUint32 idx = 0; idx < dom_cnt; idx++)
			{
				ILOG << "trying to match child:" << idx << IDBG;

				nsIDOMElement* dom_parent_child = nsnull;
				dom_parent_children->Item(idx, (nsIDOMNode**) &dom_parent_child); // addrefs

				// if we have hit the dom's rule node then check the dom node
				if (rvXmlDocument::IsWhiteSpace(dom_parent_child))
				{
					ILOG << " Child is whitespace" << IDBG;
					NS_RELEASE(dom_parent_child);
					continue;
				}

				PRFloat64 cmv = 0;
				if (rule_node_type == MozStr(RNV_NODE)) 
				{
					ILOG << " -------------------------" << IINF;
					ILOG << "Child is rule node" << IINF;

					nsAutoString rule_node_name = _rules_doc->GetNodeAttributeValue(rule_parent_child, MozStr(RN_TAG_NAME));
					nsAutoString dom_node_name = _rules_doc->GetNodeName(dom_parent_child);
					ILOG << "Matching rule " << rule_node_name << " with dom " << dom_node_name << IINF;

					RuleResult* crr = ProcessRule_MatchDOMNode(rule_parent_child, dom_parent_child); 
					ILOG << "parent's child match value:" << crr->weighted_match_value << IINF;

					if (crr->weighted_match_value > 50) // dom_parent_child addrefed
					{
						ILOG << "Node match value: " << crr->weighted_match_value << " is greater than 50, adding to result" << IINF;
						SortAndAddRuleResult(crr);
					}
					else
					{
						ILOG << "Node match value less than 50, descarding" << IDBG;
						delete crr;
						NS_RELEASE(dom_parent_child);
					}
				}
				else if (rule_node_type == MozStr(RNV_PARENT))
				{
					ILOG << " -----------------------------" << IDBG;
					ILOG << " Child is parent node" << IDBG;
					ProcessRule_MatchDOMNodeParentTree(rule_parent_child, dom_parent_child);
					NS_RELEASE(dom_parent_child);
				}
			}

			ILOG << "done matching parent children" << IDBG;
			NS_IF_RELEASE(dom_parent_children);
		}

		NS_IF_RELEASE(rule_parent_child);
	}

	delete result;

	ILOG << "Completed ProcessRule_MatchDOMNodeParentTree()" << IDBG;
	IL_UNTAB;
	
	// If we reached here then either
		// the parent node matches were poor, nothing to do, ignore this path
    // the parent tree is too short, that is count is 0, nothing to do, this is not going to match
		// the parent tree is too long, already reached child rule nodes in the rules tree, this is not going to match
		// something fatally wrong with the rule node types set during the rule creation
	return;
}

void CRuleProcessor::ProcessRule_MatchAllDOMNodes(nsIDOMElement* p_root_dom_node, nsIDOMElement* p_rule_node)
{
	ILOG << "CRuleProcessor::ProcessRule_MatchAllDOMNodes()" << IDBG;
	IL_TAB;

	// This method performs an hungry search for the dom node in all of the html document
	// To be called only after MatchDOMNode/MatchDOMNodeParent have failed to 
	// yield any concrete result
	nsresult rv;
  nsCOMPtr<nsIDOMDocumentTraversal> trav = do_QueryInterface(p_root_dom_node, &rv);
	if (NS_FAILED(rv))
	{
		ILOG << IMSG(IIR_FAILED_TO_GET_INTERFACE) << " nsIDOMDocumentTraversal " << IERR;
		IL_UNTAB;
		return;
	}

  nsCOMPtr<nsIDOMTreeWalker> walker;

	nsCOMPtr<nsIDOMNode> docAsNode = do_QueryInterface(p_root_dom_node);

  rv = trav->CreateTreeWalker(docAsNode, 
															nsIDOMNodeFilter::SHOW_ALL,
															nsnull, PR_TRUE, getter_AddRefs(walker));
	if (NS_FAILED(rv))
	{
		ILOG << IMSG(IIR_FAILED_TO_CREATE) << " nsIDOMTreeWalker " << IERR;
		IL_UNTAB;
		return;
	}

  nsIDOMNode* currentNode;
  walker->GetCurrentNode(&currentNode);
  while (currentNode)
  {
		RuleResult *result = new RuleResult;
		result->id_match_mv = ProcessRule_MatchID(p_rule_node, (nsIDOMElement*) currentNode);
		result->tag_match_mv = ProcessRule_MatchTagName(p_rule_node, (nsIDOMElement*) currentNode);

		// return if the id match is too low
		result->ComputeTotalMatchValue();
		if (result->weighted_match_value == 100)
		{
			ILOG << "Found Identity match value 100" << IDBG;

			result->tag_attr_mv = ProcessRule_MatchAttributes(p_rule_node, (nsIDOMElement*) currentNode);
			result->sib_before_mv = ProcessRule_MatchPrevSibling(p_rule_node, (nsIDOMElement*) currentNode);
			result->sib_after_mv = ProcessRule_MatchNextSibling(p_rule_node, (nsIDOMElement*) currentNode);
			if (result->sib_before_mv == 0 || result->sib_after_mv == 0)
				result->sib_mixed_sib_mv = ProcessRule_MatchMixedSiblings(p_rule_node, (nsIDOMElement*) currentNode);

			result->parent_mv = ProcessRule_MatchParentNode(p_rule_node, (nsIDOMElement*) currentNode);

			// return if the neighbours match is too low
			result->ComputeTotalMatchValue();
			if (result->weighted_match_value > 30)
			{
				ILOG << "Found Identity match value > 50" << IDBG;
				result->depth_mv = ProcessRule_MatchDepth(p_rule_node, (nsIDOMElement*) currentNode);
				result->position_mv = ProcessRule_MatchPosition(p_rule_node, (nsIDOMElement*) currentNode);
				result->sib_before_count_mv = ProcessRule_MatchBeforeSibCount(p_rule_node, (nsIDOMElement*) currentNode);
				result->sib_after_count_mv = ProcessRule_MatchAfterSibCount(p_rule_node, (nsIDOMElement*) currentNode);
				result->child_count_mv = 	ProcessRule_MatchChildCount(p_rule_node, (nsIDOMElement*) currentNode);
		
				// return if the position does not any value
				result->ComputeTotalMatchValue();
				if (result->weighted_match_value > 30)
				{
					ILOG << "Found Identity match value > 30" << IDBG;
					result->html_node = (nsIDOMElement*) currentNode; 

					ILOG << " -----------------------------" << IDBG;
					ILOG << "Found match with match value: " << result->weighted_match_value << "adding to result array" << IDBG;
					ILOG << " -----------------------------" << IDBG;
					SortAndAddRuleResult(result);
				}
			}
		}

		NS_RELEASE(currentNode);
		walker->NextNode(&currentNode);
	}

	ILOG << "Done CRuleProcessor::ProcessRule_MatchAllDOMNodes()" << IDBG;
	IL_UNTAB;
	return;
}

// =============================THE CORE ATOMIC MATCH FUNCTIONS ==============================
// ================================ Match Identity   =========================================
// ===================================== Content ===============================
PRFloat64 CRuleProcessor::ProcessRule_MatchID(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	// get the ids from the dom's rule node and the dom node
	nsAutoString dom_node_id_from_rule = _rules_doc->GetNodeID(p_rule_node);
	nsAutoString dom_node_id_from_doc = _rules_doc->GetNodeID(p_dom_node); 

	PRInt32 mv = 0;
	// match them
	if (dom_node_id_from_rule == dom_node_id_from_doc)
	{
		if (dom_node_id_from_rule == MozStr(""))
			mv = -1; // ignore if no ids exist in both
		else
			mv = 10;
	}

	IL_TAB;
	ILOG << "ProcessRule_MatchID match value:" << mv << IDBG;
	IL_UNTAB;
	return mv;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchTagName(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	// get the tag names from the dom's rule node and the dom node
	nsAutoString l_rule_dom_node_tag = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr(RN_TAG_NAME));
	nsAutoString l_dom_tag = _rules_doc->GetNodeName(p_dom_node);

	PRInt32 mv = 0;

	// match
	if (l_dom_tag == l_rule_dom_node_tag)
		mv = 10;

	IL_TAB;
	ILOG << "ProcessRule_MatchTagName match value:" << mv << IDBG;
	IL_UNTAB;

	return mv;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchAttributes(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	// get the attrs of the dom node
	nsIDOMNamedNodeMap* dom_attrs;
	p_dom_node->GetAttributes(&dom_attrs); // addrefs
	PRUint32 cnt = 0; PRUint32 cnt_rule = 0;
	if (dom_attrs == nsnull)
		cnt = 0;
	else
		dom_attrs->GetLength(&cnt);

	// get the count of rule attrs
	nsIDOMNamedNodeMap* rule_attrs;
	p_rule_node->GetAttributes(&rule_attrs); // addrefs
	if (rule_attrs == nsnull)
		cnt_rule = 0;
	else
		rule_attrs->GetLength(&cnt_rule);

	// if there are no attributes, confirm that the dom's rule node also has no attributes
	if (cnt == 0)
	{
		PRInt32 ret = 0;
		if (cnt_rule - TOTAL_RULE_ATTR_COUNT == 0)
			ret = -1; // ignore since both do not have attributes

		NS_IF_RELEASE(dom_attrs);
		NS_IF_RELEASE(rule_attrs);

		IL_TAB;
		ILOG << "ProcessRule_MatchAttributes match value:" << ret << IDBG;
		IL_UNTAB;

		return ret;
	}
		
	// both have attributes and hence check them
	PRFloat64 imp_attrs_matched_count = 0;PRInt32 imp_attr_count = 0;
	PRFloat64 matched_count = 0;
	
	for (PRInt32 idx = 0; idx < cnt; idx++)
	{
		nsIDOMNode* dom_attr;
		dom_attrs->Item(idx, &dom_attr); // addrefs
		nsAutoString dom_attr_name, dom_attr_value;
		dom_attr->GetNodeName(dom_attr_name);
		dom_attr->GetNodeValue(dom_attr_value);
	
		PRBool imp_attr = CheckIfNotExpectedToMatch(p_dom_node, dom_attr_name);

		// now get this attribute from the dom's rule node
		nsIDOMAttr* rule_attr_node = nsnull;
		nsAutoString rule_attr_value;
		PRBool has_attr;
		p_rule_node->HasAttribute(dom_attr_name,  &has_attr);
		if (has_attr)
		{
			nsresult rv = p_rule_node->GetAttributeNode(dom_attr_name, &rule_attr_node); // addrefs
			if (rule_attr_node != nsnull)
				rule_attr_node->GetValue(rule_attr_value);
			
			if (imp_attr)
			{
				imp_attr_count++;
				if (rule_attr_node != nsnull && rule_attr_value == dom_attr_value)
						imp_attrs_matched_count++;
			}
			else
			{
				if (rule_attr_node != nsnull && rule_attr_value == dom_attr_value)
						matched_count++;
			}

			NS_IF_RELEASE(rule_attr_node);
		}
		else
		{ 
			if (imp_attr) 
				imp_attr_count++;
		}

		NS_RELEASE(dom_attr);
	}

	// there could me attrs in the rule that do not exist in the dom
	PRInt32 extra_cnt = (cnt_rule-TOTAL_RULE_ATTR_COUNT)-cnt;
	if (extra_cnt > 0)
		cnt+=extra_cnt;

	PRFloat64 imp_mv = (imp_attrs_matched_count+1)/(imp_attr_count+1);
	PRFloat64 notimp_mv = (matched_count+1)/(cnt-imp_attr_count+1);
	PRFloat64 mv = (imp_mv*10 + notimp_mv*20)/3;

	NS_IF_RELEASE(dom_attrs);
	NS_IF_RELEASE(rule_attrs);

	IL_TAB;
	ILOG << "ProcessRule_MatchAttributes match value:" << mv << IDBG;
	IL_UNTAB;

	return mv;
}

// =================== MATCH STRUCTURE =============================================================
PRFloat64 CRuleProcessor::ProcessRule_MatchDepth(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 error;
	nsAutoString l_rule_dom_node_depth_str = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr(RN_DEPTH));
	PRInt32 l_rule_dom_node_depth = l_rule_dom_node_depth_str.ToInteger(&error);
	PRInt32 dom_node_depth = 0;
	_rules_doc->GetNodeDepth(p_dom_node, dom_node_depth); 

	if (l_rule_dom_node_depth == 0 && dom_node_depth == 0)
	{
		IL_TAB;
		ILOG << "ProcessRule_MatchDepth match value:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}
	
	PRFloat64 parity = CalculateParityValue(l_rule_dom_node_depth, dom_node_depth);
	IL_TAB;
	ILOG << "ProcessRule_MatchDepth match value:" << parity << IDBG;
	IL_UNTAB;

	return parity;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchPosition(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	// check position
	PRInt32 error;
	nsAutoString rule_node_pos_str = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr(RN_POSITION)); 
	PRInt32 rule_node_pos = rule_node_pos_str.ToInteger(&error);
	PRInt32 dom_node_pos = _rules_doc->GetNodePosition(p_dom_node); 

	if (rule_node_pos  == 0 && dom_node_pos == 0)
	{
		IL_TAB;
		ILOG << "ProcessRule_MatchPosition match value:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}

	PRFloat64 pos_parity = CalculateParityValue(rule_node_pos, dom_node_pos);
	IL_TAB;
	ILOG << "ProcessRule_MatchPosition match value:" << pos_parity << IDBG;
	IL_UNTAB;

	return pos_parity;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchBeforeSibCount(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 error;
	nsAutoString l_rule_dom_node_sib_str = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr(RN_SIB_BEFORE_COUNT));
	PRInt32 l_rule_dom_node_sib = l_rule_dom_node_sib_str.ToInteger(&error);
	PRInt32 dom_node_sib = _rules_doc->GetSiblingsBeforeCount(p_dom_node);

	if (l_rule_dom_node_sib == 0 && dom_node_sib == 0)
	{
		IL_TAB;
		ILOG << "ProcessRule_MatchBeforeSibCount match value:" << -1 << IDBG;
		IL_UNTAB;
		return -1;
	}

	// get the percentage of before count match, 100 being exact
	PRFloat64 parity = CalculateParityValue(l_rule_dom_node_sib, dom_node_sib); 
	IL_TAB;
	ILOG << "ProcessRule_MatchBeforeSibCount match value:" << parity << IDBG;
	IL_UNTAB;

	return parity;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchAfterSibCount(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 error;
	nsAutoString l_rule_dom_node_sib_str = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr(RN_SIB_AFTER_COUNT));
	PRInt32 l_rule_dom_node_sib = l_rule_dom_node_sib_str.ToInteger(&error);
	PRInt32 dom_node_sib = _rules_doc->GetSiblingsAfterCount(p_dom_node);

	if (l_rule_dom_node_sib == 0 && dom_node_sib == 0)
	{
		IL_TAB;
		ILOG << "ProcessRule_MatchAfterSibCount match value:" << -1 << IDBG;
		IL_UNTAB;
		return -1;
	}

	// get the percentage of before count match, 100 being exact
	PRFloat64 parity = CalculateParityValue(l_rule_dom_node_sib, dom_node_sib);
	IL_TAB;
	ILOG << "ProcessRule_MatchAfterSibCount match value:" << parity << IDBG;
	IL_UNTAB;

	return parity;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchChildCount(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 error;
	nsAutoString l_child_count_from_rule_str = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr(RN_CHILD_COUNT));
	PRInt32 l_child_count_from_rule = l_child_count_from_rule_str.ToInteger(&error);

	// get the doms child count
	PRInt32 l_child_count = _rules_doc->GetChildCount(p_dom_node);

	if (l_child_count == 0 && l_child_count_from_rule == 0)
	{
		IL_TAB;
		ILOG << "ProcessRule_MatchChildCount match value:" << -1 << IDBG;
		IL_UNTAB;
		return -1;
	}

	PRFloat64 parity = CalculateParityValue(l_child_count_from_rule, l_child_count); 
	IL_TAB;
	ILOG << "ProcessRule_MatchChildCount match value:" << parity << IDBG;
	IL_UNTAB;
	
	return parity;
}

// ===================================== Nodes In and Around ===============================
PRFloat64 CRuleProcessor::ProcessRule_MatchParentNode(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	nsIDOMElement* dom_parent; p_dom_node->GetParentNode((nsIDOMNode**) &dom_parent); // addrefs
	nsIDOMElement* rule_parent; p_rule_node->GetParentNode((nsIDOMNode**) &rule_parent); // addrefs
	nsAutoString node_name = _rules_doc->GetNodeName(rule_parent);

	// if this is the root rule node then ignore
	if (dom_parent == nsnull && node_name ==  MozStr(RN_RULE_ROOT))
	{
		NS_IF_RELEASE(dom_parent);
		NS_IF_RELEASE(rule_parent);
		IL_TAB;
		ILOG << "ProcessRule_MatchParent . rule and dom parent are both null, mv:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}

	// if one of them is null, then there is no match, return 0
	if (dom_parent == nsnull || node_name ==  MozStr(RN_RULE_ROOT))
	{
		NS_IF_RELEASE(dom_parent);
		NS_IF_RELEASE(rule_parent);
		IL_TAB;
		ILOG << "ProcessRule_MatchParent. Either dom or rule parent is null, mv:" << 0 << IDBG;
		IL_UNTAB;
		return 0;
	}

	RuleResult* prr = new RuleResult();
	prr->id_match_mv = ProcessRule_MatchID(rule_parent, dom_parent);
	prr->tag_match_mv = ProcessRule_MatchTagName(rule_parent, dom_parent);
	prr->tag_attr_mv = ProcessRule_MatchAttributes(rule_parent, dom_parent);
	
	prr->position_mv = ProcessRule_MatchPosition(rule_parent, dom_parent);
	prr->sib_before_count_mv = ProcessRule_MatchBeforeSibCount(rule_parent, dom_parent);
	prr->sib_after_count_mv = ProcessRule_MatchAfterSibCount(rule_parent, dom_parent);

	prr->sib_before_mv = ProcessRule_MatchPrevSibling(rule_parent, dom_parent);
	prr->sib_after_mv = ProcessRule_MatchNextSibling(rule_parent, dom_parent);

	prr->ComputeTotalMatchValue();
	PRFloat64 mv = prr->weighted_match_value; 
	delete prr;

	NS_IF_RELEASE(dom_parent);
	NS_IF_RELEASE(rule_parent);

	mv/=10;
	IL_TAB;
	ILOG << "ProcessRule_MatchParent match value:" << mv << IDBG;
	IL_UNTAB;

	return mv;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchPrevSibling(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	nsIDOMElement *rule_prev, *rule_next;
	GetSiblingNodesForRule(p_rule_node, &rule_prev, &rule_next); // addrefs

	nsIDOMElement *dom_prev;
	p_dom_node->GetPreviousSibling((nsIDOMNode**) &dom_prev); // addrefs
	while (dom_prev != nsnull && rvXmlDocument::IsWhiteSpace(dom_prev))
	{
		nsIDOMNode* prev_prev;
		dom_prev->GetPreviousSibling((nsIDOMNode**) &prev_prev); 
		NS_RELEASE(dom_prev);
		dom_prev = (nsIDOMElement*) prev_prev;
	}

	// nothing to match
	if (dom_prev == nsnull && rule_prev == nsnull)
	{
		NS_IF_RELEASE(rule_next);
		IL_TAB;
		ILOG << "ProcessRule_MatchPrevSibling both dom and rule prev are null, mv:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}

	// one of them failed to exist
	if (dom_prev == nsnull || rule_prev == nsnull)
	{
		NS_IF_RELEASE(rule_next);
		NS_IF_RELEASE(dom_prev);
		NS_IF_RELEASE(rule_prev);

		IL_TAB;
		ILOG << "ProcessRule_MatchPrevSibling either dom or rule prev is null, mv:" << 0 << IDBG;
		IL_UNTAB;

		return 0;
	}

	// both exist
	RuleResult* psrr = new RuleResult();
	psrr->id_match_mv = ProcessRule_MatchID(rule_prev, dom_prev);
	psrr->tag_match_mv = ProcessRule_MatchTagName(rule_prev, dom_prev);
	psrr->tag_attr_mv = ProcessRule_MatchAttributes(rule_prev, dom_prev);
	psrr->child_count_mv = 	ProcessRule_MatchChildCount(rule_prev, dom_prev);
	
	psrr->ComputeTotalMatchValue();
	PRFloat64 mv = psrr->weighted_match_value;
	delete psrr;

	NS_IF_RELEASE(rule_next);
	NS_IF_RELEASE(dom_prev);
	NS_IF_RELEASE(rule_prev);

	mv/=10;
	IL_TAB;
	ILOG << "ProcessRule_MatchPrevSibling mv:" << mv << IDBG;
	IL_UNTAB;
	
	return mv;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchNextSibling(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	nsIDOMElement *rule_prev, *rule_next;
	GetSiblingNodesForRule(p_rule_node, &rule_prev, &rule_next); // addrefs

	nsIDOMElement *dom_next;
	p_dom_node->GetNextSibling((nsIDOMNode**) &dom_next); // addrefs
	while (dom_next != nsnull && rvXmlDocument::IsWhiteSpace(dom_next))
	{
		nsIDOMNode* next_next;
		dom_next->GetNextSibling((nsIDOMNode**) &next_next); 
		NS_RELEASE(dom_next);
		dom_next = (nsIDOMElement*) next_next;
	}

	// nothing to match
	if (dom_next == nsnull && rule_next == nsnull)
	{
		NS_IF_RELEASE(rule_prev);
		IL_TAB;
		ILOG << "ProcessRule_MatchNextSibling both dom and rule next are null, mv:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}

	// one of them failed to exist
	if (dom_next == nsnull || rule_next == nsnull)
	{
		NS_IF_RELEASE(rule_prev);
		NS_IF_RELEASE(dom_next);
		NS_IF_RELEASE(rule_next);

		IL_TAB;
		ILOG << "ProcessRule_MatchNextSibling either dom or rule next is null, mv:" << 0 << IDBG;
		IL_UNTAB;

		return 0;
	}

	// both exist
	RuleResult* nsrr = new RuleResult();
	nsrr->id_match_mv = ProcessRule_MatchID(rule_next, dom_next);
	nsrr->tag_match_mv = ProcessRule_MatchTagName(rule_next, dom_next);
	nsrr->tag_attr_mv = ProcessRule_MatchAttributes(rule_next, dom_next);
	nsrr->child_count_mv = 	ProcessRule_MatchChildCount(rule_next, dom_next);
	
	nsrr->ComputeTotalMatchValue();
	PRFloat64 mv = nsrr->weighted_match_value;
	delete nsrr;

	NS_IF_RELEASE(rule_prev);
	NS_IF_RELEASE(dom_next);
	NS_IF_RELEASE(rule_next);

	IL_TAB;
	ILOG << "ProcessRule_MatchNextSibling mv:" << mv/10 << IDBG;
	IL_UNTAB;
	return mv/10;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchMixedSiblings(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	IL_TAB;
	ILOG << "CRuleProcessor::ProcessRule_MatchMixedSiblings()" <<  IDBG;

	// Get the parent and then the children of the dom node
	nsIDOMElement* parent = nsnull;
	p_dom_node->GetParentNode((nsIDOMNode**) &parent); // addrefs
	if (parent == nsnull)
	{
		ILOG << "dom parent is null, cannot match mv:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}

	// get all the children
	nsIDOMNodeList* children;
	parent->GetChildNodes(&children); // addrefs
	if (children == nsnull)
	{
		NS_RELEASE(parent);
		ILOG << "parent has no children, how? cannot match mv:" << -1 << IDBG;
		IL_UNTAB;

		return -1;
	}

	PRUint32 cnt;children->GetLength(&cnt);

	// Also get the dom's sibling rule nodes from the rule node
	nsIDOMElement *rule_prev, *rule_next;
	GetSiblingNodesForRule(p_rule_node, &rule_prev, &rule_next); // addrefs

	if (rule_prev == nsnull && rule_next == nsnull)
	{
		PRInt32 mv = -1;
		// but if there are children
		if (cnt > 0)
			mv = 0;

		ILOG << "match mv:" << mv << IDBG;
		IL_UNTAB;
		return mv;
	}

	ILOG << "children are there and checking" << IDBG;

	// now loop through and find the sibling nodes
	PRFloat64 largest_prev_mv = 0, largest_next_mv = 0;
	for (PRInt32 idx = 0; idx < cnt; idx++)
	{
		nsIDOMElement* child;
		children->Item(idx, (nsIDOMNode**) &child); // addrefs

		// for prev sibling, search the children for a match
		RuleResult* rr = new RuleResult();
		if (rule_prev != nsnull)
		{
			rr->id_match_mv = ProcessRule_MatchID(rule_prev, child);
			rr->tag_match_mv = ProcessRule_MatchTagName(rule_prev, child);
			rr->tag_attr_mv = ProcessRule_MatchAttributes(rule_prev, child);
			rr->child_count_mv = 	ProcessRule_MatchChildCount(rule_prev, child);

			// if matched
			rr->ComputeTotalMatchValue();
			if (rr->weighted_match_value > largest_prev_mv)
				largest_prev_mv = rr->weighted_match_value;
		}

		// for next sibling, search the children for a match
		if (rule_next != nsnull)
		{
			rr->id_match_mv = ProcessRule_MatchID(rule_next, child);
			rr->tag_match_mv = ProcessRule_MatchTagName(rule_next, child);
			rr->tag_attr_mv = ProcessRule_MatchAttributes(rule_next, child);
			rr->child_count_mv = 	ProcessRule_MatchChildCount(rule_next, child);

			// if matched
			rr->ComputeTotalMatchValue();
			if (rr->weighted_match_value > largest_next_mv)
				largest_next_mv = rr->weighted_match_value;
		}

		NS_RELEASE(child);

		delete rr;
	}

	NS_IF_RELEASE(rule_prev);
	NS_IF_RELEASE(rule_next);
	NS_IF_RELEASE(children);
	NS_RELEASE(parent);

	PRInt32 mv = 0;
	if (rule_prev != nsnull  && rule_next != nsnull)
		mv = (largest_prev_mv+largest_next_mv)/20;
	else if (rule_prev != nsnull)
		mv = largest_prev_mv/10;
	else if (rule_next != nsnull)
		mv = largest_next_mv/10;
	else
		mv = 0;

	ILOG << "match value:" << mv << IDBG;
	IL_UNTAB;
	return mv;
}

// ===================================== Content ===============================
PRFloat64 CRuleProcessor::ProcessRule_MatchNodeChildren(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	// check if the current node is a leaf node, if yes match
	II_RESULT res;
	PRInt32 cmv = ProcessRule_MatchContent(p_rule_node, p_dom_node, res);
	if (res != IIR_NOTHING_DONE) // then it was a leaf node and something was processed. could have been whitespace as well
	{
		IL_TAB;
		ILOG << "ProcessRule_MatchNodeChildren Leaf Node mv:" << cmv << IINF;
		IL_UNTAB;
		return cmv;
	}

	// ok got genuine child nodes
	nsIDOMNodeList* rule_node_list, *dom_node_list;
	p_rule_node->GetChildNodes(&rule_node_list); // addrefs
	p_dom_node->GetChildNodes(&dom_node_list); // addrefs

	// get the list of immediate children of the dom and the rule
	PRUint32 len = 0; rule_node_list->GetLength(&len);
	PRUint32 len_dom = 0; dom_node_list->GetLength(&len_dom);

	// proceed with further processing of children only if they exist
	PRInt32 processed_rules=0, processed_doms=0;
	PRFloat64 mv =0;PRFloat64 tot_mv =0;
	if (len != 0 && len_dom != 0)
	{
		// we cannot assume that child nodes will match, that is the whole point of this function 
		// so for each rule node, check it against all the dom child nodes and pick the highest
		// so ideally if all the rules matched then the match value at this depth should be 10. i.e. total/num_rules
		for (PRUint32 idx = 0; idx < len; idx++) 
		{
			nsIDOMElement* child_rule, *child_dom;
			rule_node_list->Item(idx, (nsIDOMNode**) &child_rule); // addrefs

			PRFloat64 highest_for_this_rule = 0;

			// proceed only if the rule has not been processed before
			for (PRUint32 idx1 =0; idx1 < len_dom; idx1++)
			{
				dom_node_list->Item(idx1, (nsIDOMNode**) &child_dom); // addrefs
				if (rvXmlDocument::IsWhiteSpace(child_dom))
				{
					NS_RELEASE(child_dom);
					continue;
				}

				// proceed only if the dom node has not been processed before
				// do a basic id match
				RuleResult crr;
				crr.id_match_mv = ProcessRule_MatchID(child_rule, child_dom);
				crr.tag_match_mv = ProcessRule_MatchTagName(child_rule, child_dom);
				crr.ComputeTotalMatchValue();

				// now check if the id, tag and the position match
				if (crr.weighted_match_value == 100)
				{
					PRFloat64 cmv = ProcessRule_MatchNodeChildren(child_rule, child_dom);
					if (cmv != -1)
					{
						crr.tag_attr_mv = ProcessRule_MatchAttributes(p_rule_node, p_dom_node);
						crr.sib_before_count_mv = ProcessRule_MatchBeforeSibCount(p_rule_node, p_dom_node);
						crr.sib_after_count_mv = ProcessRule_MatchAfterSibCount(p_rule_node, p_dom_node);
						crr.child_count_mv = 	ProcessRule_MatchChildCount(p_rule_node, p_dom_node);
						crr.ComputeTotalMatchValue();

						// structure match is more important than the content match, so give it three times the weightage
						PRFloat64 nmv = (cmv*2 + crr.weighted_match_value/10)/3;
						if (nmv > highest_for_this_rule)
							highest_for_this_rule = nmv;
					}
				}

				NS_IF_RELEASE(child_dom);
			}

			tot_mv+= highest_for_this_rule;					

			NS_IF_RELEASE(child_rule);
		}
	}


	NS_IF_RELEASE(rule_node_list);
	NS_IF_RELEASE(dom_node_list);

	
	// get the child dom count without the whitespace
	PRFloat64 this_node_mv = 0;
	len_dom = _rules_doc->GetChildCount(p_dom_node);
	PRInt32 len_rules = _rules_doc->GetChildCount(p_rule_node);
	if (len_dom != 0 && len_rules != 0) // there is a tree
	{
		mv = tot_mv/len_rules;
		if (len_dom == len_rules)
			this_node_mv = mv;
		else if (len_rules > len_dom) // there were less dom nodes this time
			this_node_mv = mv - (10-CalculateParityValue(len_rules, len_dom));
		else if (len_rules < len_dom)
			this_node_mv = mv - (10-CalculateParityValue(len_dom, len_rules));

		if (this_node_mv < 0) this_node_mv = 0;
	}
	else if (len_rules == 0 && len_dom == 0)
		this_node_mv = 10;
	else 
		this_node_mv = 0;
	
	IL_TAB;
	ILOG << "ProcessRule_MatchChildNode mv:" << mv << IDBG;
	IL_UNTAB;

	return this_node_mv;
}

PRFloat64 CRuleProcessor::ProcessRule_MatchContent(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node, II_RESULT &result)
{
	result = IIR_SUCCESS;

	II_HTMLNodeType type = rvHTMLElement::GetNodeType(p_dom_node); 
	if (type == IIN_Unknown || type == IIN_WhiteSpace || p_dom_node == nsnull)
	{
		result = IIR_FAILED;
		return -1; // invalid node
	}
	
	if (type == IIN_Text)
	{
		nsIDOMNode* txt_child_rule = _rules_doc->GetChildNode(p_rule_node, MozStr("Text"));
		if (txt_child_rule == nsnull)
		{
			result = IIR_FAILED;
			return -1;
		}

		nsIDOMNode* text_node;
		txt_child_rule->GetFirstChild(&text_node);
		if (text_node == nsnull)
		{
			result = IIR_FAILED;
			return -1;
		}

		nsAutoString rule_node_value, dom_node_value;

		text_node->GetNodeValue(rule_node_value);
		p_dom_node->GetNodeValue(dom_node_value);

		rule_node_value.StripWhitespace();
		dom_node_value.StripWhitespace();
		
		ILOG << rule_node_value << IINF;
		ILOG << dom_node_value << IINF;

		NS_RELEASE(text_node);
		NS_RELEASE(txt_child_rule);

		if (rule_node_value.Equals(dom_node_value))
		{
			if (rule_node_value.Equals(MozStr("")))
				return -1;
			else
				return 10;
		}
		else
			return 0;
	}

	// get the image properties and compare
	if (type == IIN_Image)
	{
		nsIImage* pimg;
		rvHTMLElement::GetImageFromDOMNode((nsIDOMNode*) p_dom_node, &pimg);
		if (pimg == nsnull)
			return nsnull;

		nsIDOMElement* image_node = _rules_doc->GetChildNode(p_rule_node, MozStr("Image"));
		
		PRFloat64 mv = 0;
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("BytesPix"), pimg->GetBytesPix())?mv+10:mv;
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("IsRowOrderTopToBottom"), pimg->GetIsRowOrderTopToBottom())?mv+10:mv;
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("PixWidth"), pimg->GetWidth())?mv+10:mv;	
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("PixHeight"), pimg->GetHeight())?mv+10:mv;	
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("HasAlphaMask"), pimg->GetHasAlphaMask())?mv+10:mv;	

		PRInt32 width=0, height=0;
		rvHTMLElement::GetImageDimensions(p_dom_node, width, height);
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("NaturalHeight"), height)?mv+10:mv;	
		mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("NaturalWidth"), width)?mv+10:mv;	

		nsColorMap* cmap = pimg->GetColorMap();
		if (cmap != nsnull)
			mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("NumColors"), cmap->NumColors)?mv+10:mv;	
		else
			mv = _rules_doc->CompareNodeTextValue(image_node, MozStr("NumColors"), -1)?mv+10:mv;	

		NS_RELEASE(pimg);
		return mv/8;
	}

	// value based inputs
	if (type == IIN_InputText || type == IIN_InputButton ||	type == IIN_InputReset ||	type == IIN_InputSubmit)
	{
		nsAutoString rule_node_value, dom_node_value;
		rule_node_value = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr("value"));
		II_RESULT res = rvHTMLElement::GetInputElementValue(p_dom_node, dom_node_value);

		rule_node_value.StripWhitespace();
		dom_node_value.StripWhitespace();
		ILOG << rule_node_value << IINF;
		ILOG << dom_node_value << IINF;

		PRFloat64 mv = 0;
		if (rule_node_value.Equals(dom_node_value))
		{
			if (rule_node_value.Equals((MozStr(""))))
				mv = -1;
			else
				mv = 10;
		}
		else
			mv = 0;

		return mv;
	}
	
	if (type == IIN_InputCheckBox || type == IIN_InputRadio)
	{
		PRInt32 dom_node_value;
		rvHTMLElement::GetInputElementChecked(p_dom_node, dom_node_value);

		PRInt32 rule_node_value;
		nsIDOMAttr* attr = _rules_doc->GetNodeAttribute(p_rule_node, MozStr("checked"));
		if (attr == nsnull)
			rule_node_value = 0;
		else
			rule_node_value = 1;
		
		if (rule_node_value == dom_node_value)
			return 10;
		else
			return 0;
	}

	if (type == IIN_Select)
	{
		// the number of options if not matched, then content has changed
		PRInt32 num_dom_options=0, num_rule_options=0;
		num_dom_options = _rules_doc->GetChildCount(p_dom_node);
		num_rule_options = _rules_doc->GetChildCount(p_rule_node);
		
		PRFloat64 mv = 0;
		if (num_dom_options == 0 && num_rule_options == 0)
			return -1;
		else if (num_dom_options == 0)
			return 0;
		else if (num_rule_options == 0)
			return 0;
		else if (num_dom_options != num_rule_options)
			mv = CalculateParityValue(num_dom_options, num_rule_options);
		else 
			mv = 10; // so far

		// for each option if the value and the text do not match then the content has changed.
		// get an option node from rule and check if it exists in the dom select node. Position is not important if the num options are different
		nsCOMPtr<nsIDOMHTMLSelectElement> sel_elem = do_QueryInterface(p_dom_node);
		nsCOMPtr<nsIDOMHTMLOptionsCollection> opt_col;
		sel_elem->GetOptions(getter_AddRefs(opt_col));
		nsIDOMNodeList* rule_option_list;
		p_rule_node->GetChildNodes(&rule_option_list); // addrefs

		// create a bool array to flag if the dom option was already matched
		PRBool* dom_opt_alreay_matched = new PRBool[num_dom_options];
		for (PRInt32 idx3 = 0; idx3 < num_dom_options;idx3++)  dom_opt_alreay_matched[idx3] = PR_FALSE;

		PRFloat64 opts_mv = 0;
		for (PRInt32 idx = 0;idx<num_rule_options; idx++)
		{
			// Get the Option Rule
			nsIDOMElement *rule_option, *dom_option;
			rule_option_list->Item(idx, (nsIDOMNode**) &rule_option); // addrefs

			// get value, get text
			nsAutoString rule_text = _rules_doc->GetNodeTextValue(rule_option , MozStr("Rule"));

			// Spot that Option in the DOM
			for (PRInt32 idx1 = 0;idx1 <num_dom_options; idx1++)
			{
				if (dom_opt_alreay_matched[idx1] == PR_TRUE)
					continue;

				opt_col->Item(idx1, (nsIDOMNode**) &dom_option); // addrefs
				nsAutoString dom_text = _rules_doc->GetNodeValue(dom_option);
	
				// spot
				if (dom_text == rule_text)
				{
					RuleResult result;
					result.id_match_mv = ProcessRule_MatchID(rule_option, dom_option);
					result.tag_match_mv = ProcessRule_MatchTagName(rule_option, dom_option);
					result.tag_attr_mv = ProcessRule_MatchAttributes(rule_option, dom_option);
					result.position_mv = ProcessRule_MatchPosition(rule_option, dom_option);
					result.ComputeTotalMatchValue();
					opts_mv+=(result.weighted_match_value/10);
					dom_opt_alreay_matched[idx1] = PR_TRUE;
					NS_RELEASE(dom_option);
					break;
				}

				NS_RELEASE(dom_option);
			}

			NS_RELEASE(rule_option);
		}

		NS_IF_RELEASE(rule_option_list);

		// calc the number of dom options matched
		mv =  (mv +opts_mv/num_dom_options)/2;

		// TODO: match selected values/indicies
		return mv;
	}

	// if not return -1, since this is not a leaf node
	result = IIR_NOTHING_DONE;
	return -1;
}

// ========================================================================================================
// ========== FUNCTIONS TO BE CALLED AFTER FINDIND A PROSPECTIVE MATCH ====================================
nsVoidArray* CRuleProcessor::ProcessRule_Decide(PRInt32 percentile)
{
	ILOG << "CRuleProcessor::ProcessRule_Decide()" << " percentile=" << percentile << IINF;
	IL_TAB;

	PRInt32 current_result_count = m_result_array->Count();
	ILOG << "Total result count:" << current_result_count << IINF;

	// If result count <= 0
	if (current_result_count <= 0)
	{
		IL_UNTAB;
		return nsnull;
	}

	// array of results to be returned
	nsVoidArray* results = new nsVoidArray();
	
	// if result count is 1
	if (current_result_count == 1)
	{
		RuleResult* first_result = (RuleResult*) m_result_array->ElementAt(0);
		PRFloat64 first_mv = first_result->weighted_match_value;

		if (first_result->node_content_mv == -1)
		{
			first_result->node_content_mv = ProcessRule_MatchNodeChildren(m_rule_node, ((RuleResult*) m_result_array->ElementAt(0))->html_node);
			first_result->ComputeTotalMatchValue();
		}

		// cutoff any further processing here
		if (first_result->weighted_match_value < percentile)
		{
			IL_TAB;
			return nsnull;
		}

		results->AppendElement((void*) first_result);
		return results;
	}
	
	// if result count is > 1
	// compute the top results which are within the 10 diff range
	if (current_result_count > 1)
	{
		RuleResult* first_result = (RuleResult*) m_result_array->ElementAt(0);
		PRFloat64 first_mv = first_result->weighted_match_value;
	
		PRBool foundCloseMatch = PR_FALSE;
		for (PRInt32 idx=1; idx<current_result_count;idx++)
		{
			RuleResult* temp_result = (RuleResult*) m_result_array->ElementAt(idx);
			
			// check if the next weighted match value is wihin 10 diff of the first one
			if (temp_result->weighted_match_value >= percentile && first_mv - temp_result->weighted_match_value < 10)
			{
				foundCloseMatch = PR_TRUE;
				if (temp_result->node_content_mv == -1)
				{
					temp_result->node_content_mv = ProcessRule_MatchNodeChildren(m_rule_node, ((RuleResult*) m_result_array->ElementAt(idx))->html_node);
					temp_result->ComputeTotalMatchValue();
				}
			}
			else
				break;
		}
		// idx contains the index until which results matter so far

		// if there were close matches
		if (foundCloseMatch)
		{
				// sort them, bubble sort
			for (PRInt32 idx2 = 0; idx2 <= idx;idx2++)
			{
				for (PRInt32 idx3 = idx2;idx3<=idx2-1;idx3++)
				{
						if (((RuleResult*) m_result_array->ElementAt(idx3+1))->weighted_match_value >((RuleResult*) m_result_array->ElementAt(idx3))->weighted_match_value)
					{
						RuleResult* temp = (RuleResult*) m_result_array->ElementAt(idx3);
						m_result_array->ReplaceElementAt(m_result_array->ElementAt(idx3+1),idx3);
						m_result_array->ReplaceElementAt((void*) temp, idx3+1);
					}
				}
			}

			// now pick the greatest of these first idx values, whihc are a close match, i.e. within 3 diff
			RuleResult* top_result = (RuleResult*) m_result_array->ElementAt(0);
			PRFloat64 top_mv = top_result->weighted_match_value;

			results->AppendElement(top_result);
			for (PRInt32 idx4=1; idx4<idx;idx4++)
			{
				RuleResult* temp_result = (RuleResult*) m_result_array->ElementAt(idx4);
				if (temp_result->weighted_match_value >= percentile && top_mv - temp_result->weighted_match_value < 3)
					results->AppendElement(temp_result);
				else
					break;
			}

			// return the highest nodes
			// Dump the results

			IL_UNTAB;
			return results;
		}
		else
		{
			// compute the final value
			RuleResult* temp = ((RuleResult*) m_result_array->ElementAt(0));
			if (temp->node_content_mv == -1)
			{
				temp->node_content_mv = ProcessRule_MatchNodeChildren(m_rule_node, temp->html_node);
				temp->ComputeTotalMatchValue();
			}

			if (temp->weighted_match_value >= percentile)
				results->AppendElement((void*) temp);
		}
	}
	
	// Dump Results
	PRInt32 count=results->Count();
	ILOG << "Returning result count:" << count << IINF;
	for (PRInt32 idx5=0;idx5<count;idx5++)
	{
		PRFloat64 mv = ((RuleResult*) results->ElementAt(idx5))->weighted_match_value;
		ILOG << "Result" << idx5+1 << "=" << mv << IINF;
	}

	IL_UNTAB;
	return results;

	// TODO : More complex decision making 
	//				based on multiple similar mvs
	//				based on mvs that are almost close
	//				based on type(nature) of page that is parsed
	//				based on poor mvs
	//				etc..
}

// ============== UTILITY FUNCTIONS ===================================================
void CRuleProcessor::SortAndAddRuleResult(RuleResult* result)
{
	m_result_array->AppendElement((void*) result);
	PRInt32 current_result_count = m_result_array->Count();
	if (current_result_count < 2)
		return;

	for (PRInt32 index = current_result_count-1; index > 0; index--)
	{
		RuleResult *current, *prev;
		current = (RuleResult*) m_result_array->ElementAt(index);
		prev = (RuleResult*) m_result_array->ElementAt(index-1);

		if (current->weighted_match_value > prev->weighted_match_value)
		{// swap
			m_result_array->ReplaceElementAt((void*) prev, index);
			m_result_array->ReplaceElementAt((void*) current, index-1);
		}
		else
			break;
	}
}

void CRuleProcessor::ClearRuleResultsArray()
{
	ILOG << "CRuleProcessor::ClearRuleResultsArray()" << IDBG;
	IL_TAB;

	try
	{
		PRInt32 cnt = m_result_array->Count();
		for (PRInt32 idx=0;idx<cnt;idx++)
		{
			RuleResult *res = (RuleResult*) m_result_array->ElementAt(idx);
			NS_IF_RELEASE(res->html_node);
			delete res;
		}
		
		m_result_array->Clear();
		ILOG << cnt << " elements cleared" << IDBG;
		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleProcessor::ClearRuleResultsArray()" << IEXC;
		IL_UNTAB;
	}
}

// =================== UTILITY FUNCTIONS ===================
PRFloat64 CRuleProcessor::CalculateParityValue(PRFloat64 p_val1, PRFloat64 p_val2)
{
	if (p_val1 == p_val2)
		return 10;

	if (p_val1 == 0 || p_val2 == 0)
	{
		p_val1++;
		p_val2++;
	}

	if (p_val2 > p_val1)
	{
		PRFloat64 temp = p_val1;
		p_val1 = p_val2;
		p_val2 = temp;
	}

	PRFloat64 parity = ((p_val1-p_val2)*10)/p_val1;
	if (parity < 0)
			parity*= -1;

	parity = 10 - parity;
	if (parity < 0)
		parity = 0;
	
	if (parity > 10)
		parity = 10;

	return parity;
}

PRBool CRuleProcessor::CheckIfNotExpectedToMatch(nsIDOMElement* node, nsAutoString p_attr_name)
{
	if (node == nsnull)
		return false;

	if (p_attr_name == MozStr(""))
		return false;

	if (p_attr_name.EqualsIgnoreCase("value"))
	{
		nsAutoString node_name = _rules_doc->GetNodeName(node);
		if (node_name.EqualsIgnoreCase("input"))
		{
			nsAutoString type = _rules_doc->GetNodeAttributeValue(node, MozStr("type"));
			if (type.EqualsIgnoreCase("text"))
				return true;
			else
				return false;
		}
	}
	
	if (p_attr_name.EqualsIgnoreCase("href")		|| 
			p_attr_name.EqualsIgnoreCase("src")			||
			p_attr_name.EqualsIgnoreCase("checked") ||
			p_attr_name.EqualsIgnoreCase("disabled"))
			return true;

	return false;
}

// =================== UNUSED FUNCTIONS ===================
nsresult CRuleProcessor::UpdateBaseURL()
{
/*
  nsIDOMHTMLDocument* domDoc;
  mAlertBrowser->GetDocument(domDoc);
  if (!domDoc) return NS_ERROR_FAILURE;

  // Look for an HTML <base> tag
  nsCOMPtr<nsIDOMNodeList> nodeList;
  nsresult rv = domDoc->GetElementsByTagName(NS_LITERAL_STRING("base"), getter_AddRefs(nodeList));
  NS_ENSURE_SUCCESS(rv, rv);

  nsCOMPtr<nsIDOMNode> baseNode;
  if (nodeList)
  {
    PRUint32 count;
    nodeList->GetLength(&count);
    if (count >= 1)
    {
      rv = nodeList->Item(0, getter_AddRefs(baseNode));
      NS_ENSURE_SUCCESS(rv, rv);
    }
  }
  // If no base tag, then set baseURL to the document's URL
  // This is very important, else relative URLs for links and images are wrong
  if (!baseNode)
  {
    nsCOMPtr<nsIDocument> doc = do_QueryInterface(domDoc);
    if (!doc) return NS_ERROR_FAILURE;

		//_ILOG(m_url);
		nsCAutoString spec;
		mInternalBrowser->mWebCrawler->mLastURL->GetSpec(spec);
		doc->SetDocumentURI(mInternalBrowser->mWebCrawler->mLastURL);
		doc->SetBaseURI(mInternalBrowser->mWebCrawler->mLastURL);
		
		//_ILOG(spec.get());

		/*
		PRInt32 last_slash_pos = spec.RFind("/");
		spec.Left(spec, last_slash_pos+1);
		_ILOG(spec.get());
		
		nsIDOMNode* new_base;
		nsIDOMNode *retval_from_map;
		rv = domDoc->CreateElement(MozStr("BASE"), (nsIDOMElement**) &new_base);
		_rules_doc->DumpNode((nsIDOMElement*) new_base);
		nsCOMPtr<nsIDOMNodeList> nodeList;
		nsresult rv = domDoc->GetElementsByTagName(NS_LITERAL_STRING("html"), getter_AddRefs(nodeList));
		NS_ENSURE_SUCCESS(rv, rv);

		nsCOMPtr<nsIDOMNode> headNode;
		if (nodeList)
		{
			PRUint32 count;
			nodeList->GetLength(&count);
			if (count >= 1)
			{
				rv = nodeList->Item(0, getter_AddRefs(headNode));
				NS_ENSURE_SUCCESS(rv, rv);
			}
		}

		rv = headNode->AppendChild(new_base, &retval_from_map);

		nsIDOMAttr* href;
		rv = domDoc->CreateAttribute(MozStr("href"), &href);
		rv = href->SetValue(spec);
		nsIDOMNamedNodeMap* map;
		rv = new_base->GetAttributes(&map); 


		rv = map->SetNamedItem(href, &retval_from_map);
		

		//_rules_doc->DumpNode((nsIDOMElement*) domDoc);

  }
	else
		; // need to change the base uri
		*/
  return NS_OK;
}

