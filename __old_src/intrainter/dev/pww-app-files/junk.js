function create_view_area_section()
{
	// create the outer div
  	var html="<div id=viewarea>";
	
	html += "</div>";
	document.write(html);

	// set the object
	var obj = document.all("viewarea");

	gviewsection = new CSection();

	gviewsection.outer_object = obj;
	gviewsection.parent_object = document.body;
	
	// defaults
	obj.style.position = "absolute";
	obj.style.marginLeft=0;	
	obj.style.paddingLeft=0;
	obj.style.borderWidth = 1;
	obj.style.marginTop=0;	
	obj.style.paddingTop=0;
	obj.style.marginBottom=0;	
	obj.style.paddingBottom=0;
	obj.style.marginRight=0;	
	obj.style.paddingRight=0;
	obj.style.borderStyle="solid";
	obj.style.borderColor="black";
	obj.style.backgroundColor="gray";
	obj.style.overflow = "auto";
}

function set_section_init_pos_size(section)
{
//	alert("setting init pos for section=" + section.id);
	var p = null;
	
	// if this is the topmost section
	if (section.parent_section == null)
	{
		section.left = 0;
		section.top = 0;
		section.width = document.body.clientWidth;
		section.height = document.body.clientHeight;
		section.owidth = section.width;
		section.oheight = section.height;
		
		section.maxleft = section.left+section.width;
		section.maxtop = section.top+section.height;
		section.maxright = 0;
		section.maxbottom = 0;		

		return;
	}
	
	//section.parent_section.size_changed = false;
	
	// every other section must have a parent_Section, at the least the parent should be gtop_section
	var horz_before_section = null;
	var horz_after_section = null;
	var vert_before_section = null;
	var vert_after_section = null;
	
	// now compute the width and height
	if (section.parent_section.width < section.width)	
	{
		section.parent_section.size_changed = true;		
		section.parent_section.width = section.width;
	}
		
	if (section.parent_section.height < section.height)	
	{
		section.parent_section.height = section.height;
		section.parent_section.size_changed = true;		
	}
	// TODO, all the sections before before and after after sections have to be altered with new page dimensions.


	if (section.dock_position == "left")
	{
		for (var il=0; il < section.parent_section.child_sections.length; il++)
		{
			var cs = section.parent_section.child_sections[il];
				
			if (cs.id == section.id)
				continue;
				
			if (cs.left > section.parent_section.maxleft)
				continue;

			if (cs.dock_position == "left")
			{
				if (section.left > cs.left)
				{
					if (horz_before_section != null)
					{
						if (cs.left > horz_before_section.left)
							horz_before_section = cs; 
					}
					else
						horz_before_section = cs;
				}

				if (section.left < cs.left)
				{
					if (horz_after_section != null)
					{
						if (cs.left < horz_after_section.left)
							horz_after_section = cs;
					}
					else
						horz_after_section = cs;
				}
					
				if (section.left == cs.left)
					horz_after_section = cs;
			}
							
			if (cs.dock_position == "top" || cs.dock_position == "bottom")
			{
				if (section.top > cs.top)
				{
					if (vert_before_section != null)
					{
						if (cs.top < vert_before_section.top)
							vert_before_section = cs; 
					}
					else
						vert_before_section = cs;
				}

				if (section.top < cs.top)
				{
					if (vert_after_section != null)
					{
						if (cs.top < vert_after_section.top)
							vert_after_section = cs;
					}
					else
						vert_after_section = cs;
				}

				if (section.top == cs.top)
					horz_after_section = cs;
			}
		}

		alert_section("initing current", section);
		alert_section("horz before", horz_before_section);
		alert_section("horz after", horz_after_section);
		alert_section("vert before", vert_before_section);
		alert_section("vert after", vert_after_section);
		
	

		if (horz_before_section != null && horz_after_section != null)
		{
			var w = Math.ceil(section.width/2);
			horz_before_section.width-=w;
			horz_after_section.width-=w;
			section.left = horz_before_section.left + horz_before_section.width + cborder_thickness;
			section.width-= cborder_thickness;
			horz_after_section.left = section.left+section.width+cborder_thickness;

			horz_before_section.size_changed = true;
			horz_after_section.size_changed = true;		

		}
		else if (horz_before_section != null)
		{
			horz_before_section.width -= section.width+cborder_thickness;
			section.left = horz_before_section.left + horz_before_section.width + cborder_thickness;
			horz_before_section.size_changed = true;
		}
		else if (horz_after_section	!= null)
		{
			section.left = 0;
			horz_after_section.width -=  section.width+cborder_thickness; 
			horz_after_section.left = section.left+section.width+cborder_thickness;
			horz_after_section.size_changed = true;	
		}
		else
		{
			section.left = 0;
		 //USE section.width = section.parent_section.maxleft; 
		}

		if (vert_before_section != null && vert_after_section != null)
		{
			section.top = vert_before_section.top + vert_before_section.height + cborder_thickness;
			section.height = vert_after_section.top-section.top-cborder_thickness;
		}
		else if (vert_before_section != null)
		{	
			if (horz_before_section != null && horz_before_section.top == vert_before_section.top+vert_before_section.height + cborder_thickness)
			{
				section.top = horz_before_section.top;
				section.height = horz_before_section.height;
			}
			else if (horz_after_section != null && horz_after_section.top == vert_before_section.top+vert_before_section.height + cborder_thickness)
			{
				section.top = horz_after_section.top;
				section.height = horz_after_section.height;
			}
			else
			{
				vert_before_section.height-=section.height+cborder_thickness;
				section.top = vert_before_section.top + vert_before_section.height + cborder_thickness;
				section.height = section.parent_section.maxtop-section.top;
			}
		}
		else if (vert_after_section	!= null)
		{
			if (horz_before_section != null && horz_before_section.top + horz_before_section.height + cborder_thickness == vert_after_section.top)
			{
				section.top = horz_before_section.top;
				section.height = horz_before_section.height;
			}
			if (horz_after_section != null && horz_after_section.top + horz_after_section.height + cborder_thickness == vert_after_section.top)
			{
				section.top = horz_after_section.top;
				section.height = horz_after_section.height;
			}
			else
			{
				section.top = 0;
				section.height = vert_after_section.top-cborder_thickness;
			}
		}
		else
		{
			section.top = 0;
			section.height = section.parent_section.maxtop; 
		}
	}
	
	if (section.dock_position == "top")
	{
		for (il=0; il < section.parent_section.child_sections.length; il++)
		{
			var cs = section.parent_section.child_sections[il];
				
			if (cs.id == section.id)
				continue;
				
			if (cs.top > section.parent_section.maxtop)
				continue;

			if (cs.dock_position == "left" || cs.dock_position == "right")
			{
				if (section.left > cs.left)
				{
					if (horz_before_section != null)
					{
						if (cs.left > horz_before_section.left)
							horz_before_section = cs; 
					}
					else
						horz_before_section = cs;
				}

				if (section.left < cs.left)
				{
					if (horz_after_section != null)
					{
						if (cs.left < horz_after_section.left)
							horz_after_section = cs;
					}
					else
						horz_after_section = cs;
				}
					
				if (section.left == cs.left)
					horz_after_section = cs;
			}
							
			if (cs.dock_position == "top")
			{
				if (section.top > cs.top)
				{
					if (vert_before_section != null)
					{
						if (cs.top < vert_before_section.top)
							vert_before_section = cs; 
					}
					else
						vert_before_section = cs;
				}

				if (section.top < cs.top)
				{
					if (vert_after_section != null)
					{
						if (cs.top < vert_after_section.top)
							vert_after_section = cs;
					}
					else
						vert_after_section = cs;
				}

				if (section.top == cs.top)
					vert_after_section = cs;
			}
		}

		alert_section("initing current", section);
		alert_section("horz before", horz_before_section);
		alert_section("horz after", horz_after_section);
		alert_section("vert before", vert_before_section);
		alert_section("vert after", vert_after_section);
	
	
		if (vert_before_section != null && vert_after_section != null)
		{
			var h = Math.ceil(section.height/2);

			vert_before_section.height-=h;
			vert_after_section.height-=h;
			
			section.top = vert_before_section.top + vert_before_section.height + cborder_thickness;
			section.height-= cborder_thickness;
			
			vert_after_section.top = section.top+section.height + cborder_thickness;
			
			vert_before_section.size_changed = true;
			vert_after_section.size_changed = true;		
		}
		else if (vert_before_section != null)
		{
			vert_before_section.height -= section.height+cborder_thickness;
			section.top = vert_before_section.top + vert_before_section.height + cborder_thickness;
			vert_before_section.size_changed = true;

		}
		else if (vert_after_section	!= null)
		{
			section.top = 0;
			vert_after_section.height -= section.height+cborder_thickness; 
			vert_after_section.top = section.top+section.height+cborder_thickness;

			vert_after_section.size_changed = true;	
		}
		else
		{
			section.top = 0;
			//USE section.height = section.parent_section.maxtop; 
		}			

		if (horz_before_section != null && horz_after_section != null)
		{
			section.left = horz_before_section.left + horz_before_section.width + cborder_thickness;
			section.width = horz_after_section.left - cborder_thickness - section.left;
		}
		else if (horz_before_section != null)
		{	
			if (vert_before_section != null && vert_before_section.left == vert_before_section.left+vert_before_section.width + cborder_thickness)
			{
				section.left = vert_before_section.left;
				section.width = vert_before_section.width;
			}
			else if (vert_after_section != null && vert_after_section.left == vert_before_section.left+vert_before_section.width + cborder_thickness)
			{
				section.left = vert_before_section.left;
				section.width = vert_before_section.width;
			}
			else
			{
				vert_before_section.width-=section.width+cborder_thickness;
				section.left = vert_before_section.left + vert_before_section.width + cborder_thickness;
				section.width = section.parent_section.maxtop-section.left;
			}
		}
		else if (horz_after_section	!= null)
		{
			if (vert_before_section != null && vert_before_section.left + vert_before_section.width + cborder_thickness == vert_after_section.left)
			{
				section.left = vert_before_section.left;
				section.width = vert_before_section.width;
			}
			if (vert_after_section != null && vert_after_section.left + vert_after_section.width + cborder_thickness == vert_after_section.left)
			{
				section.left = vert_after_section.left;
				section.width = vert_after_section.width;
			}
			else
			{
				section.left = 0;
				section.width = vert_after_section.left-cborder_thickness;
			}
		}
		else
		{
			section.left = 0;
			section.width = section.parent_section.maxleft; 
		}		
	}	
	
	// set max limits
	section.maxleft = section.top + section.height;
	section.maxtop = section.left + section.width;
	section.maxright = 0;
	section.maxbottom = 0;
	
	section.size_changed = true;
}

function create_left_dockset_section(section)
{
	var caboveindex = -1;
	var cbelowindex = -1;

	// find the dock row and the section in it above/below where the current one has to be displayed							
	var dmaxleft = 0;
	for (var idx1 = 0; idx1 < gcount; idx1++)
	{
		if (gsections[idx1].id == section.id)
			break;
			
		if (gsections[idx1].position_type != "dock" || gsections[idx1].dock_position != "left")
			continue;
						
		var dx = gsections[idx1].left;
					
		// find a section in the desired dock row
		if (section.left > dx && dx >= dmaxleft)
			dmaxleft = dx;
		else if (section.left == dx)
		{
			dmaxleft = dx;// TODO: then a complete new column
		}
	}

	var dmaxtop = 0;
	for (var idx2 = 0; idx2 < gcount; idx2++)
	{
		if (gsections[idx2].id == section.id)
			break;

		if (gsections[idx2].position_type != "dock" || gsections[idx2].dock_position != "left")
			continue;
						
		var dx = gsections[idx2].left;
		var dy = gsections[idx2].top;
					
		// find a section in the desired dock row
		if (dx >= dmaxleft)
		{
			if (section.top > dy)
			{
				if (dy >= dmaxtop)
				{
					caboveindex = idx2;
					cmaxtop = dy;
				}
			}
			else 
			{
				if (cbelowindex == -1 || dy <= gsections[cbelowindex].top)
					cbelowindex = idx2;
			}
		}
	}

	if (caboveindex != -1)
	{
		// ok found a section that has to be docked.
		gsections[caboveindex].is_left_dockset = true;
		gsections[caboveindex].is_left_dockset_topmost = true;
		
		// set limits for sizing
		var maxtop = gsections[caboveindex].top;
		var maxbot = gsections[caboveindex].top + gsections[caboveindex].height;
				
		if (cbelowindex != -1)
			maxbot = gsections[cbelowindex].top + gsections[cbelowindex].height;;

		// set dimensions of current section and cabove section
		// set left, width easy
		section.left = gsections[caboveindex].left;
					
		if (section.width <= gsections[caboveindex].width)
			section.width = gsections[caboveindex].width;
		else
		{
			gsections[caboveindex].width = section.width;
			gmaxleft+= (section.width-gsections[caboveindex].width);
		}
					
		if (cbelowindex != -1)
		{
			gsections[cbelowindex].left = gsections[caboveindex].left;
			gsections[cbelowindex].width = gsections[caboveindex].width;
		}
				
		// set top and bottom
		if (section.top -60 < maxtop)
		{
			gsections[caboveindex].height = 60; // minimum height
			section.top = gsections[caboveindex].top + gsections[caboveindex].height + cborder_thickness;
		}
		else	
			gsections[caboveindex].height = section.top - maxtop - cborder_thickness;				
				
		// set the dimensions of the below section
		if (cbelowindex != -1)									
		{
			gsections[cbelowindex].top=section.top+section.height+cborder_thickness;
			gsections[cbelowindex].height = maxbot - gsections[cbelowindex].top;
		}
		else
			section.height = maxbot - section.top;
					
		// set the min limits, all heights must be atleast 60
		if (gsections[caboveindex].height < 60)
		{
			if (section.height > 0)
			{
				gsections[caboveindex].height = 60;
				section.top = gsections[caboveindex].top + gsections[caboveindex].height + cborder_thickness;
			}
		}
				
		// check height
		if (section.height < 60)
		{
			if (cbelowindex != -1)
			{
				if (gsections[cbelowindex].height > 60)
				{
					section.height = 60;
					gsections[cbelowindex].top=section.top+section.height+cborder_thickness;				
					gsections[cbelowindex].height = maxbot - gsections[cbelowindex].top;
				}
			}
			else
			{
				if (gsections[caboveindex].height > 60)
				{
					section.height = 60;
					section.top = maxbot-60;
					gsections[caboveindex].height = section.top-maxtop-cborder_thickness;
				}
			}
		}
				
		if (cbelowindex != -1 && gsections[cbelowindex].height  < 60)
		{
			if (section.height > 60)
			{
				section.height-=(60-gsections[cbelowindex].height);
				gsections[cbelowindex].top=section.top+section.height+cborder_thickness;				
				gsections[cbelowindex].height = maxbot - gsections[cbelowindex].top;
			}
		}

		// check tops and bottoms
		if (gsections[caboveindex].top < maxtop)
			gsections[caboveindex].top = maxtop;
					
		if (gsections[caboveindex].top +  gsections[caboveindex].height > maxbot)
			gsections[caboveindex].height = maxbot-gsections[caboveindex].top;
				
		if (section.top < maxtop)
			section.top = maxtop;
					
		if (section.top +  section.height > maxbot)
			section.height = maxbot-section.top;
				
		if (cbelowindex != -1)
		{
			if (gsections[cbelowindex].top < maxtop)
				gsections[cbelowindex].top = maxtop;
						
			if (gsections[cbelowindex].top +  gsections[cbelowindex].height > maxbot)
				gsections[cbelowindex].height = maxbot-gsections[cbelowindex].top;
		}
				
	}						
	else if (cbelowindex != -1 && gsections[cbelowindex] != null)
	{	
		section.is_left_dockset_topmost = true;
		gsections[cbelowindex].is_left_dockset = true;
		
		// set limits for sizing
		var maxtop = gsections[cbelowindex].top;
		var maxbot = gsections[cbelowindex].top + gsections[cbelowindex].height;

		// set the dimensions of this section and the cbelowsection
		section.left = gsections[cbelowindex].left;
			
		if (section.width <= gsections[cbelowindex].width)
		{
			section.width = gsections[cbelowindex].width;
			// _debug("have set section.width " +section.width);					
		}
		else
		{
			gmaxleft+= (section.width-gsections[cbelowindex].width);
			gsections[cbelowindex].width = section.width;
		}				

		section.top = maxtop;
		gsections[cbelowindex].top = section.top + section.height+cborder_thickness;
		gsections[cbelowindex].height = maxbot - gsections[cbelowindex].top;
				
		// check the limits, all heights have to be atleast 60;
		if (section.height < 60)
		{
			if (gsections[cbelowindex].height > 60)
			{
				section.height = 60;
				gsections[cbelowindex].top=60+cborder_thickness;
				gsections[cbelowindex].height = maxbot-gsections[cbelowindex].top;
			}
		}
		if (gsections[cbelowindex].height < 60)
		{
			if (section.height > 60)
			{
				gsections[cbelowindex].height = 60;
				gsections[cbelowindex].top=maxbot-60;
				section.height=gsections[cbelowindex].top-section.top-cborder_thickness;
			}
		}
				
		// check tops and bottoms
		if (section.top < maxtop)
			section.top = maxtop;
					
		if (section.top +  section.height > maxbot)
			section.height = maxbot-section.top;
				
		if (gsections[cbelowindex].top < maxtop)
			gsections[cbelowindex].top = maxtop;
						
		if (gsections[cbelowindex].top +  gsections[cbelowindex].height > maxbot)
			gsections[cbelowindex].height = maxbot-gsections[cbelowindex].top;
	}
	else
		;//	TODO Display the dock at maxleft
		
	if (caboveindex != -1 || cbelowindex != -1)
	{
		if (section.border_left == null)
			section.border_left = create_border(section);
		section.border_left.can_merge = true;
					
		if (section.border_top == null)
			section.border_top = create_border(section);
		section.border_top.can_merge = false;
					
		if (section.border_right == null)				
			section.border_right = create_border(section);
		section.border_right.can_merge = true;
					
		if (section.border_bottom == null)
			section.border_bottom = create_border(section);
		section.border_bottom.can_merge = false;
		
		// redisp above and below sections
		if (caboveindex != -1)
		{
			_dump_section(gsections[caboveindex]);
			layout_section(gsections[caboveindex]);
		}
						
		if (cbelowindex != -1)
		{
			_dump_section(gsections[cbelowindex]);
			layout_section(gsections[cbelowindex]);
		}
				
		_dump_section(section);
		
		return true; // indicate  left dockset was found and section created
	}
	
	// indicate not left dockset was found
	return false;
}

function set_section_page_limits(section)
{
	var x = section.left;
	var y = section.top;
	var w = section.width;
	var h = section.height;

	// set the min/max limts dimensions of the section
	if (y < 0)
	{
		y = 0;
		if (section.border_right != null)
			section.border_right.top = 0;
		if (section.border_left != null)
			section.border_left.top = 0;
	}
			
	if (x < 0)
	{
		x = 0;
		if (section.border_top != null)
			section.border_top.left = 0;
		if (section.border_bottom != null)
			section.border_bottom.left = 0;
	}
	
	if (y + h >= document.body.clientHeight)
	{
		h = document.body.clientHeight - y;
		if (section.border_right != null)
			section.border_right.height = h;
		if (section.border_left != null)
			section.border_left.height = h;
	}

	if (x+ w >= document.body.clientWidth)
	{
		w = document.body.clientWidth - x;
		if (section.border_top != null)
			section.border_top.width = w;
		if (section.border_bottom != null)
			section.border_bottom.width = w;
	}
	
	// reset the sections dims
  	section.left = x;
	section.top = y;
	section.width = w;
	section.height = h;
}

function resize_page()
{
/*
	// get the difference in height and width
	var px = (document.body.clientWidth - gbody_width)/document.body.clientWidth;
	var py = (document.body.clientHeight - gbody_height)/document.body.clientHeight;
	
	for (var idx=0; idx < gcount; idx++)
	{
		var section = gsections[idx];
	
		var oh = section.height;
		section.width+= section.width*px;
		section.width = Math.ceil(section.width);
		section.height+=section.height*py;
		section.height = Math.ceil(section.height);
		
		section.initialized = false;
	}

	layout_page();
	
	gbody_width = document.body.clientWidth;
	gbody_height = document.body.clientHeight;
*/	
}

function calculate_container_boundary(container)
{
	_sm("layout", "calculate_container_boundary");
	_ss("before", container, false);
	
	if (container.parent_section == null)
		return;
		
	var mx = container.parent_section.maxleft;
	var my = container.parent_section.maxtop;
	var mr = container.parent_section.maxright;
	var mb = container.parent_section.maxbottom;
	
	_sm("layout", "mx=" + mx);
	_sm("layout", "my=" + my);
	_sm("layout", "mr=" + mr);
	_sm("layout", "mb=" + mb);
	
	if (container.dock_position == "left")
	{
		ssl(container, mx);
		sst(container, my);
		ssh(container, mb-my);
	}
	else if (container.dock_position == "top")
	{
		sst(container, my);
		ssl(container, mx);
		ssw(container, mr-mx);
	}
	else if (container.dock_position == "bottom")
	{
		sst(container, mb-gsh(container));
		ssl(container, mx);
		ssw(container, mr-mx);
	}
							
	else if (container.dock_position == "right")
	{
		ssl(container, mr-gsw(container));
		sst(container, my);
		ssh(container, mb-my);
	}
	
	// if the width is greater then the parent width/or available width, then increase the parent width
	var x = gsl(container);
	var y = gst(container);
	var w = gsw(container);
	var h = gsh(container);

	if (w > mr-mx) 
		w-= (mr-mx)-(x+w+cborder_thickness);
		
	if (h > mb-my) 
		h-= (mb-my)-(y+h+cborder_thickness);
		
	ssw(container, w);
	ssh(container, h);
	
	container.size_changed = true;
	_ss("after", container, false);	
}

// this will calculate the current available boundaries within a parent section. So pass in a parent section
function recalculate_parent_section_limits(section)
{	
	if (section.parent_section == null)
		return;
		
	var x = gsl(section);
	var y = gst(section);
	var w = gsw(section);
	var h = gsh(section);
	
	if (section.parent_section.dock_position == "left" && x + w + cborder_thickness > section.parent_section.maxleft)
		section.parent_section.maxleft = x + w + cborder_thickness;
	else if (section.parent_section.dock_position == "right" &&  x-cborder_thickness < section.parent_section.maxright)
		section.parent_section.maxright = x-cborder_thickness;				
	else if (section.dock_position == "bottom" && y-cborder_thickness < section.parent_section.maxbottom)
		section.parent_section.maxbottom = y-cborder_thickness;
	else if (section.dock_position == "top" && y + h + cborder_thickness > section.parent_section.maxtop)
		section.parent_section.maxtop = y+h+cborder_thickness;
}

/*		// remove parent section from its container
		array_remove_element(parent_section.parent_section.child_sections, parent_section);
		parent_section.parent_section.view_object.removeChild(parent_section.boundary_object);
		
		// create a new container for the parent section
		var pcontainer = create_container_section("cc_" + parent_section.id);
		
		// set the pcontainers parent to the parent of the parent section
		pcontainer.parent_section = parent_section.parent_section;
		add_section_to_parent_collection(pcontainer);
		pcontainer.parent_section.section_type = "super_container";
		pcontainer.parent_section.view_object.appendChild(pcontainer.boundary_object);
		//set_super_container_dimension(pcontainer);
										
		// move the parent section to this container
		parent_section.parent_section = pcontainer;
		add_section_to_parent_collection(parent_section);
		parent_section.parent_section.view_object.appendChild(parent_section.boundary_object);
		//set_super_container_dimension(parent_section);				

		// set the new container for the new section that is being added to that of the pcontainer 
		// and add the section to its collection
		container.parent_section = pcontainer.parent_section;
		add_section_to_parent_collection(container);
		container.parent_section.view_object.appendChild(container.boundary_object);				
		
		
		//set_super_container_dimension(pcontainer);
		// add the newly created section to the newly create container
		section.parent_section = container;
		add_section_to_parent_collection(section);
		section.parent_section.view_object.appendChild(section.boundary_object);
		container.dock_position = section.dock_position;
		
		alert(container.id);
		set_container_dimension(container,section);		
		set_container_dimension(pcontainer, parent_section);
		set_super_container_dimension(container.parent_section);
*/		

function set_dockset_sections_dimensions(changed_section, dockset_section)
{
	if (changed_section. id == dockset_section.id)
		return;
		
	var ssd = changed_section.outer_object.style;
	var sectiond = dockset_section.outer_object.style;

	if ((changed_section.dock_position == "left" && dockset_section.dock_position == "left") ||
		(changed_section.dock_position == "right" && dockset_section.dock_position == "right"))
	{
		if (ssd.posLeft == sectiond.posLeft  && ssd.posLeft+ssd.posWidth == sectiond.posLeft + sectiond.posWidth)
			dockset_section.width = changed_section.width;
	}
}
