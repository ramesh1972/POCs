using System;
using System.Collections;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using System.Resources;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Reflection;
using System.Security.Permissions;

using XYZ.EntLib.DataLayer;

using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging.Formatters;

namespace XYZ.EntLib.AppBlocks
{
    [ConfigurationElementType(typeof(CustomFormatterData))]
    public class XYZLogXmlFormatter : LogFormatter
    {
        public XYZLogXmlFormatter(NameValueCollection ignored)
        {
        }

        public override string Format(LogEntry log)
        {
            LogInfo inf = new LogInfo();
            inf.SetLogMessage(log);

            return inf.GetDSXml();
        }
    }
}
