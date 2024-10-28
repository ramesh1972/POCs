<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<SCRIPT LANGUAGE=javascript>
<!--
var gSearchText = new Array();
gSearchText[0] = "SELECT";
gSearchText[1] = "FROM";
gSearchText[2] = "WHERE";
gSearchText[3] = "HAVING";

function div_onkeyup() {
	var lCode = window.event.keyCode;
	var lKey = String.fromCharCode(lCode);
	var lText = document.all.oDiv.innerText;
	var lOutText = lText;
	var lOutText1 = lText;
	var lRegExp = "";
	
	if ((lKey >= 'a' && lKey <= 'z') || 
		(lKey >= 'A' && lKey <= 'Z') ||
		(lKey >= '0' && lKey <= '9') ||
		(lKey == ' ')) {

		for (var lIdx = 0; lIdx < gSearchText.length; lIdx++) {
			lRegExp = "/(" + gSearchText[lIdx] + ")/gi";
			lOutText = lOutText.replace(eval(lRegExp), "<font color='blue'>$1</font>");	
		}

		lOutText1 = lOutText.replace(/\n/g, "<BR>");
		document.all.oDiv.innerHTML	= lOutText1;
	}
}

function fonclick() {
	document.all.ta.innerText = document.all.oDiv.innerText;
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<DIV id=oDiv CONTENTEDITABLE ALIGN=left onkeyup="return div_onkeyup();" STYLE="height:100; 
                width:95%;background-color:inactiveborder; font-face:Arial; padding:3;LINE-HEIGHT: normal;    
                border:inset #99ccff; scrollbar-base-color:#99ccff;">
</DIV> 

<BR>
<input type=button value=but onclick="fonclick();">
<BR>
<textarea id=ta></textarea>
</BODY>
</HTML>
