#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvXmlDocument.h"

extern rvMyMozApp* theApp;

rvXmlDocument::rvXmlDocument()
{
	_xml_file = MozStr("");
	_doc_loaded = PR_FALSE;

	nsresult rv;
  rv = nsComponentManager::CreateInstance(kXMLDocumentCID, nsnull, kIDOMXMLDocumentIID, (void**) &_xml_doc);
	_xml_doc->SetAsync(PR_FALSE);
}

rvXmlDocument::~rvXmlDocument()
{
	Destroy();
}

bool rvXmlDocument::LoadFromFile(nsAutoString XmlFile) 
{
	_xml_file = XmlFile;	
	if (_xml_doc != nsnull)
		_xml_doc->Load(_xml_file, &_doc_loaded);

	if (_doc_loaded == 1)
	{
		//NS_ADDREF(_xml_doc);
		return PR_TRUE;
	}
	
	return false;
}

bool rvXmlDocument::Save(nsCAutoString p_path, nsCAutoString p_file) 
{
	nsCAutoString sfile;
	sfile.Append(p_path);
	sfile.Append(p_file);
//	_ILOG(sfile.get());

	nsCOMPtr<nsILocalFile> file;
  NS_NewNativeLocalFile(nsDependentCString(sfile), TRUE, getter_AddRefs(file));

  nsCOMPtr<nsILocalFile> dataPath;
  NS_NewNativeLocalFile(nsDependentCString(p_path), TRUE, getter_AddRefs(dataPath));

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

nsIDOMElement* rvXmlDocument::CreateEmptyDocument(nsAutoString name) 
{
	_doc_loaded = PR_FALSE;
	nsIDOMElement* doc_elem;
	nsresult result = _xml_doc->CreateElement(name, &doc_elem);
	if (result != NS_OK)
		return nsnull;

	nsIDOMNode* old;
	_xml_doc->AppendChild(doc_elem, &old);

	if (result == NS_OK)
	{
		NS_IF_RELEASE(old);
		_doc_loaded = PR_TRUE;
		return doc_elem;
	}

	NS_RELEASE(doc_elem);
	return nsnull;
}

nsIDOMElement* rvXmlDocument::GetDocumentElement()
{
	nsIDOMElement* doc_elem;
	_xml_doc->GetDocumentElement(&doc_elem);
//	if (doc_elem != nsnull) 
	//	NS_ADDREF(doc_elem);

	return doc_elem;
}

nsIDOMElement* rvXmlDocument::CreateNode(nsIDOMElement* parent, nsAutoString node_name, PRUint32 index)
{
	if (parent == nsnull || node_name == MozStr(""))
		return nsnull;

	nsIDOMElement* new_node;
	_xml_doc->CreateElement(node_name, &new_node);
	
	if (new_node == nsnull)
		return nsnull;

	nsIDOMNode* old = nsnull;
	if (index == -1)
	{
		parent->AppendChild(new_node, &old);
		NS_IF_RELEASE(old);
		return new_node;
	}
	else
	{
		nsIDOMNodeList* child_list;
		parent->GetChildNodes(&child_list);
		if (child_list == nsnull)
		{
			parent->AppendChild(new_node, &old);
			NS_IF_RELEASE(old);
			return new_node;
		}
		
		nsIDOMNode* ref_node;
		child_list->Item(index, &ref_node);
		parent->InsertBefore(new_node, ref_node, &old);
		NS_IF_RELEASE(old);
		NS_RELEASE(ref_node);
		NS_RELEASE(child_list);
		return new_node;
	}
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

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* node, nsAutoString node_value)
{
	if (node == nsnull)
		return nsnull;

	nsIDOMText* new_text_node;
	_xml_doc->CreateTextNode(node_value, &new_text_node);

	nsIDOMElement* old;
	node->AppendChild((nsIDOMNode*) new_text_node, (nsIDOMNode**) &old);
	NS_IF_RELEASE(old);
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
	nsAutoString val;
	val.AppendInt(node_value);
	return CreateTextNode(node, val);
}

nsIDOMText* rvXmlDocument::CreateTextNode(nsIDOMElement* node, PRFloat64 node_value)
{
	nsAutoString val;
	val.AppendFloat(node_value);
	return CreateTextNode(node, val);
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, nsAutoString node_value, PRUint32 index)
{
	nsIDOMElement* textn = CreateNode(node,node_name);
	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	NS_RELEASE(textn);
	return lnode;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRInt32 node_value, PRUint32 index)
{
	nsIDOMElement* textn = CreateNode(node,node_name);
	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	NS_RELEASE(textn);
	return lnode;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRUint32 node_value, PRUint32 index)
{
	nsIDOMElement* textn = CreateNode(node,node_name);
	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	NS_RELEASE(textn);
	return lnode;
}

nsIDOMText* rvXmlDocument::CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRFloat64 node_value, PRUint32 index)
{
	nsIDOMElement* textn = CreateNode(node,node_name);
	nsIDOMText* lnode = CreateTextNode(textn, node_value);
	NS_RELEASE(textn);
	return lnode;
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

void rvXmlDocument::GetElementsWithID(nsAutoString id, nsIDOMElement* elem, nsVoidArray &p_list)
{
	if (id.Equals(NS_LITERAL_STRING("")))
		return;

	if (elem == nsnull)
		return;

	nsresult rv;
  nsCOMPtr<nsIDOMDocumentTraversal> trav = do_QueryInterface(elem, &rv);
  nsCOMPtr<nsIDOMTreeWalker> walker;

	nsCOMPtr<nsIDOMNode> docAsNode = do_QueryInterface((nsIDOMNode*) elem);
  rv = trav->CreateTreeWalker(docAsNode, 
															nsIDOMNodeFilter::SHOW_ALL,
															nsnull, PR_TRUE, getter_AddRefs(walker));

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
		}

		NS_RELEASE(currentNode);
		walker->NextNode(&currentNode);
	}
}

nsAutoString rvXmlDocument::GetNodeID(nsIDOMElement* p_node)
{
	nsAutoString id = MozStr("");
	if (p_node == nsnull)
		return id;

	id = GetNodeAttributeValue(p_node, MozStr("id"));
	if (id == MozStr(""))
		id = GetNodeAttributeValue(p_node, MozStr("name"));

	return id;
}

PRBool rvXmlDocument::CheckIfIdIDExists(nsIDOMElement* p_node)
{
	nsAutoString id = GetNodeID(p_node);
	if (id == MozStr(""))
		return false;

	return true;
}

nsIDOMElement* rvXmlDocument::GetNode(nsAutoString XPath)
{
	if (_doc_loaded == PR_FALSE)
		return nsnull;

	if (XPath == MozStr(""))
		return nsnull;

	nsAutoString temp_xpath = XPath;
	nsAutoString temp_name = XPath;

	nsIDOMElement* node = GetDocumentElement();
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

nsIDOMElement* rvXmlDocument::GetChildNode(nsIDOMElement* parent, nsAutoString child_name)
{
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
			node->GetNodeName(name);
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

void rvXmlDocument::DumpNode(nsIDOMElement* elem)
{
	if (elem == nsnull)
		return;

	nsAutoString name;
	nsAutoString val;

	elem->GetNodeName(name);
	_ILOG("Dump Node Name: ");
	_ILOG(name);

	elem->GetNodeValue(val);
	_ILOG("Dump Node Value: ");
	_ILOG(val);

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
			_ILOG("Dump Attr Name: ");
			_ILOG(namea);
			_ILOG("Dump Attr Value: ");
			_ILOG(vala);

			NS_RELEASE(attr);
		}

		NS_RELEASE(map);
	}

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
			DumpNode(child);
			NS_RELEASE(child);
		}

		NS_RELEASE(node_list);
	}
}

PRBool rvXmlDocument::IsWhiteSpace(nsIDOMElement* p_node)
{
	if (p_node == nsnull)
		return PR_TRUE;
	
	nsAutoString node_name = GetNodeName(p_node);
	if (node_name != MozStr("#text"))
		return PR_FALSE;

	nsAutoString node_val = GetNodeValue(p_node);
	node_val.StripChar(' ');
	node_val.StripChar('\r');
	node_val.StripChar('\n');
	PRBool isWhiteSpace = PR_FALSE;
	//_ILOG(node_val);
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


