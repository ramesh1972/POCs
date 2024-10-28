<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
</SCRIPT>
</HEAD>
<BODY LANGUAGE=javascript topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<OBJECT classid=clsid:0713E8A2-850A-101B-AFC0-4210102A8DA7 height=85 
id=TreeView1 VIEWASTEXT><PARAM NAME="_ExtentX" VALUE="5927"><PARAM NAME="_ExtentY" VALUE="11086"><PARAM NAME="_Version" VALUE="327682"><PARAM NAME="HideSelection" VALUE="1"><PARAM NAME="Indentation" VALUE="1005"><PARAM NAME="LabelEdit" VALUE="0"><PARAM NAME="LineStyle" VALUE="1"><PARAM NAME="PathSeparator" VALUE=""><PARAM NAME="Sorted" VALUE="0"><PARAM NAME="Style" VALUE="7"><PARAM NAME="ImageList" VALUE=""><PARAM NAME="BorderStyle" VALUE="0"><PARAM NAME="Appearance" VALUE="1"><PARAM NAME="MousePointer" VALUE="0"><PARAM NAME="Enabled" VALUE="1"><PARAM NAME="OLEDragMode" VALUE="0"><PARAM NAME="OLEDropMode" VALUE="0"></OBJECT>

<script language="VBScript">
	Dim nodX

	Set nodX = TreeView1.Nodes.Add(,,"R","Root")
	Set nodX = TreeView1.Nodes.Add("R", 4,"C1","Child 1")
	Set nodX = TreeView1.Nodes.Add("R", 4,"C2","Child 2")
	Set nodX = TreeView1.Nodes.Add("R", 4,"C3","Child 3")
	Set nodX = TreeView1.Nodes.Add("R", 4,"C4","Child 4")
	Set nodX = TreeView1.Nodes.Add("C2", 4, "C2.5","Child 2.5")		
	Set nodX = TreeView1.Nodes.Add("C2.5", 4, "C2.6","Child 2.5")		
</script>

<script language=javascript>
	TreeView1.style.height= parent.window.screen.height; 
	TreeView1.style.width = 200;
	TreeView1.style.left = 0;
	TreeView1.style.color="red";
	TreeView1.style.top = 0;
	TreeView1.style.border = 0;
</script>
</BODY>
</HTML>
