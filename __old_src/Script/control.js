function LoadPanelControl(control_id, control_row_ui) 
{
	var control_html = "";
	var table_closed = 0;
	
	// get the control from control_id
	// do the loading of the control here
	control_html += LoadControl(control_id);
	control_row_ui += control_html;
		
	// get the control col id and row id of control id
	// if next row and first col create </table> tag
	// get the next control in position...check its row value, 
	// if diff from the current row then close the table tag
	var next_control = GetNextSiblingNode(control_id, "TreeNode");
	if (next_control != 0 && next_control != "" && next_control != null) 
	{
		var next_row = GetChildNodeValue(next_control, "controlRow");
		var curr_row = GetChildNodeValue(control_id, "controlRow");

		if (next_row != curr_row) {
			control_row_ui += "</tr></table>";
			table_closed = 1;
		}
	}
	else {
		control_row_ui += "</tr></table>";
		table_closed = 1;
	}
	
	if (table_closed) {
		// This is true when a control has been created and it is time to put it in the div
		var control_parent = GetNodeParent(control_id);
		var parent_div = GetChildNodeValue(control_parent, "controlID");
		
		var div_obj = document.all(parent_div);
		
		div_obj.innerHTML += control_row_ui;
		control_row_ui = "";
		table_closed = 0;
	}
	else
	{
		if (next_control != 0 && next_control != "" && next_control != null) 
		{
			LoadPanelControl(next_control, control_row_ui);
		}
	}
	
	// ---- The current table cell is displayed
	
	// ---- display the children or child controls of the current control
	
	// get all children that are TreeNodes in order of cells, row-col
	var controls_sub = GetNodeChildrenWithType(control_id, "TreeNode");
	var prev_row = 0;

	for (var idx=0; idx<controls_sub.length; idx++) 
	{
		// if it is in different cols
		var row = GetChildNodeValue(controls_sub[idx], "controlRow");
		
		if (row != prev_row) {
			var elem_type = GetNodeName(controls_sub[idx]);
			if (elem_type == "Control")
				LoadDeckControl(controls_sub[idx], "");
			else if(elem_type == "Element")
				LoadControlElements(controls_sub[idx], "");

		}
		
		prev_row = row		
		
	}

	return;
}

function LoadControl(control_obj_id) 
{
	var control_html_string = "";
	
	// create a table and/or td element and close the td
	var table_str = "";
	var table_td = "";
	var cell_row_no = GetChildNodeValue(control_obj_id, "ControlRow");
	var cell_col_no = GetChildNodeValue(control_obj_id, "ControlCol");
	var cell_width = GetChildNodeValue(control_obj_id, "ControlColWidth");
	var cell_height = GetChildNodeValue(control_obj_id, "ControlRowHeight");
	var cell_inner_border = GetChildNodeValue(control_obj_id, "ControlInnerBorderWidth");
	var cell_outer_border = GetChildNodeValue(control_obj_id, "ControlOuterBorderWidth");
	var cell_col_align = GetChildNodeValue(control_obj_id, "ControlColAlign");
	var cell_row_align = GetChildNodeValue(control_obj_id, "ControlRowAlign"); 
	var cell_style = GetChildNodeValue(control_obj_id, "ControlStyle");
	
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
	var cell_id = GetChildNodeValue(control_obj_id, "controlID");
	table_td += "<Div id='" + cell_id + "'" + 
					" align=" + cell_col_align + 
					" valign=" + cell_row_align +
				">Control" + "</Div>";
	
	table_td += "</td>";
	
	table_str += table_td;
	
	return table_str;
}

function LoadControlElements(control_id) {
	// get all children that are TreeNodes in order of cells, position
	var elements = GetNodeChildrenWithType(control_id, "TreeNode");
	
	for(var idx=0;idx<elements.length;idx++)
		LoadControlElement(elements[idx], "");
}

function LoadControlElement(element_id) {
	var element_html = "";
	var table_closed = 0;
	
	// get the element from element_id
	// do the loading of the element here
	element_html += Loadelement(element_id);
	element_row_ui += element_html;
		
	// get the element col id and row id of element id
	// if next row and first col create </table> tag
	// get the next element in position...check its row value, 
	// if diff from the current row then close the table tag
	var next_element = GetNextSiblingNode(element_id, "TreeNode");
	if (next_element != 0 && next_element != "" && next_element != null) 
	{
		var next_row = GetChildNodeValue(next_element, "elementRow");
		var curr_row = GetChildNodeValue(element_id, "elementRow");

		if (next_row != curr_row) {
			element_row_ui += "</tr></table>";
			table_closed = 1;
		}
	}
	else {
		element_row_ui += "</tr></table>";
		table_closed = 1;
	}
	
	if (table_closed) {
		// This is true when a element has been created and it is time to put it in the div
		var element_parent = GetNodeParent(element_id);
		var parent_div = GetChildNodeValue(element_parent, "elementID");
		
		var div_obj = document.all(parent_div);
		
		div_obj.innerHTML += element_row_ui;
		element_row_ui = "";
		table_closed = 0;
	}
	else
	{
		if (next_element != 0 && next_element != "" && next_element != null) 
		{
			LoadControlElement(next_element, element_row_ui);
		}
	}
	
	// ---- The current table cell is displayed
	
	// ---- display the children or child elements of the current element
	
	// get all children that are TreeNodes in order of cells, row-col
	var elements_sub = GetNodeChildrenWithType(element_id, "TreeNode");
	var prev_row = 0;

	for (var idx=0; idx<elements_sub.length; idx++) 
	{
		// if it is in different cols
		var row = GetChildNodeValue(elements_sub[idx], "elementRow");
		
		if (row != prev_row) {
			LoadDeckelement(elements_sub[idx], "");
		}
		
		prev_row = row		
		
	}

	return;
}

function LoadElement(element_id) {
	// get the element object (Window#Window#element)
	var html_str;
	var obj_type = obj.type;

	// The main parsing routine
	if (obj.tagName == "DIV") 
	{
		// get type of node
		var node_type = GetNodeType(element_id);
		
		// get the children nodes (that is the object)
		var element_id = GetChildNodeValue(element_id, "ElementID");
		var element_label = GetChildNodeValue(element_id, "ElementLabel");
		var element_style = GetChildNodeValue(element_id, "ElementStyle");
		var element_size = GetChildNodeValue(element_id, "ElementSize");
		var element_value = GetChildNodeValue(element_id, "ElementValue");		
		var element_rows = GetChildNodeValue(element_id, "ElementRows");
		var element_cols = GetChildNodeValue(element_id, "ElementCols");		
		
		var element_change = GetChildNodeValue(element_id, "ElementOnChange");
		var element_click = GetChildNodeValue(element_id, "ElementOnClick");
		
		// marshall the object nodes
		if (element_label != "" && element_label != "undefined")
		{
			var label_node = GetChildDataNode(element_id, "elementLabel");
			var label_type = GetNodeType(label_node);
			if (label_type == "Element") 
			{
				Loadelement(element_name,  element_label[0], element_label[1]);
				element_label = "";
			}
			element_label = element_label.replace(/&LINEBREAK/g, "<BR>");
		}
					
		if (element_change != "" && element_change != "undefined")
		{
			element_change = element_change.replace(/&COMMA/g, ",");
		}
		
		if (element_click != "" && element_click != "undefined")
		{
			element_click = element_click.replace(/&COMMA/g, ",");
		}
		
		// parse the object nodes based on root node type
		if (node_type == "LinkElement") 
		{
			var link_href = GetChildNodeValue(element_id, "LinkHREF");
			var link_text = GetChildNodeValue(element_id, "LinkText");
			
			html_str = "<A href='" + link_href + "'" + " style='font-weight:bold;font-size:12;color:blue'" + " onclick=\"" + element_click + ";\">" + link_text + "</A>";
		}
		
		if (node_type == "ButtonElement") 
		{
			var button_text = GetChildNodeValue(element_id, "ButtonText");
			
			html_str = element_label + "<Input type=button " + " id='" + element_id + "'" + " style='" + element_style + "'" + " value='" + button_text + "'" + " onclick=\"" + element_click + ";\">";
		}
	
		if (node_type == "SelectElement") 
		{
			var sel_values = GetChildNodeValue(element_id, "SelValues");
			var sel_codes = GetChildNodeValue(element_id, "SelCodes");
			var sel_type = GetChildNodeValue(element_id, "SelType");
			
			html_str = element_label + "<Select id='" + element_id + "'";
			if (sel_type == "Multiple") 
			{
				html_str += " multiple"; 
			} 
				
			if (element_size != "") 
			{
				html_str += " size=" + element_size;
			}
				
			html_str += " style='" + element_style + "'" + " onchange=\"" + element_change + "\";" + ">" + "</Select>";
		
		
			var sel_obj = obj.all(element_id);
			for (var idx=0; idx < sel_values.length;idx++) 
			{
				var opt = document.createElement("<Option>");
				opt.text = sel_values[idx];
				opt.value = sel_codes[idx];
				
				sel_obj.add(opt);
			}
		}

		if (node_type == "TextElement") 
		{
			var text_string = GetChildNodeValue(element_id, "TextString");
			
			text_string = text_string.replace(/&LINEBREAK/g, "<BR>");
			html_str = "<Span style='" + element_style + "'" + ">" + text_string + "</Span>";
		}		


		if (node_type == "TextAreaElement") 
		{
			html_str = element_label + "<TextArea id='" + element_id + "'" + 
												 " style='" + element_style + "'" +
												 " rows='" + element_rows + "'" +
												 " cols='" + element_cols + "'" +    
												 " onchange=\"" + element_change + ";\"" + 
											">" +
											element_value + 
											"</TextArea>";

		}		

		if (node_type == "TextBoxElement") 
		{
			html_str = element_label + "<Input type=text " + 
												 " id='" + element_id + "'" + 
												 " style='" + element_style + "'" +
												 " size='" + element_size + "'" +  
												 " value='" + element_value + "'" + 
												 " onchange=\"" + element_change + ";\"" + 
											">";

		}
	}
		
	LogEvent("4 Done element");
	return html_str;
}

function LoadControlValue(control_name, control_data_node, control_data_node_name) 
{
	var node_value = GetNodeValue(control_data_node, control_data_node_name);
	
	// get the control object (Window#Window#Control)
	var obj = document.all(control_name);
	if (obj == "undefined") {
		alert ("invalid control");
		return null;
	}
	
	var obj_type = obj.type;
	if (obj_type == "text" || obj_type == "textarea") {

		obj.value = node_value;
		return;
	}
	
	if (obj_type == "select-one" || obj_type == "select-multiple") {
		// loop through the options, check the value, set the selected index, break
		for (var idx=0; idx < obj.length;idx++) 
		{
			var opt = obj.options[idx];
			if(opt.value == node_value) 
			{
				opt.selected = true;
				break;
			}
		}
	}
		
	return;
}

function SaveControlValue(control_name, control_data_node, control_data_node_name) 
{
	// get the control object
	var obj = document.all(control_name);
	if (obj == "undefined") {
		alert ("invalid control");
		return null;
	}
	
	var node_value = SetNodeValue(control_data_node, control_data_node_name, obj.value);
}

