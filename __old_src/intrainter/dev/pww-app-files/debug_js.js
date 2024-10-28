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
	
	indent++;
	var istr = "";
	for (var i=0;i< indent;i++)
		istr+="|  ";
	
	var pid = "no parent";
	if (section.parent_section != null)
		pid = section.parent_section.id;
		
	var str =  "type=" + section.section_type + "," + 
				" id=" + section.id + "," +
				" pid=" + pid +"," + 
				" dock_pos=" + section.dock_position + "," + 
				" left=" + section.left + ", top=" + section.top + ", width=" + section.width + ",height=" + section.height +
				"\n";
	
	for(var idx=0; idx < section.child_sections.length;idx++)		
		str+= istr + "-" + _ssd(section.child_sections[idx], indent);
		
	return str;
}
