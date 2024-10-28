<!-- #include = file="ed-common-selects.asp" -->
<% Function TreeLeafBreakEdit(pieDObj, piNodeID, piLeafElementID)
	Dim lBreakRs
	Dim lNoOfBreaks
	
	Set lBreakRs = Server.CreateObject("ADODB.RecordSet")
	Set lBreakRs = pieDObj.GetBreak (piLeafElementID)

	If lBreakRs.RecordCount > 0 Then
		lNoOfBreaks = trim(lBreakRs("LB_NoOfBreaks"))
					
		' Give Edit controls on the edit toolbar for the current breaks
%>
		<BR>
		<TABLE align="center" width=100%>
		<TR>
		<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=piNodeID%>">View Breaks</A></TD>
		</TR>
		</TABLE>
		<BR>		
		<FORM name="frmUpdateBreak<%=piLeafElementID%>" method="post" action="ed-tree-leaf-break-update.asp">
		<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Update Line Breaks</font></TD>
		</TR>
		</TABLE>
					
		<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align='left' width=175><B>Number of Line Breaks</B></TD>
			<TD align='left' width=60%><INPUT name='tNoOfBreaks<%=piLeafElementID%>' size=10 type='text' value=<%=lNoOfBreaks%>></TD> 
		</TR>
		</TABLE>
		<TABLE width=100% align='center' class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Update Line Breaks'></TD></TR></TABLE>
		<input type="hidden" name="hNodeID" Value="<%=piNodeID%>">
		<input type="hidden" name="hLeafElementID" Value="<%=piLeafElementID%>">
		</FORM>
		<BR>
<%
	else
%>
		<BR>Line Breaks Not Found<BR>
<%
	End if
End Function
%>

