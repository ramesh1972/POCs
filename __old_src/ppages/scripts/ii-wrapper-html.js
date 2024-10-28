// ===================================================================
// client width/height functions
function g_cw()
{
	return document.body.clientWidth;
}

function g_ch()
{
	return document.body.clientHeight;
}

// ================================================================================
// get functions
function g_groot()
{
	return document.body;
}

// ================================================================================
// Basic section dimension get/set functions
function g_set_dimensions(html_object, x, y, w, h)
{
	if (html_object == null)
		return;
	
	html_object.style.posLeft = x;
	html_object.style.posTop = y;
	html_object.style.posWidth = w;
	html_object.style.posHeight = h;
}

function _get_html_actual_left(obj)
{
	if (obj == null)
		return null;
	
	return obj.style.posLeft;
}

function _get_html_actual_top(obj)
{
	if (obj == null)
		return null;
	
	return obj.style.posTop;
}

function _get_html_actual_width(obj)
{
	if (obj == null)
		return null;
	
	return obj.style.posWidth;
}

function _get_html_actual_height(obj)
{
	if (obj == null)
		return null;
	
	return obj.style.posHeight;
}

function g_goal(obj) { return _get_html_actual_left(obj); }
function g_goat(obj) { return _get_html_actual_top(obj); }
function g_goaw(obj) { return _get_html_actual_width(obj); }
function g_goah(obj) { return _get_html_actual_height(obj); }
function g_goar(obj) { return g_goal(obj) + g_goaw(obj); }
function g_goab(obj) { return g_goat(obj) + g_goah(obj); }

function _set_html_actual_left(obj, x)
{
	if (obj == null)
		return null;
	
	obj.style.posLeft = x;
}

function _set_html_actual_top(obj, y)
{
	if (obj == null)
		return null;
	
	obj.style.posTop = y;
}

function _set_html_actual_width(obj , w)
{
	if (obj == null)
		return null;
	
	obj.style.posWidth = w;
}

function _set_html_actual_height(obj, h)
{
	if (obj == null)
		return null;
	
	obj.style.posHeight = h;
}

function g_soal(obj, x) { _set_html_actual_left(obj, x); }
function g_soat(obj, y) { _set_html_actual_top(obj, y); }
function g_soaw(obj, w) { _set_html_actual_width(obj, w); }
function g_soah(obj, h) { _set_html_actual_height(obj, h); }

// ===================================================================
// element create/destroy functions
function g_get_id(elm)
{
	if (elm == null)
		return "";
		
	if (elm.id != "")
		return elm.id;
		
	return elm.name;
}

function g_set_id(elm, id)
{
	if (elm == null)
		return "";

	elm.id = id;
	elm.name = id;
}

function g_create_element(elm_name, id)
{
	var elm = document.createElement(elm_name);
	elm.id = id;
	elm.name = id;
	
	return elm;
}

function g_create_block(id)
{
	return g_create_element("div", id); 
}

function g_create_frame(id, src)
{
	var elm = g_create_element("iframe", id); 
	if (elm != null)
		elm.src = src;
	
	return elm;
}

function g_create_image(id, src)
{
	var elm = g_create_element("image", id); 
	if (elm != null)
		elm.src = src;
	
	return elm;
}

function g_append_child(parent, child)
{
	if (parent == null || child == null)
		return;
		
	parent.appendChild(child);
}

// destroy
function g_remove_child(child)
{
	if (child == null || child.parentNode == null)
		return;
		
	g_hide_element(child);
	child.parentNode.removeChild(child);
}

// ===================================================================
// layout
function g_show_element(elem)
{
	if (elem != null && elem.style != null)
		elem.style.visibility = "visible";
}

function g_hide_element(elem)
{
	if (elem != null && elem.style != null)
		elem.style.visibility = "hidden";
}

function g_is_visible(elem)
{
	if (elem != null && elem.style != null && elem.style.visibility == "visible")
		return true;
	
	return false;
}

// ==================
// other
function g_clone(elm, deep)
{
	if (elm == null)
		return null;
		
	return elm.cloneNode(deep);
}

// ===================================================================
// properties
function g_set_align(elem, alignment)
{
	if (elem == null)
		return;
		
	elem.align = alignment;
}

// ===================================================================
// styles set/get
function g_set_element_style(elem, pstyle, value)
{
	if (elem == null || elem.style == null)
		return;
	
	if (value == null)
		value = "";
	
	value = "'" + value + "'";
	eval("elem.style." + pstyle + "=" + value);
	
}

function g_ss(elem, pstyle, value)
{
	g_set_element_style(elem, pstyle, value);
}

function g_set_element_filter(elem, value)
{
	if (elem == null)
		return;
	
	if (value == null)
		value = "";
	
	elem.style.filter = value;
}

function g_sf(elem, value)
{
	g_set_element_filter(elem, value);
}

function g_get_zindex(elem)
{
	if (elem != null)
		return elem.style.zIndex;
	
	return -1;
}

function g_set_zindex(elem, zindex)
{
	g_ss(elem, "zIndex", zindex);
}