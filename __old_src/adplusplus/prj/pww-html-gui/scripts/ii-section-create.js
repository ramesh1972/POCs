// ================================================================================
// Class Definitions 
// A section when displayed/used is 2 sections, one within the other. The inner within the outer.
// all sections have these 2, by means of creating 2 instances of this class. Same class is used to denote both 
// outer and inner
//	what is outer? 
//	1) outer section holds the inner sections, and optionaly will hold the bars, which can be used for title, menu, controls, status, etc..
//	2) outer section does not contain any other children apart from these
//	3) the borders (for sizing) are displayed only between outer sections
//  4) outer section hold the positioning properties like dock, stack, float etc, but its dimensions are decided by the inner section dimensions
//	5) outer section has the real type property
									
//	what is inner?
//	1) inner section contains outer child sections like text, buttons, images etc..
//  2) inner section has the innerGraphics property, which in a web page is an html sting
//  3) inner section also has a frame, if enabled with a source file
//  4) importantly inner section can hold several outer sections, i.e basic child sections. So it can act also as a container
//	5) the position type of an inner section is always a left dock.

									
function CSection()
{
	// id and types
	this.id = "";
	this.section_type = "none";     // outer, inner
	this.real_type = "none";	    // root, section, sub-section, border, bar, tab, paw, text, image, progress-bar, slider, button, etc..

	// making the section tree
	this.parent_section = null;
	this.child_sections = new Array();
	this.inner_section_ref = null; // if this is an outer section
	this.outer_section_ref = null; // if this is an inner section
	
	// important references
	this.handle = null; // the graphic object reference, for html this is the div object
	this.frame_handle = null;
	this.is_frame = false;
	this.src = "";
	
	// ref to the derived object (inheritance)
	this.derived_object_ref = null; 

	// positioning
	this.position_type = "float"; // float, dock, tab, stack, static, stick,      popin, popout, modal, slide, 
	this.dock_position = "none"; // left, top, right, bottom, center
	this.tab_position = "none";
	this.stick_left = false;
	this.stick_right = false;
	this.stick_bottom = false;
	this.stick_top = false;
	this.is_always_on_top = false;
		
	// properties dictating dimensions/display
	this.is_visible = true;
	this.size_changed = false;
	this.limit_already_checked = false;
	this.is_sized = false;

	// properties that dictate the mobility of the sections
	this.is_sizable = true;
	this.is_left_sizable = true;
	this.is_top_sizable = true;
	this.is_right_sizable = true;
	this.is_bottom_sizable = true;
	this.is_fixed_width = false;
	this.is_fixed_height = false;
	
	this.is_movable = false;
	this.is_floatable = false;
	this.is_dockable = false;
	this.is_tabbable = false;
	this.is_stickable = false;
	
	this.can_have_drops = true;
	this.can_have_docks = true;
	this.can_have_floats = true;
	this.can_have_sticks = true;
	this.can_have_tabs = true;
	
	// dimensions
	this.left = 0;
	this.top = 0;
	this.width = 400;	
	this.height = 600;
	this.owidth = 400;
	this.oheight = 600;
	
	this.min_section_width = 50;
	this.min_section_height = 100;
	
	// special properties for borders
	this.border_thickness = 5;
	this.border_left = null;
	this.border_right = null;
	this.border_top = null;
	this.border_bottom = null;
		
	// special properties for sections with tabs
	this.tab_container = null; // for sections, tab bar
	this.tab_bar = null; // for a tab container, tabs
	this.tab_section = null; // for a tab
	this.tab = null; // for a section	
	this.is_tab_bar	= false;
	this.tab_is_active = false;

	// these must be set for the tab container
	this.tab_length = 100;
	this.tab_breadth = 40;
	this.tabs_overlap = 10;
	this.tab_length_fixed = true;
	this.tab_min_length = 50;
	this.tabbar_padding = 10;
		
	// special properties, for sections with section bars (outer sections)
	this.bar_left = null;
	this.bar_top = null;
	this.bar_right = null;
	this.bar_bottom = null;
	this.bar_thickness = 16;
}

// ================================================================================
function create_abstract_section(parent_section, id, section_type)
{
	if (section_type != "outer" && section_type != "inner")
		return null;
		
	var section = new CSection();
	section.id = "section_" + section_type + "_" + id;
	section.section_type = section_type;
	
	section.handle = g_create_block("g_" + section.id); // g for graphic
	position_section(section, "absolute");

	// for back reference of the div objects from section
	section.frame_handle = null;

	set_section_parent(section, parent_section);
	
	// signal for sizing
	section.size_changed = true;

	// default styles
  	set_abstract_default_style(section);

	return section;
}

function create_section(parent_section, id, x, y, w, h, pos_type)
{
	// reset is_sized
	reset_section_is_sized(groot_container, false, true);

	if (parent_section == null)
		parent_section = groot_container;
	
	// create the outer
	var outer_s = create_abstract_section(parent_section, id, "outer");
	outer_s.position_type = pos_type;
	
	// create the inner
	var inner_s = create_abstract_section(outer_s, id, "inner");
	inner_s.position_type = "dock";
	inner_s.dock_position = "left";
	inner_s.is_sizable = false;

	// set the main reference	
	outer_s.inner_section_ref = inner_s;
	inner_s.outer_section_ref = outer_s;

	// for certain position types of sections, the x and y are computed on the fly
	if (pos_type == "stack" || pos_type == "stick" || pos_type == "dock")
	{
		x = 0;
		y = 0;
	}
	
	// set the dimensions
	set_section_oi_dimension(outer_s, x, y, w, h);
	
	// set the styles
	set_outer_default_style(outer_s);
	set_inner_default_style(inner_s);

	// ============================================
	// create the container for non docked sections
	// create the outer
	var ndock_outer_s = create_abstract_section(inner_s, "center_" + id, "outer");
	ndock_outer_s.position_type = "dock";
	ndock_outer_s.dock_position = "center";
	ndock_outer_s.is_visible = false; // This center section is visible only when there are non docked sections, like float, stack or static
	
	// create the inner
	var ndock_inner_s = create_abstract_section(ndock_outer_s, "center_" + id, "inner");
	ndock_inner_s.position_type = "dock";
	ndock_inner_s.dock_position = "left";
	ndock_inner_s.is_sizable = false;
	ndock_inner_s.is_visible = false
	
	// set the main reference	
	ndock_outer_s.inner_section_ref = ndock_inner_s;
	ndock_inner_s.outer_section_ref = ndock_outer_s;

	// set dimensions
	set_section_oi_dimension(ndock_outer_s, 0, 0, 0, 0);

	// set the styles
	set_outer_default_style(ndock_outer_s);
	set_inner_default_style(ndock_inner_s);
	set_center_section_default_style(ndock_inner_s);

	return outer_s; // from this the inner can be got, from which outer can be got again, from the inner, center (ndock) can be got.
}

function create_section_iframe(section, src)
{
	if (section == null || !is_inner(section))
		return;
		
	if (src != "")
	{
		section.src = src;
		section.is_frame = true;
	}
	
	// if there is a frame create the same
	var frame_handle = section.frame_handle;
  	if (section.is_frame)
  	{
  		if (frame_handle == null)
  		{
  			frame_handle = g_create_inner_frame("frame_" + section.id, src);
  			g_append_child(section.handle, frame_handle);
  			sss(frame_handle, "position", "absolute");
			section.frame_handle = frame_handle;  		
		}
		
		g_set_dimensions(section.frame_handle, 0, 0, section.width, section.height);
  	}
  	else
  		section.frame_handle = null;  		

	set_iframe_default_styles(section);

	return frame_handle;
}

// ===============================================================
function set_abstract_default_style(section)
{
	sss(section, "backgroundColor","red");
	sss(section, "overflow", "hidden");
	sss(section, "borderStyle","none");
	
	sss(section, "marginLeft", 0);	
	sss(section, "paddingLeft", 0);
	sss(section, "marginTop", 0);	
	sss(section, "paddingTop", 0);
	sss(section, "marginBottom", 0);	
	sss(section, "paddingBottom", 0);
	sss(section, "marginRight", 0);	
	sss(section, "paddingRight", 0);
}

function set_outer_default_style(section)
{
	sss(section, "backgroundColor", "white");
	sss(section, "borderStyle", "none");
	sss(section, "overflow", "hidden");
}

function set_inner_default_style(vsection)
{
	sss(vsection, "backgroundColor", "yellow");
	sss(vsection, "overflow", "hidden");
	sss(vsection, "borderStyle", "none");
}

function set_iframe_default_styles(section)
{
	var frame_handle = section.frame_handle;
	if (frame_handle != null)
	{
  		g_ss(frame_handle, "borderWidth", 1);
		g_ss(frame_handle, "borderStyle", "solid");
		g_ss(frame_handle, "marginLeft", 0);	
		g_ss(frame_handle, "paddingLeft", 0);
		g_ss(frame_handle, "marginTop", 0);	
		g_ss(frame_handle, "paddingTop", 0);
		g_ss(frame_handle, "marginBottom", 0);	
		g_ss(frame_handle, "paddingBottom", 0);
		g_ss(frame_handle, "marginRight", 0);	
		g_ss(frame_handle, "paddingRight", 0);
	}
}

function set_center_section_default_style(section)
{
	sss(section, "backgroundColor", "gray");
	sss(section, "overflow", "auto");
}

// =================================
// get functions
function get_outer(section)
{
	if (section == null)
		return null;
		
	if (section.section_type == "outer")
		return section;
		
	if (section.section_type == "inner")
		return section.outer_section_ref;
		
	return section;		
}

function get_inner(section)
{
	if (section == null)
		return null;
		
	if (section.section_type == "outer")
		if (section.inner_section_ref != null)
			return section.inner_section_ref;

	// if section type is not outer, then it has to be inner, so return the section
	// if section type is outer and if there is no inner, then simply return the outer	
	return section;		
}

function get_center_outer(section)
{
	if (section == null)
		return null;
	
	if (is_center(section))
		return section;
		
	var inner = get_inner(section);
	
			
	var center = null;
	for (var idx = 0; idx < inner.child_sections.length; idx++)
	{
		var child = inner.child_sections[idx];
		if (is_center(child))
		{
			center = child;
			break;
		}
	}
	
	return center;
}

function get_center_inner(section)
{
	var center = get_center_outer(section);
	return get_inner(center);
}

function get_center_owner_outer(center)
{
	return get_parent_outer(center);
}

function get_center_owner_inner(center)
{
	return get_parent_inner(center);
}

function get_parent_outer(section)
{
	var s = get_outer(section);
	if (s == null)
		return null;
		
	var parent = s.parent_section;
	return get_outer(parent);
}

function get_parent_inner(section)
{
	var s = get_outer(section);
	if (s == null)
		return;
		
	var parent = s.parent_section;
	return get_inner(parent);
}

function go(section) { return get_outer(section); }
function gi(section) { return get_inner(section); }
function gco(section) { return get_center_outer(section); }
function gci(section) { return get_center_inner(section); }
function gcoo(section) { return get_center_owner_outer(section); }
function gcoi(section) { return get_center_owner_inner(section); }
function gpo(section) { return get_parent_outer(section); }
function gpi(section) { return get_parent_inner(section); }

function is_outer(section)
{
	if (section != null && section.section_type == "outer")
		return true;
	
	return false;
}

function is_inner(section)
{
	if (section != null && section.section_type == "inner")
		return true;
	
	return false;
}

function is_center(center)
{
	if (center == null)
		return false;
		
	var co = go(center);
	if (co != null && co.dock_position == "center")
		return true;
	
	return false;
}

function is_center_the_only_child_and_visible(section)
{
	var center = gco(section);
	if (center != null && center.is_visible && get_number_of_child_sections(section) == 1)
		return true;
	else
		return false;
}

function is_root(section)
{
	var s = go(section);
	if (s != null && s.real_type == "root")
		return true;
	
	return false;
}

function is_section_in_child_tree(section, tree_start_section)
{
	if (section == null || tree_start_section == null)
		return false;
		
	for (var idx=0;idx<tree_start_section.child_sections.length;idx++)
		if (tree_start_section.child_sections[idx].id == section.id)
			return true;
		else
		{
			var exists = is_section_in_child_tree(section, tree_start_section.child_sections[idx]);
			if (exists)
				return true;
		}
	
	return false;
}
// ===============================================================================
function create_root_container()
{
	groot_container = create_section(null, "root", 0, 0, g_cw(), g_ch(), "dock");
	groot_container.dock_position = "left";
	add_property(groot_container, "real_type", "root");
	groot_container.is_sizable = false;
	
	// add this to the document
	g_append_child(g_groot(), groot_container.handle);

	// display the root
	check_set_and_show_section_tree(groot_container, true);		
}	

// ================================================================================
function contain_root_container(id, side)
{
	var arr = new Array();
		
	// remove all the children of the root and save them in an arrya
	var child = gi(groot_container).child_sections[0];
	var idx = 0;
	var pos = 0;
	var center_child = null;
	while (child != null)
	{
		if (!is_center(child))
		{
			arr[idx++] = child;
			remove_child_section(child);
		}
		else
		{
			center_child = child;
			pos = 1;
		}		
		
		child = gi(groot_container).child_sections[pos];
	}
				 
	// create a new container under the root and add the original children to this container
	var container = create_section(gi(groot_container), id, 0, 0, groot_container.width, groot_container.height, "dock");

	// move all the children of the root container to this container.
	for (idx =0; idx < arr.length; idx++)
	{
		var child = arr[idx];
		set_section_parent(child, gi(container));
	}
			
	// move all the non docked children, i.e. children of center child to the center child of the new container.
	destroy_section_borders(center_child);
	var new_center = gci(container);
	
	var moved = false;
	for (var idx1 = 0; idx1 < gi(center_child).child_sections.length; idx1++)
	{
		var old_center_child = gi(center_child).child_sections[idx1];
		remove_child_section(old_center_child);
		set_section_parent(old_center_child, new_center);
		idx1--;
		
		moved = true;
	}
	
	if (moved)
	{
		center_child.is_visible = false;
		gi(center_child).is_visible = false;
		new_center.is_visible = true;
		go(new_center).is_visible = true;
	}
	
	container.border_thickness = groot_container.border_thickness;
	container.dock_position = side;
	delete arr;

	return container;
}

function contain_section(section, id)
{
	if (is_root(section))
		return contain_root_container(id);
		
	section = go(section);
		
	// detach the parent_section from its parent
	var pos = array_remove_element(section.parent_section.child_sections, section);
	g_remove_child(section.handle);
	
	// create a new container for the parent section
	var pcontainer = create_section(section.parent_section, id, 0, 0, section.width, section.height, section.position_type);
		
	// move the parent section under the pcontainer
	set_section_parent(section, gi(pcontainer));
	pcontainer.real_type = "container";
	pcontainer.position_type = section.position_type;
	pcontainer.dock_position = section.dock_position;
		
	// move the pcontainers position to the pos of the original parent_section
	move_last_section_to_position(pcontainer, pos);
	
	pcontainer.left = section.left;
	pcontainer.top = section.top;	
	
	if (section.position_type == "stick")
	{
		add_property(pcontainer, "is_sized", true);
		pcontainer.stick_left = section.stick_left;
		pcontainer.stick_right = section.stick_right;
		pcontainer.stick_bottom = section.stick_bottom;
		pcontainer.stick_top = section.stick_top;
	}
	
	pcontainer.border_thickness = section.border_thickness;	
	pcontainer.is_always_on_top = section.is_always_on_top;
	
	return pcontainer;
}

// ===================================================================================
function append_child_section(parent_section, section)
{
	if (section == null || parent_section == null)
		return;

	g_append_child(parent_section.handle, section.handle);
}

function destroy_section(section)
{
	if (section == null)
		return;

	hide_section(section);
	
	if (section.is_frame)
		g_remove_child(section.frame_handle);

	var pos = remove_child_section(section);
	
	delete section;
	section = null;
	
	return pos;
}

// destroy hides and deletes the section, while this function simply detaches the section from it parent. it does not 
// destroy it.
function remove_child_section(section)
{
	if (section == null)
		return;

	// destroy borders
	undo_section_border_dimensions(section, true);
	destroy_section_borders(section);
	
	// remove the physical handle
	g_remove_child(section.handle);
	
	return remove_section_from_parent_collection(section);
}	

// ================================================================================
function add_section(parent_section, id, x, y, w, h, src, position_type)
{
	reset_section_is_sized(groot_container, false, true);

	if (position_type == "popout")
	{
		var window = create_and_add_popout_section(id, x, y, w, h, "", src);
		return window;
	}
		
	// create the id
	var id = position_type + "_" + id;

	var parent = parent_section;
	if (parent == null)
		parent = groot_container;
				
	if (!is_root(parent) && position_type != "tab")
		parent.real_type = "container";
	
	// child sections are created under the inner section
	parent = gi(parent);
		
	if (position_type == "float" || position_type == "stack" || position_type == "static")
	{
		parent = gci(parent);
		parent.is_visible = true;
		add_property(gco(parent), "is_visible", true);
	}
	
	if (position_type == "dock" || position_type == "tab" || position_type == "stick" || position_type == "stack")
		x = y = 0;

	if (position_type == "popin")
		parent = gi(groot_container);
		
	// create the section and get a reference to the outer section
	var section = null;
	if (position_type == "tab")
		section = create_section_and_add_tab(parent, id, x, y, w, h, "bottom"); // by default do a bottom tab, then by add_property, change the tab position
	else
		section = create_section(parent, id, x, y, w, h, position_type);

	if (position_type == "stick" || position_type == "popin")
	{
		section.is_always_on_top = true;
		set_section_max_zindex(section);
	}

	if (src != "")
	    section.inner_section_ref.handle.innerHTML = src;

	return section;	// .tab_container on the section, will give the ref to the tab container
}

function add_property(section, name, value)
{
	if (section == null)
		return;
	
	var outer = go(section);
	var inner = gi(section);
	var tabc = get_tab_container(outer);
	var center =  gco(section);
	
	if (name == "real_type")
		outer.real_type = value;
	else if (name == "dock_position")
		outer.dock_position = value;
	else if (name == "stick_left")
		outer.stick_left = value;
	else if (name == "stick_top")
		outer.stick_top = value;
	else if (name == "stick_bottom")
		outer.stick_bottom = value;
	else if (name == "stick_right")
		outer.stick_right = value;

	else if (name == "bar")
	{
		var bar = create_section_bar(outer, value);
		return bar;
	}
	else if (name == "url")
		create_section_iframe(inner, value);

	else if (name == "is_visible")
	{
		outer.is_visible = value;
		inner.is_visible = value;
	}

	else if (name == "is_sized")
		outer.is_sized = value;

	else if (name == "border_thickness")
	{
		outer.border_thickness = value;
		center.border_thickness = value;
	}

	// set the following properties on a tab container
	else if (name == "tab_position" && tabc != null)
		tabc.tab_position = value; // that of the tab container
	else if (name == "tab_length" && tabc != null)
		tabc.tab_length = value;
	else if (name == "tab_breadth" && tabc != null)
		tabc.tab_breadth = value;
	else if (name == "tabs_overlap" && tabc != null)
		tabc.tabs_overlap = value;
	else if (name == "tab_length_fixed" && tabc != null)
		tabc.tab_length_fixed = value;
	else if (name == "tab_min_length" && tabc != null)
		tabc.tab_min_length = value;
	else if (name == "tabbar_padding" && tabc != null)
		tabc.tabbar_padding = value;

	else if (name == "is_sizable")
		outer.is_sizable = value;
	else if (name == "is_fixed_width")
	{
		outer.is_fixed_width = value;
		outer.is_left_sizable = !value;
		outer.is_right_sizable = !value;
	}
	else if (name == "is_fixed_height")
	{
		outer.is_fixed_height = value;
		outer.is_top_sizable = !value;
		outer.is_bottom_sizable = !value;
	}
	else if (name == "is_left_sizable")
		outer.is_left_sizable = value;
	else if (name == "is_top_sizable")		
		outer.is_top_sizable = value;
	else if (name == "is_right_sizable")		
		outer.is_right_sizable = value;
	else if (name == "is_bottom_sizable")		
		outer.is_bottom_sizable = value;
	else if (name == "is_always_on_top")
	{
		outer.is_always_on_top = value;
		inner.is_always_on_top = value;
	}
	else if (name == "is_movable")		
		outer.is_movable = value;
	else if (name == "is_floatable")		
		outer.is_floatable = value;
	else if (name == "is_dockable")		
		outer.is_dockable = value;
	else if (name == "is_tabbable")		
		outer.is_tabbable = value;
	else if (name == "is_stickable")		
		outer.is_stickable = value;

	else if (name == "can_have_drops")		
		outer.can_have_drops = value;
	else if (name == "can_have_docks")		
		outer.can_have_docks = value;
	else if (name == "can_have_floats")		
		outer.can_have_floats = value;
	else if (name == "can_have_sticks")		
		outer.can_have_sticks = value;
	else if (name == "can_have_tabs")		
		outer.can_have_tabs = value;

	else if (name == "min_section_width")
	{
		inner.min_section_width = value;
		outer.min_section_width = value;
	}
	else if (name == "min_section_height")
	{
		inner.min_section_height = value;
		outer.min_section_height = value;
	}
	else if (name == "bar_thickness")
	{
		inner.bar_thickness = value;
		outer.bar_thickness = value;
	}	
}

// ===================================================
// TODO: Support the following in the section
/*
	this.type = "abstract";     // outer, inner, 
	this.object_type = "none";  // sections-container, section, sub-section, static-composed, script-composed, server-composed, composite, elementary
	this.real_type = "none";	// root, section, sub-section, border, bar, tab, paw, text, image, progress-bar, slider, button, etc..

	this.parent_section = null;
	this.child_sections = new Array();
	this.composer = null;
	this.handle = null;
	
	this.is_slidable = false;
	
	this.children_layout_style = "none"; // tells how the children are displayed, 
										 // could be none (no instruction for children), static, tile, cascade
	this.on_inner_overflow = "none"; // none, hide, fit, resize, scroll_bars, scroll_arrows, reflow, resize_height, resize_width 
	this.on_outer_overflow = "none"; // none, repos_left, repos_top
*/
