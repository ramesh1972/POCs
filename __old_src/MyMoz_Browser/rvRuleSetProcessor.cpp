// This class processes a single rule set. That is a linked list of related rules that
// eventually get the "Trace Me" me HTML node. The rules are linke by the RuleInfo's m_prev_rule
// pointer.
//
// This class is the main class that handles the passing of processing from one rule to the next
// It also processes the Commands of the Rules

#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvParentWindow.h"
#include "rvRulesDefines.h"
#include "rvRuleProcessor.h"
#include "rvRuleRenderer.h"
#include "rvRuleSetProcessor.h"

extern rvMyMozApp* theApp;
extern rvXmlDocument* _rules_doc;

CRuleSetProcessor::CRuleSetProcessor()
{
}

CRuleSetProcessor::~CRuleSetProcessor()
{
}

// =================================================================
// Entry function: A RuleInfo object with the rule object from db shoudl be set.
// Also the m_prev_rule has also be set, and further for the m_prev_rule's m_prev_rule should be set.
// A complete linked list of related rules has to be set and the starting RuleInfo object to be passed in
nsresult CRuleSetProcessor::ProcessRuleSet(RuleInfo* p_rule_info)
{
	// create the rule processor that will hold the browser window through the entire processing
	m_rule_processor = new CRuleProcessor();

	// Assume there is a prev rule and hence this as an intermediary rule
	RuleInfo* final_rule = ProcessIntermediaryRule(p_rule_info);

	// destroy the browser that was loaded with the original url, clear stuff
	delete m_rule_processor;

	// The trace html document created, users alerted after the above call!!
	return NS_OK;
}

RuleInfo* CRuleSetProcessor::ProcessIntermediaryRule(RuleInfo* p_rule_info)
{
	RuleInfo* prev_processed_rule_info = nsnull;
	RuleInfo* processed_rule_info = nsnull;

	if (p_rule_info == nsnull)
		return nsnull;

	if (p_rule_info->m_prev_rule != nsnull)
	{
		prev_processed_rule_info = ProcessIntermediaryRule(p_rule_info->m_prev_rule);
		if (prev_processed_rule_info == nsnull)
			return nsnull;

		// all post commands are executed for the current rule
		// Post Commands executed could have one of the following effects
		//	1) load a new page, so FinishLoadingDocument will be called again
		//			- So the rule next to this will have to be processed for the new document
		_ILOG(p_rule_info->m_rule_name);
		if (prev_processed_rule_info->m_will_load_new_document) 
		{
			m_rule_processor->WaitForDocumentToLoad();
			m_rule_processor->m_IsCurrentRuleProcessed = PR_FALSE; //reset
			p_rule_info->m_html_document = m_rule_processor->m_html_document;  
		}
		else
		{
			//	2) commands will be executed and so the document will be ready for next rule
			//			- So the rule next to this will have to be processed, but for the same document
			p_rule_info->m_html_document = prev_processed_rule_info->m_html_document; 
		}

		//	3) the final node will be finally.
		//			- So the rule next to this which will be the final one will have to processed, 
		//				on the last loaded document or on a new document, this trace has to be done.
		//			- The above 2 conditions will take care of the this

		// initiate THE MATCING PROCESS!
		processed_rule_info = ProcessRule_Initiator(p_rule_info);
	}
	else 
	{
		// we are at the beginning of the ruleset, i.e. the first doucment to be loaded
		processed_rule_info = ProcessStarterRule(p_rule_info);

		// initiate THE MATCING PROCESS!
		processed_rule_info = ProcessRule_Initiator(processed_rule_info);
	}

	if (processed_rule_info == nsnull)
		return nsnull;

	// TODO: if there are multiple results and the first one did not work, then the next processing has 
	// to be rolled back and re-tried with the next match. 
	// TODO: as of now, no rollback is implemented
	processed_rule_info = ProcessPostCommands(processed_rule_info);
	processed_rule_info->m_rule_executed = PR_TRUE;
	
	// done with the current results
	m_rule_processor->ClearRuleResultsArray(); 

	return processed_rule_info;
}

RuleInfo* CRuleSetProcessor::ProcessStarterRule(RuleInfo* p_rule_info)
{
	_ILOG(p_rule_info->m_rule_name);
	
	// Check if this is a frame.
	nsAutoString url = p_rule_info->m_window_url;
	if (url == MozStr(""))
	{
		// This is not a frame
		// Load the document
		url = p_rule_info->m_url;
	}
	// else, this is a frame, so load the RN_WINDOW_URL

	// get the rule node
	m_rule_processor->LoadDocument(url);
	
	// LoadDocument will create a new browser window and after finishing the document load, it will 
	// call FinishLoadingDocument() which will flag completion of load
	// wait till the current rule is processed
	m_rule_processor->WaitForDocumentToLoad();
	m_rule_processor->m_IsCurrentRuleProcessed = PR_FALSE; //reset

	// ok we have loaded a url and now parse/spot
	// set the html doc member variable
	p_rule_info->m_html_document = m_rule_processor->m_html_document;  

	return p_rule_info;
}

RuleInfo* CRuleSetProcessor::ProcessRule_Initiator(RuleInfo* p_rule_info)
{
	_ILOG(p_rule_info->m_rule_name);

	// if there is nothing to spot, just return
	nsIDOMElement* main_rule_node = m_rule_processor->GetMainRuleNode(p_rule_info->m_rule_root_node);
	if (main_rule_node == nsnull)
		return p_rule_info;

	NS_RELEASE(main_rule_node);

	// TODO: The code prior does not set the root rule node sometimes. ?? Now it is working
  //p_rule_info->m_rule_root_node = _rules_doc->GetChildNodeWithAttributeValue(nsnull, MozStr(RN_NAME), p_rule_info->m_rule_name);

	// Check if this a frame, If yes then get the right html document
	nsAutoString url = p_rule_info->m_window_url;
	if (url != MozStr("")) // This is a frame
	{ 
		nsAutoString frame_url = p_rule_info->m_url;
		nsAutoString frame_location = p_rule_info->m_frame_id;

		m_rule_processor->SetFrameHTMLDocument(frame_url, frame_location);
	}
	else // This is not a frame document
		m_rule_processor->m_html_document = p_rule_info->m_html_document;

	// spot the current node
 	p_rule_info->m_rule_results = m_rule_processor->ProcessRule_Parse(p_rule_info->m_rule_root_node);

	// Remove ref to the rule root node

	// TODO: handling/reporting of multiple results. As of now picking the topmost
	// Going upwards in multiple paths. Which ever returns??
	if (p_rule_info->m_rule_results != nsnull)
	{
		RuleResult* result_node = (RuleResult*) p_rule_info->m_rule_results->ElementAt(0); 
		if (result_node == nsnull || result_node->html_node == nsnull)
		{
			p_rule_info->m_html_document = nsnull;
			return nsnull;
		}

		// TODO: See why this does not work. set the document back to the one that is processed
		//		m_rule_processor->SetProcessedHTMLDoc(result_node->html_node);
		//		p_rule_info->m_html_document = m_rule_processor->m_html_document;
	}
	else
	{
		p_rule_info->m_html_document = nsnull;
		return nsnull;
	}

	return p_rule_info;
}

RuleInfo* CRuleSetProcessor::ProcessPostCommands(RuleInfo* p_rule_info)
{
	// execute the post commands, assume the commands are in order
	RuleInfo* processed_rule_info = p_rule_info;
	PRInt32 num_cmds = p_rule_info->m_cmds->Count();

	// Process PostLoad Events First
	for (PRInt32 idx=0;idx<num_cmds;idx++)
	{
		CommandInfo* cmd = (CommandInfo*) p_rule_info->m_cmds->ElementAt(idx);
		if (cmd->m_exec_type == MozStr("PostLoad"))
		{
			if (cmd->m_cmd.Find(MozStr("Events")) >= 0)
				processed_rule_info = ProcessEventCommand(p_rule_info, cmd);
			else if (cmd->m_cmd == MozStr("Change"))
				processed_rule_info = ProcessChangeCommand(p_rule_info, cmd);
		}
	}

	// Process trace events
	for (idx=0;idx<num_cmds;idx++)
	{
		CommandInfo* cmd = (CommandInfo*) p_rule_info->m_cmds->ElementAt(idx);
		if (cmd->m_exec_type == MozStr("TraceEvent"))
		{
			if (cmd->m_cmd == MozStr("PickMe"))
				processed_rule_info = ProcessTraceMeCommand(processed_rule_info, cmd);
		}
	}

	return processed_rule_info;
}

RuleInfo* CRuleSetProcessor::ProcessEventCommand(RuleInfo* p_rule_info, CommandInfo* cmd)
{
	// This will execute all events
	// Get the html document, element, In case of frames, then the appropriate frame document to be fetched.
	// The frame document should already have been set in rules processor, during initiation
	nsIDOMHTMLDocument* doc = m_rule_processor->m_html_document;
	if (p_rule_info->m_rule_results->Count() < 1)
		return p_rule_info;

	nsIDOMElement* element = ((RuleResult*)(p_rule_info->m_rule_results->ElementAt(0)))->html_node; 
	nsAutoString tag;
	element->GetTagName(tag);

	nsCOMPtr<nsIDOMDocumentEvent> docEvent(do_QueryInterface(doc));
  nsCOMPtr<nsIDOMEvent> event;

	// Events to be dispatched
	if (tag.EqualsIgnoreCase("a") || tag.EqualsIgnoreCase("anchor") || tag.EqualsIgnoreCase("span") || tag.EqualsIgnoreCase("font") || tag.EqualsIgnoreCase("em"))
	{
		docEvent->CreateEvent(cmd->m_cmd, getter_AddRefs(event));
		event->InitEvent(cmd->m_param_name, PR_TRUE, PR_TRUE);
	}
	else if (tag.EqualsIgnoreCase("button"))
	{
		docEvent->CreateEvent(cmd->m_cmd, getter_AddRefs(event));
		event->InitEvent(cmd->m_param_name, PR_TRUE, PR_TRUE);
	}
	else if (tag.EqualsIgnoreCase("input"))
	{
		nsAutoString itype;
		itype = _rules_doc->GetNodeAttributeValue(element, MozStr("type"));

		if (itype.EqualsIgnoreCase("button"))
		{
			docEvent->CreateEvent(cmd->m_cmd, getter_AddRefs(event));
			event->InitEvent(cmd->m_param_name, PR_TRUE, PR_TRUE);
		}
	}

	if (event != nsnull)
	{	
		nsCOMPtr<nsIPrivateDOMEvent> privateEvent(do_QueryInterface(event));
		privateEvent->SetTrusted(PR_TRUE);

		PRBool noDefault;
		nsCOMPtr<nsIDOMEventTarget> targ(do_QueryInterface(element));
		targ->DispatchEvent(event, &noDefault);
		return p_rule_info;
	}

	// These are change events
	if (tag.EqualsIgnoreCase("input"))
	{
		nsAutoString itype;
		itype = _rules_doc->GetNodeAttributeValue(element, MozStr("type"));

		if (itype.EqualsIgnoreCase("text") || itype.EqualsIgnoreCase(""))
		{
			nsCOMPtr<nsIDOMHTMLInputElement> ielement = do_QueryInterface(element);
			ielement->SetValue(cmd->m_param_value);
		}
		else if (itype.EqualsIgnoreCase("checkbox") || itype.EqualsIgnoreCase("radio"))
		{
			nsCOMPtr<nsIDOMHTMLInputElement> ielement = do_QueryInterface(element);
			if (cmd->m_param_name == MozStr("checked"))
				ielement->SetChecked(PR_TRUE);
			else
				ielement->SetChecked(PR_FALSE);
		}
	}
	else if (tag.EqualsIgnoreCase("textarea"))
	{
		nsCOMPtr<nsIDOMHTMLTextAreaElement> telement = do_QueryInterface(element);
		telement->SetDefaultValue(cmd->m_param_value);
	}
	else if (tag.EqualsIgnoreCase("select"))
	{
		nsCOMPtr<nsIDOMHTMLOptionsCollection> col;
		nsCOMPtr<nsIDOMHTMLSelectElement> selement = do_QueryInterface(element);
		selement->GetOptions(getter_AddRefs(col));

		PRUint32 len = 0;col->GetLength(&len);
		for (PRInt32 idx=0;idx < len;idx++)
		{
			nsCOMPtr<nsIDOMHTMLOptionElement> opt = nsnull;
			col->Item(idx, (nsIDOMNode**) &opt);
			
			nsAutoString idxstr;
			idxstr.Append(MozStr(","));
			idxstr.AppendInt(idx);
			idxstr.Append(MozStr(","));

			opt->SetDefaultSelected(PR_FALSE);
			if (cmd->m_param_value.Find(idxstr) != -1)
				opt->SetDefaultSelected(PR_TRUE);
		}
	}
	else if (tag.EqualsIgnoreCase("form"))
	{
		nsCOMPtr<nsIDOMHTMLFormElement> felement = do_QueryInterface(element);
		if (cmd->m_param_name.EqualsIgnoreCase("submit"))
			felement->Submit();
		else if (cmd->m_param_name.EqualsIgnoreCase("reset"))
			felement->Reset();
	}	

	return p_rule_info;
}

RuleInfo* CRuleSetProcessor::ProcessChangeCommand(RuleInfo* p_rule_info, CommandInfo* cmd)
{
	// This will execute all change events, liek text box value change, checkbox change, 
	// drop down selections etc..

	// Get the html document, element
	// NO REQUIREMENT SO FAR
	nsIDOMHTMLDocument* doc = p_rule_info->m_html_document; 
	nsIDOMElement* element = ((RuleResult*)(p_rule_info->m_rule_results->ElementAt(0)))->html_node; 

	return p_rule_info;
}

RuleInfo* CRuleSetProcessor::ProcessTraceMeCommand(RuleInfo* p_rule_info, CommandInfo* cmd)
{
	// This will execute all change events, liek text box value change, checkbox change, 
	// drop down selections etc..

	// Get the html document, element
	nsIDOMHTMLDocument* doc = p_rule_info->m_html_document; 
	RuleResult* result = (RuleResult*) p_rule_info->m_rule_results->ElementAt(0); 

	if (result == nsnull || result->html_node == nsnull)
		return nsnull;

	// Create a Renderer , create the html document with the Trace Node and return!!
	CRuleRenderer* renderer = new CRuleRenderer();
	renderer->m_rule_name = p_rule_info->m_rule_name;
	renderer->m_url = p_rule_info->m_url;
	renderer->m_html_document = p_rule_info->m_html_document;
	renderer->ProcessPickMeCommand(result->html_node, p_rule_info->m_rule_root_node, result->m_content_changed);
	return p_rule_info;
}

