function show_text(section, id, pos, text)
{
	var spn = create_text(section, id, text);
	set_text_direction(section, id, pos);
}

function create_and_show_text(section, id, pos, text, face, color, size, weight, bgcolor) {
	create_box_text(section, id, text);
	set_text_direction(section, id, pos);
	set_text_style(section, id, face, color, size, weight, bgcolor)
}

function create_and_show_title_text(section, id, pos, text, face, color, size, weight, bgcolor) {
    create_title_box_text(section, id, text);
    set_text_direction(section, id, pos);
    set_text_style(section, id, face, color, size, weight, bgcolor)
}

function create_text(section, id, text)
{
	var html_handle = section.handle;
	html_handle.innerHTML = "<span style=\"width:100%;height:100%;align:center;vertical-align:middle\" id=" + id + "><B>&nbsp;&nbsp;" + text + "&nbsp;&nbsp;</B></span>";
	var spn = html_handle.all(id);
	if (spn == null)
		return null;
	
	return spn;
}

function create_box_text(section, id, text) {
    var html_handle = section.handle;
    html_handle.innerHTML = "<table id=\"" + "table_" + id + "\" width=100% height=100% cellpadding=0 cellspacing=0 style=\"margin:0px;padding:0px;background-color:transparent\"><tr valign=middle><td align=center>" +
                                     "<div id=\"" + id + "\">" + text +"</div>" +
                                     "</td></tr></table>";
    var spn = html_handle.all(id);
    if (spn == null)
        return null;

    return spn;
}

function create_title_box_text(section, id, text) {
    var html_handle = section.handle;
    html_handle.innerHTML = "<table id=\"" + "table_" + id + "\" width=100% height=100% cellpadding=0 cellspacing=0 style=\"margin:0px;padding:0px\"><tr style=\"vertical-align:middle\"><td align=center style=\"margin:0px;width:100%;height:100%;align:center;vertical-align:middle;font-size:12px;font-weight:bold;margin:0px;padding:0px%\" id=\"" + id + "\" >" +
                                     "<B>" + text + "</B>" + 
                                     "</td></tr></table>";
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
		spn.style.width = gsh(section); //.height;
		spn.style.height = gsw(section); //.width;
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