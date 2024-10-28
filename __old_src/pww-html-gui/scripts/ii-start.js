function page_main()
{
	document.body.onclick = page_onclick;
	document.body.onresize = resize_page;
	document.body.onmousemove = body_mousemove; 
	create_root_container();
}

function rock_and_roll_tabs() {
    var section1 = add_section(groot_container, "rnr1", 0, 0, 400, 100, "", "dock");
    add_property(section1, "dock_position", "left");
    add_property(section1, "bar", "left");

    var section11 = add_section(section1, "rnr11", 0, 0, 400, 400, "", "dock");
    add_property(section11, "dock_position", "top");
    add_property(section11, "bar", "bottom");

    var section12 = add_section(section1, "rnr12", 0, 0, 400, 200, "", "dock");
    add_property(section12, "dock_position", "bottom");
    add_property(section12, "bar", "right");

}

function rock_and_roll() 
{
    var section1 = add_section(groot_container, "rnr1", 0, 0, 400, 100, "", "dock");
        add_property(section1, "dock_position", "left");
        add_property(section1, "bar", "left");

        var section11 = add_section(section1, "rnr11", 0, 0, 400, 400, "", "dock");
            add_property(section11, "dock_position", "top");
            add_property(section11, "bar", "bottom");

        var section12 = add_section(section1, "rnr12", 0, 0, 400, 200, "", "dock");
            add_property(section12, "dock_position", "bottom");
            add_property(section12, "bar", "right");

    var section2 = add_section(groot_container, "rnr2", 0, 0, 50, 200, "", "dock");
        add_property(section2, "dock_position", "top");
        add_property(section2, "bar", "top");

    var section3 = add_section(groot_container, "rnr3", 0, 0, 400, 100, "", "dock");
        add_property(section3, "dock_position", "right");

        var section7 = add_section(null, "rnr7", 100, 50, 200, 200, "", "popin");
            //add_property(section7, "dock_position", "bottom");
            add_property(section7, "bar", "bottom");

        var section8 = add_section(null, "rnr8", 0, 0, 400, 200, "", "popout");
            //add_property(section8, "dock_position", "top");
            add_property(section8, "bar", "right");

    var section4 = add_section(groot_container, "rnr4", 0, 0, 50, 100, "", "dock");
        add_property(section4, "dock_position", "bottom");
        add_property(section4, "bar", "top");

        var section5 = add_section(section4, "rnr5", 0, 0, 400, 300, "", "tab");
            add_property(section5, "bar", "right");
            add_property(section5, "tab_length", 140);
            add_property(section5, "tab_breadth", 50);
            add_property(section5, "tabbar_padding", 20);
            add_property(section5, "tab_position", "bottom");

            var section9 = add_section(section5, "rnr9", 100, 30, 300, 150, "", "stack");
                add_property(section9, "bar", "left");

            var section10 = add_section(section5, "rnr10", 250, 200, 100, 100, "", "float");
                add_property(section10, "bar", "left");
    
        var section6 = add_section(section4, "rnr6", 0, 0, 150, 150, "", "tab");
            add_property(section6, "bar", "right");

        var section14 = add_section(section4, "rnr14", 0, 0, 250, 200, "", "dock");
            add_property(section14, "dock_position", "left");
            add_property(section14, "bar", "bottom");

        var section15 = add_section(section4, "rnr15", 0, 0, 400, 200, "", "dock");
            add_property(section15, "dock_position", "right");
            add_property(section15, "bar", "right");

    var section13 = add_section(groot_container, "rnr13", 100, 100, 150, 100, "", "stick");
        add_property(section13, "bar", "left");
        add_property(section13, "stick_right", true);
        add_property(section13, "stick_top", true);
}

// =============================================================================
// single left dock
function create_single_ld(id)
{
	section1 = add_section(groot_container, "l_" + id , 0, 0, 400,100, "", "dock");
		add_property(section1, "dock_position", "left");
		add_property(section1, "bar", "left");
		add_property(section1, "bar", "top");

}

// double left dock
function create_double_ld(id)
{
	create_single_ld(id + "_" + "1");
	create_single_ld(id + "_" + "2");
	
}

// triple left dock
function create_triple_ld(id)
{
	create_single_ld(id + "_" + "1");
	create_single_ld(id + "_" + "2");
	create_single_ld(id + "_" + "3");	
}

// =============================================================================
// single top dock
function create_single_td()
{
	create_docking_section(groot_container, "1", 0,0,50,100,"", "top");
}

// double top dock
function create_double_td()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "top",  "view", true);
	create_docking_section(groot_container,"2", 0,0,50,30,"", "top",  "view", true);
}

// triple top dock
function create_triple_td()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "top",  "view", true);
	create_docking_section(groot_container,"2", 0,0,50,30,"", "top",  "view", true);
	create_docking_section(groot_container,"3", 0,0,50,100,"", "top",  "view", true);
}

// =============================================================================
// single right dock
function create_single_rd()
{
	create_docking_section(groot_container,"1", 0,0,10,100,"", "right",  "view", true);
}

// double right dock
function create_double_rd()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "right",  "view", true);
	create_docking_section(groot_container,"2", 0,0,150,300,"", "right",  "view", true);
}

function create_triple_rd()
{
	create_docking_section(groot_container,"1", 0,0,350,300,"", "right",  "view", true);
	create_docking_section(groot_container,"2", 0,0,250,300,"", "right",  "view", true);
	create_docking_section(groot_container,"3", 0,0,250,300,"", "right",  "view", true);
}

// =============================================================================
// single bottom dock
function create_single_bd()
{
	create_docking_section(groot_container,"1", 0,0,50,200,"", "bottom",  "view", true);
}

// double right dock
function create_double_bd()
{
	create_docking_section(groot_container,"1", 0,0,50,120,"", "bottom",  "view", true);
	create_docking_section(groot_container,"2", 0,0,150,120,"", "bottom",  "view", true);
}

function create_triple_bd()
{
	create_docking_section(groot_container,"1", 0,0,50,120,"", "bottom",  "view", true);
	create_docking_section(groot_container,"2", 0,0,150,120,"", "bottom",  "view", true);
	create_docking_section(groot_container,"3", 0,0,50,120,"", "bottom",  "view", true);
}

// =============================================================================
// simple all dock
function simple_docks()
{
	section1 = add_section(groot_container, "sd_1", 0, 0, 400,100, "", "dock");
		add_property(section1, "dock_position", "left");
		add_property(section1, "bar", "left");
		add_property(section1, "bar", "top");
		
	section2 = add_section(groot_container, "sd_2", 0, 0, 300,100, "", "dock");
		add_property(section2, "dock_position", "top");
		add_property(section2, "bar", "top");
		
	section3 = add_section(groot_container, "sd_3", 0, 0, 400,200, "", "dock");
		add_property(section3, "dock_position", "bottom");
		add_property(section3, "bar", "right");
		add_property(section3, "bar", "bottom");
		
	section4 = add_section(groot_container, "sd_4", 0, 0, 150,150, "", "dock");
		add_property(section4, "dock_position", "right");
		add_property(section4, "bar", "right");
}

function simple_tabs()
{
	section0 = add_section(groot_container, "st_0", 0, 0, 350,300, "", "dock");
		add_property(section0, "dock_position", "left");
		add_property(section0, "is_right_sizable", true);
				
	section1 = add_section(groot_container, "st_1", 0, 0, 350,300, "", "dock");
		add_property(section1, "dock_position", "left");
		add_property(section1, "bar_thickness", "40");
		add_property(section1, "bar", "top");		

				
	section2 = add_section(groot_container, "st_2", 0, 0, 300,300, "", "dock");
		add_property(section2, "dock_position", "top");
		add_property(section2, "bar", "top");
		
	section3 = add_section(section2, "st_3", 0, 0, 400,300, "", "tab");
		add_property(section3, "bar", "right");
		add_property(section3, "tab_length", 140);
		add_property(section3, "tab_breadth", 70);
		add_property(section3, "tabbar_padding", 20);
		add_property(section3, "tab_position", "right");
				
	section4 = add_section(section2, "sc_4", 0, 0, 150,150, "", "tab");
		add_property(section4, "bar", "right");

/*	section5 = add_section(section1, "sc_5", 0, 0, 100,100, "", "tab");
		add_property(section5, "bar", "left");
		
	section6 = add_section(section1, "sc_6", 0, 0, 100,100, "", "tab");
		add_property(section6, "bar", "left");
*/
	section7 = add_section(groot_container, "st_7", 0, 0, 300,60, "", "dock");
		add_property(section7, "dock_position", "top");
		add_property(section7, "bar", "top");
}

function simple_floats()
{
	section1 = add_section(groot_container, "sf_1", 10, 30, 100,100, "", "float");
		add_property(section1, "bar", "left");
		add_property(section1, "bar", "top");
		
	section5 = add_section(groot_container, "sf_5", 150, 30, 100,100, "", "float");
		add_property(section5, "bar", "right");

	add_section(null, "sf_7", 100, 100, 200, 300, "", "popout");
	popin_section(section5);
	section2 = add_section(groot_container, "sf_2", 0, 0, 300,100, "", "dock");
		add_property(section2, "dock_position", "top");
		add_property(section2, "bar", "top");
		
	section3 = add_section(groot_container, "sf_3", 0, 0, 400,200, "", "dock");
		add_property(section3, "dock_position", "top");
		add_property(section3, "bar", "right");
		add_property(section3, "bar", "bottom");
		
	section4 = add_section(section3, "sf_4", 10, 10, 120,120, "", "float");
		add_property(section4, "bar", "right");
		add_property(section4, "url", "htmls/home.html");
		
		add_property(groot_container, "border_thickness", 2);
	
	stack_section(section4);
	
	section4 = add_section(null, "sf_6", 10, 10, 120,120, "", "popin");
	
	
}

function simple_stacks()
{
	section1 = add_section(groot_container, "ss_1", 10, 30, 200,100, "", "stack");
		add_property(section1, "bar", "left");
		add_property(section1, "bar", "top");
		
	section2 = add_section(groot_container, "ss_2", 0, 0, 300,100, "", "dock");
		add_property(section2, "dock_position", "left");
		add_property(section2, "bar", "top");
		
	section3 = add_section(groot_container, "ss_3", 0, 0, 400,200, "", "dock");
		add_property(section3, "dock_position", "right");
		add_property(section3, "bar", "right");
		add_property(section3, "bar", "bottom");
		
	section4 = add_section(section3, "ss_4", 10, 10, 120,120, "", "stack");
		add_property(section4, "bar", "right");

	section5 = add_section(groot_container, "ss_5", 10, 30, 100,50, "", "stack");
		add_property(section5, "bar", "bottom");

	section6 = add_section(groot_container, "ss_6", 10, 30, 60,120, "", "stack");
		add_property(section6, "bar", "right");
		
	add_property(section3, "border_thickness", 2);
}

function simple_sticks()
{
	section1 = add_section(groot_container, "ss_1", 10, 30, 100,100, "", "stick");
		add_property(section1, "bar", "left");
		//add_property(section1, "stick_right", true);
		//add_property(section1, "stick_top", true);
		
	section2 = add_section(groot_container, "ss_2", 0, 0, 300,100, "", "dock");
		add_property(section2, "dock_position", "left");
		add_property(section2, "bar", "top");
		
	section3 = add_section(groot_container, "ss_3", 0, 0, 40,20, "", "dock");
		add_property(section3, "dock_position", "right");
		add_property(section3, "bar", "right");
		add_property(section3, "bar", "bottom");
		
	section4 = add_section(section3, "ss_4", 10, 10, 200,120, "", "stick");
		add_property(section4, "bar", "right");
		add_property(section4, "stick_left", true);
		add_property(section4, "stick_bottom", true);

	section5 = add_section(section3, "ss_5", 10, 30, 110,80, "", "stick");
		add_property(section5, "bar", "bottom");
		add_property(section5, "stick_left", true);
		add_property(section5, "stick_top", true);
}

function simple_contained_docks()
{
	add_property(groot_container, "border_thickness", 3);
	section1 = add_section(groot_container, "sc_1", 0, 0, 400,100, "", "dock");
		add_property(section1, "dock_position", "left");
		add_property(section1, "bar", "left");
		add_property(section1, "bar", "top");
		add_property(section1, "border_thickness", 2);
		
	section2 = add_section(groot_container, "sc_2", 0, 0, 300,100, "", "dock");
		add_property(section2, "dock_position", "top");
		add_property(section2, "bar", "top");
		
	    section3 = add_section(section1, "sc_3", 0, 0, 400,200, "", "dock");
		    add_property(section3, "dock_position", "bottom");
		    add_property(section3, "bar", "right");
		    add_property(section3, "bar", "bottom");
		
	    section4 = add_section(section1, "sc_4", 0, 0, 150,150, "", "dock");
		    add_property(section4, "dock_position", "top");
		    add_property(section4, "bar", "right");
		    add_property(section4, "border_thickness", 10);

	        section5 = add_section(section4, "sc_5", 0, 0, 100,100, "", "dock");
		        add_property(section5, "dock_position", "left");

	        section5 = add_section(section4, "sc_6", 0, 0, 100,100, "", "dock");
		        add_property(section5, "dock_position", "top");
}

function simple_docks_in_floats()
{
	section1 = create_floating_section(groot_container, "1", 100, 100, 400,100, "", "view", true);
		add_section_bar(section1, "top");
		add_section_bar(section1, "left");
		add_section_bar(section1, "right");
		add_section_bar(section1, "bottom");

	section2 = create_floating_section(groot_container, "2", 300, 300, 300,100, "", "view", true);
			add_section_bar(section2, "bottom");
			create_docking_section(section2, "6", 100, 100, "", "left","view", true);
			section3 = create_docking_section(section2, "8", 100, 100, "", "top","view", true);
				add_section_bar(section3, "left");
			create_docking_section(section2, "7", 100, 100, "", "right","view", true);
			
}
// simple all dock double
function simple_all_double_dock()
{
	create_docking_section(groot_container, "1", 0,0,100,100, "", "left", "view", true);
	create_docking_section(groot_container, "1", 0,0,380,100, "", "top", "view", true);
	create_docking_section(groot_container, "1", 0,0,200, 200, "", "right","view", true);		
	create_docking_section(groot_container, "1", 0,0,100,300, "", "bottom","view", true);
	create_docking_section(groot_container, "2", 0,0,100,100, "", "left", "view", true);
	create_docking_section(groot_container, "2", 0,0,380,100, "", "top", "view", true);
	create_docking_section(groot_container, "2", 0,0,200, 200, "", "right", "view", true);		
	create_docking_section(groot_container, "2", 0,0,100,300, "", "bottom", "view", true);
}

function simple_all_contained_dock()
{
	section1 = create_docking_section(groot_container, "1", 0,0,200,50, "", "left","view", false);
			   create_docking_section(groot_container, "1", 0,0,100,160, "", "top","view", false);
	section2 = create_docking_section(groot_container, "1", 0,0,200,10, "", "right","view", false);	
			   create_docking_section(groot_container, "2", 0,0,30, 200, "", "bottom","view", true);		
			   create_docking_section(groot_container, "3", 0,0,50,100, "", "bottom","view", true);
			   create_docking_section(groot_container, "2", 0,0,100,50, "", "top","view", false);


		       create_docking_section(section1, "2", 0,0,100,100, "", "left","view", false);
		       
		       create_docking_section(section1.parent_section, "3", 0,0,120,260, "", "top","view", true);
			   create_docking_section(section2, "3", 0,0,100, 100, "", "left","view", true);		
}

// =============================================================================
function create_complex_docks()
{
	section1 = create_docking_section(groot_container, "1", 0,0,200, 100, "", "left","view", false);		
	section2 = create_docking_section(groot_container, "2", 0,0,380,80, "", "top","view", false);
	section3 = create_docking_section(groot_container, "1", 0,0,100,100, "", "right","view", false);
	section3 = create_docking_section(groot_container, "2", 0,0,100,100, "", "right","view", false);
	section4 = create_docking_section(groot_container, "3", 0,0,100,100, "", "right","view", false);
	
	section5 = create_docking_section(section1, "4", 0,0,390,100, "", "bottom","view", false);
	create_docking_section(section2, "4", 0,0,390,70, "", "left","view", false);
	create_docking_section(section5, "4", 0,0,30,50, "", "top","view", false);
	section4 = create_docking_section(groot_container, "1", 0,0,100, 100, "", "top","view", false);		
	section2 = create_docking_section(groot_container, "23", 0,0,180,80, "", "top","view", false);

	section3 = create_docking_section(groot_container, "23", 0,0,100,100, "", "bottom","view", false);
	section4 = create_docking_section(groot_container, "43", 0,0,300, 100, "", "left","view", false);
	section3 = create_docking_section(groot_container, "43", 0,0,10,10, "", "top","view", false);
	section1 = create_docking_section(groot_container, "44", 0,0,39,40, "", "bottom","view", false);
	section4 = create_docking_section(groot_container, "44", 0,0,30, 10, "", "top","view", false);

	section4 = create_docking_section(section1, "2", 0,0,150,90,"", "left","view", false);
	section5 = create_docking_section(section4, "3", 0,0,70,80,"", "left","view", false);
	section5 = create_docking_section(section4.parent_section, "3", 0,0,10,80,"", "top","view", true);
	section5 = create_docking_section(section5, "3", 0,0,70,80,"", "bottom","view", false);
	create_docking_section(section1.parent_section, "3", 0,0,60,90,"", "top","view", false);
	create_docking_section(section1.parent_section, "3", 0,0,60,90,"", "bottom","view", false);

	create_docking_section(section2, "4", 0,0,80,100,"", "left","view", false);
	
	section7 = create_docking_section(section2.parent_section, "4", 10,0,90,80,"", "top",  "view", true);

//	create_docking_section(section7, "6", 0,0,50,50,"", "left",  "view", true);

	//section10 = create_docking_section(section3, "7", 10,0,60,180,"", "top",  "view", true);
	//section11 = create_docking_section(section7, "8", 0,0,60,80,"", "top",  "view", true);
	//section4 = create_docking_section(groot_container, "2", 100,50,150,200,"", "top",  "view", true);
	//section3 = create_docking_section(section2.parent_section, "12", 0,0,10,10,"", "bottom",  "view", true);

	//create_docking_section(section1.parent_section, "5", 0,0,200,100,"", "right",  "view", true);
	//create_docking_section(section1.parent_section, "5", 0,0,200,100,"", "left",  "view", true);

	//create_docking_section(section1.parent_section,"2", 10,0,170,200,"", "right",  "view", true);
	//create_docking_section(groot_container,"2", 100,0,60,200,"", "right",  "view", true);
}

// =============================================================================
// double left dock row
function create_double_dockset_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,200,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,200,100,250,"", "left",  "view", true);
}

function create_double_dockset_ld_with_flip()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,-10,100,100,"", "left",  "view", true);
}

// triple left dock row
function create_triple_dockset_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,350,100,200,"", "left",  "view", true);
}

function create_triple_dockset_ld_with_flip()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,100,100,200,"", "left",  "view", true);
}

function create_quadruple_dockset_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,160,100,200,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,250,100,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_3", 10,350,100,200,"", "left",  "view", true);
}

function create_dockset_double_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  "view", true);
	
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  "view", true);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  "view", true);
}

function create_dockset_double_ld_with_flip()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  "view", true);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  "view", true);
}

// triple left dock with top & bottom
function create_dockset_ld_with_top_bottom()
{
	create_docking_section(groot_container,"dt", 0,0,50,80,"", "top",  "view", true);
	create_docking_section(groot_container,"db", 0,0,200,90,"", "bottom",  "view", true);
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  "view", true);
}

function create_dockset_double_ld_with_top_bottom()
{
	create_docking_section(groot_container,"dt", 0,0,50,80,"", "top",  "view", true);
	create_docking_section(groot_container,"db", 0,0,200,90,"", "bottom",  "view", true);
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  "view", true);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  "view", true);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  "view", true);
}

// complex left dock row
function create_dockset_ld_complex()
{
	create_docking_section(groot_container,"1", 0,0,200,50,"", "bottom",  "view", true);
	create_docking_section(groot_container,"dt", 0,0,50,50,"", "top",  "view", true);
	create_docking_section(groot_container,"1", 0,0,50,80,"", "top",  "view", true);
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  "view", true);
	create_docking_section(groot_container,"1_1", 10,-10,10,350,"", "left",  "view", true);
	create_docking_section(groot_container,"1_2", 10,30,100,200,"", "left",  "view", true);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  "view", true);

	create_docking_section(groot_container,"db", 0,0,200,90,"", "bottom",  "view", true);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  "view", true);
	create_docking_section(groot_container,"dr", 0,0,200,70,"", "right",  "view", true);
	create_docking_section(groot_container,"2", 0,0,200,90,"", "bottom",  "view", true);
}

// iframes
function create_sections_with_frames()
{
	create_docking_section(groot_container,"test2", 0,0,80,100,"file:///c:/MyReleases/intrainter/dev/pww-app-files/openurl.html", "top",  "view", true);
	create_floating_div_section("test3", 10,50,520,520,"file:///C:/MyReleases/intrainter/dev/pww-archive/PWW/Temp/10_10_10/rendered.html");
}

// tabs
function create_tabbed_sections()
{
	create_docking_section(groot_container, "1", 0,0,100,100, "", "left","view", true);
	create_docking_section(groot_container, "2", 0,0,300,100, "", "left","view", true);
	
//	create_docking_section(groot_container, "3", 0,0,80,100, "", "right","view", true);
//	create_docking_section(groot_container, "4", 100,50,200,200,"", "right", "view", true);
	
	section1 = create_docking_section(groot_container,"5", 100,50,200,200,"", "left", "view", true);
	section2 = create_tabbed_section(section1, "6", 0, 0, 400, 50, "", "bottom", "view", true);
			   create_tabbed_section(section1, "7", 100,50,200,200,"", "left", "view", true);
 			   create_tabbed_section(section1, "8", 0,0,200, 200, "", "top","view", true);		
//	create_docking_section(groot_container, "9", 0,0,100,300, "", "bottom","view", true);
	
//	section2 = create_docking_section(groot_container,"3", 210,50,200,100,"", "top",  "view", true);
//	create_tabbed_section(section2, "4", 0, 0, 100, 50, "", "bottom", "view", true);		
//	create_tabbed_section(section1, "4", 0, 0, 150, 50, "", "left", "view", true);	
//	section5 = create_tabbed_section(section1,"51", 210,50,400,200,"", "left",  "view", true);	
//	section5 = create_tabbed_section(section1.tab_container.tab_container,"61", 210,50,200,200,"", "left",  "view", true);
//	create_docking_section(section5, "33", 100,50,200,200,"", "left", "view", true);
}

function create_tabbed_sections_contained()
{
//	create_docking_section(groot_container,"1", 210,50,200,200,"", "top",  "view", true);	
	section1 = create_docking_section(groot_container, "2", 0,0,200,50, "", "left","view", true);
	section2 = create_docking_section(groot_container, "3", 0,0,200,10, "", "right","view", false);	

	create_docking_section(section1, "4", 0,0,100,100, "", "top","view", true);
	create_docking_section(section1, "5", 0,0,120,260, "", "top","view", true);
	create_docking_section(section2, "6", 0,0,100, 100, "", "left","view", true);		

	create_tabbed_section(section1, "9", 0, 0, 150, 50, "", "bottom", "view", true);
	create_tabbed_section(section1, "7", 0, 0, 70, 50, "", "bottom", "view", true);
	create_tabbed_section(section2, "8", 0, 0, 100, 50, "", "top", "view", true);		

	
//	create_tabbed_section(section2.parent_section, "6", 0, 0, 150, 50, "", "left", "view", true);		

}

function create_float_sections()
{
	section1 = create_docking_section(groot_container, "1", 0,0,100,100, "", "left","view", true);
	create_docking_section(groot_container, "2", 0,0,80,100, "", "right","view", true);
	create_docking_section(groot_container, "3", 0,0,200, 200, "", "top","view", true);		
	create_docking_section(groot_container, "4", 0,0,100,300, "", "bottom","view", true);

	create_sticky_section(section1, "5", 60,40, false, true, true, false, "", "plain", true);	
	create_sticky_section(section1, "6", 60,40, true, true, true, false, "", "plain", true);	
	create_sticky_section(section1, "7", 60,40, true, false, false, true, "", "plain", true);	
	create_sticky_section(groot_container, "8", 160,140, false, false, true, true, "", "view", true);	
	
	create_stacked_section(groot_container, "9", 10,50,100,120,"", "view", true);	
	create_stacked_section(groot_container, "10", 10,50,140,100,"", "view", true);
	create_stacked_section(groot_container, "11", 10,50,50,70,"", "view", true);
	create_stacked_section(groot_container, "12", 10,50,110,150,"", "plain", true);
	create_floating_section(groot_container, "13", 10,10,100,250, "", "view", true);
	create_static_section(groot_container, "14", 40,40,300,200, "", "view", true);	
create_floating_section(section1, "15", 100,200,200,150, "", "view", true);
	//create_floating_section(groot_container, "5", 100,200,100,80, "", "view", true);
}

// main
page_main();

rock_and_roll_tabs();
check_set_and_show_section_tree(groot_container, true);
gpage_initialization = false;

gdebugging = false;
_ss("after create", groot_container, true);
gdebugging = false;
