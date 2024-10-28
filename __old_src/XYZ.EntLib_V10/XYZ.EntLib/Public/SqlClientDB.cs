using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace XYZ.Common.Data
{
    public class SqlClientDB
    {
        public string connection_string;

        public string entity_server_name;
        public string entity_database_name;
        public string user_id;
        public string password;

        public string table_name;

        public SqlClientDB(string con_str)
        {
            connection_string = con_str;
        }

        public SqlClientDB(string server, string db, string uid, string pwd)
        {
            server = server.Trim();
            db = db.Trim();
            uid = uid.Trim();
            pwd = pwd.Trim();

            connection_string = "Provider=SQLOLEDB;data source=" + server +
                ";initial catalog=" + db +
                ";UID=" + uid +
                ";PWD=" + pwd;

        }

        public DataTable GetDataTable(string query)
        {
            if (query == null || query == "")
                return null;

            DataTable dt = new DataTable(); ;

            System.Data.SqlClient.SqlConnection dbCon = null;
            try
            {
                // move this code to Data.cs and connect to ucms
                dbCon = new System.Data.SqlClient.SqlConnection(connection_string);
                dbCon.Open();

                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter(query, dbCon);
                adapter.Fill(dt);
                dbCon.Close();

                return dt;
            }
            catch (InvalidOperationException ioe)
            {
                XYZ.Common.ExceptionHandler.HandleException(ioe);
            }
            catch (Exception e)
            {
                string err = e.Message;
                XYZ.Common.ExceptionHandler.HandleException(e);
            }

            finally
            {
                if (dbCon != null)
                    dbCon.Close();
            }

            if (dt != null && dt.Rows.Count > 0)
                return dt;
            else
                return null;
        }

        public DataRow GetDataRow(string query)
        {
            if (query == null || query == "")
                return null;

            DataTable dt = new DataTable(); ;
            DataRow dr = null;

            System.Data.SqlClient.SqlConnection dbCon = null;
            try
            {
                dbCon = new System.Data.SqlClient.SqlConnection(connection_string);
                dbCon.Open();

                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter(query, dbCon);
                adapter.Fill(dt);
                dbCon.Close();
            }
            catch (InvalidOperationException ioe)
            {
                XYZ.Common.ExceptionHandler.HandleException(ioe);
            }
            catch (Exception e)
            {
                string err = e.Message;
                XYZ.Common.ExceptionHandler.HandleException(e);
            }

            finally
            {
                if (dbCon != null)
                    dbCon.Close();

                if (dt != null && dt.Rows.Count > 0)
                    dr = dt.Rows[0];
            }

            return dr;
        }

        public object GetDataCell(string query)
        {
            if (query == null || query == "")
                return -1;

            System.Data.SqlClient.SqlConnection dbCon = null;
            System.Data.SqlClient.SqlDataReader reader = null;
            object v = null;

            try
            {
                // move this code to Data.cs and connect to ucms
                dbCon = new System.Data.SqlClient.SqlConnection(connection_string);
                dbCon.Open();

                SqlCommand cmd = new SqlCommand(query, dbCon);
                
                reader = cmd.ExecuteReader();

                if (reader != null)
                    v = reader.GetValue(0);
            }
            catch (InvalidOperationException ioe)
            {
                XYZ.Common.ExceptionHandler.HandleException(ioe);
            }
            catch (Exception e)
            {
                string err = e.Message;
                XYZ.Common.ExceptionHandler.HandleException(e);
            }

            finally
            {
                if (dbCon != null)
                    dbCon.Close();
            }

            return v;
        }

        public int ExecuteQuery(string query)
        {
            if (query == null || query == "")
                return -1;

            int ret1 = 1;
            System.Data.SqlClient.SqlConnection dbCon = null;
            try
            {
                // move this code to Data.cs and connect to ucms
                dbCon = new System.Data.SqlClient.SqlConnection(connection_string);
                dbCon.Open();

                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, dbCon);
                object ret = cmd.ExecuteScalar();
                dbCon.Close();

                if (ret != null)
                    ret1 = (int)ret;
            }
            catch (InvalidOperationException ioe)
            {
                XYZ.Common.ExceptionHandler.HandleException(ioe);
            }
            catch (Exception e)
            {
                string err = e.Message;
                XYZ.Common.ExceptionHandler.HandleException(e);
            }

            finally
            {
                if (dbCon != null)
                    dbCon.Close();
            }
 
            return ret1;
        }
    }
}