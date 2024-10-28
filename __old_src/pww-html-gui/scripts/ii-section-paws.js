function destroy_dock_paws()
{
	// create the dock paws and display
	for (var idx = 0; idx < groot_container.child_sections.length;idx++)
	{
		var child = groot_container.child_sections[idx];
		if (is_paw(child))
		{
			destroy_section(child);
			idx--;
		}
	}
}

function create_dock_paw(section, pos)
{
	if (section == null)
		return null;
		
	var id = "paw_" + pos + "_" + section.id;
	
	// create the section for the paw
	var bsection = create_abstract_section(section, id, "outer");
	if (bsection == null)
		return null;
		
	bsection.position_type = "float";
	bsection.real_type = "paw";
	
	sss(bsection, "backgroundColor", "magenta");
	ssf(bsection, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=.7, rotation=0)progid:DXImageTransform.Microsoft.Alpha( Opacity=100, FinishOpacity=100, Style=2, StartX=60,  FinishX=90, StartY=10, FinishY=90);");
	align_section(bsection, "center");	

	// override
	sss(bsection, "overflow", "hidden");
	sss(bsection, "borderTopStyle", "outset");
	sss(bsection, "borderTopWidth", ".04cm");
	sss(bsection, "borderTopColor", "white");
	sss(bsection, "borderLeftStyle", "outset");
	sss(bsection, "borderLeftWidth", ".04cm");
	sss(bsection, "borderLeftColor", "white");
	sss(bsection, "borderBottomStyle", "outset");
	sss(bsection, "borderBottomWidth", ".04cm");
	sss(bsection, "borderBottomColor", "white");
	sss(bsection, "borderRightStyle", "outset");
	sss(bsection, "borderRightWidth", ".04cm");
	sss(bsection, "borderRightColor", "white");

	return bsection;
}

function is_paw(paw)
{
	if (paw != null && paw.real_type == "paw")
		return true;
	
	return false;
}

// =================================================================
// show dock paws 
function show_dock_paws()
{
	var section = gdrop_in_section;
	
	// get section from mouse x, y
	if (section == null)
		return;
		
	// destroy the paws of the previous section
	destroy_dock_paws();
	
	gprev_dock_paw = null;
	if (is_tab_bar(gdragdock_org_section))
	{
		var tabc = get_tab_container(section);
			
		if (tabc != null && tabc.id == gdragdock_org_section.tab_container.id)
		{
			show_tab_bar_dock_paws(tabc.tab_bar);
			return;
		}
	}
	else if (is_tab_bar(section))
	{
		show_tab_bar_tab_dock_paw(section);
		return;
	}

	show_container_dock_paws(section, section, true, true);
}

function show_tab_bar_dock_paws(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;

	var tabc = tab_bar.tab_container;
	show_tab_container_dock_paws(tabc);
}

function show_tab_bar_tab_dock_paw(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;
		
	var center = gci(tab_bar);
	var last_tab = center.child_sections[center.child_sections.length-1];
	
	var tabc = tab_bar.tab_container;
	var left = gsl_s(last_tab);
	var top = gst_s(last_tab);
	if (tab_bar.dock_position == "bottom")
	{	
		var x =  left + last_tab.width - tabc.tabs_overlap;
		var y = top;
		var w = tabc.tab_length;
		var h = tabc.tab_breadth-tabc.tabbar_padding;

		show_tab_dock_paw(tab_bar, x, y, w, h, "bottom");
	}
	else if (tab_bar.dock_position == "top")
	{	
		var x = left + last_tab.width - tabc.tabs_overlap;
		var y = top;
		var w = tabc.tab_length;
		var h = tabc.tab_breadth - tabc.tabbar_padding;

		show_tab_dock_paw(tab_bar, x, y, w, h, "top");
	}
	else if (tab_bar.dock_position == "left")
	{	
		var x = left;
		var y = top + last_tab.height - tabc.tabs_overlap;;
		var w = tabc.tab_breadth - tabc.tabbar_padding;
		var h = tabc.tab_length;

		show_tab_dock_paw(tab_bar, x, y, w, h, "left");
	}
	else if (tab_bar.dock_position == "right")
	{	
		var x = left;
		var y = top + last_tab.height - tabc.tabs_overlap;;
		var w = tabc.tab_breadth - tabc.tabbar_padding;
		var h = tabc.tab_length;

		show_tab_dock_paw(tab_bar, x, y, w, h, "right");
	}
}

function show_container_dock_paws(section, container, show_tab_paws, show_stick_paws)
{
	if (section == null || container == null) 
		return false;
		
	// recursively display dock/tab/stick paws for the section and all its containers, till the root.
	var container_parent = gpo(container);
	if (container.parent_section != null)
		show_container_dock_paws(section, container_parent, show_tab_paws, show_stick_paws);
	
	// if container is a child of the org drag section then do not display paws in the container
	if (is_section_in_child_tree(container, gdragdock_org_section) || is_section_in_child_tree(section, gdragdock_org_section))
		return false;

	// also dock paws for a tab container are displayed by a different function. so return here
	if (section.tab_container != null && section.tab_container.id == container.id)
		return false;

	var lx = section.width * .3;
	var ly = section.height * .3;
	
	var ex = window.event.x - gsl_s(container);
	var ey = window.event.y - gst_s(container);

	if (ey > ly && ey <= container.height - ly)
	{
		if (ex < lx)
			show_dock_paw(container, "left", show_tab_paws, show_stick_paws);

		if (ex > container.width - lx)			
			show_dock_paw(container, "right", show_tab_paws, show_stick_paws);
	}
		
	if (ex > lx && ex <= container.width - lx)
	{
		if (ey < ly)
			show_dock_paw(container, "top", show_tab_paws, show_stick_paws);

		if (ey > container.height - ly)			
			show_dock_paw(container, "bottom", show_tab_paws, show_stick_paws);
	}
}

function show_tab_container_dock_paws(container)
{
	if (container == null) 
		return false;
		
	var lx = container.width * .3;
	var ly = container.height * .3;
	
	var ex = window.event.x - gsl_s(container);
	var ey = window.event.y - gst_s(container);

	if (ey > ly && ey <= container.height - ly)
	{
		if (ex < lx)
			show_dock_paw(container, "left", false, false);

		if (ex > container.width - lx)			
			show_dock_paw(container, "right", false, false);
	}
		
	if (ex > lx && ex <= container.width - lx)
	{
		if (ey < ly)
			show_dock_paw(container, "top", false, false);

		if (ey > container.height - ly)			
			show_dock_paw(container, "bottom", false, false);
	}
}

function show_dock_paw(section, pos, show_tab_paws, show_stick_paws)
{
	if (section == null)
		return;

	var bsection = create_dock_paw(groot_container, pos);
	var tab_paw = null;
	
	section = go(section);
		
	// no docking in the center section
	if (is_center(section))
		return;
		
	// set the pos and size
	if (pos == "left")
	{
		var h = 0;
		var x = gsl_s(section);
		if (gprev_dock_paw != null)
			x = gprev_dock_paw.left + gprev_dock_paw.width;
		var y = gst_s(section);
		var w = gpaw_thickness;		
		
		if (show_stick_paws)
		{
			// show the tab dock paw
			h = gpaw_tab_length;
			if (section.height/4 <= h)
				h = section.height/4;
						
			stick_paw = show_stick_paw(section, x, y, w, h, "left");
			create_and_show_text(stick_paw, "cap_" + stick_paw.id, "left", "Stick", "arial", "white", 12, "", "");								
			
			y+=h;						
		}

		if (show_tab_paws)
		{
			// show the tab dock paw
			hs = gpaw_tab_length;
			if (section.height/4 <= hs)
				hs = section.height/4;
						
			tab_paw = show_tab_dock_paw(section, x, y, w, hs, "left");
			create_and_show_text(tab_paw, "cap_" + tab_paw.id, "left", "Tab", "arial", "white", 12, "", "");								
			
			y+=hs;
			h+=hs;
		}
		
		// show the section dock paw
		bsection.left = x;
		bsection.top = y;
		bsection.width = gpaw_thickness;
		bsection.height = section.height-h;
		
		create_and_show_text(bsection, "cap_" + bsection.id, "left", "Dock Left", "arial", "white", 12, "", "");								
	}
	else if (pos == "right")
	{
		var h = 0;
		var x = gsl_s(section) + section.width - gpaw_thickness;
		if (gprev_dock_paw != null)
			x = gprev_dock_paw.left - gpaw_thickness;
		var y = gst_s(section);
		var w = gpaw_thickness;
		
		if (show_tab_paws)
		{
			// show the tab dock paw
			h = gpaw_tab_length;
		
			if (section.height/4 <= h)
				h = section.height/4;
							
			tab_paw = show_tab_dock_paw(section, x, y, w, h, "right");
			create_and_show_text(tab_paw, "cap_" + tab_paw.id, "right", "Tab", "arial", "white", 12, "", "");								
			y+=h;
		}
		
		bsection.left = x;
		bsection.top = y;
		bsection.width = gpaw_thickness;
		
		// show the section dock paw
		if (show_stick_paws)
		{
			// show the tab dock paw
			var sh = gpaw_tab_length;
		
			if (section.height/4 <= sh)
				sh = section.height/4;
							
			stick_paw = show_stick_paw(section, x, section.height - sh + (gst_s(section)), w, sh, "right");
			create_and_show_text(stick_paw, "cap_" + stick_paw.id, "right", "Stick", "arial", "white", 12, "", "");								

			h+=sh;			
		}
		
		bsection.height = section.height-h;		
		create_and_show_text(bsection, "cap_" + bsection.id, "right", "Dock Right", "arial", "white", 12, "", "");								

	}
	else if (pos == "top")
	{
		var w = 0;
		var y = gst_s(section);
		if (gprev_dock_paw != null)
			y = gprev_dock_paw.top + gprev_dock_paw.height;
		var x = gsl_s(section);
		
		if (show_tab_paws)
		{
			// show the tab dock paw
			w = gpaw_tab_length;
			var h = gpaw_thickness;
		
			if (section.width/4 <= w)
				w = section.width/4;
							
			tab_paw = show_tab_dock_paw(section, x, y, w, h, "top");
			create_and_show_text(tab_paw, "cap_" + tab_paw.id, "top", "Tab", "arial", "white", 12, "", "");								
			
			x+=w;
		}
		
		bsection.left = x;
		bsection.top = y;
		bsection.height = gpaw_thickness;

		if (show_stick_paws)
		{
			// show the tab dock paw
			var ws = gpaw_tab_length;
			var h = gpaw_thickness;
		
			if (section.width/4 <= ws)
				ws = section.width/4;
							
			stick_paw = show_stick_paw(section, section.width-ws + gsl_s(section), y, ws, h, "top");
			create_and_show_text(stick_paw, "cap_" + stick_paw.id, "top", "Stick", "arial", "white", 12, "", "");								
			
			w+=ws;
		}

		// show the section dock paw
		bsection.width = section.width - w;
		
		create_and_show_text(bsection, "cap_" + bsection.id, "top", "Dock Top", "arial", "white", 12, "", "");								
	}
	else if (pos == "bottom")
	{
		var x = gsl_s(section);
		var w = 0;
		var y = gst_s(section) + section.height - gpaw_thickness;
		if (gprev_dock_paw != null)
			y = gprev_dock_paw.top - gpaw_thickness;

		if (show_tab_paws)
		{
			// show the tab dock paw
			w = gpaw_tab_length;
			var h = gpaw_thickness;
		
			if (section.width/4 < w)
				w = section.width/4;
							
			tab_paw = show_tab_dock_paw(section, x, y, w, h, "bottom");
			create_and_show_text(tab_paw, "cap_" + tab_paw.id, "bottom", "Tab", "arial", "white", 12, "", "");								
			
			x+=w;
		}
			
		if (show_stick_paws)
		{
			ws = gpaw_tab_length;
			var h = gpaw_thickness;
		
			if (section.width/4 < ws)
				ws = section.width/4;
							
			stick_paw = show_stick_paw(section, x, y, ws, h, "bottom");
			create_and_show_text(stick_paw, "cap_" + stick_paw.id, "bottom", "Stick", "arial", "white", 12, "", "");								
			
			x+=ws;
			w+=ws;
		}

		// show the section dock paw
		bsection.top = y;
		bsection.left = x;
		bsection.width = section.width - w;
		bsection.height = gpaw_thickness;
		create_and_show_text(bsection, "cap_" + bsection.id, "bottom", "Dock Bottom", "arial", "white", 12, "", "");								
	}

	gprev_dock_paw = bsection;
  	set_section_actual_dimension(bsection);
	show_section(bsection);
	
	bsection.paw_type = "section";
	if (is_tab_bar(gdragdock_org_section))
		bsection.paw_type = "tab_bar";
	bsection.dock_to_section = section;
	bsection.dock_position = pos;
	
	return bsection;
}

function show_tab_dock_paw(section, x, y, w, h, pos)
{
	if (section == null)
		return;
		
	var paw = create_dock_paw(groot_container, "tab");

	set_section_dimension(paw, x,y,w,h);		
  	set_section_actual_dimension(paw);
  		
	sss(paw, "backgroundColor", "lime");
	show_section(paw);
		
	paw.paw_type = "tab";
	paw.dock_to_section = section;
	paw.dock_position = pos;
	
	return paw;
}

function show_stick_paw(section, x, y, w, h, pos)
{
	if (section == null)
		return;
		
	var paw = create_dock_paw(groot_container, "stick");

	set_section_dimension(paw, x,y,w,h);		
  	set_section_actual_dimension(paw);
  		
	sss(paw, "backgroundColor", "green");
	show_section(paw);
		
	paw.paw_type = "stick";
	paw.dock_to_section = section;
	paw.dock_position = pos;
	
	return paw;
}
