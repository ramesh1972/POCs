#include "rvXPBaseWindow.h"
#include "nsIFactory.h"
#include "nsIComponentManager.h"
#include "nsIAppShell.h"
#include "nsIWidget.h"
#include "nsIDOMDocument.h"
#include "nsIURL.h"
#include "nsWidgetsCID.h"
#include "nsIDocumentViewer.h"
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

#include <ctype.h> // tolower

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

static nsEventStatus PR_CALLBACK
HandleXPDialogEvent(nsGUIEvent *aEvent);

rvXPBaseWindow::rvXPBaseWindow() :
  mAppShell(nsnull)
{
}

//----------------------------------------------------------------------
rvXPBaseWindow::~rvXPBaseWindow()
{
  NS_IF_RELEASE(mAppShell);
}

//----------------------------------------------------------------------
NS_IMPL_ADDREF(rvXPBaseWindow)
NS_IMPL_RELEASE(rvXPBaseWindow)

//----------------------------------------------------------------------
nsresult rvXPBaseWindow::QueryInterface(const nsIID& aIID,
                                        void** aInstancePtrResult)
{
  NS_PRECONDITION(nsnull != aInstancePtrResult, "null pointer");
  if (nsnull == aInstancePtrResult) {
    return NS_ERROR_NULL_POINTER;
  }

  *aInstancePtrResult = NULL;

  if (aIID.Equals(kIXPBaseWindowIID)) {
    *aInstancePtrResult = (void*) ((nsIXPBaseWindow*)this);
    NS_ADDREF_THIS();
    return NS_OK;
  }
  if (aIID.Equals(kIWebShellContainerIID)) {
    *aInstancePtrResult = (void*) ((nsIWebShellContainer*)this);
    NS_ADDREF_THIS();
    return NS_OK;
  }
  if (aIID.Equals(kIDOMMouseListenerIID)) {
    NS_ADDREF_THIS(); // Increase reference count for caller
    *aInstancePtrResult = (void *)((nsIDOMMouseListener*)this);
    return NS_OK;
  }
  
  if (aIID.Equals(kISupportsIID)) {
    NS_ADDREF_THIS();
    *aInstancePtrResult = (void*) ((nsISupports*)((nsIXPBaseWindow*)this));
    return NS_OK;
  }

  return NS_NOINTERFACE;
}

class rvXPBaseWindowFactory : public nsIFactory
{
public:
  NS_DECL_ISUPPORTS
  NS_DECL_NSIFACTORY

  rvXPBaseWindowFactory();
  virtual ~rvXPBaseWindowFactory();
};

//----------------------------------------------------------------------
rvXPBaseWindowFactory::rvXPBaseWindowFactory()
{
}

//----------------------------------------------------------------------
rvXPBaseWindowFactory::~rvXPBaseWindowFactory()
{
}

//----------------------------------------------------------------------
nsresult
rvXPBaseWindowFactory::QueryInterface(const nsIID &aIID, void **aResult)
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

NS_IMPL_ADDREF(rvXPBaseWindowFactory)
NS_IMPL_RELEASE(rvXPBaseWindowFactory)

//----------------------------------------------------------------------
nsresult
rvXPBaseWindowFactory::CreateInstance(nsISupports *aOuter,
                                       const nsIID &aIID,
                                       void **aResult)
{
  nsresult rv;
  rvXPBaseWindow *inst;

  if (aResult == NULL) {
    return NS_ERROR_NULL_POINTER;
  }
  *aResult = NULL;
  if (nsnull != aOuter) {
    rv = NS_ERROR_NO_AGGREGATION;
    goto done;
  }

  NS_NEWXPCOM(inst, rvXPBaseWindow);
  if (inst == NULL) {
    rv = NS_ERROR_OUT_OF_MEMORY;
    goto done;
  }

  NS_ADDREF(inst);
  rv = inst->QueryInterface(aIID, aResult);
  NS_RELEASE(inst);

done:
  return rv;
}

//----------------------------------------------------------------------
nsresult
rvXPBaseWindowFactory::LockFactory(PRBool aLock)
{
  // Not implemented in simplest case.
  return NS_OK;
}

//----------------------------------------------------------------------
nsresult
NS_NewXPBaseWindowFactory(nsIFactory** aFactory)
{
  nsresult rv = NS_OK;
  rvXPBaseWindowFactory* inst;
  NS_NEWXPCOM(inst, rvXPBaseWindowFactory);
  if (nsnull == inst) {
    rv = NS_ERROR_OUT_OF_MEMORY;
  }
  else {
    NS_ADDREF(inst);
  }
  *aFactory = inst;
  return rv;
}

nsresult rvXPBaseWindow::Init(nsXPBaseWindowType aType,
                              nsIAppShell*       aAppShell,
                              const nsString&    aDialogURL,
                              const nsString&    aTitle,
                              const nsRect&      aBounds,
                              PRUint32           aChromeMask,
                              PRBool             aAllowPlugins)
{
  mWindowType   = aType;
  mAppShell     = aAppShell;
  NS_IF_ADDREF(mAppShell);

  // Create top level window
  nsresult rv;
  rv = nsComponentManager::CreateInstance(kWindowCID, nsnull, kIWidgetIID,
                                             (void**)&mWindow);

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
/*  rv = nsComponentManager::CreateInstance(kWebShellCID, nsnull,
                                    kIWebShellIID,
                                    (void**)&mWebShell);
  if (NS_OK != rv) {
    return rv;
  }
  r.x = r.y = 0;
  nsCOMPtr<nsIDocShell> docShell(do_QueryInterface(mWebShell));
  docShell->SetAllowPlugins(aAllowPlugins);
  nsCOMPtr<nsIBaseWindow> docShellWin(do_QueryInterface(mWebShell));

  rv = docShellWin->InitWindow(nsnull, mWindow, r.x, r.y, r.width, r.height);
  docShellWin->Create();
  mWebShell->SetContainer((nsIWebShellContainer*) this);
  docShellWin->SetVisibility(PR_TRUE);

  // Now lay it all out
  Layout(r.width, r.height);

  // Load URL to Load GUI
  mDialogURL = aDialogURL;
  LoadURL(mDialogURL);

  SetTitle(aTitle.get());*/

  return NS_OK;
}

void rvXPBaseWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
{
  nsRect rr(0, 0, aWidth, aHeight);
//  nsCOMPtr<nsIBaseWindow> webShellWin(do_QueryInterface(mWebShell));
  //webShellWin->SetPositionAndSize(rr.x, rr.y, rr.width, rr.height, PR_FALSE);
}

//----------------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::SetLocation(PRInt32 aX, PRInt32 aY)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Move(aX, aY);
  return NS_OK;
}


//----------------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::SetDimensions(PRInt32 aWidth, PRInt32 aHeight)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");

  // XXX We want to do this in one shot
  mWindow->Resize(aWidth, aHeight, PR_FALSE);
  Layout(aWidth, aHeight);

  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::GetBounds(nsRect& aBounds)
{
  mWindow->GetBounds(aBounds);
  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP
rvXPBaseWindow::GetWindowBounds(nsRect& aBounds)
{
  //XXX This needs to be non-client bounds when it exists.
  mWindow->GetBounds(aBounds);
  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::SetVisible(PRBool aIsVisible)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Show(aIsVisible);
  return NS_OK;
}

//----------------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::Close()
{
/*  if (nsnull != mWindowListener) {
    mWindowListener->Destroy(this);
  }

  if (nsnull != mWebShell) {
    nsCOMPtr<nsIBaseWindow> webShellWin(do_QueryInterface(mWebShell));
    webShellWin->Destroy();
    NS_RELEASE(mWebShell);
  }
*/
  if (nsnull != mWindow) {
    nsIWidget* w = mWindow;
    NS_RELEASE(w);
  }

  return NS_OK;
}


//----------------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::GetWebShell(nsIWebShell*& aResult)
{
//  aResult = mWebShell;
 // NS_IF_ADDREF(mWebShell);
  return NS_OK;
}

//---------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::SetTitle(const PRUnichar* aTitle)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mTitle = aTitle;
  nsAutoString newTitle(aTitle);
  mWindow->SetTitle(newTitle);
  return NS_OK;
}

//---------------------------------------------------------------
NS_IMETHODIMP rvXPBaseWindow::GetTitle(const PRUnichar** aResult)
{
  *aResult = ToNewUnicode(mTitle);
  return NS_OK;
}


NS_IMETHODIMP rvXPBaseWindow::LoadURL(const nsString& aURL)
{
 //  nsCOMPtr<nsIWebNavigation> webNav(do_QueryInterface(mWebShell));
 //  webNav->LoadURI(aURL.get(), nsIWebNavigation::LOAD_FLAGS_NONE, nsnull, nsnull, nsnull);
   return NS_OK;
}

NS_IMETHODIMP rvXPBaseWindow::AddEventListener(nsIDOMNode * aNode)
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
NS_IMETHODIMP rvXPBaseWindow::RemoveEventListener(nsIDOMNode * aNode)
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
NS_IMETHODIMP rvXPBaseWindow::AddWindowListener(nsIWindowListener * aWindowListener)
{
/*  if (nsnull != mWindowListener) {
    return NS_ERROR_FAILURE;
  }

  mWindowListener = aWindowListener;
  if (mDocIsLoaded && nsnull != mWindowListener) {
    mWindowListener->Initialize(this);
  }*/
  return NS_OK;
}

//-----------------------------------------------------
// Get the HTML Document
NS_IMETHODIMP rvXPBaseWindow::GetDocument(nsIDOMHTMLDocument *& aDocument)
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

nsresult rvXPBaseWindow::HandleEvent(nsIDOMEvent* aEvent)
{
  return NS_OK;
}

nsresult rvXPBaseWindow::MouseUp(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult rvXPBaseWindow::MouseDown(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult rvXPBaseWindow::MouseClick(nsIDOMEvent* aMouseEvent)
{
/*  if (nsnull != mWindowListener) {
    PRBool status;
    mWindowListener->MouseClick(aMouseEvent, this, status);
  }*/
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult rvXPBaseWindow::MouseDblClick(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult rvXPBaseWindow::MouseOver(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}

//-----------------------------------------------------------------
nsresult rvXPBaseWindow::MouseOut(nsIDOMEvent* aMouseEvent)
{
  return NS_OK;
}


static nsEventStatus PR_CALLBACK
HandleXPDialogEvent(nsGUIEvent *aEvent)
{ 
  nsEventStatus result = nsEventStatus_eIgnore;

  rvXPBaseWindow* baseWin;
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

NS_IMETHODIMP rvXPBaseWindow::GetPresShell(nsIPresShell*& aPresShell)
{
  aPresShell = nsnull;

/*  nsCOMPtr<nsIDocShell> docShell(do_QueryInterface(mWebShell));
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
  }*/
  return NS_OK;
}

