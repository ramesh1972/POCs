using System;

namespace GRAVE
{
	namespace Server
	{
		public class GlobalsCon
		{
			private GlobalsCon() {}

			static public short GRAVE_BASE_LOCATION_INFO_ID = 0; 
			static public short GRAVE_BASE_LOCATION_TYPE = 0; 
			static public string GRAVE_BASE_LOCATION_INFO_RESOURCE_NAME = "grave_entities_locations_info";
			static public string GRAVE_BASE_LOCATION_CONNECTION_STRING = 
				@"Provider=SQLOLEDB;data source=sys\sqlexpress;initial catalog=grave;UID=pmsdev;PWD=pM$d3V22";

			static public string GRAVE_BASE_LOCATION_SRV = "sys\\sqlexpress";
			static public string GRAVE_BASE_LOCATION = "grave";
			static public string GRAVE_BASE_LOCATION_UID = "pmsdev";
			static public string GRAVE_BASE_LOCATION_PWD = "pM$d3V22";

			static public string GRAVE_ENTITIES_LOCATIONS_INFO_TABLE_NAME = "grave_entities_locations_info";

			static public string LORE_DB_SRV = "sys\\sqlexpress";
			static public string LORE_DB = "lore";
			static public string LORE_DB_UID = "pmsdev";
			static public string LORE_DB_PWD = "pM$d3V22";
			static public string LORE_DB_CONNECTION_STRING =
				@"Provider=SQLOLEDB;data source=sys\sqlexpress;initial catalog=lore;UID=pmsdev;PWD=pM$d3V22";

			static public string LORE_ENTITIES_DB_SRV = "sys\\sqlexpress";
			static public string LORE_ENTITIES_DB = "lore_entities";
			static public string LORE_ENTITIES_DB_UID = "pmsdev";
			static public string LORE_ENTITIES_DB_PWD = "pM$d3V22";
			static public string LORE_ENTITIES_DB_CONNECTION_STRING =
				@"Provider=SQLOLEDB;data source=sys\sqlexpress;initial catalog=lore_entities;UID=pmsdev;PWD=pM$d3V22";

		}
	}
}
