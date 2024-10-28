#ifndef __RV_FORM_WINDOW_H_
#define __RV_FORM_WINDOW_H_

#include "rvXPCOMIDs.h"


typedef nsVoidArray EventHandlerList;
class rvMainWindow;

class CHTMLFormWindow : public nsIDOMKeyListener,
												public nsIDOMMouseListener,
												public nsIDOMFormListener
{
	public:
		NS_DECL_ISUPPORTS

	// event dispatcher
	void DispatchEvent(nsIDOMEvent* aEvent);

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

	// functions to add/remove all listeners for a given dom object on the form
	EventHandlerList m_events; // This should be filled by the derived classes
	nsresult AddListeners();
	nsresult AddListenerInternal(nsIDOMElement* p_form_element, nsAutoString p_event_type);
	nsresult RemoveListeners();
	nsresult RemoveListenerInternal(nsIDOMElement* p_form_element, nsAutoString p_event_type); 

public:
  CHTMLFormWindow();
  virtual ~CHTMLFormWindow();

	rvMainWindow* mInternalBrowser;

	// Initialization must be done in derived classes or forms, where the dom obejcts on which the listeners are to be set is known
	// This function is called back by the rvMainWindow (base class Browser) EndLoadURL listener
  virtual void InitializeListeners();
	virtual void UninitializeListeners();

	virtual void DoOpen() = 0;
	virtual void DoClose();

public:
	// Generic FORM Control get/set methods
  PRBool IsChecked(const nsAString & aName);
  PRBool IsChecked(nsIDOMElement * aNode);
  void   SetChecked(nsIDOMElement * aNode, PRBool aValue);
  void   SetChecked(const nsAString & aName, PRBool aValue);
  void   GetText(nsIDOMElement * aNode, nsAString & aStr);
  void   GetText(const nsAString & aName, nsAString & aStr);
  float  GetFloat(nsString & aStr);
  void   SetText(nsIDOMElement * aNode, const nsAString &aValue);
  void   SetText(const nsAString & aName, const nsAString & aStr);
};

// struct to hold an event subscription
typedef void (*FormHTMLElementEventHandler) (nsIDOMElement*, CHTMLFormWindow*);

struct EventSubscription
{
public:
	nsIDOMElement* m_element;
	nsAutoString m_event;
	nsAutoString m_event_type;
	FormHTMLElementEventHandler m_handler;
	CHTMLFormWindow* m_form;
};

#endif 
