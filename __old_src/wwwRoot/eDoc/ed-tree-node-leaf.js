var gFolderPageExpanded = false;
var gFolderPageExpandedAfter = false;

function here() {
}

function ToggleNode() {
	var lRadioValue = document.frmInsertSectionBefore.rSectionBefore;

	if (lRadioValue[1].checked) {
		document.all.dSectionTitle.innerHTML = "Enter Web Page Name<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
	else if (lRadioValue[0].checked) {
		document.all.dSectionTitle.innerHTML = "Enter Web Folder Name<BR><Input type='text' maxlength=256 size=60 name='tSectionNodeTitle'><BR>Enter Web Page Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
}

function ToggleNodeAfter() {
	var lRadioValue = document.frmInsertSectionAfter.rSectionAfter;

	if (lRadioValue[1].checked) {
		document.all.dSectionTitleAfter.innerHTML = "Enter Web Page Name<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
	else if (lRadioValue[0].checked) {
		document.all.dSectionTitleAfter.innerHTML = "Enter Web Folder Name<BR><Input type='text' maxlength=256 size=60 name='tSectionNodeTitle'><BR>Enter Web Page Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
}

function rEntity_onclick(piNodeID, piLeafElementID, piTableNo) {
	var lRadio =  document.all("rEntityBefore" + piLeafElementID);
	var lDiv = document.all("dEntityBefore" + piLeafElementID);
	
	if (lRadio[0].checked) {
		lDiv.innerHTML =				 "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-para-insert.asp'>" +
										 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=20%><B>Paragraph Title</B></TD>" + "<TD align='left'width=80%><INPUT name='tbParaTitleBefore" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR><TR>" + 
										 "<TD align='left' width=20%><B>Paragraph</B></TD>" + "<TD align='left' width=80%><Textarea name='taParaBefore" + piLeafElementID + "' cols=50 rows=8></Textarea></TD>" +
										 "</TR></TABLE><TABLE class='insertWebElementBody' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Paragraph'></TD></TR></TABLE>" +
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>" +
										 "</form>";
										 
										 
	}
	else if (lRadio[1].checked) {
		lDiv.innerHTML = 				 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Table Header</B></TD>" + "<TD align='left' width=60%><INPUT name='tbTableHeader" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR>" +
										 "</TABLE>" + 
										 "<Div id='dTable" + piLeafElementID + "' name='dTable" + piLeafElementID + "'></Div>" +
										 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR><TD><input type='button' value='Insert Row' onclick='TableAddRow(" + piTableNo + "," + piLeafElementID + ", gTableRowCount[" + piTableNo + "], gTableCells[" + piTableNo + "][gTableRowCount[" + piTableNo + "]]);'></TD></TR>" +
										 "</TABLE>" + 
										 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Table Footer</B></TD>" + "<TD align='left' width=60%><INPUT name='tbTableFooter" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR>" +
										 "</TABLE>" + 
										 "<TABLE class='insertWebElementBody' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Table'></TD></TR></TABLE>" +
 										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>";

	}	
	else if (lRadio[6].checked) {
		lDiv.innerHTML = "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-break-insert.asp'>" +
						 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
	  					 "<TR>" +
						 "<TD align='left' width=175><B>Number of Line Breaks</B></TD>" + "<TD align='left' width=60%><INPUT name='tNoOfBreaksBefore" + piLeafElementID + "' size=10 type='text'></TD>" +  
						 "</TR></TABLE><TABLE class='insertWebElementBody' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Breaks'></TD></TR></TABLE>" +
						 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
						 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
						 "<input type='hidden' name='hDirection' Value='Before'>" +
						 "</FORM>";
	}
	else {
		lDiv.innerHTML = "";
	}
}

function rEntityAfter_onclick(piNodeID, piLeafElementID) {
	var lSelIndex;
	
	var lRadio =  document.all("rEntityAfter" + piLeafElementID);
	var lDiv = document.all("dEntityAfter" + piLeafElementID);

	if (lRadio[0].checked) {
		lDiv.innerHTML = "<FORM method='post' name='frmInsertEntityAfter" + piLeafElementID + "' action='ed-tree-leaf-para-insert.asp'>" + 
										 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=20%><B>Paragraph Title</B></TD>" + "<TD align='left'width=80%><INPUT name='tbParaTitleAfter" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR><TR>" + 
										 "<TD align='left' width=20%><B>Paragraph</B></TD>" + "<TD align='left' width=80%><Textarea name='taParaAfter" + piLeafElementID + "' cols=50 rows=8></Textarea></TD>" +
										 "</TR></TABLE><TABLE class='insertWebElementBody' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Paragraph' STYLE='BORDER-COLLAPSE: collapse'></TD></TR></TABLE>" +
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='After'>";
										 
	}
	else if (lRadio[6].checked) {
		lDiv.innerHTML = "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-line-break-insert.asp'>" + 
						 "<TABLE border=1 width=100% align='center' class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
						 "<TR>" +
						 "<TD align='left' width=175><B>Number of Line Breaks</B></TD>" + "<TD align='left' width=60%><INPUT name='tNoOfBreaksAfter" + piLeafElementID + "' size=10 type='text'></TD>" +  
						 "</TR></TABLE><TABLE class='insertWebElementBody' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Breaks' id=submit2 name=submit2></TD></TR></TABLE>" +
						 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
						 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
						 "<input type='hidden' name='hDirection' Value='Before'>";
	}
	else {
		lDiv.innerHTML = "";
	}
}

function ToggleFolderPageInsert(piNodeID) {
	var oDiv = document.all.divFolderPage;

	if (gFolderPageExpanded) {
		// collapse
		oDiv.innerHTML = "";
		gFolderPageExpanded = false;
	}
	else {
		// expand
		oDiv.innerHTML = "<FORM name='frmInsertSectionBefore' method='post' action='ed-tree-node-insert.asp'>" +
			"<TABLE align='center' width=100% border=1 class='tlightb' STYLE='BORDER-COLLAPSE: collapse'>" +
			"<TR>" +
				"<TD width=50% align='left'><input type='radio' name='rSectionBefore' Value='Folder' onclick='ToggleNode();'>Web Folder</TD>" +
				"<TD width=50% align='left'><input type='radio' name='rSectionBefore' Value='Leaf' checked onclick='ToggleNode();'>Web Page</TD>" + 
			"</TR>" +
			"</TABLE>" +
			"<TABLE align='center' width=100% border=1 class='tlightb' STYLE='BORDER-COLLAPSE: collapse'>" +
			"<TR>" +
				"<TD width=100%><div id='dSectionTitle'></div></TD>" +
			"</TR>" +
			"<TR>" +
				"<TD align='center'><INPUT type=submit value='Insert'>" +
				"</TD>" +
			"</TR>" +
			"</TABLE>" +
			"<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
			"<input type='hidden' name='hDirection' Value='Before'>" +
			"</FORM>";

		ToggleNode();
		gFolderPageExpanded = true;
	}
}

function ToggleFolderPageInsertAfter(piNodeID) {
	var oDiv = document.all.divFolderPageAfter;

	if (gFolderPageExpandedAfter) {
		// collapse
		oDiv.innerHTML = "";
		gFolderPageExpandedAfter = false;
	}
	else {
		// expand
		oDiv.innerHTML = "<FORM name='frmInsertSectionAfter' method='post' action='ed-tree-node-insert.asp'>" +
			"<TABLE align='center' width=100% border=1 class='tlightb' STYLE='BORDER-COLLAPSE: collapse'>" +
			"<TR>" +
				"<TD width=50% align='left'><input type='radio' name='rSectionAfter' Value='Folder' onclick='ToggleNodeAfter();'>Web Folder</TD>" +
				"<TD width=50% align='left'><input type='radio' name='rSectionAfter' Value='Leaf' checked onclick='ToggleNodeAfter();'>Web Page</TD>" + 
			"</TR>" +
			"</TABLE>" +
			"<TABLE align='center' width=100% border=1 class='tlightb' STYLE='BORDER-COLLAPSE: collapse'>" +
			"<TR>" +
				"<TD width=100%><div id='dSectionTitleAfter'></div></TD>" +
			"</TR>" +
			"<TR>" +
				"<TD align='center'><INPUT type=submit value='Insert'>" +
				"</TD>" +
			"</TR>" +
			"</TABLE>" +
			"<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
			"<input type='hidden' name='hDirection' Value='After'>" +
			"</FORM>";

		ToggleNodeAfter();
		gFolderPageExpandedAfter = true;
	}
}

function TogglePageElementInsert(piNodeID, piLeafElementID) {
	var lDiv = document.all("divPageElementInsert" + piLeafElementID);
	var lHiddenExpanded = document.all("hInsertElementExpanded" + piLeafElementID);
	
	if (lHiddenExpanded.value == "true") {
		lDiv.innerHTML = "";
		lHiddenExpanded.value = "false";
	}
	else {	
		lDiv.innerHTML = 
		"<TABLE align='center' width=100% class='insertWebElementHead' STYLE='BORDER-COLLAPSE: collapse'>" +
		"<TR>" +
			"<TD><font class='insertWebElementHeadText'>Insert</font></TD>" +
		"</TR>" +
		"</TABLE>" +

		"<TABLE align='center' width=100% border=1 class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
		"<TR>" +
		   "<TD align='left'><input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0 );' Value='PARA'>Paragraph" +
							"<input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='TABLE'>Table" +
							"<input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='HLINK'>Hyper Link" +
							"<input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='IMAGE'>Image" +
							"<input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='AUDIO'>Audio" +
							"<input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='VIDEO'>Video" +
							"<input type='radio' name='rEntityBefore" + piLeafElementID + "' onclick='return rEntity_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='BREAK'>Line Break" +
			"</TD>" +
		"</TR>" +
		"</TABLE>" +

		"<TABLE align='center' width=100% border=1 class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
		"<TR>" +
			"<TD align='left'>" +
			"<div id='dEntityBefore" + piLeafElementID + "'></div>" +
			"</TD>" +
		"</TR>" +
		"</TABLE>";
		
		lHiddenExpanded.value = "true";
	}
}

function TogglePageElementInsertAfter(piNodeID, piLeafElementID) {
	var lDiv = document.all("divPageElementInsertAfter" + piLeafElementID);
	var lHiddenExpanded = document.all("hInsertElementExpandedAfter" + piLeafElementID);
	
	if (lHiddenExpanded.value == "true") {
		lDiv.innerHTML = "";
		lHiddenExpanded.value = "false";
	}
	else {	
		lDiv.innerHTML = 
		"<TABLE align='center' width=100% class='insertWebElementHead' STYLE='BORDER-COLLAPSE: collapse'>" +
		"<TR>" +
			"<TD><font class='insertWebElementHeadText'>Insert</font></TD>" +
		"</TR>" +
		"</TABLE>" +

		"<TABLE align='center' width=100% border=1 class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
		"<TR>" +
		   "<TD align='left'><input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0 );' Value='PARA'>Paragraph" +
							"<input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='TABLE'>Table" +
							"<input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='HLINK'>Hyper Link" +
							"<input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='IMAGE'>Image" +
							"<input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='AUDIO'>Audio" +
							"<input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='VIDEO'>Video" +
							"<input type='radio' name='rEntityAfter" + piLeafElementID + "' onclick='return rEntityAfter_onclick(" + piNodeID + "," + piLeafElementID + ",0);' Value='BREAK'>Line Break" +
			"</TD>" +
		"</TR>" +
		"</TABLE>" +

		"<TABLE align='center' width=100% border=1 class='insertWebElementBody' STYLE='BORDER-COLLAPSE: collapse'>" +
		"<TR>" +
			"<TD align='left'>" +
			"<div id='dEntityAfter" + piLeafElementID + "'></div>" +
			"</TD>" +
		"</TR>" +
		"</TABLE>";
		
		lHiddenExpanded.value = "true";
	}
}
