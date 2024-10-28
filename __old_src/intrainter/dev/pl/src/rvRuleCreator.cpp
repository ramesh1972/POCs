#include "rvMyMozApp.h"
#include "rvXmlDocument.h"
#include "rvHTMLElement.h"
#include "rvRuleCreator.h"

// externs
IRULESG;

CRuleCreator::CRuleCreator()
{
}

CRuleCreator::~CRuleCreator()
{
}

void CRuleCreator::CreateRule(RuleInfo* p_rinfo)
{
	// set the basic member
	m_rule_info = p_rinfo;

	// create rule root node
	CreateRootNode();

	// create the command nodes
	CreateCommands();

	// Create Rule node
	CreateRuleNode();

	// Set the other main atributes for the root node
	SetURL();
	SetTitle();
}

void CRuleCreator::CreateRootNode()
{
	// Check if this rule already exists
	nsIDOMElement* doc_element = _rules_doc->GetDocumentElement(); 
	if (doc_element == nsnull)
		return;

	nsIDOMNode* rule_root = _rules_doc->GetChildNodeWithAttributeValue(doc_element, MozStr(RN_NAME), m_rule_info->m_rule_name);
	
	if (rule_root == nsnull)
	{
		// It does not exist, So create a <RuleRoot> node with __rulename attribute
		rule_root = _rules_doc->CreateNode(MozStr(RN_RULES), MozStr(RN_RULE_ROOT));
		m_rule_info->m_rule_root_node  = (nsIDOMElement*) rule_root;
		NS_RELEASE(rule_root);
		_rules_doc->AddAttribute(m_rule_info->m_rule_root_node, MozStr(RN_NAME), m_rule_info->m_rule_name);
		_rules_doc->AddAttribute(m_rule_info->m_rule_root_node, MozStr(RN_WINDOW_TYPE), m_rule_info->m_window_type);
		_rules_doc->AddAttribute(m_rule_info->m_rule_root_node, MozStr(RN_LOAD_TYPE), m_rule_info->m_document_load_type); //#
	}
	else
	{
		m_rule_info->m_rule_root_node  = (nsIDOMElement*) rule_root;
		NS_RELEASE(rule_root);
	}
	
	NS_RELEASE(doc_element);
	return;
}

void CRuleCreator::CreateCommands()
{
	// Check if commands already exist
	nsIDOMElement* cmds_node = _rules_doc->GetChildNode(m_rule_info->m_rule_root_node, MozStr(RN_COMMANDS));
	if (cmds_node == nsnull) // create a new one
		cmds_node = _rules_doc->CreateNode(m_rule_info->m_rule_root_node, MozStr(RN_COMMANDS));
	
	PRInt32 num_cmds = m_rule_info->m_cmds->Count();
	for (PRInt32 idx =0;idx < num_cmds;idx++)
	{
		CommandInfo* cmd = (CommandInfo*) m_rule_info->m_cmds->ElementAt(idx);
		if (cmd == nsnull)
			continue;

		// Check if this command exists
		nsIDOMNodeList* cmd_nodes;
		cmds_node->GetChildNodes(&cmd_nodes);
		PRUint32 len = 0; cmd_nodes->GetLength(&len);
		nsIDOMElement* cmd_node = nsnull;
		for (PRInt32 idx1 = 0; idx1 < len; idx1++)
		{
			cmd_nodes->Item(idx1, (nsIDOMNode**) &cmd_node);
			if (_rules_doc->GetNodeAttributeValue(cmd_node, MozStr(RN_CMD_EXEC_TYPE)) == cmd->m_exec_type &&
					_rules_doc->GetNodeAttributeValue(cmd_node, MozStr(RN_CMD_NAME)) == cmd->m_cmd &&
					_rules_doc->GetNodeAttributeValue(cmd_node, MozStr(RN_CMD_PARAM_NAME)) == cmd->m_param_name)
					break;
		
			NS_RELEASE(cmd_node);
			cmd_node = nsnull;
		}
		
		// if already exists then just update the value
		if (cmd_node != nsnull)
			_rules_doc->SetNodeAttributeValue(cmd_node, MozStr(RN_CMD_PARAM_VALUE), cmd->m_param_value);
		else
		{// create a new command node
			cmd_node = _rules_doc->CreateNode(cmds_node, MozStr(RN_COMMAND));
			_rules_doc->AddAttribute(cmd_node, MozStr(RN_CMD_EXEC_TYPE), cmd->m_exec_type); 
			_rules_doc->AddAttribute(cmd_node, MozStr(RN_CMD_NAME), cmd->m_cmd);
			_rules_doc->AddAttribute(cmd_node, MozStr(RN_CMD_PARAM_NAME), cmd->m_param_name);
			_rules_doc->AddAttribute(cmd_node, MozStr(RN_CMD_PARAM_VALUE), cmd->m_param_value);

			NS_RELEASE(cmd_node);
		}

		NS_IF_RELEASE(cmd_nodes);
	}

	NS_RELEASE(cmds_node);
}

void CRuleCreator::CreateRuleNode()
{
	if (m_rule_info->m_dom_node_to_spot == nsnull)
		return; // No rules to create, mostly a refresh of the page

	// Check if the Rule Node exists
	nsIDOMElement* starting_rule_node = _rules_doc->GetChildNode(m_rule_info->m_rule_root_node, MozStr(RN_RULE));
	if (starting_rule_node != nsnull) // then nothing to do, return
	{
		NS_RELEASE(starting_rule_node);
		return;
	}

	// create the parent node rules for the selected DOM object
	nsIDOMElement* current_rule_node = m_rule_info->m_rule_root_node;
	nsIDOMElement* dom_parent;
	m_rule_info->m_dom_node_to_spot->GetParentNode((nsIDOMNode**) &dom_parent);
	CreateRuleNode_ParentTree(dom_parent, &current_rule_node);
	CreateRuleNode_AddSiblings(m_rule_info->m_dom_node_to_spot, current_rule_node);

	// Create the rule node for the selected DOM object
	nsIDOMElement* l_rule_node = _rules_doc->CreateNode(current_rule_node, MozStr(RN_RULE));

	_rules_doc->AddAttribute(l_rule_node, MozStr(RN_TYPE), MozStr(RNV_NODE));
	CreateRuleNode_MakeAttributes(m_rule_info->m_dom_node_to_spot, l_rule_node);

	//	create the child node rules for the selected DOM object
	CreateRuleNode_ChildTree(m_rule_info->m_dom_node_to_spot, l_rule_node);
	NS_IF_RELEASE(l_rule_node);
	NS_IF_RELEASE(dom_parent);
}

II_RESULT CRuleCreator::CreateRuleNode_AddContent(nsIDOMElement* p_dom_node,nsIDOMElement* p_rule_node)
{
	ILOG << "CRuleCreator::CreateRuleNode_AddContent()" << IDBG;

	// get the leaf node type
	II_HTMLNodeType type = rvHTMLElement::GetNodeType(p_dom_node);

	if (type == IIN_Text)
	{
		nsAutoString text;
		II_RESULT res = rvHTMLElement::GetTextElementValue(p_dom_node, text);
		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed while getting text element (#text) value" << IERR;
			return res;
		}

		nsIDOMText* textn = _rules_doc->CreateNodeWithText(p_rule_node, MozStr("Text"), text);
		NS_RELEASE(textn);

		ILOG << "Succesfully added Text content" << IDBG;
		return IIR_SUCCESS;
	}

	if (type == IIN_Image)
	{
		// Add these sub children
		nsIImage* pimg;
		rvHTMLElement::GetImageFromDOMNode((nsIDOMNode*)p_dom_node, &pimg);
		
		if (pimg == nsnull)
		{
			ILOG << "Could not get image interface" << IERR;
			return IIR_NULL_INTERFACE;
		}

		nsIDOMElement* image_rule_node = _rules_doc->CreateNode(p_rule_node, MozStr("Image"));

		nsIDOMNode* text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("BytesPix"), pimg->GetBytesPix());
		NS_RELEASE(text);
		text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("IsRowOrderTopToBottom"), pimg->GetIsRowOrderTopToBottom());
		NS_RELEASE(text);
		text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("PixWidth"), pimg->GetWidth());	
		NS_RELEASE(text);
		text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("PixHeight"), pimg->GetHeight());	
		NS_RELEASE(text);
		text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("HasAlphaMask"), pimg->GetHasAlphaMask());	
		NS_RELEASE(text);

		PRInt32 width=0, height=0;
		II_RESULT res = rvHTMLElement::GetImageDimensions(p_dom_node, width, height);
		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed while getting image element width and height" << IERR;
			NS_RELEASE(image_rule_node);
			NS_RELEASE(pimg);
			return res;
		}

		text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("NaturalHeight"), height);	
		NS_RELEASE(text);
		text =_rules_doc->CreateNodeWithText(image_rule_node, MozStr("NaturalWidth"), width);	
		NS_RELEASE(text);

		nsColorMap* cmap = pimg->GetColorMap();
		if (cmap != nsnull)
		{
			text = _rules_doc->CreateNodeWithText(image_rule_node, MozStr("NumColors"), cmap->NumColors);	
			NS_RELEASE(text);
		}
		else
		{
			text = _rules_doc->CreateNodeWithText(image_rule_node, MozStr("NumColors"), -1);	
			NS_RELEASE(text);
		}

		NS_RELEASE(image_rule_node);
		NS_RELEASE(pimg);

		ILOG << "Succesfully added Image content" << IDBG;
		return IIR_SUCCESS;
	}

	ILOG << "Not a leaf node that requires any special processing" << IDBG;
	return IIR_NOTHING_DONE;
}

void CRuleCreator::CreateRuleNode_MakeAttributes(nsIDOMElement* p_dom_node, nsIDOMElement* p_rule_node)
{
	if (p_dom_node == nsnull || p_rule_node == nsnull)
		return;

	// add the tag name
	nsAutoString dom_node_name = _rules_doc->GetNodeName(p_dom_node);
	_rules_doc->AddAttribute(p_rule_node, MozStr(RN_TAG_NAME), dom_node_name);

	// do we have to display the parent
	if (dom_node_name.EqualsIgnoreCase("area"))
		_rules_doc->AddAttribute(p_rule_node, MozStr(RN_DISPLAY_PARENT), MozStr("true"));
	else
		_rules_doc->AddAttribute(p_rule_node, MozStr(RN_DISPLAY_PARENT), MozStr("false"));

	// add the depth
	PRInt32 depth = 0;
	_rules_doc->GetNodeDepth(p_dom_node, depth);
	nsAutoString depth_str(NS_LITERAL_STRING(""));
	depth_str.AppendInt(depth);
	_rules_doc->AddAttribute(p_rule_node, MozStr(RN_DEPTH), depth_str);

	// add the position
	PRInt32 pos = _rules_doc->GetNodePosition(p_dom_node);
	nsAutoString pos_str(NS_LITERAL_STRING(""));
	pos_str.AppendInt(pos);
	_rules_doc->AddAttribute(p_rule_node, MozStr(RN_POSITION), pos_str);

	// add the total siblings before and after
	PRInt32 chld_bfre_cnt = _rules_doc->GetSiblingsBeforeCount(p_dom_node);
	nsAutoString chld_bfre_cnt_str(NS_LITERAL_STRING(""));
	chld_bfre_cnt_str.AppendInt(chld_bfre_cnt);
	_rules_doc->AddAttribute(p_rule_node, MozStr(RN_SIB_BEFORE_COUNT), chld_bfre_cnt_str);

	PRInt32 chld_aftr_cnt = _rules_doc->GetSiblingsAfterCount(p_dom_node);
	nsAutoString chld_aftr_cnt_str(NS_LITERAL_STRING(""));
	chld_aftr_cnt_str.AppendInt(chld_aftr_cnt);
	_rules_doc->AddAttribute(p_rule_node, MozStr(RN_SIB_AFTER_COUNT), chld_aftr_cnt_str);

	// add the child count
	PRUint32 child_count = _rules_doc->GetChildCount(p_dom_node);
	nsAutoString chld_cnt_str(NS_LITERAL_STRING(""));
	chld_cnt_str.AppendInt(child_count);
	_rules_doc->AddAttribute(p_rule_node, MozStr(RN_CHILD_COUNT), chld_cnt_str);

	// add the dom node's attributes
	_rules_doc->CopyAttirbutes(p_dom_node, p_rule_node);
}

void CRuleCreator::CreateRuleNode_ParentTree(nsIDOMElement* p_dom_node, nsIDOMElement** p_rule_node)
{
	// Recursively traverse the parent of the spotted dom node and  
	// add the parent node info
	if (p_dom_node == nsnull || p_rule_node == nsnull)
		return;

	nsIDOMElement* parent = nsnull;
	nsresult rv = p_dom_node->GetParentNode((nsIDOMNode**) &parent);

	if (rv == NS_OK && parent != nsnull)
	{
		CreateRuleNode_ParentTree(parent, p_rule_node);
		NS_RELEASE(parent);
	}

	// add the siblings for the parent
	CreateRuleNode_AddSiblings(p_dom_node, *p_rule_node);

	// create the node for the child rule
	nsIDOMElement* l_rule_node = _rules_doc->CreateNode(*p_rule_node,MozStr(RN_RULE));
	_rules_doc->AddAttribute(l_rule_node, MozStr(RN_TYPE), MozStr(RNV_PARENT));
	CreateRuleNode_MakeAttributes(p_dom_node, l_rule_node);
	*p_rule_node = l_rule_node;
	NS_RELEASE(l_rule_node);
}

void CRuleCreator::CreateRuleNode_ChildTree(nsIDOMElement* p_dom_node, nsIDOMElement* p_rule_node)
{
	if (p_dom_node == nsnull || p_rule_node == nsnull)
		return;

	if (CreateRuleNode_AddContent(p_dom_node, p_rule_node) == IIR_SUCCESS)
		return;

	PRBool yes = PR_FALSE;
	p_dom_node->HasChildNodes(&yes);
	if (yes)
	{
		nsIDOMNodeList* node_list;
		p_dom_node->GetChildNodes(&node_list);
		PRUint32 cnt;
		node_list->GetLength(&cnt);
		for (PRInt32 idx=0; idx< cnt;idx++) 
		{
			nsIDOMElement* child;
			node_list->Item(idx, (nsIDOMNode**) &child);

			if (rvXmlDocument::IsWhiteSpace(child))
			{
				NS_RELEASE(child);
				continue;
			}

			nsIDOMElement* l_rule_node = _rules_doc->CreateNode(p_rule_node, MozStr(RN_RULE));
			_rules_doc->AddAttribute(l_rule_node, MozStr(RN_TYPE), MozStr(RNV_CHILD));
			CreateRuleNode_MakeAttributes(child, l_rule_node);
			CreateRuleNode_ChildTree(child, l_rule_node);
			NS_RELEASE(child);
			NS_RELEASE(l_rule_node);
		}

		NS_IF_RELEASE(node_list);
	}
}

void CRuleCreator::CreateRuleNode_AddSiblings(nsIDOMElement* p_dom_node, nsIDOMElement* p_rule_node)
{
	if (p_dom_node == nsnull || p_rule_node == nsnull)
		return;

	nsresult rv;
	nsIDOMElement* prev;
	nsIDOMElement* l_sib_node = _rules_doc->CreateNode(p_rule_node,MozStr(RN_SIBLINGS));
	if (l_sib_node == nsnull)
		return;

	rv = p_dom_node->GetPreviousSibling((nsIDOMNode**) &prev);
	while (rv == NS_OK && prev != nsnull && rvXmlDocument::IsWhiteSpace(prev))
	{		
		nsIDOMElement *tmp_prev;
		rv = prev->GetPreviousSibling((nsIDOMNode**) &tmp_prev);
		NS_RELEASE(prev);
		prev = tmp_prev;
	}

	if (rv == NS_OK && prev != nsnull)
	{
		nsIDOMElement* prev_sib = _rules_doc->CreateNode(l_sib_node,MozStr(RN_RULE));
		_rules_doc->AddAttribute(prev_sib, MozStr(RN_TYPE), MozStr(RNV_PREV_SIB));
		CreateRuleNode_MakeAttributes(prev, prev_sib);
		NS_IF_RELEASE(prev_sib);
	}
	NS_IF_RELEASE(prev);

	nsIDOMElement* next;
	rv = p_dom_node->GetNextSibling((nsIDOMNode**) &next);
	while(rv == NS_OK && next != nsnull && rvXmlDocument::IsWhiteSpace(next))
	{
		nsIDOMElement *tmp_next;
		rv = next->GetNextSibling((nsIDOMNode**) &tmp_next);
		NS_RELEASE(next);
		next = tmp_next;
	}
	
	if (rv == NS_OK && next != nsnull && !rvXmlDocument::IsWhiteSpace(next))
	{
		nsIDOMElement* next_sib = _rules_doc->CreateNode(l_sib_node,MozStr(RN_RULE));
		_rules_doc->AddAttribute(next_sib, MozStr(RN_TYPE), MozStr(RNV_NEXT_SIB));
		CreateRuleNode_MakeAttributes(next, next_sib);
		NS_IF_RELEASE(next_sib);
	}
	NS_IF_RELEASE(next);

	NS_RELEASE(l_sib_node);
}

bool CRuleCreator::SetURL()
{
	_rules_doc->AddAttribute(m_rule_info->m_rule_root_node, MozStr(RN_URL), m_rule_info->m_url);

	// Set the windows URL
	if (m_rule_info->m_window_url != MozStr(""))
	{
		_rules_doc->AddAttribute(m_rule_info->m_rule_root_node, MozStr(RN_WINDOW_URL), m_rule_info->m_window_url);
		_rules_doc->AddAttribute(m_rule_info->m_rule_root_node, MozStr(RN_FRAME_LOC), m_rule_info->m_frame_id);
	}

	return PR_TRUE;
}

bool CRuleCreator::SetTitle()
{
	return PR_TRUE;
}

