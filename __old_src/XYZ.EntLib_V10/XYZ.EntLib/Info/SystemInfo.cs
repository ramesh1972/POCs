using System;
using System.Collections;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Text;

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    public class SystemInfo : BaseInfo
    {
        public SystemInfo()
        {
        }

        public SystemInfo(XYZ_EntLib_DB_DS logDS, Guid log_id) : base(logDS, log_id)
        {
        }

        public void SetSystemInfo()
        {
            AssemblyInfo ainfo = new AssemblyInfo(_logDS, _logEntryId);
            XYZ_EntLib_DB_DS.DiagnosticInfoRow drow = ainfo.SetAssemblyInfo();

            // Add host environment information
            SetHostEnvironmentInfo();

            ProcessInfo pinfo = new ProcessInfo(_logDS, _logEntryId);
            pinfo.SetProcessInfo();
            pinfo.SetStartInfo();
        }

        public void SetHostEnvironmentInfo()
        {
            // create a new row
            XYZ_EntLib_DB_DS.HostEnvironmentRow row = _logDS.HostEnvironment.NewHostEnvironmentRow();
            row.logEntryId = _logEntryId;

            // write out the values
            row.osVersion = Environment.OSVersion.ToString();
            row.processorCount = (short)Environment.ProcessorCount;
            row.currentDirectory = Environment.CurrentDirectory;

            // add the row
            _logDS.HostEnvironment.Rows.Add(row);
        }

        public void SetEnvironmentVariablesInfo(IDictionary variables)
        {
            // write each variable out
            foreach (DictionaryEntry entry in variables)
            {
                // make a row
                XYZ_EntLib_DB_DS.EnvironmentVariablesRow row = _logDS.EnvironmentVariables.NewEnvironmentVariablesRow();

                // add the name/value
                row.logEntryId = _logEntryId;
                row.variableName = entry.Key.ToString();
                row.variableValue = entry.Value.ToString();

                // add the row
                _logDS.EnvironmentVariables.Rows.Add(row);
            }
        }

        public void SetEnvironmentVariablesInfo(StringDictionary variables)
        {
            // write each one
            foreach (DictionaryEntry entry in variables)
            {
                // make a new row
                XYZ_EntLib_DB_DS.EnvironmentVariablesRow row = _logDS.EnvironmentVariables.NewEnvironmentVariablesRow();

                // add the values
                row.logEntryId = _logEntryId;
                row.variableName = entry.Key.ToString();
                row.variableValue = entry.Value.ToString();

                // add the row
                _logDS.EnvironmentVariables.Rows.Add(row);
            }
        }
    }
}
