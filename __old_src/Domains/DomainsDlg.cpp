// DomainsDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Domains.h"
#include "DomainsDlg.h"

#import "c:\winnt\system32\activeds.tlb" no_namespace

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDomainsDlg dialog

CDomainsDlg::CDomainsDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDomainsDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDomainsDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CDomainsDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDomainsDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDomainsDlg, CDialog)
	//{{AFX_MSG_MAP(CDomainsDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDomainsDlg message handlers

BOOL CDomainsDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CDomainsDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CDomainsDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CDomainsDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CDomainsDlg::OnOK() 
{
	LPWSTR target;
	IDsBrowseDomainTreePtr *pDSB;
	
	CoInitialize(NULL);
	HRESULT hr = CoCreateInstance(CLSID_DsDomainTreeBrowser,
                           NULL,
                           CLSCTX_INPROC_SERVER,
                           IID_IDsBrowseDomainTree,
                           (void**)&pDSB);
 
	// specify computer and credentials for retrieving domain information.
	hr = pDSB->SetComputer(L"rameshv", L"rameshv", L"2%codeshare")
 
	// bring up a domain browser against "myMachine" and the given credentials.
	hr = pDSB->BrowseTo(GetTopDeskWindow(),&target, DBDTF_RETURNFQDN);
 
	// Retrieve trust domains of "myMachine":
	// Can be any of the following: DOMAIN_TREE domains; DOMAINTREE 
	//domains; PDOMAINTREE domains; LPDOMAINTREE domains;
	//PDOMAINTREE domains.
	
	hr = pDSB->GetDomains(&domains, DBDTF_RETURNFQDN);
 
	// Flush internal cache before retargeting to a different machine:
	hr = pDSB->FlushCachedDomains();
	hr = pDSB->SetComputer(L"yourComputer", L"admin", L"passwd");
	hr = pDSB->GetDomains(&domains, DBDTF_RETURNFQDN);
 
	// Frees domains
	pDSB->FreeDomains(&domains);
 
	pDSB->Release();
	CoUninitialize(); 	
	
	CDialog::OnOK();
}
