#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvParentWindow.h"
#include "rvRuleCreator.h"
#include "rvDOMEventListener.h"
#include "rvRuleProcessor.h"
#include "rvRuleRenderer.h"
#include "rvFormWindow.h"

#include "rvMainWindow.h"

// externs
IAPPG;

// Main Interface Implements
NS_IMPL_THREADSAFE_ISUPPORTS4(rvMainWindow, nsIBaseWindow, nsIInterfaceRequestor, nsIWebShellContainer, nsIDOMFocusListener)

// =====================================================================================
// WINDOW FUNCTIONS
static nsEventStatus PR_CALLBACK HandleMainWindowEvent(nsGUIEvent *aEvent)
{ 
	try
	{
		nsEventStatus result = nsEventStatus_eIgnore;
		
		ON_THE_RUN(result)
		rvMainWindow* bw = IPWW->FindBrowserFor(aEvent->widget, FIND_WINDOW);
		if (bw != nsnull && bw->mBrowserIsExiting)
			return result;

		if (nsnull != bw) 
		{
			if (bw->mSubWinType != IIW_RuleProcessor && bw->mSubWinType != IIW_RuleProcessor_Popup)
			{
				nsCOMPtr<nsIWebBrowserFocus> focus = do_GetInterface(bw->mWebBrowser);
			
				if (focus)
					focus->Activate();
			}
				
			switch(aEvent->message) 
			{
				case NS_SIZE:
				{
					nsSizeEvent* sizeEvent;
					sizeEvent = (nsSizeEvent*)aEvent;  
					bw->Layout(sizeEvent->windowSize->width,
										 sizeEvent->windowSize->height);
					result = nsEventStatus_eConsumeNoDefault;

					break;
				}
				case NS_MOVE:
				{
					PRInt32 x,y, width, height;
					bw->GetPositionAndSize(&x,&y,&width, &height);
					bw->Layout(width, height);
					result = nsEventStatus_eConsumeNoDefault;

					break;
				}
				case NS_XUL_CLOSE:
				case NS_DESTROY:
				{
					ON_THE_RUN(nsEventStatus_eIgnore)
					ILOG << "Requested to Close Browser. About to Destroy Browser Window" << IINF;
					IPWW->CloseBrowserWindow(bw);
					NS_RELEASE(bw);
					result = nsEventStatus_eConsumeNoDefault;
					return result;
				}
				case NS_ACTIVATE:
				{
					nsCOMPtr<nsIWebBrowserFocus> focus = do_GetInterface(bw->mWebBrowser);
					if (focus)
						focus->Activate();
					result = nsEventStatus_eConsumeNoDefault;
				}
				break;
				case NS_DEACTIVATE:
				{
					nsCOMPtr<nsIWebBrowserFocus> focus = do_GetInterface(bw->mWebBrowser);
					if (focus)
						focus->Deactivate();
					result = nsEventStatus_eConsumeNoDefault;
			
				}
				break;
				default:
					break;
			}

			nsFocusEvent* fEvent = (nsFocusEvent*) aEvent;
			if (fEvent != nsnull && fEvent->isMozWindowTakingFocus && (bw->mSubWinType == IIW_WWW || bw->mSubWinType == IIW_WWW_Popup)) 
			{
				bw->mParent->SetActiveBrowser(bw);
				bw->mWindowTakingFocus = PR_TRUE;
				bw->OnDesignMode_HighlightElement();
			}

			NS_RELEASE(bw);
		}
  
		return result;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMainWindow's HandleMainWindowEvent" << IEXC;
		return nsEventStatus_eConsumeDoDefault;
	}
}

// =====================================================================================
// INIT/UNINT FUNCTIONS
void rvMainWindow::UnsetMembers()
{
	ILOG << "rvMainWindow::UnsetMembers()" << IINF;

  mApp = nsnull;
	mParent = nsnull;
  mAppShell = nsnull;
  mTitle = MozStr("");
  mWindow = nsnull;
 	m_window_type = eWindowType_toplevel;;
	m_border_style = eBorderStyle_default;
  mSubWinType = IIW_Unknown;
	mWidth = mHeight = 0;
	m_doc_pos = 0; // 0-no dock, 1-left, 2-top, 3-right,4-bottom
	m_on_top = PR_FALSE; // true means always on top
	m_resize = PR_TRUE; // true means user resizable, else false
	mMainAction = IIMA_Unknown;
	mWebBrowser = nsnull;
  mWebBrowserChrome = nsnull;
  mContentRoot = nsnull; // Points at the Root Content Node
  mChromeMask = nsIWebBrowserChrome::CHROME_ALL;
  mDocIsLoaded = PR_FALSE;
  mDataPath = nsnull;
	mIsInDesignMode = PR_FALSE;
	mWindowTakingFocus = PR_FALSE;
	m_dom_pick_listener = nsnull;  
	m_referer_browser = nsnull;
	m_form_browser_container = nsnull;
}

II_RESULT rvMainWindow::InitializeListeners()
{
	ILOG << "rvMainWindow::InitializeListeners()" << IINF;
	IL_TAB;

	// ----------------------------------------
	// create the frame tree
	nsIDOMHTMLDocument* doc;
	II_RESULT res = GetDocument(doc);

	if (doc == nsnull || res != IIR_SUCCESS)
	{
		ILOG << "Could not get document. Cannot initialize" << IFTL;
		ILOG << IMSG(res);
		IL_UNTAB;
		return res;
	}

	// ----------------------------------------
	// remove listening on existing document or create the event listeners for the action tracker for standard browser windows
	// since the document changes for every new page loaded, the listeners for the previsou document
	// have to be removed and later added for the current document
	if (mSubWinType == IIW_WWW)
	{
		if (m_dom_pick_listener != nsnull)
		{
			m_dom_pick_listener->RemoveListeners(this);
			ILOG << "Removed DOM Event Listeners: The Action Tracker: for the previous document" << IINF;
		}
		else
		{
			m_dom_pick_listener = new rvDOMEventListener();
			NS_ADDREF(m_dom_pick_listener);
			ILOG << "Created DOM Event Listener: The Action Tracker" << IINF;
		}
	}

	// same as above but for popup windows. Since popups can be connected to the referer windows, 
	// they should share the same DOM Event listener
	if (mSubWinType == IIW_WWW_Popup)
	{
		ILOG << "Setting DOM Event Listeners: The Action Tracker: for the a Popup Document" << IINF;
		if (m_referer_browser == nsnull)
		{
			m_dom_pick_listener = new rvDOMEventListener();
			ILOG << "Either the Referer browser is not set or was closed: SO creating a new DOM Event Listener: The Action Tracker" << IINF;
		}
		else
		{
			m_dom_pick_listener = m_referer_browser->m_dom_pick_listener;
			ILOG << "Set the Popups DOM Event Listener: The Action Tracker same as the referer Windows" << IINF;
		}

		NS_ADDREF(m_dom_pick_listener);
	}

	// ----------------------------------------
	// for all types of browser windows set frame info
	// clear the existing frame info
	ClearFrameTree(&m_root_frame);
	ILOG << "Cleared Previous document's frame info" << IINF;

	// create new frame info
	m_root_frame.m_doc = doc;
	NS_ADDREF(m_root_frame.m_doc);
	doc->GetURL(m_root_frame.m_url);
	m_root_frame.m_id = MozStr("0");
	m_root_frame.m_sub_frames = nsnull;
	
	ILOG << "-------------------------------------------------" << IINF;
	RecurseAndCreateFrameInfo(&m_root_frame);
	ILOG << "-------------------------------------------------" << IINF;

	ILOG << "Created frame info" << IINF;

	// ----------------------------------------
	// All window types require the focus listener
	// This enables bringing child windows to the front by clicking on the view area,
	// otherwise windows can be brought to front only be clicking on title bar, resizing etc..
	nsresult rv;
	nsIDOMEventReceiver * receiver;
	if (NS_OK == (rv = doc->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver))) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);
		mgr->AddEventListenerByIID((nsIDOMFocusListener*) this, kIDOMFocusListenerIID,NS_EVENT_FLAG_INIT);
		NS_RELEASE(receiver);
		NS_RELEASE(mgr);
		ILOG << "Initialized Focus Listener" << IINF;
	}
	else
		ILOG << "Failed to initialize Focus Listener:" << "rv:" << rv << IERR;

	// ----------------------------------------
	// if this is a form, do form specific uninitialize
	if (mSubWinType == IIW_Form && m_form_browser_container != nsnull)
	{
		m_form_browser_container->InitializeListeners();
		ILOG << "Initialized Form Listeners" << IINF;
		NS_RELEASE(doc);
		IL_UNTAB;
		return IIR_SUCCESS;
	}

	// ----------------------------------------
	// Listeners were removed above for the previous document.
	// add listeners for the new document
	if (mSubWinType == IIW_WWW || mSubWinType == IIW_WWW_Popup)
	{
		m_dom_pick_listener->AddListeners(this);
		ILOG << "Added DOM Event listeners for the new document" << IINF;
	}

	NS_RELEASE(doc);

	ILOG << "Completed listeners initialization" << IINF;
	IL_UNTAB;
	return IIR_SUCCESS;

}

II_RESULT rvMainWindow::UninitializeListeners()
{
	ILOG << "rvMainWindow::UninitializeListeners()" << IINF;
	IL_TAB;

	// ----------------------------
	// Get Document
	nsIDOMHTMLDocument* doc;
	II_RESULT res = GetDocument(doc);

	if (doc == nsnull || res != IIR_SUCCESS)
	{
		ILOG << "Could not get document. Cannot Uninitialize" << IFTL;
		ILOG << IMSG(res);
		IL_UNTAB;
		return res;
	}

	// -------------------------------
	// all browser types have the focus listeners added. So remove for all
	nsIDOMEventReceiver * receiver;
  if (NS_OK == doc->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);
    mgr->RemoveEventListenerByIID((nsIDOMFocusListener*) this, kIDOMFocusListenerIID,NS_EVENT_FLAG_INIT);
    NS_RELEASE(receiver);
		NS_RELEASE(mgr);
		ILOG << "Removed focus listener" << IINF;
  }
	else
		ILOG << "Not able to get the focus listener" << IERR;
		
	NS_RELEASE(doc);

	// ------------------------------
	// if this is a form, do form specific uninitialize
	if (mSubWinType == IIW_Form)
	{
		m_form_browser_container->UninitializeListeners();
		m_form_browser_container = nsnull;
		IL_UNTAB;
		return IIR_SUCCESS;
	}

	// for the main www browser and popups, remove listeners
	if (mSubWinType == IIW_WWW || mSubWinType == IIW_WWW_Popup)
	{
		if (m_dom_pick_listener != nsnull)
		{
			m_dom_pick_listener->RemoveListeners(this);
			NS_RELEASE(m_dom_pick_listener);
			m_dom_pick_listener = nsnull;
		}

		ILOG << "Removed DOM Event listeners" << IINF;
	}

	ILOG << "Completed Uninitialization" << IINF;
	IL_UNTAB;
	return IIR_SUCCESS;
}

// interface functions
nsresult rvMainWindow::GetInterface(const nsIID& aIID, void** aInstancePtrResult)
{
  NS_PRECONDITION(aInstancePtrResult, "null pointer");
  if (!aInstancePtrResult)
    return NS_ERROR_NULL_POINTER;

  if (aIID.Equals(NS_GET_IID(nsIWebBrowserChrome))) 
	{
    nsresult rv = EnsureWebBrowserChrome();
    if (NS_SUCCEEDED(rv))
      return mWebBrowserChrome->QueryInterface(aIID, aInstancePtrResult);
  }

  return QueryInterface(aIID, aInstancePtrResult);
}


NS_IMETHODIMP rvMainWindow::Destroy()
{
	ILOG << "rvMainWindow::Destroy()" << IINF;
	IL_TAB;
	try
	{
		mBrowserIsExiting = PR_TRUE;

		// important to remove listeners first
		ILOG << "About to remove all Listeners..." << IINF;
		UninitializeListeners();
		ILOG << "Unintialized all listeners" << IINF;

		// Others are holding refs to this, 
		// but it gets released OK.
		if (mWebBrowserChrome != nsnull)
		{
			nsWeakPtr weakling(do_GetWeakReference((nsIWebProgressListener*) mWebBrowserChrome));
			mWebBrowser->RemoveWebBrowserListener(weakling, NS_GET_IID(nsIWebProgressListener));
			mWebBrowser->SetContainerWindow(nsnull);

			NS_RELEASE(mWebBrowserChrome);
			delete mWebBrowserChrome;
			mWebBrowserChrome = nsnull;
			ILOG << "Destroyed Chrome" << IINF;
		}

		if (mWebBrowser != nsnull)
		{
			nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
			if (webBrowserWin != nsnull)
				webBrowserWin->Destroy();

			mWebBrowser = nsnull;
			ILOG << "Destroyed WebBrowser Embedded Window" << IINF;
		}

		if (mDocShell != nsnull)
		{
			nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
			mDocShell->SetAllowPlugins(PR_FALSE);
			webShell->SetContainer(nsnull);
			mDocShell = nsnull;
			ILOG << "Destroyed DocShell " << IINF;
		}

		if (mWindow != nsnull)
		{
			DestroyWidget(mWindow);	
			mWindow = nsnull;
			ILOG << "Destroyed Widget" << IINF;
		}

		if (mAppShell != nsnull)
		{
			NS_IF_RELEASE(mAppShell);
			ILOG << "Released App Shell" << IINF;
		}

		// Clear frame tree
		ClearFrameTree(&m_root_frame);
		ILOG << "Cleared Frame InfoTree " << IINF;

		UnsetMembers();
		ILOG << "Unintialized All Member" << IINF;

		ILOG << "Successfully destroyed browser" << IINF;
		IL_UNTAB;
		return NS_OK;
	}
	catch (...)
	{
		ILOG << "Caught Exception in rvMainWindow::Destroy" << IEXC;
		return NS_ERROR_FAILURE;
	}
}

NS_IMETHODIMP rvMainWindow::DestroyWidget(nsISupports* aWidget)
{
  if (aWidget) 
  {
    nsCOMPtr<nsIWidget> wdgt(do_QueryInterface(aWidget));
    if (wdgt) 
      wdgt->Destroy();
		else
			ILOG << "Widget is null for the browser" << IERR;
  }

  return NS_OK;
}

// =====================================================================================
// MAIN BROWSER FUNCTIONS
II_RESULT rvMainWindow::Init(rvParentWindow* aParWin, nsIAppShell* aAppShell, const nsRect& aBounds, PRBool aMakeVisible)
{
	try
	{
		ILOG << "rvMainWindow::Init() " << IINF;
		IL_TAB;

		ILOG << "Creating Browser" << IINF;

		// inits
		mParent = aParWin;
		mAppShell = aAppShell;
		NS_IF_ADDREF(mAppShell);

		mChromeMask = nsIWebBrowserChrome::CHROME_ALL;
		m_root_frame.m_doc = nsnull;

		// create the main widget
		nsresult rv = NS_OK;
		rv = nsComponentManager::CreateInstance(kChildCID, nsnull, kIWidgetIID, getter_AddRefs(mWindow));
		if (NS_OK != rv) 
		{
			IL_UNTAB;
			ILOG << "Failed to Create Child Window Instance" << IFTL;
			return IIR_FAILED_WIDGET_CREATE;
		}
		ILOG << "Created Child Window Instance" << IINF;

		// create the window
		nsWidgetInitData initData;
		initData.mWindowType = m_window_type;
		initData.mBorderStyle = m_border_style;
		initData.mListenForResizes = PR_TRUE;
		initData.clipChildren = PR_TRUE; 
		initData.clipSiblings = PR_TRUE;
  
		nsRect r(0, 0, aBounds.width, aBounds.height);
		mWindow->Create(mParent->mWindow, r, HandleMainWindowEvent, nsnull, aAppShell, nsnull, &initData);
		mWindow->Show(PR_FALSE);
		mWindow->GetClientBounds(r);
  
		ILOG << "Created child window" << IINF;

		// create the web browser
		mWebBrowser = do_CreateInstance(NS_WEBBROWSER_CONTRACTID);
		if (mWebBrowser == nsnull)
		{
			IL_UNTAB;
			ILOG << "Failed to Create Web Browser instance" << IFTL;
			return IIR_FAILED_WEB_BROWSER_CREATE;
		}

		nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
		rv = webBrowserWin->InitWindow(mWindow->GetNativeData(NS_NATIVE_WIDGET), nsnull, r.x, r.y, r.width, r.height);
		webBrowserWin->Create();
		ILOG << "Created web browser within child window" << IINF;

		if (EnsureWebBrowserChrome() != NS_OK)
		{
			IL_UNTAB;
			ILOG << "Failed to Create Chrome instance" << IFTL;
			return IIR_FAILED_CHROME_CREATE;
		}
		ILOG << "Created Chrome, the container" << IINF;

		mWebBrowser->SetContainerWindow(mWebBrowserChrome);
		nsWeakPtr weakling(do_GetWeakReference((nsIWebProgressListener*) mWebBrowserChrome));
		mWebBrowser->AddWebBrowserListener(weakling, NS_GET_IID(nsIWebProgressListener));
		ILOG << "Added chrome listener for the browser" << IINF;

		// set up the doc shell
		mDocShell = do_GetInterface(mWebBrowser);
		if (mDocShell == nsnull)
		{
			IL_UNTAB;
			ILOG << "Failed to Get DocShell instance" << IFTL;
			return IIR_FAILED_DOCSHELL;
		}
		ILOG << "Got DocShell Instance" << IINF;

		mDocShell->SetAllowPlugins(PR_TRUE);
		nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
		webShell->SetContainer((nsIWebShellContainer*) this);
		ILOG << "Have set this browser as the container of the webshell" << IINF;
		
		// layout the window
		ILOG << "Laying the window" << IINF;
		mWidth = r.width;
		mHeight = r.height;
		Layout(r.width, r.height);

		// bring to front
		ILOG << "Setting Focus" << IINF;
		Focus(nsnull);
		
		// visiblity
		if (aMakeVisible)
			MakeVisible();
		else
			MakeInvisible();

		mBrowserIsExiting = PR_FALSE;

		// return success
		ILOG << "Successfully Created Browser" << IINF;
		IL_UNTAB;
		
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMainWindow::Init()" << IEXC;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvMainWindow::GoTo(const nsString aURL)
{
	ILOG << "rvMainWindow::GoTo() "<< "URL = " << aURL << IINF;
	IL_TAB;

	if (aURL.Equals(NS_LITERAL_STRING("")))
	{
		ILOG << "Empty URL Sent" << IERR;
		IL_UNTAB;
		return IIR_INVALID_URL;
	}
	
	II_RESULT res = IIR_FAILED;
	mDocIsLoaded = PR_FALSE;
	if (mDocShell != nsnull)
	{
    nsCOMPtr<nsIWebNavigation> webNav(do_QueryInterface(mDocShell));
		if (webNav != nsnull)
		{
			nsresult rv;
			rv = webNav->LoadURI(aURL.get(), nsIWebNavigation::LOAD_FLAGS_NONE, nsnull, nsnull, nsnull);
			if (rv == NS_OK)
			{
				ILOG << "Sent request to load URI!" << IINF;
				res = IIR_SUCCESS;
			}
			else
			{
				ILOG << "Failed to send request via web navigation instance. rv:" << rv << IFTL;
				res = IIR_FAILED_URL_REQUEST;
			}
		}
		else
		{
			ILOG << "Not able to get web navigation instance" << IFTL;
			res = IIR_FAILED_WEB_NAV_INSTANCE;
		}
	}
	else
	{
		ILOG << "Doc Shell not set" << IFTL;
		res = IIR_NULL_DOCSHELL;
	}

	IL_UNTAB;
	return res;
}

II_RESULT rvMainWindow::WaitForDocumentToLoad()
{
	ILOG << "rvMainWindow::WaitForDocumentToLoad() " << IINF;
	IL_TAB;

	try
	{
		nsresult rv;
		nsCOMPtr<nsIEventQueueService> eqs = do_GetService(kEventQueueServiceCID, &rv);
		if (NS_FAILED(rv))
		{
			ILOG << "Failed to create instance " << "nsIEventQueueService" << IERR;
			IL_UNTAB;
			return IIR_FAILED;
		}

		rv = eqs->CreateMonitoredThreadEventQueue();
		if (NS_FAILED(rv))
		{
			ILOG << "Failed to create " << "MonitoredThreadEventQueue" << IERR;
			IL_UNTAB;
			return IIR_FAILED;
		}

		nsIEventQueue* gEventQ = nsnull;
		rv = eqs->GetThreadEventQueue(NS_CURRENT_THREAD, &gEventQ);
		if (NS_FAILED(rv))
		{
			ILOG << "Failed to create instance " << "nsIEventQueue" << IERR;
			IL_UNTAB;
			return IIR_FAILED;
		}

		II_RESULT res = IIR_FAILED;
		time_t tstart;
		time(&tstart);

		ILOG << "Waiting for document to be loaded.." << IINF;
		PRBool gKeepRunning = PR_TRUE;
		while (gKeepRunning)
		{
			time_t tend;
			time(&tend);
			double diff = difftime(tend, tstart);
			if (diff > II_DOCUMENT_LOAD_TIMEOUT)
			{
				ILOG << "Document Load Timed Out" << IFTL;
				res = IIR_TIMED_OUT;
				break;
			}

			gEventQ->ProcessPendingEvents();
			if (mDocIsLoaded)
			{
				ILOG << "Succesfully Loaded document" << IINF;
				res = IIR_SUCCESS;
				break;
			}
		}

		NS_RELEASE(gEventQ);
		IL_UNTAB;
		return res;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMainWindow::WaitForDocumentToLoad()" << IEXC;
		IL_UNTAB;
		return IIR_FAILED;
	}
}

NS_IMETHODIMP rvMainWindow::CreateEmptyDocument()
{
  nsIDOMHTMLDocument *htmlDoc = nsnull;
  nsIDOMWindow *aContentDOMWindow;
  mWebBrowser->GetContentDOMWindow(&aContentDOMWindow);
	 
  return NS_OK;
}

// =====================================================================================
// WINDOW FUNCTIONS
void rvMainWindow::MakeVisible()
{
	SetVisibility(PR_TRUE);
	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	if (webBrowserWin != nsnull)
		webBrowserWin->SetVisibility(PR_TRUE);
}

void rvMainWindow::MakeInvisible()
{
	SetVisibility(PR_FALSE);
	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	if (webBrowserWin != nsnull)
		webBrowserWin->SetVisibility(PR_FALSE);
}

NS_IMETHODIMP rvMainWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
{
	try
	{
		// push all the hidden windows to the side
		if (mSubWinType==IIW_RuleProcessor_Popup || mSubWinType==IIW_RuleProcessor)
		{
			MakeInvisible();
			SetPositionAndSize(0, 0, 0, 0, PR_FALSE);

			nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
			if (webBrowserWin != nsnull) 
				webBrowserWin->SetPositionAndSize(0, 0, 0, 0, PR_FALSE);

			return NS_OK;
		}

		// Lay out based on whether it is floating, docked, sliding, tabbed etc
		if (m_doc_pos == 0)
			LayoutDefault(aWidth, aHeight);
		else if (m_doc_pos == 1)
			LayoutLeftDockingWindow(aWidth, aHeight);
		else if (m_doc_pos == 2)
			LayoutTopDockingWindow(aWidth, aHeight);
		else if (m_doc_pos == 4)
			LayoutBottomDockingWindow(aWidth, aHeight);

		return NS_OK;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMainWindow::Layout()" << IEXC;
		return NS_ERROR_FAILURE;
	}
}

NS_IMETHODIMP rvMainWindow::LayoutDefault(PRInt32 aWidth, PRInt32 aHeight)
{
	// no layout for rule proecssing windows
	if (mSubWinType == IIW_RuleProcessor)
		return NS_OK;

	// Calculate docking bounds
	nsRect parent_bounds;
	mParent->GetWindowBounds(parent_bounds);

	PRBool docked_left = PR_FALSE;	PRBool docked_top = PR_TRUE;	PRBool docked_right = PR_FALSE;PRBool docked_bottom = PR_FALSE;
	PRInt32 dock_left=0, dock_top=50, dock_bottom=parent_bounds.height, dock_right=0;

	nsVoidArray* docked_windows = mParent->GetDockedWindows();
	if (docked_windows != nsnull)
	{
		for (PRInt32 idx=0; idx<docked_windows->Count();idx++)
		{
			rvMainWindow* browser = (rvMainWindow*) docked_windows->ElementAt(idx);
			nsRect dock_bounds;
			browser->GetWindowBounds(dock_bounds);
			if (browser->m_doc_pos == 1) // Top
			{
				docked_left = PR_TRUE;
				if (dock_bounds.x +dock_bounds.width> dock_left)
					dock_left = dock_bounds.x +dock_bounds.width;
			}
			if (browser->m_doc_pos == 2) // Top
			{
				docked_top = PR_TRUE;
				if (dock_bounds.y +dock_bounds.height> dock_top)
					dock_top = dock_bounds.y + dock_bounds.height;
			}
			else if (browser->m_doc_pos == 4) // Bottom
			{
				docked_bottom = PR_TRUE;
				if (dock_bounds.y < dock_bottom)
					dock_bottom = dock_bounds.y;
			}
		}
	}

	// original bounds
	nsRect fwb;
	GetWindowBounds(fwb);

	// expected bounds
	nsRect rr(0,0,aWidth,aHeight);
	PRBool repos_required = PR_FALSE;

	if (docked_left && fwb.x < dock_left)
	{
		repos_required =PR_TRUE;
		fwb.x = dock_left;
	}

	if (docked_top && fwb.y < dock_top)
	{
		repos_required =PR_TRUE;
		fwb.y = dock_top;
	}

	if (docked_bottom && fwb.y + fwb.height > dock_bottom)
	{
		repos_required =PR_TRUE;
		fwb.y = dock_bottom-fwb.height;
	}

	if (repos_required)
	{
		fwb.width < 0? 0:fwb.width;
		fwb.height < 0? 0:fwb.height;

		SetPositionAndSize(fwb.x-4, fwb.y-50, fwb.width, fwb.height, PR_TRUE);
	}

	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	if (webBrowserWin != nsnull) 
	{
		rr.width < 0? 0:rr.width;
		rr.height < 0? 0:rr.height;
		
		webBrowserWin->SetPositionAndSize(0, 0, rr.width, rr.height, PR_FALSE);
	}
	
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::LayoutLeftDockingWindow(PRInt32 aWidth, PRInt32 aHeight)
{
	nsRect parent_bounds;
	mParent->GetWindowBounds(parent_bounds);

	PRBool docked_left = PR_FALSE;	PRBool docked_top = PR_TRUE;	PRBool docked_right = PR_FALSE;PRBool docked_bottom = PR_FALSE;
	PRInt32 dock_left=0, dock_top=0, dock_bottom=parent_bounds.height, dock_right=0;

	nsVoidArray* docked_windows = mParent->GetDockedWindows();
	if (docked_windows != nsnull)
	{
		for (PRInt32 idx=0; idx<docked_windows->Count();idx++)
		{
			rvMainWindow* browser = (rvMainWindow*) docked_windows->ElementAt(idx);
			nsRect dock_bounds;
			browser->GetWindowBounds(dock_bounds);
			if (browser->m_doc_pos == 2) // Top
			{
				docked_top = PR_TRUE;
				if (dock_bounds.y +dock_bounds.height> dock_top)
					dock_top = dock_bounds.y + dock_bounds.height;
			}
		}
	}

	nsRect dwr(0,dock_top,mWidth, parent_bounds.height-dock_top);
	SetPositionAndSize(dwr.x, dwr.y-50, dwr.width, dwr.height, PR_FALSE);

	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	if (webBrowserWin != nsnull) 
			webBrowserWin->SetPositionAndSize(0, 0, dwr.width, dwr.height, PR_FALSE);
	
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::LayoutTopDockingWindow(PRInt32 aWidth, PRInt32 aHeight)
{
	nsRect parent_bounds;
	mParent->GetWindowBounds(parent_bounds);

	nsRect dwr(0,0,parent_bounds.width,mHeight);
	SetPositionAndSize(dwr.x, dwr.y, dwr.width, dwr.height, PR_FALSE);

	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	if (webBrowserWin != nsnull) 
			webBrowserWin->SetPositionAndSize(0, 0, dwr.width, dwr.height, PR_FALSE);
	
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::LayoutBottomDockingWindow(PRInt32 aWidth, PRInt32 aHeight)
{
	nsRect parent_bounds;
	mParent->GetWindowBounds(parent_bounds);

	nsRect dwr(0,parent_bounds.height-mHeight-55,parent_bounds.width, mHeight);
	SetPositionAndSize(dwr.x, dwr.y, dwr.width, dwr.height, PR_FALSE);

	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	if (webBrowserWin != nsnull) 
			webBrowserWin->SetPositionAndSize(0, 0, dwr.width, dwr.height, PR_FALSE);
	
	return NS_OK;
}

// ---------------------------------------------------------------------------------
NS_IMETHODIMP rvMainWindow::InitWindow(nativeWindow aParentNativeWindow, nsIWidget* parentWidget, PRInt32 x, PRInt32 y, PRInt32 cx, PRInt32 cy)   
{
   // Ignore wigdet parents for now.  Don't think those are a vaild thing to call.
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, cx, cy, PR_FALSE), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetWindow(nsIWidget** aWindow)
{
  if (aWindow && mWindow) 
  {
    *aWindow = mWindow.get();
    NS_IF_ADDREF(*aWindow);
    return NS_OK;
  }
  return NS_ERROR_FAILURE;
}

NS_IMETHODIMP rvMainWindow::Create()
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_UNEXPECTED;
}

NS_IMETHODIMP rvMainWindow::MoveTo(PRInt32 aX, PRInt32 aY)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Move(aX, aY);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SizeContentTo(PRInt32 aWidth, PRInt32 aHeight)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Resize(aWidth, aHeight, PR_FALSE);

  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight,
                              PRBool /*aWidthTransient*/,
                              PRBool /*aHeightTransient*/)
{
  return SizeContentTo(aWidth, aHeight);
}

NS_IMETHODIMP rvMainWindow::GetContentBounds(nsRect& aBounds)
{
  mWindow->GetClientBounds(aBounds);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetWindowBounds(nsRect& aBounds)
{
  mWindow->GetBounds(aBounds);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetFocus()
{
   //XXX First Check In
   //NS_WARNING("Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetMainWidget(nsIWidget** aMainWidget)
{
   NS_ENSURE_ARG_POINTER(aMainWidget);

   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetEnabled(PRBool *aEnabled)
{
  NS_ENSURE_ARG_POINTER(aEnabled);
  *aEnabled = PR_TRUE;
  if (mWindow)
    mWindow->IsEnabled(aEnabled);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetEnabled(PRBool aEnabled)
{
  if (mWindow)
    mWindow->Enable(aEnabled);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetBlurSuppression(PRBool *aBlurSuppression)
{
  NS_ENSURE_ARG_POINTER(aBlurSuppression);
  *aBlurSuppression = PR_FALSE;
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::SetBlurSuppression(PRBool aBlurSuppression)
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::GetVisibility(PRBool* aVisibility)
{
   NS_ENSURE_ARG_POINTER(aVisibility);

   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetVisibility(PRBool aVisibility)
{
   NS_ENSURE_STATE(mWindow);

   NS_ENSURE_SUCCESS(mWindow->Show(aVisibility), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Repaint(PRBool aForce)
{
   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetParentWidget(nsIWidget** aParentWidget)
{
   NS_ENSURE_ARG_POINTER(aParentWidget);
   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetParentWidget(nsIWidget* aParentWidget)
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::GetParentNativeWindow(nativeWindow* aParentNativeWindow)
{
   NS_ENSURE_ARG_POINTER(aParentNativeWindow);

   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetParentNativeWindow(nativeWindow aParentNativeWindow)
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::SetPosition(PRInt32 aX, PRInt32 aY)
{
   PRInt32 cx=0;
   PRInt32 cy=0;

   NS_ENSURE_SUCCESS(GetSize(&cx, &cy), NS_ERROR_FAILURE);
   NS_ENSURE_SUCCESS(SetPositionAndSize(aX, aY, cx, cy, PR_FALSE), 
      NS_ERROR_FAILURE);
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetPosition(PRInt32* aX, PRInt32* aY)
{
   return GetPositionAndSize(aX, aY, nsnull, nsnull);
}

NS_IMETHODIMP rvMainWindow::SetSize(PRInt32 aCX, PRInt32 aCY, PRBool aRepaint)
{
   PRInt32 x=0;
   PRInt32 y=0;

   NS_ENSURE_SUCCESS(GetPosition(&x, &y), NS_ERROR_FAILURE);
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, aCX, aCY, aRepaint), 
      NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetSize(PRInt32* aCX, PRInt32* aCY)
{
   return GetPositionAndSize(nsnull, nsnull, aCX, aCY);
}

NS_IMETHODIMP rvMainWindow::SetPositionAndSize(PRInt32 aX, PRInt32 aY, 
   PRInt32 aCX, PRInt32 aCY, PRBool aRepaint)
{
   NS_ENSURE_SUCCESS(mWindow->Resize(aX, aY, aCX, aCY, aRepaint), 
      NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetPositionAndSize(PRInt32* aX, PRInt32* aY, 
   PRInt32* aCX, PRInt32* aCY)
{
   nsRect bounds;

   NS_ENSURE_SUCCESS(mWindow->GetBounds(bounds), NS_ERROR_FAILURE);

   if(aX)
      *aX = bounds.x;
   if(aY)
      *aY = bounds.y;
   if(aCX)
      *aCX = bounds.width;
   if(aCY)
      *aCY = bounds.height;

   return NS_OK;
}

// web browser functions
NS_IMETHODIMP rvMainWindow::GetTitle(PRUnichar** aTitle)
{
   NS_ENSURE_ARG_POINTER(aTitle);

   *aTitle = ToNewUnicode(mTitle);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetTitle(const PRUnichar* aTitle)
{
   NS_ENSURE_STATE(mWindow);

   mTitle = aTitle;

   NS_ENSURE_SUCCESS(mWindow->SetTitle(nsAutoString(aTitle)), NS_ERROR_FAILURE);

   return NS_OK;
}

// =======================================================================
// CHROME/BROWSER FUNCTIONS
NS_IMETHODIMP rvMainWindow::GetChrome(PRUint32& aChromeMaskResult)
{
  aChromeMaskResult = mChromeMask;
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::EnsureWebBrowserChrome()
{
	ILOG << "rvMainWindow::EnsureWebBrowserChrome()" << IINF;
	IL_TAB;

	if (mWebBrowserChrome != nsnull)
	{
		ILOG << "Chrome Already Existing for this browser" << IINF;
		IL_UNTAB;
		return NS_OK;
	}

	mWebBrowserChrome = new nsWebBrowserChrome();
	NS_ENSURE_TRUE(mWebBrowserChrome, NS_ERROR_OUT_OF_MEMORY);

	NS_ADDREF(mWebBrowserChrome);
	mWebBrowserChrome->BrowserWindow(this);

	ILOG << "Created Chrome for this browser" << IINF;
	IL_UNTAB;
	
	return NS_OK;
}

//---------------------------------------------------------------------------------
NS_IMETHODIMP rvMainWindow::GetWebShell(nsIWebShell*& aResult)
{
  nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
  aResult = webShell;
  NS_IF_ADDREF(aResult);
  return NS_OK;
}

nsIPresShell* rvMainWindow::GetPresShellFor(nsIDocShell* aDocShell)
{
	ILOG << "rvMainWindow::GetPresShellFor()" << IDBG;
	nsresult rv = NS_ERROR_FAILURE;

	try
	{
		nsIPresShell* shell = nsnull;
		if (nsnull != aDocShell) 
		{
			ILOG << "Have nsIDocShell" << IDBG;

			nsIContentViewer* cv = nsnull;
			rv = aDocShell->GetContentViewer(&cv);
			if (nsnull != cv) 
			{
				ILOG << "Got nsIContentViewer" << IDBG;

				nsIDocumentViewer* docv = nsnull;
				rv = cv->QueryInterface(kIDocumentViewerIID, (void**) &docv);
				if (nsnull != docv) 
				{
					ILOG << "Got nsIDocumentViewer" << IDBG;

					nsCOMPtr<nsIPresContext> cx;
					rv = docv->GetPresContext(getter_AddRefs(cx));
					if (nsnull != cx) 
					{
						ILOG << "Got nsIPresContext" << IDBG;

						NS_IF_ADDREF(shell = cx->GetPresShell());
					}
					else
						ILOG << "rvMainWindow::GetPresShellFor(): nsIPresContext is NULL" << IERR;

					
					NS_RELEASE(docv);
				}
				else
					ILOG << "rvMainWindow::GetPresShellFor(): nsIDocumentViewer is NULL" << IERR;

				NS_RELEASE(cv);
			}
			else
				ILOG << "rvMainWindow::GetPresShellFor(): nsIConentViewer is NULL" << IERR;
		}
		else
			ILOG << "rvMainWindow::GetPresShellFor(): nsIDocShell is NULL" << IERR;

		if (shell == nsnull)
			ILOG << "rvMainWindow::GetPresShellFor():rv:" << rv << IERR;

		return shell;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMainWindow::GetPresForShell():" << "rv:" << rv << IEXC;
		return nsnull;
	}
}

NS_IMETHODIMP rvMainWindow::GetPresShell(nsIPresShell** aPresShell)
{  
	*aPresShell = GetPresShellFor(mDocShell);
	return NS_OK;
}

II_RESULT rvMainWindow::GetDocument(nsIDOMHTMLDocument *& aDocument)
{
	ILOG << "rvMainWindow::GetDocument()" << IDBG;
	IL_TAB;

	nsresult rv = NS_ERROR_FAILURE;

	try
	{
		nsIDOMHTMLDocument *htmlDoc = nsnull;
		nsIPresShell *shell = nsnull;
		GetPresShell(&shell);

		if (nsnull != shell) 
		{
			ILOG << "Got nsIPresShell" << IDBG;

			nsCOMPtr<nsIDocument> doc;
			rv = shell->GetDocument(getter_AddRefs(doc));
			if (doc) 
			{
				ILOG << "Got nsIDocument" << IDBG;

				rv = doc->QueryInterface(kIDOMHTMLDocumentIID,(void **)&htmlDoc);
			}
			else
				ILOG << "nsIDocument is NULL" << IERR;

			NS_RELEASE(shell);
		}
		else
			ILOG << "nsIPresShell is NULL" << IERR;

		aDocument = htmlDoc;
		if (htmlDoc != nsnull)
		{
			ILOG << "rvMainWindow:GetDocument() : Got Document" << IINF;
			IL_UNTAB;
			return IIR_SUCCESS;
		}
		else
		{
			ILOG << "rvMainWindow:GetDocument() : Document is NULL:" << "rv:" << rv << IERR;
			IL_UNTAB;
			return IIR_FAILED_GET_DOCUMENT;
		}
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMainWindow::GetDocument():" << "rv:" << rv << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

NS_IMETHODIMP rvMainWindow::ForceRefresh()
{
  nsIPresShell* shell;
  GetPresShell(&shell);
  if (nsnull != shell) 
  {
    nsCOMPtr<nsIViewManager> vm;
    shell->GetViewManager(getter_AddRefs(vm));
    if (vm) 
		{
      nsIView* root;
      vm->GetRootView(root);
      if (nsnull != root) 
			{
        vm->UpdateView(root, NS_VMREFRESH_IMMEDIATE);
      }
    }
    NS_RELEASE(shell);
  }
  return NS_OK;
}

// =====================================================================
// FRAME FUNCTIONS
void rvMainWindow::ClearFrameTree(Frame* p_frame)
{
	if (p_frame->m_doc != nsnull)
	{
		NS_IF_RELEASE(p_frame->m_doc);
		p_frame->m_doc = nsnull;
	}

	p_frame->m_url = MozStr("");
	p_frame->m_id = MozStr("");

	if (p_frame->m_sub_frames != nsnull)
	{
		PRInt32 idx = 0;
		PRInt32 count = p_frame->m_sub_frames->Count();
		while(idx < count)
		{
			Frame* frm = (Frame*) (p_frame->m_sub_frames->ElementAt(idx++));
			ClearFrameTree(frm);
			if (frm->m_doc != nsnull)
				NS_IF_RELEASE(frm->m_doc);
			delete frm;
			frm=nsnull;
		}

		p_frame->m_sub_frames->Clear();
		delete p_frame->m_sub_frames;
		p_frame->m_sub_frames = nsnull;
	}
}

void rvMainWindow::RecurseAndCreateFrameInfo(Frame *p_frame)
{
	ILOG << "Frame URL:" << p_frame->m_url << IINF;
	ILOG << "Frame Location:" << p_frame->m_id << IINF;
	IL_TAB;

	nsIDOMHTMLDocument* doc = p_frame->m_doc;
	PRInt32 frm_cnt = 1;

	nsIDOMNodeList* list;
	doc->GetElementsByTagName(MozStr("frame"), &list);
	PRUint32 len=0;

	// process normal <frame> tags
	if (list != nsnull)
	{
		list->GetLength(&len);
		if (len > 0)
			p_frame->m_sub_frames = new nsVoidArray();

		for (PRUint32 idx=0;idx<len;idx++)
		{
			nsIDOMNode* node;
			list->Item(idx, &node);
			nsCOMPtr<nsIDOMHTMLFrameElement> frame = do_QueryInterface(node);
			nsIDOMDocument* doc; frame->GetContentDocument(&doc);
			nsCOMPtr<nsIDOMHTMLDocument> frame_doc = do_QueryInterface(doc);
			
			// create frame info
			Frame *frm = new Frame();
			frm->m_doc = frame_doc;
			NS_ADDREF(frm->m_doc);
			frame_doc->GetURL(frm->m_url);
			frm->m_id.Append(p_frame->m_id);
			frm->m_id.Append(MozStr("-"));
			frm->m_id.AppendInt(frm_cnt++);
			frm->m_sub_frames = nsnull;

			p_frame->m_sub_frames->AppendElement((void*) frm);

			NS_RELEASE(doc);
			RecurseAndCreateFrameInfo(frm);
		}

		NS_RELEASE(list);
	}

	doc->GetElementsByTagName(MozStr("iframe"), &list);
	len=0;

	// process normal <iframe> tags
	if (list != nsnull)
	{
		list->GetLength(&len);
		if (p_frame->m_sub_frames == nsnull && len > 0)
			p_frame->m_sub_frames = new nsVoidArray();

		for (PRInt32 idx=0;idx<len;idx++)
		{
			nsIDOMNode* node;
			list->Item(idx, &node);
			nsCOMPtr<nsIDOMHTMLIFrameElement> frame = do_QueryInterface(node);
			nsIDOMDocument* doc; frame->GetContentDocument(&doc);
			nsCOMPtr<nsIDOMHTMLDocument> frame_doc = do_QueryInterface(doc);
			
			// create frame info
			Frame *frm = new Frame();
			frm->m_doc = frame_doc;
			NS_ADDREF(frm->m_doc);
			frame_doc->GetURL(frm->m_url);
			frm->m_id.Append(p_frame->m_id);
			frm->m_id.Append(MozStr("-"));
			frm->m_id.AppendInt(frm_cnt++);
			frm->m_sub_frames = nsnull;

			p_frame->m_sub_frames->AppendElement((void*) frm);

			NS_RELEASE(doc);
			RecurseAndCreateFrameInfo(frm);
		}

		NS_RELEASE(list);
	}

	IL_UNTAB;
}

// =====================================================================
// EVENT HANDLERS
// progress listeners. Fired by chrome object
NS_IMETHODIMP rvMainWindow::WillLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsLoadType aReason)
{
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::BeginLoadURL(nsIWebShell* aShell, const PRUnichar* aURL)
{
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::ProgressLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, PRInt32 aProgress, PRInt32 aProgressMax)
{
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::EndLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsresult aStatus)
{
	ILOG << "rvMainWindow::EndLoadURL()" << IINF;
	IL_TAB;

	ILOG << "About to initialize listeners" << IINF;
	InitializeListeners();

	mDocIsLoaded = PR_TRUE;

	ILOG << "-------------------------------------------------------------" << IINF;
	ILOG << "rvMainWindow::EndLoadURL() --- Document Loaded" << IINF;
	ILOG << "-------------------------------------------------------------" << IINF;

	IL_UNTAB;
	return NS_OK;
}

//---------------------------------------------------------------------------------
// focus listener. THis is required for bring child windows to front on clickng in the view region
NS_IMETHODIMP rvMainWindow::HandleEvent(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Focus(nsIDOMEvent* aEvent)
{
	mWindow->PlaceBehind(eZPlacementTop, nsnull, PR_TRUE);
	mParent->SetActiveBrowser(this);
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Blur(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

// ==========================================================================
// Pagelet service: Merge, alert, process rules etc.. related functions
void rvMainWindow::OnDesignMode_HighlightElement()
{
	if (mWindowTakingFocus)
	{
		nsILayoutDebugger* ld;
		nsresult rv = nsComponentManager::CreateInstance(kLayoutDebuggerCID,
																										nsnull,
																										kILayoutDebuggerIID,
                                                    (void **)&ld);

		if (NS_SUCCEEDED(rv)) 
		{
			ld->SetShowEventTargetFrameBorder(mIsInDesignMode);
			ForceRefresh();
			NS_RELEASE(ld);
		}			 
	}
}

// ==================================================================
// PERSIST
II_RESULT rvMainWindow::ArchivePage(nsAutoString path_file_name)
{
	try
	{
		ILOG << "rvMainWindow::ArchivePage():" << "path_file_name:" << path_file_name << IINF;
		IL_TAB;

		nsAutoString szDataFile1;
		nsAutoString szFile_URI1;

		if (path_file_name == MozStr(""))
		{
			ILOG << "Empty File Name Passed" << IERR;
			IL_UNTAB;
			return IIR_INVALID_FILE_NAME;
		}

		ILOG << "About to persist document" << IINF;

		// Create File Path and Name
		// unique time based folder
		time_t t1;
		time(&t1);
		tm *t = localtime(&t1);
		char buft[12];
		sprintf(buft,"%d_%d_%d", t->tm_hour,t->tm_min,t->tm_sec);

		// data path
		szDataFile1.Append(PWW_DATA_ROOT);
		szDataFile1.Append(PWW_ARCHIVE_DIR);
		szDataFile1.Append(NS_LITERAL_STRING("\\PWW\\"));
		szDataFile1.Append(path_file_name);
		szDataFile1.Append(NS_LITERAL_STRING("_files\\"));
		
		char tempbuf[1024];
		szDataFile1.ToCString(tempbuf,szDataFile1.Length()+1);
		PR_MkDir(tempbuf, PR_RDWR);

		szDataFile1.AppendWithConversion(buft);
		szDataFile1.ToCString(tempbuf,szDataFile1.Length()+1);
		PR_MkDir(tempbuf, PR_RDWR);
		szDataFile1.Append(NS_LITERAL_STRING("\\"));

		szFile_URI1.Append(szDataFile1);
		szFile_URI1.Append(NS_LITERAL_STRING("rendered.html"));

		nsCOMPtr<nsILocalFile> file;
		nsCString szCFile_URI1;
		LossyCopyUTF16toASCII(szFile_URI1, szCFile_URI1);
		NS_NewNativeLocalFile(szCFile_URI1, PR_TRUE, getter_AddRefs(file));

		nsCOMPtr<nsILocalFile> dataPath;
		nsCString szCDataFile1;
		LossyCopyUTF16toASCII(szDataFile1, szCDataFile1);
		NS_NewNativeLocalFile(szCDataFile1, PR_TRUE, getter_AddRefs(dataPath));

		ILOG << "File:" << szFile_URI1 << IINF;
		ILOG << "Path:" << szDataFile1 << IINF;

		// Get the document
		nsIDOMHTMLDocument* doc;
		II_RESULT res = GetDocument(doc);

		if (doc == nsnull || res != IIR_SUCCESS)
		{
			ILOG << "Persist Failed because of Null document" << IERR;
			IL_UNTAB;
			return res;
		}

		nsCOMPtr<nsIDOMDocument> domdoc = do_QueryInterface(doc);
		if (!domdoc)
		{
			ILOG << "Persist Failed to get nsIDOMDocument" << IERR;
			IL_UNTAB;

			return IIR_FAILED_GET_DOMDOCUMENT;
		}

		ILOG << "Got DOM Document" << IINF;

		// Create a throwaway persistence object to do the work
		nsresult rv;
		nsCOMPtr<nsIWebBrowserPersist> persist;
		persist = do_CreateInstance(NS_WEBBROWSERPERSIST_CONTRACTID, &rv);
		 
		persist->SetPersistFlags(nsIWebBrowserPersist::PERSIST_FLAGS_DONT_CHANGE_FILENAMES | 
														 nsIWebBrowserPersist::PERSIST_FLAGS_FIXUP_ORIGINAL_DOM |
														 nsIWebBrowserPersist::PERSIST_FLAGS_SERIALIZE_OUTPUT);
		
		ILOG << "About to call SaveDocument..." << IINF;
		rv = persist->SaveDocument(domdoc, file, dataPath, "text/html", nsIWebBrowserPersist::ENCODE_FLAGS_ABSOLUTE_LINKS, 0);
		ILOG << "Returned from SaveDocument:rv:" << rv << IINF;

		// Set the document URI 
		nsCOMPtr<nsIDocument> doc1 = do_QueryInterface(domdoc);
		if (!doc1) 
		{
			ILOG << "Unable to Set Document URI" << IERR;
			IL_UNTAB;
			return IIR_FAILED_GET_IDOCUMENT;
		}

		ILOG << "Got nsIDocument" << IINF;

		nsAutoString file_prot;
		file_prot.Append(NS_LITERAL_STRING("file:///"));
		file_prot.Append(szFile_URI1);
		file_prot.ReplaceChar('\\', '/');

		nsIURI* uri;
		NS_NewURI(&uri,file_prot);
		doc1->SetDocumentURI(uri);
		doc1->SetBaseURI(uri);

		NS_RELEASE(uri);
		NS_RELEASE(doc);

		persist = nsnull;
		ILOG << "Successfully Set Base URI and Persisted" << IINF;
		IL_UNTAB;

		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception In rvMainWindow::ArchivePage()" << IEXC;
		return IIR_EXCEPTION;
	}
}

// ==============================================================================
// utility functions
nsAutoString rvMainWindow::GetSubWndTypeText()
{
	if (mSubWinType == IIW_WWW)
		return MozStr("IIW_WWW"); 
	else if (mSubWinType == IIW_WWW_Popup)
		return MozStr("IIW_WWW_Popup"); 
	else
		return MozStr("IIW_NotSupported"); 
}

void rvMainWindow::DumpStyles()
{
	nsIPresShell* shell;
	GetPresShell(&shell);

  if (nsnull != shell) 
  {
    nsCOMPtr<nsIDocument> doc;
    shell->GetDocument(getter_AddRefs(doc));

	  PRInt32 i  = doc->GetNumberOfStyleSheets(PR_TRUE);
	  for (int idx=0;idx<i;idx++)
	  {
		  nsIStyleSheet* sheet= doc->GetStyleSheetAt(idx, PR_TRUE);
		  

		  nsCOMPtr<nsICSSStyleSheet> cssSheet = do_QueryInterface(sheet);
		  if (cssSheet) 
		  {
			  PRInt32 rul_cnt;
			  cssSheet->StyleRuleCount(rul_cnt);
			  nsICSSRule* rule;

			  for(int idx1 = 0;idx1<rul_cnt;idx1++) 
			  {
					cssSheet->GetStyleRuleAt(idx1, rule);
					nsCOMPtr<nsICSSStyleRule> cssRule = do_QueryInterface(rule);

					if (cssRule == nsnull)
						return;

					nsAutoString cssText;
					cssRule->GetSelectorText(cssText);

					char* buf = new char[100];
					buf = cssText.ToCString(buf, 100, 1);

					fputs(buf, stdout);
					fputs("\n", stdout);
					delete buf;
				}
			}
		} 

		NS_RELEASE(shell);
	}
	else 
	{
		fputs("null pres shell\n", stdout);
	}
}

void rvMainWindow::DumpChildren(nsIDOMNode* elem)
{
	if (elem == nsnull)
		return;

	nsAutoString name;
	nsAutoString val;

	elem->GetNodeName(name);
	elem->GetNodeValue(val);

	PRBool yes = PR_FALSE;
	elem->HasAttributes(&yes);

	if (yes)
	{
		nsIDOMNamedNodeMap* map;
		elem->GetAttributes(&map); 

		PRUint32 cnt;
		map->GetLength(&cnt);
		for (int idx=0; idx<cnt;idx++)
		{
			nsIDOMNode* attr;
			map->Item(idx, &attr);

			nsAutoString namea;
			nsAutoString vala;
			attr->GetNodeName(namea);
			attr->GetNodeValue(vala);
		}
	}

	elem->HasChildNodes(&yes);
	if (yes)
	{
		nsIDOMNodeList* node_list;
		elem->GetChildNodes(&node_list);
		PRUint32 cnt;
		node_list->GetLength(&cnt);
		for (PRInt32 idx=0; idx< cnt;idx++) 
		{
			nsIDOMNode* child;
			node_list->Item(idx, &child);
			nsString name(NS_LITERAL_STRING(""));
			child->GetNodeName(name); 
			DumpChildren(child);
		}
	}
}

// Unused functions
// PWW functions
NS_IMETHODIMP rvMainWindow::MouseClick_MoveToPWW(nsIDOMEvent* aMouseEvent)
{
	if (mParent->mActivePWWBrowser == NULL)
			return NS_OK;

	// move style sheets
	if (mIsStyleSheetsMoved == PR_FALSE) 
	{
		ArchivePage(MozStr("temp"));
		mIsStyleSheetsMoved = PR_TRUE;
	}

	// move the element
	// get the current item selected or clicked
	nsCOMPtr<nsIDOMEventTarget> target;
	aMouseEvent->GetTarget(getter_AddRefs(target));
	nsCOMPtr<nsIDOMNode> node(do_QueryInterface(target));
	nsCOMPtr<nsIContent> nodec(do_QueryInterface(target));

	// clone this browser content
	nsIDOMNode* act_node = nsnull; // TODO
	if (act_node == nsnull)
		return NS_OK;

	nsIDOMNode* node_new_clone;
	act_node->CloneNode(PR_TRUE, &node_new_clone);

	// add it to the PWW Window
	// get the body of the active PWW window
	nsIDOMHTMLDocument * aDocument;
	mParent->mActivePWWBrowser->GetDocument(aDocument);

	nsIDOMHTMLElement* body;
	aDocument->GetBody(&body);

	nsIDOMNode* node_new;
	body->AppendChild(node_new_clone, &node_new);

	aMouseEvent->StopPropagation();
	aMouseEvent->PreventDefault();
	//aMouseEvent->flags = NS_EVENT_FLAG_STOP_DISPATCH;
	return NS_OK;
}
