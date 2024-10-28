using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.Xml;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.TraceListeners;
using Microsoft.Practices.EnterpriseLibrary.Logging.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Security.Cryptography;

namespace CriticalErrorReporting.Logging
{
    /// <summary>
    /// Custom TraceListener to implement the logging in the Critical Error Reporting Framework
    /// </summary>
    [ConfigurationElementType(typeof(CustomTraceListenerData))]
    public class CriticalErrorTraceListener : CustomTraceListener
    {
        /// <summary>
        /// This is the attribute string for the custom attribute expected
        /// by this tracelistener.  
        /// </summary>
        internal const string IssueLogPathKey = "issueLogPath";
        /// <summary>
        /// This indicates that the tracelistener supports an attribute called issueLogPath
        /// This is used in GetSupportedAttributes
        /// </summary>
        internal readonly static string[] SupportedAttributes = new string[] { IssueLogPathKey };
        /// <summary>
        /// This is a synchronization object for the log
        /// </summary>
        private object _logSyncObj = new object();
        /// <summary>
        /// This holds the value of the issue log path from the configuation
        /// </summary>
        internal string _issueLogPath;

        /// <summary>
        /// Default Constructor for the TraceListener
        /// </summary>
        public CriticalErrorTraceListener()
        {
        }

        /// <summary>
        /// Constructor that take a path to an issue log file.  This path is set
        /// up in the EntLib config tool under the Attributes for the custom TraceListener
        /// </summary>
        /// <param name="issueLogPath">where to place the issue log</param>
        public CriticalErrorTraceListener(string issueLogPath)
        {
            this._issueLogPath = issueLogPath;
        }

        /// <summary>
        /// The location of the issue log.  Established via configuration attribute.
        /// </summary>
        internal string IssueLogPath
        {
            get { return Attributes[IssueLogPathKey]; }
        }

        /// <summary>
        /// This method indicates the attributes supported by the TraceListener.
        /// </summary>
        /// <returns></returns>
        protected override string[] GetSupportedAttributes()
        {
            return SupportedAttributes;
        }

        /// <summary>
        /// Write is not implemented as all of the work for this TraceListener is 
        /// done in TraceData
        /// </summary>
        /// <param name="message">the message to write</param>
        public override void Write(string message)
        {
            throw new Exception("The method or operation is not implemented.");
        }

        /// <summary>
        /// WriteLine is not implemented as all of the work for this TraceListener is 
        /// done in TraceData
        /// </summary>
        /// <param name="message">the message to write</param>
        public override void WriteLine(string message)
        {
            throw new Exception("The method or operation is not implemented.");
        }

        /// <summary>
        /// This method formats the current log entry and writes it to both the
        /// web service and the local issue log.
        /// </summary>
        /// <param name="eventCache">trace event data</param>
        /// <param name="source">source of the log entry</param>
        /// <param name="eventType">type of the event causing the trace</param>
        /// <param name="id">id of the event</param>
        /// <param name="data">data to trace</param>
        public override void TraceData(TraceEventCache eventCache, string source, TraceEventType eventType, int id, object data)
        {
            // check to see if we have a formatter set up and that this 
            // is a LogEntry
            if (data is LogEntry && this.Formatter != null)
            {
                // format the message using the formatter (should be DataSetXmlLogFormatter...)
                if (this.Formatter is DataSetXmlLogFormatter)
                {
                    FormatAndLog(data as LogEntry);
                }
                else
                {
                    throw new LoggingException("CriticalErrorTraceListener requires the DataSetXmlLogFormatter to be set in the configuration.");
                }
            }
        }

        /// <summary>
        /// Format the log entry and write it to the local issue log
        /// </summary>
        /// <param name="logEntry"></param>
        private void FormatAndLog(LogEntry logEntry)
        {
            // Format the log entry message
            string entryMessage = this.Formatter.Format(logEntry);

            // Write the formatted entry to the local log
            WriteLocalEntry(entryMessage);

            // Get the bytes for the log entry message
            byte[] entryBytes = Encoding.Unicode.GetBytes(entryMessage);

            // Encrypt the information using the Cryptography block
            // The "RijindaelManaged" string is the name of the Symmetric Provider
            // that is set up in the configuration file of the application.
            byte[] encryptedEntryBytes =
                Cryptographer.EncryptSymmetric("RijndaelManaged", entryBytes);

            // Base 64 encode the bytes
            string encodedEncryptedEntryMessage =
                Convert.ToBase64String(encryptedEntryBytes);

            // Get the bytes for the log entry message
            byte[] encodedEncryptedEntryBytes = 
                Encoding.UTF8.GetBytes(encodedEncryptedEntryMessage);

            // Send the encrypted entry to the web service for processing
            CriticalErrorReportingTarget.CriticalErrorReportingService reportService = new CriticalErrorReporting.CriticalErrorReportingTarget.CriticalErrorReportingService();
            reportService.ReportCriticalError(encodedEncryptedEntryBytes);
        }

        /// <summary>
        /// Write the log entry to the local issue log
        /// </summary>
        /// <param name="entryMessage">the XML for the log entry</param>
        private void WriteLocalEntry(string entryMessage)
        {
            // make sure there is only one writer at a time (from this at least...)
            lock (_logSyncObj)
            {
                // Load or create the issue log
                XmlDocument doc = new XmlDocument();
                XmlElement root = null;
                string issueLogPathNoQuotes = IssueLogPath.Trim(new char[] { '"' });
                if (File.Exists(issueLogPathNoQuotes))
                {
                    // found it, load it
                    doc.Load(issueLogPathNoQuotes);
                    root = doc.DocumentElement;
                }
                else
                {
                    // make a new issue log main section
                    doc.CreateXmlDeclaration("1.0", null, null);
                    root = doc.CreateElement("CriticalErrorEntries");
                    doc.AppendChild(root);
                }
                // make a new entry with the logentry XML 
                XmlElement entry = doc.CreateElement("CriticalErrorEntry");
                entry.InnerXml = entryMessage;
                entry.SetAttribute("logged", DateTime.UtcNow.ToString());
                root.AppendChild(entry);
                // save the issue log
                doc.Save(issueLogPathNoQuotes);
                doc = null;
            }
        }
    }
}
