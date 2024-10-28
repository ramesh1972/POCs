function create_docking_section(parent, id, l, t, w, h, src, dock_pos, stype, somebool) {
    section1 = add_section(parent, id, l, t, w, h, src, "dock");
    add_property(section1, "type", stype);
    add_property(section1, "dock_position", dock_pos);
    add_property(section1, "bar", "top");
    add_property(section1, "border_thickness", 2);

    return section1;
}

function create_floating_section(parent, id, l, t, w, h, src, dock_pos, stype, somebool) {
    section1 = add_section(parent, id, l, t, w, h, src, "float");
    add_property(section1, "type", stype);
    add_property(section1, "bar", "top");

    return section1;
}