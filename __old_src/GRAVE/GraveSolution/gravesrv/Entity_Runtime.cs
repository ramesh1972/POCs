using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server;  
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation; 
using GRAVE.Server.Entity.Specification; 
using GRAVE.Server.Data;

namespace GRAVE
{
	namespace Server
	{
		namespace Entity
		{
			namespace RunTime
			{
				public class CEntityRT : CEntitySpec
				{					
					// ===================================================================================
					public CEntityRT()
					{
					}

					public CEntityRT(long entity_id) : base(entity_id)
					{
					}

					public CEntityRT(long entity_id, CEntityRT owner) : base(entity_id, owner)
					{
					}
				}
			}
		}
	}
}