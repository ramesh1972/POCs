<%@ Language=VBScript %>
<HTML>
<HEAD>
<!-- #include = file="adovbs.inc" -->
<LINK REL=StyleSheet HREF="theme.css">
<!-- #include file="ed-common-selects.asp" -->
<script language="javascript">
// -----------------------------------------------------------------------------
// Table related functions
var gTableMaxRows = 100;
var gTableMaxCols = 100;
var gTableMaxTables = 25;

//var gTableCount = 0;
var gTableRowCount = new Array(gTableMaxTables);
var gTableHTMLs = new Array(gTableMaxTables);
var gCellButtonExpanded = new Array(gTableMaxTables);
var gTableCells = new Array(gTableMaxTables);

for (var lIdx1 = 0; lIdx1 < gTableMaxTables; lIdx1++) {
	gTableHTMLs[lIdx1] = new Array(gTableMaxRows);
	for (var lIdx2 = 0; lIdx2 < gTableMaxRows; lIdx2++) { 
		gTableHTMLs[lIdx1][lIdx2] = "";
	}
}
	
for (lIdx1 = 0; lIdx1 < gTableMaxTables; lIdx1++) {
	gTableCells[lIdx1] = new Array(gTableMaxCols);
	for (lIdx2 = 0; lIdx2 < gTableMaxCols; lIdx2++) 
		gTableCells[lIdx1][lIdx2] = 1;
}

for (lIdx1 = 0; lIdx1 < gTableMaxTables; lIdx1++) {
	gCellButtonExpanded[lIdx1] = new Array(gTableMaxRows);
	for (lIdx2 = 0; lIdx2 < gTableMaxRows; lIdx2++) {
		gCellButtonExpanded[lIdx1][lIdx2] = new Array(gTableMaxCols);
		for (var lIdx3 = 0; lIdx3 < gTableMaxCols; lIdx3++) 	
			gCellButtonExpanded[lIdx1][lIdx2][lIdx3] = true;
	}
}

for (var lIdx1 = 0; lIdx1 < gTableMaxTables; lIdx1++) {
	gTableRowCount[lIdx1] = 0;
}

function TableAddRow(piTableNo, piLeafElementID, piPosition, piCellPosition) {
	var oDiv = document.all("dTable" + piLeafElementID);
	var lDivHTML = "";

	for (var lIdx = gTableRowCount[piTableNo]; lIdx > piPosition; lIdx--) {
		gTableHTMLs[piTableNo][lIdx] = gTableHTMLs[piTableNo][lIdx-1];
		gTableCells[piTableNo][lIdx] = gTableCells[piTableNo][lIdx-1];
		gCellButtonExpanded[piTableNo][lIdx] = gCellButtonExpanded[piTableNo][lIdx-1];
	}
	
	gTableHTMLs[piTableNo][lIdx] = "<TABLE id='tTableTable" + piTableNo + "Row" + lIdx + "' border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
					  "<TBODY id = 'tTableBody"  + piTableNo + "Row" + lIdx + "'>" + 
					  "</TBODY>" +
					  "</TABLE>";		

	// insert the cells here
	gTableRowCount[piTableNo]++;
	for (lIdx = 0; lIdx < gTableRowCount[piTableNo]; lIdx++) {
		lDivHTML = lDivHTML + gTableHTMLs[piTableNo][lIdx];
	}
	
	oDiv.innerHTML = lDivHTML;
	
	// Create the number of cells in each row
	for (lIdx = 0; lIdx < gTableRowCount[piTableNo]; lIdx++) {
		var oTable = document.all("tTableBody" + piTableNo + "Row" + lIdx);
		var oRow = oTable.insertRow();
		
		// Insert the delete row link
		var oCell = oRow.insertCell();
		oCell.innerHTML = "<input type='button' onclick='TableDeleteRow(" + piLeafElementID + "," + lIdx + ");' Value='Delete Row'>";
		oCell.vAlign="top";
		oCell.align = "left";

		var oCell = oRow.insertCell();
		oCell.color = "cyan";
		oCell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		
		// insert a default cell
 		var lNumCells = gTableCells[piTableNo][lIdx];
		for (var lIdxc = 0; lIdxc < lNumCells; lIdxc++) {
			TableAddCell(piTableNo,piLeafElementID, oRow, lIdx, lIdxc+1, "ExistingCell");
			gCellButtonExpanded[piTableNo][lIdx][lIdxc] = true;
		}

		var oCell = oRow.insertCell();
		oCell.color = "cyan";
		oCell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

		// Insert the insert cell link
//		var oCell = oRow.insertCell();
  //  	oCell.innerHTML = "<input type='button' onclick='TableDeleteCell(" + piTableNo + "," + piLeafElementID + "," + lIdx + ");' Value='Delete Cell'>" + 
	//					  "<input type='button' onclick='TableInsertCell(" + piTableNo + "," + piLeafElementID + "," + lIdx + ");' Value='Insert Cell'>";
	//	oCell.vAlign="top";
	//	oCell.align = "left";
	}
}

function TableInsertCell(piTableNo, piLeafElementID,piRowID, piPosition) {
	var oRow = document.all("tTableTable" + piTableNo + "Row" + piRowID).rows(0);
	oRow.deleteCell(oRow.cells.length-1);
	
	TableAddCell(piTableNo, piLeafElementID, oRow, piRowID, piPosition, "");
}

function TableAddCell(piTableNo, piLeafElementID, piRow, piRowID, piPosition, piCellOrg) {
	var lCellCount = piRow.cells.length-1;

	for (var lIdx = 0; lIdx < lCellCount ;lIdx++) {
		piRow.deleteCell(piRow.cells.length-1);
	}
	
	if (piCellOrg == "ExistingCell") 
		lCellCount--;
		
	for (lIdx = 0; lIdx < lCellCount+1; lIdx++) {
		var oCell = piRow.insertCell(piRow.cells.length);
		oCell.style.backgroundColor = "cyan";
		oCell.innerHTML = "<div id='dCellButtonT" + piTableNo + "R" + piRowID + "C" + lIdx + "'></div>";
		oCell.align = "left";
		oCell.vAlign = "top";

		CellButtonDefault(piTableNo, piLeafElementID, piRowID,lIdx);
	}
	
	if (piCellOrg == "ExistingCell") 
		return;
		
	gTableCells[piTableNo][piRowID] += 1;
	TableRefresh(piTableNo,piLeafElementID);
}

function CellButtonDefault(piTableNo, piLeafElementID, piRow, piCell) {
	var lDiv = document.all("dCellButtonT" + piTableNo + "R" + piRow + "C" + piCell);
	lDiv.innerHTML = "<input type='button' value='Open Cell' onclick='ToggleCellButton(" + piTableNo + "," + piLeafElementID + "," + piRow + "," + piCell + ");'>" +
					 "<BR><A href='javascript:here();' onclick='TableInsertCell(" + piTableNo + "," + piLeafElementID + "," + piRow + "," + (piCell+1) + ");'><font class='text8'>Insert</font></A>," + 
					 "<A href='javascript:here();' onclick='TableDeleteCell(" + piTableNo + "," + piLeafElementID + "," + piRow + ");'><font class='text8'>Delete </font></A><font class='text8'>Cell</font>" + piCell;
}

function ToggleCellButton(piTableNo, piLeafElementID, piRow, piCell) {
	var lDiv = document.all("dCellButtonT" + piTableNo + "R" + piRow + "C" + piCell);
	
	window.open("ed-tree-leaf-table-cell-edit.asp","_blank",'top=0,left=0,toolbar=no,menubar=no,height=350,width=550');	
	gCellButtonExpanded[piTableNo][piRow][piCell] = true;
}

function TableRefresh(piTableNo, piLeafElementID) {
	var oDiv = document.all("dTable" + piLeafElementID);
	var lDivHTML = "";

	for (lIdx = 0; lIdx < gTableRowCount[piTableNo]; lIdx++) {
		lDivHTML = lDivHTML + gTableHTMLs[piTableNo][lIdx];
	}
	
	oDiv.innerHTML = lDivHTML;
	
	// Create the number of cells in each row
	for (lIdx = 0; lIdx < gTableRowCount[piTableNo]; lIdx++) {
		var oTable = document.all("tTableBody" + piTableNo + "Row" + lIdx);
		var oRow = oTable.insertRow();
		
		// Insert the delete row link
		var oCell = oRow.insertCell();
		oCell.innerHTML = "<input type='button' onclick='TableDeleteRow(" + piLeafElementID + "," + lIdx + ");' Value='Delete Row'>";
		oCell.vAlign="top";
		oCell.align = "left";

		var oCell = oRow.insertCell();
		oCell.color = "cyan";
		oCell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		
		// insert a default cell
 		var lNumCells = gTableCells[piTableNo][lIdx];
		for (var lIdxc = 0; lIdxc < lNumCells; lIdxc++) {
			TableAddCell(piTableNo, piLeafElementID, oRow, lIdx, lIdxc+1, "ExistingCell");
			gCellButtonExpanded[piTableNo][lIdx][lIdxc] = true;
		}

		var oCell = oRow.insertCell();
		oCell.color = "cyan";
		oCell.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

		// Insert the insert cell link
//		var oCell = oRow.insertCell();
  //  	oCell.innerHTML = "<input type='button' onclick='TableDeleteCell(" + piLeafElementID + "," + lIdx + ");' Value='Delete Cell'>" + 
	//					  "<input type='button' onclick='TableInsertCell(" + piTableNo + "," + piLeafElementID + "," + lIdx + ");' Value='Insert Cell'>";
	//	oCell.vAlign="top";
	//	oCell.align = "left";
	}
}


// -----------------------------------------------------------------------------
// Paragraph related functions
function ParaTitlePropertyApply(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lTitle = lForm("tbParaTitle" + piElementID);
	
	// Set the properties for the para title
	lTitle.style.textAlign = lForm.sTextAlign.value;
	lTitle.style.color = lForm.sTextColor.value;
	lTitle.style.textDecoration = lForm.sTextDeco.value;
	lTitle.style.backgroundColor = lForm.sBGColor.value;
	lTitle.style.borderWidth = lForm.tbBorderWidth.value;
	lTitle.style.borderColor = lForm.sBorderColor.value;
	lTitle.style.borderStyle = lForm.sBorderStyle.value;
	lTitle.style.fontFamily = lForm.sFontFamily.value;
	lTitle.style.fontWeight = lForm.sFontWeight.value;
	lTitle.style.fontSize = lForm.tbFontSize.value;
	
	// set the values for the hidden fields
	lForm.hTextAlign.value = lForm.sTextAlign.value;
	lForm.hTextColor.value = lForm.sTextColor.value;
	lForm.hTextDeco.value = lForm.sTextDeco.value;
	lForm.hBGColor.value = lForm.sBGColor.value;
	lForm.hBGImage.value = lForm.fBGImage.value;
	lForm.hBorderWidth.value = lForm.tbBorderWidth.value;
	lForm.hBorderColor.value = lForm.sBorderColor.value;
	lForm.hBorderStyle.value = lForm.sBorderStyle.value;
	lForm.hFontFamily.value = lForm.sFontFamily.value;
	lForm.hFontWeight.value = lForm.sFontWeight.value;
	lForm.hFontSize.value = lForm.tbFontSize.value;
}

function ParaPropertyApply(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lPara = lForm("taPara" + piElementID);
	
	// Set the properties for the para Para
	lPara.style.textAlign = lForm.sParaTextAlign.value;
	lPara.style.color = lForm.sParaTextColor.value;
	lPara.style.textDecoration = lForm.sParaTextDeco.value;
	lPara.style.backgroundColor = lForm.sParaBGColor.value;
	lPara.style.borderWidth = lForm.tbParaBorderWidth.value;
	lPara.style.borderColor = lForm.sParaBorderColor.value;
	lPara.style.borderStyle = lForm.sParaBorderStyle.value;
	lPara.style.fontFamily = lForm.sParaFontFamily.value;
	lPara.style.fontWeight = lForm.sParaFontWeight.value;
	lPara.style.fontSize = lForm.tbParaFontSize.value;
	
	// set the values for the hidden fields
	lForm.hParaTextAlign.value = lForm.sParaTextAlign.value;
	lForm.hParaTextColor.value = lForm.sParaTextColor.value;
	lForm.hParaTextDeco.value = lForm.sParaTextDeco.value;
	lForm.hParaBGColor.value = lForm.sParaBGColor.value;
	lForm.hParaBGImage.value = lForm.fParaBGImage.value;
	lForm.hParaBorderWidth.value = lForm.tbParaBorderWidth.value;
	lForm.hParaBorderColor.value = lForm.sParaBorderColor.value;
	lForm.hParaBorderStyle.value = lForm.sParaBorderStyle.value;
	lForm.hParaFontFamily.value = lForm.sParaFontFamily.value;
	lForm.hParaFontWeight.value = lForm.sParaFontWeight.value;
	lForm.hParaFontSize.value = lForm.tbParaFontSize.value;
}


// Paragraph related functions
function TitlePropOnClick(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lDiv = document.all("dParaTitleProp" + piElementID);
	var lExpanded = lForm.hExpanded.value;
	
	if (lExpanded == "false") {	
		lDiv.innerHTML="<TABLE align='center' width=100% border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
				   "<TR><TD width=30%><B>Text</B> Align</TD><TD width=100><Select name='sTextAlign' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gHAlignSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Color</TD><TD width=100><Select name='sTextColor' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gColorsSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Decoration</TD><TD width=100><Select name='sTextDeco' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gTDecorationSelectStr%></Select></TD></TR>" + 				   				   				   				    				   				   				   
				   "<TR><TD width=30%><B>Background</B> Color</B></TD><TD width=100><Select name='sBGColor' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gColorsSelectStr%></Select></TD></TR>" + 
				   "<TR><TD width=30%><B>Background</B> Image</TD><TD width=100><Input type=file name='fBGImage' onchange='ParaTitlePropertyApply(" + piElementID + ");'></TD></TR>" + 
				   "<TR><TD width=30%><B>Border</B> Width</TD><TD width=100><Input size=5 type=text name='tbBorderWidth'></TD></TR>" + 				   
				   "<TR><TD width=30%><B>Border</B> Color</TD><TD width=100><Select name='sBorderColor' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gColorsSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Border</B> Style</TD><TD width=100><Select name='sBorderStyle' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gBorderStyleSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Family</TD><TD width=100><Select name='sFontFamily' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gFontFamilySelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Size</TD><TD width=100><Input size=5 type=text name='tbFontSize' onchange='ParaTitlePropertyApply(" + piElementID + ");'></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Weight</TD><TD width=100><Select name='sFontWeight' onchange='ParaTitlePropertyApply(" + piElementID + ");'><%=gFontWeightSelectStr%></Select></TD></TR>" +				   
				   "</TABLE>";

		lForm.sTextAlign.value = lForm.hTextAlign.value;
		lForm.sTextColor.value = lForm.hTextColor.value;
		lForm.sTextDeco.value = lForm.hTextDeco.value;
		lForm.sBGColor.value = lForm.hBGColor.value;
		lForm.fBGImage.value = lForm.hBGImage.value;
		lForm.tbBorderWidth.value = lForm.hBorderWidth.value;
		lForm.sBorderColor.value = lForm.hBorderColor.value;
		lForm.sBorderStyle.value = lForm.hBorderStyle.value;
		lForm.sFontFamily.value = lForm.hFontFamily.value;
		lForm.sFontWeight.value = lForm.hFontWeight.value;
		lForm.tbFontSize.value = lForm.hFontSize.value;

		lForm.hExpanded.value = "true";
	}
	else {
		lDiv.innerHTML="";
		lForm.hExpanded.value = "false";
	}
}

function ParaPropOnClick(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lDiv = document.all("dParaProp" + piElementID);
	var lExpanded = lForm.hParaExpanded.value;
	
	if (lExpanded == "false") {	
		lDiv.innerHTML="<TABLE align='center' width=100% border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
				   "<TR><TD width=30%><B>Text</B> Align</TD><TD width=100><Select name='sParaTextAlign' onchange='ParaPropertyApply(" + piElementID + ");'><%=gHAlignSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Color</TD><TD width=100><Select name='sParaTextColor' onchange='ParaPropertyApply(" + piElementID + ");'><%=gColorsSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Decoration</TD><TD width=100><Select name='sParaTextDeco' onchange='ParaPropertyApply(" + piElementID + ");'><%=gTDecorationSelectStr%></Select></TD></TR>" + 				   				   				   				    				   				   				   
				   "<TR><TD width=30%><B>Background</B> Color</B></TD><TD width=100><Select name='sParaBGColor' onchange='ParaPropertyApply(" + piElementID + ");'><%=gColorsSelectStr%></Select></TD></TR>" + 
				   "<TR><TD width=30%><B>Background</B> Image</TD><TD width=100><Input type=file name='fParaBGImage' onchange='ParaPropertyApply(" + piElementID + ");'></TD></TR>" + 
				   "<TR><TD width=30%><B>Border</B> Width</TD><TD width=100><Input size=5 type=text name='tbParaBorderWidth'></TD></TR>" + 				   
				   "<TR><TD width=30%><B>Border</B> Color</TD><TD width=100><Select name='sParaBorderColor' onchange='ParaPropertyApply(" + piElementID + ");'><%=gColorsSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Border</B> Style</TD><TD width=100><Select name='sParaBorderStyle' onchange='ParaPropertyApply(" + piElementID + ");'><%=gBorderStyleSelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Family</TD><TD width=100><Select name='sParaFontFamily' onchange='ParaPropertyApply(" + piElementID + ");'><%=gFontFamilySelectStr%></Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Size</TD><TD width=100><Input size=5 type=text name='tbParaFontSize' onchange='ParaPropertyApply(" + piElementID + ");'></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Weight</TD><TD width=100><Select name='sParaFontWeight' onchange='ParaPropertyApply(" + piElementID + ");'><%=gFontWeightSelectStr%></Select></TD></TR>" +				   
				   "</TABLE>";

		lForm.sParaTextAlign.value = lForm.hParaTextAlign.value;
		lForm.sParaTextColor.value = lForm.hParaTextColor.value;
		lForm.sParaTextDeco.value = lForm.hParaTextDeco.value;
		lForm.sParaBGColor.value = lForm.hParaBGColor.value;
		lForm.fParaBGImage.value = lForm.hParaBGImage.value;
		lForm.tbParaBorderWidth.value = lForm.hParaBorderWidth.value;
		lForm.sParaBorderColor.value = lForm.hParaBorderColor.value;
		lForm.sParaBorderStyle.value = lForm.hParaBorderStyle.value;
		lForm.sParaFontFamily.value = lForm.hParaFontFamily.value;
		lForm.sParaFontWeight.value = lForm.hParaFontWeight.value;
		lForm.tbParaFontSize.value = lForm.hParaFontSize.value;

		lForm.hParaExpanded.value = "true";
	}
	else {
		lDiv.innerHTML="";
		lForm.hParaExpanded.value = "false";
	}
}
</script>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function here() {
}

function rCellEntity_onclick(piNodeID, piLeafElementID) {
	var lSelIndex;
	
	var lRadio =  document.all("rCellEntity");
	var lDiv = document.all("dCellEntity");
	
	if (lRadio[0].checked) {			 
		lDiv.innerHTML = 	 			 "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-para-insert.asp' onsubmit='return InsertEntityBeforeSubmit(" + piLeafElementID + ");'>" +
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=20%><B>Paragraph Title</B></TD>" + "<TD align='left'width=80%><INPUT name='tbParaTitleBefore" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR><TR>" + 
										 "<TD align='left' width=20%><B>Paragraph</B></TD>" + "<TD align='left' width=80%><Textarea name='taParaBefore" + piLeafElementID + "' cols=50 rows=8></Textarea></TD>" +
										 "</TR></TABLE><TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Paragraph'></TD></TR></TABLE>" + 
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>" +
										 "</form>";
										 
	}
	else if (lRadio[1].checked) {
		lDiv.innerHTML = 				 "<TABLE border=1 width=100% align='left' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Table Header</B></TD>" + "<TD align='left' width=60%><INPUT name='tbTableHeader" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR>" +
										 "</TABLE>" + 
										 "<Div id='dTable" + piLeafElementID + "' name='dTable" + piLeafElementID + "'></Div>" +
										 "<TABLE border=1 width=100% align='left' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR><TD><input type='button' value='Insert Row' onclick='TableAddRow(" + piLeafElementID + ", gTableRowCount, gTableCells[gTableRowCount]);'></TD></TR>" +
										 "</TABLE>" + 
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Table Footer</B></TD>" + "<TD align='left' width=60%><INPUT name='tbTableFooter" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR>" +
										 "</TABLE>" + 
										 "<TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Table' id=submit2 name=submit2></TD></TR></TABLE>" +
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>";
	}	
	else if (lRadio[6].checked) {
		lDiv.innerHTML = "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-line-break-insert.asp' onsubmit='return InsertEntityBeforeSubmit(" + piLeafElementID + ");'>" + 
						 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Number of Line Breaks</B></TD>" + "<TD align='left' width=60%><INPUT name='tNoOfBreaksBefore" + piLeafElementID + "' size=10 type='text'></TD>" +  
										 "</TR></TABLE><TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Breaks' id=submit2 name=submit2></TD></TR></TABLE>" + 
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>" +
										 "</form>";
	}
	else {
		lDiv.innerHTML = "";
	}
}

function rEntity_onclick(piNodeID, piLeafElementID, piTableNo) {
	var lRadio =  document.all("rEntityBefore" + piLeafElementID);
	var lDiv = document.all("dEntityBefore" + piLeafElementID);
	
	if (lRadio[0].checked) {
		lDiv.innerHTML =				 "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-para-insert.asp'>" +
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=20%><B>Paragraph Title</B></TD>" + "<TD align='left'width=80%><INPUT name='tbParaTitleBefore" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR><TR>" + 
										 "<TD align='left' width=20%><B>Paragraph</B></TD>" + "<TD align='left' width=80%><Textarea name='taParaBefore" + piLeafElementID + "' cols=50 rows=8></Textarea></TD>" +
										 "</TR></TABLE><TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Paragraph'></TD></TR></TABLE>" +
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>" +
										 "</form>";
										 
										 
	}
	else if (lRadio[1].checked) {
		lDiv.innerHTML = 				 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Table Header</B></TD>" + "<TD align='left' width=60%><INPUT name='tbTableHeader" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR>" +
										 "</TABLE>" + 
										 "<Div id='dTable" + piLeafElementID + "' name='dTable" + piLeafElementID + "'></Div>" +
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR><TD><input type='button' value='Insert Row' onclick='TableAddRow(" + piTableNo + "," + piLeafElementID + ", gTableRowCount[" + piTableNo + "], gTableCells[" + piTableNo + "][gTableRowCount[" + piTableNo + "]]);'></TD></TR>" +
										 "</TABLE>" + 
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=175><B>Table Footer</B></TD>" + "<TD align='left' width=60%><INPUT name='tbTableFooter" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR>" +
										 "</TABLE>" + 
										 "<TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Table'></TD></TR></TABLE>" +
 										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='Before'>";

	}	
	else if (lRadio[6].checked) {
		lDiv.innerHTML = "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-line-break-insert.asp'>" +
						 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
	  					 "<TR>" +
						 "<TD align='left' width=175><B>Number of Line Breaks</B></TD>" + "<TD align='left' width=60%><INPUT name='tNoOfBreaksBefore" + piLeafElementID + "' size=10 type='text'></TD>" +  
						 "</TR></TABLE><TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Breaks'></TD></TR></TABLE>" +
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
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
										 "<TR>" +
										 "<TD align='left' width=20%><B>Paragraph Title</B></TD>" + "<TD align='left'width=80%><INPUT name='tbParaTitleAfter" + piLeafElementID + "' size=50 type='text'></TD>" +  
										 "</TR><TR>" + 
										 "<TD align='left' width=20%><B>Paragraph</B></TD>" + "<TD align='left' width=80%><Textarea name='taParaAfter" + piLeafElementID + "' cols=50 rows=8></Textarea></TD>" +
										 "</TR></TABLE><TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Paragraph' STYLE='BORDER-COLLAPSE: collapse'></TD></TR></TABLE>" +
										 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
										 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
										 "<input type='hidden' name='hDirection' Value='After'>";
										 
	}
	else if (lRadio[6].checked) {
		lDiv.innerHTML = "<FORM method='post' name='frmInsertEntityBefore" + piLeafElementID + "' action='ed-tree-leaf-line-break-insert.asp'>" + 
						 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
						 "<TR>" +
						 "<TD align='left' width=175><B>Number of Line Breaks</B></TD>" + "<TD align='left' width=60%><INPUT name='tNoOfBreaksAfter" + piLeafElementID + "' size=10 type='text'></TD>" +  
						 "</TR></TABLE><TABLE class='tdbglight' width=100% align='center' STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Insert Breaks' id=submit2 name=submit2></TD></TR></TABLE>" +
						 "<input type='hidden' name='hNodeID' Value='" + piNodeID + "'>" +
						 "<input type='hidden' name='hLeafElementID' Value='" + piLeafElementID + "'>" +
						 "<input type='hidden' name='hDirection' Value='Before'>";
	}
	else {
		lDiv.innerHTML = "";
	}
}

function ToggleNode() {
	var lRadioValue = document.frmInsertSectionBefore.rSectionBefore;

	if (lRadioValue[1].checked) {
		document.all.dSectionTitle.innerHTML = "Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
	else if (lRadioValue[0].checked) {
		document.all.dSectionTitle.innerHTML = "Enter Folder Title<BR><Input type='text' maxlength=256 size=60 name='tSectionNodeTitle'><BR>Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
}

function ToggleNodeAfter() {
	var lRadioValue = document.frmInsertSectionAfter.rSectionAfter;

	if (lRadioValue[1].checked) {
		document.all.dSectionTitleAfter.innerHTML = "Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
	else if (lRadioValue[0].checked) {
		document.all.dSectionTitleAfter.innerHTML = "Enter Folder Title<BR><Input type='text' maxlength=256 size=60 name='tSectionNodeTitle'><BR>Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
}

//-->
</SCRIPT>
</HEAD>
<BODY>
<script language="javascript">
parent.frames("fContents").document.location = "ed-contents-edit.asp";
</script>
<%
	Dim lNodeID
	Dim lNodeType
	Dim lLeafType
	Dim lLeafElementID
	
	Dim lEDObj
	Dim lRs
	
	Dim lParaRs
	Dim lParaTitle
	Dim lPara
	Dim lFormAction
		
	lNodeID = Request.QueryString("NodeID")
	lNodeType = Request.QueryString("NodeType")
	
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	Set lRs = Server.CreateObject("ADODB.RecordSet")
	Set lParaRs = Server.CreateObject("ADODB.RecordSet")
	
	lLeafElementID = 0
	Set lRs = lEDObj.GetLeafLets  (eval(lNodeID))
%>
<TABLE align="center" width=100%>
<TR>
<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=lNodeID%>">View</A></TD>
</TR>
</TABLE>
<% 'Create the Folder/Leaf insert here %>
<FORM name="frmInsertSectionBefore" method="post" action="ed-tree-node-insert.asp">
<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Insert Section</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=50% align="left"><input type="radio" name="rSectionBefore" Value="Folder" onclick="ToggleNode();">Folder</TD>
	<TD width=50% align="left"><input type="radio" name="rSectionBefore" Value="Leaf" checked onclick="ToggleNode();">Leaf</TD>
</TR>
</TABLE>
<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=100%><div id="dSectionTitle"></div></TD>
</TR>
<TR>
	<TD align='center'><INPUT type=submit value='Insert Section'>
	</TD>
</TR>
</TABLE>

<input type="hidden" name="hNodeID" Value="<%=lNodeID%>">
<input type="hidden" name="hDirection" Value="Before">
</FORM>	

<script language="javascript">
ToggleNode();
</script>
<HR>
<%
	Dim gTableCount
	
	gTableCount = 0
	if lRs.RecordCount > 0 then
		lRs.MoveFirst 
		while Not lRs.EOF 
			' Based on the type of leaf element display the para, table etc...
			lLeafType = trim(lRs("TL_LeafType"))
			lLeafElementID = trim(lRs("TL_LeafElementID"))

			' Create the standard Insert toolbar
%>
			<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD><font class="whiteboldtext">Insert</font></TD>
			</TR>
			</TABLE>

			<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD align="left"><input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>,0 );" Value="PARA">Paragraph
								<input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>, <%=gTableCount%>);" Value="TABLE">Table
								<input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>,0);" Value="HLINK">Hyper Link
								<input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>,0);" Value="IMAGE">Image
								<input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>,0);" Value="AUDIO">Audio
								<input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>,0);" Value="VIDEO">Video
								<input type="radio" name="rEntityBefore<%=lLeafElementID%>" onclick="return rEntity_onclick(<%=lNodeID%>, <%=lLeafElementID%>,0);" Value="BREAK">Line Break
				</TD>	
			</TR>
			</TABLE>

			<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD align="left"> 
				<div id="dEntityBefore<%=lLeafElementID%>"></div>
				</TD>
			</TR>
			</TABLE>
<% gTableCount = gTableCount + 1 %>
<%
			if lLeafType = "PARA" Then
				Set lParaRs = lEDObj.GetParagraph(eval(trim(lRs("TL_LeafElementID"))))
				If lParaRs.RecordCount > 0 Then
					lParaTitle = trim(lParaRs("P_ParagraphTitle"))
					lPara = trim(lParaRs("P_ParagraphText"))
					
					' Give Edit controls on the edit toolbar for the current paragraph
%>
					<FORM name="frmUpdatePara<%=lLeafElementID%>" method="post" action="ed-tree-leaf-para-update.asp">
					<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD><font class="whiteboldtext">Update Paragraph</font></TD>
					</TR>
					</TABLE>
					<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD width=150 valign="top"><B>Paragraph Title</B></TD><TD><INPUT name="tbParaTitle<%=lLeafElementID%>" size=50 type='text' value="<%=lParaTitle%>"></TD>  
					</TR>
					</TABLE>
					<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD><A href="javascript:here();" onclick="TitlePropOnClick(<%=lLeafElementID%>);">Title Properties</TD>
					</TR>
					</TABLE>
					<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD><div id="dParaTitleProp<%=lLeafElementID%>"></div></TD>
					</TR>
					</TABLE>
					<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
					<TR> 
						 <TD width=150 valign="top"><B>Paragraph</B></TD><TD><Textarea name="taPara<%=lLeafElementID%>" cols=50 rows=8><%=lPara%></Textarea></TD>
					</TR>
					</TABLE>
					<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD><A href="javascript:here();" onclick="ParaPropOnClick(<%=lLeafElementID%>);">Paragraph Properties</TD>
					</TR>
					</TABLE>
					<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD><div id="dParaProp<%=lLeafElementID%>"></div></TD>
					</TR>
					</TABLE>
					<TABLE width=100% align='center' class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Update Paragraph'></TD></TR></TABLE>
					<input type=hidden name="hExpanded" value="false">
					<input type=hidden name="hParaExpanded" value="false">
					<input type="hidden" name="hNodeID" Value="<%=lNodeID%>">
					<input type="hidden" name="hLeafElementID" Value="<%=lLeafElementID%>">
					
					<input type=hidden name="hTextAlign" value="<%=trim(lParaRs("P_TitleTextAlign"))%>">
					<input type=hidden name="hTextColor" value="<%=trim(lParaRs("P_TitleTextColor"))%>">
					<input type=hidden name="hTextDeco" value="<%=trim(lParaRs("P_TitleTextDeco"))%>">
					<input type=hidden name="hBGColor" value="<%=trim(lParaRs("P_TitleBGColor"))%>">
					<input type=hidden name="hBGImage" value="">
					<input type=hidden name="hBorderWidth" value="<%=trim(lParaRs("P_TitleBorderWidth"))%>">
					<input type=hidden name="hBorderColor" value="<%=trim(lParaRs("P_TitleBorderColor"))%>">
					<input type=hidden name="hBorderStyle" value="<%=trim(lParaRs("P_TitleBorderStyle"))%>">
					<input type=hidden name="hFontFamily" value="<%=trim(lParaRs("P_TitleFontFamily"))%>">
					<input type=hidden name="hFontWeight" value="<%=trim(lParaRs("P_TitleFontWeight"))%>">
					<input type=hidden name="hFontSize" value="<%=trim(lParaRs("P_TitleFontSize"))%>">

					<input type=hidden name="hParaTextAlign" value="<%=trim(lParaRs("P_TextAlign"))%>">
					<input type=hidden name="hParaTextColor" value="<%=trim(lParaRs("P_TextColor"))%>">
					<input type=hidden name="hParaTextDeco" value="<%=trim(lParaRs("P_TextDeco"))%>">
					<input type=hidden name="hParaBGColor" value="<%=trim(lParaRs("P_BGColor"))%>">
					<input type=hidden name="hParaBGImage" value="">
					<input type=hidden name="hParaBorderWidth" value="<%=trim(lParaRs("P_BorderWidth"))%>">
					<input type=hidden name="hParaBorderColor" value="<%=trim(lParaRs("P_BorderColor"))%>">
					<input type=hidden name="hParaBorderStyle" value="<%=trim(lParaRs("P_BorderStyle"))%>">
					<input type=hidden name="hParaFontFamily" value="<%=trim(lParaRs("P_FontFamily"))%>">
					<input type=hidden name="hParaFontWeight" value="<%=trim(lParaRs("P_FontWeight"))%>">
					<input type=hidden name="hParaFontSize" value="<%=trim(lParaRs("P_FontSize"))%>">
					</FORM>
					<script language="javascript">
						TitlePropOnClick(<%=lLeafElementID%>);						
						ParaTitlePropertyApply(<%=lLeafElementID%>);
						TitlePropOnClick(<%=lLeafElementID%>);
						
						ParaPropOnClick(<%=lLeafElementID%>);						
						ParaPropertyApply(<%=lLeafElementID%>);
						ParaPropOnClick(<%=lLeafElementID%>);
					</script>
<%
				else
%>
					Paragraph Not Found<BR>
<%
				End if
			end if
			
			if lLeafType = "BREAK" Then
				Set lBreakRs = lEDObj.GetBreak (eval(trim(lRs("TL_LeafElementID"))))
				If lBreakRs.RecordCount > 0 Then
					lNoOfBreaks = trim(lBreakRs("LB_NoOfBreaks"))
					
					' Give Edit controls on the edit toolbar for the current paragraph
%>
					<FORM name="frmUpdateBreak<%=lLeafElementID%>" method="post" action="ed-tree-leaf-line-break-update.asp">
					<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD><font class="whiteboldtext">Update Line Breaks</font></TD>
					</TR>
					</TABLE>
					
					<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>
					<TR>
						<TD align='left' width=175><B>Number of Line Breaks</B></TD>
						<TD align='left' width=60%><INPUT name='tNoOfBreaks<%=lLeafElementID%>' size=10 type='text' value=<%=lNoOfBreaks%>></TD> 
					</TR>
					</TABLE>
					<TABLE width=100% align='center' class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'><TR colspan=2><TD align='center'><INPUT type=submit value='Update Line Breaks'></TD></TR></TABLE>
					<input type="hidden" name="hNodeID" Value="<%=lNodeID%>">
					<input type="hidden" name="hLeafElementID" Value="<%=lLeafElementID%>">
					</FORM>
<%
				else
%>
					Line Breaks Not Found<BR>
<%
				End if
			end if

			lRs.MoveNext 
		wend
	end if
		
	' Put the Insert toolbar here after all the elements in this leaf
%>
	<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
	<TR>
		<TD><font class="whiteboldtext">Insert</font></TD>
	</TR>
	</TABLE>

	<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
	<TR>
		<TD align="left">
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="PARA" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Paragraph
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="TABLE" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Table
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="HLINK" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Hyper Link
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="IMAGE" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Image
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="AUDIO" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Audio
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="VIDEO" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Video
			<input type="radio" name="rEntityAfter<%=lLeafElementID%>" onclick="return rEntityAfter_onclick(<%=lNodeID%>, <%=lLeafElementID%>);" Value="BREAK" onclick="return rEntityAfter_onclick(<%=lLeafElementID%>);">Line Break
		</TD>	
	</TR>
	</TABLE>

	<TABLE align="center" width=100% border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
	<TR>
		<TD align="left"> 
		<div id="dEntityAfter<%=lLeafElementID%>"></div>
		</TD>
	</TR>
	</TABLE>
<% 'Create the Folder/Leaf insert here %>
<HR>
<FORM name="frmInsertSectionAfter" method="post" action="ed-tree-node-insert.asp">
<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Insert Section</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=50% align="left"><input type="radio" name="rSectionAfter" Value="Folder" onclick="ToggleNodeAfter();">Folder</TD>
	<TD width=50% align="left"><input type="radio" name="rSectionAfter" Value="Leaf" checked onclick="ToggleNodeAfter();">Leaf</TD>
</TR>
</TABLE>
<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=100%><div id="dSectionTitleAfter"></div></TD>
</TR>
<TR>
	<TD align='center'><INPUT type=submit value='Insert Section' id=submit1 name=submit1>
	</TD>
</TR>
</TABLE>

<input type="hidden" name="hNodeID" Value="<%=lNodeID%>">
<input type="hidden" name="hDirection" Value="After">
</FORM>
<script language="javascript">
ToggleNodeAfter();
</script>
</BODY>

<script language="javascript">
/*		
function AddCells(piElementID, piRow, piRowID, piNumCells) {
	for (var lIdxc = 0; lIdxc < piNumCells; lIdxc++) {
		var oCell = piRow.insertCell();
		oCell.innerHTML = "Insert Text <INPUT type=text size=10 maxlength=1024 name='tTable" + piElementID + "Cell" + piRowID + lIdxc + "'>";
	}
}
function RemoveCells(piTable, piNumCells) {
	var lRowsCount = piTable.rows.length;
	for (var lIdx = 0; lIdx < lRowsCount; lIdx++) {	
		for (var lIdxc = 0; lIdxc<piNumCells; lIdxc++) {
			var oRow = piTable.rows(lIdx);
			oRow.deleteCell(oRow.cells.length-1);
		}
	}
}

function AddCellsForAllRows(piElementID, piTable, piNumCells) {
	var lRowsCount = piTable.rows.length;
	var lCellsCount = piTable.rows(0).cells.length;
	for (var lIdx = 0; lIdx < lRowsCount; lIdx++) {	
		for (var lIdxc = 0; lIdxc < piNumCells; lIdxc++) {
			var oCell = piTable.rows(lIdx).insertCell(lIdxc+lCellsCount);
			oCell.innerHTML = "Insert Text <INPUT type=text size=10 maxlength=1024 name='tTable" + piElementID + "Cell" + lIdx + lIdxc + "'>";
		}
	}
}
function AddRow(piTable, piNumRows, piNumCells) {
	var lRowsCount = piTable.rows.length;
	for (var lIdx = 0; lIdx < piNumRows; lIdx++) {
		var oRow = piTable.insertRow(lRowsCount + lIdx);
		AddCells(piElementID, oRow, lRowsCount + lIdx, piNumCells);
	}
}
function RemoveRows(piTable, piNumRows) {
	var lRowsCount = piTable.rows.length;
	for (var lIdx = 0; lIdx < piNumRows; lIdx++) {
		var oRow = piTable.deleteRow(piTable.rows.length-1);
	}
}

function CreateTable(piElementID) {
	var lTableBody = document.all("tTableBody" + piElementID)
	var lNumRows = document.all("tbTableRows" + piElementID).value;
	var lNumCols = document.all("tbTableCols" + piElementID).value;
	var lCellsCount = 0;
	
	var lRowsCount = lTableBody.rows.length;
	if (lRowsCount > 0) 
		lCellsCount = lTableBody.rows(0).cells.length;
	
	if (lRowsCount == 0) {	
		AddRows(piElementID,lTableBody,lNumRows, lNumCols);
		return;
	}

	if (lRowsCount > lNumRows) 
		RemoveRows(lTableBody, lRowsCount-lNumRows);
	else if (lRowsCount < lNumRows)
		AddRows(piElementID,lTableBody,lNumRows-lRowsCount, lNumCols);
	 
	if (lCellsCount > lNumCols) 
		RemoveCells(lTableBody, lCellsCount-lNumCols)
	else if (lCellsCount < lNumCols) 
		AddCellsForAllRows(piElementID, lTableBody, lNumCols-lCellsCount)
}
*/
</script>
</HTML>
