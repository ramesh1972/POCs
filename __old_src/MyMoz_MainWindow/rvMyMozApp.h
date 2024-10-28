#ifndef rvMozApp
#define rvMozApp

#include "nsCRT.h"
#include "nsNETCID.h"
#include "nsIAppShell.h"
#include "rvMainWindow.h"

class rvMyMozApp : public nsISupports
{
public:
  // new/delete operator
  NS_DECL_AND_IMPL_ZEROING_OPERATOR_NEW

  // nsISupports
  NS_DECL_ISUPPORTS

  // this app functions
  nsresult Initialize(int argc, char** argv);

  virtual ~rvMyMozApp();

public:
	rvMyMozApp();

public :
	int Run();
	NS_METHOD OpenWindow();
	NS_METHOD CloseWindow(rvMainWindow* aMainWin);
public:
	nsIAppShell* mAppShell;
	PRBool mIsInitialized;
	PRInt32 mWidth, mHeight;
	rvMainWindow *mWin;
};

/* Not Requried 
class rvNativeMyMozApp : public rvMyMozApp {
public:
  rvNativeMyMozApp();
  ~rvNativeMyMozApp();

  virtual int Run();
};
*/
#endif
