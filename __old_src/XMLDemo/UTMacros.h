// This header contains the Unit Test (UT) Case load, execution, save results macros
// Must be included in the project/program that you want to test.
// Once included, simply call the 4 macros defined below to set your 
// points of testing.

#define  DO_UT 1

#ifndef _UT_MACROS_INCLUDED_
#define _UT_MACROS_INCLUDED_

// Highest Level Check for doing UT or not
// If the following Base Macro is defined, define all other UT Macros
// or else set all other UT Macros to ""
#ifdef DO_UT

// Include standard ATL and XML Headers\Libs
#include <atlbase.h>
#import <msxml3.dll> raw_interfaces_only
using namespace MSXML2;
// These are the UT Functions
// Note : Read these functions after reading the macros defined below

// Function to set the value of the variable
// 1. Get the DOM Node that corresponds to UTCaseID
// 2. Get the Value stored in the DOM Node
// 3. Based on the type of the Variable passed, set the value
// 4. That's about setting input values for the Unit Test Case
void do_ut_set_var(char* UTCaseID, void* VariableName, char* VariableType) {
}

// Function to check the value of the variable
// 1. Get the DOM Node that corresponds to UTCaseID
// 2. Get the Value stored in the DOM Node
// 3. Based on the type of the Variable passed to the macro, check/test the value
// 4. Report the result back to XML Node
// 5. Continue or End testing as the case may be
void do_ut_check_var(char* UTCaseID, void* VariableName, char* VariableType) {
}

// These are the UT Macros
// This is the Macro to begin UT
// 1. Declare all the global variables requried for Unit Testing
#define BEGIN_UT(UTCaseXMLFileName) \
	HRESULT ghr; \
	IXMLDOMDocument* gUTDocRoot; \
	IXMLDOMElement* gUTElement; \
	IXMLDOMNodeList* gUTNodeList; \
	IXMLDOMNode* gUTNode; \
	VARIANT_BOOL gStatus; \
	VARIANT vUTSrcFileName; \
	\
	ghr = CoInitialize(NULL); \
	\
	ghr = CoCreateInstance(__uuidof(DOMDocument), NULL, CLSCTX_INPROC_SERVER, \
						  __uuidof(IXMLDOMDocument), (void**) &gUTDocRoot);  \
	\
	VariantInit(&vUTSrcFileName); \
	V_BSTR(&vUTSrcFileName) = SysAllocString(L##UTCaseXMLFileName); \
	V_VT(&vUTSrcFileName) = VT_BSTR; \
	gUTDocRoot->load(vUTSrcFileName, &gStatus); \
	\
	ghr = gUTDocRoot->get_documentElement(&gUTElement); \
	\
    ghr = gUTElement->get_childNodes(&gUTNodeList); 
	
// This ends the Testing process
// 1. Save the XML document to a result xml file
// 2. Clean up 
// 3. Unintialize COM
#define END_UT CoUninitialize();

// This sets a value for a variable
#define DO_UT_SET_VAR(UTCaseID, VariableName,VariableType)

// This macro checks the value of the variable
#define DO_UT_CHECK_VAR(UTCaseID, VariableName, VariableType)

// NULL Macros
#else
#define BEGIN_UT(UTCaseXMLFileName) 
#define END_UT 
#define DO_UT_SET_VAR(UTCaseID, VariableName,VariableType)
#define DO_UT_CHECK_VAR(UTCaseID, VariableName, VariableType)
#endif
#endif