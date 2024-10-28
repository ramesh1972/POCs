// ======================================================================================================
function create_section_and_add_tab(tab_in_section, id, x, y, w, h, position)
{
	tab_in_section = go(tab_in_section);
	if (tab_in_section == null)
		return null;
				
	var tabc = null;
	if (tab_in_section.tab_container == null) 
    {
	    tabc = create_tab_container(tab_in_section, w, h, position);
	    tab_in_section.tab_container = tabc;
	}
    else
		tabc = tab_in_section.tab_container;
				
	// create the new section and create a tab
	var new_section = add_section(tabc, id, x, y, w, h, "", "dock");
	create_tab(tabc.tab_bar, new_section);

	return new_section;
}

function create_tab_container(for_section, w, h, pos)
{
	if (for_section == null)
		return;

	// contain the for_section, and then make the container as the tab_container		
	var container = contain_section(for_section, "tabc_" + for_section.id);
	var container_inner = gi(container);

	if (pos == "left" || pos == "right")
		set_section_oi_dimension(container, -1, -1, w + container.tab_breadth, h);
	else
		set_section_oi_dimension(container, -1, -1, w, h + container.tab_breadth);

	// create a tab bar for the tab container
	var tab_bar = create_tab_bar(container, for_section, pos);

	sss(gi(container), "overflow", "hidden");
	container.tab_position = pos;	
	return container;
}

function create_tab_bar(tab_container, for_section, pos)
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
	tab_bar.is_movable = tab_container.is_movable;
	
	tab_container.tab_bar = tab_bar;
	tab_bar.tab_container = tab_container;

	// create the tab_bar's section bar, initially all invisible
	create_section_bar(tab_bar, "left");
	create_section_bar(tab_bar, "right");
	create_section_bar(tab_bar, "top");
	create_section_bar(tab_bar, "bottom");

	set_tab_bar_default_style(tab_bar);
	
	// create the tab for the for_section		
	create_tab(tab_bar, for_section);
	
	return tab_bar;
}

function create_tab(tab_bar, for_section)
{
	if (tab_bar == null || for_section == null)
		return null;
		
	// create the tab
	var center = gci(tab_bar);
	add_property(center, "is_visible", true);

	var tab = create_section(center, "tab_for_" + for_section.id, 0, 0, 0, 0, "dock"); // set the dimensions later
	if (tab_bar.tab_container.tabs == null)
	    tab_bar.tab_container.tabs = new Array();

	tab_bar.tab_container.tabs.push(tab);

	tab.real_type = "tab";
	tab.position_type = "static";
	tab.is_sizable = false;
	add_property(tab, "is_fixed_height", true);
	add_property(tab, "is_fixed_width", true);
		
	tab.tab_bar = tab_bar;
	tab.tab_section = for_section;
	
	for_section.tab = tab;
	for_section.tab_container = tab_bar.tab_container;
	tab.tab_container = tab_bar.tab_container;
	for_section.is_sizable = false;
	add_property(for_section, "is_visible", true);
	
	set_section_dimension(gi(for_section), 0, 0, tab_bar.tab_container.width, tab_bar.tab_container.height);
	
	tab.handle.onmouseover = tab_mouseover;
	tab.handle.onmouseout = tab_mouseout;
	tab.handle.onmousedown = bar_mousedown;
	tab.handle.onmousemove = tab_mousemove;		
	tab.handle.onmouseup = bar_mouseup;
	
	tab.handle.onclick = tab_onclick;	
	
	for (var idx=0; idx < center.child_sections.length; idx++)
	{
		var t = center.child_sections[idx];
		t.tab_is_active = false;
	}

    var text = create_box_text(tab, "tab_text_" + tab.id, tab.tab_section.id.substring(tab.tab_section.id.length - 10));
    tab.text = text;
    set_text_direction(tab, "tab_text_" + tab.id, tab_bar.dock_position);	
	set_text_style(tab, "tab_text_" + tab.id, "arial", "black", 12, "bold", "aqua");	

	set_tab_default_style(tab);
	set_tab_is_active(tab);
	
	layout_tab_bar_tabs(tab_bar);
	return tab;
}

function set_tab_bar_default_style(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;
	
	var tab_bar_center = gci(tab_bar);
	sss(tab_bar_center, "backgroundColor", "white");
	sss(tab_bar_center, "overflow", "hidden");
	sss(tab_bar_center, "borderStyle", "none");
}

function set_tab_default_style(tab)
{
	if (!is_tab(tab))
		return;
	
	sss(gi(tab), "borderStyle", "none");
	
	sss(tab, "backgroundColor", "lime");
	sss(tab, "overflow", "hidden");

	sss(tab, "borderTopStyle", "outset");
	sss(tab, "borderTopWidth", "2px");
	sss(tab, "borderTopColor", "white");

	sss(tab, "borderLeftStyle", "outset");
	sss(tab, "borderLeftWidth", "2px");
	sss(tab, "borderLeftColor", "white");
		
	sss(tab, "borderBottomStyle", "outset");
	sss(tab, "borderBottomWidth", "2px");
	sss(tab, "borderBottomColor", "white");

	sss(tab, "borderRightStyle", "outset");
	sss(tab, "borderRightWidth", "2px");
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

function set_tab_text(tab, value) 
{
    if (tab == null)
        return;

    tab.text.innerHTML = "<table id=\"table_" + tab.id + "\" width=100% height=100% align=center><tr valign=middle><td align=center>" +
                         "<div id=\"" + tab.id + "\">" + value + "</div>" +
                         "</td></tr></table>";
}

function layout_tab_bar(tab_bar)
{
	// pass the center
	if (!is_tab_bar(tab_bar))
		return;

	var tab_bar_center = gci(tab_bar);
	
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
		tab_bar_center.width = gi(tab_bar.tab_container).width;
		tab_bar_center.height = gi(tab_bar).height;

		tab_bar.min_section_height = tabc.tab_breadth;
	
		add_property(tab_bar, "is_fixed_height", true);
		if (tabc.tab_bar_visible)
		    tab_bar.bar_left.is_visible = true;
		
		create_text(gi(tab_bar.bar_left), "tit_" + tab_bar.bar_left.id, "");								
	}
	else if (tab_bar.dock_position == "top")
	{	
		tab_bar_center.width = gi(tab_bar.tab_container).width;
		tab_bar_center.height = gi(tab_bar).height;

		tab_bar.min_section_height = tabc.tab_breadth;
		
		add_property(tab_bar, "is_fixed_height", true);
		if (tabc.tab_bar_visible)
		    tab_bar.bar_left.is_visible = true;

		create_text(gi(tab_bar.bar_left), "tit_" + tab_bar.bar_left.id, "");								
	}
	else if (tab_bar.dock_position == "left")
	{	
		tab_bar_center.width = gi(tab_bar).width;
		tab_bar_center.height = gi(tab_bar.tab_container).height;

		tab_bar.min_section_width = tabc.tab_breadth;
		
		add_property(tab_bar, "is_fixed_width", true);
		if (tabc.tab_bar_visible)
		    tab_bar.bar_top.is_visible = true;
		
		create_text(gi(tab_bar.bar_top), "tit_" + tab_bar.bar_top.id, "");										
	}
	else if (tab_bar.dock_position == "right")
	{	
		tab_bar_center.width = gi(tab_bar).width;
		tab_bar_center.height = gi(tab_bar.tab_container).height;

		tab_bar.min_section_width = tabc.tab_breadth;
		
		add_property(tab_bar, "is_fixed_width", true);
		if (tabc.tab_bar_visible)
		    tab_bar.bar_top.is_visible = true;
		
		create_text(gi(tab_bar.bar_top), "tit_" + tab_bar.bar_top.id, "");										
	}

	set_tab_bar_default_style(tab_bar);
}

function layout_tab_bar_tabs(tab_bar)
{
	if (!is_tab_bar(tab_bar))
		return;

	var tab_bar_center = gci(tab_bar);

	var active_tab = null;		
	var breadth_increased = 0;
	var pt = null;

	var tlength = 0;
	var num_tabs = get_number_of_child_sections(tab_bar_center);
	
	var tabc = tab_bar.tab_container;
	if (tabc.tab_length_fixed)	
		tlength = tabc.tab_length;
	else
	{
		if (tab_bar.dock_position == "top" || tab_bar.dock_position == "bottom")
			tlength = gi(tab_bar).width/num_tabs;
		else
			tlength = gi(tab_bar).height/num_tabs;
			
		if (tlength < tabc.tab_min_length)
			tlength = tabc.tab_min_length;
	}
		
	if (((tab_bar.dock_position == "bottom" || tab_bar.dock_position == "top") && tab_bar.width > tlength) ||
		((tab_bar.dock_position == "left" || tab_bar.dock_position == "right") && tab_bar.height > tlength))
	{
		for (var idx=0; idx < tab_bar_center.child_sections.length; idx++)
		{
			var t = tab_bar_center.child_sections[idx];
				
			if (idx > 0)
				pt = tab_bar_center.child_sections[idx-1];

			if (t.tab_is_active)
				active_tab = t;
					
			add_property(t, "is_fixed_width", true);
			add_property(t, "is_fixed_height", true);

		    var fgcolor = tabc.tabs[idx].tab_fgcolor;
			if (fgcolor == undefined)
			    fgcolor = "black";

			var bgcolor = tabc.tabs[idx].tab_bgcolor;
			if (bgcolor == undefined)
			    bgcolor = "aqua";

			var tab = t;
			set_text_direction(tab, "tab_text_" + tab.id, tab.tab_bar.tab_container.tab_position);

			set_text_style(tab, "tab_text_" + tab.id, "arial tahoma", fgcolor, 12, "bold", bgcolor);

			//t.inner_section_ref.bgcolor = bgcolor;

			if (tab_bar.dock_position == "bottom")
			{	
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "top";

				if (idx == 0 && tabc.tab_bar_visible)
				    t.left = 0;
				else if (idx == 0 && tabc.tab_bar_visible == false)
				    t.left = tabc.title_bar_thickness;
				else {
				    t.left = pt.left + pt.width - tabc.tabs_overlap;
				    if (t.left < 0)
				        t.left = 0;
				}
					
				if (idx == 0)
					t.top =0;
				else
					t.top = pt.top;

				//t.width = tlength;
	            t.width = tabc.tab_length;
				t.height = tabc.tab_breadth - tabc.tabbar_padding;
					
				if (t.left + t.width > tab_bar.width)
				{
					breadth_increased++;
					t.left = 0;
					t.top = breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}
					
				set_section_oi_dimension(t, t.left, t.top, t.width, t.height);
			}
			else if (tab_bar.dock_position == "top")
			{	
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "bottom";

				if (idx == 0 && tabc.tab_bar_visible)
				    t.left = 0;
                else if (idx == 0 && tabc.tab_bar_visible == false)
                    t.left = tabc.title_bar_thickness;
				else
				{
					t.left = pt.left + pt.width - tabc.tabs_overlap;
					if (t.left < 0)
						t.left = 0;
				}

				if (idx == 0)
					t.top = tabc.tabbar_padding;
				else
					t.top = pt.top;

				//t.width = tlength;
				t.width = t.tab_length;
				t.height = tabc.tab_breadth - tabc.tabbar_padding;
					
				if (t.left + t.width > tab_bar.width)
				{
					breadth_increased++;
					t.left = 0;
					t.top = tabc.tabbar_padding + breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}
				
				set_section_oi_dimension(t, t.left, t.top, t.width, t.height);
			}
			else if (tab_bar.dock_position == "left")
			{	
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "right";

				if (idx == 0 && tabc.tab_bar_visible)
					t.top = 0;
				else if (idx == 0 && tabc.tab_bar_visible == false)
				    t.top = tabc.title_bar_thickness;
				else
				{
					t.top = pt.top + pt.height - tabc.tabs_overlap;
					if (t.top < 0)
						t.top = 0;
				}

				if (idx == 0)
					t.left = tabc.tabbar_padding;
				else
					t.left = pt.left;
					
				t.width = tabc.tab_breadth - tabc.tabbar_padding;
				t.height = tlength;
					
				if (t.top + t.height > tab_bar.height)
				{
					breadth_increased++;
					t.top = 0;
					t.left = tabc.tabbar_padding + breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}

				set_section_oi_dimension(t, t.left, t.top, t.width, t.height);
			}
			else if (tab_bar.dock_position == "right")
			{	
				t.tab_section.position_type = "dock";
				t.tab_section.dock_position = "left";

				if (idx == 0 && tabc.tab_bar_visible)
				    t.top = 0;
				else if (idx == 0 && tabc.tab_bar_visible == false)
				    t.top = tabc.title_bar_thickness;
				else
				{
					t.top = pt.top + pt.height - tabc.tabs_overlap;
					if (t.top < 0)
						t.top = 0;
				}

				if (idx == 0)
					t.left = 0;
				else
					t.left = pt.left;

				t.width = tabc.tab_breadth - tabc.tabbar_padding;
				t.height = tlength;
					
				if (t.top + t.height > tab_bar.height)
				{
					breadth_increased++;
					t.top = 0;
					t.left = breadth_increased*(tabc.tab_breadth - tabc.tabbar_padding);
				}

				set_section_oi_dimension(t, t.left, t.top, t.width, t.height);
			}

			set_tab_default_style(t);
			set_text_direction(t, "tab_text_" + t.id, t.tab_bar.tab_container.tab_position);
		}
	}
	else
		breadth_increased = tab_bar_center.child_sections.length-1;
		
	if (tab_bar.dock_position == "top" || tab_bar.dock_position == "bottom")
	{
		tab_bar_center.height = ((tabc.tab_breadth-tabc.tabbar_padding)*(1+breadth_increased))+tabc.tabbar_padding;
		tab_bar.height = tab_bar_center.height;
		gi(tab_bar).height = tab_bar_center.height;
	}
	else
	{
		tab_bar_center.width = ((tabc.tab_breadth-tabc.tabbar_padding)*(1+breadth_increased))+tabc.tabbar_padding;
		tab_bar.width = tab_bar_center.width;
		gi(tab_bar).width = tab_bar_center.width;
	}
}

function is_tab_bar(tab_bar)
{
	if (tab_bar == null)
		return false;
	
	tab_bar = go(tab_bar);
	if (is_center(tab_bar))
		tab_bar = gpo(tab_bar);
			
	if (tab_bar != null && tab_bar.real_type == "tab_bar")
		return true;
	
	return false;
}

function is_tab(tab)
{
	if (tab == null)
		return false;
	
	tab = go(tab);
	if (is_center(tab))
		tab = gpo(tab);
	
	if (tab != null && tab.real_type == "tab")
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
	sss(tab, "width", tab.actual_width);
}

function set_tab_active_style(tab) {
    if (!is_tab(tab))
        return;

    //set_tab_default_style(tab);

    sss(tab, "backgroundColor", "yellow");
    sss(tab.outer_section_ref, "backgroundColor", "yellow");
    sss(tab.inner_section_ref, "backgroundColor", "yellow");
    sss(tab, "zIndex", 1);
    if (tab.handle.style.width != "") {
        tab.actual_width = parseInt(tab.handle.style.width.replace("px", ""));
        sss(tab, "width", parseInt(tab.handle.style.width.replace("px", "")) + 12);
    }

    set_text_direction(tab, "tab_text_" + tab.id, tab.tab_bar.tab_container.tab_position);
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
	tabc.id = "section_outer_tc_" + for_section.id + "_" + tabc.id;
	g_set_id(tabc.handle, "g_" + tabc.id);

	gi(tabc).id = "section_inner_tc_" + for_section.id + "_" + tabc.id;
	g_set_id(gi(tabc).handle, "g_" + tabc.id);

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
	var center = gci(tab_bar);
	for (var idx = 0; idx < center.child_sections.length; idx++)
	{
		var stab = center.child_sections[idx];
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
			!is_tab_bar(child) && 
			!is_center(child))
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
		
	var center = gci(tab_bar);
	if (is_center(center))
		set_tab_is_active(center.child_sections[center.child_sections.length-1]);
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
		
	tab_section.tab.id = "section_outer_tab_for_" + tab_section.id;
	g_set_id(tab_section.tab.handle, "g_" + tab_section.tab.id);
	
	gi(tab_section.tab).id = "section_inner_tab_for_" + tab_section.id;
	g_set_id(gi(tab_section.tab).handle, "g_" + gi(tab_section.tab).id);

	var t = create_text(tab_section.tab, "tab_text_" + tab_section.tab.id, tab_section.id.substring(tab_section.id.length-10));		

	set_text_direction(tab_section.tab, "tab_text_" + tab_section.tab.id, tab_section.tab.tab_bar.dock_position);
	set_text_style(tab_section.tab, "tab_text_" + tab_section.tab.id, "arial tahoma", "white", 12, "bold",  "aqua");	
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
		if (is_outer(s) && gpi(s) != null && gpo(s) != null)
		{
			if (s.tab_container != null && 	s.tab_container.id == gpo(s).id)
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