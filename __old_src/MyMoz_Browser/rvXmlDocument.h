#ifndef _MYMOZ_XML_DOCUMENT_
#define _MYMOZ_XML_DOCUMENT_

#include "rvXPCOMIDs.h"

class rvXmlDocument
{
private:
	nsAutoString _xml_file;
	nsIDOMXMLDocument* _xml_doc;
		
public:
	PRBool _doc_loaded;
	rvXmlDocument();
	~rvXmlDocument();

public:
	bool LoadFromFile(nsAutoString XmlFile);
	nsIDOMElement* CreateEmptyDocument(nsAutoString root);
	bool Save(nsCAutoString p_path, nsCAutoString p_file);
	void Destroy();

	nsIDOMElement* GetDocumentElement();
	nsAutoString GetNodeID(nsIDOMElement* node);
	PRBool CheckIfIdIDExists(nsIDOMElement* node);
	void GetElementsWithID(nsAutoString id, nsIDOMElement* elem, nsVoidArray &p_list);

	nsIDOMElement* GetNode(nsAutoString XPath);
	nsIDOMElement* GetChildNode(nsIDOMElement* parent, nsAutoString child_name);
	PRInt32 GetChildCount(nsIDOMElement* node);
	nsAutoString GetNodeName(nsIDOMElement* node);
	nsAutoString GetNodeValue(nsIDOMElement* node);
	nsAutoString GetNodeValue(nsAutoString xpath_name);
	nsAutoString GetNodeTextValue(nsIDOMElement* parent, nsAutoString node_name);
	PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, nsAutoString node_value, PRBool IgnoreCase = PR_FALSE);
	PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRInt32 node_value);
	PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRUint32 node_value);
	PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRFloat64 node_value);

	nsIDOMAttr* GetNodeAttribute(nsIDOMElement* node, nsAutoString attr_name);
	nsAutoString GetNodeAttributeValue(nsAutoString xpath, nsAutoString attr_name);
	nsAutoString GetNodeAttributeValue(nsIDOMElement* node, nsAutoString attr_name);
	void GetNodesWithAttributeValue(nsIDOMElement* p_start_node, nsAutoString attr_name, nsAutoString att_val, nsVoidArray &list);
	nsIDOMElement* GetChildNodeWithAttributeValue(nsIDOMElement* p_parent_node, nsAutoString p_attr_name, nsAutoString p_attr_val);

	void GetNodeDepth(nsIDOMElement* p_dom_node, PRInt32 &depth);
	PRInt32 GetNodePosition(nsIDOMElement* p_dom_node);
	PRInt32 GetSiblingsBeforeCount(nsIDOMElement* p_dom_node);
	PRInt32 GetSiblingsAfterCount(nsIDOMElement* p_dom_node);

	void SetNodeAttributeValue(nsIDOMElement* elem, nsAutoString attr_name, nsAutoString attr_value);
	void SetNodeValue(nsIDOMElement* p_dom_node, nsAutoString node_value);
	void AddAttribute(nsIDOMElement* node, nsAutoString AttrName, nsAutoString AttrValue);
	void AddAttribute(nsAutoString XPath, nsAutoString AttrName, nsAutoString AttrValue);
	void AddAttribute(nsIDOMElement* node, nsAutoString AttrName, PRInt32 AttrValue);
	void CopyAttirbutes(nsIDOMElement* p_from_node, nsIDOMElement* p_to_node);

	nsIDOMElement* CreateNode(nsIDOMElement* parent, nsAutoString node_name, PRUint32 index = -1);
	nsIDOMElement* CreateNode(nsAutoString xpath_parent_name, nsAutoString node_name, PRUint32 index = -1);
	nsIDOMText* CreateTextNode(nsIDOMElement* parent, nsAutoString node_name, nsAutoString node_value, PRUint32 index = -1);
	nsIDOMText* CreateTextNode(nsAutoString xpath_parent_name, nsAutoString node_name, nsAutoString node_value, PRUint32 index = -1);
	nsIDOMText* CreateTextNode(nsIDOMElement* node, nsAutoString node_value);
	nsIDOMText* CreateTextNode(nsIDOMElement* node, PRInt32 node_value);
	nsIDOMText* CreateTextNode(nsIDOMElement* node, PRUint32 node_value);
	nsIDOMText* CreateTextNode(nsIDOMElement* node, PRFloat64 node_value);
	nsIDOMText* CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, nsAutoString node_value, PRUint32 index =-1);
	nsIDOMText* CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRFloat64 node_value, PRUint32 index =-1);
	nsIDOMText* CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRInt32 node_value, PRUint32 index =-1);
	nsIDOMText* CreateNodeWithText(nsIDOMElement* node, nsAutoString node_name, PRUint32 node_value, PRUint32 index =-1);

	PRBool IsWhiteSpace(nsIDOMElement* p_node);
	PRInt32 NumberOfWhiteSpaces(nsIDOMElement* p_node);

	void DumpNode(nsIDOMElement* elem);
};

#endif