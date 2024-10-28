using System;
using System.Collections.Generic;
using System.Collections;
using System.Collections.Specialized;
using System.Text;
using System.IO;
using System.Data;
using System.Xml;
using System.Diagnostics;
using CriticalErrorReporting.Data;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging.Formatters;

namespace CriticalErrorReporting.Logging
{
    /// <summary>
    /// Log formatter that will format a LogEntry into an XML representation of a DataSet.
    /// </summary>
    [ConfigurationElementType(typeof(CustomFormatterData))]
    public class DataSetXmlLogFormatter : LogFormatter
    {
        /// <summary>
        /// The dataset member
        /// </summary>
        private CriticalErrorDS _errorDS = null;

        /// <summary>
        /// Initializes a new instance of the DataSetXmlLogFormatter class.
        /// </summary>
        public DataSetXmlLogFormatter(NameValueCollection ignored)
        {
        }

        /// <summary>
        /// Formats a log entry into an xml representation of a DataSet.
        /// </summary>
        /// <param name="logEntry">The LogEntry to format.</param>
        /// <returns>The LogEntry as xml</returns>
        public override string Format(LogEntry logEntry)
        {
            string xmlLogEntry = "";
            try
            {
                _errorDS = new CriticalErrorDS();
                // load up the exception info into the dataset
                using (StringReader exceptionStream = new StringReader(logEntry.Message))
                {
                    XmlReadMode mode = _errorDS.ReadXml(exceptionStream);
                }

                // make a new row in the dataset for the log entry
                CriticalErrorDS.LogEntryRow row = _errorDS.LogEntry.NewLogEntryRow();
                row.id = Guid.NewGuid();
                // extract and write the site code for the log entry
                WriteSiteCode(row, logEntry);
                // extract and write the issue tag for the log entry
                WriteIssueTag(row, logEntry);
                // write the entry data
                row.activityId = logEntry.ActivityId;
                row.appDomainName = logEntry.AppDomainName;
                row.errorMessages = logEntry.ErrorMessages;
                row.eventId = logEntry.EventId;
                row.loggedSeverity = logEntry.LoggedSeverity;
                row.machineName = logEntry.MachineName;
                row.managedThreadName = logEntry.ManagedThreadName;
                row.priority = logEntry.Priority;
                row.processId = Convert.ToInt32(logEntry.ProcessId);
                row.processName = logEntry.ProcessName;
                row.severity = logEntry.Severity.ToString();
                row.timeStamp = logEntry.TimeStamp;
                row.title = logEntry.Title;
                row.win32ThreadId = Convert.ToInt32(logEntry.Win32ThreadId);
                // write the log entry categories
                row.categoriesId = Guid.NewGuid();
                WriteCategories(logEntry.CategoriesStrings, row.categoriesId);
                // extract and write the exception id for the log entry
                WriteExceptionId(row);
                // write the extended properties for the log entry
                row.extendedPropertiesId = Guid.NewGuid();
                WriteExtendedProps(logEntry.ExtendedProperties, row.extendedPropertiesId);
                // add the row
                _errorDS.LogEntry.Rows.Add(row);

                // create a memory stream to hold the resulting xml
                using (MemoryStream memStream = new MemoryStream())
                {
                    // write out the xml for the dataset
                    _errorDS.WriteXml(memStream);
                    // convert it to a string
                    xmlLogEntry = Encoding.UTF8.GetString(memStream.ToArray());
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine("Formatting LogEntry threw exception: " + e);
                throw e;
            }
            // return the string for the log entry
            return xmlLogEntry;
        }

        /// <summary>
        /// Get the site code from the extended properties of the log entry and 
        /// add it directly to the log entry information
        /// </summary>
        /// <param name="row">the log entry row</param>
        /// <param name="logEntry">the log entry</param>
        private void WriteSiteCode(CriticalErrorDS.LogEntryRow row, LogEntry logEntry)
        {
            // add the site code to the top level info if present
            Object siteCodeObject;
            if (logEntry.ExtendedProperties.TryGetValue("SiteCode", out siteCodeObject))
            {
                row.siteCode = siteCodeObject.ToString();
            }
        }

        /// <summary>
        /// Get the issue tag from the extended properties of the log entry and 
        /// add it directly to the log entry information
        /// </summary>
        /// <param name="row">the log entry row</param>
        /// <param name="logEntry">the log entry</param>
        private void WriteIssueTag(CriticalErrorDS.LogEntryRow row, LogEntry logEntry)
        {
            // add the issue tag to the top level info if present
            Object issueTagObject;
            if (logEntry.ExtendedProperties.TryGetValue("IssueTag", out issueTagObject))
            {
                row.issueTag = (Guid)issueTagObject;
            }
        }

        /// <summary>
        /// Get the exception id from the LogEntry message xml and add it
        /// directly to the log entry row
        /// </summary>
        /// <param name="row">the log entry row</param>
        private void WriteExceptionId(CriticalErrorDS.LogEntryRow row)
        {
            DataRow[] rows = _errorDS.Exception.Select("diagnosticInfoId <> '00000000-0000-0000-0000-000000000000'");
            // should only be one row in this table for the actual exception, all
            // the others are inner exceptions marked by the null GUID in the diagnostic info
            // since we don't do diagnostic info for inner exceptions as it would be the 
            // same.
            row.exceptionId = (Guid)rows[0]["id"];
        }

        /// <summary>
        /// Write out all of the categories the log entry has
        /// </summary>
        /// <param name="categories">the categories of the log entry</param>
        /// <param name="id">the category id</param>
        private void WriteCategories(string[] categories, Guid id)
        {
            // write em all...
            foreach (string category in categories)
            {
                // make a new row
                CriticalErrorDS.CategoriesRow row = _errorDS.Categories.NewCategoriesRow();
                // write the data
                row.logEntryCategoriesId = id;
                row.category = category;
                // add the row
                _errorDS.Categories.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write out the extended properties of the log entry
        /// </summary>
        /// <param name="props">the properties for the log entry</param>
        /// <param name="id">the id for the properties</param>
        private void WriteExtendedProps(IDictionary<string,object> props, Guid id)
        {
            // write em all
            foreach (KeyValuePair<string, object> entry in props)
            {
                // make a new row
                CriticalErrorDS.ExtendedPropsRow row = _errorDS.ExtendedProps.NewExtendedPropsRow();
                // write the values
                row.logEntryExtendedPropertiesId = id;
                row.propertyKey = entry.Key;
                row.propertyValue = entry.Value.ToString();
                // add a new row
                _errorDS.ExtendedProps.Rows.Add(row);
            }
        }
    }
}
