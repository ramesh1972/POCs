var curr_max_node_id = 2;

function LoadDeckPanel(panel_id, panel_row_ui) 
{
	var panel_html = "";
	var table_closed = 0;
	
	// get the panel from panel_id
	// do the loading of the panel here
	panel_html += LoadPanel(panel_id);
	panel_row_ui += panel_html;
		
	// get the panel col id and row id of panel id
	// if next row and first col create </table> tag
	// get the next panel in position...check its row value, 
	// if diff from the current row then close the table tag
	var next_panel = GetNextSiblingNode(panel_id, "TreeNode");
	if (next_panel != 0 && next_panel != "" && next_panel != null) 
	{
		var next_row = GetChildNodeValue(next_panel, "PanelRow");
		var curr_row = GetChildNodeValue(panel_id, "PanelRow");

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
		var panel_parent = GetNodeParent(panel_id);
		var parent_div = GetChildNodeValue(panel_parent, "PanelID");
		
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
	var panels_sub = GetNodeChildrenWithType(panel_id, "TreeNode");
	var prev_row = 0;

	for (var idx=0; idx<panels_sub.length; idx++) 
	{
		var elem_type = GetNodeName(panels_sub[idx]);
		if (elem_type == "Panel") {
			// if it is in different cols
			var row = GetChildNodeValue(panels_sub[idx], "PanelRow");
		
			if (row != prev_row) {
				LoadDeckPanel(panels_sub[idx], "");
			}
			
			prev_row = row;
		}
		else if(elem_type == "Control")
			LoadPanelControl(panels_sub[idx]);
	}

	return;
}

function LoadPanel(panel_obj_id) 
{
	var panel_html_string = "";
	
	// create a table and/or td element and close the td
	var table_str = "";
	var table_td = "";
	var cell_row_no = GetChildNodeValue(panel_obj_id, "PanelRow");
	var cell_col_no = GetChildNodeValue(panel_obj_id, "PanelCol");
	var cell_width = GetChildNodeValue(panel_obj_id, "PanelColWidth");
	var cell_height = GetChildNodeValue(panel_obj_id, "PanelRowHeight");
	var cell_inner_border = GetChildNodeValue(panel_obj_id, "PanelInnerBorderWidth");
	var cell_outer_border = GetChildNodeValue(panel_obj_id, "PanelOuterBorderWidth");
	var cell_col_align = GetChildNodeValue(panel_obj_id, "PanelColAlign");
	var cell_row_align = GetChildNodeValue(panel_obj_id, "PanelRowAlign"); 
	var cell_style = GetChildNodeValue(panel_obj_id, "PanelStyle");
	
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
	var cell_id = GetChildNodeValue(panel_obj_id, "PanelID");
	table_td += "<Div id='" + cell_id + "'" + 
					" align=" + cell_col_align + 
					" valign=" + cell_row_align +
				">Panel" + "</Div>";
	
	table_td += "</td>";
	
	table_str += table_td;
	
	return table_str;
}

function LoadPanelControls(panel_id) {
	// get all children that are TreeNodes in order of cells, position
	// that is all the controls of this panel
	var controls = GetNodeChildrenWithType(panel_id, "TreeNode");
	
	for(var idx=0;idx<controls.length;idx++)
		LoadPanelControl(controls[idx], "");
}


