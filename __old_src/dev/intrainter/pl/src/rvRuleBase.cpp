#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvXmlDocument.h"
#include "rvRuleBase.h"

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
	ILOG << "CRuleBase::GetRootRuleNode()" << "rule_name=" << rule_name << IINF;
	IL_TAB;

	nsIDOMElement* doc_elem = _rules_doc->GetDocumentElement(); 
	if (doc_elem == nsnull)
	{
		ILOG << "Failed to get document element for Rules XMl" << IFTL;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMElement* rule_node = _rules_doc->GetChildNodeWithAttributeValue(doc_elem, MozStr(RN_NAME), rule_name); 
	
	IL_UNTAB;
	//NS_RELEASE(doc_elem);
	return rule_node;
}

nsIDOMElement* CRuleBase::GetMainRuleNode(nsIDOMElement* p_root_rule_node)
{
	try
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
		while (rv == NS_OK && currentNode)
		{
			//_rules_doc->DumpNode((nsIDOMElement*) currentNode);
			nsAutoString name;
			currentNode->GetNodeName(name);
			if (name == MozStr(RN_RULE))
			{
				nsAutoString rulenode_type = _rules_doc->GetNodeAttributeValue((nsIDOMElement*) currentNode, MozStr(RN_TYPE));
				if (rulenode_type == MozStr(RNV_NODE))
				{
					NS_RELEASE(doc);
					NS_ADDREF(currentNode);
					return (nsIDOMElement*) currentNode;
				}
			}

			NS_IF_RELEASE(currentNode);
			rv = walker->NextNode(&currentNode);
		}

		NS_RELEASE(doc);
		return nsnull;
	}
	catch(...)
	{
		IL_TAB;
		ILOG << "Caught Exception in CRuleBase::GetMainRuleNode()" << IEXC;
		IL_UNTAB;
		return nsnull;
	}
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
	ILOG << "CRuleBase::LoadRules()" << IINF;
	IL_TAB;

	try
	{
		if (_rules_doc == nsnull)
		{
			_rules_doc = new rvXmlDocument();
			_rules_doc->_doc_loaded = false;
		}
		else
		{
			ILOG << "Already loaded" << IINF;
			IL_UNTAB;
			return;
		}

		ILOG << "Loading XML Rules DB" << IINF;
		nsAutoString xml_rules_uri;
		xml_rules_uri.Append(PWW_DATA_ROOT_FILE_PROTOCOL);
		xml_rules_uri.Append(PWW_XML_DB_DIR);
		xml_rules_uri.Append(NS_LITERAL_STRING("/"));
		xml_rules_uri.Append(PWW_RULES_FILE);

		if (_rules_doc->LoadFromFile(xml_rules_uri))
		{
			ILOG << "Successfully Loaded XML Rules" << IINF;
			IL_UNTAB;
			return;
		}

		// else create one
		ILOG << "Failed to Load XML Rules" << IINF;
		ILOG << "Creating an empty one" << IINF;
		_rules_doc->CreateEmptyDocument(MozStr(RN_RULES));
		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleBase::LoadRules()" << IEXC;
		IL_UNTAB;
	}
}

void CRuleBase::ClearRules()
{
	try
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
	catch(...)
	{
		IL_TAB;
		ILOG << "Caught Exception in CRuleBase::ClearRules()" << IEXC;
		IL_UNTAB;
	}
}

void CRuleBase::SaveRules()
{
	ILOG << "CRuleBase::SaveRules()" << IINF;
	IL_TAB;

	try
	{
		if (_rules_doc == nsnull)
		{
			ILOG << "Rules DB Not Loaded, to save" << IINF;
			IL_UNTAB;
			return;
		}

		nsAutoString file_path(PWW_DATA_ROOT);
		file_path.Append(NS_LITERAL_STRING("\\"));
		file_path.Append(PWW_XML_DB_DIR);
		file_path.Append(NS_LITERAL_STRING("\\"));

		nsAutoString file(PWW_RULES_FILE);
		
		ILOG << "XML DB file path: " << file_path << IINF;
		ILOG << "XML DB file     : " << file << IINF;
		_rules_doc->Save(file_path, file);
		ILOG << "Saved Xml Rules DB" << IINF;
		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleBase::SaveRules()" << IEXC;
		IL_UNTAB;
	}
}

void CRuleBase::DestroyRulesObject()
{
	ILOG << "CRuleBase::DestroyRulesObject()" << IINF;
	IL_TAB;

	try
	{
		if (_rules_doc == nsnull)
		{
			ILOG << "XML DB Rules not loaded to destroy" << IINF;
			IL_UNTAB;
			return;
		}

		_rules_doc->Destroy();
		delete _rules_doc;
		_rules_doc = nsnull;
		ILOG << "XML DB Rules object destroyed" << IINF;
		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleBase::SaveRules()" << IEXC;
		IL_UNTAB;
	}
}

// TODO: With DB
bool CRuleBase::LoadRule(nsAutoString RuleName)
{
	nsIDOMElement* node = _rules_doc->GetNode(RuleName); 

	nsAutoString name, value;
	node->GetNodeName(name);
	node->GetNodeValue(value);

	return nsnull;
}	

// TODO. Now it saves all the rules, do it for DB 
bool CRuleBase::SaveRule()
{
	SaveRules();
	return PR_TRUE;
}





