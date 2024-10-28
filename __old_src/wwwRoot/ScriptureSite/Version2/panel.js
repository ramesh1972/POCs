var curr_max_node_id = 2;

function LoadDeckPanel(panel_id, panel_row_ui) 
{
	var panel_html = "";
	var table_closed = 0;
	
	// get the panel from panel_id
	// do the loading of the panel here
	panel_html += LoadPanel(panel_id);
	panel_row_ui += panel_html;
	//alert("APPENDED = " + panel_row_ui);
		
	// get the panel col id and row id of panel id
	// if next row and first col create </table> tag
	// get the next panel in position...check its row value, 
	// if diff from the current row then close the table tag
	var next_panel = GetNextSiblingNode(panel_id, "TreeNode");
	if (next_panel != 0 && next_panel != "" && next_panel != null) 
	{
		var panel_children = GetNodeChildren(panel_id);
		var next_panel_children = GetNodeChildren(next_panel);
		
		var next_row = GetDataNodeChildValue(next_panel_children, "PanelRow");
		var curr_row = GetDataNodeChildValue(panel_children, "PanelRow");

		alert( "Panel 1 " + panel_id + " Row = " + curr_row);
		alert( "NExt Panel 1 " + next_panel + " Row = " + next_row);
		if (next_row != curr_row) {
			panel_row_ui += "</tr></table>";
			table_closed = 1;
		}
	}
	else {
		panel_row_ui += "</tr></table>";
		table_closed = 1;
	}
	
	if (table_closed) {
		// This is true when a panel has been created and it is time to put it in the div
		var panel_parent = GetDataNodeParent(panel_id);
		var parent_children = GetNodeChildren(panel_parent);
		var parent_div = GetDataNodeChildValue(parent_children, "PanelID");
		
		var div_obj = document.all(parent_div);
		
		div_obj.innerHTML += panel_row_ui;
		panel_row_ui = "";
		table_closed = 0;
	}
	else
	{
		if (next_panel != 0 && next_panel != "" && next_panel != null) 
		{
			LoadDeckPanel(next_panel, panel_row_ui);
		}
	}
	
	// ---- The current table cell is displayed
	
	// ---- display the children or child panels of the current panel
	
	// get all children that are TreeNodes in order of cells, row-col
	var panels_sub = GetNodeChildrenOnType(panel_id, "TreeNode");
	var prev_row = 0;
	alert(panels_sub.length);
	for (var idx=0; idx<panels_sub.length; idx++) 
	{
		// if it is in different cols
		var childs_of_node = GetNodeChildren(panels_sub[idx]);
		var row = GetDataNodeChildValue(childs_of_node, "PanelRow");
		
		if (row != prev_row) {
			alert(panels_sub[idx]);

			LoadDeckPanel(panels_sub[idx], "");
			alert("Done");
		}
		
		prev_row = row		
		
	}

	return;
}

function LoadPanel(panel_obj_id) 
{
	var panel_html_string = "";
	
	// get all children
	var panel_children = GetNodeChildren(panel_obj_id);
	
	// create a table and/or td element and close the td
	var table_str = "";
	var table_td = "";
	var cell_row_no = GetDataNodeChildValue(panel_children, "PanelRow");
	var cell_col_no = GetDataNodeChildValue(panel_children, "PanelCol");
	var cell_width = GetDataNodeChildValue(panel_children, "PanelColWidth");
	var cell_height = GetDataNodeChildValue(panel_children, "PanelRowHeight");
	var cell_inner_border = GetDataNodeChildValue(panel_children, "PanelInnerBorderWidth");
	var cell_outer_border = GetDataNodeChildValue(panel_children, "PanelOuterBorderWidth");
	var cell_col_align = GetDataNodeChildValue(panel_children, "PanelColAlign");
	var cell_row_align = GetDataNodeChildValue(panel_children, "PanelRowAlign"); 
	var cell_style = GetDataNodeChildValue(panel_children, "PanelStyle");
	
	if (cell_col_no == 1) 
	{
		table_str = "<Table " + " width=" + cell_width + 
							   " height=" + cell_height +
							   " align=" + cell_col_align +
							   " valign=" + cell_row_align;

		if (cell_outer_border > 0) {
			table_str += " border=1";
			cell_style += ";border-width:" + cell_outer_border;
		}
	
		table_str += " style='" + cell_style + "'";
		table_str += "><TR>";
	}
	else {
		table_str = "";
		}
	
	table_td = "<TD " + " width=" + cell_width + 
					    " height=" + cell_height +
					    " align=" + cell_col_align +
	 				    " valign=" + cell_row_align;
	
	if (cell_inner_border > 0)
		cell_style += ";border-width:" + cell_inner_border;
	
	table_td += ">";
		
	// create the div string and put in the td
	var cell_id = GetDataNodeChildValue(panel_children, "PanelID");
	table_td += "<Div id='" + cell_id + "'" + 
					" align=" + cell_col_align + 
					" valign=" + cell_row_align +
				">Hello" + "</Div>";
	
	table_td += "</td>";
	
	table_str += table_td;
	
	return table_str;
}

function LoadPanelControls(panel_name) 
{
	if (panel_name == "HeadPanel") {
		LoadControl("oDivTextControlSelectScript", "Node_108", "LabelSelectScript");
		LoadControl("oDivButtonControlNewScripture", "Node_316", "NewScriptureButton");
		LoadControl("oDivSelectControlScriptures", "Node_100", "SelectScript");
		
		LoadControl("oDivLinkControlScriptureTab", "Node_300", "ScriptureTabLink");
		LoadControl("oDivLinkControlInformationTab", "Node_304", "InformationTabLink");
		LoadControl("oDivLinkControlSignificanceTab", "Node_308", "SignificanceTabLink");
		LoadControl("oDivLinkControlHistoryTab", "Node_312", "HistoryTabLink");
	}
	else if (panel_name == "Scripture")
	{
		LogEvent("3 Start Script Name");
		LoadControl('oDivTextBoxControlScriptName', 'Node_111', 'ScriptName');
	
		LogEvent("3 Start Script Lang");
		LoadControl('oDivSelectControlScriptLang', 'Node_130', 'SelectOrgVersionLang');
		//LogEvent("3 Start Script This Lang");
		LoadControl('oDivSelectControlScriptThisLang', 'Node_140', 'SelectThisVersionLang');
		//LogEvent("3 Start Script Other Lang");
		LoadControl('oDivSelectControlScriptOtherLang', 'Node_150', 'SelectOtherVersionLang');
		
		LogEvent("3 Start Log stanza count");
		LoadControl('oDivTextBoxControlStanzasNo', 'Node_160', 'StanzaCount');
		//LogEvent("3 Start Log lines count");
		LoadControl('oDivTextBoxControlLinesNo', 'Node_170', 'LinesPerStanza');
		//LogEvent("3 Start Log recitiation proc");
		LoadControl('oDivTextAreaControlProc', 'Node_180', 'RecitationProcedure');

		LoadControl('oDivTextControlSelectStanza', 'Node_190', 'LabelSelectStanza');
		LoadControl('oDivButtonControlNewStanza', 'Node_193', 'NewStanzaButton');
		LoadControl('oDivSelectControlSelectStanza', 'Node_210', 'SelectStanzaToEdit');
		LoadControl('oDivButtonControlMoveStanzaUp', 'Node_220', 'MoveStanzaUp');
		LoadControl('oDivButtonControlMoveStanzaDown', 'Node_230', 'MoveStanzaDown');

		LoadControl('oDivTextAreaControlStanzaLines', 'Node_240', 'EnterStanzaLines');
		LoadControl('oDivTextAreaControlWordsTrans', 'Node_250', 'EnterStanzaLinesWordsTrans');
		LoadControl('oDivTextAreaControlStanzaTrans', 'Node_260', 'EnterStanzaLinesTrans');

		LoadControl('oDivButtonControlGoPrevStanza', 'Node_270', 'PrevStanza');
		LoadControl('oDivButtonControlGoNextStanza', 'Node_280', 'NextStanza');
	}
	else if (panel_name == "Information")
	{
		LoadControl("Cmb_ScriptType", "Node_12", "ScriptTypes");
		LoadControl("Cmb_ScriptSrc", "Node_15", "ScriptSrcs");
		LoadControl("Cmb_Gods", "Node_18", "Gods");
		LoadControl("Cmb_GodsRelations", "Node_18", "Gods");
		LoadControl("Cmb_Authors", "Node_21", "Authors");
		LoadControl("Cmb_Works", "Node_24", "Works");
		LoadControl("Cmb_OriginWhere", "Node_27", "LocationWhere");
		LoadControl("Cmb_OriginYear", "Node_41", "Years");
		LoadControl("Cmb_OriginMonth", "Node_42", "Months");
		LoadControl("Cmb_OriginDay", "Node_43", "Days");
	}

	//LoadPanelControlValues(panel_name);
}

function LoadPanelControlValues(panel_name) 
{
	if (panel_name == "Scripture") 
	{
		LoadControlValue('Txt_ScriptName', 'Node_2', 'ScriptName');
		LoadControlValue('Cmb_Org_Lang', 'Node_3', 'ScriptOrgLang');
		LoadControlValue('Cmb_OtherLangs', 'Node_4', 'ScriptOthLang');
		LoadControlValue('Cmb_ThisLang', 'Node_5', 'ScriptThisLang');
		
		LoadControlValue("Txt_StanzaCnt", "Node_7", "StanzaCount");
		LoadControlValue("Txt_LinesCnt", "Node_8", "LinesPerStanza");
		LoadControlValue("Txt_Procedure", "Node_9", "RecitiationProcedure");
	}
	else if (panel_name == "Information") 
	{
		LoadControlValue('Txt_OriginHow', 'Node_6', 'OriginHow');
	}
}

