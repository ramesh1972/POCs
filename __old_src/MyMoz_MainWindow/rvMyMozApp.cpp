#include "nsISupportsObsolete.h"
#include "nsCOMPtr.h"
#include "nsICookieService.h"
#include "nsIServiceManager.h"
#include "nsIComponentRegistrar.h"
#include "nsICookieService.h"
#include "nsIWindowWatcher.h"
#include "prprf.h"
#include "nsIAppShell.h"
#include "nsWidgetsCID.h"

#include <windows.h>

#include "rvMyMozapp.h"
#include "rvWindowCreator.h"
#include "rvMainWindow.h"
#include "rvXPBaseWindow.h"

extern nsresult NS_NewXPBaseWindowFactory(nsIFactory** aFactory);

static NS_DEFINE_IID(kISupportsIID, NS_ISUPPORTS_IID);
static NS_DEFINE_IID(kCookieServiceCID, NS_COOKIESERVICE_CID);

static NS_DEFINE_IID(kAppShellCID, NS_APPSHELL_CID);
static NS_DEFINE_IID(kIAppShellIID, NS_IAPPSHELL_IID);

static NS_DEFINE_IID(kXPBaseWindowCID, NS_XPBASE_WINDOW_CID);

#define DEFAULT_WIDTH 620
#define DEFAULT_HEIGHT 400

rvMyMozApp::rvMyMozApp()
{
  mIsInitialized = PR_FALSE;
  mWidth = DEFAULT_WIDTH;
  mHeight = DEFAULT_HEIGHT;
}

rvMyMozApp::~rvMyMozApp()
{

}

// XMPCOM interface funtions
NS_IMPL_THREADSAFE_ADDREF(rvMyMozApp)
NS_IMPL_THREADSAFE_RELEASE(rvMyMozApp)



nsresult rvMyMozApp::QueryInterface(REFNSIID aIID, void** aInstancePtrResult) 
{
  NS_PRECONDITION(nsnull != aInstancePtrResult, "null pointer");

  if (nsnull == aInstancePtrResult) {
    return NS_ERROR_NULL_POINTER;
  }

  if (aIID.Equals(kISupportsIID)) {
    nsISupports* tmp = this;
    *aInstancePtrResult = (void*) tmp;
    NS_ADDREF_THIS();
    return NS_OK;
  }

#if defined(NS_DEBUG) 
  /*
   * Check for the debug-only interface indicating thread-safety
   */
  static NS_DEFINE_IID(kIsThreadsafeIID, NS_ISTHREADSAFE_IID);
  if (aIID.Equals(kIsThreadsafeIID)) {
    return NS_OK;
  }
#endif /* NS_DEBUG */

  return NS_NOINTERFACE;
}

// this app functions
nsresult rvMyMozApp::Initialize(int argc, char** argv) {
  nsresult rv;

  // setup registry
  nsCOMPtr<nsIServiceManager> servManager;
	   NS_GetServiceManager(getter_AddRefs(servManager));
  nsCOMPtr<nsIComponentRegistrar> registrar = do_QueryInterface(servManager);
  NS_ASSERTION(registrar, "No nsIComponentRegistrar from get service. see dougt");
  rv = registrar->AutoRegister(nsnull);

//
  // Register our browser window factory
/*  nsIFactory* bwf;
  NS_NewXPBaseWindowFactory(&bwf);
  registrar->RegisterFactory(kXPBaseWindowCID, 0, 0, bwf);
  NS_RELEASE(bwf);*/

  // register the cookie manager
  nsCOMPtr<nsICookieService> cookieService = do_GetService(kCookieServiceCID, &rv);
  if (NS_FAILED(rv) || (nsnull == cookieService)) {
#ifdef DEBUG
    printf("Unable to instantiate Cookie Manager\n");
#endif
  }

   /* InitializeWindowCreator creates and hands off an object with a callback
   to a window creation function. This is how all new windows are opened,
   except any created directly by the viewer app. */

  // create an nsWindowCreator and give it to the WindowWatcher service
  rvWindowCreator *creatorCallback = new rvWindowCreator(this);
  if (creatorCallback) 
  {
    nsCOMPtr<nsIWindowCreator> windowCreator(NS_STATIC_CAST(nsIWindowCreator *, creatorCallback));
    if (windowCreator) 
	{
      nsCOMPtr<nsIWindowWatcher> wwatch(do_GetService(NS_WINDOWWATCHER_CONTRACTID));
      if (wwatch) 
	  {
        wwatch->SetWindowCreator(windowCreator);
	  }
	  else
		  return NS_ERROR_FAILURE;
	}
	else
		return NS_ERROR_FAILURE;
  }
  else
	  return NS_ERROR_FAILURE;
  
  // create the application shell
    // Create widget application shell
  rv = nsComponentManager::CreateInstance(kAppShellCID, nsnull, kIAppShellIID,
                                          (void**)&mAppShell);

  mAppShell->Create(&argc, argv);
  mIsInitialized = PR_TRUE;

  return rv;
}

int rvMyMozApp::Run() 
{
  OpenWindow();
 
  // Process messages
  MSG  msg;
  int  keepGoing = 1;

  // Pump all messages
  do {
    // Give priority to system messages (in particular keyboard, mouse,
    // timer, and paint messages).
    // Note: on Win98 and NT 5.0 we can also use PM_QS_INPUT and PM_QS_PAINT flags.
    if (::PeekMessage(&msg, NULL, 0, WM_USER-1, PM_REMOVE) || 
      ::PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) {

      keepGoing = (msg.message != WM_QUIT);

      // If we successfully retrieved a message then dispatch it
      if (keepGoing >= 0) {
  //      if (!JSConsole::sAccelTable || !gConsole || !gConsole->GetMainWindow() ||
    //      !TranslateAccelerator(gConsole->GetMainWindow(), JSConsole::sAccelTable, &msg)) {
          TranslateMessage(&msg);
          DispatchMessage(&msg);
      //  }
      }

    } else {
       // Block and wait for any posted application message
      ::WaitMessage();
    }
  } while (keepGoing != 0);

  return msg.wParam;
}

NS_IMETHODIMP rvMyMozApp::OpenWindow() {
  mWin = new rvMainWindow();
  NS_ENSURE_TRUE(mWin, NS_ERROR_FAILURE);
  NS_ADDREF(mWin);

  mWin->SetApp(this);

  mWin->Init(mAppShell, nsRect(0, 0, mWidth, mHeight));
  mWin->SetVisibility(PR_TRUE);


  return NS_OK;
}

NS_IMETHODIMP
rvMyMozApp::CloseWindow(rvMainWindow* aMainWindow)
{
  aMainWindow->Destroy();
  NS_RELEASE(aMainWindow);

  return NS_OK;
}

