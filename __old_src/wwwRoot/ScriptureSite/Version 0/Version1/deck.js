var curr_max_node_id = 2;

function LoadDeck(deck_id) {
	document.body.innerHTML = "";
	
	// get the deck node and display
	
	// call LoadDeckPanel on the root panel
	LoadDeckPanel(deck_id,  -1);
}

