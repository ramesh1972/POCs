// basically should hold pointers to rule creators/processors

// The GUI/front end, traces the events and creates the following SpotRuleList
// As and when a node is picked the, the rule has to be created
//				rule_creator->CreateRule(RuleInfo);
//				The RuleInfo object consists of the url, html doc, dom node, the commands (before and after),
//				and also duing processing stage, the RuleResult
// The rule_Creator has to be invoked for each change, since the html doc will not be available for later processing.
// RuleInfo --> URL, HTML Doc, DOM Node, Rule DOM Node, RULE Command Node, RuleResult
//
// TO hold a certain set of rules for spotting a node, several spottings might be required in order to first execute the commands
// and load the final url and hence process the "final spot". RuleInfoGroup struct does exactly the same
// contains a ordered array of RuleInfo object pointers.
//
// An instance of this object holds rule data obejcts for spotting a sinle node
// structure
//		RuleInfoGroup->RuleInfo
//								 ->RuleInfo
//								 ->RuleInfo

// RuleInfo is created before a spot and sorted according to the load of URLs (from the Commands in PRE section)
// A New Class called CRulesCommandExecutor to be created, which will hold a collection of SpotRulesList
// And Processes Commands. The RuleInfo objects will be processed ony by one (but in sequence for the same URL)
//
// This class will have a singleton void array of RuleInfoGroup may be called RuleInfoGroupSet
//				nsVoidArray m_rule_info_group_set;
// During creation process, RuleInfo and RuleInfoGroup objects are created and passed on to the rule creator.
// During the processing, these are created from the XML.
//
// IMPORTANT: the RulesCollection class not only interfaces between the GUI and creator and processor class,
// but also loads from and saves to the Rules XML/DB.

// classes
//	rvDOMEventListener, -> Listens to DOM events until a "pick node" event is fired. While doing so creates,
//												 an ordered list of CRulesCollection
//  CRulesCollection -> Holds all the rules/commands for all the dom nodes to spotted. A function to order the list.
//  CRuleCreator -> For a given Rule object from the collection creates a <RuleRoot><Commands></Commands><Rule></Rule></RuleRoot> xml object and saves
//  ---------
//  CRulesCommandExecutor -> Creates the CRulesCollection fomr the XML DB
//													 orders them (from first url/first noe - last url/final node)
//													 picks up a rule node and processes commands until completion
//  CRuleProcessor ->			For every command from the above class, a rule processor is created and does the actual execution
//  CRuleBase -> A simple base class holding common functions for the above classes.

#ifndef _RV_RULES_COLLECTION_
#define _RV_RULES_COLLECTION_

#include "rvRuleBase.h"

class CRulesCollection : public CRuleBase
{
public:
	CRulesCollection();
	~CRulesCollection();

public:
	RuleInfoList* m_rules;
	RuleInfo* m_current_rule_info;

	// processing phase
	void LoadRulesFromDB();
	PRBool IsThisAPickMeRule(RuleInfo* rule);
	RuleInfo* GetNextProcessRule(RuleInfoList* list, RuleInfo* rule);
};

#endif