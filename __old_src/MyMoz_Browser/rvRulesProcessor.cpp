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

extern rvMyMozApp* theApp;
extern rvXmlDocument* _rules_doc;

CRulesProcessor::CRulesProcessor()
{
}

CRulesProcessor::~CRulesProcessor()
{
}

// ===========================================================================
nsresult CRulesProcessor::ProcessRules()
{
	// load the rules from db
	CRulesCollection* col = new CRulesCollection();
	col->LoadRulesFromDB();

	PRUint32 cnt = col->m_rules->Count();
	for (PRUint32 idx = 0; idx <cnt;idx++)
	{
		RuleInfo* rule = (RuleInfo*) (col->m_rules->ElementAt(idx));
		CRuleSetProcessor* rule_obj = new CRuleSetProcessor();
		rule_obj->ProcessRuleSet(rule);
		delete rule_obj;
		DestroyRuleInfo(rule);
	}

	delete col;
	
	return NS_OK;
}
