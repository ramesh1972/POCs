#ifndef _RV_RULES_PROCESSOR_
#define _RV_RULES_PROCESSOR_

#include "rvXPCOMIDs.h"
#include "rvRuleBase.h"
#include "rvMainWindow.h"
#include "rvRuleResult.h"

class CRulesProcessor : public CRuleBase
{
public:
	CRulesProcessor();
	~CRulesProcessor();

	// From the DB a Rule is picked and Processed (PRE)
	nsresult ProcessRules();
};

#endif