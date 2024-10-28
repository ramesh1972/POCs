using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server;  
using GRAVE.Server.Entity.Locator; 
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Data;

namespace GRAVE
{
	namespace Server
	{
		namespace Entity
		{
			namespace Implementation
			{
				public class CEntityDecl : System.Collections.IEnumerable
				{
					protected long _entity_id = -1;
					protected CEntityTypeDef _type = null;

					protected CEntityProperties _properties = null;
					protected CEntityRelations _rels = null;
					protected CEntityAssociations _assocs = null;

					protected CEntityImpl _owner_entity_ref = null; // Things: need to set this, implement SetEntityOwner.
				
					public CEntityDecl()
					{
						_properties = new CEntityProperties((CEntityImpl) this);
						_rels = new CEntityRelations((CEntityImpl) this);
						_assocs = new CEntityAssociations((CEntityImpl) this);
					}

					public CEntityDecl(long entity_id)
					{
						_properties = new CEntityProperties((CEntityImpl) this);
						_rels = new CEntityRelations((CEntityImpl) this);
						_assocs = new CEntityAssociations((CEntityImpl) this);
					}

					public CEntityDecl(long entity_id, CEntityDecl owner)
					{
						_properties = new CEntityProperties( (CEntityImpl) this);
						_rels = new CEntityRelations((CEntityImpl) this);
						_assocs = new CEntityAssociations((CEntityImpl) this);

						SetEntityOwnerRef((CEntityImpl) owner);
					}

					// =======================================================================================
					public CEntityImpl Owner
					{
						get {return _owner_entity_ref;}
					}

					public CEntityTypeDef Entity_Type
					{
						get {return _type;}
					}

					public long ID
					{
						get {return _entity_id;}
						set {_entity_id = value; SetPropertyValue("entity_id", value);}
					}

					public string ID_Name
					{
						get {return Utils.ObjectToString(GetPropertyValue("entity_id_name"));}
						set {SetPropertyValue("entity_id_name", value);}
					}

					public string  Name
					{
						get {return Utils.ObjectToString(GetPropertyValue("entity_name"));}
						set {SetPropertyValue("entity_name", value);}
					}

					public long OwnerID
					{
						get {return Utils.ObjectToLong(GetPropertyValue("entity_owner_id"));}
						set {SetPropertyValue("entity_owner_id", value);}
					}

					public CEntityProperties Properties
					{
						get {return _properties;}
					}

					public CEntityRelations Relations
					{
						get {return _rels;}
					}

					public CEntityAssociations Associations
					{
						get {return _assocs;}
					}

					// =======================================================================================
					protected void SetEntityType()
					{
						if (Entity_Type == null)
						{
							CEntityImpl abs_ent = new CEntityImpl(ID);
							abs_ent.SetEntityType(4021);
							abs_ent.FillEntity("entity_type_id");
							
							long type_id = Utils.ObjectToLong(abs_ent.GetPropertyValue("entity_type_id"));
							SetEntityType(type_id);
						}
					}

					public void SetEntityType(long type_id)
					{
						_type = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(type_id);
						SetPropertyValue("entity_type_id", type_id);
					}

					public void SetEntityOwnerRef(CEntityImpl impl)
					{
						_owner_entity_ref = impl;
						if (_owner_entity_ref != null)
							_owner_entity_ref.Relations.AddChildEntity((CEntityImpl) this);
					}

					// =======================================================================================					
					public void SetPropertyValue(string name, object prop_value)
					{
						Properties.SetValue(name, prop_value);
					}

					public void SetPropertyValueFromLocation(string loc_prop_name, object prop_value)
					{
						Properties.SetValueFromLocation(loc_prop_name, prop_value);
					}

					public object GetPropertyValue(string name)
					{
						return Properties.GetValue(name);
					}

					// =======================================================================================
					public void GenIDName()
					{
						string new_name = Name;
						new_name.Replace(" ","_");
						new_name.Replace("\"","");
						new_name.Replace(",","_");
						new_name.Replace("\'","");

						ID_Name = new_name;
					}

					// =======================================================================================
					public IEnumerator GetEnumerator()
					{
						if (_rels != null)
							return _rels.GetEnumerator();
						else
							return null;
					}				
				}

				// =======================================================================================
				public class CEntityImpl : CEntityDecl
				{
					protected CEntityLocator _entity_locator = null;

					public CEntityImpl()
					{
					}

					public CEntityImpl(long entity_id) : base(entity_id)
					{
						ID = entity_id;
					}

					public CEntityImpl(long entity_id, CEntityDecl owner) : base(entity_id, owner)
					{
						ID = entity_id;
					}

					// =======================================================================================
					// Locate and Fill Functions
					public virtual void LocateEntity()
					{
						if (this._entity_locator == null)
						{// use default entity db info from Globals
							_entity_locator = new CEntityLocator(); 
						}

						_entity_locator.LocateEntity(this);
					}

					public virtual void FillEntity(string properties_to_fill)
					{
						// set the entity type
						SetEntityType();

						// locate the entity
						LocateEntity();

						// fetch
						_entity_locator.FetchEntity(this, properties_to_fill);
					}

					// ====================================================================================
					public virtual void FillEntityRelations(string properties_to_fill)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						// fetch
						ArrayList cdefs = null;
						Entity_Type.GetChildTypeDefs(ref cdefs);

						foreach (CEntityTypeDef cdef in cdefs)
							_entity_locator.FetchRelatedEntities(this, cdef.id, properties_to_fill);
					}				

					public virtual void FillEntityRelations(long child_type_id, string properties_to_fill)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						// fetch
						_entity_locator.FetchRelatedEntities(this, child_type_id, properties_to_fill);
					}				

					public virtual void FillEntityCollections()
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						CEntityTypeDef colt = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(4042);
						_entity_locator.FetchRelatedEntities(this, 4042, "*");

						// check derived types
						ArrayList cdefs = colt.GetDerivedTypeDefs();

						foreach (CEntityTypeDef cdef in cdefs)
							_entity_locator.FetchRelatedEntities(this, cdef.id, "*");
					}				

					public virtual void FillCollectionEntity(string properties_to_fill) // assume that there is only one child type per collection entity (as parent)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						if (Entity_Type.IsContainerType)
							_entity_locator.FetchRelatedEntities(this, -1, properties_to_fill);
					}				

					public virtual void FillDefinitionEntityRelations(string properties_to_fill)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						if (Entity_Type.IsDefinitionType || Entity_Type.IsSpecificationType)
							_entity_locator.FetchRelatedEntities(this, -1, properties_to_fill);
					}

					public virtual void FillEntityResourceRelations(string properties_to_fill)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						ArrayList cdefs = null;
						Entity_Type.GetChildTypeDefs(ref cdefs);

						foreach (CEntityTypeDef cdef in cdefs)
							if (cdef.IsResourceType)
								_entity_locator.FetchRelatedEntities(this, cdef.id, properties_to_fill);
					}				

					public virtual void FillSystemEntityRelations(string properties_to_fill)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						ArrayList cdefs = null;
						Entity_Type.GetChildTypeDefs(ref cdefs);

						foreach (CEntityTypeDef cdef in cdefs)
							if (cdef.IsSystemType)
								_entity_locator.FetchRelatedEntities(this, cdef.id, properties_to_fill);
					}				

					public bool HasRelations
					{
						get
						{
							if (Entity_Type != null)
							{
								if (Entity_Type.IsDefinitionType)
								{
									FillDefinitionEntityRelations("entity_id,entity_type_id");
									if (Relations.Count > 0)
										return true;
								}
								else if (Entity_Type.id == 4042)
								{
									FillCollectionEntity("entity_id, entity_type_id");
									if (Relations.Count > 0)
										return true;
								}
								else
								{
									ArrayList child_defs = Entity_Type.GetChildTypeDefs();
									foreach (CEntityTypeDef cdef in child_defs)
									{
										FillEntityRelations(cdef.id, "entity_id,entity_type_id");
										if (Relations.Count > 0)
											return true;
									}
								}
							}
							else
							{
								FillEntityRelations(-1, "entity_id, entity_type_id");
								if (Relations.Count > 0)
									return true;
							}

							// check if there are collections
							FillEntityCollections();
		
							if (Relations.Count > 0)
								return true;

							return false;
						}
					}

					// ====================================================================================
					public virtual void FillEntityAssociations(long assoc_type_id, string props)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						// set the entity type
						SetEntityType();

						// fetch
						CEntityImpl thiso = this;
						_entity_locator.FetchEntityAssociations(ref thiso, assoc_type_id, props);
					}				

					// ====================================================================================
					public virtual void UnFillEntity()
					{
						if (_entity_locator == null)
							LocateEntity();
	
						_entity_locator.UpdateEntity(this);
					}

					public virtual void NewFillEntity()
					{
						ArrayList props = Properties.GetPropertyValues();
						_NewFillEntity(props);
					}
					
					public void _NewFillEntity(ArrayList props)
					{
						if (_entity_locator == null)
							_entity_locator = new CEntityLocator();

						_entity_locator.InsertEntity(this, props);
					}

					// =======================================================================================
					// GUI FUNCTIONS
					public string GetGUICode(string gui_code)
					{
						// from the entity_type object get the code template
						// parse the code template with "this" values.
						if (this.Entity_Type == null || gui_code == "" || gui_code == null)
							return gui_code;

						int index_of_at =gui_code.IndexOf("@(", 0);

						CEntityImpl this_only = this;

						CGRAVECodeParser parser = new CGRAVECodeParser();
						string ret_html = parser.ParseAndProcessCode(gui_code, ref index_of_at, ref this_only);
						return ret_html;
					}

					// =======================================================================================
					public bool HasAssociationDefs
					{
						get 
						{
							ArrayList defs = null;
							Entity_Type.GetAssociationDefs(ref defs);

							if (defs != null && defs.Count > 0)
								return true;

							return false;
						}
					}

					// =================================================================================
					public string GetEntityHomeCode()
					{
						// from the entity_type object get the code template
						// parse the code template with "this" values.
						string tmpl = Utils.ObjectToString(Properties.GetValue("home_page_code"));
						int index_of_at = tmpl.IndexOf("@(", 0);

						CEntityImpl this_only = this;
						CGRAVECodeParser parser = new CGRAVECodeParser();
						string ret_html = parser.ParseAndProcessCode(tmpl, ref index_of_at, ref this_only);
						return ret_html;
					}

					public string GetViewCode()
					{
						// from the entity_type object get the code template
						// parse the code template with "this" values.
						if (this.Entity_Type == null)
							return "";

						string view_tmpl = this.Entity_Type.entity_view_code;
						int index_of_at =view_tmpl.IndexOf("@(", 0);

						CEntityImpl this_only = this;
						CGRAVECodeParser parser = new CGRAVECodeParser();
						string ret_html = parser.ParseAndProcessCode(view_tmpl, ref index_of_at, ref this_only);
						return ret_html;
					}

					public string GetUpdateCode()
					{
						// from the entity_type object get the code template
						// parse the code template with "this" values.
						if (this.Entity_Type == null)
							return "";

						string view_tmpl = this.Entity_Type.entity_update_code;
						int index_of_at =view_tmpl.IndexOf("@(", 0);

						CEntityImpl this_only = this;

						CGRAVECodeParser parser = new CGRAVECodeParser();
						string ret_html = parser.ParseAndProcessCode(view_tmpl, ref index_of_at, ref this_only);
						return ret_html;
					}

					public string GetInsertCode(long type)
					{
						// from the entity_type object get the code template
						CEntityTypeDef new_type = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(type);
						if (new_type == null)
							return "";
						
						// determine the type of new entity based on entity_owner_type_id
						string new_tmpl = new_type.entity_new_code;
						int index_of_at =new_tmpl.IndexOf("@(", 0);

						CEntityImpl this_only = this;
						
						// parse the code template with "this" values.
						CGRAVECodeParser parser = new CGRAVECodeParser();
						string ret_html = parser.ParseAndProcessCode(new_tmpl, ref index_of_at, ref this_only);
						return ret_html;
					}
				}

				// =============================================================================================
				public class CEntityAssociationImpl : CEntityImpl
				{
					public CEntityAssociationDef assoc_def_ref = null;
					public long associator_entity_id = -1;
					public long associate_entity_id = -1;

					public CEntityImpl associator = null;
					public CEntityImpl associate = null;

					public CEntityAssociationImpl(long ent_id, CEntityDecl owner) : base(ent_id, owner)
					{
					}

					public void SetUpAssociations(string associator_props, string associate_props)
					{						
						// create the associate entity
						CEntityTypeDef associate_type = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(assoc_def_ref.associate_entity_type_id);
						associate = (CEntityImpl) CGraveEngine.TheEngine.TheLoader.LoadEntity(associate_entity_id, associate_type, associate_props);
							
						// create the associating entity 
						CEntityTypeDef associator_type = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(assoc_def_ref.associating_entity_type_id);
						associate = (CEntityImpl) CGraveEngine.TheEngine.TheLoader.LoadEntity(associator_entity_id, associator_type, associator_props);
					}
				}

				// =============================================================================================
				public class CEntityPropertyValue
				{
					public object pvalue;
					public CEntityPropertyDef pdefref;

					public CEntityPropertyValue()
					{
					}
				}

				// =============================================================================================
				public class CEntityProperties : System.Collections.IEnumerable
				{
					// Things: Convert to hash table
					// Things: Should use the _base_type_ref
					private ArrayList _property_values;
					private CEntityImpl _ent_ref = null;

					public CEntityProperties(CEntityImpl ent)
					{
						_property_values = new ArrayList();
						_ent_ref = ent;
					}

					public string GetPropertyType(string pname)
					{
						CEntityPropertyDef prop_def = _ent_ref.Entity_Type.GetEntityPropertyDef(pname);
						if (prop_def != null &&
							prop_def.property_def_ref == null)
							return prop_def.property_def_ref.type.name;

						return "";
					}

					public void SetValue(long prop_id, object prop_value)
					{
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null &&
								epv.pdefref != null &&
								prop_id == epv.pdefref.property_id)  
							{
								epv.pvalue = prop_value;
								return;
							}
						}

						// add the property def to the array
						if (_ent_ref != null && _ent_ref.Entity_Type != null)
						{
							CEntityPropertyDef prop_def = _ent_ref.Entity_Type.GetEntityPropertyDef(prop_id);
							if (prop_def == null)
								return;

							CEntityPropertyValue val = new CEntityPropertyValue();						
							val.pdefref = prop_def;
							val.pvalue = prop_value;

							_property_values.Add(val);
						}
					}

					public void SetValue(string prop_name, object prop_value)
					{
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null &&
								epv.pdefref != null &&
								epv.pdefref.property_def_ref != null &&
								prop_name == epv.pdefref.property_def_ref.id_name)  
							{
								epv.pvalue = prop_value;
								return;
							}
						}

						// add the property def to the array
						if (_ent_ref != null && _ent_ref.Entity_Type != null)
						{
							CEntityPropertyDef prop_def = _ent_ref.Entity_Type.GetEntityPropertyDef(prop_name);
							if (prop_def == null) 
								return;

							CEntityPropertyValue val = new CEntityPropertyValue();						
							val.pdefref = prop_def;
							val.pvalue = prop_value;

							_property_values.Add(val);
						}
					}

					public void SetValueFromLocation(string prop_loc_name, object prop_value)
					{
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null &&
								epv.pdefref != null &&
								epv.pdefref.property_def_ref != null &&
								prop_loc_name == epv.pdefref.property_column_name)  
							{
								epv.pvalue = prop_value;
								return;
							}
						}

						// add the property def to the array
						if (_ent_ref != null && _ent_ref.Entity_Type != null)
						{
							CEntityPropertyDef prop_def = _ent_ref.Entity_Type.GetEntityPropertyDefFromLocation(prop_loc_name);
							if (prop_def == null) 
								return;

							CEntityPropertyValue val = new CEntityPropertyValue();						
							val.pdefref = prop_def;
							val.pvalue = prop_value;

							_property_values.Add(val);
						}
					}

					public object GetValue(long prop_id)
					{
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null &&
								epv.pdefref != null &&
								prop_id == epv.pdefref.entity_prop_def_id)  
								return epv.pvalue;
						}

						return null;
					}

					public object GetValue(string prop_name)
					{
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null &&
								epv.pdefref != null &&
								epv.pdefref.property_def_ref != null &&
								prop_name == epv.pdefref.property_def_ref.id_name)  
								return epv.pvalue;
						}

						return null;
					}

					public ArrayList GetPropertyValues()
					{
						ArrayList values = new ArrayList();
						GetPropertyValues(ref values);

						return values;
					}

					public void GetPropertyValues(ref ArrayList values)
					{
						foreach (CEntityPropertyValue epv in _property_values)
							values.Add(epv); 
					}

					public object[] GetValues()
					{
						ArrayList values = new ArrayList();
						GetValues(ref values);

						return values.ToArray();
					}

					public void GetValues(ref ArrayList values)
					{
						foreach (CEntityPropertyValue epv in _property_values)
							values.Add(epv.pvalue); 
					}

					public object GetViewCodeValue(string prop_name)
					{
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null)
							{
								if (epv.pdefref != null && epv.pdefref.property_def_ref.id_name == prop_name )
								{
									if (epv.pdefref.property_view_code != null && epv.pdefref.property_view_code != "") 
									{
										string val = _ent_ref.GetGUICode(epv.pdefref.property_view_code);
										return val;
									}
									else
										return epv.pvalue; 
								}
							}
						}
						
						return null;
					}

					public object[] GetViewCodeValues()
					{
						ArrayList values = new ArrayList();
						foreach (CEntityPropertyValue epv in _property_values)
						{
							if (epv != null)
							{
								if (epv.pdefref != null && epv.pdefref.is_visible)
								{
									if (epv.pdefref.property_view_code != "") 
									{
										string val = _ent_ref.GetGUICode(epv.pdefref.property_view_code);
										values.Add(val); 
									}
									else
										values.Add(epv.pvalue); 
								}
							}
						}

						return values.ToArray();
					}

					public IEnumerator GetEnumerator()
					{
						ArrayList values = new ArrayList(GetValues());
						return values.GetEnumerator();
					}
				}

				// =============================================================================================
				public class CEntityRelations : System.Collections.IEnumerable  
				{
					private Hashtable _entities = null; // array of CEntityDecl
					private Hashtable _entities_names = null; // array of CEntityDecl
					private CEntityImpl _ent_ref = null;
					
					public CEntityRelations(CEntityImpl ent_ref)
					{
						_entities = new Hashtable();
						_entities_names = new Hashtable();
						_ent_ref = ent_ref;
					}

					public CEntityDecl GetChildEntity(long entity_id)
					{
						CEntityDecl child = (CEntityDecl) _entities[entity_id];
						if (child != null)
							return child;

						return null;
					}

					public CEntityDecl GetChildEntity(string e_id_name)
					{
						CEntityDecl child = (CEntityDecl) _entities_names[e_id_name];
						if (child != null)
							return child;

						return null;
					}

					public CEntityDecl GetFirstChild()
					{
						if (_entities != null && _entities.Count > 0)
							return (CEntityDecl) _entities[0];

						return null;
					}

					public ArrayList GetChildren(long child_type_id)
					{
						ArrayList children = new ArrayList();
						GetChildren(child_type_id, ref children);
						
						return children;
					}

					public void GetChildren(long child_type_id, ref ArrayList children)
					{
						foreach (CEntityImpl ent in _entities.Values)
							if (child_type_id == -1 || 
							   (ent.Entity_Type != null && ent.Entity_Type.id == child_type_id))
								children.Add(ent);
					}

					public bool IsEmpty()
					{
						if (_entities != null && _entities.Count > 0)
							return false;

						return true;
					}

					public long Count 
					{
						get 
						{
							ArrayList children = GetChildren(-1);
							return children.Count;
						}
					}
							
					public void AddChildEntity(CEntityImpl ent)
					{
						if (ent == null)
							return;

						RemoveChildEntity(ent);

						_entities.Add(ent.ID, ent);
						_entities_names.Add(ent.ID_Name, ent);
					}

					public void RemoveChildEntity(CEntityImpl ent)
					{
						if (ent != null)
						{
							_entities.Remove(ent.ID);
							_entities_names.Remove(ent.ID_Name);
						}
					}

					public IEnumerator GetEnumerator()
					{
						ArrayList children = GetChildren(-1);
						return children.GetEnumerator();
					}
				}

				// =============================================================================================
				public class CEntityAssociations 
				{
					private ArrayList _assocs = null; // array of CEntityAssociationImpl
					private CEntityDecl _ent_ref = null;
					
					public CEntityAssociations(CEntityDecl ent_ref)
					{
						_assocs = new ArrayList();
						_ent_ref = ent_ref;
					}

					public CEntityAssociationImpl GetEntityAssociation(long associate_id)
					{
						if (_assocs.Count == 0)
							return null;
						
						if (associate_id == -1)
							return (CEntityAssociationImpl) _assocs[0];

						foreach (CEntityAssociationImpl e in _assocs)
							if (e != null && e.ID == associate_id)
								return e;

						return null;
					}

					public CEntityAssociationImpl GetEntityAssociation(string associate_name)
					{
						if (_assocs.Count == 0)
							return null;
						
						if (associate_name == "")
							return (CEntityAssociationImpl) _assocs[0];

						foreach (CEntityAssociationImpl e in _assocs)
							if (e != null && e.Name == associate_name)
								return e;

						return null;
					}

					public CEntityDecl GetEntityAssociate(long associate_id)
					{
						CEntityAssociationImpl e = GetEntityAssociation(associate_id);
						if (e != null)
							return e.associate;

						return null;
					}

					public CEntityDecl GetEntityAssociator(string associate_name)
					{
						CEntityAssociationImpl e = GetEntityAssociation(associate_name);
						if (e != null)
							return e.associator;

						return null;
					}

					public ArrayList GetEntityAssociations(long EntityAssoc_type_id)
					{
						if (_assocs.Count == 0)
							return null;
						
						ArrayList assocs = new ArrayList(); 

						if (EntityAssoc_type_id == -1)
						{
							assocs.Add(_assocs[0]);
							return assocs;
						}

						// get the association id 
						foreach (CEntityAssociationImpl e in _assocs)
						{
							if (e != null && e.Entity_Type != null)
							{
								if (e.assoc_def_ref.associate_entity_type_id == EntityAssoc_type_id)
									assocs.Add(e);
							}
						}
	
						return assocs;
					}

					public bool IsEmpty()
					{
						if (_assocs != null && _assocs.Count > 0)
							return false;

						return true;
					}

					public long Count 
					{
						get 
						{
							if (_assocs != null)
								return _assocs.Count;
							else
								return -1;
						}
					}
							
					public void AddEntityAssociation(CEntityAssociationImpl ent)
					{
						if (ent == null)
							return;

						CEntityAssociationImpl e = GetEntityAssociation(ent.ID);
						if (e != null)
							_assocs.Remove(e);

						_assocs.Add(ent);
					}

					public void RemoveEntityAssociation(CEntityAssociationImpl ent)
					{
						if (ent != null)
							_assocs.Remove(ent);
					}

					public IEnumerator GetEnumerator()
					{
						if (_assocs != null)
							return _assocs.GetEnumerator();
						else
							return null;
					}
				}
			}
		}
	}
}