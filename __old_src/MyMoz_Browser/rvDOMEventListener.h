#ifndef __rvDOMEventListener_
#define __rvDOMEventListener_

#include "rvMyMozApp.h"
#include "rvRulesDefines.h"
#include "rvRulesCollection.h"
#include "rvRuleCreator.h"

class rvMainWindow;
struct Frame;
class rvDOMEventListener: public nsIDOMMouseListener, 
													public nsIDOMKeyListener,
													public nsIDOMFormListener,
													public nsIDOMLoadListener
{
public:
	NS_DECL_ISUPPORTS

	// con/destr
	rvDOMEventListener();
	~rvDOMEventListener();
	
	// main members
	CRuleCreator* m_creator;
	rvMainWindow* mBrowserToListen;
	RuleInfo* m_prev_rule_info; // This is used to track changes to the same element
	PRBool m_pick_me_processed;

	// mouse event functions
  NS_IMETHOD HandleEvent(nsIDOMEvent *event);
  NS_IMETHOD MouseDown(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseUp(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseDblClick(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseOver(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseOut(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseClick(nsIDOMEvent* aMouseEvent);

	// key events
  NS_IMETHOD KeyDown(nsIDOMEvent* aKeyEvent);
  NS_IMETHOD KeyUp(nsIDOMEvent* aKeyEvent);
  NS_IMETHOD KeyPress(nsIDOMEvent* aKeyEvent);

	// form events
  NS_IMETHOD Submit(nsIDOMEvent* aEvent);
  NS_IMETHOD Reset(nsIDOMEvent* aEvent);
  NS_IMETHOD Change(nsIDOMEvent* aEvent);
  NS_IMETHOD Select(nsIDOMEvent* aEvent);
  NS_IMETHOD Input(nsIDOMEvent* aEvent);

  NS_IMETHOD Load(nsIDOMEvent* aEvent);
  NS_IMETHOD BeforeUnload(nsIDOMEvent* aEvent);
  NS_IMETHOD Unload(nsIDOMEvent* aEvent);
  NS_IMETHOD Abort(nsIDOMEvent* aEvent);
  NS_IMETHOD Error(nsIDOMEvent* aEvent);

	// main members/functions
	void AddListeners(rvMainWindow* p_win);
	void AddListenerInternal(nsIDOMHTMLDocument* p_doc);
	void RecurseAddListenersForFrames(Frame* frm);

	void RemoveListeners(rvMainWindow* p_win);
	void RemoveListenerInternal(nsIDOMHTMLDocument* p_doc);
	void RecurseRemoveListenersForFrames(Frame* frm);

	// helpers
	void HandleCommand(nsIDOMEvent *aEvent);
	RuleInfo* CreateRuleInfo(nsIDOMElement* element);
	CommandInfo* CreateEventCommandForElement(nsIDOMEvent* event, nsIDOMElement* element);

	// util
	CommandInfo* CreateCommand(nsAutoString cmd_type, nsAutoString cmd, nsAutoString cmd_param, nsAutoString cmd_value);
	CommandInfo* GetExistingCommand(RuleInfo* rule_info, CommandInfo* cmd);
	nsIDOMHTMLDocument* GetOwnerDocument(nsIDOMElement* p_element);
	nsIDOMElement* GetDOMNodeFromEvent(nsIDOMEvent* aEvent);
	nsAutoString GetURLFromElement(nsIDOMElement* p_element);
	nsAutoString GenerateRuleName();
	nsAutoString GetAttributeValue(nsIDOMElement* p_element, nsAutoString attr);
};

#endif