using System;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Security.Permissions;

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    public class ReflectionInfo : BaseInfo
    {
        public ReflectionInfo(XYZ_EntLib_DB_DS logDS, Guid log_id) : base(logDS, log_id)
        {
        }

        public ReflectionInfo()
        {
        }

        public void SetReflectionInfo(Object toRead)
        {
            if (toRead == null)
                return;

            // get the exception type
            Type type = toRead.GetType();

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
                if (property.CanRead)
                {
                    value = property.GetValue(toRead, null);
                    SetPropertyInfo(property, value);
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
                value = field.GetValue(toRead);
                SetFieldInfo(field, value);
            }
        }

        public void SetPropertyInfo(PropertyInfo propertyInfo, object value)
        {
            // make a new row 
            XYZ_EntLib_DB_DS.ReflectionPropertiesRow row = _logDS.ReflectionProperties.NewReflectionPropertiesRow();

            // add the data
            row.logEntryId = _logEntryId;
            row.propertyName = propertyInfo.Name;
            if (value != null)
            {
                if (value.ToString().Length > 255)
                    row.propertyValue = value.ToString().Substring(0, 255);
                else
                    row.propertyValue = value.ToString();
            }

            // add the row
            _logDS.ReflectionProperties.Rows.Add(row);
        }

        public void SetFieldInfo(FieldInfo fieldInfo, object value)
        {
            // make a new row
            XYZ_EntLib_DB_DS.ReflectionFieldsRow row = _logDS.ReflectionFields.NewReflectionFieldsRow();

            // add the data
            row.logEntryId = _logEntryId;
            row.fieldName = fieldInfo.Name;
            if (value != null)
            {
                if (value.ToString().Length > 255)
                    row.fieldValue = value.ToString().Substring(0, 255);
                else
                    row.fieldValue = value.ToString();
            }
            // add the row
            _logDS.ReflectionFields.Rows.Add(row);
        }

        public void SetMethodInfo(MethodBase method)
        {
            // make sure we have a target site
            if (method != null)
            {
                // create the new row in the dataset
                XYZ_EntLib_DB_DS.ReflectionTargetSiteRow row = _logDS.ReflectionTargetSite.NewReflectionTargetSiteRow();
                row.logEntryId = _logEntryId;

                // assign values
                row.name = method.Name;
                row.callingConvention = method.CallingConvention.ToString();
                row.declaringType = method.DeclaringType.ToString();
                row.memberType = method.MemberType.ToString();
                row.token = "0x" + method.MetadataToken.ToString("X");
                row.declaringModule = method.Module.FullyQualifiedName;

                // Identify if there are generic arguments and write them out as well
                SetGenericArgumentsInfo(method);

                // add the row
                _logDS.ReflectionTargetSite.Rows.Add(row);
            }
        }

        public void SetGenericArgumentsInfo(MethodBase method)
        {
            Type[] genericArguments = method.GetGenericArguments();

            // check if we have any
            if (genericArguments.Length > 0)
            {
                // write each one out as a row
                foreach (Type t in genericArguments)
                {
                    // create the row
                    XYZ_EntLib_DB_DS.ReflectionGenericArgumentsRow row = _logDS.ReflectionGenericArguments.NewReflectionGenericArgumentsRow();
                    row.logEntryId = _logEntryId;
                    row.type = t.ToString();

                    // add the row
                    _logDS.ReflectionGenericArguments.Rows.Add(row);
                }
            }
        }
    }
}
