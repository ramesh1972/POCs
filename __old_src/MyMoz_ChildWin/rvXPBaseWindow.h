#ifndef __rvXPBaseWindow
#define __rvXPBaseWindow

#include "nsIXPBaseWindow.h"
#include "nsIStreamListener.h"
#include "nsIWebShell.h"
#include "nsIDOMMouseListener.h"
#include "nsCRT.h"
#include "nsIAppShell.h"
#include "nsString.h"
#include "nsIContent.h"
#include "nsIDOMNode.h"
#include "nsIDOMElement.h"

class rvMyMozApp;
class rvXPBaseWindow : public nsIXPBaseWindow,
                       public nsIWebShellContainer,
                       public nsIDOMMouseListener {

public:
  NS_DECL_AND_IMPL_ZEROING_OPERATOR_NEW

  rvXPBaseWindow();
  virtual ~rvXPBaseWindow();

  // nsISupports
  NS_DECL_ISUPPORTS

  nsIAppShell* mAppShell;       //not addref'ed!

  NS_IMETHOD Init(nsXPBaseWindowType aType,
                  nsIAppShell*       aAppShell,
                  const nsString&    aDialogURL,
                  const nsString&    aTitle,
                  const nsRect&      aBounds,
                  PRUint32           aChromeMask,
                  PRBool             aAllowPlugins = PR_TRUE);
  NS_IMETHOD SetLocation(PRInt32 aX, PRInt32 aY);
  NS_IMETHOD SetDimensions(PRInt32 aWidth, PRInt32 aHeight);

  NS_IMETHOD GetWindowBounds(nsRect& aBounds);
  NS_IMETHOD GetBounds(nsRect& aBounds);
  NS_IMETHOD SetVisible(PRBool aIsVisible);
  NS_IMETHOD Close();
  NS_IMETHOD SetTitle(const PRUnichar* aTitle);
  NS_IMETHOD GetTitle(const PRUnichar** aResult);
  NS_IMETHOD GetWebShell(nsIWebShell*& aResult);
  NS_IMETHOD GetPresShell(nsIPresShell*& aPresShell);

  NS_IMETHOD LoadURL(const nsString &aURL);
    NS_IMETHOD GetDocument(nsIDOMHTMLDocument *& aDocument);
  NS_IMETHOD AddEventListener(nsIDOMNode * aNode);
  NS_IMETHOD RemoveEventListener(nsIDOMNode * aNode);
  NS_IMETHOD AddWindowListener(nsIWindowListener * aWindowListener);

  // nsIDOMEventListener
  NS_IMETHOD HandleEvent(nsIDOMEvent* aEvent);

  // nsIDOMMouseListener (is derived from nsIDOMEventListener)
  NS_IMETHOD MouseDown(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseUp(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseClick(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseDblClick(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseOver(nsIDOMEvent* aMouseEvent);
  NS_IMETHOD MouseOut(nsIDOMEvent* aMouseEvent);

void Layout(PRInt32 aWidth, PRInt32 aHeight);
  rvMyMozApp* mApp;
  nsXPBaseWindowType mWindowType;

  nsString     mTitle;
  nsIWidget*   mWindow;

};

#endif