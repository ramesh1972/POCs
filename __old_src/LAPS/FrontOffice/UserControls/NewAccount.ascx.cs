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
    public partial class NewAccount : System.Web.UI.UserControl
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnNewAccount.Click += new EventHandler(btnNewAccount_Click);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void btnNewAccount_Click(object sender, EventArgs e)
        {
            // fire the validation controls
            if (!Page.IsValid)
                return;

            // check to see if the email address is already registered
            string email = tbEmailAddress.Text.Trim();

            // -- Check from LAMS
            if (LAPS.LAMS.User.CheckIfEmailExists(email) > 0)
            {
                lblError.Text = "The Account already exists.";
                return;
            }

            // -- todo Check if the email is valid.

            // create the base account
            LAPS.LAMS.User usr = new LAPS.LAMS.User();
            if (usr.CreateNewAccount(tbEmailAddress.Text.Trim(), tbPassword.Text.Trim()))
            {
                // IMP: Set View state
                Session["UserGUID"] = usr.UserGUID;
                Session["AccountGUID"] = usr.AccountGUID;

                // create all the other info
                Server.Transfer("~\\NewLoanApplication.aspx");


                return;
            }

            lblError.Text = "Failed to create the account.";
        }
    }
}