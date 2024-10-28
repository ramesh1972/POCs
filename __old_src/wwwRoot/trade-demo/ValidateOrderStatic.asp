<%@ Language=VBScript %>

<HTML>
<HEAD>
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title>Welcome to the Bombay Commodity Exchange Limited</title>
<link rel="stylesheet" href="theme.css">
</head>
<body>
<%
dim lInstCode
dim lOrderBuySellFlag
dim lFilltype
dim lExpiryType
dim lStartMonth
dim lStartDate
dim lStartYear
dim lOrderQty
dim lDripQty
dim lOrderType
dim lPrice
dim lOrderstatus
dim lflgExecStatus

lflgExecStatus = false
if ucase(Request.Form("OrderBuySellFlag"))="B" then

	session("bInstCode")			= Request.Form("optInstrCode")
	session("bOrderBuySellFlag")	= Request.Form("OrderBuySellFlag")
	session("bFilltype")			= Request.Form("Filltype")
	session("bExpiryType")			= Request.Form("ExpiryType")
	session("bStartMonth")			= Request.Form("StartMonth")
	session("bStartDate")			= Request.Form("StartDate")
	session("bStartYear")			= Request.Form("StartYear")
	session("bOrderQty")			= Request.Form("OrderQty")
	session("bDripQty")				= Request.Form("DripQty")
	session("bOrderType")			= Request.Form("OrderType")
	session("bPrice")				= Request.Form("Price")
	session("bOrderstatus")			= Request.Form("Orderstatus")
	%>
	<table border="1" cellspacing="1" cellpadding="1" width="60%" align="center">
		<tr class="tdbgdark">
			<td class="tdbgdark" colspan=2 width="60%" align="left"><font class=whiteboldtext1>Order Entry Confirmation</font></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Contract Code</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext"><%=left(session("bInstCode"),10)%></font></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Order Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
						<%if session("bOrderBuySellFlag")= "B" then	%>Buy
						<%else%>Sell
						<%end if%><font class="blackboldtext"></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Fill Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
				<%select case(session("bFilltype"))
					case "P"	:	Response.Write "Partial Fill"
					case "I"	:	Response.Write "PartialFill And Kill"
					case "F"	:	Response.Write "FulFill Or Kill"
				end select 
				%></font></td>
			</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Expiry Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
				<%select case (session("bExpiryType"))
					case "C"	:	Response.Write "Good Till Cancel"
					case "D"	:	Response.Write "Good Till Date"
					case "Y"	:	Response.Write "Good For The Day"
				end select
				%></font></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Order Quantity</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
				<%=session("bOrderQty")%></font>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Order Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
			<%if session("bOrderType")="L" then
					Response.Write "Limit Price"
				else
					Response.Write "Market Price"
				end if
				%></font></td>
			
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Price</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext"><%=session("bPrice")%></font></td>
		</tr>
		</table>
	<%
	else
		
		session("sInstCode")			= Request.Form("optInstrCode")
		session("sOrderBuySellFlag")	= Request.Form("OrderBuySellFlag")
		session("sFilltype")			= Request.Form("Filltype")
		session("sExpiryType")			= Request.Form("ExpiryType")
		session("sStartMonth")			= Request.Form("StartMonth")
		session("sStartDate")			= Request.Form("StartDate")
		session("sStartYear")			= Request.Form("StartYear")
		session("sOrderQty")			= Request.Form("OrderQty")
		session("sDripQty")				= Request.Form("DripQty")
		session("sOrderType")			= Request.Form("OrderType")
		session("sPrice")				= Request.Form("Price")
		session("sOrderstatus")			= Request.Form("Orderstatus")
	
	%>
	<table border="1" cellspacing="1" cellpadding="1" width="60%" align="center">
		<tr class="tdbgdark">
			<td class="tdbgdark" colspan=2 width="60%" align="left"><font class=whiteboldtext1>Order Entry Response</font></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Contract Code</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext"><%=left(session("sInstCode"),10)%></font></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Order Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
						<%if session("sOrderBuySellFlag")= "B" then	%>Buy
						<%else%>Sell
						<%end if%><font class="blackboldtext"></td>
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Fill Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
				<%select case(session("sFilltype"))
					case "P"	:	Response.Write "Partial Fill"
					case "I"	:	Response.Write "PartialFill And Kill"
					case "F"	:	Response.Write "FulFill Or Kill"
				end select 
				%></font></td>
			</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Expiry Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
				<%select case (session("sExpiryType"))
					case "C"	:	Response.Write "Good Till Cancel"
					case "D"	:	Response.Write "Good Till Date"
					case "Y"	:	Response.Write "Good For The Day"
				end select
				%></font></td>
		</tr>
		
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Order Quantity</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
				<%=session("sOrderQty")%></font>
		</tr>
		
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Order Type</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext">
			<%if session("sOrderType")="L" then
					Response.Write "Limit Price"
				else
					Response.Write "Market Price"
				end if
				%></font></td>
			
		</tr>
		<tr class="tdbglight">
			<td class="" width="30%" align="left"><font class="blackboldtext">Price</font></td>
			<td class="" width="30%" align="left"><font class="blackboldtext"><%=session("sPrice")%></font></td>
		</tr>
		</table>
	<%end if%>
<table border="1" cellspacing="1" cellpadding="1" width="60%" align="center">			
	<tr class="tdbglight" align="left" width="60%">
		<td align=left width ="30%"><font class="blackboldtext">Order Status</font></td>
		<td align=left width ="30%"><font class="blackboldtext">
<%if Request.Form("OrderBuySellFlag")= "B" then
	if session("sOrderBuySellFlag")="" then
		Response.Write "Order Accepted </font></td>"
	else
		if session("bInstCode") = session("sInstCode")	and session("bPrice") = session("sPrice") and session("bExpiryType") = session("sExpiryType") and session("bOrderQty") <= session("sOrderQty") then
			Response.Write "Order is Executed </font></td>"
			lflgExecStatus = true
		else
			Response.Write "Order Accepted</font></td>"
		end if
	end if
end if


if Request.Form("OrderBuySellFlag")= "S" then
	if session("sOrderBuySellFlag")="" then
		Response.Write "Order Accepted</font></td>"
	else
		if session("bInstCode") = session("sInstCode")	and session("bPrice") = session("sPrice") and session("bExpiryType") = session("sExpiryType") and session("bOrderQty") >= session("sOrderQty") then
			Response.Write "Order is Executed</font></td>"
			lflgExecStatus = true
		else
			Response.Write "Order Accepted</font></td>"
		end if
	end if
end if

if lflgExecStatus = true then
	session("bInstCode")			= ""
	session("bOrderBuySellFlag")	= ""
	session("bFilltype")			= ""
	session("bExpiryType")			= ""
	session("bStartMonth")			= ""
	session("bStartDate")			= ""
	session("bStartYear")			= ""
	session("bOrderQty")			= ""
	session("bDripQty")				= ""
	session("bOrderType")			= ""
	session("bPrice")				= ""
	session("bOrderstatus")			= ""
	session("sInstCode")			= ""
	session("sOrderBuySellFlag")	= ""
	session("sFilltype")			= ""
	session("sExpiryType")			= ""
	session("sStartMonth")			= ""
	session("sStartDate")			= ""
	session("sStartYear")			= ""
	session("sOrderQty")			= ""
	session("sDripQty")				= ""
	session("sOrderType")			= ""
	session("sPrice")				= ""
	session("sOrderstatus")			= ""
end if%>
</tr>
</table>
</BODY>
</HTML>
