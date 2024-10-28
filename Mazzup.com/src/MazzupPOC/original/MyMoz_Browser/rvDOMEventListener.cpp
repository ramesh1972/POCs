#include "rvRulesCollection.h"
#include "rvRuleCreator.h"
#include "rvMainWindow.h"
#include "rvDOMEventListener.h"
extern rvMyMozApp* theApp;

NS_IMPL_THREADSAFE_ISUPPORTS4(rvDOMEventListener, nsIDOMMouseListener, nsIDOMKeyListener, nsIDOMLoadListener, nsIDOMFormListener);

rvDOMEventListener::rvDOMEventListener()
{
	mBrowserToListen = nsnull;
	m_prev_rule_info = nsnull;
	m_pick_me_processed = PR_FALSE;

	m_creator = new CRuleCreator();
	srand(100);
}

rvDOMEventListener::~rvDOMEventListener()
{
	mBrowserToListen = nsnull;
	DestroyRuleInfo(m_prev_rule_info);
	m_prev_rule_info = nsnull;

	m_pick_me_processed = PR_FALSE;

	if (m_creator != nsnull) 
	{
		m_creator->SaveRules();
		delete m_creator;
		m_creator = nsnull;

	}
}

void rvDOMEventListener::AddListeners(rvMainWindow* p_win)
{
	mBrowserToListen = p_win;
	nsIDOMHTMLDocument* doc;
	p_win->GetDocument(doc);

	RuleInfo* rule_info = CreateRuleInfo((nsIDOMElement*) doc);
	rule_info->m_dom_node_to_spot = nsnull;

	CommandInfo* cmd_pre = nsnull;
	if (m_prev_rule_info != nsnull)
	{
		cmd_pre = CreateCommand(MozStr("RuleEvent"), MozStr("ProcessRule"), MozStr(RN_NAME), m_prev_rule_info->m_rule_name);
		DestroyRuleInfo(m_prev_rule_info);
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

	m_creator->CreateRule(m_prev_rule_info); 
	m_creator->SaveRules(); 
	
	NS_RELEASE(doc);

	if (p_win ==nsnull)
		return;

	// add for the topmost document
	AddListenerInternal(p_win->m_root_frame.m_doc);

	// add listeners for the frames/subdocuments
	RecurseAddListenersForFrames(&p_win->m_root_frame);
	
}

void rvDOMEventListener::AddListenerInternal(nsIDOMHTMLDocument* p_doc)
{
	if (p_doc == nsnull)
		return;

	nsIDOMHTMLElement* body;
	p_doc->GetBody(&body);
	nsIDOMEventReceiver * receiver;
  if (body != nsnull && NS_OK == body->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);

		nsIDOMMouseListener* mlist;
		QueryInterface(kIDOMMouseListenerIID, (void**) &mlist);
    mgr->AddEventListenerByIID(mlist, kIDOMMouseListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(mlist);

		nsIDOMKeyListener* klist;
		QueryInterface(kIDOMKeyListenerIID, (void**) &klist);
		mgr->AddEventListenerByIID(klist, kIDOMKeyListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(klist);

		nsIDOMFormListener* flist;
		QueryInterface(kIDOMFormListenerIID, (void**) &flist);
		mgr->AddEventListenerByIID(flist, kIDOMFormListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(flist);

		nsIDOMLoadListener* llist;
		QueryInterface(kIDOMLoadListenerIID, (void**) &llist);
		mgr->AddEventListenerByIID(llist, kIDOMLoadListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(llist);

    NS_RELEASE(receiver);
		NS_RELEASE(mgr);
		NS_RELEASE(body);
  }
}


void rvDOMEventListener::RecurseAddListenersForFrames(Frame *p_frame)
{
	if (p_frame->m_sub_frames == nsnull)
		return;

	PRUint32 len=p_frame->m_sub_frames->Count();
	for (PRUint32 idx=0;idx<len;idx++)
	{
		Frame *frm = (Frame*) p_frame->m_sub_frames->ElementAt(idx);
		AddListenerInternal(frm->m_doc);
		RecurseAddListenersForFrames(frm);
	}
}

void rvDOMEventListener::RemoveListeners(rvMainWindow* p_win)
{
	if (p_win == nsnull)
		return;

	// TODO: Not Working
	RemoveListenerInternal(p_win->m_root_frame.m_doc);

	// remove listeners for the frames
	RecurseRemoveListenersForFrames(&p_win->m_root_frame);

	// unset
	mBrowserToListen = nsnull;
}

void rvDOMEventListener::RemoveListenerInternal(nsIDOMHTMLDocument* p_doc)
{
	nsIDOMHTMLElement* body;
	p_doc->GetBody(&body);
	nsIDOMEventReceiver * receiver;
  if (NS_OK == body->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);

		nsIDOMMouseListener* mlist;
		QueryInterface(kIDOMMouseListenerIID, (void**) &mlist);
    mgr->RemoveEventListenerByIID(mlist, kIDOMMouseListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(mlist);

		nsIDOMKeyListener* klist;
		QueryInterface(kIDOMKeyListenerIID, (void**) &klist);
		mgr->RemoveEventListenerByIID(klist, kIDOMKeyListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(klist);

		nsIDOMFormListener* flist;
		QueryInterface(kIDOMFormListenerIID, (void**) &flist);
		mgr->RemoveEventListenerByIID(flist, kIDOMFormListenerIID,NS_EVENT_FLAG_BUBBLE);
		NS_RELEASE(flist);

		nsIDOMLoadListener* llist;
		QueryInterface(kIDOMLoadListenerIID, (void**) &llist);
		mgr->RemoveEventListenerByIID(llist, kIDOMLoadListenerIID,NS_EVENT_FLAG_BUBBLE);
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
	nsIDOMElement* element = GetDOMNodeFromEvent(aEvent);
	CommandInfo* cmd = CreateEventCommandForElement(aEvent, element);
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

RuleInfo* rvDOMEventListener::CreateRuleInfo(nsIDOMElement* element)
{
	RuleInfo* rule_info = new RuleInfo();
	rule_info->m_rule_name = GenerateRuleName();
	rule_info->m_html_document = GetOwnerDocument(element); 
	rule_info->m_url = GetURLFromElement(element);

	Frame root_frame = mBrowserToListen->m_root_frame;
	if (root_frame.m_sub_frames != nsnull && root_frame.m_sub_frames->Count() > 0)
	{
		rule_info->m_window_url = root_frame.m_url;
		rule_info->m_frame_id = mBrowserToListen->GetFrameID(rule_info->m_html_document, &root_frame);
	}
	else
	{
		rule_info->m_frame_id = MozStr("");
		rule_info->m_window_url = MozStr("");
	}

	rule_info->m_rule_root_node = nsnull;
	rule_info->m_rule_results = nsnull;
	rule_info->m_prev_rule = nsnull;
	rule_info->m_dom_node_to_spot = element; // auto addref/release
	rule_info->m_cmds = new CommandList();
	rule_info->m_cmds->Clear();

	return rule_info;
}

CommandInfo* rvDOMEventListener::CreateEventCommandForElement(nsIDOMEvent* event, nsIDOMElement* element)
{
	nsAutoString tag;
	element->GetTagName(tag);
	
	nsAutoString event_type;
	event->GetType(event_type);
//	_ILOG(event_type);

	CommandInfo* cmd = nsnull;
	PRBool set_cmd = PR_FALSE;

	// mask key events as mouse/change/form events 
	if (event_type == MozStr("keypress"))
	{
	/*	PRUint32 key_code = 0;
		nsCOMPtr<nsIDOMKeyEvent> keyevent = do_QueryInterface(event);
		keyevent->GetKeyCode(&key_code);
		if (key_code == 13)
			event_type = MozStr("click");
		else if (key_code == 0)
			event_type = MozStr("change");
		else
			return nsnull;*/
	}

	if (event_type == MozStr("click"))
	{
		if (mBrowserToListen->mIsInDesignMode)
		{
			event->StopPropagation();
			event->PreventDefault();
			cmd = CreateCommand(MozStr("TraceEvent"), MozStr("PickMe"), MozStr("alert"), MozStr("email"));
			return cmd;
		}

		_ILOG(tag);
		nsAutoString href = GetAttributeValue(element, MozStr("href"));;
		if (href != MozStr(""))
			set_cmd = PR_TRUE;
		else if (tag.EqualsIgnoreCase("a") || tag.EqualsIgnoreCase("anchor"))
			set_cmd = PR_TRUE;
		else if (tag.EqualsIgnoreCase("input"))
		{
			nsAutoString itype = GetAttributeValue(element, MozStr("type"));
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
			cmd = CreateCommand(MozStr("PostLoad"), MozStr("MouseEvents"), MozStr("click"), MozStr(""));
	}
	else if (event_type == MozStr("input"))
	{
	}
	else if (event_type == MozStr("change"))
	{
		if (tag.EqualsIgnoreCase("input"))
		{
			nsAutoString itype = GetAttributeValue(element, MozStr("type"));
			if (itype.EqualsIgnoreCase("checkbox") || itype.EqualsIgnoreCase("radio"))
			{
				PRInt32 value;
				nsIDOMHTMLInputElement* ielement;
				element->QueryInterface(kIDOMHTMLInputElementIID, (void**) &ielement);
				ielement->GetChecked(&value);

				if (value)
					cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("checked"), MozStr(""));
				else
					cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("unchecked"), MozStr(""));

				NS_RELEASE(ielement);
			}
			else if (tag.EqualsIgnoreCase("input"))
			{
				nsAutoString itype = GetAttributeValue(element, MozStr("type"));
				if (itype.EqualsIgnoreCase("text"))
				{
					nsAutoString value;
					nsIDOMHTMLInputElement* ielement;
					element->QueryInterface(kIDOMHTMLInputElementIID, (void**) &ielement);
					ielement->GetValue(value);
					cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("value"), value);
					set_cmd = PR_TRUE;
					NS_RELEASE(ielement);
				}
			}
		}
		else if (tag.EqualsIgnoreCase("textarea"))
		{
			nsAutoString value;
			nsCOMPtr<nsIDOMHTMLTextAreaElement> telement = do_QueryInterface(element);
			telement->GetValue(value);
			cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("value"), value);
		}
		else if (tag.EqualsIgnoreCase("select"))
		{
			nsCOMPtr<nsIDOMHTMLOptionsCollection> col;
			nsCOMPtr<nsIDOMHTMLSelectElement> selement = do_QueryInterface(element);
			selement->GetOptions(getter_AddRefs(col));

			PRUint32 len = 0;col->GetLength(&len);
			nsAutoString value;
			for (PRInt32 idx=0;idx < len;idx++)
			{
				nsCOMPtr<nsIDOMHTMLOptionElement> opt = nsnull;
				col->Item(idx, (nsIDOMNode**) &opt);

				PRBool selected;
				opt->GetSelected(&selected);
				if (selected)
				{
					nsAutoString idxstr;
					idxstr.Append(MozStr(","));
					idxstr.AppendInt(idx);
					idxstr.Append(MozStr(","));
					value.Append(idxstr);
				}
			}

			cmd = CreateCommand(MozStr("PostLoad"), MozStr("InputEvents"), MozStr("selected"), value);
		}
	}
	else if (event_type == MozStr("submit"))
	{
		cmd = CreateCommand(MozStr("PostLoad"), MozStr("MouseEvents"), MozStr("submit"), MozStr(""));
		set_cmd = PR_TRUE;
	}
	else if (event_type == MozStr("reset"))
	{
		cmd = CreateCommand(MozStr("PostLoad"), MozStr("MouseEvents"), MozStr("reset"), MozStr(""));
		set_cmd = PR_TRUE;
	}
	else
		set_cmd = PR_FALSE;

	return cmd;
}

// ========================= Utility functions ======================================
CommandInfo* rvDOMEventListener::CreateCommand(nsAutoString cmd_type, nsAutoString cmd, nsAutoString cmd_param, nsAutoString cmd_value)
{
	CommandInfo* cmd_info = new CommandInfo();
	cmd_info->m_exec_type = cmd_type;
	cmd_info->m_cmd = cmd;
	cmd_info->m_param_name = cmd_param;
	cmd_info->m_param_value = cmd_value;

	return cmd_info;
}

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

nsIDOMHTMLDocument* rvDOMEventListener::GetOwnerDocument(nsIDOMElement* p_element)
{
	nsIDOMDocument* doc;
	p_element->GetOwnerDocument(&doc);

	if (doc == nsnull)
		return (nsIDOMHTMLDocument*) p_element;
	
	nsCOMPtr<nsIDOMHTMLDocument> hdoc = do_QueryInterface(doc);
	NS_RELEASE(doc);
	return hdoc;
}

nsAutoString rvDOMEventListener::GetURLFromElement(nsIDOMElement* p_element)
{
	nsIDOMHTMLDocument* doc = GetOwnerDocument(p_element);
	nsAutoString url;

	if (doc != nsnull)
	{
		doc->GetURL(url);
	}
	else
		((nsIDOMHTMLDocument*) p_element)->GetURL(url);

	return url;
}

// util functions
nsIDOMElement* rvDOMEventListener::GetDOMNodeFromEvent(nsIDOMEvent* aEvent)
{
	nsCOMPtr<nsIDOMEventTarget> target;
	aEvent->GetTarget(getter_AddRefs(target));
	nsCOMPtr<nsIDOMElement> node(do_QueryInterface(target));

	return node;
}

nsAutoString rvDOMEventListener::GetAttributeValue(nsIDOMElement* p_element, nsAutoString p_attr)
{
	/*
		nsAutoString val;
	p_element->GetAttribute(p_attr, val);
	return val;*/

	nsIDOMNamedNodeMap* map;
	p_element->GetAttributes(&map);
	if (map == nsnull)
		return MozStr("");

	PRUint32 cnt=0;map->GetLength(&cnt);

	for (PRInt32 idx =0;idx<cnt;idx++)
	{
		nsIDOMNode* node=nsnull;
		map->Item(idx, &node);

		nsAutoString name, value;
		node->GetNodeName(name);
		if (name == p_attr)
		{
			node->GetNodeValue(value); 
			NS_RELEASE(node);
			NS_RELEASE(map);
			return value;
		}
	
		NS_RELEASE(node);
	}

	NS_RELEASE(map);
	return MozStr("");
}
