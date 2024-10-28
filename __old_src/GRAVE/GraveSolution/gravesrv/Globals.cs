using System;

namespace GRAVE
{
	namespace Server
	{
		public class Globals
		{
			private Globals() {}

			static public short GC_GRAVE_ROOT_ENTITY_ID = 1001;
			static public short GC_GRAVE_PROJECTS_SUBSYSTEM_ID = 1002;
			static public short GC_GRAVE_PROCESS_SUBSYSTEM_ID = 1004;
			static public short GC_GRAVE_PEOPLE_SUBSYSTEM_ID = 1005;
			static public short GC_GRAVE_METRICS_SUBSYSTEM_ID = 1006;

			static public long GC_GRAVE_SYSTEM_ENTITIES_LAST_ID = 9999;
			static public long GC_GRAVE_REAL_ENTITIES_LAST_ID = 9999;
		}
	}
}
