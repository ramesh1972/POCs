using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server;  
using GRAVE.Server.Entity; 
using GRAVE.Server.Entity.Locator; 
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation; 
using GRAVE.Server.Entity.Specification;
using GRAVE.Server.Entity.RunTime;
using GRAVE.Server.Data;

namespace GRAVE
{
	namespace Server
	{
		public class CEntityDefinitionLoader
		{
			public static Hashtable _loaded_property_types = new Hashtable();
			public static Hashtable _loaded_property_defs = new Hashtable();
			private static Hashtable _loaded_entity_types = new Hashtable();

			public CEntityDefinitionLoader()
			{
			}

			// ========================================================================================
			public void LoadDefinition(long location_id)
			{
				// if location_id is -1, then use the default Grave location
				//      i.e. GRAVE.Server.GlobalsCon.Grave_DB_CONNECTION_STRING
				CEntityLocationInfo linfo = CGraveEngine.TheEngine.GetEntityLocationInfo(location_id);
				
				LoadPropertyTypeDefs(linfo);
				LoadPropertyDefs(linfo); 
				LoadEntityTypes(linfo);
			}

			public void LoadPropertyTypeDefs(CEntityLocationInfo linfo)
			{
				if (linfo == null)
					return;

				linfo.SetInfo();
				linfo.loc_resource_name = "entity_property_data_type_defs, grave_entities";
				DataTable dt = linfo.Location.FetchTable("entity_property_data_type_defs.*, grave_entities.entity_id_name, grave_entities.entity_name", "grave_entities.entity_id = entity_property_data_type_defs.entity_id");
				linfo.Reset();

				if (dt == null)
					return;
	
				foreach (DataRow rw in dt.Rows)
				{
					// not found, so load the property type from db
					CPropertyDataTypeDef pt_new = new CPropertyDataTypeDef();

					pt_new.id = Utils.ObjectToLong(rw["entity_id"]);
					pt_new.id_name = Utils.ObjectToString(rw["entity_id_name"]);
					pt_new.name = Utils.ObjectToString(rw["entity_name"]);
					pt_new.parent_id = Utils.ObjectToLong(rw["property_type_parent_id"]);

					_loaded_property_types.Add(pt_new.id, pt_new); 
				}

				// set the base types
				foreach (DictionaryEntry ptid in _loaded_property_types)
				{
					CPropertyDataTypeDef def = (CPropertyDataTypeDef) _loaded_property_types[ptid.Key];
					def.parent_def_ref = (CPropertyDataTypeDef) _loaded_property_types[def.parent_id]; 
				}
			}

			public void LoadPropertyDefs(CEntityLocationInfo linfo)
			{
				if (linfo == null)
					return;

				linfo.SetInfo();
				linfo.loc_resource_name = "entity_property_defs, grave_entities";
				DataTable dt = linfo.Location.FetchTable("entity_property_defs.*, grave_entities.entity_id_name, grave_entities.entity_name",
					"grave_entities.entity_id = entity_property_defs.entity_id");
				linfo.Reset();

				if (dt == null)
					return;

				foreach (DataRow rw in dt.Rows)
				{
					// not found, so load the propertyset
					CPropertyDef pd_new = new CPropertyDef();
					
					pd_new.id = Utils.ObjectToLong(rw["entity_id"]);
					pd_new.id_name = Utils.ObjectToString(rw["entity_id_name"]);
					pd_new.name = Utils.ObjectToString(rw["entity_name"]);
					pd_new.type = CPropertyDataTypeDef.GetPropertyTypeDef(Utils.ObjectToLong(rw["property_type_id"]));

					_loaded_property_defs.Add(pd_new.id, pd_new);
				}
			}		

			public void LoadEntityTypes(CEntityLocationInfo linfo)
			{
				if (linfo == null)
					return;

				linfo.SetInfo();
				linfo.loc_resource_name = "entity_type_defs, grave_entities";
				DataTable dt = linfo.Location.FetchTable("entity_type_defs.*, grave_entities.entity_id_name, grave_entities.entity_name, grave_entities.entity_owner_id",
					"grave_entities.entity_id = entity_type_defs.entity_id");
				linfo.Reset();

				if (dt == null)
					return;
				
				foreach (DataRow rw in dt.Rows)
				{
					// not found, so load the propertyset
					CEntityTypeDef etype_new = new CEntityTypeDef();

					etype_new.id = Utils.ObjectToLong(rw["entity_id"]);
					etype_new.id_name = Utils.ObjectToString(rw["entity_id_name"]);
					etype_new.name = Utils.ObjectToString(rw["entity_name"]);
					etype_new.base_type_id = Utils.ObjectToLong(rw["entity_base_type_id"]);
					etype_new.type_owner_id = Utils.ObjectToLong(rw["entity_owner_id"]);

					etype_new.image_url = Utils.ObjectToString(rw["entity_type_image_url"]);

					_loaded_entity_types.Add(etype_new.id, etype_new);
				}

				// load entity properties
				linfo.SetInfo();
				linfo.loc_resource_name = "entity_properties_defs";
				dt = linfo.Location.FetchTable("*", "");
						
				if (dt != null)
				{
					foreach (DataRow rw in dt.Rows)
					{
						CEntityPropertyDef pdef = new CEntityPropertyDef();

						pdef.entity_prop_def_id = Utils.ObjectToLong(rw["entity_id"]);
						pdef.entity_type_id = Utils.ObjectToLong(rw["entity_type_id"]);
						pdef.property_id = Utils.ObjectToLong(rw["property_id"]);
						pdef.property_column_name = Utils.ObjectToString(rw["property_column_name"]);
						pdef.property_loc_info_id = Utils.ObjectToLong(rw["property_location_info_id"]);

						CEntityTypeDef type = GetEntityTypeDef(pdef.entity_type_id);
						if (type != null)
						{
							type.AddPropertyDef(pdef);

							pdef.entity_type_ref = type;
							pdef.property_def_ref = GetPropertyDef(pdef.property_id);
						}
					}
				}

				// load entity associations
				linfo.SetInfo();
				linfo.loc_resource_name = "entity_associations_defs";
				dt = linfo.Location.FetchTable("*", "");
				linfo.Reset();

				if (dt != null)
				{
					foreach (DataRow rw in dt.Rows)
					{
						CEntityAssociationDef pdef = new CEntityAssociationDef();

						pdef.association_id = Utils.ObjectToLong(rw["entity_id"]);
						pdef.association_type_id = Utils.ObjectToLong(rw["association_type_id"]);
						pdef.associating_entity_type_id = Utils.ObjectToLong(rw["associating_entity_type_id"]);
						pdef.associate_entity_type_id = Utils.ObjectToLong(rw["associate_entity_type_id"]);

						CEntityTypeDef type = GetEntityTypeDef(pdef.associating_entity_type_id);
						if (type != null)
							type.AddAssociationDef(pdef);
					}
				}

				// set entity_type properties like base, owner, child defs etc for each entity_type
				foreach (CEntityTypeDef tdef in _loaded_entity_types.Values)
				{
					tdef.SetBaseTypeRef();
					tdef.SetOwnerEntityType();
				}
			}

			// ========================================================================================
			// gets
			public CPropertyDataTypeDef GetPropertyDataTypeDef(long pid)
			{
				return (CPropertyDataTypeDef) _loaded_property_types[pid];
			}

			public CPropertyDef GetPropertyDef(long pid)
			{
				return (CPropertyDef) _loaded_property_defs[pid];
			}

			public Hashtable GetPropertyDefs()
			{
				return _loaded_property_defs;
			}

			public CEntityTypeDef GetEntityTypeDef(long tid)
			{
				return (CEntityTypeDef) _loaded_entity_types[tid];
			}
		}

		// ========================================================================================
		public class CEntitySpecificationLoader : CEntityDefinitionLoader
		{
			private static Hashtable _loaded_spec_entities = null; // Hashtable of CSpecEntity objects which are composed of the entities sub-specification objects

			public CEntitySpecificationLoader()
			{
				_loaded_spec_entities = new Hashtable();
			}

			public void LoadSpecification(long location_id)
			{
				CEntityLocationInfo linfo = CGraveEngine.TheEngine.GetEntityLocationInfo(location_id);
				
				LoadGUICodeSpecs(linfo);
				LoadGUIGridSpecs(linfo); 
			}

			// ===================================================================================
			public void LoadGUICodeSpecs(CEntityLocationInfo linfo)
			{
				if (linfo == null)
					return;

				// get the collection object
				CEntityTypeDef ct = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(4042);
				CEntityRT codes_coll_entity = (CEntityRT) CGraveEngine.TheEngine.TheLoader.LoadEntity(1016, ct, "*");

				if (codes_coll_entity == null)
					return;
				
				// load all its children which are essentially the gui code spec object
				codes_coll_entity.FillCollectionEntity("*"); // This will call load entity of this class for each child object
				
				// loop through the children and create/update corresponding CSpecEntity objects
				ArrayList codes = codes_coll_entity.Relations.GetChildren(4073);
				foreach (CEntityGUICodeSpec spec in codes)
				{
					long spec_entity_id = Utils.ObjectToLong(spec.GetPropertyValue("spec_for_entity"));
					CSpecEntity spec_entity = (CSpecEntity) _loaded_spec_entities[spec_entity_id];

					if (spec_entity == null)
					{
						spec_entity = (CSpecEntity) CreateSpecEntity(-1);
						spec_entity.spec_for_entity_id = spec_entity_id;
						_AddSpec(spec_entity);
					}

					spec_entity.entity_gui_codes.Add(spec.ID, spec);
				}
			}

			public void LoadGUIGridSpecs(CEntityLocationInfo linfo)
			{
				if (linfo == null)
					return;

				// get the collection object
				CEntityTypeDef ct = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(4042);
				CEntityRT codes_coll_entity = (CEntityRT) CGraveEngine.TheEngine.TheLoader.LoadEntity(1017, ct, "*");

				if (codes_coll_entity == null)
					return;
				
				// load all its children which are essentially the gui code spec object
				codes_coll_entity.FillCollectionEntity("*"); // This will call load entity of this class for each child object
				
				// loop through the children and create/update corresponding CSpecEntity objects
				ArrayList grids = codes_coll_entity.Relations.GetChildren(4087);
				foreach (CEntityGUIGridSpec spec in grids)
				{
					long spec_entity_id = Utils.ObjectToLong(spec.GetPropertyValue("spec_for_entity"));
					CSpecEntity spec_entity = (CSpecEntity) _loaded_spec_entities[spec_entity_id];

					if (spec_entity == null)
					{
						spec_entity = (CSpecEntity) CreateSpecEntity(-1);
						spec_entity.spec_for_entity_id = spec_entity_id;
						_AddSpec(spec_entity);
					}

					spec_entity.entity_gui_grids.Add(spec.ID, spec);
				}
			}

			// ===================================================================================
			protected CEntityDecl CreateSpecEntity(long spec_type_id)
			{
				CEntityDecl newe = null;

				if (spec_type_id == 4073)
					newe = new CEntityGUICodeSpec(spec_type_id, null);
				else if (spec_type_id == 4087)
					newe = new CEntityGUIGridSpec(spec_type_id, null);
				else if (spec_type_id == 4088)
					newe = new CEntityGUIGridColSpec(spec_type_id, null);
				else
					newe = new CSpecEntity();

				return newe;
			}

			// ===================================================================================
			public virtual CEntityDecl LoadEntity(long spec_type_id, string props)
			{
				return null;
			}

			public virtual CEntityDecl LoadEntity(long spec_type_id, CEntityTypeDef spec_type, string props)
			{
				if (spec_type == null)
					return null;

				if (!spec_type.IsSpecificationType && !spec_type.IsDefinitionType)
					return null;

				CEntityImpl newe = (CEntityImpl) CreateSpecEntity(spec_type.id);
				newe.ID = spec_type_id;
				newe.SetEntityType(spec_type.id);

				if (props != "-1")
					newe.FillEntity(props);

				return newe;
			}

			public virtual CEntityDecl LoadEntity(long spec_type_id, CEntityDecl parent, CEntityTypeDef spec_type, string props)
			{
				if (spec_type == null)
					return null;

				if (!spec_type.IsSpecificationType && !spec_type.IsDefinitionType)
					return null;
				
				CEntityImpl newe = (CEntityImpl) CreateSpecEntity(spec_type.id);
				newe.ID = spec_type_id;
				newe.SetEntityType(spec_type.id);
				newe.SetEntityOwnerRef((CEntityImpl) parent);

				if (props != "-1")
					newe.FillEntity(props);

				return newe;
			}

			public virtual CEntityDecl LoadEntity(long ent_id, CEntityDecl parent, string props)
			{		
				return null;
			}

			// ========================================================================================
			public CSpecEntity GetSpecEntity(long entity_id)
			{
				Hashtable table = _loaded_spec_entities;

				if (!table.ContainsKey(entity_id))
					return null;

				return (CSpecEntity) table[entity_id];
			}

			private void _AddSpec(CSpecEntity e)
			{
				if (e == null)
					return;
				
				if (_loaded_spec_entities.Contains(e.spec_for_entity_id))
					_loaded_spec_entities.Remove(e.spec_for_entity_id);

				_loaded_spec_entities.Add(e.spec_for_entity_id, e);
			}
		}

		// ========================================================================================
		public class CEntityRTLoader : CEntitySpecificationLoader
		{
			private static Hashtable _loaded_entities = null;

			public CEntityRTLoader()
			{
				_loaded_entities = new Hashtable();
			}

			// ====================================================================================
			protected CEntityRT CreateEntity()
			{
				return new CEntityRT(-1, null);
			}

			protected CEntityRT CreateEntity(long ent_id)
			{
				CEntityRT ent = new CEntityRT(ent_id, null);
				return ent;
			}

			protected CEntityRT CreateEntity(CEntityTypeDef type)
			{
				CEntityRT ent = CreateEntity();
				if (type != null)
					ent.SetEntityType(type.id);

				return ent;
			}

			// ================================================================================
			public CEntityRT GetEntity(long ent_id)
			{
				return (CEntityRT) _loaded_entities[ent_id];
			}
				
			// ====================================================================================
			public override CEntityDecl LoadEntity(long ent_id, string props)
			{
				CEntityRT ent = GetEntity(ent_id);
				if (ent == null)
				{
					ent = CreateEntity(ent_id);

					if (ent == null)
						return null;
					else
						_AddEntity(ent);
				}

				ent.ID = ent_id;
					
				if (props != "-1")
					ent.FillEntity(props);

				_AddEntity(ent);

				return ent;
			}

			public override CEntityDecl LoadEntity(long ent_id, CEntityTypeDef type, string props)
			{
				if (type == null)
					return LoadEntity(ent_id, props);

				if (type.IsSpecificationType || type.IsDefinitionType)
					return base.LoadEntity(ent_id, type, props);;

				if (type.IsAssociationType)
					return (CEntityDecl) LoadEntityAssociation(ent_id, -1, -1, type, null, props);

				// definition, resource, container entities etc..
				CEntityRT ent = GetEntity(ent_id);
				if (ent == null)
				{
					ent = CreateEntity(ent_id);

					if (ent == null)
						return null;
					else
						_AddEntity(ent);
				}

				ent.ID = ent_id;				
				ent.SetEntityType(type.id);

				if (props != "-1")
					ent.FillEntity(props);

				_AddEntity(ent);

				return ent;
			}

			public override CEntityDecl LoadEntity(long ent_id, CEntityDecl parent, string props)
			{
				if (parent == null)
					return LoadEntity(ent_id, props);

				CEntityRT ent = GetEntity(ent_id);
				if (ent == null)
				{
					ent = CreateEntity(ent_id);

					if (ent == null)
						return null;
					else
						_AddEntity(ent);
				}

				ent.SetEntityOwnerRef((CEntityImpl) parent);

				if (props != "-1")
					ent.FillEntity(props);

				return ent;
			}

			public override CEntityDecl LoadEntity(long ent_id, CEntityDecl parent, CEntityTypeDef type, string props)
			{
				if (type == null)
					return LoadEntity(ent_id, parent, props);

				if (type.IsSpecificationType || type.IsDefinitionType)
					return base.LoadEntity(ent_id, type, props);;

				if (type.IsAssociationType)
					return (CEntityDecl) LoadEntityAssociation(ent_id, -1, -1, type, null, props);

				CEntityRT ent = (CEntityRT) LoadEntity(ent_id, type, props);
				if (ent == null)
					return null;

				ent.SetEntityOwnerRef((CEntityImpl) parent);
				return ent;
			}

			public CEntityAssociationImpl LoadEntityAssociation(long assoc_id, long associate_eid, long associating_eid, 
															CEntityTypeDef type, CEntityAssociationDef def, string props)
			{
				if (type == null || !type.IsAssociationType)
					return null;
					
				CEntityAssociationImpl assoc = new CEntityAssociationImpl(assoc_id, null);
				if (assoc == null)
					return null;

				assoc.ID = assoc_id;
						
				assoc.SetEntityType(type.id);
				assoc.associate_entity_id = associate_eid;
				assoc.associator_entity_id = associating_eid;
				assoc.assoc_def_ref = def;

				if (props != "-1")
					assoc.FillEntity(props);

				return assoc;
			}

			// ===============================================================================
			private void _AddEntity(CEntityRT ent)
			{
				if (ent == null)
					return;

				if (_loaded_entities.ContainsKey(ent.ID))
				{
					_loaded_entities.Remove(ent.ID);
				}

				_loaded_entities.Add(ent.ID, ent);
			}
		}
	}
}