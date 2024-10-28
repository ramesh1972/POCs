#include "rvMainWindow.h"
#include "rvMyMozApp.h"
#include "nsIDeviceContext.h"

#include "nsIChannel.h"
#include "nsIURI.h"
#include "nscore.h"
#include "nsIAppShell.h"
#include "nsIComponentManager.h"
#include "nsWidgetsCID.h"
#include "nsIFactory.h"
#include "nsIRenderingContext.h"

static NS_DEFINE_CID(kWindowCID, NS_WINDOW_CID);
static NS_DEFINE_IID(kIWidgetIID, NS_IWIDGET_IID);
static NS_DEFINE_IID(kISupportsIID, NS_ISUPPORTS_IID);
static NS_DEFINE_IID(kIFactoryIID, NS_IFACTORY_IID);

rvMainWindow* gMainWin;
static nsEventStatus PR_CALLBACK HandleMainWindowEvent(nsGUIEvent *aEvent);

NS_IMPL_ADDREF(rvMainWindow)
NS_IMPL_RELEASE(rvMainWindow)
//NS_IMPL_ISUPPORTS2(rvMainWindow, nsIInterfaceRequestor, nsIProgressEventSink)

NS_INTERFACE_MAP_BEGIN(rvMainWindow)
    NS_INTERFACE_MAP_ENTRY(nsIBaseWindow)
	    NS_INTERFACE_MAP_ENTRY(nsIInterfaceRequestor)
		    NS_INTERFACE_MAP_ENTRY(nsIProgressEventSink)
			NS_INTERFACE_MAP_ENTRY(nsIWebBrowser)
NS_INTERFACE_MAP_END

NS_IMETHODIMP rvMainWindow::InitWindow(nativeWindow aParentNativeWindow,
   nsIWidget* parentWidget, PRInt32 x, PRInt32 y, PRInt32 cx, PRInt32 cy)   
{
   // Ignore wigdet parents for now.  Don't think those are a vaild thing to call.
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, cx, cy, PR_FALSE), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Create()
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_UNEXPECTED;
}

NS_IMETHODIMP rvMainWindow::Destroy()
{
  // Others are holding refs to this, 
  // but it gets released OK.
  DestroyWidget(mWindow);
  mWindow = nsnull;
  // NS_RELEASE(mWindow);

  return NS_OK;
}

void rvMainWindow::DestroyWidget(nsISupports* aWidget)
{
  if(aWidget) {
    nsCOMPtr<nsIWidget> w(do_QueryInterface(aWidget));
    if (w) {
      w->Destroy();
    }
  }
}

NS_IMETHODIMP
rvMainWindow::MoveTo(PRInt32 aX, PRInt32 aY)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");
  mWindow->Move(aX, aY);
  return NS_OK;
}

NS_IMETHODIMP
rvMainWindow::SizeContentTo(PRInt32 aWidth, PRInt32 aHeight)
{
  NS_PRECONDITION(nsnull != mWindow, "null window");

  // XXX We want to do this in one shot
  mWindow->Resize(aWidth, aHeight, PR_FALSE);
 // Layout(aWidth, aHeight);

  return NS_OK;
}

NS_IMETHODIMP
rvMainWindow::SizeWindowTo(PRInt32 aWidth, PRInt32 aHeight,
                              PRBool /*aWidthTransient*/,
                              PRBool /*aHeightTransient*/)
{
  return SizeContentTo(aWidth, aHeight);
}

NS_IMETHODIMP
rvMainWindow::GetContentBounds(nsRect& aBounds)
{
  mWindow->GetClientBounds(aBounds);
  return NS_OK;
}

NS_IMETHODIMP
rvMainWindow::GetWindowBounds(nsRect& aBounds)
{
  mWindow->GetBounds(aBounds);
  return NS_OK;
}


nsEventStatus rvMainWindow::ProcessDialogEvent(nsGUIEvent *aEvent)
{ 
  nsEventStatus result = nsEventStatus_eIgnore;

  switch(aEvent->message) {

    case NS_KEY_DOWN: {
    } break;

    case NS_MOUSE_LEFT_BUTTON_UP: {
    } break;

    case NS_PAINT: 
      break;
    default:
      result = nsEventStatus_eIgnore;
  }
  
    return result;
}

void rvMainWindow::CloseAllWindows() {
}

NS_IMETHODIMP rvMainWindow::GetTitle(PRUnichar** aTitle)
{
   NS_ENSURE_ARG_POINTER(aTitle);

   *aTitle = ToNewUnicode(mTitle);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetTitle(const PRUnichar* aTitle)
{
   NS_ENSURE_STATE(mWindow);

   mTitle = aTitle;

   NS_ENSURE_SUCCESS(mWindow->SetTitle(nsAutoString(aTitle)), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetFocus()
{
   //XXX First Check In
   //NS_WARNING("Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetMainWidget(nsIWidget** aMainWidget)
{
   NS_ENSURE_ARG_POINTER(aMainWidget);

   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetEnabled(PRBool *aEnabled)
{
  NS_ENSURE_ARG_POINTER(aEnabled);
  *aEnabled = PR_TRUE;
  if (mWindow)
    mWindow->IsEnabled(aEnabled);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetEnabled(PRBool aEnabled)
{
  if (mWindow)
    mWindow->Enable(aEnabled);
  return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetBlurSuppression(PRBool *aBlurSuppression)
{
  NS_ENSURE_ARG_POINTER(aBlurSuppression);
  *aBlurSuppression = PR_FALSE;
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::SetBlurSuppression(PRBool aBlurSuppression)
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::GetVisibility(PRBool* aVisibility)
{
   NS_ENSURE_ARG_POINTER(aVisibility);

   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetVisibility(PRBool aVisibility)
{
   NS_ENSURE_STATE(mWindow);

   NS_ENSURE_SUCCESS(mWindow->Show(aVisibility), NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::Repaint(PRBool aForce)
{
   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetParentWidget(nsIWidget** aParentWidget)
{
   NS_ENSURE_ARG_POINTER(aParentWidget);
   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetParentWidget(nsIWidget* aParentWidget)
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::GetParentNativeWindow(nativeWindow* aParentNativeWindow)
{
   NS_ENSURE_ARG_POINTER(aParentNativeWindow);

   //XXX First Check In
   NS_ASSERTION(PR_FALSE, "Not Yet Implemented");
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::SetParentNativeWindow(nativeWindow aParentNativeWindow)
{
   NS_ASSERTION(PR_FALSE, "You can't call this");
   return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP rvMainWindow::SetPosition(PRInt32 aX, PRInt32 aY)
{
   PRInt32 cx=0;
   PRInt32 cy=0;

   NS_ENSURE_SUCCESS(GetSize(&cx, &cy), NS_ERROR_FAILURE);
   NS_ENSURE_SUCCESS(SetPositionAndSize(aX, aY, cx, cy, PR_FALSE), 
      NS_ERROR_FAILURE);
   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetPosition(PRInt32* aX, PRInt32* aY)
{
   return GetPositionAndSize(aX, aY, nsnull, nsnull);
}

NS_IMETHODIMP rvMainWindow::SetSize(PRInt32 aCX, PRInt32 aCY, PRBool aRepaint)
{
   PRInt32 x=0;
   PRInt32 y=0;

   NS_ENSURE_SUCCESS(GetPosition(&x, &y), NS_ERROR_FAILURE);
   NS_ENSURE_SUCCESS(SetPositionAndSize(x, y, aCX, aCY, aRepaint), 
      NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetSize(PRInt32* aCX, PRInt32* aCY)
{
   return GetPositionAndSize(nsnull, nsnull, aCX, aCY);
}

NS_IMETHODIMP rvMainWindow::SetPositionAndSize(PRInt32 aX, PRInt32 aY, 
   PRInt32 aCX, PRInt32 aCY, PRBool aRepaint)
{
   NS_ENSURE_SUCCESS(mWindow->Resize(aX, aY, aCX, aCY, aRepaint), 
      NS_ERROR_FAILURE);

   return NS_OK;
}

NS_IMETHODIMP rvMainWindow::GetPositionAndSize(PRInt32* aX, PRInt32* aY, 
   PRInt32* aCX, PRInt32* aCY)
{
   nsRect bounds;

   NS_ENSURE_SUCCESS(mWindow->GetBounds(bounds), NS_ERROR_FAILURE);

   if(aX)
      *aX = bounds.x;
   if(aY)
      *aY = bounds.y;
   if(aCX)
      *aCX = bounds.width;
   if(aCY)
      *aCY = bounds.height;

   return NS_OK;
}

NS_IMETHODIMP
rvMainWindow::OnStatus(nsIRequest* request, nsISupports *ctxt,
                          nsresult aStatus, const PRUnichar *aStatusArg)
{
  return NS_OK;
}

NS_IMETHODIMP
rvMainWindow::OnProgress(nsIRequest* request, nsISupports *ctxt,
                            PRUint32 aProgress, PRUint32 aProgressMax)
{
  nsresult rv;

  nsCOMPtr<nsIURI> aURL;
  nsCOMPtr<nsIChannel> channel = do_QueryInterface(request);
  rv = channel->GetURI(getter_AddRefs(aURL));
  if (NS_FAILED(rv)) return rv;
  
  return NS_OK;
}

nsresult
rvMainWindow::GetInterface(const nsIID& aIID,
                              void** aInstancePtrResult)
{
  NS_PRECONDITION(aInstancePtrResult, "null pointer");
  if (!aInstancePtrResult)
    return NS_ERROR_NULL_POINTER;

  return QueryInterface(aIID, aInstancePtrResult);
}

nsresult
rvMainWindow::Init(nsIAppShell* aAppShell,
                      const nsRect& aBounds)
{
  gMainWin = this;
  mAppShell = aAppShell;
  NS_IF_ADDREF(mAppShell);

  nsresult rv = nsComponentManager::CreateInstance(kWindowCID, nsnull,
                                                   kIWidgetIID,
                                                   getter_AddRefs(mWindow));

  if (NS_OK != rv) {
    return rv;
  }

// create the window
  nsWidgetInitData initData;
  initData.mWindowType = eWindowType_toplevel;
  initData.mBorderStyle = eBorderStyle_default;


  nsRect r(0, 0, aBounds.width, aBounds.height);
  mWindow->Create((nsIWidget*)NULL, r, HandleMainWindowEvent,
                  nsnull, aAppShell, nsnull, &initData);
  mWindow->GetClientBounds(r);
/*  nsIRenderingContext* rc = mWindow->GetRenderingContext();
  
 rc->SetColor(NS_RGB(0,0,0));
rc->DrawRect(r);*/

  

/*      nsIRenderingContext *rc = new nsIRenderingContext();
      nscolor oldColor;
      rc->GetColor(oldColor);
      rc->SetColor(NS_RGB(10,10,10));
      rc->FillRect(*paintEvent->rect);
      rc->SetColor(oldColor);*/


  return NS_OK;
}

void rvMainWindow::Layout(PRInt32 aWidth, PRInt32 aHeight)
{
}


static nsEventStatus PR_CALLBACK
HandleMainWindowEvent(nsGUIEvent *aEvent)
{ 
  nsEventStatus result = nsEventStatus_eIgnore;
  rvMainWindow* bw = gMainWin;
    NS_ADDREF(bw);
  if (nsnull != bw) {
    nsSizeEvent* sizeEvent;
    switch(aEvent->message) {
    case NS_SIZE:{
      break;
				 }
    case NS_PAINT:{
		nsRect bounds;
      sizeEvent = (nsSizeEvent*)aEvent;  
      nsPaintEvent *pe = (nsPaintEvent *)aEvent;
		pe->widget->GetClientBounds(bounds);
		nsIRenderingContext *cx = pe->renderingContext;
	
      cx->SetColor(NS_RGB(0, 0, 0));
      cx->FillRect(0, 0, bounds.width, bounds.height);
		break;
				  }
    case NS_XUL_CLOSE:
    case NS_DESTROY:
    {
      rvMyMozApp* app = bw->mApp;
      app->CloseWindow(bw);
      result = nsEventStatus_eConsumeDoDefault;
    }
    return result;
    default:
      break;
    }
    NS_RELEASE(bw);
  }
  return result;
}


NS_IMETHODIMP rvMainWindow::AddWebBrowserListener(nsIWeakReference *aListener, const nsIID & aIID)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}

/* void removeWebBrowserListener (in nsIWeakReference aListener, in nsIIDRef aIID); */
NS_IMETHODIMP rvMainWindow::RemoveWebBrowserListener(nsIWeakReference *aListener, const nsIID & aIID)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}

/* attribute nsIWebBrowserChrome containerWindow; */
NS_IMETHODIMP rvMainWindow::GetContainerWindow(nsIWebBrowserChrome * *aContainerWindow)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}
NS_IMETHODIMP rvMainWindow::SetContainerWindow(nsIWebBrowserChrome * aContainerWindow)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}

/* attribute nsIURIContentListener parentURIContentListener; */
NS_IMETHODIMP rvMainWindow::GetParentURIContentListener(nsIURIContentListener * *aParentURIContentListener)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}
NS_IMETHODIMP rvMainWindow::SetParentURIContentListener(nsIURIContentListener * aParentURIContentListener)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}

/* readonly attribute nsIDOMWindow contentDOMWindow; */
NS_IMETHODIMP rvMainWindow::GetContentDOMWindow(nsIDOMWindow * *aContentDOMWindow)
{
    return NS_ERROR_NOT_IMPLEMENTED;
}

