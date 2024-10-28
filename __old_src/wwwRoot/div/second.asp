<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
<script language="javascript">
function OnMouseOverBody() {
	document.all.testdiv.style.left = window.event.clientX + 5;
	document.all.testdiv.style.top = window.event.clientY + 5;
	//document.all.text1.value = window.event.clientX;
	//document.all.text2.value = window.event.clientY;
}
</script>
<script language="javascript">
function testdivfunc(val) {
	if (val == 1) {
		document.all.testdiv.innerText = "Ramesh"; //<input type=text id=text1 name=text1><br><input type=text id=text2 name=text2>";
		document.all.testdiv.style.position = "absolute";
		document.all.testdiv.style.bottom = 50;
		document.all.testdiv.style.left = 100;
		document.all.testdiv.style.visibility  = "visible";
	}
	else
		document.all.testdiv.style.visibility  = "hidden";
}

function testspanfunc(val) {
	if (val == 1) {
		document.all.testspan.innerHTML = "<input type=text id=text1 name=text1><br><input type=text id=text2 name=text2>";
	}
	else
		document.all.testspan.style.visibility  = "hidden";
		
		
}
</script>
<script language="VBscript">
function hello()
	hello = Sin(1)
end function
</script>

</HEAD>
<BODY onmousemove="OnMouseOverBody();">
<!-- <form name="testfrm"> -->
<div id="testdiv">
Ramesh
</div>
<script language="javascript">
testdivfunc(1);
</script>
<input type=button  value="test" onclick="testdivfunc(1);">
<input type=button  value="test1" onclick="testdivfunc(2);" >
<BR>
<span id="testspan">
Viswanathan
</span>
<br>
<input type=button  value="test" onclick="testspanfunc(1);">
<input type=button  value="test1" onclick="testspanfunc(2);">

<!-- </form> -->
</BODY>
</HTML>
