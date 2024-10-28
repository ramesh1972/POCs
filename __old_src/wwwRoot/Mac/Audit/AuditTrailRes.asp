<%@ Language=VBScript %>
	<HTML>
	<HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    </head>

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class="">
	<form>
	<br>
	<table align="center" width="80%" border="1">
	<tr class="tdbgdark" width="80%">
		<td align="center" class="whiteboldtext1">Audit Trail Response</td>
	</tr>
	</table>
	<br>
	<table align="center" width="80%" border="1">
	<tr class="tdbgdark" width="80%">
		<td colspan="4" class="whiteboldtext1">BCE Reference No</td>
	</tr>
	<tr class=tdbglight>
		<td ><font class=blacktext>Order Prefix<font></td> 
		<td><input type="text" name="txtprefix"></td>
		<td>Order Suffix </td>
		<td><input type="text" name="txtsuffix"></td>
	</tr>
	<tr class="tdbgdark">
	<td colspan="4" class="whiteboldtext1">
	Transaction Information
	</td>
	</tr>
	<tr class=tdbglight>
		<td>Transaction Date </td>
		<td><input type="text" name="txtTranDate"></td>
		<td>Transaction Time </td>
		<td><input type="text" name="txtTranTime"></td>
	</tr>
	<tr class="tdbgdark">
	<td colspan="4" class="whiteboldtext1">
	Event Information
	</td>
	</tr>
	<tr class=tdbglight>
		<td>Event Date </td>
		<td><input type="text" name="txtEvtDate"></td>
		<td>Event Time </td>
		<td><input type="text" name="txtEvtTime"></td>
	</tr>
	<tr class="tdbgdark">
	<td colspan="4" class="whiteboldtext1">
			Order Information
		</td>
	</tr>
	<tr class=tdbglight>
		<td>Order Status </td>
		<td><input type="text" name="txtOrdSts"></td>
		<td>Executed Quantity</td>
		<td><input type="text" name="txtExeQty"></td>
	</tr>
	<tr class=tdbglight>
		<td>Rejected Quantity </td>
		<td><input type="text" name="txtRejQty"></td>
		<td>Remain Quantity </td>
		<td><input type="text" name="txtRemQty"></td>
	</tr>
	<tr class=tdbglight>
		<td>Order Price </td>
		<td><input type="text" name="OrdPrc"></td>
		<td>Broker Order Ref</td>
		<td><input type="text" name="txtRemQty"></td>
	</tr>
</table>
</form>
</BODY>
</HTML>
