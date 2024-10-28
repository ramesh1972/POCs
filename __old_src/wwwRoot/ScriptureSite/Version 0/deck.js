var curr_max_node_id = 2;

function LoadDeck(deck_id) {
	document.body.innerHTML = "";
	
	// get the deck node and display
	// create the table tag and div tag and load
	var deck_node = GetNodeChildren(deck_id);
		
	var deck_div_id = GetDataNodeChildValue(deck_node, "PanelID");
	var html = "<Div width=100% id='" + deck_div_id + "'>" + "</Div>";
	document.body.innerHTML = html;
	
	// get all children that are TreeNodes in order of cells, position
	var main_panels = GetNodeChildrenOnType(deck_id, "TreeNode");
	LoadDeckPanel(main_panels[0], "");
}

