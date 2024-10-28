; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CDomainsDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "Domains.h"

ClassCount=4
Class1=CDomainsApp
Class2=CDomainsDlg
Class3=CAboutDlg

ResourceCount=3
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDD_DOMAINS_DIALOG

[CLS:CDomainsApp]
Type=0
HeaderFile=Domains.h
ImplementationFile=Domains.cpp
Filter=N

[CLS:CDomainsDlg]
Type=0
HeaderFile=DomainsDlg.h
ImplementationFile=DomainsDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC

[CLS:CAboutDlg]
Type=0
HeaderFile=DomainsDlg.h
ImplementationFile=DomainsDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_DOMAINS_DIALOG]
Type=1
Class=CDomainsDlg
ControlCount=3
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352

