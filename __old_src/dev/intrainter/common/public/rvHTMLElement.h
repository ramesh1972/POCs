#ifndef __RV_HTML_ELEMENT
#define __RV_HTML_ELEMENT

#include "rvXPCOMIds.h"

// Leaf Node Types of HTML
enum II_HTMLNodeType
{
	IIN_HTMLElement,
	IIN_WhiteSpace,
	IIN_Unknown,
	IIN_TextArea,
	IIN_Text,
	IIN_Image,
	IIN_InputText,
	IIN_InputButton,
	IIN_InputCheckBox,
	IIN_InputRadio,
	IIN_InputReset,
	IIN_InputSubmit,
	IIN_Button,
	IIN_Select,
	IIN_Anchor
};

// This class has bunch of static functions that do work on specific HTML Elements
class rvHTMLElement
{
private:
	rvHTMLElement() {}
	~rvHTMLElement() {}

public:
	static nsIDOMHTMLDocument* GetOwnerDocument(nsIDOMElement* p_element);
	static nsAutoString GetURLFromElement(nsIDOMElement* p_element);
	static II_HTMLNodeType GetNodeType(nsIDOMElement* p_dom_node);
	static nsAutoString GetFileFromURL(nsAutoString url);

	static nsIDOMHTMLDocument* GetFrameHTMLDocument(Frame* p_frame, nsAutoString p_frame_url, nsAutoString p_frame_location);
	static nsAutoString GetFrameID(nsIDOMHTMLDocument* p_doc, Frame* p_frame);
	static bool IsEventOnFrame(nsIDOMHTMLDocument* p_doc, Frame* p_frame);

	static II_RESULT GetTextElementValue(nsIDOMElement* element, nsAutoString &value);
	static II_RESULT SetTextElementValue(nsIDOMElement* element, nsAutoString value);
	
	static II_RESULT GetInputElementValue(nsIDOMElement* element, nsAutoString &value);
	static II_RESULT SetInputElementValue(nsIDOMElement* element, nsAutoString value);

	static II_RESULT GetInputElementChecked(nsIDOMElement* element, PRInt32 &value);
	static II_RESULT SetInputElementChecked(nsIDOMElement* element, PRInt32 value);

	static II_RESULT GetTextAreaElementValue(nsIDOMElement* element, nsAutoString &value);
	static II_RESULT SetTextAreaElementValue(nsIDOMElement* element, nsAutoString value);

	static II_RESULT GetOptionElementSelected(nsIDOMHTMLOptionElement* option, PRBool &value);
	static II_RESULT GetSelectElementSelectedIndices(nsIDOMElement* element, nsAutoString &value);
	static II_RESULT SetSelectElementSelectedIndices(nsIDOMElement* element, nsAutoString value);

	static II_RESULT SubmitForm(nsIDOMElement* element);
	static II_RESULT ResetForm(nsIDOMElement* element);

	static II_RESULT GetImageDimensions(nsIDOMElement* element, PRInt32 width, PRInt32 height);
	static II_RESULT GetImageFromDOMNode(nsIDOMNode* inNode, nsIImage**outImage);

	// utils
	static II_RESULT GetAttributeValue(nsIDOMElement* p_element, nsAutoString p_attr, nsAutoString &value);

};
#endif