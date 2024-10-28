<%@language="vbscript"%>
<%
		dim objRsMac
		dim StartMonth
		dim StartDate
		dim startYear
		dim LMONTH
		DIM LYEAR
		DIM LYEAR1
		DIM LDATE
		DIM CURRENTDATE
		dim lYearPrev
		dim objMacWeb
		CURRENTDATE=NOW()
		LMONTH= MONTH(CURRENTDATE)
		LDATE=DAY(CURRENTDATE)
		LYEAR=YEAR(CURRENTDATE)
		LYEAR1=LYEAR+1
		lYearPrev	= LYEAR -1
		dim dtmFrom
		dim dtmTo
		dtmFrom = cstr(Request.form("StartYear")) & "-" & cstr(Request.Form("StartMonth")) & "-" & cstr(Request.Form("StartDate"))
		dtmTo=cstr(Request.form("EndYear")) & "-" & cstr(Request.Form("EndMonth")) & "-" & cstr(Request.Form("EndDate"))
		set objMacWeb=server.CreateObject("MacWebCon.clsMacWebCon")
		set objRsMac=server.CreateObject("ADODB.Recordset")
		
		set objRsMac=objMacWeb.GetNonLiveContractCodes()
		
		if objRsMac.BOF =false then
			objRsMac.MoveFirst 
	%>
	    
     	
	<script language="javascript">
	function validateDate()
	{
	if (document.frmMrktView.rdoContDate(1).checked == true)
	{
		lSDate	= document.frmDateSelect.StartDate.value ;
		lSMonth	= document.frmDateSelect.StartMonth.value;
		lSYear	= document.frmDateSelect.StartYear.value;
		lEDate	=	document.frmDateSelect.EndDate.value;
		lEMonth	=	document.frmDateSelect.EndMonth.value;
		lEYear	=	document.frmDateSelect.EndYear.value;  
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		lEDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear);
		if (lSDay > lEDay) 
		{
			document.frmDateSelect.StartMonth.focus(); 
			alert("Start date should be Lesser than End date");
			return false;
		}
		if ((validDate(lSMonth,lSDate,lSYear))== false )
		{
			document.frmDateSelect.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
		}
		if ((validDate(lEMonth,lEDate,lEYear))== false)
		{
			document.frmDateSelect.EndDate.focus(); 
			alert("Please Enter valid End Date");
			return false;
		}
		return true;
	}
	}
		
	function validDate(vMonth,vDay,vYear)
	{
	var vaMonths = new Array();
	vaMonths[1]=31;
	if (vYear%4==0)
		vaMonths[2]=29;
	else
		vaMonths[2]=28;
			
	vaMonths[3]=31;
	vaMonths[4]=30;
	vaMonths[5]=31;
	vaMonths[6]=30;
	vaMonths[7]=31;
	vaMonths[8]=31;
	vaMonths[9]=30;
	vaMonths[10]=31;
	vaMonths[11]=30;
	vaMonths[12]=31;
		
	if (vDay>vaMonths[vMonth])
		{
		return false;
		}
	return true;
	}	
		
	function validateDateEnabled()
	{
		document.frmDateSelect.StartDate.disabled = false;
		document.frmDateSelect.StartMonth.disabled = false;
		document.frmDateSelect.StartYear.disabled = false;
		document.frmDateSelect.EndDate.disabled = false;
		document.frmDateSelect.EndMonth.disabled = false;
		document.frmDateSelect.EndYear.disabled = false;   
	}
	function validateDate()
	{
	if (document.frmMrktView.rdoContDate(1).checked == true)
	{
		
			lSDate	= document.frmMrktView.StartDate.value ;
			lSMonth	= document.frmMrktView.StartMonth.value;
			lSYear	= document.frmMrktView.StartYear.value;
			lEDate	=	document.frmMrktView.EndDate.value;
			lEMonth	=	document.frmMrktView.EndMonth.value;
			lEYear	=	document.frmMrktView.EndYear.value;  
			lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
			lEDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear);
			if (lSDay > lEDay) 
			{
				document.frmMrktView.StartMonth.focus(); 
				alert("Start date should be Lesser than End date");
				return false;
			}
			if ((validDate(lSMonth,lSDate,lSYear))== false )
			{
				document.frmMrktView.StartDate.focus();
				alert("Please Enter valid Start Date");
				return false;
			}
			if ((validDate(lEMonth,lEDate,lEYear))== false)
			{
				document.frmMrktView.EndDate.focus(); 
				alert("Please Enter valid End Date");
				return false;
			}
			}
			if ((document.frmMrktView.rdoContDate(0).checked == true))
			{
				if (document.frmMrktView.selContract.value == "SELECT")
				{
					alert("Please Select Contract Coode");
					return false;
				}
			}
			
			if ((document.frmMrktView.rdoContDate(1).checked == false) && (document.frmMrktView.rdoContDate(0).checked == false))
			{
					alert("Please Select Option Contract or Date");
					return false;
			}
			
		}
		function validDate(vMonth,vDay,vYear)
		{
			var vaMonths = new Array();
			vaMonths[1]=31;
			if (vYear%4==0)
				vaMonths[2]=29;
			else
				vaMonths[2]=28;
				vaMonths[3]=31;
				vaMonths[4]=30;
				vaMonths[5]=31;
				vaMonths[6]=30;
				vaMonths[7]=31;
				vaMonths[8]=31;
				vaMonths[9]=30;
				vaMonths[10]=31;
				vaMonths[11]=30;
				vaMonths[12]=31;
			if (vDay>vaMonths[vMonth])
				{
				return false;
				}
			return true;
		}	

		function CheckEndDate()
		{
		    //alert('dfdf');
		if (document.frmMrktView.rdoContDate(1).checked == true)
		{	    
			lEDate	=	document.frmMrktView.EndDate.value
			lEMonth	=	document.frmMrktView.EndMonth.value
			lEYear	=	document.frmMrktView.EndYear.value	
			lDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear)
			lCDay	=	new Date();
			lCMonth =   lCDay.getMonth();
			lCMonth =	lCMonth + 1
			lCDate	=	lCDay.getDate();
			lCYear	=	lCDay.getYear();
	
			if (lEMonth > lCMonth)
				{	
					document.frmMrktView.EndMonth.focus(); 
					alert("Please Enter Correct Month.\nEnd Date should be Less than or Equal to Current Date.");
					return false;
				}
			if (lEDate > lCDate)
				{	
					document.frmMrktView.EndDate.focus();
					alert("Please Enter Correct Date.\nEnd Date should be Less than or Equal to Current Date.");
					return false;
				}
			if (lEYear > lCYear)
				{	
					document.frmMrktView.EndYear.focus(); 
					alert("Please Enter Correct Year.\nEnd Date should be Less than or Equal to Current Date.");
					return false;
				}
				
			return true;
		}
		}
		function forRadioCont()
		{
			document.frmMrktView.hdnContDate.value='I';
			document.frmMrktView.selContract.disabled=false;
			document.frmMrktView.StartMonth.disabled=true;
			document.frmMrktView.StartDate.disabled=true;
			document.frmMrktView.StartYear.disabled=true;
			document.frmMrktView.EndMonth.disabled=true;
			document.frmMrktView.EndDate.disabled=true;
			document.frmMrktView.EndYear.disabled=true;
			document.frmMrktView.subMktView.disabled=false;
		}	
		function forRadioDate()
		{
			document.frmMrktView.hdnContDate.value='D';
			document.frmMrktView.selContract.disabled=true;          
			document.frmMrktView.StartMonth.disabled=false;
			document.frmMrktView.StartDate.disabled=false;
			document.frmMrktView.StartYear.disabled=false;
			document.frmMrktView.EndMonth.disabled=false;
			document.frmMrktView.EndDate.disabled=false;
			document.frmMrktView.EndYear.disabled=false;
			document.frmMrktView.subMktView.disabled=false;
		}
	function fn_finalChk()
		{
			if ((document.frmMrktView.rdoContDate[0].checked == true) || (document.frmMrktView.rdoContDate[1].checked == true))
				{
					document.frmMrktView.method ="post";
					document.frmMrktView.action ="mrktView.asp";
					document.frmMrktView.submit();
					return true;
				}
			else
				{
					alert("Select Either Contract Or Date Option");
					return false;
				}
			
		}
	function fn_GetContCode()
	{
		document.frmMrktView.hdnContCode.value=document.frmMrktView.selContract.options[document.frmMrktView.selContract.selectedIndex].value;
	}
	</script>
</HEAD>
<HTML>
	<HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    </head>
    

<BODY>


<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->
	<br>

<form name="frmMrktView" method="post" action ="Mktviewres.asp" >
	<table width="347" align="center" border="1"  cellpadding=1 cellspacing=1 >
	<tr class=tdbgdark height=30 align=middle><td align=left width="337"><font class=whiteboldtext1>Market View</font></td></tr>
		<tr class=tdbglight height=30 align=left><td width="337"><INPUT name="rdoContDate" type="radio" value ="C" onclick="forRadioCont()" >Contract&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <INPUT name="rdoContDate" 
      type="radio" value ="Y" onclick="forRadioDate()">  Date</td></tr>
		<tr class=tdbglight height=30 align=left><td width="337">&nbsp; Contract Code 
      :&nbsp;&nbsp;&nbsp; <SELECT  name="selContract" style="height: 23; width: 210" onchange="fn_GetContCode();"> 
	      <OPTION  value="SELECT" selected>SELECT</OPTION>
	      <OPTION  value="All">All</OPTION>
		  <%while not objRsMac.EOF %>
				<%if trim(Request.Form("hdnContCode")) = objRsMac("inst_code") then %>
					<OPTION value=<%=objRsMac("inst_code")%> selected><%=objRsMac("inst_desc")%></OPTION>
				<%else%>
					<OPTION value=<%=objRsMac("inst_code")%>><%=objRsMac("inst_desc")%></OPTION>
				<%end if%>
		  <%objRsMac.MoveNext%>		
		  <%wend
		  objRsMac.Close
		  set objRsMac=nothing
		  %>
      <%
      else
		  objRsMac.Close
		  set objRsMac=nothing
      end if
      %>
      </SELECT></td></tr>
      <%if Request.Form("rdoContDate")="Y" then Response.Write "hai hai hai hai" %>
		<tr class=tdbglight height=30 align=left>
			<td width="337">From Date :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" >
					<OPTION  value="1" <%if  LMONTH=1 then Response.Write "selected"%>>January</OPTION>
					<OPTION value="2" <%if LMONTH=2 then Response.Write "selected"%>>February</OPTION>
					<OPTION value="3" <%if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
					<OPTION value="4" <%if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
					<OPTION value="5" <%if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
					<OPTION value="6" <%if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
					<OPTION value="7" <%if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
					<OPTION value="8" <%if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
					<OPTION value="9" <%if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
					<OPTION value="10" <%if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
					<OPTION value="11" <%if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
					<OPTION value="12" <%if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
				</select> 
				<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >
					<OPTION  value="1" <%if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3" <%if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5" <%if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7" <%if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9" <%if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%if LDATE=10 then Response.Write "selected"%>>10</OPTION>
					<OPTION value="11" <%if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%if LDATE=12 then Response.Write "selected"%>>12</OPTION>
					<OPTION value="13" <%if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%if LDATE=14 then Response.Write "selected"%>>14</OPTION>
					<OPTION value="15" <%if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%if LDATE=16 then Response.Write "selected"%>>16</OPTION>
					<OPTION value="17" <%if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%if LDATE=18 then Response.Write "selected"%>>18</OPTION>
					<OPTION value="19" <%if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%if LDATE=20 then Response.Write "selected"%>>20</OPTION>
					<OPTION value="21" <%if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%if LDATE=22 then Response.Write "selected"%>>22</OPTION>
					<OPTION value="23" <%if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%if LDATE=24 then Response.Write "selected"%>>24</OPTION>
					<OPTION value="25" <%if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%if LDATE=26 then Response.Write "selected"%>>26</OPTION>
					<OPTION value="27" <%if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%if LDATE=28 then Response.Write "selected"%>>28</OPTION>
					<OPTION value="29" <%if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%if LDATE=30 then Response.Write "selected"%>>30</OPTION>
					<OPTION value="31" <%if LDATE=31 then Response.Write "selected"%>>31</OPTION>
				</select>&nbsp;
				<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
					<OPTION value="<%=lYearPrev%>"><%=lYearPrev%></OPTION>
					<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
				</select></td>
		</tr>
		<tr class=tdbglight height=30 align=left>
			<td width="337">To Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;<select size="1" name="EndMonth" style="HEIGHT: 22px; WIDTH: 92px" >
					<OPTION  value="1" <%if LMONTH=1 then Response.Write "selected"%>>January</OPTION>
					<OPTION value="2" <%if LMONTH=2 then Response.Write "selected"%>>February</OPTION>
					<OPTION value="3" <%if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
					<OPTION value="4" <%if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
					<OPTION value="5" <%if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
					<OPTION value="6" <%if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
					<OPTION value="7" <%if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
					<OPTION value="8" <%if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
					<OPTION value="9" <%if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
					<OPTION value="10" <%if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
					<OPTION value="11" <%if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
					<OPTION value="12" <%if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
				</select> 
				<select size="1" name="EndDate" style="HEIGHT: 22px; WIDTH: 40px" >
					<OPTION  value="1" <%if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3" <%if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5" <%if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7" <%if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9" <%if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%if LDATE=10 then Response.Write "selected"%>>10</OPTION>
					<OPTION value="11" <%if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%if LDATE=12 then Response.Write "selected"%>>12</OPTION>
					<OPTION value="13" <%if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%if LDATE=14 then Response.Write "selected"%>>14</OPTION>
					<OPTION value="15" <%if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%if LDATE=16 then Response.Write "selected"%>>16</OPTION>
					<OPTION value="17" <%if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%if LDATE=18 then Response.Write "selected"%>>18</OPTION>
					<OPTION value="19" <%if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%if LDATE=20 then Response.Write "selected"%>>20</OPTION>
					<OPTION value="21" <%if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%if LDATE=22 then Response.Write "selected"%>>22</OPTION>
					<OPTION value="23" <%if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%if LDATE=24 then Response.Write "selected"%>>24</OPTION>
					<OPTION value="25" <%if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%if LDATE=26 then Response.Write "selected"%>>26</OPTION>
					<OPTION value="27" <%if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%if LDATE=28 then Response.Write "selected"%>>28</OPTION>
					<OPTION value="29" <%if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%if LDATE=30 then Response.Write "selected"%>>30</OPTION>
					<OPTION value="31" <%if LDATE=31 then Response.Write "selected"%>>31</OPTION>
				</select>&nbsp;
				<select name="EndYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
					<OPTION value="<%=lYearPrev%>"><%=lYearPrev%></OPTION>
					<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
				</select></td>
		</tr>
		<tr class=tdbglight height=30 align="center">
		   <td width="337"><INPUT name="subMktView" type="submit" value="Submit" onclick="return validateDate()"></td>
        </tr>
	
</table>
<br><br>

</center>
<input type="hidden" name="hdnContCode">
<input type="hidden" name="hidNext" value=<%=strNPBotLn%>>
<input type="hidden" name ="hidPrevious" value=<%=strNPTopLn%>>
<input type="hidden" name="hidStatus">
<input type="hidden" name="hdnContDate">

</form>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
