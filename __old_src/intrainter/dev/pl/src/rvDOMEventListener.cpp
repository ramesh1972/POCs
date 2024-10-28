#include "rvRulesCollection.h"
#include "rvRuleCreator.h"
#include "rvMainWindow.h"
#include "rvParentWindow.h"
#include "rvHTMLElement.h"
#include "rvDOMEventListener.h"

// externs
IAPPG;

NS_IMPL_THREADSAFE_ISUPPORTS4(rvDOMEventListener, nsIDOMMouseListener, nsIDOMKeyListener, nsIDOMLoadListener, nsIDOMFormListener);

rvDOMEventListener::rvDOMEventListener()
{
	ILOG << "rvDOMEventListener::rvDOMEventListener()" << IINF;

	mBrowserToListen = nsnull;
	m_prev_rule_info = nsnull;
	m_pick_me_processed = PR_FALSE;

	m_creator = new CRuleCreator();

	time_t t1;
	time(&t1);
	tm *t = localtime(&t1);

	srand(t->tm_min*60+t->tm_sec);
}

rvDOMEventListener::~rvDOMEventListener()
{
	try
	{
		ILOG << "rvDOMEventListener::~rvDOMEventListener()" << IINF;
		IL_TAB;

		mBrowserToListen = nsnull;
		
		DestroyRuleInfo(m_prev_rule_info);
		m_prev_rule_info = nsnull;

		m_pick_me_processed = PR_FALSE;

		if (m_creator != nsnull) 
		{
			ILOG << "About to Flush rules to DB" << IINF;
			m_creator->SaveRules();
			delete m_creator;
			m_creator = nsnull;
			ILOG << "Destroyed Rules creator" << IINF;
		}
		else
			ILOG << "Rules creator already destroyed" << IINF;

		ILOG << "Destruction Complete" << IINF;
		IL_UNTAB;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvDOMEventListener::rvDOMEventListener()" << IEXC;
		IL_UNTAB;
	}
}

II_RESULT rvDOMEventListener::AddListeners(rvMainWindow* p_win)
{
	ILOG << "rvDOMEventListener::AddListeners()" << IINF;
	IL_TAB;

	if (p_win == nsnull)
	{
		ILOG << "Null Browser passed in. Pass in the handle to the browser or the referer browser in case of Popups"<< IFTL;
		ILOG << "No DOM EventLIsteners are set. action Tracking will not work" << IFTL;
		IL_UNTAB;
		return IIR_NULL_BROWSER_INSTANCE;
	}

	if (p_win->mSubWinType  != IIW_WWW && p_win->mSubWinType != IIW_WWW_Popup)
	{
		ILOG << "Only WWW or WWW_Popup windows are to be initialized with DOM Event listeners: The current window type is:" << p_win->mSubWinType << IFTL;
		ILOG << "No DOM EventLIsteners are set. action Tracking will not work" << IFTL;
		IL_UNTAB;
		return IIR_INVALID_BROWSER_TYPE;
	}	

	ILOG << "About to set Mouse, Key, Form and Load event listeners..." << IINF;
	ILOG << "Window Type:" << p_win->mSubWinType << IINF;

	if (p_win->mSubWinType == IIW_WWW)
		mBrowserToListen = p_win;

	ILOG << "About to create Document Load Rule..." << IINF;
	HandleCommand_DocumentLoadComplete(p_win);

	// add for the topmost document
	II_RESULT list_res = AddListenerInternal(p_win->m_root_frame.m_doc);

	// add listeners for the frames/subdocuments
	list_res = RecurseAddListenersForFrames(&p_win->m_root_frame);
	
	ILOG << "Added DOM Event Listeners" << IINF;
	IL_UNTAB;

	return IIR_SUCCESS;
}

II_RESULT rvDOMEventListener::AddListenerInternal(nsIDOMHTMLDocument* p_doc)
{
	IL_TAB;

	try
	{
		if (p_doc == nsnull)
		{
			ILOG << "Got Null browser instance. Cannot set listeners" << IFTL;
			IL_UNTAB;
			return IIR_NULL_DOCUMENT;
		}

		ILOG << "Setting Event Listeners on the Body" << IINF;

		nsIDOMEventReceiver * receiver;
		nsIDOMHTMLElement* body;
		nsresult rv = p_doc->GetBody(&body);

		if (body == nsnull)
		{
			ILOG << "Got Null HTML Body instance. Cannot set listeners:rv:" << rv << IFTL;
			IL_UNTAB;
			return IIR_NULL_POINTER;
		}

		rv = p_doc->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver);

		if (rv ==  NS_OK)
		{
			nsIEventListenerManager* mgr;
			rv = receiver->GetListenerManager(&mgr);
			if (rv != NS_OK)
			{
				ILOG << "Could not get event manager. Cannot set listeners:rv:" << rv << IFTL;
				IL_UNTAB;
				NS_RELEASE(receiver);
				NS_RELEASE(body);
				return IIR_NULL_INSTANCE;
			}

			nsIDOMMouseListener* mlist;
			QueryInterface(kIDOMMouseListenerIID, (void**) &mlist);
			mgr->AddEventListenerByIID(mlist, kIDOMMouseListenerIID,NS_EVENT_FLAG_CAPTURE);
			NS_RELEASE(mlist);

			nsIDOMKeyListener* klist;
			QueryInterface(kIDOMKeyListenerIID, (void**) &klist);
			mgr->AddEventListenerByIID(klist, kIDOMKeyListenerIID,NS_EVENT_FLAG_CAPTURE);
			NS_RELEASE(klist);

			nsIDOMFormListener* flist;
			QueryInterface(kIDOMFormListenerIID, (void**) &flist);
			mgr->AddEventListenerByIID(flist, kIDOMFormListenerIID,NS_EVENT_FLAG_CAPTURE);
			NS_RELEASE(flist);

			nsIDOMLoadListener* llist;
			QueryInterface(kIDOMLoadListenerIID, (void**) &llist);
			mgr->AddEventListenerByIID(llist, kIDOMLoadListenerIID,NS_EVENT_FLAG_CAPTURE);
			NS_RELEASE(llist);

			NS_RELEASE(mgr);
			NS_RELEASE(receiver);
			NS_RELEASE(body);

			ILOG << "Successfully added DOM Event listeners on the HTML Body Element" << IINF;
			IL_UNTAB;
			return IIR_SUCCESS;
		}
		else
		{
			ILOG << "Could not get event receiver. Cannot set listeners:rv:" << rv << IFTL;
			IL_UNTAB;
			return IIR_NULL_INTERFACE;
		}

	}
	catch(...)
	{
		ILOG << "Caught Exception in rvDOMEventListener::AddListenerInternal()" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvDOMEventListener::RecurseAddListenersForFrames(Frame *p_frame)
{
	if (p_frame->m_sub_frames == nsnull)
		return IIR_SUCCESS;

	II_RESULT res = IIR_FAILED;
	PRUint32 len=p_frame->m_sub_frames->Count();
	for (PRUint32 idx=0;idx<len;idx++)
	{
		Frame *frm = (Frame*) p_frame->m_sub_frames->ElementAt(idx);
		ILOG << "Adding Listener for Frame:url:"<< frm->m_url << IINF; 
		ILOG << "Frame Location:url:"<< frm->m_id << IINF;

		rvXmlDocument::DumpNodeDeep((nsIDOMElement*) frm->m_doc);
		res = AddListenerInternal(frm->m_doc);
		if ( res != IIR_SUCCESS)
			ILOG << "Failed while trying add DOM listeners for Frame. Continuing with other frames.." << IFTL;
			
		RecurseAddListenersForFrames(frm);
	}

	return res;
}

void rvDOMEventListener::RemoveListeners(rvMainWindow* p_win)
{
	if (p_win == nsnull)
		return;

	RemoveListenerInternal(p_win->m_root_frame.m_doc);

	// remove listeners for the frames
	RecurseRemoveListenersForFrames(&p_win->m_root_frame);

	// unset
	if (p_win->mSubWinType == IIW_WWW)
		mBrowserToListen = nsnull;

	ILOG << "Removed all DOM Event listeners for the browser" << IINF;
}

void rvDOMEventListener::RemoveListenerInternal(nsIDOMHTMLDocument* p_doc)
{
	nsIDOMHTMLElement* body;
	p_doc->GetBody(&body);
	nsIDOMEventReceiver * receiver;
  if (p_doc != nsnull && NS_OK == p_doc->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);

		nsIDOMMouseListener* mlist;
		QueryInterface(kIDOMMouseListenerIID, (void**) &mlist);
    mgr->RemoveEventListenerByIID(mlist, kIDOMMouseListenerIID,NS_EVENT_FLAG_CAPTURE);
		NS_RELEASE(mlist);

		nsIDOMKeyListener* klist;
		QueryInterface(kIDOMKeyListenerIID, (void**) &klist);
		mgr->RemoveEventListenerByIID(klist, kIDOMKeyListenerIID,NS_EVENT_FLAG_CAPTURE);
		NS_RELEASE(klist);

		nsIDOMFormListener* flist;
		QueryInterface(kIDOMFormListenerIID, (void**) &flist);
		mgr->RemoveEventListenerByIID(flist, kIDOMFormListenerIID,NS_EVENT_FLAG_CAPTURE);
		NS_RELEASE(flist);

		nsIDOMLoadListener* llist;
		QueryInterface(kIDOMLoadListenerIID, (void**) &llist);
		mgr->RemoveEventListenerByIID(llist, kIDOMLoadListenerIID,NS_EVENT_FLAG_CAPTURE);
		NS_RELEASE(llist);

    NS_RELEASE(receiver);
		NS_RELEASE(mgr);
		NS_RELEASE(body);
  }
}

void rvDOMEventListener::RecurseRemoveListenersForFrames(Frame *p_frame)
{
	if (p_frame->m_sub_frames == nsnull)
		return;

	PRUint32 len=p_frame->m_sub_frames->Count();
	for (PRUint32 idx=0;idx<len;idx++)
	{
		Frame *frm = (Frame*) p_frame->m_sub_frames->ElementAt(idx);
		RemoveListenerInternal(frm->m_doc);
		RecurseRemoveListenersForFrames(frm);
	}
}

NS_IMETHODIMP rvDOMEventListener::HandleEvent(nsIDOMEvent *event)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::MouseDown(nsIDOMEvent* aMouseEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::MouseUp(nsIDOMEvent* aMouseEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::MouseDblClick(nsIDOMEvent* aMouseEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::MouseOver(nsIDOMEvent* aMouseEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::MouseOut(nsIDOMEvent* aMouseEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::MouseClick(nsIDOMEvent* aMouseEvent)
{
	HandleCommand(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::KeyDown(nsIDOMEvent* aKeyEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::KeyUp(nsIDOMEvent* aKeyEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::KeyPress(nsIDOMEvent* aKeyEvent)
{
	HandleCommand(aKeyEvent);
	return NS_OK;
}

// FORM Events
NS_IMETHODIMP rvDOMEventListener::Submit(nsIDOMEvent* aEvent)
{
	HandleCommand(aEvent);
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Reset(nsIDOMEvent* aEvent)
{
	HandleCommand(aEvent);
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Change(nsIDOMEvent* aEvent)
{
	HandleCommand(aEvent);
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Select(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Input(nsIDOMEvent* aEvent)
{
	HandleCommand(aEvent);
	return NS_OK;
}

// Document events
NS_IMETHODIMP rvDOMEventListener::Load(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::BeforeUnload(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Unload(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Abort(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvDOMEventListener::Error(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

void rvDOMEventListener::HandleCommand(nsIDOMEvent *aEvent)
{
	ILOG << "rvDOMEventListener::HandleCommand()" << IDBG;

	nsIDOMElement* element = GetDOMNodeFromEvent(aEvent);
	CommandInfo* cmd = CreateEventCommand(aEvent, element);
	CommandInfo* cmd_pre = nsnull;
	if (cmd == nsnull)
		return;

	RuleInfo* rule_info = nsnull;
	if (m_prev_rule_info != nsnull && element == m_prev_rule_info->m_dom_node_to_spot)
		rule_info = m_prev_rule_info;
	else
	{
		rule_info = CreateRuleInfo(element);
	
		// add the ProcessRule Commands
		if (m_prev_rule_info != nsnull)
		{
			// add it to the list
			cmd_pre = CreateCommand(MozStr("RuleEvent"), MozStr("ProcessRule"), MozStr(RN_NAME), m_prev_rule_info->m_rule_name);
			DestroyRuleInfo(m_prev_rule_info);
		}
		
		m_prev_rule_info = rule_info;
	}

	CommandInfo* existing = nsnull;
	if (cmd_pre != nsnull)
	{
		existing = GetExistingCommand(rule_info, cmd_pre);
		if (existing == nsnull)
			rule_info->m_cmds->AppendElement((void*) cmd_pre);
		else
		{
			existing->m_param_value = cmd_pre->m_param_value; 
			delete cmd_pre;
		}
	}

	existing = GetExistingCommand(rule_info, cmd);
	if (existing == nsnull)
		rule_info->m_cmds->AppendElement((void*) cmd);
	else
	{
		existing->m_param_value = cmd->m_param_value; 
		delete cmd;
	}

	//NS_RELEASE(element);
	m_creator->CreateRule(rule_info); 
	m_creator->SaveRules(); 
}

II_RESULT rvDOMEventListener::HandleCommand_DocumentLoadComplete(rvMainWindow* p_win)
{
	ILOG << "rvDOMEventListener::HandleCommand_DocumentLoadComplete()" << IINF;
	IL_TAB;

	// Get the document
	nsIDOMHTMLDocument* doc;
	II_RESULT doc_res = p_win->GetDocument(doc);
	if (doc == nsnull || doc_res != IIR_SUCCESS)
	{
		ILOG << "Could not get document. Cannot initialize" << IFTL;
		ILOG << IMSG(doc_res);
		IL_UNTAB;
		return doc_res;
	}

	// Create a generic rule info
	RuleInfo* rule_info = CreateRuleInfo((nsIDOMElement*) doc);

	// set the actual window type
	rule_info->m_window_type = p_win->GetSubWndTypeText();

	// override the load in rule_info and set it to new. 
	// IMPORTANT. This is the only thing that indicates the Rule Processor to wait for a document load
	rule_info->m_document_load_type = MozStr("new");
	rule_info->m_dom_node_to_spot = nsnull;

	// set commands
	CommandInfo* cmd_pre = nsnull;
	if (m_prev_rule_info != nsnull)
	{
		cmd_pre = CreateCommand(MozStr("RuleEvent"), MozStr("ProcessRule"), MozStr(RN_NAME), m_prev_rule_info->m_rule_name);
		DestroyRuleInfo(m_prev_rule_info);
		ILOG << "Set Previous Rule Link" << IINF;
	}

	m_prev_rule_info = rule_info;
	CommandInfo* existing = nsnull;
	if (cmd_pre != nsnull)
	{
		existing = GetExistingCommand(rule_info, cmd_pre);
		if (existing == nsnull)
			rule_info->m_cmds->AppendElement((void*) cmd_pre);
		else
		{
			existing->m_param_value = cmd_pre->m_param_value; 
			delete cmd_pre;
		}
	}

	ILOG << "Creating and Saving Rule.." << IINF;
	m_creator->CreateRule(m_prev_rule_info); 
	m_creator->SaveRules(); 
	ILOG << "Created and Saved Rule" << IINF;
	NS_RELEASE(doc);

	IL_UNTAB;
	return IIR_SUCCESS;
}

RuleInfo* rvDOMEventListener::CreateRuleInfo(nsIDOMElement* element)
{
	ILOG << "rvDOMEventListener::CreateRuleInfo()" << IINF;
	IL_TAB;

	RuleInfo* rule_info = new RuleInfo();
	rule_info->m_rule_name = GenerateRuleName();
	ILOG << "New Rule Name:" << rule_info->m_rule_name << IINF;

	rule_info->m_html_document = rvHTMLElement::GetOwnerDocument(element); 
	ILOG << "Got Owner Document" << IINF;

	ON_THE_RUN(nsnull)
	rvMainWindow* bw = IPWW->mActiveWWWBrowser;
	if (bw != nsnull)
	{
		// set the url
		Frame root_frame = bw->m_root_frame;
		if (rvHTMLElement::IsEventOnFrame(rule_info->m_html_document, &root_frame))
		{
			rule_info->m_window_url = root_frame.m_url;
			rule_info->m_url = rvHTMLElement::GetFileFromURL(rvHTMLElement::GetURLFromElement(element));
			rule_info->m_frame_id = rvHTMLElement::GetFrameID(rule_info->m_html_document, &root_frame);

			ILOG << "This Event is on a frame: Frame URL: " << rule_info->m_url << IINF;
			ILOG << "Frame ID:" << rule_info->m_frame_id << IINF; 
		}
		else
		{
			rule_info->m_frame_id = MozStr("");
			rule_info->m_window_url = MozStr("");
			
			rule_info->m_url = rvHTMLElement::GetURLFromElement(element);
			ILOG << "This Event is not on a frame: URL:" << rule_info->m_url << IDBG;
		}
	}

	rule_info->m_window_type = bw->GetSubWndTypeText();
	rule_info->m_document_load_type = MozStr("reuse"); 
	rule_info->m_rule_root_node = nsnull;
	rule_info->m_rule_results = nsnull;
	rule_info->m_prev_rule = nsnull;
	rule_info->m_dom_node_to_spot = element; // auto addref/release
	rule_info->m_cmds = new CommandList();
	rule_info->m_cmds->Clear();

	IL_UNTAB;
	return rule_info;
}

CommandInfo* rvDOMEventListener::CreateEventCommand(nsIDOMEvent* event, nsIDOMElement* element)
{
	ILOG << "rvDOMEventListener::CreateEventCommand()" << IDBG;

	II_ENSURE_INSTANCE_RETURN(element, nsnull)

	// Check if this is a pick me command
	ON_THE_RUN(nsnull)
	rvMainWindow* bw = IPWW->mActiveWWWBrowser;
	II_ENSURE_INSTANCE_RETURN(bw, nsnull)
	if (bw->mIsInDesignMode)
	{
		event->StopPropagation();
		event->PreventDefault();
		CommandInfo* cmd = CreateCommand(MozStr("TraceEvent"), MozStr("PickMe"), MozStr("alert"), MozStr("email"));
		ILOG << "Created PickMe CommandInfo" << IINF;
		return cmd;
	}

	// pass the event on, based on the type
	nsAutoString event_type;
	event->GetType(event_type);
	ILOG << "event type: " << event_type << IDBG;

	CommandInfo* cmd = nsnull;
	if (event_type == MozStr("click"))
		cmd = CreateEventCommand_Click(event, element);
	else if (event_type == MozStr("keypress"))
		cmd = CreateEventCommand_KeyPress(event, element);
	else if (event_type == MozStr("input"))
		cmd = CreateEventCommand_Input(event, element);
	else if (event_type == MozStr("change"))
		cmd = CreateEventCommand_Change(event, element);
	else if (event_type == MozStr("submit"))
		cmd = CreateEventCommand_Submit(event, element);
	else if (event_type == MozStr("reset"))
		cmd = CreateEventCommand_Reset(event, element);
	else
		return nsnull;

	return cmd;
}

CommandInfo* rvDOMEventListener::CreateEventCommand_Click(nsIDOMEvent* event, nsIDOMElement* element)
{
	nsAutoString tag;
	element->GetTagName(tag);
	ILOG << "tag: " << tag << IINF;

	PRBool set_cmd = PR_FALSE;
	CommandInfo* cmd = nsnull;
	
	nsAutoString href;
	II_RESULT res = rvHTMLElement::GetAttributeValue(element, MozStr("href"), href);
	II_ENSURE(res, nsnull)

	if (href != MozStr(""))
		set_cmd = PR_TRUE;
	else if (tag.EqualsIgnoreCase("a") || tag.EqualsIgnoreCase("anchor"))
		set_cmd = PR_TRUE;
	else if (tag.EqualsIgnoreCase("input"))
	{
		nsAutoString itype;
		II_RESULT res = rvHTMLElement::GetAttributeValue(element, MozStr("type"), itype);
		II_ENSURE(res, nsnull)

		if (itype.EqualsIgnoreCase("button"))
			set_cmd = PR_TRUE;
	}
	else if (tag.EqualsIgnoreCase("button"))
		set_cmd = PR_TRUE;
	else if (tag.EqualsIgnoreCase("area"))
		set_cmd = PR_TRUE;
	else if (tag.EqualsIgnoreCase("span"))
		set_cmd = PR_TRUE;
	else if (tag.EqualsIgnoreCase("font"))
		set_cmd = PR_TRUE;
	else if (tag.EqualsIgnoreCase("em"))
		set_cmd = PR_TRUE;

	if (set_cmd)
	{
		ILOG << "Creating Command for Click Event" << IINF;
		cmd = CreateCommand(MozStr("PostLoad"), MozStr("MouseEvents"), MozStr("click"), MozStr(""));
	}

	return cmd;
}

CommandInfo* rvDOMEventListener::CreateEventCommand_KeyPress(nsIDOMEvent* event, nsIDOMElement* element)
{
// mask key events as mouse/change/form events 
	/*	PRUint32 key_code = 0;
		nsCOMPtr<nsIDOMKeyEvent> keyevent = do_QueryInterface(event);
		keyevent->GetKeyCode(&key_code);
		if (key_code == 13)
			event_type = MozStr("click");
		else if (key_code == 0)
			event_type = MozStr("change");
		else
			return nsnull;*/
	return nsnull;
}

CommandInfo* rvDOMEventListener::CreateEventCommand_Input(nsIDOMEvent* event, nsIDOMElement* element)
{
	nsAutoString tag;
	element->GetTagName(tag);
	ILOG << "tag: " << tag << IINF;

	CommandInfo* cmd = nsnull;

	if (tag.EqualsIgnoreCase("input"))
	{
		nsAutoString itype;
		II_RESULT res = rvHTMLElement::GetAttributeValue(element, MozStr("type"), itype);
		II_ENSURE(res, nsnull)

		if (itype.EqualsIgnoreCase("") || itype.EqualsIgnoreCase("text"))
		{
			nsAutoString value;
			II_RESULT res = rvHTMLElement::GetInputElementValue(element, value);
			II_ENSURE(res, nsnull)

			ILOG << "Creating Command for Input Event" << IINF;
			cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("value"), value);
		}
	}

	return cmd;
}

CommandInfo* rvDOMEventListener::CreateEventCommand_Change(nsIDOMEvent* event, nsIDOMElement* element)
{
	nsAutoString tag;
	element->GetTagName(tag);
	ILOG << "tag: " << tag << IINF;

	CommandInfo* cmd = nsnull;
	if (tag.EqualsIgnoreCase("input"))
	{
		nsAutoString itype;
		II_RESULT res=rvHTMLElement::GetAttributeValue(element, MozStr("type"), itype);
		II_ENSURE(res, nsnull)

		if (itype.EqualsIgnoreCase("checkbox") || itype.EqualsIgnoreCase("radio"))
		{
			PRInt32 value;
			II_RESULT res=rvHTMLElement::GetInputElementChecked(element, value);
			II_ENSURE(res, nsnull)

			ILOG << "Creating Command for Change Event" << IINF;
			if (value)
				cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("checked"), MozStr(""));
			else
				cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("unchecked"), MozStr(""));
		}
	}
	else if (tag.EqualsIgnoreCase("textarea"))
	{
		nsAutoString value;
		II_RESULT res = rvHTMLElement::GetTextAreaElementValue(element, value);
		II_ENSURE(res, nsnull)
		cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("value"), value);
	}
	else if (tag.EqualsIgnoreCase("select"))
	{
		nsAutoString value;
		II_RESULT res = rvHTMLElement::GetSelectElementSelectedIndices(element, value);
		II_ENSURE(res, nsnull)

		ILOG << "Creating Command for Change Event" << IINF;
		cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("selected"), value);
	}
	
	return cmd;
}

CommandInfo* rvDOMEventListener::CreateEventCommand_Submit(nsIDOMEvent* event, nsIDOMElement* element)
{
	nsAutoString tag;
	element->GetTagName(tag);
	ILOG << "tag: " << tag << IINF;

	ILOG << "Creating Command for Submit Event" << IINF;
	CommandInfo* cmd = CreateCommand(MozStr("PostLoad"), MozStr("MouseEvents"), MozStr("submit"), MozStr(""));
	return cmd;
}

CommandInfo* rvDOMEventListener::CreateEventCommand_Reset(nsIDOMEvent* event, nsIDOMElement* element)
{
	nsAutoString tag;
	element->GetTagName(tag);
	ILOG << "tag: " << tag << IINF;

	ILOG << "Creating Command for Reset Event" << IINF;
	CommandInfo* cmd = CreateCommand(MozStr("PostLoad"), MozStr("MouseEvents"), MozStr("reset"), MozStr(""));
	return cmd;
}

CommandInfo* rvDOMEventListener::CreateCommand(nsAutoString cmd_type, nsAutoString cmd, nsAutoString cmd_param, nsAutoString cmd_value)
{
	CommandInfo* cmd_info = new CommandInfo();

	cmd_info->m_exec_type = cmd_type;
	cmd_info->m_cmd = cmd;
	cmd_info->m_param_name = cmd_param;
	cmd_info->m_param_value = cmd_value;

	ILOG << " -------------------------------" << IINF;
	ILOG << "Created CommandInfo" << IINF;
	ILOG << "m_exec_type: " << cmd_type << IINF;
	ILOG << "m_cmd: " << cmd << IINF;
	ILOG << "m_param_name: " << cmd_param << IINF;
	ILOG << "m_param_value: " << cmd_value << IINF;
	ILOG << " -------------------------------" << IINF;

	return cmd_info;
}

// ========================= Utility functions ======================================
CommandInfo* rvDOMEventListener::GetExistingCommand(RuleInfo* rule_info, CommandInfo* cmd)
{
	// Check if this command was already added
	for (PRInt32 idx = 0; idx < rule_info->m_cmds->Count(); idx++)
	{
		CommandInfo* existing = (CommandInfo*) rule_info->m_cmds->ElementAt(idx);
		if (existing != nsnull && 
			  existing->m_cmd == cmd->m_cmd &&
				existing->m_exec_type == cmd->m_exec_type &&
				existing->m_param_name == cmd->m_param_name)
				return existing;
	}

	return nsnull;
}

nsAutoString rvDOMEventListener::GenerateRuleName()
{
	time_t t1;
	time(&t1);
	tm *t = localtime(&t1);

	int r = rand();

	// Get a random number
	char buf[28];
	sprintf(buf,"RuleID_%d_%d_%d_%d_%d_%d_%d", t->tm_year, t->tm_mon, t->tm_mday, t->tm_hour,t->tm_min,t->tm_sec, r);
	nsAutoString name;
	name.AppendWithConversion(buf);

	return name;
}

// util functions
nsIDOMElement* rvDOMEventListener::GetDOMNodeFromEvent(nsIDOMEvent* aEvent)
{
	ILOG << "rvDOMEventListener::GetDOMNodeFromEvent()" << IDBG;

	nsCOMPtr<nsIDOMEventTarget> target;
	aEvent->GetTarget(getter_AddRefs(target));
	nsCOMPtr<nsIDOMElement> node(do_QueryInterface(target));
	if (node == nsnull)
	{
		ILOG << "Could not get Node from Target" << IERR;
		return nsnull;
	}

	nsAutoString node_name;
	node->GetNodeName(node_name);
	ILOG << "Event Target : " << node_name << IDBG;
	
	return node;
}

