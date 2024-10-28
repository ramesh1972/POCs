/* -*- Mode: C++; tab-width: 3; indent-tabs-mode: nil; c-basic-offset: 2 -*-
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 * 
 * The Original Code is the Mozilla browser.
 * 
 * The Initial Developer of the Original Code is Netscape
 * Communications, Inc.  Portions created by Netscape are
 * Copyright (C) 1999, Mozilla.  All Rights Reserved.
 * 
 * Contributor(s):
 *   Travis Bogard <travis@netscape.com>
 *   Brian Ryner <bryner@brianryner.com>
 */

// Local Includes
#include "rvXPCOMIDs.h"
#include "rvMyMozApp.h"
#include "rvMainWindow.h"
#include "nsWebBrowserChrome.h"
#include "nsIWeakReference.h"

// externs
IAPPG;

//*****************************************************************************
//***    nsWebBrowserChrome: Object Management
//*****************************************************************************
nsWebBrowserChrome::nsWebBrowserChrome() : mBrowserWindow(nsnull)
{
	ILOG << "nsWebBrowserChrome::nsWebBrowserChrome()" << IINF;

	mActiveDocuments = 0;
	mChromeFlags = 0;
	mSizeSet = PR_FALSE;
	mContinueModalLoop = PR_FALSE;
	mModalStatus = NS_OK;
	mChromeLoaded = PR_FALSE;
}

nsWebBrowserChrome::~nsWebBrowserChrome()
{
	ILOG << "nsWebBrowserChrome::~nsWebBrowserChrome()" << IINF;
	mActiveDocuments = 0;
	mChromeFlags = 0;
	mSizeSet = PR_FALSE;
	mContinueModalLoop = PR_FALSE;
	mModalStatus = NS_OK;
	mChromeLoaded = PR_FALSE;
}

//*****************************************************************************
// nsWebBrowserChrome::nsISupports
//*****************************************************************************   
NS_IMPL_ADDREF(nsWebBrowserChrome)
NS_IMPL_RELEASE(nsWebBrowserChrome)

NS_INTERFACE_MAP_BEGIN(nsWebBrowserChrome)
  NS_INTERFACE_MAP_ENTRY_AMBIGUOUS(nsISupports, nsIWebBrowserChrome)
  NS_INTERFACE_MAP_ENTRY(nsIInterfaceRequestor)
  NS_INTERFACE_MAP_ENTRY(nsIWebBrowserChrome)
  NS_INTERFACE_MAP_ENTRY(nsIWebBrowserChromeFocus)
  NS_INTERFACE_MAP_ENTRY(nsIEmbeddingSiteWindow)
  NS_INTERFACE_MAP_ENTRY(nsIWebProgressListener)
	NS_INTERFACE_MAP_ENTRY(nsISupportsWeakReference)
NS_INTERFACE_MAP_END

//*****************************************************************************
// nsWebBrowserChrome::nsIInterfaceRequestor
//*****************************************************************************   
NS_IMETHODIMP nsWebBrowserChrome::GetInterface(const nsIID &aIID, void** aInstancePtr)
{
  NS_ENSURE_ARG_POINTER(aInstancePtr);
  *aInstancePtr = 0;

  /* WindowCreator wants the main content shell when it asks a chrome window
     for this interface. */
  if (aIID.Equals(NS_GET_IID(nsIDOMWindow))) 
	{
    if (mBrowserWindow && mBrowserWindow->mWebBrowser) 
		{
      nsIDOMWindow *contentWin;
      mBrowserWindow->mWebBrowser->GetContentDOMWindow(&contentWin);
      *aInstancePtr = contentWin;
    }

    return NS_OK;
  }

  return QueryInterface(aIID, aInstancePtr);
}

//*****************************************************************************
// nsWebBrowserChrome::nsIWebBrowserChrome
//*****************************************************************************   
NS_IMETHODIMP nsWebBrowserChrome::SetStatus(PRUint32 aStatusType, const PRUnichar* aStatus)
{
   return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::SetWebBrowser(nsIWebBrowser* aWebBrowser)
{
   NS_ERROR("Haven't Implemented this yet");
   return NS_ERROR_FAILURE;
}

NS_IMETHODIMP nsWebBrowserChrome::GetWebBrowser(nsIWebBrowser** aWebBrowser)
{
  // Unimplemented, and probably will remain so; xpfe windows have docshells,
  // not webbrowsers.
  NS_ENSURE_ARG_POINTER(aWebBrowser);
  *aWebBrowser = 0;
  return NS_ERROR_FAILURE;
}

NS_IMETHODIMP nsWebBrowserChrome::SetChromeFlags(PRUint32 aChromeFlags)
{
   mChromeFlags = aChromeFlags;
   return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::GetChromeFlags(PRUint32* aChromeFlags)
{
   *aChromeFlags = mChromeFlags;
   return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::DestroyBrowserWindow()
{
   ExitModalEventLoop(NS_OK);
   return mBrowserWindow->Destroy();
}

NS_IMETHODIMP nsWebBrowserChrome::SizeBrowserTo(PRInt32 aCX, PRInt32 aCY)
{
   mSizeSet = PR_TRUE;
   mBrowserWindow->mWindow->Resize(aCX, aCY, PR_FALSE);
   mBrowserWindow->Layout(aCX, aCY);

   return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::ShowAsModal()
{
  /* Copied from nsXULWindow */
  nsCOMPtr<nsIAppShell> appShell(do_CreateInstance(kAppShellCID));
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
  if (stack && NS_SUCCEEDED(stack->Push(nsnull))) 
	{
    while (NS_SUCCEEDED(rv) && mContinueModalLoop) 
		{
      void* data;
      PRBool isRealEvent;
      PRBool processEvent;

      rv = appShell->GetNativeEvent(isRealEvent, data);
      if (NS_SUCCEEDED(rv)) 
			{
        window->ModalEventFilter(isRealEvent, data, &processEvent);
        if (processEvent)
          appShell->DispatchNativeEvent(isRealEvent, data);
      }
    }

    JSContext* cx;
    stack->Pop(&cx);
    NS_ASSERTION(!cx, "JSContextStack mismatch");
  } 
	else
    rv = NS_ERROR_FAILURE;

  mContinueModalLoop = PR_FALSE;
  window->SetModal(PR_FALSE);
  appShell->Spindown();

  return mModalStatus;
}

NS_IMETHODIMP nsWebBrowserChrome::IsWindowModal(PRBool *_retval)
{
  *_retval = mContinueModalLoop;
  return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::ExitModalEventLoop(nsresult aStatus)
{
  if (mContinueModalLoop)
    EnableParent(PR_TRUE);

  mContinueModalLoop = PR_FALSE;
  mModalStatus = aStatus;
  return NS_OK;
}

//*****************************************************************************
// nsIWebBrowserChromeFocus
//*****************************************************************************
NS_IMETHODIMP nsWebBrowserChrome::FocusNextElement()
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

NS_IMETHODIMP nsWebBrowserChrome::FocusPrevElement()
{
  return NS_ERROR_NOT_IMPLEMENTED;
}

//*****************************************************************************
// nsWebBrowserChrome::nsIEmbeddingSiteWindow
//*****************************************************************************   
NS_IMETHODIMP nsWebBrowserChrome::SetDimensions(PRUint32 aFlags, PRInt32 aX, PRInt32 aY, PRInt32 aCX, PRInt32 aCY)
{
  PRInt32 x, y, cx, cy;
  mBrowserWindow->GetPositionAndSize(&x, &y, &cx, &cy);
  if (aFlags & DIM_FLAGS_POSITION)
  {
    x = aX;
    y = aY;
  }

  if (aFlags & DIM_FLAGS_SIZE_INNER || aFlags & DIM_FLAGS_SIZE_OUTER)
  {
    cx = aCX;
    cy = aCY;
  }

  return mBrowserWindow->SetPositionAndSize(aX, aY, aCX, aCY, PR_TRUE);
}

NS_IMETHODIMP nsWebBrowserChrome::GetDimensions(PRUint32 aFlags, PRInt32 *aX, PRInt32 *aY, PRInt32 *aCX, PRInt32 *aCY)
{
  PRInt32 x, y, cx, cy;
  mBrowserWindow->GetPositionAndSize(&x, &y, &cx, &cy);
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

NS_IMETHODIMP nsWebBrowserChrome::GetSiteWindow(void ** aParentNativeWindow)
{
   NS_ENSURE_ARG_POINTER(aParentNativeWindow);

   if (mBrowserWindow) 
	 {
     nsCOMPtr<nsIWidget> window;
     mBrowserWindow->GetWindow(getter_AddRefs(window));
     if (window) 
		 {
       *aParentNativeWindow = window->GetNativeData(NS_NATIVE_WINDOW);
     }
   }
   return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::GetVisibility(PRBool *aVisibility)
{
  return mBrowserWindow->GetVisibility(aVisibility);
}

NS_IMETHODIMP nsWebBrowserChrome::SetVisibility(PRBool aVisibility)
{
  if ((mChromeFlags & nsIWebBrowserChrome::CHROME_OPENAS_CHROME) && !mChromeLoaded) 
	{
    // suppress showing the window until the chrome has completely loaded
    return NS_OK;
  } 
	else 
	{
	  if (mBrowserWindow)
	    return mBrowserWindow->SetVisibility(aVisibility);
		else
			return NS_OK;
  }
}

NS_IMETHODIMP nsWebBrowserChrome::SetFocus()
{  
	if (mBrowserWindow)
		return mBrowserWindow->SetFocus();
	else
		return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::GetTitle(PRUnichar** aTitle)
{
   return mBrowserWindow->GetTitle(aTitle);
}

NS_IMETHODIMP nsWebBrowserChrome::SetTitle(const PRUnichar* aTitle)
{
   mBrowserWindow->mTitle = aTitle;

   nsAutoString newTitle(aTitle);
   newTitle.Append(NS_LITERAL_STRING(" - IntraInter"));
   
   if (mBrowserWindow)
		mBrowserWindow->SetTitle(newTitle.get());

   return NS_OK;
}

//*****************************************************************************
// nsWebBrowserChrome::nsIWebProgressListener
//*****************************************************************************   

NS_IMETHODIMP nsWebBrowserChrome::OnProgressChange(nsIWebProgress* aProgress,
                                      nsIRequest* aRequest,
                                      PRInt32 aCurSelfProgress,
                                      PRInt32 aMaxSelfProgress, 
                                      PRInt32 aCurTotalProgress,
                                      PRInt32 aMaxTotalProgress)
{
  mProgress = aCurTotalProgress;
  mMaxProgress = aMaxTotalProgress;
  return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::OnStateChange(nsIWebProgress* aProgress,
                                  nsIRequest* aRequest,
                                  PRUint32 aProgressStateFlags,
                                  nsresult aStatus)
{
  if (aProgressStateFlags & STATE_START) 
	{
    if (aProgressStateFlags & STATE_IS_NETWORK) 
		{
      OnWindowActivityStart();
      OnLoadStart(aRequest);
    }
    
		if (aProgressStateFlags & STATE_IS_REQUEST) 
	    mTotal += 1;
  }

  if (aProgressStateFlags & STATE_STOP) 
	{
    if (aProgressStateFlags & STATE_IS_REQUEST) 
      mCurrent += 1;

    if (aProgressStateFlags & STATE_IS_NETWORK) 
		{
      OnLoadFinished(aRequest, aProgressStateFlags);
      OnWindowActivityFinished();
			mBrowserWindow->EndLoadURL(nsnull, nsnull, NS_OK);
    }
  }

  if (aProgressStateFlags & STATE_TRANSFERRING) 
    OnStatusTransferring(aRequest);

  return NS_OK;
}

NS_IMETHODIMP nsWebBrowserChrome::OnLocationChange(nsIWebProgress* aWebProgress,
                                                   nsIRequest* aRequest,
                                                   nsIURI* aURI)
{
	// TODO: Status Reporting
   return NS_OK;
}

NS_IMETHODIMP 
nsWebBrowserChrome::OnStatusChange(nsIWebProgress* aWebProgress,
                                   nsIRequest* aRequest,
                                   nsresult aStatus,
                                   const PRUnichar* aMessage)
{
    return NS_OK;
}

NS_IMETHODIMP 
nsWebBrowserChrome::OnSecurityChange(nsIWebProgress *aWebProgress, 
                                     nsIRequest *aRequest, 
                                     PRUint32 state)
{
    return NS_OK;
}

//*****************************************************************************
// nsWebBrowserChrome: Helpers
//*****************************************************************************   

//*****************************************************************************
// nsWebBrowserChrome: Accessors
//*****************************************************************************   
void nsWebBrowserChrome::BrowserWindow(rvMainWindow* aBrowserWindow)
{
   mBrowserWindow = aBrowserWindow;
}

rvMainWindow* nsWebBrowserChrome::BrowserWindow()
{
   return mBrowserWindow;
}

//*****************************************************************************
// nsWebBrowserChrome: Status Change Handling
//*****************************************************************************   

void nsWebBrowserChrome::OnLoadStart(nsIRequest* aRequest)
{
	// TODO : Status Reporting
}

void nsWebBrowserChrome::OnLoadFinished(nsIRequest* aRequest,  PRInt32 aProgressStatusFlags)
{
	// TODO: Status Reporting
}

void nsWebBrowserChrome::OnStatusDNS(nsIChannel* aChannel)
{
}

void nsWebBrowserChrome::OnStatusConnecting(nsIChannel* aChannel)
{
}

void nsWebBrowserChrome::OnStatusRedirecting(nsIChannel* aChannel)
{
}

void nsWebBrowserChrome::OnStatusNegotiating(nsIChannel* aChannel)
{
}

void nsWebBrowserChrome::OnStatusTransferring(nsIRequest* aRequest)
{
}

void nsWebBrowserChrome::OnWindowActivityStart()
{
}

void nsWebBrowserChrome::OnWindowActivityFinished()
{
}

void nsWebBrowserChrome::EnableParent(PRBool aEnable)
{
}
