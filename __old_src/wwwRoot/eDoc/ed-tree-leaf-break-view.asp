<!-- #include = file="ed-common-selects.asp" -->
<%
Function TreeLeafBreakView(leDocObj, lLeafRs)
%>
	<BR>
	<TABLE align="center" width=100%>
	<TR>
	<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=lNodeID%>&LeafElementID=<%=trim(lRs("TL_LeafElementID"))%>&LeafType=Break">Edit Breaks</A></TD>
	</TR>
	</TABLE>
	<BR>
<%
	Set lBreakRs = lEDObj.GetBreak (eval(trim(lRs("TL_LeafElementID"))))
	If lBreakRs.RecordCount > 0 Then
		lNoOfBreaks = trim(lBreakRs("LB_NoOfBreaks"))
					
		for lIdx = 0 to lNoOfBreaks-1
			Response.Write("<BR>")
		next
	else
%>
		Breaks not found<BR>
<%
	end if
End Function
%> 
