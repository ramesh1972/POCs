#ifndef __rvMainWindow
#define __rvMainWindow

#include "rvXPCOMIDs.h"
#include "nsWebBrowserChrome.h"

class rvMyMozApp;
class rvParentWindow;
class rvDOMEventListener;
class CRuleProcessor;
class CRuleRenderer;
class CHTMLFormWindow;

// The main browser event handler
static nsEventStatus PR_CALLBACK HandleMainWindowEvent(nsGUIEvent *aEvent);

// frame struct
struct Frame
{
public:
	nsAutoString m_url;
	nsIDOMHTMLDocument* m_doc;
	nsAutoString m_id;

	nsVoidArray *m_sub_frames;
};

enum II_MainActionType
{
	IIMA_WWW2PWW,
	IIMA_SetAlert,
	IIMA_None
};

enum II_WindowType
{
	IIW_Main,
	IIW_WWW,
	IIW_PWW,
	IIW_Form,
	IIW_Alert,
	IIW_AlertView,
	IIW_RuleProcessor
};

class rvMainWindow : public nsIBaseWindow,
                     public nsIInterfaceRequestor,
                     public nsIWebShellContainer,
										 public nsIDOMMouseListener,
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
  nsAutoString mTitle;
  nsCOMPtr<nsIWidget> mWindow;
 	nsWindowType m_window_type;
	nsBorderStyle m_border_style;
  II_WindowType mSubWinType;
	int mWidth;
  int mHeight;
	PRUint32 m_doc_pos; // 0-no dock, 1-left, 2-top, 3-right,4-bottom
	PRBool m_on_top; // true means always on top
	PRBool m_resize; // true means user resizable, else false
	II_MainActionType mMainAction;
  nsCOMPtr<nsIWebBrowser> mWebBrowser;
  nsWebBrowserChrome*   mWebBrowserChrome;
  nsCOMPtr<nsIDocShell> mDocShell;
  nsIContent * mContentRoot; // Points at the Root Content Node
  PRUint32 mChromeMask;
  PRBool       mDocIsLoaded;
  char* mDataPath;
  PRBool mIsStyleSheetsMoved;
	PRBool mIsInDesignMode;
	Frame m_root_frame;
	rvDOMEventListener* m_dom_pick_listener; 
	CRuleProcessor *mRuleProcessor;
	CRuleRenderer *mRuleRenderer;
	PRBool mWindowTakingFocus;
	CHTMLFormWindow *m_form_browser_container;

	// cons
	void InitializeMembers();

  // app functions
  void SetApp(rvMyMozApp* aApp) {mApp = aApp;}

  // Window functions
  NS_IMETHOD MoveTo(PRInt32 aX, PRInt32 aY);
  NS_IMETHOD SizeContentTo(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight, PRBool aWidthTransient, PRBool aHeightTransient);
  NS_IMETHOD GetContentBounds(nsRect& aBounds);
  NS_IMETHOD GetWindowBounds(nsRect& aBounds);
  NS_IMETHOD DestroyWidget(nsISupports* aWidget);
  NS_IMETHOD GetWindow(nsIWidget** aWindow);	
	NS_IMETHOD Init(rvParentWindow* aParWin, nsIAppShell* aAppShell, const nsRect& aBounds, PRBool aMakeVisible = PR_TRUE);
  NS_IMETHOD Layout(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutDefault(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutLeftDockingWindow(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutTopDockingWindow(PRInt32 aWidth, PRInt32 aHeight);
	NS_IMETHODIMP LayoutBottomDockingWindow(PRInt32 aWidth, PRInt32 aHeight);
	void MakeVisible();
	void MakeInvisible();

  // web browser functions
  nsIPresShell* GetPresShellFor(nsIDocShell* aDocShell);
  NS_IMETHOD EnsureWebBrowserChrome();
  NS_IMETHOD GetWebShell(nsIWebShell*& aResult);
  NS_IMETHOD GetChrome(PRUint32& aChromeMaskResult);
  NS_IMETHOD ForceRefresh();
  NS_IMETHODIMP GetDocument(nsIDOMHTMLDocument *& aDocument);
  NS_IMETHOD GetPresShell(nsIPresShell**);
  NS_IMETHOD GoTo(const nsString aURL);

	// persist functions
	NS_IMETHOD SavePage(nsAutoString path_file_name = MozStr(""));

  // progress functions
  NS_IMETHOD WillLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsLoadType aReason);
  NS_IMETHOD BeginLoadURL(nsIWebShell* aShell, const PRUnichar* aURL);
  NS_IMETHOD ProgressLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, PRInt32 aProgress, PRInt32 aProgressMax);
  NS_IMETHOD EndLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsresult aStatus);
  virtual void InitializeListeners();
	virtual void UninitializeListeners();

	// focus event handlers
	NS_IMETHOD Focus(nsIDOMEvent* aEvent);
	NS_IMETHOD Blur(nsIDOMEvent* aEvent);

  // mouse event functions
  NS_IMETHOD HandleEvent(nsIDOMEvent *event);
  NS_IMETHOD MouseDown(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseUp(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseDblClick(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseOver(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseOut(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseClick(nsIDOMEvent* aMouseEvent);
	NS_IMETHOD CreateEmptyDocument();

	// design/pww/alert mode functions
	void OnDesignMode_HighlightElement();
	NS_IMETHOD MouseClick_MoveToPWW(nsIDOMEvent* aMouseEvent);

  // util functions
  void DumpStyles();
  void DumpChildren(nsIDOMNode* elem);

	// Frames
	nsAutoString GetFrameID(nsIDOMHTMLDocument* p_doc, Frame* p_frame);
	void RecurseAndCreateFrameInfo(Frame* p_frame);
	void ClearFrameTree(Frame* p_frame);
	nsIDOMHTMLDocument* GetFrameHTMLDocument(Frame* p_frame, nsAutoString frame_url, nsAutoString frame_location);

	// processing of rules
	void SetRuleProcessor(CRuleProcessor* rule_processor);
	void SetRuleRenderer(CRuleRenderer* rule_renderer);
};

#endif