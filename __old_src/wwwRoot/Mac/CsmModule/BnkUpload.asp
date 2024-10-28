<%@ Language=VBScript %>
<%

 %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
<TITLE>Download Exchange</TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
</HEAD>
<script language =javascript>
	function funcupload()
	{
		
		document.form1.method ="post";
		document.form1.action ="BnkUploadRes.asp";
		document.form1.submit();
	//alert("upload");
	}
	function funcexit()
	{
	document.form1.action ="UpdateFileUpload.asp";
	document.form1.method ="post";
	document.form1.submit();
	}
	/*function SelectAll()
		{			
			var k = document.form1.hidctn.value;
			alert(k);
			if (document.form1.selectall.checked==true)	
				{
				for(i=1;i<=k;i++)	
					{
						var m = "C";
						var n = i;
						var O = m + n;
						var x =  "document.form1.";
						var y= ".checked";
						var h1=(x+O+y);
						eval(h1+'=true');
					}
				}
			else
				{
				for(i=1;i<=k;i++)
				{
					var m = "C";
					var n = i;
					var O = m + n;
					var x =  "document.form1.";
					var y= ".checked";
					var h1=(x+O+y);
					eval(h1+'=false');
				}   
		}
	} */
	  
	</script>
<BODY>
<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->

<form name="form1" method="post" ENCTYPE="multipart/form-data" action="UpdateFileUpload.asp">
<%
Const ForReading = 1 , ForWriting = 2
  Dim fso, f
  dim filename
  Set fso = CreateObject("Scripting.FileSystemObject")
	
	dd=day(date)
	if len(dd)=1 then dd="0"&dd
	mm=month(date)
	if len(mm)=1 then mm="0"&mm
	yy=year(date)
	
	webserverdate=cstr(yy)+"-"+cstr(mm)+"-"+cstr(dd)
	
	'filename="tcmm2mdetail-" & webserverdate & ".txt"
	filename="tmpBnkdetail.txt"
	
	if fso.FileExists(server.MapPath(filename)) then
	Set f = fso.OpenTextFile(server.MapPath(filename), ForReading)
	Dim WriteLineToFile
  %>
<table width="100%" border="1" cellpadding="1"  cellspacing="1" align="center">
	<tr class=tdbglight height=10 align="middle" >
 		<td><font class=blackboldtext1 align="center">Upload Bank Details</font></td>
 	</tr>
</table>
<table width="100%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr class=tdbgdark height=30 align="middle">
		<td width="10%" align="middle"><font class=whiteboldtext1>Date</font></td>
		<td width="10%" align="middle"><font class=whiteboldtext1>Account No</font></td>
		<td width="20%" align="middle"><font class=whiteboldtext1>User Name</font></td>
		<td width="10%" align="middle"><font class=whiteboldtext1>Account Type</font></td>
		<td width="10%" align="middle"><font class=whiteboldtext1>Amount Type</font></td>
		<td width="10%" align="middle"><font class=whiteboldtext1>Acount(Rs.)</font></td>
		<td width="10%" align="middle"><font class=whiteboldtext1>Remarks </font></td>
   </tr>
</table>
<%

 Do While Not f.AtEndOfLine 
 WriteLineToFile = f.Readline
 

 dim sp 
 sp = split( WriteLineToFile ,",")
 on error resume next
%>
<table width="100%" border=1 cellpadding=1 cellspacing=1 align="center">
<tr class=tdbglight height=10 align="middle" >
   <td width="10%" align="middle"><font class=blacktext2><%Response.Write sp(0) %></font></td>
   <td width="10%" align="right"><font class=blacktext2><%Response.Write sp(1) %></font></td>
   <td width="20%" align="left"><font class=blacktext2><%Response.Write sp(2) %></font></td>
   <td width="10%" align="middle"><font class=blacktext2><%if trim(ucase(sp(3)))= "M" then
					                                Response.Write "Margin" 
					                             elseif trim(ucase(sp(3)))= "C" then
					                                 Response.Write "Clearing"
					                             else
					                                 Response.Write "Invalid"
					                             end if %></font></td>
   <td width="10%" align="middle"><font class=blacktext2><%if trim(ucase(sp(4)))= "D" then
					                                Response.Write "Debit" 
					                             elseif trim(ucase(sp(4)))= "C" then
					                                 Response.Write "Credit"
					                             else
					                                 Response.Write "Invalid"
					                             end if %></font></td>
   <td width="10%" align="right"><font class=blacktext2><%Response.Write sp(5) %></font></td>
   <td width="10%" align="middle"><font class=blacktext2><%Response.Write sp(6) %></font></td>
   
</tr>
</table> 
<%'for i = 1 to f.AtEndOfLine%>
<!--
<input type="hidden" name="hidfldzero" value=<%=sp(0)%>>
<input type="hidden" name="hidfld1" value=<%=sp(1)%> >
<input type="hidden" name="hidfld2" value="<%'=sp(2)%>">
<input type="hidden" name="hidfld3" value="<%'=sp(3)%>">
<input type="hidden" name="hidfld4" value="<%'=sp(4)%>">
<input type="hidden" name="hidfld5" value="<%'=sp(5)%>">
<input type="hidden" name="hidfld6" value="<%'=sp(6)%>">  
-->
<%
'next
loop
%>
<%end if'If file exist
'for i = 1 to f.AtEndOfLine
'Response.Write WriteLineToFile%>

<input type="hidden" name="hidctn" value="<%=WriteLineToFile%>">
<%'next%>

<br>
<table  width="55%" border=1 cellpadding=1 cellspacing=1 align="center" >
	<tr WIDTH="55%" class=tdbglight height=10 align="left">
	<td colspan=4 align="center">
	   <input type=file id=file1 name=file1 onchange="form1.submit();" value="File" style="WIDTH: 70px"> &nbsp;&nbsp;
       <!--<input style="WIDTH: 80px" type="submit" name="subBrowse1" value="View" > &nbsp;&nbsp;-->
       <input style="WIDTH: 80px" type="submit" name="subupload" value="Upload" onclick="funcupload()"> &nbsp;&nbsp;
       <input style="WIDTH: 80px" type="button" name="btnexit" value="Exit" onclick="funcexit();">
	</TD>
     </tr>  
</table>
</br>
</form>
</BODY>
</HTML>
