function show_text(section, id, pos, text)
{
	var spn = create_text(section, id, text);
	set_text_direction(section, id, pos);
}

function create_and_show_text(section, id, pos, text, face, color, size, weight, bgcolor)
{
	create_text(section, id, text);
	set_text_direction(section, id, pos);
	set_text_style(section, id, face, color, size, weight, bgcolor)
}

function create_text(section, id, text)
{
	var html_handle = section.handle;
	html_handle.innerHTML = "<div id=" + id + "><B>&nbsp;&nbsp;" + text + "&nbsp;&nbsp;</B></div>";
	var spn = html_handle.all(id);
	if (spn == null)
		return null;

	return spn;
}

function set_text_direction(section, id, pos)
{
	var html_handle = section.handle;
	var spn = html_handle.all(id);
	if (spn == null || spn.style == null)
		return null;
		
	g_ss(spn, "position", "absolute");
	if (pos == "left")
	{
		spn.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=3);";
		spn.style.posLeft = 0;
		spn.style.posTop = 0;
		spn.style.posWidth = section.height;
		spn.style.posHeight = section.width;
	}
	else if (pos == "right")
	{
		spn.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=1);";
		spn.style.posLeft = 0;
		spn.style.posTop = 0;
		spn.style.posWidth = section.height;
		spn.style.posHeight = section.width;
	}
	else if (pos == "top")
	{
		spn.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0);";
		spn.style.posLeft = 0;
		spn.style.posTop = 0;
		spn.style.posWidth = section.width;
		spn.style.posHeight = section.height;
	}
	else if (pos == "bottom")
	{
		spn.style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=0, xray=0, mirror=0, invert=0, opacity=1, rotation=0);";
		spn.style.posLeft = 0;
		spn.style.posTop = 0;
		spn.style.posWidth = section.width;
		spn.style.posHeight = section.height;
	}

	return spn;
}

function set_text_style(section, id, face, color, size, weight, bgcolor)
{
	var html_handle = section.handle;
	var spn = html_handle.all(id);
	if (spn == null || spn.style == null || spn.style == "undefined")
		return;
		
	g_ss(spn, "fontFamily", face);
	g_ss(spn, "fontWeight", weight);
	g_ss(spn, "fontSize", size);
	g_ss(spn, "color", color);
	g_ss(spn, "backgroundColor", bgcolor);
}