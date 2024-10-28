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
using CriticalErrorReporting.Data.CriticalErrorDSTableAdapters;

namespace CriticalErrorReporting.Data 
{
    /// <summary>
    /// Extension code to the DataSet to handle processing a critical error
    /// </summary>
    partial class CriticalErrorDS
    {
        partial class ExceptionDataTable
        {
        }
        /// <summary>
        /// Process the critical error from it's posted format to the database
        /// </summary>
        /// <param name="message">the byte array containing the posted error</param>
        public void ProcessCriticalError(string entryMessage, Database db)
        {
            try
            {
                // Process the critical error xml
                using (StringReader errorStream = new StringReader(entryMessage))
                {
                    XmlReadMode mode = this.ReadXml(errorStream);
                }
                // persist to the db
                PersistLogEntry(db);
            }
            catch (Exception e)
            {
                Debug.WriteLine("Exception from ProcessCriticalError: " + e);
                throw e;
            }
        }

        #region Persist Methods (to DB from DataSet)
        /// <summary>
        /// Persist the whole log entry into the database
        /// </summary>
        /// <param name="db">the EntLib database to persist to</param>
        private void PersistLogEntry(Database db)
        {
            // create the connection for the database
            using (DbConnection connection = db.CreateConnection())
            {
                // open the connection
                connection.Open();
                // start the transaction
                DbTransaction transaction = connection.BeginTransaction();
                try
                {
                    // use the extended adapters to perform the persistence
                    LogEntryTableAdapter adapter = new LogEntryTableAdapter();
                    // set the adapter connection to the EntLib connection so 
                    // that it participates in the transaction
                    adapter.Connection = (SqlConnection)connection;
                    // update the data set using the methods from the 
                    // extended adapter
                    db.UpdateDataSet(this, "LogEntry",
                        adapter.GetInsertCommand(), adapter.GetDeleteCommand(), 
                        adapter.GetUpdateCommand(), transaction);
                    // persist the other parts of the log entry in the same manner
                    PersistCategories(db,transaction);
                    PersistExtendedProperties(db, transaction);
                    PersistException(db, transaction);

                    // Commit the transaction.
                    transaction.Commit();
                }
                catch(Exception e)
                {
                    Debug.WriteLine("Exception caught persisting log entry:" + e.ToString());
                    // Roll back the transaction. 
                    transaction.Rollback();
                    throw e;
                }
            }
        }

        private void PersistCategories(Database db, DbTransaction transaction)
        {
            CategoriesTableAdapter adapter = new CategoriesTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "Categories",
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

            PersistExceptionData(db, transaction);
            PersistTargetSite(db, transaction);
            PersistAdditionalInfo(db, transaction);
            PersistDiagnosticInfo(db, transaction);
            PersistExceptionProperties(db, transaction);
            PersistExceptionFields(db, transaction);
            PersistInnerExceptions(db, transaction);
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

        private void PersistTargetSite(Database db, DbTransaction transaction)
        {
            TargetSiteTableAdapter adapter = new TargetSiteTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "TargetSite",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(), 
                adapter.GetUpdateCommand(), transaction);
            PersistGenericArguments(db, transaction);
        }

        private void PersistGenericArguments(Database db, DbTransaction transaction)
        {
            GenericArgumentsTableAdapter adapter = new GenericArgumentsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "GenericArguments",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(), 
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistAdditionalInfo(Database db, DbTransaction transaction)
        {
            AdditionalInfoTableAdapter adapter = new AdditionalInfoTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "AdditionalInfo",
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
            PersistProcessInfo(db, transaction);
            PersistHostEnvironment(db, transaction);
        }

        private void PersistProcessInfo(Database db, DbTransaction transaction)
        {
            ProcessInfoTableAdapter adapter = new ProcessInfoTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ProcessInfo",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(), 
                adapter.GetUpdateCommand(), transaction);
            PersistStartInfo(db, transaction);
            PersistEnvironmentVariables(db, transaction);
        }

        private void PersistStartInfo(Database db, DbTransaction transaction)
        {
            StartInfoTableAdapter adapter = new StartInfoTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "StartInfo",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(), 
                adapter.GetUpdateCommand(), transaction);
            PersistEnvironmentVariables(db, transaction);
            PersistVerbs(db, transaction);
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

        private void PersistExceptionProperties(Database db, DbTransaction transaction)
        {
            ExceptionPropertiesTableAdapter adapter = new ExceptionPropertiesTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ExceptionProperties",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        private void PersistExceptionFields(Database db, DbTransaction transaction)
        {
            ExceptionFieldsTableAdapter adapter = new ExceptionFieldsTableAdapter();
            adapter.Connection = (SqlConnection)transaction.Connection;
            db.UpdateDataSet(this, "ExceptionFields",
                adapter.GetInsertCommand(), adapter.GetDeleteCommand(),
                adapter.GetUpdateCommand(), transaction);
        }

        #endregion // Persist Methods
    }
}

#region Extended Table Adapters 
namespace CriticalErrorReporting.Data.CriticalErrorDSTableAdapters 
{
    // These table adapters have additional methods added via 
    // partial classes to enable access to the commands that are
    // set up via the DataSet UI so that these commands do not
    // have to be rebuilt in each of the persist methods

    public partial class AdditionalInfoTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class VerbsTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class CategoriesTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class DiagnosticInfoTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class EnvironmentVariablesTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class ExceptionTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class ExceptionDataTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class GenericArgumentsTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class HostEnvironmentTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class InnerExceptionsTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class LogEntryTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class ProcessInfoTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class StartInfoTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class TargetSiteTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class ExtendedPropsTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class ExceptionPropertiesTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }

    public partial class ExceptionFieldsTableAdapter
    {
        public System.Data.SqlClient.SqlCommand GetInsertCommand()
        {
            return this.Adapter.InsertCommand;
        }
        public System.Data.SqlClient.SqlCommand GetUpdateCommand()
        {
            return this.Adapter.UpdateCommand;
        }
        public System.Data.SqlClient.SqlCommand GetDeleteCommand()
        {
            return this.Adapter.DeleteCommand;
        }
    }
}
#endregion