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
    class XYZLogTextFormatter : LogFormatter
    {
        private string text = "";
        private short indent = 0;
        public XYZLogTextFormatter(NameValueCollection ignored)
        {
        }

        public override string Format(LogEntry log)
        {
            // get the xml
            LogInfo inf = new LogInfo();
            inf.SetLogMessage(log);

            string xml = inf.GetDSXml();
            if (xml == "")
                return "";

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xml);

            text = "";
            GetText(doc.DocumentElement);
            return text;
        }

        private void GetText(XmlNode node)
        {
            string indent_s = "";
            for (int idx=0;idx<indent;idx++) 
                indent_s+= "\t";

            if (node.NodeType == XmlNodeType.Element)
            {
                if (node.ChildNodes.Count == 1 && node.FirstChild.NodeType == XmlNodeType.Text)
                {
                    text += indent_s;
                    text += node.Name + " = ";
                    text += node.FirstChild.Value;
                    text += Environment.NewLine;
                }
                else
                {
                    text += indent_s;
                    text += node.Name;
                    text += Environment.NewLine;
                    indent++;
                    foreach (XmlNode cnode in node.ChildNodes)
                        GetText(cnode);
                    indent--;
                }
            }
            else if (node.NodeType == XmlNodeType.EndElement)
                indent--;

        }
    }
}
