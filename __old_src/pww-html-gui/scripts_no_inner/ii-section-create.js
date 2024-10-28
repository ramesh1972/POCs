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
	this.section_type = "none";     // future reserved
	this.real_type = "none";	    // root, section, sub-section, border, bar, tab, paw, text, image, progress-bar, slider, button, etc..
	this.serialize = false;

	// making the section tree
	this.parent_section = null;
	this.child_sections = new Array();
	
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
function create_abstract_section(parent_section, id, section_type) // dunit
{
    var section = new CSection();
    section.id = id;
	section.section_type = section_type;
	
    // ******** THis is the native html element
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

function create_section(parent_section, id, x, y, w, h, pos_type) // dunit
{
	// reset is_sized
	reset_section_is_sized(groot_container, false, true);

	if (parent_section == null)
		parent_section = groot_container;
	
	// create the section
	var section = create_abstract_section(parent_section, id, "none");
	section.position_type = pos_type;
	
	// for certain position types of sections, the x and y are computed on the fly
	if (pos_type == "stack" || pos_type == "stick" || pos_type == "dock")
	{
		x = 0;
		y = 0;
	}

    // set the dimensions
	set_section_dimension(section, x, y, w, h);
	
	return section; 
}

function create_section_iframe(section, src) // dunit
{
	if (section == null)
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
function set_abstract_default_style(section) // dunit
{
	sss(section, "backgroundColor","yellow");
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

function set_iframe_default_styles(section) // dunit
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

// =================================
// get functions
function get_parent(section) // dunit
{
	if (section == null)
		return null;
		
	return section.parent_section;
}

function is_root(section) // dunit
{
	if (section != null && section.real_type == "root")
		return true;
	
	return false;
}

function is_section_in_child_tree(section, tree_start_section) // dunit
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
function create_root_container() // dunit
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
function contain_root_container(id, side) //dunit
{
	var arr = new Array();
		
	// remove all the children of the root and save them in an arrya
	var child = groot_container.child_sections[0];
	var idx = 0;
	var pos = 0;
	while (child != null)
	{
    	arr[idx++] = child;
	    remove_child_section(child);

		child = groot_container.child_sections[pos];
	}
				 
	// create a new container under the root and add the original children to this container
	var container = create_section(groot_container, id, 0, 0, groot_container.width, groot_container.height, "dock");

	// move all the children of the root container to this container.
	for (idx =0; idx < arr.length; idx++)
	{
		var child = arr[idx];
		set_section_parent(child, container);
	}
	container.border_thickness = groot_container.border_thickness;
	container.dock_position = side;
	delete arr;

	return container;
}

function contain_section(section, id) // dunit
{
	if (is_root(section))
		return contain_root_container(id);
		
	// detach the parent_section from its parent
	var pos = array_remove_element(section.parent_section.child_sections, section);
	g_remove_child(section.handle);
	
	// create a new container for the parent section
	var pcontainer = create_section(section.parent_section, id, 0, 0, section.width, section.height, section.position_type);
		
	// move the parent section under the pcontainer
	set_section_parent(section, pcontainer);
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
	if (position_type == "popout")
	{
		var window = create_and_add_popout_section(id, x, y, w, h, "", src);
		return window;
	}
		
	// create the id
	var parent = parent_section;
	if (parent == null)
		parent = groot_container;
				
	if (!is_root(parent) && position_type != "tab")
		parent.real_type = "container";
	
	if (position_type == "float" || position_type == "stack" || position_type == "static")
	{
		parent.is_visible = true;
		add_property(parent, "is_visible", true);
	}
	
	if (position_type == "dock" || position_type == "tab" || position_type == "stick" || position_type == "stack")
		x = y = 0;
		
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
	    section.handle.innerHTML = src;

	section.serialize = true;
	return section;	// .tab_container on the section, will give the ref to the tab container
}

function add_property(section, name, value)
{
	if (section == null)
		return;
	
	var tabc = get_tab_container(section);
	
	if (name == "real_type")
		section.real_type = value;
	else if (name == "dock_position")
		section.dock_position = value;
	else if (name == "stick_left")
		section.stick_left = value;
	else if (name == "stick_top")
		section.stick_top = value;
	else if (name == "stick_bottom")
		section.stick_bottom = value;
	else if (name == "stick_right")
		section.stick_right = value;

	else if (name == "bar")
	{
		var bar = create_section_bar(section, value);
		return bar;
	}
    else if (name == "url")
		create_section_iframe(section, value);

	else if (name == "is_visible")
		section.is_visible = value;

	else if (name == "is_sized")
		section.is_sized = value;

	else if (name == "border_thickness")
		section.border_thickness = value;

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
		section.is_sizable = value;
	else if (name == "is_fixed_width")
	{
		section.is_fixed_width = value;
		section.is_left_sizable = !value;
		section.is_right_sizable = !value;
	}
	else if (name == "is_fixed_height")
	{
		section.is_fixed_height = value;
		section.is_top_sizable = !value;
		section.is_bottom_sizable = !value;
	}
	else if (name == "is_left_sizable")
		section.is_left_sizable = value;
	else if (name == "is_top_sizable")		
		section.is_top_sizable = value;
	else if (name == "is_right_sizable")		
		section.is_right_sizable = value;
	else if (name == "is_bottom_sizable")		
		section.is_bottom_sizable = value;
	else if (name == "is_always_on_top")
		section.is_always_on_top = value;
	else if (name == "is_movable")		
		section.is_movable = value;
	else if (name == "is_floatable")		
		section.is_floatable = value;
	else if (name == "is_dockable")		
		section.is_dockable = value;
	else if (name == "is_tabbable")		
		section.is_tabbable = value;
	else if (name == "is_stickable")		
		section.is_stickable = value;

	else if (name == "can_have_drops")		
		section.can_have_drops = value;
	else if (name == "can_have_docks")		
		section.can_have_docks = value;
	else if (name == "can_have_floats")		
		section.can_have_floats = value;
	else if (name == "can_have_sticks")		
		section.can_have_sticks = value;
	else if (name == "can_have_tabs")		
		section.can_have_tabs = value;

	else if (name == "min_section_width")
		section.min_section_width = value;
	else if (name == "min_section_height")
		section.min_section_height = value;
	else if (name == "bar_thickness")
		section.bar_thickness = value;
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