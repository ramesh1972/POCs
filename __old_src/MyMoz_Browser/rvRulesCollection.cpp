#include "rvRulesCollection.h"

extern rvXmlDocument* _rules_doc;

CRulesCollection::CRulesCollection()
{
	m_rules = new nsVoidArray();
	m_current_rule_info = nsnull;
}

CRulesCollection::~CRulesCollection()
{
	m_rules->Clear();
	delete m_rules;
	m_current_rule_info = nsnull;
}

void CRulesCollection::LoadRulesFromDB()
{
	// Load each root node into a void array of RuleInfo
	nsIDOMElement* doc_elem = _rules_doc->GetDocumentElement();  // addrefs
	if (doc_elem == nsnull)
		return; // ERR: Something drastically wrong with the xml rules db

	nsIDOMNodeList* rules; doc_elem->GetChildNodes(&rules);  // addrefs

	RuleInfoList* temp_rules_array = new nsVoidArray();
	if (rules != nsnull)
	{
		PRUint32 num_rules = 0; rules->GetLength(&num_rules);
		for (PRInt32 idx = 0;idx < num_rules;idx++)
		{
			RuleInfo* rule_info = new RuleInfo();
			nsIDOMElement* rule_root = nsnull;
			rules->Item(idx, (nsIDOMNode**) &rule_root); // addrefs
			rule_info->m_rule_root_node = rule_root;
			NS_RELEASE(rule_root);

			rule_info->m_rule_name = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_NAME));
			rule_info->m_window_url = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_WINDOW_URL));
			rule_info->m_frame_id = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_FRAME_LOC));
			rule_info->m_url = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_URL));
			rule_info->m_dom_node_to_spot = nsnull;
			rule_info->m_html_document = nsnull;

			// Load the Commands
			rule_info->m_cmds = new nsVoidArray();
			nsIDOMElement* cmds_root = _rules_doc->GetChildNode(rule_info->m_rule_root_node, MozStr(RN_COMMANDS));  // addrefs
			if (cmds_root != nsnull)
			{
				nsIDOMNodeList* cmds; cmds_root->GetChildNodes(&cmds); // addrefs
				if (cmds != nsnull)
				{
					PRUint32 cmd_cnt = 0; cmds->GetLength(&cmd_cnt);
					for (PRInt32 idx1 = 0; idx1 < cmd_cnt; idx1++)
					{
						CommandInfo* cmd_info = new CommandInfo();
						nsIDOMElement* cmd=nsnull;
						cmds->Item(idx1, (nsIDOMNode**) &cmd); // addrefs
						
						cmd_info->m_cmd = _rules_doc->GetNodeAttributeValue(cmd, MozStr(RN_CMD_NAME)); 
						cmd_info->m_exec_type = _rules_doc->GetNodeAttributeValue(cmd, MozStr(RN_CMD_EXEC_TYPE));
						cmd_info->m_param_name = _rules_doc->GetNodeAttributeValue(cmd, MozStr(RN_CMD_PARAM_NAME));
						cmd_info->m_param_value = _rules_doc->GetNodeAttributeValue(cmd, MozStr(RN_CMD_PARAM_VALUE));
						
						NS_RELEASE(cmd);
						rule_info->m_cmds->AppendElement((void*) cmd_info);
					}

					NS_RELEASE(cmds);

					rule_info->m_rule_results = nsnull;
					rule_info->m_rule_executed = PR_FALSE;
					rule_info->m_will_load_new_document = PR_FALSE;

					// processing link info
					rule_info->m_prev_rule = nsnull;

					// add it to the rules array
					temp_rules_array->AppendElement((void*) rule_info);
				}
				NS_RELEASE(cmds_root);
			}
		}
		NS_RELEASE(rules);
	}

	// Then sort the same
	RuleInfo* current = (RuleInfo*) temp_rules_array->ElementAt(0);
	PRInt32 idx2=0;
	while (temp_rules_array->Count() > 0 && current != nsnull)
	{
		// For each rule check the commands
		// If there is a PickMe, get it and remove it from the array
		if (current->m_prev_rule == nsnull)
		{
			// check if there is a Pre Process Rule, if so find it/remove it and add as the prev rule of the above node
			RuleInfo* next_rule = GetNextProcessRule(temp_rules_array, current);
			while (next_rule != nsnull)
			{
				if (next_rule->m_window_url == current->m_window_url)
				{
					if (next_rule->m_frame_id == current->m_frame_id)
					{
						if (next_rule->m_url == current->m_url)
							current->m_will_load_new_document = PR_FALSE;
						else
							current->m_will_load_new_document = PR_TRUE;
					}
					else
							current->m_will_load_new_document = PR_FALSE;
				}
				else
					current->m_will_load_new_document = PR_TRUE;

				// if this is loading of the framseset, then we have to indicate a change in document on the current
				if (next_rule->m_window_url == next_rule->m_url)
				{
					if (current->m_window_url == current-> m_url && current->m_url == next_rule->m_url)
						; // Nothing
					else
						current->m_will_load_new_document = PR_TRUE;
				}

				next_rule->m_prev_rule = current;
				temp_rules_array->RemoveElement((void*) current);

				// check again if this has a pre process rule, and do the samething is as above, until there is no pre process rule
				current = next_rule;
				next_rule = GetNextProcessRule(temp_rules_array, current);
			}

			// add the PickMe to m_rules collection
			RuleInfo* theRule = current;
			m_rules->AppendElement((void*) theRule);
			temp_rules_array->RemoveElement((void*) current);
		}

		current = (RuleInfo*) temp_rules_array->ElementAt(0);
	}

	delete temp_rules_array;

	NS_RELEASE(doc_elem);
}

PRBool CRulesCollection::IsThisAPickMeRule(RuleInfo* rule)
{
	PRInt32 num_cmds = rule->m_cmds->Count();
	for (PRInt32 idx =num_cmds-1;idx >=0;idx--)
	{
		CommandInfo* cmd = (CommandInfo*) rule->m_cmds->ElementAt(idx);
		if (cmd->m_cmd.EqualsIgnoreCase("TraceEvent") && cmd->m_exec_type.EqualsIgnoreCase("PickMe"))
			return PR_TRUE;
	}

	return PR_FALSE;
}

RuleInfo* CRulesCollection::GetNextProcessRule(RuleInfoList* list, RuleInfo* rule)
{
	PRInt32 idx1 = 0;
	RuleInfo* current = (RuleInfo*) list->ElementAt(idx1);
	while (current != nsnull)
	{
		PRInt32 num_cmds = current->m_cmds->Count();
		for (PRInt32 idx =num_cmds-1;idx >=0;idx--)
		{
			CommandInfo* cmd = (CommandInfo*) current->m_cmds->ElementAt(idx);
			if (cmd->m_cmd.EqualsIgnoreCase("ProcessRule"))
			{
				nsAutoString next_rule_name = cmd->m_param_value;

				if (rule->m_rule_name == next_rule_name)
					return current;
			}
		}
	
		idx1++;
		current = (RuleInfo*) list->ElementAt(idx1);
	}

	return nsnull;
}

