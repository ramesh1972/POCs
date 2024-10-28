<%@ Language=VBScript %>
<HTML>
<HEAD>
<SCRIPT LANGUAGE=javascript>
var selectedItem = "";

function div_onmousemove() {
	var x = window.event.x;
	var y = window.event.y;

	if (selectedItem == "") return;
	
	var width =  document.all(selectedItem).style.width;
	width = width.substr(0,width.length-2);
	var height =  document.all(selectedItem).style.height;
	height = height.substr(0,height.length-2);
	
	var dWidth = document.all.oDivForm.style.width;
	dWidth = dWidth.substr(0,dWidth.length-2);
	var dHeight = document.all.oDivForm.style.height;
	dHeight = dHeight.substr(0,dHeight.length-2);
	var dLeft = document.all.oDivForm.style.left;
	dLeft = dLeft.substr(0,dLeft.length-2);
	var dTop = document.all.oDivForm.style.top;
	dTop = dTop.substr(0,dTop.length-2);

	if (x - (width/2) < dLeft) return;
	if (y - (height/2) < dTop) return;
	
	if (x + (width/2)> eval(dWidth)+eval(dLeft)) return;
	if (y + (height/2)> eval(dHeight)+eval(dTop)) return;

	document.all(selectedItem).style.position = "absolute";
	document.all(selectedItem).style.left = x-(width/2)-dLeft;
	document.all(selectedItem).style.top = y-(height/2)-dTop;
}

function setelement() {
	selTag = event.srcElement.tagName;
	
	if (selTag =="DIV") {
		selectedItem = "";
		return;
	}
	
	if (selectedItem == "") 
		selectedItem = event.srcElement.id;
	else
		selectedItem = "";
}

function form_onsubmit() {
	var bLeft = frmForm.oButton.style.left;
	var bTop = frmForm.oButton.style.top;

	var sLeft = frmForm.oSelect.style.left;
	var sTop = frmForm.oSelect.style.top;

	var tLeft = frmForm.oText.style.left;
	var tTop = frmForm.oText.style.top;
	
	frmForm.bLeft.value  = bLeft;
	frmForm.bTop.value = bTop;

	frmForm.sLeft.value = sLeft;
	frmForm.sTop.value = sTop;

	frmForm.tLeft.value = tLeft;
	frmForm.tTop.value = tTop;

	return true;
}
</SCRIPT>
</HEAD>
<BODY>

<form name="frmForm" method="post" action="form-show.asp" onsubmit="return form_onsubmit();">
<DIV onclick="setelement()" onmousemove="div_onmousemove()" id=oDivForm style="width=300;height=200;background-color:inactivecaption" border=1>
<input type=button name=oButton id=oButton value="Click">
<input type=text name=oText id=oText value="Text">
<select name=oSelect id=oSelect>
<option>select</option>
</select>
<input type=submit Value="submit">
<input type=hidden name="bLeft">
<input type=hidden name="bTop">
<input type=hidden name="sLeft">
<input type=hidden name="sTop">
<input type=hidden name="tLeft">
<input type=hidden name="tTop">
</div>
</form>
</BODY>

<script language=javascript>
oDivForm.style.position = "absolute"; 
oDivForm.style.left = 100;
oDivForm.style.top = 50;
oDivForm.style.right = 400;
oDivForm.style.bottom = 250; 

frmForm.oButton.style.width = 80;
frmForm.oButton.style.height = 20;
frmForm.oSelect.style.width = 120;
frmForm.oSelect.style.height = 20;
frmForm.oText.style.width = 120;
frmForm.oText.style.height = 20;
</script>
</HTML>
