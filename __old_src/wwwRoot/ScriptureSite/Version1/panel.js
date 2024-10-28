var curr_max_node_id = 2;

function LoadDeckPanel(deck_id, panel_id) 
{
	var root_panel_id = -1;
	
	// get the panel from panel_id
	if (panel_id != -1) {
		// do the loading of the panel here
		LoadPanel(deck_id, panel_id);
		root_panel_id = panel_id;
	}
	else {
		root_panel_id = deck_id;
	}
		
	// check for child panels under this panel
	var child_panels = GetNodeChildren(root_panel_id);
		
	for (var idx=0; idx<child_panels; idx++) 
	{
		LoadDeckPanel(deck_id, child_panels[idx]);
	}

		
//	LoadPanel("MainPanel", null);
//	LoadPanel("HeadPanel", "oDivHeadPanel");
}

function LoadPanel(panel_name, panel_obj_name) 
{
	var panel_html_string = "";
	
	if (panel_name == "MainPanel") 
	{
		panel_html_string = "<Table style='border-collapse:collapse;border-width:12;border-color:deepskyblue' border=1 width=100% height=100%>" + 
							"<Tr><Td>" +
							"<Table style='border-collapse:collapse;border-width:8;border-color:aqua' border=1 width=100% height=100%>" +
							"<Tr><Td>" + 
							"<Table style='border-collapse:collapse;border-width:6;border-color:lightblue' border=1 width=100% height=100%>" + 
							"<Tr><Td valign=top align=center>" + 
							"<Table width=100%>" + 
							"<Tr><Td valign=top align=center>" + 
							"<BR>" +
							"<Div id=oDivHeadPanel style='WIDTH: 90%;position:relative' valign=top align=center></Div>" +
							"<BR>" +
							"</Td></Tr>" +
							"<Tr><Td valign=top align=center>" +
							"<Div id=oDivBodyPanel style='WIDTH: 90%;position:relative' valign=top align=center></Div>" +
							"<BR>" +							
							"</Td></Tr></Table>" +
							"</Td></Tr></Table>" +
							"</Td></Tr></Table>" +
							"</Td></Tr></Table>";
							
		document.write(panel_html_string);
		return;
	}
	else if (panel_name == "HeadPanel") 
	{
		panel_html_string = "<Table style='border-collapse:collapse' border=1 width=100% bgcolor=lightgreen cols=4>" +
							"<TBody>" +
							"<Tr><Td colspan=1>" + 
							"<Div id='oDivTextControlSelectScript'></Div>" +
							"</TD>" +
							"<Td colspan=3>" + 
							"<Div id='oDivButtonControlNewScripture'></Div>" +
							"</TD></TR>" + 
							"<Tr><Td colspan=4>" + 
							"<Div id='oDivSelectControlScriptures'></Div>" +  
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lightgreen colspan=4>" + 
							"<span style='font-size:4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"<Tr><Td height=10 bgcolor=white colspan=4>" + 
							"&nbsp;" + 
							"</Td></Tr>" +
							"<Tr valign=top align=center>" +
							"<Td id=tab1 width=25%>" + 
							"<Div id='oDivLinkControlScriptureTab'></Div>" + 
							"</Td>" +
							"<Td id=tab2 width=25%>" + 
							"<Div id='oDivLinkControlInformationTab'></Div>" + 
							"</Td>" +
							"<Td id=tab3 width=25%>" + 
							"<Div id='oDivLinkControlSignificanceTab'></Div>" + 
							"</Td>" +
							"<Td id=tab4 width=25%>" + 
							"<Div id='oDivLinkControlHistoryTab'></Div>" + 
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=4>" + 
							"<span style='font-size:4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"</Tbody>" +
							"</Table>";
							
	}
	else if (panel_name == "Scripture") 
	{
		panel_html_string = "<Table style='border-collapse:collapse' border=1 width=100% bgcolor=darkgray align=center cols=3>" +
							"<Tr><Td colspan=3>" +
							"<Div id='oDivTextBoxControlScriptName'></Div>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=3>" + 
							"<span style='font-size:4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"<Tr valign=top><Td colspan=1>" +
							"<Div id='oDivSelectControlScriptLang'></Div>" +  							
							"</Td>" +  
							"<Td colspan=1>" +
							"<Div id='oDivSelectControlScriptThisLang'></Div>" +  														
							"</Td>" +
							"<Td colspan=1>" +
							"<Div id='oDivSelectControlScriptOtherLang'></Div>" +  																					
							"</Td></Tr>" +
							"<Tr valign=top align=left><Td colspan=1 width=50%>" +
							"<Div id='oDivTextBoxControlStanzasNo'></Div>" +
							"</Td><Td colspan=2 width=50%>" +
							"<Div id='oDivTextBoxControlLinesNo'></Div>" +
							"</Td></Tr>" +
							"<Tr><Td colspan=3>" +
							"<Div id='oDivTextAreaControlProc'></Div>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=3>" + 
							"<span style='font-size:4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"<Tr><Td colspan=1>" +
							"<Div id='oDivTextControlSelectStanza'></Div>" +
							"</TD>" +
							"<Td colspan=2>" + 
							"<Div id='oDivButtonControlNewStanza'></Div>" +
							"</TD>" + 
							"<TR>" + 
							"<TD colspan=2>" +
							"<Div id='oDivSelectControlSelectStanza'></Div>" +  							
							"</TD>" +
							"<TD colspan=1>" +
							"<Div id='oDivButtonControlMoveStanzaUp'></Div>" +
							"<Div id='oDivButtonControlMoveStanzaDown'></Div>" +
							"</Td></Tr>" +
							"<Tr><Td colspan=3>" +
							"<Div id='oDivTextAreaControlStanzaLines'></Div>" +
							"</Td></Tr>" +
							"<Tr><Td colspan=3>" +
							"<Div id='oDivTextAreaControlWordsTrans'></Div>" +
							"</Td></Tr>" +
							"<Tr><Td colspan=3>" +
							"<Div id='oDivTextAreaControlStanzaTrans'></Div>" +
							"</Td></Tr>" +
							"<TR align=left><TD colspan=3>" +
							"<Div id='oDivButtonControlGoPrevStanza'></Div><Div id='oDivButtonControlGoNextStanza'></Div>" +
							"</Td></Tr></Table>";
	}
	else if (panel_name == "Information") 
	{
		panel_html_string = "<Table style='border-collapse:collapse' border=1 width=100% bgcolor=darkgray align=center cols=5>" +
							"<Tr><Td colspan=2 width=50%>" +
							"Scripture Name" + 
							"<BR>" + 
							"<Input type=text id='name' style='border-width:1;border-color:gray' size=64 Value='Om'>" +
							"</Td>" +
							"<Td colspan=2 width=25%>" + 
							"Scripture Type" + 
							"<BR>" + 
							"<Select name='Cmb_ScriptType' style='border-width:1;border-color:gray;width:160'></Select>" +
							"</Td>" + 
							"<Td width=25%>" +
							"Scripture Source" + 
							"<BR>" + 
							"<Select name='Cmb_ScriptSrc' style='border-width:1;border-color:gray;width:160'></Select>" +
							"</TD></TR>" +
							"<Tr><Td colspan=2>" +
							"God, Goddess" + 
							"<BR>" + 
							"<Select name='Cmb_Gods' style='border:0;border-style:small;width=320' size=3 multiple></Select>" +
							"</Td>" + 
							"<TD colspan=3>" +
							"Relations" + 
							"<BR>" + 
							"<Select name='Cmb_GodsRelations' style='border-width:1;border-color:gray;width:320' size=3 multiple></Select>" +
							"</TD></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=5>" +
							"<span style='font-size=4'>&nbsp;</span>" +
							"</Td></Tr>" +
							"<Tr><Td colspan=2>" +
							"Author<Br><Select name='Cmb_Authors' style='border-width:1;border-color:gray;width:320'></Select>" +
							"</Td>" +
							"<Td colspan=3>" +
							"Works<BR><Select name='Cmb_Works' style='border-width:1;border-color:gray;width:320'></Select>" +
							"</Td></Tr>" + 
							"<Tr><Td colspan=5>" +
							"How<BR><Textarea name=Txt_OriginHow style='border-width:1;border-color:gray;width:87%' scroll='auto' rows=4></Textarea>" +
							"</Td></TR>" + 
							"<Tr><Td colspan=2>" +
							"Where<Br><Select name='Cmb_OriginWhere' style='border-width:1;border-color:gray;width:320'></Select>" +
							"</td>" + 
							"<Td valign=bottom colspan=3>" +
							"Date" +
							"</TD></TR>" + 
							"<TR>" + 
							"<TD colspan=2>&nbsp;</TD>" +
							"<TD width=12%>Year</TD><TD width=12%>Month</TD><TD width=12%>Day</TD>" +
							"</TR>" +
							"<TR><TD colspan=2>&nbsp;</TD>" +
							"<TD width=12%><Select name='Cmb_OriginYear' style='border-width:1;border-color:gray;width:80'></Select>" +
							"</TD>" + 
							"<TD width=12%>" +
							"<Select name='Cmb_OriginMonth' style='border-width:1;border-color:gray;width:80'></Select>" +
							"</TD>" + 
							"<TD width=12%>" +
							"<Select name='Cmb_OriginDay' style='border-width:1;border-color:gray;width:80'></Select>" +
							"</TD></TR></Table>";
	}
	else if (panel_name == "Significance") 
	{
		panel_html_string = "<Table style='border-collapse:collapse'  border=1 width=100% bgcolor=darkgray align=center cols=2>" +
							"<Tr><Td colspan=2>" +
							"Scripture Name" + 
							"<BR>" + 
							"<Input type=text id='name' style='border-width:1;border-color:gray' size=64 Value='Om'>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=4>" + 
							"<span style='font-size=4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"<Tr><Td colspan=2>" +
							"Significance (Why)<BR><Textarea name=significance style='border-width:1;border-color:gray;width:87%' scroll='auto' rows=4></Textarea>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=4>" + 
							"<span style='font-size=4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"<Tr><Td colspan=2>" +
							"Health (How this can be used to imporve certain health conditions)" +
							"</Td></Tr>" +
							"<Tr><Td colspan=2>" +
							"Select Health Benefit to Edit&nbsp;&nbsp;&nbsp;&nbsp;<Input type=button id='new_scripture' style='border-width:1;width:110;font-weight:bold;font-size:10;color:blue' Value='New Benefit'>" +
							"</TD></TR>" +
							"<TR><TD colspan=1 width=40%>" +
							"<Select name='scripture' style='border-width:1;width:360' size=3></Select>" +
							"</TD><TD>" +
							"<Input type=button id='move_up' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Up'>" + 
							"<BR>" +
							"<Input type=button id='move_down' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Down'>" +
							"</TD></Tr>" +
							"<Tr valign=top align=left><Td colspan=1 width=50%>" +
							"Health Benefit" + 
							"<BR>" + 
							"<TextArea id='history_period' style='border-width:1;border-color:gray' rows=3 cols=44 Value='1'></TextArea>" +
							"</Td>" +
							"<TD colspan=1 width=50%>" +
							"Select Health Category<BR><Select name='health_cat' style='border-width:1;width:360'></Select>" +
							"</TD></Tr>" +
							"<Tr valign=top align=left><Td colspan=2>" +
							"<Input type=button id='prev_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='<< Previous Benefit'>" +
							"<Input type=button id='next_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='Next Benefit >>'>" +
							"</Td></Tr></Table>";
	}							
	else if (panel_name == "History") 
	{
		panel_html_string = "<Table style='border-collapse:collapse'  border=1 width=100% bgcolor=darkgray align=center cols=2>" +
							"<Tr><Td colspan=2>" +
							"Scripture Name" + 
							"<BR>" + 
							"<Input type=text id='name' style='border-width:1;border-color:gray' size=64 Value='Om'>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=4>" + 
							"<span style='font-size=4'>&nbsp;</span>" + 
							"</Td></Tr>" +
							"<Tr><Td colspan=2>" +
							"Select History to Edit&nbsp;&nbsp;&nbsp;&nbsp;<Input type=button id='new_scripture' style='border-width:1;width:90;font-weight:bold;font-size:10;color:blue' Value='New History'>" +
							"</TD></TR>" +
							"<TR><TD colspan=1 width=40%>" +
							"<Select name='scripture' style='border-width:1;width:360' size=3></Select>" +
							"</TD>" +
							"<TD>" +
							"<Input type=button id='move_up' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Up'>" + 
							"<BR>" +
							"<Input type=button id='move_down' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Down'>" +
							"</TD></Tr>" +
							"<Tr><Td colspan=2 width=50%>" +
							"A Period In History" + 
							"<BR>" + 
							"<TextArea id='history_period' style='border-width:1;border-color:gray' rows=6 cols=80 Value='1'></TextArea>" +
							"</Td></Tr>" +
							"<Tr valign=top align=left><Td colspan=2>" +
							"<Input type=button id='prev_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='<< Previous Period'>" +
							"<Input type=button id='next_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='Next Period >>'>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=4><span style='font-size=4'>" + 
							"&nbsp;" + 
							"</span></Td></Tr>" +
							"<Tr><Td colspan=2>" +
							"Select Bibliography to Edit&nbsp;&nbsp;&nbsp;&nbsp;<Input type=button id='new_scripture' style='border-width:1;width:110;font-weight:bold;font-size:10;color:blue' Value='New Bibliography'>" +
							"</TD></TR>" +
							"<TR><TD colspan=1 width=40%>" +
							"<Select name='scripture' style='border-width:1;width:360' size=3></Select>" +
							"</TD>" +
							"<TD>" +
							"<Input type=button id='move_up' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Up'><BR>" +
							"<Input type=button id='move_down' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Down'>" +
							"</TD></Tr>" +
							"<Tr valign=top align=left><Td colspan=2 width=50%>" +
							"Bibliography<BR><TextArea id='history_period' style='border-width:1;border-color:gray' rows=3 cols=80 Value='1'></TextArea>" +
							"</Td></Tr>" +
							"<Tr valign=top align=left><Td colspan=2>" +
							"<Input type=button id='prev_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='<< Previous Biblio'>" +
							"<Input type=button id='next_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='Next Biblio >>'>" +
							"</Td></Tr>" +
							"<Tr><Td height=6 bgcolor=lime colspan=4><span style='font-size=4'>&nbsp;</span></Td></Tr>" +
							"<Tr valign=top align=left><Td colspan=2>" +
							"Select Internet Link to Edit&nbsp;&nbsp;&nbsp;&nbsp;<Input type=button id='new_scripture' style='border-width:1;width:80;font-weight:bold;font-size:10;color:blue' Value='New Link'>" +
							"</TD></TR>" +
							"<TR><TD colspan=1 width=40%>" +
							"<Select name='scripture' style='border-width:1;width:360' size=3></Select>" +
							"</TD><TD>" +
							"<Input type=button id='move_up' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Up'><BR>" +
							"<Input type=button id='move_down' style='border-width:1;width:40;font-weight:bold;font-size:10;color:blue' Value='Down'>" +
							"</TD></Tr>" +
							"<Tr><Td colspan=1 width=50%>" +
							"Link URL" + 
							"<BR>" + 
							"<input type=text id='link_url' style='border-width:1;border-color:gray;width:360'>" +
							"</Td><Td colspan=1 width=50%>" +
							"Link Title" + 
							"<BR>" + 
							"<input type=text id='link_title' style='border-width:1;border-color:gray;width:360'>" +
							"</Td></Tr>" +
							"<Tr><Td colspan=2 width=100%>" +
							"Browse - <A href='rameshv.dynu.com'>Scripture Site</A>" +
							"</Td>" +
							"<Tr><Td colspan=2>" +
							"<Input type=button id='prev_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='<< Previous Link'>" +
							"<Input type=button id='next_stanza' style='border-width:1;width:120;font-weight:bold;font-size:10;color:blue' Value='Next Link >>'>" +
							"</Td></Tr></Table>";
	}
	
	document.all(panel_obj_name).innerHTML = panel_html_string;
	LoadPanelControls(panel_name);
}

function LoadPanelControls(panel_name) 
{
	if (panel_name == "HeadPanel") {
		LoadControl("oDivTextControlSelectScript", "Node_108", "LabelSelectScript");
		LoadControl("oDivButtonControlNewScripture", "Node_316", "NewScriptureButton");
		LoadControl("oDivSelectControlScriptures", "Node_100", "SelectScript");
		
		LoadControl("oDivLinkControlScriptureTab", "Node_300", "ScriptureTabLink");
		LoadControl("oDivLinkControlInformationTab", "Node_304", "InformationTabLink");
		LoadControl("oDivLinkControlSignificanceTab", "Node_308", "SignificanceTabLink");
		LoadControl("oDivLinkControlHistoryTab", "Node_312", "HistoryTabLink");
	}
	else if (panel_name == "Scripture")
	{
		LogEvent("3 Start Script Name");
		LoadControl('oDivTextBoxControlScriptName', 'Node_111', 'ScriptName');
	
		LogEvent("3 Start Script Lang");
		LoadControl('oDivSelectControlScriptLang', 'Node_130', 'SelectOrgVersionLang');
		//LogEvent("3 Start Script This Lang");
		LoadControl('oDivSelectControlScriptThisLang', 'Node_140', 'SelectThisVersionLang');
		//LogEvent("3 Start Script Other Lang");
		LoadControl('oDivSelectControlScriptOtherLang', 'Node_150', 'SelectOtherVersionLang');
		
		LogEvent("3 Start Log stanza count");
		LoadControl('oDivTextBoxControlStanzasNo', 'Node_160', 'StanzaCount');
		//LogEvent("3 Start Log lines count");
		LoadControl('oDivTextBoxControlLinesNo', 'Node_170', 'LinesPerStanza');
		//LogEvent("3 Start Log recitiation proc");
		LoadControl('oDivTextAreaControlProc', 'Node_180', 'RecitationProcedure');

		LoadControl('oDivTextControlSelectStanza', 'Node_190', 'LabelSelectStanza');
		LoadControl('oDivButtonControlNewStanza', 'Node_193', 'NewStanzaButton');
		LoadControl('oDivSelectControlSelectStanza', 'Node_210', 'SelectStanzaToEdit');
		LoadControl('oDivButtonControlMoveStanzaUp', 'Node_220', 'MoveStanzaUp');
		LoadControl('oDivButtonControlMoveStanzaDown', 'Node_230', 'MoveStanzaDown');

		LoadControl('oDivTextAreaControlStanzaLines', 'Node_240', 'EnterStanzaLines');
		LoadControl('oDivTextAreaControlWordsTrans', 'Node_250', 'EnterStanzaLinesWordsTrans');
		LoadControl('oDivTextAreaControlStanzaTrans', 'Node_260', 'EnterStanzaLinesTrans');

		LoadControl('oDivButtonControlGoPrevStanza', 'Node_270', 'PrevStanza');
		LoadControl('oDivButtonControlGoNextStanza', 'Node_280', 'NextStanza');
	}
	else if (panel_name == "Information")
	{
		LoadControl("Cmb_ScriptType", "Node_12", "ScriptTypes");
		LoadControl("Cmb_ScriptSrc", "Node_15", "ScriptSrcs");
		LoadControl("Cmb_Gods", "Node_18", "Gods");
		LoadControl("Cmb_GodsRelations", "Node_18", "Gods");
		LoadControl("Cmb_Authors", "Node_21", "Authors");
		LoadControl("Cmb_Works", "Node_24", "Works");
		LoadControl("Cmb_OriginWhere", "Node_27", "LocationWhere");
		LoadControl("Cmb_OriginYear", "Node_41", "Years");
		LoadControl("Cmb_OriginMonth", "Node_42", "Months");
		LoadControl("Cmb_OriginDay", "Node_43", "Days");
	}

	//LoadPanelControlValues(panel_name);
}

function LoadPanelControlValues(panel_name) 
{
	if (panel_name == "Scripture") 
	{
		LoadControlValue('Txt_ScriptName', 'Node_2', 'ScriptName');
		LoadControlValue('Cmb_Org_Lang', 'Node_3', 'ScriptOrgLang');
		LoadControlValue('Cmb_OtherLangs', 'Node_4', 'ScriptOthLang');
		LoadControlValue('Cmb_ThisLang', 'Node_5', 'ScriptThisLang');
		
		LoadControlValue("Txt_StanzaCnt", "Node_7", "StanzaCount");
		LoadControlValue("Txt_LinesCnt", "Node_8", "LinesPerStanza");
		LoadControlValue("Txt_Procedure", "Node_9", "RecitiationProcedure");
	}
	else if (panel_name == "Information") 
	{
		LoadControlValue('Txt_OriginHow', 'Node_6', 'OriginHow');
	}
}

