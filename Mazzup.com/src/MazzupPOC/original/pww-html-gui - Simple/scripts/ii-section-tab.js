// ======================================================================================================
function create_section_and_add_tab(tab_in_section, id, x, y, w, h, position, tab_text)
{
	tab_in_section = go(tab_in_section);
	if (tab_in_section == null)
		return null;
				
	var tabc = null;
	if (tab_in_section.tab_container == null)
		tabc = create_tab_container(tab_in_section, w, h, position);
	else
		tabc = tab_in_section.tab_container;
				
	// create the new section and create a tab
	var new_section = add_section(tabc, id, x, y, w, h, "", "dock");
	create_tab(tabc.tab_bar, new_section, tab_text);

	return new_section;
}

function create_section_and_add_tab_node(parent, id, x, y, w, h, position, tab_text) {
    if (parent == null)
        return null;

/*    var tabc = null;
    if (tab_in_section.tab_container == null)
        tabc = create_tab_container(tab_in_section, w, h, position);
    else
        tabc = tab_in_section.tab_container;
*/

    // create the new section and create a tab
    var w = 0; var h = 0;
    if (position == "left" || position == "right") {
        w = parent.tab_breadth;
        h = gsh(parent);
    }
    else {
        w = gsw(parent);
        h = parent.tab_breadth;
    }

    var tab_node = create_section(parent, "tab_bar_for_" + id, 0, 0, w, h, "", "dock");
    tab_node.position_type = "dock";
    tab_node.dock_position = "left";

    if (parent.tab_bar == null) {
        parent.tab_bar = create_tab_bar(parent, tab_node, position, tab_text);
        parent.tab_bar.tab_container = parent;
    }
    else {
        var tab = create_tab(parent.tab_bar, tab_node, tab_text);
        tab_node.tab = tab;
    }

    return tab_node;
}

function create_tab_container(for_section, w, h, pos)
{
	if (for_section == null)
		return;

	// contain the for_section, and then make the container as the tab_container		
	var container = contain_section(for_section, "tabc_" + for_section.id);

	if (pos == "left" || pos == "right")
		set_section_dimension(container, -1, -1, w + container.tab_breadth, h);
	else
		set_section_dimension(container, -1, -1, w, h + container.tab_breadth);

	// create a tab bar for the tab container
	var tab_bar = create_tab_bar(container, for_section, pos);

	sss(container, "overflow", "hidden");
	container.tab_position = pos;	
	return container;
}

function create_tab_bar(tab_container, for_section, pos, tab_text)
{
	if (tab_container == null || for_section == null)
		return null;
		
	var w = 0; var h = 0;
	if (pos == "left" || pos == "right")
	{
		w = tab_container.tab_breadth;
		h = gsh(gi(for_section));
	}
	else
	{
		w = gsw(gi(for_section));
		h = tab_container.tab_breadth;		
	}

	var tab_bar = create_section(gi(tab_container), "tab_bar_for_" + tab_container.id, 0, 0, w, h, "", "dock");
	tab_bar.real_type = "tab_bar";
	tab_bar.is_sizable = false;		
	tab_bar.position_type = "dock";
	tab_bar.dock_position = pos;
	
	tab_container.tab_bar = tab_bar;
	tab_bar.tab_container = tab_container;

	// create the tab_bar's section bar, initially all invisible
	create_section_bar(tab_bar, "left");
	create_section_bar(tab_bar, "right");
	create_section_bar(tab_bar, "top");
	create_section_bar(tab_bar, "bottom");

	set_tab_bar_default_style(tab_bar);
	
	// create the tab for the for_section		
	create_tab(tab_bar, for_section, tab_text);
	
	return tab_bar;
}

function create_tab(tab_bar, for_section, tab_text)
{
	if (tab_bar == null || for_section == null)
		return null;

	// create the tab
	add_property(tab_bar, "is_visible", true);

	var tab = create_section(tab_bar, "tab_for_" + for_section.id, 0, 0, 0, 0, "dock"); // set the dimensions later
	tab.real_type = "tab";
	tab.position_type = "static";
	tab.is_sizable = false;
	add_property(tab, "is_fixed_height", true);
	add_property(tab, "is_fixed_width", true);
		
	tab.tab_bar = tab_bar;
	tab.tab_section = for_section;
	
	for_section.tab = tab;
	for_section.tab_container = tab_bar.tab_container;
	for_section.is_sizable = false;
	add_property(for_section, "is_visible", true);
	
	set_section_dimension(gi(for_section), 0, 0, tab_bar.tab_container.width, tab_bar.tab_container.height);
	
	tab.handle.onmouseover = tab_mouseover;
	tab.handle.onmouseout = tab_mouseout;
	tab.handle.onmousedown = bar_mousedown;
	tab.handle.onmousemove = tab_mousemove;		
	tab.handle.onmouseup = bar_mouseup;
	
	tab.handle.onclick = tab_onclick;	
	
	for (var idx=0; idx < tab_bar.child_sections.length; idx++) {
		var t = tab_bar.child_sections[idx];
		t.tab_is_active = false;
	}

    var tabtxt = tab.tab_section.tab_text;
    if (tab_text != undefined)
        tabtxt = tab_text;

    if (tabtxt == "")
        tabtxt = tab.tab_section.id.substring(tab.tab_section.id.length - 10);

    var text = create_text(tab, "tab_text_" + tab.id, tabtxt);
    text.onclick = tab_onclick;	

    tab.tab_length = tabtxt.length * 8 + 50;

    // set alignment
    if (text.parentNode != null) {
        //g_ss(text.parentNode, "margin", "10px");
    }

	set_text_direction(tab, "tab_text_" + tab.id, tab_bar.dock_position);	
	set_text_style(tab, "tab_text_" + tab.id, "arial", "white", 12, "bold", "");	

	set_tab_default_style(tab);
	set_tab_is_active(tab);
	
	layout_tab_bar_tabs(tab_bar);
	return tab;
}

function set_tab_bar_default_style(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;

	sss(tab_bar, "backgroundColor", "white");
	sss(tab_bar, "overflow", "auto");
	sss(tab_bar, "borderStyle", "none");
}

function set_tab_default_style(tab)
{
	if (!is_tab(tab))
		return;
	
	sss(gi(tab), "borderStyle", "none");
	
	sss(tab, "backgroundColor", "lime");
	sss(tab, "overflow", "hidden");

	sss(tab, "borderTopStyle", "outset");
	sss(tab, "borderTopWidth", "2");
	sss(tab, "borderTopColor", "white");

	sss(tab, "borderLeftStyle", "outset");
	sss(tab, "borderLeftWidth", "2");
	sss(tab, "borderLeftColor", "white");
		
	sss(tab, "borderBottomStyle", "outset");
	sss(tab, "borderBottomWidth", "2");
	sss(tab, "borderBottomColor", "white");

	sss(tab, "borderRightStyle", "outset");
	sss(tab, "borderRightWidth", "2");
	sss(tab, "borderRightColor", "white");

	if (!is_tab_bar(tab.tab_bar))
	{
		if (tab.tab_bar.dock_position == "bottom")
			sss(tab, "borderTopStyle", "none");
		else if (tab.tab_bar.dock_position == "top")
			sss(tab, "borderBottomStyle", "none");
		else if (tab.tab_bar.dock_position == "left")
			sss(tab, "borderRightStyle", "none");
		else if (tab.tab_bar.dock_position == "right")
			sss(tab, "borderLeftStyle", "none");
	}
}

function layout_tab_bar(tab_bar)
{
	// pass the center
	if (!is_tab_bar(tab_bar))
		return;
	
	// set default and change below based on the position	
	tab_bar.bar_right.is_visible = false;
	tab_bar.bar_bottom.is_visible = false;
	tab_bar.bar_left.is_visible = false;
	tab_bar.bar_top.is_visible = false;

	add_property(tab_bar, "is_fixed_height", false);
	add_property(tab_bar, "is_fixed_width", false);
	tab_bar.is_sizable = false;
	
	tab_bar.min_section_width = 0;
	tab_bar.min_section_height = 0;

	var tabc = tab_bar.tab_container;
	tab_bar.dock_position = tabc.tab_position;
		
	if (tab_bar.dock_position == "bottom")
	{	
		tab_bar.width = gi(tab_bar.tab_container).width;
		tab_bar.height = gi(tab_bar).height;

		tab_bar.min_section_height = tabc.tab_breadth;
	
		add_property(tab_bar, "is_fixed_height", true);
		tab_bar.bar_left.is_visible = true;
		
		create_text(gi(tab_bar.bar_left), "tit_" + tab_bar.bar_left.id, "");								
	}
	else if (tab_bar.dock_position == "top")
	{	
		tab_bar.width = gi(tab_bar.tab_container).width;
		tab_bar.height = gi(tab_bar).height;

		tab_bar.min_section_height = tabc.tab_breadth;
		
		add_property(tab_bar, "is_fixed_height", true);
		tab_bar.bar_left.is_visible = true;

		create_text(gi(tab_bar.bar_left), "tit_" + tab_bar.bar_left.id, "");								
	}
	else if (tab_bar.dock_position == "left")
	{	
		tab_bar.width = gi(tab_bar).width;
		tab_bar.height = gi(tab_bar.tab_container).height;

		tab_bar.min_section_width = tabc.tab_breadth;
		
		add_property(tab_bar, "is_fixed_width", true);
		tab_bar.bar_top.is_visible = true;
		
		create_text(gi(tab_bar.bar_top), "tit_" + tab_bar.bar_top.id, "");										
	}
	else if (tab_bar.dock_position == "right")
	{	
		tab_bar.width = gi(tab_bar).width;
		tab_bar.height = gi(tab_bar.tab_container).height;

		tab_bar.min_section_width = tabc.tab_breadth;
		
		add_property(tab_bar, "is_fixed_width", true);
		tab_bar.bar_top.is_visible = true;
		
		create_text(gi(tab_bar.bar_top), "tit_" + tab_bar.bar_top.id, "");										
	}


	set_tab_bar_default_style(tab_bar);
}

function layout_tab_bar_tabs(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;

	var active_tab = null;		
	var breadth_increased = 0;
	var pt = null;

	var tlength = 0;
	var num_tabs = get_number_of_child_sections(tab_bar);

	var tabidx = 0;
	var tabc = tab_bar.tab_container;
	if (tabc.tab_length_fixed)	
		tlength = tabc.tab_length;
//	else
//	{
//        tlength 
//		if (tab_bar.dock_position == "top" || tab_bar.dock_position == "bottom")
//			tlength = gi(tab_bar).width/num_tabs;
//		else
//			tlength = gi(tab_bar).height/num_tabs;
//			
//		if (tlength < tabc.tab_min_length)
//			tlength = tabc.tab_min_length;
//	}
		
	if (((tab_bar.dock_position == "bottom" || tab_bar.dock_position == "top") && tab_bar.width > tlength) ||
		((tab_bar.dock_position == "left" || tab_bar.dock_position == "right") && tab_bar.height > tlength))
	{
		for (var idx=0; idx < tab_bar.child_sections.length; idx++)
		{
			var t = tab_bar.child_sections[idx];
			if (is_bar(t))
			    continue;
                		
			if (t.tab_is_active)
				active_tab = t;

			var ptl = 0;
			var ptt = 0;
			var ptw = 0;
			var pth = 0;
			if (pt != null) {
			    ptl = pt.left;
			    ptt = pt.top;
			    ptw = pt.width;
			    pth = pt.height;
			}

			add_property(t, "is_fixed_width", true);
			add_property(t, "is_fixed_height", true);

			if (tab_bar.dock_position == "bottom") {
			    var tab_bar_bar_left = tab_bar.bar_left;
			    if (tabidx == 0)
			        ptl += tab_bar_bar_left.left + tab_bar_bar_left.width;

			    ppt = tab_bar_bar_left.top;
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "top";

				if (tabidx == 0)
				    t.left = ptl + tabc.tabbar_padding;
				else {
					t.left = ptl + ptw - tabc.tabs_overlap;
					if (t.left < 0)
						t.left = 0;
				}
					
    			t.top = 0;
	
				t.width = t.tab_length;
				t.height = tabc.tab_breadth - tabc.tabbar_padding;
					
				if (t.left + t.width > tab_bar.width)
				{
					breadth_increased++;
					t.left = 0;
					t.top = breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}

				set_section_dimension(t, t.left, t.top, t.width, t.height);
			}
			else if (tab_bar.dock_position == "top")
			{	
			    var tab_bar_bar_left = tab_bar.bar_left;
			    if (tabidx == 0)
			        ptl += tab_bar_bar_left.left + tab_bar_bar_left.width;

				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "bottom";

				if (tabidx == 0)
				    t.left = ptl + tabc.tabbar_padding;
				else
				{
					t.left = ptl + ptw - tabc.tabs_overlap;
					if (t.left < 0)
						t.left = 0;
				}

	            t.width = t.tab_length;
	            t.height = tabc.tab_breadth - tabc.tabbar_padding;

	            t.top = tab_bar.height - t.height;

				if (t.left + t.width > tab_bar.width)
				{
					breadth_increased++;
					t.left = 0;
					t.top = tabc.tabbar_padding + breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}
				
				set_section_dimension(t, t.left, t.top, t.width, t.height);
			}
			else if (tab_bar.dock_position == "left")
			{	
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "right";

				var tab_bar_bar_top = tab_bar.bar_top;
				if (tabidx == 0)
                {
                    ptl = tab_bar.width - t.width;
				    ptt += tab_bar_bar_top.top + tab_bar_bar_top.height;
                }

				if (tabidx == 0)
					t.top = ptt + tabc.tabbar_padding;
				else
				{
					t.top = ptt + pth - tabc.tabs_overlap;
					if (t.top < 0)
						t.top = 0;
				}

				t.width = tabc.tab_breadth - tabc.tabbar_padding;
				t.height = t.tab_length;

				t.left = ptl;
					
				if (t.top + t.height > tab_bar.height)
				{
					breadth_increased++;
					t.top = tabc.tabbar_padding + tab_bar_bar_top.top + tab_bar_bar_top.height;
					t.left = tab_bar.width - breadth_increased * (tabc.tab_breadth - tabc.tabbar_padding) - t.width;
				}

				set_section_dimension(t, t.left, t.top, t.width, t.height);
			}
			else if (tab_bar.dock_position == "right")
			{	
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "left";

				var tab_bar_bar_top = tab_bar.bar_top;
				if (tabidx == 0)
				    ptt += tab_bar_bar_top.top + tab_bar_bar_top.height;

				if (tabidx == 0)
				    t.top = ptt + tabc.tabbar_padding;
				else {
				    t.top = ptt + pth - tabc.tabs_overlap;
				    if (t.top < 0)
				        t.top = 0;
				}

				t.left = ptl;

				t.width = tabc.tab_breadth - tabc.tabbar_padding;
				t.height = t.tab_length;

				if (t.top + t.height > tab_bar.height)
				{
					breadth_increased++;
					t.top = tabc.tabbar_padding + tab_bar_bar_top.top + tab_bar_bar_top.height;
					t.left = breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}

				set_section_dimension(t, t.left, t.top, t.width, t.height);
			}

            position_section(t, "absolute");
            set_tab_default_style(t);
			set_text_direction(t, "tab_text_" + t.id, t.tab_bar.tab_container.tab_position);

			pt = t;

			tabidx++;

        }
	}
	else
		breadth_increased = tab_bar.child_sections.length-1;
		
	if (tab_bar.dock_position == "top" || tab_bar.dock_position == "bottom")
	{
		tab_bar.height = ((tabc.tab_breadth-tabc.tabbar_padding)*(1+breadth_increased))+tabc.tabbar_padding;
		tab_bar.height = tab_bar.height;
		gi(tab_bar).height = tab_bar.height;
	}
	else
	{
		tab_bar.width = ((tabc.tab_breadth-tabc.tabbar_padding)*(1+breadth_increased))+tabc.tabbar_padding;
		tab_bar.width = tab_bar.width;
		gi(tab_bar).width = tab_bar.width;
	}
}

function is_tab_bar(tab_bar)
{
	if (tab_bar == null)
		return false;
	
	tab_bar = go(tab_bar);
			
	if (tab_bar != null && tab_bar.real_type == "tab_bar")
		return true;
	
	return false;
}

function is_tab(tab)
{
	if (tab == null)
		return false;
	
	tab = go(tab);
	
	if (tab != null && (tab.real_type == "tab" || tab.real_type == "tab_node"))
		return true;
	
	return false;
}

// ================================================
function set_tab_is_active(tab)
{
	if (!is_tab(tab))
		return;

	// go through the children of the tab bar and set them all to invisible
	for (var idx = 0; idx < tab.parent_section.child_sections.length; idx++)
	{
		var stab = tab.parent_section.child_sections[idx];
		if (stab.id == tab.id)
			continue;

        if (is_bar(stab))
            continue;

		stab.tab_is_active = false;
		stab.tab_section.is_visible = false;
		
		set_tab_inactive_style(stab);
		
		hide_all_borders(stab.tab_section);
		sss(stab, "zIndex", tab.parent_section.child_sections.length - idx);		
	}

	tab.tab_is_active = true;
	tab.tab_section.is_visible = true;
	
	set_tab_active_style(tab);
	sss(tab, "zIndex", tab.parent_section.child_sections.length);			

	add_property(tab.tab_bar.tab_container, "is_sized", true);
}

function set_tab_inactive_style(tab)
{
	if (!is_tab(tab))
		return;
		
	set_tab_default_style(tab);
	
	sss(tab, "backgroundColor", "#F080F0");
	sss(tab, "zIndex", 0);
	
	set_text_direction(tab, "tab_text_" + tab.id, tab.tab_bar.tab_container.tab_position);
	set_text_style(tab, "tab_text_" + tab.id, "arial", "white", 12, "bold",  "#F080F0");	
}

function set_tab_active_style(tab)
{
	if (!is_tab(tab))
		return;

	set_tab_default_style(tab);
	
	sss(tab, "backgroundColor", "yellow");
	sss(tab, "zIndex", 1);

	set_text_direction(tab, "tab_text_" + tab.id, tab.tab_bar.tab_container.tab_position);
	set_text_style(tab, "tab_text_" + tab.id, "arial", "red", 12, "bold", "yellow");	
}

// ================================================
function add_tab(for_section, tab_container)
{
	if (for_section == null || tab_container == null)
		return;
		
	set_section_parent(for_section, gi(tab_container));
	var tab = create_tab(tab_container.tab_bar, for_section);

	add_property(for_section, "is_sized", false);
	add_property(tab_container, "is_sized", false);
	
	return tab;
}

function add_new_tab(for_section, in_section)
{
	if (for_section == null || !is_tab_bar(in_section))
		return null;
	
	if (for_section.tab_container != null && for_section.tab_container.id == in_section.tab_container.id)
		return;

	return add_tab(for_section, in_section.tab_container);
}
	
function add_tab_in_untabbed_section(for_section, in_section, pos)
{
	if (in_section == null || for_section == null || in_section.tab_container != null)
		return null;

	destroy_section_borders(for_section);
	destroy_section_borders(in_section);
	
	// if this is tabbing to a section in which there are no tabs
	var tabc = create_tab_container(in_section, in_section.width, in_section.height, pos);
	for_section.tab_container = null;

	return add_tab(for_section, tabc);
}
	
function add_tab_in_tabbed_section(for_section, in_section, pos)
{
	if (in_section == null || for_section == null || in_section.tab_container == null)
		return null;

	destroy_section_borders(for_section);
	destroy_section_borders(in_section);

	// if this is tabbing to a section in which there are already tabs
	var org_tabc = in_section.tab_container;
	var org_tab = in_section.tab;
	var org_dp = in_section.dock_position;
		
	// unset the old one
	if (for_section.tab_container != null)
		for_section.tab_container = null;
			
	// create the new tab container for in_section, for_section
	var tabc = create_tab_container(in_section, in_section.width, in_section.height, pos);
	tabc.dock_position = org_dp;
		
	// change references for the in_section's old tab container
	tabc.tab_container = org_tabc;
	tabc.tab = org_tab;
	tabc.tab.tab_section = tabc;

	// create unique ids for the tabbed tab container		
	tabc.id = "section_tc_" + for_section.id + "_" + tabc.id;
	g_set_id(tabc.handle, "g_" + tabc.id);

	change_tab_id(tabc);
		
	// set properties for the new tab container
	tabc.is_sizable = false;
	add_property(in_section, "is_sized", false);
			
	// for the for_section, create a tab in the in_section
	var t = add_tab(for_section, tabc);
		
	// display
	set_tab_is_active(t);
	
	return t;
}

function add_tab_for_root_container(for_section, pos)
{
	if (for_section == null)
		return null;
	
	destroy_section_borders(for_section);
		
	// create a new root and contain the old children
	var container = contain_root_container(for_section.id, pos);

	// create a tab container		
	var tabc = create_tab_container(container, container.width, container.height, pos);
	tabc.dock_position = pos;
			
	// create a tab for the for_section
	set_section_parent(for_section, gi(tabc));
	var ntab = create_tab(tabc.tab_bar, for_section);
	set_tab_is_active(ntab);
	
	add_property(for_section, "is_sized", false);

	return ntab;
}

function dock_tab_bar(tab_bar, new_dock_pos)
{
	if (!is_tab_bar(tab_bar))
		return;
		
	destroy_section_borders(tab_bar.tab_container);
	
	// set the new dock position
	tab_bar.tab_container.tab_position = new_dock_pos;

	// invoke the styles by setting the active tab
	for (var idx = 0; idx < tab_bar.child_sections.length; idx++) {
		var stab = tab_bar.child_sections[idx];
		if (stab.tab_is_active)
		{
			set_tab_is_active(stab);		
			break;
		}
	}

	layout_tab_bar(tab_bar);
	layout_tab_bar_tabs(tab_bar);

}

function remove_tab(section)
{
	if (section == null || section.tab_container == null || section.tab == null)
		return false;
		
	var section_to_adjust = null;
	var num_tabbed_sections = 0;
	for (idx=0; idx<gi(section.tab_container).child_sections.length;idx++)
	{
		var child = gi(section.tab_container).child_sections[idx];
		if (child.id != section.id && 
			!is_border(child) && 
			!is_tab_bar(child))
		{
			num_tabbed_sections++;
			section_to_adjust = child;
		}
	}

	// there is only one tab in the container, so remove the whole tabbing.
	// check if itself is contained in a tab. IN that case proper references have to be set to the parent tab_container 
	if (num_tabbed_sections == 1)
	{
		// tab container's parent
		var tabc = section.tab_container;
		var tabc_psection = tabc.parent_section;
		
		// destroy the tabbing
		destroy_section(section.tab_container.tab_bar);
		var cpos = get_section_position(section.tab_container);
		remove_child_section(section);
		destroy_section(section.tab_container);

		// move the only tabbed section out of the tab container 
		set_section_parent(section_to_adjust, tabc_psection);
		move_last_section_to_position(section_to_adjust, cpos);

		section_to_adjust.position_type = tabc.position_type;
		section_to_adjust.dock_position = tabc.dock_position;
		section_to_adjust.is_sizable = true;
		section_to_adjust.is_visible = true;
		
		add_property(section_to_adjust, "is_sized", false);
		
		// if the destroyed tabbing's tab_Container is itself part of a tab (super tabbing)
		// then section_to_adjust becomes part of the super tab
		if (tabc.tab != null)
		{
			// set tab references
			section_to_adjust.tab_container = go(tabc_psection);
			section_to_adjust.tab = tabc.tab;
			section_to_adjust.tab.tab_section = section_to_adjust;
			section_to_adjust.is_sizable = false;
			section_to_adjust.is_visible = true;
			
			set_section_dimension(gi(section_to_adjust), 0, 0, section_to_adjust.tab_container.width, section_to_adjust.tab_container.height);
			change_tab_id(section_to_adjust);

			set_tab_is_active(section_to_adjust.tab);
		}
		else
		{
			section_to_adjust.tab_container = null;
			section_to_adjust.tab == null;
		}
						
		// set the tab references to null
		section.tab_container = null;
		section.tab == null;
		section.is_sizable = true;
		section.is_visible = true;
		add_property(section, "is_sized", false);

		return true;
	}		
	
	// if number of remaining tabbed sections is > 1, then simply remove the same
	if (num_tabbed_sections > 1)
	{
		// remove the tab
		destroy_tab(section.tab);
		remove_child_section(section);

		section.is_sizable = true;
		section.is_visible = true;
		add_property(section, "is_sized", false);
		
		set_last_tab_active(section.tab_container.tab_bar)

		section.tab_container = null;
		section.tab = null;

		return true;
	}
	
	return false;
}

function set_last_tab_active(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;

	set_tab_is_active(tab_bar.child_sections[tab_bar.child_sections.length - 1]);
}

function change_tab_position(tab, before_tab)
{
	// if this is tabbing in a particular tab position
	if (!is_tab(tab))
		return;
		
	if (!is_tab(before_tab))
		return;

	if (tab.id == before_tab.id)
		return;
		
	if (tab.tab_bar.id != before_tab.tab_bar.id)
		return;
		
	var tpos = get_section_position(before_tab);
	move_section_to_position(tab, tpos);
	
	set_tab_is_active(tab);	
}


// ================================================
function shift_tab_container(of_section, to_section)
{
	if (of_section == null || to_section == null)
		return;
		
	if (of_section.tab_container != null && of_section.tab != null)
	{
		to_section.tab_container = of_section.tab_container;
		to_section.tab = of_section.tab;
		to_section.tab.tab_section = to_section;
			
		change_tab_id(to_section);
		
		to_section.is_sizable = false;
		of_section.is_sizable = true;
		add_property(of_section, "is_sized", false);

		of_section.tab_container = null;
		of_section.tab = null;
		
		set_tab_is_active(to_section.tab);
	}
}

function change_tab_id(tab_section)
{
	if (tab_section == null || tab_section.tab == null)
		return;
		
	tab_section.tab.id = "section_tab_for_" + tab_section.id;
	g_set_id(tab_section.tab.handle, "g_" + tab_section.tab.id);


	var tabtxt = tab_section.tab_text;
	if (tabtxt == "")
	    tabtxt = tab_section.id.substring(tab_section.id.length - 10);

	var t = create_text(tab_section.tab, "tab_text_" + tab_section.tab.id, tabtxt);

	// set alignment
	if (t.parentNode != null)
	  t.parentNode.valign = "middle";

	set_text_direction(tab_section.tab, "tab_text_" + tab_section.tab.id, tab_section.tab.tab_bar.dock_position);
	set_text_style(tab_section.tab, "tab_text_" + tab_section.tab.id, "arial", "white", 12, "bold",  "#F080F0");	
}

function destroy_tab(tab)
{
	var pos = 0;
	var index = -1;
	
	destroy_section(tab);

	add_property(tab.tab_section, "is_sized", false);
	tab.tab_section.is_sizable = true;
	tab.tab_section.is_visible = true;
	tab.tab_section.tab = null;
	tab.tab_section = null;
}

function get_tab_container(section)
{
	if (section == null)
		return;
	
	section = go(section);
		
	var tabc = null;
	var s = section;
	
	while (s != null)
	{
		if (s.parent_section != null)
		{
			if (s.tab_container != null && 	s.tab_container.id == s.parent_section.id)
			{
				tabc = s.tab_container;
				break;
			}
			
			s = gpo(s);
		}
		else
			s = null;		
		
	}
	
	return tabc;
}