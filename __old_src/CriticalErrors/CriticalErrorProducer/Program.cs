using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Diagnostics;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace CriticalErrorProducer
{
    static class Program
    {
        static private string _reportingPolicy = "Critical Errors Reporting Policy";
        // declare generic delegate
        public delegate void ExceptionReportedDelegate();
        static public event ExceptionReportedDelegate ExceptionReported;

        static private MainForm _mainForm = null;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            // hook up the WinForms thread exception handler
            Application.ThreadException += Application_ThreadException;
            // hook up the AppDomain unhandled exception handler
            AppDomain.CurrentDomain.UnhandledException += CurrentDomain_UnhandledException;
            _mainForm = new MainForm();
            // run the application
            Application.Run(_mainForm);

        }

        static void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            HandleException((Exception)e.ExceptionObject);
        }

        static void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs e)
        {
            HandleException(e.Exception);
        }

        static void HandleException(Exception ex)
        {
            try
            {
                _mainForm.Cursor = Cursors.WaitCursor;
                try
                {
                    // Tell the EntLib to handle the exception based on configuration
                    ExceptionPolicy.HandleException(ex, _reportingPolicy);
                }
                catch (Exception e)
                {
                    MessageBox.Show("Error reporting exception: " + e.ToString());
                }
                // This is just to get the UI refreshed...
                System.Threading.Thread.Sleep(5000);
            }
            finally
            {
                _mainForm.Cursor = Cursors.Default;
            }
            if(ExceptionReported!=null)
                ExceptionReported();
        }
    }
}