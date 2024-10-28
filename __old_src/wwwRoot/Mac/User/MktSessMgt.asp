	<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	MktSessMgt.asp										  *
	'* Purpose		:	This is used for Market Session Management	  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/12/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for Market Session Management							  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   27/12/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		
	option explicit 
	
	
	%>
	
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="Javascript">
	
	
	</script>
	
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	
	<form name="frmMktSessMgt" method="post" action="MktSessMgt.asp" >
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1">Market Session Management</font></td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Market Code</font>
	        </td>
	        <td  align="left" height="16"  width="30%">
				<select name="optMktCode" style="height: 22px; width: 199px">
					<option selected>------    Market Code   ------</option>
					<option value="BOOE">BOOE</option>
					<option value="KCEX">KCEX</option>
				</select> 
	        </td>
		</tr>
		
		<tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Basket Code</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optBasketCode" style="HEIGHT: 22px; WIDTH: 199px">
					<option selected>------   Basket Code   ------</option>
					<option value="BOOE">BOOE</option>
					<option value="BOOE1">BOOE1</option>
					<%'if not lRsUserId.BOF and lRsUserId.EOF then
						'while not lRsUserId.EOF %>
							<option value="<%'=lRsUserId(0)%>"><%'=lRsUserId(0)%></option>							
							<%'lRsUserId.MoveNext
					'	wend
					'end if%>
				</select> 
	        </td>
		</tr>
		
		
		 <tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Contract Code</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optContractCode" style="HEIGHT: 22px; WIDTH: 199px">
				<option value="ALL" selected>All</option>
				<% 'if not (lRSBOB.BOF and lRSBOB.EOF) then
					' while not lRSBOB.EOF %>
						<option value="<%'=lRsBOB.Fields("INST_CODE")%>"><%'=lRsBOB.Fields("INST_CODE")%></option>
						<% 'lRsBOB.MoveNext 
					'wend
				  'end if %>
			</select> 
	        </td>
		</tr>
		
	    <tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Event code</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="Event Code" style="HEIGHT: 22px; WIDTH: 199px">
					<option selected>------ Event code  ------</option>
					<option value="TVE0081000">TVE0081000</option>
					<option value="MNA0003000">MNA0003000</option>
		     </select> 
	        </td>
		</tr>
		
		<input type=hidden name="hidActionValue">	
		<tr class="tdbglight"> 
			<td colspan=2 valign="center" align=middle height="27">
				<input type="submit" name="sbtBrowse" value="Browse">
				<input type="reset" name="btnCancel" value="Cancel" >
			</td>
		</tr>
	</table>
	</form>
	<br><!---#include file="../includes/footer.inc"--->
	<body>
	</html>
	