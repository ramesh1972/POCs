using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Telerik.WebControls;

using GRAVE.Server;
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation;
using GRAVE.Server.Entity.Specification; 
using GRAVE.Server.Entity.RunTime; 
  
namespace GRAVE
{
	namespace Client
	{
		public class CEntityBrowser : Page
		{ 
			CGraveSystem GRAVES = null;
			protected DataTable EntityGrid_Source = null;
			protected DataTable EntityAssocGrid_Source = null;

			protected System.Web.UI.HtmlControls.HtmlForm mainForm;
			protected Telerik.WebControls.RadSplitBar MainSplitBar;
			protected Telerik.WebControls.RadSplitter MainSplitter;
			protected Telerik.WebControls.AjaxLoadingPanel LoadingPanel1;
			protected Telerik.WebControls.AjaxLoadingPanel LoadingPanel2;
			protected System.Web.UI.HtmlControls.HtmlInputHidden request_source;
			protected System.Web.UI.HtmlControls.HtmlInputHidden request_name;
			protected System.Web.UI.HtmlControls.HtmlInputHidden request_args;
			protected Telerik.WebControls.RadPane EntityTreePane;
			protected Telerik.WebControls.RadTreeView EntityTree;
			protected System.Web.UI.WebControls.Image Image3;
			protected System.Web.UI.WebControls.Image Image1;
			protected System.Web.UI.WebControls.Panel EntityViewerPane;
			protected Telerik.WebControls.RadPane EntityViewerHolder;
			protected Telerik.WebControls.RadAjaxManager MainAjaxManager;

			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Page Init/Panes layout Functions, Explorer Tree Explorer Panes container functions
			override protected void OnInit(EventArgs e)
			{
				InitializeComponent();					

				// Create the GRAVE
				GRAVES = new CGraveSystem(GRAVE.Server.Globals.GC_GRAVE_ROOT_ENTITY_ID);
				GRAVES.Load();

				// Entity Tree Control
				OnCreate_EntityTree();
				OnInit_EntityTree();

				base.OnInit(e); 
			}
		
			private void InitializeComponent()
			{
				this.Load += new System.EventHandler(this.Page_Load);
				AjaxMan.ResolveUpdatedControls +=new Telerik.WebControls.RadAjaxManager.ResolveUpdatedControlsDelegate(AjaxMan_ResolveUpdatedControls);
			}

			private void Page_Load(object sender, System.EventArgs e)
			{
				if (!IsPostBack)
				{
					// This is the start page code
					OnLoadPage();
				}
				else 
				{
					string target = Request.Params["__EVENTTARGET"];
					string arg = Request.Params["__EVENTARGUMENT"];
					if (!(target == "EntityTree"))
						OnReCreatePage();					
				}
			}

			private void OnLoadPage()
			{
				// This is the start page code that recreates the page first, 
				// loads from stateMan based on request, 
				// loads values from ASP.NET request object via gets, posts, postbacks, asyncreqs, callbacks and processes the request.
				// start by adding base objects and pass on the buck to the child objects, after determining the request.
				OnRequestAddGRAVERootEntity();
				OnRequestShowGRAVERootEntity();

				// set this back (for the initial request)
				Session["SelectedEntityID"] = "1"; // root
				Session["SelectedEntityTab"] = "Entity_View_Code";

				SetPageSkin("Default");
			}

			private void OnReCreatePage()
			{
				object oeid = Session["SelectedEntityID"];
				object osel_tab = Session["SelectedEntityTab"];

				long eid = 1;
				if (oeid != null)
					eid = GRAVE.Utils.ObjectToLong(oeid); 

				string sel_tab = "Entity_View_Code";
				if (osel_tab != null)
					sel_tab = GRAVE.Utils.ObjectToString(osel_tab); 

				// fill all the entity properties, associations, children from the db
				CEntityRT e = new CEntityRT(eid, null);
				e.FillEntity("*");

				// create child panes that represent the entity
				OnDestroy_EntityPanes();
				OnCreate_EntityPanes(eid);
				OnInit_EntityPanes();

				// create/load the entity tabs, show view tab
				OnCreate_EntityTabs(ref e);
				OnCreate_EntitiesTabs(ref e);
				OnCreate_EntityAssocTabs(ref e);

				if (sel_tab.IndexOf("_Assoc") >= 0)
				{
					OnCreate_EntityAssocGrid(ref e, sel_tab);
					OnLoad_EntityAssocGrid(ref e, sel_tab);
				}
				else if (sel_tab.IndexOf("_Main_Grid") >= 0)
				{
					OnCreate_EntitiesGrid(ref e, sel_tab);
					OnLoad_EntitiesGrid(ref e, sel_tab);
				}
				else
				{
					OnLoad_EntityTab(ref e, sel_tab);
					OnCreate_EntityTabContent(ref e, sel_tab);
				}

				SelectEntityTab(sel_tab);	

				SetPageSkin("Default");
			}

			private void SetPageSkin(string skin)
			{
				MainSplitter.Skin = "Vista";

				EntityTree = (RadTreeView) FindControl("EntityTree");
				if (EntityTree != null)
					EntityTree.Skin = "Arrows/3DClassic";
					
				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs != null)
					EntityTabs.Skin = "SimpleBarGreen";

//				RadGrid EntityGrid = (RadGrid) FindControl("EntityGrid");
//				if (EntityGrid != null)
//					EntityGrid.Skin = "Blue";

				RadGrid EntityAssocGrid = (RadGrid) FindControl("EntityAssocGrid");
				if (EntityAssocGrid != null)
					EntityAssocGrid.Skin = "Excel";			
			}
			
			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// The one and only ajax manager
			public RadAjaxManager AjaxMan
			{
				get { return (RadAjaxManager) FindControl("MainAjaxManager"); }
			}

			protected void MainAjaxManager_AjaxRequest(object sender, AjaxRequestEventArgs e)
			{
				MainAjaxManager.ResponseScripts.Clear();
				ResetRequest();
			}

			public void AjaxifyGRAVERequest(string request_source_control_id)
			{
				Client.Utils.AJAX.AddNewAjaxControl(MainAjaxManager, request_source_control_id, Client.Globals.Strings.ReqSrc, ""); 
				Client.Utils.AJAX.AddNewAjaxControl(MainAjaxManager, request_source_control_id, Client.Globals.Strings.ReqName, ""); 
				Client.Utils.AJAX.AddNewAjaxControl(MainAjaxManager, request_source_control_id, "request_args", ""); 
			}

			private void AjaxMan_ResolveUpdatedControls(object sender, UpdatedControlsEventArgs e)
			{
				e.SuppressError = true;				
			}

			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Request Functions/ Entry Points - Posts, PostBack (Events), Async requests - all go through this routine
			// request handlers - specific request routines...
			public void OnRequestAddGRAVERootEntity()
			{
				RadTreeView EntityTree = (RadTreeView) FindControl("EntityTree");
				if (EntityTree == null)
					return;
				
				// --> add the root node
				if (CGraveSystem.TheEngine.RootSystem == null)
					return;

				// ----> create a tree node and add it to the tree
				RadTreeNode root_node = new RadTreeNode(
					CGraveSystem.TheEngine.RootSystem.Name,
					CGraveSystem.TheEngine.RootSystem.ID.ToString()
					);

				root_node.ExpandMode = ExpandMode.ServerSide;
				root_node.ImageUrl = "/ucms/img/ucms.gif";
				EntityTree.Nodes.Add(root_node);
			}

			public bool OnRequestShowEntity(long eid)
			{
				string sel_tab = GetSelectedEntityTab();
				
				// create child panes that represent the entity
				OnDestroy_EntityPanes();
				OnCreate_EntityPanes(eid);
				OnInit_EntityPanes();
								
				// fill al the entity properties, associations, children from the db
				CEntityRT e = new CEntityRT(eid, null);
				e.FillEntity("*");

				// create/load the entity tabs, show view tab
				OnCreate_EntityTabs(ref e);
				OnCreate_EntitiesTabs(ref e);
				OnCreate_EntityAssocTabs(ref e);
				OnCreate_EntityTabContent(ref e, sel_tab);

				if (sel_tab.IndexOf("_Assoc") >= 0)
				{
					OnCreate_EntityAssocGrid(ref e, sel_tab);
					OnLoad_EntityAssocGrid(ref e, sel_tab);
				}
				else if (sel_tab.IndexOf("_Main_Grid") >= 0)
				{
					OnCreate_EntitiesGrid(ref e, sel_tab);
					OnLoad_EntitiesGrid(ref e, sel_tab);
				}
				else
				{
					OnLoad_EntityTab(ref e, sel_tab);
					OnCreate_EntityTabContent(ref e, sel_tab);
				}

/*				if (e.IsAssociation)
				{
					OnCreate_EntityAssocGrid(ref e, sel_tab);
					OnLoad_EntityAssocGrid(ref e, sel_tab);
				}
				else if (sel_tab.IndexOf("_Main_Grid") >= 0)
				{
					OnCreate_EntitiesGrid(ref e, sel_tab);
					OnLoad_EntitiesGrid(ref e, sel_tab);
				}
				else
					OnLoad_EntityTab(ref e, sel_tab);
*/
				SelectEntityTab(sel_tab);	
				
				return true;
			}

			public bool OnRequestShowGRAVERootEntity()
			{
				return true;
			}

			public bool OnRequestUpdateEntity(long eid)
			{
				CEntityRT e = new CEntityRT(eid, null);
				e.FillEntity("entity_id, entity_type_id");

				// iterate through properties array and fetch values from form and set in properties array
				ArrayList props = new ArrayList();
				e.Entity_Type.GetEntityAllPropertyDefs(ref props);

				foreach (CEntityPropertyDef pd in props)
				{
					if (pd != null && pd.property_def_ref != null)
					{
						string prop_value = Request.Params["form_" + pd.property_def_ref.id_name];
						if (prop_value == null)				
							prop_value = Utils.GetRequestParamLikeValue(Page, "form_" + pd.property_def_ref.id_name);

						if (prop_value != null && 
							prop_value != "-1")
						{
							e.SetPropertyValue(pd.property_def_ref.id_name, prop_value);
						}
					}
				}

				// update the entity in the db
				e.UnFillEntity();

				return true;
			}

			public bool OnRequestInsertEntity(long eid)
			{
				// create the parent entity and load its property def(via properties fill) from db
				CEntityRT e = new CEntityRT(eid, null);
				e.FillEntity("entity_id, entity_type_id");

				// create the child entity
				CEntityRT ec = new CEntityRT(-1, null);
				e.Relations.AddChildEntity(ec);

				// get the entity id from the form
				string stid = Request.Params["form_new_entity_type"];
				if (stid == "")
					return false;

				long tid = GRAVE.Utils.ObjectToLong(stid);
				if (tid <= 0)
					return false;

				// iterate through properties array and fetch values from form and set in properties array
				ec.SetEntityType(tid);
				if (ec.Entity_Type == null)
					return false;

				ec.SetPropertyValue("entity_type_id", tid);

				// iterate through props
				ArrayList props = new ArrayList();
				ec.Entity_Type.GetEntityAllPropertyDefs(ref props);

				foreach (CEntityPropertyDef pd in props)
				{
					if (pd != null && pd.property_def_ref != null)
					{
						string prop_value = Request.Params["form_" + pd.property_def_ref.id_name];
						if (prop_value == null)				
							prop_value = Utils.GetRequestParamLikeValue(Page, "form_" + pd.property_def_ref.id_name);

						if (prop_value != null && 
							prop_value != "-1")
						{
							ec.SetPropertyValue(pd.property_def_ref.id_name, prop_value);
						}
					}
				}

				// insert the entity in the db
				ec.NewFillEntity();

				return true;
			}

			public bool OnRequestRemoveEntity(long eid)
			{
				CEntityRT e = new CEntityRT(eid, null);
				e.FillEntity("entity_id, entity_type_id");

				return true;
			}

			// request helpers...
			private string GetRequestSource()
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_source");
				if (h != null)
					return h.Value;
				
				return "";
			}
			
			private string GetRequestName()
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_name");
				if (h != null)
					return h.Value;
				
				return "";
			}

			private string GetRequestArgs()
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_args");
				if (h != null)
					return h.Value;
				
				return "";
			}
			
			private void SetRequestSource(string src)
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_source");
				if (h != null)
					h.Value  = src;
			}
			
			private void SetRequestName(string name)
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_name");
				if (h != null)
					h.Value = name;
			}

			private void SetRequestArgs(string args)
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_args");
				if (h != null)
					h.Value = args;
			}

			public void ResetRequest()
			{
				HtmlInputControl h = (HtmlInputControl) FindControl("request_name");
				if (h != null)
					h.Value = "";
				h = (HtmlInputControl) FindControl("request_source");
				if (h != null)
					h.Value = "";
				h = (HtmlInputControl) FindControl("request_args");
				if (h != null)
					h.Value = "";
			}

			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Entity Tree Functions
			public void OnCreate_EntityTree()
			{
				// create the entity tree
				RadPane tp = (RadPane) FindControl("EntityTreePane");
				
				// The Entity tree will be null since it is loaded at run time...but anyway good practice to check..
				RadTreeView EntityTree = (RadTreeView) FindControl("EntityTree");
				if (EntityTree == null)
				{
					EntityTree = new RadTreeView();
					EntityTree.ID = "EntityTree"; 

					tp.Controls.Add(EntityTree);
				}
			}

			public void OnInit_EntityTree()
			{
				RadTreeView EntityTree = (RadTreeView) FindControl("EntityTree");
				if (EntityTree == null)
					return;

				EntityTree.DragAndDrop=false;
				EntityTree.AutoPostBack = true;
				EntityTree.LoadingMessage = "(loading...)";
				EntityTree.LoadingMessagePosition =  Telerik.WebControls.LoadingMessagePosition.AfterNodeText;

				EntityTree.NodeExpand +=new Telerik.WebControls.RadTreeView.RadTreeViewEventHandler(EntityTree_NodeExpand);
				EntityTree.NodeClick += new Telerik.WebControls.RadTreeView.RadTreeViewEventHandler(EntityTree_NodeClick);
			}

			public void OnDestroy()
			{
				Panel viewer = (Panel) FindControl("EntityViewerPane");
				viewer.Controls.Clear();
			}

			private long GetSelectedEntity()
			{
				RadTreeNode node = EntityTree.SelectedNode;
				if (node != null)
					return GRAVE.Utils.ObjectToLong(node.Value);

				return -1;
			}

			private void AddEntities(RadTreeNode node)
			{
				long ent_id = System.Convert.ToInt32(node.Value);

				GRAVE.Server.Entity.RunTime.CEntityRT ent = new GRAVE.Server.Entity.RunTime.CEntityRT(ent_id, null);
				ent.FillEntity("*"); 

				if (ent.Entity_Type == null)
					return;

				if (ent.Entity_Type.id == 4042)
					ent.FillCollectionEntity("entity_id, entity_type_id, entity_id_name, entity_name");
				else if (ent.Entity_Type.IsSystemType)
					ent.FillSystemEntityRelations("entity_id, entity_type_id, entity_id_name, entity_name");
				else if (ent.Entity_Type.IsResourceType)
					ent.FillEntityResourceRelations("entity_id, entity_type_id, entity_id_name, entity_name");
				else if (ent.Entity_Type.IsDefinitionType || ent.Entity_Type.IsSpecificationType)
					ent.FillDefinitionEntityRelations("entity_id, entity_type_id, entity_id_name, entity_name");

				// fill collection entities for all
				ent.FillEntityCollections();

				AddEntitiesToTreeView(node.Nodes, ent);
			}

			private void AddEntitiesToTreeView(RadTreeNodeCollection node_col, CEntityRT parent) 
			{
				if (node_col == null || parent == null)
					return;

				foreach (CEntityImpl ent in parent)
				{
					if (ent.Entity_Type != null)
					{
						RadTreeNode node = new RadTreeNode();
						node.Text = ent.Name + " (" + ent.Entity_Type.name + ")";
						node.Value = ent.ID.ToString();

						if (ent.HasRelations)
							node.ExpandMode = ExpandMode.ServerSide;

						node.ImageUrl = "/ucms/Img/" + ent.Entity_Type.image_url.Trim();
						if (ent.Entity_Type.image_url.Trim().ToLower() == "default.gif")
							node.ImageExpandedUrl = "/ucms/Img/" + "default_open.gif";

						node_col.Add(node);
					}
				}
			}
		
			public void EntityTree_NodeExpand(object o, Telerik.WebControls.RadTreeNodeEventArgs e)
			{
				e.NodeClicked.Nodes.Clear();
				AddEntities(e.NodeClicked);  
 
				AjaxMan.AjaxSettings[1].UpdatedControls.Remove(new AjaxUpdatedControl("EntityViewerPane", "LoadingPanel1"));  
				SetPageSkin("Default");
			}

			private void EntityTree_NodeClick(object o, RadTreeNodeEventArgs e)
			{
				OnRequestShowEntity(GRAVE.Utils.ObjectToLong(e.NodeClicked.Value));

				// checkthis
				RadGrid EntityAssocGrid = (RadGrid) FindControl("EntityAssocGrid");
				if (EntityAssocGrid != null)
					EntityAssocGrid.DataBind();

				Session["SelectedEntityID"] = e.NodeClicked.Value;
				SetPageSkin("Default");
			}		

			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Entity, Assocs and Sub Entities Functions
			public void OnCreate_EntityPanes(long eid)
			{
				// ***** Start Creating the Page for Real entities *****
				Panel viewer = (Panel) FindControl("EntityViewerPane");
				viewer.Controls.Clear();

				// layout
				Table t = new Table();
				t.ID = "EntityPanes";
				t.Width = Unit.Percentage(100);
				t.Height = Unit.Percentage(100);
				t.BorderStyle = BorderStyle.None; 
				t.CellSpacing = 0;
				t.CellPadding = 0;

				TableRow tr = new TableRow();
				tr.VerticalAlign = VerticalAlign.Top; 
				t.Rows.Add(tr);

				TableCell td = new TableCell();
				td.ID = "EntityViewerTitle";
				td.CssClass = "FormTitle";
				td.Text = "LMS Viewer";

				td.Style.Add("padding", "2px");
				td.Style.Add("padding-bottom", "0px");
				tr.Cells.Add(td);

				tr = new TableRow();
				tr.VerticalAlign = VerticalAlign.Top; 
				t.Rows.Add(tr);

				td = new TableCell();
				td.ID = "EntityTabsCell";
				td.BackColor = System.Drawing.ColorTranslator.FromHtml("#bfdbff");
				td.Style.Add("padding", "3px");
				td.Style.Add("padding-bottom", "0px");
//				td.Height = Unit.Pixel(25);
				tr.Cells.Add(td);

				tr = new TableRow();
				tr.VerticalAlign = VerticalAlign.Top; 
				t.Rows.Add(tr);

				td = new TableCell();
				td.ID = "EntityContentCell";
//				td.Height = Unit.Percentage(80);		
				tr.Cells.Add(td);
				
				viewer.Controls.Add(t);

				// create the child panes
				// entity pane
				OnCreate_EntityPane(eid);
				OnInit_EntityPane();
			}
		

			public void OnInit_EntityPanes()
			{
			}

			public void OnDestroy_EntityPanes()
			{
				OnDestroy_EntityPane();
			}
		
			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Entity Functions
			public void OnCreate_EntityPane(long eid)
			{			
				// create the main pane
				Table e_panes = (Table) FindControl("EntityPanes");
				if (e_panes == null)
					return;

				// create the sub sel_tabs
				TableCell td = (TableCell) e_panes.FindControl("EntityContentCell");
				
				RadSplitter rs = Utils.CreateSplitter(Page, "ECCellSplitter", "EntityContentCell", Telerik.WebControls.RadSplitterOrientation.Horizontal);
				
				RadPane rp = new RadPane();
				rs.Items.Add(rp);
				rp.Height = Unit.Percentage(90);

				Panel ContentPanel = new Panel();
				ContentPanel.ID = "EntityContentPanel";
				rp.Controls.Add(ContentPanel);
				ContentPanel.Style.Add("padding", "12px");
			}

			public void OnInit_EntityPane()
			{
			}

			private void OnDestroy_EntityPane()
			{
			}

			public bool OnCreate_EntityTabs(ref CEntityRT ent)
			{
				if (ent == null)
					return false;

				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs == null)
				{
					EntityTabs = new RadTabStrip();
					EntityTabs.ID = "EntityTabs";
					EntityTabs.AutoPostBack = true;
					EntityTabs.EnableViewState = true;
					EntityTabs.TabClick +=new TabStripEventHandler(EntityTabs_TabClick);
					Control pane_c = FindControl("EntityTabsCell");
					pane_c.Controls.Add(EntityTabs);
				}
								
				EntityTabs.Tabs.Clear();
				if (ent.Entity_Type.id != 4042) // collection
				{
					Telerik.WebControls.Tab t = new Telerik.WebControls.Tab("View " + ent.Entity_Type.name, "Entity_View_Code");
					t.BackColor = System.Drawing.Color.LightSteelBlue;
					EntityTabs.Tabs.Add(t);

					t = new Telerik.WebControls.Tab("Modify " + ent.Entity_Type.name, "Entity_Update_Code");
					t.BackColor = System.Drawing.Color.LightSteelBlue;
					EntityTabs.Tabs.Add(t);

					t = new Telerik.WebControls.Tab("Remove " + ent.Entity_Type.name, "Entity_Remove_Code");
					t.BackColor = System.Drawing.Color.LightSteelBlue;
					EntityTabs.Tabs.Add(t);
				}

				// add the new tabs
				ArrayList ctypes = new ArrayList(); 
				ent.Entity_Type.GetChildTypeDefs(ref ctypes);
				if (ctypes != null && ctypes.Count > 0)
					foreach (CEntityTypeDef def in ctypes)
					{
						if (def.IsSpecificationType)
							continue;

						Telerik.WebControls.Tab t = new Telerik.WebControls.Tab("New " + def.name, def.id + "_Entity_New_Code");
						t.BackColor = System.Drawing.Color.Yellow;
						EntityTabs.Tabs.Add(t);
					}

				if (EntityTabs.Tabs.Count <= 1)
				{
					TableCell td = (TableCell) FindControl("EntityTabsCell");
					if (td != null)
					{
						td.Height = Unit.Pixel(0);
						td.Style.Add("padding", "0");
					}
				}

				Utils.AJAX.AddNewAjaxSetting(AjaxMan, "EntityTabs"); 
				Utils.AJAX.AddNewAjaxControl(AjaxMan, "EntityTabs", "EntityContentPanel", "LoadingPanel2");
				Utils.AJAX.AddNewAjaxControl(AjaxMan, "EntityTabs", "EntityTabs", "LoadingPanel2");

				return true;
			}

			public void OnLoad_EntityTab(ref CEntityRT ent, string panel_name)
			{
				if (ent == null)
					return;

				if (panel_name == null || panel_name == "")
					panel_name = "Entity_View_Code";
									
				// find and load in the content panel
				Panel cp = (Panel) FindControl("EntityContentPanel");
				if (cp == null)
					return;

				// get the GUI spec
				CEntityGUICodeSpec gui_spec = null;
				if (panel_name.IndexOf("_New_Code") > 0)
				{
					int pos = panel_name.IndexOf("Entity_New_Code");
					long ctype_id = GRAVE.Utils.ObjectToLong(panel_name.Substring(0, pos-1));

					CEntityRT e = new CEntityRT(ctype_id, null);
					e.FillEntity("*");
					gui_spec = e.GetGUICodeSpec("Entity_New_Code");
				}
				else
					gui_spec = ent.GetGUICodeSpec(panel_name);

				if (gui_spec == null)
					return;

				// get the panel code
				if (panel_name.IndexOf("_View_Code") > 0 && 
					ent.Entity_Type.IsSpecificationType)
					gui_spec.MakeOutViewHtml();

				// get the parsed code
				string panel_html = gui_spec.GetGUICode(ent);

				// display
				cp.Controls.Clear();
				if (panel_html != "")
				{
					Control c = Page.ParseControl(panel_html);
					cp.Controls.Add(c);
				}
			}

			public bool OnCreate_EntityTabContent(ref CEntityRT ent, string panel_name)
			{
				if (ent == null)
					return false;

				Panel ContentPanel = (Panel) FindControl("EntityContentPanel");
				if (ContentPanel == null)
					return false;

				if (panel_name == "Entity_Update_Code")
				{
					OnCreate_EntityContentFormButtons();
					Panel ent_form = (Panel) FindControl("EntityFormButtons");

					ImageButton save = new ImageButton();
					save.ID = "UpdateEntity";
					save.ImageUrl = "~/img/save_button.gif";
					save.Attributes.Add("runat", "server"); 
					save.Attributes.Add("style", "MARGIN: 10px 0px"); 
					save.CssClass = "button";

					save.Click += new ImageClickEventHandler(UpdateEntity_Click);
					ent_form.Controls.Add(save);

					Utils.AJAX.AddNewAjaxSetting(AjaxMan, "UpdateEntity"); 
					Utils.AJAX.AddNewAjaxControl(AjaxMan, "UpdateEntity", "EntityFormReturnMessage", "LoadingPanel2");
				}
				else if (panel_name.IndexOf("Entity_New_Code") >= 0)
				{
					OnCreate_EntityContentFormButtons();
					Panel ent_form = (Panel) FindControl("EntityFormButtons");

					ImageButton new_e = new ImageButton();
					new_e.ID = "NewEntity";
					new_e.ImageUrl = "~/img/save_button.gif";

					new_e.Attributes.Add("runat", "server"); 
					new_e.Attributes.Add("style", "MARGIN: 10px 0px"); 
					new_e.CssClass = "button";

					new_e.Click += new ImageClickEventHandler(InsertEntity_Click);
					ent_form.Controls.Add(new_e);

					Utils.AJAX.AddNewAjaxSetting(AjaxMan, "NewEntity"); 
					Utils.AJAX.AddNewAjaxControl(AjaxMan, "NewEntity", "EntityFormReturnMessage", "LoadingPanel2");
				}

				return true;
			}

			private void OnCreate_EntityContentFormButtons()
			{
				Panel ContentPanel = (Panel) FindControl("EntityContentPanel");
				if (ContentPanel == null)
					return;

				Panel ent_form = null;
				ent_form = new Panel();
				ent_form.ID = "EntityFormButtons";
				ent_form.Height = Unit.Pixel(40);
				ContentPanel.Controls.Add(ent_form);

				Label msg = new Label();
				msg.ID = "EntityFormReturnMessage";
				msg.CssClass = "FormReturnMessage";
				ent_form.Controls.Add(msg);

				LiteralControl l = new LiteralControl();
				l.Text = "<BR>";
				ent_form.Controls.Add(l);

			}

			private void UpdateEntity_Click(object sender, ImageClickEventArgs e)
			{
				long eid = GetSelectedEntity();
				bool success = OnRequestUpdateEntity(eid);

				Label result = (Label) FindControl("EntityFormReturnMessage");
				if (result != null)
					if (success)
						result.Text = "Updated Successfully";
					else
						result.Text =  "Failed To Update";
			}

			private void InsertEntity_Click(object sender, ImageClickEventArgs e)
			{
				long eid = GetSelectedEntity();
				bool success = OnRequestInsertEntity(eid);

				Label result = (Label) FindControl("EntityFormReturnMessage");
				if (result != null)
					if (success)
						result.Text = "Inserted Successfully";
					else
						result.Text =  "Failed To Insert";
			}

			protected string GetSelectedEntityTab()
			{
				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs == null)
					return "Entity_View_Code";

				return EntityTabs.SelectedTab.Value.ToString(); 
			}

			protected void UnSelectEntityTabs()
			{
				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs == null)
					return;

				foreach(Telerik.WebControls.Tab t in EntityTabs.Tabs)
					t.Selected = false;
			}
			
			protected void SelectEntityTab(string tname)
			{
				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs == null)
					return;

				if (tname == null || tname == "")
					tname = "Entity_View_Code";

				Telerik.WebControls.Tab selt = null;
				foreach(Telerik.WebControls.Tab t in EntityTabs.Tabs)
				{
					t.Selected = false;
					if (t.Value == tname)
						selt = t;
				}

				if (selt != null)
					selt.Selected = true;
			}

			private void EntityTabs_TabClick(object sender, TabStripEventArgs e)
			{
				long id = GetSelectedEntity();

				CEntityRT ent = new CEntityRT(id, null);
				ent.FillEntity("*");

				if (e.Tab.Value.IndexOf("_Assoc") >= 0)
				{
					OnCreate_EntityAssocGrid(ref ent, e.Tab.Value);
					OnLoad_EntityAssocGrid(ref ent, e.Tab.Value);
				}
				else if (e.Tab.Value.IndexOf("_Main_Grid") >= 0)
				{
					OnCreate_EntitiesGrid(ref ent, e.Tab.Value);
					OnLoad_EntitiesGrid(ref ent, e.Tab.Value);
				}
				else
				{
					OnLoad_EntityTab(ref ent, e.Tab.Value);
					OnCreate_EntityTabContent(ref ent, e.Tab.Value);
				}

				SelectEntityTab(e.Tab.Value);

				Session["SelectedEntityTab"] = e.Tab.Value;

				SetPageSkin("Default");			
			}

			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Sub Entities functions			
			private bool OnCreate_EntitiesTabs(ref CEntityRT ent)
			{
				if (ent == null)
					return false;

				// get the sliding zone
				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs == null)
					return false;

				// get all the children types
				ArrayList types = new ArrayList();
				if (ent.Entity_Type != null)
					ent.Entity_Type.GetChildTypeDefs(ref types);

				foreach (CEntityTypeDef td in types)
				{
					if (td.IsSpecificationType)
						continue;

					Telerik.WebControls.Tab t = new Tab(td.name + "(s)", td.id_name + "_Main_Grid");
					EntityTabs.Tabs.Add(t);
					t.BackColor = System.Drawing.Color.Yellow;
				}	
				
				return true;
			}		

			private bool OnCreate_EntitiesGrid(ref CEntityRT parent, string child_grid_name)
			{				
				if (parent == null)
					return false;

				CEntityTypeDef ctype = null;
				int pos = child_grid_name.IndexOf("_Main_Grid");
				if (pos >= 0)
				{
					string ctype_s = "";
					if (parent.Entity_Type.id != 4087)
						ctype_s = child_grid_name.Substring(0, pos); 
					else
						ctype_s = child_grid_name.Substring(0, pos); 

					ArrayList types = new ArrayList();
					parent.Entity_Type.GetChildTypeDefs(ref types);
					foreach (CEntityTypeDef td in types)
					{
						if (td.id_name == ctype_s)
						{
							ctype = td;
							break;
						}
					}
				}

				if (ctype == null)
					return false;
				
				// create the Entities Grid
				Panel gridp = (Panel) FindControl("EntityContentPanel");
				if (gridp == null)
					return false;

				RadGrid EntityGrid = (RadGrid) FindControl("EntityGrid");
				if (EntityGrid == null)
				{
					EntityGrid = new RadGrid();
					EntityGrid.ID = "EntityGrid";
				
					gridp.Controls.Clear();
					gridp.Controls.Add(EntityGrid); 
				}

				EntityGrid_Source = new DataTable();
				OnDestroy_EntitiesGrid(EntityGrid, EntityGrid_Source);
				OnInit_EntitiesGrid(EntityGrid);

				// grid properties
				// add the link image button
				GridButtonColumn but_e = new GridButtonColumn();
				but_e.UniqueName = "entity_id";
				but_e.HeaderStyle.Width = Unit.Pixel(20); 
				but_e.ButtonType = Telerik.WebControls.GridButtonColumnType.ImageButton;  
				but_e.CommandName = "Select";
	
				string img = "img\\"  + ctype.image_url;
				but_e.ImageUrl = img;
				EntityGrid.Columns.Add(but_e); 

				CEntityRT r_ent = new CEntityRT(ctype.id, null);
				r_ent.FillEntity("*");
				CEntityGUIGridSpec i_grid_spec = r_ent.GetEntityGrid("Entity_Main_Grid");

				// set skin
				string skin = GRAVE.Utils.ObjectToString(i_grid_spec.GetPropertyValue("grid_skin"));
				if (skin == "")
					skin = "Default";
				EntityGrid.Skin = skin;

				ArrayList children = i_grid_spec.GetGUIGridColumns();
				foreach (CEntityGUIGridColSpec i_child_col in children)
				{
					long is_visible = GRAVE.Utils.ObjectToLong(i_child_col.GetPropertyValue("grid_col_visibility"));
					if (is_visible == 1)
					{
						long prop_id = GRAVE.Utils.ObjectToLong(i_child_col.GetPropertyValue("grid_entity_property_id"));
						string prop_id_name = "";
						CEntityPropertyDef pd = ctype.GetEntityPropertyDefFromEntityPropID(prop_id, true);
					
						GridBoundColumn boundColumn = new GridBoundColumn();

						if (pd != null)
						{
							boundColumn.HeaderText = pd.property_def_ref.name;
							prop_id_name = pd.property_column_name;
						}

						boundColumn.UniqueName = prop_id_name;
						boundColumn.DataField = prop_id_name;
						//boundColumn.HeaderText = GRAVE.Utils.ObjectToString(i_child_col.GetPropertyValue("grid_col_text"));
						boundColumn.HeaderStyle.Width = Unit.Pixel((int) GRAVE.Utils.ObjectToLong(i_child_col.GetPropertyValue("grid_col_size"))); 

						EntityGrid.Columns.Add(boundColumn);
						EntityGrid_Source.Columns.Add(prop_id_name); 
					}
				}

				return true;
			}
			
			private void OnInit_EntitiesGrid(RadGrid EntityGrid)
			{
				if (EntityGrid == null)
					return;

				Utils.InitGrid(EntityGrid);
				EntityGrid.HeaderStyle.Height = Unit.Pixel(20);
			}

			private bool OnLoad_EntitiesGrid(ref CEntityRT parent, string child_grid_name)
			{				
				if (parent == null)
					return false;

				if (child_grid_name == "")
					return false;

				RadGrid EntityGrid = (RadGrid) FindControl("EntityGrid");
				if (EntityGrid == null)
					return false;

				// get the type from name
				CEntityTypeDef ctype = null;
				int pos = child_grid_name.IndexOf("_Main_Grid");
				if (pos >= 0)
				{
					string ctype_s = "";
					if (parent.Entity_Type.id != 4087)
						ctype_s = child_grid_name.Substring(0, pos); 
					else
						ctype_s = child_grid_name.Substring(0, pos); 

					ArrayList types = new ArrayList();
					parent.Entity_Type.GetChildTypeDefs(ref types);
					foreach (CEntityTypeDef td in types)
					{
						if (td.id_name == ctype_s)
						{
							ctype = td;
							break;
						}
					}
				}

				if (ctype == null)
					return false;

				// start loading the grid
				parent.FillEntityRelations(ctype.id, "*"); 

				ArrayList children = parent.Relations.GetChildren(ctype.id);
				foreach (CEntityImpl entity in children)
				{
					DataRow r = EntityGrid_Source.NewRow();

					ArrayList object_vals = new ArrayList();
					foreach (System.Data.DataColumn d in EntityGrid_Source.Columns)
					{
						object val = entity.Properties.GetViewCodeValue(d.ColumnName);
						if (val == null)
							val = "";
						object_vals.Add(val);
					}
					object[] values = object_vals.ToArray();
					
					r.ItemArray = values;
					EntityGrid_Source.Rows.Add(r);
				}

				EntityGrid.DataSource = EntityGrid_Source;
				EntityGrid.DataBind();

				return true;
			}

			private void OnDestroy_EntitiesGrid(RadGrid EntityGrid, DataTable EntityGrid_Source)
			{
				if (EntityGrid != null)
				{
					EntityGrid.Columns.Clear();
					EntityGrid.Controls.Clear();

					EntityGrid.MasterTableView.Columns.Clear();
					EntityGrid.MasterTableView.Controls.Clear();

					if (EntityGrid_Source != null)
					{
						EntityGrid_Source.Clear();
						EntityGrid_Source.Columns.Clear();
						EntityGrid_Source = null;
					}

					EntityGrid.DataSource = null;
					EntityGrid.Dispose();
				}
			}

			// ========================================================================================
			// ========================================================================================
			// ========================================================================================
			// Entities Association functions
			private bool OnCreate_EntityAssocTabs(ref CEntityRT ent)
			{
				if (ent == null)
					return false;

				RadTabStrip EntityTabs = (RadTabStrip) FindControl("EntityTabs");
				if (EntityTabs == null)
					return false;
				
				ArrayList assoc_defs = null;
				ent.Entity_Type.GetAssociationDefs(ref assoc_defs);
				foreach (CEntityAssociationDef atype in assoc_defs)
				{
					CEntityTypeDef assoc_type = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(atype.association_type_id);
					CEntityTypeDef associate_type = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(atype.associate_entity_type_id);

					if (associate_type != null)
					{
						string title = associate_type.name + "(s)";
						
						Telerik.WebControls.Tab t = new Tab(title, assoc_type.id_name + "_Main_Grid");
						EntityTabs.Tabs.Add(t); 
						t.BackColor = System.Drawing.Color.SpringGreen;
					}
				}
				
				return true;
			}

			private bool OnCreate_EntityAssocGrid(ref CEntityRT entity, string assoc_name)
			{				
				if (entity == null)
					return false;

				CEntityAssociationDef assoc_def = null;
				int pos = assoc_name.IndexOf("_Main_Grid");
				if (pos >= 0)
				{
					string ctype_s = assoc_name.Substring(0, pos); 
					ArrayList assocs = null;
					entity.Entity_Type.GetAssociationDefs(ref assocs);
					foreach (CEntityAssociationDef ead in assocs)
					{
						CEntityTypeDef eadt = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(ead.association_type_id);
						if (eadt.id_name == ctype_s)
						{
							assoc_def = ead;
							break;
						}
					}
				}

				if (assoc_def == null)
					return false;

				RadGrid EntityAssocGrid = new RadGrid();
				EntityAssocGrid.ID = "EntityAssocGrid";

				Panel cp = (Panel) FindControl("EntityContentPanel");
				cp.Controls.Clear();
				cp.Controls.Add(EntityAssocGrid); 

				OnDestroy_EntityAssocGrid();
				OnInit_EntityAssocGrid();

				EntityAssocGrid_Source = new DataTable();
   
				CEntityTypeDef atype = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(assoc_def.association_type_id); 
				EntityAssocGrid.MasterTableView.CommandItemSettings.AddNewRecordText = "New " + atype.name;

				// start creating the grid columns
				// add the link image button
				GridButtonColumn but_e = new GridButtonColumn();
				but_e.UniqueName = "EntityAssocLinkButton";
				but_e.HeaderStyle.Width = Unit.Pixel(20); 
				but_e.ButtonType = Telerik.WebControls.GridButtonColumnType.ImageButton;  
				but_e.CommandName = "Select";
				but_e.ItemStyle.Width = Unit.Pixel(10);  
				but_e.ItemStyle.Height = Unit.Pixel(10);  

				CEntityTypeDef atype1 = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(assoc_def.associate_entity_type_id);
				string img = "img\\"  + atype1.image_url;
				but_e.ImageUrl = img;
				EntityAssocGrid.Columns.AddAt(0,but_e); 

				// create grid columns
				CEntityGUIGridSpec grid_spec = entity.GetEntityAssociationGrid(assoc_def.association_type_id);

				if (grid_spec != null)
				{			
					ArrayList grid_cols = grid_spec.GetGUIGridColumns();
					foreach (CEntityGUIGridColSpec child_col in grid_cols)
					{
						long prop_id = GRAVE.Utils.ObjectToLong(child_col.GetPropertyValue("grid_entity_property_id"));
						long is_visible = GRAVE.Utils.ObjectToLong(child_col.GetPropertyValue("grid_col_visibility"));

						if (is_visible == 1 || prop_id == 3001 || prop_id == 3004)
						{
							string col_name = "prop_col_" + prop_id;
							string col_header = GRAVE.Utils.ObjectToString(child_col.GetPropertyValue("grid_col_text"));
							int size = (int) GRAVE.Utils.ObjectToLong(child_col.GetPropertyValue("grid_col_size")); 
							string view_code = GRAVE.Utils.ObjectToString(child_col.GetPropertyValue("grid_col_view_code"));
							string ucode = GRAVE.Utils.ObjectToString(child_col.GetPropertyValue("grid_col_update_code"));
							string ncode = GRAVE.Utils.ObjectToString(child_col.GetPropertyValue("grid_col_new_code"));

							GridTemplateColumn tmpl = new GridTemplateColumn();
							tmpl.UniqueName = col_name;
							
							tmpl.DataField = col_name;
							tmpl.HeaderText = col_header;
							
							tmpl.ItemTemplate = new Client.Utils.CTemplatedControl(col_name, view_code, Page, ref entity);

							if (prop_id == 3158)
								tmpl.ColumnEditor = new Client.Utils.CGridColumnEditor("form_associate_entity_id", assoc_def.associate_edit_code, assoc_def.associate_insert_code, Page, assoc_def.association_type_id, entity.ID);
							else
								tmpl.ColumnEditor = new Client.Utils.CGridColumnEditor("form_" + col_name, ucode, ncode, Page, assoc_def.association_type_id, entity.ID);

							if (size == 0)
								size = 100;
							tmpl.HeaderStyle.Width = Unit.Pixel(size);

							if (prop_id == 3004 || prop_id == 3003)
								tmpl.Visible = false;
				
							EntityAssocGrid.Columns.Add(tmpl);
							EntityAssocGrid_Source.Columns.Add(col_name); 
						}
					}

//					EntityAssocGrid.Columns.FindByUniqueName("prop_col_3001").HeaderText = "Assoc ID";
//					EntityAssocGrid.Columns.FindByUniqueName("prop_col_3001").HeaderStyle.Width = Unit.Pixel(50);
				}

				// add edit columsn
				GridEditCommandColumn editc = new GridEditCommandColumn();
				editc.UniqueName = "EntityAssocEditcol";
				editc.ButtonType = Telerik.WebControls.GridButtonColumnType.ImageButton;  
				editc.UpdateImageUrl = "Img\\update.gif";
				editc.EditImageUrl = "Img\\edit.gif";
				editc.InsertImageUrl = "Img\\insert.gif";
				editc.CancelImageUrl = "Img\\cancel.gif";
				editc.HeaderStyle.Width = Unit.Pixel(20);
				editc.ItemStyle.Width = Unit.Pixel(10);  
				editc.ItemStyle.Height = Unit.Pixel(10);  

				EntityAssocGrid.Columns.Add(editc); 

				GridClientDeleteColumn delc = new GridClientDeleteColumn();
				delc.UniqueName = "EntityAssocDelCol";
				delc.ButtonType = Telerik.WebControls.GridButtonColumnType.ImageButton;  
				delc.ImageUrl = "Img\\delete.gif";
				delc.ConfirmText="Are you sure you want to delete the selected row?";
				delc.HeaderStyle.Width = Unit.Pixel(20);
				delc.ItemStyle.Width = Unit.Pixel(10);  
				delc.ItemStyle.Height = Unit.Pixel(10);  

				EntityAssocGrid.Columns.Add(delc); 
				EntityAssocGrid.InsertCommand += new Telerik.WebControls.GridCommandEventHandler(this.EntityAssocGrid_InsertCommand);
				EntityAssocGrid.UpdateCommand += new Telerik.WebControls.GridCommandEventHandler(this.EntityAssocGrid_UpdateCommand);
				EntityAssocGrid.ItemCommand += new Telerik.WebControls.GridCommandEventHandler(this.EntityAssocGrid_ItemCommand);

				return true;
			}

			public void OnInit_EntityAssocGrid()
			{
				RadGrid EntityAssocGrid = (RadGrid) FindControl("EntityAssocGrid");
				if (EntityAssocGrid == null)
					return;

				// common init
				Utils.InitGrid(EntityAssocGrid);

				// overrides
				EntityAssocGrid.Skin = "Excel";
				EntityAssocGrid.GridLines = GridLines.Vertical; 
								
				EntityAssocGrid.HeaderStyle.Font.Size = FontUnit.Point(6);
				EntityAssocGrid.HeaderStyle.Font.Bold = true;
				EntityAssocGrid.HeaderStyle.Height = Unit.Pixel(20);
												
				EntityAssocGrid.MasterTableView.CommandItemDisplay  = Telerik.WebControls.GridCommandItemDisplay.Bottom;
				EntityAssocGrid.MasterTableView.CommandItemStyle.Font.Size  = FontUnit.Point(4);  
				EntityAssocGrid.MasterTableView.EditMode = GridEditMode.InPlace; 
				
				EntityAssocGrid.MasterTableView.Font.Size = FontUnit.Point(7);
			}

			private bool OnLoad_EntityAssocGrid(ref CEntityRT entity, string assoc_name)
			{
				if (entity == null)
					return false;
				
				RadGrid EntityAssocGrid = (RadGrid) FindControl("EntityAssocGrid");
				if (EntityAssocGrid == null)
					return false;

				CEntityAssociationDef assoc_def = null;
				int pos = assoc_name.IndexOf("_Main_Grid");
				if (pos >= 0)
				{
					string ctype_s = assoc_name.Substring(0, pos); 
					ArrayList assocs = null;
					entity.Entity_Type.GetAssociationDefs(ref assocs);
					foreach (CEntityAssociationDef ead in assocs)
					{
						CEntityTypeDef eadt = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(ead.association_type_id);
						if (eadt.id_name == ctype_s)
						{
							assoc_def = ead;
							break;
						}
					}
				}

				if (assoc_def == null)
					return false;

				long associate_type_id = GRAVE.Utils.ObjectToLong(assoc_def.associate_entity_type_id);
				entity.FillEntityAssociations(associate_type_id, "*");

				EntityAssocGrid_Source.Rows.Clear();
				ArrayList associations = entity.Associations.GetEntityAssociations(assoc_def.associate_entity_type_id); 
				if (associations != null)
				{
					foreach (CEntityAssociationImpl ea in associations)
					{
						CEntityImpl assoc = (CEntityImpl) ea;

						DataRow r = EntityAssocGrid_Source.NewRow();
						ArrayList object_vals = new ArrayList();
						foreach (System.Data.DataColumn d in EntityAssocGrid_Source.Columns)
						{
							// strip the prop_col_
							long propid = GRAVE.Utils.ObjectToLong(d.ColumnName.Substring(9));
							
							object val = assoc.Properties.GetValue(propid);
							object_vals.Add(val);
						}
						object[] values = object_vals.ToArray();

						r.ItemArray = values;
						EntityAssocGrid_Source.Rows.Add(r);
					}
				}
				
				EntityAssocGrid.DataSource = EntityAssocGrid_Source;
				EntityAssocGrid.DataBind();
				
				return true;
			}
			
			private void EntityAssocGrid_ItemCommand(object source, Telerik.WebControls.GridCommandEventArgs e)
			{
				DataRow r = null;
				if (EntityAssocGrid_Source.Rows.Count >= 0 && 
					e.Item.RowIndex >= 0 &&
					e.Item.RowIndex < EntityAssocGrid_Source.Rows.Count)
				{
					r = EntityAssocGrid_Source.Rows[e.Item.RowIndex];
				}

				if ( e.CommandName == "Update" )
				{
					Page.Validate();
					if ( !Page.IsValid )
					{
						//UpdateCommand event will not fire
						e.Canceled = true;
						return;
					}
				}
			}

			private void EntityAssocGrid_UpdateCommand(object source, Telerik.WebControls.GridCommandEventArgs e)
			{
				GridEditableItem editedItem = e.Item as GridEditableItem;
				GridTableRow editedRow = e.Item as GridTableRow;
				
				DataRowView drv = (DataRowView) (editedItem.DataItem);
				object oeid = drv["prop_col_3001"];
				object oetid = drv["prop_col_3004"];
				
				long ass_entity_id = GRAVE.Utils.ObjectToLong(oeid);
				OnRequestUpdateEntity(ass_entity_id);

				long eid = GetSelectedEntity();
				CEntityRT ent = new CEntityRT(eid, null);
				ent.FillEntity("entity_id,entity_type_id,entity_name,entity_owner_id");
  
				long ass_type_id = GRAVE.Utils.ObjectToLong(oetid);
				CEntityAssociationDef assoc = ent.Entity_Type.GetEntityAssociationDef(ass_type_id);
				if (assoc != null)
				{
					CEntityTypeDef atype = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(assoc.association_type_id);
					if (atype != null)
					{
						ent.FillEntityAssociations(assoc.associate_entity_type_id, "*");
						OnCreate_EntityAssocGrid(ref ent, atype.id_name + "_Main_Grid");
						OnLoad_EntityAssocGrid(ref ent, atype.id_name + "_Main_Grid");
					}
				}

				//Code for updating the database can go here...
//				AssocGridResult.Text += "Entity updated";
			}

			private void EntityAssocGrid_InsertCommand(object source, GridCommandEventArgs e)
			{
				GridEditableItem editedItem = e.Item as GridEditableItem;
				
				GridInsertionObject drv = (GridInsertionObject) (editedItem.DataItem);
				object oeid = drv.GetPropertyValue("prop_col_3001"); 
				object oetid = Request.Params["form_new_entity_type"];

				long eid = GetSelectedEntity();
				OnRequestInsertEntity(eid);

				CEntityRT ent = new CEntityRT(eid, null);
				ent.FillEntity("entity_id,entity_type_id,entity_name,entity_owner_id");
  
				long ass_type_id = GRAVE.Utils.ObjectToLong(oetid);
				CEntityAssociationDef assoc = ent.Entity_Type.GetEntityAssociationDef(ass_type_id);
				if (assoc != null)
				{
					ent.FillEntityAssociations(assoc.associate_entity_type_id, "*");
					CEntityTypeDef atype = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(assoc.association_type_id);
					if (atype != null)
					{
						ent.FillEntityAssociations(assoc.associate_entity_type_id, "*");
						OnCreate_EntityAssocGrid(ref ent, atype.id_name + "_Main_Grid");
						OnLoad_EntityAssocGrid(ref ent, atype.id_name + "_Main_Grid");
					}
				}			
			}

			private void OnDestroy_EntityAssocGrid()
			{
				RadGrid EntityAssocGrid = (RadGrid) FindControl("EntityAssocGrid");
				if (EntityAssocGrid != null)
				{
					EntityAssocGrid.Columns.Clear();
					EntityAssocGrid.MasterTableView.Columns.Clear();

					if (EntityAssocGrid_Source != null)
					{
						EntityAssocGrid_Source.Clear();
						EntityAssocGrid_Source.Columns.Clear();
						EntityAssocGrid_Source = null;
					}

					EntityAssocGrid.DataSource = null;
				}
			}
		}
	}
}
