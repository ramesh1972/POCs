#include "rvMyMozapp.h"
#include "rvRulesCollection.h"

// externs
IRULESG;

CRulesCollection::CRulesCollection()
{
	ILOG << "CRulesCollection::CRulesCollection()" << IINF;
	IL_TAB;

	m_rules = new nsVoidArray();
	
	IL_UNTAB;
}

CRulesCollection::~CRulesCollection()
{
	ILOG << "CRulesCollection::~CRulesCollection()" << IINF;
	IL_TAB;

	m_rules->Clear();
	delete m_rules;

	ILOG << "Done Destruction" << " CRulesCollection" << IINF;
	IL_UNTAB;
}

II_RESULT CRulesCollection::LoadRulesFromDB()
{
	ILOG << "CRulesCollection::LoadRulesFromDB()" << IINF;
	IL_TAB;

	// Load each root node into a void array of RuleInfo
	nsIDOMElement* doc_elem = _rules_doc->GetDocumentElement();  // addrefs
	if (doc_elem == nsnull)
	{
		ILOG << "Failed to Get DocumentElement" << IFTL;
		IL_UNTAB;
	
		return IIR_RULES_FAILED_CONNECTION; // ERR: Something drastically wrong with the xml rules db
	}

	nsIDOMNodeList* rules; 
	doc_elem->GetChildNodes(&rules);  // addrefs
	if (rules == nsnull)
	{
		ILOG << "No Rules to Process" << IFTL;
		NS_RELEASE(doc_elem);

		IL_UNTAB;
		return IIR_RULES_NONE;
	}

	PRUint32 num_rules = 0; 
	rules->GetLength(&num_rules);
	if (num_rules < 1)
	{
		ILOG << "No Rules to Process" << IFTL;
		NS_RELEASE(doc_elem);
		
		IL_UNTAB;
		return IIR_RULES_NONE;
	}
	
	// ok found rules
	ILOG << "Found Rules. Creating an Array of Rules" << IINF;
	RuleInfoList* temp_rules_array = new nsVoidArray();

	// do a flat load of all rules. Later create the linked list of rules and set of linked lists
	for (PRInt32 idx = 0; idx < num_rules; idx++)
	{
		RuleInfo* rule_info = new RuleInfo();
		nsIDOMElement* rule_root = nsnull;

		// rule root
		rules->Item(idx, (nsIDOMNode**) &rule_root); // addrefs
		rule_info->m_rule_root_node = rule_root;
		NS_RELEASE(rule_root);

		// standard params
		rule_info->m_rule_name = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_NAME));
		rule_info->m_url = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_URL));
		rule_info->m_window_url = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_WINDOW_URL));
		rule_info->m_frame_id = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_FRAME_LOC));
		rule_info->m_window_type = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_WINDOW_TYPE));
		rule_info->m_document_load_type = _rules_doc->GetNodeAttributeValue(rule_info->m_rule_root_node, MozStr(RN_LOAD_TYPE)); //#
	
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
					
					rule_info->m_cmds->AppendElement((void*) cmd_info);
					NS_RELEASE(cmd);
				}
				NS_RELEASE(cmds);
			}
			NS_RELEASE(cmds_root);

			// null settings
			rule_info->m_dom_node_to_spot = nsnull;
			rule_info->m_html_document = nsnull;
			rule_info->m_rule_results = nsnull;

			// processing link info
			rule_info->m_prev_rule = nsnull;

			// add it to the rules array
			temp_rules_array->AppendElement((void*) rule_info);
		}
	}
	
	NS_RELEASE(rules);
	ILOG << "Completed creating a temp array of Rules" << IINF;
	
	// Then sort the same
	ILOG << "Creating an array of linked lists of rule objects" << IINF;

	PRInt32 idx2=0;
	PRInt32 cnt1=temp_rules_array->Count();
	RuleInfo* current = (RuleInfo*) temp_rules_array->ElementAt(0);

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
				next_rule->m_prev_rule = current;
				temp_rules_array->RemoveElement((void*) current);

				// check again if this has a pre process rule, and do the samething is as above, until there is no pre process rule
				current = next_rule;
				next_rule = GetNextProcessRule(temp_rules_array, current);
			}

			// add the PickMe to m_rules collection
			RuleInfo* theRule = current;
			m_rules->AppendElement((void*) theRule);

			ILOG << "Created a ruleset: start rule name:" << theRule->m_rule_name << IINF;
			temp_rules_array->RemoveElement((void*) current);
		}

		current = (RuleInfo*) temp_rules_array->ElementAt(0);
	}

	delete temp_rules_array;
	NS_RELEASE(doc_elem);

	ILOG << "Completed creating rulesets" << IINF;
	IL_UNTAB;

	return IIR_SUCCESS;
}

RuleInfo* CRulesCollection::GetNextProcessRule(RuleInfoList* list, RuleInfo* rule)
{
	// Find the rule which has to be processed after the current rule. Basically used in 
	// setting the m_prev_rule member of RuleInfo
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

