#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvMainWindow.h"
#include "rvOpenURL.h"
#include "rvXmlDocument.h"
#include "rvRuleProcessor.h"
#include "rvRulesProcessor.h"
#include "rvRulesCollection.h"
#include "rvParentWindow.h"

extern HINSTANCE gInstance, gPrevInstance;
extern rvMyMozApp* theApp;

// global functions
static PRBool GetFileFromFileSelector(nsIDOMWindowInternal* aParentWindow,  nsILocalFile **aFile, nsILocalFile **aDisplayDirectory);
static nsEventStatus PR_CALLBACK HandleParentWindowEvent(nsGUIEvent *aEvent);

// cons/destr
rvParentWindow::rvParentWindow()
{
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
	Destroy();
}

// implement main interfaces
NS_IMPL_ISUPPORTS2(rvParentWindow, nsIBaseWindow, nsIInterfaceRequestor)

nsresult rvParentWindow::GetInterface(const nsIID& aIID, void** aInstancePtrResult)
{
  NS_PRECONDITION(aInstancePtrResult, "null pointer");
  if (!aInstancePtrResult)
    return NS_ERROR_NULL_POINTER;

  return QueryInterface(aIID, aInstancePtrResult);
}

// main window functions
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

nsresult rvParentWindow::Init(nsIAppShell* aAppShell, const nsRect& aBounds)
{
	// make sure the browser collection is et
  if (m_browsers == nsnull) 
    m_browsers = new nsVoidArray();

  mAppShell = aAppShell;
  NS_IF_ADDREF(mAppShell);

  // create the main window
  nsresult rv = nsComponentManager::CreateInstance(kWindowCID, nsnull,  kIWidgetIID, getter_AddRefs(mWindow));
  if (NS_OK != rv) 
    return rv;

  nsWidgetInitData initData;
  initData.mWindowType = eWindowType_toplevel;
  initData.mBorderStyle = eBorderStyle_all;
  initData.clipChildren = PR_TRUE;
  initData.clipSiblings = PR_TRUE;

  mWindow->Create((nsIWidget*) NULL, aBounds, HandleParentWindowEvent, nsnull, aAppShell, nsnull, &initData);
	SetTitle(L"Welcome to IntraInter.com");

  // create the menu
  HMENU menu = ::LoadMenu(gInstance, "IDR_MENU_PWW");
  HWND hwnd = (HWND)mWindow->GetNativeData(NS_NATIVE_WIDGET);
  ::SetMenu(hwnd, menu);
    
  // Show Location Bar
	//DispatchMenuItem(ID_WWW_SHOWTOOLBAR);

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

  // return success
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
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

NS_IMETHODIMP rvParentWindow::Destroy()
{
  // Close all the child windows
	CloseAllWindows();

	// close the current widget
	DestroyWidget(mWindow);
	mWindow = nsnull;

	if (mAppShell != nsnull)
	{
		NS_IF_RELEASE(mAppShell);
		mAppShell = nsnull;
	}

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
	delete m_rules_loader;
	m_rules_loader = nsnull;

  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::DestroyWidget(nsISupports* aWidget)
{
  if (aWidget != nsnull) 
  {
    nsCOMPtr<nsIWidget> wgdt(do_QueryInterface(aWidget));
    if (wgdt) 
      wgdt->Destroy();
  }

	return NS_OK;
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

// **** Browser and browser array functions ****
NS_IMETHODIMP rvParentWindow::OpenBrowserWindow(nsAutoString url, rvMainWindow* aWin) 
{
  NS_ENSURE_TRUE(aWin, NS_ERROR_FAILURE);
  NS_ADDREF(aWin);

  aWin->SetApp(mApp);
  aWin->Init(this, mAppShell,nsRect(0, 0, 600, 600));

  // load the page
  aWin->GoTo(url);

  // add the browser
  AddBrowser(aWin);

	NS_RELEASE(aWin);
  return NS_OK;
}

NS_IMETHODIMP rvParentWindow::CloseBrowserWindow(rvMainWindow* aBrowserWindow)
{
	// destroy and remove from list
	aBrowserWindow->Destroy();
	RemoveBrowser(aBrowserWindow);

  return NS_OK;
}

void rvParentWindow::CloseAllWindows()
{
	if (m_browsers == nsnull)
		return;
	
  if (m_browsers != nsnull)
	{
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
}

void rvParentWindow::AddBrowser(rvMainWindow* aBrowser)
{
	m_browsers->AppendElement(aBrowser);
  NS_ADDREF(aBrowser);

	SetActiveBrowser(aBrowser);
	SetWindowsCollectionsOnTypes();
}

void rvParentWindow::RemoveBrowser(rvMainWindow* aBrowser)
{
  if (!m_browsers)
    return;
  
	SetNextActiveBrowser(aBrowser);
  m_browsers->RemoveElement(aBrowser);

	NS_RELEASE(aBrowser);
	SetWindowsCollectionsOnTypes();
}

void rvParentWindow::SetActiveBrowser(rvMainWindow* aBrowser)
{
    if (nsnull != aBrowser) 
		{
			switch (aBrowser->mSubWinType)
			{
  			case IIW_Main:
				case IIW_WWW:
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

	if (p_bw->mSubWinType == IIW_Main && p_bw == mActiveWWWBrowser)
	{
		PRInt32 cnt = m_browsers->Count();
		for (PRInt32 idx = cnt-1; idx>=0;idx--)
		{
			rvMainWindow* bw = (rvMainWindow*) (m_browsers->ElementAt(idx));
			if (bw == p_bw)
				continue;
	
			if (bw->mSubWinType == IIW_Main || bw->mSubWinType == IIW_WWW)
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

rvMainWindow* rvParentWindow::FindBrowserFor(nsIWidget* aWidget, PRIntn aWhich)
{
  if (m_browsers == nsnull)
    return nsnull;

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
    NS_ADDREF(result);

  return result;
}

// menu functions
nsEventStatus rvParentWindow::DispatchMenuItem(PRInt32 aID)
{
  // Dispatch windows-only menu code goes here
	switch(aID)
	{
		case ID_WWW_OPEN:
		{
			DoFileOpen();
			break;
		}
		case ID_WWW_SAVEPAGE:
		{
			if (mActiveWWWBrowser != nsnull) 
				mActiveWWWBrowser->SavePage();
			break;
		}
		case ID_CHROMIUM_CREATEWINDOW:
		{
			nsAutoString url(NS_LITERAL_STRING("file:///c:/MyMozFiles/AppFiles/empty.html"));  
			rvMainWindow* Win = new rvMainWindow();
			Win->InitializeMembers();
			Win->mSubWinType = IIW_WWW;
			Win->m_window_type = eWindowType_toplevel;
			Win->m_border_style = eBorderStyle_default;
			Win->m_doc_pos = 0; 
			OpenBrowserWindow(url, Win);
			break;
		}
		case ID_PWW_IMERGE_WWWPWWBEGIN:
		{
			if (mActiveWWWBrowser != nsnull) 
			{
				mActiveWWWBrowser->mMainAction = IIMA_WWW2PWW;
				mActiveWWWBrowser->mIsInDesignMode = !theApp->mParentWindow->mActiveWWWBrowser->mIsInDesignMode;
				mActiveWWWBrowser->OnDesignMode_HighlightElement();
			}
			break;
		}
		case ID_PWW_IMERGE_CREATEWINDOW:
		{
			nsAutoString url(NS_LITERAL_STRING("file:///c:/MyMozFiles/AppFiles/empty.html"));  
			rvMainWindow* Win = new rvMainWindow();
			Win->InitializeMembers();
			Win->mSubWinType = IIW_PWW;
			Win->m_window_type = eWindowType_toplevel;
			Win->m_border_style = eBorderStyle_default;
			Win->m_doc_pos = 0; 
			OpenBrowserWindow(url, (rvMainWindow*) Win);
			break;
		}
		case ID_WWW_SHOWTOOLBAR:
		{
			COpenURLWindow* url_wnd = new COpenURLWindow();
			url_wnd->DoOpen(); 
			break;
		}
		case ID_CHROMIUM_TODAY_SITE1:
		{
			nsAutoString url(NS_LITERAL_STRING("file:///c:/MyMozFiles/AppFiles/test0.html"));
			rvMainWindow* Win = new rvMainWindow();
			Win->InitializeMembers();
			Win->mSubWinType = IIW_WWW;
			Win->m_window_type = eWindowType_toplevel;
			Win->m_border_style = eBorderStyle_default;
			Win->m_doc_pos = 0; 
			OpenBrowserWindow(url, Win);

			break;
		}
		case ID_CHROMIUM_TODAY_SITE2:
		{
			nsAutoString url(NS_LITERAL_STRING("file:///c:/MyMozFiles/AppFiles/test1.html"));
			rvMainWindow* Win = new rvMainWindow();
			Win->InitializeMembers();
			Win->mSubWinType = IIW_WWW;
			Win->m_window_type = eWindowType_toplevel;
			Win->m_border_style = eBorderStyle_default;
			Win->m_doc_pos = 0; 
			OpenBrowserWindow(url, Win);
			break;
		}
	
		case ID_CHROMIUM_EXIT:
		{
			theApp->Exit();
			return nsEventStatus_eConsumeNoDefault;
		}
		case ID_CHROMIUM_DUMP:
		{
			if (mActiveWWWBrowser != nsnull)
				mActiveWWWBrowser->DumpStyles();
			break;
		}
		case ID_ALERT_LOADTESTPAGE:
		{
			nsAutoString url(NS_LITERAL_STRING("file:///c:/MyMozFiles/Tests/Mozilla_Pages/tc_1n_span_id.html"));
			rvMainWindow* Win = new rvMainWindow();
			Win->InitializeMembers();
			Win->mSubWinType = IIW_WWW;
			Win->m_window_type = eWindowType_toplevel;
			Win->m_border_style = eBorderStyle_default;
			OpenBrowserWindow(url, (rvMainWindow*) Win);
			break;
		}
		case ID_ALERT_ALERTDESIGNMODE:
		{
			if (mActiveWWWBrowser != nsnull) 
			{
				mActiveWWWBrowser->mMainAction = IIMA_SetAlert;
				mActiveWWWBrowser->mIsInDesignMode = !theApp->mParentWindow->mActiveWWWBrowser->mIsInDesignMode;
				mActiveWWWBrowser->OnDesignMode_HighlightElement();
			}
			break;
		}
		case ID_ALERT_LOADALERTEDPAGE:
		{
			CRuleProcessor::m_always_show = PR_FALSE;
			CRulesProcessor* proc = new CRulesProcessor();
			proc->ProcessRules();
			delete proc;
			proc = nsnull;
			break;
		}
		case ID_TESTS_LOADSPOTTEDNODE:
		{
			CRuleProcessor::m_always_show = PR_TRUE;
			CRulesProcessor* proc = new CRulesProcessor();
			proc->ProcessRules();
			delete proc;
			proc = nsnull;
			break;
		}
		case ID_RULESDB_CLEARRULES:
		{
			CRulesCollection* col = new CRulesCollection();
			col->ClearRules(); 
			delete col;
			col = nsnull;
  		break;
		}
	}
	
  // Dispatch xp menu items
  return nsEventStatus_eIgnore;
}

PRBool rvParentWindow::GotoURLOnActiveWWWBrowser(nsAutoString url) 
{
	if (mActiveWWWBrowser != nsnull)
	{
		mActiveWWWBrowser->GoTo(url);
		return PR_TRUE;
	}

	// if not open a new window
	rvMainWindow* aWin = new rvMainWindow();
  NS_ENSURE_TRUE(aWin, NS_ERROR_FAILURE);
  NS_ADDREF(aWin);

	aWin->InitializeMembers();
	aWin->m_window_type = eWindowType_toplevel;
	aWin->m_border_style = eBorderStyle_default;
	aWin->m_doc_pos = 0; 

	OpenBrowserWindow(url, aWin);
	NS_RELEASE(aWin);
	
	return PR_FALSE;
}

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

	aWin->InitializeMembers();
	aWin->SetApp(mApp);
	aWin->m_border_style = eBorderStyle_all;
	aWin->m_window_type = eWindowType_toplevel;
	aWin->m_doc_pos = 0;
  aWin->Init(this, mAppShell,nsRect(0, 0, 600, 600), PR_FALSE);

  rv = aWin->mWebBrowser->GetContentDOMWindow(&domWindow);
  if (NS_SUCCEEDED(rv))
    domWindow->QueryInterface(kIDOmWindowInternalIID, (void**) &parentWindow);

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

  if (filePicker) 
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
		if (browser->mSubWinType != IIW_RuleProcessor && browser->m_doc_pos > 0)
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
		if (browser->mSubWinType != IIW_RuleProcessor && browser->m_doc_pos == 0)
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


// Event handlers
static nsEventStatus PR_CALLBACK HandleParentWindowEvent(nsGUIEvent *aEvent)
{ 
	// This is important
	if (theApp == nsnull || theApp->mParentWindow == nsnull) 
		return nsEventStatus_eIgnore;

	// process the event
	nsEventStatus result = nsEventStatus_eIgnore;
  switch(aEvent->message)
	{
		case NS_SIZE:
		{
			nsSizeEvent* sizeEvent;
		  sizeEvent = (nsSizeEvent*)aEvent;  
		  theApp->mParentWindow->Layout(sizeEvent->windowSize->width, sizeEvent->windowSize->height);

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
		case NS_DESTROY:
		{
		  theApp->Exit();
		  
			result = nsEventStatus_eConsumeDoDefault;
		  break;
		}
		case NS_MENU_SELECTED:
		{
			result = theApp->mParentWindow->DispatchMenuItem(((nsMenuEvent*)aEvent)->mCommand);
			break;
		}
		default:
			break;
    }
    
	return result;
}

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

