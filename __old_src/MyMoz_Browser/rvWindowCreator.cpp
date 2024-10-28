#include "rvMyMozapp.h"
#include "rvParentWindow.h"
#include "rvMainWindow.h"
#include "rvWindowCreator.h"

extern rvMyMozApp* theApp;
rvWindowCreator::rvWindowCreator(rvMyMozApp *aApp)
{
  mApp = aApp;
}

rvWindowCreator::~rvWindowCreator()
{
}

NS_IMPL_ISUPPORTS1(rvWindowCreator, nsIWindowCreator)

NS_IMETHODIMP rvWindowCreator::CreateChromeWindow(nsIWebBrowserChrome *parent, PRUint32 chromeFlags, nsIWebBrowserChrome **_retval) 
{

  NS_ENSURE_ARG_POINTER(_retval);
  *_retval = NULL;

  rvMainWindow* browser = nsnull;
  NS_ENSURE_TRUE(browser, NS_ERROR_FAILURE);
  NS_ADDREF(browser);

	browser->mChromeMask = chromeFlags;
	browser->m_doc_pos = 0;
	browser->mSubWinType = IIW_Main;
	browser->m_window_type = eWindowType_toplevel;
	browser->m_border_style = eBorderStyle_default;
	browser->SetApp(mApp);
  browser->Init(theApp->mParentWindow, theApp->mAppShell,nsRect(0, 0, 600, 600));
	browser->MakeVisible(); 

  // add the browser
  theApp->mParentWindow->AddBrowser(browser);
	NS_RELEASE(browser);

  nsCOMPtr<nsIWebBrowserChrome> chrome(do_GetInterface(NS_STATIC_CAST(nsIInterfaceRequestor *, browser)));
  if (chrome) 
	{
    chrome->SetChromeFlags(chromeFlags);
    *_retval = chrome;
    NS_ADDREF(*_retval);
  }

  return NS_OK;
}
