// CXmlPage represents a page
// class to
    // create/destroy xml objects to pages
    // create & modify pages
    // convert xmls to sections & sections to xmls,
// adding/changing/removing properties

var pageStartSection = null;
function CXmlPage() {
    this.pageName = document.all("_page_name").value
    this.pageXml = document.all("_page_xml").value; // holds the sections represented in the xmls of the page
    this.pageXmlDoc = new CXml(this.pageXml); // holds the sections represented in xml objects
}

CXmlPage.prototype.Boot = function () {
    // create the top command bar
/*    var commndBarHtml = "<input type=button value=Save onclick=onSave()>";
    var commandBar = add_section(groot_container, "commandBar", 0, 0, g_cw(), 30, commndBarHtml, "dock");
    add_property(commandBar, "dock_position", "top");
    add_property(commandBar, "min_section_height", "30");
    add_property(commandBar, "is_fixed_height", true);
    */
    // create an xml object
    this.LoadSections(this.pageXmlDoc);
}

CXmlPage.prototype.LoadSections = function () {
    var rootChildNodes = this.pageXmlDoc.documentElement().childNodes();
    for (var idx = 0; idx < rootChildNodes.length; idx++)
        this.LoadSection(groot_container, rootChildNodes[idx]);
}

CXmlPage.prototype.LoadSection = function (parentSection, currentSectionNode) {
    if (currentSectionNode.isNull())
        return;

    if (parentSection == null)
        parentSection = groot_container;

    var thisSectionId = currentSectionNode.stringAttribute("id");

    var thisSectionPosition = currentSectionNode.stringAttribute("position");
    if (thisSectionPosition == "")
        thisSectionPosition = "dock";

    var thisSectionWidth = currentSectionNode.intAttribute("width");
    if (thisSectionWidth == 0)
        thisSectionWidth = g_cw();
    var thisSectionHeight = currentSectionNode.intAttribute("height");
    if (thisSectionHeight == 0)
        thisSectionHeight = g_ch();
    var thisSectionLeft = currentSectionNode.intAttribute("left");
    var thisSectionTop = currentSectionNode.intAttribute("top");

    var thisBorderThickness = currentSectionNode.intAttribute("border_thickness");

    var thisSection = add_section(parentSection, thisSectionId, thisSectionLeft, thisSectionTop, thisSectionWidth, thisSectionHeight, "", thisSectionPosition);

    add_property(thisSection, "dock_position", currentSectionNode.stringAttribute("dock_position"));
    add_property(thisSection, "bar", currentSectionNode.stringAttribute("bar"));
    add_property(thisSection, "border_thickness", thisBorderThickness);

    add_property(thisSection, "is_sizable", currentSectionNode.boolAttribute("is_sizable"));

    for (var idx = 0; idx < currentSectionNode.childNodes().length; idx++)
        this.LoadSection(thisSection, currentSectionNode.childNode(idx));

    return thisSection;
}

function onSave() {
    var pageName = document.all("_page_name").value
    var pageXml = document.all("_page_xml").value; // holds the sections represented in the xmls of the page

    // recreate the xmls from the sections
    var sectionXmls = GetSectionXmls(pageStartSection);
    alert(sectionXmls);
}

function GetSectionXmls(section) { // dunit
    var thisSectionXml = "";

    if (section != null && !is_bar(section) && !is_border(section) && !is_tab(section) && !is_tab_bar(section)) {
        // section type
        var sectionOpen = "<section ";

        var sectionAttrib = "id=\"" + section.id + "\" ";
        sectionAttrib += "position_type=\"" + section.position_type + "\" ";
        sectionAttrib += "real_type=\"" + section.real_type + "\" ";

        if (section.position_type == "dock")
            sectionAttrib += "dock_position=\"" + section.dock_position + "\" ";
        else if (section.position_type == "stick") {
            if (section.stick_left)
                sectionAttrib += "stick_left=\"true\" ";
            if (section.stick_right)
                sectionAttrib += "stick_right=\"true\" ";
            if (section.stick_top)
                sectionAttrib += "stick_top =\"true\" ";
            if (section.stick_bottom)
                sectionAttrib += "stick_bottom=\"true\" ";
        }
        else if (section.position_type == "tab") {
            sectionAttrib += "tab_length=\"" + section.tab_length + "\" ";
            sectionAttrib += "tab_breadth=\"" + section.tab_breadth + "\" ";
            sectionAttrib += "tabs_overlap=\"" + section.tabs_overlap + "\" ";
            sectionAttrib += "tab_length_fixed=\"" + section.tab_length_fixed + "\" ";
            sectionAttrib += "tab_min_length=\"" + section.tab_min_length + "\" ";
            sectionAttrib += "tabbar_padding=\"" + section.tabbar_padding + "\" ";
        }

        // dimensions
        sectionAttrib += "left=\"" + section.left + "\" ";
        sectionAttrib += "top=\"" + section.top + "\" ";
        sectionAttrib += "width=\"" + section.width + "\" ";
        sectionAttrib += "height=\"" + section.height + "\" ";

        sectionAttrib += "min_section_width=\"" + section.min_section_width + "\" ";
        sectionAttrib += "min_section_height=\"" + section.min_section_height + "\" ";

        if (section.is_fixed_width)
            sectionAttrib += "is_fixed_width=\"true\" ";
        if (section.is_fixed_height)
            sectionAttrib += "is_fixed_height=\"true\" ";

        // border
        sectionAttrib += "border_thickness=\"" + section.border_thickness + "\" ";

        // bar
        if (section.bar_left != null)
            sectionAttrib += "bar=\"left\" ";
        if (section.bar_right != null)
            sectionAttrib += "bar=\"right\" ";
        if (section.bar_top != null)
            sectionAttrib += "bar=\"top\" ";
        if (section.bar_bottom != null)
            sectionAttrib += "bar=\"bottom\" ";

        if (section.bar_thickness != null)
            sectionAttrib += "bar_thickness=\"" + section.bar_thickness + "\" ";

        // url
        if (section.url != null || section.url != "" || section.url != undefined)
            sectionAttrib += "url=\"" + section.url + "\" ";

        if (section.is_visible == true)
            sectionAttrib += "is_visible=\"true\" ";

        // sizability
        if (section.is_sizable == true)
            sectionAttrib += "is_sizable=\"true\" ";
        else
            sectionAttrib += "is_sizable=\"false\" ";

        if (section.is_left_sizable == true)
            sectionAttrib += "is_left_sizable=\"true\" ";
        else
            sectionAttrib += "is_left_sizable=\"false\" ";

        if (section.is_right_sizable == true)
            sectionAttrib += "is_right_sizable=\"true\" ";
        else
            sectionAttrib += "is_right_sizable=\"false\" ";

        if (section.is_top_sizable == true)
            sectionAttrib += "is_top_sizable=\"true\" ";
        else
            sectionAttrib += "is_top_sizable=\"false\" ";

        if (section.is_bottom_sizable == true)
            sectionAttrib += "is_bottom_sizable=\"true\" ";
        else
            sectionAttrib += "is_bottom_sizable=\"false\" ";

        if (section.is_always_on_top)
            sectionAttrib += "is_always_on_top=\"true\" ";

        // mobility
        if (section.is_movable)
            sectionAttrib += "is_movable=\"true\" ";
        if (section.is_floatable)
            sectionAttrib += "is_floatable=\"true\" ";
        if (section.is_dockable)
            sectionAttrib += "is_dockable=\"true\" ";
        if (section.is_tabbable)
            sectionAttrib += "is_tabbable=\"true\" ";
        if (section.is_stickable)
            sectionAttrib += "is_stickable=\"true\" ";

        // can have stuff
        if (section.can_have_drops)
            sectionAttrib += "can_have_drops=\"true\" ";
        else
            sectionAttrib += "can_have_drops=\"false\" ";

        if (section.can_have_docks)
            sectionAttrib += "can_have_docks=\"true\" ";
        else
            sectionAttrib += "can_have_docks=\"false\" ";

        if (section.can_have_floats)
            sectionAttrib += "can_have_floats=\"true\" ";
        else
            sectionAttrib += "can_have_floats=\"false\" ";

        if (section.can_have_sticks)
            sectionAttrib += "can_have_sticks=\"true\" ";
        else
            sectionAttrib += "can_have_sticks=\"false\"";

        if (section.can_have_tabs)
            sectionAttrib += "can_have_tabs=\"true\" ";
        else
            sectionAttrib += "can_have_tabs=\"false\" ";

        var sectionXmlEndTag = ">";

        thisSectionXml = sectionOpen + sectionAttrib + sectionXmlEndTag;
    }

    for (var idx = 0; idx < section.child_sections.length; idx++) {
        thisSectionXml += GetSectionXmls(section.child_sections[idx]);
    }

    if (thisSectionXml != "")
        return thisSectionXml + "</section>" + section.id;

    return thisSectionXml;
}   