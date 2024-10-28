#pragma warning(disable:4786)

#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvXmlDocument.h"
#include "rvMessageList.h"

rvXmlDocument::rvXmlDocument()
{
	try
	{
		ILOG << "rvXmlDocument::rvXmlDocument()" << IINF;
		IL_TAB;

		_xml_file = MozStr("");
		_doc_loaded = PR_FALSE;

		nsresult rv;
		rv = nsComponentManager::CreateInstance(kXMLDocumentCID, nsnull, kIDOMXMLDocumentIID, (void**) &_xml_doc);
		if (NS_SUCCEEDED(rv))
		{
			_xml_doc->SetAsync(PR_FALSE);
			ILOG << IMSG(IIR_CREATED_INSTANCE) << "kXMLDocumentCID" << IINF;
		}
		else
		{
			ILOG << IMSG(IIR_CREATE_INSTANCE_FAILED) << "kXMLDocumentCID " << "nsresult=" << rv << IFTL;
		}

		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << IMSG(IIR_EXCEPTION) << IFTL;
		IL_UNTAB;
	}
}

rvXmlDocument::~rvXmlDocument()
{
	Destroy();
}

PRBool rvXmlDocument::LoadFromString(nsAutoString xml)
{
		nsCOMPtr<nsIDOMParser>  pDOMParser;
		nsresult rv;
		
		pDOMParser = do_CreateInstance( NS_DOMPARSER_CONTRACTID, &rv );

    if (NS_SUCCEEDED( rv )) 
        rv = pDOMParser->ParseFromString(xml.get(), "text/xml", (nsIDOMDocument**) &_xml_doc);
		else
			return PR_FALSE;

		if (_xml_doc) 
		{
				nsCOMPtr<nsIDOMElement> element;
				_xml_doc->GetDocumentElement(getter_AddRefs(element));
				nsAutoString tagName;
				if (element) 
					element->GetTagName(tagName);
				return PR_TRUE;
		}

		return PR_FALSE;
}

PRBool rvXmlDocument::LoadFromFile(nsAutoString XmlFile) 
{
	try
	{
		ILOG << "rvXmlDocument::LoadFromFile() " << "XmlFile=" << XmlFile << IINF;
		IL_TAB;

		if (_xml_doc == nsnull)
		{
			ILOG << IMSG(IIR_NULL_POINTER) << "_xml_doc" << IERR;
			IL_UNTAB;
			return PR_FALSE;
		}

		nsresult rv;
		_xml_file = XmlFile;	
		rv = _xml_doc->Load(_xml_file, &_doc_loaded);
		if (NS_SUCCEEDED(rv) && _doc_loaded == 1)
		{
			//NS_ADDREF(_xml_doc);
			ILOG << IMSG(IIR_LOADED_FROM_FILE) << IINF;
			IL_UNTAB;
			return PR_TRUE;
		}

		ILOG << IMSG(IIR_FAILED_TO_LOAD_FROM_FILE) << "nsresult=" << rv << IERR;
		IL_UNTAB;
		return PR_FALSE;
	}
	catch(...)
	{
		ILOG << IMSG(IIR_EXCEPTION) << IFTL;
		IL_UNTAB;
		return PR_FALSE;
	}
}

bool rvXmlDocument::Save(nsAutoString p_path, nsAutoString p_file) 
{
	nsAutoString sfile;
	sfile.Append(p_path);
	sfile.Append(p_file);

	nsCOMPtr<nsILocalFile> file;
	nsCString acstr_file;
	LossyCopyUTF16toASCII(sfile, acstr_file);
  NS_NewNativeLocalFile(acstr_file, TRUE, getter_AddRefs(file));

  nsCOMPtr<nsILocalFile> dataPath;
	nsCString acstr_path;
	LossyCopyUTF16toASCII(p_path, acstr_path);
  NS_NewNativeLocalFile(acstr_path, TRUE, getter_AddRefs(dataPath));

	nsresult rv;
	const char* const kPersistContractID = "@mozilla.org/embedding/browser/nsWebBrowserPersist;1";
	nsCOMPtr<nsIWebBrowserPersist> persist(do_CreateInstance(kPersistContractID, &rv));
  if (!persist)
     return false;

	persist->SaveDocument(_xml_doc, file, dataPath, "text/xml", nsIWebBrowserPersist::ENCODE_FLAGS_FORMATTED | nsIWebBrowserPersist::ENCODE_FLAGS_CR_LINEBREAKS | nsIWebBrowserPersist::ENCODE_FLAGS_LF_LINEBREAKS ,0);
	return true;
}

void rvXmlDocument::Destroy() 
{
	if (_xml_doc != nsnull)
	{
		NS_RELEASE(_xml_doc);
		_xml_doc = nsnull;
	}

	_xml_file = MozStr("");
	_doc_loaded = PR_FALSE;
}

PRBool rvXmlDocument::CreateEmptyDocument(nsAutoString name) 
{
	ILOG << "rvXmlDocument::CreateEmptyDocument() " << "name=" << name << IDBG;
	IL_TAB;

	_doc_loaded = PR_FALSE;
	nsIDOMElement* doc_elem;

	if (_xml_doc == nsnull)
	{
		ILOG << IMSG(IIR_NULL_POINTER) << "_xml_doc" << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsresult result = _xml_doc->CreateElement(name, &doc_elem);
	if (result != NS_OK)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Document element" << " rv=" << result << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMNode* old;
	result = _xml_doc->AppendChild(doc_elem, &old);
	if (result != NS_OK)
	{
		NS_IF_RELEASE(old);
		NS_RELEASE(doc_elem);
		ILOG << IMSG(IIR_APPEND_DOM_FAILED) << IERR;
		IL_UNTAB;
		return nsnull;
	}

	NS_IF_RELEASE(old);
	NS_RELEASE(doc_elem);
	_doc_loaded = PR_TRUE;

	IL_UNTAB;
	return _doc_loaded;
}

nsIDOMElement* rvXmlDocument::GetDocumentElement()
{
	ILOG << "rvXmlDocument::GetDocumentElement() " << IDBG;
	IL_TAB;

	if (_xml_doc == nsnull)
	{
		ILOG << IMSG(IIR_NULL_POINTER) << "_xml_doc" << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMElement* doc_elem;
	nsresult rv  = _xml_doc->GetDocumentElement(&doc_elem);
	if (NS_SUCCEEDED(rv))
	{
		IL_UNTAB;
		return doc_elem;
	}

	ILOG << IMSG(IIR_FAILED_TO_GET_DOC_ELEMENT) << "nsresult=" << rv << IERR;
	IL_UNTAB;
	NS_RELEASE(doc_elem);
	return nsnull;
}

nsIDOMElement* rvXmlDocument::GetIfChildNodeExists(nsIDOMElement* parent, nsIDOMElement* child)
{
	if (parent == nsnull || child == nsnull)
		return nsnull;

	// check if child exists
	nsIDOMElement* child_node = GetChildNode(parent, GetNodeName(child));
	if (child_node == NULL)
		return nsnull;

	// compare the attributes of child and child_node
	PRBool attr_same = CompareNodeAttributes(child_node, child);
	if (!attr_same)
	{
		NS_RELEASE(child_node);
		return nsnull;
	}

	return child_node;
}

PRBool rvXmlDocument::CompareNodeAttributes(nsIDOMElement* node1, nsIDOMElement* node2)
{
	if (node1 == nsnull || node2 == nsnull)
		return PR_FALSE;

	nsIDOMNamedNodeMap* map1;
	node1->GetAttributes(&map1); 
	PRUint32 len1;
	map1->GetLength(&len1);

	nsIDOMNamedNodeMap* map2;
	node2->GetAttributes(&map2); 
	PRUint32 len2;
	map2->GetLength(&len2);

	if (len1 != len2)
	{
		NS_RELEASE(map1);
		NS_RELEASE(map2);
		return PR_FALSE;
	}

	if (len1 == 0)
	{
		NS_RELEASE(map1);
		NS_RELEASE(map2);

		return PR_TRUE;
	}

	for (PRInt32 idx = 0; idx<len1; idx++)
	{
		nsIDOMElement* attr1;
		map1->Item(idx, (nsIDOMNode**) &attr1);

		nsAutoString name1;
		nsAutoString val1;
		attr1->GetNodeName(name1);
		attr1->GetNodeValue(val1);
	
		// check if this attribute exists in the map2.
		nsIDOMNode* attr2;
		map2->GetNamedItem(name1, &attr2);
		if (attr2 == NULL)
		{
			NS_RELEASE(map1);
			NS_RELEASE(map2);
			NS_RELEASE(attr1);
			return PR_FALSE;
		}

		nsAutoString val2;
		attr2->GetNodeValue(val2);
		if (!val1.Equals(val2))
		{
			NS_RELEASE(map1);
			NS_RELEASE(map2);
			NS_RELEASE(attr1);
			NS_RELEASE(attr2);
			return PR_FALSE;
		}

		NS_RELEASE(attr1);
		NS_RELEASE(attr2);
	}

	NS_RELEASE(map1);
	NS_RELEASE(map2);

	return PR_TRUE;
}
	
nsIDOMElement* rvXmlDocument::CreateNode(nsIDOMElement* parent, nsAutoString node_name, PRUint32 index)
{
	ILOG << "rvXmlDocument::CreateNode() " << "node_name=" << node_name << ",index=" << index << IDBG;
	IL_TAB;

	if (parent == nsnull || node_name == MozStr(""))
	{
		ILOG << IMSG(IIR_NULL_POINTER) << "parent" << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsresult rv;
	nsIDOMElement* new_node;
	rv = _xml_doc->CreateElement(node_name, &new_node);
	
	if (NS_FAILED(rv) || new_node == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "rv=" << rv << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMNode* old = nsnull;
	if (index == -1)
	{
		rv = parent->AppendChild(new_node, &old);
		if (NS_SUCCEEDED(rv))
		{
			ILOG << IMSG(IIR_APPENDED_DOM) << IDBG;
			IL_UNTAB;
			NS_IF_RELEASE(old);
			return new_node;
		}
	}
	else
	{
		nsIDOMNodeList* child_list;
		parent->GetChildNodes(&child_list);
		if (child_list == nsnull)
		{
			rv = parent->AppendChild(new_node, &old);
			if (NS_SUCCEEDED(rv))
			{
				ILOG << IMSG(IIR_APPENDED_DOM) << IDBG;
				IL_UNTAB;
				NS_IF_RELEASE(old);
				return new_node;
			}
		}
		else
		{
			
			nsIDOMNode* ref_node;
			child_list->Item(index, &ref_node);
			rv = parent->InsertBefore(new_node, ref_node, &old);
			if (NS_SUCCEEDED(rv))
			{
				ILOG << IMSG(IIR_INSERTED_DOM) << IDBG;
				IL_UNTAB;
				NS_IF_RELEASE(old);
				NS_IF_RELEASE(ref_node);
				NS_RELEASE(child_list);
				return new_node;
			}
			else
			{
				NS_IF_RELEASE(child_list);
				NS_IF_RELEASE(ref_node);
			}
		}
	}

	ILOG << IMSG(IIR_CREATE_DOM_FAILED) << IERR;
	IL_UNTAB;
	NS_IF_RELEASE(old);
	return nsnull;
}

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* node, nsAutoString node_value)
{
	ILOG << "rvXmlDocument::CreateTextNode() " << "node_value=" << node_value << IDBG;
	IL_TAB;

	if (node == nsnull)
	{
		ILOG << IMSG(IIR_NULL_POINTER) << "node" << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMText* new_text_node;
	nsresult rv = _xml_doc->CreateTextNode(node_value, &new_text_node);
	if (NS_FAILED(rv))
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "rv=" << rv << IERR;
		IL_UNTAB;
		NS_IF_RELEASE(new_text_node);
		return nsnull;
	}

	nsIDOMElement* old;
	rv = node->AppendChild((nsIDOMNode*) new_text_node, (nsIDOMNode**) &old);
	if (NS_FAILED(rv))
	{
		NS_IF_RELEASE(old);
		NS_RELEASE(new_text_node);
		ILOG << IMSG(IIR_APPEND_DOM_FAILED) << IERR;
		IL_UNTAB;
		return nsnull;
	}

	ILOG << IMSG(IIR_CREATED_DOM_NODE) << IDBG;
	NS_IF_RELEASE(old);
	IL_UNTAB;
	return new_text_node;
}

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* node, PRInt32 node_value)
{
	nsAutoString val;
	val.AppendInt(node_value);
	return CreateTextNode(node, val);
}

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* node, PRUint32 node_value)
{
	ILOG << "rvXmlDocument::CreateTextNode() " << "node_value=" << node_value << IDBG;
	IL_TAB;

	nsAutoString val;
	val.AppendInt(node_value);
	nsIDOMText* text = CreateTextNode(node, val);
	if (text == nsnull)
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << " Text Node with Int Value " << node_value << IERR;
	else
		ILOG << IMSG(IIR_CREATED_DOM_NODE) << " Text Node with Int Value " << node_value << IDBG;

	IL_UNTAB;
	return text;
}

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* node, PRFloat64 node_value)
{
	ILOG << "rvXmlDocument::CreateTextNode() " << "node_value=" << node_value << IDBG;
	IL_TAB;

	nsAutoString val;
	val.AppendFloat(node_value);
	nsIDOMText* text = CreateTextNode(node, val);

	if (text == nsnull)
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << " Text Node with Float Value " << node_value << IERR;
	else
		ILOG << IMSG(IIR_CREATED_DOM_NODE) << " Text Node with Float Value " << node_value << IDBG;

	IL_UNTAB;
	return text;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, nsAutoString node_value, PRUint32 index)
{
	ILOG << "rvXmlDocument::CreateNodeWithText() " << "node_name=" << node_name << "node_value=" << node_value << IDBG;
	IL_TAB;

	nsIDOMElement* textn = CreateNode(node,node_name);
	if (textn == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node " << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	if (lnode == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node " << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		NS_RELEASE(textn);
		return nsnull;
	}

	ILOG << IMSG(IIR_CREATED_DOM_NODE) << "Node with text node " << IDBG;
	NS_RELEASE(textn);
	IL_UNTAB;
	return lnode;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRInt32 node_value, PRUint32 index)
{
	ILOG << "rvXmlDocument::CreateNodeWithText() " << "node_name=" << node_name << "node_value=" << node_value << IDBG;
	IL_TAB;

	nsIDOMElement* textn = CreateNode(node,node_name);
	if (textn == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node, int value" << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	if (lnode == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node, int value " << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		NS_RELEASE(textn);
		return nsnull;
	}

	ILOG << IMSG(IIR_CREATED_DOM_NODE) << "Node with text node, int value " << IDBG;
	NS_RELEASE(textn);
	IL_UNTAB;
	return lnode;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRUint32 node_value, PRUint32 index)
{
	ILOG << "rvXmlDocument::CreateNodeWithText() " << "node_name=" << node_name << "node_value=" << node_value << IDBG;
	IL_TAB;

	nsIDOMElement* textn = CreateNode(node,node_name);
	if (textn == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node, unsigned int value" << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	if (lnode == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node, unsigned int value " << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		NS_RELEASE(textn);
		return nsnull;
	}

	ILOG << IMSG(IIR_CREATED_DOM_NODE) << "Node with text node, int value " << IDBG;
	NS_RELEASE(textn);
	IL_UNTAB;
	return lnode;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRFloat64 node_value, PRUint32 index)
{
	ILOG << "rvXmlDocument::CreateNodeWithText() " << "node_name=" << node_name << "node_value=" << node_value << IDBG;
	IL_TAB;

	nsIDOMElement* textn = CreateNode(node,node_name);
	if (textn == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node, float value" << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		return nsnull;
	}

	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	if (lnode == nsnull)
	{
		ILOG << IMSG(IIR_CREATE_DOM_FAILED) << "Node with text node, float value " << "node_name=" << node_name << "node_value=" << node_value << IERR;
		IL_UNTAB;
		NS_RELEASE(textn);
		return nsnull;
	}

	ILOG << IMSG(IIR_CREATED_DOM_NODE) << "Node with text node, float value " << IDBG;
	NS_RELEASE(textn);
	IL_UNTAB;
	return lnode;
}

void rvXmlDocument::GetElementsWithID(nsAutoString id, nsIDOMElement* elem, nsVoidArray &p_list)
{
	ILOG << "rvXmlDocument::GetElementsWithID() " << "id=" << id << IDBG;
	IL_TAB;

	if (id.Equals(NS_LITERAL_STRING("")))
	{
		ILOG << IMSG(IIR_INVALID_VALUE_PASSED) << " empty id" << IERR;
		IL_UNTAB;
		return;
	}

	if (elem == nsnull)
	{
		ILOG << IMSG(IIR_NULL_POINTER) << " null element passed " << IERR;
		IL_UNTAB;
		return;
	}

	nsresult rv;
  nsCOMPtr<nsIDOMDocumentTraversal> trav = do_QueryInterface(elem, &rv);
	if (!NS_SUCCEEDED(rv))
	{
		ILOG << IMSG(IIR_FAILED_TO_GET_INTERFACE) << " nsIDOMDocumentTraversal " << IERR;
		IL_UNTAB;
		return;
	}

	nsCOMPtr<nsIDOMNode> docAsNode = do_QueryInterface((nsIDOMNode*) elem);
	nsCOMPtr<nsIDOMTreeWalker> walker;
  rv = trav->CreateTreeWalker(docAsNode, 
															nsIDOMNodeFilter::SHOW_ALL,
															nsnull, PR_TRUE, getter_AddRefs(walker));
	if (!NS_SUCCEEDED(rv))
	{
		ILOG << IMSG(IIR_FAILED_TO_CREATE) << " nsIDOMTreeWalker " << IERR;
		IL_UNTAB;
		return;
	}

  nsIDOMNode* currentNode;
  walker->GetCurrentNode(&currentNode);
  while (currentNode)
  {
		nsAutoString elem_id = GetNodeAttributeValue((nsIDOMElement*) currentNode, MozStr("id"));
		if (elem_id.Equals(NS_LITERAL_STRING("")))
			elem_id = GetNodeAttributeValue(elem, MozStr("name"));

		if (elem_id == id)
		{
			nsIDOMNode* node = currentNode;
			NS_ADDREF(node);
			p_list.AppendElement((void*) node);
			ILOG << IMSG(IIR_SUCCESS) << " Found element with id=" << id << IINF;
		}

		NS_RELEASE(currentNode);
		walker->NextNode(&currentNode);
	}

	IL_UNTAB;
}

nsAutoString rvXmlDocument::GetNodeID(nsIDOMElement* p_node)
{
	ILOG << "rvXmlDocument::GetNodeID()" << IDBG;
	IL_TAB;

	nsAutoString id = MozStr("");
	if (p_node == nsnull)
	{
		ILOG << IMSG(IIR_NULL_POINTER) << " null element passed " << IERR;
		IL_UNTAB;
		return id;
	}

	id = GetNodeAttributeValue(p_node, MozStr("id"));
	if (id == MozStr(""))
		id = GetNodeAttributeValue(p_node, MozStr("name"));

	IL_UNTAB;
	return id;
}

PRBool rvXmlDocument::CheckIfIdIDExists(nsIDOMElement* p_node)
{
	ILOG << "rvXmlDocument::CheckIfIdIDExists()" << IDBG;
	IL_TAB;

	nsAutoString id = GetNodeID(p_node);
	if (id == MozStr(""))
	{
		ILOG << "Element does not have an id" << IDBG;
		IL_UNTAB;
		return false;
	}

	ILOG << "Found Element with id=" << id << IDBG;
	IL_UNTAB;
	return true;
}


nsIDOMElement* rvXmlDocument::GetChildNode(nsIDOMElement* parent, nsAutoString child_name)
{
	//ILOG << "rvXmlDocument::GetChildNode() " << "child_name=" << child_name << IDBG;
	//IL_TAB;

	if (parent == nsnull || child_name == MozStr(""))
		return nsnull;

	nsIDOMNodeList* node_list;
	parent->GetChildNodes(&node_list);
	if (node_list == nsnull)
		return nsnull;

	PRUint32 len = 0; node_list->GetLength(&len);
	for (PRUint32 idx = 0; idx < len; idx++)
	{
		nsIDOMNode* child;
		node_list->Item(idx, &child);

		nsAutoString name;
		child->GetNodeName(name);
		if (name == child_name)
		{
			NS_RELEASE(node_list);
			return (nsIDOMElement*) child;
		}

		NS_RELEASE(child);
	}

	NS_RELEASE(node_list);
	return nsnull;	
}

PRInt32 rvXmlDocument::GetChildCount(nsIDOMElement* node)
{
	PRUint32 cnt = 0;
	if (node == nsnull)
		return cnt;

	nsIDOMNodeList* children;
	node->GetChildNodes(&children);
	if (children != nsnull)
	{
		children->GetLength(&cnt);
		NS_RELEASE(children);
		return cnt-NumberOfWhiteSpaces(node);
	}

	return 0;
}

nsAutoString rvXmlDocument::GetNodeName(nsIDOMElement* node)
{
	if (node == nsnull)
		return MozStr("");

	nsAutoString name;
	node->GetNodeName(name);
	return name;
}

nsAutoString rvXmlDocument::GetNodeValue(nsAutoString xpath_name)
{
	if (xpath_name == MozStr(""))
		return MozStr("");

	nsIDOMElement* node = GetNode(xpath_name);
	if (node == nsnull)
		return MozStr("");

	nsAutoString value = GetNodeValue(node);
	NS_RELEASE(node);

	return value;
}

nsAutoString rvXmlDocument::GetNodeValue(nsIDOMElement* node)
{
	if (node == nsnull)
		return MozStr("InvalidString"); // should return a proper error code

	nsIDOMNode* child;
	node->GetFirstChild(&child);

	// for #text nodes
	if (child != nsnull)
	{
			nsAutoString value,name;
			child->GetNodeName(name);
			if (name.EqualsIgnoreCase("#text"))
			{
				child->GetNodeValue(value);
				NS_RELEASE(child);
				return value;
			}

			NS_RELEASE(child); 
			// pass it down as a generic node
	}
	
	// for other nodes wnot like <Node>Text</Node>, return the value
	nsAutoString value;
	node->GetNodeValue(value); 
	return value;
}

nsAutoString rvXmlDocument::GetNodeTextValue(nsIDOMElement* parent, nsAutoString node_name)
{
	if (parent == nsnull || node_name == MozStr(""))
		return MozStr(""); // TODO should return a proper error code

	nsIDOMElement* node = GetChildNode(parent, node_name);
	if (node == nsnull)
		return MozStr("");

	nsAutoString value = GetNodeValue(node);
	NS_RELEASE(node);
	return value;
}

PRBool rvXmlDocument::CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, nsAutoString node_value, PRBool IgnoreCase)
{
	if (parent == nsnull || node_name == MozStr(""))
		return PR_FALSE;

	nsAutoString val = GetNodeTextValue(parent, node_name);
	if (IgnoreCase)
		return val == node_value;
	else
		return val.Equals(node_value);
}

PRBool rvXmlDocument::CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRInt32 node_value)
{
	if (parent == nsnull || node_name == MozStr(""))
		return PR_FALSE;

	nsAutoString val = GetNodeTextValue(parent, node_name);
	PRInt32 error = 0;
	PRInt32 ival = val.ToInteger(&error);
	if (error)
		return PR_FALSE;

	return ival == node_value;
}

PRBool rvXmlDocument::CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRUint32 node_value)
{
	if (parent == nsnull || node_name == MozStr(""))
		return PR_FALSE;

	nsAutoString val = GetNodeTextValue(parent, node_name);
	PRInt32 error = 0;
	PRUint32 ival = val.ToInteger(&error);
	if (error)
		return PR_FALSE;

	return ival == node_value;
}

PRBool rvXmlDocument::CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRFloat64 node_value)
{
	if (parent == nsnull || node_name == MozStr(""))
		return PR_FALSE;

	nsAutoString val = GetNodeTextValue(parent, node_name);
	PRInt32 error = 0;
	PRFloat64 ival = val.ToFloat(&error);
	if (error)
		return PR_FALSE;

	return ival == node_value;
}

void rvXmlDocument::SetNodeValue(nsIDOMElement* p_dom_node, nsAutoString node_value)
{
	if (p_dom_node == nsnull)
		return;

	p_dom_node->SetNodeValue(node_value);
}

nsIDOMAttr* rvXmlDocument::GetNodeAttribute(nsIDOMElement* node, nsAutoString attr_name)
{
	if (node == nsnull || attr_name == MozStr(""))
		return nsnull;

	nsIDOMAttr *attr;
	node->GetAttributeNode(attr_name, &attr); 
	return attr;
}

nsAutoString rvXmlDocument::GetNodeAttributeValue(nsAutoString xpath, nsAutoString attr_name)
{
	if (xpath == MozStr("") || attr_name == MozStr(""))
		return MozStr("");

	nsIDOMElement* node = GetNode(xpath);
	if (node == nsnull)
		return MozStr("");

	nsAutoString value = GetNodeAttributeValue(node, attr_name);
	NS_RELEASE(node);
	return value;
}

nsAutoString rvXmlDocument::GetNodeAttributeValue(nsIDOMElement* node, nsAutoString attr_name)
{
	if (node == nsnull || attr_name == MozStr(""))
		return MozStr("");

	nsAutoString vala(MozStr(""));
	nsIDOMElement* lnode = nsnull;
	node->QueryInterface(kIDOMElement, (void**) &lnode);
	
	if (lnode != nsnull)
	{
		lnode->GetAttribute(attr_name, vala);
		NS_RELEASE(lnode);
	}
	
	return vala;
}

void rvXmlDocument::SetNodeAttributeValue(nsIDOMElement* elem, nsAutoString attr_name, nsAutoString attr_value)
{
	if (elem == nsnull || attr_name == MozStr(""))
		return;

	nsIDOMAttr *attr_node;
	elem->GetAttributeNode(attr_name, &attr_node); 
	if (attr_node != nsnull)
	{
		attr_node->SetValue(attr_value);
		NS_RELEASE(attr_node);
	}
}

void rvXmlDocument::SetOrCreateNodeAttributeValue(nsIDOMElement* elem, nsAutoString attr_name, nsAutoString attr_value)
{
	if (elem == nsnull || attr_name == MozStr(""))
		return;

	nsIDOMAttr *attr_node;
	elem->GetAttributeNode(attr_name, &attr_node); 
	if (attr_node != nsnull)
	{
		attr_node->SetValue(attr_value);
		NS_RELEASE(attr_node);
		return;
	}

	AddAttribute(elem, attr_name, attr_value);
	return;
}

void rvXmlDocument::GetNodesWithAttributeValue(nsIDOMElement* p_start_node, nsAutoString p_attr_name, nsAutoString p_attr_val, nsVoidArray &p_list)
{
	if (p_start_node == nsnull || p_attr_name == MozStr(""))
		return;

	nsIDOMDocument* doc;p_start_node->GetOwnerDocument(&doc);
	if (doc == nsnull)
		return;
	
	nsresult rv;
  nsCOMPtr<nsIDOMDocumentTraversal> trav = do_QueryInterface(doc, &rv);
  nsCOMPtr<nsIDOMTreeWalker> walker;

	nsCOMPtr<nsIDOMNode> docAsNode = do_QueryInterface(p_start_node);
  rv = trav->CreateTreeWalker(docAsNode, 
															nsIDOMNodeFilter::SHOW_ALL,
															nsnull, PR_TRUE, getter_AddRefs(walker));

  nsIDOMNode* currentNode;
  walker->GetCurrentNode(&currentNode);
  while (currentNode)
  {
		nsAutoString name;
		currentNode->GetNodeName(name);
		if (currentNode == nsnull)
			break;

		nsAutoString attr_val = GetNodeAttributeValue((nsIDOMElement*) currentNode, p_attr_name);
		if (attr_val == p_attr_val)
		{
			nsIDOMNode* clone;
			currentNode->CloneNode(PR_TRUE, &clone);
			p_list.AppendElement((void*) clone);
		}

		NS_RELEASE(currentNode);
		walker->NextNode(&currentNode);
	}
}

nsIDOMElement* rvXmlDocument::GetChildNodeWithAttributeValue(nsIDOMElement* p_parent_node, nsAutoString p_attr_name, nsAutoString p_attr_val)
{
	if (p_attr_name == MozStr(""))
		return nsnull;

	PRBool release_p = PR_FALSE;
	if (p_parent_node == nsnull)
	{
	// assume its child of the document element
		p_parent_node = GetDocumentElement();
		release_p = PR_TRUE;
	}

	// still if it is nuull, return null
	if (p_parent_node == nsnull)
		return nsnull;

	nsIDOMNode* child;
	p_parent_node->GetFirstChild(&child);
	while (child != nsnull)
	{
		nsAutoString attr_val = GetNodeAttributeValue((nsIDOMElement*) child, p_attr_name);
		if (attr_val == p_attr_val)
		{
			if (release_p) NS_RELEASE(p_parent_node);
			return (nsIDOMElement*) child;
		}

		nsIDOMNode* next;
		child->GetNextSibling((nsIDOMNode**) &next); 
		NS_RELEASE(child);
		child = next;
	}

	if (release_p) NS_RELEASE(p_parent_node);
	return nsnull;
}

void rvXmlDocument::AddAttribute(nsIDOMElement* node, nsAutoString AttrName, nsAutoString AttrValue)
{
	if (node == nsnull || AttrName == MozStr(""))
		return;

	// create the attribute
	nsIDOMAttr *retval;
	_xml_doc->CreateAttribute(AttrName, &retval);
	retval->SetValue(AttrValue);

	// add it to the attribute named map
	nsIDOMNode* retval_from_map;
	nsIDOMNamedNodeMap* map;
	node->GetAttributes(&map); 

	map->SetNamedItem(retval, &retval_from_map);

	NS_IF_RELEASE(retval_from_map);
	NS_RELEASE(retval);
	NS_RELEASE(map);
}

void rvXmlDocument::AddAttribute(nsIDOMElement* node, nsAutoString AttrName, PRInt32 AttrValue)
{
	if (node == nsnull || AttrName == MozStr(""))
		return;

	nsAutoString value;
	value.AppendInt(AttrValue);

	AddAttribute(node, AttrName, value);
}

void rvXmlDocument::AddAttribute(nsAutoString XPath, nsAutoString AttrName, nsAutoString AttrValue)
{
	if (XPath == MozStr("") || AttrName == MozStr(""))
		return;

	nsIDOMElement* node = GetNode(XPath);
	AddAttribute(node, AttrName, AttrValue);
}

void rvXmlDocument::GetNodeDepth(nsIDOMElement* p_dom_node, PRInt32 &depth)
{
	if (p_dom_node == nsnull)
	{
		depth = -1;
		return;
	}

	nsIDOMNode* parent;
	p_dom_node->GetParentNode(&parent);

	if (parent == nsnull)
	{
		depth = 0;
		return;
	}

	depth++;
	GetNodeDepth((nsIDOMElement*) parent, depth);
	NS_RELEASE(parent);
	return;
}

PRInt32 rvXmlDocument::GetNodePosition(nsIDOMElement* p_dom_node)
{
	if (p_dom_node == nsnull)
		return -1;

	PRInt32 ws_cnt = 0;
	nsIDOMNode* parent;
	p_dom_node->GetParentNode(&parent);

	if (parent == nsnull)
		return 1;

	nsIDOMNodeList* node_list;
	parent->GetChildNodes(&node_list);
	PRUint32 cnt = 0;
	node_list->GetLength(&cnt);

	for (PRUint32 idx = 0; idx < cnt; idx++)
	{
		nsIDOMNode* child_node;
		node_list->Item(idx, &child_node);

		if (IsWhiteSpace((nsIDOMElement*) child_node))
		{
			ws_cnt++;
		}
		else if (child_node == p_dom_node)
		{
			NS_RELEASE(child_node);
			NS_IF_RELEASE(node_list);
			NS_RELEASE(parent);
			return idx+1-ws_cnt;
		}

		NS_RELEASE(child_node);
	}

	NS_IF_RELEASE(node_list);
	NS_RELEASE(parent);
	return -1; // This is not possible
}

PRInt32 rvXmlDocument::GetSiblingsBeforeCount(nsIDOMElement* p_dom_node)
{
	if (p_dom_node == nsnull)
		return -1;

	PRInt32 pos = GetNodePosition(p_dom_node);
	return pos-1;
}

PRInt32 rvXmlDocument::GetSiblingsAfterCount(nsIDOMElement* p_dom_node)
{
	if (p_dom_node == nsnull)
		return -1;

	nsIDOMNode* parent;p_dom_node->GetParentNode(&parent);
	if (parent == nsnull)
		return 0;

	PRUint32 tot_count = GetChildCount((nsIDOMElement*) parent);
	PRInt32 pos = GetNodePosition(p_dom_node);

	NS_RELEASE(parent);
	return tot_count - pos;
}

void rvXmlDocument::CopyAttirbutes(nsIDOMElement* p_from_node, nsIDOMElement* p_to_node)
{
	if (p_from_node == nsnull || p_to_node == nsnull)
		return;

	// add the attributes
	nsIDOMNamedNodeMap* attrs;
	p_from_node->GetAttributes(&attrs);
	if (attrs == nsnull)
		return;
	
	// get a pointer to the attributes named map
	nsIDOMNamedNodeMap* map;
	p_to_node->GetAttributes(&map); 

	PRUint32 len = 0;
	attrs->GetLength(&len);
	for (PRUint32 idx = 0; idx < len; idx++)
	{
		nsIDOMElement* attr = nsnull;
		attrs->Item(idx, (nsIDOMNode**) &attr);
		
		nsAutoString attr_name, attr_value;
		attr->GetNodeName(attr_name);
		attr->GetNodeValue(attr_value);

		NS_RELEASE(attr);

		// create the attribute
		nsIDOMAttr *new_attr;
		_xml_doc->CreateAttribute(attr_name, &new_attr);
		new_attr->SetValue(attr_value);

		nsIDOMNode* retval_from_map;
		map->SetNamedItem(new_attr, &retval_from_map);	
		NS_IF_RELEASE(retval_from_map);
		NS_RELEASE(new_attr);
	}

	NS_RELEASE(map);
	NS_RELEASE(attrs);
}

nsAutoString rvXmlDocument::SerializeNode(nsIDOMElement* elem)
{
	if (elem == nsnull)
		return MozStr("");

	// return xml
	nsAutoString xml;

	// if it is a leaf node
	nsAutoString name;
	elem->GetNodeName(name);

	if (name.EqualsIgnoreCase("#text"))
	{
		nsAutoString val;
		elem->GetNodeValue(val);
		xml.Append(val);
		return xml;
	}

	// create the tag <Node>
	xml.Append(NS_LITERAL_STRING("<"));
	xml.Append(name);

	// add attributes to <Node>
	PRBool yes = PR_FALSE;
	elem->HasAttributes(&yes);

	if (yes)
	{
		nsIDOMNamedNodeMap* map;
		elem->GetAttributes(&map); 

		PRUint32 cnt;
		map->GetLength(&cnt);
		for (int idx=0; idx<cnt;idx++)
		{
			nsIDOMElement* attr;
			map->Item(idx, (nsIDOMNode**) &attr);

			nsAutoString namea;
			nsAutoString vala;
			attr->GetNodeName(namea);
			attr->GetNodeValue(vala);

			xml.Append(NS_LITERAL_STRING(" "));
			xml.Append(namea);
			xml.Append(NS_LITERAL_STRING("='"));
			xml.Append(vala);
			xml.Append(NS_LITERAL_STRING("'"));

			NS_RELEASE(attr);
		}

		NS_RELEASE(map);
	}

	xml.Append(NS_LITERAL_STRING(">"));

	// recursively add child nodes
	elem->HasChildNodes(&yes);
	if (yes)
	{
		nsIDOMNodeList* node_list;
		elem->GetChildNodes(&node_list);
		PRUint32 cnt;
		node_list->GetLength(&cnt);
		for (PRInt32 idx=0; idx< cnt;idx++) 
		{
			nsIDOMElement* child;
			node_list->Item(idx, (nsIDOMNode**) &child);
			nsAutoString lname;
			child->GetNodeName(lname);

			nsAutoString child_xml = SerializeNode(child);
			xml.Append(child_xml);
			NS_RELEASE(child);
		}

		NS_RELEASE(node_list);
	}

	// close the node
	xml.Append(NS_LITERAL_STRING("</"));
	xml.Append(name);
	xml.Append(NS_LITERAL_STRING(">"));

	return xml;
}

void rvXmlDocument::DumpNodeDeep(nsIDOMElement* elem)
{
	if (elem == nsnull)
		return;

	nsAutoString xml;

	// tag
	nsAutoString name;
	elem->GetNodeName(name);

	nsAutoString val;
	elem->GetNodeValue(val);

	if (name.EqualsIgnoreCase("#text"))
	{
		IL_TAB;
		ILOG << val << IINF;
		IL_UNTAB;
		return;
	}

	xml.Append(NS_LITERAL_STRING("<"));
	xml.Append(name);

	// add attributes
	PRBool yes = PR_FALSE;
	elem->HasAttributes(&yes);

	if (yes)
	{
		nsIDOMNamedNodeMap* map;
		elem->GetAttributes(&map); 

		PRUint32 cnt;
		map->GetLength(&cnt);
		for (int idx=0; idx<cnt;idx++)
		{
			nsIDOMElement* attr;
			map->Item(idx, (nsIDOMNode**) &attr);

			nsAutoString namea;
			nsAutoString vala;
			attr->GetNodeName(namea);
			attr->GetNodeValue(vala);

			xml.Append(NS_LITERAL_STRING(" "));
			xml.Append(namea);
			xml.Append(NS_LITERAL_STRING("=\""));
			xml.Append(vala);
			xml.Append(NS_LITERAL_STRING("\""));

			NS_RELEASE(attr);
		}

		NS_RELEASE(map);
	}

	xml.Append(NS_LITERAL_STRING(">"));

	// add value if it exists
	//if (val != MozStr(""))
		//xml.Append(val);
	
	// show the current node
	IL_TAB;
	ILOG << xml << IINF;

	// show children
	elem->HasChildNodes(&yes);
	if (yes)
	{
		nsIDOMNodeList* node_list;
		elem->GetChildNodes(&node_list);
		PRUint32 cnt;
		node_list->GetLength(&cnt);
		for (PRInt32 idx=0; idx< cnt;idx++) 
		{
			nsIDOMElement* child;
			node_list->Item(idx, (nsIDOMNode**) &child);
			nsAutoString lname;
			child->GetNodeName(lname);

			DumpNodeDeep(child);
			NS_RELEASE(child);
		}

		NS_RELEASE(node_list);
	}

	IL_UNTAB;
}

void rvXmlDocument::DumpNode(nsIDOMElement* elem)
{
	if (elem == nsnull)
		return;

	nsAutoString xml;

	// tag
	nsAutoString name;
	elem->GetNodeName(name);

	nsAutoString val;
	elem->GetNodeValue(val);

	if (name.EqualsIgnoreCase("#text"))
	{
		IL_TAB;
		ILOG << val << IINF;
		IL_UNTAB;
		return;
	}

	xml.Append(NS_LITERAL_STRING("<"));
	xml.Append(name);

	// add attributes
	PRBool yes = PR_FALSE;
	elem->HasAttributes(&yes);

	if (yes)
	{
		nsIDOMNamedNodeMap* map;
		elem->GetAttributes(&map); 

		PRUint32 cnt;
		map->GetLength(&cnt);
		for (int idx=0; idx<cnt;idx++)
		{
			nsIDOMElement* attr;
			map->Item(idx, (nsIDOMNode**) &attr);

			nsAutoString namea;
			nsAutoString vala;
			attr->GetNodeName(namea);
			attr->GetNodeValue(vala);

			xml.Append(NS_LITERAL_STRING(" "));
			xml.Append(namea);
			xml.Append(NS_LITERAL_STRING("=\""));
			xml.Append(vala);
			xml.Append(NS_LITERAL_STRING("\""));

			NS_RELEASE(attr);
		}

		NS_RELEASE(map);
	}

	xml.Append(NS_LITERAL_STRING(">"));

	// show the current node
	IL_TAB;
	ILOG << xml << IINF;

	// show children
	IL_UNTAB;
}

PRBool rvXmlDocument::IsWhiteSpace(nsIDOMElement* p_node)
{
	if (p_node == nsnull)
		return PR_TRUE;
	
	nsAutoString node_name;
	p_node->GetNodeName(node_name);
	if (node_name != MozStr("#text"))
		return PR_FALSE;

	nsAutoString node_val;
	p_node->GetNodeValue(node_val );
	node_val.StripChar(' ');
	node_val.StripChar('\r');
	node_val.StripChar('\n');
	PRBool isWhiteSpace = PR_FALSE;
	if (node_val == MozStr("") || node_val == MozStr("\n") || node_val == MozStr("\r") || node_val == MozStr("\r\n"))
		return PR_TRUE;
	else
	{
		return PR_FALSE;
	}
}

PRInt32 rvXmlDocument::NumberOfWhiteSpaces(nsIDOMElement* p_node)
{
	if (p_node == nsnull)
		return 0;

	PRInt32 cnt = 0;
	nsIDOMNodeList* children;
	p_node->GetChildNodes(&children);
	PRUint32 len; children->GetLength(&len);
	
	for (PRUint32 idx = 0; idx < len; idx++)
	{
		nsIDOMElement* child;
		children->Item(idx, (nsIDOMNode**) &child);
		if (IsWhiteSpace(child))
			cnt++;

		NS_RELEASE(child);
	}

	NS_IF_RELEASE(children);
	
	return cnt;
}


nsIDOMText* rvXmlDocument::CreateTextNode(nsAutoString xpath_parent_name, nsAutoString node_name, nsAutoString node_value, PRUint32 index)
{
	if (node_name == MozStr(""))
		return nsnull;

	nsIDOMElement* node = CreateNode(xpath_parent_name, node_name, index);
	if (node == nsnull)
		return nsnull;

	nsIDOMText *new_text_node = CreateTextNode(node, node_value);
	NS_IF_RELEASE(node);
	return new_text_node;
}

nsIDOMElement* rvXmlDocument::CreateNode(nsAutoString xpath_parent_name, nsAutoString node_name, PRUint32 index)
{
	if (xpath_parent_name == MozStr("") || node_name == MozStr(""))
		return nsnull;

	nsIDOMElement* parent = GetNode(xpath_parent_name);
	if (parent == nsnull)
		return nsnull;

	nsIDOMElement* node = CreateNode(parent, node_name, index);
	NS_RELEASE(parent);
	return node;
}

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* parent, nsAutoString node_name, nsAutoString node_value, PRUint32 index)
{
	if (parent == nsnull || node_name == MozStr(""))
		return nsnull;

	nsIDOMElement* node = CreateNode(parent, node_name, index);
	nsIDOMText* new_text_node;
	_xml_doc->CreateTextNode(node_value, &new_text_node);

	nsIDOMElement* old;
	node->AppendChild((nsIDOMElement*) new_text_node, (nsIDOMNode**) &old);
	
	NS_IF_RELEASE(old);
	NS_IF_RELEASE(node);
	return new_text_node;
}
nsIDOMElement* rvXmlDocument::GetNode(nsAutoString XPath)
{
	if (XPath == MozStr(""))
		return nsnull;

	nsAutoString temp_xpath = XPath;
	nsAutoString temp_name = XPath;

	nsIDOMElement* node = (nsIDOMElement*) _xml_doc; //GetDocumentElement();
	if (node == nsnull)
		return nsnull;

	// check the XPath. Split at Slash and iterate to get the last node in the xpath
	PRInt32 slash_pos = 0;
	slash_pos = temp_xpath.Find("/", PR_TRUE, slash_pos);
	if (slash_pos == kNotFound) // Then the root was queried for
		return node;

	nsIDOMElement* child;
	while (slash_pos != kNotFound)
	{
		// split the string
		temp_xpath.Left(temp_name,slash_pos);
		temp_xpath.Right(temp_xpath, temp_xpath.Length() - slash_pos-1);
	
		slash_pos = temp_xpath.Find("/", PR_TRUE, 0);
		child = GetChildNode(node, temp_name);
		if (child == nsnull)
		{
			NS_RELEASE(node);
			node = nsnull;
			break;
		}

		NS_RELEASE(node);
		node=child;
	}

	if (node != nsnull)
	{
		child = GetChildNode(node, temp_xpath);
		NS_RELEASE(node);
	}
	
	return child;		
}
