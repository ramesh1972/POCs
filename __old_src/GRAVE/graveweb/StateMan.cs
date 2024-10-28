using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Web;
using System.Web.SessionState;

namespace UCMS
{
	namespace Client
	{
		// Manage state of the page for async requests, post backs, session.
		// act as a cache of entities (for a page request)
		// act as a cache for data sources (for a page request)
		// dictionary of ViewState variables as well..
		// client side - cache for sizes/scrollpos etc...for all panes...across ajax calls.
		//			   - maintaining sliding panes (re-sliding) 
		//			   - maintaing pinned panes 
		//			   - maintaining grids state (grouping, sorting paging)
		//			   - maintaining tree state

		// The CStateMan class should be a singleton class and created on Page_Load.
		// The ref to Page object has to be passed in.
		// Then event handlers from the Page object can set/get objects...
		// ...from the cache based on the cache type..

		// The InitCache function is automatically called on the constructor which
		// creates a dictionary of possible cache objects. 
		// And only entries in the dictionary will be served, which means the entry has to be made at compile time.
		// *** this design is important from async perspective where the state of the page should not be "corrupt",
		// meaning all the controls and the values should be re-produced exactly in the same manner during postbacks, apart from
		// the controls that can be updated via async calls. So it is not advicable to add/remove state params at will.
		public class CStateMan
		{
			private static CStateMan _self = null;
			private System.Web.UI.Page _current_page_ref = null;
			private Hashtable _cache = null;

			private CStateMan(ref System.Web.UI.Page page_ref)
			{
				_current_page_ref = page_ref;

				// create the hash table, load the definitions
				_cache = new Hashtable();
				InitializeDictionary();
			}

			public static CStateMan CreateStateManager(ref System.Web.UI.Page page_ref)
			{
				if (_self == null)
					_self = new CStateMan(ref page_ref);

				return _self;
			}

			private void InitializeDictionary()
			{
				AddNewEntry(Cache_Type.CT_ViewState, Cache_Object_Type.COT_Object, "SelectedEntityID");
				AddNewEntry(Cache_Type.CT_ViewState, Cache_Object_Type.COT_Object, "SelectedEntityTab");
				AddNewEntry(Cache_Type.CT_ViewState, Cache_Object_Type.COT_Object, "SelectedEntityAssocTab");
			}

			public void AddNewEntry(Cache_Type ct, Cache_Object_Type cot, string key)
			{
				AddNewEntry(ct, cot, key, null);
			}

			public void AddNewEntry(Cache_Type ct, Cache_Object_Type cot, string key, object val)
			{
				string key1 = ct.ToString() + "_" + cot.ToString() + "_" + key;

				if (ct == Cache_Type.CT_Session)
					_current_page_ref.Session[key1] = val;
				else if (ct == Cache_Type.CT_ViewState)
				{
				//		_current_page_ref.ViewState[key1] = val;
				}
				else if (ct == Cache_Type.CT_RequestScope)
					_cache.Add(key1, val);
			}

			public object GetEntryValue(Cache_Type ct, Cache_Object_Type cot, string key)
			{
				string key1 = ct.ToString() + "_" + cot.ToString() + "_" + key;

				if (ct == Cache_Type.CT_Session)
					return _current_page_ref.Session[key1];
				else if (ct == Cache_Type.CT_ViewState)
				{
					//return _current_page_ref.ViewState[key1];
				}
				else if (ct == Cache_Type.CT_RequestScope)
				{
					IDictionaryEnumerator it = _cache.GetEnumerator();
					it.Reset();
					while (it.Current != null)
					{
						if (it.Key.ToString() == key1)
							break;
					}

					return it.Current;
				}

				return null;
			}

			public void SetEntryValue(Cache_Type ct, Cache_Object_Type cot, string key, string val)
			{
				string key1 = ct.ToString() + "_" + cot.ToString() + "_" + key;

				if (ct == Cache_Type.CT_Session)
					_current_page_ref.Session[key1] = val;
				else if (ct == Cache_Type.CT_ViewState)
				{
					//_current_page_ref.ViewState[key1] = val;
				}
				else if (ct == Cache_Type.CT_RequestScope)
				{
					IDictionaryEnumerator it = _cache.GetEnumerator();
					it.Reset();
					while (it.Current != null)
					{
						if (it.Key.ToString() == key1)
							break;
					}

					//it.Current = val;
				}
			}
				
			public enum Cache_Type
			{
				CT_Session,
				CT_ViewState,
				CT_RequestScope
			};

			public enum Cache_Object_Type
			{
				COT_Object,
				COT_Entity,
				COT_Table,
				COT_Tree			
			};

			public class CCacheObject
			{
				public string cache_entry_name;
				public object cached_object_ref;

				public object Value
				{
					get { return cached_object_ref; }
					set 
					{
						cached_object_ref = value;
					}
				}
			}


		}

	}
}
