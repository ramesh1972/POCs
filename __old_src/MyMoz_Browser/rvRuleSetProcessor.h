#ifndef _RV_RULE_SET_PROCESSOR_
#define _RV_RULE_SET_PROCESSOR_

#include "rvXPCOMIDs.h"
#include "rvRuleBase.h"
#include "rvRuleResult.h"
#include "rvRuleProcessor.h"

class CRuleSetProcessor : public CRuleBase
{
public:
	CRuleSetProcessor();
	~CRuleSetProcessor();

	// the rule processor that will hold the browser window through the entire processing
	CRuleProcessor* m_rule_processor;

	nsresult ProcessRuleSet(RuleInfo* p_rule_info);
	
	RuleInfo* ProcessIntermediaryRule(RuleInfo* p_rule_info);
	RuleInfo* ProcessStarterRule(RuleInfo* p_rule_info);
	RuleInfo* ProcessRule_Initiator(RuleInfo* p_rule_info);
	RuleInfo* ProcessPostCommands(RuleInfo* p_rule_info);

	RuleInfo* ProcessEventCommand(RuleInfo* p_rule_info, CommandInfo* cmd);
	RuleInfo* ProcessChangeCommand(RuleInfo* p_rule_info, CommandInfo* cmd);
	RuleInfo* ProcessTraceMeCommand(RuleInfo* p_rule_info, CommandInfo* cmd);
};

#endif