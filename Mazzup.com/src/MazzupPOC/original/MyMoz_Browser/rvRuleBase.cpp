#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvXmlDocument.h"
#include "rvRuleBase.h"

extern rvMyMozApp* theApp;
rvXmlDocument* _rules_doc;

// const/destr
CRuleBase::CRuleBase()
{
}

CRuleBase::~CRuleBase()
{
}

nsIDOMElement* CRuleBase::GetRootRuleNode(nsAutoString rule_name)
{
	nsIDOMElement* doc_elem = _rules_doc->GetDocumentElement(); 
	nsIDOMElement* rule_node = _rules_doc->GetChildNodeWithAttributeValue(doc_elem, MozStr(RN_NAME), rule_name); 

	return rule_node;
}

nsIDOMElement* CRuleBase::GetMainRuleNode(nsIDOMElement* p_root_rule_node)
{
	if (p_root_rule_node == nsnull)
		return nsnull;

	nsIDOMDocument* doc = nsnull;
	p_root_rule_node->GetOwnerDocument(&doc);
	if (doc == nsnull)
		return nsnull;

	nsresult rv;
  nsCOMPtr<nsIDOMDocumentTraversal> trav = do_QueryInterface(doc, &rv);
	if (rv != NS_OK)
	{
		NS_RELEASE(doc);
		return nsnull;
	}

  nsCOMPtr<nsIDOMTreeWalker> walker;
	nsCOMPtr<nsIDOMNode> docAsNode = do_QueryInterface(p_root_rule_node);
  rv = trav->CreateTreeWalker(docAsNode, 
															nsIDOMNodeFilter::SHOW_ALL,
															nsnull, PR_TRUE, getter_AddRefs(walker));
	if (rv != NS_OK)
	{
		NS_RELEASE(doc);
		return nsnull;
	}

  nsIDOMNode* currentNode;
  walker->GetCurrentNode(&currentNode);
  while (currentNode)
  {
		nsAutoString name;
		currentNode->GetNodeName(name);
		if (name == MozStr(RN_RULE))
		{
			nsAutoString rulenode_type = _rules_doc->GetNodeAttributeValue((nsIDOMElement*) currentNode, MozStr(RN_TYPE));
			if (rulenode_type == MozStr(RNV_NODE))
			{
				NS_RELEASE(doc);
				return (nsIDOMElement*) currentNode;
			}
		}

		NS_RELEASE(currentNode);
		walker->NextNode(&currentNode);
	}

	NS_RELEASE(doc);
	return nsnull;
}

void CRuleBase::GetSiblingNodesForRule(nsIDOMElement* p_rule_node, nsIDOMElement** prev, nsIDOMElement** next)
{
	if (p_rule_node == nsnull)
		return;

	*prev =*next=nsnull;

	nsIDOMElement* sib_node;
	p_rule_node->GetPreviousSibling((nsIDOMNode**) &sib_node); 
	if (sib_node == nsnull)
		return;

	nsIDOMNodeList* list;
	sib_node->GetChildNodes(&list);
	PRUint32 len = 0;list->GetLength(&len);
	if (len > 0)
	{
		for (PRInt32 idx =0; idx <len;idx++)
		{
			nsIDOMNode* child = nsnull;
			list->Item(idx, &child);
			
			nsAutoString type = _rules_doc->GetNodeAttributeValue((nsIDOMElement*) child, MozStr(RN_TYPE));
			if (type == MozStr(RNV_PREV_SIB))
				*prev = (nsIDOMElement*) child;
			else if (type == MozStr(RNV_NEXT_SIB))
				*next = (nsIDOMElement*) child;
			else
				NS_RELEASE(child);
		}
	}

	NS_IF_RELEASE(list);
	NS_RELEASE(sib_node);
}

void CRuleBase::LoadRules()
{
	if (_rules_doc == nsnull)
	{
		_rules_doc = new rvXmlDocument();
		_rules_doc->_doc_loaded = false;
	}
	else
		return;

	nsAutoString xml_rules_uri;
	xml_rules_uri.Append(NS_LITERAL_STRING(XMLDB_PATH));
	xml_rules_uri.Append(NS_LITERAL_STRING(RULES_FILE));

	if (_rules_doc->LoadFromFile(xml_rules_uri))
		return;

	// else create one
	_rules_doc->CreateEmptyDocument(MozStr(RN_RULES));
}

void CRuleBase::ClearRules()
{
	nsIDOMElement* doc_elem = _rules_doc->GetDocumentElement();
	if (doc_elem == nsnull)
		return;

	nsIDOMNode* first_child;
	doc_elem->GetFirstChild(&first_child);

	while (first_child != nsnull)
	{
		nsIDOMNode* old;
		doc_elem->RemoveChild(first_child, &old);
		NS_RELEASE(first_child);
		NS_RELEASE(old);
		doc_elem->GetFirstChild(&first_child);
	}

	NS_RELEASE(doc_elem);

	SaveRules();
}

void CRuleBase::SaveRules()
{
	nsCAutoString file_path("C:\\MyMozFiles\\MyMozDB\\");
	nsCAutoString file(RULES_FILE);
	
	_rules_doc->Save(file_path, file);
}

void CRuleBase::DestroyRulesObject()
{
	if (_rules_doc == nsnull)
		return;

	_rules_doc->Destroy();
	delete _rules_doc;
	_rules_doc = nsnull;
}

// TODO: With DB
bool CRuleBase::LoadRule(nsAutoString RuleName)
{
	//_ILOG(RuleName);
	nsIDOMElement* node = _rules_doc->GetNode(RuleName); 

	nsAutoString name, value;
	node->GetNodeName(name);
	node->GetNodeValue(value);

	//_ILOG(name);_ILOG(value);

	return nsnull;
}	

// TODO. Now it saves all the rules, do it for DB 
bool CRuleBase::SaveRule()
{
	SaveRules();
	return PR_TRUE;
}

LeafNodeType CRuleBase::GetLeafNodeType(nsIDOMElement* p_dom_node, nsIDOMElement** p_ret_p_leaf_node)
{
	// Check if this is a valid node
	if (p_dom_node == nsnull)
	{
			*p_ret_p_leaf_node = nsnull;
			return LNT_Unknown;
	}

	nsIDOMElement *dom_child = nsnull;
	dom_child = p_dom_node; 
	NS_IF_ADDREF(dom_child);

	// get the next genuine node, that is not whitespace
	while(dom_child != nsnull && _rules_doc->IsWhiteSpace(dom_child))
	{
		nsIDOMNode* next;
		dom_child->GetNextSibling((nsIDOMNode**) &next);
		NS_RELEASE(dom_child);
		dom_child = (nsIDOMElement*) next;
	}

	if (dom_child == nsnull)
	{
			*p_ret_p_leaf_node = nsnull;
			return LNT_WhiteSpace;
	}

	nsAutoString dom_child_node_name = _rules_doc->GetNodeName(dom_child);
	if (dom_child_node_name.EqualsIgnoreCase("#text"))
	{
			*p_ret_p_leaf_node = dom_child;
			return LNT_Text;
	}
	else if (dom_child_node_name.EqualsIgnoreCase("img") || dom_child_node_name.EqualsIgnoreCase("image"))
	{
			*p_ret_p_leaf_node = dom_child;
			return LNT_Image;
	}
	else if (dom_child_node_name.EqualsIgnoreCase("a") || dom_child_node_name.EqualsIgnoreCase("anchor"))
	{
		*p_ret_p_leaf_node = dom_child;
		return LNT_Anchor;
	}
	else if (dom_child_node_name.EqualsIgnoreCase("input"))
	{
		*p_ret_p_leaf_node = dom_child;
		nsAutoString type = _rules_doc->GetNodeAttributeValue(dom_child, MozStr("type"));
		if (type.EqualsIgnoreCase("text"))
			return LNT_InputText;
		if (type.EqualsIgnoreCase("button"))
			return LNT_InputButton;
		if (type.EqualsIgnoreCase("checkbox"))
			return LNT_InputCheckBox;
		if (type.EqualsIgnoreCase("radio"))
			return LNT_InputRadio;
		if (type.EqualsIgnoreCase("reset"))
			return LNT_InputReset;
		if (type.EqualsIgnoreCase("submit"))
			return LNT_InputSubmit;

		return LNT_InputText;
	}
	else if (dom_child_node_name.EqualsIgnoreCase("button"))
	{
		*p_ret_p_leaf_node = dom_child;
		return LNT_Button;
	}
	else if (dom_child_node_name.EqualsIgnoreCase("select"))
	{
		*p_ret_p_leaf_node = dom_child;
		return LNT_Select;
	}
	else
	{
		PRUint32 child_cnt= _rules_doc->GetChildCount(dom_child);		
		if (child_cnt > 1)
		{
			NS_IF_RELEASE(dom_child);
			*p_ret_p_leaf_node = nsnull;
			return LNT_NotALeaf;
		}

		nsIDOMNode* first = nsnull;
		dom_child->GetFirstChild((nsIDOMNode**) &first); 
		if (first == nsnull)
		{
			NS_RELEASE(dom_child);
			*p_ret_p_leaf_node = nsnull;
			return LNT_Unknown;
		}

		dom_child_node_name = _rules_doc->GetNodeName((nsIDOMElement*) first);
		if (dom_child_node_name.EqualsIgnoreCase("#text"))
		{
			NS_RELEASE(dom_child);
			*p_ret_p_leaf_node = (nsIDOMElement*) first;
			return LNT_TextContainer;
		}

		NS_RELEASE(first);
		NS_RELEASE(dom_child);
		*p_ret_p_leaf_node = nsnull;
		return LNT_NotALeaf;
	}

	NS_IF_RELEASE(dom_child);
	return LNT_NotALeaf;
}

nsresult CRuleBase::GetImageFromDOMNode(nsIDOMNode* inNode, nsIImage**outImage)
{
  NS_ENSURE_ARG_POINTER(outImage);
  *outImage = nsnull;

  nsCOMPtr<nsIImageLoadingContent> content(do_QueryInterface(inNode));
  if (!content) {
    return NS_ERROR_NOT_AVAILABLE;
  }

  nsCOMPtr<imgIRequest> imgRequest;
  content->GetRequest(nsIImageLoadingContent::CURRENT_REQUEST,
                      getter_AddRefs(imgRequest));
  if (!imgRequest) {
    return NS_ERROR_NOT_AVAILABLE;
  }
  
  nsCOMPtr<imgIContainer> imgContainer;
  imgRequest->GetImage(getter_AddRefs(imgContainer));

  if (!imgContainer) {
    return NS_ERROR_NOT_AVAILABLE;
  }
    
  nsCOMPtr<gfxIImageFrame> imgFrame;
  imgContainer->GetFrameAt(0, getter_AddRefs(imgFrame));

  if (!imgFrame) {
    return NS_ERROR_NOT_AVAILABLE;
  }
  
  nsCOMPtr<nsIInterfaceRequestor> ir = do_QueryInterface(imgFrame);

  if (!ir) {
    return NS_ERROR_NOT_AVAILABLE;
  }
  
  return CallGetInterface(ir.get(), outImage);
}




