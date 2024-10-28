using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Xml;
using System.IO;
using System.Diagnostics;
using System.Net.NetworkInformation;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.ExtraInformation;

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    [ConfigurationElementType(typeof(CustomHandlerData))]
    public class XYZExceptionHandler : IExceptionHandler
    {
        private static int _eventId = 0;
        private object _syncEventId = new object();

        public XYZExceptionHandler(NameValueCollection ignore)
        {
        }

        private int GetNextEventId()
        {
            lock (_syncEventId)
            {
                return _eventId++;
            }
        }

        public Exception HandleException(Exception exception, Guid handlingInstanceId)
        {
            // Use the handling instance Id for the Issue Tag for this error
            Guid issueTag = handlingInstanceId;

            string xmlExceptionData = "";

            // create a memory stream to hold the resulting xml
            using (MemoryStream memStream = new MemoryStream())
            {
                // set up a new dataset
                XYZ_EntLib_DB_DS _logDS = LogInfo.PrepareDS();

                // Write the exception to the dataset
                Guid logG = ((XYZ_EntLib_DB_DS.LogEntryRow)(_logDS.LogEntry.Rows[0])).id;
                ExceptionInfo einf = new ExceptionInfo(_logDS, logG, exception);

                // write out the XML for the dataset to the stream
                _logDS.WriteXml(memStream);

                // get the encoded stream as a string
                xmlExceptionData = Encoding.UTF8.GetString(memStream.ToArray());
            }

            // set up a dictionary for extended information
            Dictionary<string, object> dictionary = new Dictionary<string, object>();

            // get the managed security context information for the exception
            ManagedSecurityContextInformationProvider mgdInfoProvider =
              new ManagedSecurityContextInformationProvider();
            mgdInfoProvider.PopulateDictionary(dictionary);

            // get the unmanaged security context information for the exception
            UnmanagedSecurityContextInformationProvider unmgdInfoProvider =
                new UnmanagedSecurityContextInformationProvider();
            unmgdInfoProvider.PopulateDictionary(dictionary);

            // get the com plus information for the exception
            ComPlusInformationProvider complusInfoProvider =
                new ComPlusInformationProvider();
                complusInfoProvider.PopulateDictionary(dictionary);

            // now log the exception
            LogEntry logEntry = new LogEntry();
            logEntry.EventId = GetNextEventId();

            // Set the Severity to Critical so that our logging handler picks it up
            logEntry.Severity = TraceEventType.Critical;
            logEntry.Priority = 2;
            logEntry.Message = xmlExceptionData;
            
            // Add the Critical Error Reporting Framework category
            logEntry.Categories.Add("Critical");

            // add in the additional information from the providers
            logEntry.ExtendedProperties = dictionary;

            // add the issue tag to the extended properties of the log entry
            logEntry.ExtendedProperties.Add("IssueTag", issueTag);

            // get the MAC address to use as the site code
            NetworkInterface[] interfaces = NetworkInterface.GetAllNetworkInterfaces();
            if (interfaces.Length > 0)
            {
                //use the first one as the site code
                string macAddress = interfaces[0].GetPhysicalAddress().ToString();
                logEntry.ExtendedProperties.Add("SiteCode", macAddress);
            }

            // write to the reporting service
            Logger.Write(logEntry);

            // just return the initial exception
            return exception;
        }
    }
}
