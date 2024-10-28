// XMLDemoDlg.h : header file
//

#if !defined(AFX_XMLDEMODLG_H__F52A96AA_5C13_4A3E_85EE_C1ECCDA9DCCB__INCLUDED_)
#define AFX_XMLDEMODLG_H__F52A96AA_5C13_4A3E_85EE_C1ECCDA9DCCB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CXMLDemoDlg dialog

class CXMLDemoDlg : public CDialog
{
// Construction
public:
	CXMLDemoDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CXMLDemoDlg)
	enum { IDD = IDD_XMLDEMO_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CXMLDemoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CXMLDemoDlg)
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

#endif // !defined(AFX_XMLDEMODLG_H__F52A96AA_5C13_4A3E_85EE_C1ECCDA9DCCB__INCLUDED_)
