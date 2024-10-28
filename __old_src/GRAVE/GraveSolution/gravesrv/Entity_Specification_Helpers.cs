using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server;  
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation; 
using GRAVE.Server.Entity.RunTime; 
using GRAVE.Server.Data;


namespace GRAVE
{
	namespace Server
	{
		namespace Entity
		{
			namespace Specification
			{
				// =============================================================================================
				public class CEntityTypeSpec : CEntityImpl
				{
					public CEntityTypeSpec EntityBaseTypeSpec = null;

					public CEntityTypeSpec(long ent_type_id, CEntityDecl owner) : base(ent_type_id, owner)
					{
					}

					public override void FillEntity(string properties_to_fill)
					{
						base.FillEntity(properties_to_fill);
						
						// recursively set base type spec
						if (Entity_Type != null)
						{
							CEntityTypeDef this_etype = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(ID);
							if (this_etype != null)
							{
								CEntityTypeDef t = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(4067);
								CEntityTypeDef baset = this_etype.GetBaseTypeRef();
								if (baset != null)
									EntityBaseTypeSpec = (CEntityTypeSpec) CGraveEngine.TheEngine.TheLoader.LoadEntity(baset.id, t, "*");
							}
						}
					}

					public CEntityGUICodeSpec GetGUICodeSpec(long code_id)
					{
						CEntityGUICodeSpec a = (CEntityGUICodeSpec) Relations.GetChildEntity(code_id);
						if (a != null)
							return a;							
						
						// check with type spec
						if (EntityBaseTypeSpec != null)
							return EntityBaseTypeSpec.GetGUICodeSpec(code_id); 

						return null;
					}

					public CEntityGUICodeSpec GetGUICodeSpec(string code_id_name)
					{
						CEntityGUICodeSpec a = (CEntityGUICodeSpec) Relations.GetChildEntity(code_id_name);
						if (a != null)
							return a;							
						
						// check with base type spec
						if (EntityBaseTypeSpec != null)
							return EntityBaseTypeSpec.GetGUICodeSpec(code_id_name); 

						return null;
					}

					public CEntityGUIGridSpec GetEntityGrid(string grid_name)
					{
						CEntityGUIGridSpec a = (CEntityGUIGridSpec) Relations.GetChildEntity(grid_name);
						if (a != null)
							return a;							
						
						// check with base type spec
						if (EntityBaseTypeSpec != null)
							return EntityBaseTypeSpec.GetEntityGrid(grid_name); 

						return null;
					}

					public CEntityGUIGridSpec GetEntityAssociationGrid(long association_type_id)
					{
						CEntityTypeDef def = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(association_type_id);

						CEntityGUIGridSpec a = (CEntityGUIGridSpec) Relations.GetChildEntity(def.id_name + "_Grid");
						if (a != null)
							return a;							

						// build the grid from the assoc type defs
						// get the associate and associator columns from the association definition for the entity
/*						FillEntityRelations(association_type_id, "*");
						CEntityImpl assoc_def = Relations.GetChildEntity(association_type_id);
						CEntityGUIGridSpec agdef = assoc_def.GetEntityGrid("Entity_Assoc_Main_Grid");

						// get the grid columsn from the association type definition
						CEntityTypeDef def1 = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(4045);
						CEntityImpl assoc_def1 = CGraveSystem.TheEngine.TheLoader.LoadEntity(association_type_id, adef, "*");
						CEntityGUIGridSpec agdef1 = assoc_def1.GetEntityGrid("Entity_Assoc_Main_Grid");
						
						// get the grid colmns from the base association type definition
						CEntityTypeDef def2 = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(4045);
						CEntityImpl assoc_def2 = CGraveSystem.TheEngine.TheLoader.LoadEntity(4045, adef, "*");
						CEntityGUIGridSpec agdef2 = assoc_def2.GetEntityGrid("Entity_Assoc_Main_Grid");

						// put the grids together
						// put the properties together
						// put the children together (columns)
						// --> make sure the appropriate associate_type
						// return the grid

						// check with type spec
						if (EntityBaseTypeSpec != null)
							return EntityBaseTypeSpec.GetEntityAssociationGrid(association_type_id); 
*/
						return null;
					}
				}

				// =========================================================================================
				public class CEntityGUICodeSpec : CEntityImpl
				{
					private string code = "";
					private short gui_code_type = 0;

					public CEntityGUICodeSpec(long entity_id, CEntityDecl owner) : base(entity_id, owner)
					{
					}

					public override void FillEntity(string properties_to_fill)
					{
						base.FillEntity(properties_to_fill);

						// fill the props
						code = Utils.ObjectToString(GetPropertyValue("entity_gui_code"));
						gui_code_type = (short) Utils.ObjectToLong(GetPropertyValue("entity_gui_code_type_id"));
					}

					public string GetGUICode(CEntityRT ent)
					{
						if (ent == null || ent.Entity_Type == null || code == "")
							return code;

						int index_of_at = code.IndexOf("@(", 0);

						CGRAVECodeParser parser = new CGRAVECodeParser();
						CEntityImpl this_only = ent;
						string ret_html = parser.ParseAndProcessCode(code, ref index_of_at, ref this_only);

						return ret_html;
					}

					public void MakeOutViewHtml()
					{
						code = GRAVE.Utils.MakeOutViewHtml(code);
					}
				}

				// ======================================================================================
				public class CEntityGUIGridSpec : CEntityImpl
				{
					public CEntityGUIGridSpec BaseGridSpec = null;

					public CEntityGUIGridSpec(long entity_id, CEntityDecl owner) : base(entity_id, owner)
					{
					}

					public override void FillEntity(string properties_to_fill)
					{
						base.FillEntity(properties_to_fill);

						// fill the child column entities
						FillEntityRelations(4088, "*");

						// set the base spec
						long owner_id = Utils.ObjectToLong(Properties.GetValue("entity_owner_id"));
						
/*						CEntityTypeSpec base_spec = CGraveSystem.TheEngine.TheLoader.GetEntityTypeSpec(owner_id);
						if (base_spec != null && base_spec.EntityBaseTypeSpec != null)
						{
							if (!base_spec.EntityBaseTypeSpec.AreGUIGridSpecsFilled)
							{
								base_spec.EntityBaseTypeSpec.FillEntityRelations(4087, "*");
								base_spec.EntityBaseTypeSpec.AreGUIGridSpecsFilled = true;
							}

							BaseGridSpec = (CEntityGUIGridSpec) base_spec.EntityBaseTypeSpec.Relations.GetChildEntity(ID_Name);
						}
*/						
					}

					public object GetGridPropertyValue(string prop_name)
					{
						object val = null; 

						CEntityGUIGridSpec grid = this;
						while (grid != null && val != null) // if not overridden
						{
							val = grid.GetPropertyValue(prop_name);
							grid = grid.BaseGridSpec;
						}

						return val;
					}

					public ArrayList GetGUIGridColumns()
					{
						ArrayList grid_cols = Relations.GetChildren(4088);

						CEntityGUIGridSpec grid = this.BaseGridSpec;
						while (grid != null) // if not overridden
						{
							ArrayList grid_cols_base = grid.Relations.GetChildren(4088);

							foreach (CEntityGUIGridColSpec gc_base in grid_cols_base)
							{
								bool got_it = false;
								foreach (CEntityGUIGridColSpec gc in grid_cols)
								{
									if (gc_base.ID_Name == gc.ID_Name)
									{
										got_it = true;
										break;
									}
								}

								if (!got_it)
									grid_cols.Add(gc_base);
							}

							grid = grid.BaseGridSpec;
						}
						
						return grid_cols;
					}

					public void GetGUIGridColumns(ref ArrayList cols)
					{
						if (BaseGridSpec != null)
							BaseGridSpec.GetGUIGridColumns(ref cols);

						ArrayList grid_cols = Relations.GetChildren(4088);
						foreach (CEntityGUIGridColSpec gc in grid_cols)
							cols.Add(gc);
					}
				}

				public class CEntityGUIGridColSpec : CEntityImpl
				{
					public CEntityGUIGridColSpec(long entity_id, CEntityDecl owner) : base(entity_id, owner)
					{
					}

					public override void FillEntity(string properties_to_fill)
					{
						base.FillEntity(properties_to_fill);
					}
				}
			}
		}
	}
}