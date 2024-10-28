#include "rvXPCOMIDs.h"
#include "rvRuleResult.h"
#include "rvRulesDefines.h"

void DestroyRuleInfo(RuleInfo *p_rule_info)
{
	if (p_rule_info == nsnull)
		return;

	if (p_rule_info->m_cmds != nsnull)
	{
		for (PRInt32 idx=0;idx < p_rule_info->m_cmds->Count();idx++) 
			delete ((CommandInfo*) p_rule_info->m_cmds->ElementAt(idx));

		p_rule_info->m_cmds->Clear();
		delete p_rule_info->m_cmds;
	}

	if (p_rule_info->m_rule_results != nsnull)
	{
		/*for (PRInt32 idx = 0;idx<p_rule_info->m_rule_results->Count();idx++)
		{
			RuleResult *rr = (RuleResult*) (p_rule_info->m_rule_results->ElementAt(idx));
			delete rr;
		}*/
		
		p_rule_info->m_rule_results->Clear();
		delete p_rule_info->m_rule_results;	
		p_rule_info->m_rule_results = nsnull;
		
	}

	if (p_rule_info->m_dom_node_to_spot != nsnull)
		p_rule_info->m_dom_node_to_spot = nsnull;
	
	if (p_rule_info->m_rule_root_node != nsnull)
		p_rule_info->m_rule_root_node = nsnull;

	if (p_rule_info->m_html_document != nsnull)
		p_rule_info->m_html_document = nsnull;

	if (p_rule_info->m_prev_rule)
		DestroyRuleInfo(p_rule_info->m_prev_rule);

	delete p_rule_info;
	p_rule_info = nsnull;
}


