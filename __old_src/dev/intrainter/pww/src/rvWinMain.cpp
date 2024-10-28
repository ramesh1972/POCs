#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"

// global instance/handle to the application object, from where everything is visible
rvMyMozApp* theApp;
HINSTANCE gInstance, gPrevInstance;

int main(int argc, char **argv)
{
	try
	{
		// Initialize XPCOM		
		nsresult rv;
		rv = NS_InitXPCOM2(nsnull, nsnull, nsnull);
		NS_ASSERTION(NS_SUCCEEDED(rv), "NS_InitXPCOM failed");

		// log file
		CFileLogger::CreateInstance();
		CFileLogger::CreateLogFile(MozStr("")); // use default
		ILOG << "Logger Initialized" << IINF;

		// load messages
		CTextMessages::CreateInstance();
		CTextMessages::LoadMessages();
		ILOG << "Messages Initialized" << IINF;

		ILOG << "XPCOM Initialized" << IINF;

		// Initialize this application
		ILOG << "Creating Application Object" << IINF;
		theApp = new rvMyMozApp();
		NS_ADDREF(theApp);
		theApp->Initialize(argc, argv);
		ILOG << "Successfully Created Application Object" << IINF;

		// Start the main application event loop
		ILOG << "Calling Application Run" << IINF;
		ILOG << "-------------------------------------------------------" << IINF;
		int result = theApp->Run();
		ILOG << "-------------------------------------------------------" << IINF;
		ILOG << "Exited Application Run" << IINF;
  
		// This should put back all the further logging to the start of line
		IL_UNTAB;

		// Shutdown 
		NS_RELEASE(theApp);
		ILOG << "Destroyed Application Object" << IINF;

		ILOG << "Shutting Down XPCOM" << IINF;
		result = NS_ShutdownXPCOM(nsnull);
		if (result != NS_OK)
			ILOG << "Failed shutting Down XPCOM : error code=" << result << IFTL;
		else
			ILOG << "Successfully Shut Down XPCOM" << IINF;

		// delete other global/singletop instances
		CTextMessages::Destroy();
		ILOG << "Destroyed Messages" << IINF;

		ILOG << "Exiting Application" << IINF;
		ILOG << "Destroying Logger" << IINF;
		CFileLogger::Destroy();
		
	  return result;
	}
	catch(...)
	{
		ILOG << "-------------------------------------------------------" << IINF;
		ILOG << "Caught Exception in main()" << IEXC;
		return IIR_EXCEPTION;
	}
}

