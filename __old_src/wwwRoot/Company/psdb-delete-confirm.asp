<%@ Language=VBScript %>
<% Option Explicit
	Dim lid 
	Dim lsdesc
	Dim lldesc

	Dim server_obj
	Dim sql_str
	Dim rec
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../Includes/theme.css">
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<%	lid = Request("Identifier") 

	Set server_obj = Server.CreateObject("ADODB.Connection")
	server_obj.Open "PSDB", "sa", "bce@testing"
	
	Set rec = Server.CreateObject ("ADODB.RecordSet")
	sql_str = "Select Status, ShortDescription, LongDescription From PS_Reports Where Identifier = " & lid
	
	Set rec = server_obj.Execute (sql_str)
	lsdesc = trim(rec("ShortDescription"))
	lldesc = trim(rec("LongDescription"))
%>

<FORM ACTION = "psdb-delete-problem.asp" method="post" name="frmDelete">
<TABLE align="center" width=600>
<TR>
	<TD align=left><A href="psdb-system-start.asp">Start Page</A></TD>
</TR>
</TABLE>
<TABLE align="center" border=1 width=600 class="tdbgdark">
  <TR>
    <TD><B>Problem Delete Confirm</B></TD>
  </TR>
</TABLE>

<TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align="right"><B>Identifier</B></TD>
    <TD width=300><%=lid%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Problem Title</B></TD>
    <TD width=300><%If lsdesc <> "" Then Response.Write(lsdesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Problem Description</B></TD>
    <TD width=300 align=left><%If lldesc <> "" Then Response.Write(lldesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  <INPUT type="hidden" name="hIdentifier" value = <%=lid%>>
  </TABLE>
  <TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align="middle"><INPUT type="submit" value="Confirm Delete" name="bbtDelete">
    </TD>
  </TR>
</TABLE>
</FORM>
<BR>
<!-- #include file="../Includes/footer.inc" -->
</BODY>
</HTML>
