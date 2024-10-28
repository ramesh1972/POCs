using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    public class ExceptionInfo : BaseInfo
    {
        protected XYZ_EntLib_DB_DS.ExceptionRow _exceptionRow = null;
        protected Exception _exp = null;

        public ExceptionInfo(XYZ_EntLib_DB_DS logDS, Guid log_id, Exception exceptionToRead) : base(logDS, log_id)
        {
            // make sure we have a valid exception
            if (exceptionToRead == null)
                throw new ArgumentNullException("exceptionToRead");

            // set the exception
            _exp = exceptionToRead;

            // create a new row in the dataset
            _exceptionRow = _logDS.Exception.NewExceptionRow();

            // assign the exception id
            _exceptionRow.id = Guid.NewGuid();
            _exceptionRow.logEntryId = _logEntryId;

            // write the base exception based information
            _exceptionRow.description = string.Format("An exception of type '{0}' occurred and was caught.",
                                    _exp.GetType().FullName);

            _exceptionRow.dateTime = DateTime.UtcNow.ToLocalTime();
            _exceptionRow.exceptionType = _exp.GetType().AssemblyQualifiedName;
            _exceptionRow.exceptionMessage = _exp.Message;
            _exceptionRow.source = _exp.Source;
            _exceptionRow.helpLink = _exp.HelpLink;
            _exceptionRow.stackTrace = _exp.StackTrace;

            // set exception data
            _exceptionRow.exceptionDataId = Guid.NewGuid();
            SetExceptionDataInfo();

            // Write any inner exceptions
            SetInnerExceptionInfo(_exceptionRow.id, exceptionToRead.InnerException);

            // set target site
            ReflectionInfo reflinfo = new ReflectionInfo(_logDS, _logEntryId);
            reflinfo.SetReflectionInfo(_exp);
            reflinfo.SetMethodInfo(_exp.TargetSite);

            // write generic info
            SystemInfo si = new SystemInfo(_logDS, _logEntryId);
            si.SetSystemInfo();

            // add the row
            _logDS.Exception.Rows.Add(_exceptionRow);
            _exceptionRow = null;
        }

        public void SetExceptionDataInfo()
        {
            System.Collections.IDictionary data = _exp.Data;
            Guid id = _exceptionRow.exceptionDataId;

            // write them all...
            foreach (DictionaryEntry entry in data)
            {
                // create a new row
                XYZ_EntLib_DB_DS.ExceptionDataRow row = _logDS.ExceptionData.NewExceptionDataRow();
                row.exceptionId = id;

                // add the key/value pair
                row.dataKey = entry.Key.ToString();
                row.dataValue = entry.Value.ToString();

                // add the row
                _logDS.ExceptionData.Rows.Add(row);
            }
        }

        public void SetInnerExceptionInfo(Guid parentId, Exception inner)
        {
            // make sure we have an inner exception
            if (inner != null)
            {
                // set up join table entry
                XYZ_EntLib_DB_DS.InnerExceptionsRow innerRow = _logDS.InnerExceptions.NewInnerExceptionsRow();
                innerRow.exceptionId = parentId;
                innerRow.innerExceptionId = Guid.NewGuid();

                // add to the join table
                _logDS.InnerExceptions.Rows.Add(innerRow);

                // set up exception entry for inner exception
                XYZ_EntLib_DB_DS.ExceptionRow row = _logDS.Exception.NewExceptionRow();
                row.id = innerRow.innerExceptionId;
                row.exceptionType = inner.GetType().AssemblyQualifiedName;
                row.source = inner.Source;
                row.helpLink = inner.HelpLink;
                row.exceptionDataId = Guid.Empty;
                row.stackTrace = inner.StackTrace;

                // recurse for other inner exceptions
                SetInnerExceptionInfo(row.id, inner.InnerException);

                // add exception definition
                _logDS.Exception.Rows.Add(row);
            }
        }
    }
}
