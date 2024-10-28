function create_and_add_popout_section(id, x, y, w, h, url, src)
{
	// create a new browser window similar to the parent browser window
//	if (url == "")
//		url = "C:\\MyReleases\\intrainter\\dev\\pww-html-gui\\ii.html";
		
	var new_window = window.open(url, "_blank");
		
	// set the dimensions to the ones provided
	new_window.moveTo(x, y);
	new_window.resizeTo(w, h);
	
	// create and add the section (initially as dock top);
}