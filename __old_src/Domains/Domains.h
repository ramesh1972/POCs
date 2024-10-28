// Domains.h : main header file for the DOMAINS application
//

#if !defined(AFX_DOMAINS_H__6BB26D59_6598_4FE4_90F7_3BB99F676597__INCLUDED_)
#define AFX_DOMAINS_H__6BB26D59_6598_4FE4_90F7_3BB99F676597__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CDomainsApp:
// See Domains.cpp for the implementation of this class
//

class CDomainsApp : public CWinApp
{
public:
	CDomainsApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDomainsApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CDomainsApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DOMAINS_H__6BB26D59_6598_4FE4_90F7_3BB99F676597__INCLUDED_)
