function CBorder()
{
	this.base = null;	// section object, for back reference
	this.image_handle = null;

	this.position = ""; //left, right etc.
	this.can_merge = true;
	this.owner_section = null;
}

function create_border_section(section, pos)
{
	if (section == null || section.is_sizable == false)
		return null;
		
	// borders are added not added to borders, unless everything is on the edge !&*%
	if (is_border(section))
		return null;
		
	// The topmost section has no parent section. It has no borders as well.
	if (is_root(section))
		return null;
		
	if (is_inner(section))
		return;
		
	// create the section for the border
	var id = "border_" + pos + "_" + section.id;
	var bsection = create_abstract_section(section.parent_section, id, "outer");

	// create the border object and reference forward
	var border = new CBorder();
	border.base = bsection;
	border.base.real_type = "border";
	border.base.derived_object_ref = border;
	border.owner_section = section;
	border.position = pos;
							
	// create and put the image in the document
	var oimg = g_create_image("g_image_" + id, "images/border_red.gif");
	border.image_handle = oimg;
	g_append_child(border.base.handle, border.image_handle);
	g_ss(oimg, "position", "absolute");
		
	// set sizing handlers	
	oimg.onmouseover = border_mouseover;  
	oimg.ondragstart = border_dragstart;
	oimg.ondrag = border_drag;
	oimg.ondragend = border_dragend;

	set_border_default_style(border);
	return border;
}

function set_border_default_style(border)
{
	if (border == null || !is_border(border.base))
		return;
		
	// override
	sss(border.base, "overflow", "hidden");
	sss(border.base, "borderWidth", ".01cm");
	sss(border.base, "borderStyle", "none");
	sss(border.base, "borderColor", "white");
	
	// styles for the image
	var oimg = border.image_handle;
	
	oimg.border = 0;
	g_ss(oimg, "marginLeft", 0);
	g_ss(oimg, "paddingLeft", 0);
	g_ss(oimg, "marginTop", 0);	
	g_ss(oimg, "paddingTop", 0);
	g_ss(oimg, "marginBottom", 0);	
	g_ss(oimg, "paddingBottom", 0);
	g_ss(oimg, "marginRight", 0);	
	g_ss(oimg, "paddingRight", 0);
}

function set_border_dimension(border, x, y, w, h)
{
	if (border == null || !is_border(border.base))
		return;
		
	set_section_dimension(border.base, x, y, w, h);
}

function is_border(border)
{
	if (border != null && border.real_type == "border")
		return true;
}

// ================================================================================
function set_section_borders(section)
{
	// TODO: support fixed_width/fixed_height flag, support siblings is_sizable flag.
	
	// main criteria. Only outer sections have borders
	if (section == null || !is_outer(section) || is_root(section))
		return;
	
	// no sense in adding a border to a border
	if (is_border(section))
		return;
	
	// no sense adding a border if the section is invisible
	if (!section.is_visible)
		return;
		
	// if the section is not sizable then it has no borders
	if (!section.is_sizable)
		return;

	var bt = gpo(section).border_thickness;
		
	// create the borders based on position type
	var x = gsl(section);
	var y = gst(section);
	var w = gsw(section);
	var h = gsh(section);

	var redim_children = false;
	
	// destroy the existing borders
	destroy_section_borders(section);

	var show_left = section.is_left_sizable;
	var show_right = section.is_right_sizable;
	var show_top = section.is_top_sizable;
	var show_bottom = section.is_bottom_sizable;
	
	// get the surrounding sections and check if they are sizable
	var lsss = new Array();
	var rsss = new Array();
	var tsss = new Array();
	var bsss = new Array();

	get_pre_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
	for (var idx=0; idx<lsss.length;idx++)
	{
		if (!lsss[idx].is_sizable || !lsss[idx].is_right_sizable)
		{
			show_left = false;
			break;
		}
	}

	for (idx=0; idx<rsss.length;idx++)
	{
		if (!rsss[idx].is_sizable || !rsss[idx].is_left_sizable)
		{
			show_right = false;
			break;
		}
	}

	for (idx=0; idx<tsss.length;idx++)
	{
		if (!tsss[idx].is_sizable || !tsss[idx].is_bottom_sizable)
		{
			show_top = false;
			break;
		}
	}

	for (idx=0; idx<bsss.length;idx++)
	{
		if (!bsss[idx].is_sizable || !bsss[idx].is_top_sizable)
		{
			show_bottom = false;
			break;
		}
	}
	
	// create borders that are shared between sections
	if (section.position_type == "dock" || section.position_type == "stack")
	{
		// bbottom
		if (show_bottom && y + h < gsh(section.parent_section))
		{
			section.height-=bt;
			section.border_bottom = create_border_section(section, "bottom");
			set_border_dimension(section.border_bottom, section.left, section.top+section.height, section.width, bt);
			redim_children = true;
		}

		// btop
		if (show_top && y > 1)
		{
			section.border_top = create_border_section(section, "top");
			set_border_dimension(section.border_top, section.left, section.top-bt, section.width, bt);		
		}
	
		// bleft
		if (show_left && x > 1)
		{
			section.border_left = create_border_section(section, "left");
			set_border_dimension(section.border_left, section.left-bt, section.top, bt, section.height);
		}

		// bright
		if (show_right && x + w < gsw(section.parent_section))
		{
			section.width-=bt;
			section.border_right = create_border_section(section, "right");
			set_border_dimension(section.border_right, section.left+section.width, section.top, bt, section.height);
			redim_children = true;
		}
	}
	
	// create borders that are not shared between sections
	else if (section.position_type == "float" || section.position_type == "stick" || section.position_type == "popin")
	{
		// bbottom
		if (show_bottom)
		{
			section.border_bottom = create_border_section(section, "bottom");
			set_border_dimension(section.border_bottom, section.left, section.top+section.height, section.width, bt);
		}

		// btop
		if (show_top)
		{
			section.border_top = create_border_section(section, "top");
			set_border_dimension(section.border_top, section.left, section.top-bt, section.width, bt);		
		}
			
		// bleft
		if (show_left)
		{
			section.border_left = create_border_section(section, "left");
			set_border_dimension(section.border_left, section.left-bt, section.top-bt, bt, section.height+2*bt);
		}
		
		// bright
		if (show_right)
		{
			section.border_right = create_border_section(section, "right");
			set_border_dimension(section.border_right, section.left+section.width, section.top - bt, bt, section.height + 2*bt);
		}
	}
	
	if (redim_children)
		set_section_tree_children_dimensions(section, true);
}

// ================================================================================
function layout_section_borders(section)
{
	// layout the borders for the section
	layout_border(section, section.border_left);
	layout_border(section, section.border_top);
	layout_border(section, section.border_right);
	layout_border(section, section.border_bottom);		
}

function layout_border(section, border)
{
	if (border == null || !is_border(border.base))
		return;

	if (border.base.handle == null || border.image_handle == null)
		return;
		
	// layout the section for the border
	layout_section_position_and_size(border.base);

	// set the image up
	var oimg = border.image_handle;
	g_set_dimensions(oimg, 0, 0, g_goaw(border.base.handle), g_goah(border.base.handle));
	g_ss(oimg, "visibility", "visible");
}

// ================================================================================
function show_border(border)
{
	show_section(border.base);
	g_show_element(border.image_handle);
}

function hide_border(border)
{
	hide_section(border.base);
	g_hide_element(border.image_handle);
}

function destroy_border(border)
{
	if (border == null || border.base == null || border.base.handle == null)
		return;
	
	if (border.image_handle != null)
	{
		hide_border(border);
		g_remove_child(border.image_handle);
		border.image_handle = null;
		
		destroy_section(border.base);
	}
	
	border.base = null;
	border = null;
}

function destroy_section_borders(section)
{
	destroy_border(section.border_left);
	destroy_border(section.border_right);
	destroy_border(section.border_bottom);
	destroy_border(section.border_top);
	
	section.border_left = null;
	section.border_right = null;
	section.border_bottom = null;
	section.border_top = null;
}

function hide_all_borders(section)
{
	if (section == null)
		return;
	
	for (var idx=0; idx< section.child_sections.length;idx++)
	{
		var b = section.child_sections[idx];
		if (is_border(b) && b.handle != null)
			hide_border(b.derived_object_ref);
		else
			hide_all_borders(b);
	}
}

function undo_section_border_dimensions(section, deep)
{
	if (section == null)
		return;
	
	// only sections of these 2 position types share the border, so the dims have to be undone only in these cases
	if (is_outer(section) && section.is_sizable && (section.position_type == "dock" || section.position_type == "stack"))
	{
		var bt = gpo(section).border_thickness;
		if (section.border_right != null)
			section.width += bt;

		if (section.border_bottom != null)
			section.height += bt;
	}
		
	if (deep)
	{
		for (var idx = 0; idx < section.child_sections.length;idx++)
			undo_section_border_dimensions(section.child_sections[idx], true);
	}
}

// =============================================================
function remove_overlapped_borders(container)
{
	if (container == null)
		return;
	
	// for each border check against every border. 
	// if it is contained within a bigger border, then remove it (hide it)
	for (var idx=0; idx < container.child_sections.length; idx++)
	{
		var sborder = container.child_sections[idx];
		if (!is_border(sborder))
			continue;
		
		if (sborder.derived_object_ref == null)
			continue;
			
		var border = sborder.derived_object_ref;
		if (border.base == null)
			continue;

		if (border.owner_section == null) 
			continue;
			
		if (border.owner_section.position_type != "dock" && border.owner_section.position_type != "stack")
			continue;
			
		if (!g_is_visible(border.base.handle))
			continue;

		var bt = gpo(border.base).border_thickness;
		for (var idx1=0; idx1 < container.child_sections.length; idx1++)
		{
			if (idx == idx1)
				continue;

			var sborder1 = container.child_sections[idx1];
			if (!is_border(sborder1))
				continue;
			
			if (sborder1.derived_object_ref == null)
				continue;
				
			var border1 = sborder1.derived_object_ref;
			if (border1.base == null)
				continue;
				
			if (border1.owner_section == null) 
				continue;
				
			if (border1.owner_section.position_type != "dock" && border1.owner_section.position_type != "stack")
				continue;

			if (!g_is_visible(border1.base.handle))
				continue;

			var bt1 = gpo(border1.base).border_thickness;
			if (border.base.left == border1.base.left)
			{
				if (border.base.top == border1.base.top+border1.base.height + bt1)
				{
					hide_border(border1);
					show_border(border);

					border.base.top = border1.base.top;
					border.base.height += border1.base.height;
					
					equalize_border_dimension(border1, border);
					layout_border(border.owner_section, border);
					break;
				}

				if (border1.base.top == border.base.top+border.base.height + bt)
				{
					hide_border(border);
					show_border(border1);

					border1.base.top = border.base.top;
					border1.base.height += border.base.height;
					
					equalize_border_dimension(border, border1);
					layout_border(border1.owner_section, border1);
					break;
				}
			}
				
			if (border.base.top == border1.base.top)
			{
				if (border.base.left == border1.base.left+border1.base.width + bt1 ||
					border.base.left == border1.base.left+border1.base.width)
				{
					hide_border(border1);
					show_border(border);

					border.base.left = border1.base.left;
					border.base.width += border1.base.width;
					
					equalize_border_dimension(border1, border);
					layout_border(border.owner_section, border);
					break;
				}

				if (border1.base.left == border.base.left+border.base.width + bt || 
					border1.base.left == border.base.left+border.base.width)
				{
					hide_border(border);
					show_border(border1);

					border1.base.left = border.base.left;
					border1.base.width += border.base.width;
					
					equalize_border_dimension(border, border1);
					layout_border(border1.owner_section, border1);
					break;
				}
			}

			// vertical
			if ((border.position == "left" || border.position == "right") && (border1.position == "left" || border1.position == "right"))
			{
				if (border.base.left == border1.base.left)
				{
					if (border1.base.top <= border.base.top && border1.base.top+border1.base.height >= border.base.top+border.base.height)
					{
						hide_border(border);
						show_border(border1);
						
						equalize_border_dimension(border, border1);

						break;
					}
					else if (border.base.top <= border1.base.top && border.base.top+border.base.height >= border1.base.top+border1.base.height)
					{
						hide_border(border1);
						show_border(border);
						
						equalize_border_dimension(border1, border);
						break;
					}
				}
			}

			if ((border.position == "top" || border.position == "bottom") && ( border1.position == "top" || border1.position == "bottom"))
			{
				if (border.base.top == border1.base.top)
				{
					if (border1.base.left >= border.base.left && border1.base.left+border1.base.width <= border.base.left+border.base.width)
					{
						hide_border(border1);
						show_border(border);
						
						equalize_border_dimension(border1, border);						
						break;
					}
					else if (border.base.left >= border1.base.left && border.base.left+border.base.width <= border1.base.left+border1.base.width)
					{
						hide_border(border);
						show_border(border1);

						equalize_border_dimension(border, border1);
						break;
					}
				}
			}
		}
	}
	
	for (idx=0; idx < container.child_sections.length; idx++)
		remove_overlapped_borders(container.child_sections[idx]);
}

function equalize_border_dimension(border, equal_to_border)
{
	border.base.left = equal_to_border.base.left;
	border.base.top = equal_to_border.base.top;
	border.base.width = equal_to_border.base.width;
	border.base.height = equal_to_border.base.height;
}

// ================================================================================
function get_border_from_event(evnt)
{
	if (evnt.srcElement == null)
		return null;
		
	if (evnt.srcElement.tagName != "IMG")
		return null;

	var obj = evnt.srcElement;

	// check if this is a sizing image
	if (obj.id.match("g_image_border_") < 0)
		return null;
			
	var id = "section_outer_" + obj.id.substring(8);
		
	var border = get_section_from_id(groot_container, id, "outer", "border");
	return border;
}

