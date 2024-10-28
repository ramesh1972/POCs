#ifndef __rvPIDsDefined__
#define __rvPIDsDefined__

#include "nsWeakReference.h"
#include "nsIFilePicker.h"
#include "nsTimer.h"
#include "nsITimer.h"
#include "nsNetUtil.h"
#include "nsString.h"
#include "prio.h"

#include "nsIComponentRegistrar.h"
#include "nsICookieService.h"
#include "nsProfileDirServiceProvider.h"
#include "nsAppDirectoryServiceDefs.h"
#include "nsIEventQueueService.h"
#include "nsIPref.h"

// ================================================= //
#include "nsIAppShell.h"

#include "nsWidgetsCID.h"
#include "nsIBaseWindow.h"
#include "nsILookAndFeel.h"
#include "nsILayoutDebugger.h"
#include "nsLayoutCID.h"
#include "nsIWindowWatcher.h"

#include "nsIContent.h"
#include "nsIDocument.h"
#include "nsIDOMParser.h"
#include "nsIDOMNodeList.h"
#include "nsIDOMNamedNodeMap.h"
#include "nsIDOMElement.h"
#include "nsIDOMHTMLDocument.h"
#include "nsIDOMHTMLElement.h"
#include "nsIDOMHTMLImageElement.h"
#include "nsIDOMWindow.h"
#include "nsIDOMWindowInternal.h"
#include "nsStyleSet.h"
#include "nsICSSStyleRule.h"
#include "nsIDOMXMLDocument.h"
#include "nsIDOMAttr.h"
#include "nsIParser.h"
#include "nsParserCIID.h"
#include "nsIHTMLContentSink.h"
#include "nsIHTMLToTextSink.h"
#include "nsIDOMDocumentTraversal.h"
#include "nsIDOMTreeWalker.h"
#include "nsIDOMNodeFilter.h"
struct JSContext;
#include "nsIJSContextStack.h"
#include "nsIDOMHTMLSelectElement.h"
#include "nsIDOMHTMLInputElement.h"
#include "nsIDOMHTMLFrameElement.h"
#include "nsIDOMHTMLIFrameElement.h"
#include "nsIDOMHTMLTextAreaElement.h"
#include "nsIDOMEvent.h"
#include "nsIDOMEventTarget.h"
#include "nsIDOMHTMLAnchorElement.h"
#include "nsIDOMHTMLOptionElement.h"
#include "nsIDOMHTMLFormElement.h"
#include "nsIWebNavigation.h"
#include "nsIWebShell.h"
#include "nsIDocShell.h"
#include "nsCWebBrowser.h"
#include "nsIWebBrowserFocus.h"
#include "nsCWebBrowserPersist.h"
#include "nsIWebProgress.h"
#include "nsIProgressEventSink.h"
#include "nsIWebProgressListener.h"
#include "nsIWebBrowserChrome.h"
#include "nsIWebBrowserChromeFocus.h"
#include "nsIEmbeddingSiteWindow.h"

#include "nsEvent.h"
#include "nsGUIEvent.h"
#include "nsIEventListenerManager.h"
#include "nsIDOMEventReceiver.h"
#include "nsIDOMMouseListener.h"
#include "nsIDOMKeyListener.h"
#include "nsIDOMLoadListener.h"
#include "nsIDOMFormListener.h"
#include "nsIDOMDocumentEvent.h"
#include "nsIPrivateDOMEvent.h"

#include "nsIViewManager.h"
#include "nsIDocumentViewer.h"

#include "nsIImageLoadingContent.h"
#include "imgIContainer.h"
#include "imgIRequest.h"
#include "nsIInterfaceRequestor.h"
#include "nsIInterfaceRequestorUtils.h"
#include "gfxIImageFrame.h"
#include "nsIImage.h"
#include "nsIWebShell.h"
#include "nsIContentViewer.h"
#include "nsIDocumentViewer.h"
#include "nsIDocument.h"
#include "nsIContent.h"
#include "nsIPresShell.h"
#include "nsIPresContext.h"
#include "nsIViewManager.h"
#include "nsIFrame.h"
#include "nsIFrameDebug.h"
#include "nsIURL.h"
#include "nsNetUtil.h"
#include "nsITimer.h"
#include "nsIAtom.h"
#include "nsIFrameUtil.h"
#include "nsIComponentManager.h"
#include "nsLayoutCID.h"
#include "nsRect.h"
#include "plhash.h"
#include "nsINameSpaceManager.h"
#include "nsXPIDLString.h"
#include "nsReadableUtils.h"
#include "nsIServiceManager.h"
#include "nsIEventQueueService.h"
#include "nsIEventQueue.h"
#include "prprf.h"
#include "nsIContentViewer.h"
#include "nsIContentViewerFile.h"
#include "nsIDocShell.h"
#include "nsIWebNavigation.h"
#include "nsIWebProgress.h"
#include "nsCOMPtr.h"
#include "nsVoidArray.h"
#include "nsString.h"
#include "nsIAtom.h"
#include "nsWeakReference.h"
#include "nsIURI.h"
#include "nsIWebProgressListener.h"
#include "nsIWebBrowserChrome.h"
#include "nsIDOMText.h"

#include "nsIDOMEvent.h"
#include "nsIDOMEventTarget.h"
#include "nsIDOMEventReceiver.h"

#include "rvFileLogger.h"
#include "nsIDOMFocusListener.h"

// Windows Specific
#include <windows.h>
#include <time.h>
#include "resource.h"

#undef CreateEvent

// XPCOM GUIDS
static NS_DEFINE_CID(kEventQueueServiceCID, NS_EVENTQUEUESERVICE_CID);
static NS_DEFINE_IID(kIEventQueueServiceIID, NS_IEVENTQUEUESERVICE_IID);


static NS_DEFINE_IID(kIDOMHTMLInputElementIID, NS_IDOMHTMLINPUTELEMENT_IID);
static NS_DEFINE_IID(kIDOMHTMLImageElementIID, NS_IDOMHTMLIMAGEELEMENT_IID);


static NS_DEFINE_IID(kISupportsIID, NS_ISUPPORTS_IID);
static NS_DEFINE_IID(kIFactoryIID, NS_IFACTORY_IID);

static NS_DEFINE_CID(kAppShellCID, NS_APPSHELL_CID);
static NS_DEFINE_IID(kIAppShellIID, NS_IAPPSHELL_IID);

static NS_DEFINE_CID(kWindowCID, NS_WINDOW_CID);
static NS_DEFINE_IID(kIWidgetIID, NS_IWIDGET_IID);

static NS_DEFINE_IID(kIDOmWindowInternalIID, NS_IDOMWINDOWINTERNAL_IID);


static NS_DEFINE_IID(kChildCID, NS_CHILD_CID);

static NS_DEFINE_CID(kLookAndFeelCID, NS_LOOKANDFEEL_CID);
static NS_DEFINE_IID(kILookAndFeelIID, NS_ILOOKANDFEEL_IID);

static NS_DEFINE_IID(kCookieServiceCID, NS_COOKIESERVICE_CID);

static NS_DEFINE_IID(kIDocumentViewerIID, NS_IDOCUMENT_VIEWER_IID);

static NS_DEFINE_IID(kIDOMEventReceiverIID,   NS_IDOMEVENTRECEIVER_IID);
static NS_DEFINE_IID(kIDOMMouseListenerIID,   NS_IDOMMOUSELISTENER_IID);
static NS_DEFINE_IID(kIDOMKeyListenerIID,    NS_IDOMKEYLISTENER_IID);
static NS_DEFINE_IID(kIDOMLoadListenerIID,   NS_IDOMLOADLISTENER_IID);
static NS_DEFINE_IID(kIDOMFormListenerIID,   NS_IDOMFORMLISTENER_IID);
static NS_DEFINE_IID(kIDOMFocusListenerIID, NS_IDOMFOCUSLISTENER_IID);

static NS_DEFINE_IID(kIDOMDocumentIID, NS_IDOMDOCUMENT_IID);
static NS_DEFINE_IID(kIDOMHTMLDocumentIID, NS_IDOMHTMLDOCUMENT_IID);
static NS_DEFINE_CID(kIDOMHTMLDocumentCID, NS_HTMLDOCUMENT_CID);
static NS_DEFINE_IID(kIDOMNode, NS_IDOMNODE_IID);
static NS_DEFINE_IID(kIDOMElement, NS_IDOMELEMENT_IID);

static NS_DEFINE_CID(kXMLDocumentCID, NS_XMLDOCUMENT_CID);
static NS_DEFINE_IID(kIDOMXMLDocumentIID, NS_IDOMXMLDOCUMENT_IID);

static NS_DEFINE_CID(kWebShellCID, NS_WEB_SHELL_CID);
static NS_DEFINE_IID(kIDOCShellIID, NS_IDOCSHELL_IID);


static NS_DEFINE_IID(kILayoutDebuggerIID, NS_ILAYOUT_DEBUGGER_IID);
static NS_DEFINE_CID(kLayoutDebuggerCID, NS_LAYOUT_DEBUGGER_CID);

static NS_DEFINE_CID(kCParserCID, NS_PARSER_CID);

static NS_DEFINE_IID(kIHTMLContentSinkIID, NS_IHTML_CONTENT_SINK_IID);

static NS_DEFINE_IID(kFrameUtilCID, NS_FRAME_UTIL_CID);
static NS_DEFINE_IID(kIFrameUtilIID, NS_IFRAME_UTIL_IID);


//static NS_DEFINE_IID(kCTimer, NS_TIMER_CONTRACTID);

// all defines
#define SAMPLES_BASE_URL "resource:/res/samples"
#define MAX_TEXT_LENGTH 30000
#define FIND_WINDOW   0
#define FIND_BACK     1
#define FIND_FORWARD  2
#define FIND_LOCATION 3

#define DEFAULT_WIDTH 620
#define DEFAULT_HEIGHT 400
#define BUTTON_WIDTH 90
#define BUTTON_HEIGHT 32 

#define WEBSHELL_LEFT_INSET 5
#define WEBSHELL_RIGHT_INSET 5
#define WEBSHELL_TOP_INSET 5
#define WEBSHELL_BOTTOM_INSET 5

#define _ILOG(X) theApp->log->WriteLog("INF",X)
#define _ELOG(X) theApp->log->WriteLog("ERR",X)


#define MozStr(X) nsAutoString(NS_LITERAL_STRING(X))



#endif

