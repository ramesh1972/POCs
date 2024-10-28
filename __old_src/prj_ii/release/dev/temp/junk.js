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

// good one
// call this function on a section whose dimensions are "changed" 
// to set set the dimensions of the neighboring sections. This is recursive and
// set the dimensions of all the sections in the layout, based on the initial change.
// NOTE: This function should be called before doing the physical layout, that is posTOp, posWidth etc..
// should not be changed. On returning from this function simply call page_relayout()
//  ... example...say if a section x changed in height, then 
//			set_section_limits_and_adjust_surroundings(x);
//			relayout_page();
// these are enough to set the display of the whole page right
function set_section_limits_and_adjust_surroundings(section, is_pre_layout_check)
{
	// get surrounding sections
	var lsss = new Array();
	var rsss = new Array();
	var tsss = new Array();
	var bsss = new Array();

	// check the limits of the current section
	set_section_limits(section, is_pre_layout_check);
	
	if (is_pre_layout_check)
		get_pre_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
	else
		get_post_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
		
	// check the left ones
	for (var idx=0; idx<lsss.length;idx++)
	{
		var lss = lsss[idx];
		if (lss.limit_already_checked == false)
		{
			//set_dockset_sections_dimensions(section, lss);
			if (section.left - lss.left - cborder_thickness < lss.min_section_dim)
			{
				alert(2.1 + section.id + "," + lss.id);

				lss.width = lss.min_section_dim;				
				section.width = section.left +  section.width - (lss.left + lss.width + cborder_thickness);
				section.left = lss.left + lss.width + cborder_thickness;
				
				if (section.width < section.min_section_dim)
				{	
					alert(10);
					alert(section.width); // - section.min_section_dim));
					alert(section.id);
					section.parent_section.parent_section.width += section.min_section_dim - section.width;
				}	
				for (var idx1 = 0;idx1 < lsss.length;idx1++)
				{
					if (lsss[idx1].id == lss.id)
						continue;

					if (lss.handle.style.posLeft + lss.handle.style.posWidth == lsss[idx1].handle.style.posLeft + lsss[idx1].handle.style.posWidth)
					{
						lsss[idx1].width = (lss.left + lss.width) - (lsss[idx1].left);
						lsss[idx1].size_changed = true;
						lsss[idx1].limit_already_checked = true;
					}
				}
				
				lss.size_changed = true;
				section.size_changed = true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(lss);								
			}
			else if (lss.left + lss.width + cborder_thickness > section.left)
			{
				alert(2.2 + section.id + "," + lss.id);

				lss.width -= (lss.left + lss.width + cborder_thickness) - section.left;
				section.left = (lss.left + lss.width + cborder_thickness);

				lss.size_changed = true;
				section.size_changed = true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(lss);								
			}
			else if (section.left > lss.left + lss.width + cborder_thickness)
			{
				alert(2.3 + section.id + "," + lss.id);
				
				lss.width += section.left - (lss.left + lss.width + cborder_thickness);
				section.left = lss.left + lss.width + cborder_thickness;

				lss.size_changed = true;
				section.size_changed=true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(lss);				
			}
		}
	}
	
	// check the right sections
	for (idx=0; idx<rsss.length;idx++)
	{
		var rss = rsss[idx];
		if (rss.limit_already_checked == false)
		{
			//set_dockset_sections_dimensions(section, rss);
			if (rss.width - (section.left + section.width + cborder_thickness) + (rss.left) < section.min_section_dim)			
			{
				alert(3.1 + section.id + "," + rss.id);
				
				section.width = rss.left + rss.width - section.left - section.min_section_dim - cborder_thickness;
				rss.width = section.min_section_dim;
				rss.left = section.left+section.width+cborder_thickness;

				for (var idx1 = 0;idx1 < rsss.length;idx1++)
				{
					if (rsss[idx1].id == rss.id)
						continue;
						
					if (rss.handle.style.posLeft == rsss[idx1].handle.style.posLeft)
					{
						rsss[idx1].width += rsss[idx1].left - rss.left;
						rsss[idx1].left = rss.left;
						
						rsss[idx1].size_changed = true;				
						rsss[idx1].limit_already_checked = true;				
					}
				}				

				rss.size_changed = true;
				section.size_changed=true;
				
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(rss);												
			}
			else if (section.left + section.width + cborder_thickness > rss.left)
			{
				alert(3.2 + section.id + "," + rss.id);

				rss.width = rss.width - (section.left + section.width + cborder_thickness) + (rss.left);
				rss.left = section.left+section.width+cborder_thickness;

				rss.size_changed = true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(rss);												
			}
			else if (section.left + section.width + cborder_thickness < rss.left)
			{
				alert(3.3 + section.id + "," + rss.id);

				rss.width += rss.left - (section.left + section.width + cborder_thickness);
				rss.left =  section.left + section.width + cborder_thickness;

				rss.size_changed = true;
				section.limit_already_checked = true;					
				set_section_limits_and_adjust_surroundings(rss);							
			}
		}
	}	

	// check the top sections
	for (idx=0; idx<tsss.length;idx++)
	{
		var tss = tsss[idx];
		
		if (tss.limit_already_checked == false)
		{
			//set_dockset_sections_dimensions(section, tss);
			
			if (section.top - tss.top - cborder_thickness < section.min_section_dim)
			{
				alert(4.1 + section.id + "," + tss.id);
			
				if (tss.is_fixed_height == false)
				{
					tss.height = section.min_section_dim;				
					section.height = section.top +  section.height - (tss.top + tss.height + cborder_thickness);
					section.top = tss.top + tss.height + cborder_thickness;
				}
				
				for (var idx1 = 0;idx1 < tsss.length;idx1++)
				{
					if (tsss[idx1].id == tss.id)
						continue;

					if (tsss[idx1].is_fixed_height == true)
						continue;
						
					if (tss.handle.style.posTop + tss.handle.style.posHeight == tsss[idx1].handle.style.posTop + tsss[idx1].handle.style.posHeight)
					{
						tsss[idx1].height = (tss.top + tss.height) - (tsss[idx1].top);
						tsss[idx1].size_changed = true;
						tsss[idx1].limit_already_checked = true;
					}
				}

				tss.size_changed = true;
				section.size_changed=true;
				
				section.limit_already_checked = true;			
				set_section_limits_and_adjust_surroundings(tss);								
			}
			else if (tss.top + tss.height + cborder_thickness > section.top)
			{
				alert(4.2 + section.id + "," + tss.id);
				
				if (tss.is_fixed_height == false)
				{
					tss.height -= (tss.top + tss.height + cborder_thickness) - section.top;
					section.top = (tss.top + tss.height + cborder_thickness);
				}
				
				tss.size_changed = true;
				section.size_changed=true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(tss);								
			}
			if (section.top > tss.top + tss.height + cborder_thickness)
			{
				alert(4.3 + section.id + "," + tss.id);
				
				if (tss.is_fixed_height == false)
				{
					tss.height += section.top - (tss.top + tss.height + cborder_thickness);
					section.top = tss.top + tss.height + cborder_thickness;
				}
				
				tss.size_changed = true;
				section.size_changed=true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(tss);				
			}
		}
	}	

	// check the bottom sections
	for (idx=0; idx<bsss.length;idx++)
	{
		var bss = bsss[idx];
		if (bss.limit_already_checked == false)
		{
			//set_dockset_sections_dimensions(section, bss);
			
			if (bss.height - (section.top + section.height + cborder_thickness) + (bss.top) < section.min_section_dim)			
			{
				alert(5.1 + section.id + "," + bss.id);
				
				if (bss.is_fixed_height == false)
				{
					section.height = bss.top + bss.height - section.top - section.min_section_dim - cborder_thickness;
					bss.height = section.min_section_dim;
					bss.top = section.top+section.height+cborder_thickness;
				}

				for (var idx1 = 0;idx1 < bsss.length;idx1++)
				{
					if (bsss[idx1].id == bss.id)
						continue;
						
					if (bsss[idx1].is_fixed_height)
						continue;

					if (bss.handle.style.posTop == bsss[idx1].handle.style.posTop)
					{
						bsss[idx1].height += bsss[idx1].top - bss.top;
						bsss[idx1].top = bss.top;
						bsss[idx1].size_changed = true;						
						bsss[idx1].limit_already_checked = true;
					}
				}
				
				bss.size_changed = true;
				section.size_changed=true;
				section.limit_already_checked = true;		
				set_section_limits_and_adjust_surroundings(bss);												
			}
			else if (section.top + section.height + cborder_thickness > bss.top)
			{
				alert(5.2 + section.id + "," + bss.id);
				
				if (bss.is_fixed_height == false)
				{
					bss.height = bss.height - (section.top + section.height + cborder_thickness) + (bss.top);
					bss.top = section.top+section.height+cborder_thickness;
				}
				
				bss.size_changed = true;
				section.limit_already_checked = true;				
				set_section_limits_and_adjust_surroundings(bss);												
			}
			else if (section.top + section.height + cborder_thickness < bss.top)
			{
				alert(5.3 + section.id + "," + bss.id);

				if (bss.is_fixed_height == false)
				{
					bss.height += bss.top - (section.top + section.height + cborder_thickness);
					bss.top =  section.top + section.height + cborder_thickness;
				}
				
				bss.size_changed = true;
				section.limit_already_checked = true;					
				set_section_limits_and_adjust_surroundings(bss);							
			}
		}
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
		
		if (ss.section_type == "border") // || ss.section_type == "section_bar")
			continue;
				
		if (ss.id == section.id)
			continue;
			
		var ssl = gsl(ss);
		var sst = gst(ss);
		var ssr = gsr(ss);
		var ssb = gsb(ss);
		
		if (sl == ssr + cborder_thickness)
			lsss.push(ss);
		else if (sr + cborder_thickness == ssl)
			rsss.push(ss);

		if (sb + cborder_thickness == sst)
			bsss.push(ss);
		else if (st == ssb + cborder_thickness)
			tsss.push(ss);
	}	

	// sort the arrays
	// if array of bottoms, then sort by height ascending
//	tsss = tsss.sort(section_sorter_h);
//	bsss = bsss.sort(section_sorter_h);
	
//	lsss = tsss.sort(section_sorter_w);
//	rsss = bsss.sort(section_sorter_w);
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
	
	for (var idx=0; idx < section.parent_section.child_sections.length;idx++)
	{
		var ss = section.parent_section.child_sections[idx];
		if (ss.section_type == "border")
			continue;
			
		if (ss.id == section.id)
			continue;
			
		var ssl = gsal(ss);
		var sst = gsat(ss);
		var ssr = gsar(ss);
		var ssb = gsab(ss);
		
		if (sl == ssr + cborder_thickness)
			lsss.push(ss);
		else if (sr + cborder_thickness == ssl)
			rsss.push(ss);

		if (sb + cborder_thickness == sst)
			bsss.push(ss);
		else if (st == ssb + cborder_thickness)
			tsss.push(ss);
	}	

	// sort the arrays
	// if array of bottoms, then sort by height ascending
//	tsss = tsss.sort(section_sorter_h);
//	bsss = bsss.sort(section_sorter_h);
	
//	lsss = tsss.sort(section_sorter_w);
//	rsss = bsss.sort(section_sorter_w);
}

function section_sorter_h(x,y)
{
	if (gsh(x) < gsh(y))
		return -1;
		
	return 1;
}

function section_sorter_w(x,y)
{
	if (gsw(x) < gsw(y))
		return -1;
		
	return 1;
}
/*
function calculate_section_children_dimensions(container)
{
	//	gdebugging = false;
	_sm("layout", "calculate_section_children_dimensions");
	_ss("before", container, false);
	
	if (container.child_sections.length == 0)
		return null;
	
	_sm("layout", "container type " + container.section_type);
	
	// go through the collection of the child containers
	//	- based on the original width and height set the width/length of each child container
	var prev_container = null;
	var pmx = container.maxleft;
	var pmy = container.maxtop;
	var pmr = container.maxright;
	var pmb = container.maxbottom;
	var pw = 0;
	var ph = 0;

	var bthickness = cborder_thickness;
	
	for (var idx=0; idx < container.child_sections.length;idx++)
	{
		var child_container = container.child_sections[idx];

		if (child_container.section_type == "border")
			continue;
			
		if (child_container.is_visible == false)
			continue;
			
		if (child_container.is_sizable == false)
			bthickness = 0;
			
		var mx = container.maxleft;
		var my = container.maxtop;
		var mr = container.maxright;
		var mb = container.maxbottom;

		// calculate the width/height of the child containers
		_sm("layout", "mx=" + mx);
		_sm("layout", "my=" + my);
		_sm("layout", "mr=" + mr);
		_sm("layout", "mb=" + mb);

		_ss("child before", child_container, false);

		if (prev_container != null)
		{
			alert("prev con");
			if (mb-my <= 0)
			{
				if (prev_container.dock_position == "top")
				{
					prev_container.top = pmy;
					prev_container.height = ph;
					my = prev_container.top + prev_container.height + bthickness;
					mb = pmb;
					mx = pmx;
					mr = pmr;
				}
				else if (prev_container.dock_position == "bottom")
				{
					prev_container.top = pmb-ph;
					prev_container.height = ph;
					my = pmy;
					mb = prev_container.top - bthickness;
					mx = pmx;
					mr = pmr;
				}
			}				

			if (mr-mx <= 0)
			{
				if (prev_container.dock_position == "left")
				{
					prev_container.left = pmx;
					prev_container.width = pw;
					mx = prev_container.left + prev_container.width + bthickness;
					mr = pmr;
					my = pmy;
					mb = pmb;
				}			
				else if (prev_container.dock_position == "right")
				{
					prev_container.left = pmr-pw;
					prev_container.width = pw;
					mx = pmx;
					mr = prev_container.left - bthickness;
					my = pmy;
					mb = pmb;
				}			
			}
		}
		
		if (mb-my <= 0)
		{
			
			alert("no height for " + child_container.id);
			alert(mb-my);
			get_vspace_from_siblings(child_container);
			if (child_container.section_type == "top")
				my-=child_container.height;
			else (child_container.section_type == "bottom")
				mb+= child_container.height;
		}
			
		if (mr-mx <= 0)
		{
			alert("no width for " + child_container.id);
			get_hspace_from_siblings(child_container)
			if (child_container.section_type == "left")
				ml-=child_container.width;
			else (child_container.section_type == "right")
				mr+= child_container.width;
		}


		// save the current limits	
		pmx = mx;
		pmy = my;
		pmr = mr;
		pmb = mb;

		_sm("layout", "after set from prev");
		_sm("layout", "mx=" + mx);
		_sm("layout", "my=" + my);
		_sm("layout", "mr=" + mr);
		_sm("layout", "mb=" + mb);
		
//		pw = child_container.width;
//		ph = child_container.height;

		ssl(child_container, mx);
		sst(child_container, my);
		
		if (child_container.is_fixed_height == false)
			ssh(child_container, mb-my);
		
		if (child_container.is_fixed_width == false)
			ssw(child_container, mr-mx);


		// get the initials of dims
		var x = gsl(child_container);
		var y = gst(child_container);
		var w = gsw(child_container);
		var h = gsh(child_container);

		// recalculare the max limits	
		if (x + w + bthickness > container.maxleft)
			container.maxleft = x + w + bthickness;
		if (x-bthickness < container.maxright)
			container.maxright = x-bthickness;				
		if (y-bthickness < container.maxbottom)
			container.maxbottom = y-bthickness;
		if (y + h + bthickness > container.maxtop)
			container.maxtop = y+h+bthickness;

		_ss("after", child_container, false);
		
		container.size_changed = true;

//		prev_container = child_container;
	}	
		
	var mx = container.maxleft;
	var my = container.maxtop;
	var mr = container.maxright;
	var mb = container.maxbottom;
	if (mr < 0)
		container.maxright = 0;
	if (mb < 0)
		container.maxbottom = 0;
	
}
*/

/*
function calculate_section_children_dimensions(container)
{
	//gdebugging = true;	
	_sm("layout", "calculate_section_children_dimensions");
	_ss("before", container, false);

	var bthickness = cborder_thickness;

	if (container.child_sections.length == 0)
		return;

	// initialize the section limits to the dimensions of the container
	initialize_section_limits(container);
	var mx = container.maxleft;
	var my = container.maxtop;
	var mr = container.maxright;
	var mb = container.maxbottom;

	// then loop though the children and fit all sections with fixed width or height
	// - also calculate the remaining space.
	for (var idx=0; idx < container.child_sections.length;idx++)
	{
		var child_container = container.child_sections[idx];

		if (child_container.section_type == "border")
			continue;
			
		if (child_container.is_visible == false)
			continue;
			
		if (child_container.is_sizable == false)
			bthickness = 0;
		
		var setd = false;
		var w = mr-mx;
		var h = mb-my;
		
		if (child_container.is_fixed_width)
		{
			setd = true;
			w = gsw(child_container);
		}

		if (child_container.is_fixed_height)
		{
			setd = true;
			h = gsh(child_container);
		}	
			
		if (setd)
		{
			ssw(child_container, w);
			ssh(child_container, h);

			if (child_container.dock_position == "left")
			{
				ssl(child_container, mx);
				sst(child_container, my);
				mx+=w;
			}
			else if (child_container.dock_position == "right")
			{
				ssl(child_container, mr-w);
				sst(child_container, my);
				mr-=w;
			}
			else if (child_container.dock_position == "top")
			{
				ssl(child_container, mx);
				sst(child_container, my);
				my+=h;
			}
			else if (child_container.dock_position == "bottom")
			{
				ssl(child_container, mx);
				sst(child_container, mb-h);
				mb-= h;
			}			
		}
	}
	
	
	//	maximize/minimize the child dimensions to fit exactly with 
	var filled = false;
	for (idx=0; idx < container.child_sections.length;idx++)
	{
		var child_container = container.child_sections[idx];

		if (child_container.section_type == "border")
			continue;
			
		if (child_container.is_fixed_width || child_container.is_fixed_height)
			continue;
			
		if (child_container.is_visible == false)
			continue;
			
		if (child_container.is_sizable == false)
			bthickness = 0;
		
		_ss("child before", child_container, false);
			
		var w = gsw(child_container);
		var h = gsh(child_container);

		if (!filled)
		{
			ssl(child_container, mx);
			sst(child_container, my);
			ssw(child_container, mr-mx);
			ssh(child_container, mb-my);
			
			filled = true;		
		}
		else
		{
			// check if the current child has enough space, if not borrow it from its siblings
			if (child_container.dock_position == "left")
			{
				alert("no width for " + child_container.id);
				get_hspace_from_siblings(child_container);
				w = child_container.width;
				sst(child_container, my);
				ssh(child_container, mb-my);
			}
			else if (child_container.dock_position == "right")
			{
				alert("no width for " + child_container.id);
				get_hspace_from_siblings(child_container);
				w = child_container.width;
				sst(child_container, my);
				ssh(child_container, mb-my);
			}
			else if (child_container.dock_position == "top")
			{
				alert("no height for top" + child_container.id);
				get_vspace_from_siblings(child_container)
				h = child_container.height;
				ssl(child_container, mx);
				ssw(child_container, mr-mx);
			}
			else if (child_container.dock_position == "bottom")
			{
				alert("no height for bottom" + child_container.id);
				get_vspace_from_siblings(child_container)
				h = child_container.height;
				ssl(child_container, mx);
				ssw(child_container, mr-mx);
			}
			
			_ss("adjusted", child_container, false);
		}		
		
		if (child_container.dock_position == "left")
			mx+=w;
		else if (child_container.dock_position == "right")
			mr-=w;
		else if (child_container.dock_position == "top")
			my+=h;
		else if (child_container.dock_position == "bottom")
			mb-=h;

		_ss("after", child_container, false);
		
		child_container.size_changed = true;
	}	
	
	gdebugging = false;
}

function get_vspace_from_siblings(section)
{
	alert("vspace");
	if (section == null || section.parent_section == null)
		return;
	
	if (section.parent_section.child_sections.length == 1)
		return;
		
	var htoget = section.height;
		
	var idx_with_max_height = 0;
	for (var idx=0; idx < section.parent_section.child_sections.length;idx++)
	{
		var cs = section.parent_section.child_sections[idx];
		if (cs.id == section.id)
			continue;
		
		if (cs.section_type == "left" || cs.section_type == "right")
			continue;
			
		_ss("before adjust", cs, false);
		cs.height-= (htoget +cborder_thickness);
		if (cs.dock_position == "top")
		{
			alert("here");
			section.top = cs.top+cs.height+cborder_thickness;
		}
		else if (cs.dock_position == "bottom")			
		{
			section.top = cs.top;
			cs.top+= (htoget +cborder_thickness);
		}
		_ss("after adjust", cs, false);
		_ss("after adjust this", section, false);
		calculate_section_children_dimensions(cs);		
		break;
	}
	
	section.height = htoget;
}

function get_hspace_from_siblings(section)
{
	alert("hspace");
	if (section == null || section.parent_section == null)
		return;
	
	if (section.parent_section.child_sections.length == 1)
		return;
		
	var wtoget = section.width;
		
	var idx_with_max_width = 0;
	for (var idx=0; idx < section.parent_section.child_sections.length;idx++)
	{
		var cs = section.parent_section.child_sections[idx];
		if (cs.id == section.id)
			continue;
		
		if (cs.dock_position == "top" || cs.dock_position == "bottom")
			continue;

		cs.width-= (wtoget +cborder_thickness);
		if (cs.section_type == "left")
			section.left = cs.left+cs.width+cborder_thickness;
		else if (cs.section_type == "right")			
		{
			section.left = cs.left;
			cs.left+= (wtoget +cborder_thickness);
		}
		_ss("after adjust", cs, false);
		_ss("after adjust this", section, false);
		calculate_section_children_dimensions(cs);		
		break;
	}
	
	section.width = wtoget;
}
*/

function set_section_limits_and_adjust_surroundings(section, is_pre_layout)
{
	// get surrounding sections
	var lsss = new Array();
	var rsss = new Array();
	var tsss = new Array();
	var bsss = new Array();
		
	var bt = 0;	
	if (is_pre_layout)
		get_pre_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
	else
	{
		bt = cborder_thickness;
		get_post_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
	}

	// check the basic limits of the section
	set_section_limits(section, !is_pre_layout);
	
	// check the left ones
	for (var idx=0; idx<lsss.length;idx++)
	{
		var lss = lsss[idx];
		if (lss.limit_already_checked)
			continue;
					
		var recurse = false;
		if (section.width < section.min_section_dim)
		{
			alert(2 + section.id + "," + lss.id);

			var org_s_left = section.left;

			lss.width -= (section.min_section_dim - section.width);
			section.width = section.min_section_dim;
			section.left = lss.left + lss.width + bt;

			for (var idx1 = 0;idx1 < bsss.length;idx1++)
			{
				if (bsss[idx1].left == org_s_left)
				{
					bsss[idx1].width += (bsss[idx1].left) - (lss.left + lss.width);
					bsss[idx1].left = lss.left + lss.width;
					bsss[idx1].size_changed = true;
					bsss[idx1].limit_already_checked = false;
				}
			}

			for (idx1 = 0;idx1 < tsss.length;idx1++)
			{
				if (tsss[idx1].left == org_s_left)
				{
					tsss[idx1].width += (tsss[idx1].left) - (lss.left + lss.width);
					tsss[idx1].left = lss.left + lss.width;
					tsss[idx1].size_changed = true;
					tsss[idx1].limit_already_checked = false;
				}
			}
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		*/
		/*
		else if (section.left <= lss.left)
		{
			alert(2.1 + section.id + "," + lss.id);

			var org_s_left = section.left;
			
			section.width -= lss.left + lss.min_section_dim - section.left - bt;
			section.left = lss.left + lss.min_section_dim + bt;
			lss.width = lss.min_section_dim;

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.left < lss.left + lss.width + bt)
		{
			alert(2.2 + section.id + "," + lss.id);

			lss.width -= lss.left + lss.width - section.left;

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.left > lss.left + lss.width + bt)
		{
			alert(2.3 + section.id + "," + lss.id);
				
			section.width += section.left - lss.left + lss.width;
			section.left = lss.left + lss.width;
			
			section.limit_already_checked = true;				
			recurse = true;
		}

		if (recurse)
		*/
			set_section_limits_and_adjust_surroundings(lss, is_pre_layout);
	}
	
	// check the right sections
	for (idx=0; idx<rsss.length;idx++)
	{
		var rss = rsss[idx];
		//if (rss.limit_already_checked)
		//	continue;

		var recurse = false;

/*		if (section.width < section.min_section_dim)
		{
			alert(3 + section.id + "," + rss.id);

			var org_s_right = section.left + section.width;
			
//			if (section.left == 0)
			{
				//rss.width -= section.min_section_dim - section.width;
				section.width = section.min_section_dim;
//				rss.width = rss.left+ rss.width - section.left - section.width - bt;
//				rss.left =  section.left + section.width + bt;
				//ld(section);
				//ld(rss);
			}
//			else
//			{
//				section.left -= section.min_section_dim - section.width;
//				section.width = section.min_section_dim;
//				rss.left = section.left + section.width + bt;	
//			}		
/*			for (var idx1 = 0;idx1 < bsss.length;idx1++)
			{
				if (bsss[idx1].left + bsss[idx1].width == org_s_right)
				{
					bsss[idx1].width += rss.left - bsss[idx1].left;
					bsss[idx1].size_changed = true;
					bsss[idx1].limit_already_checked = false;
				}
			}

			for (idx1 = 0;idx1 < tsss.length;idx1++)
			{
				if (tsss[idx1].left + tsss[idx1].width == org_s_right)
				{
					tsss[idx1].width += rss.left - tsss[idx1].left;
					tsss[idx1].size_changed = true;
					tsss[idx1].limit_already_checked = false;
				}
			}

			section.limit_already_checked = false;				
			recurse = true;
		}		
*/
/*		if (section.left + section.width >= rss.left + rss.width)
		{
			alert(3.1 + section.id + "," + rss.id);

//			rss.left += rss.width - rss.min_section_dim;
//			rss.width = rss.min_section_dim;
//			section.width = rss.left - section.left - bt;				
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		else */
		if (section.left + section.width + bt > rss.left)
		{
			alert(3.2 + section.id + "," + rss.id);
				
//			rss.width -= (section.left + section.width)-rss.left;
//			rss.left += (section.left + section.width)-rss.left;
//			section.width -= bt;

			rss.left = section.left + section.width + bt;			
			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.left + section.width + bt < rss.left)
		{
			alert(3.3 + section.id + "," + rss.id);

			//section.width = rss.left - bt - section.left;
			rss.width += rss.left - (section.left + section.width);
			rss.left = section.left + section.width + bt;
			rss.width -= bt;
			section.limit_already_checked = false;					
			recurse = true;
		}
		
/*		if (section.width < section.min_section_dim)
		{
			alert(3 + section.id + "," + rss.id);

			var org_s_right = section.left + section.width;
			
//			if (section.left == 0)
			{
				section.width = section.min_section_dim;
				rss.width += rss.left - (section.left + section.width + bt);
				rss.left =  section.left + section.width + bt;
			}
//			else
//			{
//				section.left -= section.min_section_dim - section.width;
//				section.width = section.min_section_dim;
//				rss.left = section.left + section.width + bt;	
//			}		
			for (var idx1 = 0;idx1 < bsss.length;idx1++)
			{
				if (bsss[idx1].left + bsss[idx1].width == org_s_right)
				{
					bsss[idx1].width += rss.left - bsss[idx1].left;
					bsss[idx1].size_changed = true;
					bsss[idx1].limit_already_checked = false;
				}
			}

			for (idx1 = 0;idx1 < tsss.length;idx1++)
			{
				if (tsss[idx1].left + tsss[idx1].width == org_s_right)
				{
					tsss[idx1].width += rss.left - tsss[idx1].left;
					tsss[idx1].size_changed = true;
					tsss[idx1].limit_already_checked = false;
				}
			}

			section.limit_already_checked = false;				
			recurse = true;
		}		
*/
/*		if (rss.width < rss.min_section_dim)
		{
			alert(3.5 + section.id + "," + rss.id);

			var org_s_left = section.left;

			if (rss.left + rss.width == rss.parent_section.width)
			{
   				section.width -=(rss.min_section_dim - rss.width)
   				rss.width = rss.min_section_dim;
   				rss.left = section.left + section.width + bt;
			}
			else 
			{
   				rss.width = rss.min_section_dim;
			}
			

			section.limit_already_checked = false;				
			recurse = true;
		}
*/
		if (recurse)
		{
//			ld(section);
//			ld(rss);
			set_section_limits_and_adjust_surroundings(rss, is_pre_layout);
		}
	}	

	// check the top sections
	for (idx=0; idx<tsss.length;idx++)
	{
		var tss = tsss[idx];
		
		if (tss.limit_already_checked)
			continue;
			
		var recurse = false;
		if (section.height < section.min_section_dim)
		{
			alert(4 + section.id + "," + tss.id);

			var org_s_top = section.top;
			
			tss.height -= (section.min_section_dim - section.height);
			section.height = section.min_section_dim;
			section.top = tss.top + tss.height;

			for (var idx1 = 0;idx1 < lsss.length;idx1++)
			{
				if (lsss[idx1].top == org_s_top)
				{
					lsss[idx1].height += (lsss[idx1].top) - (tss.top + tss.height);
					lsss[idx1].top = tss.top + tss.height;
					lsss[idx1].size_changed = true;
					lsss[idx1].limit_already_checked = false;
				}
			}

			for (idx1 = 0;idx1 < rsss.length;idx1++)
			{
				if (rsss[idx1].top == org_s_top)
				{
					rsss[idx1].top = tss.top;
					rsss[idx1].height = (rsss[idx1].top + rsss[idx1].height) - (tss.top);
					rsss[idx1].size_changed = true;
					rsss[idx1].limit_already_checked = false;
				}
			}

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.top < tss.top)
		{
			alert(4.1 + section.id + "," + tss.id);

			section.height -= tss.top + tss.min_section_height - section.top;
			section.top = tss.top + tss.min_section_height;
			tss.height = tss.min_section_height;

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.top < tss.top + tss.height)
		{
			alert(4.2 + section.id + "," + tss.id);

			tss.height -= tss.top + tss.height - section.top;

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.top > tss.top + tss.height)
		{
			alert(4.3 + section.id + "," + tss.id);
				
			section.height += section.top - tss.top + tss.height;
			section.top = tss.top + tss.height;
			
			section.limit_already_checked = true;				
			recurse = true;
		}

		if (recurse)
			set_section_limits_and_adjust_surroundings(tss, is_pre_layout);
	}	

	// check the bottom sections
	for (idx=0; idx<bsss.length;idx++)
	{
		var bss = bsss[idx];
		if (bss.limit_already_checked)
			continue;
			
		var recurse = false;
		if (section.height < section.min_section_dim)
		{
			alert(5 + section.id + "," + bss.id);

			var org_s_bottom = section.top + section.height;
			
			bss.height -= (section.min_section_dim - section.height);
			bss.top += (section.min_section_dim - section.height);
			section.height = section.min_section_dim;
		
			for (var idx1 = 0;idx1 < lsss.length;idx1++)
			{
				if (lsss[idx1].top + lsss[idx1].height == org_s_bottom)
				{
					lsss[idx1].height += bss.top - lsss[idx1].top;
					lsss[idx1].size_changed = true;
					lsss[idx1].limit_already_checked = false;
				}
			}

			for (idx1 = 0;idx1 < rsss.length;idx1++)
			{
				if (rsss[idx1].top + rsss[idx1].height == org_s_bottom)
				{
					rsss[idx1].height += bss.top - rsss[idx1].top;
					rsss[idx1].size_changed = true;
					rsss[idx1].limit_already_checked = false;
				}
			}

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.top + section.height > bss.top + bss.height)
		{
			alert(5.1 + section.id + "," + bss.id);

			bss.top += bss.height - bss.min_section_height;
			bss.height = bss.min_section_height;
			section.height = bss.top - section.top;				
			
			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.top + section.height > bss.top)
		{
			alert(5.2 + section.id + "," + bss.id);
				
			bss.height -= (section.top + section.height)-bss.top;
			bss.top += (section.top + section.height)-bss.top;

			section.limit_already_checked = true;				
			recurse = true;
		}
		else if (section.top + section.height < bss.top)
		{
			alert(5.3 + section.id + "," + bss.id);

			//section.height = bss.top - section.top;

			section.limit_already_checked = true;					
			recurse = true;
		}
		
		if (recurse)
			set_section_limits_and_adjust_surroundings(bss, is_pre_layout);
	}	
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
function set_section_limits_and_adjust_surroundings(section, is_pre_layout)
{
	// get surrounding sections
	var lsss = new Array();
	var rsss = new Array();
	var tsss = new Array();
	var bsss = new Array();
		
	var bt = 0;	
	if (is_pre_layout)
		get_pre_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
	else
	{
		bt = cborder_thickness;
		get_post_layout_surrounding_sections(section, lsss, rsss, tsss, bsss);
	}
	
	// check the basic limits of the section
	set_section_limits(section, !is_pre_layout);
	
	// check the left ones
	for (var idx=0; idx<lsss.length;idx++)
	{
		var lss = lsss[idx];
		if (lss.limit_already_checked)
			continue;
					
		var recurse = false;
		
		if (section.width < section.min_section_dim)
		{
			//alert(2 + section.id + "," + lss.id);

			if (lss.width - (section.min_section_dim - section.width) < lss.min_section_dim && section.width + section.left != section.parent_section.width)
			{
				section.width = section.min_section_dim;
			}
			else
			{
				//alert(2.01);
				lss.width -= (section.min_section_dim - section.width);
				section.left -= (section.min_section_dim - section.width);
				section.width = section.min_section_dim;
			}
			
			section.limit_already_checked = true;				
			recurse = true;
		}

		if (section.left > lss.left + lss.width + bt)
		{
			//alert(2.2 + section.id + "," + lss.id);
				
			lss.width += (section.left) - (lss.left + lss.width);
			lss.width-= bt;
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.left < lss.left + lss.width + bt)
		{
			//alert(2.1 + section.id + "," + lss.id);

			lss.width -= lss.left + lss.width - section.left;
			lss.width -= bt;

			section.limit_already_checked = false;				
			recurse = true;
		}
			
		if (recurse)
		{
			lss.recurse = true;
			lds(section);
			lds(lss);
		}
	}
	
	// check the right sections
	for (idx=0; idx<rsss.length;idx++)
	{
		var rss = rsss[idx];
		if (rss.limit_already_checked)
			continue;

		var recurse = false;
		if (section.left + section.width + bt > rss.left)
		{
			//alert(3.1 + section.id + "," + rss.id);
				
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
			rss.left = section.left + section.width;
			rss.width -= bt;
			rss.left += bt;

			section.limit_already_checked = false;					
			recurse = true;
		}
		
		if (section.width < section.min_section_dim)
		{
			//alert(3 + section.id + "," + rss.id);

			rss.width -= (section.min_section_dim - section.width);
			rss.left += (section.min_section_dim - section.width);
			section.width = section.min_section_dim;

			section.limit_already_checked = true;				
			recurse = true;
		}		
				
		if (recurse)
		{
			rss.recurse = true;
			lds(section);
			lds(rss);
		}
	}	

	// check the top sections
	for (var idx=0; idx<tsss.length;idx++)
	{
		var tss = tsss[idx];
		if (tss.limit_already_checked)
			continue;
					
		var recurse = false;

		if (section.top < tss.top + tss.height + bt)
		{
			//alert(4.1 + section.id + "," + tss.id);

			tss.height -= tss.top + tss.height - section.top;
			tss.height -= bt;

			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.top > tss.top + tss.height + bt)
		{
			//alert(4.2 + section.id + "," + tss.id);
				
			tss.height += (section.top) - (tss.top + tss.height);
			tss.height-= bt;
			
			section.limit_already_checked = true;				
			recurse = true;
		}

		if (section.height < section.min_section_dim)
		{
			//alert(4 + section.id + "," + tss.id);

			if (tss.height - (section.min_section_dim - section.height) < tss.min_section_dim && section.height + section.top != section.parent_section.height)
			{
				section.height = section.min_section_dim;
			}
			else
			{
				//alert(4.01);
				tss.height -= (section.min_section_dim - section.height);
				section.top -= (section.min_section_dim - section.height);
				section.height = section.min_section_dim;
			}
			
			section.limit_already_checked = false;				
			recurse = true;
		}
		
		if (recurse)
		{
			tss.recurse = true;
				lds(section);
				lds(tss);
		}
	}

	// check the bottom sections
	for (idx=0; idx<bsss.length;idx++)
	{
		var bss = bsss[idx];
		if (bss.limit_already_checked)
			continue;
			
		var recurse = false;

		if (section.top + section.height + bt > bss.top)
		{
			//alert(5.1 + section.id + "," + bss.id);
				
			bss.height -= (section.top + section.height)-bss.top;
			bss.top += (section.top + section.height)-bss.top;
			bss.height -= bt;
			bss.top += bt;

			section.limit_already_checked = false;				
			recurse = true;
		}
		else if (section.top + section.height + bt < bss.top)
		{
			//alert(5.2 + section.id + "," + bss.id);

			bss.height += bss.top - (section.top + section.height);
			bss.top = section.top + section.height;
			bss.height -= bt;
			bss.top += bt;

			section.limit_already_checked = false;					
			recurse = true;
		}
		
		if (section.height < section.min_section_dim)
		{
			//alert(5 + section.id + "," + bss.id);

			bss.height -= (section.min_section_dim - section.height);
			bss.top += (section.min_section_dim - section.height);
			section.height = section.min_section_dim;

			section.limit_already_checked = true;				
			recurse = true;
		}		
				
		if (recurse)
		{
			bss.recurse = true;
			lds(section);
			lds(bss);
		}
	}	
	
	section.recurse = false;
	for (idx=0; idx<lsss.length;idx++)
	{
		if (lsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(lsss[idx], is_pre_layout);
	}

	for (idx=0; idx<rsss.length;idx++)
	{
		if (rsss[idx].recurse)
		{
			set_section_limits_and_adjust_surroundings(rsss[idx], is_pre_layout);
		}
	}

	for (idx=0; idx<tsss.length;idx++)
	{
		if (tsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(tsss[idx], is_pre_layout);
	}

	for (idx=0; idx<bsss.length;idx++)
	{
		if (bsss[idx].recurse)
			set_section_limits_and_adjust_surroundings(bsss[idx], is_pre_layout);
	}
}

function check_set_section_tree_limits(rsection, deep)
{
	if (rsection == null)
		return;
		
	if (rsection.section_type == "border")
		return;
	
	if (!rsection.is_visible)
		return;

	if (rsection.parent_section != null)
	{
		reset_limit_check(rsection.parent_section);
		set_section_limits_and_adjust_surroundings(rsection);
		set_section_children_current_dimensions(rsection.parent_section);
		set_section_children_current_dimensions(rsection);
	}
		
	// if this is not a deep display, then the function should return for super containers, 
	// but allow for the root container and the section containter, i.e. "container"
	if (!deep)
		return;
	
	// if deep loop through the children and recursively call this function
	// if not deep, then at the least display the sections contained.
	for (var idx=0; idx < rsection.child_sections.length;idx++)
		check_set_section_tree_limits(rsection.child_sections[idx], true);
}

function check_set_on_section_tree_overflow(rsection, deep)
{
	if (rsection == null)
		return false;
		
	if (rsection.section_type == "border")
		return false;
	
	if (!rsection.is_visible)
		return;
	
	// if this is not a deep display, then the function should return for super containers, 
	// but allow for the root container and the section containter, i.e. "container"
	if (!deep)
	{
		if (rsection.size_changed)
			// now this def. contains children that has to be resized, pre calculate their dimensions
			check_set_on_overflow(rsection);
	
		return;
	}
			
	// if deep loop through the children and recursively call this function
	// if not deep, then at the least display the sections contained.
	for (var idx=0; idx<rsection.child_sections.length;idx++)
		check_set_on_section_tree_overflow(rsection.child_sections[idx], true);

	if (rsection.size_changed)
		check_set_on_overflow(rsection);
}

function set_section_tree_borders(rsection, deep)
{
	if (rsection == null)
		return;
		
	if (rsection.section_type == "border")
		return;
	
	if (!rsection.is_visible)
		return;

	if (rsection.size_changed)
	{
		// now this def. contains children that has to be resized, pre calculate their dimensions
		set_section_borders(rsection);
		set_section_children_current_dimensions(rsection);
	}

	// if this is not a deep display, then the function should return for super containers, 
	// but allow for the root container and the section containter, i.e. "container"
	if (!deep)
		return;

	// if deep loop through the children and recursively call this function
	// if not deep, then at the least display the sections contained.
	for (var idx=0; idx<rsection.child_sections.length;idx++)
		set_section_tree_borders(rsection.child_sections[idx], true);
}

function layout_section_tree(rsection, deep)
{
	if (rsection == null)
		return;
		
	if (rsection.section_type == "border")
		return;
	
	if (!rsection.is_visible)
	{
		hide_section(rsection);
		return;
	}
	else
	{
		// display the current section
		if (rsection.size_changed)
			layout_section(rsection);
	}
						
	// if this is not a deep display, then the function should return for super containers, 
	// but allow for the root container and the section containter, i.e. "container"
	if (!deep)
		return;

	// loop through the children and recursively call this function
	for (var idx=0; idx<rsection.child_sections.length;idx++)
	{
		layout_section_tree(rsection.child_sections[idx], true);
	}
}
