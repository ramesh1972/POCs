// =============================================================================
// single left dock
function create_single_ld()
{

	section1 = create_docking_section(null, "1", 100,50,200,300,"", "left",  -1, 100);
//		create_docking_section(section1, "2", 100,100,200,100,"", "top",  -1, 100);
//	section2 = create_docking_section(null, "1", 60,60,200,100,"", "top",  -1, 100);
//		section3 = create_docking_section(section2, "3", 10,10,200,100,"", "left",  -1, 100);
//			section4 = create_docking_section(section3, "4", 10,10,200,100,"", "bottom",  -1, 100);
		create_docking_section(section1.parent_section.parent_section, "4", 10,10,200,100,"", "top",  -1, 100);
				section5 = create_docking_section(section4.parent_section.parent_section, "4", 10,10,200,100,"", "bottom",  -1, 100);
	
	set_check_and_show_section_tree(groot_container, deep);
}

// double left dock
function create_double_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"2", 210,50,200,200,"", "left",  -1, 100);
}

// triple left dock
function create_triple_ld()
{
	create_docking_section(groot_container,"1", 100,50,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"2", 110,50,130,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"3", 310,50,200,200,"", "left",  -1, 100);	
}

// single top dock
function create_single_td()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "top",  100,-1);
}

// double top dock
function create_double_td()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "top",  100,-1);
	layout_page();
	create_docking_section(groot_container,"2", 0,0,50,30,"", "top",  100,-1);
	layout_page();
}

// triple top dock
function create_triple_td()
{
	create_docking_section(groot_container,"1", 0,0,50,10,"", "top",  100,-1);
	layout_page();
	create_docking_section(groot_container,"2", 0,0,50,120,"", "top",  100,-1);
	layout_page();
	create_docking_section(groot_container,"3", 0,0,50,20,"", "top",  100,-1);
	layout_page();
	
}

// single right dock
function create_single_rd()
{
	create_docking_section(groot_container,"1", 0,0,10,100,"", "right",  100,-1);
}

// double right dock
function create_double_rd()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "right",  100,-1);
	create_docking_section(groot_container,"2", 0,0,150,300,"", "right",  100,-1);
}

function create_triple_rd()
{
	create_docking_section(groot_container,"1", 0,0,50,100,"", "right",  100,-1);
	create_docking_section(groot_container,"2", 0,0,150,300,"", "right",  100,-1);
	create_docking_section(groot_container,"3", 0,0,150,300,"", "right",  100,-1);
}

// single right dock
function create_single_bd()
{
	create_docking_section(groot_container,"1", 0,0,50,200,"", "bottom",  100,-1);
}

// double right dock
function create_double_bd()
{
	create_docking_section(groot_container,"1", 0,0,50,120,"", "bottom",  100,-1);
	create_docking_section(groot_container,"2", 0,0,150,120,"", "bottom",  100,-1);
}

function create_triple_bd()
{
	create_docking_section(groot_container,"1", 0,0,50,120,"", "bottom",  100,-1);
	create_docking_section(groot_container,"2", 0,0,150,120,"", "bottom",  100,-1);
	create_docking_section(groot_container,"3", 0,0,50,120,"", "bottom",  100,-1);
}

// simple all dock
function simple_all_dock()
{
	section1 = create_docking_section(groot_container, "1", 10,0,500,180,"", "left",  -1, 100);
	section5 = create_docking_section(groot_container, "1", 10,0,200,180,"", "right",  -1, 100);
	section2 = create_docking_section(groot_container, "1", 0,0,50,200,"", "bottom",  100,-1);
	section3 = create_docking_section(groot_container, "1", 0,0,100,100,"", "top",  100,-1);
	
	section4 = create_docking_section(section1, "2", 100,50,150,200,"", "top",  -1, 100);
	section3 = create_docking_section(section1, "2", 0,0,10,100,"", "left",  100,-1);

	//create_docking_section(section1.parent_section.parent_section, "5", 0,0,200,100,"", "left",  100,-1);


	//create_docking_section(section1,"2", 10,0,70,200,"", "left",  -1, 100);
//	create_docking_section(groot_container,"2", 100,0,60,200,"", "right",  -1, 100);
	set_check_and_show_section_tree(groot_container, true);	

}

// simple all dock double
function simple_all_double_dock()
{
	create_docking_section(groot_container,"2", 0,0,50,100,"", "bottom",  100,-1);
	create_docking_section(groot_container,"2", 0,0,50,150,"", "top",  100,-1);
	create_docking_section(groot_container,"1", 0,0,50,100,"", "bottom",  100,-1);
	section1 = create_docking_section(groot_container,"1", 100,150,100,200,"", "left",  -1, 100);
	create_docking_section(section1,"1", 0,0,150,100,"", "right",  100,-1);
	create_docking_section(section1,"2", 120,150,200,200,"", "left",  -1, 100);

	create_docking_section(groot_container,"2", 0,0,150,100,"", "right",  100,-1);
	create_docking_section(groot_container,"1", 0,0,50,100,"", "top",  100,-1);
}

function create_complex_docks()
{
	// lots of docks
	create_docking_section(groot_container,"4", 0,0,50,60,"", "bottom",  100,-1);
	layout_page();
	create_docking_section(groot_container,"1", 100,50,10,200,"", "left",  -1, 100);
	layout_page();
	create_docking_section(groot_container,"1", 0,0,50,10,"", "top",  100,-1);
	layout_page();
	create_docking_section(groot_container,"1", 0,0,10,10,"", "right",  100,-1);
	layout_page();
	create_docking_section(groot_container,"2", 210,50,100,200,"", "left",  -1, 100);
	layout_page();

	create_docking_section(groot_container,"4", 0,0,100,100,"", "right",  100,-1);
	layout_page();
	create_docking_section(groot_container,"1", 0,0,50,30,"", "bottom",  100,-1);
	layout_page();
	create_docking_section(groot_container,"2", 0,0,50,100,"", "right",  100,-1);
	layout_page();
	create_docking_section(groot_container,"4", 0,0,50,20,"", "top",  100,-1);
	layout_page();	
	create_docking_section(groot_container,"2", 0,0,50,40,"", "bottom",  100,-1);
	layout_page();

	create_docking_section(groot_container,"3", 410,50,120,200,"", "left",  -1, 100);
	layout_page();
	create_docking_section(groot_container,"3", 0,0,140,100,"", "right",  100,-1);
	layout_page();

	create_docking_section(groot_container,"2", 0,0,50,80,"", "top",  100,-1);
	layout_page();


	create_docking_section(groot_container,"5", 0,0,50,10,"", "bottom",  100,-1);
	layout_page();
	create_docking_section(groot_container,"5", 0,0,100,100,"", "right",  100,-1);
	layout_page();
	create_docking_section(groot_container,"4", 210,50,120,200,"", "left",  -1, 100);
	layout_page()

/*	create_docking_section(groot_container,"16", 0,0,50,10,"", "bottom",  100,-1);
	layout_page();
	create_docking_section(groot_container,"16", 0,0,70,100,"", "right",  100,-1);
	layout_page();
	create_docking_section(groot_container,"15", 410,50,20,200,"", "left",  -1, 100);
	layout_page()

	create_docking_section(groot_container,"17", 0,0,50,10,"", "bottom",  100,-1);
	layout_page();
	create_docking_section(groot_container,"17", 0,0,30,100,"", "right",  100,-1);
	layout_page();
	create_docking_section(groot_container,"18", 410,50,120,200,"", "left",  -1, 100);
	layout_page()
*/
}

// double left dock row
function create_double_dockset_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,200,100,250,"", "left",  -1, 100);
}

function create_double_dockset_ld_with_flip()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,-10,100,100,"", "left",  -1, 100);
}

// triple left dock row
function create_triple_dockset_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,350,100,200,"", "left",  -1, 100);
}

function create_triple_dockset_ld_with_flip()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,100,100,200,"", "left",  -1, 100);
}

function create_quadruple_dockset_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,160,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,250,100,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_3", 10,350,100,200,"", "left",  -1, 100);
}

function create_dockset_double_ld()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	layout_page();
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  -1, 100);
	layout_page();
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  -1, 100);
}

function create_dockset_double_ld_with_flip()
{
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  -1, 100);
}

// triple left dock with top & bottom
function create_dockset_ld_with_top_bottom()
{
	create_docking_section(groot_container,"dt", 0,0,50,80,"", "top",  100,-1);
	create_docking_section(groot_container,"db", 0,0,200,90,"", "bottom",  100,-1);
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  -1, 100);
}

function create_dockset_double_ld_with_top_bottom()
{
	create_docking_section(groot_container,"dt", 0,0,50,80,"", "top",  100,-1);
	create_docking_section(groot_container,"db", 0,0,200,90,"", "bottom",  100,-1);
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,200,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  -1, 100);
}

// complex left dock row
function create_dockset_ld_complex()
{
	create_docking_section(groot_container,"1", 0,0,200,50,"", "bottom",  100,-1);
	create_docking_section(groot_container,"dt", 0,0,50,50,"", "top",  100,-1);
	create_docking_section(groot_container,"1", 0,0,50,80,"", "top",  100,-1);
	create_docking_section(groot_container,"1", 100,50,200,100,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_1", 10,-10,10,350,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_2", 10,30,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"1_3", 210,160,100,400,"", "left",  -1, 100);

	create_docking_section(groot_container,"db", 0,0,200,90,"", "bottom",  100,-1);
	create_docking_section(groot_container,"1_4", 220,200,100,200,"", "left",  -1, 100);
	create_docking_section(groot_container,"dr", 0,0,200,70,"", "right",  -1, 100);
	create_docking_section(groot_container,"2", 0,0,200,90,"", "bottom",  100,-1);
}

// iframes
function create_sections_with_frames()
{
	create_docking_section(groot_container,"test2", 0,0,80,100,"file:///c:/MyReleases/intrainter/dev/pww-app-files/openurl.html", "top",  100,-1);
	create_floating_div_section("test3", 10,50,520,520,"file:///C:/MyReleases/intrainter/dev/pww-archive/PWW/Temp/10_10_10/rendered.html");
}

function create_float_section()
{
//	var sect = create_floating_div_section("test32", 10,10,300,400,"");
	gdebug = null; //sect.view_object;
}

// main
page_main();

//create_single_ld();
//create_double_ld();
//create_triple_ld();
//create_single_td();
//create_double_td();
//create_triple_td();
//create_single_rd();
//create_double_rd();
//create_triple_rd();
//create_single_bd();
//create_double_bd();
//create_triple_bd();

simple_all_dock();
//simple_all_double_dock();
//create_complex_docks();

//create_double_dockset_ld();
//create_double_dockset_ld_with_flip();
//create_triple_dockset_ld();
//create_triple_dockset_ld_with_flip();
//create_quadruple_dockset_ld();
//create_dockset_double_ld();
//create_dockset_double_ld_with_flip();
//create_dockset_ld_with_top_bottom();
//create_dockset_double_ld_with_top_bottom();
//create_dockset_ld_complex();

//create_sections_with_frames();
//create_float_section();

//create_sections_with_frames();

