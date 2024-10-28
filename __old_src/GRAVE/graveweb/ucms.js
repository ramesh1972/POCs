// for the moz page
function window_resize()
{
	
}

// entity tree
function EntityTree_AfterClick(sender, eventArgs)
{
	document.all("request_source").value = "entity_tree";			
	document.all("request_name").value = "entity_selected";
	document.all("request_args").value = window["EntityTree"].SelectedNode.Value;			

	window["MainAjaxManager"].AjaxRequest();
}

// entity tabs
var selectedTabIndex = 0;
var clicked = false;

function EnableTab(control, args)
{
	alert(control.ID)
	alert(args.Tab.ID);
	args.Tab.Select();
}

function DisableTabs()
{
    var tabstrip = window["EntityTabs"];
    selectedTabIndex = tabstrip.SelectedIndex;
    var coll = tabstrip.Tabs;
    for (var i = 0; i < coll.length; i++)
    {
		if (i != selectedTabIndex)
			coll[i].Disable();
    }
}

function TabCallback(sender, eventArgs)
{
	if (clicked)
	{
		clicked = false;
		return;
	}
	clicked = true;
	DisableTabs();


	document.all("request_source").value = "entity_tabs";			
	document.all("request_name").value = eventArgs.Tab.Value;
	document.all("request_args").value = window["EntityTree"].SelectedNode.Value;			

	window["MainAjaxManager"].AjaxRequest("entity_tabs");
}

var selectedTabIndexAssoc = 0;
var clickedAssoc = false;

function EnableAssocTabs()
{
	var tabstrip = window["EntityAssocTabs"];
	var coll = tabstrip.Tabs;
    for (var i = 0; i < coll.length; i++)
    {
        coll[i].Enable();
    }
	clickedAssoc = false;
}

function DisableAssocTabs()
{
    var tabstrip = window["EntityAssocTabs"];
    selectedTabIndexAssoc = tabstrip.SelectedIndex;
    var coll = tabstrip.Tabs;
    for (var i = 0; i < coll.length; i++)
    {
		if (i != selectedTabIndexAssoc)
			coll[i].Disable();
    }
}

function TabCallbackAssoc(sender, eventArgs)
{
	if (clickedAssoc)
	{
		clickedAssoc = false;
		return;
	}
	clickedAssoc = true;
	DisableAssocTabs();
	
	document.all("request_source").value = "explorer_entity_assoc_tabs";			
	document.all("request_name").value = eventArgs.Tab.Value;
	document.all("request_args").value = window["EntityTree"].SelectedNode.Value;			

	window["MainAjaxManager"].AjaxRequest("explorer_entity_assoc_tabs");
}

function OnSubmitSetRequest(req_src, req_name, req_args)
{			
	document.all("request_source").value = req_src;			
	document.all("request_name").value = req_name;			
	document.all("request_args").value = req_args;
	
	window["mainForm"].submit();
}

function sendUCMSAjaxRequest(req_src, req_name, req_args)
{
	document.all("request_source").value = req_src;			
	document.all("request_name").value = req_name;			
	document.all("request_args").value = req_args;
	
	window["MainAjaxManager"].AjaxRequest();
}

function ResetRequest()
{			
	document.all("request_source").value = "";			
	document.all("request_name").value = "";			
	document.all("request_args").value = "";
}

// for the ucms configurator
// for the ucms
var selectedConfigTabIndex = 0;
var clickedConfig = false;

function EnableConfigTabs()
{
	var tabstrip = window["ConfigTabs"];
	var coll = tabstrip.Tabs;
	
    for (var i = 0; i < coll.length; i++)
    {
        coll[i].Enable();
    }
	clickedConfig = false;
}

function DisableConfigTabs()
{
    var tabstrip = window["ConfigTabs"];
    selectedConfigTabIndex = tabstrip.SelectedIndex;
    var coll = tabstrip.Tabs;
    for (var i = 0; i < coll.length; i++)
    {
		if (i != selectedConfigTabIndex)
			coll[i].Disable();
    }
}

function ConfigTabCallback(sender, eventArgs)
{
	if (clickedConfig)
	{
		clicked = false;
		return;
	}
	clickedConfig = true;
	DisableConfigTabs();

	window["MainAjaxManager"].AjaxRequest(eventArgs.Tab.Value);
}

function OnSaveCodeSetFormValues(req)
{
	document.all("request_name").value =req;			
}


// for sub entities
function OnSubEntityClicked()
{
alert(100);
}

// general
function getTimeElapsedPercent(start_time, end_time)
{
	if (start_time == "" || end_time == "")
		return -1;
	
	var sd = new Date(start_time);
	var ed = new Date(end_time);
	var tn = new Date();

	if (ed < sd)
		return -1;
	else if (ed == sd)
		return 100;
	else if (tn > ed)
		return 100;
	
	var elapsed = tn.getTime() - sd.getTime();
	var tot = ed.getTime()-sd.getTime();
	return elapsed*100/tot;
}

function showProgress(ctrl, start_time, end_time)
{
	var prcnt = getTimeElapsedPercent(start_time, end_time);
	var html = "<table padding=0 spacing=0 border=0 width=100%>" + 
				"<tr>" + 
				"<td class=ProgressBarText width=50%>" + 
				"Time Elapsed&nbsp;" + "(" + Math.ceil(prcnt) + "%)" +
				"</td>" + 
				"<td class=ProgressBarText width=50% align=right>" + 
				"Time Remaining&nbsp;" + "(" + Math.ceil(100-prcnt) + "%)" +
				"</td>" + 
				"</tr>" +
				"</table>" +
				
				"<table padding=0 spacing=0 border=0 width=100%>" + 
				"<tr>" + 
				"<td bgcolor=orange width=" + prcnt + "%>" + 
				"&nbsp;" +
				"</td>" + 
				"<td bgcolor=yellow width=" + eval(100-prcnt) + "%>" + 
				"&nbsp;" + 
				"</td>" + 
				"</tr>" +
				"</table>";
				
	ctrl.innerHTML = html;
}

function ToggleDatePopup(date_control)
{
	date_control.ClientID.ShowPopup();
}

function EntitiesSlidingPane_BeforeExpand(sender, eventArgs)
{
	var pane = eventArgs.paneObj.ID;
	sendUCMSAjaxRequest("entities_pane", "show", pane);	
	return true;
}

function SetCheckBoxValue(c, v)
{
	var ctrl = document.all(c);
	
	if (ctrl == null)
		return;
	if (v == 1 || v == true || v == "True")
		ctrl.checked = true;
	else
		ctrl.checked = false;
}