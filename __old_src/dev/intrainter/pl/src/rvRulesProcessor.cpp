// This is a starter class for loading rules off the database and processing them to end.
// CRulesCollection is used to load the rules from db into a nsVoidArray of RuleInfo pointers
// Each RuleInfo entry in the array is a "final trace" rule and has the m_prev_rule pointer set appropriately
// to the pre rule to be processed. In essence a linked list of rules to trace the final node.
//
// Once the array of "Trace Me" rules are created, each of it is passed to the CRuleSetProcessor,
// which is responsible for one linked list of related rules.
//
// NOTE that this class is created as a standalone in order to lanuch the each ruleset in
// its own thread. So this class will be expanded to included all threads, each of which are
// processing a particular trace. This is useful since, the load of documents happens asynchronously.

#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvRulesCollection.h"
#include "rvRulesProcessor.h"
#include "rvRuleSetProcessor.h"

CRulesProcessor::CRulesProcessor()
{
	ILOG << "CRulesProcessor::CRulesProcessor()" << IINF;
}

CRulesProcessor::~CRulesProcessor()
{
	ILOG << "CRulesProcessor::~CRulesProcessor()" << IINF;
}

nsresult CRulesProcessor::ProcessRules()
{
	ILOG << "CRulesProcessor::ProcessRules()" << IINF;
	IL_TAB;

	// load the rules from db
	ILOG << "About to load rules from DB" << IINF;
	CRulesCollection* col = new CRulesCollection();
	II_RESULT load_res = col->LoadRulesFromDB();
	if (load_res != IIR_SUCCESS)
	{
		ILOG << "Failed to load rules from document" << IFTL;
		ILOG << IMSG(load_res) << IFTL;
	}
	
	ILOG << "Loaded rules from DB" << IINF;

	PRUint32 cnt = col->m_rules->Count();
	ILOG << "Number of RuleSets to Process : " << cnt << IINF;
	for (PRUint32 idx = 0; idx < cnt; idx++)
	{
		RuleInfo* rule = (RuleInfo*) (col->m_rules->ElementAt(idx));

		ILOG << "------------------------------------------------------------" << IINF;
		ILOG << "Processing RuleSet " << idx << " : " << rule->m_rule_name << IINF;

		CRuleSetProcessor* rule_obj = new CRuleSetProcessor();
		II_RESULT res = rule_obj->ProcessRuleSet(rule);
		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed to process ruleset " << IFTL;
			ILOG << IMSG(load_res) << IFTL;
		}
		
		ILOG << "Done processing RuleSet : " << rule->m_rule_name << IINF;
		ILOG << "------------------------------------------------------------" << IINF;
		
		delete rule_obj;
		DestroyRuleInfo(rule);
		ILOG << "Destroyed ruleset info" << IINF;
	}

	ILOG << "Done processing all RuleSets" << IINF;

	delete col;
	ILOG << "Destroyed Collection object" << IINF;

	IL_UNTAB;
	return NS_OK;
}
