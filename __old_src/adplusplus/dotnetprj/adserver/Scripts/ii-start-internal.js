function go_layout() // main
{
    page_main();

    // header setup & get the main content section
    setup_header_section();

    // setup the main content page
    setup_main_content_section();

    // standard stuff
    check_set_and_show_section_tree(groot_container, true);
    gpage_initialization = false;

    gdebugging = false;
    _ss("after create", groot_container, true);
    gdebugging = false;
}