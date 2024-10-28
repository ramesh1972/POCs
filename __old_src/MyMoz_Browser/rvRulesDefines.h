#ifndef __RULES_DEFINES_
#define __RULES_DEFINES_

#include "rvXPCOMIds.h"

// ==================================================================
// The Rules DB Defines
#define XMLDB_PATH "file:///c:/MyMozFiles/MyMozDB/"
#define RULES_FILE "MyMozDOMSpotRules.xml"

// ==================================================================
// Rule Document Defines
// The rule tag names
#define RN_RULES "Rules"
#define RN_RULE_ROOT "RulelRoot"
#define RN_RULE "Rule"
#define RN_SIBLINGS "Siblings"
#define RN_COMMANDS "Commands"
#define RN_COMMAND  "Command"


// The rule tag attribute names
#define RN_NAME "__rulenode_name"
#define RN_DISPLAY_PARENT "__rulenode_display_parent"
#define RN_URL "__ruleurl"
#define RN_WINDOW_URL "__rule_window_url"
#define RN_FRAME_LOC "_rule_frame_location"
#define RN_TITLE "__rulenode_title"
#define RN_TYPE "__rulenode_type"
#define RN_TAG_NAME "__rulenode_tag_name"
#define RN_DEPTH	"__rulenode_depth"
#define RN_POSITION "__rulenode_position"
#define RN_SIB_BEFORE_COUNT "__rulenode_sib_before_count"
#define RN_SIB_AFTER_COUNT "__rulenode_sib_after_count"
#define RN_CHILD_COUNT "__rulenode_child_count"
#define RN_CMD_EXEC_TYPE "__cmdnode_exec_type"
#define RN_CMD_NAME "__cmdnode_name"
#define RN_CMD_PARAM_NAME "__cmdnode_pname"
#define RN_CMD_PARAM_VALUE "__cmdnode_pvalue"

// The rule document standard values
#define RNV_NODE "rule_node"
#define RNV_PARENT "parent_rule_node"
#define RNV_CHILD "child_rule_node"
#define RNV_PREV_SIB "prev_sibling"
#define RNV_NEXT_SIB "next_sibling"

// const definitions
const PRInt32 TOTAL_RULE_ATTR_COUNT = 8;

// ==================================================================
// Rule Classes Defines 
// Leaf Node Types of HTML
enum LeafNodeType
{
	LNT_NotALeaf,
	LNT_WhiteSpace,
	LNT_Unknown,
	LNT_TextContainer,
	LNT_Text,
	LNT_Image,
	LNT_InputText,
	LNT_InputButton,
	LNT_InputCheckBox,
	LNT_InputRadio,
	LNT_InputReset,
	LNT_InputSubmit,
	LNT_Button,
	LNT_Select,
	LNT_Anchor
};

// ==================================================================
// RuleResult defines
enum MatchWeightage
{
	MW_ID = 300,
	MW_TAG = 300,
	MW_ATTR = 300,

	MW_DEPTH = 100, 
	MW_POS = 100, 
	MW_SIB_BEFORE_CNT = 100, 
	MW_SIB_AFTER_CNT = 100, 

	MW_PARENT = 200,
	MW_SIB_BEFORE = 200,
	MW_SIB_AFTER = 200,
	MW_SIB_MIXED = 200,
	MW_CHILD_COUNT = 200,
	
	MW_CHILD_TREE = 300,
	MW_CONTENT = 300
};

enum DOMNodeSpotRuleType
{
	RuleType_BasedOnNodeID,
	RuleType_BasedOnParentTree,
	RuleType_HungrySearch
};

// ==================================================================
// RulesCollection Defines
enum CmdExecuteType
{
	CET_PreLoad = 1,
	CET_PostLoad = 2
};

enum CmdType
{
	CT_PickMe,
	CT_Click,
	CT_Change,
	CT_ProcessRule,
};

struct CommandInfo
{
public:
	nsAutoString m_exec_type;
	nsAutoString m_cmd;
	nsAutoString m_param_name;
	nsAutoString m_param_value;

	CommandInfo()
	{
		m_exec_type = MozStr("");
		m_cmd = MozStr("");
		m_param_name = MozStr("");
		m_param_value = MozStr("");
	}
};

typedef nsVoidArray CommandList;

struct RuleInfo
{
public:
	// rule creation info
	nsAutoString m_window_url; // IF this window contains the frame, it will be the windows url.
	nsAutoString m_frame_id;
	nsAutoString m_url; // THis will be the frame's url if it is a frame, otherwise it will be the same as m_window_url if there are no frames
	nsAutoString m_rule_name;
	nsIDOMElement *m_dom_node_to_spot;
	CommandList* m_cmds;
	
	// rule processing info
	nsIDOMHTMLDocument *m_html_document;
	nsIDOMElement *m_rule_root_node;
	nsVoidArray* m_rule_results;
	
	PRBool m_rule_executed;
	PRBool m_will_load_new_document;

	// processing link info
	RuleInfo *m_prev_rule;
};

// The following two hold pointers to RuleInfo objects
typedef nsVoidArray RuleInfoList;  // holds all the rules(pointers to RuleInfo), typically, the main rules that have a PickMe command
																	 // the other intermediary rules are linked by m_prev_rule of RuleInfo

void DestroyRuleInfo(RuleInfo *p_rule_info);
#endif