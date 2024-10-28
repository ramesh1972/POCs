<%@ Language=VBScript %>
<HTML>
<HEAD>	
<!-- #include = file="adovbs.inc" -->
</HEAD>
<script language="javascript">
parent.frames("fContents").document.location = "ed-contents-view.asp";
</script>
<BODY>
<%
	Dim lNodeID
	Dim lNodeType
	Dim lLeafType
	
	Dim lEDObj
	Dim lRs
	
	Dim lParaRs
	Dim lParaTitle
	Dim lPara

	Dim lBreakRs
	Dim lNoOfBreaks
	
	Dim lIdx
	
	lNodeID = Request.QueryString("NodeID")
	lNodeType = Request.QueryString("NodeType")
	
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	Set lRs = Server.CreateObject("ADODB.RecordSet")
	Set lParaRs = Server.CreateObject("ADODB.RecordSet")
	Set lBreakRs = Server.CreateObject("ADODB.RecordSet")	
	
	Set lRs = lEDObj.GetLeafLets  (eval(lNodeID))
%>
	<TABLE align="center" width=100%>
	<TR>
	<TD align="right"><A href="ed-tree-leaf-edit.asp?NodeID=<%=lNodeID%>">Edit</A></TD>
	</TR>
	</TABLE>
<%
	if lRs.RecordCount > 0 then
		lRs.MoveFirst 
		while Not lRs.EOF 
			' Based on the type of leaf element display the para, table etc...
			lLeafType = trim(lRs("TL_LeafType"))

			if lLeafType = "PARA" Then
				Set lParaRs = lEDObj.GetParagraph(eval(trim(lRs("TL_LeafElementID"))))
				If lParaRs.RecordCount > 0 Then
					lParaTitle = trim(lParaRs("P_ParagraphTitle"))
					lPara = trim(lParaRs("P_ParagraphText"))
%>
					<table align="<%=trim(lParaRs("P_TitleTextAlign"))%>">
					<TR>
						<TD align="<%=trim(lParaRs("P_TitleTextAlign"))%>">
							<div	id="ParaTitle<%=eval(trim(lRs("TL_LeafElementID")))%>" 
									name="ParaTitle<%=eval(trim(lRs("TL_LeafElementID")))%>">
							<%=lParaTitle%>
							</div>
							<script language=javascript>
							var lTitleDiv = document.all("ParaTitle" + <%=eval(trim(lRs("TL_LeafElementID")))%>);
	
							// Set the properties for the para title
							lTitleDiv.style.textAlign = "<%=trim(lParaRs("P_TitleTextAlign"))%>";
							lTitleDiv.style.color = "<%=trim(lParaRs("P_TitleTextColor"))%>";
							lTitleDiv.style.textDecoration = "<%=trim(lParaRs("P_TitleTextDeco"))%>";
							lTitleDiv.style.backgroundColor = "<%=trim(lParaRs("P_TitleBGColor"))%>";
							lTitleDiv.style.borderStyle = "<%=trim(lParaRs("P_TitleBorderStyle"))%>";
							lTitleDiv.style.borderWidth = <%=trim(lParaRs("P_TitleBorderWidth"))%>;
							lTitleDiv.style.borderColor = "<%=trim(lParaRs("P_TitleBorderColor"))%>";
							lTitleDiv.style.fontFamily = "<%=trim(lParaRs("P_TitleFontFamily"))%>";
							lTitleDiv.style.fontWeight = "<%=trim(lParaRs("P_TitleFontWeight"))%>";
							lTitleDiv.style.fontSize = <%=trim(lParaRs("P_TitleFontSize"))%>;
							</script>
						</TD>
					</TR>
					</TABLE>
					<BR><BR>
					<table align="<%=trim(lParaRs("P_TextAlign"))%>">
					<TR>
						<TD align="<%=trim(lParaRs("P_TextAlign"))%>">
							<div	id="Para<%=eval(trim(lRs("TL_LeafElementID")))%>" 
									name="Para<%=eval(trim(lRs("TL_LeafElementID")))%>">
							<%=lPara%>
							</div>
							<script language=javascript>
							var lDiv = document.all("Para" + <%=eval(trim(lRs("TL_LeafElementID")))%>);
	
							// Set the properties for the para title
							lDiv.style.textAlign = "<%=trim(lParaRs("P_TextAlign"))%>";
							lDiv.style.color = "<%=trim(lParaRs("P_TextColor"))%>";
							lDiv.style.textDecoration = "<%=trim(lParaRs("P_TextDeco"))%>";
							lDiv.style.backgroundColor = "<%=trim(lParaRs("P_BGColor"))%>";
							lDiv.style.borderWidth = <%=trim(lParaRs("P_BorderWidth"))%>;
							lDiv.style.borderColor = "<%=trim(lParaRs("P_BorderColor"))%>";
							lDiv.style.borderStyle = "<%=trim(lParaRs("P_BorderStyle"))%>";
							lDiv.style.fontFamily = "<%=trim(lParaRs("P_FontFamily"))%>";
							lDiv.style.fontWeight = "<%=trim(lParaRs("P_FontWeight"))%>";
							lDiv.style.fontSize = <%=trim(lParaRs("P_FontSize"))%>;
							</script>
						</TD>
					</TR>
					</TABLE>
<%
				else
%>
					Paragraph Not Found<BR>
<%
				End if
			end if
			
			if lLeafType = "BREAK" Then
				Set lBreakRs = lEDObj.GetBreak (eval(trim(lRs("TL_LeafElementID"))))
				If lBreakRs.RecordCount > 0 Then
					lNoOfBreaks = trim(lBreakRs("LB_NoOfBreaks"))
					
					for lIdx = 0 to lNoOfBreaks-1
						Response.Write("<BR>")
					next
				End if
			end if

			lRs.MoveNext 
		wend
	else
%>
		Topic contents not found<BR>
<%
	end if
%> 
</BODY>
</HTML>
