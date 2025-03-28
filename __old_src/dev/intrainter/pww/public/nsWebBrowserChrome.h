/* -*- Mode: IDL; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 2 -*-
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

#ifndef nsWebBrowserChrome_h__
#define nsWebBrowserChrome_h__

#include "rvXPCOMIDs.h"

class rvMainWindow;
class nsWebBrowserChrome : public nsIWebBrowserChrome,
                           public nsIWebBrowserChromeFocus,
                           public nsIEmbeddingSiteWindow,
                           public nsIWebProgressListener,
                           public nsIInterfaceRequestor,
                           public nsSupportsWeakReference
{
friend class rvMainWindow;

public:
   NS_DECL_ISUPPORTS

   NS_DECL_NSIWEBBROWSERCHROME
   NS_DECL_NSIWEBBROWSERCHROMEFOCUS
   NS_DECL_NSIEMBEDDINGSITEWINDOW
   NS_DECL_NSIWEBPROGRESSLISTENER
   NS_DECL_NSIINTERFACEREQUESTOR

public:
   nsWebBrowserChrome();
   virtual ~nsWebBrowserChrome();

   void BrowserWindow(rvMainWindow* aBrowserWindow);
   rvMainWindow* BrowserWindow();

   // Status Change Handling
   void OnLoadStart(nsIRequest* aRequest);
   void OnLoadFinished(nsIRequest* aRequest, PRInt32 aProgressStatusFlags);
   void OnStatusDNS(nsIChannel* aChannel);
   void OnStatusConnecting(nsIChannel* aChannel);
   void OnStatusRedirecting(nsIChannel* aChannel);
   void OnStatusNegotiating(nsIChannel* aChannel);
   void OnStatusTransferring(nsIRequest* aRequest);
   void OnWindowActivityStart();
   void OnWindowActivityFinished();

  void EnableParent(PRBool aEnable);

  rvMainWindow*  mBrowserWindow;

protected:   
   PRPackedBool mContinueModalLoop;
   PRPackedBool mSizeSet;
   PRPackedBool mChromeLoaded;
   PRUint32 mChromeFlags;
   nsresult mModalStatus;
   PRInt32 mActiveDocuments;
   PRInt32 mCurrent, mTotal, mProgress, mMaxProgress;
};

#endif /* nsWebBrowserChrome_h__ */
