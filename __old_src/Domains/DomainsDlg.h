// DomainsDlg.h : header file
//

#if !defined(AFX_DOMAINSDLG_H__93E02BBB_1008_47C7_86FB_4D2CAF522056__INCLUDED_)
#define AFX_DOMAINSDLG_H__93E02BBB_1008_47C7_86FB_4D2CAF522056__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CDomainsDlg dialog

class CDomainsDlg : public CDialog
{
// Construction
public:
	CDomainsDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CDomainsDlg)
	enum { IDD = IDD_DOMAINS_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDomainsDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CDomainsDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DOMAINSDLG_H__93E02BBB_1008_47C7_86FB_4D2CAF522056__INCLUDED_)
