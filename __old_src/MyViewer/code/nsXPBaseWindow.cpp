/* -*- Mode: C++; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: NPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Netscape Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/NPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Communicator client code.
 *
 * The Initial Developer of the Original Code is 
 * Netscape Communications Corporation.
 * Portions created by the Initial Developer are Copyright (C) 1998
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or 
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the NPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the NPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */
#include "nsCOMPtr.h"
#include "prmem.h"

#include "nsXPBaseWindow.h"

#include "nsCOMPtr.h"
#include "nsIPrompt.h"
#include "nsIAppShell.h"
#include "nsIWidget.h"
#include "nsIDOMDocument.h"
#include "nsIURL.h"
#include "nsIComponentManager.h"
#include "nsIFactory.h"
#include "nsCRT.h"
#include "nsWidgetsCID.h"
#include "nsViewerApp.h"

#include "nsIDocument.h"
#include "nsIPresContext.h"
#include "nsIDocumentViewer.h"
#include "nsIContentViewer.h"
#include "nsIPresShell.h"
#include "nsIDocument.h"
#include "nsIDocument.h"
#include "nsIDOMEventReceiver.h"
#include "nsIDOMElement.h"
#include "nsIDOMHTMLDocument.h"
#include "nsIWindowListener.h"
#include "nsIBaseWindow.h"
#include "nsIWebNavigation.h"
#include "nsIViewManager.h"
#include "nsGUIEvent.h"

#include "nsIDocShell.h"
#include "nsIDocShellTreeItem.h"
#include "nsIDocShellTreeNode.h"
#include "nsXPIDLString.h"
#include "nsReadableUtils.h"
#include "nsIWebProgress.h"
#include "nsIWebProgressListener.h"
#include "nsIDOMWindow.h"
#include "nsCWebBrowser.h"

#include <ctype.h> // tolower

// XXX For font setting below
#include "nsFont.h"
//#include "nsUnitConversion.h"
//#include "nsIDeviceContext.h"
#include "nsIInterfaceRequestor.h"

static NS_DEFINE_IID(kWebShellCID, NS_WEB_SHELL_CID);
static NS_DEFINE_IID(kWindowCID, NS_WINDOW_CID);


static NS_DEFINE_IID(kIXPBaseWindowIID, NS_IXPBASE_WINDOW_IID);
static NS_DEFINE_IID(kISupportsIID, NS_ISUPPORTS_IID);
static NS_DEFINE_IID(kIFactoryIID, NS_IFACTORY_IID);
static NS_DEFINE_IID(kIWebShellIID, NS_IWEB_SHELL_IID);
static NS_DEFINE_IID(kIWebShellContainerIID, NS_IWEB_SHELL_CONTAINER_IID);
static NS_DEFINE_IID(kIDocumentViewerIID, NS_IDOCUMENT_VIEWER_IID);
static NS_DEFINE_IID(kIWidgetIID, NS_IWIDGET_IID);

static NS_DEFINE_IID(kIDOMMouseListenerIID,   NS_IDOMMOUSELISTENER_IID);
static NS_DEFINE_IID(kIDOMEventReceiverIID,   NS_IDOMEVENTRECEIVER_IID);
static NS_DEFINE_IID(kIDOMHTMLDocumentIID, NS_IDOMHTMLDOCUMENT_IID);

//----------------------------------------------------------------------
nsXPBaseWindow::nsXPBaseWindow() :
  mContentRoot(nsnull),
  mWindowListener(nsnull),
  mDocIsLoaded(PR_FALSE),
  mAppShell(nsnull)
{
}

//----------------------------------------------------------------------
nsXPBaseWindow::~nsXPBaseWindow()
{
  NS_IF_RELEASE(mContentRoot);
  NS_IF_RELEASE(mAppShell);
}

//----------------------------------------------------------------------
NS_IMPL_ADDREF(nsXPBaseWindow)
NS_IMPL_RELEASE(nsXPBaseWindow)

NS_INTERFACE_MAP_BEGIN(nsXPBaseWindow)
  NS_INTERFACE_MAP_ENTRY_AMBIGUOUS(nsISupports, nsIXPBaseWindow)
  NS_INTERFACE_MAP_ENTRY(nsIWebProgressListener)
  NS_INTERFACE_MAP_ENTRY(nsISupportsWeakReference)
     NS_INTERFACE_MAP_ENTRY(nsIInterfaceRequestor)
  NS_INTERFACE_MAP_ENTRY(nsIWebBrowserChrome)
  NS_INTERFACE_MAP_ENTRY(nsIWebBrowserChromeFocus)
  NS_INTERFACE_MAP_ENTRY(nsIEmbeddingSiteWindow)
	 NS_INTERFACE_MAP_END
//----------------------------------------------------------------------
nsresult nsXPBaseWindow::GetInterface(const nsIID& aIID,
                                        void** aInstancePtr)
{
  NS_ENSURE_ARG_POINTER(aInstancePtr);
  *aInstancePtr = 0;

  /* WindowCreator wants the main content shell when it asks a chrome window
     for this interface. */
  if (aIID.Equals(NS_GET_IID(nsIDOMWindow))) {
    if (mWebBrowser) {
      nsIDOMWindow *contentWin;
      mWebBrowser->GetContentDOMWindow(&contentWin);
      *aInstancePtr = contentWin;
    }
    return NS_OK;
  }



  if (aIID.Equals(kIXPBaseWindowIID)) {
    *aInstancePtr = (void*) ((nsIXPBaseWindow*)this);
    NS_ADDREF_THIS();
    return NS_OK;
  }
  if (aIID.Equals(kIDOMMouseListenerIID)) {
    NS_ADDREF_THIS(); // Increase reference count for caller
    *aInstancePtr = (void *)((nsIDOMMouseListener*)this);
    return NS_OK;
  }
  

    return QueryInterface(aIID, aInstancePtr);
}


//----------------------------------------------------------------------
static nsEventStatus PR_CALLBACK
HandleXPDialogEvent(nsGUIEvent *aEvent)
{ 
  nsEventStatus result = nsEventStatus_eIgnore;

  nsXPBaseWindow* baseWin;
  aEvent->widget->GetClientData(((void*&)baseWin));

  if (nsnull != baseWin) {
    nsSizeEvent* sizeEvent;
    switch(aEvent->message) {
      case NS_SIZE:
        sizeEvent = (nsSizeEvent*)aEvent;  
        baseWin->Layout(sizeEvent->windowSize->width,
                        sizeEvent->windowSize->height);
        result = nsEventStatus_eConsumeNoDefault;
        break;

    case NS_DESTROY: {
        //nsViewerApp* app = baseWin->mApp;
        result = nsEventStatus_eConsumeDoDefault;
        baseWin->Close();
        NS_RELEASE(baseWin);
      }
      return result;

    default:
      break;
    }
    //NS_RELEASE(baseWin);
  }
  return result;
}


//----------------------------------------------------------------------
nsresult nsXPBaseWindow::Init(nsXPBaseWindowType aType,
                              nsIAppShell*       aAppShell,
                              const nsString&    aDialogURL,
                              const nsString&    aTitle,
                              const nsRect&      aBounds,
                              PRUint32           aChromeMask,
                              PRBool             aAllowPlugins)
{
  mAllowPlugins = aAllowPlugins;
  mWindowType   = aType;
  mAppShell     = aAppShell;
  NS_IF_ADDREF(mAppShell);

  // Create top level window
  nsresult rv;
  rv = nsComponentManager::CreateInstance(kWindowCID, nsnull, kIWidgetIID,
                                             (void**) &mWindow);

  if (NS_OK != rv) {
    return rv;
  }

  mWindow->SetClientData(this);

  nsWidgetInitData initData;
  initData.mWindowType = eWindowType_toplevel;
  initData.mBorderStyle = eBorderStyle_default;

  nsRect r(0, 0, aBounds.width, aBounds.height);
  mWindow->Create((nsIWidget*)NULL, r, HandleXPDialogEvent,
                  nsnull, aAppShell, nsnull, &initData);
  mWindow->GetBounds(r);

  // Create web shell
    // Create web shell
  mWebBrowser = do_CreateInstance(NS_WEBBROWSER_CONTRACTID);
  NS_ENSURE_TRUE(mWebBrowser, NS_ERROR_FAILURE);

  r.x = r.y = 0;
  nsCOMPtr<nsIBaseWindow> webBrowserWin(do_QueryInterface(mWebBrowser));
  rv = webBrowserWin->InitWindow(mWindow->GetNativeData(NS_NATIVE_WIDGET), nsnull, r.x, r.y, r.width, r.height);
  
  mWebBrowser->SetContainerWindow((nsIWebBrowserChrome*) this);
  

  /*rv = nsComponentManager::CreateInstance(kWebShellCID, nsnull,
                                    kIWebShellIID,
                                    (void**)&mDocShell);
  if (NS_OK != rv) {
    return rv;
  }*/

    nsWeakPtr weakling(
      do_GetWeakReference((nsIWebProgressListener*)this));
  mWebBrowser->AddWebBrowserListener(weakling, NS_GET_IID(nsIWebProgressListener));

  webBrowserWin->Create();

  mDocShell = do_GetInterface(mWebBrowser);
  //mDocShell->SetAllowPlugins(aAllowPlugins);
  nsCOMPtr<nsIWebShell> webShell(do_QueryInterface(mDocShell));
  webShell->SetContainer((nsIWebShellContainer*) this);
  webBrowserWin->SetVisibility(PR_TRUE);

  r.x = r.y = 0;
  //nsCOMPtr<nsIDocShell> docShell(do_QueryInterface(mDocShell));
  //docShell->SetAllowPlugins(aAllowPlugins);
  //nsCOMPtr<nsIBaseWindow> docShellWin(do_QueryInterface(mDocShell));

  //rv = docShellWin->InitWindow(nsnull, mWindow, r.x, r.y, r.width, r.height);
  //docShellWin->Create();
  //mDocShell->SetContainer((nsIWebShellContainer*) this);
  //docShellWin->SetVisibility(PR_TRUE);

  // Now lay it all out
  Layout(r.width, r.height);

  // Load URL to Load GUI
  mDialogURL = aDialogURL;
  LoadURL(mDialogURL);

  SetTitle(aTitle.get());

  return NS_OK;
}

//----------------------------------------------------------------------
void nsXPBaseWindow::ForceRefresh()
{
  nsIPresShell* shell;
  GetPresShell(shell);
  if (nsnull != shell) {
    nsCOMPtr<nsIViewManager> vm;
    shell->GetViewManager(getter_AddRefs(vm));
    if (vm) {
      nsIView* root;
      vm->GetRootView(root);
      if (nsnull != root) {
        vm->UpdateView(root, NS_VMREFRESH_IMMEDIATE);
      }
    }
    NS_RELEASE(shell);
  }
}

//----------------------------------------------------------------------
void nsXPBaseWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
{
  nsRect rr(0, 0, aWidth, aHeight);
  nsCOMPtr<nsIBaseWindow> webShellWin(do_QueryInterface(mDocShell));
  webShellWin->SetPositionAndSize(rr.x, rr.y, rr.width, rr.height, PR_FALSE);
}

//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::SetLocation(PRInt32 aX, PRInt32 aY)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Move(aX, aY);
  return NS_OK;
}


//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::SetDimensions(PRInt32 aWidth, PRInt32 aHeight)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");

  // XXX We want to do this in one shot
  mWindow->Resize(aWidth, aHeight, PR_FALSE);
  Layout(aWidth, aHeight);

  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::GetBounds(nsRect& aBounds)
{
  mWindow->GetBounds(aBounds);
  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP
nsXPBaseWindow::GetWindowBounds(nsRect& aBounds)
{
  //XXX This needs to be non-client bounds when it exists.
  mWindow->GetBounds(aBounds);
  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::SetVisible(PRBool aIsVisible)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Show(aIsVisible);
  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::Close()
{
  if (nsnull != mWindowListener) {
    mWindowListener->Destroy(this);
  }

  if (nsnull != mDocShell) {
    nsCOMPtr<nsIBaseWindow> webShellWin(do_QueryInterface(mDocShell));
    webShellWin->Destroy();
//    NS_RELEASE(mDocShell);
  }

  if (nsnull != mWindow) {
    nsIWidget* w = mWindow;
    NS_RELEASE(w);
  }

  return NS_OK;
}


//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::GetWebShell(nsIDocShell*& aResult)
{
  aResult = mDocShell;
//  NS_IF_ADDREF(mDocShell);
  return NS_OK;
}

//---------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::SetTitle(const PRUnichar* aTitle)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mTitle = aTitle;
  nsAutoString newTitle(aTitle);
  mWindow->SetTitle(newTitle);
  return NS_OK;
}

//---------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::GetTitle(const PRUnichar** aResult)
{
  *aResult = ToNewUnicode(mTitle);
  return NS_OK;
}

//---------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::LoadURL(const nsString& aURL)
{
   nsCOMPtr<nsIWebNavigation> webNav(do_QueryInterface(mDocShell));
   webNav->LoadURI(aURL.get(), nsIWebNavigation::LOAD_FLAGS_NONE, nsnull, nsnull, nsnull);
   return NS_OK;
}

//---------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::WillLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsLoadType aReason)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::BeginLoadURL(nsIWebShell* aShell, const PRUnichar* aURL)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::ProgressLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, PRInt32 aProgress, PRInt32 aProgressMax)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::EndLoadURL(nsIWebShell* aShell, const PRUnichar* aURL, nsresult aStatus)
{
  // Find the Root Conent Node for this Window
  nsIPresShell* shell;
  GetPresShell(shell);
  if (nsnull != shell) {
    nsCOMPtr<nsIDocument> doc;
    shell->GetDocument(getter_AddRefs(doc));
    if (doc) {
      NS_IF_ADDREF(mContentRoot = doc->GetRootContent());
      mDocIsLoaded = PR_TRUE;
      if (nsnull != mWindowListener) {
        mWindowListener->Initialize(this);
      }
    }
    NS_RELEASE(shell);
  }

  return NS_OK;
}

//-----------------------------------------------------------------

NS_IMETHODIMP
nsXPBaseWindow::FindWebShellWithName(const PRUnichar* aName,
                                     nsIDocShell*& aResult)
{
  aResult = nsnull;

  nsString aNameStr(aName);

  nsCOMPtr<nsIDocShell> webShell;
  GetWebShell(*getter_AddRefs(webShell));
  nsCOMPtr<nsIDocShellTreeItem> docShellAsItem(do_QueryInterface(webShell));
  if (webShell) {
    nsXPIDLString name;
    if (NS_SUCCEEDED(docShellAsItem->GetName(getter_Copies(name)))) {
      if (aNameStr.Equals(name)) {
        aResult = webShell;
        NS_ADDREF(aResult);
        return NS_OK;
      }
    }      

    nsCOMPtr<nsIDocShellTreeNode> docShellAsNode(do_QueryInterface(webShell));
    nsCOMPtr<nsIDocShellTreeItem> result;
    if (NS_OK == docShellAsNode->FindChildWithName(aName, PR_TRUE, PR_FALSE,
      nsnull, getter_AddRefs(result))) {
      if (result) {
        CallQueryInterface(result, &aResult);
        return NS_OK;
      }
    }
  }

  return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::FocusAvailable(nsIWebShell* aFocusedWebShell, PRBool& aFocusTaken)
{
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::AddEventListener(nsIDOMNode * aNode)
{
  nsIDOMEventReceiver * receiver;

  NS_PRECONDITION(nsnull != aNode, "adding event listener to null node");

  if (NS_OK == aNode->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) {
    receiver->AddEventListenerByIID((nsIDOMMouseListener*)this, kIDOMMouseListenerIID);
    NS_RELEASE(receiver);
    return NS_OK;
  }
  return NS_ERROR_FAILURE;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::RemoveEventListener(nsIDOMNode * aNode)
{
  nsIDOMEventReceiver * receiver;

  NS_PRECONDITION(nsnull != aNode, "removing event listener from null node");

  if (NS_OK == aNode->QueryInterface(kIDOMEventReceiverIID, (void**) &receiver)) {
    receiver->RemoveEventListenerByIID(this, kIDOMMouseListenerIID);
    NS_RELEASE(receiver);
    return NS_OK;
  }
  return NS_ERROR_FAILURE;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::AddWindowListener(nsIWindowListener * aWindowListener)
{
  if (nsnull != mWindowListener) {
    return NS_ERROR_FAILURE;
  }

  mWindowListener = aWindowListener;
  if (nsnull != mWindowListener) {
    mWindowListener->Initialize(this);
  }
  return NS_OK;
}

//-----------------------------------------------------
// Get the HTML Document
NS_IMETHODIMP nsXPBaseWindow::GetDocument(nsIDOMHTMLDocument *& aDocument)
{
  nsIDOMHTMLDocument *htmlDoc = nsnull;
  nsIPresShell *shell = nsnull;
  GetPresShell(shell);
  if (nsnull != shell) {
    nsCOMPtr<nsIDocument> doc;
    shell->GetDocument(getter_AddRefs(doc));
    if (doc) {
      doc->QueryInterface(kIDOMHTMLDocumentIID,(void **)&htmlDoc);
    }
    NS_RELEASE(shell);
  }

  aDocument = htmlDoc;
  return NS_OK;
}

//-----------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::NewWebShell(PRUint32 aChromeMask,
                                          PRBool aVisible,
                                          nsIDocShell*& aNewWebShell)
{
  nsresult rv = NS_OK;

  // Create new window. By default, the refcnt will be 1 because of
  // the registration of the browser window in gBrowsers.
  nsXPBaseWindow* dialogWindow;
  NS_NEWXPCOM(dialogWindow, nsXPBaseWindow);

  if (nsnull != dialogWindow) {
    nsRect  bounds;
    GetBounds(bounds);

    rv = dialogWindow->Init(mWindowType, mAppShell, mDialogURL, mTitle, bounds, aChromeMask, mAllowPlugins);
    if (NS_OK == rv) {
      if (aVisible) {
        dialogWindow->SetVisible(PR_TRUE);
      }
      nsIDocShell *shell;
      rv = dialogWindow->GetWebShell(shell);
      aNewWebShell = shell;
    } else {
      dialogWindow->Close();
    }
  } else {
    rv = NS_ERROR_OUT_OF_MEMORY;
  }

  return rv;
}

NS_IMETHODIMP
nsXPBaseWindow::ContentShellAdded(nsIWebShell* aChildShell, nsIContent* frameNode)
{
  return NS_OK;
}


//----------------------------------------------------------------------
NS_IMETHODIMP nsXPBaseWindow::GetPresShell(nsIPresShell*& aPresShell)
{
  aPresShell = nsnull;

  nsCOMPtr<nsIDocShell> docShell(do_QueryInterface(mDocShell));
  if (docShell) {
    nsIContentViewer* cv = nsnull;
    docShell->GetContentViewer(&cv);
    if (nsnull != cv) {
      nsIDocumentViewer* docv = nsnull;
      cv->QueryInterface(kIDocumentViewerIID, (void**) &docv);
      if (nsnull != docv) {
        nsCOMPtr<nsIPresContext> cx;
        docv->GetPresContext(getter_AddRefs(cx));
        if (nsnull != cx) {
          NS_IF_ADDREF(aPresShell = cx->GetPresShell());
        }
        NS_RELEASE(docv);
      }
      NS_RELEASE(cv);
    }
  }
  return NS_OK;
}

//-----------------------------------------------------------------
//-- nsIDOMMouseListener
//-----------------------------------------------------------------

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::HandleEvent(nsIDOMEvent* aEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::MouseUp(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::MouseDown(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::MouseClick(nsIDOMEvent* aMouseEvent)
{
  if (nsnull != mWindowListener) {
    PRBool status;
    mWindowListener->MouseClick(aMouseEvent, this, status);
  }
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::MouseDblClick(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::MouseOver(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult nsXPBaseWindow::MouseOut(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//----------------------------------------------------------------------
// Factory code for creating nsXPBaseWindow's
//----------------------------------------------------------------------
class nsXPBaseWindowFactory : public nsIFactory
{
public:
  NS_DECL_ISUPPORTS
  NS_DECL_NSIFACTORY

  nsXPBaseWindowFactory();
  virtual ~nsXPBaseWindowFactory();
};

//----------------------------------------------------------------------
nsXPBaseWindowFactory::nsXPBaseWindowFactory()
{
}

//----------------------------------------------------------------------
nsXPBaseWindowFactory::~nsXPBaseWindowFactory()
{
}

//----------------------------------------------------------------------
nsresult
nsXPBaseWindowFactory::QueryInterface(const nsIID &aIID, void **aResult)
{
  if (aResult == NULL) {
    return NS_ERROR_NULL_POINTER;
  }

  // Always NULL result, in case of failure
  *aResult = NULL;

  if (aIID.Equals(kISupportsIID)) {
    *aResult = (void *)(nsISupports*)this;
  } else if (aIID.Equals(kIFactoryIID)) {
    *aResult = (void *)(nsIFactory*)this;
  }

  if (*aResult == NULL) {
    return NS_NOINTERFACE;
  }

  NS_ADDREF_THIS(); // Increase reference count for caller
  return NS_OK;
}

NS_IMPL_ADDREF(nsXPBaseWindowFactory)
NS_IMPL_RELEASE(nsXPBaseWindowFactory)

//----------------------------------------------------------------------
nsresult
nsXPBaseWindowFactory::CreateInstance(nsISupports *aOuter,
                                       const nsIID &aIID,
                                       void **aResult)
{
  nsresult rv;
  nsXPBaseWindow *inst;

  if (aResult == NULL) {
    return NS_ERROR_NULL_POINTER;
  }
  *aResult = NULL;
  if (nsnull != aOuter) {
    rv = NS_ERROR_NO_AGGREGATION;
    goto done;
  }

  NS_NEWXPCOM(inst, nsXPBaseWindow);
  if (inst == NULL) {
    rv = NS_ERROR_OUT_OF_MEMORY;
    goto done;
  }

  NS_ADDREF(inst);
  rv = inst->GetInterface(aIID, aResult);
  NS_RELEASE(inst);

done:
  return rv;
}

//----------------------------------------------------------------------
nsresult
nsXPBaseWindowFactory::LockFactory(PRBool aLock)
{
  // Not implemented in simplest case.
  return NS_OK;
}

//----------------------------------------------------------------------
nsresult
NS_NewXPBaseWindowFactory(nsIFactory** aFactory)
{
  nsresult rv = NS_OK;
  nsXPBaseWindowFactory* inst;
  NS_NEWXPCOM(inst, nsXPBaseWindowFactory);
  if (nsnull == inst) {
    rv = NS_ERROR_OUT_OF_MEMORY;
  }
  else {
    NS_ADDREF(inst);
  }
  *aFactory = inst;
  return rv;
}

//*****************************************************************************
// nsXPBaseWindow::nsIWebProgressListener
//*****************************************************************************   

NS_IMETHODIMP
nsXPBaseWindow::OnProgressChange(nsIWebProgress* aProgress,
                                      nsIRequest* aRequest,
                                      PRInt32 aCurSelfProgress,
                                      PRInt32 aMaxSelfProgress, 
                                      PRInt32 aCurTotalProgress,
                                      PRInt32 aMaxTotalProgress)
{
  mProgress = aCurTotalProgress;
  mMaxProgress = aMaxTotalProgress;
/*  if(mBrowserWindow->mStatus) {
    nsAutoString buf;
    PRUint32 size;

    buf.Append(NS_LITERAL_STRING("Loaded "));
    buf.AppendInt(mCurrent);
    buf.Append(NS_LITERAL_STRING(" of "));
    buf.AppendInt(mTotal);
    buf.Append(NS_LITERAL_STRING(" items.  ("));
    buf.AppendInt(mProgress);
    buf.Append(NS_LITERAL_STRING(" bytes of "));
    buf.AppendInt(mMaxProgress);
    buf.Append(NS_LITERAL_STRING(" bytes)"));

    mBrowserWindow->mStatus->SetText(buf,size);
  }*/
   return NS_OK;
}

NS_IMETHODIMP
nsXPBaseWindow::OnStateChange(nsIWebProgress* aProgress,
                                  nsIRequest* aRequest,
                                  PRUint32 aProgressStateFlags,
                                  nsresult aStatus)
{
  if (aProgressStateFlags & STATE_START) {
    if (aProgressStateFlags & STATE_IS_NETWORK) {
//      OnWindowActivityStart();
      BeginLoadURL(NULL, NULL);
    }
    if (aProgressStateFlags & STATE_IS_REQUEST) {
      mTotal += 1;
    }
  }

  if (aProgressStateFlags & STATE_STOP) {
    if (aProgressStateFlags & STATE_IS_REQUEST) {
      mCurrent += 1;

/*      if(mBrowserWindow->mStatus) {
        nsAutoString buf;
        PRUint32 size;

        buf.Append(NS_LITERAL_STRING("Loaded "));
        buf.AppendInt(mCurrent);
        buf.Append(NS_LITERAL_STRING(" of "));
        buf.AppendInt(mTotal);
        buf.Append(NS_LITERAL_STRING(" items.  ("));
        buf.AppendInt(mProgress);
        buf.Append(NS_LITERAL_STRING(" bytes of "));
        buf.AppendInt(mMaxProgress);
        buf.Append(NS_LITERAL_STRING(" bytes)"));

        mBrowserWindow->mStatus->SetText(buf,size);
      }*/
    }

    if (aProgressStateFlags & STATE_IS_NETWORK) {
      EndLoadURL(NULL,NULL,NS_OK);
//      OnWindowActivityFinished();
    }
  }

  if (aProgressStateFlags & STATE_TRANSFERRING) {
  //  OnStatusTransferring(aRequest);
  }

  return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::OnLocationChange(nsIWebProgress* aWebProgress,
                                                   nsIRequest* aRequest,
                                                   nsIURI* aURI)
{
   nsCAutoString spec;

   if(aURI)
      aURI->GetSpec(spec);

   PRBool isSubFrameLoad = PR_FALSE; // Is this a subframe load
   if (aWebProgress) {
     nsCOMPtr<nsIDOMWindow>  domWindow;
     nsCOMPtr<nsIDOMWindow>  topDomWindow;
     aWebProgress->GetDOMWindow(getter_AddRefs(domWindow));
     if (domWindow) { // Get root domWindow
//       domWindow->GetTop(getter_AddRefs(topDomWindow));
     }
//     if (domWindow != topDomWindow)
  //     isSubFrameLoad = PR_TRUE;
   }

/*   if(mBrowserWindow->mLocation && !isSubFrameLoad)
      {
      PRUint32 size;
      NS_ConvertUTF8toUCS2 tmp(spec);
      mBrowserWindow->mLocation->SetText(tmp,size);
      }*/

   return NS_OK;
}

NS_IMETHODIMP 
nsXPBaseWindow::OnStatusChange(nsIWebProgress* aWebProgress,
                                   nsIRequest* aRequest,
                                   nsresult aStatus,
                                   const PRUnichar* aMessage)
{
/*    if (mBrowserWindow && mBrowserWindow->mStatus) {
        PRUint32 size;
        mBrowserWindow->mStatus->SetText(nsAutoString(aMessage), size);
    }
*/    return NS_OK;
}

NS_IMETHODIMP 
nsXPBaseWindow::OnSecurityChange(nsIWebProgress *aWebProgress, 
                                     nsIRequest *aRequest, 
                                     PRUint32 state)
{
    return NS_OK;
}

void nsXPBaseWindow::OnLoadStart(nsIRequest* aRequest)
{
mCurrent=mTotal=mProgress=mMaxProgress=0;

//  mBrowserWindow->mLoadStartTime = PR_Now();

  if (aRequest) {
    nsresult rv;
    nsCOMPtr<nsIChannel> channel;
    nsCOMPtr<nsIURI> uri;

    channel = do_QueryInterface(aRequest, &rv);
    if (NS_SUCCEEDED(rv)) {
      channel->GetURI(getter_AddRefs(uri));
     
#ifdef MOZ_PERF_METRICS
      if (PR_FALSE == mTimerSet) {
        nsCAutoString url;
        nsresult rv = NS_OK;
        rv = uri->GetSpec(url);
        if (NS_SUCCEEDED(rv))
          MOZ_TIMER_LOG(("*** Timing layout processes on url: '%s', WebBrowserChrome: %p\n", url.get(), this));
        MOZ_TIMER_DEBUGLOG(("Reset and start: nsXPBaseWindow::OnLoadStart(), this=%p\n", this));
        MOZ_TIMER_RESET(mTotalTime);
        MOZ_TIMER_START(mTotalTime);
        mTimerSet = PR_TRUE;
      }
#endif

/*      if(mBrowserWindow->mStatus) {
        nsCAutoString uriString;

        uri->GetSpec(uriString);

        NS_ConvertUTF8toUCS2 url(uriString);
        url.Append(NS_LITERAL_STRING(": start"));
        PRUint32 size;
        mBrowserWindow->mStatus->SetText(url,size);
      }*/
    }
  } // if (aChannel)
}

void nsXPBaseWindow::OnLoadFinished(nsIRequest* aRequest,
                                        PRInt32 aProgressStatusFlags)
{
#ifdef MOZ_PERF_METRICS
  if ( /*(aProgressStatusFlags & nsIWebProgress::flag_win_stop) && */mTimerSet ) {
    MOZ_TIMER_DEBUGLOG(("Stop: nsWebShell::OnEndDocumentLoad(), this=%p\n", this));
    MOZ_TIMER_STOP(mTotalTime);
    MOZ_TIMER_LOG(("Total (Layout + Page Load) Time (webBrowserChrome=%p): ", this));
    MOZ_TIMER_PRINT(mTotalTime);
    mTimerSet = PR_FALSE;
  }
#endif

  nsCAutoString uriString;
  if(aRequest) {
    nsresult rv;
    nsCOMPtr<nsIChannel> channel;
    nsCOMPtr<nsIURI> uri;

    channel = do_QueryInterface(channel, &rv);
    if (NS_SUCCEEDED(rv)) {
      channel->GetURI(getter_AddRefs(uri));

      uri->GetSpec(uriString);
    }
  }  
  NS_ConvertUTF8toUCS2 msg(uriString);

  PRTime endLoadTime = PR_Now();
/*  if(mBrowserWindow->mShowLoadTimes)
     {
     printf("Loading ");
     fputs(NS_LossyConvertUCS2toASCII(msg).get(), stdout);
     PRTime delta;
     LL_SUB(delta, endLoadTime, mBrowserWindow->mLoadStartTime);
     double usecs;
     LL_L2D(usecs, delta);
     printf(" took %g milliseconds\n", usecs / 1000.0);
     }

  if(mBrowserWindow->mStatus)
     {
//     PRUint32 size;

     msg.Append(NS_LITERAL_STRING(" done."));

///      mBrowserWindow->mStatus->SetText(msg, size);
      }*/
}


NS_IMETHODIMP nsXPBaseWindow::SetStatus(PRUint32 aStatusType, const PRUnichar* aStatus)
{
/*   NS_ENSURE_STATE(mBrowserWindow->mStatus);

   switch (aStatusType)
     {
     case STATUS_SCRIPT:
     case STATUS_LINK:
       {
         NS_ENSURE_STATE(mBrowserWindow->mStatus);
         PRUint32 size;
         mBrowserWindow->mStatus->SetText(nsAutoString(aStatus), size);
       }
       break;
     }*/
   return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::SetWebBrowser(nsIWebBrowser* aWebBrowser)
{
   NS_ERROR("Haven't Implemented this yet");
   return NS_ERROR_FAILURE;
}

NS_IMETHODIMP nsXPBaseWindow::GetWebBrowser(nsIWebBrowser** aWebBrowser)
{
  // Unimplemented, and probably will remain so; xpfe windows have docshells,
  // not webbrowsers.
  NS_ENSURE_ARG_POINTER(aWebBrowser);
  *aWebBrowser = 0;
  return NS_ERROR_FAILURE;
}

NS_IMETHODIMP nsXPBaseWindow::SetChromeFlags(PRUint32 aChromeFlags)
{
//   mChromeFlags = aChromeFlags;
   return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::GetChromeFlags(PRUint32* aChromeFlags)
{
//   *aChromeFlags = mChromeFlags;
   return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::DestroyBrowserWindow()
{
   ExitModalEventLoop(NS_OK);
   return NS_OK;
}

#if 0
/* Just commenting out for now because it looks like somebody went to
   a lot of work here. This method has been removed from nsIWebBrowserChrome
   per the 5 Feb 01 API review, to be handled one level further down
   in nsDocShellTreeOwner.
*/
NS_IMETHODIMP nsXPBaseWindow::FindNamedBrowserItem(const PRUnichar* aName,
   nsIDocShellTreeItem** aBrowserItem)
{
   NS_ENSURE_ARG_POINTER(aBrowserItem);
   *aBrowserItem = nsnull;

   PRInt32 i = 0;
   PRInt32 n = mBrowserWindow->gBrowsers.Count();

   nsString aNameStr(aName);

   for (i = 0; i < n; i++)
      {
      nsBrowserWindow* bw = (nsBrowserWindow*)mBrowserWindow->gBrowsers.ElementAt(i);
      nsCOMPtr<nsIDocShellTreeItem> docShellAsItem(do_QueryInterface(bw->mWebBrowser));
      NS_ENSURE_TRUE(docShellAsItem, NS_ERROR_FAILURE);

      docShellAsItem->FindItemWithName(aName, NS_STATIC_CAST(nsIWebBrowserChrome*, this), aBrowserItem);

      if(!*aBrowserItem)
         return NS_OK;
      }
   return NS_OK;
}
#endif

NS_IMETHODIMP nsXPBaseWindow::SizeBrowserTo(PRInt32 aCX, PRInt32 aCY)
{
//   mSizeSet = PR_TRUE;
   mWindow->Resize(aCX, aCY, PR_FALSE);
   Layout(aCX, aCY);

   return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::ShowAsModal()
{
  /* Copied from nsXULWindow */
  /*nsCOMPtr<nsIAppShell> appShell(do_CreateInstance(kAppShellCID));
  if (!appShell)
    return NS_ERROR_FAILURE;

  appShell->Create(0, nsnull);
  appShell->Spinup();
  // Store locally so it doesn't die on us
  nsCOMPtr<nsIWidget> window = mBrowserWindow->mWindow;

  window->SetModal(PR_TRUE);
  mContinueModalLoop = PR_TRUE;
  EnableParent(PR_FALSE);

  nsCOMPtr<nsIJSContextStack> stack(do_GetService("@mozilla.org/js/xpc/ContextStack;1"));
  nsresult rv = NS_OK;
  if (stack && NS_SUCCEEDED(stack->Push(nsnull))) {
    while (NS_SUCCEEDED(rv) && mContinueModalLoop) {
      void* data;
      PRBool isRealEvent;
      PRBool processEvent;

      rv = appShell->GetNativeEvent(isRealEvent, data);
      if (NS_SUCCEEDED(rv)) {
        window->ModalEventFilter(isRealEvent, data, &processEvent);
        if (processEvent)
          appShell->DispatchNativeEvent(isRealEvent, data);
      }
    }

    JSContext* cx;
    stack->Pop(&cx);
    NS_ASSERTION(!cx, "JSContextStack mismatch");
  } else
    rv = NS_ERROR_FAILURE;

  mContinueModalLoop = PR_FALSE;
  window->SetModal(PR_FALSE);
  appShell->Spindown();

  return mModalStatus;*/
	return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::IsWindowModal(PRBool *_retval)
{
//  *_retval = mContinueModalLoop;
  return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::ExitModalEventLoop(nsresult aStatus)
{
  //if (mContinueModalLoop)
//    EnableParent(PR_TRUE);
  //mContinueModalLoop = PR_FALSE;
//  mModalStatus = aStatus;
  return NS_OK;
}

//*****************************************************************************
// nsIWebBrowserChromeFocus
//*****************************************************************************

NS_IMETHODIMP
nsXPBaseWindow::FocusNextElement()
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP
nsXPBaseWindow::FocusPrevElement()
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

//*****************************************************************************
// nsXPBaseWindow::nsIEmbeddingSiteWindow
//*****************************************************************************   

NS_IMETHODIMP nsXPBaseWindow::SetDimensions(PRUint32 aFlags, PRInt32 aX, PRInt32 aY, PRInt32 aCX, PRInt32 aCY)
{
  return SetDimensions(aCX, aCY);
}

NS_IMETHODIMP nsXPBaseWindow::GetDimensions(PRUint32 aFlags, PRInt32 *aX, PRInt32 *aY, PRInt32 *aCX, PRInt32 *aCY)
{
  PRInt32 x, y, cx, cy;
//  mBrowserWindow->GetPositionAndSize(&x, &y, &cx, &cy);
  if (aFlags & DIM_FLAGS_POSITION)
  {
    if(aX)
      *aX = x;
    if(aY)
      *aY = y;
  }
  if (aFlags & DIM_FLAGS_SIZE_INNER || aFlags & DIM_FLAGS_SIZE_OUTER)
  {
    if(aCX)
      *aCX = cx;
    if(aCY)
      *aCY = cy;
  }
  return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::GetSiteWindow(void ** aParentNativeWindow)
{
   NS_ENSURE_ARG_POINTER(aParentNativeWindow);

   //if (mBrowserWindow) {
     //nsCOMPtr<nsIWidget> window;
//     mBrowserWindow->GetWindow(getter_AddRefs(window));
  //   if (window) {
    //   *aParentNativeWindow = window->GetNativeData(NS_NATIVE_WINDOW);
     //}
   //}
   return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::GetVisibility(PRBool *aVisibility)
{
	return NS_OK;
	//mWindow->GetVisibility(aVisibility);

}

NS_IMETHODIMP nsXPBaseWindow::SetVisibility(PRBool aVisibility)
{
	//mWindow->SetVisible(aVisibility);
	return NS_OK;
}

NS_IMETHODIMP nsXPBaseWindow::SetFocus()
{  
   return mWindow->SetFocus();
}

NS_IMETHODIMP nsXPBaseWindow::GetTitle(PRUnichar** aTitle)
{
   //return mWindow->GetTitle(aTitle);
	return NS_OK;
}

