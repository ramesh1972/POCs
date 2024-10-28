function LoadControl(control_name, control_data_node, control_data_node_name) 
{
	// get the control object (Window#Window#Control)
	var obj = document.all(control_name);
	if (obj == null || obj == "undefined") {
		alert ("invalid control");
		return null;
	}

	var obj_type = obj.type;

	// The main parsing routine
	if (obj.tagName == "DIV") 
	{
		// get type of node
		var node_type = GetDataNodeType(control_data_node);
		
		// get the children nodes (that is the object)
		LogEvent("4 Start Log Get Node Children");
		var child_nodes = GetNodeChildren(control_data_node);
		LogEvent("4 Start Log End Get Node Children");			
		
		var control_id = GetDataNodeChildValue(child_nodes, "ControlID");
		var control_label = GetDataNodeChildValue(child_nodes, "ControlLabel");
		var control_style = GetDataNodeChildValue(child_nodes, "ControlStyle");
		var control_size = GetDataNodeChildValue(child_nodes, "ControlSize");
		var control_value = GetDataNodeChildValue(child_nodes, "ControlValue");		
		var control_rows = GetDataNodeChildValue(child_nodes, "ControlRows");
		var control_cols = GetDataNodeChildValue(child_nodes, "ControlCols");		
		
		var control_change = GetDataNodeChildValue(child_nodes, "ControlOnChange");
		var control_click = GetDataNodeChildValue(child_nodes, "ControlOnClick");
		
		LogEvent("4 Done Child Values");
		
		// marshall the object nodes
		if (control_label != "" && control_label != "undefined")
		{
			var label_node = GetChildDataNode(child_nodes, "ControlLabel");
			var label_type = GetDataNodeType(label_node);
			if (label_type == "Element") 
			{
				LoadControl(control_name,  control_label[0], control_label[1]);
				control_label = "";
			}
			control_label = control_label.replace(/&LINEBREAK/g, "<BR>");
		}
					
		if (control_change != "" && control_change != "undefined")
		{
			control_change = control_change.replace(/&COMMA/g, ",");
		}
		
		if (control_click != "" && control_click != "undefined")
		{
			control_click = control_click.replace(/&COMMA/g, ",");
		}
		
		// parse the object nodes based on root node type
		if (node_type == "LinkControl") 
		{
			var link_href = GetDataNodeChildValue(child_nodes, "LinkHREF");
			var link_text = GetDataNodeChildValue(child_nodes, "LinkText");
			
			var html_str = "<A href='" + link_href + "'" + " style='font-weight:bold;font-size:12;color:blue'" + " onclick=\"" + control_click + ";\">" + link_text + "</A>";
			obj.innerHTML = html_str;
		}
		
		if (node_type == "ButtonControl") 
		{
			var button_text = GetDataNodeChildValue(child_nodes, "ButtonText");
			
			var html_str = control_label + "<Input type=button " + " id='" + control_id + "'" + " style='" + control_style + "'" + " value='" + button_text + "'" + " onclick=\"" + control_click + ";\">";
			obj.innerHTML = html_str;
		}
	
		if (node_type == "SelectControl") 
		{
			var sel_values = GetDataNodeChildValue(child_nodes, "SelValues");
			var sel_codes = GetDataNodeChildValue(child_nodes, "SelCodes");
			var sel_type = GetDataNodeChildValue(child_nodes, "SelType");
			
			var html_str = control_label + "<Select id='" + control_id + "'";
			if (sel_type == "Multiple") 
			{
				html_str += " multiple"; 
			} 
				
			if (control_size != "") 
			{
				html_str += " size=" + control_size;
			}
				
			html_str += " style='" + control_style + "'" + " onchange=\"" + control_change + "\";" + ">" + "</Select>";
		
			obj.innerHTML = html_str;
			
			var sel_obj = obj.all(control_id);
			for (var idx=0; idx < sel_values.length;idx++) 
			{
				var opt = document.createElement("<Option>");
				opt.text = sel_values[idx];
				opt.value = sel_codes[idx];
				
				sel_obj.add(opt);
			}
		}

		if (node_type == "TextControl") 
		{
			var text_string = GetDataNodeChildValue(child_nodes, "TextString");
			
			text_string = text_string.replace(/&LINEBREAK/g, "<BR>");
			obj.innerHTML = "<Span style='" + control_style + "'" + ">" + text_string + "</Span>";
		}		


		if (node_type == "TextAreaControl") 
		{
			var html_str = control_label + "<TextArea id='" + control_id + "'" + 
												 " style='" + control_style + "'" +
												 " rows='" + control_rows + "'" +
												 " cols='" + control_cols + "'" +    
												 " onchange=\"" + control_change + ";\"" + 
											">" +
											control_value + 
											"</TextArea>";

			obj.innerHTML = obj.innerHTML + html_str;
		}		

		if (node_type == "TextBoxControl") 
		{
			var html_str = control_label + "<Input type=text " + 
												 " id='" + control_id + "'" + 
												 " style='" + control_style + "'" +
												 " size='" + control_size + "'" +  
												 " value='" + control_value + "'" + 
												 " onchange=\"" + control_change + ";\"" + 
											">";

			obj.innerHTML = obj.innerHTML + html_str;
		}
	}
		
	LogEvent("4 Done Control");
	return;
}

function LoadControlValue(control_name, control_data_node, control_data_node_name) 
{
	var node_value = GetDataNodeValue(control_data_node, control_data_node_name);
	
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
	
	var node_value = SetDataNodeValue(control_data_node, control_data_node_name, obj.value);
}

