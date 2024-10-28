<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading											      *
	'* File name	:	ContBuildViewRes.asp								  *
	'* Purpose		:	This page will display the menu for MAC User	      * 
	'* Prepared by	:	Obula Reddy         							      *
	'* Date			:	16.11.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to display menu for MAC Contracts         				  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   16.11.2001	V.Christopher Britto	  First Baseline      *
	'*																		  *
	'**************************************************************************
'	dim lUserType
'	lUserType=Request.Cookies("UserType")
	%>	
		<script language="Javascript">
	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
		document.frmContBuildView.action="ContBuildDelRes.asp";
		document.frmContBuildView.method="post";
		document.frmContBuildView.submit(); }
	 
	 else if(i==2)
	 {
		document.frmContBuildView.action="ContBuildMenu.asp";
		document.frmContBuildView.submit(); }
	}
	</script>

	<HTML>
	<HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="frmContBuildView" method="post">
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
<%

   dim lConCode
   dim lContBasePrice
   dim lDesc
   dim lConStatus
   dim lConGrp
   dim lConUnit
   dim lConType
   dim lTrdStDate
   dim lTrdEndDate
   dim lDlvdStDate
   dim lDlvdEndDate
   dim lMktLot
   dim lOCPTrdCount
   dim lTickSize 
   dim lOCPTrdDuration
   dim lCirFilter
   dim lMinDripQty
   dim lSettleFilter
   dim lObjConBuldr
   dim linstcode
   dim lExchange
   dim lUserId
   dim lMinVal
   dim lMaop
   Dim lUnit
   Dim lStatus
   
   Set lObjConBuldr = Server.CreateObject("Project1.InstrumentMgr")
   Dim lRespCode
   
   lConCode			= Request.Form("OptContCode")
   Response.Write  lConCode
   lRespCode = lObjConBuldr.DoBrowse(lConCode,linstcode,lConType,lConGrp,lDesc,lCirFilter,lOCPTrdDuration,lTickSize,lMktLot,lTrdStDate,lTrdEndDate,lMinVal,lDlvdStDate,lDlvdEndDate,lMaop,lOCPTrdCount,lConUnit,lStatus,lSettleFilter,lMinDripQty,lContBasePrice,lExchange,"MAS0001000")
   
  if lRespCode=0 then
  %>	

 <table width="90%" border="0"  cellpadding=1 cellspacing=1 align=center>
	    <tr class="tdbgdark" >
	       <td  align = "middle" colspan=4 height="10"><font class="whiteboldtext1">Contract Information</font></td>
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Contract Code</div></td>
	       <td align="left"   class="tdbglight" height="16"  width="30%" >
	       <INPUT name = "lstConCode" value=<%=linstcode%>
	       </td>   
	       
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Contract Base Code*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtContBasePrice" value=<%=lContBasePrice%>
	        </td>
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Description*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtDesc" value=<%=lDesc%>
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Contract Status*
	         </div>  
	        </td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtStatus" value=<%=lStatus%>
	        </td>           
	        
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Contract Group*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	       <INPUT name = "txtContGrp" value=<%=lConGrp%>>
	       </td>
	       
    
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Contract Unit*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	        <INPUT name = "txtConUnit" value=<%=lConUnit%>>
	        </td>   
	        
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Contract Type*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%" colspan="3">
	        <INPUT name = "txtConType" value=<%=lConType%>>
	       </td>   
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Trading Start Date*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtTrdStDate" value=<%=lTrdStDate%>>
	        </td>   
	        
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Trading End Date*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtTrdEndDate" value=<%=lTrdEndDate%>>
	        </td>   
	     </tr>
	     
	     <tr>
	       <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Delivery Start Date*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtDlvdStDate" value=<%=lDlvdStDate%>>
	        </td>   
	        
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Delivery End Date*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtDlvEndDate" value=<%=lDlvdEndDate%>>
	        </td>   
	     </tr>
	     
	    <tr class="tdbgdark">
	     <td  colspan="4" height="10" align = "middle"><font class="whiteboldtext1">Trade Information</font></td>
	     </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Market Lot</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtMktLot" value=<%=lMktLot%>>
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           OCP Trade Count
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtOCPTrdCount" value=<%=lOCPTrdCount%>>
	        </td>   
	     </tr>
	     
	     <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Tick Size in Rupees</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtTickSize" value=<%=lTickSize%>>
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           OCP Trade Duaration[Min]
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtOCPTrdDuration" value=<%=lOCPTrdDuration%>>
	        </td>   
	     </tr>
	     
	     <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Circuit Filter %</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtCirFilter" value=<%=lCirFilter*100%>>
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Min Drip Quantity %
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtMinDripQty" value=<%=lMinDripQty%>>
	        </td>   
	     </tr>
	     <tr>
	     
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Settlement Filter %</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%" colspan="3">
	          <INPUT name = "txtSettleFilter" value=<%=lSettleFilter%>>
	        </td>   
	      </tr>
	  

<% if Request.Form("txthidMode")="D" then%>
	<tr>
      <td  colspan=4 align=center class="tdbglight">
   		<input type="Button" name="sbtDelChrg"   value="Delete    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
	</tr>
 <input type=hidden name=txthidUserId value=<%=trim(Request.Form("optContCode"))%>>
 
<%else%>
	<tr>
    <td  colspan=4 align=center class="tdbglight">
   	<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
	</tr>
<%end if%>

</table>			
<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Contract Builder  View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Contracts details available for the selected cirteria. Click <a href="ContBuildMenu.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















