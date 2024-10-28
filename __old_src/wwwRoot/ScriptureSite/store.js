function GetStore(parent_store, store_id);
{
	// fetch the data stores object
	var parent_store_obj = document.all(parent_store);
	var parent_store_tree_obj = document.all(parent_store + "_tree");
	
	var ds_node = parent_store_obj.all(store_id);
	if (ds_node == null || ds_node == "undefined")
		// store id does not exist, check to see if the children have it
		var children_str = parent_store_tree_obj.all(store_id).value;
		var children = children_str.split(",");
	
		for (var idx=0; idx<children.length;idx++) 
		{
			GetStore(parent_store, children[idx]);
			
		}
		else 
		{
			var store_obj = GetNodeValue(parent_store, store_id);
			return store_obj;
		}
		
	

	
	// if not root, then traverse the children and call GetStore on each
	
	 
}

