function page_main()
{
	document.body.onclick = page_onclick;
	document.body.onresize = resize_page;
	document.body.onmousemove = body_mousemove; 
	create_root_container();
}

function rock_and_roll() {
    var section1 = add_section(groot_container, "rnr1", 0, 0, 400, 100, "", "dock");
        add_property(section1, "dock_position", "left");
        add_property(section1, "bar", "left");
        add_property(section1, "border_thickness", 15);

        var section11 = add_section(section1, "rnr11", 0, 0, 400, 400, "", "dock");
            add_property(section11, "dock_position", "left");
            add_property(section11, "bar", "bottom");
            add_property(section11, "border_thickness", 15);

        var section12 = add_section(section1, "rnr12", 0, 0, 400, 200, "", "dock");
            add_property(section12, "dock_position", "right");
            add_property(section12, "bar", "right");
            add_property(section12, "border_thickness", 15);
}

function getImg(src) 
{
    return "<img src='file://C:/Documents and Settings/All Users.WINDOWS/Documents/My Pictures/Sample Pictures/" + src + "' style='width:100%;height:100%'>";
}

// main
page_main();

rock_and_roll();
check_set_and_show_section_tree(groot_container, true);
gpage_initialization = false;

gdebugging = false;
_ss("after create", groot_container, true);
gdebugging = false;
