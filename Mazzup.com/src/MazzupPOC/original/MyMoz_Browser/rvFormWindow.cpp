#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvMainWindow.h"
#include "rvFormWindow.h"

extern rvMyMozApp* theApp;

NS_IMPL_THREADSAFE_ISUPPORTS3(CHTMLFormWindow, nsIDOMMouseListener, nsIDOMKeyListener, nsIDOMFormListener);

CHTMLFormWindow::CHTMLFormWindow() 
{
	mInternalBrowser = nsnull;
}

CHTMLFormWindow::~CHTMLFormWindow()
{
}

void CHTMLFormWindow::DoClose()
{
}

// generic functions to Add/Remove event listeners ona particula dom object
void CHTMLFormWindow::InitializeListeners()
{
	AddListeners();
}

void CHTMLFormWindow::UninitializeListeners()
{
	RemoveListeners();
	NS_ADDREF(mInternalBrowser);
	NS_RELEASE_THIS();
}

nsresult CHTMLFormWindow::AddListeners()
{
	PRInt32 idx = m_events.Count();
	while (idx > 0)
	{
		EventSubscription* sub = (EventSubscription*) m_events.ElementAt(--idx);
		AddListenerInternal(sub->m_element , sub->m_event); 
	}

	return NS_OK;
}

nsresult CHTMLFormWindow::AddListenerInternal(nsIDOMElement* p_element, nsAutoString p_event_type)
{
	if (p_element == nsnull)
		return NS_OK;

	nsIDOMEventReceiver * receiver;
  if (NS_OK == p_element->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);

		if (p_event_type.EqualsIgnoreCase("mouse"))
		{
			nsIDOMMouseListener* mlist;
			QueryInterface(kIDOMMouseListenerIID, (void**) &mlist);
			mgr->AddEventListenerByIID(mlist, kIDOMMouseListenerIID,NS_EVENT_FLAG_BUBBLE);
			NS_RELEASE(mlist);
		}

		if (p_event_type.EqualsIgnoreCase("key"))
		{
			nsIDOMKeyListener* klist;
			QueryInterface(kIDOMKeyListenerIID, (void**) &klist);
			mgr->AddEventListenerByIID(klist, kIDOMKeyListenerIID,NS_EVENT_FLAG_BUBBLE);
			NS_RELEASE(klist);
		}

		if (p_event_type.EqualsIgnoreCase("form"))
		{
			nsIDOMFormListener* flist;
			QueryInterface(kIDOMFormListenerIID, (void**) &flist);
			mgr->AddEventListenerByIID(flist, kIDOMFormListenerIID,NS_EVENT_FLAG_BUBBLE);
			NS_RELEASE(flist);
		}

		NS_RELEASE(receiver);
		NS_RELEASE(mgr);
  }

	return NS_OK;
}

nsresult CHTMLFormWindow::RemoveListeners()
{
	PRInt32 cnt = m_events.Count();
	for (PRInt32 idx = 0;idx<cnt;idx++)
	{
		EventSubscription* sub = (EventSubscription*) m_events.ElementAt(idx);
		RemoveListenerInternal(sub->m_element, sub->m_event); 
		NS_RELEASE(sub->m_element);
		sub->m_handler = nsnull;
		delete sub;
	}

	m_events.Clear();
	return NS_OK;
}

nsresult CHTMLFormWindow::RemoveListenerInternal(nsIDOMElement* p_element, nsAutoString p_event_type)
{
	if (p_element == nsnull)
		return NS_OK;

	nsIDOMEventReceiver * receiver;
  if (NS_OK == p_element->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);
		if (p_event_type.EqualsIgnoreCase("mouse"))
		{
			nsIDOMMouseListener* mlist;
			QueryInterface(kIDOMMouseListenerIID, (void**) &mlist);
			mgr->RemoveEventListenerByIID(mlist, kIDOMMouseListenerIID,NS_EVENT_FLAG_BUBBLE);
			NS_RELEASE(mlist);
		}

		if (p_event_type.EqualsIgnoreCase("key"))
		{
			nsIDOMKeyListener* klist;
			QueryInterface(kIDOMKeyListenerIID, (void**) &klist);
			mgr->RemoveEventListenerByIID(klist, kIDOMKeyListenerIID,NS_EVENT_FLAG_BUBBLE);
			NS_RELEASE(klist);
		}

		if (p_event_type.EqualsIgnoreCase("form"))
		{
			nsIDOMFormListener* flist;
			QueryInterface(kIDOMFormListenerIID, (void**) &flist);
			mgr->RemoveEventListenerByIID(flist, kIDOMFormListenerIID,NS_EVENT_FLAG_BUBBLE);
			NS_RELEASE(flist);
		}

    NS_RELEASE(receiver);
		NS_RELEASE(mgr);
  }

	return NS_OK;
}

// This class does not implement any event handlers specifically since it does not have
// any knowledge of the form. So these will merely return NS_OK
// SHOULD NOT BE ADDING ANY CODE IN THESE EVENT HANDLERS
NS_IMETHODIMP CHTMLFormWindow::HandleEvent(nsIDOMEvent *event)
{
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::MouseDown(nsIDOMEvent* aMouseEvent)
{
	DispatchEvent(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::MouseUp(nsIDOMEvent* aMouseEvent)
{
	DispatchEvent(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::MouseDblClick(nsIDOMEvent* aMouseEvent)
{
	DispatchEvent(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::MouseOver(nsIDOMEvent* aMouseEvent)
{
	DispatchEvent(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::MouseOut(nsIDOMEvent* aMouseEvent)
{
	DispatchEvent(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::MouseClick(nsIDOMEvent* aMouseEvent)
{
	DispatchEvent(aMouseEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::KeyDown(nsIDOMEvent* aKeyEvent)
{
	DispatchEvent(aKeyEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::KeyUp(nsIDOMEvent* aKeyEvent)
{
	DispatchEvent(aKeyEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::KeyPress(nsIDOMEvent* aKeyEvent)
{
	DispatchEvent(aKeyEvent);
	return NS_OK;
}

// FORM Events
NS_IMETHODIMP CHTMLFormWindow::Submit(nsIDOMEvent* aEvent)
{
	DispatchEvent(aEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::Reset(nsIDOMEvent* aEvent)
{
	DispatchEvent(aEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::Change(nsIDOMEvent* aEvent)
{
	DispatchEvent(aEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::Select(nsIDOMEvent* aEvent)
{
	DispatchEvent(aEvent);
	return NS_OK;
}

NS_IMETHODIMP CHTMLFormWindow::Input(nsIDOMEvent* aEvent)
{
	DispatchEvent(aEvent);
	return NS_OK;
}

void CHTMLFormWindow::DispatchEvent(nsIDOMEvent* aEvent)
{
  nsCOMPtr<nsIDOMEventTarget> target;
  aEvent->GetTarget(getter_AddRefs(target));

	nsCOMPtr<nsIDOMElement> node;
  if (target) 
		node = do_QueryInterface(target);

	nsAutoString event_type; aEvent->GetType(event_type);
	//_ILOG(event_type);

	PRInt32 idx = m_events.Count();
	while (idx > 0)
	{
		EventSubscription* sub = (EventSubscription*) m_events.ElementAt(--idx);
		if (sub->m_element == node && sub->m_event_type == event_type)
			sub->m_handler(node, this); 
	}
}

// =================== END EVENT HANDLERS ======================
// =============================================================

// get/setter functions on basic form elements
PRBool CHTMLFormWindow::IsChecked(nsIDOMElement * aNode)
{
  nsIDOMHTMLInputElement * element;
  if (NS_OK == aNode->QueryInterface(kIDOMHTMLInputElementIID, (void**) &element)) 
	{
    PRBool checked;
    element->GetChecked(&checked);
    NS_RELEASE(element);
    return checked;
  }

  return PR_FALSE;
}

PRBool CHTMLFormWindow::IsChecked(const nsAString & aName)
{
  nsIDOMElement      * node;
  nsIDOMHTMLDocument * doc = nsnull;
  mInternalBrowser->GetDocument(doc);
  if (nsnull != doc) 
	{
    if (NS_OK == doc->GetElementById(aName, &node)) 
		{
      PRBool value = IsChecked(node);
      NS_RELEASE(node);
      NS_RELEASE(doc);
      return value;
    }
    NS_RELEASE(doc);
  }

  return PR_FALSE;
}

void CHTMLFormWindow::SetChecked(nsIDOMElement * aNode, PRBool aValue)
{
  nsIDOMHTMLInputElement * element;
  if (NS_OK == aNode->QueryInterface(kIDOMHTMLInputElementIID, (void**) &element)) 
	{
    element->SetChecked(aValue);
    NS_RELEASE(element);
  }
}

void CHTMLFormWindow::SetChecked(const nsAString & aName, PRBool aValue)
{
  nsIDOMElement      * node;
  nsIDOMHTMLDocument * doc = nsnull;
  mInternalBrowser->GetDocument(doc);
  if (nsnull != doc) 
	{
    if (NS_OK == doc->GetElementById(aName,   &node)) 
		{
      SetChecked(node, aValue);
      NS_RELEASE(node);
    }

    NS_RELEASE(doc);
  }
}

void CHTMLFormWindow::GetText(nsIDOMElement * aNode, nsAString & aStr)
{
  nsIDOMHTMLInputElement * element;
  if (NS_OK == aNode->QueryInterface(kIDOMHTMLInputElementIID, (void**) &element)) 
	{
    element->GetValue(aStr);
    NS_RELEASE(element);
  }
}

void CHTMLFormWindow::GetText(const nsAString & aName, nsAString & aStr)
{
  nsIDOMElement      * node;
  nsIDOMHTMLDocument * doc = nsnull;
  mInternalBrowser->GetDocument(doc);
  if (nsnull != doc) 
	{
    if (NS_OK == doc->GetElementById(aName,   &node)) 
		{
      GetText(node, aStr);
      NS_RELEASE(node);
    }
    NS_RELEASE(doc);
  }
}

void CHTMLFormWindow::SetText(nsIDOMElement * aNode, const nsAString &aValue)
{
  nsIDOMHTMLInputElement * element;
  if (NS_OK == aNode->QueryInterface(kIDOMHTMLInputElementIID, (void**) &element)) 
	{
    element->SetValue(aValue);
    NS_RELEASE(element);
  }
}

void CHTMLFormWindow::SetText(const nsAString & aName, const nsAString & aStr)
{
  nsIDOMElement      * node;
  nsIDOMHTMLDocument * doc = nsnull;
  mInternalBrowser->GetDocument(doc);
  if (nsnull != doc) 
	{
    if (NS_OK == doc->GetElementById(aName,   &node)) 
		{
      SetText(node, aStr);
      NS_RELEASE(node);
    }
    NS_RELEASE(doc);
  }
}

