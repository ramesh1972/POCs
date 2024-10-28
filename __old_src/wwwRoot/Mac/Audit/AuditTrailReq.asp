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
		<td align="center" class="whiteboldtext1">Audit Trail Request</td>
	</tr>
	</table>
	<br>
	<table align="center" width="80%" border="1">
	<tr class="tdbgdark" width="80%">
		<td colspan="4" class="whiteboldtext1">Basic Information</td>
	</tr>
	<tr class=tdbglight>
		<td ><font class=blacktext>Contract Code<font></td> 
		<td><input type="text" name="txtCntCode"></td>
		<td>Contract Phase</td>
		<td><input type="text" name="txtCntPhs"></td>
	</tr>
	<tr class=tdbglight>
		<td>Broker Ref. No </td>
		<td><input type="text" name="txtBrkRefNo"></td>
		<td>Client Id</td>
		<td><input type="text" name="txtClntId"></td>
	</tr>
	<tr class=tdbglight>
		<td>TCM Id</td>
		<td><input type="text" name="txtTcmId"></td>
		<td>ICM Id</td>
		<td><input type="text" name="txtIcmId"></td>
	</tr>
	<tr class="tdbgdark">
	<td colspan="4" class="whiteboldtext1">
			Order Information
		</td>
	</tr>
	<tr class=tdbglight>
		<td>Order Type </td>
		<td><input type="text" name="txtOrdType"></td>
		<td>Order Sub Type</td>
		<td><input type="text" name="txtOrdSubType"></td>
	</tr>
	<tr class=tdbglight>
		<td>Price Protection</td>
		<td><input type="text" name="txtPrcPro"></td>
		<td>Order Book Type</td>
		<td><input type="text" name="txtOrdBkTyp"></td>
	</tr>
	<tr class=tdbglight>
		<td>Buy/Sell</td>
		<td><input type="text" name="txtbuySell"></td>
		<td>Order Quantity</td>
		<td><input type="text" name="txtOrdQty"></td>
	</tr>
	<tr class=tdbglight>
		<td>Drip Quantity</td>
		<td><input type="text" name="txtDrpQty"></td>
		<td>Order Price</td>
		<td><input type="text" name="txtOrdPrc"></td>
	</tr>
	<tr class=tdbglight>
		<td>Order Entered By</td>
		<td><input type="text" name="txtOrdEntby"></td>
		<td>Price Protection Limit</td>
		<td><input type="text" name="txtPrcProLmt"></td>
	</tr>
	<tr class=tdbglight>
		<td>Order Ownership</td>
		<td><input type="text" name="txtOrdOwnr"></td>
		<td></td>
		<td></td>
	</tr>
	<tr class="tdbgdark">
	<td colspan="4" class="whiteboldtext1">
			Expiry Information
		</td>
	</tr>
	<tr class=tdbglight>
		<td>Expiry Type </td>
		<td><input type="text" name="txtExpyType"></td>
		<td>Expiry Date</td>
		<td><input type="text" name="txtExpyDate"></td>
	</tr>
</table>
</form>
</BODY>
</HTML>
