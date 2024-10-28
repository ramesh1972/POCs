<%
function TreeLeafParaView(leDocObj, lLeafRs)
	Dim lParaRs
	Dim lParaTitle
	Dim lPara

	' create the anchor here
%>
	<A name="aPara<%=trim(lLeafRs("TL_LeafElementID"))%>"></A>
<%
	Set lParaRs = Server.CreateObject("ADODB.RecordSet")
	Set lParaRs = leDocObj.GetParagraph(eval(trim(lLeafRs("TL_LeafElementID"))))
	If lParaRs.RecordCount > 0 Then
		lParaTitle = trim(lParaRs("P_ParagraphTitle"))
		lPara = trim(lParaRs("P_ParagraphText"))
%>
		<BR>
		<TABLE align="center" width=100%>
		<TR>
		<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=lNodeID%>&LeafElementID=<%=trim(lLeafRs("TL_LeafElementID"))%>&LeafType=Para#aPara<%=trim(lLeafRs("TL_LeafElementID"))%>">Edit Para</A></TD>
		</TR>
		</TABLE>
		<BR>
		<table align="<%=trim(lParaRs("P_TitleTextAlign"))%>">
		<TR>
			<TD align="<%=trim(lParaRs("P_TitleTextAlign"))%>">
				<div	id="ParaTitle<%=eval(trim(lLeafRs("TL_LeafElementID")))%>" 
						name="ParaTitle<%=eval(trim(lLeafRs("TL_LeafElementID")))%>">
				<%=lParaTitle%>
				</div>
				<script language=javascript>
				var lTitleDiv = document.all("ParaTitle" + <%=eval(trim(lLeafRs("TL_LeafElementID")))%>);
	
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
		<BR>
		<table align="<%=trim(lParaRs("P_TextAlign"))%>">
		<TR>
			<TD align="<%=trim(lParaRs("P_TextAlign"))%>">
				<div	id="Para<%=eval(trim(lLeafRs("TL_LeafElementID")))%>" 
						name="Para<%=eval(trim(lLeafRs("TL_LeafElementID")))%>">
				<%=lPara%>
				</div>
				<script language=javascript>
				var lDiv = document.all("Para" + <%=eval(trim(lLeafRs("TL_LeafElementID")))%>);
	
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
end function
%>
