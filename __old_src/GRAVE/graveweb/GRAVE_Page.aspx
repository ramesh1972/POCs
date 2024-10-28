<%@ Page language="c#" AspCompat="false" Codebehind="GRAVE_PAGE.aspx.cs" AutoEventWireup="false" Inherits="GRAVE.Client.CEntityBrowser" validateRequest="false" %>
<%@ Register TagPrefix="radspl" Namespace="Telerik.WebControls" Assembly="RadSplitter" %>
<%@ Register TagPrefix="radG" Namespace="Telerik.WebControls" Assembly="RadGrid" %>
<%@ Register TagPrefix="radT" Namespace="Telerik.WebControls" Assembly="RadTreeView" %>
<%@ Register TagPrefix="rada" Namespace="Telerik.WebControls" Assembly="RadAjax" %>
<%@ Register TagPrefix="radts" NameSpace="Telerik.WebControls" Assembly="RadTabStrip" %>
<HTML style="HEIGHT: 100%">
	<HEAD>
		<LINK href="StyleSheet.css" type="text/css" rel="stylesheet"></LINK>
		<script src="ucms.js" type="text/javascript"></script>
	</HEAD>
	<body class="BODY" style="MARGIN: 0px; OVERFLOW: hidden; HEIGHT: 100%" scroll="no">
		<form id="mainForm" style="HEIGHT: 100%" runat="server" DESIGNTIMEDRAGDROP="1">
			<!-- Request params for Posts/PostBacks --><INPUT id="request_source" type="hidden" value="-1" name="request_source" runat="server">
			<INPUT id="request_name" type="hidden" value="-1" name="request_name" runat="server">
			<INPUT id="request_args" type="hidden" value="-1" name="request_args" runat="server">
			<!-- Lister Header -->
			<table class="ListerHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<TD vAlign="middle" align="left" width="20%"><A href="http://www.listertechnologies.com/lister/index.asp"><IMG height="44" hspace="10" src="img/lister_logo.jpg" width="152" vspace="10" border="0"></A></TD>
					<TD class="contenttext" vAlign="middle" align="center" width="40%">
						<H4>Lister Technologies Management Systems (LMS)</H4>
					</TD>
					<TD class="contenttext" vAlign="middle" align="right" width="40%"><SPAN class="style12"><SPAN class="style1"><IMG height="7" hspace="2" src="img/orange_bullet.jpg" width="6" align="absMiddle"></SPAN>&nbsp;&nbsp;<A class="blacklink" href="http://www.listertechnologies.com/">Lister Home</SPAN></A>&nbsp;&nbsp;|&nbsp;&nbsp;<A class="blacklink" href="http://www.listertechnologies.com/lister/about_us.asp">About 
							Us</A>&nbsp;&nbsp;|&nbsp;&nbsp;<A class="blacklink" href="http://www.listertechnologies.com/lister/careers.asp">Careers</A>&nbsp;&nbsp;|&nbsp;&nbsp;<A class="blacklink" href="http://www.listertechnologies.com/lister/contactus.asp">Contact 
							Us</A>&nbsp;&nbsp;|&nbsp;&nbsp;<A class="blacklink" href="http://www.listertechnologies.com/lister/sitemap.asp">Sitemap</A>&nbsp;&nbsp;&nbsp;
					</TD>
				</tr>
			</table>
			<!-- Entity Explorer/eBrowser -->
			<table height="86%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="top">
					<td vAlign="top" align="center" width="100%" height="100%"><radspl:radsplitter id="MainSplitter" runat="server" SplitBarsSize="8px" BorderSize="0" PanesBorderSize="0"
							BorderStyle="None" BorderWidth="0px" width="100%" height="100%" skin="Default" orientation="Vertical">
							<radspl:RadPane id="EntityTreePane" runat="server" width="20%" BorderStyle="None" scrolling="Both">
								<DIV class="FormTitle" width="100%">LMS Explorer</DIV>
								<radT:RadTreeView id="EntityTree" runat="Server" AutoPostBack="true"></radT:RadTreeView>
							</radspl:RadPane>
							<radspl:RadSplitBar id="MainSplitBar" runat="server" CollapseMode="Forward"></radspl:RadSplitBar>
							<radspl:RadPane id="EntityViewerHolder" runat="server" scrolling="None" Width="100%">
								<asp:Panel id="EntityViewerPane" runat="server" BorderStyle="None"></asp:Panel>
							</radspl:RadPane>
						</radspl:radsplitter></td>
				</tr>
			</table>
			<!-- Ajaxification --><rada:radajaxmanager id="MainAjaxManager" runat="server" OnAjaxRequest="MainAjaxManager_AjaxRequest"
				EnableAJAX="true">
				<ajaxsettings>
					<rada:AjaxSetting ajaxcontrolid="MainAjaxManager">
						<updatedcontrols>
							<rada:ajaxupdatedcontrol controlid="MainAjaxManager" loadingpanelid=""></rada:ajaxupdatedcontrol>
						</updatedcontrols>
					</rada:AjaxSetting>
					<rada:AjaxSetting ajaxcontrolid="EntityTree">
						<updatedcontrols>
							<rada:ajaxupdatedcontrol controlid="EntityTree" loadingpanelid="LoadingPanel1"></rada:ajaxupdatedcontrol>
							<rada:ajaxupdatedcontrol controlid="EntityViewerPane" loadingpanelid="LoadingPanel1"></rada:ajaxupdatedcontrol>
							<rada:ajaxupdatedcontrol controlid="MainAjaxManager" loadingpanelid=""></rada:ajaxupdatedcontrol>
						</updatedcontrols>
					</rada:AjaxSetting>
				</ajaxsettings>
			</rada:radajaxmanager><rada:ajaxloadingpanel id="LoadingPanel1" Runat="server" Transparency="30">
				<asp:Image id="Image3" style="MARGIN-TOP: 200px" runat="server" BorderWidth="0px" ImageUrl="~/RadControls/AJAX/Skins/Default/loadingProgressbar.gif"
					AlternateText="Loading..."></asp:Image>
			</rada:ajaxloadingpanel><rada:ajaxloadingpanel id="LoadingPanel2" width="75px" height="75px" Runat="server" Transparency="30">
				<asp:Image id="Image1" style="MARGIN-TOP: 140px; MARGIN-LEFT: 150px" runat="server" BorderWidth="0px"
					ImageUrl="~/RadControls/AJAX/Skins/Default/Loading1.gif" AlternateText="Loading"></asp:Image>
			</rada:ajaxloadingpanel>
			<!-- Copyright --></form>
	</body>
</HTML>
