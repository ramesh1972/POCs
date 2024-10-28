function create_section_bar(section, pos)
{
	if (section == null)
		return null;

	section = go(section);
		
	// create the bar section
	var id = "bar_" + pos + "_" + section.id;
	
	var bar = create_section(section, id, 0, 0, 0, 0, "dock");
	bar.real_type = "bar";
	bar.dock_position = pos;
	
	gi(bar).min_section_width = 0;
	gi(bar).min_section_height = 0;
	
	bar.is_sizable = false;	

	var w = gsw(section);
	var h = gsh(section);

	sss(bar.inner_section_ref, "textAlign", "center");
	sss(bar.inner_section_ref, "verticalAlign", "middle");
    	
	if (pos == "top")
	{
		set_section_oi_dimension(bar, 0, 0, w, section.title_bar_thickness);
		bar.min_section_height = section.title_bar_thickness;
		
		add_property(bar, "is_fixed_height", true);
		section.bar_top = bar;		
	}
	else if (pos == "bottom")
	{
		set_section_oi_dimension(bar, 0, h-section.title_bar_thickness, w, section.title_bar_thickness);
		bar.min_section_height = section.title_bar_thickness;
		
		add_property(bar, "is_fixed_height", true);
		section.bar_bottom = bar;
	}
	else if (pos =="left")
	{
		set_section_oi_dimension(bar, 0, 0, section.title_bar_thickness, h);
		bar.min_section_width = section.title_bar_thickness;
		
		add_property(bar, "is_fixed_width", true);
		section.bar_left = bar;
	}
	else if (pos =="right")
	{
		set_section_oi_dimension(bar, w-section.title_bar_thickness, 0, section.title_bar_thickness, h);
		bar.min_section_width = section.title_bar_thickness;
		
		add_property(bar, "is_fixed_width", true);
		section.bar_right = bar;
	}

	set_bar_default_style(gi(bar));
	layout_bar_text(bar, section.title);
	
	// event handlers
	bar.handle.onmouseover = bar_mouseover;
	bar.handle.onmousedown = bar_mousedown;
	bar.handle.onmouseup = bar_mouseup;
	bar.handle.onmousemove = bar_mousemove;		
	bar.handle.onclick = bar_mouseclick;
	
	// move the bar to first position
	move_last_section_to_position(bar, 0);

	return bar;
}

function set_bar_default_style(inner)
{
	if (!is_bar(inner))
		return;
		
	sss(inner, "backgroundColor", "blue");
	sss(inner, "overflow", "hidden");
	sss(go(inner), "overflow", "hidden");
	
	sss(inner, "borderStyle", "none");
	sss(go(inner), "borderStyle", "none");
}

function is_bar(bar)
{
	bar = go(bar);
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

	bar = go(bar);
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
function layout_bar_text(section, text)
{
	if (section == null)
		return;
		
	if (!section.is_visible)
		return;
		
	if (is_bar(section.title_bar))
	{
		create_and_show_title_text(section.title_bar, "tit_" + section.id, section.bar, text, "arial", "white", section.title_font_size, "bold", "");								
		ssf(section.title_bar, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0)progid:DXImageTransform.Microsoft.Gradient(GradientType=1, StartColorStr='#FF0000FF', EndColorStr='#20000000')progid:DXImageTransform.Microsoft.Alpha( Opacity=100, FinishOpacity=0, Style=1, StartX=0,  FinishX=100, StartY=0, FinishY=100);");
	}	
	/*else if (is_bar(section))
	{
		create_and_show_text(section, "tit_" + section.id, section.dock_position, text, "arial", "white", section.title_font_size, "bold", "");								
		ssf(section, "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0)progid:DXImageTransform.Microsoft.Gradient(GradientType=1, StartColorStr='#FF0000FF', EndColorStr='#20000000')progid:DXImageTransform.Microsoft.Alpha( Opacity=100, FinishOpacity=0, Style=1, StartX=0,  FinishX=100, StartY=0, FinishY=100);");
	}*/	
}


