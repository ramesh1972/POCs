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
    class XYZLogHtmlFormatter : LogFormatter
    {
        private string html = "";
        public XYZLogHtmlFormatter(NameValueCollection ignored)
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

            //html = inf.GetAllHtml();
            GetHtml(doc.DocumentElement);
            return html;
        }

        private void GetHtml(XmlNode node)
        {
            if (node.NodeType == XmlNodeType.Element)
            {
                if (node.ChildNodes.Count == 1 && 
                   (node.FirstChild.NodeType == XmlNodeType.Text  || node.FirstChild.NodeType == XmlNodeType.SignificantWhitespace))
                {
                    html += "<tr><td><b>";
                    html += node.Name + "</b></td>";
                    html += "<td>";

                    string val = node.InnerText;

                    if (val == null || val.Trim() == "")
                        val = "not set";

                    html += val;
                    html += "</td></tr>";
                }
                else if (node.ChildNodes.Count > 0)
                {
                    html += "<table border=1>";
                    html += "<tr><td colspan=2 style='font-size:large'><b>" + node.Name + "</b></td></tr>";

                    foreach (XmlNode cnode in node.ChildNodes)
                        GetHtml(cnode);

                    html += "</table>";
                }
            }
        }
    }
}
