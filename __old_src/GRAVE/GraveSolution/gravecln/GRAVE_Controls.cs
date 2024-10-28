using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Data;
using System.Data.OleDb;

using Telerik.WebControls;

using GRAVE.Server;
using GRAVE.Server.Entity.Implementation;    
using GRAVE.Server.Entity.RunTime;    

namespace GRAVE
{
	namespace Client
	{
		public class Utils
		{
			public static Control CreateCaption(Page page, string caption)
			{
				string table = "<TABLE style='BORDER-COLLAPSE: collapse' cellSpacing='0' cellPadding='0' width='100%' border='1'>";
				table+="<TR>";
				table+="<TD class='Caption' vAlign='middle' height='20px'>" + caption + "</TD>";
				table+="</TR>";
				table+="</TABLE>";

				Control c = page.ParseControl(table);
				return c;
			}

			public static RadSlidingZone CreateSlidingZone(string id, RadSplitter rs)
			{
				// create a pane
				RadPane zone_holder = new RadPane();
				zone_holder.ID = id + "_holder";
				zone_holder.Height = Unit.Pixel(30);
				zone_holder.Width = Unit.Percentage(100);
				zone_holder.Scrolling = Telerik.WebControls.RadSplitterPaneScrolling.None; 
				rs.Items.Add(zone_holder);

				RadSlidingZone slidingZone1 = new RadSlidingZone();
				slidingZone1.ID = id;
				slidingZone1.SlideDirection = Telerik.WebControls.RadSplitterSlideDirection.Top;
				zone_holder.Controls.Add(slidingZone1);

				return slidingZone1;
			}

			public static RadSplitter CreateSplitter(Page page, string id, string pid, Telerik.WebControls.RadSplitterOrientation o)
			{
				if (id == null || id == "")
					return null;

				if (pid == null || pid == "")
					return null;

				Control p = page.FindControl(pid);
				if (p == null)
					return null;

				RadSplitter rs = new RadSplitter();
				rs.ID = id;
				rs.Orientation = o;

				p.Controls.Add(rs);
				return rs;
			}

			private void CreateSplitBar(Page page, string id, string splitter, Telerik.WebControls.RadSplitBarCollapseMode mode)
			{
				RadSplitter rs = (RadSplitter) page.FindControl(splitter);
				if (rs == null)
					return;

				RadSplitBar bar = new RadSplitBar();
				bar.CollapseMode = mode;  
				bar.EnableResize = false;
				bar.ID = id;
				rs.Items.Add(bar);				
			}
			
			public static string GetRequestParamLikeValue(Page pg, string id_like)
			{
				System.Collections.Specialized.NameValueCollection prms = pg.Request.Params;
				int idx = 0;
				foreach (string key in prms.AllKeys)
				{
					if (key.IndexOf(id_like) >= 0)
						return (string) prms[idx];

					idx++;
				}

				return null;
			}

			public static void InitGrid(RadGrid grid)
			{
				grid.CellPadding = 0;
				grid.CellSpacing = 0;
				grid.GridLines = GridLines.Horizontal; 

				grid.AutoGenerateColumns= false;
				grid.EnableAJAX=true;
				grid.EnableAJAXLoadingTemplate=true;
				grid.EnableViewState = true;
				grid.MasterTableView.EnableColumnsViewState = true;
				grid.MasterTableView.EnableViewState = true;
				grid.MasterTableView.DataSourcePersistenceMode = GridDataSourcePersistenceMode.NoPersistence;
								
				grid.ClientSettings.ApplyStylesOnClient = true;      
				grid.ClientSettings.AllowColumnHide = true;
				grid.ClientSettings.AllowRowHide = true;
				grid.ClientSettings.Resizing.AllowColumnResize = true;
				grid.ClientSettings.Resizing.AllowRowResize = true;				
				grid.ClientSettings.Resizing.ResizeGridOnColumnResize = true;

				grid.MasterTableView.RowIndicatorColumn.Display = false;
				grid.HeaderStyle.Height = Unit.Pixel(20);
				grid.HeaderStyle.HorizontalAlign = HorizontalAlign.Left;
			}

			public class CTemplatedControl : ITemplate
			{
				protected Panel theCell;
				private string _code = null;
				private string _col_name = null;
				private Page page_ref = null;
				private CEntityImpl ent = null;

				public CTemplatedControl(string col, string code, Page pref, ref CEntityRT e)
				{
					_col_name = col;
					_code = code;
					page_ref = pref;
					ent = e;
				}

				public void InstantiateIn(System.Web.UI.Control container) 
				{						
					theCell = new Panel();
					theCell.ID = "cell_" + _col_name;

					container.Controls.Add(theCell);

					theCell.DataBinding += new System.EventHandler(Cell_EventHandler);
				}

				public void Cell_EventHandler(object sender, System.EventArgs args)
				{
					Panel tc = (Panel) sender;
					GridDataItem container = (GridDataItem) tc.NamingContainer;
					string t = tc.NamingContainer.GetType().ToString();

					if (!container.IsInEditMode)
					{
						DataRowView drv = (DataRowView) container.DataItem;
							
						object val = drv[_col_name];

						if (_code != "")
						{
							long assoc_id = GRAVE.Utils.ObjectToLong(drv["prop_col_3001"]);
							
							_code = GRAVE.Utils.MakeGUICodeForProcessing(_code);
							GRAVE.Server.CGRAVECodeParser p = new GRAVE.Server.CGRAVECodeParser();
					
							
							CEntityAssociationImpl enta = ent.Associations.GetEntityAssociation(assoc_id);
							if (enta != null)
							{
								CEntityImpl thisa = (CEntityImpl) enta;
							
								int index = 0;
								string code = p.ParseAndProcessCode(_code, ref index, ref thisa);
								Control mainc = page_ref.ParseControl(code);

								mainc.ID = "main_" + _col_name;
								tc.Controls.Add(mainc);
								tc.Style.Add("padding", "0");
							}
						}
						else if (val != null)
						{
							tc.Style.Add("padding", "0");
							tc.Controls.Add(page_ref.ParseControl(val.ToString().Trim()));
						}
					}
				}
			}

			public class CGridColumnEditor: Telerik.WebControls.GridTemplateColumnEditor 
			{
				protected Control mainc;

				protected string form_field_name;
				protected long association_type_id;
				protected long associating_entity_id;

				protected string _insert_code;
				protected string _edit_code;
				Page page_ref = null;

				public CGridColumnEditor(string form_field, string edit_code, string insert_code, Page pref, long assoc_tid, long associating_eid)
				{
					form_field_name = form_field;
					page_ref = pref;
					_insert_code = insert_code;
					_edit_code = edit_code;
					associating_entity_id = associating_eid;
					association_type_id = assoc_tid;
				}

				protected override void AddControlsToContainer()
				{
					try
					{
						// decide if the callback is an insert or an update, based on the RowIndex (-1 for inserts)
						long rowi = ((GridItem) (this.ContainerItem)).RowIndex;
						string code = _insert_code;
						CEntityImpl association = null;
						if (rowi != -1)
						{
							code = _edit_code;
							
							// This is an update..fetch the entity from db..
							DataRowView drv = (DataRowView) ContainerItem.DataItem;
							long association_ent_id = GRAVE.Utils.ObjectToLong(drv["prop_col_3001"]);
							association = new CEntityImpl(association_ent_id);
							association.FillEntity("*");
						}
						else
						{
							association = new CEntityRT(-1, null);
							association.SetEntityType(association_type_id); 
							association.Properties.SetValue("associating_entity_id", associating_entity_id);
						}

						// process the code and display in grid item (table cell).
						code = GRAVE.Utils.MakeGUICodeForProcessing(code);
						GRAVE.Server.CGRAVECodeParser p = new GRAVE.Server.CGRAVECodeParser();
						
						int index = 0;
						code = p.ParseAndProcessCode(code, ref index, ref association);

						Control mainc = page_ref.ParseControl(code);
						mainc.ID = "main_" + form_field_name;
						this.ContainerControl.Controls.Add(mainc);
					}
					catch (Exception e)
					{
						string m = e.Message; 
					}
				}

				protected override void LoadControlsFromContainer()
				{
					if (this.ContainerControl.Controls.Count > 0) 
						this.mainc = this.ContainerControl.Controls[0] as Control;
					else
						this.mainc = null;
				}

				public override bool IsInitialized
				{
					get
					{
						return this.mainc != null;
					}
				}
			}

			public abstract class AJAX
			{
				public static void AddNewAjaxSetting(RadAjaxManager MainAjaxManager, string ajax_control_id)
				{
					AjaxSetting ajx_set = new AjaxSetting(ajax_control_id); 
					MainAjaxManager.AjaxSettings.Add(ajx_set);
				}

				public static void AddNewAjaxControl(RadAjaxManager MainAjaxManager, string ajax_control_id, string control_id, string loading_control_id)
				{
					AjaxSetting ajx_set = null;
					foreach (AjaxSetting  ajx_set1 in MainAjaxManager.AjaxSettings)
						if (ajx_set1.AjaxControlID == ajax_control_id)
						{
							ajx_set = ajx_set1;
							break; 
						}

					if (ajx_set == null)
						return;

					Control c = MainAjaxManager.Page.FindControl(control_id);
					if (c != null)
					{
						AjaxUpdatedControl auc = new AjaxUpdatedControl(control_id, loading_control_id);

						// check if it already exists
						if (!ajx_set.UpdatedControls.Contains(auc)) 
							ajx_set.UpdatedControls.Add(auc); 
					}
				}
			}
		}
	}
}
