using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Security;
using System.Security.Permissions;
using System.Configuration;
using System.IO;
using System.Diagnostics;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging.Configuration;

namespace CriticalErrorProducer
{
    public partial class MainForm : Form
    {
        private string _issueLogPath;

        public MainForm()
        {
            InitializeComponent();
            DisableBack();
            DisableForward();
        }

        private void _btnObjectDisposed_Click(object sender, EventArgs e)
        {
            Exception inner = new Exception("BOOM!");
            ObjectDisposedException ode = new ObjectDisposedException("Fake Object", inner);
            string disposedObject = "I'm disposed!";
            ode.Data.Add("DisposedObject", disposedObject);
            throw ode;
        }

        private void _btnDivideByZero_Click(object sender, EventArgs e)
        {
            // set up for a Divide by zero exception
            int x = 10;
            int y = 0;
            int i = x / y;
        }

        private void Main_Load(object sender, EventArgs e)
        {
            _browser.DocumentText =
                "<html><body><h1>Press a button to cause a critical error to be reported.</h1></body></html>";
            _browser.CanGoBackChanged += _browser_CanGoBackChanged;
            _browser.CanGoForwardChanged += _browser_CanGoForwardChanged;
            // hook up for exception report
            Program.ExceptionReported += Program_ExceptionReported;

            LoggingSettings settings =
               ConfigurationManager.GetSection("loggingConfiguration") as LoggingSettings;
            // Loop through the list of trace listeners for the issue log path 
            // on the CriticalErrorTraceListener
            foreach (TraceListenerData data in settings.TraceListeners)
            {
                if (data.ListenerDataType == typeof(CustomTraceListenerData))
                {
                    CustomTraceListenerData customData = (CustomTraceListenerData)data;
                    _issueLogPath = customData.Attributes["issueLogPath"];
                    break;
                }
            }
        }

        void _browser_CanGoForwardChanged(object sender, EventArgs e)
        {
            if (_browser.CanGoForward)
                EnableForward();
            else
                DisableForward();
        }

        void _browser_CanGoBackChanged(object sender, EventArgs e)
        {
            if (_browser.CanGoBack)
                EnableBack();
            else
                DisableBack();
        }

        void Program_ExceptionReported()
        {
            if (this.InvokeRequired)
            {
                this.Invoke(new MethodInvoker(Program_ExceptionReported));
            }
            else
            {
                this.Cursor = Cursors.WaitCursor;
                // refresh the content
                Uri reportingSiteUrl = new Uri("http://localhost:2346/CriticalErrorReportingSite/Default.aspx");
                _browser.Navigate(reportingSiteUrl);
                this.Cursor = Cursors.Default;
            }
        }

        private void _btnBack_Click(object sender, EventArgs e)
        {
            _browser.GoBack();
            _browser.Refresh();
        }

        private void _btnForward_Click(object sender, EventArgs e)
        {
            _browser.GoForward();
            _browser.Refresh();
        }

        private void DisableBack()
        {
            _btnBack.Enabled = false;
            _btnBack.Image = global::CriticalErrorProducer.Properties.Resources.GreyBack;
        }

        private void DisableForward()
        {
            _btnForward.Enabled = false;
            _btnForward.Image = global::CriticalErrorProducer.Properties.Resources.GreyForward;
        }

        private void EnableBack()
        {
            _btnBack.Enabled = true;
            _btnBack.Image = global::CriticalErrorProducer.Properties.Resources.Back;
        }

        private void EnableForward()
        {
            _btnForward.Enabled = true;
            _btnForward.Image = global::CriticalErrorProducer.Properties.Resources.Forward;
        }

        private void _btnLocalLog_Click(object sender, EventArgs e)
        {
            // we don't have an issue log file path in the app.config
            // for the tracelistener
            if (_issueLogPath.Length == 0)
            {
                // see if they want to go find it...
                DialogResult yn = MessageBox.Show("The Local Log path is not set up in the configuration file.  Would you like to browse to the log?", "Critical Error Producer", MessageBoxButtons.YesNo);
                if (yn == DialogResult.Yes)
                {
                    DialogResult dr = _openFileDialog.ShowDialog();
                    if (dr == DialogResult.OK)
                    {
                        // got a new path to it, use that from now on...
                        _issueLogPath = _openFileDialog.FileName;
                    }
                }
                else
                {
                    // they don't want to look and we can't find it so bail
                    return;
                }
            }
            else // we have a path in the app config for the tracelistener
            {
                // File.Exists can't deal with quoted paths so trim
                // the quotes.
                if (!File.Exists(_issueLogPath.Trim(new char[] {'"'})))
                {
                    MessageBox.Show("Issue Log not found at " + _issueLogPath + ".  It will not be displayed.","Critical Error Producer",MessageBoxButtons.OK,MessageBoxIcon.Error);
                    // clear out isse log path to allow for looking again
                    _issueLogPath = "";
                }
                else
                {
                    // launch the xml file in the associated viewer
                    Process process = new Process();
                    process.StartInfo.FileName = _issueLogPath;
                    process.StartInfo.UseShellExecute = true;
                    process.Start();
                }
            }
        }
    }
}