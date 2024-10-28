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

namespace XYZ.EntLib.AppBlocks
{
    [ConfigurationElementType(typeof(CustomTraceListenerData))]
    class XYZConsoleLogListener : CustomTraceListener
    {
        public override void Write(string message)
        {
            throw new Exception("The method or operation is not implemented.");
        }

        public override void WriteLine(string message)
        {
            throw new Exception("The method or operation is not implemented.");
        }    
    }
}
