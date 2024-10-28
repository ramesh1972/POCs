#ifndef __rvParentWindow
#define __rvParentWindow

#include "rvXPCOMIDs.h"
#include "rvRuleBase.h"
#include "rvMyMozApp.h"

class rvMainWindow;

// the main window
class rvParentWindow : public nsIBaseWindow,
                       public nsIInterfaceRequestor
{
public:
  NS_DECL_AND_IMPL_ZEROING_OPERATOR_NEW

  NS_DECL_ISUPPORTS
  NS_DECL_NSIBASEWINDOW
  NS_DECL_NSIINTERFACEREQUESTOR

	// data
  rvMyMozApp *mApp;
  nsIAppShell* mAppShell;
  nsAutoString mTitle;
  nsCOMPtr<nsIWidget> mWindow;
	nsVoidArray *m_browsers;
  rvMainWindow* mActiveWWWBrowser;
  rvMainWindow* mActivePWWBrowser;
	rvMainWindow* mActiveAlertBrowser;
	rvMainWindow* mActiveFormBrowser;
	nsVoidArray mDockedWindows; // these contains references to windows in the m_browsers list. 
	nsVoidArray mFloatingWindows; // so need to keep these in sync
	CRuleBase *m_rules_loader;
	// cons/dests
	rvParentWindow();
	~rvParentWindow();

  // app functions
  void SetApp(rvMyMozApp* aApp) {mApp = aApp;}

  // Window functions
  NS_IMETHOD Init(nsIAppShell* aAppShell, const nsRect& aBounds);
  NS_IMETHOD MoveTo(PRInt32 aX, PRInt32 aY);
  NS_IMETHOD SizeContentTo(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight, PRBool aWidthTransient, PRBool aHeightTransient);
  NS_IMETHOD GetContentBounds(nsRect& aBounds);
  NS_IMETHOD GetWindowBounds(nsRect& aBounds);
  NS_IMETHOD DestroyWidget(nsISupports* aWidget);
  NS_IMETHOD Layout(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD GetWindow(nsIWidget** aWindow);
	
  // Menu functions
  nsEventStatus DispatchMenuItem(PRInt32 aID);
  nsresult GetMenuBarHeight(PRInt32 * aHeightOut);
  
	// directory/file open
  nsresult DoFileOpen();
  
	// loading/unloading of browser windows
  NS_METHOD OpenBrowserWindow(nsAutoString url, rvMainWindow* mNewWindow);
  NS_METHOD CloseBrowserWindow(rvMainWindow* aWin);
	PRBool GotoURLOnActiveWWWBrowser(nsAutoString url);
	void CloseAllWindows();

  // active browsers
	void SetActiveBrowser(rvMainWindow* aBrowser);

	// Browsers collection
  void AddBrowser(rvMainWindow* aBrowser);
  void RemoveBrowser(rvMainWindow* aBrowser);
  rvMainWindow* FindBrowserFor(nsIWidget* aWidget, PRIntn aWhich);
	void SetNextActiveBrowser(rvMainWindow* p_bw);
	void SetWindowsCollectionsOnTypes();
	nsVoidArray* GetFloatingWindows();
	nsVoidArray* GetDockedWindows();
};

class nsNativeBrowserWindow : public rvParentWindow 
{
public:
  nsNativeBrowserWindow();
  ~nsNativeBrowserWindow();
  
  nsresult CreateMenuBar(PRInt32 aWidth);
  nsEventStatus DispatchMenuItem(PRInt32 aID);
  nsresult GetMenuBarHeight(PRInt32 * aHeightOut);

protected:
  NS_IMETHOD InitNativeWindow();
};

#endif