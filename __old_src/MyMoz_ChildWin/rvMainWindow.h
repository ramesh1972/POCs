#ifndef __rvMainWindow
#define __rvMainWindow

#include "nsCOMPtr.h"
#include "nsISupports.h"
#include "nsIBaseWindow.h"
#include "nsIInterfaceRequestor.h"
#include "nsIProgressEventSink.h"
#include "nsString.h"
#include "nsCRT.h"
#include "nsIXPBaseWindow.h"
#include "nsEvent.h"
#include "nsGUIEvent.h"
#include "nsIWidget.h"
#include "nsIWebBrowser.h"


class rvMyMozApp;

class rvMainWindow : public nsIBaseWindow,
                        public nsIInterfaceRequestor,
                        public nsIProgressEventSink

				
{
public:
  NS_DECL_AND_IMPL_ZEROING_OPERATOR_NEW

  NS_DECL_ISUPPORTS
  NS_DECL_NSIBASEWINDOW
  NS_DECL_NSIINTERFACEREQUESTOR

  // Window functions
  NS_IMETHOD MoveTo(PRInt32 aX, PRInt32 aY);
  NS_IMETHOD SizeContentTo(PRInt32 aWidth, PRInt32 aHeight);
  NS_IMETHOD SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight,
                          PRBool aWidthTransient, PRBool aHeightTransient);
  NS_IMETHOD GetContentBounds(nsRect& aBounds);
  NS_IMETHOD GetWindowBounds(nsRect& aBounds);

  // nsIProgressEventSink
  NS_DECL_NSIPROGRESSEVENTSINK

  // Event processor
  nsEventStatus ProcessDialogEvent(nsGUIEvent *aEvent);

  void SetApp(rvMyMozApp* aApp) {
    mApp = aApp;
  }
	nsresult Init(nsIAppShell* aAppShell, const nsRect& aBounds);
	
  static void CloseAllWindows();
  void DestroyWidget(nsISupports* aWidget);
void Layout(PRInt32 aWidth, PRInt32 aHeight);

  // data
  rvMyMozApp* mApp;
  nsString mTitle;
  nsIAppShell* mAppShell;

  nsCOMPtr<nsIWidget> mWindow;
nsCOMPtr<nsIWidget> mChildWidget;
};


#endif