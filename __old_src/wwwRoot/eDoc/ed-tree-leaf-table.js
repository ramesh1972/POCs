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
