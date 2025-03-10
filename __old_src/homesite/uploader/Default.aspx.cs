using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Telerik.WebControls;

namespace RVK
{
    public partial class Uploader : System.Web.UI.Page
    {
        
        protected Telerik.WebControls.RadProgressArea progressArea1;
        

        private void Page_Load(object sender, System.EventArgs e)
        {
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }
        
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        { 
            this.buttonSubmit.Click += new System.EventHandler(this.buttonSubmit_Click);
            this.Load += new System.EventHandler(this.Page_Load);

        }
        #endregion

        private void buttonSubmit_Click(object sender, System.EventArgs e)
        {
            BindResults();
        }

        private void BindResults()
        {
            if (Radupload1.UploadedFiles.Count > 0)
            {
                labelNoResults.Visible = false;
                reportResults.Visible = true;
                reportResults.DataSource = Radupload1.UploadedFiles;
                reportResults.DataBind();
            }
            else
            {
                labelNoResults.Visible = true;
                reportResults.Visible = false;
            }
        }
    }
}
