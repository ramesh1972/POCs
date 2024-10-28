<%@ Language=VBScript %>
<HTML>
<HEAD>
<!-- #include = file="adovbs.inc" -->
<LINK REL=StyleSheet HREF="theme.css">
<!-- #include file="ed-common-selects.asp" -->
<script language="javascript">
// Table related functions
var gTableRowCount = 0;
var gTableMaxRows = 100;
var gTableMaxCols = 100;
var gTableHTMLs = new Array(gTableMaxRows);
var gCellButtonExpanded = new Array(gTableMaxRows);
var gTableCells = new Array(gTableMaxRows);

for (var lIdx1 = 0; lIdx1 < gTableMaxRows; lIdx1++) 
	gTableHTMLs[lIdx1] = "";

for (lIdx1 = 0; lIdx1 < gTableMaxRows; lIdx1++) 
	gCellButtonExpanded[lIdx1] = new Array(gTableMaxCols);
	for (var lIdx1c = 0; lIdx1 < gTableMaxCols; lIdx1++) 	
		gCellButtonExpanded[lIdx1][lIdx1c] = true;
		
for (lIdx1 = 0; lIdx1 < gTableMaxRows; lIdx1++) 
	gTableCells[lIdx1] = 1;

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

function TableAddRow(piLeafElementID, piPosition, piCellPosition) {
	var oDiv = document.all("dTable" + piLeafElementID);
	var lDivHTML = "";

	for (var lIdx = gTableRowCount; lIdx > piPosition; lIdx--) {
		gTableHTMLs[lIdx] = gTableHTMLs[lIdx-1];
		gTableCells[lIdx] = gTableCells[lIdx-1];
		gCellButtonExpanded[lIdx] = gCellButtonExpanded[lIdx-1];
	}
	
	gTableHTMLs[lIdx] = "<TABLE id='tTableTable" + lIdx + "' border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
					  "<TBODY id = 'tTableBody" + lIdx + "'>" + 
					  "</TBODY>" +
					  "</TABLE>";		

	// insert the cells here
	gTableRowCount++;
	for (lIdx = 0; lIdx < gTableRowCount; lIdx++) {
		lDivHTML = lDivHTML + gTableHTMLs[lIdx];
	}
	
	oDiv.innerHTML = lDivHTML;
	
	// Create the number of cells in each row
	for (lIdx = 0; lIdx < gTableRowCount; lIdx++) {
		var oTable = document.all("tTableBody"+lIdx);
		var oRow = oTable.insertRow();
		
		// Insert the delete row link
		var oCell = oRow.insertCell();
		oCell.innerHTML = "<input type='button' onclick='TableDeleteRow(" + piLeafElementID + "," + lIdx + ");' Value='Delete Row'>";
		oCell.vAlign="top";
		oCell.align = "left";

		// insert a default cell
		var lNumCells = gTableCells[lIdx];
		for (var lIdxc = 0; lIdxc < lNumCells; lIdxc++) {
			TableAddCell(piLeafElementID, oRow, lIdx, "ExistingCell");
					
			if (lIdx == piPosition && lIdxc == piCellPosition)
				ToggleCellButton(piLeafElementID, lIdx, lIdxc);

			gCellButtonExpanded[lIdx][lIdxc] = true;
		}

		// Insert the insert cell link
		var oCell = oRow.insertCell();
		oCell.innerHTML = "<input type='button' onclick='TableDeleteCell(" + piLeafElementID + "," + lIdx + ");' Value='Delete Cell'>" + 
						  "<input type='button' onclick='TableInsertCell(" + piLeafElementID + "," + lIdx + ");' Value='Insert Cell'>";
		oCell.vAlign="top";
		oCell.align = "left";
	}
}

function TableInsertCell(piLeafElementID,piRowID) {
	var oRow = document.all("tTableTable" + piRowID).rows(0);
	
	oRow.deleteCell(oRow.cells.length-1);
	TableAddCell(piLeafElementID, oRow, piRowID, "");

	// Insert the insert cell link
	var oCell = oRow.insertCell();
	oCell.innerHTML = "<input type='button' onclick='TableDeleteCell(" + piLeafElementID + "," + piRowID + ");' Value='Delete Cell'>" + 
					  "<input type='button' onclick='TableInsertCell(" + piLeafElementID + "," + piRowID + ");' Value='Insert Cell'>";
	oCell.vAlign="top";
	oCell.align = "left";
}

function TableAddCell(piLeafElementID, piRow, piRowID, piCellOrg) {
	var oCell = piRow.insertCell(piRow.cells.length);
	oCell.style.backgroundColor = "cyan";
	oCell.innerHTML = "<div id='dCellButtonR" + piRowID + "C" + (piRow.cells.length-1) + "'></div>";
	oCell.align = "left";
	oCell.vAlign = "top";
	CellButtonDefault(piLeafElementID, piRowID,piRow.cells.length-1);
	
	if (piCellOrg == "ExistingCell") 
		return;
		
	gTableCells[piRowID] += 1;
}

function CellButtonDefault(piLeafElementID, piRow, piCell) {
	var lDiv = document.all("dCellButtonR" + piRow + "C" + piCell);
	lDiv.innerHTML = "<input type='button' value='Open Cell' onclick='ToggleCellButton(" + piLeafElementID + "," + piRow + "," + piCell + ");'>";
}

function ToggleCellButton(piLeafElementID, piRow, piCell) {
	var lDiv = document.all("dCellButtonR" + piRow + "C" + piCell);
	
	if (!gCellButtonExpanded[piRow][piCell]) {
		window.open("ed-tree-leaf-table-cell-edit.asp");
		gCellButtonExpanded[piRow][piCell] = true;
	}
	else {
		gCellButtonExpanded[piRow][piCell] = false;
	}
}

// Paragrpah related functions
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
<SCRIPT ID=clientEventHandlersJS LANGUAGE="javascript">
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
										 "<TABLE border=1 width=100% align='center' class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
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

function rEntity_onclick(piNodeID, piLeafElementID) {
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
										 "<TR><TD><input type='button' value='Insert Row' onclick='TableAddRow(" + piLeafElementID + ", gTableRowCount, gTableCells[gTableRowCount]);'></TD></TR>" +
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
<TABLE align="center" width=100%>
<TR>
<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=lNodeID%>">View</A></TD>
</TR>
</TABLE>
<TABLE valign='top' align='center' class='tdbgdark' width=100% STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class='whiteboldtext'>Insert</font></TD>
</TR>
</TABLE>
<TABLE align='center' width=100% border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align='left'><input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='PARA'>Paragraph
	<input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='TABLE'>Table
	<input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='HLINK'>Hyper Link
	<input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='IMAGE'>Image
	<input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='AUDIO'>Audio
	<input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='VIDEO'>Video
	<input type='radio' name='rCellEntity' onclick='return rCellEntity_onclick();' Value='BREAK'>Line Break
	</TD>
</TR> 
</TABLE>
<TABLE align='center' width=100% border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>
<TR>
<TD align='left'>
<div id='dCellEntity'></div>
</TD>
</TR>
</TABLE>
<input type='hidden' name='hRowID' Value=''> 
<input type='hidden' name='hCellID' Value=''>
</form>
</BODY>
</HTML>
