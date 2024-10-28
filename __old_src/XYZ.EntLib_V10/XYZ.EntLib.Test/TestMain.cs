using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace XYZ.EntLib.Test
{
    public partial class TestMain : Form
    {
        public TestMain()
        {
            InitializeComponent();
        }

        private void button_log_Click(object sender, EventArgs e)
        {
            XYZ.Common.Logger.Log(textBox_logMsg.Text);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                int x = 0;
                int y = 1 / x;
            }
            catch (Exception exp)
            {
                XYZ.Common.ExceptionHandler.HandleException(exp, "Arithmetic Exception Policy");
            }
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogProcessInfo();
        }

        private void linkLabel7_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogAssemblyInfo();
        }

        private void linkLabel4_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogEnvironmentInfo();
        }

        private void linkLabel2_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogStartInfo();
        }

        private void linkLabel5_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogHostInfo();
        }

        private void linkLabel6_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogSystemInfo();
        }

        private void linkLabel3_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            XYZ.Common.Logger.LogReflectionInfo(this);
        }
    }
}