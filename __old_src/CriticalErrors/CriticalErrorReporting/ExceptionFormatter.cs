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
using CriticalErrorReporting.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace CriticalErrorReporting.ExceptionHandling
{
    /// <summary>
    /// The Exception Formatter for the Critical Error Reporting Framework
    /// 
    /// The exception is formatted into a DataSet and then the xml is extracted from
    /// the dataset to be passed as the message of the LogEntry
    /// </summary>
    public class CriticalErrorExceptionFormatter : ExceptionFormatter
    {
        /// <summary>
        /// The Critical Error Reporting Framework DataSet
        /// </summary>
        private CriticalErrorDS _errorDS = null;
        /// <summary>
        /// A memory stream to write the dataset to
        /// </summary>
        private MemoryStream _memStream = null;
        /// <summary>
        /// The row being created in the Exception table of the DataSet
        /// </summary>
        private CriticalErrorDS.ExceptionRow _exceptionRow = null;
        /// <summary>
        /// The list of Properties to ignore during the recording of exception
        /// information via reflection
        /// </summary>
        private static readonly ArrayList IgnoredProperties = new ArrayList(
            new string[] { "Source", "Message", "HelpLink", "InnerException", "StackTrace", "TargetSite", "Data" });

        /// <summary>
        /// The construcutor for the formatter
        /// </summary>
        /// <param name="memStream">The memory stream to format the exception to</param>
        /// <param name="exception">The exception to be formatted</param>
        public CriticalErrorExceptionFormatter(MemoryStream memStream, Exception exception)
            : base(exception)
        {
            if (memStream == null)
                throw new ArgumentNullException("memStream", "Parameter 'memStream' cannot be null.  Please provide an instantiated MemoryStream instance.");
            
            if (exception == null)
                throw new ArgumentNullException("exception", "Parameter 'exception' cannot be null.  Please provide an exception to format.");

            _memStream = memStream;
        }

        /// <summary>
        /// Formats the exception into the dataset and then writes it to the memory stream
        /// </summary>
        public override void Format()
        {
            try
            {
                // set up a new dataset
                _errorDS = new CriticalErrorDS();
                // Write the exception to the dataset
                WriteException(base.Exception, Guid.NewGuid());
                // write out the XML for the dataset to the stream
                _errorDS.WriteXml(_memStream);
            }
            catch (Exception e)
            {
                Debug.WriteLine("Formatting Exception threw exception: " + e);
                throw e;
            }
        }

        #region Write to Exception DataRow methods
        /// <summary>
        /// Write the description of the exception
        /// </summary>
        protected override void WriteDescription()
        {
            if(_exceptionRow != null)
                _exceptionRow.description = string.Format("An exception of type '{0}' occurred and was caught.", base.Exception.GetType().FullName);
        }

        /// <summary>
        /// Write the datetime the exception occurred
        /// </summary>
        /// <param name="utcNow">the universal date time datetime when the exception occurred</param>
        protected override void WriteDateTime(DateTime utcNow)
        {
            if(_exceptionRow != null)
                _exceptionRow.dateTime = utcNow.ToLocalTime();
        }

        /// <summary>
        /// Write the type of the exception
        /// </summary>
        /// <param name="exceptionType">the type of the exception</param>
        protected override void WriteExceptionType(Type exceptionType)
        {
            if (_exceptionRow != null)
                _exceptionRow.exceptionType = exceptionType.AssemblyQualifiedName;
        }

        /// <summary>
        /// Write the message for the exception
        /// </summary>
        /// <param name="message">the message for the exception</param>
        protected override void WriteMessage(string message)
        {
            if (_exceptionRow != null)
                _exceptionRow.exceptionMessage = message;
        }

        /// <summary>
        /// Write the source for the exception
        /// </summary>
        /// <param name="source">the source of the exception</param>
        protected override void WriteSource(string source)
        {
            if (_exceptionRow != null)
                _exceptionRow.source = source;
        }

        /// <summary>
        /// Write the help link for the exception
        /// </summary>
        /// <param name="helpLink">the help link for the exception</param>
        protected override void WriteHelpLink(string helpLink)
        {
            if (_exceptionRow != null)
                _exceptionRow.helpLink = helpLink;
        }

        /// <summary>
        /// Write the stack trace for the exception
        /// </summary>
        /// <param name="stackTrace">the stack trace for the exception</param>
        protected override void WriteStackTrace(string stackTrace)
        {
            if (_exceptionRow != null)
                _exceptionRow.stackTrace = stackTrace;
        }

        /// <summary>
        /// Write the Exception and all of the nested pieces inside of it as well
        /// as additional information to help in debugging / diagnostics
        /// </summary>
        /// <param name="exceptionToFormat">the exception to write</param>
        /// <param name="id">the GUID identifier for the exception</param>
        protected void WriteException(Exception exceptionToFormat, Guid id)
        {
            // make sure we have a valid exception
            if (exceptionToFormat == null) throw new ArgumentNullException("exceptionToFormat");

            // create a new row in the dataset
            _exceptionRow = _errorDS.Exception.NewExceptionRow();
            // assign the exception id
            _exceptionRow.id = id;

            // write the base exception based information
            WriteDescription();
            WriteDateTime(DateTime.UtcNow);
            WriteExceptionType(exceptionToFormat.GetType());
            WriteMessage(exceptionToFormat.Message);
            WriteSource(exceptionToFormat.Source);
            WriteHelpLink(exceptionToFormat.HelpLink);
            _exceptionRow.exceptionDataId = Guid.NewGuid();
            this.WriteData(exceptionToFormat.Data, _exceptionRow.exceptionDataId);
            _exceptionRow.targetSiteId = Guid.NewGuid();
            this.WriteTargetSite(exceptionToFormat.TargetSite, _exceptionRow.targetSiteId);
            WriteStackTrace(exceptionToFormat.StackTrace);

            // write additional environmental information
            _exceptionRow.additionalInfoId = Guid.NewGuid();
            this.WriteAdditionalInfo(this.AdditionalInfo, _exceptionRow.additionalInfoId);

            // write additional diagnostic information
            _exceptionRow.diagnosticInfoId = Guid.NewGuid();
            this.WriteDiagnosticInfo(_exceptionRow.diagnosticInfoId);

            // write the derived exception property and field values via reflection
            _exceptionRow.propertiesId = Guid.NewGuid();
            _exceptionRow.fieldsId = Guid.NewGuid();
            this.WriteReflectionInfo(exceptionToFormat,_exceptionRow.propertiesId, _exceptionRow.fieldsId);

            // Write any inner exceptions
            WriteInnerException(id, exceptionToFormat.InnerException);

            // add the row
            _errorDS.Exception.Rows.Add(_exceptionRow);
            _exceptionRow = null;
        }

        /// <summary>
        /// Write an inner exception.  This is called recursively to write all of the inner exceptions.
        /// </summary>
        /// <param name="parentId">the parent exception id</param>
        /// <param name="inner">the inner exception to write</param>
        protected void WriteInnerException(Guid parentId, Exception inner)
        {
            // make sure we have an inner exception
            if (inner != null)
            {
                // set up join table entry
                CriticalErrorDS.InnerExceptionsRow innerRow = _errorDS.InnerExceptions.NewInnerExceptionsRow();
                innerRow.exceptionId = parentId;
                innerRow.innerExceptionId = Guid.NewGuid();
                // add to the join table
                _errorDS.InnerExceptions.Rows.Add(innerRow);

                // set up exception entry for inner exception
                CriticalErrorDS.ExceptionRow row = _errorDS.Exception.NewExceptionRow();
                row.id = innerRow.innerExceptionId;
                row.exceptionType = inner.GetType().AssemblyQualifiedName;
                row.source = inner.Source;
                row.helpLink = inner.HelpLink;
                row.exceptionDataId = Guid.Empty;
                row.targetSiteId = Guid.Empty;
                row.stackTrace = inner.StackTrace;
                row.additionalInfoId = Guid.Empty;
                row.diagnosticInfoId = Guid.Empty;
                // recurse for other inner exceptions
                WriteInnerException(row.id, inner.InnerException);

                // add exception definition
                _errorDS.Exception.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write the Target Site information for the exception
        /// </summary>
        /// <param name="targetSite">the Target Site information for the exception</param>
        /// <param name="id">the id for the target site</param>
        protected void WriteTargetSite(MethodBase targetSite, Guid id)
        {
            // make sure we have a target site
            if (targetSite != null)
            {
                // create the new row in the dataset
                CriticalErrorDS.TargetSiteRow row = _errorDS.TargetSite.NewTargetSiteRow();
                // assign values
                row.id = id;
                row.name = targetSite.Name;
                row.callingConvention = targetSite.CallingConvention.ToString();
                row.declaringType = targetSite.DeclaringType.ToString();
                row.memberType = targetSite.MemberType.ToString();
                row.token = "0x" + targetSite.MetadataToken.ToString("X");
                row.declaringModule = targetSite.Module.FullyQualifiedName;
                // Identify if there are generic arguments and write them out as well
                Type[] genericArguments = targetSite.GetGenericArguments();
                row.genericArgumentsId = Guid.NewGuid();
                WriteGenericArguments(genericArguments, row.genericArgumentsId);
                // add the row
                _errorDS.TargetSite.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write the generic arguments for the TargetSite
        /// </summary>
        /// <param name="genericArguments">the generic arguments</param>
        /// <param name="id">the id for the generic arguments</param>
        protected void WriteGenericArguments(Type[] genericArguments, Guid id)
        {
            // check if we have any
            if (genericArguments.Length > 0)
            {
                // write each one out as a row
                foreach (Type t in genericArguments)
                {
                    // create the row
                    CriticalErrorDS.GenericArgumentsRow row = _errorDS.GenericArguments.NewGenericArgumentsRow();
                    row.id = id;
                    row.type = t.ToString();
                    // add the row
                    _errorDS.GenericArguments.Rows.Add(row);
                }
            }
        }

        /// <summary>
        /// Write out the additional information
        /// </summary>
        /// <param name="additionalInformation">the additional information to write out</param>
        protected override void WriteAdditionalInfo(NameValueCollection additionalInformation)
        {
            WriteAdditionalInfo(additionalInformation, Guid.NewGuid());
        }

        /// <summary>
        /// The additional information override that takes the Id and does the work
        /// </summary>
        /// <param name="additionalInformation">the additional info to write</param>
        /// <param name="id">the id of the additional info</param>
        private void WriteAdditionalInfo(NameValueCollection additionalInformation, Guid id)
        {
            // write a row per value
            foreach (string name in additionalInformation.AllKeys)
            {
                // create the row
                CriticalErrorDS.AdditionalInfoRow row = _errorDS.AdditionalInfo.NewAdditionalInfoRow();
                // set values
                row.id = id;
                row.name = name;
                row.value = additionalInformation[name];
                // add the row
                _errorDS.AdditionalInfo.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write out the diagnostic information
        /// </summary>
        /// <param name="id">the id for the diagnostic information</param>
        protected void WriteDiagnosticInfo(Guid id)
        {
            // Create the row for the diagnostic info
            CriticalErrorDS.DiagnosticInfoRow row = _errorDS.DiagnosticInfo.NewDiagnosticInfoRow();
            row.id = id;

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
            // Add information about the process
            row.processInfoId = Guid.NewGuid();
            WriteProcessInfo(row.processInfoId);
            // Add host environment information
            row.hostEnvironmentId = Guid.NewGuid();
            WriteHostEnvironment(row.hostEnvironmentId);
            // add the row
            _errorDS.DiagnosticInfo.Rows.Add(row);
        }

        /// <summary>
        /// Write the process specific information that the exception occurred in
        /// </summary>
        /// <param name="id">the id for the process information</param>
        protected void WriteProcessInfo(Guid id)
        {
            // Make a new row
            CriticalErrorDS.ProcessInfoRow row = _errorDS.ProcessInfo.NewProcessInfoRow();
            row.id = id;

            // get some process information
            Process currentProcess = Process.GetCurrentProcess();

            // add the process data
            row.startTime = currentProcess.StartTime;
            row.processId = currentProcess.Id;
            row.terminalServicesSessionId =  currentProcess.SessionId;
            row.nonPagedSystemMemorySize = currentProcess.NonpagedSystemMemorySize64;
            row.pagedMemorySize = currentProcess.PagedMemorySize64;
            row.pagedSystemMemory = currentProcess.PagedSystemMemorySize64;
            row.peakPagedMemorySize = currentProcess.PeakPagedMemorySize64;
            row.peakVirtualMemorySize = currentProcess.PeakVirtualMemorySize64;
            row.peakWorkingSet = currentProcess.PeakWorkingSet64;
            row.privateMemorySize = currentProcess.PrivateMemorySize64;
            row.virtualMemorySize = currentProcess.VirtualMemorySize64;
            row.workingSet = currentProcess.WorkingSet64;
            row.totalProcessorTimeDays =  currentProcess.TotalProcessorTime.Days;
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
            // Write the StartInfo data for the Process
            row.startInfoId = Guid.NewGuid();
            WriteStartInfo(currentProcess, row.startInfoId);
            // Write out the Process Environment Block
            row.processEnvironmentId = Guid.NewGuid();
            WriteEnvironmentVariables(Environment.GetEnvironmentVariables(),row.processEnvironmentId);
            // Add the row
            _errorDS.ProcessInfo.Rows.Add(row);
        }

        /// <summary>
        /// Write out environment variables for the process
        /// </summary>
        /// <param name="variables">the environment variable set</param>
        /// <param name="id">the id for the set</param>
        protected void WriteEnvironmentVariables(IDictionary variables, Guid id)
        {
            // write each variable out
            foreach (DictionaryEntry entry in variables)
            {
                // make a row
                CriticalErrorDS.EnvironmentVariablesRow row = _errorDS.EnvironmentVariables.NewEnvironmentVariablesRow();
                // add the name/value
                row.id = id;
                row.variableName = entry.Key.ToString();
                row.variableValue = entry.Value.ToString();
                // add the row
                _errorDS.EnvironmentVariables.Rows.Add(row);
            }
        }

        /// <summary>
        /// Add the StartInfo for the given process the exception occurred in
        /// </summary>
        /// <param name="currentProcess">The process to get the StartInfo for</param>
        /// <param name="id">the id for the StartInfo</param>
        protected void WriteStartInfo(Process currentProcess, Guid id)
        {
            // make the row
            CriticalErrorDS.StartInfoRow row = _errorDS.StartInfo.NewStartInfoRow();
            row.id = id;

            // Get the ProcessStartInfo
            ProcessStartInfo startInfo = currentProcess.StartInfo;
            // add the values
            row.fileName = startInfo.FileName;
            row.arguments = startInfo.Arguments;
            row.domain = startInfo.Domain;
            row.verb = startInfo.Verb;
            row.useShellExecute = startInfo.UseShellExecute;
            row.workingDirectory = startInfo.WorkingDirectory;
            // write the environment block
            row.startInfoEnvironmentId = Guid.NewGuid();
            WriteEnvironmentVariables(startInfo.EnvironmentVariables,row.startInfoEnvironmentId);
            // write the verbs
            row.verbsId = Guid.NewGuid();
            WriteVerbs(startInfo.Verbs,row.verbsId);
            // add the row
            _errorDS.StartInfo.Rows.Add(row);
        }

        /// <summary>
        /// Write out environment variables for the start info
        /// </summary>
        /// <param name="variables">the environment variable set</param>
        /// <param name="id">the id for the set</param>
        protected void WriteEnvironmentVariables(StringDictionary variables, Guid id)
        {
            // write each one
            foreach (DictionaryEntry entry in variables)
            {
                // make a new row
                CriticalErrorDS.EnvironmentVariablesRow row = _errorDS.EnvironmentVariables.NewEnvironmentVariablesRow();
                // add the values
                row.id = id;
                row.variableName = entry.Key.ToString();
                row.variableValue = entry.Value.ToString();
                // add the row
                _errorDS.EnvironmentVariables.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write out the StartInfo verbs
        /// </summary>
        /// <param name="verbs">the set of verbs</param>
        /// <param name="id">the verbs set id</param>
        protected void WriteVerbs(string[] verbs, Guid id)
        {
            // write each one
            foreach (string verb in verbs)
            {
                // create the row
                CriticalErrorDS.VerbsRow row = _errorDS.Verbs.NewVerbsRow();
                // write the value
                row.id = id;
                row.verb = verb;
                // add the row
                _errorDS.Verbs.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write the host environment variables
        /// </summary>
        /// <param name="id">the id for the host environment</param>
        protected void WriteHostEnvironment(Guid id)
        {
            // create a new row
            CriticalErrorDS.HostEnvironmentRow row = _errorDS.HostEnvironment.NewHostEnvironmentRow();
            row.id = id;
            // write out the values
            row.osVersion = Environment.OSVersion.ToString();
            row.processorCount = Environment.ProcessorCount;
            row.currentDirectory = Environment.CurrentDirectory;
            // add the row
            _errorDS.HostEnvironment.Rows.Add(row);
        }

        /// <summary>
        /// Write out the exception data from the Data property
        /// </summary>
        /// <param name="data">the Data property dictionary of values</param>
        /// <param name="id">the identifier for the Data values</param>
        protected void WriteData(IDictionary data, Guid id)
        {
            // write them all...
            foreach (DictionaryEntry entry in data) 
            {
                // create a new row
                CriticalErrorDS.ExceptionDataRow row = _errorDS.ExceptionData.NewExceptionDataRow();
                row.id = id;
                // add the key/value pair
                row.dataKey = entry.Key.ToString();
                row.dataValue = entry.Value.ToString();
                // add the row
                _errorDS.ExceptionData.Rows.Add(row);
            }
        }

        /// <summary>
        /// Write out the properties and fields found via reflection that are not on the base exception type
        /// </summary>
        /// <param name="exceptionToFormat">the exception to examine</param>
        /// <param name="propertiesId">the properties identifier</param>
        /// <param name="fieldsId">the fields identifier</param>
        protected void WriteReflectionInfo(Exception exceptionToFormat, Guid propertiesId, Guid fieldsId)
        {
            if (exceptionToFormat == null) throw new ArgumentNullException("exceptionToFormat");

            // get the exception type
            Type type = exceptionToFormat.GetType();

            // Note that if this is used in an ASP.NET application, the ReflectionPermission 
            // will not be present so this will throw an exception
            ReflectionPermission reflPerm = new ReflectionPermission(PermissionState.Unrestricted);
            reflPerm.Demand();

            // Get all of the properties on the exception, public, private, static and instance
            PropertyInfo[] properties = 
                type.GetProperties(BindingFlags.Instance | 
                        BindingFlags.Public | 
                        BindingFlags.Static | 
                        BindingFlags.NonPublic);
            object value;

            // write out the property values
            foreach (PropertyInfo property in properties)
            {
                if (property.CanRead && IgnoredProperties.IndexOf(property.Name) == -1)
                {
                    value = property.GetValue(exceptionToFormat, null);
                    WritePropertyInfo(propertiesId, property, value);
                }
            }

            // Get all of the fields on the exception, public, private, static and instance
            FieldInfo[] fields =
                type.GetFields(BindingFlags.Instance |
                        BindingFlags.Public |
                        BindingFlags.Static |
                        BindingFlags.NonPublic);

            // write out the field values
            foreach (FieldInfo field in fields)
            {
                value = field.GetValue(exceptionToFormat);
                WriteFieldInfo(fieldsId, field, value);
            }
        }

        /// <summary>
        /// Empty implementation to satisfy the ExceptionFormatter demands
        /// </summary>
        /// <param name="propertyInfo">the property info to examine</param>
        /// <param name="value">the value for the property</param>
        protected override void WritePropertyInfo(PropertyInfo propertyInfo, object value)
        {
        }

        /// <summary>
        /// Write out the property and it's current value
        /// </summary>
        /// <param name="propertiesId">the property identifier</param>
        /// <param name="propertyInfo">the property info to examine</param>
        /// <param name="value">the value for the property</param>
        protected void WritePropertyInfo(Guid propertiesId, PropertyInfo propertyInfo, object value)
        {
            // make a new row
            CriticalErrorDS.ExceptionPropertiesRow row =
                _errorDS.ExceptionProperties.NewExceptionPropertiesRow();
            // add the data
            row.id = propertiesId;
            row.propertyName = propertyInfo.Name;
            if (value != null)
            {
                if (value.ToString().Length > 255)
                    row.propertyValue = value.ToString().Substring(0, 255);
                else
                    row.propertyValue = value.ToString();
            }
            // add the row
            _errorDS.ExceptionProperties.Rows.Add(row);
        }

        /// <summary>
        /// Empty implementation to satisfy the ExceptionFormatter demands
        /// </summary>
        /// <param name="fieldInfo">the fieldInfo to process</param>
        /// <param name="value">the value of the field</param>
        protected override void WriteFieldInfo(FieldInfo fieldInfo, object value)
        {
        }

        /// <summary>
        /// Write out the field and it's value
        /// </summary>
        /// <param name="fieldsId">the field identifier</param>
        /// <param name="fieldInfo">the fieldInfo to process</param>
        /// <param name="value">the value of the field</param>
        protected void WriteFieldInfo(Guid fieldsId, FieldInfo fieldInfo, object value)
        {
            // make a new row
            CriticalErrorDS.ExceptionFieldsRow row =
                _errorDS.ExceptionFields.NewExceptionFieldsRow();
            // add the data
            row.id = fieldsId;
            row.fieldName = fieldInfo.Name;
            if (value != null)
            {
                if (value.ToString().Length > 255)
                    row.fieldValue = value.ToString().Substring(0, 255);
                else
                    row.fieldValue = value.ToString();
            }
            // add the row
            _errorDS.ExceptionFields.Rows.Add(row);
        }
        #endregion // End Write to Exception DataRow methods
    }
}
