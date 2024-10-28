// ================================================================================
function set_section_parent(section, parent_section)
{
	if (section == null || parent_section == null)
		return;

	section.parent_section = parent_section;
	append_child_section(parent_section, section);	
	add_section_to_parent_collection(section);
}

// parent_section property has to be set
function add_section_to_parent_collection(section)
{
	// add this section to parent child list...Hence creating a tree of sections!!!
	if (section != null && section.parent_section != null)
		section.parent_section.child_sections.push(section);
}

function remove_section_from_parent_collection(section)
{
	if (section == null || section.parent_section == null)
		return;
	
	var parents = section.parent_section;
	return array_remove_element(parents.child_sections, section);
}

// ================================================================================
function move_last_section_to_position(section, position)
{
	if (section == null || section.parent_section == null)
		return null;
		
	array_move_last_element_to_pos(section.parent_section.child_sections, section, position);
}

function move_section_to_position(section, position)
{
	if (section == null || section.parent_section == null)
		return null;
		
	var pos = remove_section_from_parent_collection(section);
	add_section_to_parent_collection(section);
	array_move_last_element_to_pos(section.parent_section.child_sections, section, position);
}

// ================================================================================
function get_number_of_child_sections(parent_section)
{
	if (parent_section == null)
		return -1;
	
	var num_children = 0;
	for (var idx = 0; idx < parent_section.child_sections.length; idx++)
	{
		var child = parent_section.child_sections[idx];
		if (child.is_visible && !is_border(child) && !is_bar(child) && !is_border(child) && !is_tab(child) && !is_tab_bar(child))
			num_children++;
	}
		
	return num_children;
}

function get_section_position(section)
{
	if (section == null || section.parent_section == null)
		return -1;
		
	return array_get_element_pos(section.parent_section.child_sections, section);
}


function get_section_from_id(start_section, id)
{
	if (start_section ==  null || !start_section.is_visible)
		return null;
		
	if (start_section.id == id)
		return start_section;
	
	for (var idx1 = 0; idx1 < start_section.child_sections.length;idx1++)
	{
		var cs = get_section_from_id(start_section.child_sections[idx1], id);
		if (cs !=  null)
			return cs;
	}
	
	return null;
}

function get_section_at_xy(s_section, x, y) // dunit
{
	if (s_section == null)
		return null;
		
	if (gsl_s(s_section) <= x && 
		gsl_s(s_section) + gsw(s_section) >= x && 
		gst_s(s_section) <= y &&
		gst_s(s_section) + gsh(s_section) >= y)
	{
		var c_section = null;
		for (var idx=0;idx < s_section.child_sections.length;idx++)
		{
			var child = s_section.child_sections[idx];
			if (child.is_visible && !is_bar(child) && !is_paw(child) && !is_border(child))
			{
				c_section = get_section_at_xy(child, x, y);
				if (c_section != null)
					return c_section;
			}
		}
		
		return s_section;
	}
	
	return null;
}

function get_section_of_type_at_xy(s_section, type, x, y) // dunit
{
	if (s_section == null)
		return null;
		
	if (gsl_s(s_section) <= x && 
		gsl_s(s_section) + gsw(s_section) >= x && 
		gst_s(s_section) <= y &&
		gst_s(s_section) + gsh(s_section) >= y)
	{
		var c_section = null;
		for (var idx=0;idx < s_section.child_sections.length;idx++)
		{
			var child = s_section.child_sections[idx];
			if (child.is_visible)
			{
				c_section = get_section_of_type_at_xy(child, type, x, y);
				if (c_section != null && c_section.real_type == type)
					return c_section;
			}
		}
		
		if (s_section != null && s_section.real_type == type)
			return s_section;
		else
			return null;
	}
	
	return null;
}