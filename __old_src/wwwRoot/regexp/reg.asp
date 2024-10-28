<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<input type="text" name="ebDate">
<input type="button" value="click" onclick="extract();">


</BODY>
<script language="javascript">
function extract() {
var lDate = document.all("ebDate").value;
var arr;

var lRegExp = /(\d{4})-(\d{2})-(\d{2})/i;
arr = lDate.match(lRegExp);
alert("Year = " + arr[1] + " Month = " + arr[2] + " Day = " + arr[3]);
}
</script>
</HTML>
