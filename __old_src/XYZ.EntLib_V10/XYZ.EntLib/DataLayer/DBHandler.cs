using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.XPath;
using System.IO;
using System.Text;
using System.Diagnostics;
using Microsoft.Practices.EnterpriseLibrary.Data;

using XYZ.EntLib.DataLayer.XYZ_EntLib_DB_DSTableAdapters;

namespace XYZ.EntLib.DataLayer
{
    public partial class XYZ_EntLib_DB_DS : System.Data.DataSet
    {
        Database db = null;
        public XYZ_EntLib_DB_DS(string constr)
        {
        }

        public void SaveLog(string constr, string logmsg)
        {
            // Process the critical error xml
            using (StringReader stream = new StringReader(logmsg))
            {
                XmlReadMode mode = this.ReadXml(stream);
            }

            SaveLog(constr);
        }

        public void SaveLog(string constr)
        {
            db = DatabaseFactory.CreateDatabase(constr);

            DbTransaction transaction = null;
            try
                {
                    // create the connection for the database
                    using (DbConnection connection = db.CreateConnection())
                    {
                        // open the connection
                        connection.Open();

                        // start the transaction
                        transaction = connection.BeginTransaction();
                        PersistLogEntry(db, transaction);
                                                
                        // Persist the other parts of the log entry in the same manner
                        PersistExtendedProperties(db, transaction);
                        
                        PersistException(db, transaction);
                        PersistExceptionData(db, transaction);
                        PersistReflectionProperties(db, transaction);
                        PersistReflectionFields(db, transaction);
                        PersistInnerExceptions(db, transaction);

                        PersistReflectionTargetSite(db, transaction);
                        PersistGenericArguments(db, transaction);

                        PersistDiagnosticInfo(db, transaction);
                        PersistProcessInfo(db, transaction);
                        PersistStartInfo(db, transaction);

                        PersistHostEnvironment(db, transaction);
                        PersistEnvironmentVariables(db, transaction);
                        PersistVerbs(db, transaction);

                        // Commit the transaction.
                        transaction.Commit();
                  }
            }
            catch (Exception e)
            {
                Debug.WriteLine("Exception caught Persisting log entry:" + e.ToString());
                // Roll back the transaction. 
                transaction.Rollback();
                throw e;
            }
        }

        private void PersistLogEntry(Database db, DbTransaction transaction)
        {
            LogEntryTableAdapter adapter = new LogEntryTableAdapter();
            adapter.Connection = (SqlConnection) transaction.Connection;
            db.UpdateDataSet(this, "LogEntry",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }
        
        private void PersistExtendedProperties(Database db, DbTransaction transaction)
        {
            ExtendedPropsTableAdapter adapter = new ExtendedPropsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ExtendedProps",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistException(Database db, DbTransaction transaction)
        {
            ExceptionTableAdapter adapter = new ExceptionTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "Exception",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistInnerExceptions(Database db, DbTransaction transaction)
        {
            InnerExceptionsTableAdapter adapter = new InnerExceptionsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "InnerExceptions",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistExceptionData(Database db, DbTransaction transaction)
        {
            ExceptionDataTableAdapter adapter = new ExceptionDataTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ExceptionData",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistReflectionTargetSite(Database db, DbTransaction transaction)
        {
            ReflectionTargetSiteTableAdapter adapter = new ReflectionTargetSiteTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ReflectionTargetSite",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistGenericArguments(Database db, DbTransaction transaction)
        {
            ReflectionGenericArgumentsTableAdapter adapter = new ReflectionGenericArgumentsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ReflectionGenericArguments",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistDiagnosticInfo(Database db, DbTransaction transaction)
        {
            DiagnosticInfoTableAdapter adapter = new DiagnosticInfoTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "DiagnosticInfo",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistProcessInfo(Database db, DbTransaction transaction)
        {
            ProcessInfoTableAdapter adapter = new ProcessInfoTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ProcessInfo",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistStartInfo(Database db, DbTransaction transaction)
        {
            StartInfoTableAdapter adapter = new StartInfoTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "StartInfo",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistEnvironmentVariables(Database db, DbTransaction transaction)
        {
            EnvironmentVariablesTableAdapter adapter = new EnvironmentVariablesTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "EnvironmentVariables",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistVerbs(Database db, DbTransaction transaction)
        {
            VerbsTableAdapter adapter = new VerbsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "Verbs",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistHostEnvironment(Database db, DbTransaction transaction)
        {
            HostEnvironmentTableAdapter adapter = new HostEnvironmentTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "HostEnvironment",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistReflectionProperties(Database db, DbTransaction transaction)
        {
            ReflectionPropertiesTableAdapter adapter = new ReflectionPropertiesTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ReflectionProperties",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistReflectionFields(Database db, DbTransaction transaction)
        {
            ReflectionFieldsTableAdapter adapter = new ReflectionFieldsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ReflectionFields",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }
    }
}
