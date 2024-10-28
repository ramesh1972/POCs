// GenUTCase.h : main header file for the GENUTCASE application
//

#if !defined(AFX_GENUTCASE_H__112E889F_6801_4258_B429_DE6F1E465987__INCLUDED_)
#define AFX_GENUTCASE_H__112E889F_6801_4258_B429_DE6F1E465987__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CGenUTCaseApp:
// See GenUTCase.cpp for the implementation of this class
//

class CGenUTCaseApp : public CWinApp
{
public:
	CGenUTCaseApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGenUTCaseApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CGenUTCaseApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GENUTCASE_H__112E889F_6801_4258_B429_DE6F1E465987__INCLUDED_)
