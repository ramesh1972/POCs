function GetNodeString(data_node_id) 
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

function GetNodeParent(data_node_id) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in GetNodeParent");
		return null;
	}	

	for (var idx = 0; idx< document.all("global_vars_id").length;idx++) 
	{
		var node_str = document.all("global_vars_id").item(idx).value;
		var res = node_str.match(data_node_id);
		if (res != null)
			return document.all("global_vars_id").item(idx).id;
	}

	return null;	
}

function GetNodeName(data_node_id) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in GetNodeName");
		return null;
	}	

	var node_str = GetNodeString(data_node_id);
	
	if (node_str == null) {
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	var data_name = res_array[1];
	
	return data_name;
}

function GetNodeType(data_node_id) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in GetNodeType");
		return null;
	}	

	var node_str = GetNodeString(data_node_id);
	
	if (node_str == null) 
	{
		alert("field node string is empty");
		return null;
	}	
	
	var res_array = node_str.split(",");
	var data_type = res_array[0];
	
	return data_type;
}

function GetNodePosition(data_node_id) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in GetNodePosition");
		return null;
	}	
	
	var data_pos = 0;
	var parent = GetNodeParent(data_node_id);
	if (parent == null) 
		alert("data node does not contain parent in GetNodePosition");
		
	var children = new Array();
	children = GetNodeChildren(parent);
	if (children == null) 
	{
		alert("no children for data node in GetNodePosition");
		return 0;
	}	
	
	for (var idx = 0; idx < children.length; idx++) {
		if (children[idx] == data_node_id) 
			return idx + 1;
	}
	
	return 0;
}

function GetNodeChildren(parent_node_id) 
{
	if (parent_node_id == null) 
	{
		alert("invalid parent_node_id in GetNodeChildren");
		return null;
	}	

	var idx = 0;
	var idxc = 0;
	var children = new Array();

	var glb_form = document.all("global_vars_id");
	var node_obj = glb_form.all(parent_node_id);

	if (!(node_obj == null || node_obj == "undefined")) 
	{
		var val = node_obj.value;
		return val.split(",");
	}
	
	return null;
}

// ---------------------------------------------------------
function GetChildNodeByName(parent_id, data_node_name) 
{
	if (parent_id == null) 
	{
		alert("invalid parent_node_id in GetCHildNodeByName");
		return null;
	}	

	var req_node_id = null;
	var child_nodes_array = GetNodeChildren(parent_id);
	
	if (parent_id == "" || parent_id == null) 
	{
		alert("empty node name value requested");
		return null;
	}

	for (var idx=0;idx < child_nodes_array.length; idx++) 
	{
		req_node_name = GetNodeName(child_nodes_array[idx]);
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

function GetNodeChildrenWithType(parent_node_id, node_type) 
{
	if (parent_node_id == null) 
	{
		alert("invalid parent_node_id in GetNodeChildrenWithType");
		return null;
	}	

	var idx = 0;
	var idxc = 0;
	var children = new Array();
	var type_children = new Array();
	
	children = GetNodeChildren(parent_node_id);
	if (parent_node_id == null || children == null)
	{
		alert("node does not contain children");
		children = null;
		type_children = null;
		return null;
	}
	
	for (idx = 0; idx < children.length; idx++) 
	{
		var res_node_type = GetNodeType(children[idx]);
		if (node_type == "" || res_node_type == node_type) 
			type_children[idxc++] = children[idx];
	}
	
	children = null;
	return type_children;
}
	

function GetNodeAtPosition(parent_node_id, pos) 
{
	if (parent_node_id == null) 
	{
		alert("invalid data_node_id in GetNodeAtPOsition");
		return null;
	}	

	var children = GetNodeChildren(parent_node_id);
	for (var idx = 0; idx < children.length; idx++) 
	{
		if (pos == idx+1)
			return children[idx];
	}
	
	return 0;
}

function GetNextSiblingNode(data_node_id, node_type) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in GetNodeString");
		return null;
	}	

	// get the parent of node_id
	var parent_id = GetNodeParent(data_node_id);

	// get the position of node_id
	var pos = GetNodePosition(data_node_id);

	// get the node in next position
	var next_node = GetNodeAtPosition(parent_id, Number(pos)+1)
	return next_node;
}

// ---------------------------------------------------------
function GetChildNodeValue(parent_id, data_node_name) 
{
	if (parent_id == null) 
	{
		alert("invalid parent_id in GetChildNodeValue");
		return null;
	}	

	var req_node_id = GetChildNodeByName(parent_id, data_node_name);
	if (req_node_id != null) 
	{
		var val = GetNodeValue(req_node_id, data_node_name);
		return val;
	}

	return null;
}

function GetNodeValue(data_node_id, data_node_name) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in GetNodeValue");
		return null;
	}	

	var node_str = GetNodeString(data_node_id);
	
	if (data_node_name == "" || data_node_name == null) 
	{
		alert("empty node name value requested");
		return "";
	}

	if (node_str == null) 
	{
		alert("field node string is empty");
		return "";
	}	
	
	var res_array = node_str.split(",");
	var data_parentid = GetNodeParent(data_node_id);
	var data_name = res_array[1];
	var data_type = res_array[0];

	var data_value = "";

	if (data_node_name != "" && data_node_name != null && data_node_name != data_name) 
	{
		alert("Invalid data requested in GetNodeValue");
	}

	if (data_type == "Node") 
	{
		data_node_ptr_id = res_array[4];
		data_node_ptr_name = res_array[5];
		data_value = new Array();
		
		var children = GetNodeChildren(data_node_ptr_id);
		for (var idx = 0; idx < children.length; idx++) 
		{
			var value=GetNodeValue(children[idx], data_node_ptr_name);
			data_value[idx] = value;
		}
	}

	if (data_type == "NameValue") 
	{
		data_value = res_array[2];
	}
		
	if (data_type == "Element") 
	{
		data_value = new Array();
		data_value[0] = res_array[2];
		data_value[1] = res_array[3];
	}

	if (data_type == "DataSet") 
	{
		data_value = new Array();
		data_value[0] = res_array[2];
		data_value[1] = res_array[3];
	}

	if (data_type == "NameValueList") 
	{
		data_value = new Array();
		for (var idx = 2; idx < res_array.length;idx++) 
		{
			data_value[idx-2] = res_array[idx];
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
		var start = res_array[2];
		var end = res_array[3];
		var step  = res_array[3];
		var neg_prefix  = res_array[4];
		var pos_prefix  = res_array[5];
		var neg_suffix  = res_array[7];
		var pos_suffix  = res_array[8];

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

function SetNodeValue(data_node_id, data_node_name, node_data_value) 
{
	if (data_node_id == null) 
	{
		alert("invalid data_node_id in SetNodeValue");
		return null;
	}	

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
	
	var node_str = GetNodeDataString(data_node_id);
	var res_array = node_str.split(",");
	var data_parentid = GetNodeParent(data_node_id);
	var data_name = res_array[1];
	var data_type = res_array[0];

	var data_value = "";

	if (data_node_name != data_name) 
		alert("Invalid data requested for change");

	if (data_type == "NameValue")
		data_value = node_data_value;
		
	// cancel the strings
	var node_hid_value = data_type + "," + data_name + "," +  data_value;
						 
	document.all("global_vars").all(data_node_id).value = node_hid_value;
}

// ---------------------------------------------------		
function GetCollection(collection_node, collection_field) 
{
	var col = new Array();
	var col_cnt = 0;
	
	// loop through all hids an
	for (idx = 0; idx < global_vars.all.length; idx++) 
	{
		var parent = GetNodeParent(global_vars.all.item(idx).id);
		
		// find hids that have parent as collection_node
		if (collection_node == parent) 
		{
			// if yes check the collection_field
			var node_val = GetNodeValue(global_vars.all[idx].id, collection_field);
			
			// append it to the list
			col[col_cnt++] = node_val;
		}
	}
				
	return col;			
}

