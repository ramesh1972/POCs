<%@ Language=VBScript %>
<% Option Explicit
	Dim lid 
	Dim lsdesc
	Dim lldesc

	Dim srv
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

	Set srv = Server.CreateObject ("User.clsUser")
	Set rec = Server.CreateObject("ADODB.Recordset")

	Set rec = srv.ViewDescriptions(cint(lid))
	
	lsdesc = trim(rec("ShortDescription"))
	lldesc = trim(rec("LongDescription"))
%>

<TABLE align="center" width=600>
<TR>
	<TD align=left width=100><A href="psdb-user-view.asp">View Problems</A></TD>
	<TD align=left><A href="psdb-user-start.asp">Start Page</A></TD>
</TR>
</TABLE>

<TABLE align="center" border=1 width=600 class="tdbgdark">
  <TR>
    <TD><font class="whiteboldtext">Problem Details</font></TD>
  </TR>
</TABLE>

<TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align="right"><B>Identifier</B></TD>
    <TD width=300><%=lid%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Problem Title</B></TD>
    <TD width=300><% If lsdesc <> "" Then Response.Write(lsdesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Problem Description</B></TD>
    <TD width=300 align=left><%If lldesc <> "" Then Response.Write(lldesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  </TABLE>
  <BR>
 <!-- #include file="../Includes/footer.inc" --> 
</BODY>
</HTML>
