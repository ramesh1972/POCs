// Globals

// topmost section for the page, which covers the whole page, and the view section
var groot_container = null;
var gpage_initialization = true;

// sizing using borders
var gresizing =false;
var gstartex = 0;
var gstartey = 0;
var gstartx = 0;
var gstarty = 0;
var gsizing_border_object = null;

// drag n dock
var	gdragdocking = false;
var gdocking_mousedown = false;
var	gdragdock_org_section = null;
var	gdragdock_clone_handle = null;
var gdrop_in_section = null;

// paws
var gpaw_thickness = 25;
var gpaw_tab_length = 50;
var gprev_dock_paw = null;
