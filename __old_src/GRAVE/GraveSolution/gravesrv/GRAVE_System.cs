using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server;  
using GRAVE.Server.Entity; 
using GRAVE.Server.Entity.Locator;
using GRAVE.Server.Entity.Definition;
using GRAVE.Server.Entity.Specification;
using GRAVE.Server.Entity.RunTime;
using GRAVE.Server.Data;

namespace GRAVE
{
	namespace Server
	{
		public class CGraveEngine
		{
			public static CGraveSystem TheEngine = null;
			public CEntityRTLoader TheLoader = null;
			public CEntityLocationInfo TheLocation = null;

			private static Hashtable _entity_locations = new Hashtable(); // virtual info

			protected CGraveEngine()
			{
				if (TheEngine == null)
				{
					// Set the Engine Ref for the whole world to use
					TheEngine = (CGraveSystem) this; // The Engine is the Grave application

					BootEngine();
				}
				else
					TheLoader = TheEngine.TheLoader;
			}

			public virtual void BootEngine()
			{
				// create the singleton loader
				TheLoader = new CEntityRTLoader();

				// create the base_location info
				TheLocation = new CEntityLocationInfo();
				TheLocation.loc_info_id = GRAVE.Server.GlobalsCon.GRAVE_BASE_LOCATION_INFO_ID;
				TheLocation.loc_resource_name = GRAVE.Server.GlobalsCon.GRAVE_BASE_LOCATION_INFO_RESOURCE_NAME;
				TheLocation.loc_type_id = GRAVE.Server.GlobalsCon.GRAVE_BASE_LOCATION_TYPE;

				TheLocation.CreateLocationObject(GRAVE.Server.GlobalsCon.GRAVE_BASE_LOCATION_CONNECTION_STRING);

				// first load all the location info...
				LoadEntityLocationsInfo(TheLocation);

				// load the defintions
				TheLoader.LoadDefinition(TheLocation.loc_info_id);

				// load the specifications
				TheLoader.LoadSpecification(TheLocation.loc_info_id);			
			}

			public void LoadEntityLocationsInfo(CEntityLocationInfo grave_base)
			{
				// fetch real locs and loc types
				Hashtable rlocs = new Hashtable();
				Hashtable loc_types = new Hashtable();

				grave_base.loc_resource_name = "grave_entities_location_types";
				DataTable dt = grave_base.Location.FetchTable("*", "");
				
				if (dt != null)
				{
					foreach (DataRow rw in dt.Rows)
					{
						// not found, so load the property type from db
						CEntityLocationType ltinfo  = new CEntityLocationType();

						ltinfo.loc_type_id = Utils.ObjectToLong(rw["entity_id"]);
						ltinfo.location_name = Utils.ObjectToString(rw["grave_location_name"]);						
					
						loc_types.Add(ltinfo.loc_type_id, ltinfo); 

						// for each loc type fetch loc specific info
						grave_base.loc_resource_name = ltinfo.location_name;
						DataTable dt1 = grave_base.Location.FetchTable("*", "");
				
						if (dt1 != null)
						{
							foreach (DataRow row in dt1.Rows)
							{
								// not found, so load the property type from db
								CEntityLocation l = null;

								if (ltinfo.loc_type_id == 0)
								{
									l = new CEntityDBLocation(grave_base);
									CEntityDBLocation l1 = (CEntityDBLocation) l;
					
									l1.real_location_id = Utils.ObjectToLong(row["entity_id"]);
									l1.server_name = Utils.ObjectToString(row["entity_connection_server"]);
									l1.database_name = Utils.ObjectToString(row["entity_connection_database_name"]);
									l1.user_id = Utils.ObjectToString(row["entity_connection_uid"]);
									l1.password = Utils.ObjectToString(row["entity_connection_pwd"]);
									l1.connection_string = Utils.ObjectToString(row["entity_connection_string"]);
									l1.provider_name = Utils.ObjectToString(row["entity_connection_provider"]);
									l1.dsn = Utils.ObjectToString(row["entity_connection_dsn"]);

									l1.SetDBHandler();

									string key = ltinfo.loc_type_id + "_" + l1.real_location_id;
									rlocs.Add(key, l1);
								}
							}
						}
					}
				}
				
				// fetch the actual (i.e. virtual ) locations for entity types for all purposes
				grave_base.loc_resource_name = "grave_entities_locations_info";
				dt = grave_base.Location.FetchTable("*", "");
				
				if (dt == null)
					return;

				foreach (DataRow rw in dt.Rows)
				{
					// not found, so load the property type from db
					CEntityLocationInfo linfo  = new CEntityLocationInfo();

					linfo.loc_info_id = Utils.ObjectToLong(rw["entity_id"]);
					linfo.location_id = Utils.ObjectToLong(rw["location_id"]);
					linfo.loc_entity_type_id = Utils.ObjectToLong(rw["location_entity_type_id"]);
					linfo.loc_type_id =  Utils.ObjectToLong(rw["location_type_id"]);
					linfo.loc_resource_name = Utils.ObjectToString(rw["location_resource_name"]);
					linfo.loc_uses_guid = Utils.ObjectToBool(rw["location_uses_guid"]);

					linfo.original_resource_name = linfo.loc_resource_name;

					// set the EntityLocation ref 
					string key = linfo.loc_type_id + "_" + linfo.location_id;
					linfo.Location = (CEntityLocation) rlocs[key];

					linfo.Location.location_info = linfo;

					// set the LocationType ref
					linfo._loc_type_ref = (CEntityLocationType) loc_types[linfo.loc_type_id];
	
					_entity_locations.Add(linfo.loc_info_id, linfo); 
				}				
			}

			public CEntityLocationInfo GetEntityLocationInfo(long loc_info_id)
			{
				return (CEntityLocationInfo) _entity_locations[loc_info_id];
			}

			public Hashtable GetEntityLocationsInfo(long loc_ent_type_id)
			{
				Hashtable ret = new Hashtable();
				foreach (CEntityLocationInfo linfo in _entity_locations.Values)
					if (linfo.loc_entity_type_id == loc_ent_type_id)
						ret.Add(linfo.loc_info_id, linfo);


				return ret;
			}		

			public Hashtable GetEntityLocationsInfo()
			{
				return _entity_locations;
			}
		}

		public class CGraveSystem : CGraveEngine 
		{
			private CEntityRT _the_root_system = null;
			private long _the_root_system_id = -1;

			// singleton
			public CGraveSystem(long root_id)
			{
				_the_root_system_id = root_id;
			}

			public virtual void Load()
			{
				CEntityTypeDef sys_type = TheLoader.GetEntityTypeDef(4075);

				// load the root system
				_the_root_system = (CEntityRT) TheLoader.LoadEntity(_the_root_system_id , sys_type, "*");	
				
				// load the sub-systems, their modules, use cases and collections.
				_the_root_system.FillEntityRelations("entity_id, entity_id_name, entity_name"); // This will fill the sub-systems
			}

			public CEntityRT RootSystem
			{
				get 
				{
					return _the_root_system;
				}
			}

			public CEntityRT SpecSystem
			{
				get 
				{
					return null;
				}
			}

			public CEntityRT ConfigSystem
			{
				get 
				{
					return null;
				}
			}

			public CEntityRT AdminSystem
			{
				get 
				{
					return null;
				}
			}

			// properties

			// accessor functions
		}
	}
}