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

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    [ConfigurationElementType(typeof(CustomTraceListenerData))]
    class XYZWebServiceLogListener : CustomTraceListener
    {
        public override void Write(string message)
        {
        }

        public override void WriteLine(string message)
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
