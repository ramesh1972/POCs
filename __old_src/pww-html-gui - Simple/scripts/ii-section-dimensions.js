// ================================================================================
function set_section_dimension(section, x, y, w, h)
{
	if (section == null)
		return;
		
	if (x != -1) ssl(section, x);
	if (y != -1) sst(section, y);
	if (w != -1) ssw(section, w);
	if (h != -1) ssh(section, h);
	
	set_section_original_dimension(section, w, h);
}

function set_section_original_dimension(section, w, h)
{
	if (section == null)
		return;
		
	if (w != -1)
		section.owidth = w;
	
	if (h != -1)
		section.oheight = h;
}


function reset_section_to_original_dimension(section)
{
	if (section == null)
		return;
		
	if (!section.is_fixed_width)
		ssw(section, section.owidth);
		
	if (!section.is_fixed_height)
		ssh(section, section.oheight);
}

function set_section_actual_dimension(section)
{
	if (section == null)
		return;
		
	ssal(section, gsl(section));
	ssat(section, gst(section));
	ssaw(section, gsw(section));
	ssah(section, gsh(section));	
}

// ================================================================================
function set_section_current_dimension(section) {

	// This function calculates the dimensions (w,h) of a section based on the dimensions of the child sections.
	// This section should be called iteratively for the whole section tree (page) bottom up. 
	// So the child sections are set first and based on them the parent section is set
	if (!should_layout_section(section))
		return;
		
	// if the section was sized explicitly by resizing, then w/h should not be set for the section.
	if (section.is_sized)
		return;
				
	if (is_root(section))
	{
		set_section_dimension(section, 0, 0, g_cw(), g_ch());
		return; 
	}
	else
	{
		section.width = gi(section).width;
		section.height = gi(section).height;
	}

    if (get_number_of_child_sections(section) == 0) 
    {
        reset_section_to_original_dimension(section);
        return;
    }

	// =================================
	// If a section is inner and has one (if it is not center child) or more children, then loop through all the children 
	// and set the max dimensions for section based on the children
	// set the initial width/height to 0 and then recalculate
/*	if (!section.is_fixed_width)
		section.width = 0;
	if (!section.is_fixed_height)
		section.height = 0;
	*/
	// for docks
	var w = 0;
	var h = 0;
	var maxw = 0;
	var maxh = 0;
	
	// for statics
	var cminleft = 0;
	var cmaxright = 0;
	var cmintop = 0;
	var cmaxbottom = 0;
	
	// width of the section is the sum of all the widths of the lefts/right docks. 
	// If there are none, the the max width of the tops/bottoms
	// similarly for the height
	for (var idx = 0;idx < section.child_sections.length;idx++)
	{
		var child = section.child_sections[idx];
		if (!should_layout_section(child))
			continue;
	
		if (child.position_type == "dock")
		{		
			if (child.dock_position == "left" || child.dock_position == "right")
			{
				if (child.width >= child.min_section_width)
					w += child.width;
				else
					w += child.min_section_width;
					
				if (child.height > maxh)
					if (child.height >= child.min_section_height)
						maxh = child.height;
					else
						maxh = child.min_section_height;
			}
			else if (child.dock_position == "top" || child.dock_position == "bottom")
			{
				if (child.height >= child.min_section_height)
					h += child.height;
				else
					h += child.min_section_height;

				if (child.width > maxw)
					if (child.width >= child.min_section_width)
						maxw = child.width;
					else
						maxw = child.min_section_width;
			}
		}
		else if (child.position_type == "static" || child.position_type == "float" || child.position_type == "stack" || child.position_type == "stick")
		{
			if (child.left < cminleft)
				cminleft = child.left;		
			
			if (child.left + child.width > cmaxright)
				cmaxright = child.left + child.width;
			
			if (child.top < cmintop)
				cmintop = child.top;
			
			if (child.top + child.height > cmaxbottom)
				cmaxbottom = child.top +child.height;
		}
	}

	// set the left/top
	if (section.position_type == "dock")
	{	
		section.left = 0;
		section.top = 0;
	}
	
	// set the width/height. If fixed width or height then nothing is changed	
	if (!section.is_fixed_width)
	{
		// width for the docks
		w += maxw;
		section.width = w;

		// create width  for statics
		if (w < cmaxright - cminleft)
			w = cmaxright - cminleft;
		
		section.width = w;
	}
	
	if (!section.is_fixed_height)		
	{
		h += maxh;

		// create height for statics
		if (h < cmaxbottom - cmintop)
			h = cmaxbottom - cmintop;
			
		section.height = h;
	}
}

function set_section_children_current_position(section) {
	// This function loops through all the children and positions them. In some cases changes the dimensions as well.
	// This function should be called after setting the approximate w,h of all child sections by 
	// calling the previous (above) method.
	if (!should_layout_section(section))
		return;
		
	// if section has a frame, then that is the only child. Set its dimensions and return
	if (section.is_frame)
		return g_set_dimensions(section.frame_handle, 0, 0, section.width, section.height);

	// if this is a center section, then use its function to layout the center's children (i.e non docked sections)
    set_non_docked_children_current_position(section);

	// =======================================
	// Set the positioning of child sections of a section that is either
	// - an inner section with its child sections (the meat)
	// - an outer section with the section bars, controls, etc.. and the single inner section. (the skin/boundary)
	
	// This is the section that will be used at the end to fill the remaining space of the section.
	var the_last_child = null;

	// get the initial limits of the section, the rectangle denoting available space
	var mx = my = 0;
	var mr = section.width;
	var mb = section.height;

	if (is_root(section)) {
	    mr = g_cw();
	    mb = g_ch();
	}

	// loop though the children and fit all sections - also calculate the remaining space.
	for (var idx=0; idx < section.child_sections.length;idx++)
	{
		var child_section = section.child_sections[idx];
		
		if (!should_layout_section(child_section))
			continue;
                 
        // the remaining space rectangle could fall out of the limits. correct the same.
		if (mx > section.width)
			mx = section.width;
				
		if (mx < 0)
			mx = 0;
				
		if (mr > section.width)
			mr = section.width;
				
		if (mr < 0)
			mr = 0;

		if (my > section.height)
			my = section.height;
				
		if (my < 0)
			my = 0;
			
		if (mb > section.height)
			mb = section.height;
				
		if (mb < 0)
			mb = 0;
			
		if (mr < mx)
			mr = mx;
			
		if (mb < my)
			mb = my;

		// position a docked child
		if (child_section.position_type == "dock")
		{
			// if the remaining space is not enough for the current child, then shrink the child accordingly
			// if a child has fixed width/height then it should not be altered		
			if (!child_section.is_fixed_width)
			{
				if (mr-mx < child_section.width)
					child_section.width = mr-mx;
			}
			
			if (!child_section.is_fixed_height)
			{
				if (mb-my < child_section.height)
					child_section.height = mb-my;
			}
					
			// dock it!
			if (child_section.dock_position == "left")
			{
				ssl(child_section, mx);
				sst(child_section, my);
				ssw(child_section, child_section.width);
				ssh(child_section, mb-my);
									
				mx+=child_section.width;
			}
			else if (child_section.dock_position == "right")
			{
				ssl(child_section, mr-child_section.width);
				sst(child_section, my);
				ssw(child_section, child_section.width);
				ssh(child_section, mb-my);				

				mr-=child_section.width;
			}
			else if (child_section.dock_position == "top") {
				ssl(child_section, mx);
				sst(child_section, my);	
				ssw(child_section, mr-mx);
				ssh(child_section, child_section.height);

			    my += child_section.height;
			}
			else if (child_section.dock_position == "bottom")
			{
				ssl(child_section, mx);
				sst(child_section, mb-child_section.height);
				ssw(child_section, mr-mx);
				ssh(child_section, child_section.height);

				mb-= child_section.height;
            }

            g_set_dimensions(child_section.handle, child_section.left, child_section.top, child_section.width, child_section.height);

		}
		// position a sticky child
		else if (child_section.position_type == "stick")
		{
			// set the correct sticky corner
			if (child_section.stick_left)
				child_section.stick_right = false;
			else
				child_section.stick_right = true;
			
			if (child_section.stick_top)
				child_section.stick_bottom = false;
			else
				child_section.stick_bottom = true;
			
			// stick it!
			if (child_section.stick_left)
				ssl(child_section, 0);
				
			if (child_section.stick_top)
				sst(child_section, 0);
					
			if (child_section.stick_right)
				ssl(child_section, section.width - child_section.width);
				
			if (child_section.stick_bottom)
				sst(child_section, section.height - child_section.height);
		}
			
		// Suppose there is no center child, that is no stack/float etc.. children were intended for the section,
		// then the remaining space has to be filled up with last docked section.
		if (child_section.position_type == "dock")
		{
			if (child_section.is_fixed_height || child_section.is_fixed_width)
				; // nothing
			else
				the_last_child = child_section;
		}
	} // done positioning docks and sticks
	
	// Fill up the remaining space
	// if there is a center section then it will occupy the remaining space. 
	
	// if there is no center section then the last child will occupy the remaining space.
	if (the_last_child != null && the_last_child.position_type == "dock")
	{
		if (the_last_child.dock_position == "left")
			the_last_child.width+=(mr-mx);
		else if (the_last_child.dock_position == "right")
		{
			the_last_child.left = mx;
			the_last_child.width+=(mr-mx);
		}
		else if (the_last_child.dock_position == "top")
			the_last_child.height+= (mb-my);
		else if (the_last_child.dock_position == "bottom")
		{
			the_last_child.top = my;
			the_last_child.height+= (mb-my);

        }

        g_set_dimensions(the_last_child.handle, the_last_child.left, the_last_child.top, the_last_child.width, the_last_child.height);
	}
}


function set_non_docked_children_current_position(section)
{
	// This function sets the position of the non docked sections, like float, stack, static etc..
	if (section == null)
		return;
	
	// This function should be called with a section which is the inner section of a center section		
	var prevx = 0;
	var prevy = 0;
	var maxb = 0;
	
	for (idx=0; idx < section.child_sections.length;idx++)
	{
		var child = section.child_sections[idx];

		if (!should_layout_section(child))
			continue;
					
		if (child.position_type == "float" || child.position_type == "static")
		{
			if (child.left < 0)
				child.left = 0;

			if (child.top < 0)
				child.top = 0;
		}
			
		if (child.position_type == "stack")
		{					
			// TODO, to support reflow flag
			child.left = prevx;
			child.top = prevy;
					
			// reflow the stacked sections if the width is not enough
			prevx = child.left + child.width;
			if (prevx != 0 && prevx > section.width)
			{
				prevx = 0;
				prevy = maxb;
				maxb = 0;
						
				child.left = prevx;
				child.top = prevy;
				prevx = child.left + child.width;
			}
					
			if (child.top + child.height > maxb)
				maxb = child.top + child.height;
		}
	}
}

// ============================================================================================
function check_set_on_overflow(section)
{
	return; // TODO not implemented
	
	if (section == null)
		return;
		
	if (section.on_overflow == "none")
		return;
	else if (section.child_sections.length == 0)
		return;
		
	// check if there is a inner overflow
	var cminleft = 0;
	var cmaxright = 0;
	var cmintop = 0;
	var cmaxbottom = 0;
	
	// width of the container is the sum of all the widths of the lefts/right docks. If there are none, the the max width of the tops/bottoms
	// similarly for the height
	for (var idx = 0;idx < section.child_sections.length;idx++)
	{
		if (section.left < cminleft)
			cminleft = section.left;		
			
		if (section.left + section.width > cmaxright)
			cmaxright = section.left + section.width;
			
		if (section.top < cmintop)
			cmintop = section.top;
			
		if (section.top + section.height > cmaxbottom)
			cmaxbottom = section.top +section.height;
	}
	
	var overflowedx = false;
	var overflowedy = false;
	if (cmaxright - cminleft > section.width)
		overflowedx = true;
	if (cmaxbottom - cmintop > section.height)
		overflowedy = true;
		
	// based on the overflow action set, take the appropriate action
	if (overflowedx || overflowedy)
	{
		if (section.on_overflow.match("scroll_bars"))
			sss(section, "overflow", "auto");
	}
}

// ================================================================================
function gsl_s(section)
{
	if (section == null)
		return 0;

	if (section == groot_container)
		return 0;

	var x = gsl_s(section.parent_section);
	x += section.left;
	return x;
}

function gst_s(section)
{
	if (section == null)
		return 0;

	if (section == groot_container)
		return 0;
	
	var y = gst_s(section.parent_section);
	y += gst(section);
	return y;
}

// ===
function _get_section_actual_left(section)
{
	if (section == null)
		return null;
	
	return g_goal(section.handle);
}

function _get_section_actual_top(section)
{
	if (section == null)
		return null;
	
	return g_goat(section.handle);
}

function _get_section_actual_width(section)
{
	if (section == null)
		return null;
	
	return g_goaw(section.handle);
}

function _get_section_actual_height(section)
{
	if (section == null)
		return null;
	
	return g_goah(section.handle);
}

function gsal(section) { return _get_section_actual_left(section); }
function gsat(section) { return _get_section_actual_top(section); }
function gsaw(section) { return _get_section_actual_width(section); }
function gsah(section) { return _get_section_actual_height(section); }
function gsar(section) { return gsal(section) + gsaw(section); }
function gsab(section) { return gsat(section) + gsah(section); }

function _set_section_actual_left(section, x)
{
	if (section == null)
		return null;
	
	g_soal(section.handle, x);
}

function _set_section_actual_top(section, y)
{
	if (section == null)
		return null;
	
	g_soat(section.handle, y);
}

function _set_section_actual_width(section , w)
{
	if (section == null)
		return null;
	
	g_soaw(section.handle, w);
}

function _set_section_actual_height(section, h)
{
	if (section == null)
		return null;
	
	g_soah(section.handle, h);
}

function ssal	(section, x) { _set_section_actual_left(section, x); }
function ssat(section, y) { _set_section_actual_top(section, y); }
function ssaw(section, w) { _set_section_actual_width(section, w); }
function ssah(section, h) { _set_section_actual_height(section, h); }

function _get_section_left(section)
{
	if (section == null)
		return null;
	
	return section.left;
}

function _get_section_top(section)
{
	if (section == null)
		return null;
	
	return section.top;
}

function _get_section_width(section)
{
	if (section == null)
		return null;
	
	return section.width;
}

function _get_section_height(section)
{
	if (section == null)
		return null;
	
	return section.height;
}

function gsl(section) { return _get_section_left(section); }
function gst(section) { return _get_section_top(section); }
function gsw(section) { return _get_section_width(section); }
function gsh(section) { return _get_section_height(section); }
function gsr(section) { return gsl(section) + gsw(section); }
function gsb(section) { return gst(section) + gsh(section); }

function _set_section_left(section, x)
{
	if (section == null)
		return null;
	
	section.left = x;
}

function _set_section_top(section, y)
{
	if (section == null)
		return null;
	
	section.top = y;
}

function _set_section_width(section , w)
{
	if (section == null)
		return null;
	
	section.width = w;
}

function _set_section_height(section, h)
{
	if (section == null)
		return null;
	
	section.height = h;
}

function ssl(section, x) { _set_section_left(section, x); }
function sst(section, y) { _set_section_top(section, y); }
function ssw(section, w) { _set_section_width(section, w); }
function ssh(section, h) { _set_section_height(section, h); }

// =============================================================
// other
function align_section(section, alignment)
{
	if (section == null)
		return;
		
	g_set_align(section.handle, alignment);
}

function position_section(section, position)
{
	if (section == null)
		return;
		
	sss(section, "position", position);
}

function set_section_max_zindex(section)
{
	set_max_zindex(section);
}

function set_max_zindex(section)
{
	if (section == null || section.parent_section == null)
		return;
		
	var max = 0;
	var min = 0;
	
	// find the max zindex and also the min
	for (var idx=0; idx<section.parent_section.child_sections.length; idx++)
	{
		if (section.parent_section.child_sections[idx].is_always_on_top)
			;		
		else
		{
			var zi = g_get_zindex(section.parent_section.child_sections[idx].handle);
			if (zi > max)
				max = zi;
			
			if (zi < min)
				min = zi;
		}
	}

	// normalize index, if always on top, set it to max+2
	max = max - min;	
	for (var idx=0; idx<section.parent_section.child_sections.length; idx++)
	{
		if (section.parent_section.child_sections[idx].is_always_on_top)
			g_set_zindex(section.parent_section.child_sections[idx].handle, max+2);
		else
			g_set_zindex(section.parent_section.child_sections[idx].handle, g_get_zindex(section.parent_section.child_sections[idx].handle) - min);
	}
	
	// set the max index for the section (but not greater than sections with always_on_top flag)
	if (!section.is_always_on_top)
		max = max + 1;
	else
		max = max + 3;
		
	g_set_zindex(section.handle, max);				
	
	if (section.border_left != null)
		g_set_zindex(section.border_left.base.handle, max);
		
	if (section.border_right != null)
		g_set_zindex(section.border_right.base.handle, max);		
		
	if (section.border_bottom != null)		
		g_set_zindex(section.border_bottom.base.handle, max);		
		
	if (section.border_top != null)		
		g_set_zindex(section.border_top.base.handle, max);				
}