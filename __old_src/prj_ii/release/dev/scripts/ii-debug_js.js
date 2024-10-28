// debugging
var gdebug;
gdebugging = false;

function _d(t)
{
	if (!gdebugging)
		return;	
		
	if (gdebug == null)
		create_float_section();
		
	if (t == null)
		t = "Not Set";

	gdebug.innerHTML+= t +  "<BR>";
}

function _sm(owner, msg)
{
	if (!gdebugging)
		return;
		
	if (owner == "section info" ||
		owner == "remove_section" ||
		owner == "layout")		
	{
		alert(owner + "   " + msg);
//		_d(owner + "  "  + msg);
	}
}

function _ss(msg, section, deep)
{
	if (section == null)
	{
		_sm("section info", msg + " null");
		return;
	}

	var str = "";
	if (deep)
		str = msg + "\n" + _ssd(section, 0);
	else
		str = msg + "\n" + section.dock_position + "  id=" + section.id + "  " + "left=" + section.left + ", top = " + section.top + ", width = " + section.width + ",height = " + section.height;
			
	_sm("section info", str);
}


function _ssd(section, indent)
{
	if (section == null)
		return "";
	
	var str = "";
	if (true)
	{	
		indent++;
		var istr = "";
		for (var i=0;i< indent;i++)
			istr+="|..";
	
		var pid = "no parent";
		if (section.parent_section != null)
			pid = section.parent_section.id;

		str =  "type=" + section.section_type + "," + 
				" id=" + section.id + "," +
//				" pid=" + pid +"," + 
				" pos=" + section.position_type + "," + 
				" dpos=" + section.dock_position + "," + 
				" l=" + section.left + ", t=" + section.top + ", w=" + section.width + ",h=" + section.height +
				"\n";
	
		for(var idx=0; idx < section.child_sections.length;idx++)		
		{
			if (!is_border(section.child_sections[idx]) && !is_bar(section.child_sections[idx]))
			{
				var temp = _ssd(section.child_sections[idx], indent);
				if (temp != "")
					str+= istr + "-" + temp;
			}
		}
	}
			
	return str;
}

function _shtml(section)
{
	if (section == null)
		return "";
		
	var numc = get_number_of_child_sections(section);

	if (numc == 0 && !is_bar(section) && !is_border(section) && !is_tab(section) && !is_tab_bar(section))
	{
		var ppid = -1;
		var s = section;
			
		var str = "";
			
		s = section;

		while (s != null)
		{
			str += "<B>id=" + s.id + "</B>" + ",type=" + s.section_type + ",vis=" + s.is_visible + "<BR>" +  
					  " l=" + s.left + ", t=" + s.top + ", w=" + s.width + ",h=" + s.height + "<BR>" + 
					  " pos=" + s.position_type + "<BR>" + ",dpos=" + s.dock_position + "<BR>" +
					  " is_sizable=" + s.is_sizable +  " is_sized=" + s.is_sized + "<BR><BR>";

//			str +=  s.id + "</B> pos type=<B>" + s.position_type + "</B> dock_pos=<B>" + s.dock_position + "</B><BR>"; 
			s = s.parent_section;
		}
		
		return "<font size=1>" + str + "</font>";			
	}

	return "";
}

function page_onclick()
{
	var id = window.event.srcElement.id;
	alert(id);
}
