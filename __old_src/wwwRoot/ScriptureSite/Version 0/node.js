function GetDataNodeString(data_node_id) 
{
	// check field
	if (document.all("global_vars").item(data_node_id) == null || document.all("global_vars").item(data_node_id) == "undefined") 
	{
		alert("Data Node does not exist");
	}
	
	if (document.all("global_vars").item(data_node_id).type == "hidden")	
	{
		return document.all("global_vars").item(data_node_id).value;
	}
	
	return null;
}

function GetDataNodeName(data_node_id) 
{
	var node_str = GetDataNodeString(data_node_id);
	
	if (node_str == "") {
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	var data_name = res_array[1];
	
	return data_name;
}

function GetDataNodeParent(data_node_id) 
{
	var node_str = GetDataNodeString(data_node_id);
	
	if (node_str == "") 
	{
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	var parent_data_name = res_array[2];
	
	return parent_data_name;
}

function GetDataNodeType(data_node_id) 
{
	var node_str = GetDataNodeString(data_node_id);
	
	if (node_str == "") 
	{
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	var data_type = res_array[0];
	
	return data_type;
}

function GetDataNodePosition(data_node_id) 
{
	var data_pos = 0;
	var node_str = GetDataNodeString(data_node_id);
	
	if (node_str == "") 
	{
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	data_pos = res_array[3];
	
	return data_pos;
}

function GetDataNodeAtPos(parent_node_id, pos) 
{
	var children = GetNodeChildren(parent_node_id);
	for (var idx = 0; idx < children.length; idx++) {
		var res_pos = GetDataNodePosition(children[idx]);
			
		if (res_pos == pos)
			return children[idx];
	}
	
	return 0;
}

// --------------------------------------------------------
function GetNextSiblingNode(node_id, node_type) {
	// get the parent of node_id
	var parent_id = GetDataNodeParent(node_id);
	
	// get the position of node_id
	var pos = GetDataNodePosition(node_id);

	// get the node in next position
	var next_node = GetDataNodeAtPos(parent_id, Number(pos)+1)
	return next_node;
}

// ---------------------------------------------------------
function GetChildDataNode(child_nodes_array, data_node_name) 
{
	var req_node_id = "";
	
	if (data_node_name == "") 
	{
		alert("empty node name value requested");
		return "";
	}

	for (var idx=0;idx < child_nodes_array.length; idx++) 
	{
		req_node_name = GetDataNodeName(child_nodes_array[idx]);

		if (req_node_name == data_node_name) 
		{
			req_node_id = child_nodes_array[idx];
			break;
		}
		else 
		{
			req_node_id = "";
			req_node_name = "";
		}
	}
	
	return req_node_id;
}

function GetDataNodeChildValue(child_nodes_array, data_node_name) 
{
	var req_node_id = GetChildDataNode(child_nodes_array, data_node_name);
	
	if (req_node_id != "") 
	{
		return GetDataNodeValue(req_node_id, data_node_name);
	}
	else 
	{
		return "";
	}
}

function GetNodeChildren(control_data_node) {
	var idx = 0;
	var idxc = 0;
	var children = new Array();

	var glb_form = document.all("global_vars_id");
	for (idx = 0; idx < glb_form.length; idx++) 
	{
		var node_obj = glb_form.all(idx);
		if (node_obj != null && node_obj != "undefined") 
		{
			if (node_obj.type == "hidden") 
			{
				var node_obj_hid = node_obj;
				var node_obj_hid_id = node_obj.id;
				
				var data_parent = node_obj.value;
	
				if (data_parent == control_data_node) 
				{
					children[idxc++] = node_obj_hid_id;
				}
			}
		}
	}
	
	return children;
}

function GetNodeChildrenOnType(node_id, node_type) {
	var idx = 0;
	var idxc = 0;
	var children = new Array();

	var glb_form = document.all("global_vars_id");
	for (idx = 0; idx < glb_form.length; idx++) 
	{
		var node_obj = glb_form.all(idx);
		if (node_obj != null && node_obj != "undefined") 
		{
			if (node_obj.type == "hidden") 
			{
				var node_obj_hid = node_obj;
				var node_obj_hid_id = node_obj.id;
				
				var data_parent = node_obj.value;
	
				if (data_parent == node_id) 
				{
					var res_node_type = GetDataNodeType(node_obj_hid_id);
					if (res_node_type == node_type) 
						children[idxc++] = node_obj_hid_id;
				}
			}
		}
	}
	
	return children;
}



function GetCollection(collection_node, collection_field) {
	var col = new Array();
	var col_cnt = 0;
	
	// loop through all hids an
	for (idx = 0; idx < global_vars.all.length; idx++) 
	{
		var parent = GetDataNodeParent(global_vars.all.item(idx).id);
		
		// find hids that have parent as collection_node
		if (collection_node == parent) 
		{
			// if yes check the collection_field
			var node_val = GetDataNodeValue(global_vars.all[idx].id, collection_field);
			
			// append it to the list
			col[col_cnt++] = node_val;
		}
	}
				
	return col;			
}

// ---------------------------------------------------		
function GetDataNodeValue(data_node_id, data_node_name) 
{
	var node_str = GetDataNodeString(data_node_id);
	
	if (data_node_name == "") 
	{
		alert("empty node name value requested");
		return "";
	}

	if (node_str == "") 
	{
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	var data_type = res_array[0];
	var data_name = res_array[1];
	var data_parentid = res_array[2];
	var data_position = res_array[3];
	var data_value = "";

	if (data_node_name != "-1" && data_node_name != data_name) 
	{
		alert("Invalid data requested");
	}

	if (data_type == "Node") 
	{
		data_node_ptr_id = res_array[4];
		data_node_ptr_name = res_array[5];
		data_value = new Array();
		
		var children = GetNodeChildren(data_node_ptr_id);
		for (var idx = 0; idx < children.length; idx++) 
		{
			var value=GetDataNodeValue(children[idx], data_node_ptr_name);
			data_value[idx] = value;
		}
	}

	if (data_type == "NameValue") 
	{
		data_value = res_array[4];
	}
		
	if (data_type == "Element") 
	{
		data_value = new Array();
		data_value[0] = res_array[4];
		data_value[1] = res_array[5];
	}

	if (data_type == "DataSet") 
	{
		data_value = new Array();
		data_value[0] = res_array[4];
		data_value[1] = res_array[5];
	}

	if (data_type == "NameValueList") 
	{
		data_value = new Array();
		for (var idx = 4; idx < res_array.length;idx++) 
		{
			data_value[idx-4] = res_array[idx];
		}
	}

	if (data_type == "Collection") 
	{
		data_value = new Array();
		data_value = GetCollection(res_array[4], res_array[5]);		
	}
	
	if (data_type == "NameValueRange") 
	{
		data_value = new Array();
		var start = res_array[4];
		var end = res_array[5];
		var step  = res_array[6];
		var neg_prefix  = res_array[7];
		var pos_prefix  = res_array[8];
		var neg_suffix  = res_array[9];
		var pos_suffix  = res_array[10];

		if(step == null || step == "undefined") 
		{
			step = 1;
		}
			
		for (var idx = Number(start); idx <= Number(end);idx += Number(step)) 
		{
			data_value[idx/Number(step)-Number(start)] = idx;
			if (idx < 0) 
			{
				if (neg_prefix != null && neg_prefix != "" && neg_prefix != " ") 
				{
					data_value[idx/Number(step)-Number(start)] = neg_prefix + res_array[idx];
				}
				
				if (neg_suffix != null && neg_suffix != "" && neg_suffix != "") 
				{
					data_value[idx/Number(step)-Number(start)] += neg_suffix;
				}
			}
					
			if (idx >= 0) 
			{
				if (pos_prefix != null && pos_prefix != " " && pos_prefix != "") 
				{
					data_value[idx/Number(step)-Number(start)] = pos_prefix + res_array[idx];
				}
				if (pos_suffix != null && pos_suffix != " " && pos_suffix != "") 
				{
					data_value[idx/Number(step)-Number(start)] += pos_suffix;
				}
			}
		}
	}

	if (data_value == "undefined" || data_value == null) 
	{
		return "";
	}
		
	return data_value;
}

function GetDataNodeParent(data_node_id) 
{
	var node_str = GetDataNodeString(data_node_id);
	
	if (node_str == null || node_str == " " && node_str == "") 
	{
		return null;
	}	
	
	var res_array = node_str.split(",");
	var data_parent = res_array[2];

	return data_parent;
}
function SetDataNodeValue(hid_node_id, data_node_name, node_data_value) 
{
	if (data_node_name == "") 
	{
		alert("empty node name value requested");
		return null;
	}

	if (node_str == "") 
	{
		alert("field node string is empty");
		return null;
	}	
	
	var node_str = GetNodeDataString(hid_node_id);
	var res_array = node_str.split(",");
	var data_type = res_array[0];
	var data_name = res_array[1];
	var data_parentid = res_array[2];
	var data_position = res_array[3];
	var data_value = "";

	if (data_node_name != data_name) 
		alert("Invalid data requested for change");

	if (data_type == "NameValue")
		data_value = node_data_value;
		
	// concal the strings
	var node_hid_value = data_type + "," + data_name + "," + data_parentid + "," +
						 data_position + "," + data_value;
						 
	document.all(hid_node_id).value = node_hid_value;
}

// ---------------------------------------------------		