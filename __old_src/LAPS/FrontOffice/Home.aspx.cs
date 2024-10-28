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

namespace LAPS.FrontOffice
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserControl uc = (UserControl)LoadControl("~\\UserControls\\NewAccount.ascx");
            pnlNewAccount.Controls.Clear();
            pnlNewAccount.Controls.Add(uc);

            uc = (UserControl)LoadControl("~\\UserControls\\Login.ascx");
            pnlLogin.Controls.Clear();
            pnlLogin.Controls.Add(uc);
        }
    }
}