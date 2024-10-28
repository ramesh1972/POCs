using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;

using Microsoft.Practices.EnterpriseLibrary.Logging;

using XYZ.EntLib.DataLayer;
using XYZ.EntLib.AppBlocks;

namespace XYZ.Common
{
    public class Logger
    {
        public static void Log(string msg, string category, int priority, int eventId, System.Diagnostics.TraceEventType severity)
        {
            Microsoft.Practices.EnterpriseLibrary.Logging.Logger.Write(msg,category, priority, eventId, severity);
        }

        public static void Log(string msg)
        {
            Microsoft.Practices.EnterpriseLibrary.Logging.Logger.Write(msg);
        }

        public static void LogSystemInfo()
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            SystemInfo g = new SystemInfo();
            g.SetSystemInfo();
            Logger.Log(g.GetDSXml());
        }

        public static void LogEnvironmentInfo()
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            SystemInfo g = new SystemInfo();
            g.SetEnvironmentVariablesInfo(Environment.GetEnvironmentVariables());
            Logger.Log(g.GetDSXml());
        }

        public static void LogAssemblyInfo()
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            AssemblyInfo g = new AssemblyInfo(ds);
            g.SetAssemblyInfo();
            Logger.Log(g.GetDSXml());
        }

        public static void LogProcessInfo()
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            ProcessInfo g = new ProcessInfo(ds);
            g.SetProcessInfo();
            Logger.Log(g.GetDSXml());
        }
        
        public static void LogStartInfo()
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            ProcessInfo g = new ProcessInfo();
            g.SetStartInfo();
            Logger.Log(g.GetDSXml());
        }

        public static void LogHostInfo()
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            SystemInfo g = new SystemInfo();
            g.SetHostEnvironmentInfo();
            Logger.Log(g.GetDSXml());
        }

        public static void LogReflectionInfo(Object toRead)
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            ReflectionInfo g = new ReflectionInfo();
            g.SetReflectionInfo(toRead);
            Logger.Log(g.GetDSXml());
        }

        public static void LogReflectionMethodInfo(MethodBase method)
        {
            XYZ_EntLib_DB_DS ds = LogInfo.PrepareDS();
            ReflectionInfo g = new ReflectionInfo();
            g.SetMethodInfo(method);
            Logger.Log(g.GetDSXml());
        }

        // events to hook up.
        public static void Application_ApplicationExit(object sender, EventArgs e)
        {
            Logger.Log("Application:" + System.Diagnostics.Process.GetCurrentProcess().ProcessName + " has exited.");

            LogSystemInfo();
        }

        public static void Application_ThreadExit(object sender, EventArgs e)
        {
            Logger.Log("Thread:" + System.Threading.Thread.CurrentThread.ManagedThreadId + " has exited.");
        }
    }
}
