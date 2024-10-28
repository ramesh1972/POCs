#include "rvWindowCreator.h"
#include "rvMyMozapp.h"

rvWindowCreator::rvWindowCreator(rvMyMozApp *aApp)
{
  mApp = aApp;
}

rvWindowCreator::~rvWindowCreator()
{
}

NS_IMPL_ISUPPORTS1(rvWindowCreator, nsIWindowCreator)

NS_IMETHODIMP rvWindowCreator::CreateChromeWindow(nsIWebBrowserChrome *parent, PRUint32 chromeFlags, nsIWebBrowserChrome **_retval) {

	return NS_OK;
}
