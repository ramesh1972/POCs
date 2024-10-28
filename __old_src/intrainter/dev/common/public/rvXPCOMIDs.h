#pragma warning(disable:4786)
#pragma warning(disable:4800)
#pragma warning(disable:4273)
#pragma warning(disable:4355)

#ifndef __rvPIDsDefined__
#define __rvPIDsDefined__

// Mozilla Specific Includes
#include "nspr/prio.h"
#include "nspr/plhash.h"
#include "nspr/prprf.h"

#include "string/nsString.h"
#include "string/nsXPIDLString.h"
#include "string/nsReadableUtils.h"

#include "xpcom/nsCOMPtr.h"
#include "xpcom/nsIInterfaceRequestor.h"
#include "xpcom/nsIInterfaceRequestorUtils.h"
#include "xpcom/nsIComponentManager.h"
#include "xpcom/nsIServiceManager.h"
#include "xpcom/nsIEventQueueService.h"
#include "xpcom/nsIEventQueue.h"
#include "xpcom/nsVoidArray.h"
#include "xpcom/nsITimer.h"
#include "xpcom/nsIComponentRegistrar.h"
#include "xpcom/nsAppDirectoryServiceDefs.h"
#include "xpcom/nsIEventQueueService.h"
#include "xpcom/nsIAtom.h"
#include "xpcom/nsIWeakReference.h"
#include "xpcom/nsWeakReference.h"

#include "necko/nsNetUtil.h"
#include "necko/nsICookieService.h"
#include "necko/nsIProgressEventSink.h"
#include "necko/nsIURL.h"
#include "necko/nsNetUtil.h"

#include "uriloader/nsIWebProgress.h"
#include "uriloader/nsIWebProgressListener.h"

#include "gfx/gfxIImageFrame.h"
#include "gfx/nsIImage.h"
#include "gfx/nsRect.h"

#include "widget/nsIFilePicker.h"
#include "widget/nsWidgetsCID.h"
#include "widget/nsIBaseWindow.h"
#include "widget/nsILookAndFeel.h"
#include "widget/nsIAppShell.h"
#include "widget/nsEvent.h"
#include "widget/nsGUIEvent.h"
#include "embed_base/nsIWindowCreator.h"

#include "layout/nsIFrameUtil.h"
#include "layout/nsLayoutCID.h"
#include "layout/nsILayoutDebugger.h"
#include "layout/nsLayoutCID.h"
#include "layout/nsIPresShell.h"
#include "layout/nsIPresContext.h"
#include "layout/nsIFrame.h"
#include "layout/nsIFrameDebug.h"

#include "docshell/nsIContentViewerFile.h"
#include "docshell/nsIWebNavigation.h"
#include "docshell/nsIDocShell.h"
#include "docshell/nsIContentViewer.h"
#include "webshell/nsIWebShell.h"

#include "webbrwsr/nsCWebBrowser.h"
#include "webbrwsr/nsIWebBrowserFocus.h"
#include "webbrwsr/nsIWebBrowserChrome.h"
#include "webbrwsr/nsIWebBrowserChromeFocus.h"
#include "webbrwsr/nsIEmbeddingSiteWindow.h"

#include "content/nsIContent.h"
#include "content/nsIDocument.h"
#include "content/nsStyleSet.h"
#include "content/nsICSSStyleRule.h"
#include "content/nsIEventListenerManager.h"
#include "content/nsIDocumentViewer.h"
#include "content/nsIImageLoadingContent.h"
#include "content/nsINameSpaceManager.h"
#include "content/nsIPrivateDOMEvent.h"

#include "dom/nsIDOMNodeList.h"
#include "dom/nsIDOMNamedNodeMap.h"
#include "dom/nsIDOMElement.h"
#include "dom/nsIDOMHTMLDocument.h"
#include "dom/nsIDOMHTMLElement.h"
#include "dom/nsIDOMHTMLImageElement.h"
#include "dom/nsIDOMWindow.h"
#include "dom/nsIDOMWindowInternal.h"
#include "dom/nsIDOMHTMLSelectElement.h"
#include "dom/nsIDOMHTMLInputElement.h"
#include "dom/nsIDOMHTMLFrameElement.h"
#include "dom/nsIDOMHTMLIFrameElement.h"
#include "dom/nsIDOMHTMLTextAreaElement.h"
#include "dom/nsIDOMEvent.h"
#include "dom/nsIDOMEventTarget.h"
#include "dom/nsIDOMHTMLAnchorElement.h"
#include "dom/nsIDOMHTMLOptionElement.h"
#include "dom/nsIDOMHTMLFormElement.h"
#include "dom/nsIDOMXMLDocument.h"
#include "dom/nsIDOMAttr.h"
#include "dom/nsIDOMDocumentTraversal.h"
#include "dom/nsIDOMTreeWalker.h"
#include "dom/nsIDOMNodeFilter.h"
#include "dom/nsIDOMEventReceiver.h"
#include "dom/nsIDOMMouseListener.h"
#include "dom/nsIDOMKeyListener.h"
#include "dom/nsIDOMLoadListener.h"
#include "dom/nsIDOMFormListener.h"
#include "dom/nsIDOMDocumentEvent.h"
#include "dom/nsIDOMText.h"
#include "dom/nsIDOMFocusListener.h"

#include "htmlparser/nsIParser.h"
#include "htmlparser/nsParserCIID.h"
#include "htmlparser/nsIHTMLContentSink.h"
#include "content/nsIHTMLToTextSink.h"

#include "windowwatcher/nsIWindowWatcher.h"
#include "profdirserviceprovider/nsProfileDirServiceProvider.h"
#include "pref/nsIPref.h"
struct JSContext;
#include "xpconnect/nsIJSContextStack.h"
#include "xmlextras/nsIDOMParser.h"
#include "webbrowserpersist/nsCWebBrowserPersist.h"
#include "view/nsIViewManager.h"
#include "imglib2/imgIContainer.h"
#include "imglib2/imgIRequest.h"

// Windows Specific Includes
#include <windows.h>
#include <time.h>
#include <map>
#include <string>

#undef CreateEvent

// Mozilla Specific Defines
static NS_DEFINE_IID(kISupportsIID, NS_ISUPPORTS_IID);
static NS_DEFINE_IID(kIFactoryIID, NS_IFACTORY_IID);
static NS_DEFINE_CID(kEventQueueServiceCID, NS_EVENTQUEUESERVICE_CID);
static NS_DEFINE_IID(kIEventQueueServiceIID, NS_IEVENTQUEUESERVICE_IID);
static NS_DEFINE_IID(kCookieServiceCID, NS_COOKIESERVICE_CID);

static NS_DEFINE_CID(kAppShellCID, NS_APPSHELL_CID);
static NS_DEFINE_IID(kIAppShellIID, NS_IAPPSHELL_IID);
static NS_DEFINE_CID(kWebShellCID, NS_WEB_SHELL_CID);
static NS_DEFINE_IID(kIDOCShellIID, NS_IDOCSHELL_IID);
static NS_DEFINE_CID(kStandardURLCID, NS_STANDARDURL_CID);    

static NS_DEFINE_IID(kILayoutDebuggerIID, NS_ILAYOUT_DEBUGGER_IID);
static NS_DEFINE_CID(kLayoutDebuggerCID, NS_LAYOUT_DEBUGGER_CID);

static NS_DEFINE_CID(kWindowCID, NS_WINDOW_CID);
static NS_DEFINE_IID(kIWidgetIID, NS_IWIDGET_IID);
static NS_DEFINE_IID(kChildCID, NS_CHILD_CID);
static NS_DEFINE_CID(kLookAndFeelCID, NS_LOOKANDFEEL_CID);
static NS_DEFINE_IID(kILookAndFeelIID, NS_ILOOKANDFEEL_IID);

static NS_DEFINE_CID(kXMLDocumentCID, NS_XMLDOCUMENT_CID);
static NS_DEFINE_IID(kIDOMXMLDocumentIID, NS_IDOMXMLDOCUMENT_IID);
static NS_DEFINE_IID(kIDOMDocumentIID, NS_IDOMDOCUMENT_IID);
static NS_DEFINE_IID(kIDOMHTMLDocumentIID, NS_IDOMHTMLDOCUMENT_IID);
static NS_DEFINE_CID(kIDOMHTMLDocumentCID, NS_HTMLDOCUMENT_CID);

static NS_DEFINE_IID(kIDOMEventReceiverIID,   NS_IDOMEVENTRECEIVER_IID);
static NS_DEFINE_IID(kIDOMMouseListenerIID,   NS_IDOMMOUSELISTENER_IID);
static NS_DEFINE_IID(kIDOMKeyListenerIID,    NS_IDOMKEYLISTENER_IID);
static NS_DEFINE_IID(kIDOMLoadListenerIID,   NS_IDOMLOADLISTENER_IID);
static NS_DEFINE_IID(kIDOMFormListenerIID,   NS_IDOMFORMLISTENER_IID);
static NS_DEFINE_IID(kIDOMWindowInternalIID, NS_IDOMWINDOWINTERNAL_IID);
static NS_DEFINE_IID(kIDOMFocusListenerIID, NS_IDOMFOCUSLISTENER_IID);

static NS_DEFINE_IID(kIDOMNode, NS_IDOMNODE_IID);
static NS_DEFINE_IID(kIDOMElement, NS_IDOMELEMENT_IID);
static NS_DEFINE_IID(kIDOMHTMLInputElementIID, NS_IDOMHTMLINPUTELEMENT_IID);
static NS_DEFINE_IID(kIDOMHTMLImageElementIID, NS_IDOMHTMLIMAGEELEMENT_IID);

static NS_DEFINE_CID(kCParserCID, NS_PARSER_CID);
static NS_DEFINE_IID(kIHTMLContentSinkIID, NS_IHTML_CONTENT_SINK_IID);
static NS_DEFINE_IID(kFrameUtilCID, NS_FRAME_UTIL_CID);
static NS_DEFINE_IID(kIFrameUtilIID, NS_IFRAME_UTIL_IID);
static NS_DEFINE_IID(kIDocumentViewerIID, NS_IDOCUMENT_VIEWER_IID);

// PWW Specific Defines
#define SAMPLES_BASE_URL "resource:/res/samples"

#define PWW_DATA_ROOT NS_LITERAL_STRING("C:\\MyReleases\\intrainter\\dev\\")
#define PWW_DATA_ROOT_FILE_PROTOCOL NS_LITERAL_STRING("file:///c:/MyReleases/intrainter/dev/")

#define PWW_LOG_DIR NS_LITERAL_STRING("pww-logs")
#define PWW_LOG_FILE_PREFIX NS_LITERAL_STRING("pww-log-")
#define PWW_APP_DIR NS_LITERAL_STRING("pww-app-files")
#define PWW_CACHE_DIR NS_LITERAL_STRING("pww-cache-files")
#define PWW_ARCHIVE_DIR NS_LITERAL_STRING("pww-archive")
#define PWW_TEST_DIR NS_LITERAL_STRING("pww-test-data")
#define PWW_XML_DB_DIR NS_LITERAL_STRING("pww-xml-db")
#define PWW_RULES_FILE NS_LITERAL_STRING("RulesDB.xml")

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

// PWW Specific Includes
#include "..\res\resource.h"
#include "rvFileLogger.h"
#include "rvMessages.h"
#include "rvMessageList.h"

// defines
#define II_DOCUMENT_LOAD_TIMEOUT 60 // seconds

// basic defines for the app
#define IAPPG extern rvMyMozApp* theApp
#define IAPP theApp
#define IPWW theApp->mParentWindow
#define ON_THE_RUN(X) \
	if (theApp == nsnull || theApp->mParentWindow == nsnull) \
	{\
		IL_TAB;\
		ILOG << " * * Red Alert * * : Application/ParentWindow Object Non Existant" << IFTL;\
		IL_UNTAB;\
		exit(-1);\
		return X;\
	}

#define II_ENSURE_INSTANCE(X) \
		if (X == nsnull)\
		{\
			ILOG << "Null Element" << IERR;\
			return IIR_NULL_INSTANCE;\
		}\

#define II_ENSURE_INSTANCE_RETURN(X,R) \
		if (X == nsnull)\
		{\
			ILOG << "Null Element" << IERR;\
			return R;\
		}\


#define II_ENSURE_INTERFACE(X) \
		if (X == nsnull)\
		{\
			ILOG << "Null Element" << IERR;\
			return IIR_NULL_INSTANCE;\
		}\

#define II_ENSURE_NS_RESULT_RETURN(X,R) \
		if (NS_FAILED(X))\
		{\
			ILOG << "XPCOM Call Failed:rv:" << X << IERR;\
			return R;\
		}\

#define II_ENSURE_NS_RESULT(X) \
		if (NS_FAILED(X))\
		{\
			ILOG << "XPCOM Call Failed:rv:" << X << IERR;\
			return IIR_NS_RESULT_FAILED;\
		}\

#define II_ENSURE(X, Y) \
		if (X != IIR_SUCCESS)\
		{\
			ILOG << "Call Failed:res:" << IMSG(X) << IERR;\
			return Y;\
		}

#define II_GET_INTERFACE(O,I,R) \
		II_ENSURE_INSTANCE(O) \
		nsCOMPtr<I> R; \
		R = do_QueryInterface(O); \
		II_ENSURE_INTERFACE(R); \

// basic defines for log/error messages
typedef long II_RESULT;

#define ILOG CFileLogger::GetInstance()
#define IMSG(X) CTextMessages::GetInstance().GetMessage(X)

#define IL_TAB   ++(ILOG)
#define IL_UNTAB --(ILOG)

#define IFTL IILL_Fatal 
#define IERR IILL_Error
#define IEXC IILL_Exception
#define IINF IILL_Info
#define IDBG IILL_Debug
 
// defines for the main browser window
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
	IIMA_Browse,
	IIMA_Merge,
	IIMA_PickMode,
	IIMA_ProcessRule,
	IIMA_None,

	IIMA_Unknown
};

enum II_WindowType
{
	IIW_WWW,
	IIW_WWW_Popup,
	IIW_Form,

	IIW_PWW,
	IIW_Alert,
	IIW_AlertView,
	IIW_RuleProcessor,
	IIW_RuleProcessor_Popup,

	IIW_Unknown
};

// defines for rules
#define IRULESG extern rvXmlDocument* _rules_doc

// util macros
#define MozStr(X) nsAutoString(NS_LITERAL_STRING(X))

// temp
#define _ILOG 

using namespace std;
#endif

