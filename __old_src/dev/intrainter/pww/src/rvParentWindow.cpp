#include "rvXPCOMIDs.h"
#include "../res/resource.h"
#include "rvMyMozApp.h"
#include "rvMainWindow.h"
#include "rvOpenURL.h"
#include "rvXmlDocument.h"
#include "rvRuleProcessor.h"
#include "rvRulesProcessor.h"
#include "rvRulesCollection.h"
#include "rvParentWindow.h"

extern HINSTANCE gInstance, gPrevInstance;

// externs
IAPPG;

// global functions
static PRBool GetFileFromFileSelector(nsIDOMWindowInternal* aParentWindow,  nsILocalFile **aFile, nsILocalFile **aDisplayDirectory);
static nsEventStatus PR_CALLBACK HandleParentWindowEvent(nsGUIEvent *aEvent);

// =================================================================================
// xpcom interfaces
NS_IMPL_ISUPPORTS2(rvParentWindow, nsIBaseWindow, nsIInterfaceRequestor)

nsresult rvParentWindow::GetInterface(const nsIID& aIID, void** aInstancePtrResult)
{
  NS_PRECONDITION(aInstancePtrResult, "null pointer");
  if (!aInstancePtrResult)
    return NS_ERROR_NULL_POINTER;

  return QueryInterface(aIID, aInstancePtrResult);
}

// ====================================================================================
// actions dispatcher
// Event handlers
static nsEventStatus PR_CALLBACK HandleParentWindowEvent(nsGUIEvent *aEvent)
{ 
	try
	{
		// This is important
		ON_THE_RUN(nsEventStatus_eIgnore)

		// process the event
		nsEventStatus result = nsEventStatus_eIgnore;
		switch(aEvent->message)
		{
			case NS_SIZE:
			{
				nsSizeEvent* sizeEvent;
				sizeEvent = (nsSizeEvent*)aEvent;
				
				ON_THE_RUN(nsEventStatus_eIgnore)	
				IPWW->Layout(sizeEvent->windowSize->width, sizeEvent->windowSize->height);

				result = nsEventStatus_eConsumeNoDefault;
				break;
			}
			case NS_PAINT:
			{
				nsRect bounds;
				nsPaintEvent *pe = (nsPaintEvent *)aEvent;
				pe->widget->GetClientBounds(bounds);
				
				nsIRenderingContext *cx = pe->renderingContext;
				cx->SetColor(NS_RGB(160, 160, 160));
				cx->FillRect(0, 0, bounds.width, bounds.height);
				
				result = nsEventStatus_eConsumeDoDefault;
				break;
			}
			case NS_XUL_CLOSE:
			case NS_DESTROY:
			{
				ON_THE_RUN(nsEventStatus_eIgnore)
				ILOG << "Requested to Close Application" << IINF;
				ILOG << "About to Exit Application.." << IINF;
				IAPP->Exit();
				
				result = nsEventStatus_eConsumeDoDefault;
				break;
			}
			case NS_MENU_SELECTED:
			{
				ON_THE_RUN(nsEventStatus_eIgnore)
				result = IPWW->DispatchMenuItem(((nsMenuEvent*)aEvent)->mCommand);
				break;
			}
			default:
				break;
			}
    
		return result;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow's HandleParentWindowEvent" << IEXC;
		return nsEventStatus_eIgnore;
	}
}

nsEventStatus rvParentWindow::DispatchMenuItem(PRInt32 aID)
{
	try
	{
		ILOG << "rvParentWindow::DispatchMenuItem" << IINF;
		IL_TAB;

		ILOG << "--------------------------------------------------------" << IINF;
		ILOG << "Dispatching Action" << IINF;

		// make sure the application is alive
		ON_THE_RUN(nsEventStatus_eIgnore)

		// Dispatch windows-only menu code goes here
		switch(aID)
		{
			case ID_WWW_OPEN:
			{
				ILOG << "Action: OpenFromFileDialog" << IINF;
				DoFileOpen();
				break;
			}
			case ID_WWW_SAVEPAGE:
			{
				ILOG << "Action: SavePage" << IINF;
				if (mActiveWWWBrowser != nsnull && !mActiveWWWBrowser->mBrowserIsExiting) 
					mActiveWWWBrowser->ArchivePage(MozStr("temp"));
				break;
			}
			case ID_CHROMIUM_CREATEWINDOW:
			{
				ILOG << "Action: NewBrowser" << IINF;

				rvMainWindow* Win = new rvMainWindow();
				OpenEmptyBrowser(Win, eWindowType_toplevel, eBorderStyle_default, IIW_WWW, 0, PR_FALSE);
				break;
			}
			case ID_PWW_IMERGE_WWWPWWBEGIN:
			case ID_ALERT_ALERTDESIGNMODE:
			{
				ILOG << "Action: SetPickMode" << IINF;
				if (mActiveWWWBrowser != nsnull && !mActiveWWWBrowser->mBrowserIsExiting) 
				{
					mActiveWWWBrowser->mMainAction = IIMA_Merge;
					mActiveWWWBrowser->mIsInDesignMode = !IPWW->mActiveWWWBrowser->mIsInDesignMode;
					mActiveWWWBrowser->OnDesignMode_HighlightElement();
				}
				break;
			}
			case ID_PWW_IMERGE_CREATEWINDOW:
			{
				ILOG << "Action: NewMergePage" << IINF;

				rvMainWindow* Win = new rvMainWindow();
				OpenEmptyBrowser(Win, eWindowType_toplevel, eBorderStyle_default, IIW_WWW, 0, PR_FALSE);
				break;
			}
			case ID_WWW_SHOWTOOLBAR:
			{
				ILOG << "Action: ShowLocationControls" << IINF;
				COpenURLWindow* url_wnd = new COpenURLWindow();
				url_wnd->DoOpen(); 
				break;
			}
			case ID_CHROMIUM_TODAY_SITE1:
			{
				ILOG << "Action: LoadSampleSite1" << IINF;

				nsAutoString url(PWW_DATA_ROOT_FILE_PROTOCOL);
				url.Append(PWW_TEST_DIR);
				url.Append(NS_LITERAL_STRING("/Mozilla_Pages/"));
				url.Append(NS_LITERAL_STRING("test0.html"));

				rvMainWindow* Win = new rvMainWindow();
				OpenStandardBrowser(url, Win);

				break;
			}
			case ID_CHROMIUM_TODAY_SITE2:
			{
				ILOG << "Action: LoadSampleSite2" << IINF;

				nsAutoString url(PWW_DATA_ROOT_FILE_PROTOCOL);
				url.Append(PWW_TEST_DIR);
				url.Append(NS_LITERAL_STRING("/Mozilla_Pages/"));
				url.Append(NS_LITERAL_STRING("test1.html"));

				rvMainWindow* Win = new rvMainWindow();
				OpenStandardBrowser(url, Win);

				break;
			}
			case ID_CHROMIUM_EXIT:
			{
				ILOG << "Action: ExitApplication" << IINF;

				IAPP->Exit();
				return nsEventStatus_eConsumeNoDefault;
			}
			case ID_ALERT_LOADTESTPAGE:
			{
				ILOG << "Action: LoadSampleSite1" << IINF;

				nsAutoString url(PWW_DATA_ROOT_FILE_PROTOCOL);
				url.Append(PWW_TEST_DIR);
				url.Append(NS_LITERAL_STRING("/Mozilla_Pages/"));
				url.Append(NS_LITERAL_STRING("test0.html"));

				rvMainWindow* Win = new rvMainWindow();
				OpenStandardBrowser(url, Win);
				break;
			}
			case ID_ALERT_LOADALERTEDPAGE:
			{
				ILOG << "Action: AlertPageLets" << IINF;

				CRuleProcessor::m_always_show = PR_FALSE;
				CRulesProcessor* proc = new CRulesProcessor();
				proc->ProcessRules();
				delete proc;
				proc = nsnull;
				break;
			}
			case ID_TESTS_LOADSPOTTEDNODE:
			{
				ILOG << "Action: ShowtPageLets" << IINF;

				CRuleProcessor::m_always_show = PR_TRUE;
				CRulesProcessor* proc = new CRulesProcessor();
				proc->ProcessRules();
				delete proc;
				proc = nsnull;
				break;
			}
			case ID_RULESDB_CLEARRULES:
			{
				ILOG << "Action: ClearPageLetRules" << IINF;

				CRulesCollection* col = new CRulesCollection();
				col->ClearRules(); 
				delete col;
				col = nsnull;
  			break;
			}
		}
		
		ILOG << "Dispatched" << IINF;
		ILOG << "--------------------------------------------------------" << IINF;
		IL_UNTAB;
		// Dispatch xp menu items

		return nsEventStatus_eIgnore;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::DispatchMenuItem()" << IEXC;
		return nsEventStatus_eIgnore;
	}
}

// =============================================================================
// cons/destr
rvParentWindow::rvParentWindow()
{
	ILOG << "rvParentWindow::rvParentWindow()" << IINF;

  mApp = nsnull;
  mAppShell = nsnull;
  mTitle = MozStr("");

	m_browsers = nsnull;
	mActiveWWWBrowser = nsnull;
	mActivePWWBrowser = nsnull;

  mActiveWWWBrowser = nsnull;
  mActivePWWBrowser = nsnull;
	mActiveAlertBrowser = nsnull;
	mActiveFormBrowser = nsnull;

  mWindow = nsnull;
}

rvParentWindow::~rvParentWindow()
{
	ILOG << "rvParentWindow::~rvParentWindow()" << IINF;
}

NS_IMETHODIMP rvParentWindow::Destroy()
{
	try
	{
		ILOG << "rvParentWindow::Destroy()" << IINF;
		IL_TAB;

		// Close all the child windows
		II_RESULT res = CloseAllWindows();
		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed to close all child windows" << IERR;
			ILOG << "Continuing..." << IINF;
		}
		// close the current widget
		DestroyWidget(mWindow);
		mWindow = nsnull;

		if (mAppShell != nsnull)
		{
			NS_IF_RELEASE(mAppShell);
			mAppShell = nsnull;
		}
		
		ILOG << "Destroyed AppShell" << IINF;

		mApp = nsnull;
		mTitle = MozStr("");

		m_browsers = nsnull;
		mActiveWWWBrowser = nsnull;
		mActivePWWBrowser = nsnull;
		mActiveAlertBrowser = nsnull;
		mActiveFormBrowser = nsnull;

		mFloatingWindows.Clear();
		mDockedWindows.Clear();

		// destroy the rules xml db object
		m_rules_loader->DestroyRulesObject();
		ILOG << "Destroyed XML DB Object" << IINF;

		delete m_rules_loader;
		m_rules_loader = nsnull;

		IL_UNTAB;
		return NS_OK;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::Destroy()" << IEXC;
		IL_UNTAB;
		return NS_ERROR_FAILURE;
	}
}

// ================================================================================
// main window functions
II_RESULT rvParentWindow::Init(nsIAppShell* aAppShell, const nsRect& aBounds)
{
	try
	{
		ILOG << "rvParentWindow::Init()" << IINF;
		IL_TAB;

		// make sure the browser collection is et
		if (m_browsers == nsnull) 
			m_browsers = new nsVoidArray();
		ILOG << "Initialized browser collection" << IINF;

		mAppShell = aAppShell;
		NS_IF_ADDREF(mAppShell);

		// create the main window
		ILOG << "Creating top level widget instance" << IINF;
		nsresult rv = nsComponentManager::CreateInstance(kWindowCID, nsnull,  kIWidgetIID, getter_AddRefs(mWindow));
		if (NS_OK != rv)
		{
			ILOG << "Failed while creating widget instance via XPCOM. Should exit application. errorcode:" << rv << IFTL;
			IL_UNTAB;
			return IIR_CREATE_INSTANCE_FAILED;
		}
		ILOG << "Created top level widget instance" << IINF;

		nsWidgetInitData initData;
		initData.mWindowType = eWindowType_toplevel;
		initData.mBorderStyle = eBorderStyle_all;
		initData.clipChildren = PR_TRUE;
		initData.clipSiblings = PR_TRUE;

		ILOG << "Creating Main Frame Window" << IINF;
		rv = mWindow->Create((nsIWidget*) NULL, aBounds, HandleParentWindowEvent, nsnull, aAppShell, nsnull, &initData);
		if (NS_OK != rv)
		{
			ILOG << "Failed while creating main widget. Should exit application. errorcode:" << rv << IFTL;
			IL_UNTAB;
			return IIR_FAILED_WIDGET_CREATE;
		}

		SetTitle(L"Welcome to IntraInter.com");
		ILOG << "Created Main Frame Window" << IINF;

		// create the menu
		HMENU menu = ::LoadMenu(gInstance, "IDR_MENU_PWW");
		HWND hwnd = (HWND)mWindow->GetNativeData(NS_NATIVE_WIDGET);
		::SetMenu(hwnd, menu);
    
		// Layout
		nsRect parentBounds;
		mWindow->GetClientBounds(parentBounds);

		// start with a position at the top/left of the screen
		parentBounds.x = parentBounds.y = 0;
		Layout(parentBounds.width, parentBounds.height);

		// make it visible
		mWindow->Show(PR_TRUE);

		// Load the Rules DB to XML
		m_rules_loader = new CRuleBase();
		m_rules_loader->LoadRules();
		ILOG << "Loaded PageLet Processing Rules" << IINF;

		// return success
		ILOG << "Successfully created PWW Client" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::Init()" << IEXC;
		IL_UNTAB;

		return IIR_EXCEPTION;
	}
}

NS_IMETHODIMP rvParentWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
{
	try
	{
		// first all the docking windows
		for (PRInt32 idx=0; idx<mDockedWindows.Count();idx++)
		{
			rvMainWindow* browser = (rvMainWindow*) mDockedWindows.ElementAt(idx);
			browser->Layout(0, 0);
		}

		// then all the floating windows
		for (idx=0; idx<mFloatingWindows.Count();idx++)
		{
			rvMainWindow* browser = (rvMainWindow*) mFloatingWindows.ElementAt(idx);
			nsRect bounds;
			browser->GetContentBounds(bounds); 
			browser->Layout(bounds.width, bounds.height);
		}

		return NS_OK;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::Layout()" << IEXC;
		return NS_ERROR_FAILURE;
	}
}

// =========================================================================================
// Browser open/close functions
II_RESULT rvParentWindow::OpenBrowser(nsAutoString url, rvMainWindow* aWin, nsWindowType p_wnd_type, nsBorderStyle p_border_style, II_WindowType p_bw_sub_type, PRInt32 p_dock_pos, PRBool p_hidden)
{
	try
	{
		ILOG << "rvParentWindow::OpenBrowser():" << "url:" << url << IINF;
		IL_TAB;

		if (url == MozStr(""))
		{
			ILOG << "Empty url passed" << IERR;
			IL_UNTAB;
			return IIR_INVALID_URL;
		}

		if (aWin == nsnull)
		{
			ILOG << "Null Window Passed in. Create a rvMainWindow object and pass in" << IERR;
			IL_UNTAB;
			return IIR_NULL_BROWSER_INSTANCE;
		}

		NS_ADDREF(aWin);

		aWin->UnsetMembers();
		aWin->SetApp(mApp);

		aWin->mSubWinType = p_bw_sub_type;
		aWin->m_window_type = p_wnd_type;
		aWin->m_border_style = p_border_style;
		aWin->m_doc_pos = p_dock_pos; 

		ILOG << "About to create Browser Child Window" << IINF;
		II_RESULT open_res = aWin->Init(this, mAppShell,nsRect(0, 0, 600, 600), !p_hidden);
		if (open_res != IIR_SUCCESS)
		{
			ILOG << "Fatal: Failed to Open Browser Child Window" << IFTL;
			IL_UNTAB;
			NS_RELEASE(aWin);
			return IIR_FAILED_MAIN_WINDOW;
		}
		
		ILOG << "Successfully created Browser Child Window" << IINF;

		// load the page
		aWin->GoTo(url);
		ILOG << "Sent http request for url load" << IINF;

		// add the browser
		AddBrowser(aWin);

		NS_RELEASE(aWin);
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::OpenBrowser()" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvParentWindow::OpenStandardBrowser(nsAutoString url, rvMainWindow* aWin, PRBool p_hidden) 
{
	return OpenBrowser(url, aWin, eWindowType_toplevel, eBorderStyle_default, IIW_WWW, 0, p_hidden);
}

II_RESULT rvParentWindow::OpenEmptyBrowser(rvMainWindow* aWin, nsWindowType p_wnd_type, nsBorderStyle p_border_style, II_WindowType p_bw_sub_type, PRInt32 p_dock_pos, PRBool p_hidden)
{
	nsAutoString url(PWW_DATA_ROOT_FILE_PROTOCOL);
	url.Append(PWW_APP_DIR);
	url.Append(NS_LITERAL_STRING("/"));
	url.Append(NS_LITERAL_STRING("empty.html"));

	return OpenBrowser(url, aWin, p_wnd_type, p_border_style, p_bw_sub_type, p_dock_pos, p_hidden);
}

II_RESULT rvParentWindow::CloseBrowserWindow(rvMainWindow* aBrowserWindow)
{
	try
	{
		ILOG << "rvParentWindow::CloseBrowserWindow()" << IINF;
		IL_TAB;

		ILOG << "Closing Browser:url:" << aBrowserWindow->m_root_frame.m_url << IINF;

		// destroy and remove from list
		aBrowserWindow->Destroy();
		RemoveBrowser(aBrowserWindow);

		ILOG << "Successfully closed and destroyed browser child window" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::CloseBrowserWindow()" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvParentWindow::CloseAllWindows()
{
	ILOG << "rvParentWindow::CloseAllWindows()" << IINF;
	IL_TAB;

	ILOG << "Closing child windows" << IINF;
	try
	{
		if (m_browsers == nsnull)
		{
			ILOG << "Empty Browser Collection" << IINF;
			IL_UNTAB;
			return IIR_SUCCESS;
		}
		
		if (m_browsers != nsnull)
		{
			ILOG << "Closing " << m_browsers->Count() << " child windows" << IINF;
			while (m_browsers->Count() > 0)
			{
				rvMainWindow* bw = (rvMainWindow*) m_browsers->ElementAt(0);
				if (bw != nsnull)
					CloseBrowserWindow(bw);
			}

			m_browsers->Clear();
			delete m_browsers;
			m_browsers = nsnull;
		}

		ILOG << "Closed all child windows" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvParentWindow::CloseAllWindows()" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvParentWindow::AddBrowser(rvMainWindow* aBrowser)
{
	m_browsers->AppendElement(aBrowser);
  NS_ADDREF(aBrowser);

	SetActiveBrowser(aBrowser);
	SetWindowsCollectionsOnTypes();

	ILOG << "Added child window browser to collection" << IINF;
	return IIR_SUCCESS;
}

II_RESULT rvParentWindow::RemoveBrowser(rvMainWindow* aBrowser)
{
  if (!m_browsers)
	{
		ILOG << "Empty Browser Collection" << IINF;
    return IIR_SUCCESS;
	}
  
	SetNextActiveBrowser(aBrowser);
  m_browsers->RemoveElement(aBrowser);

	NS_RELEASE(aBrowser);
	SetWindowsCollectionsOnTypes();
	ILOG << "Removed child window browser from collection" << IINF;
	return IIR_SUCCESS;
}

II_RESULT rvParentWindow::GotoURLOnActiveWWWBrowser(nsAutoString url) 
{
	ILOG << "rvParentWindow::GotoURLOnActiveWWWBrowser()" << IINF;
	IL_TAB;

	if (mActiveWWWBrowser != nsnull && !mActiveWWWBrowser->mBrowserIsExiting)
	{
		II_RESULT res = mActiveWWWBrowser->GoTo(url);
		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed to send url request on active browser window" << IINF;
			IL_UNTAB;
			return res;
		}

		ILOG << "Loaded url in active child browser window" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}

	// if not open a new window
	ILOG << "No active browser found. Creating new child browser window..." << IINF;
	rvMainWindow* aWin = new rvMainWindow();
  if (aWin ==  nsnull)
	{
		ILOG << "Null Window Passes. Create a rvMainWindow object and pass in" << IERR;
		IL_UNTAB;
		return IIR_NULL_BROWSER_INSTANCE;
	}

  NS_ADDREF(aWin);

	aWin->UnsetMembers();
	II_RESULT res = OpenStandardBrowser(url, aWin);

	NS_RELEASE(aWin);
	if (res == IIR_SUCCESS)
	{
		ILOG << "Loaded url in new child browser window" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}

	ILOG << "Failed to load url:" << url << ":result" << IMSG(res) << IERR;
	IL_UNTAB;
	return res;
}

// ===================================================================
// active browsers
void rvParentWindow::SetActiveBrowser(rvMainWindow* aBrowser)
{
	if (nsnull != aBrowser) 
	{
		switch (aBrowser->mSubWinType)
		{
			case IIW_WWW:
			case IIW_WWW_Popup:
				mActiveWWWBrowser = aBrowser;
				break;
			case IIW_PWW:
				mActivePWWBrowser = aBrowser;
				break;
			case IIW_Form:
				mActiveFormBrowser = aBrowser;			
				break;
			case IIW_Alert:
				mActiveAlertBrowser = aBrowser;
				break;
			default:
				break;
		}
	}
}

void rvParentWindow::SetNextActiveBrowser(rvMainWindow* p_bw)
{
  if (!m_browsers)
    return;

	if ((p_bw->mSubWinType == IIW_WWW || p_bw->mSubWinType == IIW_WWW_Popup) && p_bw == mActiveWWWBrowser)
	{
		PRInt32 cnt = m_browsers->Count();
		for (PRInt32 idx = cnt-1; idx>=0;idx--)
		{
			rvMainWindow* bw = (rvMainWindow*) (m_browsers->ElementAt(idx));
			if (bw == p_bw)
				continue;
	
			if (bw->mSubWinType == IIW_WWW || p_bw->mSubWinType == IIW_WWW_Popup)
			{
				mActiveWWWBrowser = bw;
				return;
			}
		}

		mActiveWWWBrowser = nsnull;
	}
	else if (p_bw->mSubWinType == IIW_PWW && p_bw == mActivePWWBrowser)
	{
		PRInt32 cnt = m_browsers->Count();
		for (PRInt32 idx = cnt-1; idx>=0;idx--)
		{
			rvMainWindow* bw = (rvMainWindow*) (m_browsers->ElementAt(idx));
			if (bw == p_bw)
				continue;
	
			if (bw->mSubWinType == IIW_PWW)
			{
				mActivePWWBrowser = bw;
				return;
			}
		}

		mActivePWWBrowser = nsnull;
	}
	else if (p_bw->mSubWinType == IIW_Form && p_bw == mActiveFormBrowser)
	{
		PRInt32 cnt = m_browsers->Count();
		for (PRInt32 idx = cnt-1; idx>=0;idx--)
		{
			rvMainWindow* bw = (rvMainWindow*) (m_browsers->ElementAt(idx));
			if (bw == p_bw)
				continue;
	
			if (bw->mSubWinType == IIW_Form)
			{
				mActiveFormBrowser = bw;
				return;
			}
		}

		mActiveFormBrowser = nsnull;
	}
	else if (p_bw->mSubWinType == IIW_Form && p_bw == mActiveAlertBrowser)
	{
		PRInt32 cnt = m_browsers->Count();
		for (PRInt32 idx = cnt-1; idx>=0;idx--)
		{
			rvMainWindow* bw = (rvMainWindow*) (m_browsers->ElementAt(idx));
			if (bw == p_bw)
				continue;
	
			if (bw->mSubWinType == IIW_Alert)
			{
				mActiveAlertBrowser = bw;
				return;
			}
		}

		mActiveAlertBrowser = nsnull;
	}	
}

// browser collection iterators
rvMainWindow* rvParentWindow::GetPopupBrowserWindow(rvMainWindow* p_referer, nsAutoString p_url, PRInt32 p_pos)
{
	IL_TAB;

  if (m_browsers == nsnull)
	{
		ILOG << "rvParentWindow::GetPopupBrowserWindow(): Empty Collection" << IERR;
		IL_UNTAB;
    return nsnull;
	}

  PRInt32 i, n = m_browsers->Count();
  for (i = 0; i < n; i++) 
	{
    rvMainWindow* bw = (rvMainWindow*) m_browsers->ElementAt(i);

		// support only for main windows and rule processor window
    if (nsnull != bw && bw->m_referer_browser == p_referer) 
		{
			if (bw->mSubWinType == IIW_WWW_Popup || bw->mSubWinType == IIW_RuleProcessor_Popup)
			{
				ILOG << "Found browser with url:" << bw->m_root_frame.m_url << ":referer url:" << bw->m_referer_browser->m_root_frame.m_url <<  IINF;
				IL_UNTAB;
				// TODO: need to check on url and position
				return bw;
			}
		}
	}

	ILOG << "rvParentWindow::GetPopupBrowserWindow(): Failed to find dependent browser of referer browser" << IERR;
	IL_UNTAB;
	return nsnull;
}

rvMainWindow* rvParentWindow::GetDocumentTargetBrowser(nsIDOMHTMLDocument* p_doc)
{
	IL_TAB;

  if (m_browsers == nsnull)
	{
		ILOG << "rvParentWindow::GetDocumentTargetBrowser(): Empty Collection" << IERR;
		IL_UNTAB;
	  return nsnull;
	}

  PRInt32 i, n = m_browsers->Count();
  for (i = 0; i < n; i++) 
	{
    rvMainWindow* bw = (rvMainWindow*) m_browsers->ElementAt(i);

		// support only for main windows and rule processor window
    if (nsnull != bw)
		{
			nsIDOMHTMLDocument* doc;
			bw->GetDocument(doc);
			if (doc == p_doc) // assuming the address will be the same (must be)
			{
				ILOG << "Found browser for document" <<  IINF;
				NS_RELEASE(doc);
				IL_UNTAB;
				return bw;
			}

			NS_RELEASE(doc);
		}
	}

	ILOG << "rvParentWindow:GetDocumentTargetBrowser(): Failed to find browser for document" <<  IINF;
	IL_UNTAB;
	return nsnull;
}

rvMainWindow* rvParentWindow::FindBrowserFor(nsIWidget* aWidget, PRIntn aWhich)
{
	IL_TAB;
  if (m_browsers == nsnull)
	{
		ILOG << "rvParentWindow::FindBrowserFor():Empty Collection" << IDBG;
		IL_UNTAB;
    return nsnull;
	}

  nsIWidget*     widget;
  rvMainWindow*  result = nsnull;
  PRInt32 i, n = m_browsers->Count();
  for (i = 0; i < n; i++) 
	{
    rvMainWindow* bw = (rvMainWindow*) m_browsers->ElementAt(i);
    if (nsnull != bw) 
		{
      switch (aWhich) 
			{
				case FIND_WINDOW:
				{
 					if (bw->mWindow) 
					{
						bw->mWindow->QueryInterface(kIWidgetIID, (void**) &widget);
						if (widget == aWidget) 
							result = bw;

						NS_IF_RELEASE(widget);
					}
					break;
				}
      }
    }
  }
  
  if (nsnull != result) 
	{
		ILOG << "rvParentWindow::FindBrowserFor found Browser" << IDBG;
    NS_ADDREF(result);
	}
	else
		ILOG << "rvParentWindow::FindBrowserFor(): Error: Failed to find browser from target window" << IDBG;

	IL_UNTAB;
  return result;
}

void rvParentWindow::SetWindowsCollectionsOnTypes()
{
	mDockedWindows.Clear();
	mFloatingWindows.Clear();

	if (m_browsers == nsnull)
		return;

	PRInt32 len = m_browsers->Count();
	if (len < 1)
		return;

	for (PRInt32 idx=0;idx<len;idx++)
	{
		rvMainWindow* browser = (rvMainWindow*) m_browsers->ElementAt(idx);
		if (browser->mSubWinType != IIW_RuleProcessor && browser->mSubWinType != IIW_RuleProcessor_Popup && browser->m_doc_pos > 0)
			mDockedWindows.AppendElement((void*) browser);
	}

	if (m_browsers == nsnull)
		return;

	len = m_browsers->Count();
	if (len < 1)
		return;

	for (idx=0;idx<len;idx++)
	{
		rvMainWindow* browser = (rvMainWindow*) m_browsers->ElementAt(idx);
		if (browser->mSubWinType != IIW_RuleProcessor && browser->mSubWinType != IIW_RuleProcessor_Popup && browser->m_doc_pos == 0)
			mFloatingWindows.AppendElement((void*) browser);
	}
}

nsVoidArray* rvParentWindow::GetDockedWindows()
{
	return &mDockedWindows;
}

nsVoidArray* rvParentWindow::GetFloatingWindows()
{
	return &mFloatingWindows;
}

// ================================================================================
// widget functions
NS_IMETHODIMP rvParentWindow::DestroyWidget(nsISupports* aWidget)
{
  if (aWidget != nsnull) 
  {
    nsCOMPtr<nsIWidget> wgdt(do_QueryInterface(aWidget));
    if (wgdt) 
      wgdt->Destroy();
		else
		{
			ILOG << "Could not get widget interface" << IERR;
			return NS_ERROR_FAILURE;
		}
  }

	ILOG << "Destroyed Widget" << IINF;
	return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetWindow(nsIWidget** aWindow)
{
  if (aWindow && mWindow) 
	{
    *aWindow = mWindow.get();
    NS_IF_ADDREF(*aWindow);
    return NS_OK;
  }
  
	return NS_ERROR_FAILURE;
}

NS_IMETHODIMP rvParentWindow::InitWindow(nativeWindow aParentNativeWindow, nsIWidget* parentWidget, PRInt32 x, PRInt32 y, PRInt32 cx, PRInt32 cy)   
{
   // Ignore wigdet parents for now.  Don't think those are a vaild thing to call.
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, cx, cy, PR_FALSE), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::Create()
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_UNEXPECTED;
}

NS_IMETHODIMP rvParentWindow::MoveTo(PRInt32 aX, PRInt32 aY)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Move(aX, aY);
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SizeContentTo(PRInt32 aWidth, PRInt32 aHeight)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");

  // XXX We want to do this in one shot
  mWindow->Resize(aWidth, aHeight, PR_FALSE);

  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight, PRBool aWidthTransient, PRBool aHeightTransient)
{
  return SizeContentTo(aWidth, aHeight);
}

NS_IMETHODIMP rvParentWindow::GetContentBounds(nsRect& aBounds)
{
  mWindow->GetClientBounds(aBounds);
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetWindowBounds(nsRect& aBounds)
{
  mWindow->GetBounds(aBounds);
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetTitle(PRUnichar** aTitle)
{
   NS_ENSURE_ARG_POINTER(aTitle);
   *aTitle = ToNewUnicode(mTitle);

   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SetTitle(const PRUnichar* aTitle)
{
   NS_ENSURE_STATE(mWindow);
   mTitle = aTitle;
   NS_ENSURE_SUCCESS(mWindow->SetTitle(nsAutoString(aTitle)), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SetFocus()
{
   // NS_WARNING("Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetMainWidget(nsIWidget** aMainWidget)
{
   NS_ENSURE_ARG_POINTER(aMainWidget);
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetEnabled(PRBool *aEnabled)
{
  NS_ENSURE_ARG_POINTER(aEnabled);
  *aEnabled = PR_TRUE;
  if (mWindow)
    mWindow->IsEnabled(aEnabled);
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SetEnabled(PRBool aEnabled)
{
  if (mWindow)
    mWindow->Enable(aEnabled);
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetBlurSuppression(PRBool *aBlurSuppression)
{
  NS_ENSURE_ARG_POINTER(aBlurSuppression);
  *aBlurSuppression = PR_FALSE;
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvParentWindow::SetBlurSuppression(PRBool aBlurSuppression)
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvParentWindow::GetVisibility(PRBool* aVisibility)
{
   NS_ENSURE_ARG_POINTER(aVisibility);
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SetVisibility(PRBool aVisibility)
{
   NS_ENSURE_STATE(mWindow);
   NS_ENSURE_SUCCESS(mWindow->Show(aVisibility), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::Repaint(PRBool aForce)
{
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetParentWidget(nsIWidget** aParentWidget)
{
   NS_ENSURE_ARG_POINTER(aParentWidget);
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SetParentWidget(nsIWidget* aParentWidget)
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvParentWindow::GetParentNativeWindow(nativeWindow* aParentNativeWindow)
{
   NS_ENSURE_ARG_POINTER(aParentNativeWindow);
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::SetParentNativeWindow(nativeWindow aParentNativeWindow)
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvParentWindow::SetPosition(PRInt32 aX, PRInt32 aY)
{
   PRInt32 cx=0;
   PRInt32 cy=0;

   NS_ENSURE_SUCCESS(GetSize(&cx, &cy), NS_ERROR_FAILURE);
   NS_ENSURE_SUCCESS(SetPositionAndSize(aX, aY, cx, cy, PR_FALSE), NS_ERROR_FAILURE);
   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetPosition(PRInt32* aX, PRInt32* aY)
{
   return GetPositionAndSize(aX, aY, nsnull, nsnull);
}

NS_IMETHODIMP rvParentWindow::SetSize(PRInt32 aCX, PRInt32 aCY, PRBool aRepaint)
{
   PRInt32 x=0;
   PRInt32 y=0;

   NS_ENSURE_SUCCESS(GetPosition(&x, &y), NS_ERROR_FAILURE);
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, aCX, aCY, aRepaint), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetSize(PRInt32* aCX, PRInt32* aCY)
{
   return GetPositionAndSize(nsnull, nsnull, aCX, aCY);
}

NS_IMETHODIMP rvParentWindow::SetPositionAndSize(PRInt32 aX, PRInt32 aY, PRInt32 aCX, PRInt32 aCY, PRBool aRepaint)
{
   NS_ENSURE_SUCCESS(mWindow->Resize(aX, aY, aCX, aCY, aRepaint), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvParentWindow::GetPositionAndSize(PRInt32* aX, PRInt32* aY, PRInt32* aCX, PRInt32* aCY)
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

// Overload this method in your nsNativeBrowserWindow if you need to 
// have the logic in rvParentWindow::Layout() offset the menu within
// the parent window.
nsresult rvParentWindow::GetMenuBarHeight(PRInt32 * aHeightOut)
{
  NS_ASSERTION(nsnull != aHeightOut,"null out param.");

  NS_ENSURE_ARG_POINTER(aHeightOut);

	HMENU hmenu = ::GetMenu((HWND) mWindow->GetNativeData(NS_NATIVE_WIDGET));
	RECT menu;
  ::GetWindowRect((HWND) hmenu, &menu);
	*aHeightOut = menu.bottom-menu.top;

  return NS_OK;
}

// helper functions. Must go somewhere else
nsresult rvParentWindow::DoFileOpen()
{
  nsILocalFile *file = nsnull;
  nsIDOMWindow *domWindow= nsnull;
  nsIDOMWindowInternal *parentWindow= nsnull;
	nsILocalFile *OpenFileDirectory= nsnull;
  nsresult rv;

	rvMainWindow* aWin = new rvMainWindow();
  NS_ENSURE_TRUE(aWin, NS_ERROR_FAILURE);
  NS_ADDREF(aWin);

	aWin->UnsetMembers();
	aWin->SetApp(mApp);
	aWin->mSubWinType = IIW_WWW;
	aWin->m_border_style = eBorderStyle_all;
	aWin->m_window_type = eWindowType_toplevel;
	aWin->m_doc_pos = 0;
  aWin->Init(this, mAppShell,nsRect(0, 0, 600, 600), PR_FALSE);

  rv = aWin->mWebBrowser->GetContentDOMWindow(&domWindow);
  if (NS_SUCCEEDED(rv))
    domWindow->QueryInterface(kIDOMWindowInternalIID, (void**) &parentWindow);

  // show the open file dialog
  if (GetFileFromFileSelector(parentWindow, &file, &OpenFileDirectory))
	{
    nsIURI *uri;
    NS_NewFileURI(&uri, file);
    if (uri) 
		{
      nsCAutoString spec;
      uri->GetSpec(spec);
      
      // Ask the Web widget to load the file URL
			// load the page
			aWin->GoTo(NS_ConvertUTF8toUCS2(spec));
			aWin->MakeVisible();
			
			// add the browser
			AddBrowser(aWin);
		}

		NS_RELEASE(uri);
		NS_RELEASE(domWindow);
		NS_RELEASE(parentWindow);
		NS_RELEASE(file);
		NS_RELEASE(OpenFileDirectory);
		return NS_OK;
  }

	NS_RELEASE(domWindow);
	NS_RELEASE(parentWindow);
	aWin->Destroy();
	NS_RELEASE(aWin);
	delete aWin;
	return NS_OK;
}

static PRBool GetFileFromFileSelector(nsIDOMWindowInternal* aParentWindow,
                                      nsILocalFile **aFile,
                                      nsILocalFile **aDisplayDirectory)
{
  nsresult rv;
  nsCOMPtr<nsIFilePicker> filePicker = do_CreateInstance("@mozilla.org/filepicker;1");

  if (filePicker != nsnull) 
	{
    rv = filePicker->Init(aParentWindow, NS_LITERAL_STRING("Open HTML"), nsIFilePicker::modeOpen);
    if (NS_SUCCEEDED(rv)) 
		{
      filePicker->AppendFilters(nsIFilePicker::filterAll | nsIFilePicker::filterHTML |
                                nsIFilePicker::filterXML | nsIFilePicker::filterImages);
      if (*aDisplayDirectory)
        filePicker->SetDisplayDirectory(*aDisplayDirectory);
      
      PRInt16 dialogResult;
      rv = filePicker->Show(&dialogResult);
      if (NS_FAILED(rv) || dialogResult == nsIFilePicker::returnCancel)
			{
				filePicker=nsnull;
				NS_IF_RELEASE(*aDisplayDirectory);
        return PR_FALSE;
			}

      filePicker->GetFile(aFile);
      if (*aFile) 
			{
        NS_IF_RELEASE(*aDisplayDirectory);
        filePicker->GetDisplayDirectory(aDisplayDirectory);
				filePicker=nsnull;
				return PR_TRUE;
      }
    }
  }

	filePicker=nsnull;
  return PR_FALSE;
}

// ==========================================================================================
// native parent window functions
nsNativeBrowserWindow::nsNativeBrowserWindow()
{
}

nsNativeBrowserWindow::~nsNativeBrowserWindow()
{
}

nsresult nsNativeBrowserWindow::InitNativeWindow()
{
	// override to do something special with platform native windows
  return NS_OK;
}

nsresult nsNativeBrowserWindow::CreateMenuBar(PRInt32 aWidth)
{
  HMENU menu = ::LoadMenu(gInstance, "Viewer");
  HWND hwnd = (HWND)mWindow->GetNativeData(NS_NATIVE_WIDGET);
  ::SetMenu(hwnd, menu);

  return NS_OK;
}

nsresult nsNativeBrowserWindow::GetMenuBarHeight(PRInt32 * aHeightOut)
{
  NS_ENSURE_ARG_POINTER(aHeightOut);

	HMENU hmenu = ::GetMenu((HWND) mWindow->GetNativeData(NS_NATIVE_WIDGET));
	RECT menu;
  ::GetWindowRect((HWND) hmenu, &menu);
	*aHeightOut = menu.bottom-menu.top;

  return NS_OK;
}

nsEventStatus nsNativeBrowserWindow::DispatchMenuItem(PRInt32 aID)
{
  // Dispatch windows-only menu code goes here

  // Dispatch xp menu items
  return rvParentWindow::DispatchMenuItem(aID);
}

