using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;

using XYZ.EntLib.DataLayer;
using XYZ.EntLib.DataLayer.XYZ_EntLib_DB_DSTableAdapters;

namespace XYZ.EntLib.AppBlocks
{
    public class ProcessInfo : BaseInfo
    {
        public ProcessInfo()
        {
        }

        public ProcessInfo(XYZ_EntLib_DB_DS logDS)
            : base(logDS)
        {
        }

        public ProcessInfo(XYZ_EntLib_DB_DS logDS, Guid log_id) : base(logDS, log_id)
        {
        }

        public XYZ_EntLib_DB_DS.ProcessInfoRow SetProcessInfo()
        {
            // Make a new row
            XYZ_EntLib_DB_DS.ProcessInfoRow row = _logDS.ProcessInfo.NewProcessInfoRow();
            row.logEntryId = _logEntryId;

            // get some process information
            Process currentProcess = Process.GetCurrentProcess();

            // add the process data
            row.startTime = currentProcess.StartTime;
            row.processId = currentProcess.Id;
            row.terminalServicesSessionId = currentProcess.SessionId;
            row.nonPagedSystemMemorySize = currentProcess.NonpagedSystemMemorySize64;
            row.pagedMemorySize = currentProcess.PagedMemorySize64;
            row.pagedSystemMemory = currentProcess.PagedSystemMemorySize64;
            row.peakPagedMemorySize = currentProcess.PeakPagedMemorySize64;
            row.peakVirtualMemorySize = currentProcess.PeakVirtualMemorySize64;
            row.peakWorkingSet = currentProcess.PeakWorkingSet64;
            row.privateMemorySize = currentProcess.PrivateMemorySize64;
            row.virtualMemorySize = currentProcess.VirtualMemorySize64;
            row.workingSet = currentProcess.WorkingSet64;
            row.totalProcessorTimeDays = currentProcess.TotalProcessorTime.Days;
            row.totalProcessorTimeHours = currentProcess.TotalProcessorTime.Hours;
            row.totalProcessorTimeMinutes = currentProcess.TotalProcessorTime.Minutes;
            row.totalProcessorTimeSeconds = currentProcess.TotalProcessorTime.Seconds;
            row.totalProcessorTimeFraction = currentProcess.TotalProcessorTime.Milliseconds;
            row.userProcessorTimeDays = currentProcess.UserProcessorTime.Days;
            row.userProcessorTimeHours = currentProcess.UserProcessorTime.Hours;
            row.userProcessorTimeMinutes = currentProcess.UserProcessorTime.Minutes;
            row.userProcessorTimeSeconds = currentProcess.UserProcessorTime.Seconds;
            row.userProcessorTimeFraction = currentProcess.UserProcessorTime.Milliseconds;
            row.threadCount = currentProcess.Threads.Count;

            // Add the row
            _logDS.ProcessInfo.Rows.Add(row);

            SetStartInfo();

            return row;
        }

        public void SetStartInfo()
        {
            // make the row
            XYZ_EntLib_DB_DS.StartInfoRow row = _logDS.StartInfo.NewStartInfoRow();

            // Get the ProcessStartInfo
            ProcessStartInfo startInfo = Process.GetCurrentProcess().StartInfo;
            row.logEntryId = _logEntryId;

            // add the values
            row.fileName = startInfo.FileName;
            row.arguments = startInfo.Arguments;
            row.domain = startInfo.Domain;
            row.verb = startInfo.Verb;
            row.useShellExecute = startInfo.UseShellExecute;
            row.workingDirectory = startInfo.WorkingDirectory;

            // write the environment block
            SystemInfo sinfo = new SystemInfo(_logDS, _logEntryId);
            sinfo.SetEnvironmentVariablesInfo(startInfo.EnvironmentVariables);

            // write the verbs
            SetVerbsInfo(startInfo.Verbs);

            // add the row
            _logDS.StartInfo.Rows.Add(row);
        }

        public void SetVerbsInfo(string[] verbs)
        {
            // write each one
            foreach (string verb in verbs)
            {
                // create the row
                XYZ_EntLib_DB_DS.VerbsRow row = _logDS.Verbs.NewVerbsRow();

                // write the value
                row.logEntryId = _logEntryId;
                row.verb = verb;

                // add the row
                _logDS.Verbs.Rows.Add(row);
            }
        }

        public string GetHtmlFromDB(string type)
        {
            if (type.Equals("Process Info"))
            {
            }

            return "";
        }
    }
}
