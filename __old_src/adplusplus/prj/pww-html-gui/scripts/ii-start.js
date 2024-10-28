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

        var section11 = add_section(section1, "rnr11", 0, 0, 400, 400, getImg("beatles.jpg"), "dock");
            add_property(section11, "dock_position", "top");
            add_property(section11, "bar", "bottom");

        var section12 = add_section(section1, "rnr12", 0, 0, 400, 200, getImg("syd_barrett-708552.jpg"), "dock");
            add_property(section12, "dock_position", "bottom");
            add_property(section12, "bar", "right");

    var section2 = add_section(groot_container, "rnr2", 0, 0, 50, 200, getImg("The Wall - DVD - Front & Back.jpg"), "dock");
        add_property(section2, "dock_position", "top");
        add_property(section2, "bar", "top");

    var section3 = add_section(groot_container, "rnr3", 0, 0, 400, 100, getImg("grateful-dead.jpg"), "dock");
        add_property(section3, "dock_position", "right");
        
        var section7 = add_section(null, "rnr7", 100, 50, 200, 200, getImg("Eric_Clapton.jpg"), "popin");
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

            var section9 = add_section(section5, "rnr9", 10, 10, 250, 150, getImg("csn.jpg"), "stack");
                add_property(section9, "bar", "left");

            var section10 = add_section(section5, "rnr10", 260, 70, 160, 170, getImg("the-band-snl-1976-17.jpg"), "float");
                add_property(section10, "bar", "left");

        var section6 = add_section(section4, "rnr6", 0, 0, 150, 150, getImg("10705698-roger-waters-tickets.jpg"), "tab");
            add_property(section6, "bar", "right");

        var section14 = add_section(section4, "rnr14", 0, 0, 250, 200, getImg("allman.jpg"), "dock");
            add_property(section14, "dock_position", "left");
            add_property(section14, "bar", "bottom");

            var section15 = add_section(section4, "rnr15", 0, 0, 400, 200, getImg("mushroom.jpg"), "dock");
            add_property(section15, "dock_position", "right");
            add_property(section15, "bar", "right");
            add_property(section15, "is_sizable", false);

        var section13 = add_section(groot_container, "rnr13", 100, 100, 150, 100, getImg("bob_dylan_12_64.jpg"), "stick");
        add_property(section13, "bar", "left");
        add_property(section13, "stick_right", true);
        add_property(section13, "stick_top", true);
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
