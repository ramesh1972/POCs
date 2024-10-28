#include "rvXmlDocument.h"
#include "rvHTMLElement.h"

II_HTMLNodeType rvHTMLElement::GetNodeType(nsIDOMElement* p_dom_node)
{
	ILOG << "rvHTMLElement::GetNodeType()" << IDBG;
	IL_TAB;

	// Check if this is a valid node
	if (p_dom_node == nsnull)
	{
		ILOG << "NULL pointer passed in" << IERR;	
		IL_UNTAB;
		return IIN_Unknown;
	}

	// get the next genuine node, that is not whitespace
	if (rvXmlDocument::IsWhiteSpace(p_dom_node))
	{
		ILOG << "NodeType=" << "IIN_WhiteSpace" << IDBG;
		IL_UNTAB;

		return IIN_WhiteSpace;
	}

	nsAutoString node_name;
	p_dom_node->GetNodeName(node_name);
	ILOG << "DOM Node Name : " << node_name << IDBG;

	if (node_name.EqualsIgnoreCase("#text"))
	{
		ILOG << "NodeType=" << "IIN_Text" << IDBG;
		IL_UNTAB;

		return IIN_Text;
	}
	else if (node_name.EqualsIgnoreCase("textarea"))
	{
		ILOG << "NodeType=" << "IIN_TextArea" << IDBG;
		IL_UNTAB;

		return IIN_TextArea;
	}
	else if (node_name.EqualsIgnoreCase("img") || node_name.EqualsIgnoreCase("image"))
	{
		ILOG << "NodeType=" << "IIN_Image" << IDBG;
		IL_UNTAB;

		return IIN_Image;
	}
	else if (node_name.EqualsIgnoreCase("a") || node_name.EqualsIgnoreCase("anchor"))
	{
		ILOG << "NodeType=" << "IIN_Anchor" << IDBG;
		IL_UNTAB;

		return IIN_Anchor;
	}
	else if (node_name.EqualsIgnoreCase("input"))
	{
		nsAutoString type;
		GetAttributeValue(p_dom_node, MozStr("type"), type);
		ILOG << "NodeType=" << "IIN_Input:" << type << IDBG;
		IL_UNTAB;

		if (type.EqualsIgnoreCase("text"))
			return IIN_InputText;
		if (type.EqualsIgnoreCase("button"))
			return IIN_InputButton;
		if (type.EqualsIgnoreCase("checkbox"))
			return IIN_InputCheckBox;
		if (type.EqualsIgnoreCase("radio"))
			return IIN_InputRadio;
		if (type.EqualsIgnoreCase("reset"))
			return IIN_InputReset;
		if (type.EqualsIgnoreCase("submit"))
			return IIN_InputSubmit;

		return IIN_InputText;
	}
	else if (node_name.EqualsIgnoreCase("button"))
	{
		ILOG << "NodeType=" << "IIN_Button" << IDBG;
		IL_UNTAB;

		return IIN_Button;
	}
	else if (node_name.EqualsIgnoreCase("select"))
	{
		ILOG << "NodeType=" << "IIN_Select" << IDBG;
		IL_UNTAB;

		return IIN_Select;
	}

  ILOG << "NodeType=" << "IIN_NotALeaf" << IDBG;
	IL_UNTAB;

	return IIN_HTMLElement;
}

nsAutoString rvHTMLElement::GetFileFromURL(nsAutoString p_url)
{
	PRInt32 pos = p_url.RFind("?");
	if (pos == -1)
		return p_url;

	nsAutoString url;
	p_url.Left(url, pos);
	return url;

	/*nsresult rv;
  nsCOMPtr<nsIURL> iurl = do_CreateInstance(kStandardURLCID, &rv);
  if (NS_SUCCEEDED(rv)) 
	{
		nsCAutoString curl;
		LossyCopyUTF16toASCII(p_url, curl);
		
		nsCAutoString file;
		iurl->SetSpec(curl);
    rv = iurl->GetFileName(file);

		if (NS_SUCCEEDED(rv))
		{
			nsAutoString file1;
			CopyASCIItoUTF16(file, file1);
			return file1;
		}
	}

	*/
	return MozStr("");
}

nsIDOMHTMLDocument* rvHTMLElement::GetFrameHTMLDocument(Frame* p_frame, nsAutoString p_frame_url, nsAutoString p_frame_location)
{
	ILOG << "Frame URL:" << p_frame->m_url << IINF;
	ILOG << "Frame Location:" << p_frame->m_id << IINF;
	IL_TAB;

	if (p_frame == nsnull)
		return nsnull;

	// the frame urls many times contain a session string/timestamp etc..in the parameters. So comparing
	// the currrently loaded url with the original one will fail.
	// So strip the parameters path and then check. NOTE: the frame url passed for the check
	// should already be without the params.
	// In case of non frame documents, the urls most likely will have such params. But it is not
	// an issue there since only the starting url is used and all the other urls that are loaded are
	// not needed.
	nsAutoString f_url = GetFileFromURL(p_frame->m_url);

	if (f_url == p_frame_url && p_frame->m_id == p_frame_location)
		return p_frame->m_doc;

	Frame* frm = nsnull;
	PRInt32 idx = 0;
	while (p_frame->m_sub_frames != nsnull && idx < p_frame->m_sub_frames->Count())
	{
		nsIDOMHTMLDocument* doc = GetFrameHTMLDocument((Frame*) p_frame->m_sub_frames->ElementAt(idx++), p_frame_url, p_frame_location);
		if (doc != nsnull)
		{
			IL_UNTAB;
			return doc;
		}
	}

	IL_UNTAB;
	return nsnull;
}

nsAutoString rvHTMLElement::GetFrameID(nsIDOMHTMLDocument* p_doc, Frame* p_frame)
{
	if (p_frame->m_doc == p_doc)
		return p_frame->m_id;

	Frame* frm = nsnull;
	PRInt32 idx = 0;
	while (p_frame->m_sub_frames != nsnull && idx < p_frame->m_sub_frames->Count())
	{
		nsAutoString id = GetFrameID(p_doc, (Frame*) p_frame->m_sub_frames->ElementAt(idx++));
		if (id != MozStr(""))
			return id;
	}

	return MozStr("");
}

bool rvHTMLElement::IsEventOnFrame(nsIDOMHTMLDocument* p_doc, Frame* p_frame)
{
	PRInt32 idx = 0;
	if (p_frame != nsnull && p_frame->m_sub_frames == nsnull)
		return false;

	PRInt32 cnt = p_frame->m_sub_frames->Count();
	while (idx < cnt)
	{
		Frame* child = (Frame*) p_frame->m_sub_frames->ElementAt(idx++);
		if (child->m_doc == p_doc)
			return true;

		if (IsEventOnFrame(p_doc, child))
			return true;
	}

	return false;
}


II_RESULT rvHTMLElement::GetImageFromDOMNode(nsIDOMNode* inNode, nsIImage**outImage)
{
	try
	{
		*outImage = nsnull;

		nsCOMPtr<nsIImageLoadingContent> content(do_QueryInterface(inNode));
		if (!content) {
			return IIR_NULL_INTERFACE;
		}

		nsCOMPtr<imgIRequest> imgRequest;
		content->GetRequest(nsIImageLoadingContent::CURRENT_REQUEST,
												getter_AddRefs(imgRequest));
		if (!imgRequest) {
			return IIR_NULL_INTERFACE;
		}
  
		nsCOMPtr<imgIContainer> imgContainer;
		imgRequest->GetImage(getter_AddRefs(imgContainer));

		if (!imgContainer) {
			return IIR_NULL_INTERFACE;
		}
    
		nsCOMPtr<gfxIImageFrame> imgFrame;
		imgContainer->GetFrameAt(0, getter_AddRefs(imgFrame));

		if (!imgFrame) {
			return IIR_NULL_INTERFACE;
		}
  
		nsCOMPtr<nsIInterfaceRequestor> ir = do_QueryInterface(imgFrame);

		if (!ir) {
			return IIR_NULL_INTERFACE;
		}
  
		nsresult rv = CallGetInterface(ir.get(), outImage);
		II_ENSURE_NS_RESULT_RETURN(rv, IIR_FAILED)
		return IIR_SUCCESS;
	}
	catch(...)
	{
		IL_TAB;
		ILOG << "Caught Exception:Failed to get image object" << IEXC;
		IL_UNTAB;
		*outImage = nsnull;
		return IIR_EXCEPTION;
	}
}

II_RESULT rvHTMLElement::GetAttributeValue(nsIDOMElement* p_element, nsAutoString p_attr, nsAutoString &value)
{
	II_ENSURE_INSTANCE(p_element)
	nsresult rv = p_element->GetAttribute(p_attr, value);
	II_ENSURE_NS_RESULT(rv)

	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::GetTextElementValue(nsIDOMElement* element, nsAutoString &value)
{
	II_ENSURE_INSTANCE(element)
	nsresult rv = element->GetNodeValue(value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Got Text Element Value:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::GetInputElementValue(nsIDOMElement* element, nsAutoString &value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLInputElement, ielement);
	nsresult rv = ielement->GetValue(value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Got Input Element Value:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::SetInputElementValue(nsIDOMElement* element, nsAutoString value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLInputElement, ielement);
	nsresult rv = ielement->SetValue(value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Set Input Element Value:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::GetInputElementChecked(nsIDOMElement* element, PRInt32 &value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLInputElement, ielement);
	nsresult rv = ielement->GetChecked(&value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Got Input Element Checked:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::SetInputElementChecked(nsIDOMElement* element, PRInt32 value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLInputElement, ielement);
	nsresult rv = ielement->SetChecked(value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Set Input Element Checked:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::GetTextAreaElementValue(nsIDOMElement* element, nsAutoString &value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLTextAreaElement, ielement);
	nsresult rv = ielement->GetValue(value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Got TextArea Element value:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::SetTextAreaElementValue(nsIDOMElement* element, nsAutoString value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLTextAreaElement, ielement);
	nsresult rv = ielement->SetDefaultValue(value);
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Set TextArea Element value:" << value << IDBG;
	return IIR_SUCCESS;
}


II_RESULT rvHTMLElement::GetSelectElementSelectedIndices(nsIDOMElement* element, nsAutoString &value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLSelectElement, selement);
	
	nsCOMPtr<nsIDOMHTMLOptionsCollection> col;
	nsresult rv1 = selement->GetOptions(getter_AddRefs(col));
	II_ENSURE_INTERFACE(col)
	II_ENSURE_NS_RESULT(rv1)

	PRUint32 len = 0;col->GetLength(&len);
	for (PRInt32 idx=0;idx < len;idx++)
	{
		nsCOMPtr<nsIDOMHTMLOptionElement> opt = nsnull;
		nsresult rv2 = col->Item(idx, (nsIDOMNode**) &opt);
		II_ENSURE_INTERFACE(opt)
		II_ENSURE_NS_RESULT(rv2)
		
		PRBool selected = PR_FALSE;
		II_RESULT res = GetOptionElementSelected((nsIDOMHTMLOptionElement*) opt, selected);
		II_ENSURE(res, res)

		if (selected)
		{
			nsAutoString idxstr;
			idxstr.Append(MozStr(","));
			idxstr.AppendInt(idx);
			idxstr.Append(MozStr(","));
			value.Append(idxstr);
		}
	}

	ILOG << "Select Value Created:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::GetOptionElementSelected(nsIDOMHTMLOptionElement* option, PRBool &value)
{
	II_ENSURE_INSTANCE(option)
	nsresult rv = option->GetSelected(&value);
	II_ENSURE_NS_RESULT(rv)

	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::SetSelectElementSelectedIndices(nsIDOMElement* element, nsAutoString value)
{
	II_GET_INTERFACE(element, nsIDOMHTMLSelectElement, selement);

	nsCOMPtr<nsIDOMHTMLOptionsCollection> col;
	nsresult rv1 = selement->GetOptions(getter_AddRefs(col));
	II_ENSURE_INTERFACE(col)
	II_ENSURE_NS_RESULT(rv1)

	PRUint32 len = 0;col->GetLength(&len);
	for (PRInt32 idx=0;idx < len;idx++)
	{
		nsCOMPtr<nsIDOMHTMLOptionElement> opt = nsnull;
		nsresult rv2 = col->Item(idx, (nsIDOMNode**) &opt);
		II_ENSURE_INTERFACE(opt)
		II_ENSURE_NS_RESULT(rv2)
		
		nsAutoString idxstr;
		idxstr.Append(MozStr(","));
		idxstr.AppendInt(idx);
		idxstr.Append(MozStr(","));

		opt->SetDefaultSelected(PR_FALSE);
		if (value.Find(idxstr) != -1)
			opt->SetDefaultSelected(PR_TRUE);
	}

	ILOG << "Select Value Set:" << value << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::SubmitForm(nsIDOMElement* element)
{
	II_GET_INTERFACE(element, nsIDOMHTMLFormElement, frm_element);
	nsresult rv = frm_element->Submit();
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Form Submitted" << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::ResetForm(nsIDOMElement* element)
{
	II_GET_INTERFACE(element, nsIDOMHTMLFormElement, frm_element);
	nsresult rv = frm_element->Reset();
	II_ENSURE_NS_RESULT(rv)

	ILOG << "Form Reset" << IDBG;
	return IIR_SUCCESS;
}

II_RESULT rvHTMLElement::GetImageDimensions(nsIDOMElement* element, PRInt32 width, PRInt32 height)
{
	II_GET_INTERFACE(element, nsIDOMHTMLImageElement, img_element);
	nsresult rv = img_element->GetHeight(&height);
	II_ENSURE_NS_RESULT(rv)
	rv = img_element->GetWidth(&width);
	II_ENSURE_NS_RESULT(rv)
	
	return IIR_SUCCESS;
}

nsIDOMHTMLDocument* rvHTMLElement::GetOwnerDocument(nsIDOMElement* p_element)
{
	nsIDOMDocument* doc;
	p_element->GetOwnerDocument(&doc);

	if (doc == nsnull)
		return (nsIDOMHTMLDocument*) p_element;
	
	nsCOMPtr<nsIDOMHTMLDocument> hdoc = do_QueryInterface(doc);
	NS_RELEASE(doc);
	return hdoc;
}

nsAutoString rvHTMLElement::GetURLFromElement(nsIDOMElement* p_element)
{
	nsIDOMHTMLDocument* doc = GetOwnerDocument(p_element);
	nsAutoString url;

	if (doc != nsnull)
	{
		doc->GetURL(url);
	}
	else
		((nsIDOMHTMLDocument*) p_element)->GetURL(url);

	return url;
}
