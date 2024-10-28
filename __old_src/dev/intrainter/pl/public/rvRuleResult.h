#ifndef __RV_RULE_RESULT_
#define __RV_RULE_RESULT_

#include "rvRulesDefines.h"

// ==================================================================
// Class for processing the spot rule of single DOM Node
// BASIS: There are 4 categories, identity, structure, nodes around and content(including child tree)
// The assumption is that documents do not change drastically. the expected changes are
// the identity does not change most of the time
		// The ID cannot change
		// The tag name cannot change
		// attributes could change, but not drastically. for an input element, size or textvalue could be different, such attributes are to be given less weightage, for an image, src could change, for an a href could change
// the nodes in and around move together, but usually stick together
		// parent never changes, unless the page has been remade
		// if position matches, then siblings should match
		// children likely to change, when it is a auto generated content like lists, trees, content values
// depth and position could change
		// the depth could change, because of addition and deletion of nodes in the parent tree when doucments are auto generated
		// position could change more quite easily than the depth
		// if the position is not changed, then siblings counts mostly should be the same
// the child content could change, but again not drastically
	// for manually written pages, node content structure should not change
	// for auto-generated, few nodes could be added/removed
	// highly unlikely that the entire child tree will be different, unless if the node is at the top of the tree
struct RuleResult
{
	public:
		RuleResult()
		{
			id_exists_mv = -1;	
			id_match_mv = -1;
			tag_match_mv = -1;
			tag_attr_mv = -1; 

			depth_mv = -1;
			position_mv = -1; 
			sib_before_count_mv = -1; 
			sib_after_count_mv = -1; 
			child_count_mv = -1; 

			sib_before_mv = -1; 
			sib_after_mv = -1; 
			sib_mixed_sib_mv = -1;
			
			parent_mv = -1;
			node_content_mv = -1;
			m_content_changed = PR_FALSE;

			html_node = nsnull;
		}

		DOMNodeSpotRuleType parse_type;
		PRFloat64 weighted_match_value;

		PRBool id_exists_mv;	
		PRFloat64 id_match_mv; 
		PRFloat64 tag_match_mv; 
		PRFloat64 tag_attr_mv; 

		PRFloat64 depth_mv; 
		PRFloat64 position_mv; 
		PRFloat64 sib_before_count_mv; 
		PRFloat64 sib_after_count_mv; 
		PRFloat64 child_count_mv; 

		PRFloat64 sib_before_mv; 
		PRFloat64 sib_after_mv; 
		PRFloat64 sib_mixed_sib_mv; 
		
		PRFloat64 parent_mv; 

		// These are the boosters
		PRFloat64 node_content_mv;  // this will try to match the child tree structure as well
		PRBool m_content_changed;

		nsIDOMElement* html_node;

		void ComputeTotalMatchValue()
		{
			PRFloat64 value = 0;
			PRUint32 total_weightage = 0;
			if (id_match_mv != -1)
			{
				value += id_match_mv * MW_ID;
				total_weightage += MW_ID;
			}

			if (tag_match_mv != -1)
			{
				value += tag_match_mv * MW_TAG;
				total_weightage += MW_TAG;
			}

			if (tag_attr_mv != -1)
			{
				value += tag_attr_mv * MW_ATTR;
				total_weightage += MW_ATTR;
			}

			if (depth_mv != -1)
			{
				value += depth_mv * MW_DEPTH;
				total_weightage+=MW_DEPTH;
			}

			if (position_mv != -1)
			{
				value += position_mv * MW_POS;
				total_weightage+=MW_POS;
			}
			
			// the above should be deteremined for any match if you have to use this function.
			// the below is optional and we have to check
			if (sib_before_count_mv != -1 && position_mv == 10)
			{
				value += sib_before_count_mv * MW_SIB_BEFORE_CNT;
				total_weightage+=MW_SIB_BEFORE_CNT;
			}

			if (sib_after_count_mv != -1 && position_mv == 10)
			{
				value += sib_after_count_mv * MW_SIB_AFTER_CNT;
				total_weightage+=MW_SIB_AFTER_CNT;
			}

			if (child_count_mv != -1)
			{
				value += child_count_mv * MW_CHILD_COUNT;
				total_weightage+=MW_CHILD_COUNT;
			}

			// if siblings were not found this will be set a positive value
			if (sib_mixed_sib_mv != -1)
			{
				value += sib_mixed_sib_mv * MW_SIB_MIXED;
				total_weightage+=MW_SIB_MIXED;
			}
			else
			{
				if (sib_before_mv != -1)
				{
					value += sib_before_mv * MW_SIB_BEFORE;
					total_weightage+=MW_SIB_BEFORE;
				}
				if (sib_after_mv != -1)
				{
					value += sib_after_mv * MW_SIB_AFTER;
					total_weightage+=MW_SIB_AFTER;
				}
			}

			// if the parent was checked
			if (parent_mv != -1)
			{
				value += parent_mv * MW_PARENT;
				total_weightage+=MW_PARENT;
			}

			// These are the boosters. In case we get a low result from the above, then we can finally
			// check the child tree structure and the content
			if (node_content_mv!= -1)
			{
				value += node_content_mv * MW_CONTENT;
				total_weightage+=MW_CONTENT;
			}

			// set the flag for change in content
			if (node_content_mv != 10)
				m_content_changed = PR_TRUE;
			else
				m_content_changed = PR_FALSE;

			// calc the match value in terms of percentage
			weighted_match_value = (value*10/total_weightage);
			return;
		}
};

#endif