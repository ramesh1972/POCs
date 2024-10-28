<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<script language="javascript">
var currentTab = 0;
var currentleft = 0;
var prevtext = "New";

function SelectTab(tabNo, pileft,pitext) {
	var oDiv = document.all("oDivHead" + tabNo);
	var oDivCurrent = document.all("oDivHead" + currentTab);	
	
	oDiv.innerHTML = "<Img STYLE='position:absolute;left:" + pileft + "px;top:10px;zIndex:2' src='tab-sel.bmp'>" + 
					 "<span STYLE='position:absolute;top:10px;left:" + (pileft+10) + "px;zIndex:1'>" + pitext + "</span>";
	oDivCurrent.innerHTML = "<Img STYLE='position:absolute;left:" + currentleft + "px;top:10px;zIndex:2' src='tab.bmp'>" + 
						    "<span STYLE='position:absolute;top:10px;left:" + (currentleft+10) + "px;zIndex:1'>" + prevtext + "</span>";
	
	oDivBody.innerText = pitext + " Tab = " + tabNo;
	currentTab = tabNo;
	currentleft = pileft;
	prevtext = pitext;
}
</script>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>

<table border=1 style="border-collapse:collapse" width=50%>
<tr>
<td width=25%>
<Div id=oDivHead0 onclick="SelectTab(0, 10, 'New');"></Div>
</td>
<td width=25%>
<Div id=oDivHead1 onclick="SelectTab(1,100, 'Edit');"></Div>
</td>
<td width=25%>
<Div id=oDivHead2 onclick="SelectTab(2,190, 'Save');"></Div>
</td>
<td width=25%>
<Div id=oDivHead3 onclick="SelectTab(3,280, 'Close');"></Div>
</td>
</tr>
</table>
<table id=oTable style="border-collapse:collapse" width=400>
<tr>
<td>
<Div id=oDivBody></Div>
</td>
</tr>
</table>
</BODY>
<script language=javascript>
oDivBody.style.width=oTable.width;
oDivBody.style.height=200;
oDivBody.style.position="absolute";
oDivBody.style.left=0;
oDivBody.style.top=30;
oDivBody.style.backgroundColor = "yellow";

SelectTab(0, 10, "New");
SelectTab(1, 100, "Edit");
SelectTab(2, 190, "Save");
SelectTab(3, 280, "Close");
</script>
</HTML>
