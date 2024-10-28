#include "rvParentWindow.h"
#include "rvWindowCreator.h"
#include "rvMyMozapp.h"

// The main global vars
extern HINSTANCE gInstance, gPrevInstance;
extern rvMyMozApp* theApp;

rvMyMozApp::rvMyMozApp()
{
  mIsInitialized = PR_FALSE;
	mAppShell = nsnull;
	mParentWindow = nsnull;
	log = nsnull;
	
	NS_ADDREF_THIS();
}

rvMyMozApp::~rvMyMozApp()
{
	Exit();
	NS_RELEASE_THIS();
}

// XMPCOM interface funtions
NS_IMPL_THREADSAFE_ADDREF(rvMyMozApp)
NS_IMPL_THREADSAFE_RELEASE(rvMyMozApp)

nsresult rvMyMozApp::QueryInterface(REFNSIID aIID, void** aInstancePtrResult) 
{
  NS_PRECONDITION(nsnull != aInstancePtrResult, "null pointer");

  if (nsnull == aInstancePtrResult) 
  {
    return NS_ERROR_NULL_POINTER;
  }

  if (aIID.Equals(kISupportsIID)) 
  {
    nsISupports* tmp = this;
    *aInstancePtrResult = (void*) tmp;
    NS_ADDREF_THIS();
    return NS_OK;
  }

  return NS_NOINTERFACE;
}

// this app functions
nsresult rvMyMozApp::Initialize(int argc, char** argv) 
{
	
	if (mIsInitialized)
		return NS_OK;

  nsresult rv;

	// set up log
	// log file
	if (log == nsnull)
	{
		log = new CFileLogger();
		log->CreateLogFile();
		_ILOG("Start Logging");
	}

	// setup registry
	_ILOG("Initializing Components");

	nsComponentManager::Initialize();
  nsCOMPtr<nsIServiceManager> servManager;
  NS_GetServiceManager(getter_AddRefs(servManager));
  
	nsCOMPtr<nsIComponentRegistrar> registrar = do_QueryInterface(servManager);
  NS_ASSERTION(registrar, "No nsIComponentRegistrar from get service. see dougt");
  rv = registrar->AutoRegister(nsnull);

  // set app dir
	nsCOMPtr<nsIFile> appDataDir;
	rv = NS_GetSpecialDirectory(NS_APP_APPLICATION_REGISTRY_DIR, getter_AddRefs(appDataDir));
	if (NS_FAILED(rv))
	  return rv;

	appDataDir->Append(NS_LITERAL_STRING("MyMoz"));
	nsCOMPtr<nsILocalFile> localAppDataDir(do_QueryInterface(appDataDir));

	nsCOMPtr<nsProfileDirServiceProvider> locProvider;
	NS_NewProfileDirServiceProvider(PR_TRUE, getter_AddRefs(locProvider));
	if (!locProvider)
	  return NS_ERROR_FAILURE;

	rv = locProvider->Register();
	if (NS_FAILED(rv))
	  return rv;
              
	locProvider->SetProfileDir(localAppDataDir);

  // register the cookie manager
   nsCOMPtr<nsICookieService> cookieService = do_GetService(kCookieServiceCID, &rv);
  if (NS_FAILED(rv) || (nsnull == cookieService)) 
	{
		#ifdef DEBUG
			printf("Unable to instantiate Cookie Manager\n");
		#endif
  }

  // Load preferences
/*
  rv = CallGetService(NS_PREFSERVICE_CONTRACTID, &mPrefService);
  if (NS_OK != rv) {
    return rv;
  }
  mPrefService->ReadUserPrefs(nsnull);
*/

  /* InitializeWindowCreator creates and hands off an object with a callback
   to a window creation function. This is how all new windows are opened,
   except any created directly by the viewer app. */

  // create an nsWindowCreator and give it to the WindowWatcher service
  mCreatorCallback = new rvWindowCreator(this);
  if (mCreatorCallback) 
  {
    nsCOMPtr<nsIWindowCreator> windowCreator(NS_STATIC_CAST(nsIWindowCreator *, mCreatorCallback));
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
  rv = nsComponentManager::CreateInstance(kAppShellCID, nsnull, kIAppShellIID, (void**)&mAppShell);
  mAppShell->Create(&argc, argv);
  mIsInitialized = PR_TRUE;

	// ref count
	_ILOG("Completed Initializing Components");
  return rv;
}

int rvMyMozApp::Run() 
{
	// Open the parent window with menu and stuff
  OpenParentWindow();
  
  // Process messages
  MSG  msg;
  int  keepGoing = 1;

  // Pump all messages
  do 
	{
    // Give priority to system messages (in particular keyboard, mouse, timer, and paint messages).
    if (::PeekMessage(&msg, NULL, 0, WM_USER-1, PM_REMOVE) ||  ::PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) 
		{
      keepGoing = (msg.message != WM_QUIT);

      // If we successfully retrieved a message then dispatch it
      if (keepGoing >= 0) 
			{
          TranslateMessage(&msg);
          DispatchMessage(&msg);
      }
    } 
		else 
		{
       // Block and wait for any posted application message
      ::WaitMessage();
    }
  } 
	while (keepGoing != 0);

	// IF the app was stopped in other ways apart from the parent windows exit actions, 
	// then clean up
	Exit();

  return msg.wParam;
}

// This will create the main frame window
NS_IMETHODIMP rvMyMozApp::OpenParentWindow() 
{
  // if it already exists return the same
	if (mParentWindow != nsnull)
		return NS_OK;
	
	mParentWindow = new rvParentWindow();
  NS_ENSURE_TRUE(mParentWindow, NS_ERROR_FAILURE);
  NS_ADDREF(mParentWindow);

  mParentWindow->SetApp(this);
  mParentWindow->Init(mAppShell, nsRect(0, 0, 980, 700));

  return NS_OK;
}

NS_IMETHODIMP rvMyMozApp::CloseParentWindow()
{
	if (mParentWindow != nsnull) 
	{
		mParentWindow->Destroy();
		NS_RELEASE(mParentWindow);
		delete mParentWindow;
		mParentWindow = nsnull;
	}

	return NS_OK;
}

nsresult rvMyMozApp::Destroy()
{
	CloseParentWindow();
	return NS_OK;
}

// Either NS_DESTROY message on ParentWindow, or Run(), or the destructor will call this
// Exit() -> Destroy()->CloseParentWindow()->Will Destroy all child windows, objects
//				-> mAppShell
nsresult rvMyMozApp::Exit()
{
  nsresult rv = NS_OK;
	Destroy();

	if (mAppShell != nsnull) 
  {
		mAppShell->Spindown();
    mAppShell->Exit();
    NS_RELEASE(mAppShell);
	  delete mAppShell;
  }

	if (log !=nsnull)
	{
		log->CloseLogFile();
		delete log;
		log = nsnull;
	}

	mIsInitialized = PR_FALSE;
  return rv;
}
