#include "rvMyMozapp.h"
#include "rvParentWindow.h"
#include "rvMainWindow.h"
#include "rvWindowCreator.h"

// externs
IAPPG;

rvWindowCreator::rvWindowCreator(rvMyMozApp *aApp)
{
  mApp = aApp;
}

rvWindowCreator::~rvWindowCreator()
{
}

NS_IMPL_ISUPPORTS1(rvWindowCreator, nsIWindowCreator)

// Popups are loaded via this function callback
NS_IMETHODIMP rvWindowCreator::CreateChromeWindow(nsIWebBrowserChrome *parent, PRUint32 chromeFlags, nsIWebBrowserChrome **_retval) 
{
	ILOG << "rvWindowCreator::CreateChromeWindow()" << IINF;
	IL_TAB;

	rvMainWindow* pbrowser = nsnull;
	II_WindowType wintype = IIW_WWW;

	nsWebBrowserChrome* pwin = (nsWebBrowserChrome*) parent;
	if (pwin != nsnull)
	{
		pbrowser = pwin->mBrowserWindow;
		if (pbrowser != nsnull)
			wintype = pbrowser->mSubWinType; 
	}
	
  NS_ENSURE_ARG_POINTER(_retval);
  *_retval = NULL;

	ILOG << "Creating Popup Window" << IINF;

  rvMainWindow* browser = new rvMainWindow();
  NS_ENSURE_TRUE(browser, NS_ERROR_FAILURE);
  NS_ADDREF(browser);

	browser->mChromeMask = chromeFlags;
	browser->m_doc_pos = 0;
	browser->m_window_type = eWindowType_toplevel;
	browser->m_border_style = eBorderStyle_default;
	browser->SetApp(mApp);

	if (pbrowser != nsnull)
	{
		ILOG << "Setting Referer Browser" << IINF;
		browser->m_referer_browser = pbrowser;  
	}
	else
	{
		ILOG << "Not able to set Referer" << IERR;
	}
  
	// In normal operation we can show the popup window.
	// But in rule processing stage, no rule processing windows should be VISIBLE
	if (wintype == IIW_RuleProcessor)
	{
		browser->m_border_style = eBorderStyle_none;
		browser->mSubWinType = IIW_RuleProcessor_Popup;
		
		ON_THE_RUN(NS_ERROR_FAILURE)
		browser->Init(IPWW, IAPP->mAppShell, nsRect(0,0,0,0), PR_FALSE);
		browser->MakeInvisible(); 
	}
	else
	{
		browser->m_border_style = eBorderStyle_default;
		browser->mSubWinType = IIW_WWW_Popup;
		
		ON_THE_RUN(NS_ERROR_FAILURE)
		browser->Init(IPWW, IAPP->mAppShell,nsRect(0, 0, 600, 400));
		browser->MakeVisible(); 
	}

  // add the browser
	ON_THE_RUN(NS_ERROR_FAILURE)
  IPWW->AddBrowser(browser);

	nsCOMPtr<nsIWebBrowserChrome> chrome(do_GetInterface(NS_STATIC_CAST(nsIInterfaceRequestor *, browser)));
  if (chrome) 
	{
    chrome->SetChromeFlags(chromeFlags);
    *_retval = chrome;
    NS_ADDREF(*_retval);
		ILOG << "Passed handling to Chrome" << IINF;  
  }
	else
		ILOG << "Could not pass handling to Chrome" << IERR;  

	NS_RELEASE(browser);
	ILOG << "Created Popup" << IINF;  
	IL_UNTAB;
  return NS_OK;
}
