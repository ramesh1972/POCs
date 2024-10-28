var curr_max_node_id = 2;

function LoadDeck(deck_id) 
{
	document.body.innerHTML = "";
	
	// get the deck node and display
	// create the table tag and div tag and load
	var deck_div_id = GetChildNodeValue(deck_id, "PanelID");
	var html = "<Div width=100% id='" + deck_div_id + "'>" + "</Div>";
	document.body.innerHTML = html;

	LoadDeckPanels(deck_id);	
}

function LoadDeckPanels(deck_id) {
	// get all children that are TreeNodes in order of cells, position
	var main_panels = GetNodeChildrenWithType(deck_id, "TreeNode");
	
	for(var idx=0;idx<main_panels.length;idx++)
		LoadDeckPanel(main_panels[idx], "");
}
