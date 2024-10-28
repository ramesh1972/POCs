<%@ Language=VBScript %>
<%
lUserId=request.form("selUsrId")
lAccType=request.form("selAccounttype")

dim lobjRsUser
dim lObjBnkGrp
dim lObjRsBnkGrp
dim lObjRsBrnCode
dim lSplitRes
set lObjBnkGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsBnkGrp=server.CreateObject("adodb.recordset")
set lObjRsBrnCode=server.CreateObject("adodb.recordset")
set lobjRsUser=lObjBnkGrp.GetUsers()
set lObjRsBnkGrp=lObjBnkGrp.GetBankCodes()
if Request.Form("txtBnkCode")<>"" then
   set lObjRsBrnCode=lObjBnkGrp.GetBranchCodes(Request.Form("txtBnkCode"))
end if

		if lobjRsUser.BOF=false then
		lobjRsUser.movefirst
		end if
'*** for Date and Time 

	dim StartMonth
	dim StartDate
	dim startYear
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
'*****
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
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmChargeSelection.OptBnKCode.selectedIndex;
		var j=document.frmChargeSelection.OptBnKCode.options[i].value;
		document.frmChargeSelection.txtBnkCode.value =j;  
    	document.frmChargeSelection.submit();
	}
	
	function FunctionCancel()
	{
	 document.frmChargeSelection.action="UbnkMenu.asp";
	 document.frmChargeSelection.submit();
	}    
	
	function btnClick()
	{	
	if (document.frmChargeSelection.selUsrId.value=="")
	{
	alert("Select Userid please");
	return false;
	}
	if (document.frmChargeSelection.selAccounttype.value=="")
	{
	alert("Select Accounttype please");
	return false;
	}
	if (document.frmChargeSelection.OptBnKCode.value=="")
	{
	alert("Select BankCode please");
	return false;
	}
	if (document.frmChargeSelection.txtAccountNo.value=="")
	{
	alert("Enter Account number...");
	document.frmChargeSelection.txtAccountNo.focus();
	return false;
	}
	if ((document.frmChargeSelection.StartMonth.value=="")||(document.frmChargeSelection.StartDate.value==""))
	{
	alert("select Month and  date ...");
	return false;
	}
	else
 	{
			document.frmChargeSelection.action="ubnkaddRes.asp";
			document.frmChargeSelection.method="post";
			document.frmChargeSelection.submit(); 	
			return true;
	}
}

	
	</script>
	<HTML>
	<HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    </head>

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class="bodycolor">
	<form name="frmChargeSelection"  method="post">
	<center>
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	
	<%
	If not  lObjRsBnkGrp.EOF then
	%>
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">User Bank Details</td>
	</tr>
	
	<TR><TD class=tdbglight width=202 height="13"><font class=blacktext>User&nbsp;
        Id:</font></TD>
		<TD WIDTH="303" CLASS=tdbglight height="13"> 
		<select size="1" name="selUsrId" style="HEIGHT: 22px; WIDTH: 150px">
		<option selected value="">-- User Ids--</option>
		<%
			while not lobjRsUser.EOF %>
			<option <%if lobjRsUser(0)=lUserId then response.write "selected"%> value="<%=lobjRsUser(0)%>" <%if lobjRsUser(0)=Request.Form("txtUserId") then Response.Write "selected"%>> <%=lobjRsUser(0)%></option>
			<%lobjRsUser.MoveNext 
			wend
			%>
		</select> </td>
		</TR>
		<TR><TD class=tdbglight width=202 height="23"><font class=blacktext>Account
            Type:</font></TD>
		<TD WIDTH="303" CLASS=tdbglight height="23"> 
		<select size="1" name="selAccounttype" style="HEIGHT: 22px; WIDTH: 150px" >
		<option <%if lAccType="C" then response.write "selected" %> value="C">Clearing Account</option>
		<option <%if lAccType="M" then response.write "selected" %> value="M">Margin Account</option>

		</select> </td>
		</TR>
	 <TR><TD class=tdbglight width=20% height="20"><font class=blacktext>Bank code</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptBnKCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option selected value="">Select Bank Code</option>
	<%
	if not lObjRsBnkGrp.EOF and trim(Request.Form("txtBnkCode"))="" then
		do while not lObjRsBnkGrp.EOF %>
			<option <%'if trim(lObjRsBnkGrp(0))=trim(Request.Form("txtBnkCode")) then Response.Write "selected"%> value="<%=lObjRsBnkGrp(0)%>"><%=lObjRsBnkGrp(0)%></option>
			<%lObjRsBnkGrp.MoveNext 
		loop
	else
		do while not lObjRsBnkGrp.EOF%>
			<option <%if trim(lObjRsBnkGrp(0))=trim(Request.Form("txtBnkCode")) then Response.Write "selected"%> value="<%=lObjRsBnkGrp(0)%>"><%=lObjRsBnkGrp(0)%></option>
			<%lObjRsBnkGrp.MoveNext 
		loop
	end if
		%>
		</select>
		<input type=hidden name="txtBnkCode">
		<tr><TD class=tdbglight width=30% height="25"><font class=blacktext>Branch Code </font></TD>
		<%if Request.Form("txtBnkCode")<>"" then%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5">
			<select size="1" name="OptBrnCode" style="HEIGHT: 22px; WIDTH: 150px">
				<!--<option value="ALL">ALL</option>-->
		<%
		if not lObjRsBrnCode.EOF then
			do while not lObjRsBrnCode.EOF %>
				<option value=<%=lObjRsBrnCode(0)%>><%=lObjRsBrnCode(0)%></option>
				<%lObjRsBrnCode.MoveNext 
			loop
		end if
		%>
		</select> </td>
		
		<%else%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5"><font class=blacktext2>Select BankCode  to Display BranchCode</font></td>
		<%end if
		%>
	</tr>
	<TR>
			<TD class=tdbglight width=202 height="23"><font class=blacktext>Account Number:</font></TD>
			<TD width="303" class=tdbglight height="23"> <INPUT NAME="txtAccountNo" size="24"> </Td>
		</Tr>
		 <TR >
			<TD class=tdbglight width="160" height="10">
				<font class=blacktext>Please Select the Date</font>
			</TD>
			<TD WIDTH="200" CLASS=tdbglight height="10"> 
				<select size="1" name="StartMonth" style="height: 23; width: 72" >
					<option value="">Months</option>
					<OPTION  value="1"  <%'if LMONTH=1 then Response.Write "selected"%>>January</OPTION>
					<OPTION value="2" <%'if LMONTH=2 then Response.Write "selected"%> >February</OPTION>
					<OPTION value="3"  <%'if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
					<OPTION value="4" <%'if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
					<OPTION value="5" <%'if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
					<OPTION value="6" <%'if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
					<OPTION value="7" <%'if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
					<OPTION value="8" <%'if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
					<OPTION value="9" <%'if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
					<OPTION value="10" <%'if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
					<OPTION value="11" <%'if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
					<OPTION value="12" <%'if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
				</select> 
				<select size="1" name="StartDate" style="height: 23; width: 55" >
					<option value="">Date</option>
					<OPTION  value="1" <%'if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%'if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3"  <%'if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%'if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5"  <%'if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%'if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7"  <%'if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%'if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9"  <%'if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%'if LDATE=10 then Response.Write "selected"%>>10</OPTION>
					<OPTION value="11" <%'if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%'if LDATE=12 then Response.Write "selected"%>>12</OPTION>
					<OPTION value="13" <%'if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%'if LDATE=14 then Response.Write "selected"%>>14</OPTION>
					<OPTION value="15" <%'if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%'if LDATE=16 then Response.Write "selected"%>>16</OPTION>
					<OPTION value="17" <%'if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%'if LDATE=18 then Response.Write "selected"%>>18</OPTION>
					<OPTION value="19" <%'if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%'if LDATE=20 then Response.Write "selected"%>>20</OPTION>
					<OPTION value="21" <%'if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%'if LDATE=22 then Response.Write "selected"%>>22</OPTION>
					<OPTION value="23" <%'if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%'if LDATE=24 then Response.Write "selected"%>>24</OPTION>
					<OPTION value="25" <%'if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%'if LDATE=26 then Response.Write "selected"%>>26</OPTION>
					<OPTION value="27" <%'if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%'if LDATE=28 then Response.Write "selected"%>>28</OPTION>
					<OPTION value="29" <%'if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%'if LDATE=30 then Response.Write "selected"%>>30</OPTION>
					<OPTION value="31" <%'if LDATE=31 then Response.Write "selected"%>>31</OPTION>
				</select>
				<select name="StartYear"  size="1" name="Year" style="HEIGHT: 22px; WIDTH: 55px" >
					<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION>
				</select>
			</TD>
		</TR>


	
	<tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAdd"   value="Add"   onclick ="btnClick()">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel" onclick="FunctionCancel();">
	</td>
	</tr>
	</table>
	
<%end if 
set lObjComgGrp=nothing
set lObjRsBnkGrp=nothing
set lObjRsBrnCode=nothing
%>
    <br><br>
    <!--#include file="../Includes/footer.inc"> -->
   	</FORM>
	</body>
</Html>
	

