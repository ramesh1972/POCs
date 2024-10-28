#ifndef __rvParentWindow
#define __rvParentWindow

#include "rvXPCOMIDs.h"
#include "rvRuleBase.h"
#include "rvMyMozApp.h"
#include "rvMainWindow.h"

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

  // main functions
  II_RESULT Init(nsIAppShell* aAppShell, const nsRect& aBounds);
  void SetApp(rvMyMozApp* aApp) {mApp = aApp;}
  nsEventStatus DispatchMenuItem(PRInt32 aID);
	void SetActiveBrowser(rvMainWindow* aBrowser);
	void SetNextActiveBrowser(rvMainWindow* p_bw);

  // Window functions
  NS_IMETHOD MoveTo(PRInt32 aX, PRInt32 aY);
  NS_IMETHOD SizeContentTo(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight, PRBool aWidthTransient, PRBool aHeightTransient);
  NS_IMETHOD GetContentBounds(nsRect& aBounds);
  NS_IMETHOD GetWindowBounds(nsRect& aBounds);
  NS_IMETHOD DestroyWidget(nsISupports* aWidget);
  NS_IMETHOD Layout(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD GetWindow(nsIWidget** aWindow);
	
  // loading/unloading of browser windows
	II_RESULT OpenBrowser(nsAutoString url, rvMainWindow* aWin, nsWindowType p_wnd_type, nsBorderStyle p_border_style, II_WindowType p_bw_sub_type, PRInt32 doc_pos, PRBool p_hidden = PR_FALSE);
	II_RESULT OpenStandardBrowser(nsAutoString url, rvMainWindow* mNewWindow, PRBool p_hidden = PR_FALSE);
	II_RESULT OpenEmptyBrowser(rvMainWindow* aWin, nsWindowType p_wnd_type, nsBorderStyle p_border_style, II_WindowType p_bw_sub_type, PRInt32 doc_pos, PRBool p_hidden = PR_FALSE);
  II_RESULT CloseBrowserWindow(rvMainWindow* aWin);
	II_RESULT GotoURLOnActiveWWWBrowser(nsAutoString url);
	II_RESULT CloseAllWindows();

	// Browsers collection
  II_RESULT AddBrowser(rvMainWindow* aBrowser);
  II_RESULT RemoveBrowser(rvMainWindow* aBrowser);
  rvMainWindow* FindBrowserFor(nsIWidget* aWidget, PRIntn aWhich);
	rvMainWindow* GetPopupBrowserWindow(rvMainWindow* p_referer, nsAutoString p_url, PRInt32 p_pos);
	rvMainWindow* GetDocumentTargetBrowser(nsIDOMHTMLDocument* p_doc);
	void SetWindowsCollectionsOnTypes();
	nsVoidArray* GetFloatingWindows();
	nsVoidArray* GetDockedWindows();

	// helpers
  nsresult DoFileOpen();
  nsresult GetMenuBarHeight(PRInt32 * aHeightOut);
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