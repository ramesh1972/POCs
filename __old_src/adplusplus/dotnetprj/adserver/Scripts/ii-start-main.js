function setup_header_section() 
{
    var section1 = add_section(groot_container, "rnr1", 0, 0, 1000, 200, "", "dock");
    add_property(section1, "dock_position", "top");
    add_property(section1, "bar", "none");
    add_property(section1, "is_sizable", false);
    add_property(section1, "is_movable", false);
    add_property(section1, "border_thickness", 0);
    
        var section11 = add_section(section1, "rnr11", 0, 0, 1100, 100, get_banner_html(), "dock");
        add_property(section11, "dock_position", "left");
        add_property(section11, "bar", "none");
        add_property(section11, "is_sizable", false);
        add_property(section11, "is_movable", false);
        add_property(section11, "border_thickness", 0);
        add_property(section11, "bgcolor", "white");

        var section12 = add_section(section1, "rnr12", 0, 0, 400, 100, get_main_menu_html(), "dock");
        add_property(section12, "dock_position", "right");
        add_property(section12, "bar", "none");
        add_property(section12, "is_sizable", false);
        add_property(section12, "is_movable", false);
        add_property(section12, "border_thickness", 0);
        add_property(section12, "bgcolor", "white");
    }

function get_banner_html() 
{
    var str = "<div class=topbar></div>" +
            "<div class=\"sideblock\">" +
                "<div class=\"sideblockInner\"></div>" +
            "</div>" +
            "<div class=\"yellowbar\"></div>" +
                    
            //"<span class=\"title\"  filter=\"progid:DXImageTransform.Microsoft.Shadow(color=#0000FF,direction=45);\">adPlusPlus.com</span>" +
            "<div class=title><img src='images/adplusplus2.png' width=200 height=28/></div>" + 
            "<div class=bluebar_top></div>" +
            "<div class=\"bluebar_bottom\"></div>" +
                    
            "<div class=titleNoteOuter>" +
                "<span class=\"titleNote\">A <Span class=\"titleNoteFreeWord\">Free</Span> Symbiotic Contextual Online Advertising Platform</span>" +
            "</div>" +

            "<div class=\"leftTitleUnderLineOuter\">" +
                "<div class=\"leftTitleUnderLineInner\">+</div>" +
            "</div>" +

            "<div class=\"rightTitleUnderLineOuter\">" +
                "<div class=\"rightTitleUnderLineInner\">+</div>" +
            "</div>";

    return str;
}

function get_main_menu_html() 
{
    return "<table width=100% height=99px border=0 style=\"border-collapse:collapse;border-width:0mm;border-color:aqua;\" align=center valign=middle>" +
            "<tr valign=middle align=center height=33px><td style=\"background-image:url('images/nav.gif');background-repeat:repeat\" align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=Default.aspx>Home</a></td></tr>" +
            "<tr valign=middle align=center height=33px><td style=\"background-image:url('images/nav.gif');background-repeat:repeat\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=About.aspx>About Us</a></td></tr>" +
            "<tr valign=middle align=center height=33px><td valign=middle style=\"background-image:url('images/nav.gif');background-repeat:repeat\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=Contact.aspx>Contact Us</a></td></tr>" +
        "</table>";
}

function setup_main_content_section() 
{
    var section2 = add_section(groot_container, "rnr2", 0, 0, 1000, 600, "Viswanathan", "dock");
    add_property(section2, "dock_position", "bottom");
    add_property(section2, "bar", "none");
    add_property(section2, "is_sizable", false);
    add_property(section2, "is_movable", false);
    add_property(section2, "border_thickness", 0);
    //add_property(section2, "bgcolor", "yellow");

        section21 = add_section(section2, "rnr21", 0, 0, 900, 100, get_intro_content(), "dock");
        add_property(section21, "dock_position", "left");
        add_property(section21, "bar", "none");
        add_property(section21, "is_sizable", true);
        add_property(section21, "is_movable", true);
        add_property(section21, "border_thickness", 2);
        //add_property(section21, "bgcolor", "yellow");
        add_property(section21, "tab_position", "top");

            var section212 = add_section(section21, "rnr212", 0, 0, 1000, 600, "", "tab");
            add_property(section212, "bar", "none");
            add_property(section212, "tab_position", "top");
            add_property(section212, "is_sizable", true);
            add_property(section212, "is_movable", false);
            add_property(section212, "border_thickness", 0);
            add_property(section212, "text", "Test Drive");
            add_property(section212, "tab_length", 90);
            add_property(section212, "tab_length_fixed", false);
            //add_property(section212, "bgcolor", "white");
            //add_property(section212, "tab_fgcolor", "black");
            //add_property(section212, "tab_bgcolor", "aqua");
            add_property(section212, "url_delay_load", false);
            add_property(section212, "url", "TestDrive.aspx");

            var section211 = add_section(section21, "rnr211", 0, 0, 1000, 600, get_gen_script_content(), "tab");
            add_property(section211, "bar", "none");
            add_property(section211, "tab_position", "top");
            add_property(section211, "is_sizable", true);
            add_property(section211, "is_movable", false);
            add_property(section211, "border_thickness", 0);
            add_property(section211, "text", "Advertise Now");
            add_property(section211, "bgcolor", "aqua");
            add_property(section211, "tab_length", 120);
            add_property(section211, "tab_length_fixed", false);
            //add_property(section211, "tab_fgcolor", "black");
            //add_property(section211, "tab_bgcolor", "#F8F0FF");

            var section215 = add_section(section21, "rnr215", 0, 0, 1000, 600, "hjhj", "tab");
            add_property(section215, "bar", "none");
            add_property(section215, "tab_position", "top");
            add_property(section215, "is_sizable", true);
            add_property(section215, "is_movable", false);
            add_property(section215, "border_thickness", 0);
            add_property(section215, "text", "Find Ad Words");
            //add_property(section215, "bgcolor", "white");
            add_property(section215, "tab_length", 120);
            add_property(section215, "tab_length_fixed", false);
            //add_property(section215, "tab_fgcolor", "black");
            //add_property(section215, "tab_bgcolor", "#AAAAA0");
            
            var section214 = add_section(section21, "rnr214", 0, 0, 1000, 600, "", "tab");
            add_property(section214, "bar", "none");
            add_property(section214, "tab_position", "top");
            add_property(section214, "is_sizable", true);
            add_property(section214, "is_movable", false);
            add_property(section214, "border_thickness", 0);
            add_property(section214, "text", "Your Statistics");
            add_property(section214, "tab_length", 120);
            add_property(section214, "tab_length_fixed", false);
            //add_property(section214, "tab_fgcolor", "black");
            //add_property(section214, "tab_bgcolor", "#F0F00F");
            add_property(section214, "url_delay_load", false);
            add_property(section214, "url", "YourStatistics.aspx");

            var section216 = add_section(section21, "rnr216", 0, 0, 1000, 600, "RameshBXVXCV<br>RameshBXVXCV  RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV    RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV  ", "tab");
            add_property(section216, "bar", "none");
            add_property(section216, "tab_position", "top");
            add_property(section216, "is_sizable", true);
            add_property(section216, "is_movable", false);
            add_property(section216, "border_thickness", 0);
            add_property(section216, "text", "Legal Information");
            add_property(section216, "tab_length", 140);
            //add_property(section216, "bgcolor", "white");
            add_property(section216, "tab_length_fixed", false);
            //add_property(section216, "tab_fgcolor", "black");
            //add_property(section216, "tab_bgcolor", "#FFFAAF");
            
  /*          var section213 = add_section(section21, "rnr213", 0, 0, 1000, 600, "RameshBXVXCV<br>RameshBXVXCV  RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV    RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV   RameshBXVXCV  ", "tab");
            add_property(section213, "bar", "none");
            add_property(section213, "tab_position", "top");
            add_property(section213, "is_sizable", true);
            add_property(section213, "is_movable", false);            
            add_property(section213, "border_thickness", 0);
            add_property(section213, "text", "About Internet Advertising");
            add_property(section213, "tab_length", 180);            add_property(section213, "bgcolor", "white");
            add_property(section213, "tab_length_fixed", false);
            add_property(section213, "tab_fgcolor", "black");
            add_property(section213, "tab_bgcolor", "#F33A33");
            */
            section22 = add_section(section2, "rnr22", 0, 0, 400, 100, "", "dock");
            add_property(section22, "dock_position", "right");
            add_property(section22, "is_sizable", true);
            add_property(section22, "is_top_sizable", false);
            add_property(section22, "url", "SiteStatistics.aspx");

            check_set_and_show_section_tree(section22, true);
            add_property(section22, "border_thickness", 4);
            //add_property(section22, "bgcolor", "aqua");
    //        add_property(section22, "title_bar_thickness", 40);
    //        add_property(section22, "bar", "top");
    //        add_property(section22, "title_font_size", "16");
    //        add_property(section22, "title", "Site Statistics");

        add_property(section21, "tab_is_active", true);
        add_property(section21, "text", "Introduction");
        add_property(section21, "tab_bar_visible", false);
        add_property(section21, "tab_length", 100);
        add_property(section21, "tab_length_fixed", false);
        //add_property(section21, "tab_fgcolor", "black");
        //add_property(section21, "tab_bgcolor", "white");

    return groot_container;
}


go_layout();