using System;
using System.Data;
using System.Data.OleDb;
using System.Collections;

using GRAVE.Server;
using GRAVE.Server.Entity.Locator;
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation; 
using GRAVE.Server.Entity.Specification; 
using GRAVE.Server.Entity.RunTime; 

namespace GRAVE
{
	namespace Server
	{
		namespace Data
		{
			public class CEntityDBLocation : CEntityLocation
			{
				public long db_location_id = -1;

				public long db_connection_type_id = -1;							
				public string provider_name = "";
				public string database_name = "";
				public string dsn = "";
				public string connection_string = "";

				public CDataBase _db_handler = null;

				public CEntityDBLocation(CEntityLocationInfo linfo) : base(linfo)
				{
				}

				public CEntityDBLocation(CEntityLocationInfo linfo, string con_string) : base(linfo)
				{
					connection_string = con_string;
					_db_handler = new CDataBase(con_string);
				}

				public void SetDBHandler()
				{
					if (connection_string != "")
						_db_handler = new CDataBase(connection_string);
					else if (server_name != "")
						_db_handler = new CDataBase(server_name, database_name, user_id, password);
					else
						_db_handler = null;
				}

				public override DataTable FetchTable(string select_fields, string conditions)
				{
					if (!IsLocationSet)
						return null;

					string query = "select " + select_fields + " from " + location_info.loc_resource_name;
					if (conditions != "")
						query += " where " + conditions;

					return _db_handler.GetDataTable(query);
				}

				public override DataRow FetchTableRow(string select_fields, string conditions)
				{
					if (!IsLocationSet)
						return null;

					string query = "select " + select_fields + " from " + location_info.loc_resource_name;
					if (conditions != "")
						query += " where " + conditions;

					return _db_handler.GetDataRow(query);
				}

				public override object FetchTableCell(string select_fields, string conditions)
				{
					if (!IsLocationSet)
						return null;

					string query = "select " + select_fields + " from " + location_info.loc_resource_name;
					if (conditions != "")
						query += " where " + conditions;

					return _db_handler.GetDataCell(query);
				}

				public override void UpdateRow(string set_string, string conditions)
				{
					if (!IsLocationSet)
						return;

					string query = "update " + location_info.loc_resource_name + " set " + set_string;
					if (conditions != "")
						query += " where " + conditions;

					_db_handler.ExecuteQuery(query);
				}

				public override void InsertRow(string cols_string, string vals_string)
				{
					if (!IsLocationSet)
						return;

					string query = "insert into " + location_info.loc_resource_name;
					if (cols_string != "")
						query += "(" + cols_string + ")";

					if (vals_string != "")
						query += " values (" + vals_string + ")";

					_db_handler.ExecuteQuery(query);
				}

				protected override bool IsLocationSet
				{
					get
					{
						if (!base.IsLocationSet)
							return false;

						if (_db_handler == null)
							return false;

						return true;
					}
				}
			}

			public class CDataBase
			{
				public string connection_string;

				public string entity_server_name;
				public string entity_database_name;
				public string user_id;
				public string password;

				public string table_name;
	
				public CDataBase(string con_str)
				{
					connection_string = con_str;
				}

				public CDataBase(string server, string db, string uid, string pwd)
				{
					server=server.Trim();
					db=db.Trim();
					uid=uid.Trim();
					pwd=pwd.Trim();

					connection_string = "Provider=SQLOLEDB;data source=" + server +
						";initial catalog=" + db +
						";UID=" + uid +
						";PWD=" + pwd;

				}

				public DataTable GetDataTable(string query)
				{
					if (query == null || query == "")
						return null;

					DataTable ret = new DataTable();;

					try
					{
						// move this code to Data.cs and connect to ucms
						OleDbConnection dbCon = new OleDbConnection(connection_string); 
						dbCon.Open();

						OleDbDataAdapter adapter = new OleDbDataAdapter(query, dbCon);
						adapter.Fill(ret);
						dbCon.Close();
						return ret;
					}
					catch  (Exception e)
					{
						string err = e.Message;
						return null;
					}
				}

				public DataRow GetDataRow(string query)
				{
					if (query == null || query == "")
						return null;

					DataTable dt = new DataTable();;

					try
					{
						// move this code to Data.cs and connect to ucms
						OleDbConnection dbCon = new OleDbConnection(connection_string); 
						dbCon.Open();

						OleDbDataAdapter adapter = new OleDbDataAdapter(query, dbCon);
						adapter.Fill(dt);
						dbCon.Close();

						if (dt != null && dt.Rows.Count > 0)
							return dt.Rows[0];
					}
					catch  (Exception e)
					{
						string err = e.Message;
					}

					return null;
				}

				public object GetDataCell(string query)
				{
					if (query == null || query == "")
						return -1;

					try 
					{
						// move this code to Data.cs and connect to ucms
						OleDbConnection dbCon = new OleDbConnection(connection_string); 
						dbCon.Open();

						OleDbCommand cmd = new OleDbCommand(query, dbCon);
						object ret = cmd.ExecuteScalar();
						dbCon.Close();
				
						return ret;
					}
					catch (Exception e)
					{
						string msg = e.Message;
						return null;
					}
				}

				public int ExecuteQuery(string query)
				{
					if (query == null || query == "")
						return -1;

					try
					{
						// move this code to Data.cs and connect to ucms
						OleDbConnection dbCon = new OleDbConnection(connection_string); 
						dbCon.Open();

						OleDbCommand cmd = new OleDbCommand(query, dbCon);
						int ret = cmd.ExecuteNonQuery();
						dbCon.Close();
				
						return ret;
					}
					catch (Exception e)
					{
						string msg = e.Message;
						return -1;
					}
				}
			}
		}
	}
}