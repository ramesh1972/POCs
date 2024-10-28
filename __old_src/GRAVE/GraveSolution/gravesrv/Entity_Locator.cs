using System;
using System.Data;
using System.Data.OleDb;
using System.Collections;

using GRAVE.Server;
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation; 
using GRAVE.Server.Entity.Specification; 
using GRAVE.Server.Entity.RunTime; 

using GRAVE.Server.Data;
namespace GRAVE
{
	namespace Server
	{
		namespace Entity
		{
			namespace Locator
			{
				// the one and only entity locator, allocator, modifier and importantly virualizer...
				// i.e. for a given entity_type this object methods go through all the locations set for that entiy_type, 
				// for e.g. project information can come for a db and also from a excel file
				public class CEntityLocator
				{
					// array of CEntityLocationInfo objects on which a request can be executed
					ArrayList possible_locations;

					public CEntityLocator() 
					{
						possible_locations  = new ArrayList();
					}
				
					public bool LocateEntity(CEntityImpl entity_to_locate)
					{						
						// Things: Need to implement the usage of GUID if ID is not set.
						if (entity_to_locate == null ||
							entity_to_locate.ID < 0)
							return false;

						// check point 
						int count = possible_locations.Count;

						Hashtable locs = null;
						if (entity_to_locate.Entity_Type != null)
						{
							CEntityTypeDef type = entity_to_locate.Entity_Type;

							while (type != null)
							{
								Hashtable locs1 = CGraveEngine.TheEngine.GetEntityLocationsInfo(type.id);
								if (locs1 != null)
								{
									foreach (CEntityLocationInfo linfo in locs1.Values)
										AddLocation(linfo);
								}

								if (type.base_type_id <= 0)
									break;

								type = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(type.base_type_id);
							}
						}
						else
						{
							locs = CGraveEngine.TheEngine.GetEntityLocationsInfo(); // search through the whole world! and possible create a bunch of invalid locations as well in the process

							if (locs != null)
								foreach (CEntityLocationInfo linfo in locs.Values)
									AddLocation(linfo);
						}

						// ----> If no loc added, return false..
						if (count == possible_locations.Count)
							return false;

						return true;
					}

					// ====================================================================================================
					public bool FetchEntity(CEntityImpl ent, string properties_to_fetch)
					{
						if (possible_locations.Count == 0 ||
							ent == null ||
							ent.ID < 0)
						{
							ent = null;
							return false;
						}
					
						// loop through multiple locations!..There must be only one instance of any entity 
						// if everything is set correctly..in the dbs.
						// a entity can have a specfic table as well as the default entry in the generic table.
						// The default entry is always fetched via inheritance principle, form the entity fill functions..
						// create a trimmable props array
						ArrayList props = null;
						if (properties_to_fetch.IndexOf(",") > 0)
						{
							props = new ArrayList();
							string []props1 = properties_to_fetch.Split(',');
							foreach (string s in props1)
								props.Add(s);
						}
						else 
						{
							props = new ArrayList();
							props.Add(properties_to_fetch);
						}

						foreach (CEntityLocationInfo linfo in possible_locations) 
							FetchEntityProperties(linfo, ref ent, ref props);

						if (ent != null)
							return true;

						return false;
					}

					private bool FetchEntityProperties(CEntityLocationInfo loc_info, ref CEntityImpl ent, ref ArrayList props)
					{
						if (loc_info == null || ent == null || ent.Entity_Type == null || props == null)
							return false;

						// the located data
						DataRow lentity = null;

						// from the properties_to_fetch get the column names... 
						string select_fields = "";

						if (props != null && props.Count == 1)
						{
							if (props[0].ToString().Equals("*"))
								select_fields = "*";
							else
							{
								string prop = ((string) props[0]).Trim();
								if (ent.Entity_Type != null)
								{
									CEntityPropertyDef pd = ent.Entity_Type.GetEntityPropertyDef(prop);
									if (pd.DoesPropertyBelongToLocation(loc_info))
									{
										select_fields = pd.property_column_name.Trim();
										props.Remove(prop);
									}
									else
										return false;
								}
							}
						}
						else
						{
							// build the entity query string
							for (int idx = 0; idx < props.Count; idx++)
							{
								string prop1 = (string) props[idx];
								string col = "";
								string prop = prop1.Trim();
								if (ent.Entity_Type != null)
								{
									CEntityPropertyDef pd = ent.Entity_Type.GetEntityPropertyDef(prop.Trim());
									if (pd.DoesPropertyBelongToLocation(loc_info))
									{
										col = pd.property_column_name.Trim();
										props.Remove(prop1);
										idx--;
									}
								}

								if (col != "")
									select_fields += col + ",";
							}

							// remove the last ,
							if (select_fields.Length > 0)
								select_fields = select_fields.Remove(select_fields.Length - 1, 1);
						}
					
						// build query
						if (select_fields != "")
						{
							string conds = "entity_id = " + ent.ID;

							// execute and return
							loc_info.SetInfo();
							lentity = loc_info.Location.FetchTableRow(select_fields, conds);
							loc_info.Reset();
						}

						SetEntityProperties(lentity, ref ent, select_fields);

						return true;
					}

					private void SetEntityProperties(DataRow entity_row, ref CEntityImpl ent, string properties_to_fetch)
					{
						if (entity_row == null || ent == null)
							return;

						// set the type first
						if (entity_row.Table.Columns.Contains("entity_type_id"))
							ent.SetEntityType(Utils.ObjectToLong(entity_row["entity_type_id"]));

						// --> based on type and the required properties create properties array for the 
						//	   entity and then fill.
						// ----> from the type get the property set id 

						// ----> from property set id and relations table fetch all properties.
						// ----> Iterate through the row from database and fill in the properties.!
						int idx = 0;
						foreach (object item in entity_row.ItemArray)
						{
							ent.SetPropertyValueFromLocation(entity_row.Table.Columns[idx].ColumnName, item);
							idx++;
						}
					}

					// ====================================================================================================
					public Hashtable FetchRelatedEntities(CEntityImpl entity, long rel_ent_type_id, string properties_to_fetch)
					{
						if (entity == null || entity.Entity_Type == null)
							return null;

						// create the list of entities to be returned
						Hashtable rents = new Hashtable();

						// get the type object
						CEntityTypeDef ct = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(rel_ent_type_id);

						// create a list of properties to fetch and trim it, so that the number of hits to the real location can be minimized
						ArrayList props = new ArrayList();
						string []props1 = null;
						if (!properties_to_fetch.Equals("*"))
						{
							props1 = properties_to_fetch.Split(',');

							foreach (string prop in props1)
								props.Add(prop.Trim());
						}

						// fetch children of the entity from base location
						ArrayList types = new ArrayList(); 

						// query for children in the grave base
						// build the select
						string sel = "";

						for (int idx = 0; idx < props.Count; idx++)
						{
							string prop = (string) props[idx];
							if (CPropertyDef.IsBaseProperty(prop))
							{
								props.Remove(prop);
								idx--;

								if (prop != "entity_id" && prop != "entity_id_name" && prop != "entity_name" && prop != "entity_type_id")
									sel += prop + ",";
							}
						}

						if (properties_to_fetch != "*")
							sel += "entity_id, entity_type_id, entity_id_name, entity_name";
						else
							sel = "*";

						string conds = "entity_owner_id = " + entity.ID;
						if (rel_ent_type_id > 0)
							conds += " and entity_type_id = " + rel_ent_type_id; 

						CGraveEngine.TheEngine.TheLocation.SetInfo();
						CGraveEngine.TheEngine.TheLocation.loc_resource_name = "grave_entities";
						DataTable dt = CGraveEngine.TheEngine.TheLocation.Location.FetchTable(sel, conds);
						CGraveEngine.TheEngine.TheLocation.Reset();

						string conds_string = "";
						if (dt != null && dt.Rows.Count > 0)
						{
							// --> iterate through children and 
							// ----> create CEntityRelations with CEntityRT with basic properties
							// ----> create an arraylist of entity_type_defs
							foreach (DataRow row in dt.Rows)
							{ 
								long id = Utils.ObjectToLong(row["entity_id"]);

								if (rel_ent_type_id < 0)
								{
									long tid = Utils.ObjectToLong(row["entity_type_id"]);
									ct = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(tid);
									rel_ent_type_id = tid;
								}

								CEntityImpl ent = (CEntityImpl) CGraveEngine.TheEngine.TheLoader.LoadEntity(id, ct, properties_to_fetch);
								if (ent != null)
								{
									int idx = 0;
									foreach (object item in row.ItemArray)
									{
										ent.SetPropertyValueFromLocation(row.Table.Columns[idx].ColumnName, item);
										idx++;
									}

									rents.Add(id, ent);
									ent.SetEntityOwnerRef(entity);
									ent.SetEntityType(rel_ent_type_id);
									conds_string += id + ","; // list of ids
								}
							}							
						}
						else
							return null;

						// check if the props list is exhausted.
						if (properties_to_fetch != "*" && props.Count == 0)
							return rents;

						if (conds_string.LastIndexOf(",") != -1 && conds_string.LastIndexOf(",") == conds_string.Length-1)
							conds_string = conds_string.Substring(0, conds_string.Length-1);

						// locate the entity
						IEnumerator it = rents.GetEnumerator();
						it.Reset();
						it.MoveNext();

						possible_locations.Clear();
						LocateEntity((CEntityImpl) ((DictionaryEntry) it.Current).Value);
							
						// loop through each location 
						foreach (CEntityLocationInfo linfo in possible_locations)
						{
							if (properties_to_fetch != "*" && props.Count == 0)
								break;

							if (linfo.loc_resource_name == "grave_entities")
								continue;
							
							if (properties_to_fetch == "*")
								sel = "*";
							else
							{
								foreach (string prop in props)
								{
									CEntityPropertyDef pd = ct.GetEntityPropertyDef(prop.Trim());
									if (pd.DoesPropertyBelongToLocation(linfo))
									{
										sel += pd.property_column_name.Trim() + ",";
										props.Remove(prop);
									}
								}
							}
							
							if (sel == "")
								continue;

							if (properties_to_fetch != "*")
								sel += "entity_id"; // the key

							conds = "entity_id in ( " + conds_string + " )";

							linfo.SetInfo();
							dt = linfo.Location.FetchTable(sel, conds);
							linfo.Reset();					

							if (dt == null)
								continue;

							foreach (DataRow erow in dt.Rows)
							{ 
								long id = Utils.ObjectToLong(erow["entity_id"]);
								CEntityImpl ent = (CEntityImpl) rents[id];

								// set the properties
								int idx = 0;
								foreach (object item in erow.ItemArray)
								{
									ent.SetPropertyValueFromLocation(erow.Table.Columns[idx].ColumnName, item);
									idx++;
								}
							}
						}

						return rents;
					}

					public bool FetchEntityAssociations(ref CEntityImpl entity, long associate_type_id, string props) // entity is the associating entity
					{
						// entity associations are nothing but another enity so, use the FetchEntity...
						if (entity == null || entity.Entity_Type == null)
							return false;

						// get the assoc def for the associate type id
						CEntityAssociationDef def = entity.Entity_Type.GetEntityAssociationDef(entity.Entity_Type.id, associate_type_id);	
						if (def == null)
							return false;

						// --> fetch children of the entity from default location
						string sel = "grave_entities.entity_id,associating_entity_id,associate_entity_id";
						string res = "grave_entities, grave_associations";
						string conds = "entity_owner_id = " + entity.ID + " and " +
									   "entity_type_id = "  + def.association_type_id + " and " +
									   "grave_entities.entity_id = grave_associations.entity_id";

						CGraveEngine.TheEngine.TheLocation.loc_resource_name = res;
						DataTable dt = CGraveEngine.TheEngine.TheLocation.Location.FetchTable(sel, conds);
						if (dt == null)
							return false;

						CEntityTypeDef assoc_type_def = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(def.association_type_id);

						// --> iterate through children and 
						// ----> create CEntityRelations with CEntityImpl with basic properties
						// ----> create an arraylist of entity_type_defs
						foreach (DataRow row in dt.Rows)
						{ 
							// filter the associations that are of associate_type
							sel = "entity_type_id";
							res = "grave_entities";
							conds = "entity_id = " + Utils.ObjectToLong(row["associate_entity_id"]);

							CGraveEngine.TheEngine.TheLocation.loc_resource_name = res;
							object dtype = CGraveEngine.TheEngine.TheLocation.Location.FetchTableCell(sel, conds);
							long ltype = Utils.ObjectToLong(dtype);
							
							if (ltype == associate_type_id)
							{
								// good to fill this association
								// create an empty association entity and fill
								long aid = Utils.ObjectToLong(row["entity_id"]);
								long associate_entity_id = Utils.ObjectToLong(row["associate_entity_id"]);
								long associating_entity_id = Utils.ObjectToLong(row["associating_entity_id"]);

								CEntityAssociationImpl ent = CGraveSystem.TheEngine.TheLoader.
									LoadEntityAssociation(aid, associate_entity_id, associating_entity_id, assoc_type_def, def, props);
	 
								entity.Associations.AddEntityAssociation(ent);
							}
						}
					
						return true;
					}

					public void UpdateEntity(CEntityImpl entity)
					{
						if (possible_locations.Count == 0 ||
							entity == null ||
							entity.ID < 0)
							return;
					
						for(int idx=0;idx< possible_locations.Count;idx++)
						{
							// --> check against the locations
							CEntityLocationInfo linfo = (CEntityLocationInfo) possible_locations[idx];
					
							// ----> foreach location, i.e db, get the table name
							// ----> for each property in this, check if it is part of table name
							string update_sql = "update " + linfo.loc_resource_name + " set ";
							string update_sql_set = "";
							string update_sql_where = "";

							ArrayList values = entity.Properties.GetPropertyValues();
							foreach (CEntityPropertyValue epv in values)
							{
								if (epv != null &&
									epv.pdefref != null &&
									epv.pdefref.property_def_ref != null)
							
								{
									if (epv.pdefref.property_column_name != "entity_id" &&
										epv.pdefref.property_column_name != "entity_type_id" &&
										epv.pdefref.property_column_name != "entity_id_name" &&
										epv.pdefref.DoesPropertyBelongToLocation(linfo))
										update_sql_set += epv.pdefref.property_column_name  + " = " + Utils.GetDBString(epv.pvalue, epv.pdefref.property_def_ref.type.id_name) + ",";
								}
							}
						
							if (update_sql_set != "")
							{
								update_sql_set =  update_sql_set.Substring(0, update_sql_set.Length-1);
								update_sql_where = "entity_id = " + entity.ID;
								update_sql += update_sql_set + update_sql_where;

								linfo.SetInfo();
								linfo.Location.UpdateRow(update_sql_set, update_sql_where);
							}
						}
						// ------> if yes add then create update sql.
					}

					public void InsertEntity(CEntityImpl entity, ArrayList prop_values)
					{
						possible_locations.Clear();
					
						if (entity.ID < 0)
						{
							// build the insert statement for the entities table..
							string insert_sql = "grave_entities";
							string insert_sql_cols = "entity_id_name, entity_name, entity_type_id, entity_owner_id, entity_guid";

							// --> build the entity_id_name, owner, guid etc..
							entity.GenIDName();
							string guid = Utils.GenNewGUID(); 

							string insert_sql_vals = "'" + entity.ID_Name + "'" + "," +
								"'" + entity.Name + "'" + "," +
								entity.Entity_Type.id + "," +
								entity.OwnerID + "," +
								"'" + guid + "'";
					
							// insert into entites and fetch the entity id
							string qry = insert_sql + insert_sql_cols + insert_sql_vals;

							CGraveSystem.TheEngine.TheLocation.loc_resource_name = insert_sql;
							CGraveSystem.TheEngine.TheLocation.SetInfo();
							CGraveSystem.TheEngine.TheLocation.Location.InsertRow(insert_sql_cols, insert_sql_vals);
							CGraveSystem.TheEngine.TheLocation.Reset();

							// fetch the entity_id
							string sel = "entity_id";
							string conds = "entity_guid = '" + guid + "'";

							CGraveSystem.TheEngine.TheLocation.loc_resource_name = "grave_entities";
							CGraveSystem.TheEngine.TheLocation.SetInfo();
							object oeid = CGraveSystem.TheEngine.TheLocation.Location.FetchTableCell(sel, conds);
							CGraveSystem.TheEngine.TheLocation.Reset();

							long eid = Utils.ObjectToLong(oeid);
							if (eid <= Globals.GC_GRAVE_REAL_ENTITIES_LAST_ID)
								return;

							entity.ID = eid;
						}

						// locate the entity and remove the entities table from the location
						LocateEntity(entity);

						// loop through locations and create and execute inserts into entity specific locations, usually 1 other.
						for (int idx=0;idx< possible_locations.Count;idx++)
						{
							// --> check against the locations
							CEntityLocationInfo linfo = (CEntityLocationInfo) possible_locations[idx];
							linfo.SetInfo();

							string insert_sql = "";
							string insert_sql_cols = "entity_id,";
							string insert_sql_vals = Utils.ObjectToString(entity.ID) + ",";

							foreach (CEntityPropertyValue epv in prop_values)
							{
								if (epv != null &&
									epv.pdefref != null &&
									epv.pdefref.property_def_ref != null)
								{
									if (epv.pdefref.DoesPropertyBelongToLocation(linfo))
									{
										string dbs = Utils.GetDBString(epv.pvalue, epv.pdefref.property_def_ref.type.id_name);
										if (dbs != "")
										{
											insert_sql_cols += epv.pdefref.property_column_name  + ",";
											insert_sql_vals +=  dbs + ",";
										}
									}
								}
							}
						
							if (insert_sql_cols != "entity_id" && 
								insert_sql_cols != "entity_id,") // that is there are property values to be inserted apart from the entity id
							{
								insert_sql = "insert into " + linfo.loc_resource_name + " ";
								insert_sql_cols =  insert_sql_cols.Substring(0, insert_sql_cols.Length-1);
								insert_sql_vals =  insert_sql_vals.Substring(0, insert_sql_vals.Length-1);
							
								insert_sql += "(" + insert_sql_cols + ") values (" + insert_sql_vals + ")";

								linfo.Location.InsertRow(insert_sql_cols, insert_sql_vals);
							}
						}
					}

					private void AddLocation(CEntityLocationInfo linfo)
					{
						if (linfo == null)
							return;

						if (possible_locations.Count == 0)
						{
							possible_locations.Add(linfo);
							return;
						}

						// check if it already exists and then add.
						if (possible_locations.Contains(linfo))
							return;

						possible_locations.Insert(possible_locations.Count, linfo);
					}
				}

				// all location info stuff
				public class CEntityLocationType
				{
					public long loc_type_id = -1;
					public string location_name = "";
				}

				public class CEntityLocationInfo
				{
					public long loc_info_id = -1;
					public long location_id = -1;
					public long loc_entity_type_id = -1;
					public long loc_type_id = -1;
					public string loc_resource_name = "";
					public bool loc_uses_guid = false;

					public string original_resource_name = "";
					public CEntityLocation Location = null;
	
					public CEntityLocationType _loc_type_ref = null;
					public void CreateLocationObject(string connection_string)
					{
						if (loc_type_id == 0)
						{
							Location = new CEntityDBLocation(this, connection_string);
						}
					}

					public void CreateLocationObject(string server, string uid, string pwd)
					{
						if (loc_type_id == 0)
							Location = new CEntityDBLocation(this);

						Location.server_name = server;
						Location.user_id = uid;
						Location.password = pwd;
					}

					public void SetInfo()
					{
						Location.location_info = this;
					}

					public void Reset()
					{
						loc_resource_name = original_resource_name;
					}

				}

				public abstract class CEntityLocation
				{
					public long real_location_id = -1;
					public string server_name = "";
					public string user_id = "";
					public string password = "";
					
					public CEntityLocationInfo location_info = null;

					public abstract DataTable FetchTable(string select_fields, string conditions);
					public abstract DataRow FetchTableRow(string select_fields, string conditions);
					public abstract object FetchTableCell(string select_fields, string conditions);

					public abstract void UpdateRow(string set_string, string conditions);
					public abstract void InsertRow(string cols_string, string vals_string);

					public CEntityLocation(CEntityLocationInfo linfo)
					{
						location_info = linfo;
					}

					protected virtual bool IsLocationSet
					{
						get
						{
							if (location_info == null || location_info.loc_resource_name == "")
								return false;

							return true;
						}
					}
				}
			}
		}
	}
}


/*
					public bool FetchRelatedEntities(CEntityImpl entity, long child_type_id, string properties_to_fetch, bool include_derived_types)
					{
						if (entity == null || entity.Entity_Type == null)
							return false;

						if (child_type_id == -1) // Things: Get all Resource entities
							return false;

						// get the type and check if it is not assoc type
						CEntityTypeDef ct = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(child_type_id);
						if (ct.IsAssociationType)
							return false;

						// fetch children of the entity from default location
						ArrayList types = new ArrayList(); 

						// query for children in the grave base
						string sel = "entity_id, entity_type_id";
						string conds = "entity_owner_id = " + entity.ID; 
						if (child_type_id > 0 && child_type_id != 4042) // bypass collection entity, i.e fetch everything under the collection
							conds += " and entity_type_id = " + child_type_id; 

						CGraveEngine.TheEngine.TheLocation.SetInfo();
						CGraveEngine.TheEngine.TheLocation.loc_resource_name = "grave_entities";
						DataTable dt = CGraveEngine.TheEngine.TheLocation.Location.FetchTable(sel, conds);
						CGraveEngine.TheEngine.TheLocation.Reset();

						if (dt != null)
						{
							// --> iterate through children and 
							// ----> create CEntityRelations with CEntityRT with basic properties
							// ----> create an arraylist of entity_type_defs
							foreach (DataRow row in dt.Rows)
							{ 
								long id = Utils.ObjectToLong(row["entity_id"]);
								long tid = Utils.ObjectToLong(row["entity_type_id"]);

								// check if it already exists, if yes bypass
								CEntityImpl ent = entity.Relations.GetChildEntity(id);
								if (ent != null)
									continue;

								if (child_type_id == 4042)
								{
									CEntityTypeDef cdef = CGraveSystem.TheEngine.TheLoader.GetEntityTypeDef(tid);
									ent = CGraveEngine.TheEngine.TheLoader.LoadEntity(id, cdef);									
								}
								else
									ent = CGraveEngine.TheEngine.TheLoader.LoadEntity(id, ct);

								if (ent != null)
								{
									if (!entity.Entity_Type.IsDefinitionType && 
										(ent.Entity_Type != null && ent.Entity_Type.IsAssociationType))
										continue;

									ent.FillEntity(properties_to_fetch);
									entity.Relations.AddChildEntity(ent);
								}
							}							
						}
	
						if (include_derived_types)
						{
							CEntityTypeDef current_child_type = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(child_type_id);
							ArrayList grand_child_types = current_child_type.GetDerivedTypeDefs();

							foreach (CEntityTypeDef grand_child_type in grand_child_types)
								FetchRelatedEntities(entity, grand_child_type.id, properties_to_fetch, include_derived_types);
						}

						return true;
					}
*/
