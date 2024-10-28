#include "nscore.h"
#include "nsXPCOM.h"
#include "nsDebug.h"

#include "rvMyMozApp.h"

rvMyMozApp* app;
int main(int argc, char **argv)
{
  // Initialize XPCOM	
  nsresult rv;
  rv = NS_InitXPCOM2(nsnull, nsnull, nsnull);
  NS_ASSERTION(NS_SUCCEEDED(rv), "NS_InitXPCOM failed");

  // Initialize this application
  app = new rvMyMozApp();
  NS_ADDREF(app);
  app->Initialize(argc, argv);
  int result = app->Run();
  

  return result;
}

/* kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib xpcom.lib nspr4.lib gkgfx.lib */