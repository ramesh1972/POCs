using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using XYZ.EntLib.AppBlocks;
using XYZ.EntLib.DataLayer;

namespace XYZ.Common
{
    public class ExceptionHandler
    {
        public static void HandleException(Exception e, string policy)
        {
            ExceptionPolicy.HandleException(e, policy);
        }

        public static void HandleException(Exception e)
        {
            HandleException(e, "Global Policy");
        }

        // events that can be hooked up by an application
        public static void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs e)
        {
            HandleException(e.Exception, "Global Policy");
        }

        public static void AppDomain_UnHandledException(object sender, System.UnhandledExceptionEventArgs e)
        {
            HandleException((Exception) e.ExceptionObject, "Global Policy");
        }
    }
}
