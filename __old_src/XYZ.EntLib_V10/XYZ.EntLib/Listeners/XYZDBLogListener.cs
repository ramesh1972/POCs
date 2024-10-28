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
using Microsoft.Practices.EnterpriseLibrary.Logging.Database;
using Microsoft.Practices.EnterpriseLibrary.Logging.Formatters;
using Microsoft.Practices.EnterpriseLibrary.Security.Cryptography;
using Microsoft.Practices.EnterpriseLibrary.Data;


using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    [ConfigurationElementType(typeof(CustomTraceListenerData))]
    class XYZDBLogListener : CustomTraceListener
    {
        public XYZDBLogListener()
        {
        }

        public override void TraceData(TraceEventCache eventCache, string source, TraceEventType eventType, int id, object data)
        {
            if (data is LogEntry && this.Formatter != null && this.Formatter is XYZLogXmlFormatter)
            {
                LogInfo inf = new LogInfo();
                inf.SetLogMessage(data as LogEntry);
                inf._logDS.SaveLog("XYZ_EntLib_DB_ConnectionString");

            }           
        }

        public override void Write(string message)
        {
        }

        public override void WriteLine(string message)
        {
        }
    }
}
