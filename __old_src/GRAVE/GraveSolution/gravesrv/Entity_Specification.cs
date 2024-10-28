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
				public class CEntitySpec : CEntityImpl
				{
					protected CEntityTypeSpec EntityTypeSpec = null; // of type CEntityTypeSpec

					// ====================================================================================				
					public CEntitySpec()
					{
					}

					public CEntitySpec(long ent_id) : base(ent_id)
					{
					}

					public CEntitySpec(long ent_id, CEntityRT owner) : base(ent_id, owner)
					{
					}

					// ==================================================================================
					protected void SetEntityTypeSpec()
					{
						CEntityTypeDef t = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(4067);
						if (Entity_Type != null && Entity_Type.id != 4067)
							EntityTypeSpec = (CEntityTypeSpec) CGraveSystem.TheEngine.TheLoader.LoadEntity(Entity_Type.id, t, "*");
					}

					// ==================================================================================
					public override void FillEntity(string properties_to_fetch)
					{
						base.FillEntity(properties_to_fetch);

			//			SetEntityTypeSpec();
					}

					// GUI Codes
					public CEntityGUICodeSpec GetGUICodeSpec(long code_id)
					{
						CEntityGUICodeSpec a = (CEntityGUICodeSpec) Relations.GetChildEntity(code_id);
						if (a != null)
							return a;							
						
						// check with type spec
						return EntityTypeSpec.GetGUICodeSpec(code_id); 
					}

					public CEntityGUICodeSpec GetGUICodeSpec(string code_name)
					{
						CEntityGUICodeSpec a = (CEntityGUICodeSpec) Relations.GetChildEntity(code_name);
						if (a != null)
							return a;							
						
						// check with type spec
						return EntityTypeSpec.GetGUICodeSpec(code_name); 
					}

					public CEntityGUIGridSpec GetEntityGrid(string grid_name)
					{
						CEntityGUIGridSpec a = (CEntityGUIGridSpec) Relations.GetChildEntity(grid_name);
						if (a != null)
							return a;							
						
						// check with type spec
						return EntityTypeSpec.GetEntityGrid(grid_name); 
					}

					public CEntityGUIGridSpec GetEntityAssociationGrid(long association_type_id)
					{
						CEntityTypeDef def = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(association_type_id);

						// fill the grid details from the 
						CEntityGUIGridSpec a = (CEntityGUIGridSpec) Relations.GetChildEntity(def.id_name + "_Grid");
						if (a != null)
							return a;							
						
						// check with type spec
						return EntityTypeSpec.GetEntityAssociationGrid(association_type_id); 
					}
				}

				public class CSpecEntity : CEntityImpl
				{
					public long spec_for_entity_id = -1;

					public Hashtable entity_gui_codes = new Hashtable(); // hash table of CEntityGUICodeSpec objects
					public Hashtable entity_gui_grids = new Hashtable(); // hash table of CEntityGUIGridSpec objects
				}
			}
		}
	}
}