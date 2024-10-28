<%@ Language=VBScript %>
<% Option Explicit
	Dim lname 
	Dim ltitle
	Dim ldesc
	
	Dim lobjUser
%>

<%	lname = Request.Form("ebName") 
	ltitle = Request.Form("ebTitle")
	ldesc = Request.Form("taDescription")
		
	Set lobjUser = Server.CreateObject("User.clsUser")
	lobjUser.InsertUserProblem (lname, ltitle, ldesc)
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<!-- #include File="psdb-user-view.asp" --> 


</BODY>
</HTML>
