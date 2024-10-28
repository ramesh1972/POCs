using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet;
using Microsoft.Practices.EnterpriseLibrary.Validation.Validators;
using Microsoft.Practices.EnterpriseLibrary;
using Microsoft.Practices.EnterpriseLibrary.Validation;

namespace LAPS.FrontOffice
{
    public partial class UserControls_Login : System.Web.UI.UserControl
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnLogin.Click += new EventHandler(btnLogin_Click);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void btnLogin_Click(object sender, EventArgs e)
        {
            string email = tbEmailAddress.Text.Trim();
            string pwd = tbPassword.Text.Trim();

            LAPS.LAMS.User usr = new LAPS.LAMS.User();
            bool valid_user = usr.CheckValidAccount(email, pwd);
            if (valid_user)
            {
                // IMP: Set View state
                Session["UserGUID"] = usr.UserGUID;
                Session["AccountGUID"] = usr.AccountGUID;

                // create all the other info
                Server.Transfer("~\\NewLoanApplication.aspx");
            }
            else
                lblError.Text = "The combination of email address and password is not found. Please try again.";

        }
    }
}