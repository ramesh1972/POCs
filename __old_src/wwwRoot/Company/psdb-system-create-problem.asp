<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
<LINK rel="stylesheet" href="../Includes/theme.css">
<SCRIPT Language="Javascript">
function Validate() {
	if (document.frmCreate.ebName.value  == "")
	 {
		alert("Please enter your Name.");
		document.frmCreate.ebName.focus();
		return false;
	}
}
</SCRIPT>
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<TABLE align="center" width=600>
<TR>
	<TD align=left><A href="psdb-system-start.asp">Start Page</A></TD>
</TR>
</TABLE>
<FORM ACTION = "psdb-system-insert-problem.asp" method="post" name="frmCreate" Onsubmit="return Validate();">
<TABLE align="center" border=1 width=600 class="tdbgdark">
  <TR>
    <TD><FONT CLASS="whiteboldtext">Problem Entry Form</FONT></TD>
  </TR>
 </TABLE>
<TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align="right"><B>Name</B></TD>
    <TD width=300><INPUT type="text" name="ebName"></TD>
  </TR>

  <TR>
    <TD align="right"><B>Problem Title</B><BR>Short Description</TD>
    <TD width=300><INPUT type="text" name="ebTitle"></TD>
  </TR>
  <TR>
    <TD align="right"><B>Problem Description</B><BR>Steps to recreate the Problem</TD>
    <TD width=300><TEXTAREA cols=40 rows=8 name="taDescription"></TEXTAREA></TD>
  </TR>
  </TABLE>
  <TABLE align="center" border=1 width=600 class="tdbglight">
  <TR >
    <TD align="middle"><INPUT type="submit" name="bbtInsert" value="Insert" >
    </TD>
  </TR>
</TABLE>
</FORM>
<!-- #include file="../Includes/footer.inc" -->
</BODY>
</HTML>
