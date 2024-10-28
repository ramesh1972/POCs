#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"

rvMyMozApp* theApp;
HINSTANCE gInstance, gPrevInstance;

int main(int argc, char **argv)
{
  // Initialize XPCOM		
  nsresult rv;
  rv = NS_InitXPCOM2(nsnull, nsnull, nsnull);
  NS_ASSERTION(NS_SUCCEEDED(rv), "NS_InitXPCOM failed");

  // Initialize this application
  theApp = new rvMyMozApp();
  NS_ADDREF(theApp);
  theApp->Initialize(argc, argv);

	// Start the main application event loop
  int result = theApp->Run();
  
	// Shutdown 
	NS_RELEASE(theApp);

	result = NS_ShutdownXPCOM(nsnull);

  return result;
}

