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

	II_RESULT ProcessRuleSet(RuleInfo *&p_rule_info);
	
	II_RESULT ProcessIntermediaryRule(RuleInfo *&p_rule_info);
	II_RESULT ProcessStarterRule(RuleInfo *&p_rule_info);
	II_RESULT ProcessRule_Initiator(RuleInfo *&p_rule_info);
	II_RESULT ProcessPostCommands(RuleInfo *&p_rule_info);

	II_RESULT ProcessEventCommand(RuleInfo *&p_rule_info, CommandInfo* cmd);
	II_RESULT ProcessChangeCommand(RuleInfo *&p_rule_info, CommandInfo* cmd);
	II_RESULT ProcessTraceMeCommand(RuleInfo *&p_rule_info, CommandInfo* cmd);
};

#endif