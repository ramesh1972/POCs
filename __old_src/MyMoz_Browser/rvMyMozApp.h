#ifndef __rvMozApp
#define __rvMozApp

#include "rvXPCOMIDs.h"

class rvParentWindow;
class rvWindowCreator;
class rvMyMozApp : public nsISupports
{
public:
  // new/delete operator
  NS_DECL_AND_IMPL_ZEROING_OPERATOR_NEW

  // nsISupports
  NS_DECL_ISUPPORTS

public:
	rvMyMozApp();
	virtual ~rvMyMozApp();

public :
	// this app functions
	nsresult Initialize(int argc, char** argv);
	int Run();

	// main frame window functions
	NS_METHOD OpenParentWindow();
	NS_METHOD CloseParentWindow();

	// close functions
	nsresult Destroy();
	nsresult Exit();

public:
	nsIAppShell* mAppShell;
	rvWindowCreator* mCreatorCallback;
	PRBool mIsInitialized;
	rvParentWindow *mParentWindow;
	nsIPrefService* mPrefService;
	CFileLogger* log;
};
#endif
