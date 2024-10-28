<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML>
<HEAD>
<!-- #include = file="adovbs.inc" -->
<LINK REL=StyleSheet HREF="theme.css">
</HEAD>
<BODY>
<%
	Dim lNodeID
	Dim lLeafType
	Dim lLeafElementID
	Dim lEDObj
	Dim lParaTitle
	Dim lPara
	Dim lUpdateFormName
	Dim lParaUpdate
	
	Dim lTTextAlign
	Dim lTTextColor
	Dim lTTextDeco
	Dim lTBGColor
	Dim lTBGImage
	Dim lTBorderWidth
	Dim lTBorderColor
	Dim lTBorderStyle
	Dim lTFontFamily
	Dim lTFontSize
	Dim lTFontWeight
	
	Dim lTextAlign
	Dim lTextColor
	Dim lTextDeco
	Dim lBGColor
	Dim lBGImage
	Dim lBorderWidth
	Dim lBorderColor
	Dim lBorderStyle
	Dim lFontFamily
	Dim lFontSize
	Dim lFontWeight

	lNodeID = Request.Form("hNodeID")	
	
	lLeafElementID = Request.Form("hLeafElementID")	
	lInsertFormName = "frmUpdatePara" & lLeafElementID
	lParaTitle = Request.Form("tbParaTitle" & lLeafElementID)
	lPara = Request.Form("taPara" & lLeafElementID)
		
	lTTextAlign = Request.Form("hTextAlign")
	lTTextColor = Request.Form("hTextColor")
	lTTextDeco = Request.Form("hTextDeco")
	lTBGColor = Request.Form("hBGColor")
	lTBGImage = Request.Form("")
	lTBorderWidth = Request.Form("hBorderWidth")
	lTBorderColor = Request.Form("hBorderColor")
	lTBorderStyle = Request.Form("hBorderStyle")
	lTFontFamily = Request.Form("hFontFamily")
	lTFontSize = Request.Form("hFontSize")
	lTFontWeight = Request.Form("hFontWeight")

	lTextAlign = Request.Form("hParaTextAlign")
	lTextColor = Request.Form("hParaTextColor")
	lTextDeco = Request.Form("hParaTextDeco")
	lBGColor = Request.Form("hParaBGColor")
	lBGImage = Request.Form("")
	lBorderWidth = Request.Form("hParaBorderWidth")
	lBorderColor = Request.Form("hParaBorderColor")
	lBorderStyle = Request.Form("hParaBorderStyle")
	lFontFamily = Request.Form("hParaFontFamily")
	lFontSize = Request.Form("hParaFontSize")
	lFontWeight = Request.Form("hParaFontWeight")

	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	lParaUpdated = true 
	
	lParaUpdated = lEDObj.UpdatePara (eval(lNodeID), lParaTitle, lPara, eval(lLeafElementID), 	lTTextAlign	,lTTextColor,lTTextDeco	,lTBGColor,lTBGImage,eval(lTBorderWidth),lTBorderColor,lTBorderStyle,lTFontFamily,eval(lTFontSize),lTFontWeight,lTextAlign,lTextColor,lTextDeco,lBGColor,lBGImage,eval(lBorderWidth),lBorderColor,lBorderStyle,lFontFamily,eval(lFontSize),lFontWeight)
	if lParaUpdated then
		Response.Redirect ("ed-tree-leaf-edit.asp?NodeID=" & lNodeID)
	end if
%>
</BODY>
</HTML>
