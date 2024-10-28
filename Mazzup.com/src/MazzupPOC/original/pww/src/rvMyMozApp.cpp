#pragma warning(disable:4786)

#include "rvParentWindow.h"
#include "rvWindowCreator.h"
#include "rvMyMozapp.h"

// The main global vars
extern HINSTANCE gInstance, gPrevInstance;

// externs
IAPPG;

rvMyMozApp::rvMyMozApp()
{
	ILOG << "rvMyMozApp::rvMyMozApp()" << IINF;

  mIsInitialized = PR_FALSE;
	mAppShell = nsnull;
	mParentWindow = nsnull;
	
	NS_ADDREF_THIS();
}

rvMyMozApp::~rvMyMozApp()
{
	ILOG << "rvMyMozApp::~rvMyMozApp()" << IINF;
	IL_TAB;

	ILOG << "Calling Exit.." << IINF;
	II_RESULT exit = Exit();
	if (exit != IIR_SUCCESS)
		ILOG << "Error exiting application object. Error is. " << IMSG(exit) << IFTL;

	NS_RELEASE_THIS();
	IL_UNTAB;
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
II_RESULT rvMyMozApp::Initialize(int argc, char** argv) 
{
	try
	{
		ILOG << "rvMyMozApp::Initialize():Application:" << argv[0] << IINF;
		IL_TAB;

		if (mIsInitialized)
		{
			ILOG << "Already Initialized. Should call this function only once" << IERR;
			IL_UNTAB;
			return NS_OK;
		}

		nsresult rv;

		// setup registry
		ILOG << "Setting Up Registry.." << IINF;
		nsComponentManager::Initialize();
		nsCOMPtr<nsIServiceManager> servManager;
		NS_GetServiceManager(getter_AddRefs(servManager));
  
		nsCOMPtr<nsIComponentRegistrar> registrar = do_QueryInterface(servManager);
		NS_ASSERTION(registrar, "No nsIComponentRegistrar from get service. see dougt");
		rv = registrar->AutoRegister(nsnull);
		if (rv != NS_OK)
		{
			ILOG << "Errored while creating XPCOM Component Registry. Exiting: errorcode: " << rv << IFTL;
			IL_UNTAB;
			return IIR_FAILED_XPCOM_REGISTRATION;
		}

		// set app dir
		nsCOMPtr<nsIFile> appDataDir;
		nsAutoString cacheDir;
		cacheDir.Append(PWW_DATA_ROOT);
		cacheDir.Append(PWW_CACHE_DIR);
		cacheDir.Append(NS_LITERAL_STRING("\\"));
		ILOG << cacheDir << IINF;
		rv = NS_NewLocalFile(cacheDir, PR_FALSE, (nsILocalFile**) &appDataDir);
		
		nsCOMPtr<nsILocalFile> localAppDataDir(do_QueryInterface(appDataDir));

		nsCOMPtr<nsProfileDirServiceProvider> locProvider;
		NS_NewProfileDirServiceProvider(PR_TRUE, getter_AddRefs(locProvider));
		if (!locProvider)
		{
			ILOG << "Could Not Load User Profile, Exiting" << IFTL;
			IL_UNTAB;
			return IIR_FAILED_LOADING_PROFILE;
		}
		
		rv = locProvider->Register();
		if (NS_FAILED(rv))
		{
			ILOG << "Could Not Register User Profile, Exiting: errorcode: " << rv << IFTL;
			IL_UNTAB;
			return IIR_FAILED_PROFILE_REGISTRY;
		}
              
		locProvider->SetProfileDir(localAppDataDir);
		ILOG << "Successfully setup User Profile" << IINF;

		// Load preferences
		rv = CallGetService(NS_PREFSERVICE_CONTRACTID, &mPrefService);
		if (NS_OK != rv) 
		{
			ILOG << "Could Not Load User Moz Preferences Exiting: errorcode: " << rv << IFTL;
			IL_UNTAB;
			return IIR_FAILED_PREF_LOAD;
		}

		mPrefService->ReadUserPrefs(nsnull);
		ILOG << "Loaded User Preferences" << IINF;
  
		// register the cookie manager
		nsCOMPtr<nsICookieService> cookieService = do_GetService(kCookieServiceCID, &rv);
		if (NS_FAILED(rv) || (nsnull == cookieService)) 
		{
			ILOG << "Could Not Create Cookie Service. Continuing: errorcode: " << rv << IERR;
		}
		else
			ILOG << "Created Cookie Service" << IINF;

		/* InitializeWindowCreator creates and hands off an object with a callback
		 to a window creation function. This is how all new windows are opened,
		 except any created directly by the viewer app. */

		// create an nsWindowCreator and give it to the WindowWatcher service
		mCreatorCallback = new rvWindowCreator(this);
		if (mCreatorCallback) 
		{
			ILOG << "Got CreatorCallback" << IINF;
			nsCOMPtr<nsIWindowCreator> windowCreator(NS_STATIC_CAST(nsIWindowCreator *, mCreatorCallback));
			if (windowCreator) 
			{
				ILOG << "Got nsIWindowCreator" << IINF;
				nsCOMPtr<nsIWindowWatcher> wwatch(do_GetService(NS_WINDOWWATCHER_CONTRACTID));
				if (wwatch) 
				{
					ILOG << "Got nsIWindowWatcher" << IINF;
					wwatch->SetWindowCreator(windowCreator);
				}
				else
					return IIR_FAILED_WINDOW_CREATEOR;
			}
			else
				return IIR_FAILED_WINDOW_CREATEOR;
		}
		else
			return IIR_FAILED_WINDOW_CREATEOR;


		// create the application shell
		ILOG << "Creating Application Shell" << IINF;
		rv = nsComponentManager::CreateInstance(kAppShellCID, nsnull, kIAppShellIID, (void**)&mAppShell);
		if (NS_FAILED(rv))
		{
			ILOG << "Could not create Application Shell: errorcode: " << rv << IFTL;
			IL_UNTAB;
			return IIR_FAILED_APPSHELL;
		}

		mAppShell->Create(&argc, argv);
		ILOG << "Created nsIAppShell" << IINF;
		mIsInitialized = PR_TRUE;

		ILOG << "Successfully Completed Initialization" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch (...)
	{
		ILOG << "Caught Exception in rvMyMozApp::Initialization()" << IEXC;
		IL_UNTAB;

		return IIR_EXCEPTION;
	}
}

II_RESULT rvMyMozApp::Run() 
{
	try
	{
		ILOG << "rvMyMozApp::Run()" << IINF;
		IL_TAB;

		// Open the parent window with menu and stuff
		ILOG << "Creating PWW Client Window (Main Frame Window)..." << IINF;
		II_RESULT pww = OpenParentWindow();
		if (pww != IIR_SUCCESS)
		{
			ILOG << "Failed while creating PWW window. exiting application" << IFTL;
			IL_UNTAB;
			return pww;
		}
  
		ILOG << "Successfully created PWW Client Window" << IINF;

		// Default windows to open
		// - Show the Location Bar
		mParentWindow->DispatchMenuItem(ID_WWW_SHOWTOOLBAR);
		mParentWindow->Layout(0,0);

		ILOG << "-------------------------------------------------------" << IINF;
		ILOG << "Entering Windows Event Message Loop........" << IINF;
  
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
					try
					{
						TranslateMessage(&msg);
						DispatchMessage(&msg);
					}
					catch(...)
					{
						ILOG << "Caught Exception in rvMyMozApp::Run() Message Loop. Ignoring and Continuing" << IEXC;
					}
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
		ILOG << "Exited Events Message Loop. Gracefully Exiting.........:wparam:" << msg.wParam << IINF;
		ILOG << "-------------------------------------------------------" << IINF;
		Exit();

		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMyMozApp::Run() Function. Exiting" << IEXC;
		ILOG << "Trying to exit gracefully........." << IINF;
		Exit();
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

// This will create the main frame window
II_RESULT rvMyMozApp::OpenParentWindow() 
{
	try
	{
		ILOG << "rvMyMozApp::OpenParentWindow()" << IINF;
		IL_TAB;

		// if it already exists return the same
		if (mParentWindow != nsnull)
		{
			ILOG << "PWW Main Frame Window already exists. This function should be called only once." << IERR;
			IL_UNTAB;
			return IIR_PWW_ALREADY_CREATED;
		}
		
		ILOG << "Creating the PWW Main Frame Window..." << IINF;
		mParentWindow = new rvParentWindow();
		if (mParentWindow == nsnull)
		{
			ILOG << "Failed Creation of Main Frame Window Should exit application." << IFTL;
			IL_UNTAB;
			return IIR_PWW_CREATE_FAILED;
		}

		ILOG << "Successfully Created PWW Client Instance" << IINF;
		NS_ADDREF(mParentWindow);

		mParentWindow->SetApp(this);

		ILOG << "Initializing the Main Frame Window.." << IINF;
		II_RESULT init_res = mParentWindow->Init(mAppShell, nsRect(0, 0, 980, 700));
		if (init_res != IIR_SUCCESS)
		{
			ILOG << "Failed Initialization of Main Frame Window. Should exit application." << IFTL;
			IL_UNTAB;
			return IIR_PWW_INIT_FAILED;
		}

		ILOG << "Successfully Created PWW Main Frame Window" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMyMozApp::OpenParentWindow() Function. Exiting" << IEXC;
		ILOG << "Trying to exit gracefully........." << IINF;
		Exit();
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvMyMozApp::CloseParentWindow()
{
	try
	{
		ILOG << "rvMyMozApp::CloseParentWindow()" << IINF;
		IL_TAB;

		if (mParentWindow != nsnull) 
		{
			ILOG << "About to Destroy PWW Main Frame Window" << IINF;
			nsresult rv = mParentWindow->Destroy();
			if (NS_FAILED(rv))
			{
				ILOG << "Failed while destroying Main Frame Window. errorcode:" << rv << IFTL;
				IL_UNTAB;
				return IIR_PWW_DESTROY_FAILED;
			}

			NS_RELEASE(mParentWindow);
			delete mParentWindow;
			mParentWindow = nsnull;
			ILOG << "Destroyed PWW Main Frame Window" << IINF;
		}

		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMyMozApp::CloseBrowserWindow() Function" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvMyMozApp::Destroy()
{
	return IIR_SUCCESS;
}

// Either NS_DESTROY message on ParentWindow, or Run(), or the destructor will call this
// Exit() -> Destroy()->CloseParentWindow()->Will Destroy all child windows, objects
//				-> mAppShell
II_RESULT rvMyMozApp::Exit()
{
	try
	{
		ILOG << "rvMyMozApp::Exit()" << IINF;
		IL_TAB;

		ILOG << "-------------------------------------------------------------" << IINF;
		if (!mIsInitialized)
		{
			ILOG << "Application Object already destroyed" << IINF;
			IL_UNTAB;
			return IIR_SUCCESS;
		}

		ILOG << "About to destroy parent window, child browsers, all resources..." << IINF;
		II_RESULT res = CloseParentWindow();
		if (res != IIR_SUCCESS)
		{
			ILOG << "Failed while trying to destroy Main Frame Window" << IFTL;
			IL_UNTAB;
			return res;
		}

		ILOG << "Successfully Destroyed Parent Window" << IINF;

		if (mAppShell != nsnull) 
		{
			mAppShell->Spindown();
			mAppShell->Exit();
			NS_RELEASE(mAppShell);
			delete mAppShell;
		}

		ILOG << "Exited nsIAppShell" << IINF;
		mIsInitialized = PR_FALSE;

		ILOG << "Successfully Completed Application:Exit Call" << IINF;
		IL_UNTAB;
		return IIR_SUCCESS;
	}
	catch(...)
	{
		ILOG << "Caught Exception in rvMyMozApp::Exit() Function" << IEXC;
		IL_UNTAB;
		return IIR_EXCEPTION;
	}
}
