<%
Function TreeLeafParaEdit(pieDObj, piNodeID, piLeafElementID)
	Dim lParaRs
	Dim lParaTitle
	Dim lPara

	' create the anchor here
%>
	<A name="aPara<%=piLeafElementID%>"></A>
<%

	Set lParaRs = Server.CreateObject("ADODB.RecordSet")
	Set lParaRs = pieDObj.GetParagraph(piLeafElementID)
	
	If lParaRs.RecordCount > 0 Then
		lParaTitle = trim(lParaRs("P_ParagraphTitle"))
		lPara = trim(lParaRs("P_ParagraphText"))
%>
		<BR>
		<TABLE align="center" width=100%>
		<TR>
		<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=piNodeID%>#aPara<%=piLeafElementID%>">View Para</A></TD>
		</TR>
		</TABLE>
		<BR>
		<FORM name="frmUpdatePara<%=piLeafElementID%>" method="post" action="ed-tree-leaf-para-update.asp#aPara<%=piLeafElementID%>">
		<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Update Paragraph</font></TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD width=150 valign="top"><B>Paragraph Title</B></TD><TD><INPUT name="tbParaTitle<%=piLeafElementID%>" size=50 type='text' value="<%=lParaTitle%>"></TD>  
		</TR>
		</TABLE>
		<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><A href="javascript:here();" onclick="TitlePropOnClick(<%=piLeafElementID%>);">Title Properties</TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><div id="dParaTitleProp<%=piLeafElementID%>"></div></TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR> 
			 <TD width=150 valign="top"><B>Paragraph</B></TD><TD><Textarea name="taPara<%=piLeafElementID%>" cols=50 rows=8><%=lPara%></Textarea></TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><A href="javascript:here();" onclick="ParaPropOnClick(<%=piLeafElementID%>);">Paragraph Properties</TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><div id="dParaProp<%=piLeafElementID%>"></div></TD>
		</TR>
		</TABLE>
		<TABLE width=100% align='center' class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Update Paragraph'></TD></TR></TABLE>
		<input type=hidden name="hExpanded" value="false">
		<input type=hidden name="hParaExpanded" value="false">
		<input type="hidden" name="hNodeID" Value="<%=piNodeID%>">
		<input type="hidden" name="hLeafElementID" Value="<%=piLeafElementID%>">
					
		<input type=hidden name="hTextAlign" value="<%=trim(lParaRs("P_TitleTextAlign"))%>">
		<input type=hidden name="hTextColor" value="<%=trim(lParaRs("P_TitleTextColor"))%>">
		<input type=hidden name="hTextDeco" value="<%=trim(lParaRs("P_TitleTextDeco"))%>">
		<input type=hidden name="hBGColor" value="<%=trim(lParaRs("P_TitleBGColor"))%>">
		<input type=hidden name="hBGImage" value="">
		<input type=hidden name="hBorderWidth" value="<%=trim(lParaRs("P_TitleBorderWidth"))%>">
		<input type=hidden name="hBorderColor" value="<%=trim(lParaRs("P_TitleBorderColor"))%>">
		<input type=hidden name="hBorderStyle" value="<%=trim(lParaRs("P_TitleBorderStyle"))%>">
		<input type=hidden name="hFontFamily" value="<%=trim(lParaRs("P_TitleFontFamily"))%>">
		<input type=hidden name="hFontWeight" value="<%=trim(lParaRs("P_TitleFontWeight"))%>">
		<input type=hidden name="hFontSize" value="<%=trim(lParaRs("P_TitleFontSize"))%>">

		<input type=hidden name="hParaTextAlign" value="<%=trim(lParaRs("P_TextAlign"))%>">
		<input type=hidden name="hParaTextColor" value="<%=trim(lParaRs("P_TextColor"))%>">
		<input type=hidden name="hParaTextDeco" value="<%=trim(lParaRs("P_TextDeco"))%>">
		<input type=hidden name="hParaBGColor" value="<%=trim(lParaRs("P_BGColor"))%>">
		<input type=hidden name="hParaBGImage" value="">
		<input type=hidden name="hParaBorderWidth" value="<%=trim(lParaRs("P_BorderWidth"))%>">
		<input type=hidden name="hParaBorderColor" value="<%=trim(lParaRs("P_BorderColor"))%>">
		<input type=hidden name="hParaBorderStyle" value="<%=trim(lParaRs("P_BorderStyle"))%>">
		<input type=hidden name="hParaFontFamily" value="<%=trim(lParaRs("P_FontFamily"))%>">
		<input type=hidden name="hParaFontWeight" value="<%=trim(lParaRs("P_FontWeight"))%>">
		<input type=hidden name="hParaFontSize" value="<%=trim(lParaRs("P_FontSize"))%>">
		</FORM>
		<script language="javascript">
			TitlePropOnClick(<%=piLeafElementID%>);						
			ParaTitlePropertyApply(<%=piLeafElementID%>);
			TitlePropOnClick(<%=piLeafElementID%>);
						
			ParaPropOnClick(<%=piLeafElementID%>);						
			ParaPropertyApply(<%=piLeafElementID%>);
			ParaPropOnClick(<%=piLeafElementID%>);
		</script>
		<BR>
<%
	else
%>		
		<BR>
		Paragraph Not Found
		<BR>
<%
	End if
End Function
%>
