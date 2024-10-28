<%@ Language=VBScript %>
<%

    '**************************************************************************
	'* Application	:	BCE								    				   		  *
	'* Module		   :   Broker Admin										  		*
	'* File name	   :	ubnkview.asp               					  *
	'* Purpose		   :	This page will display   bank detial of a particular user           *
	'*                  code                                                  * 
	'* Prepared by	:	shaikh md zeeshan                 						  *	
	'* Date			:	30.11.2001											  			*
	'* Copyright	:	(c) SSI Technologies,India							  			*
	'*																		  				*
	'**************************************************************************

	'**************************************************************************
	'* General Notes														             *
	'* This page will display a record based on userid                  *
	'* Client Side	:	Javascript											          *
	'*																		              *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														          *
	'* Version No.- Date		- By				   - Explanation	   	             *
	'*	1		            - shaik md zeeshan              First Baseline      *
	'**************************************************************************
	dim CURRENTDATE
	dim lYearPrev
	dim lYearCurrent
	dim lYearNext
	dim butAction
	'*******
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR = YEAR(CURRENTDATE)
	LYEAR1 = LYEAR+1
	lYearCurrent  = LYEAR
	lYearPrev	= LYEAR - 1
	lYearNext   = LYEAR + 1
'*****for date
if Request.Form("StartDate")="" then
		lStartDate	=	Request.Form("hidStartDate")
	else
		lStartDay	=	cstr(Request.Form("StartDate"))
		if len(lStartDay) <=1  then
			lStartDay	=	0	&	lStartDay
		end if
			lStartMonth	=	cstr(Request.Form("StartMonth")) 
		if len(lStartMonth)<=1 then
			lStartMonth	=	0 & lStartMonth
		end if
			lStartYear	=	cstr(Request.Form("StartYear"))
			lStartDate	=	lStartYear & "-" & lStartMonth & "-" & lStartDay
			lStartDate	=	cstr(lStartDate)
	end if
	

%>



<HTML>
<HEAD>
<style>
		a {text-decoration:none}
		a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
	<title>Welcome to the bombay oilseeds and oils exchange limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
	<script language="javascript">
		function fn_Go()
		{
			document.UsrBankDetailupdate.method="post";
			document.UsrBankDetailupdate.action="UbnkDelRes.asp";
			document.UsrBankDetailupdate.submit();
		}
		</script>
	</HEAD>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<%
 dim lUsrID
 dim lAcctype
 dim lbankcode
 dim lBranchcode
 dim lAccno
 dim lAccOpenYear
 dim lAccOpenmonth
 dim lAccOpenday
 dim lResult
 dim lResultValues
 dim lDisValue
 dim luserid
 
	set lObjUsrBankDetail	= server.CreateObject("Mac.UserBankMgr")
	lUsrID	= trim(Request.Form("selUsrId"))
	lAcctype	= trim(Request.Form("selAccounttype"))
 	
	lbankcode=Request.Form("optBnkCode")
	lBranchcode= trim(Request.Form("OptBrnCode"))
 	
	lResult = lObjUsrBankDetail.DoUsrBnkView(lUsrID,lbankcode, lBranchcode, lAcctype,lAccno,lAccOpenYear)
	
	select case lResult
    case "0":
		lResponse = "hello"
	case "100":
		lResponse = "Record Does not Exist"	
	case "1800":
		lResponse = "The System Date doesn't match"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	End Select
%>
<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	

<%	
	if lResult = "0" then	
%>


<center>
<form name="UsrBankDetailupdate"  method="post" >
<table width="640" border="1"  cellpadding=2 cellspacing=2 align=center height="208">
<tr class="tdbgdark">
 <td valign=center colspan=3 class="whiteboldtext1" width="628" height="19">User Bank Detail</td>
 </tr>
	 <TR><TD class=tdbglight width=202 height="13"><font class=blacktext>User&nbsp;
        </font></TD>
        <TD width="303" class=tdbglight height="23">
			<%=lUsrID%>        <input name="selUsrId" type=hidden value="<%=lUsrID%>">
		 <!--<INPUT NAME="selUsrId" size="19" > -->

		
		<TR><TD class=tdbglight width=202 height="23"><font class=blacktext>Account
            Type:</font></TD>
       <TD width="303" class=tdbglight height="23">
       <%=lAcctype%> <input name="selAccounttype" type=hidden value="<%=lAcctype%>">
		<!-- <INPUT NAME="selAccounttype" size="19" > --> </TD>
     	</TR>
		
	   <TR><TD class=tdbglight width=202 height="23"><font class=blacktext>Bank Code:</font></TD>
	   <TD width="303" class=tdbglight height="23">
	   		<%=lbankcode%><input name="selBankCode" type=hidden value="<%=lbankcode%>">
		 	<!--<INPUT NAME="selBankCode" size="19" > --> 
		 </TD>
		</TR>
		<TR>
			<TD class=tdbglight width=202 height="23"><font class=blacktext>Branch Code:</font></TD>
			<TD width="303" class=tdbglight height="23">
				<%=lBranchcode%><input name="selBranchCode" type=hidden value="<%=lBranchcode%>">
				<!--  <INPUT NAME="selBranchCode" size="19" > -->
			 </TD>
	  </TR>
	 	  
		
		<TR>
			<TD class=tdbglight width=202 height="23"><font class=blacktext>Account Number:</font></TD>
			<TD width="303" class=tdbglight height="23"> 
			 <INPUT value=<%=lAccno%></TD>
		</TR>
		
		<TR>
			<TD class=tdbglight width=202 height="23"><font class=blacktext>Account Open Date:</font></TD>
			<TD width="303" class=tdbglight height="23"> 
			 <INPUT NAME="txtAccno" size="19" value=" <%=lAccOpenYear%>"></TD>
		</TR>
		
			
		 <tr>
			 <td colspan=3 valign="center" align=middle class="tdbglight" height="16" width="628">
   		  	<input type="button" name="sbtViewUser"   value="Delete" onclick=" fn_Go();" >&nbsp;&nbsp;&nbsp;
        	<input type="reset" name="sbtCancel" value="Cancel">
			</td>
				</tr>
	</table>
  </form>
<%else%>
<br>
<center>
<Table width="40%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>User Bank Details </font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1><%=lResponse%> Click <a href="UbnkMenu.asp">here</a> to back  the previous UpdateDailogBox</font></td>
		</tr>
</Table>
</center>
<br><br><br>
<%end if%>
 <!---#include file="../Includes/footer.inc"---> 
   	
</center>
</body>
</html>





























