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
	PRBool LoadFromFile(nsAutoString XmlFile);
	PRBool LoadFromString(nsAutoString xml);
	nsIDOMElement* GetDocument() { return (nsIDOMElement*) _xml_doc;}
	PRBool CreateEmptyDocument(nsAutoString root);
	bool Save(nsAutoString p_path, nsAutoString p_file);
	void Destroy();
	nsAutoString SerializeNode(nsIDOMElement* elem);
	
	nsIDOMElement* GetDocumentElement();
	nsIDOMElement* GetNode(nsAutoString XPath);
	nsAutoString GetNodeValue(nsAutoString xpath_name);
	nsAutoString GetNodeAttributeValue(nsAutoString xpath, nsAutoString attr_name);

	static PRBool CheckIfIdIDExists(nsIDOMElement* node);
	static nsAutoString GetNodeID(nsIDOMElement* node);
	static void GetElementsWithID(nsAutoString id, nsIDOMElement* elem, nsVoidArray &p_list);
	nsIDOMElement* GetIfChildNodeExists(nsIDOMElement* parent, nsIDOMElement* child);

	static nsIDOMElement* GetChildNode(nsIDOMElement* parent, nsAutoString child_name);
	static PRInt32 GetChildCount(nsIDOMElement* node);
	static nsAutoString GetNodeName(nsIDOMElement* node);
	static nsAutoString GetNodeValue(nsIDOMElement* node);

	static nsAutoString GetNodeTextValue(nsIDOMElement* parent, nsAutoString node_name);
	static nsIDOMAttr* GetNodeAttribute(nsIDOMElement* node, nsAutoString attr_name);
	static nsAutoString GetNodeAttributeValue(nsIDOMElement* node, nsAutoString attr_name);
	static void GetNodesWithAttributeValue(nsIDOMElement* p_start_node, nsAutoString attr_name, nsAutoString att_val, nsVoidArray &list);
	nsIDOMElement* GetChildNodeWithAttributeValue(nsIDOMElement* p_parent_node, nsAutoString p_attr_name, nsAutoString p_attr_val);

	static void GetNodeDepth(nsIDOMElement* p_dom_node, PRInt32 &depth);
	static PRInt32 GetNodePosition(nsIDOMElement* p_dom_node);
	static PRInt32 GetSiblingsBeforeCount(nsIDOMElement* p_dom_node);
	static PRInt32 GetSiblingsAfterCount(nsIDOMElement* p_dom_node);

	static void SetNodeAttributeValue(nsIDOMElement* elem, nsAutoString attr_name, nsAutoString attr_value);
	static void SetNodeValue(nsIDOMElement* p_dom_node, nsAutoString node_value);
	void AddAttribute(nsIDOMElement* node, nsAutoString AttrName, nsAutoString AttrValue);
	void AddAttribute(nsAutoString XPath, nsAutoString AttrName, nsAutoString AttrValue);
	void AddAttribute(nsIDOMElement* node, nsAutoString AttrName, PRInt32 AttrValue);
	void SetOrCreateNodeAttributeValue(nsIDOMElement* elem, nsAutoString attr_name, nsAutoString attr_value);
	void CopyAttirbutes(nsIDOMElement* p_from_node, nsIDOMElement* p_to_node);

	static PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, nsAutoString node_value, PRBool IgnoreCase = PR_FALSE);
	static PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRInt32 node_value);
	static PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRUint32 node_value);
	static PRBool CompareNodeTextValue(nsIDOMElement* parent, nsAutoString node_name, PRFloat64 node_value);
	static PRBool CompareNodeAttributes(nsIDOMElement* node1, nsIDOMElement* node2);
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

	static PRBool IsWhiteSpace(nsIDOMElement* p_node);
	static PRInt32 NumberOfWhiteSpaces(nsIDOMElement* p_node);

	static void DumpNodeDeep(nsIDOMElement* elem);
	static void DumpNode(nsIDOMElement* elem);
};

#endif