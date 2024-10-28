#include "rvXPCOMIDs.h"
#include <cgi/Defs.H>
#include <cgi/Debug.H>
#include "cgi\cgipp.h"
#include "rvDB.h"
#include "rvJSDB.h"

string get_form_data();
string get_form_script();

// Initialize jsdb data processing
jsdb_s g_jsdb;

// global instance/handle to the application object, from where everything is visible
int main(int argc, char **argv)
{
	try
	{
		printf("content-type:text/html\n\n");
	//	printf("<html>");
	
		// Initialize XPCOM		
		nsresult rv;

		rv = NS_InitXPCOM2(nsnull, nsnull, nsnull);
		NS_ASSERTION(NS_SUCCEEDED(rv), "NS_InitXPCOM failed");

		// log file
		CFileLogger::CreateInstance();
		CFileLogger::CreateLogFile(MozStr("")); // use default

		ILOG.LogToConsole(PR_FALSE);
		ILOG << "Logger Initialized" << IINF;

		// load messages
		CTextMessages::CreateInstance();
		CTextMessages::LoadMessages();
		ILOG << "Messages Initialized" << IINF;

		ILOG << "XPCOM Initialized" << IINF;

		// Initialize this application
		ILOG << "Creating Application Object" << IINF;
		Cgipp *cgi = new Cgipp();

		// check to see if there is input_data tag.
		// if no then display the standard html
		FormEntry* e = cgi->findEntry("input_data");
		if (e != NULL)
		{
			ILOG << "got entry " << IINF;
				char* idata = (char*) e->Value();
				if (idata != NULL)
				{
					ILOG << "got data" << idata << IINF;
					
					// update the data
					g_jsdb.xml2db(idata);
				}
		}

		string html = "<html><body>" + get_form_data() + get_form_script() + "</body></html>";
		cout << html.c_str() << endl;

		// destroy
		ILOG << "html=" << IINF;
		ILOG << (char*) html.c_str() << IINF;
		delete cgi;

		ILOG << "Successfully Created Application Object" << IINF;

		// Start the main application event loop
		ILOG << "Calling Application Run" << IINF;
		ILOG << "-------------------------------------------------------" << IINF;

		ILOG << "-------------------------------------------------------" << IINF;
		ILOG << "Exited Application Run" << IINF;
  
		// This should put back all the further logging to the start of line
		IL_UNTAB;

		// Shutdown 
		ILOG << "Destroyed Application Object" << IINF;

		ILOG << "Shutting Down XPCOM" << IINF;
		int result = NS_ShutdownXPCOM(nsnull);
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
		
		printf("</html>");
		return result;
	}
	catch(...)
	{
		ILOG << "-------------------------------------------------------" << IINF;
		ILOG << "Caught Exception in main()" << IEXC;
		return IIR_EXCEPTION;
	}
}

string get_form_data()
{
	// get the table in xml
	g_jsdb.db2xml(0, "stock", "select * from stock");
	string xml = g_jsdb.get_client_db_data(); 
	string data = "<input type=hidden id=output_data value=\"" + xml + "\">";

	return data;	
}

string get_form_script()
{
	// get the table in xml
	return "<script language=javascript src=scripts/stock.js></script>";	
}
