<%@ Language=VBScript %>
<% 
	Dim db_conn
	Dim rst
		
	Dim sql_str
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../Includes/theme.css">
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<%
	Set db_conn = Server.CreateObject("ADODB.Connection")
	db_conn.Open "PSDB", "sa", "bce@testing"
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	
    sql_str = "Select distinct(ReportedBy) from PS_Reports"
	Set rst = db_conn.Execute (sql_str)
	
%>
<TABLE align="center" width=600>
<TR>
	<TD align="left"><A href="psdb-system-start.asp">Start Page</A></TD>
</TR>
</TABLE>
<FORM ACTION = "psdb-system-view.asp" method="post" name="frmViewQuery">
<TABLE align="center" border=1 width=600 class="tdbgdark">
  <TR>
    <TD><font class="whiteboldtext">Problems Query Form</FONT></TD>
  </TR>
 </TABLE>
<TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align=right><B>Module</B></TD>
    <TD width=300><SELECT name="cbModule"> 
				  <OPTION value="All">All</OPTION>
				  <OPTION value="Broker Admin">Broker Admin</OPTION>
				  <OPTION value="Clearing and Settlement">Clearing and Settlement</OPTION>
				  <OPTION value="MAC">MAC</OPTION>
				  <OPTION value="RMS">RMS</OPTION>
				  <OPTION value="Trading">Trading</OPTION>
				  <OPTION value="Web">Web</OPTION>				  
				  <OPTION value="Network">Network</OPTION>
				  </SELECT></TD>
  </TR>
  <TR>
    <TD align=right><B>Status</B></TD>
    <TD width=300><SELECT name="cbStatus"> 
				  <OPTION value="All">All</OPTION>
				  <OPTION value="New">New</OPTION>
				  <OPTION value="In Process">In Process</OPTION>
				  <OPTION value="Fixed">Fixed</OPTION>
				  <OPTION value="Verified">Verified</OPTION>
				  <OPTION value="No longer relevant">No longer relevant</OPTION>
				  <OPTION value="Defferd">Defferd</OPTION>				  
				  </SELECT></TD>
  </TR>

  <TR>
    <TD align=right><B>Priority</B></TD>
    <TD width=300><SELECT name="cbPriority"> 
    			  <OPTION value="All">All</OPTION>
				  <OPTION value="Very Low">Very Low</OPTION>
				  <OPTION value="Low">Low</OPTION>
				  <OPTION value="Normal">Normal</OPTION>
				  <OPTION value="High">High</OPTION>
				  <OPTION value="Very High">Very High</OPTION>
				  </SELECT></TD>
  </TR>

  <TR>
    <TD align=right><B>ReportedBy</B></TD>

    <TD width=300><SELECT name="cbReportedBy"> 
        		  <OPTION value="All">All</OPTION>
    <% While Not rst.EOF 
			Response.Write("<OPTION Value = " & rst("ReportedBy") & ">" & rst("ReportedBy") & "</OPTION>")
			rst.MoveNext
	   Wend
    %>
	</SELECT></TD>
  </TR>

  <TR>
    <TD align=right><B>Responsibility</B></TD>
    <TD width=300><SELECT name="cbResponsibility"> 
				  <OPTION value="All">All</OPTION>				  
				  <OPTION value="Ramaraju">Ramaraju</OPTION>
				  <OPTION value="Ramesh Viswanathan">Ramesh Viswanathan</OPTION>
				  <OPTION value="Sivaraj">Sivaraj</OPTION>
				  <OPTION value="Venkatesh">Venkatesh</OPTION>
				  <OPTION value="Jayakumar">Jayakumar</OPTION>
				  <OPTION value="Rajendra">Rajendra</OPTION>
				  <OPTION value="Saravana">Saravana</OPTION>
				  <OPTION value="Zheeshan">Zheeshan</OPTION>
				  <OPTION value="Britto">Britto</OPTION>
				  <OPTION value="Roopesh">Roopesh</OPTION>
				  <OPTION value="Vijay">Vijay</OPTION>
				  <OPTION value="Obula Reddy">Obula Reddy</OPTION>
				  <OPTION value="Ramesh Kota">Ramesh Kota</OPTION>
				  <OPTION value="Priya">Priya</OPTION>
				  <OPTION value="Ramnath">Ramnath</OPTION>
				  <OPTION value="TVS">TVS</OPTION>
				  <OPTION value="Narasimhan">Narasimhan</OPTION>
				  <OPTION value="Satheesh">Satheesh</OPTION>
				  <OPTION value="Jaiganesh">Jaiganesh</OPTION>
				  <OPTION value="Palani">Palani</OPTION>
				  <OPTION value="Navaneethan">Navaneethan</OPTION>
				  <OPTION value="Ashok">Ashok</OPTION>
				  <OPTION value="Sivakumar">Sivakumar</OPTION>
				  <OPTION value="Vasanth">Vasanth</OPTION>
				  <OPTION value="Dipankar">Dipankar</OPTION>
				  <OPTION value="Majo">Majo</OPTION>
				  <OPTION value="Kuttalraj">Kuttalraj</OPTION>
				  <OPTION value="Maheswari">Maheswari</OPTION>
				  <OPTION value="Ravisankar">Ravisankar</OPTION>
				  </SELECT></TD>
  </TR>
  <TR>
    <TD align=right><B>Fixed By</B></TD>
    <TD width=300><SELECT name="cbFixedBy"> 
				  <OPTION value="All">All</OPTION>				  
				  <OPTION value="Ramaraju">Ramaraju</OPTION>
				  <OPTION value="Ramesh Viswanathan">Ramesh Viswanathan</OPTION>
				  <OPTION value="Sivaraj">Sivaraj</OPTION>
				  <OPTION value="Venkatesh">Venkatesh</OPTION>
				  <OPTION value="Jayakumar">Jayakumar</OPTION>
				  <OPTION value="Rajendra">Rajendra</OPTION>
				  <OPTION value="Saravana">Saravana</OPTION>
				  <OPTION value="Zheeshan">Zheeshan</OPTION>
				  <OPTION value="Britto">Britto</OPTION>
				  <OPTION value="Roopesh">Roopesh</OPTION>
				  <OPTION value="Vijay">Vijay</OPTION>
				  <OPTION value="Obula Reddy">Obula Reddy</OPTION>
				  <OPTION value="Ramesh Kota">Ramesh Kota</OPTION>
				  <OPTION value="Priya">Priya</OPTION>
				  <OPTION value="Ramnath">Ramnath</OPTION>
				  <OPTION value="TVS">TVS</OPTION>
				  <OPTION value="Narasimhan">Narasimhan</OPTION>
				  <OPTION value="Satheesh">Satheesh</OPTION>
				  <OPTION value="Jaiganesh">Jaiganesh</OPTION>
				  <OPTION value="Palani">Palani</OPTION>
				  <OPTION value="Navaneethan">Navaneethan</OPTION>
				  <OPTION value="Ashok">Ashok</OPTION>
				  <OPTION value="Sivakumar">Sivakumar</OPTION>
				  <OPTION value="Vasanth">Vasanth</OPTION>
				  <OPTION value="Dipankar">Dipankar</OPTION>
				  <OPTION value="Majo">Majo</OPTION>
				  <OPTION value="Kuttalraj">Kuttalraj</OPTION>
				  <OPTION value="Maheswari">Maheswari</OPTION>
				  <OPTION value="Ravisankar">Ravisankar</OPTION>				  
				  </SELECT></TD>
  </TR>
  <TR>
    <TD align=right><B>Verified By</B></TD>
    <TD width=300><SELECT name="cbVerifiedBy"> 
				  <OPTION value="All">All</OPTION>				  
				  <OPTION value="Ramaraju">Ramaraju</OPTION>
				  <OPTION value="Ramesh Viswanathan">Ramesh Viswanathan</OPTION>
				  <OPTION value="Sivaraj">Sivaraj</OPTION>
				  <OPTION value="Venkatesh">Venkatesh</OPTION>
				  <OPTION value="Jayakumar">Jayakumar</OPTION>
				  <OPTION value="Rajendra">Rajendra</OPTION>
				  <OPTION value="Saravana">Saravana</OPTION>
				  <OPTION value="Zheeshan">Zheeshan</OPTION>
				  <OPTION value="Britto">Britto</OPTION>
				  <OPTION value="Roopesh">Roopesh</OPTION>
				  <OPTION value="Vijay">Vijay</OPTION>
				  <OPTION value="Obula Reddy">Obula Reddy</OPTION>
				  <OPTION value="Ramesh Kota">Ramesh Kota</OPTION>
				  <OPTION value="Priya">Priya</OPTION>
				  <OPTION value="Ramnath">Ramnath</OPTION>
				  <OPTION value="TVS">TVS</OPTION>
				  <OPTION value="Narasimhan">Narasimhan</OPTION>
				  <OPTION value="Satheesh">Satheesh</OPTION>
				  <OPTION value="Jaiganesh">Jaiganesh</OPTION>
				  <OPTION value="Palani">Palani</OPTION>
				  <OPTION value="Navaneethan">Navaneethan</OPTION>
				  <OPTION value="Ashok">Ashok</OPTION>
				  <OPTION value="Sivakumar">Sivakumar</OPTION>
				  <OPTION value="Vasanth">Vasanth</OPTION>
				  <OPTION value="Dipankar">Dipankar</OPTION>
				  <OPTION value="Majo">Majo</OPTION>
				  <OPTION value="Kuttalraj">Kuttalraj</OPTION>
				  <OPTION value="Maheswari">Maheswari</OPTION>
				  <OPTION value="Ravisankar">Ravisankar</OPTION>
				  </SELECT></TD>
  </TR>

 </TABLE>
 <TABLE align="center" border=1 width=600 class="tdbglight">
  <TR >
    <TD align="middle"><INPUT type="submit" value="Submit" name="bbtQuerySubmit">
    </TD>
  </TR>
</TABLE>
</FORM>
<BR>
<!-- #include file="../Includes/footer.inc" -->
</BODY>
</HTML>
