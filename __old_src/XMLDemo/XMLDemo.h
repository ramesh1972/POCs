// XMLDemo.h : main header file for the XMLDEMO application
//

#if !defined(AFX_XMLDEMO_H__E47F3616_A41F_4421_B80A_635AFF572A52__INCLUDED_)
#define AFX_XMLDEMO_H__E47F3616_A41F_4421_B80A_635AFF572A52__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CXMLDemoApp:
// See XMLDemo.cpp for the implementation of this class
//

class CXMLDemoApp : public CWinApp
{
public:
	CXMLDemoApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CXMLDemoApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CXMLDemoApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_XMLDEMO_H__E47F3616_A41F_4421_B80A_635AFF572A52__INCLUDED_)
