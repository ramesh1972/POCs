// This class processes a single rule set. That is a linked list of related rules that
// eventually get the "Trace Me" me HTML node. The rules are linke by the RuleInfo's m_prev_rule
// pointer.
//
// This class is the main class that handles the passing of processing from one rule to the next
// It also processes the Commands of the Rules

#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvMainWindow.h"
#include "rvParentWindow.h"
#include "rvRulesDefines.h"
#include "rvRuleProcessor.h"
#include "rvRuleRenderer.h"
#include "rvHTMLElement.h"
#include "rvRuleSetProcessor.h"

// externs
IAPPG;
IRULESG;

extern rvXmlDocument* _rules_doc;

CRuleSetProcessor::CRuleSetProcessor()
{
	ILOG << "CRuleSetProcessor::CRuleSetProcessor()" << IINF;
}

CRuleSetProcessor::~CRuleSetProcessor()
{
	ILOG << "CRuleSetProcessor::~CRuleSetProcessor()" << IINF;
}

// =================================================================
// Entry function: A RuleInfo object with the rule object from db shoudl be set.
// Also the m_prev_rule has also be set, and further for the m_prev_rule's m_prev_rule should be set.
// A complete linked list of related rules has to be set and the starting RuleInfo object to be passed in
II_RESULT CRuleSetProcessor::ProcessRuleSet(RuleInfo *&p_rule_info)
{
	try
	{
		ILOG << "CRuleSetProcessor::ProcessRuleSet()" << IINF;
		IL_TAB;

		// create the rule processor that will hold the browser window through the entire processing
		m_rule_processor = new CRuleProcessor();

		// Assume there is a prev rule and hence this as an intermediary rule
		II_RESULT res = IIR_FAILED;
		ILOG << "------------------------------------------------------------" << IINF;
		ILOG << "About to Process Rule Set With Rule Name : " << p_rule_info->m_rule_name << IINF; 
		res = ProcessIntermediaryRule(p_rule_info);
		ILOG << "Completed Processing RuleSet With Rule Name : " << p_rule_info->m_rule_name << IINF; 

		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed trying to Process RuleSet" << IFTL;
			ILOG << IMSG(res) << IFTL;
		}
		ILOG << "------------------------------------------------------------" << IINF;

		// destroy the browser that was loaded with the original url, clear stuff
		delete m_rule_processor;

		// The trace html document created, users alerted after the above call!!
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in CRuleSetProcessor::ProcessRuleSet()" << IEXC;
		ILOG << "Aborting RuleSet Processing" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT CRuleSetProcessor::ProcessIntermediaryRule(RuleInfo *&p_rule_info)
{
	ILOG << "CRuleSetProcessor::ProcessIntermediaryRule()" << IINF;
	IL_TAB;
	
	if (p_rule_info == nsnull)
	{
		IL_UNTAB;
		ILOG << "Fatal: Null rule pointer passed in" << IFTL;
		return IIR_RULE_RESULT_NULL;
	}

	II_RESULT init_res = IIR_FAILED;
	if (p_rule_info->m_prev_rule != nsnull)
	{
		II_RESULT pr_res = ProcessIntermediaryRule(p_rule_info->m_prev_rule);
		if (pr_res != IIR_SUCCESS)
		{
			if ((pr_res == IIR_FAILED_POPUP_WINDOW || p_rule_info->m_prev_rule->m_window_type == MozStr("IIW_WWW_Popup")) && p_rule_info->m_window_type != MozStr("IIW_WWW_Popup"))
			{
				ILOG << "Processing on Popup failed. Ignoring popup rule and continuing" << IERR;
				pr_res = IIR_SUCCESS;
			}
			else
			{
				ILOG << "Aborting this path of rule processing" << IERR;
				IL_UNTAB;
				return pr_res;
			}
		}
		
		// the main check to proceed further
		ILOG << "------------------------------------------------------" << IINF;
		ILOG << "Start Processing Rule:" << p_rule_info->m_rule_name << IINF;
		ILOG << "Start Processing URL:" << p_rule_info->m_url << IINF;

		// 1) check if this is a popup, if yes get the popup browser (based on the referer)
		// need to wait on it.
		IL_TAB;
		ILOG << "rule window type: " << p_rule_info->m_window_type << IINF;
		
		// get the handle to the browser
		rvMainWindow* bw_target = nsnull;
		if (p_rule_info->m_window_type == MozStr("IIW_WWW_Popup"))
		{
			ILOG << "Current rule needs to be processed on a Popup window" << IINF;

			// TODO, to get popup based on url, position(order in which it was loaded initially)
			ILOG << "Fetching Popup window" << IINF;
			
			ON_THE_RUN(IIR_APP_EXITED)
			bw_target = IPWW->GetPopupBrowserWindow(m_rule_processor->mInternalBrowser, MozStr(""), 0);
			if (bw_target == nsnull)
			{
				IL_UNTAB;IL_UNTAB;
				ILOG << "Failed to get Popup window. Must have been closed/shutdown automatically" << IERR;
				return IIR_FAILED_POPUP_WINDOW; // the browser was destroyed. 
			}

			ILOG << "Successfully found Popup window" << IINF;
		}
		else if (p_rule_info->m_window_type == MozStr("IIW_WWW"))
		{
			ILOG << "Current rule needs to be processed on the internal window" << IINF;
			ILOG << "Fetching main window" << IINF;
			bw_target = m_rule_processor->mInternalBrowser;
			if (bw_target == nsnull)
			{
				IL_UNTAB;IL_UNTAB;
				ILOG << "Failed to get main window. Must have been closed/shutdown automatically" << IFTL;
				return IIR_FAILED_MAIN_WINDOW; // the browser was destroyed. 
			}

			ILOG << "Successfully found main window" << IINF;
		}
		else
		{
			ILOG << "Unsupported window type for rule processing. Only main/www/mainpopup supported" << IFTL;
			IL_UNTAB;IL_UNTAB;
			return IIR_WINDOW_TYPE_UNKNOWN;
		}

		// keep a handle on the browser till the document is got
		NS_ADDREF(bw_target);

		ILOG << "rule document load type: " << p_rule_info->m_document_load_type << IINF;

		// get the document to process based on the document load type
		if (p_rule_info->m_document_load_type == MozStr("new"))
		{
			// check if it was loaded
			ILOG << "Waiting to get the windows html document" << IINF;
			II_RESULT wait_result = bw_target->WaitForDocumentToLoad();
			if (wait_result == IIR_TIMED_OUT)
			{
				ILOG << "document did not load, timed out" << IFTL;
				IL_UNTAB;IL_UNTAB;
				NS_RELEASE(bw_target);
				return IIR_TIMED_OUT; // assuming popups are not important TODO: later check the following rules to see if this popup window is important or not
			}
			else if (wait_result == IIR_FAILED)
			{
				ILOG << "Failed waiting for the document to load" << IFTL;
				IL_UNTAB;IL_UNTAB;
				NS_RELEASE(bw_target);
				return IIR_FAILED_WAIT; // assuming popups are not important TODO: later check the following rules to see if this popup window is important or not
			}
		
			ILOG << "Successfully returned from wait" << IINF;
			bw_target->mDocIsLoaded = PR_FALSE; //reset
		}
		else if (p_rule_info->m_document_load_type == MozStr("reuse")) //#
		{
			ILOG << "Will reuse previously processed document" << IINF;
		}
		else //#
		{
			ILOG << "Fatal: Unknown document load type" << IFTL;
			p_rule_info->m_html_document = nsnull;
			IL_UNTAB;IL_UNTAB;
			NS_RELEASE(bw_target);
			return IIR_RULE_UNKNOWN_LOAD_TYPE;
		}

		// fetch the document, this could be a frame
		// Check if this a frame, If yes then get the right html document
		nsAutoString url = p_rule_info->m_window_url;
		if (url != MozStr("")) // This is a frame
		{ 
			nsAutoString frame_url = p_rule_info->m_url;
			nsAutoString frame_location = p_rule_info->m_frame_id;
			
			ILOG << "This is a frame." << "frame_url=" << frame_url << ",frame_location=" << frame_location << IINF;
			ILOG << "Getting the Frame html document" << IINF;
		
			p_rule_info->m_html_document = rvHTMLElement::GetFrameHTMLDocument(&bw_target->m_root_frame, frame_url, frame_location);
			if (p_rule_info->m_html_document == nsnull)
			{
				IL_UNTAB;IL_UNTAB;
				ILOG << "Failed to get windows document." << IFTL;
				NS_RELEASE(bw_target);
				return IIR_FAILED_GET_FRAME_DOCUMENT; // assuming popups are not important TODO: later check the following rules to see if this popup window is important or not
			}

			ILOG << "Got document!" << IINF;
		}
		else // Not a frame
		{
			ILOG << "This is not a frame." << IINF;
			nsIDOMHTMLDocument* doc;
			bw_target->GetDocument(doc);
			if (doc == nsnull)
			{
				IL_UNTAB;IL_UNTAB;
				ILOG << "Failed to get windows document." << IFTL;
				NS_RELEASE(bw_target);
				return IIR_FAILED_GET_DOCUMENT; // assuming popups are not important TODO: later check the following rules to see if this popup window is important or not
			}

			ILOG << "Got document!" << IINF;
			p_rule_info->m_html_document = doc;  
			NS_RELEASE(doc);
		}

		// do any post result processing/pre next rule initiation
		// Hide all rule windows, just in case if there are any visible
		ON_THE_RUN(IIR_APP_EXITED)
		IPWW->Layout(0,0);

		// done using the browser, release handle
		NS_RELEASE(bw_target);
		IL_UNTAB;

		// initiate THE MATCING PROCESS!
		ILOG << "About to initiate Rule Parsing" << IINF;
		init_res = ProcessRule_Initiator(p_rule_info);
	}
	else 
	{
		// we are at the beginning of the ruleset, i.e. the first doucment to be loaded
		ILOG << "About to start processing ruleset" << IINF;

		// Log Rule Name
		ILOG << "------------------------------------------------------" << IINF;
		ILOG << "Start Processing Rule:" << p_rule_info->m_rule_name << IINF;
		ILOG << "Start Processing URL:" << p_rule_info->m_url << IINF;

		II_RESULT start_res = ProcessStarterRule(p_rule_info);
		if (start_res != IIR_SUCCESS)
		{
			ILOG << "Failed to load the starter document" << IFTL;
			IL_UNTAB;
			return start_res; // abort
		}

		// initiate THE MATCING PROCESS!
		ILOG << "About to initiate Rule Parsing" << IINF;
		init_res = ProcessRule_Initiator(p_rule_info);
	}

	// just a document loader rule
	if (init_res == IIR_RULE_NOTHING_TO_PROCESS)
	{
		IL_UNTAB;
		return IIR_SUCCESS;
	}	

	// oops. failed while parsing
	if (init_res != IIR_SUCCESS)
	{
		ILOG << "Failed initiating the rule processing for rule:" << p_rule_info->m_rule_name << IFTL;
		IL_UNTAB;
		return init_res;
	}

	ILOG << "Successfully completed rule processing" << IINF;

	// passed through rule parsing successfully. check the results
	ILOG << "-------------------------------------------------" << IINF;
	ILOG << "Handling Parse Results" << IINF;
	if (p_rule_info->m_rule_results != nsnull)
	{
		PRInt32 count = p_rule_info->m_rule_results->Count();
		ILOG << "Returned Result Count:" << count << IINF;

		if (count == 1)
		{
			ILOG << "Found single result" << IINF;

			RuleResult* result_node = (RuleResult*) p_rule_info->m_rule_results->ElementAt(0); 
			ILOG << "Found Single Result with match value: " << result_node->weighted_match_value << IINF;
			if (result_node->html_node == nsnull)
			{
				ILOG << "Could not get the html node(null) from result" << IERR;
				m_rule_processor->ClearRuleResultsArray(); 
				p_rule_info->m_html_document = nsnull;
				ILOG << "Done handling Parse results" << IINF;
				ILOG << "---------------------------------------------------------"<< IINF;
				IL_UNTAB;
				return IIR_RULE_RESULT_NULL; // abort
			}
	
			ILOG << "Match Value:" << result_node->weighted_match_value << IINF;
			ILOG << "Processing Post Commands" << IINF;
			II_RESULT cmd_res = ProcessPostCommands(p_rule_info);

			if (cmd_res != IIR_SUCCESS)
			{
				ILOG << "Failed to process post commands" << IFTL;
				m_rule_processor->ClearRuleResultsArray(); 
				ILOG << "Done handling Parse results" << IINF;
				ILOG << "---------------------------------------------------------"<< IINF;
				IL_UNTAB;
				return cmd_res;
			}

			m_rule_processor->ClearRuleResultsArray(); 
			ILOG << "Successfully Processed post commands" << IINF;
			ILOG << "Done handling Parse results" << IINF;
			ILOG << "---------------------------------------------------------"<< IINF;

			IL_UNTAB;
			return IIR_SUCCESS;
		}
		else if (count >= 1)
		{
			ILOG << "---------------------------------------------------------"<< IINF;
			ILOG << "Process Multiple results (picking the first good one and reporting others(as of current implementation)" << IINF;

			// *** IMPORTANT :Always going with the first rule, but logging the fact that 
			// there were multiple results for later inquiry: 
			PRBool processed = PR_FALSE;
			II_RESULT cmd_res;
			for (PRInt32 idx=0;idx<count;idx++)
			{
				RuleResult *result = (RuleResult*) p_rule_info->m_rule_results->ElementAt(idx);
				ILOG << "Multiple Result:" << idx << IINF;

				// IMPORTANT: Going with the first result that has a traced HTML Node
				if (result->html_node != nsnull)
				{
					ILOG << "Match Value:" << result->weighted_match_value << IINF;

					if (processed == PR_FALSE)
					{
						ILOG << "About to process Post Commands" << IINF;

						cmd_res = ProcessPostCommands(p_rule_info);
						if (cmd_res != IIR_SUCCESS) // continue with next result
						{
							// TODO: NEED TO ROLLBACK (NOW) THE CURRENT POSTS. THAT IS GO BACK TO THE PREVISOU RULE and START again
							// THIS WILL INVOLE RECREATING THE HTML DOCUMENT, BASE URI in the InternalBrowser and setting will_load_document to false
							ILOG << "Failed to process post commands for this result" << IFTL;
							ILOG << "Trying with the next result" << IINF;
							continue;
						}
						else
						{
							processed = PR_TRUE;
							ILOG << "Successfully processed post commands for this result" << IFTL;
						}

						// TODO: POSSIBLY NEED TO ROLLBACK (LATER) if the path down the processing aborts. 
						// THAT IS TO GO BACK TO THE PREVISOU RULE and START again later
						// all the rule chain in the current path is processed.
						// THIS WILL INVOLE storing the current rule in unprocessed state and the html result index that has to be next processed.
						// THEN LATER RECREATING THE HTML DOCUMENT, BASE URI in the InternalBrowser and setting will_load_document to false and calling
						// ProcessIntermediaryRule again from the root function(ProcessRuleSet) with this rule info.
					}
				}
				else
				{
					ILOG << "Empty result: Ignoring" << IERR; // continue with next result
				}
			}

			// done with the current results
			m_rule_processor->ClearRuleResultsArray(); 
			ILOG << "Done handling Parse mutliple results" << IINF;
			ILOG << "---------------------------------------------------------"<< IINF;
			IL_UNTAB;
			return cmd_res;
		}
		else
		{
			ILOG << "Invalid number of results returned" << IERR;
			p_rule_info->m_html_document = nsnull;
			m_rule_processor->ClearRuleResultsArray(); 
			IL_UNTAB;
			ILOG << "Done handling Parse results" << IINF;
			ILOG << "---------------------------------------------------------"<< IINF;

			return IIR_RULE_RESULT_INVALID; // abort
		}
	}
	else
	{
		ILOG << "No Results returned" << IERR;
		p_rule_info->m_html_document = nsnull;
		m_rule_processor->ClearRuleResultsArray(); 
		IL_UNTAB;
		ILOG << "Done handling Parse results" << IINF;
		ILOG << "---------------------------------------------------------"<< IINF;

		return IIR_RULE_RESULT_NULL; // abort
	}

	IL_UNTAB;
	return IIR_UNKNOWN;
}

II_RESULT CRuleSetProcessor::ProcessStarterRule(RuleInfo* &p_rule_info)
{
	ILOG << "CRuleSetProcessor::ProcessStarterRule() " << IINF;
	IL_TAB;

	// Check if this is a frame.
	nsAutoString url = p_rule_info->m_window_url;
	if (url == MozStr("")) // This is not a frame
	{
		ILOG << "Processing a document without frames" << IINF;
		url = p_rule_info->m_url;
	}
	else  // else, this is a frame, so load the RN_WINDOW_URL
		ILOG << "Processing a document with frames" << IINF;

	// start the action relaying!
	ILOG << "Unleash the action relaying!" << IINF;
	ILOG << "About to load document from url" << url << IINF;

	// LoadDocument will create a new browser window, load the url and wait until document is complete
	// It will also timeout if the document load does not happen within the timeout period (2 minutes)
	II_RESULT res = m_rule_processor->LoadDocument(url);
	if (res != IIR_SUCCESS)
	{
		if (res == IIR_TIMED_OUT)
			ILOG << "Document did not load, timed out" << IFTL;
		else if (res == IIR_FAILED)
			ILOG << "Failed waiting for document to load" << IFTL;
		else
			ILOG << "Failed loading document" << IFTL;

		ILOG << "Aborting this rule" << IFTL;
		IL_UNTAB;
		return res;
	}
	
	ILOG << "Successfully Started Rule Processing" << IINF;
	IL_UNTAB;
	return IIR_SUCCESS;
}

II_RESULT CRuleSetProcessor::ProcessRule_Initiator(RuleInfo *&p_rule_info)
{
	ILOG << "CRuleSetProcessor::ProcessRule_Initiator() " << IINF;
	IL_TAB;

	// if there is nothing to spot, just return
	nsIDOMElement* main_rule_node = m_rule_processor->GetMainRuleNode(p_rule_info->m_rule_root_node);
	if (main_rule_node == nsnull)
	{
		ILOG << "Nothing to Process. Just a document loader rule" << IINF;
		IL_UNTAB;
		return IIR_RULE_NOTHING_TO_PROCESS;
	}

	NS_RELEASE(main_rule_node);

	ILOG << "Found a rule to process" << IINF;
	ILOG << "Setting up the html document on the rule processor" << IINF;
	m_rule_processor->m_html_document = p_rule_info->m_html_document;

	// spot the current node
	ILOG << "-------------------------------------------------" << IINF;
	ILOG << "Calling ProcessRule_Parse.." <<IINF;
 	p_rule_info->m_rule_results = m_rule_processor->ProcessRule_Parse(p_rule_info->m_rule_root_node);
	ILOG << "Finished ProcessRule_Parse" <<IINF;
	ILOG << "-------------------------------------------------" << IINF;
	
	// TODO: handling/reporting of multiple results. As of now picking the topmost
	// Going upwards in multiple paths. Which ever returns??
	IL_UNTAB;
	return IIR_SUCCESS;
}

II_RESULT CRuleSetProcessor::ProcessPostCommands(RuleInfo *&p_rule_info)
{
	ILOG << "CRuleSetProcessor::ProcessPostCommands() " << IINF;
	IL_TAB;

	// execute the post commands, assume the commands are in order
	PRInt32 num_cmds = p_rule_info->m_cmds->Count();
	ILOG << "Number of Commands to execute: " << num_cmds << IINF;

	// Process PostLoad Events First
	II_RESULT postload_res = IIR_FAILED;
	for (PRInt32 idx=0;idx<num_cmds;idx++)
	{
		CommandInfo* cmd = (CommandInfo*) p_rule_info->m_cmds->ElementAt(idx);
		ILOG << "Processing Command" << IINF;
		IL_TAB;
		ILOG << "exec_type   =" << cmd->m_exec_type << IINF;
		ILOG << "cmd         =" << cmd->m_cmd << IINF;
		ILOG << "param_name  =" << cmd->m_param_name << IINF;
		ILOG << "param_value =" << cmd->m_param_value << IINF;
		IL_UNTAB;

		if (cmd->m_exec_type == MozStr("PostLoad"))
		{
			if (cmd->m_cmd.Find(MozStr("Events")) >= 0)
				postload_res = ProcessEventCommand(p_rule_info, cmd);
			else if (cmd->m_cmd == MozStr("Change"))
				postload_res = ProcessChangeCommand(p_rule_info, cmd);
		}
	}

	// Process trace events
	II_RESULT trace_event = IIR_FAILED;
	for (idx=0;idx<num_cmds;idx++)
	{
		CommandInfo* cmd = (CommandInfo*) p_rule_info->m_cmds->ElementAt(idx);
		if (cmd->m_exec_type == MozStr("TraceEvent"))
		{
			if (cmd->m_cmd == MozStr("PickMe"))
				trace_event = ProcessTraceMeCommand(p_rule_info, cmd);
		}
	}

	IL_UNTAB;
	return IIR_SUCCESS;
}

II_RESULT CRuleSetProcessor::ProcessEventCommand(RuleInfo *&p_rule_info, CommandInfo* cmd)
{
	ILOG << "CRuleSetProcessor::ProcessEventCommand() " << IINF;
	IL_TAB;

	// This will execute all events
	// Get the html document, element, In case of frames, then the appropriate frame document to be fetched.
	// The frame document should already have been set in rules processor, during initiation
	//# nsIDOMHTMLDocument* doc = m_rule_processor->m_html_document;
	II_RESULT res = IIR_FAILED;

	nsIDOMHTMLDocument* doc = p_rule_info->m_html_document;
	if (doc == nsnull)
	{
		ILOG << "Failed to Process Event: html_document null" << IERR;
		IL_UNTAB;
		return IIR_RULE_RESULT_NULL;
	}

	if (p_rule_info == nsnull || p_rule_info->m_rule_results == nsnull || p_rule_info->m_rule_results->Count() < 1)
	{
		ILOG << "Failed to Process Event" << IERR;
		IL_UNTAB;
		return IIR_RULE_RESULT_NONE;
	}

	nsIDOMElement* element = ((RuleResult*)(p_rule_info->m_rule_results->ElementAt(0)))->html_node; 
	if (element == nsnull)
	{
		ILOG << "Failed to Process Event: Null result->html_node" << IERR;
		IL_UNTAB;
		return IIR_RULE_RESULT_NULL;
	}
	
	nsAutoString tag;
	element->GetTagName(tag);
	ILOG << "Processing event on element:" << tag << IINF;

	nsCOMPtr<nsIDOMDocumentEvent> docEvent(do_QueryInterface(doc));
	if (docEvent == nsnull)
	{
		ILOG << "Failed to create inerface:" << "nsIDOMDocumentEvent" << IERR;
		IL_UNTAB;
		return IIR_FAILED_EVENT;
	}

  nsCOMPtr<nsIDOMEvent> event;

	// Events to be dispatched
	II_HTMLNodeType nt = rvHTMLElement::GetNodeType(element);
	rvXmlDocument::DumpNodeDeep(element);
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
	else if (nt == IIN_InputButton)
	{
		docEvent->CreateEvent(cmd->m_cmd, getter_AddRefs(event));
		event->InitEvent(cmd->m_param_name, PR_TRUE, PR_TRUE);
	}

	if (event != nsnull)
	{	
		nsCOMPtr<nsIPrivateDOMEvent> privateEvent(do_QueryInterface(event));
		privateEvent->SetTrusted(PR_TRUE);

		PRBool noDefault;
		nsCOMPtr<nsIDOMEventTarget> targ(do_QueryInterface(element));
		targ->DispatchEvent(event, &noDefault);

		nsAutoString etype;
		event->GetType(etype);
		
		ILOG << "Processed mouse/key event:" << etype << IINF;
		IL_UNTAB;

		return IIR_SUCCESS;
	}

	// These are change events
	if (nt == IIN_InputText)
	{
		res = rvHTMLElement::SetInputElementValue(element, cmd->m_param_value);
		ILOG << "Processed text event:" << tag << IINF;
	}
	else if (nt == IIN_InputCheckBox || nt == IIN_InputRadio)
	{
		if (cmd->m_param_name == MozStr("checked"))
			res = rvHTMLElement::SetInputElementChecked(element, 1);
		else
			res = rvHTMLElement::SetInputElementChecked(element, 0);

		ILOG << "Processed input checkbox/radio event:" << tag << IINF;
	}
	else if (nt == IIN_TextArea)
	{
		res = rvHTMLElement::SetTextAreaElementValue(element, cmd->m_param_value); 
		ILOG << "Processed textarea event:" << tag << IINF;
	}
	else if (tag.EqualsIgnoreCase("select"))
	{
		res = rvHTMLElement::SetSelectElementSelectedIndices(element, cmd->m_param_value); 
		ILOG << "Processed select/combo event:" << tag << IINF;
	}
	else if (tag.EqualsIgnoreCase("form"))
	{
		if (cmd->m_param_name.EqualsIgnoreCase("submit"))
			res = rvHTMLElement::SubmitForm(element);
		else if (cmd->m_param_name.EqualsIgnoreCase("reset"))
			res = rvHTMLElement::ResetForm(element);

		ILOG << "Processed form event:" << tag << IINF;
	}	

	II_ENSURE_NS_RESULT(res)

	IL_UNTAB;
	return IIR_SUCCESS;
}

II_RESULT CRuleSetProcessor::ProcessChangeCommand(RuleInfo* &p_rule_info, CommandInfo* cmd)
{
	ILOG << "CRuleSetProcessor::ProcessChangeCommand() " << IINF;
	IL_TAB;

	// This will execute all change events, like text box value change, checkbox change, 
	// drop down selections etc..

	// Get the html document, element
	// NO REQUIREMENT SO FAR
	nsIDOMHTMLDocument* doc = p_rule_info->m_html_document; 
	nsIDOMElement* element = ((RuleResult*)(p_rule_info->m_rule_results->ElementAt(0)))->html_node; 

	IL_UNTAB;
	return IIR_SUCCESS;
}

II_RESULT CRuleSetProcessor::ProcessTraceMeCommand(RuleInfo *&p_rule_info, CommandInfo* cmd)
{
	ILOG << "CRuleSetProcessor::ProcessTraceMeCommand() " << IINF;
	IL_TAB;

	// This will execute all change events, liek text box value change, checkbox change, 
	// drop down selections etc..

	// Get the html document, element
	PRInt32 cnt = p_rule_info->m_rule_results->Count();
	if (cnt <= 0)
	{
		ILOG << "No Results Passed In" << IFTL;
		IL_UNTAB;
		return IIR_RULE_RESULT_NULL;
	}

	RuleResult* result = (RuleResult*) p_rule_info->m_rule_results->ElementAt(0); 
	if (result == nsnull || result->html_node == nsnull)
	{
		ILOG << "Null Result or null match passed in " << IFTL;
		IL_UNTAB;
		return IIR_RULE_RESULT_NULL;
	}

	// Create a Renderer , create the html document with the Trace Node and return!!
	CRuleRenderer* renderer = new CRuleRenderer();
	renderer->m_rule_name = p_rule_info->m_rule_name;
	IL_TAB;
		ILOG << "About to render rule " << p_rule_info->m_rule_name << IINF;
		ILOG << "Document original URL " << p_rule_info->m_url << IINF;
		ILOG << "Document Structure:" << IINF;
		_rules_doc->DumpNodeDeep(result->html_node);
	IL_UNTAB;

	renderer->m_url = p_rule_info->m_url;
	renderer->m_html_document = p_rule_info->m_html_document;

	ILOG << "---------------------------------------------------------------------" << IINF;
	ILOG << "About to Render PageLet" << IINF;
	renderer->ProcessPickMeCommand(result->html_node, p_rule_info->m_rule_root_node, result->m_content_changed);

	ILOG << "Rendered PageLet" << IINF;
	ILOG << "---------------------------------------------------------------------" << IINF;

	IL_UNTAB;
	return IIR_SUCCESS;
}

