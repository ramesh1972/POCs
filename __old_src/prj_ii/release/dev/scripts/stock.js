var g_jsdb = null;

start();
function start()
{
	// set global db xml object
	if (!load_output_data())
	{
		alert("failed to load data");
		return false;
	}
	
	// show the form
	show_form();
}

function load_output_data()
{
	var ohid = document.all("output_data");
	if (ohid == null)
		return false;
	
	var dbstring = ohid.value;
	if (g_jsdb == null)
		g_jsdb = new ActiveXObject("Msxml2.DOMDocument.3.0");
		
	if (g_jsdb == null)
		return false;
	
	g_jsdb.loadXML(dbstring);
	document.write("<span>" + dbstring.length + "</span>");
	return true;
}

function show_form()
{
	var div = document.createElement("div");
	document.body.appendChild(div);
	
	var dchild = getData("stock");
	var thtml = "<Table width=100%>";
	var rhtml = "";
		rhtml = "<TR><TD>Identity</TD>";
		rhtml += "<TD>Stock</TD>";
		rhtml += "<TD>Price</TD>";				
		rhtml += "</TR>";


	for (var idx=0;idx<dchild.childNodes.length;idx++)
	{
		var trow = dchild.childNodes[idx];
		
		// for each row
		rhtml += "<TR>";
		for (var idx1=0;idx1<trow.childNodes.length;idx1++)
		{
			var tcol = trow.childNodes[idx1];
			rhtml += "<TD><input type=text dtab=stock drow=" + idx + " dcol=" + idx1 + " value=" + tcol.text + " onchange='changeData();'"  + "></TD>";
		}
		
		rhtml += "<TD><input type=checkbox dtab=stock drow=" + idx + " value=Delete" + " onclick='changeData();'"  + ">Delete</TD>";
		rhtml += "</TR>";
	}			

	// put a dummy row
	rhtml += "<TR><TD>New Stock</TD>";
	rhtml += "<TD><input type=text name=col2 dtab=stock drow=" + idx + " dcol=1 onchange='changeData();'></TD>";
	rhtml += "<TD><input type=text name=col3 dtab=stock drow=" + idx + " dcol=2 onchange='changeData();'></TD>";				
	rhtml += "</TR>";

	thtml += rhtml;
	thtml += "</Table>";
	
	var html = thtml + "<BR><input type=button value=Save onclick=\"saveData('stock');\">";
	div.innerHTML = html;
}	

function getData(tab)
{
	if (g_jsdb == null)
		return;
		
	var data = g_jsdb.selectSingleNode("JSDB").selectSingleNode(tab + "/Data");
	return data;
}

function getTable(tab)
{
	if (g_jsdb == null)
		return;
		
	var data = g_jsdb.selectSingleNode("JSDB").selectSingleNode(tab);
	return data;
}

function saveData(table)
{
	if (g_jsdb == null)
		return;

	var data = g_jsdb.selectSingleNode("JSDB");		
	var clone = data.cloneNode(true);
	
	setInputData(clone.xml);
	sendData();
}

function setInputData(data)
{
	// replace special chars
	data = data.replace(/"/g, "&quot;");
	
	var input = document.all("input_data");
	if (input == null)
	{
		var form  = document.createElement("form");
		document.appendChild(form);
		form.id="send_form";
		form.method = "post";
		form.action = "ii-load.exe";
		form.innerHTML = "<input type=hidden name=input_data value=\"" + data + "\">";
	}
	else
		input.value = data;
}

function sendData()
{
	var form = document.all("send_form");
	if (form == null)
		return;

	var input = document.all("input_data");
	form.submit();
}

function changeData()
{
	var control = window.event.srcElement;
		
	var table = control.dtab;
	var row = control.drow;
	var col = control.dcol;
	
	var table_node = getTable(table);
	var node = getData(table);
	var row_node = node.childNodes[eval(row)];
	var col_node = null;
	if (row_node != null)
		col_node = row_node.childNodes[eval(col)];
	
	var attr_value = "2"; // update
	if (row_node == null) // if no row,col specified in the control, then it is a new row
	{
		attr_value = "1"; 
		if (row_node == null)
		{
			var new_row = g_jsdb.createElement("R");
			
			var head = table_node.selectSingleNode("Head");
			for (var idx=0; idx<head.childNodes.length;idx++)
			{
				var new_col = g_jsdb.createElement("C");
				new_row.appendChild(new_col);
			}
			table_node.selectSingleNode("Data").appendChild(new_row);

			row_node = new_row;
			col_node = row_node.childNodes[eval(col)];
			col_node.text = control.value;
		}
	}
	else if (col_node == null) // if no column id specified in the  control, then it is a sirty flag for the row, which is delete
	{
		col_node = row_node;
		attr_value = "3"; // delete
	}
	else
		col_node.text = control.value;
	
	var attr = row_node.attributes.item(0);
	if (attr == null)
	{
		attr = g_jsdb.createAttribute("dirty");
		attr.value =attr_value;

		row_node.attributes.setNamedItem(attr);
	}
	else 
	{
		if (attr.text != "1")
			attr.text = attr_value;
	}

	var row_flag = attr.text;
	attr = col_node.attributes.item(0);
	if (attr == null)
	{
		attr = g_jsdb.createAttribute("dirty");
		attr.value = row_flag;

		col_node.attributes.setNamedItem(attr);
	}
	else 
	{
		attr.text = row_flag;
	}

//	alert(attr_value);
}