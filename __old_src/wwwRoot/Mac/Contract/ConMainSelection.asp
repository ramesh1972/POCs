<%@Language=VBSCRIPT%>
<%
Option Explicit
%>
<%
	dim StartMonth
	dim StartDate
	dim startYear
	dim CURRENTDATE
	dim lYearPrev
	dim lYearCurrent
	dim lYearNext
	dim lMonth
	dim lDate
	dim lYear
	dim lDay
	dim lYear1
	dim lStartDate
	dim lStartDay
	dim lStartMonth
	dim lStartYear
	dim lDateCurrent
	dim lMonthCurrent
	'*******
	CURRENTDATE=NOW()
	lMonth= MONTH(CURRENTDATE)
	lDate=DAY(CURRENTDATE)
	lYear = YEAR(CURRENTDATE)
	lYear1 = lYear+1
	lYearCurrent  = lYear
	lDateCurrent  = lDate
	lMonthCurrent = lMonth
	lYearPrev	= lYear - 1
	lYearNext   = lYear + 1
	
	dim lConMainRs
	Dim lConMainObj
	set lConMainObj = server.CreateObject("MacWebCon.clsMacWebCon")
	set lConMainRs = server.CreateObject("ADODB.Recordset") 
	Set lConMainRs  = lConMainObj.GetContractCodes()
%>	
<HTML>
 <HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
		</style>
		<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
		<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
 </HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<script language =javascript>
	function validateDate()
	{
		lDate	= document.ContMainSelection.StartDate.value ;
		lMonth	= document.ContMainSelection.StartMonth.value;
		lYear	= document.ContMainSelection.StartYear.value;
		lDay	=	new Date(lMonth + '/' + lDate +'/'+ lYear );
		if ((validDate(lMonth,lDate,lYear))== false )
	{
			document.ContMainSelection.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
	}
	return true;
	}
	function IntChange()
	{
			document.ContMainSelection.hidContCode.value = document.ContMainSelection.optContCode.options[document.ContMainSelection.optContCode.selectedIndex].value;
			document.ContMainSelection.hidStatus.value = document.ContMainSelection.optStatus.options[document.ContMainSelection.optStatus.selectedIndex].value;  	
			document.ContMainSelection.hidStartMonth.value = document.ContMainSelection.StartMonth.options[document.ContMainSelection.StartMonth.selectedIndex].value;
			document.ContMainSelection.hidStartDate.value = document.ContMainSelection.StartDate.options[document.ContMainSelection.StartDate.selectedIndex].value;
			document.ContMainSelection.hidStartYear.value = document.ContMainSelection.StartYear.options[document.ContMainSelection.StartYear.selectedIndex].value;    
	}
	function instChk()
	{
		if (document.ContMainSelection.optContCode.value =="")
		{
			alert("Select A Contract");
			return false;
		}
	}
	function instStstuschk()
	{	
		if (document.ContMainSelection.optStatus.value =="")
		{
			alert("Select a Status");
			return false;
		}
	}
	function FuncBrowse()
	{
		document.ContMainSelection.action ="ContractBrowse.asp";
		document.ContMainSelection.hidBstatus.value="B";
		document.ContMainSelection.method ="post";
		document.ContMainSelection.submit();
	}
	
	function FunctionCancel()
	{
		document.ContMainSelection.action ="maccontract.asp";
		document.ContMainSelection.method ="post";
		document.ContMainSelection.submit();
    }	
	
	
	function validateContractCode()
	{
		document.ContMainSelection.optContCode.disabled=false;
		document.ContMainSelection.hidSContCode.value=document.ContMainSelection.radioContract.value;
		document.ContMainSelection.optStatus.disabled=true;
		document.ContMainSelection.StartMonth.disabled=true;
		document.ContMainSelection.StartDate.disabled=true;
		document.ContMainSelection.StartYear.disabled=true;
	    
	}
	
	function validateOther()
	{
		document.ContMainSelection.optContCode.disabled=true;
		document.ContMainSelection.optStatus.disabled=false;
		document.ContMainSelection.StartMonth.disabled=false;
		document.ContMainSelection.StartDate.disabled=false;
		document.ContMainSelection.StartYear.disabled=false;
		document.ContMainSelection.hidSOther.value=document.ContMainSelection.radioOther.value;
	
	}
	
	</script>
	<form method=post  action ="ConMainSelection.asp" name="ContMainSelection">
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	
	<table align="center" width="50%" border="1" cellspacing="1" cellpadding="1">
	<tr class="tdbglight">
		<td width="30%"><font class=blacktext>Search By</font></td>
		<td class="blacktext"><input type="radio" size="10" name="radioContract" value="C"  onclick="return validateContractCode();">Contract Code</td>
		<td class="blacktext" colspan=2><input type="radio" size="10" name="radioOther" value="O" onclick="return validateOther();">Other than Contract Code </td>
    </tr> 
	
       <tr class="tdbglight">
		<td width="30%"><font class=blacktext>Contract Code</td>
		<CENTER>
		<td WIDTH="30%"  colspan=3>
				<SELECT style="WIDTH: 153px" class=tdbglight name="optContCode" onchange="IntChange()">
			<OPTION value="" selected>Select one</OPTION>
			<%if not(lConMainRs.BOF and lConMainRs.EOF) then
				while not lConMainRs.EOF %>
					<%if trim(Request.Form("hidContCode"))= lConMainRs("inst_code") then%>
   						<option value=<%=lConMainRs("INST_CODE")%> selected> <%=lConMainRs("INST_CODE")%></option>
					<%else%>
						<option value=<%=lConMainRs("INST_CODE")%>> <%=lConMainRs("INST_CODE")%></option>
					<%end if
						lConMainRs.MoveNext 
				wend
			end if
			lConMainRs.MoveFirst 
			%>
		</SELECT>
		</td>
		</tr>
		
		<tr class="tdbglight">
		<td width="30%"><font class=blacktext>Status</td>
		<CENTER>
		<td WIDTH="30%"  colspan=3>
			<SELECT style="WIDTH: 153 px"  name="optStatus" onchange="IntChange()">
					<OPTION selected value="ALL">Select One</OPTION>	
					<option value="N">Active</option>
					<option value="P">Suspended</option>
			</SELECT>
		</td>
		</tr>
		<tr class="tdbglight">
		<TD width="30%"><font class=blacktext>Find Listed Date</font></TD>
		<CENTER>
		<td WIDTH="20%"  colspan=3>
		
		<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 50px" onchange="IntChange()">
					
					<OPTION  value="1" <%'if LMONTH=1 then Response.Write "selected"%>>Jan</OPTION>
					<OPTION value="2" <%'if LMONTH=2 then Response.Write "selected"%>>Feb</OPTION>
					<OPTION value="3" <%'if LMONTH=3 then Response.Write "selected"%>>Mar</OPTION>
					<OPTION value="4" <%'if LMONTH=4 then Response.Write "selected"%>>Apr</OPTION>
					<OPTION value="5" <%'if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
					<OPTION value="6" <%'if LMONTH=6 then Response.Write "selected"%>>Jun</OPTION>
					<OPTION value="7" <%'if LMONTH=7 then Response.Write "selected"%>>Jul</OPTION>
					<OPTION value="8" <%'if LMONTH=8 then Response.Write "selected"%>>Aug</OPTION>
					<OPTION value="9" <%'if LMONTH=9 then Response.Write "selected"%>>Sep</OPTION>
					<OPTION value="10" <%'if LMONTH=10 then Response.Write "selected"%>>Oct</OPTION>
					<OPTION value="11" <%'if LMONTH=11 then Response.Write "selected"%>>Nov</OPTION>
					<OPTION value="12" <%'if LMONTH=12 then Response.Write "selected"%>>Dec</OPTION>
				</select> 
				<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px"  onchange="IntChange()">
					<OPTION  value="1" <%'if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%'if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3" <%'if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%'if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5" <%'if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%'if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7" <%'if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%'if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9" <%'if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%'if LDATE=10 then Response.Write "selected"%>>10</OPTION>
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
				<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" onchange="IntChange()" >
					
					<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION>
				</select>
			</TD>
		</TR>
	</table>
		<br>
		<input type="hidden" name="hidContCode" >
		<input type="hidden" name="hidStatus">
		<input type="hidden" name="hidStartMonth" >
		<input type="hidden" name="hidStartDate" >
		<input type="hidden" name="hidStartYear" >
		<input type="hidden" name="hidSContCode">
		<input type="hidden" name="hidSOther">
		<Input type="hidden" name="hidBstatus">
		<center>
		<input type="submit" name="btnBrowse" value="Browse" onclick="FuncBrowse();">
		<input type="submit" name="btnExit" value="Cancel" onclick="FunctionCancel();">
		</center>
		<br><br>
		<!---#include file="../Includes/footer.inc"---> 
   	
		</form>
		</body>	
	    </HTML>