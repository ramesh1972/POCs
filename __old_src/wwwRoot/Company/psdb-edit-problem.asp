<%@ Language=VBScript %>
<% 
	Dim db_conn
	Dim rst
	Dim sql_str

	Dim id
	Dim rec
	Dim sql_str1
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../Includes/theme.css">
<TITLE></TITLE>
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<%
	Set db_conn = Server.CreateObject("ADODB.Connection")
	db_conn.Open "PSDB", "sa", "bce@testing"
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	Set rec = Server.CreateObject("ADODB.Recordset") 
	
    sql_str = "Select distinct(ReportedBy) from PS_Reports"
	Set rst = db_conn.Execute (sql_str)
	
	id = Request("Identifier")
	sql_str1 = "Select * from PS_Reports Where Identifier = " & id

	
	Set rec = db_conn.Execute (sql_str1)
%>
<TABLE align="center" width=600>
<TR>
	<TD align="left"><A href="psdb-system-start.asp">Start Page</A></TD>
</TR>
</TABLE>

<FORM ACTION = "psdb-update-problem.asp" method="post">
<TABLE align="center" border=1 width=600 class="tdbgdark">
  <TR>
    <TD><FONT CLASS="whiteboldtext">Problem Edit Form</FONT></TD>
  </TR>
</TABLE>

<TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align="right"><B>Identifier</B></TD>
    <TD width=300><%=id%></TD>
  </TR>

  <TR>
    <TD align="right"><B>Module</B></TD>
    <TD width=300><SELECT name="cbModule"> 
				  <OPTION value="All" <%if trim(rec("Module")) = "All" Then Response.Write("selected")%>> All</OPTION>
				  <OPTION value="Broker Admin" <%if trim(rec("Module")) = "Broker Admin" Then Response.Write("selected") End if%>>Broker Admin</OPTION>
				  <OPTION value="Clearing and Settlement" <%if trim(rec("Module")) = "Clearing and Settlement" Then Response.Write("selected") End if%>>Clearing and Settlement</OPTION>
				  <OPTION value="MAC" <%if trim(rec("Module")) = "MAC" Then Response.Write("selected") End if%>>MAC</OPTION>
				  <OPTION value="RMS" <%if trim(rec("Module")) = "RMS" Then Response.Write("selected") End if%>>RMS</OPTION>
				  <OPTION value="Trading" <%if trim(rec("Module")) = "Trading" Then Response.Write("selected") End if%>>Trading</OPTION>
				  <OPTION value="Web" <%if trim(rec("Module")) = "Web" Then Response.Write("selected") End if%>>Web</OPTION>				  
				  <OPTION value="Network" <%if trim(rec("Module")) = "Network" Then Response.Write("selected") End if%>>Network</OPTION>
				  </SELECT>
	</TD>
  </TR>

  <TR>
    <TD align="right"><B>Problem Title</B></TD>
    <TD width=300><INPUT name="ebTitle" value=<% Response.Write(trim(rec("ShortDescription")))%>></TD>
  </TR>
  <TR>
    <TD align="right"><B>Problem Description</B></TD>
    <TD width=300 align=left><TEXTAREA cols=40 rows=8 name="taDescription"><%Response.Write(trim(rec("LongDescription")))%> </TEXTAREA></TD>
  </TR>

  <TR>
    <TD align="right"><B>Status</B></TD>
    <TD width=300><SELECT name="cbStatus"> 
				  <OPTION value="All" <%if trim(rec("Status")) = "All" Then Response.Write("selected")%>>All</OPTION>
				  <OPTION value="New" <%if trim(rec("Status")) = "New" Then Response.Write("selected")%>>New</OPTION>
				  <OPTION value="In Process" <%if trim(rec("Status")) = "In Process" Then Response.Write("selected")%>>In Process</OPTION>
				  <OPTION value="Fixed" <%if trim(rec("Status")) = "Fixed" Then Response.Write("selected")%>>Fixed</OPTION>
				  <OPTION value="Verified" <%if trim(rec("Status")) = "Verified" Then Response.Write("selected")%>>Verified</OPTION>
				  <OPTION value="No longer relevant" <%if trim(rec("Status")) = "No longer relevant" Then Response.Write("selected")%>>No longer relevant</OPTION>
				  <OPTION value="Defferd" <%if trim(rec("Status")) = "Defferd" Then Response.Write("selected")%>>Defferd</OPTION>				  
				  </SELECT>
	</TD>
  </TR>

  <TR>
    <TD align="right"><B>Priority</B></TD>
    <TD width=300 align="left"><SELECT name="cbPriority"> 
    			  <OPTION value="All" <%if trim(rec("Priority")) = "All" Then Response.Write("selected")%>>All</OPTION>
				  <OPTION value="Very Low" <%if trim(rec("Priority")) = "Very Low" Then Response.Write("selected")%>>Very Low</OPTION>
				  <OPTION value="Low" <%if trim(rec("Priority")) = "Low" Then Response.Write("selected")%>>Low</OPTION>
				  <OPTION value="Normal" <%if trim(rec("Priority")) = "Normal" Then Response.Write("selected")%>>Normal</OPTION>
				  <OPTION value="High" <%if trim(rec("Priority")) = "High" Then Response.Write("selected")%>>High</OPTION>
				  <OPTION value="Very High" <%if trim(rec("Priority")) = "Very High" Then Response.Write("selected")%>>Very High</OPTION>
				  </SELECT>
	</TD>
  </TR>

  <TR>
    <TD align="right"><B>Reported By</B></TD>

    <TD width=300><SELECT name="cbReportedBy"> 
        		  <OPTION value="All">All</OPTION>
    <% While Not rst.EOF 
			if ((trim(rec("ReportedBy")) = trim(rst("ReportedBy")))) Then
				Response.Write("<OPTION Value = " & rst("ReportedBy") & "selected>" & rst("ReportedBy") & "</OPTION>")
			Else
				Response.Write("<OPTION Value = " & rst("ReportedBy") & ">" & rst("ReportedBy") & "</OPTION>")
			End If
			rst.MoveNext
	   Wend
    %>
	</SELECT></TD>
  </TR>
  
  <TR>
    <TD align="right"><B>Reported Date</B></TD>
    <TD width=300><% =rec("ReportedDate")%></TD>
  </TR>

  <TR>
    <TD align="right"><B>Responsibility</B></TD>
    <TD width=300><SELECT name="cbResponsibility"> 
				  <OPTION value="All" <%if trim(rec("Responsibility")) = "All" Then Response.Write("selected")%>>All</OPTION>				  
				  <OPTION value="Ramaraju" <%if trim(rec("Responsibility")) = "Ramaraju" Then Response.Write("selected")%>>Ramaraju</OPTION>
				  <OPTION value="Ramesh Viswanathan" <%if trim(rec("Responsibility")) = "Ramesh Viswanathan" Then Response.Write("selected")%>>Ramesh Viswanathan</OPTION>
				  <OPTION value="Sivaraj" <%if trim(rec("Responsibility")) = "Sivaraj" Then Response.Write("selected")%>>Sivaraj</OPTION>
				  <OPTION value="Venkatesh" <%if trim(rec("Responsibility")) = "Venkatesh" Then Response.Write("selected")%>>Venkatesh</OPTION>
				  <OPTION value="Jayakumar" <%if trim(rec("Responsibility")) = "Jayakumar" Then Response.Write("selected")%>>Jayakumar</OPTION>
				  <OPTION value="Rajendra" <%if trim(rec("Responsibility")) = "Rajendra" Then Response.Write("selected")%>>Rajendra</OPTION>
				  <OPTION value="Saravana" <%if trim(rec("Responsibility")) = "Saravana" Then Response.Write("selected")%>>Saravana</OPTION>
				  <OPTION value="Zheeshan" <%if trim(rec("Responsibility")) = "Zheeshan" Then Response.Write("selected")%>>Zheeshan</OPTION>
				  <OPTION value="Britto" <%if trim(rec("Responsibility")) = "Britto" Then Response.Write("selected")%>>Britto</OPTION>
				  <OPTION value="Roopesh" <%if trim(rec("Responsibility")) = "Roopesh" Then Response.Write("selected")%>>Roopesh</OPTION>
				  <OPTION value="Vijay" <%if trim(rec("Responsibility")) = "Vijay" Then Response.Write("selected")%>>Vijay</OPTION>
				  <OPTION value="Obula Reddy" <%if trim(rec("Responsibility")) = "Obula Reddy" Then Response.Write("selected")%>>Obula Reddy</OPTION>
				  <OPTION value="Ramesh Kota" <%if trim(rec("Responsibility")) = "Ramesh Kota" Then Response.Write("selected")%>>Ramesh Kota</OPTION>
				  <OPTION value="Priya" <%if trim(rec("Responsibility")) = "Priya" Then Response.Write("selected")%>>Priya</OPTION>
				  <OPTION value="Ramnath" <%if trim(rec("Responsibility")) = "Ramnath" Then Response.Write("selected")%>>Ramnath</OPTION>
				  <OPTION value="TVS" <%if trim(rec("Responsibility")) = "TVS" Then Response.Write("selected")%>>TVS</OPTION>
				  <OPTION value="Narasimhan" <%if trim(rec("Responsibility")) = "Narasimhan" Then Response.Write("selected")%>>Narasimhan</OPTION>
				  <OPTION value="Satheesh" <%if trim(rec("Responsibility")) = "Satheesh" Then Response.Write("selected")%>>Satheesh</OPTION>
				  <OPTION value="Jaiganesh" <%if trim(rec("Responsibility")) = "Jaiganesh" Then Response.Write("selected")%>>Jaiganesh</OPTION>
				  <OPTION value="Palani" <%if trim(rec("Responsibility")) = "Palani" Then Response.Write("selected")%>>Palani</OPTION>
				  <OPTION value="Navaneethan" <%if trim(rec("Responsibility")) = "Navaneethan" Then Response.Write("selected")%>>Navaneethan</OPTION>
				  <OPTION value="Ashok" <%if trim(rec("Responsibility")) = "Ashok" Then Response.Write("selected")%>>Ashok</OPTION>
				  <OPTION value="Sivakumar" <%if trim(rec("Responsibility")) = "Sivakumar" Then Response.Write("selected")%>>Sivakumar</OPTION>
				  <OPTION value="Vasanth" <%if trim(rec("Responsibility")) = "Vasanth" Then Response.Write("selected")%>>Vasanth</OPTION>
				  <OPTION value="Dipankar" <%if trim(rec("Responsibility")) = "Dipankar" Then Response.Write("selected")%>>Dipankar</OPTION>
				  <OPTION value="Majo" <%if trim(rec("Responsibility")) = "Majo" Then Response.Write("selected")%>>Majo</OPTION>
				  <OPTION value="Kuttalraj" <%if trim(rec("Responsibility")) = "Kuttalraj" Then Response.Write("selected")%>>Kuttalraj</OPTION>
				  <OPTION value="Maheswari" <%if trim(rec("Responsibility")) = "Maheswari" Then Response.Write("selected")%>>Maheswari</OPTION>
				  <OPTION value="Ravisankar" <%if trim(rec("Responsibility")) = "Ravisankar" Then Response.Write("selected")%>>Ravisankar</OPTION>
				  </SELECT></TD>
  </TR>
  <TR>
    <TD align="right"><B>Fixed By</B></TD>
    <TD width=300><SELECT name="cbFixedBy"> 
				  <OPTION value="All" <%if trim(rec("FixedBy")) = "All" Then Response.Write("selected")%>>All</OPTION>				  
				  <OPTION value="Ramaraju" <%if trim(rec("FixedBy")) = "Ramaraju" Then Response.Write("selected")%>>Ramaraju</OPTION>
				  <OPTION value="Ramesh Viswanathan" <%if trim(rec("FixedBy")) = "Ramesh Viswanathan" Then Response.Write("selected")%>>Ramesh Viswanathan</OPTION>
				  <OPTION value="Sivaraj" <%if trim(rec("FixedBy")) = "Sivaraj" Then Response.Write("selected")%>>Sivaraj</OPTION>
				  <OPTION value="Venkatesh" <%if trim(rec("FixedBy")) = "Venkatesh" Then Response.Write("selected")%>>Venkatesh</OPTION>
				  <OPTION value="Jayakumar" <%if trim(rec("FixedBy")) = "Jayakumar" Then Response.Write("selected")%>>Jayakumar</OPTION>
				  <OPTION value="Rajendra" <%if trim(rec("FixedBy")) = "Rajendra" Then Response.Write("selected")%>>Rajendra</OPTION>
				  <OPTION value="Saravana" <%if trim(rec("FixedBy")) = "Saravana" Then Response.Write("selected")%>>Saravana</OPTION>
				  <OPTION value="Zheeshan" <%if trim(rec("FixedBy")) = "Zheeshan" Then Response.Write("selected")%>>Zheeshan</OPTION>
				  <OPTION value="Britto" <%if trim(rec("FixedBy")) = "Britto" Then Response.Write("selected")%>>Britto</OPTION>
				  <OPTION value="Roopesh" <%if trim(rec("FixedBy")) = "Roopesh" Then Response.Write("selected")%>>Roopesh</OPTION>
				  <OPTION value="Vijay" <%if trim(rec("FixedBy")) = "Vijay" Then Response.Write("selected")%>>Vijay</OPTION>
				  <OPTION value="Obula Reddy" <%if trim(rec("FixedBy")) = "Obula Reddy" Then Response.Write("selected")%>>Obula Reddy</OPTION>
				  <OPTION value="Ramesh Kota" <%if trim(rec("FixedBy")) = "Ramesh Kota" Then Response.Write("selected")%>>Ramesh Kota</OPTION>
				  <OPTION value="Priya" <%if trim(rec("FixedBy")) = "Priya" Then Response.Write("selected")%>>Priya</OPTION>
				  <OPTION value="Ramnath" <%if trim(rec("FixedBy")) = "Ramnath" Then Response.Write("selected")%>>Ramnath</OPTION>
				  <OPTION value="TVS" <%if trim(rec("FixedBy")) = "TVS" Then Response.Write("selected")%>>TVS</OPTION>
				  <OPTION value="Narasimhan" <%if trim(rec("FixedBy")) = "Narasimhan" Then Response.Write("selected")%>>Narasimhan</OPTION>
				  <OPTION value="Satheesh" <%if trim(rec("FixedBy")) = "Satheesh" Then Response.Write("selected")%>>Satheesh</OPTION>
				  <OPTION value="Jaiganesh" <%if trim(rec("FixedBy")) = "Jaiganesh" Then Response.Write("selected")%>>Jaiganesh</OPTION>
				  <OPTION value="Palani" <%if trim(rec("FixedBy")) = "Palani" Then Response.Write("selected")%>>Palani</OPTION>
				  <OPTION value="Navaneethan" <%if trim(rec("FixedBy")) = "Navaneethan" Then Response.Write("selected")%>>Navaneethan</OPTION>
				  <OPTION value="Ashok" <%if trim(rec("FixedBy")) = "Ashok" Then Response.Write("selected")%>>Ashok</OPTION>
				  <OPTION value="Sivakumar" <%if trim(rec("FixedBy")) = "Sivakumar" Then Response.Write("selected")%>>Sivakumar</OPTION>
				  <OPTION value="Vasanth" <%if trim(rec("FixedBy")) = "Vasanth" Then Response.Write("selected")%>>Vasanth</OPTION>
				  <OPTION value="Dipankar" <%if trim(rec("FixedBy")) = "Dipankar" Then Response.Write("selected")%>>Dipankar</OPTION>
				  <OPTION value="Majo" <%if trim(rec("FixedBy")) = "Majo" Then Response.Write("selected")%>>Majo</OPTION>
				  <OPTION value="Kuttalraj" <%if trim(rec("FixedBy")) = "Kuttalraj" Then Response.Write("selected")%>>Kuttalraj</OPTION>
				  <OPTION value="Maheswari" <%if trim(rec("FixedBy")) = "Maheswari" Then Response.Write("selected")%>>Maheswari</OPTION>
				  <OPTION value="Ravisankar" <%if trim(rec("FixedBy")) = "Ravisankar" Then Response.Write("selected")%>>Ravisankar</OPTION>
				  </SELECT></TD>
  </TR>
  
  <TR>
    <TD align="right"><B>Fixed Date</B></TD>
    <TD width=300><% =rec("FixedDate")%></TD>
  </TR>

  <TR>
    <TD align="right"><B>Verified By</B></TD>
    <TD width=300><SELECT name="cbVerifiedBy"> 
				  <OPTION value="All" <%if trim(rec("VerifiedBy")) = "All" Then Response.Write("selected")%>>All</OPTION>				  
				  <OPTION value="Ramaraju" <%if trim(rec("VerifiedBy")) = "Ramaraju" Then Response.Write("selected")%>>Ramaraju</OPTION>
				  <OPTION value="Ramesh Viswanathan" <%if trim(rec("VerifiedBy")) = "Ramesh Viswanathan" Then Response.Write("selected")%>>Ramesh Viswanathan</OPTION>
				  <OPTION value="Sivaraj" <%if trim(rec("VerifiedBy")) = "Sivaraj" Then Response.Write("selected")%>>Sivaraj</OPTION>
				  <OPTION value="Venkatesh" <%if trim(rec("VerifiedBy")) = "Venkatesh" Then Response.Write("selected")%>>Venkatesh</OPTION>
				  <OPTION value="Jayakumar" <%if trim(rec("VerifiedBy")) = "Jayakumar" Then Response.Write("selected")%>>Jayakumar</OPTION>
				  <OPTION value="Rajendra" <%if trim(rec("VerifiedBy")) = "Rajendra" Then Response.Write("selected")%>>Rajendra</OPTION>
				  <OPTION value="Saravana" <%if trim(rec("VerifiedBy")) = "Saravana" Then Response.Write("selected")%>>Saravana</OPTION>
				  <OPTION value="Zheeshan" <%if trim(rec("VerifiedBy")) = "Zheeshan" Then Response.Write("selected")%>>Zheeshan</OPTION>
				  <OPTION value="Britto" <%if trim(rec("VerifiedBy")) = "Britto" Then Response.Write("selected")%>>Britto</OPTION>
				  <OPTION value="Roopesh" <%if trim(rec("VerifiedBy")) = "Roopesh" Then Response.Write("selected")%>>Roopesh</OPTION>
				  <OPTION value="Vijay" <%if trim(rec("VerifiedBy")) = "Vijay" Then Response.Write("selected")%>>Vijay</OPTION>
				  <OPTION value="Obula Reddy" <%if trim(rec("VerifiedBy")) = "Obula Reddy" Then Response.Write("selected")%>>Obula Reddy</OPTION>
				  <OPTION value="Ramesh Kota" <%if trim(rec("VerifiedBy")) = "Ramesh Kota" Then Response.Write("selected")%>>Ramesh Kota</OPTION>
				  <OPTION value="Priya" <%if trim(rec("VerifiedBy")) = "Priya" Then Response.Write("selected")%>>Priya</OPTION>
				  <OPTION value="Ramnath" <%if trim(rec("VerifiedBy")) = "Ramnath" Then Response.Write("selected")%>>Ramnath</OPTION>
				  <OPTION value="TVS" <%if trim(rec("VerifiedBy")) = "TVS" Then Response.Write("selected")%>>TVS</OPTION>
				  <OPTION value="Narasimhan" <%if trim(rec("VerifiedBy")) = "Narasimhan" Then Response.Write("selected")%>>Narasimhan</OPTION>
				  <OPTION value="Satheesh" <%if trim(rec("VerifiedBy")) = "Satheesh" Then Response.Write("selected")%>>Satheesh</OPTION>
				  <OPTION value="Jaiganesh" <%if trim(rec("VerifiedBy")) = "Jaiganesh" Then Response.Write("selected")%>>Jaiganesh</OPTION>
				  <OPTION value="Palani" <%if trim(rec("VerifiedBy")) = "Palani" Then Response.Write("selected")%>>Palani</OPTION>
				  <OPTION value="Navaneethan" <%if trim(rec("VerifiedBy")) = "Navaneethan" Then Response.Write("selected")%>>Navaneethan</OPTION>
				  <OPTION value="Ashok" <%if trim(rec("VerifiedBy")) = "Ashok" Then Response.Write("selected")%>>Ashok</OPTION>
				  <OPTION value="Sivakumar" <%if trim(rec("VerifiedBy")) = "Sivakumar" Then Response.Write("selected")%>>Sivakumar</OPTION>
				  <OPTION value="Vasanth" <%if trim(rec("VerifiedBy")) = "Vasanth" Then Response.Write("selected")%>>Vasanth</OPTION>
				  <OPTION value="Dipankar" <%if trim(rec("VerifiedBy")) = "Dipankar" Then Response.Write("selected")%>>Dipankar</OPTION>
				  <OPTION value="Majo" <%if trim(rec("VerifiedBy")) = "Majo" Then Response.Write("selected")%>>Majo</OPTION>
				  <OPTION value="Kuttalraj" <%if trim(rec("VerifiedBy")) = "Kuttalraj" Then Response.Write("selected")%>>Kuttalraj</OPTION>
				  <OPTION value="Maheswari" <%if trim(rec("VerifiedBy")) = "Maheswari" Then Response.Write("selected")%>>Maheswari</OPTION>
				  <OPTION value="Ravisankar" <%if trim(rec("VerifiedBy")) = "Ravisankar" Then Response.Write("selected")%>>Ravisankar</OPTION>
				  </SELECT></TD>
  </TR>

  <TR>
    <TD align="right"><B>Verified Date</B></TD>
    <TD width=300><% =rec("VerifiedDate")%></TD>
  </TR>

  <INPUT type="hidden" name="hIdentifier" value = <%=id%>>
  </TABLE>
  <TABLE align="center" border=1 width=600 class="tdbglight">
  <TR>
    <TD align="middle"><INPUT type="submit" value="Update">
    </TD>
  </TR>
</TABLE>
</FORM>
<BR>
<!-- #include file="../Includes/footer.inc" -->
</BODY>
</HTML>
