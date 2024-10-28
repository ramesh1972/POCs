using System;
using System.Data;
using System.Collections;

using GRAVE.Server;
using GRAVE.Server.Data;  
using GRAVE.Server.Entity.Definition;    
using GRAVE.Server.Entity.Implementation;  
using GRAVE.Server.Entity.Specification;  
using GRAVE.Server.Entity.RunTime;  

   
namespace TestClient
{
	class CTestGRAVEServer
	{
		public static CGraveSystem _GRAVE = null;

		[STAThread]
		static void Main(string[] args)
		{
			Test_GetRootEntity_TheGRAVE();
//			Test_GetRootEntities_GRAVE_SubSystems();

//			Test_GetEntity();
//			Test_GetRelatedEntities();
//			Test_GetEntityAssociations();

//			Test_EntityUpdate();
//			Test_EntityInsert();

//			Test_Spec_GetGUICode();
//			Test_Spec_GetGUICGrid();

//			Test_EntityTypePropertyTraverse();
		}

		// ======================================================================================
		public static void Test_GetRootEntity_TheGRAVE()
		{
			_GRAVE = new CGraveSystem(GRAVE.Server.Globals.GC_GRAVE_ROOT_ENTITY_ID);
			_GRAVE.Load();

			CEntityRT root = CGraveSystem.TheEngine.RootSystem;
		}

		public static void Test_GetRootEntities_GRAVE_SubSystems()
		{
			CEntityRT ent = (CEntityRT) CGraveSystem.TheEngine.TheLoader.
				LoadEntity(GRAVE.Server.Globals.GC_GRAVE_PROJECTS_SUBSYSTEM_ID, "*"); 

			ent.FillEntityRelations("*");
			ent.FillEntityCollections();
		}

		// =====================================================================================
		public static void Test_GetEntity()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(10001, "*");
		}

		public static void Test_GetRelatedEntities()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(10001, "*");
			ent.FillEntityRelations("*"); // fill modules
		}

		public static void Test_GetEntityAssociations()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(10001, "*");
			ent.FillEntityAssociations(4045, "*");
		}

		// ======================================================================================
		public static void Test_EntityUpdate()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(10001, "*"); // sample_project1
			ent.Properties.SetValue("entity_name", "Sample Project123");
			ent.Properties.SetValue("project_work_units", 12);
			ent.UnFillEntity();
		}

		public static void Test_EntityInsert()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(-1, "-1"); 

			ent.SetEntityType(14); // inserting a module
			ent.Entity_Type.base_type_id = 21; 
			ent.Properties.SetValue("entity_name", "SampleModuleFromTest");
			ent.Properties.SetValue("entity_owner_id", 1000);
			ent.Properties.SetValue("module_description", "Inserted from test client");
			
			ent.NewFillEntity();
		}

		// ======================================================================================
		public static void Test_Spec_GetGUICode()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(10001, "*"); // sample_project1

			CEntityGUICodeSpec gui_spec = ent.GetGUICodeSpec("Entity_View_Code");
			string code = gui_spec.GetGUICode(ent);

			Console.WriteLine(code); 
		}

		public static void Test_Spec_GetGUICGrid()
		{
			CEntityRT ent = (CEntityRT) _GRAVE.TheLoader.LoadEntity(10001, "*"); 

			CEntityGUIGridSpec i_grid_spec = ent.GetEntityGrid("Entity_Main_Grid");

			ArrayList grid_cols = i_grid_spec.GetGUIGridColumns();
		}

		// ======================================================================================
		public static void Test_EntityTypePropertyTraverse()
		{
			CEntityTypeDef t = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(4033);
			t.Reset();
			
			while (t.MoveNext())
			{
				CEntityPropertyDef def = (CEntityPropertyDef) t.Current;
			}
		}
	}
}
