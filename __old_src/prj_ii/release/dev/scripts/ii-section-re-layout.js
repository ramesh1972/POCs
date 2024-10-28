function resize_page()
{
	groot_container.is_sized = false;
	gi(groot_container).is_sized = false;
	gco(groot_container).is_sized = false;
	gci(groot_container).is_sized = false;
	
	check_set_and_show_section_tree(groot_container, true);
}

// functions for sizing using borders
function border_mouseover()
{
	if (gresizing)
		return;
	
	var border = get_border_from_event(window.event);			
	if (border == null)
		return;
	
	if (border.handle == null)
		return;
			
	if (border.derived_object_ref == null)
		return;
		
	if (border.derived_object_ref.position == "left" || border.derived_object_ref.position == "right") // horz
		sss(border, "cursor", "col-resize");	
	else
		sss(border, "cursor", "row-resize");	
}

function border_dragstart()
{
	if (gresizing)
		return;

	gresizing = true;		
	var border = get_border_from_event(window.event);			
	if (border == null)
		return;

	var obj = border.handle;
	if (obj == null)
		return;

	gsizing_border_object = border;

	// convert event.x and event.y to section coordinates
	var section = gsizing_border_object.parent_section;
	var sx = gsl_s(section);
	var sy = gst_s(section);
	
	var ex = window.event.x - sx;
	var ey = window.event.y - sy;

	gstartex = window.event.x;
	gstartey = window.event.y;
	
	gstartx = ex;
	gstarty = ey;
	
	set_section_max_zindex(border);
}

function border_drag()
{
	if (gsizing_border_object == null)
	{
		gresizing = false;
		return;
	}

	var b = gsizing_border_object;
			
	// convert event.x and event.y to section coordinates
	var section = b.parent_section;
	var sx = gsl_s(section);
	var sy = gst_s(section);
	
	var ex = window.event.x - sx;
	var ey = window.event.y - sy;
	
	if (b.derived_object_ref.position == "left" || b.derived_object_ref.position == "right")
		ssal(b, ex);
	else
		ssat(b, ey);

	// TODO: To set the cursor
	set_section_max_zindex(b);
}

function border_dragend()
{
	if (gsizing_border_object == null)
	{
		gresizing = false;
		return;
	}

	// compute the relative mouse pointer, convert event.x and event.y to section coordinates
	var sectiono = gsizing_border_object.derived_object_ref.owner_section;
	var sectionp = gsizing_border_object.parent_section;
	var sx = gsl_s(sectionp);
	var sy = gst_s(sectionp);
	
	var ex = window.event.x - sx;
	var ey = window.event.y - sy;
	
	var rel_mousex = ex;
	var rel_mousey = ey;

	// store the original dims of the border
	var ol = gsizing_border_object.left;
	var ot = gsizing_border_object.top;
	var ow = gsizing_border_object.width;
	var oh = gsizing_border_object.height;
	
	var bt = sectionp.border_thickness;
	
	var right_section_exists = false;
	var left_section_exists = false;
	var top_section_exists = false;
	var bottom_section_exists = false;
	var found = false;

	// for the current border, get all the sections that are related.
	//	- go through the array of sections, check the border objects and create an array of sections
	if (sectionp.position_type == "dock" || sectionp.position_type == "stack")
	{
		for (var idx=0;idx<sectionp.child_sections.length;idx++)
		{
			// for each section in the array of sections check if the border is part of it based on the horz/vert sizig
			var section = sectionp.child_sections[idx];
			if (section.position_type != "dock") 
				continue;

			if (is_center(section))
				continue;
				
			if (!is_outer(section))
				continue;
				
			if (is_border(section) || is_bar(section))
				continue;
					
			right_section_exists = false;
			left_section_exists = false;
			top_section_exists = false;
			bottom_section_exists = false;
				
			// if this is an horizontal move then size the sections on either side of the border image
			if (gsizing_border_object.derived_object_ref.position == "left" || gsizing_border_object.derived_object_ref.position == "right")
			{
				// check if the section should participate in the sizing
				if (gsal(section) == ol + ow &&
					gsat(section) >= ot &&
					gsab(section) <= ot + oh)
				{
					right_section_exists = true;
						
				}
				else if (gsar(section) == ol &&
						 gsat(section) >= ot &&
						 gsab(section) <= ot + oh + bt)
				{
					left_section_exists = true;
				}

				// if this is a move to the right
				if (rel_mousex > gstartx) // if moving right
				{
					// if the section is on the left side of the border image, increase width
					if (left_section_exists)
					{
						section.width = rel_mousex-section.left;
					}

					// if the section is on the right side of the border image, move left pos 				
					else if (right_section_exists)
					{
						section.width -= rel_mousex-section.left;
						section.left = rel_mousex;
					}
				}
				//	if this is a move to the left
				else if (rel_mousex < gstartx)
				{
					// if the section is on the left side of the border image, descrese width
					if (left_section_exists)
					{
						section.width = rel_mousex-section.left;
					}
							
					// if the section is on the right side of the border image, change left pos and increase width
					else if (right_section_exists)
					{
						section.width+= section.left-rel_mousex;
						section.left = rel_mousex;
					}
				}
				// else do nothing
			}
				
			// if this is an vertical move then size the sections on either side of the border image
			else
			{
				// check if the section should participate in the sizing
					
				if (gsat(section) == ot + oh &&
					gsal(section) >= ol &&
					gsar(section) <= ol + ow)
				{
					bottom_section_exists = true;
				}
				else if (gsab(section) == ot &&
						 gsal(section) >= ol &&
						 gsar(section) <= ol + ow)
				{
					top_section_exists = true;
				}
					
				// if this is a move to the bottom
				if (rel_mousey > gstarty)
				{
					// if the section is on the top side of the border image, increase height
					if (top_section_exists)
					{
						section.height = rel_mousey - section.top;
					}
					// if the section is on the bottom side of the border image, decrease height
					else if (bottom_section_exists)
					{
						section.height -= rel_mousey-section.top;
						section.top = rel_mousey;
					}
				}
				// if this is a move to the top
				else if (rel_mousey < gstarty)
				{
					// if the section is on the top side of the border image, decrease height
					if (top_section_exists)
					{
						section.height = rel_mousey-section.top;
					}
					//	if the section is on the bottom side of the border image, increase height
					else if (bottom_section_exists)
					{	
						section.height += section.top - rel_mousey;
						section.top = rel_mousey;
					}
				}
				// else do nothing
			}

			if (top_section_exists || left_section_exists || bottom_section_exists || right_section_exists)
			{
				reset_limit_check(groot_container);
				set_section_limits_and_adjust_surroundings(section);
						
				set_section_oi_original_dimension(section, section.width, section.height);				
				add_property(section, "is_sized", true);
				add_property(gpo(section), "is_sized", true);
				
				set_section_max_zindex(section);
				found = true;
				break;
			}
		}
	}
		
	if (!found)
	{
		var ex = window.event.x;
		var ey = window.event.y;
	
		// get the edge that is being sized
		// if left/top edges
		if (sectiono.border_left != null && sectiono.border_left.base.id == gsizing_border_object.id)
		{
			sectiono.left += (ex-gstartex);
			sectiono.width -= (ex-gstartex);
		}
		else if (sectiono.border_right != null && sectiono.border_right.base.id == gsizing_border_object.id)
		{
			sectiono.width += (ex-gstartex);
		}
		else if (sectiono.border_top != null && sectiono.border_top.base.id == gsizing_border_object.id)
		{
			sectiono.top += (ey-gstartey);
			sectiono.height -= (ey-gstartey);
		}
		else if (sectiono.border_bottom != null && sectiono.border_bottom.base.id == gsizing_border_object.id)
		{
			sectiono.height += (ey-gstartey);
		}
		
		set_section_limits(sectiono);
		set_section_oi_original_dimension(sectiono, sectiono.width, sectiono.height);
		add_property(sectiono, "is_sized", true);

		set_section_max_zindex(sectiono);
	}

	sss(gsizing_border_object, "cursor", "default");
	sss(g_groot(), "cursor", "default");		
	
	// complete sizing
	gresizing = false;
	gsizing_border_object = null;
	gstartx = 0;
	gstarty = 0;

	check_set_and_show_section_tree(groot_container, true);
}

// ==============================================================
// drag and dock sections
function bar_mouseclick()
{
	var src = window.event.srcElement;
	var id = src.id;
	
	// may be it is in the title
	var bar = get_bar_from_id(id);	
	if (bar == null)
	{
		bar = get_bar_from_id(src.parentNode.id);	
			
		if (bar == null)
		{
			gdocking_mousedown = false
			return;
		}
	}
	
	set_section_max_zindex(gpo(bar));
}

function bar_mouseover()
{
	if (gdragdocking)
		return;
		
	window.event.srcElement.style.cursor = "move";	
}

function bar_mousedown()
{
	if (gdragdocking)
		return;

	gdocking_mousedown = true;
}

function bar_mouseup()
{
	sss(gdragdock_org_section, "cursor", "default");
	sss(g_groot(), "cursor", "default");		
	window.event.srcElement.style.cursor = "default";	
	
	gdocking_mousedown = false;
	gdragdock_org_section = null;
	
	if (gdragdock_clone_handle != null)
		g_remove_child(gdragdock_clone_handle);
	
	gdragdock_clone_handle = null;
	gdragdocking = false;
	
	destroy_dock_paws();
}

function bar_mousemove()
{
	if (gdragdocking)
		return;

	if (gdocking_mousedown)
	{
		// get the section object, which is the cover section and create a clone
		var src = window.event.srcElement;
		var id = src.id;
		
		// may be it is in the title
		var bar = get_bar_from_id(id);	
		if (bar == null)
		{
			bar = get_bar_from_id(src.parentNode.id);	
			
			if (bar == null)
			{
				gdocking_mousedown = false
				return;
			}
		}
			
		clone_dragdock_section(bar.parent_section);
		gdragdocking = true;
	}
}


function clone_dragdock_section(src_section)
{
	// set dragdock global variables, set in dragdockmode flag
	gdragdock_org_section = src_section; // This is always the outer section
	if (gi(gdragdock_org_section).frame_handle == null)
		gdragdock_clone_handle = g_clone(gdragdock_org_section.handle, false);
	else
		gdragdock_clone_handle = g_clone(gdragdock_org_section.handle, false);

	// gray out the actual section, to indicate it is being dragged
	ssf(gdragdock_org_section, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=1, xray=0, mirror=0, invert=0, opacity=0.5, rotation=0);");
	
	// get the absolute left, top of the section relative to the browser
	// add the cloned object to the browser at the original position 
	g_append_child(g_groot(), gdragdock_clone_handle);

	g_sf(gdragdock_clone_handle, "position",  "absolute");
	var x = gsl_s(gdragdock_org_section);
	var y = gst_s(gdragdock_org_section);
	g_set_dimensions(gdragdock_clone_handle, x, y, gsw(gdragdock_org_section), gsh(gdragdock_org_section));

	gdragdock_clone_handle.onmousemove = dragdock_clone_section_drag;
	gdragdock_clone_handle.onmouseup = dragdock_clone_section_dragend;
}

function dragdock_clone_section_drag()
{
	document.selection.clear();
	if (!gdragdocking)
		return;
		
	// based on the mouse coordinates move the clone
	g_set_dimensions(gdragdock_clone_handle, window.event.x - gdragdock_org_section.width/2, 
											 window.event.y - 10,
											 gsw(gdragdock_org_section),
											 gsh(gdragdock_org_section));

	g_sf(gdragdock_clone_handle,  "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=.4, rotation=0);");	
	window.event.srcElement.style.cursor = "move";	
}
		
function body_mousemove()
{
	if (gdragdocking)
	{
		dragdock_clone_section_drag();

		// if section is a tab then return
		if (is_tab(gdragdock_org_section))
			return;
			
		// if the mouse pointer is on  a dock paw, then simply return so that the user can move around the dock paws 
		// freely without it getting destroyed
		var paw = get_section_of_type_at_xy(groot_container, "paw", window.event.x, window.event.y);
		if (paw != null)
			return;
	
		// get the deepest child section at the mouse pointer. The return is a reference to the outer section
		var section = get_section_at_xy(groot_container, window.event.x, window.event.y);
		if (section != null && section.id == gdragdock_org_section.id)
		{
			destroy_dock_paws();
			return;
		}
			
		if (is_outer(section))
		{
			if (!is_bar(section) && !is_border(section) && !is_paw(section) && !is_tab(section))
				gdrop_in_section = section;
				
			if (is_center(section) && 
				gpo(section) != null && 
				is_tab_bar(gpo(section)))
				gdrop_in_section = gpo(section);
				
			if (is_tab(section))
				gdrop_in_section = section.tab_bar;
		}
					
					
		if (!is_center(gdrop_in_section))
			show_dock_paws();		
	} 
}

function dragdock_clone_section_dragend()
{
	if (gdragdocking)
	{
		var dropped = do_section_dragdrop_positioning();
		if (dropped)
		{
			set_section_max_zindex(gdragdock_org_section);
			check_set_and_show_section_tree(groot_container, true);
		}
	}
					
	do_cancel_section_dragdrop_positioning();
}

function do_cancel_section_dragdrop_positioning()
{
	destroy_dock_paws();
	
	sss(gdragdock_org_section, "cursor", "default");
	sss(g_groot(), "cursor", "default");		
	window.event.srcElement.style.cursor = "default";	

	ssf(gdragdock_org_section, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0);");
	if (gdragdock_clone_handle != null)
		g_remove_child(gdragdock_clone_handle);
	
	gdragdock_clone_handle = null;
	gdragdock_org_section = null;
	gdragdocking = false;
	gdocking_mousedown  = false;
	gdrop_in_section = null;
}

function do_section_dragdrop_positioning()
{
	if (!gdragdocking)
		return;

	// flag the successful drop
	var dropped = false;
	
	if (gdrop_in_section == null)
		return;
		
	if (go(gdragdock_org_section).id == go(gdrop_in_section).id)
		return false;
		
	// check and get if there is a paw on which the drag/drop has happened
	var paw = get_section_of_type_at_xy(groot_container, "paw", window.event.x, window.event.y);

	// for no paw drag/drops, that is basically a float
	if (paw == null)
	{
		// you cannot float parent in child
		if (is_section_in_child_tree(gdrop_in_section, gdragdock_org_section))
			return false;

		if (!is_tab(gdragdock_org_section) && !is_tab(gdrop_in_section) && !is_tab_bar(gdrop_in_section))
			return float_section(gdragdock_org_section, gdrop_in_section, window.event.x, window.event.y);
		else if (is_tab(gdragdock_org_section))
		{
			var tab = get_section_at_xy(groot_container, window.event.x, window.event.y);
			change_tab_position(gdragdock_org_section, tab);
			dropped = true;
		}
	}
	else 
	{			
		// remove dock paws
		destroy_dock_paws();

		// determine the side to which the docking is happening
		var new_dock_pos = paw.dock_position;

		if (paw.paw_type == "tab_bar" && paw.dock_to_section.id == gdragdock_org_section.tab_container.id)
		{	
			// dock appropriately
			dock_tab_bar(gdragdock_org_section, new_dock_pos);
			return true;
		}
	
		// if the whole set of tabbed sections are being dragged, then put the approp, drag reference, which is the tab_container
		if (is_tab_bar(gdragdock_org_section))
		{
			ssf(gdragdock_org_section, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0);");
			gdragdock_org_section = gdragdock_org_section.tab_container;
			if (paw.paw_type == "tab_bar")
				paw.paw_type = "section";
		}

		if (!remove_tab(gdragdock_org_section)) 
			remove_child_section(gdragdock_org_section);  // detach the drag item from its parent
	
		if (paw.paw_type == "tab" && is_root(paw.dock_to_section))
		{
			//alert("drop1");
			add_tab_for_root_container(gdragdock_org_section, new_dock_pos);
			dropped = true;
		}
		else if (paw.paw_type == "tab" && is_tab_bar(paw.dock_to_section))
		{
			//alert("drop2");
			add_new_tab(gdragdock_org_section, paw.dock_to_section); 
			dropped = true;
		}
		else if (paw.paw_type == "tab" && paw.dock_to_section.tab_container == null)
		{
			//alert("drop3");
			add_tab_in_untabbed_section(gdragdock_org_section, paw.dock_to_section, new_dock_pos); 
			dropped = true;
		}
		else if (paw.paw_type == "tab" && paw.dock_to_section.tab_container != null)
		{
			//alert("drop4");
			add_tab_in_tabbed_section(gdragdock_org_section, paw.dock_to_section, new_dock_pos); 
			dropped = true;
		}
		else if (paw.paw_type == "section" && is_root(paw.dock_to_section))
		{
			alert("drop5");
			var container = dock_to_root_container(gdragdock_org_section, new_dock_pos);
			set_section_max_zindex(container);
			dropped = true;
		}
		else if (paw.paw_type == "section")
		{
			//alert("drop6");
			var container = dock_to_section(paw.dock_to_section, gdragdock_org_section, new_dock_pos);
			set_section_max_zindex(container);
			dropped = true;
		}
		else if (paw.paw_type == "stick")
		{
			var sticky = stick_to_section(paw.dock_to_section, gdragdock_org_section, new_dock_pos);
			set_section_max_zindex(sticky);
			dropped = true;
		}
	}
	
	return dropped;
}

// ===================================================
// for tabs
function tab_mouseover()
{
	window.event.srcElement.style.cursor = "move";	
}

function tab_mouseout()
{
	window.event.srcElement.style.cursor = "default";	
}

function tab_mousemove()
{
	if (gdragdocking)
		return;

	if (gdocking_mousedown)
	{
		document.selection.clear();
		// get the section object, which is the cover section and create a clone
		var src = window.event.srcElement;
		var id = src.id;
		
		var bid = id.substr(2);
		var section = get_section_from_id(groot_container, bid);
		
		if (section == null)
		{
			bid = id.substr(9);
			section = get_section_from_id(groot_container, bid);
			
			if (section == null)
			{
				gdocking_mousedown = false
				return;
			}
		}
			
		clone_dragdock_section(section);
		gdragdocking = true;
	}
}

function tab_onclick()
{
	var id = window.event.srcElement.id;
	var tab_id = id.substr(2);
	if (tab_id == "")
		return;

	var tab =  get_section_from_id(groot_container, tab_id);
	if (tab == null)
	{
		tab_id = id.substr(9);
		
		tab =  get_section_from_id(groot_container, tab_id);
		if (tab == null)
			return;
	}

	set_tab_is_active(tab);		
	check_set_and_show_section_tree(groot_container, true);

	gdebugging = false;
	_ss("after create", tab.tab_section.tab_container, true);
	gdebugging = false;
}

function dock_to_section(to_section, section, side)
{
	if (section == null || to_section == null)
		return null;
		
	section = go(section);
		
	destroy_section_borders(section);
	destroy_section_borders(to_section);
	
	// create a new container that will hold the dock_To and the org sections
	var container = contain_section(to_section, section.id + "_docked_to_" + to_section.id);
	
	// before setting the new parent, set the original parent as sized
	set_section_parent(section, gi(container));
			
	// this will do the positioning
	move_last_section_to_position(section, 0);
	
	to_section.position_type = "dock";		
	to_section.dock_position = side;
	
	section.position_type = "dock";
	section.dock_position = side;
			
	// set the new height/width
	if (side == "left" || side == "right")
	{
		section.height = to_section.height;
		set_section_oi_original_dimension(section, -1, section.height)
	}
	else if (side == "top" || side == "bottom")
	{
		section.width = to_section.width;
		set_section_oi_original_dimension(section, section.width, -1)
	}

	// if the target dock section is part of a tab, then handle the dock gracefully
	// that is set the tab container, tab refernces etc..
	shift_tab_container(to_section, container); // the previously tabbed section and its new container
			
	// set the dimensions of the children of the org section and the new container
	add_property(section, "is_sized", true);
	add_property(to_section, "is_sized", true);	

	return container;
}

function dock_to_root_container(section, side)
{
	if (section == null)
		return null;
		
	destroy_section_borders(section);
	
	section.position_type = "dock";
	section.dock_position = side;
	var container = contain_root_container(section.id + "_docked_to_root", side);

	// set the parent of the section as the root container
	set_section_parent(section, gi(groot_container));
	move_last_section_to_position(section, 0);

	if (side == "left" || side == "right")
		container.width-=section.width;
	else if (side == "top" || side == "bottom")
		container.height-=section.height;

	add_property(section, "is_sized", true);
	
	return container;
}

function float_section(section, float_in_section, rx, ry)
{
	if (section == null || float_in_section == null)
		return false;
		
	if (is_tab_bar(section))
		section = section.tab_container;
		
	if (is_section_in_child_tree(float_in_section, section))
		return false;
		
	// if floating within same section			
	if (gpo(section).id == go(float_in_section).id)
	{
		destroy_section_borders(section);
		
		var px = gsl_s(gpi(section));
		var py = gst_s(gpi(section));
			
		var x = rx - px - (section.width/2);
		var y = ry - py;
			
		if (x > 0 && y  > 0)
			set_section_oi_dimension(section, x, y, section.width, section.height);
					
		section.position_type = "float";
		set_section_limits(section);
				
		set_section_max_zindex(section);
		return true;
	}
	else // if floating in a different section
	{
		var center = gco(float_in_section);
		if (center != null)
		{
			destroy_section_borders(section);
			
			// if the original section is not a tab_bar and was part of a tab, then detach it 
			// and handle the original tabs gracefully.
			if (!remove_tab(section)) // this if returns true, then it would have removed the child already
			{
				// detach the drag section from its original position
				// undock the original section and do the docking
				remove_child_section(section);
			}
						
			section.position_type = "float";
			set_section_parent(section, gi(center));
					
			center.is_visible = true;
			gi(center).is_visible = true;
			var px = gsl_s(section.parent_section);
			var py = gst_s(section.parent_section);
			
			var x = rx - px - (section.width/2);
			var y = ry - py;
			
			if (x > 0 && y  > 0)
				set_section_oi_dimension(section, x, y, section.width, section.height);
						
			set_section_max_zindex(section);
			return true;
		}		
	}
	
	return false;
}

function stick_to_section(to_section, section, side)
{
	if (section == null || to_section == null)
		return null;
		
	section = go(section);
	if (is_tab_bar(section))
		section = section.tab_container;
		
	if (is_section_in_child_tree(to_section, section))
		return false;
	
	destroy_section_borders(section);
	set_section_parent(section, gi(to_section));
			
	section.position_type = "stick";
	section.is_always_on_top = true;
	if (side == "left")
	{
		section.stick_left = true;
		section.stick_top = true;
	}
	else if (side == "top")
	{
		section.stick_right = true;
		section.stick_top = true;
	}
	else if (side == "bottom")
	{
		section.stick_left = true;
		section.stick_bottom = true;
	}
	else if (side == "right")
	{
		section.stick_right = true;
		section.stick_bottom = true;
	}
			
	// set the dimensions of the children of the org section and the new container
	add_property(section, "is_sized", true);
	add_property(to_section, "is_sized", true);	

	return section;
}

function stack_section(section)
{
	if (section == null)
		return null;
		
	section = go(section);
	if (is_tab_bar(section))
		section = section.tab_container;
		
	destroy_section_borders(section);
	section.position_type = "stack";
			
	var center = gcoo(section);
	if (center != null)
		add_property(center, "is_visible", true);
		
	check_set_and_show_section_tree(groot_container, true);				
	return section;
}

function make_section_static(section)
{
	if (section == null)
		return null;
		
	section = go(section);
	if (is_tab_bar(section))
		section = section.tab_container;
		
	destroy_section_borders(section);
	section.position_type = "static";
			
	var center = gcoo(section);
	if (center != null)
		add_property(center, "is_visible", true);
		
	check_set_and_show_section_tree(groot_container, true);				
	return section;
}

function popin_section(section)
{
	if (section == null)
		return null;
		
	section = go(section);
	if (is_tab_bar(section))
		section = section.tab_container;

	// remove the section from its original position
	if (!remove_tab(section)) // this if returns true, then it would have removed the child already
	{
		// detach the drag section from its original position
		// undock the original section and do the docking
		remove_child_section(section);
	}
						
	var root = gi(groot_container);
	set_section_parent(section, root);
	
	destroy_section_borders(section);
	section.position_type = "popin";
	section.is_always_on_top = true;
	
	set_section_max_zindex(section);
	check_set_and_show_section_tree(groot_container, true);				
	return section;
}
