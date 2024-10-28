using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.XPath;
using System.IO;
using System.Text;
using System.Diagnostics;
using System.Collections;
using System.Collections.Generic;

using Microsoft.Practices.EnterpriseLibrary.Logging;

using XYZ.EntLib.DataLayer;
using XYZ.EntLib.DataLayer.XYZ_EntLib_DB_DSTableAdapters;

namespace XYZ.EntLib.AppBlocks
{
    public class LogInfo : BaseInfo
    {
        public LogInfo(XYZ_EntLib_DB_DS logDS, Guid log_id) : base(logDS, log_id)
        {
        }

        public LogInfo(Guid log_id)
        {
            _logEntryId = log_id;
        }

        public LogInfo()
        {
        }

        public static XYZ_EntLib_DB_DS PrepareDS()
        {
            XYZ_EntLib_DB_DS ds = new XYZ_EntLib_DB_DS();
            XYZ_EntLib_DB_DS.LogEntryRow lrow = ds.LogEntry.NewLogEntryRow();
            lrow.id = Guid.NewGuid();

            LogInfo linfo = new LogInfo(ds, lrow.id);

            ds.LogEntry.Rows.Add(lrow);
            return ds;
        }

        public void SetLogMessage(LogEntry logEntry)
        {
            _logDS = new XYZ_EntLib_DB_DS();

            // check to see is this XYZ_EntLib_DB_DataSet schema xml message
            if (logEntry.Message.StartsWith("<XYZ_EntLib_DB_DS"))
            {
                XmlReaderSettings set = new XmlReaderSettings();

                XmlTextReader tr = new XmlTextReader(logEntry.Message, XmlNodeType.Document, null);
                _logDS.ReadXml(tr);
                if (_logDS.LogEntry.Rows.Count > 0)
                    _logEntryId = ((XYZ_EntLib_DB_DS.LogEntryRow)_logDS.LogEntry.Rows[0]).id;
            }

            SetLogEntryInfo(logEntry);
        }

        private void SetLogEntryInfo(LogEntry logEntry)
        {
            try
            {
                // make a new row in the dataset for the log entry
                XYZ_EntLib_DB_DS.LogEntryRow row = null;
                if (_logDS.LogEntry.Rows.Count > 0)
                {
                    row = (XYZ_EntLib_DB_DS.LogEntryRow)_logDS.LogEntry.Rows[0]; // assumes that a logEntry node is created
                    _logEntryId = row.id;
                }
                else
                {
                    row = _logDS.LogEntry.NewLogEntryRow();
                    row.id = _logEntryId;
                    _logDS.LogEntry.Rows.Add(row);
                }

                if (row.id.Equals(Guid.Empty))
                {
                    _logEntryId = Guid.NewGuid();
                    row.id = _logEntryId;
                }

                // extract and write the site code for the log entry
                Object siteCodeObject;
                if (logEntry.ExtendedProperties.TryGetValue("SiteCode", out siteCodeObject))
                    row.siteCode = (String) siteCodeObject;

                // extract and write the issue tag for the log entry
                Object issueTagObject;
                if (logEntry.ExtendedProperties.TryGetValue("IssueTag", out issueTagObject))
                    row.issueTag = (Guid) issueTagObject;

                // write the entry data
                row.activityId = logEntry.ActivityId;
                row.appDomainName = logEntry.AppDomainName;
                if (logEntry.Message.StartsWith("<XYZ_EntLib_DB_DS"))
                    row.errorMessages = "";
                else
                    row.errorMessages = logEntry.Message;

                if (logEntry.ErrorMessages != "")
                    if (row.errorMessages == "")
                        row.errorMessages += logEntry.ErrorMessages;
                    else
                        row.errorMessages += Environment.NewLine + logEntry.ErrorMessages;

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

                // write the extended properties for the log entry
                SetExtendedPropsInfo(logEntry.ExtendedProperties, _logEntryId);
            }
            catch (Exception e)
            {
                Debug.WriteLine("Handling LogEntry threw exception: " + e);
                throw e;
            }
        }

        private void SetExtendedPropsInfo(IDictionary<string, object> props, Guid log_id)
        {
            // write em all
            foreach (KeyValuePair<string, object> entry in props)
            {
                // make a new row
                XYZ_EntLib_DB_DS.ExtendedPropsRow row = _logDS.ExtendedProps.NewExtendedPropsRow();

                // write the values
                row.logEntryId = log_id;
                row.propertyKey = entry.Key;
                row.propertyValue = entry.Value.ToString();

                // add a new row
                _logDS.ExtendedProps.Rows.Add(row);
            }
        }

        public ArrayList GetRelatedLogEntriesList()
        {
            ArrayList list = new ArrayList();
            if ((int) (new LogEntryTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Log Info");
            if ((int)(new ExtendedPropsTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Extended Properties");
            if ((int)(new StartInfoTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Start Info");
            if ((int)(new ExceptionTableAdapter().GetCount(_logEntryId)) > 0)
            {
                list.Add("Exception");
                list.Add("Exception Data");
                list.Add("Inner Exception");
            }

            if ((int)(new HostEnvironmentTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Host Environment");
            if ((int)(new DiagnosticInfoTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Diagnostic Info");
            if ((int)(new ProcessInfoTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Process Info");
            if ((int)(new EnvironmentVariablesTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Environment Variables");
            if ((int)(new VerbsTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Verbs");
            if ((int)(new ReflectionTargetSiteTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Reflection TargetSite");
            if ((int)(new ReflectionFieldsTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Reflection Fields");
            if ((int)(new ReflectionGenericArgumentsTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Reflection Arguments");
            if ((int)(new ReflectionPropertiesTableAdapter().GetCount(_logEntryId)) > 0)
                list.Add("Reflection Properties");

            return list;
        }

        public string GetHtml(string type)
        {
            if (type.Equals("Process Info"))
            {
                XYZ_EntLib_DB_DS.ProcessInfoDataTable dt = (new ProcessInfoTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Diagnostic Info"))
            {
                XYZ_EntLib_DB_DS.DiagnosticInfoDataTable dt = (new DiagnosticInfoTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Log Info"))
            {
                XYZ_EntLib_DB_DS.LogEntryDataTable dt = (new LogEntryTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Start Info"))
            {
                XYZ_EntLib_DB_DS.StartInfoDataTable dt = (new StartInfoTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Extended Properties"))
            {
                XYZ_EntLib_DB_DS.ExtendedPropsDataTable dt = (new ExtendedPropsTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Exception"))
            {
                XYZ_EntLib_DB_DS.ExceptionDataTable dt = (new ExceptionTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Exception Data"))
            {
                XYZ_EntLib_DB_DS.ExceptionDataDataTable dt = (new ExceptionDataTableAdapter().GetDataByExpId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Inner Exception"))
            {
                XYZ_EntLib_DB_DS.InnerExceptionsDataTable dt = (new InnerExceptionsTableAdapter().GetDataByExpId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Host Environment"))
            {
                XYZ_EntLib_DB_DS.HostEnvironmentDataTable dt = (new HostEnvironmentTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Environment Variables"))
            {
                XYZ_EntLib_DB_DS.EnvironmentVariablesDataTable dt = (new EnvironmentVariablesTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Verbs"))
            {
                XYZ_EntLib_DB_DS.VerbsDataTable dt = (new VerbsTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Reflection TargetSite"))
            {
                XYZ_EntLib_DB_DS.ReflectionTargetSiteDataTable dt = (new ReflectionTargetSiteTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlVerticalTable(dt);
            }
            if (type.Equals("Reflection Arguments"))
            {
                XYZ_EntLib_DB_DS.ReflectionGenericArgumentsDataTable dt = (new ReflectionGenericArgumentsTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Reflection Properties"))
            {
                XYZ_EntLib_DB_DS.ReflectionPropertiesDataTable dt = (new ReflectionPropertiesTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlHorzTable(dt);
            }
            if (type.Equals("Reflection Fields"))
            {
                XYZ_EntLib_DB_DS.ReflectionFieldsDataTable dt = (new ReflectionFieldsTableAdapter().GetDataByLogId(_logEntryId));
                return GetHtmlHorzTable(dt);
            } 
            return "";
        }

        public string GetAllHtml()
        {
            string html = "";
            html += GetHtmlVerticalTable(_logDS.ProcessInfo);
            html += "</br>";
            html += GetHtmlVerticalTable(_logDS.DiagnosticInfo);
            html += "</br>";
            html += GetHtmlVerticalTable(_logDS.LogEntry);
            html += "</br>";
            html += GetHtmlVerticalTable(_logDS.StartInfo);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.ExtendedProps);
            html += "</br>";
            html += GetHtmlVerticalTable(_logDS.Exception);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.ExceptionData);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.InnerExceptions);
            html += "</br>";
            html += GetHtmlVerticalTable(_logDS.HostEnvironment);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.Verbs);
            html += "</br>";
            html += GetHtmlVerticalTable(_logDS.ReflectionTargetSite);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.ReflectionGenericArguments);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.ReflectionProperties);
            html += "</br>";
            html += GetHtmlHorzTable(_logDS.ReflectionFields);
            return html;
        }
    }
 }
