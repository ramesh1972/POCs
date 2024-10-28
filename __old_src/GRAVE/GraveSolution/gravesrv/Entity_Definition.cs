using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server;  
using GRAVE.Server.Entity.Locator;
using GRAVE.Server.Data;

namespace GRAVE
{
	namespace Server
	{
		namespace Entity
		{
			namespace Definition
			{
				public class CEntityTypeDef : System.Collections.IEnumerator, System.Collections.IEnumerable 
				{
					public long id;
					public string id_name;
					public string name;
					public long base_type_id = -1;
					public string image_url;
					public string entity_view_code;
					public string entity_update_code;
					public string entity_new_code;
					public long type_owner_id;

					private ArrayList _prop_defs = null; // array list of CEntityPropertyDef Objects
					private ArrayList _assoc_defs = null;
					private ArrayList _child_types_defs = null;
					private ArrayList _derived_types_defs = null;

					private CEntityTypeDef _base_type_ref = null;
					private CEntityTypeDef _owner_type_ref = null;

					public CEntityTypeDef()
					{
						_prop_defs = new ArrayList(); 
						_assoc_defs = new ArrayList();
						_child_types_defs = new ArrayList();
						_derived_types_defs = new ArrayList();

						base_type_id = -1;
					}

					// =======================================================================================
					public CEntityTypeDef GetBaseTypeRef()
					{
						if (_base_type_ref != null)
							return _base_type_ref;
						
						return null;
					}

					public void SetBaseTypeRef()
					{
						if (base_type_id > 0)
							_base_type_ref = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(base_type_id);
					
						if (_base_type_ref != null && _base_type_ref.id != 4021)
						{
							_base_type_ref.AddDerivedTypeDef(this);
							_base_type_ref.SetBaseTypeRef();
						}
					}

					public CEntityTypeDef GetOwnerEntityType()
					{
						if (_owner_type_ref != null)
							return _owner_type_ref;
						
						return null;
					}

					public void SetOwnerEntityType()
					{
						if (type_owner_id < 0)
							return;

						_owner_type_ref = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(type_owner_id);
						
						if (_owner_type_ref != null)
						{
							_owner_type_ref.AddChildTypeDef(this);
							_owner_type_ref.SetOwnerEntityType();
						}
					}

					public ArrayList GetDerivedTypeDefs()
					{ 
						return _derived_types_defs;
					}

					public void AddDerivedTypeDef(CEntityTypeDef pdef)
					{
						if (_derived_types_defs == null)
							return;
						
						long pos = _derived_types_defs.IndexOf(pdef);
						if (pos != -1)
							_derived_types_defs.Remove(pdef);

						_derived_types_defs.Add(pdef);
					}

					// =======================================================================================
					public void AddPropertyDef(CEntityPropertyDef pdef)
					{
						if (_prop_defs == null)
							return;
						
						long pos = _prop_defs.IndexOf(pdef);
						if (pos != -1)
							_prop_defs.Remove(pdef);

						_prop_defs.Add(pdef);
					}

					public ArrayList GetEntityPropertyDefs()
					{
						return _prop_defs;
					}

					public void GetEntityAllPropertyDefs(ref ArrayList props)
					{
						if (_base_type_ref != null)
							_base_type_ref.GetEntityAllPropertyDefs(ref props);

						props.AddRange(_prop_defs);
					}

					public CEntityPropertyDef GetEntityPropertyDef(long prop_id)
					{
						if (prop_id < 0)
							return null;

						foreach (CEntityPropertyDef pdef in _prop_defs)
							if (pdef != null && pdef.property_id == prop_id)
								return pdef;

						if (_base_type_ref != null)
							return _base_type_ref.GetEntityPropertyDef(prop_id);

						return null;
					}

					public CEntityPropertyDef GetEntityPropertyDefFromEntityPropID(long prop_id, bool check_base)
					{
						if (prop_id < 0)
							return null;

						foreach (CEntityPropertyDef pdef in _prop_defs)
							if (pdef != null && pdef.entity_prop_def_id == prop_id)
								return pdef;

						if (check_base && _base_type_ref != null)
							return _base_type_ref.GetEntityPropertyDefFromEntityPropID(prop_id, check_base);

						return null;
					}

					public CEntityPropertyDef GetEntityPropertyDef(string prop_name)
					{
						if (prop_name == "")
							return null;

						foreach (CEntityPropertyDef ps_prop in _prop_defs)
						{
							if (ps_prop != null &&
								ps_prop.property_def_ref != null &&
								ps_prop.property_def_ref.id_name == prop_name)
								return ps_prop;
						}

						if (_base_type_ref != null)
							return _base_type_ref.GetEntityPropertyDef(prop_name);

						return null;
					}

					public CEntityPropertyDef GetEntityPropertyDefFromLocation(string prop_loc_name)
					{
						if (prop_loc_name == "")
							return null;

						foreach (CEntityPropertyDef ps_prop in _prop_defs)
						{
							if (ps_prop != null &&
								ps_prop.property_def_ref != null &&
								ps_prop.property_column_name == prop_loc_name)
								return ps_prop;
						}

						if (_base_type_ref != null)
							return _base_type_ref.GetEntityPropertyDefFromLocation(prop_loc_name);

						return null;
					}

					// ======================================================================================= 
					public void AddChildTypeDef(CEntityTypeDef pdef)
					{
						if (_child_types_defs == null)
							return;
						
						long pos = _child_types_defs.IndexOf(pdef);
						if (pos != -1)
							_child_types_defs.Remove(pdef);

						_child_types_defs.Add(pdef);
					}

					private bool IsTypeDefInList(ArrayList _defs, long eid)
					{
						if (_defs == null)
							return false;

						foreach (CEntityTypeDef def in _defs)
							if (def.id == eid)
								return true;

						return false;
					}

					public ArrayList GetThisChildTypeDefs()
					{ 
						return _child_types_defs;
					}

					public ArrayList GetChildTypeDefs()
					{ 
						ArrayList ret = null;
						GetChildTypeDefs(ref ret);
						return ret;
					}

					public void GetChildTypeDefs(ref ArrayList child_defs)
					{ 
						if (child_defs == null)
							child_defs = new ArrayList();

						// create an array list and load the base types in well
						foreach (CEntityTypeDef td in _child_types_defs)
						{
							if (!child_defs.Contains(td))
								child_defs.Add(td);
						}

						if (_base_type_ref != null)
							_base_type_ref.GetChildTypeDefs(ref child_defs);
						
						return;
					}

					// =======================================================================================
					public void AddAssociationDef(CEntityAssociationDef pdef)
					{
						if (_assoc_defs == null)
							return;
						
						long pos = _assoc_defs.IndexOf(pdef);
						if (pos != -1)
							_assoc_defs.Remove(pdef);

						_assoc_defs.Add(pdef);
					}


					public CEntityAssociationDef GetEntityAssociationDef(long association_type_id)
					{
						if (_assoc_defs.Count == 0)
							return null;

						if (association_type_id == -1)
							return (CEntityAssociationDef) _assoc_defs[0];

						foreach (CEntityAssociationDef adef in _assoc_defs)
						{
							if (adef != null &&
								adef.association_type_id == association_type_id)
								return adef;
						}

						if (_base_type_ref != null)
							return _base_type_ref.GetEntityAssociationDef(association_type_id);

						return null;
					}

					public CEntityAssociationDef GetEntityAssocDefForAssociate(long associate_type_id)
					{
						if (_assoc_defs.Count == 0)
							return null;

						if (associate_type_id == -1)
							return (CEntityAssociationDef) _assoc_defs[0];

						foreach (CEntityAssociationDef assocdef in _assoc_defs)
						{
							if (assocdef != null &&
								assocdef.associate_entity_type_id == associate_type_id)
								return assocdef;
						}

						if (_base_type_ref != null)
							return _base_type_ref.GetEntityAssocDefForAssociate(associate_type_id);

						return null;
					}

					public CEntityAssociationDef GetEntityAssociationDef(long associator_type_id, long associate_type_id)
					{
						foreach (CEntityAssociationDef ead in _assoc_defs)
						{
							if (ead.associating_entity_type_id == associator_type_id &&
								ead.associate_entity_type_id == associate_type_id)
								return ead;
						}
				
						if (_base_type_ref != null)
							return _base_type_ref.GetEntityAssociationDef(associator_type_id, associate_type_id);

						return null;
					}

					public void GetAssociationDefs(ref ArrayList assoc_defs)
					{
						if (assoc_defs == null)
							assoc_defs = new ArrayList();

						// create an array list and load the base types in well
						foreach (CEntityAssociationDef ad in _assoc_defs)
							if (!assoc_defs.Contains(ad))
								assoc_defs.Add(ad);

						if (_base_type_ref != null)
							_base_type_ref.GetAssociationDefs(ref assoc_defs);

						return ;
					}

					// =======================================================================================
					public bool IsDefinitionType
					{
						get
						{
							if (id == 4067)
								return true;

							if (_base_type_ref != null)
								return _base_type_ref.IsDefinitionType;
						
							return false;
						}
					}

					public bool IsChildType(long child_type_id)
					{
						bool yes = IsTypeDefInList(_child_types_defs, child_type_id);
						if (yes)
							return yes;

						if (_base_type_ref != null)
							return _base_type_ref.IsChildType(child_type_id);
						
						return false;
					}

					public bool IsDerivedType(long derived_type_id)
					{
						return IsTypeDefInList(_derived_types_defs, derived_type_id);
					}

					public bool IsSystemType
					{
						get
						{
							if (id == 4028)
								return true;

							if (_base_type_ref != null)
								return _base_type_ref.IsSystemType;

							return false;
						}
					}

					public bool IsAssociationType
					{
						get
						{
							if (id == 4052)// 4052 is GRAVE_Entity_Association entity_type_id
								return true;

							if (_base_type_ref != null)
								return _base_type_ref.IsAssociationType;

							return false;
						}
					}

					public bool IsContainerType
					{
						get
						{
							if (id == 4042)
								return true;

							if (_base_type_ref != null)
								return _base_type_ref.IsContainerType;
						
							return false;
						}
					}

					public bool IsSpecificationType
					{
						get
						{
							if (id == 4074) // 4074 is GRAVE_Entity_Association entity_type_id
								return true;

							if (_base_type_ref != null)
								return _base_type_ref.IsSpecificationType;
							
							return false;
						}
					}

					public bool IsResourceType
					{
						get
						{
							if (id == 4094)
								return true;

							if (_base_type_ref != null)
								return _base_type_ref.IsResourceType;
						
							return false;
						}
					}

					// =======================================================================================
					// enumerate through properties
					private long _current_pdef = -1;
					private CEntityPropertyDef _current_pdef_ref = null;
					public void Reset()
					{
						_current_pdef_ref = null;
						_current_pdef = -1;
					}

					public object Current
					{
						get { return _current_pdef_ref; }
					}

					public bool MoveNext()
					{
						if (_prop_defs != null &&
							_prop_defs.Count > 0 &&
							_current_pdef < _prop_defs.Count-1)
						{
							_current_pdef_ref = (CEntityPropertyDef) _prop_defs[(int) ++_current_pdef];
							return true;
						}
						else
						{
							_current_pdef_ref = null;
							return false;
						}
					}

					public IEnumerator GetEnumerator()
					{
						if (_prop_defs != null)
							return _prop_defs.GetEnumerator();
						else
							return null;
					}
				}

				// =======================================================================================
				public class CPropertyDataTypeDef
				{
					public long id;
					public string id_name;
					public string name;
					public long parent_id;

					public CPropertyDataTypeDef parent_def_ref = null;
					
					public CPropertyDataTypeDef()
					{
						id = -1;
						id_name = "";
						name = "";
						parent_id = -1;
					}

					public static CPropertyDataTypeDef GetPropertyTypeDef(long id)
					{
						return (CPropertyDataTypeDef) CGraveEngine.TheEngine.TheLoader.GetPropertyDataTypeDef(id);
					}
				}

				// =======================================================================================
				public class CPropertyDef
				{
					public long id;
					public string id_name;
					public CPropertyDataTypeDef type;
					public string name;
			
					public CPropertyDef()
					{
					}

					public static CPropertyDef GetPropertyDef(long id)
					{
						return (CPropertyDef) CGraveEngine.TheEngine.TheLoader.GetPropertyDef(id);
					}

					public static CPropertyDef GetPropertyDef(string prop_name)
					{
						if (prop_name == null || prop_name.Trim() == "")
							return null;

						prop_name = prop_name.Trim();

						Hashtable props = CGraveEngine.TheEngine.TheLoader.GetPropertyDefs();
						foreach (CPropertyDef pd in props.Values)
						{
							if (pd != null &&
								prop_name == pd.id_name.Trim())
								return pd;
						}

						return null;
					}

					// =======================================================================================
					public static bool IsBaseProperty(string prop_name)
					{
						if (prop_name == null ||
							prop_name == "")
							return false;

						prop_name = prop_name.Trim();
						if (prop_name == "entity_id" ||
							prop_name == "entity_type_id" ||
							prop_name == "entity_id_name" ||
							prop_name == "entity_owner_id" ||
							prop_name == "entity_name")
							return true;
						else
							return false;
					}
				}

				// =======================================================================================
				public class CEntityPropertyDef
				{
					public CEntityPropertyDef()
					{
					}

					public long entity_prop_def_id;
					public long entity_type_id;
					public long property_id;
					public string property_column_name;
					public long property_loc_info_id;

					public string property_view_code;
					public string property_edit_code;
					public string property_insert_code;
					public bool is_visible;
					public string grid_col_type;
					public long grid_col_size;
					public string grid_sort_expression;
					public string grid_group_expression;

					// refs
					public CEntityTypeDef entity_type_ref; 
					public CPropertyDef property_def_ref; 

					public bool DoesPropertyBelongToLocation(CEntityLocationInfo linfo)
					{
						if (linfo != null &&
							linfo.loc_info_id == property_loc_info_id)
							return true;

						return false;
					}				
				}

				// =======================================================================================
				public class CEntityAssociationDef 
				{
					public CEntityAssociationDef()
					{
					}

					public long association_id;
					public long association_type_id;
					public long associating_entity_type_id;
					public long associate_entity_type_id;

					public string associate_view_code;
					public string associate_edit_code;
					public string associate_insert_code;
				}
			}
		}
	}
}