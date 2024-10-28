<%@Language=VBSCRIPT %>
<% 
'Option Explicit
'Response.Buffer = True
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading												  *
	'* File name	:	NewOrder.asp								          *
	'* Purpose		:	This is used to Place New Orders					  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	08/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to Enter New Order Entry.
	'* Client Side	:	Javascript											  *
	'* ServerSide   :   VBScript																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   08/11/2001		V.Christopher Britto  First Baseline      *
	'**************************************************************************	
	%>
	
<%
'on error resume next
   
dim lUserId
dim lCompanyId
dim ObjReport
dim lRsInst
dim lPhase
dim lRSClient
dim lRSICMList
dim CURRENTDATE 
dim LMONTH 
dim LDATE
dim LYEAR
dim lTCMID
dim LYEAR1
dim UserId
dim lExchId
dim lUserType
'end of variable declarations

lUserId = Request.Cookies("UserId")
lCompanyId=Request.Cookies("CompanyId")
lUserType=Request.Cookies("UserType")
lExchId=Request.Cookies("ExchId")
	if lUserType="T" then lTCMID=lUserId
	if lUserType="J" then lTCMID=lCompanyId

if err.number <>0 then
Error_para()
end if

 CURRENTDATE=NOW()
 LMONTH= MONTH(CURRENTDATE)
 LDATE=DAY(CURRENTDATE)
 LYEAR=YEAR(CURRENTDATE)
 LYEAR1=LYEAR+1

 %>

<HTML>
<HEAD>
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title>Welcome to the Bombay Commodity Exchange Limited</title>
<link rel="stylesheet" href="theme.css">
<script language="javascript">
<!---
//START DATE OF VALIDATION
var reccount;
var ArrClient=new Object();
var ArrClientId=new Object();


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
	
function checkdate()
{
	lmonth=document.frmNewOrder.StartMonth.value;
    lday=document.frmNewOrder.StartDate.value;
    lyear=document.frmNewOrder.StartYear.value;
   if ((validDate(lmonth,lday,lyear))== false )
	{
		alert("Please choose valid  Date");
		return false;
	}
return;

}
//
/*
function TouchLine()
{
	if(document.frmNewOrder.HOrderBuySellFlag.value =='S')
	{
	//document.frmNewOrder.TLPrice.value=document.frmNewOrder.HBestbid.value;
	document.frmNewOrder.TLPrice.value=<%'=session("bOrderQty")%>
	}
	if(document.frmNewOrder.HOrderBuySellFlag.value =='B')
	{
	//document.frmNewOrder.TLPrice.value=document.frmNewOrder.HBestoffer.value;
	document.frmNewOrder.TLPrice.value=<%'=session("sOrderQty")%>
	}
    
return;

}
*/

	
//end of validate validation	 
function showDate(){
   dt = new Date();   //Gets today's date right now (to the millisecond).
   tmonth = '<%=LMONTH%>';
   tday = '<%=LDATE%>';
   tyear = '<%=LYEAR%>';
   mmonth=document.frmNewOrder.StartMonth.value;
   dday=document.frmNewOrder.StartDate.value;
   yyear=document.frmNewOrder.StartYear.value;
   mdate=new Date(tmonth + '/' + tday + '/' + tyear); //Current Date
   //alert(mdate);
   sdate=new Date(mmonth + '/' + dday + '/' + yyear); //Selected Date
   //alert(sdate);

	if ((validDate(mmonth,dday,yyear))== false )
	{
		alert("Please choose valid  Date");
		return false;
	}

   if((document.frmNewOrder.HEXPIRYTYPE.value=="Y")&&(mdate!=sdate))
   {
   alert("You can not change the date for Good For the Day");
   document.frmNewOrder.StartMonth.focus();
   document.frmNewOrder.StartMonth.value=tmonth;
   document.frmNewOrder.StartYear.value=tyear;
   document.frmNewOrder.StartDate.value=tday;
   return false;
   }
   if((document.frmNewOrder.HEXPIRYTYPE.value=="C")&&(mdate>sdate))
   {
   alert("You can not back date the date for Good Till Cancel");
   document.frmNewOrder.StartMonth.value=tmonth;
   document.frmNewOrder.StartYear.value=tyear;
   document.frmNewOrder.StartDate.value=tday;
   return false;
   
   }
    if((document.frmNewOrder.HEXPIRYTYPE.value=="D")&&(mdate>sdate))
   {
   alert("You can not back date the date for Good Till Date");
   document.frmNewOrder.StartMonth.value=tmonth;
   document.frmNewOrder.StartYear.value=tyear;
   document.frmNewOrder.StartDate.value=tday;
   return false;
   }
    
    
  // alert(dt);
}
//end of DATE VALIDATION


//end of function OrdQty

function PriceProtect()
{
	if(document.frmNewOrder.HOrderType.value=="M")
		{document.frmNewOrder.OptPP[0].checked=true;
		document.frmNewOrder.OptPP[0].disabled=false;
		document.frmNewOrder.OptPP[1].disabled=false;
		}
	else if(document.frmNewOrder.HOrderType.value=="L")
		{document.frmNewOrder.OptPP[0].checked=false;
		document.frmNewOrder.OptPP[1].checked=false;
		document.frmNewOrder.OptPP[0].disabled=true;
		document.frmNewOrder.OptPP[1].disabled=true;}
}

/* function Stoploss()
{
	if(document.frmNewOrder.ChkSLOrder.checked==false)
	{
	document.frmNewOrder.SLPrice.value="";
	document.frmNewOrder.SLPrice.disabled=true;
	}
	else
	{
	document.frmNewOrder.SLPrice.disabled=false;
	}
}
*/

function Ownership()
{
   // resetClient();
    popClient();
	if(document.frmNewOrder.HOrderOwnership.value=="C")
	{
	L=reccount;
	for(var i=L;i>=1;i--)
	{
	    //new Option(" & chr(34) & rssubcat("name") & chr(34) & "," & chr(34) & rssubcat("subcatid") & chr(34) & ");" & vbcrlf
		document.frmNewOrder.ClientID.options[i]=new Option(ArrClient[i],ArrClientId[i]);
	}			
	
	document.frmNewOrder.ClientID.options[0].value="";
	document.frmNewOrder.ClientID.options[0].text="[--Select One--]";
	return false;
	}
	if(document.frmNewOrder.HOrderOwnership.value=="P")
	{
	document.frmNewOrder.ClientID.options[0].text="<%=lTCMID%>";
	document.frmNewOrder.ClientID.options[0].value="<%=lTCMID%>";
	document.frmNewOrder.HClientID.value="";
	return false;
	}
	
	
}

function checkNewOrder()
{
	if(document.frmNewOrder.HInstrCode.value=="")
	{
	alert("Please Select Contract to Place your Order");
	document.frmNewOrder.optInstrCode.focus();
	return false;
	}
		
	if(document.frmNewOrder.HOrderBuySellFlag.value=="")
	{
		alert("Please Select Order Type");
		document.frmNewOrder.OrderBuySellFlag.focus();
		return false;
	}

	if(document.frmNewOrder.OrderQty.value=="")
	{
		alert("Please Enter Order Quantity");
		document.frmNewOrder.OrderQty.focus();
		return false;
	}
			var strQty=document.frmNewOrder.OrderQty.value;
			var Qtydotpos=strQty.indexOf(".");
	if (parseInt(Qtydotpos)>0 )
	{
		alert("Decimals in Quantity is not Allowed");
		document.frmNewOrder.OrderQty.focus();
		return false;
	}
	if(document.frmNewOrder.Price.value=="")
	{
			alert("Please Enter the Price");
			document.frmNewOrder.Price.focus();
			return false;
	}
	if((document.frmNewOrder.Price.value!="")&&(isNaN(document.frmNewOrder.Price.value)))
	{
		alert("Please Enter Price in Numbers");
		document.frmNewOrder.Price.focus();
		return false;
	}
		
	if((document.frmNewOrder.Price.value<=0)&&(document.frmNewOrder.Price.value!=""))
	{
	alert("The Price can not be negative or zero value");
	document.frmNewOrder.Price.focus();
	return false;
	}
	if((document.frmNewOrder.OrderQty.value!="")&&(isNaN(document.frmNewOrder.OrderQty.value)))
	{
		alert("Please Enter Quantity in Numbers");
		document.frmNewOrder.OrderQty.focus();
		return false;
	}
	if((document.frmNewOrder.OrderQty.value<=0)&&(document.frmNewOrder.OrderQty.value!=""))
	{
	alert("The Quantity can not be negative or zero value");
	document.frmNewOrder.OrderQty.focus();
	return false;
	}
	
	if((document.frmNewOrder.DripQty.value!="")&&((document.frmNewOrder.HFILLTYPE.value=="I")||(document.frmNewOrder.HFILLTYPE.value=="F")))  
	{
		alert("Drip is not Allowed for this FillTypes");
		document.frmNewOrder.DripQty.focus();
		return false;
	}			
/*	if((document.frmNewOrder.ChkSLOrder.checked)&&(document.frmNewOrder.SLPrice.value==""))
	{
		alert("Please Enter Stop Loss Price");
		document.frmNewOrder.SLPrice.focus();
		return false;
	}
	if((document.frmNewOrder.SLPrice.value<=0)&&(document.frmNewOrder.SLPrice.value!=""))
	{
		alert("Please do not Enter Negative Price");
		document.frmNewOrder.SLPrice.focus();
		return false;
	}
	if((document.frmNewOrder.SLPrice.value!="")&&(isNaN(document.frmNewOrder.SLPrice.value)))
	{
	alert("Please Enter Valid Price");
	document.frmNewOrder.SLPrice.focus();
	return false;
	}
*/	var strDripQty=document.frmNewOrder.DripQty.value;
	var DripQtydotpos=strDripQty.indexOf(".");
	if (parseInt(DripQtydotpos)>= 0 )
	{
		alert("Decimals in Quantity is not Allowed");
		document.frmNewOrder.DripQty.focus();
		return false;
	}
	
	if((document.frmNewOrder.DripQty.value!="")&&(isNaN(document.frmNewOrder.DripQty.value)))
	{
		alert("Please Enter Quantity Number");
		document.frmNewOrder.DripQty.focus();
		return false;
	}
	if((document.frmNewOrder.DripQty.value!="")&&(document.frmNewOrder.DripQty.value<=0))
	{
	alert("The Quantity can not be negative value or 0");
	document.frmNewOrder.DripQty.focus();
	return false;
	}
	ldripqty=eval(document.frmNewOrder.DripQty.value);
	lordqty=eval(document.frmNewOrder.OrderQty.value);
	if(((ldripqty)>(lordqty))&&(document.frmNewOrder.DripQty.value!=0))
	{
	alert("Drip Qty should be less than Order Qty");
	document.frmNewOrder.DripQty.focus();
	return false;
	}
	if((((lordqty-ldripqty)%ldripqty)!=0)&&(document.frmNewOrder.DripQty.value!=0))
	{
	alert('Order Qty should be multiples of Drip Qty');
	document.frmNewOrder.OrderQty.focus();
	return false;
	}       
	if(document.frmNewOrder.HOrderType.value=="")
	{
		alert("Please Select Price Type");
		document.frmNewOrder.OrderType.focus();
		return false;
	} 
	if((document.frmNewOrder.HOrderType.value=="M")&&(document.frmNewOrder.Price.value==""))
	{
		alert("Please Enter Price Protection Percentage");
		document.frmNewOrder.Price.focus();
		return false;
	}
	if((document.frmNewOrder.HOrderType.value=="M")&&(document.frmNewOrder.Price.value!="")&&(document.frmNewOrder.OptPP[0].checked==true)&&((document.frmNewOrder.Price.value.length)>2))
	{
		alert("Price Protection Percentage can not exceed 2 digits");
		document.frmNewOrder.Price.focus();
		return false;
	}
	
	
	if((document.frmNewOrder.Price.value<=0)&&(document.frmNewOrder.Price.value!=0))
	{
	alert("The Price can not be negative value");
	document.frmNewOrder.Price.focus();
	return false;
	}
//Price digits validation
	var strprice=document.frmNewOrder.Price.value;
	var strpricelen=strprice.length;
	var dotpos=strprice.indexOf(".");
	var remlen=parseInt(strpricelen)-parseInt(dotpos);
	if ((remlen>3)&&(dotpos>0))
	{
	alert("The paise should not be more than two digits");
	document.frmNewOrder.Price.focus();
	return false;
	}
//end of digits validation	 
	 
	if((document.frmNewOrder.HOrderType.value=="L")&&(document.frmNewOrder.Price.value==""))
	{
		alert("Please Enter Price ");
		document.frmNewOrder.Price.focus();
		return false;
	}
	if((document.frmNewOrder.Price.value!="")&&(isNaN(document.frmNewOrder.Price.value)))
	{
		alert("Please Enter Price Protection Percentage in Number");
		document.frmNewOrder.Price.focus();
		return false;
	}
	
	if(document.frmNewOrder.HOrderOwnership.value=="")
	{
		alert("Please Select Order Ownership");
		document.frmNewOrder.OrderOwnership.focus();
		return false;
	}
		
	
	if((document.frmNewOrder.HOrderOwnership.value=="C")&&(document.frmNewOrder.ClientID.value==""))
	{
		alert("Please Choose CustomerID");
		document.frmNewOrder.ClientID.focus();
		return false;
	}
	
	if(document.frmNewOrder.PinNo.value=="")
	{
		alert("Please Enter Your Pin Number");
		document.frmNewOrder.PinNo.focus();
		return false;
	}
	
	if((document.frmNewOrder.HOrderStatus.value==""))
	{
		alert("Please Choose Order Status");
		return false;
	}
		
return ;
}

function InstLot()
{
var lstring=document.frmNewOrder.HInstrCode.value;
var lcommaposition = lstring.indexOf(",");
var lInstrcode = lstring.substr(lstring,lcommaposition);
document.frmNewOrder.HInstrCode.value=lInstrcode;
//Instrcode
var mlength=lstring.length;
var lstring= lstring.substr(lcommaposition+1,(mlength-(lcommaposition+1)));
var lcommaposition=lstring.indexOf(",");
var lInstrno=lstring.substr(lstring,lcommaposition);
document.frmNewOrder.HInstrNo.value=lInstrno;
//InstrNumber
var lstring= lstring.substr(lcommaposition+1,(mlength-(lcommaposition+1)));
var lcommaposition=lstring.indexOf(",");
var lLotSize=lstring.substr(lstring,lcommaposition);
document.frmNewOrder.OrderQty.value =lLotSize;
//Lotsize
var lstring= lstring.substr(lcommaposition+1,(mlength-(lcommaposition+1)));
var lcommaposition=lstring.indexOf(",");
var lBestBid=lstring.substr(lstring,lcommaposition);
document.frmNewOrder.HBestbid.value=lBestBid;
//Best Bid
var lBestOffer= lstring.substr(lcommaposition+1,(mlength-(lcommaposition+1)));
document.frmNewOrder.HBestoffer.value=lBestOffer;
//Best Sell
}
//----->	

function DisplayTouchLine()
{
	var lContract
	lContract = document.frmNewOrder.optInstrCode.options[selectedIndex].value
	alert(lContract);
	
}

</script>
</HEAD>

<!--
<BODY  bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 onload="document.frmNewOrder.optInstrCode.focus();return PriceProtect();">
-->
<BODY  bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 onload="document.frmNewOrder.optInstrCode.focus();">
<!-- #include file = "Includes/header.inc" -->
<br>
<!---#include file="Includes/IncludeCheck.asp"---> 
<br>

  <form name=frmNewOrder action="ValidateOrderStatic.asp" method=post>
    <TABLE align=center border=1 cellPadding=1 cellSpacing=1 width="80%" height="196">
      <tr> 
        <td align=left height="18" colspan="3" class="tdbgdark" width="80%"><font class=whiteboldtext1>New 
          Order Entry</font></td>
      </tr>
      <TR> 
        <TD class=tdbglight width="30%" height="25"><font class="blackboldtext">Contract Code</font></TD>
        <TD class=tdbglight width="50%" height="25" colspan="2"> 
			<select name="optInstrCode" style="height: 23; " onchange="document.frmNewOrder.HInstrCode.value=document.frmNewOrder.optInstrCode.options[selectedIndex].value;InstLot(); ">
				<option selected> --------- Select Contract ------------ </option>
				<option value="BCEPAM1201,577,1,0,0">BCEPAM1201</option>
				<option value="BPMOIL1201,576,1,0,0">BPMOIL1201</option>
				<option value="CASCAK0903,562,1,0,0">CASCAK0903</option>
				<option value="CASCAK1101,567,100,0,0">CASCAK1101</option>
				<option value="CASCAK1103,584,1,0,0">CASCAK1103</option>
				<option value="CASOIL0703,513,1,0,0">CASOIL0703</option>
				<option value="CASOIL0704,559,100,0,0">CASOIL0704</option>
				<option value="CASOIL0706,546,1,0,0">CASOIL0706</option>
				<option value="CASOIL0803,514,1,0,0">CASOIL0803</option>
				<option value="CASOIL0903,515,1,0,0">CASOIL0903</option>
          </select> 
   </TD>
          <INPUT TYPE=HIDDEN NAME=HInstrCode>
          <INPUT TYPE=HIDDEN NAME=HInstrNo>
          <INPUT TYPE=HIDDEN NAME=HBestbid>
          <INPUT TYPE=HIDDEN NAME=HBestoffer>
      </TR>
      <TR> 
        <TD class=tdbglight width="30%" height="25"><font class="blackboldtext">Order Type</font></TD>
        <TD class=tdbglight width="50%" height="25"  colspan="2"> 
		<!--
          <SELECT NAME="OrderBuySellFlag" style="height: 23; width: 207" onchange="document.frmNewOrder.HOrderBuySellFlag.value=document.frmNewOrder.OrderBuySellFlag.options[selectedIndex].value; TouchLine();">
         -->
         <SELECT NAME="OrderBuySellFlag" style="height: 23; width: 207" onchange="document.frmNewOrder.HOrderBuySellFlag.value=document.frmNewOrder.OrderBuySellFlag.options[selectedIndex].value;">
			<OPTION selected value="TT">--- Select Order Type ---</OPTION>
            <OPTION value="B">Buy</OPTION>
            <OPTION value="S">Sell</OPTION>
          </SELECT>
        </TD><INPUT TYPE="HIDDEN" NAME="HOrderBuySellFlag">
      </TR>
      <TR>  
        <TD class=tdbglight width="30%" height="25"><font class="blackboldtext">Fill Type</font></TD>
        <TD class=tdbglight width="50%" height="25"  colspan="2"> 
          <SELECT NAME="Filltype" style="height: 23; width: 207" onchange="document.frmNewOrder.HFILLTYPE.value=document.frmNewOrder.Filltype.options[selectedIndex].value">
            <OPTION selected value="P">Partial Fill</OPTION>
            <OPTION value="I">PartialFill And Kill</OPTION>
            <OPTION value="F">FulFill Or Kill</OPTION>
          </SELECT>
        </TD><INPUT TYPE="HIDDEN" NAME="HFILLTYPE">
      </TR>
       <TR colspan="3">
        <TD class=tdbglight width="30%" height="25"><font class="blackboldtext">Expiry Type</font></TD>
        <TD class=tdbglight WIDTH="50%" height="25"  colspan="2"> 
          <SELECT NAME="ExpiryType" style="height: 23; width: 207" onchange="document.frmNewOrder.HEXPIRYTYPE.value=document.frmNewOrder.ExpiryType.options[selectedIndex].value;showDate();">
			<OPTION value="C">Good Till Cancel</OPTION>
            <OPTION value="D">Good Till Date</OPTION>
            <OPTION value="Y" selected>Good For The Day</OPTION>
          </SELECT><INPUT TYPE="HIDDEN" NAME="HEXPIRYTYPE" value="Y">
         </TD></TR>
      <TR><TD class=tdbglight width="30%" height="25"><font class="blackboldtext">Expiry Date</font></TD>
        <TD WIDTH="50%" CLASS=tdbglight height="25"  colspan="2"> 
           <select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" onchange="showDate();">
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
        <select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" onchange="showDate();">
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
        <select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 63px" onchange="showDate();">
			<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
			<OPTION value="<%=LYEAR1%>"><%=LYEAR1%></OPTION>
       </select>
      </TD>
      </TR>
      <TR>
        <TD class=tdbglight WIDTH="30%" height="25"><font class="blackboldtext">Order Quantity
          </font></TD>
        <TD class=tdbglight width="50%" height="25"  colspan="2"> 
          <input type="text" name="OrderQty" size="10" MAXLENGTH="5" onChange="javascript:while(''+this.value.charAt(0)==' ')this.value=this.value.substring(1,this.value.length);">
        </TD>
      </TR>


<%'response.write "<script language=Javascript>"  & vbcrlf
 'response.write "function popClient(){" & vbcrlf
 ' response.write "reccount=" & lRSClient.RecordCount  & ";" & vbcrlf
 
 '	 	dim i 
 '	 	
'	 	i=0
'	 	while not lRSClient.EOF 
'	 	i=i+1
'	
'	  Response.write "ArrClient[" & i & "]='" & lRSClient("UPER_FNAME")&lRSClient("UPER_MNAME")&lRSClient("UPER_LNAME") & "';" & vbcrlf
'	  Response.write "ArrClientId[" & i & "]='" & lRSClient("UPER_USERID") & "';" &   vbcrlf	  
'	  lRSClient.MoveNext
'	wend	
 '   response.write "};" & vbcrlf	
'	'Response.write "</script>"  & vbcrlf  & vbcrlf
 %>
<!--
function resetClient(){
f=document.frmNewOrder;
var L=reccount;
for(var i=L;i>=1;i)
{
f.ClientID.options[i]=null;
}
f.ClientID.options[0].selected=true;
}   
-->
</script> 


     
<!---		<TR COLSPAN=2>
        <TD class=tdbglight WIDTH="228" height="23"><font class=blacktext>Stop Loss
          order</font></TD>
        <TD class=tdbglight  width="183" height="23"> 
          <input type="checkbox" name="ChkSLOrder" onclick="return Stoploss();">&nbsp;
         </TD>
          	<TD CLASS=tdbglight height="23" width="178"><font class=blacktext>
          Price</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name=SLPrice size=10>
        </TD>
      </TR>         ---------->
      <TR> 
        <TD class=tdbglight WIDTH="30%" height="31"><font class="blackboldtext">Drip Quantity
          </font>
        </TD>
                
       <TD CLASS=tdbglight WIDTH="30%" height="31"> <br>
		  <input name="DripQty" size=10 MAXLENGTH="5" onChange="javascript:while(''+this.value.charAt(0)==' ')this.value=this.value.substring(1,this.value.length);">
      </TD>
       <TD CLASS=tdbglight WIDTH="20%" height="31">
       <font class="blackboldtext">TouchLinePrice</font>
       <%if session("sOrderQty")<>"" then %>
			<input Type=Text Name="TLPrice" value=<%=session("sOrderQty")%> size="10" disabled>		
		<%elseif session("sOrderQty")<>"" then%>		
			<input Type=Text Name="TLPrice" value=<%=session("bOrderQty")%> size="10" disabled>		
		<%elseif session("sOrderQty")="" and session("bOrderQty")<>"" then%>		
			<input Type=Text Name="TLPrice" size="10" disabled>		
		<%end if%>
		</TD>
      </TR>  
  
  <TR>
        <TD class=tdbglight WIDTH="30%"><font class="blackboldtext">Price Type </font></TD>
        <TD class=tdbglight WIDTH="30%" valign=middle><br>
          <SELECT name="OrderType" style="height: 23; width: 158" valign=middle  onchange="document.frmNewOrder.HOrderType.value =document.frmNewOrder.OrderType.options[selectedIndex].value; return PriceProtect();">
          <OPTION  value="L" selected>Limit Price</OPTION> 
     <OPTION value="M">Market Price</OPTION> 
      </SELECT>
      </TD>
    <INPUT TYPE="HIDDEN" NAME="HOrderType" value ="L">
     <TD WIDTH="20%" CLASS=tdbglight>
            <font class="blackboldtext">&nbsp;Price/PP </font>
     <input name="Price" size="10" MAXLENGTH="10" onChange="javascript:while(''+this.value.charAt(0)==' ')this.value=this.value.substring(1,this.value.length);">
        </TD>
  </TR>
      <TR> 
        <TD class=tdbglight width="30%"><font class="blackboldtext"> Price Protection</font></TD>
        <TD class=tdbglight width="50%"  colspan="2"> 
        <INPUT type="radio" name="OptPP" value="P"><font class=blacktext> in % </font>
        <INPUT type="radio" name="OptPP" value="V"><font class=blacktext>in Value </font>
        </TD>
      </TR>
      <TR> 
        <TD class=tdbglight width="30%"><font class="blackboldtext"> 
		ICM Id</FONT></TD>
        <TD class=tdbglight width="30%">
     <SELECT NAME="ICMID" style="height: 23; width: 158" onchange="document.frmNewOrder.HICMID.value=document.frmNewOrder.ICMID.options[selectedIndex].value;">
		<OPTION VALUE="TAN0008000">TAN0008000 </OPTION>
		<OPTION VALUE="IKA0001000">Anil  KAPOOR</OPTION>
		<OPTION VALUE="IBA0002000">Raj  BABBAR</OPTION>
		<OPTION VALUE="IJO0003000">Sunil  JOSHI</OPTION>
		<OPTION VALUE="IRO0004000">Hrithik  ROSHAN</OPTION>
		<OPTION VALUE="IKH0005000">Amir  KHAN</OPTION>
		<OPTION VALUE="IBH0006000">Harsha  BHOGLE</OPTION>

     <!--
	 <OPTION VALUE="<%'=lTCMID%>"><%'=lTCMID%> </OPTION>
	 <%' while not lRSICMList.EOF %>
	<OPTION VALUE="<%'=lRSICMList("UPER_USERID")%>">
	<%'=lRSICMList("UPER_FNAME")&" "&lRSICMList("UPER_MNAME")&" "&lRSICMList("UPER_LNAME")%>
	</OPTION>
		<%'lRSICMList.MoveNext 
			'wend%>
	-->
	</SELECT> </td>
	<TD class=tdbglight width="20%">
	<INPUT TYPE="TEXT" SIZE="10" NAME="HICMID" VALUE="" MAXLENGTH="10" disabled>
        </TD>
      </TR>
    <TR>
    <TD class=tdbglight width="30%"><font class="blackboldtext">Order Ownership</FONT></TD>
    <TD class=tdbglight  width="50%" colspan="2">
	<!--    
		<SELECT name="OrderOwnership" style="height: 23; width: 158" onchange="document.frmNewOrder.HOrderOwnership.value =document.frmNewOrder.OrderOwnership.options[selectedIndex].value; Ownership();"> 
    -->
    <SELECT name="OrderOwnership" style="height: 23; width: 158" onchange="document.frmNewOrder.HOrderOwnership.value =document.frmNewOrder.OrderOwnership.options[selectedIndex].value;"> 
   <OPTION>--Select Ownership--</OPTION>
    <OPTION value="C">Customer</OPTION>
    <OPTION value="P" selected>Principal</OPTION></SELECT></TD></TR>
      <INPUT TYPE="HIDDEN" NAME="HOrderOwnership" VALUE="P">
      <INPUT TYPE="HIDDEN" NAME="OrdEnteredby" value="<%=UserId%>">
    <TR> 
        <TD class=tdbglight width="30%"><font class="blackboldtext"> Client Id</font></TD>
        <TD class=tdbglight width="30%">
	<SELECT NAME="ClientID" style="height: 23; width: 158" onchange="document.frmNewOrder.HClientID.value=document.frmNewOrder.ClientID.options[selectedIndex].value;">
		<OPTION VALUE="TAN0008000">TAN0008000 </OPTION>
	<!--
	<OPTION VALUE="<%'=lTCMID%>"><%'=lTCMID%> </OPTION>
		 	 <%' while not lRSClient.EOF 
	 	 
	 	 %>
	<OPTION VALUE="<%'=lRSClient("UPER_USERID")%>">
	<%'=lRSClient("UPER_FNAME")&lRSClient("UPER_MNAME")&lRSClient("UPER_LNAME")%>
	</OPTION>
		<%'lRSClient.MoveNext 
			'wend%>
	-->	
	</SELECT> </td>
	 <td width="20%" class=tdbglight>
	<INPUT TYPE="TEXT" SIZE="10" NAME="HClientID" MAXLENGTH="10" disabled>
        </TD>
      </TR>
	 <TR>
    <TD class=tdbglight width="30%"><font class="blackboldtext">PIN Number</FONT></TD>
    <TD class=tdbglight  width="50%" colspan="2">
	<INPUT TYPE="Password" NAME="PinNo" MAXLENGTH="8" style="height: 23; width: 158">
	</TD></TR>
	<TR>
    <TD class=tdbglight width="30%"><font class="blackboldtext">Order Status</FONT></TD>
    <TD class=tdbglight  width="50%" colspan="2">
    <SELECT name="Orderstatus" style="height: 23; width: 158" onchange="document.frmNewOrder.HOrderStatus.value =document.frmNewOrder.Orderstatus.options[selectedIndex].value;"> 
     <% 'if lPhase="CTNG" then %>
    <OPTION value="C" selected >Session Order</OPTION>
    <OPTION value="L">Local Order</OPTION>
    <%'ELSE%>
    <!--  <OPTION value="L" SELECTED>Local Order</OPTION>
    -->
    <%'end if%>
    </SELECT><INPUT TYPE="HIDDEN" NAME="HOrderStatus" VALUE ="C">
    </TD></TR>  <INPUT TYPE="HIDDEN" NAME="Phase" VALUE="<%=lPhase%>">
      <TR> 
        <TD class=tdbglight align="RIGHT" width="30%">&nbsp;
      </TD>
       <TD class=tdbglight colspan="2" width="50%">
       <INPUT type=submit name=submit value="Submit" onclick="return checkNewOrder();return checkdate();">
       <INPUT TYPE="RESET"  NAME="RESET" value="Reset">
       </TD>   
      </TR>
    </TABLE>
</form>

<%Footer()%>

<%Sub Header()%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>Welcome to the Bombay Commodity Exchange Limited</title>
<link rel="stylesheet" href="../Includes/theme.css">
</HEAD>
<BODY  bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0>
<!-- #include file = "Includes/header.inc" -->
<br>
<!---#include file="Includes/IncludeCheck.asp"---> 
<br>
<CENTER>
<%End Sub%>

<%Sub Footer() %>
</CENTER>
<br>
<!-- #include file = "Includes/footer.inc" -->
</BODY>
</HTML>
<%End Sub %>


<%
sub Error_para()%>
<%Header() %>
<TABLE border=1 cellPadding=1 cellSpacing=1 width="60%" >
     <tr> 
     <td align=left colspan="2" class="tdbgdark" width="424"><font class=whiteboldtext1>Error 
          Information</font></td>
      </tr>   
     <TR>
      <td align=left colspan="2" class="tdbglight" width="424" height="30"><font class=blacktext1> 	                          
		<%="Internal Error, Please try again !..." %>	 
	 </td>
	 </TR>
</TABLE>
<%Footer()%>
<%End Sub
%>
