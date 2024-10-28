// GenUTCaseDlg.h : header file
//

#if !defined(AFX_GENUTCASEDLG_H__B8219C11_0C27_49DE_9D3A_664CAAA8283B__INCLUDED_)
#define AFX_GENUTCASEDLG_H__B8219C11_0C27_49DE_9D3A_664CAAA8283B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CGenUTCaseDlg dialog

class CGenUTCaseDlg : public CDialog
{
// Construction
public:
	CGenUTCaseDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CGenUTCaseDlg)
	enum { IDD = IDD_GENUTCASE_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGenUTCaseDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CGenUTCaseDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnReadXMLFile();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GENUTCASEDLG_H__B8219C11_0C27_49DE_9D3A_664CAAA8283B__INCLUDED_)
