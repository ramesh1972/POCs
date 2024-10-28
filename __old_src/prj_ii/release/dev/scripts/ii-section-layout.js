
// ================================================================================
// Page/Section/boder/Size/Resize/Layout functions 
function check_set_and_show_section_tree(rsection, deep)
{
	// temp: TODO  handle size_changed gracefully
	set_size_changed(rsection, true);
	
	// remove any containers/covers etc..that do not have child sections
	if (!gpage_initialization)
		remove_empty_containers(rsection);

	// set dimensions functions have no knowledge of borders and rightly so, since it is better to contain
	// the border login within the border functions. Since the set dimensions functions will ignore the 
	// borders, it is important to unset the dimension changes caused by borders.
	undo_section_border_dimensions(rsection, true); 		
		
	// calculate the dimensions of each section bottom up
	// for sections containing children, after the children dimensions are set, 
	// its dimensions are calculated based on the children dimensions
	set_section_tree_dimensions(rsection, deep);

	// though the dimensions are set for all the sections, the
	// dimensions during actual layout will vary..like docking, or stacking..so fit the children
	// top/down
	set_section_tree_children_dimensions(rsection, deep);
	
	// check the limits bottom up
	check_set_section_tree_limits(rsection, deep);

	// create the borders between the sections at the same level, going down
	set_section_tree_borders(rsection, deep);

	// layout containers, covers, sections, borders top down
	layout_section_tree(rsection, deep);
	
	// remove overlapped borders
	remove_overlapped_borders(rsection);

	gdebugging = false;
	_ss("after create", groot_container, true);
	gdebugging = false;
}

// ================================================================================
function should_layout_section(section)
{
	if (section == null)
		return false;
		
	if (is_border(section))
		return false;
	
	if (!section.is_visible)
		return false;
		
	return true;
}

// ================================================================================
function remove_empty_containers(rsection)
{
	if (!should_layout_section(rsection))
		return;
		
	// do this bottom up
	for (var idx=0; idx<rsection.child_sections.length;idx++)
	{
		if (remove_empty_containers(rsection.child_sections[idx]))
			idx--;
	}

	// these are the sections that have children
	if (is_outer(rsection))
	{
		var temp = rsection;
		if (gi(rsection) != null)
			temp = gi(rsection);
			
		var num_sections = 0;
		var sect_to_move = null;
		var center_child = null;
		for (idx=0; idx< temp.child_sections.length; idx++)
		{
			var child = temp.child_sections[idx];
			if (is_center(child))
				center_child = child;
			else if (!is_border(child) && !is_bar(child))
			{
				num_sections++;
				sect_to_move = child;
			}
		}
		
		if (go(temp) != null && is_center(go(temp)))
		{
			if (num_sections == 0)
			{
				alert(4.6);
				destroy_section_borders(go(temp));
				go(temp).is_visible = false;
				return false;
			}
		}
		else if (rsection.real_type == "container")
		{
			// check if there was any child section
			if (num_sections == 0)
			{
				if (center_child != null && !center_child.is_visible) 		// check if center child is visible or not.
				{
					alert(0.6);
					remove_tab(rsection);
					destroy_section(rsection);
					return true;
				}
				
				return false;
			}
			else if (num_sections == 1) // then there is no need for the container
			{
				if (center_child != null && !center_child.is_visible)
				{
					alert(1.6);
					
					// This is a container with one child, so there is not need for the container. move the child up the tree
					var cpos = get_section_position(rsection);
					destroy_section(rsection);

					set_section_parent(sect_to_move, rsection.parent_section);
					move_last_section_to_position(sect_to_move, cpos);
					
					sect_to_move.position_type = rsection.position_type;
					sect_to_move.dock_position = rsection.dock_position;
					sect_to_move.left = rsection.left;
					sect_to_move.top = rsection.top;
					
					sect_to_move.is_sizable = true;
					if (rsection.tab_container != null)
					{
						sect_to_move.tab_container = rsection.tab_container;
						sect_to_move.tab = rsection.tab;
						sect_to_move.tab.tab_section = sect_to_move;
						sect_to_move.is_sizable = false;
						
						set_section_oi_dimension(sect_to_move, sect_to_move.tab_container.left, sect_to_move.tab_container.top, sect_to_move.tab_container.width, sect_to_move.tab_container.height);
						change_tab_id(sect_to_move);
						set_tab_is_active(sect_to_move.tab);
					}
					
					if (rsection.position_type == "stick")
					{
						sect_to_move.width = rsection.width;
						sect_to_move.height = rsection.height;
						
						sect_to_move.stick_left = rsection.stick_left;
						sect_to_move.stick_right = rsection.stick_right;
						sect_to_move.stick_bottom = rsection.stick_bottom;
						sect_to_move.stick_top = rsection.stick_top;
					}
					
					sect_to_move.is_always_on_top = false;
					sect_to_move.border_thickness = rsection.border_thickness;
					set_max_zindex(sect_to_move);
				}
				
				return false;
			}
		}
	}
	
	return false;
}

function set_section_tree_dimensions(rsection, deep)
{
	if (!should_layout_section(rsection))
		return;
	
	if (!deep)
	{
		if (rsection.size_changed)
			// now this def. contains children that has to be resized, pre calculate their dimensions
			set_section_current_dimension(rsection);
	
		return;
	}
			
	for (var idx=0; idx<rsection.child_sections.length;idx++)
		// tabs, tab bars are laid out by a separate function rather than the standard functions
		if (!is_tab(rsection))
			set_section_tree_dimensions(rsection.child_sections[idx], true);

	if (rsection.size_changed)
		set_section_current_dimension(rsection);
}

function set_section_tree_children_dimensions(rsection, deep)
{
	if (!should_layout_section(rsection))
		return;

	if (rsection.size_changed)
	{
		// tabs, tab bars are laid out by a separate function rather than the standard functions
		if (is_inner(rsection) && is_center(rsection) && is_tab_bar(rsection))
		{
			layout_tab_bar(gcoo(rsection));
			layout_tab_bar_tabs(gcoo(rsection));
				
			return;
		}

		// now this def. contains children that has to be resized, pre calculate their dimensions
		set_section_children_current_position(rsection);
	}
	
	// if this is not a deep display, then the function should return for super containers, 
	// but allow for the root container and the section containter, i.e. "container"
	if (!deep)
		return;

	for (var idx=0; idx<rsection.child_sections.length;idx++)
		set_section_tree_children_dimensions(rsection.child_sections[idx], true);
}	

function check_set_section_tree_limits(rsection, deep)
{
	if (!should_layout_section(rsection))
		return;

	if (rsection.parent_section != null)
	{
		reset_limit_check(rsection.parent_section);
		set_section_limits_and_adjust_surroundings(rsection);
		set_section_tree_children_dimensions(rsection.parent_section, true);
	}
		
	if (!deep)
		return;
	
	for (var idx=0; idx < rsection.child_sections.length;idx++)
		check_set_section_tree_limits(rsection.child_sections[idx], true);
}

function check_set_on_section_tree_overflow(rsection, deep)
{
	if (!should_layout_section(rsection))
		return;
	
	if (!deep)
	{
		if (rsection.size_changed)
			// now this def. contains children that has to be resized, pre calculate their dimensions
			check_set_on_overflow(rsection);
	
		return;
	}
			
	for (var idx=0; idx<rsection.child_sections.length;idx++)
		check_set_on_section_tree_overflow(rsection.child_sections[idx], true);

	if (rsection.size_changed)
		check_set_on_overflow(rsection);
}

function set_section_tree_borders(rsection, deep)
{
	if (!should_layout_section(rsection))
		return;

	if (rsection.size_changed)
	{
		// now this def. contains children that has to be resized, pre calculate their dimensions
		set_section_borders(rsection);
	}

	if (!deep)
		return;

	for (var idx=0; idx<rsection.child_sections.length;idx++)
		set_section_tree_borders(rsection.child_sections[idx], true);
}

function layout_section_tree(rsection, deep)
{
	if (rsection == null || is_border(rsection))
		return;
		
	if (!rsection.is_visible)
	{
		hide_section(rsection);
		return;
	}
	else
	{
		// display the current section !!!
		if (rsection.size_changed)
			layout_section(rsection);
	}
						
	if (!deep)
		return;

	// loop through the children and recursively call this function
	for (var idx=0; idx<rsection.child_sections.length;idx++)
		layout_section_tree(rsection.child_sections[idx], true);
}

// ================================================================================
function layout_section(section)
{
	//  set section pos and size, that is display !!!
	layout_section_position_and_size(section);

	// show the borders
	layout_section_borders(section);

	if (section.is_visible)
		show_section(section);
	else
		hide_section(section);
		
	if (section.is_always_on_top)
		set_section_max_zindex(section);
		
	// TODO: signal the change, so that it is not re laid out unnecessarily later
	// section.size_changed = false;				
}

function layout_section_position_and_size(section)
{
	if (section == null)
		return;
		
	_sm("layout", "layout_section_position_and_size");
	_ss("before final layout", section, false);
	
	// position the section
  	set_section_actual_dimension(section);
	show_section(section);

	// set the right background color for inner sections
	if (is_inner(section) && !is_center(section) && !is_tab_bar(section) && !is_bar(section))
	{
		var num_children = get_number_of_child_sections(section);
		var center = gci(section);
		
		if (num_children == 0 && !center.is_visible)
		{
			sss(section, "backgroundColor", "yellow")
			sss(section, "borderWidth", ".03cm");
			sss(section, "borderStyle", "inset");
			sss(section, "borderColor", "white");	
			
//			// debug
//			var htmls = _shtml(section);
//			if (htmls != "")
//				section.handle.innerHTML = htmls;
		}
		else if (num_children == 0 && center.is_visible)
		{
			sss(section, "backgroundColor", "gray")
		}
		else if (is_center(section) && go(section).is_visible)
		{
			sss(section, "backgroundColor", "gray")
			sss(section, "borderStyle", "none");
		}			
		else 
		{
			sss(section, "backgroundColor", "gray")
			sss(section, "borderStyle", "none");
		}
	}
	
	if (is_bar(section) && !is_tab_bar(gpo(section)))
		layout_bar_text(section);

		
	gdebugging = false;
}

function is_section_visible(section)
{
	if (section != null)
		return g_is_visible(section.handle);
	
	return false;
}

function show_section(section)
{
	if (section == null)
		return;
	
	g_show_element(section.handle);
	if (section.is_frame)
		g_show_element(section.frame_handle);
}

function hide_section(section)
{
	if (section == null)
		return;
	
	g_hide_element(section.handle);
	if (section.is_frame)
		g_hide_element(section.frame_handle);

	for (var idx = 0;idx < section.child_sections.length;idx++)
		hide_section(section.child_sections[idx]);
}

// ================================================================================
// call this function on a section whose dimensions are "changed" 
// to set set the dimensions of the neighboring sections. This is recursive and
// set the dimensions of all the sections in the layout, based on the initial change.
// NOTE: This function should be called before doing the physical layout, that is posTOp, posWidth etc..
// should not be changed. On returning from this function simply call page_relayout()
//  ... example...say if a section x changed in height, then 
//			set_section_limits_and_adjust_surroundings(x);
//			relayout_page();
// these are enough to set the display of the whole page right
function set_section_limits_and_adjust_surroundings(section)
{
	if (section == null || section.position_type != "dock")
		return;
		
	// get surrounding sections
	var lsss = new Array();
	var rsss = new Array();
	var tsss = new Array();
	var bsss = new Array();

	var bt = 0;
	if (gresizing)
	{
		bt = gpo(section).border_thickness;
		get_post_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
		set_section_actual_dimension(section);
	}
	else
		get_pre_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);

	// check the basic limits of the section
	set_section_limits(section);
	
	// check the left ones
	for (var idx=0; idx<lsss.length;idx++)
	{
		var lss = lsss[idx];
		if (lss.limit_already_checked)
			continue;
					
		var recurse = false;
		
		if (section.left <= lss.left)
		{
			//alert(2.1 + section.id + "," + lss.id);		
			
			lss.width = lss.min_section_width;
			section.width = section.left + section.width - (lss.left + lss.width + bt);
			section.left = lss.left + lss.width + bt;

			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.left > lss.left + lss.width + bt)
		{
			//alert(2.2 + section.id + "," + lss.id);
				
			lss.width += (section.left) - (lss.left + lss.width);
			lss.width-= bt;

			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.left < lss.left + lss.width + bt)
		{
			//alert(2.3 + section.id + "," + lss.id);
		
			lss.width = section.left - lss.left;
			lss.width -= bt;
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		
		if (section.width < section.min_section_width)
		{
			//alert(2 + section.id + "," + lss.id);

			if (lss.width - (section.min_section_width -section.width) < lss.min_section_width)
			{
				lss.width = lss.min_section_width;
				section.left = lss.left + lss.width + bt;
				section.width = section.min_section_width;
			}
			else
			{
				lss.width -= section.min_section_width -section.width;
				section.left -=section.min_section_width -section.width;
				section.width = section.min_section_width;
			}

			section.limit_already_checked = true;							
			recurse = true;
		}

		if (recurse)
		{
			lss.recurse = true;
		}
	}
	
	// check the right sections
	for (idx=0; idx<rsss.length;idx++)
	{
		var rss = rsss[idx];
		if (rss.limit_already_checked)
			continue;

		var recurse = false;
		
		if (section.left + section.width + bt >= rss.left + rss.width)
		{
			//alert(3.1 + section.id + "," + rss.id);		

			rss.left += rss.width - rss.min_section_width;
			rss.width = rss.min_section_width;			
			section.width = rss.left - section.left;
			section.width-=bt;

			section.limit_already_checked = false;								
			recurse = true;
		}
		else if (section.left + section.width + bt > rss.left)
		{
			//alert(3.2 + section.id + "," + rss.id);
				
			rss.width -= (section.left + section.width)-rss.left;
			rss.left += (section.left + section.width)-rss.left;
			rss.width -= bt;
			rss.left += bt;
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.left + section.width + bt < rss.left)
		{
			//alert(3.3 + section.id + "," + rss.id);

			rss.width += rss.left - (section.left + section.width);
			rss.width -= bt;
			rss.left = section.left + section.width;
			rss.left += bt;
			
			section.limit_already_checked = false;					
			recurse = true;
		}
		
		if (section.width < section.min_section_width)
		{
			//alert(3 + section.id + "," + rss.id);

			if (rss.width - (section.min_section_width - section.width) < rss.min_section_width)
			{
				section.left -= section.min_section_width - section.width;
				section.width = section.min_section_width;
			}
			else
			{
				rss.left += section.min_section_width - section.width;
				rss.width -= section.min_section_width - section.width;
				section.width = section.min_section_width;				
			}
			
			section.limit_already_checked = true;				
			recurse = true;
		}		

		if (recurse)
		{
			rss.recurse = true;
		}
	}	

	// check the top sections
	for (var idx=0; idx<tsss.length;idx++)
	{
		var tss = tsss[idx];
		if (tss.limit_already_checked)
			continue;
					
		var recurse = false;
		if (section.top <= tss.top)
		{
			//alert(4.1 + section.id + "," + tss.id);		
			
			tss.height = tss.min_section_height;
			section.height = section.top + section.height - (tss.top + tss.height + bt);
			section.top = tss.top + tss.height + bt;

			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.top > tss.top + tss.height + bt)
		{
			//alert(4.2 + section.id + "," + tss.id);
				
			tss.height += (section.top) - (tss.top + tss.height);
			tss.height -= bt;
	
			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.top < tss.top + tss.height + bt)
		{
			//alert(4.3 + section.id + "," + tss.id);
		
			tss.height = section.top - tss.top;
			tss.height -= bt;
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		
		if (section.height < section.min_section_height)
		{
			//alert(4 + section.id + "," + tss.id);

			if (tss.height - (section.min_section_height -section.height) < tss.min_section_height)
			{
				tss.height = tss.min_section_height;
				section.top = tss.top + tss.height + bt;
				section.height = section.min_section_height;
			}
			else
			{
				tss.height -= section.min_section_height -section.height;
				section.top -=section.min_section_height -section.height;
				section.height = section.min_section_height;
			}

			section.limit_already_checked = true;							
			recurse = true;
		}

		if (recurse)
		{
			tss.recurse = true;
		}
	}

	// check the bottom sections
	for (idx=0; idx<bsss.length;idx++)
	{
		var bss = bsss[idx];
		if (bss.limit_already_checked)
			continue;
		
		var recurse = false;

		if (section.top + section.height + bt >= bss.top + bss.height)
		{
			//alert(5.1 + section.id + "," + bss.id);		

			bss.top += bss.height - bss.min_section_height;
			bss.height = bss.min_section_height;			
			section.height = bss.top - section.top;
			section.height-=bt;

			section.limit_already_checked = false;								
			recurse = true;
		}
		else if (section.top + section.height + bt > bss.top)
		{
			//alert(5.2 + section.id + "," + bss.id);
				
			bss.height -= (section.top + section.height)-bss.top;
			bss.top += (section.top + section.height)-bss.top;
			bss.height -= bt;
			bss.top += bt;
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.top + section.height + bt < bss.top)
		{
			//alert(5.3 + section.id + "," + bss.id);

			bss.height += bss.top - (section.top + section.height);
			bss.height -= bt;
			bss.top = section.top + section.height;
			bss.top += bt;
			
			section.limit_already_checked = false;					
			recurse = true;
		}
		
		if (section.height < section.min_section_height)
		{
			//alert(5 + section.id + "," + bss.id);

			if (bss.height - (section.min_section_height - section.height) < bss.min_section_height)
			{
				section.top -= section.min_section_height - section.height;
				section.height = section.min_section_height;
			}
			else
			{
				bss.top += section.min_section_height - section.height;
				bss.height -= section.min_section_height - section.height;
				section.height = section.min_section_height;				
			}
			
			section.limit_already_checked = true;				
			recurse = true;
		}		

		if (recurse)
		{
			bss.recurse = true;
		}
	}	
	
	section.recurse = false;
	for (idx=0; idx<lsss.length;idx++)
	{
		if (lsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(lsss[idx]);
	}

	for (idx=0; idx<rsss.length;idx++)
	{
		if (rsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(rsss[idx]);
	}

	for (idx=0; idx<tsss.length;idx++)
	{
		if (tsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(tsss[idx]);
	}

	for (idx=0; idx<bsss.length;idx++)
	{
		if (bsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(bsss[idx]);
	}
}

function get_pre_layout_surrounding_sections(section, lsss, rsss, tsss, bsss)
{
	if (section == null || section.parent_section == null)
		return;
		
	var sl = gsl(section);
	var st = gst(section);
	var sw = gsw(section);
	var sh = gsh(section);
	var sr = gsr(section);
	var sb = gsb(section);
	
	for (var idx=0; idx < section.parent_section.child_sections.length;idx++)
	{
		var ss = section.parent_section.child_sections[idx];
		
		if (is_border(ss) || is_bar(ss))
			continue;
				
		if (ss.position_type != "dock" && ss.position_type != "stack")
			continue;

		if (!ss.is_visible)
			continue;
				
		if (ss.id == section.id)
			continue;
			
		var ssl = gsl(ss);
		var sst = gst(ss);
		var ssr = gsr(ss);
		var ssb = gsb(ss);
		
		if ((sst >= st && ssb <= sb) || (sst >= st && sst < sb) || (ssb > st && ssb <= sb))
		{
			if (sl == ssr)
				lsss.push(ss);
			else if (sr == ssl)
				rsss.push(ss);
		}		

		if ((ssl >= sl && ssr <= sr) && (ssl >= sl && sst < sr) || (ssr > sl && ssr <= sr))
		{
			if (sb == sst)
				bsss.push(ss);
			else if (st == ssb)
				tsss.push(ss);
		}
	}	
}

function get_post_layout_surrounding_sections(section, lsss, rsss, tsss, bsss)
{
	if (section == null || section.parent_section == null)
		return;
		
	var sl = gsal(section);
	var st = gsat(section);
	var sw = gsaw(section);
	var sh = gsah(section);
	var sr = gsar(section);
	var sb = gsab(section);
	
	var bt = gpo(section).border_thickness;
	
	for (var idx=0; idx < section.parent_section.child_sections.length;idx++)
	{
		var ss = section.parent_section.child_sections[idx];
		if (is_border(ss) || is_bar(ss))
			continue;
		
		if (ss.position_type != "dock" && ss.position_type != "stack")
			continue;

		if (ss.id == section.id)
			continue;

		var ssl = gsal(ss);
		var sst = gsat(ss);
		var ssr = gsar(ss);
		var ssb = gsab(ss);
		
		if (sl == ssr + bt)
			lsss.push(ss);
		else if (sr + bt == ssl)
			rsss.push(ss);

		if (sb + bt == sst)
			bsss.push(ss);
		else if (st == ssb + bt)
			tsss.push(ss);
	}	
}

function set_section_limits(section)
{
	if (!should_layout_section(section))
		return;

	if (is_tab_bar(section))
		return;

	if (section.position_type == "float" || section.position_type == "stack")
	{
		if (section.width < section.min_section_width)
			section.width = section.min_section_width;
	
		if (section.height < section.min_section_height)
			section.height = section.min_section_height;
			
		return;
	}

	if (section.position_type == "dock")
	{
		if (section.parent_section == null)
			return;

		// check left		
		if (section.left < 0)
		{
			//alert(0.1 + section.id);
			section.left = 0;
		}

		if (section.width < 0)
		{
			//alert(0.2 + section.id);	
			section.width = 0;
		}
	
		if (section.left > section.parent_section.width)
		{
			//alert(0.3 + section.id);
			section.left = section.parent_section.width;
		}
	
		if (section.width > section.parent_section.width)
		{
			//alert(0.4 + section.id);
			section.width = section.parent_section.width;
			section.size_changed = true;		
		}

		if (section.left + section.width > section.parent_section.width)
		{
			//alert(0.5 + section.id);
			section.left = section.parent_section.width - section.width;
		}
	
		// check top
		if (section.top < 0)
		{
			//alert(0.6 + section.id);
			section.top = 0;
		}
	
		if (section.height < 0)
		{
			//alert(0.7 + section.id);	
			section.height = 0;
		}
	
		if (section.top > section.parent_section.height)
		{
			//alert(0.8 + section.id);
			section.top = section.parent_section.height;
		}
	
		if (section.height > section.parent_section.height)
		{
			//alert(0.9 + section.id);
			section.height = section.parent_section.height;
			section.size_changed = true;		
		}

		if (section.top + section.height > section.parent_section.height)
		{
			//alert(0.91 + section.id);
			section.top = section.parent_section.height - section.height;
		}
	}
}

// ================================================================================
function set_size_changed(psection, changed)
{
	if (psection == null)
		return;
		
	psection.size_changed = changed;
		
	for (var idx=0; idx < psection.child_sections.length;idx++)
		set_size_changed(psection.child_sections[idx], changed);
}

function set_parent_tree_size_changed(psection, type, changed)
{
	if (psection == null)
		return;
		
	var ps = psection;
	while (ps != null)
	{
		if (ps.section_type == type)
			ps.is_sized = changed;
		ps = ps.parent_section;
	}
}

function reset_parent_tree_is_sized(psection, changed)
{
	if (psection == null)
		return;
		
	var ps = psection;
	while (ps != null)
	{
		ps.is_sized = false;
		ps = ps.parent_section;
	}
}

function reset_section_is_sized(psection, changed, deep)
{
	if (psection == null)
		return;
		
	psection.is_sized = changed;
		
	if (!deep)
		return;
		
	for (var idx=0; idx < psection.child_sections.length;idx++)
		reset_section_is_sized(psection.child_sections[idx], changed, true);
}

function reset_limit_check(psection)
{
	if (psection == null)
		return;
		
	psection.limit_already_checked = false;
	psection.recurse = false;
	
	for (var idx=0; idx < psection.child_sections.length;idx++)
		reset_limit_check(psection.child_sections[idx]);
}

// styles
function set_section_style(section, style, value)
{
	if (section == null)
		return;
	
	g_ss(section.handle, style, value);
}

function sss(section, style, value)
{
	set_section_style(section, style, value);
}

function set_section_filter(section, value)
{
	if (section == null)
		return;
	
	g_sf(section.handle, value);
}

function ssf(section, value)	
{
	set_section_filter(section, value);
}

