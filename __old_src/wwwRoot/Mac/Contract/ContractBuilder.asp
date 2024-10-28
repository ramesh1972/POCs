<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Mac Module 											  *
	'* File name	:	ContractBuilder.asp									  *
	'* Purpose		:	This is used to contract Builder screen               *
	'* Prepared by	:	Obula Reddy         								  *	
	'* Date			:	03.04.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to go to the Login Page deponds on the user.Here TCM,	  *
	'* ICM, SubBroker & Client can go to their appropriate Login Page.		  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.-Date		 - By					- Explanation	   		  *
	'*	1		   03.04.2001  V.Christopher Britto   First Baseline		  *
	'*	2		   05.05.2001  V.Christopher Britto   SubBroker method is	  *
	'*												  removed				  *						  *
	'**************************************************************************
	Dim lObjDataService   'Data Service Component Instance
	set lObjDataService = Server.CreateObject("MacWebCon.clsMacWebCon")
	%>
	
	<HTML>
	<HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
	<center>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	</HEAD>
	<script language="JavaScript">
	  function FunctionCancel()
	  {
	   document.frmContBuild.action="ContBuildMenu.asp";
	   document.frmContBuild.submit();
	  }     
	 function FunctionAdd()
	 {
	 // the following include file contains all validaton about the form
	  <!-- #include file="../Includes/ConBuildValid.inc"--> 
	     
	  }    
	 
	 </script>
	
	
	<center>
	<form name = "frmContBuild" method = "post" action = "ContBuildRes.asp">
	   <table width="90%" border="0"  cellpadding=1 cellspacing=1 align=center>
	    <tr class="tdbgdark" >
	       <td  align = "middle" colspan=4 height="10"><font class="whiteboldtext1">Contract Information</font></td>
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Contract Code</div></td>
	       <td align="left"   class="tdbglight" height="16"  width="30%" >
	       <INPUT name = "lstConCode">
	       </td>   
	       <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Contract Base Code*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtContBasePrice">
	        </td>
	    </tr>
	    
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Description*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtDesc"  >
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Contract Status*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <% Dim lObjRsConStatus
				  Set lObjRsConStatus = Server.CreateObject("ADODB.Recordset")
	              Set lObjRsConStatus = lObjDataService.GetInstSatus()
	              lObjRsConStatus.MoveFirst%>
	           <SELECT style="HEIGHT: 22px; WIDTH: 199px" name = "lstConStatus">
	           <%Do while lObjRsConStatus.EOF = false%>
					<OPTION value = <%=lObjRsConStatus(0)%> ><%=lObjRsConStatus(1)%></OPTION>
					<% lObjRsConStatus.MoveNext 
	             Loop
	             Set lObjRsConStatus = Nothing%>
	           </SELECT>
	        </td>   
	        
	    </tr>
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Contract Group*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <SELECT style="HEIGHT: 22px; WIDTH: 199px"  name="lstConGrp">
	           <% Dim lObjRsConGrp
	              set lObjRsConGrp = Server.CreateObject("ADODB.Recordset")
	              Set lObjRsConGrp = lObjDataService.GetCommodityGroup()
	              lObjRsConGrp.MoveFirst 
	              Do while lObjRsConGrp.EOF = false %>
	           
	           <OPTION  value = <%=lObjRsConGrp("comg_grp_code")%>><%=lObjRsConGrp("comg_grp_desc")%></OPTION>
	            <%lObjRsConGrp.MoveNext 
              Loop
              Set lObjRsConGrp = Nothing%>   	          
	           </SELECT>
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Contract Unit*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <SELECT   style="HEIGHT: 22px; WIDTH: 199px" name = "lstConUnit">
	           <OPTION selected >Kilogram</OPTION>
	           <OPTION>Litres</OPTION>
	           </SELECT>
	        </td>   
	        
	    </tr>
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Contract Type*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%" colspan="3">
	           <SELECT style="HEIGHT: 22px; WIDTH: 199px" name="lstConType">
	           <% Dim lObjRsConType
	              set lObjRsConType = Server.CreateObject("ADODB.Recordset")
	              Set lObjRsConType = lObjDataService.GetComgTypes()
	              lObjRsConType.MoveFirst 
	              Do while lObjRsConType.EOF = false %>
	           <OPTION value = <%=lObjRsConType("comt_type_code")%>><%=lObjRsConType("comt_short_desc")%></OPTION>
	            <%lObjRsConType.MoveNext 
              Loop
              Set lObjRsConType = Nothing%>   	           
	           </SELECT>
	        </td>   
	        
	        
	    </tr>
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Trading Start Date*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtTrdStDate"  >
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Trading End Date*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtTrdEndDate"  >
	        </td>   
	     </tr>
	     <tr>
	       <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Delivery Start Date*</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtDlvdStDate"  >
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Delivery End Date*
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtDlvEndDate"  >
	        </td>   
	     </tr>
	     
	     <tr class="tdbgdark">
	       <td  colspan="4" height="10" align = "middle"><font class="whiteboldtext1">Trade Information</font></td>
	     </tr>
	    <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Market Lot</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtMktLot"  >
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           OCP Trade Count
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtOCPTrdCount"  >
	        </td>   
	     </tr>
	     <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Tick Size in Rupees</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtTickSize"  >
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           OCP Trade Duaration[Min]
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtOCPTrdDuration"  >
	        </td>   
	     </tr>
	     <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Circuit Filter %</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%">
	          <INPUT name = "txtCirFilter"  >
	        </td>   
	        <td  height="27" align=left  width="20%" class="tdbglight"><div align="left" class="blacktext">
	           Min Drip Quantity %
	         </div>  
	        </td>
	        <td align="left"   class="tdbglight" height="16"  width="30%">
	           <INPUT name = "txtMinDripQty"  >
	        </td>   
	     </tr>
	     <tr>
	       <td  height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Settlement Filter %</div></td>
	       <td align = "left" class="tdbglight" height="16"  width="30%" colspan="3">
	          <INPUT name = "txtSettleFilter"  >
	        </td>   
	      </tr>
	     <tr class="tdbgdark" >
	       <td  align = "middle" colspan="4" height="10">
	         <%if Request.QueryString("Mode") = "A" then  %>
	             <Input type = "Hidden" name = "txtProcess" value = "A">
	             <INPUT type = "submit"  name = "sbtAdd" value = "Add" onclick="FunctionAdd();">
	         <%elseif Request.QueryString("Mode") = "U" then%>   
	             <Input type = "Hidden" name = "txtProcess" value = "U">
	    	     <INPUT type = "submit"  name = "sbtModify" value = "Modify">
	    	  <%elseif Request.QueryString("Mode") = "D" then %>   
	    	    <Input type = "Hidden" name = "txtProcess" value = "D">   
	            <INPUT type = "submit"  name = "sbtDelete" value = "Delete">
	          <%elseif Request.QueryString("Mode") = "V" then%>   
	            <Input type = "Hidden" name = "txtProcess" value = "V">
	            <INPUT type = "submit"  name = "sbtView" value = "View">
	          <%End If%>  
	          <INPUT type = "reset"   name = "rstCancel" value = "Cancel" onclick="FunctionCancel();">
	       </td>
	    </tr>
	    </table>
	    <br>
	    <br> 
        	    
	    
	</form>
	<p>&nbsp;</p>
	<br>
	<br>
	<center><!-- #include file="../Includes/footer.inc"--></center></center>
	</body>
	</html>

	