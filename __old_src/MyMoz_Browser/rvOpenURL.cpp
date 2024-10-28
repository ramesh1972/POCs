#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvFormWindow.h"
#include "rvMainWindow.h"
#include "rvParentWindow.h"
#include "rvOpenURL.h"

extern rvMyMozApp* theApp;

COpenURLWindow::COpenURLWindow() 
{
}

COpenURLWindow::~COpenURLWindow()
{
}

// Functions that do the opening and closing of this dialog
void COpenURLWindow::DoOpen()
{
	// create a new browser window, mInternalBrowser
	nsAutoString url(NS_LITERAL_STRING("file:///C:/MyMozFiles/AppFiles/openurl.html"));

	// This window should stick to the top
	mInternalBrowser = new rvMainWindow();

	NS_ADDREF_THIS();
	NS_ADDREF(mInternalBrowser);
	mInternalBrowser->mSubWinType = IIW_Form;
	mInternalBrowser->m_window_type = eWindowType_child;
	mInternalBrowser->m_border_style = eBorderStyle_default;
	mInternalBrowser->m_doc_pos = 2; // doc to the top
	mInternalBrowser->m_on_top = PR_TRUE;
	mInternalBrowser->m_resize = PR_FALSE;
	mInternalBrowser->mHeight= 30;

  mInternalBrowser->Init(theApp->mParentWindow, theApp->mAppShell, nsRect(0, 0, 0, 30), PR_TRUE);

  // load the page
  mInternalBrowser->GoTo(url);

  // add the browser
  theApp->mParentWindow->AddBrowser(mInternalBrowser);
	mInternalBrowser->m_form_browser_container = this;
}

void COpenURLWindow::DoClose()
{
}

// called back by the mInternalBrowser
void COpenURLWindow::InitializeListeners() 
{
	nsIDOMHTMLDocument *doc = nsnull;
  mInternalBrowser->GetDocument(doc);
  if (nsnull != doc) 
  {
		// walk the tree and get the dom elements that require event handlers
		// the url text box (change) 
		nsIDOMElement* textbox;
		doc->GetElementById(MozStr("textbox_url"), &textbox);
		EventSubscription* textbox_sub = new EventSubscription();
		textbox_sub->m_element = textbox;
		textbox_sub->m_event = MozStr("form");
		textbox_sub->m_event_type = MozStr("input");
		textbox_sub->m_handler = URLTextBox_Change;
		textbox_sub->m_form = this;

		// set the default url
		URLTextBox_Change(textbox, this);

		m_events.AppendElement((void*) textbox_sub);

		// the go button click/enter event
		nsIDOMElement* go;
		doc->GetElementById(MozStr("button_go"), &go);
		EventSubscription* bgo_sub = new EventSubscription();
		bgo_sub->m_element = go;
		bgo_sub->m_event = MozStr("mouse");
		bgo_sub->m_event_type = MozStr("click");
		bgo_sub->m_handler = GoButton_Click;
		bgo_sub->m_form = this;

		m_events.AppendElement((void*) bgo_sub);

	  NS_RELEASE(doc);
		CHTMLFormWindow::InitializeListeners();
  }
}

void COpenURLWindow::UninitializeListeners() 
{
	CHTMLFormWindow::UninitializeListeners();
}

// Event handlers
void URLTextBox_Change(nsIDOMElement* p_element, CHTMLFormWindow* p_form)
{
	COpenURLWindow* form = (COpenURLWindow*) p_form;
	nsCOMPtr<nsIDOMHTMLInputElement> node(p_element);
	node->GetValue(form->m_url);
}

void GoButton_Click(nsIDOMElement* p_element, CHTMLFormWindow* p_form)
{
	COpenURLWindow* form = (COpenURLWindow*) p_form;
		_ILOG(form->m_url);

	form->mInternalBrowser->mParent->GotoURLOnActiveWWWBrowser(form->m_url);
}



