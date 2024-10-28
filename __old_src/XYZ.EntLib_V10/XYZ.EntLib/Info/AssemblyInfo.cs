using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using System.Reflection;
using System.Diagnostics;

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    public class AssemblyInfo : BaseInfo
    {
        public AssemblyInfo()
        {
        }

        public AssemblyInfo(XYZ_EntLib_DB_DS logDS)
            : base(logDS)
        {
        }

        public AssemblyInfo(XYZ_EntLib_DB_DS logDS, Guid log_id) : base(logDS, log_id)
        {
        }

        public XYZ_EntLib_DB_DS.DiagnosticInfoRow SetAssemblyInfo()
        {
            // Create the row for the diagnostic info
            XYZ_EntLib_DB_DS.DiagnosticInfoRow row = _logDS.DiagnosticInfo.NewDiagnosticInfoRow();
            row.logEntryId = _logEntryId;

            // get the CLR version 
            row.clrVersion = RuntimeEnvironment.GetSystemVersion();

            // get some info about the executing assembly
            row.executingAssemblyName = Assembly.GetExecutingAssembly().FullName;

            // add the version information for the assembly
            FileVersionInfo executingVersion = FileVersionInfo.GetVersionInfo(Assembly.GetExecutingAssembly().Location);
            row.versionFileName = executingVersion.FileName;
            row.versionFileDescription = executingVersion.FileDescription;
            row.versionFileVersion = executingVersion.FileVersion;
            row.versionProductName = executingVersion.ProductName;
            row.versionProductVersion = executingVersion.ProductVersion;
            row.versionCompanyName = executingVersion.CompanyName;
            row.versionComments = executingVersion.Comments;
            row.versionInternalName = executingVersion.InternalName;
            row.versionIsDebug = executingVersion.IsDebug;
            row.versionIsPatched = executingVersion.IsPatched;
            row.versionLanguage = executingVersion.Language;
            row.versionLegalCopyright = executingVersion.LegalCopyright;
            row.versionLegalTrademarks = executingVersion.LegalTrademarks;

            // add the row
            _logDS.DiagnosticInfo.Rows.Add(row);

            return row;
        }
    }
}
