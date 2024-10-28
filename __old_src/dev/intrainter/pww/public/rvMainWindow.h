#ifndef __rvMainWindow
#define __rvMainWindow

#include "rvXPCOMIDs.h"
#include "nsWebBrowserChrome.h"

class rvMyMozApp;
class rvParentWindow;
class rvDOMEventListener;
class CHTMLFormWindow;

// The main browser event handler
static nsEventStatus PR_CALLBACK HandleMainWindowEvent(nsGUIEvent *aEvent);

class rvMainWindow : public nsIBaseWindow,
                     public nsIInterfaceRequestor,
                     public nsIWebShellContainer,
										 public nsIDOMFocusListener
{
	friend class nsWebBrowserChrome;

public:
  NS_DECL_AND_IMPL_ZEROING_OPERATOR_NEW

  NS_DECL_ISUPPORTS
  NS_DECL_NSIBASEWINDOW
  NS_DECL_NSIINTERFACEREQUESTOR

	// data
  rvMyMozApp *mApp;
	rvParentWindow* mParent;
  nsIAppShell* mAppShell;
  nsCOMPtr<nsIWidget> mWindow;

  PRBool mDocIsLoaded;
	PRBool mIsInDesignMode;
	PRBool mBrowserIsExiting;

  nsAutoString mTitle;
 	nsWindowType m_window_type;
	nsBorderStyle m_border_style;
  II_WindowType mSubWinType;
	int mWidth;
  int mHeight;
	PRUint32 m_doc_pos; // 0-no dock, 1-left, 2-top, 3-right,4-bottom
	PRBool m_on_top; // true means always on top
	PRBool m_resize; // true means user resizable, else false
	PRUint32 mChromeMask;
	II_MainActionType mMainAction;

  nsCOMPtr<nsIWebBrowser> mWebBrowser;
  nsWebBrowserChrome*   mWebBrowserChrome;
  nsCOMPtr<nsIDocShell> mDocShell;
  nsIContent * mContentRoot; // Points at the Root Content Node
	Frame m_root_frame;
	rvMainWindow* m_referer_browser; //Popups
  
	rvDOMEventListener* m_dom_pick_listener; 
	PRBool mWindowTakingFocus;
	CHTMLFormWindow *m_form_browser_container;

	// cons/dests
	void UnsetMembers();
  virtual II_RESULT InitializeListeners();
	virtual II_RESULT UninitializeListeners();
  NS_IMETHOD DestroyWidget(nsISupports* aWidget);

  // app functions
  void SetApp(rvMyMozApp* aApp) {mApp = aApp;}

	// browser functions
	NS_IMETHOD CreateEmptyDocument();
	II_RESULT Init(rvParentWindow* aParWin, nsIAppShell* aAppShell, const nsRect& aBounds, PRBool aMakeVisible = PR_TRUE);
  II_RESULT GoTo(const nsString aURL);
	II_RESULT ArchivePage(nsAutoString path_file_name = MozStr(""));

  // Window functions
  NS_IMETHOD GetWindow(nsIWidget** aWindow);	
  NS_IMETHOD MoveTo(PRInt32 aX, PRInt32 aY);
  NS_IMETHOD SizeContentTo(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight, PRBool aWidthTransient, PRBool aHeightTransient);
  NS_IMETHOD GetContentBounds(nsRect& aBounds);
  NS_IMETHOD GetWindowBounds(nsRect& aBounds);

  NS_IMETHOD Layout(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutDefault(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutLeftDockingWindow(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutTopDockingWindow(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutBottomDockingWindow(PRInt32 aWidth, PRInt32 aHeight);
	void MakeVisible();
	void MakeInvisible();

  // web browser functions
	II_RESULT GetDocument(nsIDOMHTMLDocument *& aDocument);
  nsIPresShell* GetPresShellFor(nsIDocShell* aDocShell);
  NS_IMETHOD EnsureWebBrowserChrome();
  NS_IMETHOD GetWebShell(nsIWebShell*& aResult);
  NS_IMETHOD GetChrome(PRUint32& aChromeMaskResult);
  NS_IMETHOD GetPresShell(nsIPresShell**);
  NS_IMETHOD ForceRefresh();

	// Frames
	void RecurseAndCreateFrameInfo(Frame* p_frame);
	void ClearFrameTree(Frame* p_frame);

	// progress functions
  NS_IMETHOD WillLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsLoadType aReason);
  NS_IMETHOD BeginLoadURL(nsIWebShell* aShell, const PRUnichar* aURL);
  NS_IMETHOD ProgressLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, PRInt32 aProgress, PRInt32 aProgressMax);
  NS_IMETHOD EndLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsresult aStatus);
	II_RESULT WaitForDocumentToLoad();

	// focus event handlers
	NS_IMETHOD HandleEvent(nsIDOMEvent* aEvent);
	NS_IMETHOD Focus(nsIDOMEvent* aEvent);
	NS_IMETHOD Blur(nsIDOMEvent* aEvent);

	// design/pww/alert/rule processing mode functions
	void OnDesignMode_HighlightElement();

  // util functions
	nsAutoString GetSubWndTypeText();

  void DumpStyles();
  void DumpChildren(nsIDOMNode* elem);

	// unused functions
	char* mDataPath;
	PRBool mIsStyleSheetsMoved;
	NS_IMETHOD MouseClick_MoveToPWW(nsIDOMEvent* aMouseEvent);
};

#endif