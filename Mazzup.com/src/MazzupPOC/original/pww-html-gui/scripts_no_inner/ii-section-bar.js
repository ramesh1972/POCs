function create_section_bar(section, pos)
{
	if (section == null)
		return null;

	// create the bar section
	var id = "bar_" + pos + "_" + section.id;
	
	var bar = create_section(section, id, 0, 0, 0, 0, "dock");
	bar.real_type = "bar";
	bar.dock_position = pos;
	
	bar.min_section_width = 0;
	bar.min_section_height = 0;
	
	bar.is_sizable = false;	

	var w = gsw(section);
	var h = gsh(section);
	
	if (pos == "top")
	{
		set_section_dimension(bar, 0, 0, w, section.bar_thickness);
		bar.min_section_height = section.bar_thickness;
		
		add_property(bar, "is_fixed_height", true);
		section.bar_top = bar;		
	}
	else if (pos == "bottom")
	{
		set_section_dimension(bar, 0, h-section.bar_thickness, w, section.bar_thickness);
		bar.min_section_height = section.bar_thickness;
		
		add_property(bar, "is_fixed_height", true);
		section.bar_bottom = bar;
	}
	else if (pos =="left")
	{
		set_section_dimension(bar, 0, 0, section.bar_thickness, h);
		bar.min_section_width = section.bar_thickness;
		
		add_property(bar, "is_fixed_width", true);
		section.bar_left = bar;
	}
	else if (pos =="right")
	{
		set_section_dimension(bar, w-section.bar_thickness, 0, section.bar_thickness, h);
		bar.min_section_width = section.bar_thickness;
		
		add_property(bar, "is_fixed_width", true);
		section.bar_right = bar;
	}

	set_bar_default_style(bar);
	layout_bar_text(bar);
	
	// event handlers
	bar.handle.onmouseover = bar_mouseover;
	bar.handle.onmousedown = bar_mousedown;
	bar.handle.onmouseup = bar_mouseup;
	bar.handle.onmousemove = bar_mousemove;		
	bar.handle.onclick = bar_mouseclick;
	
	// move the bar to first position
	move_last_section_to_position(bar, 0);
}

function set_bar_default_style(bar) {
    sss(bar, "backgroundColor", "blue");
    sss(bar, "overflow", "hidden");
	sss(bar, "borderStyle", "none");
}

function is_bar(bar)
{
	if (bar != null && bar.real_type == "bar")
		return true;
		
	return false;
}

function get_bar_from_id(id)
{
	var bid = id.substr(4);
	var bar = get_section_from_id(groot_container, bid);
		
	if (bar == null)
	{	
		if (id.match("g_"))
		{
			bid = id.substr(2);
			bar = get_section_from_id(groot_container, bid);
		}
	}

	return bar;
}

// ==================================================================
function show_bar(section, side)
{
}

function hide_bar(section, side)
{
}

function dock_bar(section, from_side, to_side)
{

}

// ==================================================================
function layout_bar_text(section)
{
	if (section == null)
		return;
		
	if (!section.is_visible)
		return;
		
	if (is_bar(section))
	{
		create_and_show_text(section, "tit_" + section.id, section.dock_position, section.parent_section.id, "arial", "white", 12, "", "blue");								
		ssf(section, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0)progid:DXImageTransform.Microsoft.Gradient(GradientType=1, StartColorStr='#FF0000FF', EndColorStr='#20000000')progid:DXImageTransform.Microsoft.Alpha( Opacity=100, FinishOpacity=0, Style=1, StartX=0,  FinishX=100, StartY=0, FinishY=100);");
	}	
}


