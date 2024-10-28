#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvParentWindow.h"
#include "rvRuleCreator.h"
#include "rvDOMEventListener.h"
#include "rvRuleProcessor.h"
#include "rvRuleRenderer.h"
#include "rvFormWindow.h"

#include "rvMainWindow.h"
extern rvMyMozApp* theApp;

// Main Interface Implements
NS_IMPL_THREADSAFE_ISUPPORTS4(rvMainWindow, nsIBaseWindow, nsIInterfaceRequestor, nsIWebShellContainer, nsIDOMFocusListener)

// The main browser event handler
static nsEventStatus PR_CALLBACK HandleMainWindowEvent(nsGUIEvent *aEvent)
{ 
	nsEventStatus result = nsEventStatus_eIgnore;
	rvMainWindow* bw = theApp->mParentWindow->FindBrowserFor(aEvent->widget, FIND_WINDOW);
	PRBool mousemove = PR_FALSE;

	if (nsnull != bw) 
	{
		nsCOMPtr<nsIWebBrowserFocus> focus = do_GetInterface(bw->mWebBrowser);
		
		if (focus)
			focus->Activate();
			
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
				theApp->mParentWindow->CloseBrowserWindow(bw);
				NS_RELEASE(bw);
				result = nsEventStatus_eConsumeNoDefault;
				return result;
			}
			case NS_ACTIVATE:
			{
				nsCOMPtr<nsIWebBrowserFocus> focus = do_GetInterface(bw->mWebBrowser);
				if (focus)
					focus->Activate();
			}
			break;

			case NS_DEACTIVATE:
			{
				nsCOMPtr<nsIWebBrowserFocus> focus = do_GetInterface(bw->mWebBrowser);
				if (focus)
				  focus->Deactivate();
			}
			break;
			default:
				break;
		}

		nsFocusEvent* fEvent = (nsFocusEvent*) aEvent;
		if (fEvent != nsnull && fEvent->isMozWindowTakingFocus) 
		{
			bw->mParent->SetActiveBrowser(bw);
			bw->mWindowTakingFocus = PR_TRUE;
			bw->OnDesignMode_HighlightElement();
		}

		NS_RELEASE(bw);
	}
  
	return result;
}

// cons/dest
void rvMainWindow::InitializeMembers()
{
  mApp = nsnull;
	mParent = nsnull;
  mAppShell = nsnull;
  mTitle = MozStr("");
  mWindow = nsnull;
 	m_window_type = eWindowType_toplevel;;
	m_border_style = eBorderStyle_default;
//  mSubWinType = IIW_Main;
	mWidth = mHeight = 0;
	m_doc_pos = 0; // 0-no dock, 1-left, 2-top, 3-right,4-bottom
	m_on_top = PR_FALSE; // true means always on top
	m_resize = PR_TRUE; // true means user resizable, else false
	mMainAction = IIMA_None;
	mWebBrowser = nsnull;
  mWebBrowserChrome = nsnull;
  mContentRoot = nsnull; // Points at the Root Content Node
  mChromeMask = nsIWebBrowserChrome::CHROME_ALL;
  mDocIsLoaded = PR_FALSE;
  mDataPath = nsnull;
	mIsInDesignMode = PR_FALSE;
	mWindowTakingFocus = PR_FALSE;
	m_dom_pick_listener = nsnull;  
	mRuleProcessor = nsnull;
	mRuleRenderer = nsnull;
}

NS_IMETHODIMP rvMainWindow::Destroy()
{
	// important to remove listeners first
	UninitializeListeners();

	// Clear frame tree
	ClearFrameTree(&m_root_frame);

  // Others are holding refs to this, 
  // but it gets released OK.
	if (mDocShell != nsnull)
	{
		nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
		webShell->SetContainer(nsnull);
		mDocShell = nsnull;
	}

	if (mWebBrowserChrome != nsnull)
	{
		nsWeakPtr weakling(do_GetWeakReference((nsIWebProgressListener*) mWebBrowserChrome));
		mWebBrowser->RemoveWebBrowserListener(weakling, NS_GET_IID(nsIWebProgressListener));
		mWebBrowser->SetContainerWindow(nsnull);

		NS_RELEASE(mWebBrowserChrome);
		delete mWebBrowserChrome;
		mWebBrowserChrome = nsnull;
	}

	if (mWebBrowser != nsnull)
	{
		nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
		webBrowserWin->Destroy();

		mWebBrowser = nsnull;
	}

	if (mWindow != nsnull)
	{
		DestroyWidget(mWindow);
		mWindow = nsnull;
	}
	
	if (mAppShell != nsnull)
		NS_IF_RELEASE(mAppShell);

	InitializeMembers();
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::DestroyWidget(nsISupports* aWidget)
{
  if (aWidget) 
  {
    nsCOMPtr<nsIWidget> wdgt(do_QueryInterface(aWidget));
    if (wdgt) 
      wdgt->Destroy();
  }

  return NS_OK;
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

// window functions
NS_IMETHODIMP rvMainWindow::InitWindow(nativeWindow aParentNativeWindow, nsIWidget* parentWidget, PRInt32 x, PRInt32 y, PRInt32 cx, PRInt32 cy)   
{
   // Ignore wigdet parents for now.  Don't think those are a vaild thing to call.
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, cx, cy, PR_FALSE), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Init(rvParentWindow* aParWin, nsIAppShell* aAppShell, const nsRect& aBounds, PRBool aMakeVisible)
{
  // inits
  mChromeMask = nsIWebBrowserChrome::CHROME_ALL;
  mParent = aParWin;
  mAppShell = aAppShell;
  NS_IF_ADDREF(mAppShell);
	m_root_frame.m_doc = nsnull;

  // create the main widget
  nsresult rv = NS_OK;
  rv = nsComponentManager::CreateInstance(kChildCID, nsnull, kIWidgetIID, getter_AddRefs(mWindow));
  if (NS_OK != rv) 
    return rv;

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
  
  // create the web browser
  mWebBrowser = do_CreateInstance(NS_WEBBROWSER_CONTRACTID);
  NS_ENSURE_TRUE(mWebBrowser, NS_ERROR_FAILURE);
  nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
  rv = webBrowserWin->InitWindow(mWindow->GetNativeData(NS_NATIVE_WIDGET), nsnull, r.x, r.y, r.width, r.height);
  webBrowserWin->Create();

  NS_ENSURE_SUCCESS(EnsureWebBrowserChrome(), NS_ERROR_FAILURE);
  mWebBrowser->SetContainerWindow(mWebBrowserChrome);
  nsWeakPtr weakling(do_GetWeakReference((nsIWebProgressListener*) mWebBrowserChrome));
  mWebBrowser->AddWebBrowserListener(weakling, NS_GET_IID(nsIWebProgressListener));
  
  // set up the doc shell
  mDocShell = do_GetInterface(mWebBrowser);
  mDocShell->SetAllowPlugins(PR_TRUE);
  nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
  webShell->SetContainer((nsIWebShellContainer*) this);

	// visiblity
	if (aMakeVisible)
		MakeVisible();
	else
		MakeInvisible();

  // layout the window
  mWidth = r.width;
  mHeight = r.height;
  Layout(r.width, r.height);

  m_dom_pick_listener = nsnull;
	mWindowTakingFocus = PR_TRUE;

  // return success
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

void rvMainWindow::MakeVisible()
{
	SetVisibility(PR_TRUE);
	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	webBrowserWin->SetVisibility(PR_TRUE);
}

void rvMainWindow::MakeInvisible()
{
	SetVisibility(PR_FALSE);
	nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
	webBrowserWin->SetVisibility(PR_FALSE);
}

NS_IMETHODIMP rvMainWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
{
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

NS_IMETHODIMP rvMainWindow::GetChrome(PRUint32& aChromeMaskResult)
{
  aChromeMaskResult = mChromeMask;
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::EnsureWebBrowserChrome()
{
   if (mWebBrowserChrome != nsnull)
      return NS_OK;

   mWebBrowserChrome = new nsWebBrowserChrome();
   NS_ENSURE_TRUE(mWebBrowserChrome, NS_ERROR_OUT_OF_MEMORY);

   NS_ADDREF(mWebBrowserChrome);
   mWebBrowserChrome->BrowserWindow(this);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetWebShell(nsIWebShell*& aResult)
{
  nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
  aResult = webShell;
  NS_IF_ADDREF(aResult);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GoTo(const nsString aURL)
{
	if (mDocShell != nsnull && !aURL.EqualsIgnoreCase(""))
	{
     nsCOMPtr<nsIWebNavigation> webNav(do_QueryInterface(mDocShell));
//  	_ILOG(aURL);
    webNav->LoadURI(aURL.get(), nsIWebNavigation::LOAD_FLAGS_NONE, nsnull, nsnull, nsnull);
	}

	return NS_OK;
}

// dom functions
void rvMainWindow::ClearFrameTree(Frame* p_frame)
{
	if (p_frame->m_doc != nsnull)
	{
		NS_RELEASE(p_frame->m_doc);
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

//---------------------------------------------------------------
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

nsIPresShell* rvMainWindow::GetPresShellFor(nsIDocShell* aDocShell)
{
  nsIPresShell* shell = nsnull;
  if (nsnull != aDocShell) 
  {
    nsIContentViewer* cv = nsnull;
    aDocShell->GetContentViewer(&cv);
    if (nsnull != cv) 
		{
      nsIDocumentViewer* docv = nsnull;
      cv->QueryInterface(kIDocumentViewerIID, (void**) &docv);
      if (nsnull != docv) 
			{
        nsCOMPtr<nsIPresContext> cx;
        docv->GetPresContext(getter_AddRefs(cx));
        if (nsnull != cx) 
				{
          NS_IF_ADDREF(shell = cx->GetPresShell());
        }
        NS_RELEASE(docv);
      }
      NS_RELEASE(cv);
    }
  }
  return shell;
}

NS_IMETHODIMP rvMainWindow::GetPresShell(nsIPresShell** aPresShell)
{  
	*aPresShell = GetPresShellFor(mDocShell);
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetDocument(nsIDOMHTMLDocument *& aDocument)
{
  nsIDOMHTMLDocument *htmlDoc = nsnull;
  nsIPresShell *shell = nsnull;
  GetPresShell(&shell);
  if (nsnull != shell) 
  {
    nsCOMPtr<nsIDocument> doc;
    shell->GetDocument(getter_AddRefs(doc));
    if (doc) 
		{
      doc->QueryInterface(kIDOMHTMLDocumentIID,(void **)&htmlDoc);
    }
    NS_RELEASE(shell);
}

  aDocument = htmlDoc;
  return NS_OK;
}

nsAutoString rvMainWindow::GetFrameID(nsIDOMHTMLDocument* p_doc, Frame* p_frame)
{
//	_ILOG(p_frame->m_id);
	if (p_frame->m_doc == p_doc)
		return p_frame->m_id;

	Frame* frm = nsnull;
	PRInt32 idx = 0;
	while (p_frame->m_sub_frames != nsnull && idx < p_frame->m_sub_frames->Count())
	{
		nsAutoString id = GetFrameID(p_doc, (Frame*) p_frame->m_sub_frames->ElementAt(idx++));
		if (id != MozStr(""))
			return id;
	}

	return MozStr("");
}

void rvMainWindow::RecurseAndCreateFrameInfo(Frame *p_frame)
{
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
}

nsIDOMHTMLDocument* rvMainWindow::GetFrameHTMLDocument(Frame* p_frame, nsAutoString p_frame_url, nsAutoString p_frame_location)
{
//	_ILOG(p_frame->m_id);
	if (p_frame->m_url == p_frame_url && p_frame->m_id == p_frame_location)
		return p_frame->m_doc;

	Frame* frm = nsnull;
	PRInt32 idx = 0;
	while (p_frame->m_sub_frames != nsnull && idx < p_frame->m_sub_frames->Count())
	{
		nsIDOMHTMLDocument* doc = GetFrameHTMLDocument((Frame*) p_frame->m_sub_frames->ElementAt(idx++), p_frame_url, p_frame_location);
		if (doc != nsnull)
			return doc;
	}

	return nsnull;
}

NS_IMETHODIMP rvMainWindow::CreateEmptyDocument()
{
  nsIDOMHTMLDocument *htmlDoc = nsnull;
  nsIDOMWindow *aContentDOMWindow;
  mWebBrowser->GetContentDOMWindow(&aContentDOMWindow);
	 
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::WillLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsLoadType aReason)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP rvMainWindow::BeginLoadURL(nsIWebShell* aShell, const PRUnichar* aURL)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP rvMainWindow::ProgressLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, PRInt32 aProgress, PRInt32 aProgressMax)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP rvMainWindow::EndLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsresult aStatus)
{
	InitializeListeners();
	return NS_OK;
}

void rvMainWindow::InitializeListeners()
{
	// create the frame tree
	nsIDOMHTMLDocument* doc;
	GetDocument(doc);

	if (doc == nsnull)
		return;

	if (mSubWinType != IIW_Form && doc != nsnull)
	{
		nsIDOMEventReceiver * receiver;
		if (NS_OK == doc->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
		{
			nsIEventListenerManager* mgr;
			receiver->GetListenerManager(&mgr);
			mgr->AddEventListenerByIID((nsIDOMFocusListener*) this, kIDOMFocusListenerIID,NS_EVENT_FLAG_INIT);
			// TODO mgr->AddEventListenerByIID((nsIDOMMouseListener*) this, kIDOMMouseListenerIID,NS_EVENT_FLAG_INIT);
			NS_RELEASE(receiver);
			NS_RELEASE(mgr);
		}
	}

	if (mSubWinType == IIW_Form)
		m_form_browser_container->InitializeListeners();

	// add the event listeners for the action tracker
	if (mSubWinType == IIW_Main)
	{
		if (m_dom_pick_listener != nsnull)
			m_dom_pick_listener->RemoveListeners(this);
		else
		{
			m_dom_pick_listener = new rvDOMEventListener();
			NS_ADDREF(m_dom_pick_listener);
		}
	}

	// clear the existing frame info
	ClearFrameTree(&m_root_frame);

	// create new frame info
	m_root_frame.m_doc = doc;
	NS_ADDREF(m_root_frame.m_doc);

	doc->GetURL(m_root_frame.m_url);
	m_root_frame.m_id = MozStr("0");
	m_root_frame.m_sub_frames = nsnull;
	RecurseAndCreateFrameInfo(&m_root_frame);

	// add listeners based on the new frameset
	if (mSubWinType == IIW_Main)
		m_dom_pick_listener->AddListeners(this);

	if (mSubWinType == IIW_RuleProcessor)
		mRuleProcessor->FinishedLoadingDocument();
	else if (mSubWinType == IIW_AlertView)
		mRuleRenderer->FinishedLoadingAlertDocument();

	if (doc != nsnull)
		NS_RELEASE(doc);
}

void rvMainWindow::UninitializeListeners()
{
	nsIDOMHTMLDocument* doc;
	GetDocument(doc);

	if (doc == nsnull)
		return;

	nsIDOMEventReceiver * receiver;
  if (mSubWinType != IIW_Form && doc != nsnull && NS_OK == doc->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) 
	{
		nsIEventListenerManager* mgr;
		receiver->GetListenerManager(&mgr);
    mgr->RemoveEventListenerByIID((nsIDOMFocusListener*) this, kIDOMFocusListenerIID,NS_EVENT_FLAG_INIT);
		// TODO mgr->RemoveEventListenerByIID((nsIDOMFocusListener*) this, kIDOMMouseListenerIID,NS_EVENT_FLAG_INIT);
    NS_RELEASE(receiver);
		NS_RELEASE(mgr);
  }

	NS_RELEASE(doc);

	if (mSubWinType == IIW_Form)
	{
		m_form_browser_container->UninitializeListeners();
		m_form_browser_container = nsnull;
	}

	if (mSubWinType == IIW_Main)
	{
		if (m_dom_pick_listener != nsnull)
		{
			m_dom_pick_listener->RemoveListeners(this);
			NS_RELEASE(m_dom_pick_listener);
			delete m_dom_pick_listener;
			m_dom_pick_listener = nsnull;
		}
	}
}

// focus listener. THis is required for bring child windows to front on clickng in the view region
NS_IMETHODIMP rvMainWindow::Focus(nsIDOMEvent* aEvent)
{
	mWindow->PlaceBehind(eZPlacementTop, nsnull, PR_TRUE);
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Blur(nsIDOMEvent* aEvent)
{
	return NS_OK;
}

// mouse / key event handlers
NS_IMETHODIMP rvMainWindow::HandleEvent(nsIDOMEvent* aEvent)
{
	nsString s(NS_LITERAL_STRING(""));
	aEvent->GetType(s);

	nsGUIEvent* ev = (nsGUIEvent*) aEvent;
	if (s.EqualsIgnoreCase("click") == PR_TRUE)
		return MouseClick(aEvent);
	else if (s.EqualsIgnoreCase("mouseover") == PR_TRUE)
	{
		OnDesignMode_HighlightElement();
		return NS_OK; // MouseOver(aEvent);
	}

	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::MouseClick(nsIDOMEvent* aMouseEvent)
{
	if (mIsInDesignMode == PR_FALSE)
		return NS_OK;

	if (mMainAction == IIMA_WWW2PWW)
		MouseClick_MoveToPWW(aMouseEvent);
	
	return NS_OK;
}

NS_IMETHODIMP rvMainWindow::MouseOver(nsIDOMEvent* aMouseEvent)
{
	 return NS_OK;
}

NS_IMETHODIMP rvMainWindow::MouseUp(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::MouseDown(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::MouseDblClick(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::MouseOut(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

// PWW functions
NS_IMETHODIMP rvMainWindow::MouseClick_MoveToPWW(nsIDOMEvent* aMouseEvent)
{
	if (mParent->mActivePWWBrowser == NULL)
			return NS_OK;

	// move style sheets
	if (mIsStyleSheetsMoved == PR_FALSE) 
	{
		SavePage();
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

void rvMainWindow::SetRuleProcessor(CRuleProcessor* rule_processor)
{
	mRuleProcessor = rule_processor;
}

void rvMainWindow::SetRuleRenderer(CRuleRenderer* rule_renderer)
{
	mRuleRenderer = rule_renderer;
}

// persist functions
NS_IMETHODIMP rvMainWindow::SavePage(nsAutoString path_file_name)
{
    nsCOMPtr<nsIBaseWindow> webBrowserAsWin = do_QueryInterface(mWebBrowser);
    nsXPIDLString windowTitle;
		
    char szFile[_MAX_PATH];
		char szFile_URI[_MAX_PATH];
		char szDataFile[_MAX_PATH];
		char szDataPath[_MAX_PATH];
    char drive[_MAX_DRIVE];
    char dir[_MAX_DIR];
    char fname[_MAX_FNAME];
    char ext[_MAX_EXT];
		char *pszDataPath = NULL;

		if (path_file_name == MozStr(""))
		{
			webBrowserAsWin->GetTitle(getter_Copies(windowTitle));
			nsCString fileName(""); 
			fileName.AssignWithConversion(windowTitle);
			fileName.CompressWhitespace();     // Remove whitespace from the ends
			fileName.ReplaceChar(' ', L'_');
			fileName.StripChars("\\*|:\"><?"); // Strip illegal characters
			fileName.ReplaceChar('/', L'-');   // Forward slashes become hyphens
	
			memset(szFile, 0, sizeof(szFile));
			strncpy(szFile, "C:\\MyMozFiles\\MyMozCache\\PWW\\", 30); // XXXldb probably should be just sizeof(szfile)
			strncat(szFile, fileName.get(), fileName.Length() - 1);
		_splitpath(szFile, drive, dir, fname, ext);
    sprintf(szDataFile, "%s_files", fname);
    _makepath(szDataPath, drive, dir, szDataFile, "");

		}
		else
		{
			memset(szDataFile, 0, sizeof(szDataFile));
			strncpy(szDataFile, "C:\\MyMozFiles\\MyMozCache\\PWW\\", 30); // XXXldb probably should be just sizeof(szfile)
			strncpy(szFile_URI,  "file:///C:/MyMozFiles/MyMozCache/PWW/", 38);

			char* buf = new char[path_file_name.Length()+1];
			path_file_name.ToCString(buf, path_file_name.Length()+1);
			strncat(szDataFile, buf, path_file_name.Length()+1);
			strncat(szFile_URI, buf, path_file_name.Length()+1);

			time_t t1;
			time(&t1);
			tm *t = localtime(&t1);
			char buft[12];
			sprintf(buft,"%d_%d_%d", t->tm_hour,t->tm_min,t->tm_sec);

			sprintf(szDataFile, "%s_files\\",szDataFile);
			PR_MkDir(szDataFile, PR_RDWR);
			sprintf(szDataFile, "%s%s",szDataFile, buft);
			PR_MkDir(szDataFile, PR_RDWR);
			sprintf(szFile_URI, "%s_files/%s/", szFile_URI, buft);

			sprintf(szFile, "%s\\%s.html", szDataFile, buf);
			sprintf(szFile_URI, "%s/%s.html", szFile_URI, buf);
			
			_splitpath(szFile, drive, dir, fname, ext);
			_makepath(szDataPath, drive, dir, "", "");

			delete buf;
		}  

    pszDataPath = szDataPath;
		nsCOMPtr<nsILocalFile> file;
    NS_NewNativeLocalFile(nsDependentCString(szFile), PR_TRUE, getter_AddRefs(file));
		//nsCOMPtr<nsILocalFile> file1 =do_QueryInterface(file);
    nsCOMPtr<nsILocalFile> dataPath;
    NS_NewNativeLocalFile(nsDependentCString(pszDataPath), PR_TRUE, getter_AddRefs(dataPath));

    nsIDOMHTMLDocument* doc;
    GetDocument(doc);

    if (!doc)
      return NS_OK;

    // Create a throwaway persistence object to do the work
    nsresult rv;
		nsCOMPtr<nsIWebBrowserPersist> persist;
    persist = do_CreateInstance(NS_WEBBROWSERPERSIST_CONTRACTID, &rv);
		 
    persist->SetPersistFlags(nsIWebBrowserPersist::PERSIST_FLAGS_DONT_CHANGE_FILENAMES | 
														 nsIWebBrowserPersist::PERSIST_FLAGS_FIXUP_ORIGINAL_DOM |
														 nsIWebBrowserPersist::PERSIST_FLAGS_SERIALIZE_OUTPUT);
		// TODO: Check the change from file1 to file
    rv = persist->SaveDocument(doc, file, dataPath, nsnull, nsIWebBrowserPersist::ENCODE_FLAGS_ABSOLUTE_LINKS, 0);

		nsIURI* uri;
		NS_NewURI(&uri,szFile_URI);
	  nsCOMPtr<nsIDocument> doc1 = do_QueryInterface(doc);
		if (!doc1) return NS_ERROR_FAILURE;

		doc1->SetDocumentURI(uri);
		doc1->SetBaseURI(uri);


    persist = nsnull;

		if (mDataPath != nsnull)
			delete mDataPath;

		mDataPath = new char[strlen(pszDataPath)];
		strcpy(mDataPath, pszDataPath);
		NS_RELEASE(uri);
		NS_RELEASE(doc);
		return NS_OK;
}

// utility functions
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

	_ILOG("Node Name: ");
	_ILOG(name);

	elem->GetNodeValue(val);
	_ILOG("Node Value: ");
	_ILOG(val);

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
			_ILOG("Attr Name: ");
			_ILOG(namea);
			_ILOG("Attr Value: ");
			_ILOG(vala);
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


