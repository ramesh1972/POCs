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
	II_RESULT Initialize(int argc, char** argv);
	II_RESULT Run();

	// main frame window functions
	II_RESULT OpenParentWindow();
	II_RESULT CloseParentWindow();

	// close functions
	II_RESULT Destroy();
	II_RESULT Exit();
	
public:
	nsIAppShell* mAppShell;
	rvWindowCreator* mCreatorCallback;
	rvParentWindow *mParentWindow;
	nsIPrefService* mPrefService;
	PRBool mIsInitialized;
};
#endif
