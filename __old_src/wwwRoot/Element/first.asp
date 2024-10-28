<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<script language="javascript">
function CreateTextBox() {
	var obj = document.createElement("<INPUT type='text'>");
	document.body.appendChild(obj);
}
</script>
</HEAD>
<BODY>

<input type=button onclick="CreateTextBox();">

</BODY>
</HTML>
